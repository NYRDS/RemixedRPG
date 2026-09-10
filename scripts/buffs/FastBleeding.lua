---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD  = require "scripts/lib/commonClasses"
local RPG  = require "scripts/lib/Functions"
local storage = require "scripts/lib/storage"
local buff = require "scripts/lib/buff"

local hero = RPD.Dungeon.hero
local type ="true"

return buff.init{
    desc  = function ()
        return {
            icon          = 26,
            name          = "Bleeding_Name",
            info          = ""
        }
    end,

    charAct = function(self,buff)
      RPD.topEffect(buff.target:getPos(),"bleeding_effect")
      RPG.damage(buff.target,buff:level(),type,elmnt)
    end
}
