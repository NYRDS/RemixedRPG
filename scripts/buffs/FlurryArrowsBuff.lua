---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD  = require "scripts/lib/commonClasses"
local RPG  = require "scripts/lib/Functions"
local storage = require "scripts/lib/storage"

local a = "flurryarrows"

local num = 0
local type ="phys"
local elmnt ="stab"

local buff = require "scripts/lib/buff"

return buff.init{
    desc  = function ()
        return {
            icon          = 70,
            name          = "FlurryArrows_BuffN",
            info          = "FlurryArrows_BuffD",
        }
    end,

    attackProc = function(self,buff,enemy,damage)
      local hero = RPD.Dungeon.hero
      local Spell = storage.gameGet(a) or {}
      local weapon = hero:getBelongings().weapon
      if weapon:goodForMelee() ~= true and weapon:getClassName() ~= "DummyItem" and RPG.distance(enemy:getPos()) >= 1 then
        Spell.exp = Spell.exp+1
        if Spell.exp == Spell.expMax then
          Spell.exp = 0
          Spell.expMax = Spell.expMax+8
          Spell.lvl = Spell.lvl+1
         end

        for i = 0, Spell.lvl do
          local dmg = RPG.smartInt(5+5*Spell.lvl+RPG.physStr()*0.1 + RPG.AllFast()*0.2)
          RPG.damage(enemy,math.random(dmg*0.75,dmg*1.25),type,elmnt)
          RPD.zapEffect(RPD.Dungeon.hero:getPos(),enemy:getPos(),"Arrow")
        end

        buff:detach()
      else
        RPD.glog(RPD.textById("FlurryArrowsLimit"))
        buff:detach()
      end
      return damage
    end
}
