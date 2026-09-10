--
-- Created by Mongol
-- VK: mongolinsult
--

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local Add = require "scripts/lib/AdditionalFunctions"

local storage = require "scripts/lib/storage"

local forgedDagger = require "scripts/lib/forgedDagger"

local item = require "scripts/lib/item"


local config = forgedDagger.makeWeapon()
return item.init(config)
