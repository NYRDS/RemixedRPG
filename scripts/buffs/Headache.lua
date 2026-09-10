---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD  = require "scripts/lib/commonClasses"
local RPG  = require "scripts/lib/Functions"
local buff = require "scripts/lib/buff"

return buff.init{
    desc = function()
        return {
            icon          = 43,
            name          = "Headache_BuffN",
            info          = "Headache_BuffD",
        }
    end,

    charAct = function(self,buff)
      local diceRoll = math.random(1,100)
      local chance = buff:level()
      if buff.target:isBoss() then
        chance = chance /2
      end
      if diceRoll <= chance then
        buff.target:spend(1)
        RPG.flyText(buff.target,RPD.textById("headache"),"red")
      end
    end
}
