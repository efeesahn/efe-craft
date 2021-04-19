ESX = nil
local uretimyapabilir = false
local uretiyor = false
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end

    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function()
    PlayerData.job = job
end)

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
	SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

RegisterCommand('üret', function()
	ESX.PlayerData = ESX.GetPlayerData()
	if uretimyapabilir == true then
		if (ESX.PlayerData.job.name == 'ballas') or (ESX.PlayerData.job.name == 'grove') or (ESX.PlayerData.job.name == 'lost') or (ESX.PlayerData.job.name == 'vagos') or (ESX.PlayerData.job.name == 'astecas') then
			kontrolb1()
		else
			TriggerEvent('notification', 'Üretimi yapmanıza beceriniz yok bir çete üyesi olmalısınız. Detaylı bilgi için /üretbilgi', 3)
		end
	else
		TriggerEvent('notification', 'Üretim bölgesinde değilsiniz.', 4)
	end
end)

function kontrolb1()
	ESX.TriggerServerCallback('efe-uret:kontrol', function(quantity)
		if quantity >= 1 then
			kontrolb2()
		else
			TriggerEvent('notification', 'Üretim için : 1x, Silah Gövdesi, 1x Silah Yayı , 3x Aliminyum, 1x Metal Hurda gerekli.', 1)
		end
	end, 'sgovde')
end

function kontrolb2()
	ESX.TriggerServerCallback('efe-uret:kontrol', function(quantity2)
		if quantity2 >= 1 then
			kontrolb3()
		else
			TriggerEvent('notification', 'Üretim için : 3x Aliminyum, 1x Metal Hurda gerekli.', 1)
		end
	end, 'silahyayi')
end

function kontrolb3()
	ESX.TriggerServerCallback('efe-uret:kontrol', function(quantity3)
		if quantity3 >= 3 then
			kontrolb4()
		else
			TriggerEvent('notification', 'Üretim için : 3x Aliminyum gerekli.', 1)
		end
	end, 'aluminum')
end

function kontrolb4()
	ESX.TriggerServerCallback('efe-uret:kontrol', function(quantity4)
		if quantity4 >= 1 then
			uretim()
		else
			TriggerEvent('notification', 'Üretim yapıldı.', 1)
		end
	end, 'smetal')
end

function uretim()
	ESX.PlayerData = ESX.GetPlayerData()
	if (ESX.PlayerData.job.name == 'ballas') or (ESX.PlayerData.job.name == 'grove') or (ESX.PlayerData.job.name == 'lost') or (ESX.PlayerData.job.name == 'vagos') or (ESX.PlayerData.job.name == 'astecas') then
		Uretbar()
	end
end

function Uretbar()
	if uretiyor == false then
		local finished = exports["reload-skillbar"]:taskBar(2000,math.random(5,15))
		if finished ~= 100 then
			TriggerEvent('notification', 'Başaramadın.', 4)
		else
			uretiyor = true
			TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
			exports["np-taskbar"]:taskBar(20000, "Üretim yapıyorsun..")
			ClearPedTasks(PlayerPedId())
			ESX.PlayerData = ESX.GetPlayerData()
			if (ESX.PlayerData.job.name == 'ballas') then 
				TriggerServerEvent("efe-uret:ballas")
				uretiyor = false
			elseif (ESX.PlayerData.job.name == 'grove') then
				TriggerServerEvent("efe-uret:grove")
				uretiyor = false
			elseif (ESX.PlayerData.job.name == 'vagos') then
				TriggerServerEvent("efe-uret:vagos")
				uretiyor = false
			elseif (ESX.PlayerData.job.name == 'astecas') then
				TriggerServerEvent("efe-uret:astecas")
				uretiyor = false
			elseif (ESX.PlayerData.job.name == 'lost') then
				TriggerServerEvent("efe-uret:lost")
				uretiyor = false
			end
		end
	else
		TriggerEvent('notification', 'Zaten üretiyorsun.', 4)
	end
end

bolgeler = {
	vector3(93.09020, -1979.29, 20.467), --ballas
	vector3(342.1586, -2036.10, 21.773), --vagos
	vector3(-133.529,-1597.65,34.243), --grove
	vector3(984.6713, -126.064, 73.970), --the lost
	vector3(951.9178, -1515.86, 31.198)    -- aztecas
}

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(10)
        for k,v in pairs(bolgeler) do
            local coords = GetEntityCoords(PlayerPedId())
            if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 5)  then
            --DrawMarker(2, v.x, v.y, v.z-0.10, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.15, 255, 255, 255, 200, 0, 0, 0, 1, 0, 0, 0)
            if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.1)  then
				uretimyapabilir = true
				DrawText3D(v.x, v.y, v.z+0.15, '/üret yazarak üretime baslayabilirsiniz.')
			else
				uretimyapabilir = false
            end
			end
        end
    end
end)