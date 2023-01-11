local displayui = false

ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent(cfg.esxInit, function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNUICallback("basickit", function(data)

    ESX.TriggerServerCallback('kits:odbierz', function(cb)
        
        print('Succesfully redeemed kit!')
    
    end, 'gracz')

end)

RegisterNUICallback("ironkit", function(data)

    ESX.TriggerServerCallback('kits:odbierz', function(cb)
    
        print('Succesfully redeemed kit!')
    
    end, 'vip')

end)

RegisterNUICallback("goldkit", function(data)

    ESX.TriggerServerCallback('kits:odbierz', function(cb)

        print('Succesfully redeemed kit!')

    end, 'svip')

end)

RegisterNUICallback("diamondkit", function(data)

    ESX.TriggerServerCallback('kits:odbierz', function(cb)
        
        print('Succesfully redeemed kit!')
    
    end, 'legend')

end)

function notify(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, true)
end

function SetDisplay(bool)

    displayui = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({

        type="ui",
        status = bool

    })

end

-- Exit callback to call it 
RegisterNUICallback("exit", function(data)

    print('exitUi')
    SetDisplay(not displayui)

end)

RegisterCommand('kits', function(args)

    SetDisplay(not displayui)

end)