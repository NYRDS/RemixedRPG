local RPD                  = require "scripts/lib/commonClasses"
local RPG                  = require "scripts/lib/Functions"
local Add                  = require "scripts/lib/AdditionalFunctions"


local hero
local smithy

smithy = {
  mainWnd = mainWnd,
  weaponWnd = weaponWnd,
  armorWnd = armorWnd,
  meleeWnd = meleeWnd,
  thisTwohanded = false,
  chooseMaterials = chooseMaterials,
  missileWnd = missileWnd,
  choosenObject = choosenObject,
  quantityForItem = quantityForItem,
  iconGroup = iconGroup,
  mode = mode,
  wType = wType,
  quantityToChoose = 0,
  allQuantity = {0,0},
  selectedItem = selectedItem,
  finalStats = finalStats,
  finalMaterials={{},{}},
  lvl = lvl,
  exp = exp,
  expToUp = expToUp,
  myself = myself,
  goldForBuy = 0,
  materialCount =
  {
    Sword={8,5},
    Longsword={14,5},
    Dagger={4,5},
    Spear={10,5},
    Mace={8,5},
    Hammer={16,5},
    Axe={8,5},
    Hatchet={14,5},
    Halberd={14,5},
    Bow={8,5},
    Crossbow={12,5},
    MagicStaff={10,5},
    MagicWand={5,5},
    LightArmor={6,5},
    MediumArmor={10,5},
    HeavyArmor={14,5}
  },

mainWnd = function(index)
  smithy.quantityToChoose = 0
  smithy.allQuantity = {0,0}
  smithy.finalMaterials={{},{}}
  if index == 0 then
    Add.smithWeapon(smithy.weaponWnd)
    else
    Add.smithArmor(smithy.armorWnd)
    end
end,

weaponWnd = function(index)
  smithy.mode = "weapon"
  if index == 0 then
    Add.smithMelee(smithy.meleeWnd)
  else
    Add.smithRange(smithy.missileWnd)
  end
end,

meleeWnd = function(index)
  local type = {
  "oneHanded",
  "twoHanded"
  }
  if index == 0 then
    Add.smithOnehand(smithy.onehandWnd)
  else
    Add.smithTwohand(smithy.twohandWnd)
  end
  smithy.wType = type[index+1]
end,

onehandWnd = function(index)
  local chooses =
  {
    "Sword",
    "Dagger",
    "Axe",
    "Mace"
  }

  smithy.choosenObject = chooses[index+1]
  Add.smithChooseMaterials(smithy.chooseMaterials)
end,

twohandWnd = function(index)
  local chooses =
  {
    "Longsword",
    "Spear",
    "Hatchet",
    "Halberd",
    "Hammer"
  }

  smithy.choosenObject = chooses[index+1]
  smithy.thisTwohanded = true
  Add.smithChooseMaterials(smithy.chooseMaterials)
end,

missileWnd = function(index)
  local chooses =
  {
    "Bow",
    "Crossbow",
    "MagicStaff",
    "MagicWand"
  }

  smithy.choosenObject = chooses[index+1]
  if index > 1 then
    smithy.mode = "magic"
  end
  if index == 1 then
    smithy.thisTwohanded = true
  end
  Add.smithChooseMaterials(smithy.chooseMaterials)
end,

armorWnd = function(index)
  smithy.mode = "armor"
  local chooses =
  {
    "LightArmor",
    "MediumArmor",
    "HeavyArmor"
  }


  smithy.choosenObject = chooses[index+1]
  Add.smithChooseMaterials(smithy.chooseMaterials)
end,

chooseMaterials = function(index)
  local WndBag = RPG.Objects.Ui.WndBag
  local materialCount = smithy.materialCount
  local hero = RPD.Dungeon.hero
  local mCount = materialCount[smithy.choosenObject]
  local finalGroup = smithy.finalMaterials[index+1]
  local quantityOfChoosed = {0,0}
  local selectedItem

  for i = 1,2 do

    local fMaterialsGroup = smithy.finalMaterials[i]

    for ii =1,#fMaterialsGroup do

      local fMaterial = fMaterialsGroup[ii]
      quantityOfChoosed[i] = quantityOfChoosed[i] + (fMaterial[2] or 0)

    end
  end


  if index == 2 then

        smithy.quantityToChoose = smithy.quantityToChoose+1
      elseif index == 3 then

        if smithy.quantityToChoose ~= 0 then
          smithy.quantityToChoose = smithy.quantityToChoose-1

        end
      end


    if (mCount[index+1] or 0) - (quantityOfChoosed[index+1] or 0) >= smithy.quantityToChoose and smithy.quantityToChoose ~= 0 then


      if index < 2 then
        RPG.selectItemForSmithing(luajava.bindClass(WndBag).Mode.ALL,"chooseTheMaterials",index+1,smithy.quantityToChoose)
        smithy.quantityToChoose = 0
      end

        elseif index ~= 4 then
        Add.smithChooseMaterials(smithy.chooseMaterials)

      end


      if index == 4 and quantityOfChoosed[1] == mCount[1] and smithy.goldForBuy <= hero:gold()  then
        hero = RPD.Dungeon.hero
        hero:spendGold(smithy.goldForBuy)

        local is = RPG.statsFromMaterials(smithy.finalMaterials,smithy.mode)

        smithy.finalStats = {activationCount = 0, str = is.str,info=is.info, name = is.name, visualName = is.visualName, icon = is.icon, tier = is.tier, dr = is.dr, maxDmg = is.maxDmg, minDmg = is.minDmg, accuracy = is.accuracy, delay = is.delay, range = is.range, dstats = is.dstats, addstats = is.addStats, type = is.type, element = is.element, wType = smithy.wType, choosenObject = smithy.choosenObject, level = 0, rareScale = is.rareScale}

        if smithy.mode == "armor" then
          armor = RPD.item("forgedArmor")
          hero:collect(armor,1)
        else
          weapon = RPD.item("forged"..smithy.choosenObject)
          hero:collect(weapon,1)
        end

        smithy.finalMaterials={{},{}}
        smithy.goldForBuy = 0
        smithy.thisTwohanded = false
        RPD.playSound("snd_evoke.ogg")
      elseif index == 4 then
        RPD.playSound("snd_wrong.ogg")
        RPD.glog("cantForge")
      end
    end


}
return smithy
