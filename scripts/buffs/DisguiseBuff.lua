---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by mike.
--- DateTime: 02.05.19 14:36
---
local RPD  = require "scripts/lib/commonClasses"
local RPG  = require "scripts/lib/Functions"
local storage = require "scripts/lib/storage"

local a = "disguise"
local hero = RPD.Dungeon.hero
local num = 0

local buff = require "scripts/lib/buff"


return buff.init{
    desc  = function ()
        return {
            icon          = 58,
            name          = "DisguiseN",
            info          = "DisguiseD",
        }
    end,

    attachTo = function(self, buff, target)
        return true
    end,

    detach = function(self, buff)
    end,

    act = function(self,buff)
        buff:detach()
    end,

    stealthBonus = function(self,buff)
        local Spell = storage.gameGet(a) or {}
        return (math.ceil(RPG.AllFast()*0.9) + 2*Spell.lvl)
    end,

    charSpriteStatus = function(self, buff)
        return "INVISIBLE"
    end
}
