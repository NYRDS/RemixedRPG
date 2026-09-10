local Add                  = require "scripts/lib/AdditionalFunctions"
local storage = require "scripts/lib/storage"
local smithy = require "scripts/lib/smithing"

local RPD = require "scripts/lib/commonClasses"
local RPG = require "scripts/lib/Functions"

local object = require "scripts/lib/object"


return object.init {

    interactive = function(self, object)
        return true
    end,

    interact = function(self, object, hero)
      local smith = storage.gameGet("smithing") or {}
      smithy.lvl = smith.lvl
      smithy.exp = smith.exp
      smithy.expToUp = smith.expToUp
      smithy.myself = true
      if RPG.luck ~= nil then
        Add.smithStart(smithy.mainWnd)
      end
        return true
    end
}
