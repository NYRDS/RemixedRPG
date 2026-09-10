--
--Created by Mongol
-- VK: mongolinsult
--

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local Add = require "scripts/lib/AdditionalFunctions"

local item = require "scripts/lib/item"

local storage = require "scripts/lib/storage"

local tier = 1
local tierN =
{
"общего",
"земного",
"небесного",
"загадочного",
"духовного",
"божественного"
}

return item.init{
    desc  = function (self, item)
        return {
            image         = 53,
            imageFile     = "rpgitems.png",
            name          = "Пилюля закалки тела",
            info          = "Препарат создаваемый восточными алхимиками из разных трав и прочих ингредиентов. Данная же пилюля создана из трав подземелья.\n\nПилюля закалки тела - препарат "..tostring(tierN[tier]).." класса. Увеличивает здоровье на "..(tier*5).." единиц, а также физическую силу и скорость на "..tier.." единиц.",
            price         = 12*2^tier,
            upgradable = false,
            stackable = true,
            defaultAction = "СЪЕСТЬ"

        }
    end,

activate = function(self, item, hero)
    end,

deactivate = function(self, item, hero)
 end,

actions = function(self, item, hero)
return {"СЪЕСТЬ"}
end,

    execute = function(self, item, hero, action)
      local Stats = storage.gameGet("") or {}
      if action == "СЪЕСТЬ" then
        hero:ht(hero:ht()+tier*5)
        hero:heal(tier*5,hero)
        item:getUser():getBelongings()
:getItem("BodyBoostPill"):detach(item:getUser():getBelongings()
.backpack)
      end

      RPG.physicStr = RPG.physicStr +tier
      RPG.fast = RPG.fast +tier
      storage.gamePut("", {str = RPG.strength, int = RPG.intelligence, dex = RPG.dexterity, vit = RPG.vitality, wis = RPG.wisdom, luc = RPG.luck, lvlT = RPG.lvlToUp, magS = RPG.magicStr, phyS = RPG.physicStr, fast = RPG.fast, sP = RPG.sPoints, spR = RPG.spRegen, class = RPG.class, subclass = RPG.subclass})
      end
}
