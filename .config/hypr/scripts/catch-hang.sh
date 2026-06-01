#!/bin/bash
# Run this from a SECOND terminal while a command is hanging.
#
# Usage:
#   catch-hang.sh           # auto-detect: any process in D-state, or running children of shells
#   catch-hang.sh 12345     # inspect specific PID

set -u

if [[ $# -eq 1 ]]; then
  PIDS=("$1")
else
  echo "[catch-hang] auto-detecting hung processes..."
  echo ""
  # Priority 1: any process in D state (uninterruptible sleep, usually disk I/O)
  D_PIDS=$(ps -eo pid,stat,comm,args --no-headers | awk '$2 ~ /^D/ {print $1}')

  # Priority 2: running children of shells (these are commands the user ran)
  # exclude shells themselves and grep
  SHELL_CHILDREN=$(ps -eo pid,ppid,stat,comm,args --no-headers \
    | awk '$4 !~ /^(fish|bash|zsh|tmux|sh|grep)$/ && $5 !~ /catch-hang/ {
        # check if parent is a shell
        getline parent < ("/proc/" $2 "/comm")
        close("/proc/" $2 "/comm")
        if (parent ~ /^(fish|bash|zsh)$/) print $1
      }')

  if [[ -n "$D_PIDS" ]]; then
    echo "[catch-hang] found D-state (disk I/O) processes:"
    ps -o pid,stat,etime,comm,args -p $D_PIDS 2>/dev/null
    PIDS=($D_PIDS)
  elif [[ -n "$SHELL_CHILDREN" ]]; then
    echo "[catch-hang] no D-state processes; inspecting children of shells:"
    ps -o pid,stat,etime,comm,args -p $SHELL_CHILDREN 2>/dev/null
    PIDS=($SHELL_CHILDREN)
  else
    echo "Nothing obviously hung. Pass a PID explicitly:"
    echo "  catch-hang <pid>"
    echo ""
    echo "Currently running shell children:"
    ps -ef --forest | /usr/bin/grep -E "fish|bash|zsh|python|ubuntu-" | /usr/bin/grep -v grep
    exit 1
  fi
fi

for PID in "${PIDS[@]}"; do
  if [[ ! -d /proc/$PID ]]; then
    echo "PID $PID no longer exists, skipping"
    continue
  fi
  echo ""
  echo "============================================================"
  STATE=$(awk '/^State:/ {print substr($0, 8)}' /proc/$PID/status 2>/dev/null)
  CMD=$(tr '\0' ' ' < /proc/$PID/cmdline 2>/dev/null)
  PARENT=$(awk '/^PPid:/ {print $2}' /proc/$PID/status 2>/dev/null)
  PARENT_CMD=$(tr '\0' ' ' < /proc/$PARENT/cmdline 2>/dev/null)
  echo "PID:     $PID  ($STATE)"
  echo "cmd:     $CMD"
  echo "parent:  $PARENT  ($PARENT_CMD)"
  echo ""
  echo "--- wchan (kernel func it's blocked in) ---"
  cat /proc/$PID/wchan 2>/dev/null; echo
  echo ""
  echo "--- /proc/$PID/stack (kernel stack) ---"
  sudo cat /proc/$PID/stack 2>/dev/null
  echo ""
  echo "--- last 30 syscalls (3s strace sample) ---"
  sudo timeout 3 strace -p "$PID" -tt -T -f -e trace=all 2>&1 | tail -40
  echo ""
  echo "--- userspace stack (gdb) ---"
  sudo timeout 5 gdb -p "$PID" -batch -ex "bt" 2>&1 | /usr/bin/grep -E "^#|^Thread|in [a-z_]+ \(" | head -25 || echo "(gdb not available or symbols missing)"
  echo ""
  echo "--- open files (top 20) ---"
  sudo lsof -p "$PID" 2>/dev/null | tail -20
done

echo ""
echo "============================================================"
echo "Share this output."
