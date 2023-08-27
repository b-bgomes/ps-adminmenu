-- Open Inventory
RegisterNetEvent('ps-adminmenu:client:openInventory', function(data, selectedData)
    local id = selectedData["Player"].value

    if not CheckPerms(data.perms) then return end

    if Config.Inventory == 'ox_inventory' then
        TriggerServerEvent("ps-adminmenu:server:OpenInv", id)
    else
        TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", id)
    end
end)

-- Open Stash
RegisterNetEvent('ps-adminmenu:client:openStash', function(inputData, _, perms)
    if not PermsCheck(perms) then return end

    local stash = inputData["Stash"]

    if Config.Inventory == 'ox_inventory' then
        TriggerServerEvent("ps-adminmenu:server:OpenStash", stash)
    else
        TriggerServerEvent("inventory:server:OpenInventory", "stash", tostring(stash))
        TriggerEvent("inventory:client:SetCurrentStash", tostring(stash))
    end
end)