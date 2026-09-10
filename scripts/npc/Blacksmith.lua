--
--Created by Mongol
-- VK: mongolinsult
--

local RPD = require "scripts/lib/commonClasses"
local RPG = require "scripts/lib/Functions"
local Add = require "scripts/lib/AdditionalFunctions"
local smithy = require "scripts/lib/smithing"
local storage = require "scripts/lib/storage"
local mob = require"scripts/lib/mob"
local quest = require"scripts/lib/quest"

local hero
local buyDelay = 0
local lvl = 2
local seller
local data

blacksmithInteract = function(index)
      smithy.lvl = 2
      smithy.exp = "-"
      smithy.expToUp = "-"
      smithy.myself = false
      Add.smithStart(smithy.mainWnd)
  end

return mob.init({

  interact = function(self, chr)
    hero = RPD.Dungeon.hero
    seller = self
    data = storage.gameGet("heroSteps", {steps = 1})
    buyDelay = data.steps


      if buyDelay > 50 then
        storage.gamePut("heroSteps",{steps = 1})

        self:collect(RPD.createItem("materials/iron",{quantity= RPG.smartInt(buyDelay/8) }))

        self:collect(RPD.createItem("materials/steel",{quantity= RPG.smartInt(buyDelay/100) }))

        self:collect(RPD.createItem("materials/gold",{quantity= RPG.smartInt(buyDelay/120) }))

        self:collect(RPD.createItem("materials/leather",{quantity= RPG.smartInt(buyDelay/80) }))

        self:collect(RPD.createItem("materials/cloth",{quantity= RPG.smartInt(buyDelay/70) }))

        self:collect(RPD.createItem("materials/Wood",{quantity= RPG.smartInt(buyDelay/75) }))

        self:collect(RPD.createItem("materials/RunicSteel",{quantity= RPG.smartInt(buyDelay/85) }))

        self:collect(RPD.createItem("materials/Ruby",{quantity= RPG.smartInt(buyDelay/100) }))

        self:collect(RPD.createItem("materials/Nephrite",{quantity= RPG.smartInt(buyDelay/125) }))
        end

      if RPG.luck ~= nil then
        Add.blacksmithDialog(blacksmithInteract)
      end
      return true
    end,

    priceForSell = function(self, item)
        return RPG.smartInt(item:price() * 1.3)
    end,

    spawn = function(self, chr)
    end
})
