-- Merty | megva

local PlayerData                = {}
ESX                             = nil
 
Citizen.CreateThread(function()
  while ESX == nil do
   TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
   Citizen.Wait(0)
  end
 
  while ESX.GetPlayerData().job == nil do
   Citizen.Wait(10)
  end
 
 PlayerData = ESX.GetPlayerData()
end)
 
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)



function openMenu()
    FreezeEntityPosition(PlayerPedId(), true)
    local elements = {}
  elements[1] = {label = 'Malları takas etmeye ne dersin?',val="takaset"}
  elements[2] = {label = 'İstiyorsan satadabilirsin - 5 Tanesi,  <span style="color:green;"><b>'.. Config.Para ..'$</span>',val="sat"}
  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'asd', {
    title    = "Uyuşturucu - Frank", 
    align    = 'top-right',
    elements = elements
  }, function(data, menu)
      if data.current.val == "takaset" then
        local elements = {}
            if exports['np-inventory']:hasEnoughOfItem('joint', 5) then
                ESX.UI.Menu.CloseAll()
                loadAnimDict( "mp_safehouselost@" )
                TaskPlayAnim( PlayerPedId(), "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
                TriggerEvent('inventory:removeItem', 'joint', 5)
                Citizen.Wait(3500)
                local napim = math.random(0, 100)
                if napim > 50 then
                    TriggerEvent('player:receiveItem', 'tuner', math.random(2,5))
                else    
                 TriggerEvent('player:receiveItem', 'oxy', math.random(3,7))
                end     
                Citizen.Wait(2000)
                FreezeEntityPosition(PlayerPedId(), false)
            else
                TriggerEvent('notification', 'Hadi ama dostum burada yeteri kadar mal yok', 2)
        end
    elseif data.current.val == "sat" then
        local elements = {}
        if exports['np-inventory']:hasEnoughOfItem('joint', 5) then
            ESX.UI.Menu.CloseAll()
            loadAnimDict( "mp_safehouselost@" )
            TaskPlayAnim( PlayerPedId(), "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
            TriggerEvent('inventory:removeItem', 'joint', 10)
            Citizen.Wait(3500)
            TriggerServerEvent('merty:addmoney')
            Citizen.Wait(2000)
            FreezeEntityPosition(PlayerPedId(), false)
        else
            TriggerEvent('notification', 'Hadi ama dostum burada yeteri kadar mal yok', 2)
        end
end
  end, function(data8, menu8)
    ESX.UI.Menu.CloseAll()
    FreezeEntityPosition(PlayerPedId(), false)
  end)
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.3, 0.3)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 245)

    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 410
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 133)
end


function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(5)
    end
end
Citizen.CreateThread(function()
    local hash = GetHashKey('a_m_m_soucent_04')
    while not HasModelLoaded(hash) do
    	RequestModel(hash)
    	Wait(20)
    end 
    
    local ped = CreatePed(21, hash, 510.7628, -1951.43, 24.985 -1, 0.0, true, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_SMOKING_POT', 0, true)
end)

Citizen.CreateThread(function()
	while ESX == nil do
		Citizen.Wait(10)
	end
	while true do
        local sleep = 1000
		if Vdist2(GetEntityCoords(PlayerPedId()), 511.0352, -1951.28, 24.985) <= 2 then
			sleep = 1
            DrawText3Ds(511.0352, -1951.28, 24.985, "[E]- Frank ile konus")
            if IsControlJustPressed(0, 38) then
                sleep = 7500
                openMenu()
                end			                                           							                        
                  end
		Citizen.Wait(sleep)
	end
end)
