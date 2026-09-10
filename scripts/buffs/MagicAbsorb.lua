---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD  = require "scripts/lib/commonClasses"
local RPG  = require "scripts/lib/Functions"
local storage = require "scripts/lib/storage"

local buff = require "scripts/lib/buff"
local hero = RPD.Dungeon.hero
local absorb = 0.5

return buff.init{
    desc  = function ()
        return {
            icon          = 57,
            name          = "MagicAbsorbN",
            info          = "MagicAbsorbD",
        }
    end,

defenceProc = function(self, buff, enemy, damage)
      local hero = RPD.Dungeon.hero
      local absorbing = math.min(0.9, absorb +buff:level()*0.08)
      if hero:getSkillPoints() -math.ceil((damage*absorbing)*absorb) >= 0 then
        hero:setSkillPoints(hero:getSkillPoints() -math.ceil((damage*absorbing)*absorb))
        return damage -damage*absorbing
      elseif hero:getSkillPoints() ~= 0 then
        hero:setSkillPoints(0)
        return damage -damage*(absorbing -((damage*absorbing)*absorb -hero:getSkillPoints())*0.1)
      else
        return damage
      end
    end

}
