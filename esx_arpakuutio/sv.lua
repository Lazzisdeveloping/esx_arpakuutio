ESX = nil
TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

ESX.RegisterServerCallback('esx_arpakuutio:onkoluuria', function(source, cb)
    local pelaaja = ESX.GetPlayerFromId(source)
  
    if pelaaja.getInventoryItem('phone').count >= 1 then
        cb(true)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Sinulla ei ole puhelinta!'})
        cb(false)
    end
  
end)

RegisterServerEvent('esx_arpakuutio:checkki',function(bet)
	local pelaaja = ESX.GetPlayerFromId(source)
	local peliraha = pelaaja.getMoney()
    if peliraha > 0 then
		if peliraha >= bet then
            TriggerClientEvent('esx_arpakuutio:noppiensumma', source, bet)
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Virheellinen summa' })
		end
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Virheellinen summa' })
	end
end)

RegisterServerEvent('esx_arpakuutio:pelikayntii', function(number, bet)
    local pelaaja = ESX.GetPlayerFromId(source)
    local arpakuutio1 = math.random(1,6)
    local arpakuutio2 = math.random(1,6)
    pelaaja.removeMoney(bet)
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Betti: ' .. bet .. ' Veikkaus: ' ..number })
    TriggerClientEvent('3dme:triggerDisplay', -1, 'Arpakuutio: \n' ..arpakuutio1..'   +   '..arpakuutio2, _source)
    if arpakuutio1 + arpakuutio2 == number then
        pelaaja.addMoney(bet*10)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Voitit: ' ..bet*10  })
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Hävisit: ' ..bet  })
    end
end)
