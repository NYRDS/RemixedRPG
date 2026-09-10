---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local spell = require "scripts/lib/spell"

local storage = require "scripts/lib/storage"

local lvl
local expMax
local exp
local a = "thornsofagony"
local type ="mag"
local elmnt

return spell.init{
    desc  = function ()
    local Count = storage.gameGet(a) or {}

     if Count.lvl == nil then
  lvl = 1
  else
   if lvl == nil then
    lvl = Count.lvl
   end
  end
        return {
            image         = 34,
            imageFile     = "spellsIcons/spellicons.png",
            name          = RPD.textById("ThornsOfAgonyN").." ["..tostring(lvl).." "..RPD.textById("Lvl").."]",
            info          = "ThornsOfAgonyD",
            magicAffinity = "Combat",
            targetingType = "self",
            level         = 1,
            spellCost     = 9+lvl,
            cooldown      = math.max(21-lvl,18),
            castTime      = 0
        }
    end,
    cast = function(self, spell, chr, cell)
    local hero = RPD.Dungeon.hero
    local level = RPD.Dungeon.level
    Count = storage.gameGet(a) or {}

	if RPD.Dungeon.hero:lvl() <= 4 then
     RPD.glog(RPD.textById("LvlLimit"))
     return false
    end

    if Count.lvl ~= nil then
     lvl = Count.lvl
     exp = Count.exp
     expMax = Count.expMax
     exp = exp+1
    if exp == expMax then
     exp = 0
     expMax = expMax+6
     lvl = lvl+1
     end
     storage.gamePut(a,{exp = exp, expMax = expMax, lvl = lvl})
    else
     lvl = 1
     exp = 0
     expMax = 4
     storage.gamePut(a,{exp = exp, expMax = expMax, lvl = lvl})
    end

    local levelW = RPD.Dungeon.level:getWidth()
        local levelH = RPD.Dungeon.level:getHeight()
      if RPD.Dungeon.depth ~= 0 then
        for i = 0, levelW do
          for j = 0, levelH do
            local cell = RPD.Dungeon.level:cell(i,j)
            local enemy = RPD.Actor:findChar(cell)
            if enemy then
            if enemy:buffLevel("BloodMark") == 1 then
            RPD.topEffect(enemy:getPos(),"blood_spikes_sp_top")
    RPD.bottomEffect(enemy:getPos(),"blood_spikes_sp_bot")
    local x = level:cellX(enemy:getPos())
     local y = level:cellY(enemy:getPos())
              for i = x-1,x+1 do
                for j = y-1,y+1 do
                  local pos = level:cell(i,j)
                  local enemy2 = RPD.Actor:findChar(pos)
                  if enemy2 and enemy2 ~= hero then

                    RPG.damage(enemy2,math.ceil(RPG.magStr()*0.1 + hero:ht()*0.15) + lvl, type,elmnt)
                    RPD.removeBuff(enemy2, "BloodMark")
                  end
                end
              end
            end
          end
        end
      end
      end
 return true
   end
}
