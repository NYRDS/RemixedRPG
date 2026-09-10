
--
--Created by Mongol
-- VK: mongolinsult
--

local RPD = require "scripts/lib/commonClasses"
local RPG = require "scripts/lib/Functions"
local Add = require "scripts/lib/AdditionalFunctions"

local interlevelScene = {}

windowShown = false

function showWindowLoop(wnd)
    RPD.RemixedDungeon:scene():enumerateWindows()
    local activeWindow = RPD.RemixedDungeon:scene():getWindow(0)
    if not windowShown then
        if activeWindow == nil then
            RPD.RemixedDungeon:scene():add(wnd)
            windowShown = true
        end
    else
        if activeWindow == nil then
            wnd = nil
            return true
        end
    end
    return false
end

--! Called when interlevelScene enters static mode

interlevelScene.onStep = function(mode, done)
    if not done then
        return false
    end

    if not wnd then
        if RPD.ModdingMode:inMod() then
            if RPD.Dungeon.previousLevelId == '0' then
                wnd = RPD.new(RPD.Objects.Ui.WndQuest, RPD.Dungeon.hero, RPD.textById("SpiderQueen_DieInfo"))
            end

            if RPD.Dungeon.previousLevelId == 'necro5' and RPD.Badges:isUnlockedInThisGame(RPD.Badges.Badge.LICH_SLAIN) then
                wnd = RPD.new(RPD.Objects.Ui.WndQuest, RPD.Dungeon.hero, RPD.textById("Lich_DieInfo"))
            end

            if RPD.Dungeon.previousLevelId == 'ice5' and RPD.Badges:isUnlockedInThisGame(RPD.Badges.Badge.ICE_GUARDIAN_SLAIN) then
                wnd = RPD.new(RPD.Objects.Ui.WndQuest, RPD.Dungeon.hero, RPD.textById("IceGuardianCore_DieInfo"))
            end
        end

        if RPD.Dungeon.levelId == '' and RPD.ModdingMode:inMod() then
            wnd = Add.rpdImage("arts/a.jpeg")
            wnd:setScaleX(0)
            wnd:setScaleY(0)
            RPD.RemixedDungeon:scene():add(wnd)
        end
    end

    return true
end


return interlevelScene
