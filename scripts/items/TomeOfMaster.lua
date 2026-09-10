
local RPD = require "scripts/lib/commonClasses"
local item = require "scripts/lib/item"
local hero = RPD.Dungeon.hero

return item.init {
    desc  = function (self, item)
    if hero:getBelongings():getItem("TomeOfMastery") ~= nil then
         hero:getBelongings():getItem("TomeOfMastery"):detach(hero:getBelongings()
.backpack)
    end
        return {
            image         = 3,
            imageFile     = "rpgitems.png",
            name          = "Нож?",
            info          = ""
        }
    end,
  isFliesStraight = function()
   return true
  end
}
