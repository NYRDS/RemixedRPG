--
--Created by Mongol
-- VK: mongolinsult
--

local RPD = require "scripts/lib/commonClasses"
local RPG = require "scripts/lib/Functions"
local Add = require "scripts/lib/AdditionalFunctions"
local smithy = require "scripts/lib/smithing"
local storage = require "scripts/lib/storage"
local GameData =luajava.bindClass("com.watabou.pixeldungeon.Statistics")
local mob = require"scripts/lib/mob"
local quest = require"scripts/lib/quest"

local hero
local buyDelay = 0
local lvl = 2
local seller
local data

return mob.init({

  interact = function(self, chr)

    hero = RPD.Dungeon.hero
    seller = self
    data = storage.gameGet("heroSteps", {steps = 1})
    buyDelay = data.steps


      if buyDelay > 50 then
        storage.gamePut("heroSteps",{steps = 1})

        self:collect(RPD.createItem("materials/iron",{quantity= RPG.smartInt(buyDelay/80) }))

        self:collect(RPD.createItem("materials/steel",{quantity= RPG.smartInt(buyDelay/80) }))

        self:collect(RPD.createItem("materials/gold",{quantity= RPG.smartInt(buyDelay/100) }))

        self:collect(RPD.createItem("materials/leather",{quantity= RPG.smartInt(buyDelay/80) }))

        self:collect(RPD.createItem("materials/cloth",{quantity= RPG.smartInt(buyDelay/60) }))

        self:collect(RPD.createItem("materials/Wood",{quantity= RPG.smartInt(buyDelay/75) }))

        self:collect(RPD.createItem("materials/RunicSteel",{quantity= RPG.smartInt(buyDelay/85) }))

        self:collect(RPD.createItem("materials/Ruby",{quantity= RPG.smartInt(buyDelay/100) }))

        self:collect(RPD.createItem("materials/Nephrite",{quantity= RPG.smartInt(buyDelay/125) }))
        end

      if RPG.luck ~= nil then
        RPD.showTradeWindow(seller,hero)
      end
    end,

    priceForSell = function(self, item)
        return RPG.smartInt(item:price() * 1.3)
    end,

    spawn = function(self, chr)
      data = storage.gameGet("blacksmithAct") or {act = 0}
      if data.act == 0 then
        storage.gamePut("blacksmithAct",{ act = 1})
      self:collect(RPD.createItem("materials/iron",{quantity=10}))

      self:collect(RPD.createItem("materials/steel",{quantity=10}))

      self:collect(RPD.createItem("materials/gold",{quantity=10}))

      self:collect(RPD.createItem("materials/leather",{quantity=10}))

      self:collect(RPD.createItem("materials/cloth",{quantity=10}))

      self:collect(RPD.createItem("materials/Wood",{quantity=10}))

      self:collect(RPD.createItem("materials/RunicSteel",{quantity=10}))

      self:collect(RPD.createItem("materials/Ruby",{quantity=10}))

      self:collect(RPD.createItem("materials/Nephrite",{quantity=10}))

      end
    end
})
