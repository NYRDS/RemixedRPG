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
local summon
local summonMax
local a = "bonegolem"
local b = "gsc"
local golems = {"BoneGolem_lvl1","BoneGolem_lvl2","BoneGolem_lvl3"}

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
            image         = 9,
            imageFile     = "spellsIcons/spellicons.png",
            name          = RPD.textById("SummoningBoneGolemN").." ["..tostring(lvl).." "..RPD.textById("Lvl").."]",
            info          = "SummoningBoneGolemD",
            magicAffinity = "Combat",
            targetingType = "cell",
            level         = 1,
            spellCost     = 15+5*lvl,
            cooldown      = math.max(19-lvl-RPG.spellFast,16-math.ceil(RPG.spellFast/2)),
            castTime      = 0.5
        }
    end,

    castOnCell = function(self, spell, chr, cell)
    local hero = RPD.Dungeon.hero
    local level = RPD.Dungeon.level
    Count = storage.gameGet(a) or {}
    if hero:lvl() <= 4 then
     RPD.glog(RPD.textById("LvlLimit"))
     return false
    end
    if RPG.subclass ~= nil and RPG.subclass ~= "Necromancer" then
      RPD.glog(RPD.textById("SubclassLimit"))
      return false
    end
    if Count.lvl ~= nil then
     lvl = Count.lvl
     exp = Count.exp
     expMax = Count.expMax
     summon = Count.summon
     summonMax = Count.summonMax
     if level:getTileType(cell) == 4 or level:getTileType(cell) == 12 or RPG.distance(cell) > 2 then
      RPD.glog(RPD.textById("SummoningBoneGolemLimit"))
      return false
     else
     RPD.playSound("snd_cursed.ogg")
      exp = exp+1
     end
    if exp == expMax then
     exp = 0
     expMax = expMax+15
     if lvl ~= 3 then
      lvl = lvl+1
     end
     end
     storage.gamePut(a,{exp = exp, expMax = expMax, lvl = lvl, summon = summon, summonMax = summonMax,})
    else
     lvl = 1
     exp = 0
     expMax = 15
     summon = 0
     summonMax = 3
     storage.gamePut(a,{exp = exp, expMax = expMax, lvl = lvl, summon = summon, summonMax = summonMax})
    end
    summon = summon +1

    local petsCount = hero:countPets()

    if petsCount == 0 and summon ~= 0 then
      summon = 0
    end

    if petsCount > 4 then
      summon = summon + petsCount-4
    end

    storage.gamePut(a,{exp = exp, expMax = expMax, lvl = lvl, summon = summon, summonMax = summonMax})
    local mob = RPD.MobFactory:mobByName(golems[lvl])
    mob:setPos(cell)
    RPD.Dungeon.level:spawnMob(RPD.Mob:makePet(mob,RPD.Dungeon.hero));
    RPD.permanentBuff(mob,"ExpShare")
    mob:ht(mob:ht()+math.ceil(RPG.magStr()*0.25) + 5*lvl)
    mob:hp(mob:ht())
  return true
   end
}
