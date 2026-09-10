---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD  = require "scripts/lib/commonClasses"
local RPG  = require "scripts/lib/Functions"
local storage = require "scripts/lib/storage"
local buff = require "scripts/lib/buff"

return buff.init{
    desc  = function ()
        return {
            icon          = 14,
            name          = "SlownessN",
            info          = "SlownessD",
        }
    end,
    speedMultiplier = function(self, buff)
        return RPG.baseSpeed() -buff:level()*0.05
    end
}
