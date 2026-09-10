---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD  = require "scripts/lib/commonClasses"

local buff = require "scripts/lib/buff"
local debuffs = {"Burning"}

return buff.init{
    desc  = function ()
        return {
            icon          = -1
        }
    end,

    immunities = function(self,buff)
  return debuffs
end

}
