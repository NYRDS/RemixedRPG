---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD  = require "scripts/lib/commonClasses"
local RPG  = require "scripts/lib/Functions"
local storage = require "scripts/lib/storage"

local a = "chop"
local hero = RPD.Dungeon.hero
local num = 0
local type ="phys"
local elmnt ="chop"

local buff = require "scripts/lib/buff"

return buff.init{
    desc  = function ()
        return {
            icon          = 52,
            name          = "Chop_BuffN",
            info          = "Chop_BuffD",
        }
    end,

    attackProc = function(self,buff,enemy,damage)
    local Spell = storage.gameGet(a) or {}
    Spell.exp = Spell.exp+1
    if Spell.exp == Spell.expMax then
     Spell.exp = 0
     Spell.expMax = Spell.expMax+6
     Spell.lvl = Spell.lvl+1
     end

    if not RPG.noBloodMobs[enemy:name()] then
      local buffs = RPD.affectBuff(enemy,"FastBleeding",2)
      buffs:level( RPG.smartInt( RPG.physStr()*0.1) )
      RPD.topEffect(enemy:getPos(),"bleeding_effect")
    end

    buff:detach()
    if RPG.physicStr ~= nil then
    return RPG.damage(enemy,damage+RPG.smartInt(RPG.physStr()*0.2),type,elmnt)
    else
    return damage
    end
    end
}
