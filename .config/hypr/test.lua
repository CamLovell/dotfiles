-- This ensures the required directory can be read from directly
package.path = os.getenv("HOME") .. "/.config/hypr/lua/?.lua;" ..
    os.getenv("HOME") .. "/.config/hypr/lua/?/init.lua;" ..
    package.path


-- Pulls into scope globle `lib` table with helpers, defaults, scripts etc.
require("lib")

lib.ctrl.volume.inc()
os.execute("sleep 2")
lib.ctrl.volume.dec()
