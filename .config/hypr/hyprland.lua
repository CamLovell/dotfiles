-- This ensures the required directory can be read from directly
package.path = os.getenv("HOME") .. "/.config/hypr/?/init.lua;" ..
    package.path


-- Pulls into scope globle `lib` table with helpers, defaults, scripts etc.
require("lib")

require("keybinds")
require("startup")
require("env")
require("window_rules")
require("config")
require("monitors")
