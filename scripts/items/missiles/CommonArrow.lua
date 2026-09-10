local RPG = require "scripts/lib/Functions"
local item = require "scripts/lib/item"

return item.init {
    desc  = function (self, item)
      if item:quantity() < 2 then
        item:quantity(math.random(15,35))
      end
        return {
            image = 7,
            imageFile = "items/ammo.png",
            name = "CommonArrow_Name",
            info = "CommonArrow_Info",
            stackable = true,
            price = 1,
        }
    end,

    dmg = function()
      return {2,4}
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
