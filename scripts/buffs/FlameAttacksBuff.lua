---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD  = require "scripts/lib/commonClasses"
local RPG  = require "scripts/lib/Functions"
local storage = require "scripts/lib/storage"
local a = "flameattacks"
local Spell = storage.gameGet(a) or {}

local hero = RPD.Dungeon.hero
local buff = require "scripts/lib/buff"
local num = 0
local type ="mag"
local elmnt ="fire"

return buff.init{
    desc  = function ()
        return {
            icon          = 61,
            name          = "FlameAttacks_BuffN",
            info          = "FlameAttacks_BuffD",
        }
    end,

    attackProc = function(self,buff,enemy,damage)
      hero = RPD.Dungeon.hero
      local weaponA = hero:getBelongings().weapon
     local weaponB = hero:getBelongings().leftHand
     local weaponRoll = (weaponA:damageRoll(hero) + weaponB:damageRoll(hero)/2)

      if enemy:buffLevel("FlameMark") > 0 then
        RPG.damage(enemy,RPG.smartInt(3+4*Spell.lvl +RPG.magStr()*0.1 +hero:ht()*0.05 +weaponRoll*0.2),type,elmnt)
        enemy:getSprite():showStatus(0xffff00,RPD.textById("boom"))
      else
        RPG.damage(enemy,math.ceil(5+5*Spell.lvl + RPG.magStr()*0.1 + hero:ht()*0.05),type,elmnt)
      end
    return damage
    end
}
