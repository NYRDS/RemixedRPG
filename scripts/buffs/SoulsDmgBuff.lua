---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD  = require "scripts/lib/commonClasses"
local RPG  = require "scripts/lib/Functions"
local storage = require "scripts/lib/storage"

local a = "soulstormentor"
local hero = RPD.Dungeon.hero
local elmnt

local buff = require "scripts/lib/buff"

return buff.init{
    desc  = function ()
        return {
            icon          = 54,
            name          = "SoulsTormentor_BuffN",
            info          = "SoulsTormentor_BuffD",
        }
    end,

    attackProc = function(self,buff,enemy,damage)
      local Spell = storage.gameGet(a) or {}
      if enemy:buffLevel("SoulsDmgMark") == 0 then
      RPD.affectBuff(enemy, "SoulsDmgMark", 1+Spell.lvl):level(1 +(buff.target:buffLevel("FastSoulsMarks") or 0))
      else
      local staks = enemy:buffLevel("SoulsDmgMark") +(buff.target:buffLevel("FastSoulsMarks") or 0) +1
      local mark = enemy:buff("SoulsDmgMark")
      mark:level(staks)
      mark:spend((1 +Spell.lvl))
      end

    return damage
    end
}
