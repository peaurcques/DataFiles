-- Define our callback, which will get called when the event happens.
local function myKeyEvent(eventData)
    -- Exit the function is the actor is not the player.
    if (e.reference ~= tes3.player) then
        return
    end
    
    if (eventData.pressed) then
        tes3.messageBox("Key was pressed.")
    else
        tes3.messageBox("Key was released.")
    end
end

-- Tell MWSE that we want our callback to be invoked when a key is pressed.

-- The function to call on the showMessageboxOnWeaponReadied event.
local function showMessageboxOnWeaponReadied(e)
    -- Exit the function is the actor is not the player.
    if (e.reference ~= tes3.player) then
        return
    end

    -- Locally store the weapon reference being readied in the event.
    local weaponStack = e.weaponStack

    -- Check that the reference exists and the reference object is a two-handed weapon.
    if (weaponStack and weaponStack.object.isTwoHanded) then
        -- Print our statement.
        tes3.messageBox("I just drew " .. weaponStack.object.name .. ", destroyer of worlds!")
    end
end

-- The function to call on the initialized event.
local function initialized()
    -- Register our function to the onReadied event.
    event.register(tes3.event.weaponReadied, showMessageboxOnWeaponReadied)
    event.register(tes3.event.key, myKeyEvent)

    -- Print a "Ready!" statement to the MWSE.log file.
    print("[MWSE Guide Demo: INFO] MWSE Guide Demo Initialized")
end

-- dofile("AlchemyExpanded.mcm")

-- Register our initialized function to the initialized event.
-- event.register(tes3.event.initialized, initialized)


dofile("AlchemyExpanded.mcm")