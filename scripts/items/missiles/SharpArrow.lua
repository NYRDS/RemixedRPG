local RPD = require "scripts/lib/commonClasses"
local item = require "scripts/lib/item"

return item.init {
    desc  = function (self, item)
      if item:quantity() < 2 then
        item:quantity(math.random(8,25))
      end
        return {
            image = 11,
            imageFile = "items/ammo.png",
            name = "SharpArrow_Name",
            info = "SharpArrow_Info",
            stackable = true,
            price = 2,
        }
    end,
  dmg = function()
      return {4,8}
    end,
    buff = function()
      return
    end,
    isFliesStraight = function()
      return true
    end,
  	bag = function()
  		return "Quiver"
  	end
}
