
local RPD = require "scripts/lib/commonClasses"

local mob = require"scripts/lib/mob"
local RPG = require"scripts/lib/Functions"

return mob.init{
attackProc = function(self, enemy, dmg)
    return RPG.getDamage(enemy,dmg,"mag","fire")
end
}
