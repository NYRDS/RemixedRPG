local RPD = require "scripts/lib/commonClasses"
local RPG = require "scripts/lib/Functions"
local item = require "scripts/lib/item"

return item.init {
    desc  = function (self, item)
      if item:quantity() < 2 then
        item:quantity(math.random(4,8))
      end
        return {
            image = 10,
            imageFile = "items/ammo.png",
            name = "ParalysisArrow_Name",
            info = "ParalysisArrow_Info",
            stackable = true,
            price = 4,
        }
    end,
    dmg = function()
      return {2,4}
    end,
    buff = function()
      return {"Paralysis",1 +RPG.smartInt(RPG.AllLuck()*0.05),1}
    end,
    isFliesStraight = function()
      return true
    end,
  	bag = function()
  		return "Quiver"
  	end
}
