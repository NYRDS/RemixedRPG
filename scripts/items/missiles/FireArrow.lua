local RPG = require "scripts/lib/Functions"
local item = require "scripts/lib/item"

return item.init {
    desc  = function (self, item)
      if item:quantity() < 2 then
        item:quantity(math.random(8,20))
      end
        return {
            image = 8,
            imageFile = "items/ammo.png",
            name = "FireArrow_Name",
            info = "FireArrow_Info",
            stackable = true,
            price = 3,
        }
    end,

    dmg = function()
      return {2,4}
    end,
    buff = function()
      return {"BurningBuff",2,8+RPG.physStr()*0.25}
    end,
    isFliesStraight = function()
      return true
    end,
  	bag = function()
  		return "Quiver"
  	end
}
