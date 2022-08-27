ESX = nil
TriggerEvent(cfg.esxInit, function(obj) ESX = obj end)

local LOGS_WEBHOOK = 'https://discord.com/api/webhooks/'

ESX.RegisterServerCallback('kits:odbierz', function(source,cb, kit)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.execute("UPDATE `users` set kitsPermsLevel=@level WHERE identifier=@hex",  {
        ['@hex'] = hex,
        ['@level'] = kit
    })
    MySQL.Async.fetchAll('SELECT hex,type,expires as timestamp FROM zykem_kits WHERE hex = @hex AND type = @type', {
    
        ['@hex'] = xPlayer.getIdentifier(),
        ['@type'] = kit

    }, function(result)

        MySQL.Async.fetchAll('SELECT kitsPermsLevel FROM users WHERE identifier=@hex', {

            ['@hex'] = xPlayer.getIdentifier()

        }, function(result2)
        
            if kit == 'basic' then

                if result[1] ~= nil then
    
                    TriggerClientEvent('esx:showNotification', xPlayer.source, 'Juz odebrales ten Zestaw! ')
    
                else
                    

                    local insertData = {
                        rok = round(os.date('%Y'),0),
                        miesiac = round(os.date('%m'),0),
                        dzien = round(os.date('%d'),0),
                        godzina = round(os.date('%H') + cfg.basicCooldown,0),
                        minuta = round(os.date('%M'),0),
                        sekunda = round(os.date('%S'),0)
                  
                    }
                    local cData = {year = insertData.rok, month = insertData.miesiac, day = insertData.dzien, hour = insertData.godzina, min = insertData.minuta, sec = insertData.sekunda}
                    local final_data = os.time(cData)
                    items = {}
        
                    for k,v in pairs (cfg.Kits.basic) do
        
                        if v.item then
        
                            if v.amount then
        
                                table.insert(items, {
        
                                    item = v.item,
                                    amount = v.amount
        
                                })
        
                            end
        
                        end
        
                    end
        
                    for k,v in pairs(items) do
        
                        xPlayer.addInventoryItem(v.item, v.amount)
        
                    end
        
                    if cfg.Logs == true then
        
                        zykem_SendWebhook('/kits', 'Gracz odebral Zestaw Basic!', xPlayer.source)
        
                    end
        
                    MySQL.Sync.execute('INSERT INTO zykem_kits (hex,type,expires) VALUES (@hex, @type, @expires)', {
        
                        ['@hex'] = xPlayer.getIdentifier(),
                        ['@type'] = kit,
                        ['@expires'] = final_data
        
                    })
        
                    cb(true)
    
                end
    
            elseif kit == 'iron' then
    
                if result[1] ~= nil then
    
                    TriggerClientEvent('esx:showNotification', xPlayer.source, 'Juz odebrales ten Zestaw! ')
    
                else
    
                    if result2[1].kitsPermsLevel >= 1 then

                        local insertData = {
                            rok = round(os.date('%Y'),0),
                            miesiac = round(os.date('%m'),0),
                            dzien = round(os.date('%d'),0),
                            godzina = round(os.date('%H') + cfg.ironCooldown,0),
                            minuta = round(os.date('%M'),0),
                            sekunda = round(os.date('%S'),0)
                      
                        }
                        local cData = {year = insertData.rok, month = insertData.miesiac, day = insertData.dzien, hour = insertData.godzina, min = insertData.minuta, sec = insertData.sekunda}
                        local final_data = os.time(cData)
                        items = {}
            
                        for k,v in pairs (cfg.Kits.iron) do
            
                            if v.item then
            
                                if v.amount then
            
                                    table.insert(items, {
            
                                        item = v.item,
                                        amount = v.amount
            
                                    })
            
                                end
            
                            end
            
                        end
            
                        for k,v in pairs(items) do
            
                            xPlayer.addInventoryItem(v.item, v.amount)
            
                        end
            
                        if cfg.Logs == true then
            
                            zykem_SendWebhook('/kits', 'Gracz odebral Zestaw Iron!', xPlayer.source)
            
                        end
            
                        MySQL.Sync.execute('INSERT INTO zykem_kits (hex,type,expires) VALUES (@hex, @type, @expires)', {
            
                            ['@hex'] = xPlayer.getIdentifier(),
                            ['@type'] = kit,
                            ['@expires'] = final_data
            
                        })
            
                        cb(true)
                    else

                        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Nie posiadasz Dostępu do tego Zestawu!')

                    end
    
                end
    
            elseif kit == 'gold' then
    
                if result[1] ~= nil then
    
                    TriggerClientEvent('esx:showNotification', xPlayer.source, 'Juz odebrales ten Zestaw! ')
    
                else
    
                    if result2[1].kitsPermsLevel >= 2 then

                        local insertData = {
                            rok = round(os.date('%Y'),0),
                            miesiac = round(os.date('%m'),0),
                            dzien = round(os.date('%d'),0),
                            godzina = round(os.date('%H') + cfg.goldCooldown,0),
                            minuta = round(os.date('%M'),0),
                            sekunda = round(os.date('%S'),0)
                      
                        }
                        local cData = {year = insertData.rok, month = insertData.miesiac, day = insertData.dzien, hour = insertData.godzina, min = insertData.minuta, sec = insertData.sekunda}
                        local final_data = os.time(cData)
                        items = {}
            
                        for k,v in pairs (cfg.Kits.gold) do
            
                            if v.item then
            
                                if v.amount then
            
                                    table.insert(items, {
            
                                        item = v.item,
                                        amount = v.amount
            
                                    })
            
                                end
            
                            end
            
                        end
            
                        for k,v in pairs(items) do
            
                            xPlayer.addInventoryItem(v.item, v.amount)
            
                        end
            
                        if cfg.Logs == true then
            
                            zykem_SendWebhook('/kits', 'Gracz odebral Zestaw Gold!', xPlayer.source)
            
                        end
            
                        MySQL.Sync.execute('INSERT INTO zykem_kits (hex,type,expires) VALUES (@hex, @type, @expires)', {
            
                            ['@hex'] = xPlayer.getIdentifier(),
                            ['@type'] = kit,
                            ['@expires'] = final_data
            
                        })
            
                        cb(true)
                    else

                        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Nie posiadasz Dostępu do tego Zestawu!')

                    end
    
                end
    
            elseif kit == 'diamond' then
    
                if result[1] ~= nil then
    
                    TriggerClientEvent('esx:showNotification', xPlayer.source, 'Juz odebrales ten Zestaw! ')
    
                else
    
                    if result2[1].kitsPermsLevel >= 3 then

                        local insertData = {
                            rok = round(os.date('%Y'),0),
                            miesiac = round(os.date('%m'),0),
                            dzien = round(os.date('%d'),0),
                            godzina = round(os.date('%H') + cfg.diamondCooldown,0),
                            minuta = round(os.date('%M'),0),
                            sekunda = round(os.date('%S'),0)
                      
                        }
                        local cData = {year = insertData.rok, month = insertData.miesiac, day = insertData.dzien, hour = insertData.godzina, min = insertData.minuta, sec = insertData.sekunda}
                        local final_data = os.time(cData)
                        items = {}
            
                        for k,v in pairs (cfg.Kits.diamond) do
            
                            if v.item then
            
                                if v.amount then
            
                                    table.insert(items, {
            
                                        item = v.item,
                                        amount = v.amount
            
                                    })
            
                                end
            
                            end
            
                        end
            
                        for k,v in pairs(items) do
            
                            xPlayer.addInventoryItem(v.item, v.amount)
            
                        end
            
                        if cfg.Logs == true then
            
                            zykem_SendWebhook('/kits', 'Gracz odebral Zestaw Diamond!', xPlayer.source)
            
                        end
            
                        MySQL.Sync.execute('INSERT INTO zykem_kits (hex,type,expires) VALUES (@hex, @type, @expires)', {
            
                            ['@hex'] = xPlayer.getIdentifier(),
                            ['@type'] = kit,
                            ['@expires'] = final_data
            
                        })
            
                        cb(true)

                    else

                        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Nie posiadasz Dostępu do tego Zestawu!')

                    end
    
                end
    
            end
        
        end)
        
        
    end)



end)

