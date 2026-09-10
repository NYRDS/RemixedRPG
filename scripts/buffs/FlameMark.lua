---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD  = require "scripts/lib/commonClasses"

local buff = require "scripts/lib/buff"

return buff.init{
    desc  = function ()
        return {
            icon          = 62,
            name          = "FlameMark_BuffN",
            info          = "FlameMark_BuffD",
        }
    end
}
