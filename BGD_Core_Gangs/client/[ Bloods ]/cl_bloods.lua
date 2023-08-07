ESX = nil

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(10)
    end

    while ESX.GetPlayerData().job == nil do
        Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
    ESX.PlayerData.job2 = job2
end)

CreateThread(function()
if bloods.jeveuxblips then
    local bloodsmap = AddBlipForCoord(bloods.pos.blips.position.x, bloods.pos.blips.position.y, bloods.pos.blips.position.z)

    SetBlipSprite(bloodsmap, 84)
    SetBlipColour(bloodsmap, 1)
    SetBlipScale(bloodsmap, 0.80)
    SetBlipAsShortRange(bloodsmap, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Quartier Bloods")
    EndTextCommandSetBlipName(bloodsmap)
end
end)

-- Garage

function GarageBloods()
  local GBloods = RageUI.CreateMenu("Garage", "Bloods")
    RageUI.Visible(GBloods, not RageUI.Visible(GBloods))
        while GBloods do
            Wait(0)
                RageUI.IsVisible(GBloods, true, true, true, function()
                    RageUI.ButtonWithStyle("Ranger la voiture", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then   
                        local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                        if dist4 < 4 then
                            DeleteEntity(veh)
                            RageUI.CloseAll()
                            end 
                        end
                    end) 

                    for k,v in pairs(GBloodsvoiture) do
                    RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then
                        Wait(1)  
                            spawnuniCarBloods(v.modele)
                            RageUI.CloseAll()
                            end
                        end)
                    end
                end, function()
                end)
            if not RageUI.Visible(GBloods) then
            GBloods = RMenu:DeleteType("GBloods", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'bloods' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'bloods' then 
            local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, bloods.pos.garage.position.x, bloods.pos.garage.position.y, bloods.pos.garage.position.z)
            if dist3 <= 10.0 and bloods.jeveuxmarker then
                Timer = 0
                DrawMarker(20, bloods.pos.garage.position.x, bloods.pos.garage.position.y, bloods.pos.garage.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 193, 18, 31, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if dist3 <= 3.0 then
                Timer = 0   
					RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au garage", time_display = 1 })
                    if IsControlJustPressed(1,51) then           
                        GarageBloods()
                    end   
                end
            end 
        Wait(Timer)
     end
end)

function spawnuniCarBloods(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, bloods.pos.spawnvoiture.position.x, bloods.pos.spawnvoiture.position.y, bloods.pos.spawnvoiture.position.z, bloods.pos.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "bloods"..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
    SetVehicleCustomPrimaryColour(vehicle, 193, 18, 31)
    SetVehicleCustomSecondaryColour(vehicle, 193, 18, 31)
    SetVehicleMaxMods(vehicle)
end

function SetVehicleMaxMods(vehicle)

    local props = {
      modEngine       = 2,
      modBrakes       = 2,
      modTransmission = 2,
      modSuspension   = 3,
      modTurbo        = true,
    }
  
    ESX.Game.SetVehicleProperties(vehicle, props)
  
  end


-- Coffre

function Coffrebloods()
	local Cbloods = RageUI.CreateMenu("Coffre", "Bloods")
        RageUI.Visible(Cbloods, not RageUI.Visible(Cbloods))
            while Cbloods do
            Wait(0)
            RageUI.IsVisible(Cbloods, true, true, true, function()

                RageUI.Separator("↓ Objet / Arme ↓")

                    RageUI.ButtonWithStyle("Retirer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            BloodsRetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Déposer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            BloodsDeposerobjet()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.Separator("↓ Vêtements ↓")

                    RageUI.ButtonWithStyle("Gang",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vuniformebloods()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.ButtonWithStyle("Remettre sa tenue",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vcivil_bloods()
                            RageUI.CloseAll()
                        end
                    end)
                end, function()
                end)
            if not RageUI.Visible(Cbloods) then
            Cbloods = RMenu:DeleteType("Cbloods", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'bloods' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'bloods' then  
            local plycrdjob = GetEntityCoords(PlayerPedId(), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, bloods.pos.coffre.position.x, bloods.pos.coffre.position.y, bloods.pos.coffre.position.z)
            if jobdist <= 10.0 and bloods.jeveuxmarker then
                Timer = 0
                DrawMarker(20, bloods.pos.coffre.position.x, bloods.pos.coffre.position.y, bloods.pos.coffre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 193, 18, 31, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au coffre", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        Coffrebloods()
                    end   
                end
            end 
        Wait(Timer)   
    end
end)

itemstock = {}
function BloodsRetirerobjet()
	local StockBloods = RageUI.CreateMenu("Coffre", "Bloods")
	ESX.TriggerServerCallback('bloods:getStockItems', function(items) 
	itemstock = items
	RageUI.Visible(StockBloods, not RageUI.Visible(StockBloods))
        while StockBloods do
		    Wait(0)
		        RageUI.IsVisible(StockBloods, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count ~= 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", '' , 8)
                                    TriggerServerEvent('bloods:getStockItem', v.name, tonumber(count))
                                    BloodsRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(StockBloods) then
            StockBloods = RMenu:DeleteType("Coffre", true)
        end
    end
end)
end

local PlayersItem = {}
function BloodsDeposerobjet()
    local DepositBloods = RageUI.CreateMenu("Coffre", "Bloods")
    ESX.TriggerServerCallback('bloods:getPlayerInventory', function(inventory)
        RageUI.Visible(DepositBloods, not RageUI.Visible(DepositBloods))
    while DepositBloods do
        Wait(0)
            RageUI.IsVisible(DepositBloods, true, true, true, function()
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                         local item = inventory.items[i]
                            if item.count > 0 then
                                        RageUI.ButtonWithStyle(item.label, nil, {RightLabel = item.count}, true, function(Hovered, Active, Selected)
                                            if Selected then
                                            local count = KeyboardInput("Combien ?", '' , 8)
                                            TriggerServerEvent('bloods:putStockItems', item.name, tonumber(count))
                                            BloodsDeposerobjet()
                                        end
                                    end)
                                end
                            else
                                RageUI.Separator('Chargement en cours')
                            end
                        end
                    end, function()
                    end)
                if not RageUI.Visible(DepositBloods) then
                DepositBloods = RMenu:DeleteType("Coffre", true)
            end
        end
    end)
end

Keys.Register('F7', 'bloods', 'Ouvrir le menu Bloods', function()
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'bloods' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'bloods' then    
            TriggerEvent('burgydev:MenuFouille')
end
end)

function vuniformebloods()
    TriggerEvent('skinchanger:getSkin', function(skin)
        local uniformObject
        if skin.sex == 0 then
            uniformObject = bloods.tenue.male
        else
            uniformObject = bloods.tenue.female
        end
        if uniformObject then
            TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
        end
    end)end

function vcivil_bloods()
ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
TriggerEvent('skinchanger:loadSkin', skin)
end)
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Wait(0)
    end 
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end