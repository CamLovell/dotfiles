#!/bin/bash
# Run this IMMEDIATELY after a fresh reboot and login,
# BEFORE manually opening Chrome or Slack. It captures where
# the cold launch actually spends its time.

OUT=/tmp/cold-chrome-trace
mkdir -p "$OUT"
cd "$OUT" || exit 1

echo "[trace] killing any running chrome to ensure cold..."
pkill -f /opt/google/chrome 2>/dev/null
sleep 2

echo "[trace] starting strace + timing of headless cold launch..."
{ time strace -tt -T -f -e trace=connect,recvmsg,recvfrom,sendto,sendmsg,futex,poll,read,openat \
    -o "$OUT/chrome.strace" \
    google-chrome --headless=new --disable-gpu \
      --no-first-run --no-default-browser-check \
      --dump-dom about:blank > /dev/null 2>&1 ; } 2> "$OUT/time.txt"

echo "[trace] done. wall-clock time:"
cat "$OUT/time.txt"

echo ""
echo "=== Top 30 SLOWEST single syscalls (>0.5s each) ==="
grep -oE '<[0-9]+\.[0-9]+>' "$OUT/chrome.strace" \
  | tr -d '<>' \
  | awk '$1+0 > 0.5' | sort -rn | head -30

echo ""
echo "=== Slow syscall context (>1s) ==="
grep -E '<[1-9][0-9]*\.[0-9]+>|<[0-9]+\.[0-9]+>' "$OUT/chrome.strace" \
  | awk '{
      if (match($0, /<([0-9]+\.[0-9]+)>/, m) && m[1]+0 > 1.0) print
    }' | head -50

echo ""
echo "=== All connect() calls (network/DBus) ==="
grep "connect(" "$OUT/chrome.strace" | head -30

echo ""
echo "=== Files opened (top dirs) ==="
grep -oE 'openat\([^)]*"([^"]+)"' "$OUT/chrome.strace" \
  | sed 's|.*"||;s|"$||' \
  | xargs -I{} dirname {} 2>/dev/null \
  | sort | uniq -c | sort -rn | head -20

echo ""
echo "Full trace saved at: $OUT/chrome.strace ($(du -h $OUT/chrome.strace | cut -f1))"