RegisterServerEvent('kits:expired')
AddEventHandler('kits:expired', function(hex)
	MySQL.Async.execute('DELETE FROM zykem_kits WHERE hex = @hex', 
	{
		['@hex'] = hex
	}, function(rowsChanged)
		print("[INFO] # Usunieto " .. hex .. ' z cooldownu Kitu!')
	end)
end)

function checkTime(d, h, m)
	print("[INFO] # Sprawdzam Czas")

	MySQL.Async.fetchAll('SELECT hex, expires as timestamp FROM zykem_kits', 
		{
			
		}, 
		function(result)
			local time_now = os.time()
			for i=1, #result, 1 do
				local dostepTime = result[i].timestamp
				if dostepTime <= time_now then
					TriggerEvent('kits:expired', result[i].hex)
				end
			end
		end
	)
end



function round(num, numDecimalPlaces)
    if numDecimalPlaces and numDecimalPlaces>0 then
      local mult = 10^numDecimalPlaces
      return math.floor(num * mult + 0.5) / mult
    end
    return math.floor(num + 0.5)
  end

function zykem_SendWebhook(eventname,wiecejinfo,idgracza)
	local steamid  = 'brak'
    local license  = 'brak'
    local discord  = 'brak'
    local xbl      = 'brak'
    local liveid   = 'brak'
    local ip       = 'brak'


  for k,v in pairs(GetPlayerIdentifiers(idgracza))do
        
      if string.sub(v, 1, string.len("steam:")) == "steam:" then
        steamid = v
      elseif string.sub(v, 1, string.len("license:")) == "license:" then
        license = v
      elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
        xbl  = v
      elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
        ip = v
      elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
        discord = v
      elseif string.sub(v, 1, string.len("live:")) == "live:" then
        liveid = v
      end
    
	  
	end
	local embed = {
        {
            ["color"] = 16753920,
            ["title"] = "**zykem_kits**",
            ["description"] = 'Gracz wlasnie uzyl `'..eventname..'`\nSteamID: **'..steamid..'**\nLicencja: **'..license..'**\nIP: **'..ip..'\n**ID Serwerowe:**' .. idgracza .. '\n**Nick Gracza:** '..GetPlayerName(idgracza)..'\n\n**Wiecej info:**'..wiecejinfo..'**',
            ["footer"] = {
                ["text"] = 'zykem_kits Logs',
            },
        }
    }
	PerformHttpRequest(LOGS_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = 'zykem_kits', embeds = embed}), { ['Content-Type'] = 'application/json' })

