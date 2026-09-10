
local RPD = require "scripts/lib/commonClasses"
local item = require "scripts/lib/item"

return item.init {
    desc  = function (self, item)
        return {
            image         = 4,
            imageFile     = "rpgitems.png",
            name          = "",
            info          = ""
        }
    end,
  isFliesStraight = function()
   return true
  end
}
