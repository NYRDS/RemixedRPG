---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD  = require "scripts/lib/commonClasses"

local RPG  = require "scripts/lib/Functions"

local Que  = require "scripts/lib/Queue"

local storage = require "scripts/lib/storage"
local spellList = require "scripts/spells/CustomSpellsList"

local hero
local depth
local level

local luckBonus = 1

local num = 0

local stats = ""

local buff = require "scripts/lib/buff"

return buff.init{
    desc  = function ()
      spellList["Combat"] = Que.getMas("spelllist")
        return {
            icon          = -1,
            name          = "",
            info          = "",
            data = {}

        }
    end,

    charAct = function(self,buff)
      local Stats = storage.gameGet(stats) or {}
      hero = RPD.Dungeon.hero
      level = RPD.Dungeon.level
      depth = RPD.Dungeon.depth
      subClass = storage.gameGet("subClassNone", {none = "", actv = 1})
      local Spells = require "scripts/spells/CustomSpellsList"
      local weapon = hero:getBelongings().weapon
      local lefthand = hero:getBelongings().leftHand
	    local armor = hero:getBelongings().armor
 	    local artifact = hero:getBelongings().ring1
	    local leftArtifact = hero:getBelongings().ring2
	    local StatsA = RPG.StatsA
	    local StatsA2 = RPG.StatsA2
	    local StatsB = RPG.StatsB
	    local StatsArt = RPG.StatsArt
	    local StatsArt2 = RPG.StatsArt2


      Spells.Combat = Que.getMas("spelllist")

      if hero:isStarving() then
        RPD.removeBuff(hero,"Hunger")
      end

      if hero:buffLevel("Poison") > 0 then
        RPD.affectBuff(hero,"PoisonBuff",hero:buffLevel("Poison")):level(RPG.smartInt(0.5+depth*0.5))
        RPD.removeBuff(hero,"Poison")
      end


      if hero:STR() > 1 then
        hero:STR(1)
        RPG.physicStr = RPG.physicStr+5
        storage.gamePut(stats, {str = RPG.strength, int = RPG.intelligence, dex = RPG.dexterity, vit = RPG.vitality, wis = RPG.wisdom, luc = RPG.luck, lvlT = RPG.lvlToUp, magS = RPG.magicStr, phyS = RPG.physicStr, fast = RPG.fast, sP = RPG.sPoints, spR = RPG.spRegen,magDef = RPG.magDef, class = RPG.class, subclass = RPG.subclass})
        storage.gamePut(tostring(hero:lvl()), {str = RPG.strength, int = RPG.intelligence, dex = RPG.dexterity, vit = RPG.vitality, wis = RPG.wisdom, luc = RPG.luck, lvlT = RPG.lvlToUp, magS = RPG.magicStr, phyS = RPG.physicStr, fast = RPG.fast, sP = RPG.sPoints, spR = RPG.spRegen,magDef = RPG.magDef, class = RPG.class, subclass = RPG.subclass, spells = Que.getMas("spelllist")})
      end

      local heroSteps = storage.gameGet("heroSteps", {steps = 1})
      storage.gamePut("heroSteps",{steps = heroSteps.steps +1})


      if RPG.luck == nil then

        if string.sub(tostring(weapon:getClass()),-10) == "CustomItem" then
          weapon:deactivate(hero)
          weapon:activate(hero)
        end

        if string.sub(tostring(lefthand:getClass()),-10) == "CustomItem" then
          lefthand:deactivate(hero)
          lefthand:activate(hero)
        end

        if string.sub(tostring(armor:getClass()),-10) == "CustomItem" then
          lefthand:deactivate(hero)
          lefthand:activate(hero)
        end


       if string.sub(tostring(artifact:getClass()),-10) == "CustomItem"  then
       for i=3,8 do
            StatsArt[RPG.statsName[i]] = 0
       end
       for i=9,21 do
            StatsArt[RPG.statsName[i]] = {0,0}     end
        end

        if string.sub(tostring(leftArtifact:getClass()),-10) == "CustomItem"  then
        for i=3,8 do
            StatsArt2[RPG.statsName[i]] = 0
        end
        for i=9,21 do
            StatsArt2[RPG.statsName[i]] = {0,0}
          end
        end

      end


      if hero:getBelongings():getItem("RatArmor") ~= nil then
         hero:getBelongings():getItem("RatArmor"):detach(hero:getBelongings().backpack)
         if hero:getBelongings():getItem("RatArmor") ~= nil then
           armor:doUnequip(hero,false)
           end
         hero:collect(RPD.item("ModRatArmor"))
    end


      if tostring(hero:getSubClass()) ~= subClass.none and subClass.actv ~= 1 then
        hero:setSubClass(subClass.none)
        storage.gamePut("subClassNone",{none = "", actv = 1})
        RPD.glog(RPD.textById("KydaLezem"))
      end

	if hero:getBelongings():getItem("ArmorKit") ~= nil then
         hero:getBelongings():getItem("ArmorKit"):detach(hero:getBelongings()
.backpack)
    end

    local golem = storage.gameGet("summonbonegolem") or {}
    local petsCount = hero:countPets()
    if petsCount > 4 and golem.exp ~= nil then
      storage.gamePut(a,{exp = golem.exp, expMax = golem.expMax, lvl = golem.lvl, summon = golem.summon +petsCount -3, summonMax = golem.summonMax})
    end

    local mobsExeptions =
    {
    BoneGolem_lvl1=false,
    BoneGolem_lvl2=false,
    BoneGolem_lvl3=false
    }

      local levelW = RPD.Dungeon.level:getWidth()
        local levelH = RPD.Dungeon.level:getHeight()
      if RPD.Dungeon.depth ~= 0 then
        for i = 0, levelW do
          for j = 0, levelH do
            local cell = RPD.Dungeon.level:cell(i,j)
            local enemy = RPD.Actor:findChar(cell)
            if enemy and enemy ~= RPD.Dungeon.hero and enemy:buffLevel("PowerBuff") == 0 and mobsExeptions[enemy:name()] ~= false then
              RPD.permanentBuff(enemy,"PowerBuff")
              local addHp = RPG.smartInt(-5 +1.2*RPD.Dungeon.depth  +4*(RPD.Dungeon.depth%5))
              if enemy:hp() < enemy:ht() then
                enemy:ht(enemy:ht() +enemy:ht()*0.02*depth + addHp)
                enemy:hp(enemy:hp() +enemy:ht()*0.02*depth + addHp)
              else
                enemy:ht(enemy:ht() +enemy:ht()*0.02*depth + addHp)
                enemy:hp(enemy:ht())
              end
            end
          end
        end
      end

      if RPG.strength == nil then
        RPG.strength = Stats.str
        RPG.intelligence = Stats.int
        RPG.dexterity = Stats.dex
        RPG.vitality = Stats.vit
        RPG.wisdom = Stats.wis
        RPG.luck = Stats.luc

        RPG.sPoints = Stats.sP
        RPG.spRegen = Stats.spR
        RPG.physicStr = Stats.phyS
        RPG.magicStr = Stats.magS
        RPG.fast = Stats.fast
        RPG.magDef = Stats.magDef
        RPG.lvlToUp = Stats.lvlT
        RPG.class = Stats.class
        RPG.subclass = Stats.subclass
      end

	  if RPG.lvlToUp - hero:lvl() >= 1 then
	    local save = storage.gameGet(tostring(hero:lvl())) or {}
	    if hero:lvl() == 1 then
	      hero:ht(10)
	      hero:hp(10)
	      hero:setMaxSkillPoints(1)
          hero:setSkillPoints(1)
	    end
	    RPG.strength = save.str
        RPG.intelligence = save.int
        RPG.dexterity = save.dex
        RPG.vitality = save.vit
        RPG.wisdom = save.wis
        RPG.luck = save.luc

        RPG.sPoints = save.sP
        RPG.spRegen = save.spR
        RPG.physicStr = save.phyS
        RPG.magicStr = save.magS
        RPG.fast = save.fast
        RPG.mageDef = save.magDef
        RPG.lvlToUp = save.lvlT
        RPG.class = save.class
        RPG.subclass = save.subclass
		Que.pushMas("spelllist", save.spells)
		storage.gamePut(stats, {str = RPG.strength, int = RPG.intelligence, dex = RPG.dexterity, vit = RPG.vitality, wis = RPG.wisdom, luc = RPG.luck, lvlT = RPG.lvlToUp, magS = RPG.magicStr, phyS = RPG.physicStr, fast = RPG.fast, sP = RPG.sPoints, spR = RPG.spRegen, magDef = RPG.magDef, class = RPG.class, subclass = RPG.subclass})
	  end

      if hero:lvl() > RPG.lvlToUp then
        RPG.lvlToUp = hero:lvl()
        hero:ht(hero:ht()-5)
        if hero:hp() >= hero:ht() then
          hero:hp(hero:ht())
        end
        hero:setMaxSkillPoints(hero:getSkillPointsMax()-1)
        RPG.sPoints = RPG.sPoints+5
        RPD.glog(RPD.textById("LvlUp"))
        if hero:lvl()%5 == 0 then
          RPG.sPoints = RPG.sPoints+3
          RPD.glog(RPD.textById("LvlUpHappy"))
        end
        storage.gamePut(stats, {str = RPG.strength, int = RPG.intelligence, dex = RPG.dexterity, vit = RPG.vitality, wis = RPG.wisdom, luc = RPG.luck, lvlT = RPG.lvlToUp, magS = RPG.magicStr, phyS = RPG.physicStr, fast = RPG.fast, sP = RPG.sPoints, spR = RPG.spRegen,magDef = RPG.magDef, class = RPG.class, subclass = RPG.subclass})
		storage.gamePut(tostring(hero:lvl()), {str = RPG.strength, int = RPG.intelligence, dex = RPG.dexterity, vit = RPG.vitality, wis = RPG.wisdom, luc = RPG.luck, lvlT = RPG.lvlToUp, magS = RPG.magicStr, phyS = RPG.physicStr, fast = RPG.fast, sP = RPG.sPoints, spR = RPG.spRegen,magDef = RPG.magDef, class = RPG.class, subclass = RPG.subclass, spells = Que.getMas("spelllist")})
      end

      if RPG.subclass == "Berserk" then
        RPG.physicStrBerserk = (hero:ht()-hero:hp())*0.4
      end

      num = num+1
      if num >= 5 then
        hero:setSkillPoints(RPD.Dungeon.hero:getSkillPoints()+RPG.AllSpRegen())
        num = 0
       end
     end,

    speedMultiplier = function(self, buff)
        return RPG.baseSpeed()
    end,

    regenerationBonus = function(self,buff)

        return 1 + buff.target:ht()*0.03
    end,

    attackProc = function(self,buff,enemy,damage)
      level = RPD.Dungeon.level
      if RPG.subclass == "Bandit" or RPG.subclass == "Necromancer" then
        luckBonus = 1.5
      end

      if RPG.subclass == "Ninja" then
        if enemy:buffLevel("KiMark") == 1 then
          enemy:damage(RPG.magStr()*0.35, buff.target)
          buff.target:heal(RPG.magStr()*0.3, buff.target)
          RPD.Sfx.CellEmitter:get(buff.target:getPos()):burst(RPD.Sfx.Speck:factory(RPD.Sfx.Speck.HEALING ), 3)
        end
      end

      if RPG.physicStr ~= nil then
        if math.random(10,100+enemy:defenseSkill()) <= RPG.AllLuck()*luckBonus then

          if enemy:hp() - ((damage)*2 - enemy:dr()) <= 0 and RPG.subclass == "Bandit" then
            RPG.createItem("Gold", enemy:getPos(), RPG.AllLuck() + RPD.Dungeon.depth)
          end

          enemy:getSprite():showStatus(0xffff00,RPD.textById("crit"))
          return (damage+RPG.smartInt(RPG.physStr()*0.25))*2
        else

          if enemy:hp() - ((damage+RPG.smartInt(RPG.physStr()*0.25))-enemy:dr()) <= 0 and RPG.subclass == "Bandit" then
            RPG.createItem("Gold", enemy:getPos(), RPG.AllLuck() + RPD.Dungeon.depth)
          end

          return damage+RPG.smartInt(RPG.physStr()*0.25)
        end
      else
        return damage
      end
    end,

    defenceProc = function(self, buff, enemy, damage)
    hero = RPD.Dungeon.hero
     if RPG.dexterity ~= nil then
     if math.random(1,120+enemy:attackSkill()) <= (RPG.AllLuck()*0.5)*luckBonus + RPG.AllFast()*0.25 then
     hero:getSprite():showStatus(0xffff00,RPD.textById("block"))
      RPD.glog(RPD.textById("Block0")..math.ceil(RPG.AllFast()*0.1 + hero:ht()*0.1 + RPG.physStr()*0.15)..RPD.textById("Block1"))
      return damage - math.ceil(RPG.AllFast()*0.1 + RPG.physStr()*0.15 + hero:ht()*0.1)
      else
      return damage
      end
     else
      return damage
     end
    end
}
