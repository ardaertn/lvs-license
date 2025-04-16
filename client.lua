local oldPlate = nil
local function CloseUI()
    SetNuiFocus(false, false)
    SendNUIMessage({ action = "closeUI" })
end

RegisterCommand("plateui", function()
    SetNuiFocus(true, true)
    SendNUIMessage({ action = "openUI" })
end)

RegisterNUICallback("exitUI", function(_, cb)
    CloseUI()
    cb('ok')
end)

RegisterNUICallback("buyPlate", function(data, cb)
    local plate = data.plate
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)

    if vehicle == 0 then
        cb({ success = false, message = "Araçta değilsin!" })
        return
    end

    oldPlate = GetVehicleNumberPlateText(vehicle)
    print(oldPlate)
    TriggerServerEvent("customplates:buyPlate", plate, oldPlate)
    cb('ok')
end)

RegisterNUICallback('sound', function()
    PlaySoundFrontend(-1, 'Click', 'DLC_HEIST_HACKING_SNAKE_SOUNDS', false)
end)

RegisterNetEvent("customplates:updateVehiclePlate", function(newPlate)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    if vehicle ~= 0 then
        SetVehicleNumberPlateText(vehicle, newPlate)
    end
    oldPlate = nil
end)

RegisterNetEvent('customplates:closeUI', function()
    CloseUI()
end)