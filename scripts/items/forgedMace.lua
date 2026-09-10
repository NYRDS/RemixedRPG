--
-- Created by Mongol
-- VK: mongolinsult
--

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local Add = require "scripts/lib/AdditionalFunctions"

local storage = require "scripts/lib/storage"

local forgedMace = require "scripts/lib/forgedMace"

local item = require "scripts/lib/item"


local config = forgedMace.makeWeapon()
return item.init(config)
