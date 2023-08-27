-- Clear Inventory
RegisterNetEvent('ps-adminmenu:server:ClearInventory', function(data, selectedData)
    local id = selectedData["Player"].value

    if not CheckPerms(data.perms) then return end

    local Player = QBCore.Functions.GetPlayer(id)
    if not Player then QBCore.Functions.Notify(source, locale("not_online"), 'error', 7500) return end

    if Config.Inventory == 'ox_inventory' then
        exports.ox_inventory:ClearInventory(id)
    else
        exports[Config.Inventory]:ClearInventory(id, nil)
    end

    QBCore.Functions.Notify(source, locale("invcleared"), 'success', 7500)
end)

-- Open Inv [ox side]
RegisterNetEvent('ps-adminmenu:server:OpenInv', function(data)
    local Player = QBCore.Functions.GetPlayer(data)

    if not Player then QBCore.Functions.Notify(source, locale("not_online"), 'error', 7500) return end

    exports.ox_inventory:forceOpenInventory(source, 'player', data)
end)

-- Open Stash [ox side]
RegisterNetEvent('ps-adminmenu:server:OpenStash', function(data)
    exports.ox_inventory:forceOpenInventory(source, 'stash', data)
end)

-- Give Item
RegisterNetEvent('ps-adminmenu:server:GiveItem', function(data, selectedData)
    local id = selectedData["Player"].value
    local item = selectedData["Item"].value
    local amount = selectedData["Amount"].value

    if not CheckPerms(data.perms) then return end

    local Player = QBCore.Functions.GetPlayer(id)
    if not Player then QBCore.Functions.Notify(source, locale("not_online"), 'error', 7500) return end
    if not item or not amount then return end

    Player.Functions.AddItem(item, amount)

    QBCore.Functions.Notify(source, locale("give_item", {info = tonumber(amount) .. " " .. item, player = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname}), "success", 7500)
end)

-- Give Item to All
RegisterNetEvent('ps-adminmenu:server:GiveItemAll', function(data, selectedData)
    local item = selectedData["Item"].value
    local amount = selectedData["Amount"].value

    if not CheckPerms(data.perms) then return end

    if not item or not amount then return end

    local players = QBCore.Functions.GetPlayers()
    for _, id in pairs(players) do
        local Player = QBCore.Functions.GetPlayer(id)
        print(Player)
        Player.Functions.AddItem(item, amount)
        QBCore.Functions.Notify(source, locale("give_item_all", {info = amount .. " " .. item}), "success", 7500)
    end
end)