local RPD = require "scripts/lib/commonClasses"
local RPG = require "scripts/lib/Functions"
local storage = require "scripts/lib/storage"



local Add = {
    rpdImage = function(image)
      return RPD.new("com.watabou.noosa.Image",image)
    end,

    imgMessage = function(img, title, text)
      local redbutton = luajava.newInstance("com.watabou.pixeldungeon.ui.RedButton","choose")
      local wnd = luajava.newInstance(RPG.Objects.Ui.WndImageMessage, RPD.new("com.watabou.noosa.Image",img), title, text)
        RPD.GameScene:show(wnd)

    end,

 pillChoise = function(dialog)
   RPD.chooseOption(dialog,
   "Выбор пилюли",
   "Тебе какая пилюля нужна, герой?",
   "Пилюля закалки тела\n(Семена Солнечника x1,\nСемена Земляного корня x1)"
   )
 end,

  blacksmithDialog = function(dialog)
    RPD.chooseOption(dialog,
   RPD.textById("Town_Blacksmith_Name"),
   RPD.textById("Town_Blacksmith_Say"),
   RPD.textById("Order_An_Item")
   )
  end,

 smithStart = function(dialog)
   local smithy = require "scripts/lib/smithing"

   RPD.chooseOption(dialog,
   RPD.textById("Smithing")..": "..smithy.lvl.."\n"..RPD.textById("Exp")..": "..smithy.exp.." / "..smithy.expToUp,
   "",
     RPD.textById("chooseWeapon"),
     RPD.textById("chooseArmor"))
 end,

 smithWeapon = function(dialog)
   local smithy = require "scripts/lib/smithing"

   RPD.chooseOption(dialog,
   RPD.textById("Smithing")..": "..smithy.lvl.."\n"..RPD.textById("Exp")..": "..smithy.exp.." / "..smithy.expToUp,
   "",
     RPD.textById("chooseMelee"),
     RPD.textById("chooseRange"))
 end,

 smithMelee = function(dialog)
   local smithy = require "scripts/lib/smithing"

   RPD.chooseOption(dialog,
   RPD.textById("Smithing")..": "..smithy.lvl.."\n"..RPD.textById("Exp")..": "..smithy.exp.." / "..smithy.expToUp,
   "",
     RPD.textById("onehandedWeapon"),
     RPD.textById("twohandedWeapon"))
   end,

  smithOnehand = function(dialog)
    local smithy = require "scripts/lib/smithing"

    RPD.chooseOption(dialog,
    RPD.textById("Smithing")..": "..smithy.lvl.."\n"..RPD.textById("Exp")..": "..smithy.exp.." / "..smithy.expToUp,
   "",
      RPD.textById("Sword"),
      RPD.textById("Dagger"),
      RPD.textById("Axe"),
      RPD.textById("Mace"))
    end,

   smithTwohand = function(dialog)
     local smithy = require "scripts/lib/smithing"

     RPD.chooseOption(dialog,
     RPD.textById("Smithing")..": "..smithy.lvl.."\n"..RPD.textById("Exp")..": "..smithy.exp.." / "..smithy.expToUp,
   "",
      RPD.textById("Longsword"),
      RPD.textById("Spear"),
      RPD.textById("Hatchet"),
      RPD.textById("Halberd"),
      RPD.textById("Hammer"))
    end,

   smithRange = function(dialog)
      local smithy = require "scripts/lib/smithing"

      RPD.chooseOption(dialog,
   RPD.textById("Smithing")..": "..smithy.lvl.."\n"..RPD.textById("Exp")..": "..smithy.exp.." / "..smithy.expToUp,
     "",
      RPD.textById("Bow"),
      RPD.textById("Crossbow"),
      RPD.textById("MagicStaff"),
      RPD.textById("MagicWand"))
   end,

 smithArmor = function(dialog)
    local smithy = require "scripts/lib/smithing"

    RPD.chooseOption(dialog,
    RPD.textById("Smithing")..": "..smithy.lvl.."\n"..RPD.textById("Exp")..": "..smithy.exp.." / "..smithy.expToUp,
   "",
      "                   "..RPD.textById("LightArmorUp")..RPD.textById("ая").."\n"..RPD.textById("attackBonus"),
      "                "..RPD.textById("MediumArmorUp")..RPD.textById("яя").."\n"..RPD.textById("noBonus"),
      "                  "..RPD.textById("HeavyArmorUp")..RPD.textById("ая").."\n"..RPD.textById("defenceBonus"))
 end,

 smithChooseMaterials = function(dialog)
    local smithy = require "scripts/lib/smithing"
    local smith = storage.gameGet("smithing") or {}
    local mc = smithy.materialCount[smithy.choosenObject]
    local mq = smithy.allQuantity
    local gold = 0
    local goldSum = 0

    if smithy.myself == false then
      local groups =
      {
      smithy.finalMaterials[1],
      smithy.finalMaterials[2]
      }
      for g = 1,2 do
      local group = groups[g]

        for i = 1, #group do

          local material = group[i]
          local matFile = require("scripts/items/"..material[1])


           local mPrice = matFile:desc().price
           goldSum = RPG.smartInt(goldSum +mPrice*material[2]*0.75)
           end
         gold = goldSum
         smithy.goldForBuy = gold
         end
       end


    RPD.chooseOption(dialog,
    RPD.textById("Smithing")..": "..smithy.lvl.."\n"..RPD.textById("Exp")..": "..smithy.exp.." / "..smithy.expToUp,
    RPD.textById("smithQuantityToChoose")..smithy.quantityToChoose.."\n\n"..RPD.textById("mainMaterials")..": "..mq[1].."/"..mc[1].."\n"..RPD.textById("addMaterials")..": "..mq[2].."/"..mc[2].."\n",
	  RPD.textById("mainMaterials"),
    RPD.textById("addMaterials"),
    "+",
    "-",
    RPD.textById("startSmith").." ("..RPD.textById("Price")..": "..gold..")")
  end,

 trapChoise = function(dialog)
   local Spell = storage.gameGet("placetrap") or {}
   RPD.chooseOption(dialog,
   "TrapChoiseT ",
   "",
   "TrapChoise0",
   RPD.textById("TrapChoise1").." ["..Spell.UP.." "..RPD.textById("SpecUpCost").."]")
 end,

 trapChoiseOn = function(dialog,index)
   local Spell = storage.gameGet("placetrap") or {}
   if index == 0 then
     RPD.chooseOption(dialog,
     "TrapChoiseOnT",
     "",
   RPD.textById("TrapChoiseOn0").." ["..Spell.FT.." "..RPD.textById("Lvl").."]",
   RPD.textById("TrapChoiseOn1").." ["..Spell.BT.." "..RPD.textById("Lvl").."]",
   RPD.textById("TrapChoiseOn2").." ["..Spell.CT.." "..RPD.textById("Lvl").."]",
   RPD.textById("TrapChoiseOn3").." ["..Spell.IT.." "..RPD.textById("Lvl").."]",
   RPD.textById("TrapChoiseOn4").." ["..Spell.PT.." "..RPD.textById("Lvl").."]")
   else
     RPD.chooseOption(dialog,
     "TrapChoiseOnT",
     ""..Spell.UP.." "..RPD.textById("SpecUpCost"),
   RPD.textById("TrapChoiseOn0").." ["..Spell.FT.." "..RPD.textById("Lvl").."]",
   RPD.textById("TrapChoiseOn1").." ["..Spell.BT.." "..RPD.textById("Lvl").."]",
   RPD.textById("TrapChoiseOn2").." ["..Spell.CT.." "..RPD.textById("Lvl").."]",
   RPD.textById("TrapChoiseOn3").." ["..Spell.IT.." "..RPD.textById("Lvl").."]",
   RPD.textById("TrapChoiseOn4").." ["..Spell.PT.." "..RPD.textById("Lvl").."]")
   end
 end,

 statusWindow = function(dialog,states,index1)
 RPD.chooseOption( dialog,
                RPD.textById("status"),
                RPD.textById("str")..": "..tostring(RPG.strength).."\n"..RPD.textById("int")..": "..tostring(RPG.intelligence).."\n"..RPD.textById("dex")..": "..tostring(RPG.dexterity).."\n"..RPD.textById("sur")..": "..tostring(RPG.vitality).."\n"..RPD.textById("wis").." : "..tostring(RPG.wisdom).."\n"..RPD.textById("luck")..": "..tostring(RPG.AllLuck()).."\n\n"..RPD.textById("PhysStr")..": "..tostring(RPG.physStr()).."\n"..RPD.textById("MagStr")..": "..tostring(RPG.magStr()).."\n"..RPD.textById("Fast")..": "..tostring(RPG.AllFast()).."\n"..RPD.textById("magDef")..": "..tostring(RPG.AllMagDef()).."\n "..tostring(RPG.AllSpRegen()).." "..RPD.textById("SpRegenMove"),
                "["..tostring(states[index1]).."]",
                RPD.textById("SpecUp").."["..tostring(RPG.sPoints).." "..RPD.textById("SpecUpCost")
        )
 end,

 statusWindowClass = function(dialog,states,index1)
 RPD.chooseOption( dialog,
              RPD.textById("status"),
              RPD.textById("str")..": "..tostring(RPG.strength).."\n"..RPD.textById("int")..": "..tostring(RPG.intelligence).."\n"..RPD.textById("dex")..": "..tostring(RPG.dexterity).."\n"..RPD.textById("sur")..": "..tostring(RPG.vitality).."\n"..RPD.textById("wis").." : "..tostring(RPG.wisdom).."\n"..RPD.textById("luck")..": "..tostring(RPG.AllLuck()).."\n\n"..RPD.textById("PhysStr")..": "..tostring(RPG.physStr()).."\n"..RPD.textById("MagStr")..": "..tostring(RPG.magStr()).."\n"..RPD.textById("Fast")..": "..tostring(RPG.AllFast()).."\n"..RPD.textById("magDef")..": "..tostring(RPG.AllMagDef()).."\n "..tostring(RPG.AllSpRegen()).." "..RPD.textById("SpRegenMove"),
                "["..tostring(states[index1]).."]",
                RPD.textById("SpecUp").."["..tostring(RPG.sPoints).." "..RPD.textById("SpecUpCost"),
                "ClassPick"
        )
 end,
 classWindow = function(dialog)
 RPD.chooseOption( dialog,
                "ClassPick",
                "ClassPickD",
                "warrior",
                "rogue",
                "mage"
        )
 end,

 statusWindowSubclass = function(dialog,states,index1)
 RPD.chooseOption( dialog,
               RPD.textById("status"),
                RPD.textById("str")..": "..tostring(RPG.strength).."\n"..RPD.textById("int")..": "..tostring(RPG.intelligence).."\n"..RPD.textById("dex")..": "..tostring(RPG.dexterity).."\n"..RPD.textById("sur")..": "..tostring(RPG.vitality).."\n"..RPD.textById("wis").." : "..tostring(RPG.wisdom).."\n"..RPD.textById("luck")..": "..tostring(RPG.AllLuck()).."\n\n"..RPD.textById("PhysStr")..": "..tostring(RPG.physStr()).."\n"..RPD.textById("MagStr")..": "..tostring(RPG.magStr()).."\n"..RPD.textById("Fast")..": "..tostring(RPG.AllFast()).."\n"..RPD.textById("magDef")..": "..tostring(RPG.AllMagDef()).."\n "..tostring(RPG.AllSpRegen()).." "..RPD.textById("SpRegenMove"),
                "["..tostring(states[index1]).."]",
                RPD.textById("SpecUp").."["..tostring(RPG.sPoints).." "..RPD.textById("SpecUpCost"),
                "SubclassPick"
        )
 end,
 subclassWindow = function(dialog)
 local subclasses = {
   Warrior = {"Berserk","Paladin","BladeOfMind","Samurai"},
   Rogue = {"Archer","Killer","Ninja","Bandit"},
   Mage = {"BattleMage","Demonologist","Necromancer","Enchanter"}
   }
   local subclass = subclasses[RPG.class]
 RPD.chooseOption( dialog,
                "SubclassPick",
                "SubclassPickD",
                subclass[1],
                subclass[2],
                subclass[3],
                subclass[4]
        )
 end

 }
return Add