end

RegisterCommand('setkit', function(source, args)
    local targetid = args[1]
    local xPlayer = ESX.GetPlayerFromId(source)
    local target
    local hex
    local kit
    if targetid ~= nil and args[2] ~= nil then
        target = ESX.GetPlayerFromId(targetid)
        hex = target.getIdentifier()
         kit = args[2]
        print('test')
    end

        if xPlayer.getGroup() == 'admin' then
            if hex ~= nil and kit ~= nil then

                if kit == '1' or kit == '2' or kit == '3' then
                    MySQL.Async.execute("UPDATE `users` set kitsPermsLevel=@level WHERE identifier=@hex",  {
                        ['@hex'] = hex,
                        ['@level'] = kit
                    })
                    TriggerClientEvent('esx:showNotification', xPlayer.source, 'Nadałeś permisje do Zestawu graczowi ' .. GetPlayerName(targetid))
        
                else
                    
                    print('Niepoprawny kit/hex!\nDDostepne kity: 1,2,3 (1=iron | 2 = gold | 3 = diamond )\nUzycie: /kit id kit')
        
                end
        
            else
                print('Niepoprawny kit/hex!\nDostepne kity: 1,2,3 (1=iron | 2 = gold | 3 = diamond )\nUzycie: /kit id kit')
            end
        else 

            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Nie posiadasz Permisji!')

        end
    
end)

-- cron tasks
TriggerEvent('cron:runAt', 02, 0, checkTime)
TriggerEvent('cron:runAt', 04, 0, checkTime)
TriggerEvent('cron:runAt', 12, 0, checkTime)
TriggerEvent('cron:runAt', 14, 0, checkTime)
TriggerEvent('cron:runAt', 16, 0, checkTime)
TriggerEvent('cron:runAt', 18, 0, checkTime)
TriggerEvent('cron:runAt', 20, 0, checkTime)
TriggerEvent('cron:runAt', 22, 0, checkTime)
TriggerEvent('cron:runAt', 24, 0, checkTime)