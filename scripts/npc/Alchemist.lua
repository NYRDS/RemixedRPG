--
--Created by Mongol
-- VK: mongolinsult
--


local RPD = require "scripts/lib/commonClasses"

local Add = require "scripts/lib/AdditionalFunctions"

local storage = require "scripts/lib/storage"

local mob = require"scripts/lib/mob"

local quest = require"scripts/lib/quest"

local sum
local need
local data
local hero

local npc = "Alchemist"
local questName =
{
"Без трав, как без рук",
"Что посеял, то пожнёшь"
}
local questText1 =
{
"Добрый день юноша, вам не составить труда мне помочь? Благодарю! Я недавно сюда приехал чтобы развернуть свой бизнес, но мою валюту не принимают здесь... \nНе мог бы ты принести мне трав из подземелья для изучения? По экземпляру каждого хватит. После я мог бы тебе сделать пилюли из трав, которые ты принесёшь, и небольшого количества золота."
}
local questText2 =
{
"Спасибо тебе большое! Зайди ко мне попозже, и я сделаю постараюсь сделать тебе особую пилюлю."
}
local needItems =
{
{
"Sungrass.Seed"
}
}

local recipes = {
{"Sungrass.Seed", "Earthroot.Seed", "BodyBoostPill"},
{"", "", ""},
{"", "", ""}
}

dialog = function(index)
  local hero = RPD.Dungeon.hero
  local recipe = recipes[index+1]
  if hero:getBelongings():getItem(recipe[1]) ~= nil and hero:getBelongings():getItem(recipe[2]) ~= nil then
    hero:getBelongings()
:getItem(recipe[1]):detach(hero:getBelongings().backpack)
    hero:getBelongings()
:getItem(recipe[2]):detach(hero:getBelongings().backpack)
    hero:collect(RPD.item(recipe[3]), 1)
    else
    RPD.glog("** Прости, но нужных семян у тебя нет")
  end
end

return mob.init({
    interact = function(self, chr)
    hero = RPD.Dungeon.hero
    Add.pillChoise(dialog)
    data = storage.gameGet(npc) or {}
    if data.Quest == nil then
      storage.gamePut(npc, {Quest = 1})
    end
    data = storage.gameGet(npc) or {}
    if quest.isGiven(questName[data.Quest]) == false and quest.isCompelete(questName[data.Quest]) == false then

     Add.showQuestWindow(self,tostring(questText1[data.Quest]))
     local hero = RPD.Dungeon.hero
     quest.give(questName[data.Quest], hero, {kills={""}})
     RPD.Journal:add(self:name()..": "..questName[data.Quest])
     quest.debug(true)

    else

      need = needItems[data.Quest]
      sum = 0
      for i = 1, #need do
        hero = RPD.Dungeon.hero
        if hero:getBelongings():getItem(need[i]) ~= nil then
          sum = sum +1
        end
      end

      if sum == #need then
        for i = 1, #need do
          hero = RPD.Dungeon.hero
          hero:getBelongings():getItem(need[i]):detach(hero:getBelongings().backpack)
        end
        Add.showQuestWindow(self,questText2[data.Quest])
        quest.complete(questName[data.Quest])
        list = recipes[1]
        hero:collect(RPD.item(list[3]), 1)
        sum = 0
        else
          RPD.glog("** Прости, но этого не достаточно")
      end

      end
    end
})
