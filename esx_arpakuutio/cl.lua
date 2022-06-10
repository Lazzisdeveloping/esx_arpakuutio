ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterCommand('arpakuutio', function()
    ESX.TriggerServerCallback('esx_arpakuutio:onkoluuria', function(luuri)
        if luuri then
            panos()
            ExecuteCommand('e record')
        end
    end)
end)

function panos()
    ESX.UI.Menu.Open(
        'dialog', GetCurrentResourceName(), 'esx_arpakuutio',
        {
          title = "Kuinka paljolla haluasit pelata?"
        },
        function(data2, menu)
			local bet = tonumber(data2.value)

			if bet == nil or bet > 99999 then
				exports['mythic_notify']:DoHudText('error', 'Virheellinen summa!')
			else
                TriggerServerEvent('esx_arpakuutio:checkki', bet)
                menu.close()
            end
        end,
        function(data, menu)
        menu.close()
      end
    )
end

RegisterNetEvent('esx_arpakuutio:noppiensumma', function(bet)
    ESX.UI.Menu.Open(
        'dialog', GetCurrentResourceName(), 'esx_arpakuutio',
        {
          title = "Veikkauksesi noppien silmälukujen summasta? (2-12)"
        },
        function(data2, menu)
			local number = tonumber(data2.value)

			if number == nil or number < 2 or number > 12 then
				exports['mythic_notify']:DoHudText('error', 'Virheellinen summa!')
			else
                TriggerServerEvent('esx_arpakuutio:pelikayntii', number, bet)
                menu.close()
            end
        end,
        function(data, menu)
        menu.close()
      end
    )
end)
