-- Define a variable to hold the ID of the text label
local textLabel = nil

-- Define a function to draw the player's vRP ID over their head
function DrawPlayerVRPId(player)
    local vrpId = vRP.getUserId(player)

    -- Only draw the vRP ID if it's valid
    if vrpId then
        -- Get the player's position
        local x, y, z = table.unpack(GetEntityCoords(player, true))

        -- Draw the vRP ID text above the player's head
        SetTextComponentFormat("STRING")
        AddTextComponentString("vRP ID: " .. vrpId)
        textLabel = DrawText(x, y, z + 1.0)
    end
end

-- Call the DrawPlayerVRPId function when the player is created and every 5 seconds thereafter
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        -- Loop through all active players
        for _, player in ipairs(GetActivePlayers()) do
            -- Draw the vRP ID text above the player's hea
            DrawPlayerVRPId(GetPlayerPed(player))
        end

        -- Wait 5 seconds before drawing the vRP ID again
        Citizen.Wait(5000)

        -- Remove the text label from the screen
        if textLabel then
            SetTextEntry("STRING")
            RemoveTextLabel(textLabel)
            textLabel = nil
        end
    end
end)