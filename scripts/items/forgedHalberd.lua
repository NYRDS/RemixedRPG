--
-- Created by Mongol
-- VK: mongolinsult
--

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local Add = require "scripts/lib/AdditionalFunctions"

local storage = require "scripts/lib/storage"

local forgedHalberd = require "scripts/lib/forgedHalberd"

local item = require "scripts/lib/item"


local config = forgedHalberd.makeWeapon()
return item.init(config)
