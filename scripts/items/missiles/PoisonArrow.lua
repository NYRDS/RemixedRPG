local RPD = require "scripts/lib/commonClasses"
local RPG = require "scripts/lib/Functions"
local item = require "scripts/lib/item"


return item.init {
    desc  = function (self, item)
      if item:quantity() < 2 then
        item:quantity(math.random(5,15))
      end
        return {
            image = 9,
            imageFile = "items/ammo.png",
            name = "PoisonArrow_Name",
            info = "PoisonArrow_Info",
            stackable = true,
            price = 3
        }
    end,
    dmg = function()
      return {2,4}
    end,
    buff = function()
      return {"PoisonBuff",5,8+RPG.AllFast()*0.15}
    end,
    isFliesStraight = function()
      return true
    end,
  	bag = function()
  		return "Quiver"
  	end
}
