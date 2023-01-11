ESX = nil
TriggerEvent(cfg.esxInit, function(obj) ESX = obj end)

local LOGS_WEBHOOK = 'https://discord.com/api/webhooks/'

ESX.RegisterServerCallback('kits:odbierz', function(source,cb, kit)
    local xPlayer = ESX.GetPlayerFromId(source)
    local rank = string.lower(exports.zykem_coinsystem:getRank(xPlayer.getIdentifier()))
    if rank ~= 'gracz' and rank ~= 'vip' and rank ~= 'svip' and rank ~= 'legend' then return false end;
    
    if rank == kit then
        MySQL.Async.fetchAll('SELECT identifier,type,expires as timestamp FROM zykem_kits WHERE identifier = @identifier AND type = @type', {
        
            ['@identifier'] = xPlayer.getIdentifier(),
            ['@type'] = kit

        }, function(result)   
            if result[1] ~= nil then TriggerClientEvent('esx:showNotification', xPlayer.source, 'Juz odebrales ten Zestaw! ') return end;
        
            local insertData = {
                rok = round(os.date('%Y'),0),
                miesiac = round(os.date('%m'),0),
                dzien = round(os.date('%d'),0),
                godzina = round(os.date('%H') + cfg.cooldown,0),
                minuta = round(os.date('%M'),0),
                sekunda = round(os.date('%S'),0)
                
            }
            local formatted_Date = {year = insertData.rok, month = insertData.miesiac, day = insertData.dzien, hour = insertData.godzina, min = insertData.minuta, sec = insertData.sekunda}
            local finalDate = os.time(formatted_Date)
            items = {}
            
            for k,v in pairs (cfg.Kits[string.lower(rank)]) do

                if v.item then
                                
                    if v.amount then
            
                        table.insert(items, {
            
                            item = v.item,
                            amount = v.amount
            
                            })
            
                    end
                    for k,v in pairs(items) do
            
                        xPlayer.addInventoryItem(v.item, v.amount)
                    
                    end
                end
                if v.coins then
                    print(v.coins)
                    exports["zykem_coinsystem"]:addUserCoins(source,xPlayer.getIdentifier(), v.coins)

                end
            
            end
            
            if cfg.Logs == true then
            
                zykem_SendWebhook(kit, 'Gracz odebral Zestaw!', xPlayer.source)
            
            end
            
            MySQL.Sync.execute('INSERT INTO zykem_kits (identifier,type,expires) VALUES (@identifier, @type, @expires)', {
        
                ['@identifier'] = xPlayer.getIdentifier(),
                ['@type'] = kit,
                ['@expires'] = finalDate
        
            })
            items = {}
            cb(true)

        end)
    else
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Do tego Zestawu nie posiadasz Permisji!')
    end
end)

RegisterServerEvent('kits:expired')
AddEventHandler('kits:expired', function(identifier)
	MySQL.Async.execute('DELETE FROM zykem_kits WHERE identifier = @identifier', 
	{
		['@identifier'] = identifier
	}, function(rowsChanged)
		print("[INFO] # Usunieto " .. identifier .. ' z cooldownu Kitu!')
	end)
end)

function checkTime(d, h, m)
	print("[INFO] # Sprawdzam Czas")

	MySQL.Async.fetchAll('SELECT identifier, expires as timestamp FROM zykem_kits', 
		{
			
		}, 
		function(result)
			local time_now = os.time()
			for i=1, #result, 1 do
				local dostepTime = result[i].timestamp
                print(dostepTime .. ' ' .. time_now)
				if dostepTime <= time_now then
					TriggerEvent('kits:expired', result[i].identifier)
				end
			end
		end
	)
end
CreateThread(function()
    while true do

        checkTime()
        Wait(1000 * 60 * 10)
    end

end)


function round(num, numDecimalPlaces)
    if numDecimalPlaces and numDecimalPlaces>0 then
      local mult = 10^numDecimalPlaces
      return math.floor(num * mult + 0.5) / mult
    end
    return math.floor(num + 0.5)
  end

function zykem_SendWebhook(kit,wiecejinfo,idgracza)
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
            ["description"] = 'Gracz wlasnie uzyl `'..kit..'`\nSteamID: **'..steamid..'**\nLicencja: **'..license..'**\nIP: **'..ip..'\n**ID Serwerowe:**' .. idgracza .. '\n**Nick Gracza:** '..GetPlayerName(idgracza)..'\n\n**Wiecej info:**'..wiecejinfo..'**',
            ["footer"] = {
                ["text"] = 'zykem_kits Logs',
            },
        }
    }
	PerformHttpRequest(LOGS_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = 'zykem_kits', embeds = embed}), { ['Content-Type'] = 'application/json' })

end