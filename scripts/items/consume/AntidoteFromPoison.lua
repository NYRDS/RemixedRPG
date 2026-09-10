--
--Created by Mongol
-- VK: mongolinsult
--

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local Add = require "scripts/lib/AdditionalFunctions"

local item = require "scripts/lib/item"

local storage = require "scripts/lib/storage"

local kind = "AntidoteFromPoison"
local act = RPD.Actions.drink


return item.init{
    desc  = function (self, item)
        return {
            image         = 67,
            imageFile     = "rpgitems.png",
            name          = kind.."_Name",
            info          = kind.."_Info",
            price         = 2,
            upgradable = false,
            stackable = true,
            defaultAction = act

        }
    end,

actions = function(self, item, hero)
return {act}
end,

    execute = function(self, item, hero, action)
      if action == act then
        RPD.removeBuff(hero,"PoisonBuff")
        RPD.affectBuff(hero,"PurificationPoison",6)
        hero:heal(hero:ht()*0.1,hero)
        item:getUser():getBelongings()
:getItem("consume/"..kind):detach(item:getUser():getBelongings()
.backpack)
        hero:spend(1)
      end

      end
}
