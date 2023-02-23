--ENCHANTING EXPANDED/main.lua
-- Define our callback, which will get called when the event happens.
local function myKeyEvent(eventData)
    -- Exit the function is the actor is not the player.
    -- if (eventData.reference ~= tes3.player) then
    --     tes3.messageBox("Not the player")
    --     return
    -- end
    -- tes3.messageBox("Is the player")

    if (eventData.pressed) then
        tes3.messageBox("Key Pressed, you get gold")
        tes3.AddItem({
            reference = tes3.player,
            item = "Gold_001"
        })
    else
        tes3.messageBox("Key Released")
    end

    e.tes3ui.forcePlayerInventoryUpdate()
end

-- Tell MWSE that we want our callback to be invoked when a key is pressed.

-- The function to call on the showMessageboxOnWeaponReadied event.
local function showMessageboxOnWeaponReadied(eventData)
    -- Exit the function is the actor is not the player.
    if (eventData.reference ~= tes3.player) then
        tes3.messageBox("enemy weapon!")
        tes3.setStatistic({
            reference = tes3.getPlayerRef(),
            name = "health",
            current = 0
        })
        return
    end
    
    tes3.messageBox("You are about to get a gold")
    local numAdded = tes3.AddItem({
        reference = tes3.player,
        item = "Gold_001",
        count = 500,
        playSound = false
    })
    tes3.playSound({
        sound = "enchant success",
        reference = tes3.player
    })
    tes3ui.forcePlayerInventoryUpdate()
    tes3.messageBox("You should have gotten "..numAdded.." gold")

    -- Locally store the weapon reference being readied in the event.
    local weaponStack = e.weaponStack

    -- Check that the reference exists and the reference object is a two-handed weapon.
    if (weaponStack and weaponStack.object.isTwoHanded) then
        -- Print our statement.
        tes3.messageBox("I just drew " .. weaponStack.object.name .. ", destroyer of worlds!")
        -- tes3.messageBox(weaponStack.object.)
    end
end

local soulgems = {
    [30] = "Misc_SoulGem_Petty",
    [60] = "Misc_SoulGem_Lesser",
    [120] = "Misc_SoulGem_Common",
    [180] = "Misc_SoulGem_Greater",
    [600] = "Misc_SoulGem_Grand",
    [5000] = "Misc_SoulGem_Azura",
}
local soulgemIDs = {
    "Misc_SoulGem_Petty",
    "Misc_SoulGem_Lesser",
    "Misc_SoulGem_Common",
    "Misc_SoulGem_Greater",
    "Misc_SoulGem_Grand",
    "Misc_SoulGem_Azura",
    "AB_Misc_SoulGemBlack"
}

local function onEquip(eventData)
    --Determine if the player equipped a filled Soul Gem
    if eventData.reference ~= tes3.player                       --If not the player
    or eventData.item.objectType ~= tes3.objectType.miscItem    --if item isn't Misc Item
    then return end           

    local isSoulGem = false
    local isSoulGemFilled = false;

    for i = 1, #soulgemIDs, 1 do
        if (tostring(soulgemIDs[i]) == tostring(eventData.item.id)) then
            print("[EnchantExpanded: INFO] Soul Gem Equipped: "..eventData.item.id)
            isSoulGem = true --You have equipped a Soul Gem
        end
    end

    if ~isSoulGem then return   --Item equipped is not a soul gem
    elseif eventData.itemData == nil or eventData.itemData.soul == nil then --The soul gem is empty
        --Do Empty Soul Gem Stuff
    else then
        --Do Filled Soul Gem Stuff
        print("[EnchantExpanded: INFO] Soul: "..eventData.itemData.soul.id)
    end



    print("[EnchantExpanded: INFO] Soul: "..eventData.itemData.soul.id)



    

    -- tes3.addItem({
    --     reference = tes3.player,
    --     item = "Misc_Soulgem_Grand",
    --     soul = "OJ_GT_CommSoulCreature",
    --     playSound = false
    -- })

    -- tes3.playSound({
    --     sound = "enchant success",
    --     reference = tes3.player
    -- })
    -- tes3ui.forcePlayerInventoryUpdate()
end


dofile("EnchantingExpanded.mcm")

--Types/tes3alchemy.effects, tes3spell.effect, tes3enchantment.effect
-- @param magicSource tes3spell|tes3enchantment|tes3alchemy
-- local function isSpellHostile(magicSource)
--     for _, effect in ipairs(magicSource.effects) do
--         if (effect.object.isHarmful) then
--             -- If one of the spell's effects is harmful, then
--             -- `true` is returned and function ends here.
--             return true
--         end
--     end
--     -- If no harmful effect was found then return `false`.
--     return false
-- end



local function initialized()
    event.register(tes3.event.weaponReadied, showMessageboxOnWeaponReadied)
    event.register(tes3.event.equip, onEquip)

    print("[EnchantExpanded: INFO] EnchantExpanded Initialized")
end

event.register(tes3.event.initialized, initialized)