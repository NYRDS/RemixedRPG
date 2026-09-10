--
-- Created by Mongol
-- VK: mongolinsult
--

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local RPG1 = require "scripts/lib/AdditionalFunctions"

local storage = require "scripts/lib/storage"

local forgedWeapon = require "scripts/lib/forgedWeapon"

local item = require "scripts/lib/item"


local config = forgedWeapon.makeWeapon()
return item.init(config)
