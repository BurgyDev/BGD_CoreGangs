ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}
local societybloodsmoney = nil
local societyblackbloodsmoney = nil

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Wait(5000) 
end)

CreateThread(function()
    ESX.TriggerServerCallback('bloods:getBlackMoneySociety', function(inventory)
        argent = inventory
    end)
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
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

---------------- FONCTIONS ------------------

function BossBloods()
  local BBloods = RageUI.CreateMenu("Actions Patron", "Bloods")

    RageUI.Visible(BBloods, not RageUI.Visible(BBloods))

            while BBloods do
                Wait(0)
                    RageUI.IsVisible(BBloods, true, true, true, function()

                    if societybloodsmoney ~= nil then
                        RageUI.ButtonWithStyle("Argent société :", nil, {RightLabel = "$" .. societybloodsmoney}, true, function()
                        end)
                    end

                    RageUI.ButtonWithStyle("Retirer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local amount = KeyboardInput("Montant", "", 10)
                            amount = tonumber(amount)
                            if amount == nil then
                                RageUI.Popup({message = "Montant invalide"})
                            else
                                TriggerServerEvent('esx_society:withdrawMoney', 'bloods', amount)
                                RefreshbloodsMoney()
                            end
                        end
                    end)

                    RageUI.ButtonWithStyle("Déposer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local amount = KeyboardInput("Montant", "", 10)
                            amount = tonumber(amount)
                            if amount == nil then
                                RageUI.Popup({message = "Montant invalide"})
                            else
                                TriggerServerEvent('esx_society:depositMoney', 'bloods', amount)
                                RefreshbloodsMoney()
                            end
                        end
                    end) 

                    RageUI.ButtonWithStyle("Accéder aux actions de Management",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            bloodsboss()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.Separator("↓ Argent Sale ↓")
            

                    if societyblackbloodsmoney ~= nil then
                        RageUI.ButtonWithStyle("Argent sale : ", nil, {RightLabel = "$" .. societyblackbloodsmoney}, true, function()
                        end)
                    end

                    RageUI.ButtonWithStyle("Déposer argent sale",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                                local count = KeyboardInput("Combien ?", "", 100)
                                TriggerServerEvent('bloods:putblackmoney', 'item_account', 'black_money', tonumber(count))
                                Deposerargentsale()
                                ESX.TriggerServerCallback('bloods:getBlackMoneySociety', function(inventory) 
                            end)
                            RefreshblackbloodsMoney()
                        end
                    end)

                    RageUI.ButtonWithStyle("Retirer argent sale",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local count = KeyboardInput("Combien ?", "", 100)
                            ESX.TriggerServerCallback('bloods:getBlackMoneySociety', function(inventory) 
                            TriggerServerEvent('bloods:getItem', 'item_account', 'black_money', tonumber(count))
                            Retirerargentsale()
                            RefreshblackbloodsMoney()
                            end)
                        end
                    end)
                end, function()
            end)
            if not RageUI.Visible(BBloods) then
            BBloods = RMenu:DeleteType("BBloods", true)
        end
    end
end   

---------------------------------------------

CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'bloods' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'bloods' and ESX.PlayerData.job2.grade_name == 'boss' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, bloods.pos.boss.position.x, bloods.pos.boss.position.y, bloods.pos.boss.position.z)
        if dist3 <= 10.0 and bloods.jeveuxmarker then
            Timer = 0
            DrawMarker(20, bloods.pos.boss.position.x, bloods.pos.boss.position.y, bloods.pos.boss.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 193, 18, 31, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 3.0 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder aux actions patron", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            RefreshbloodsMoney()
                            RefreshblackbloodsMoney()
                            BossBloods()
                    end   
                end
            end 
        Wait(Timer)
    end
end)

function RefreshbloodsMoney()
    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            UpdateSocietybloodsMoney(money)
        end, ESX.PlayerData.job2.name)
    end
end

function RefreshblackbloodsMoney()
    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
        ESX.TriggerServerCallback('bloods:getBlackMoneySociety', function(inventory)
            UpdateSocietyblackbloodsMoney(inventory)
        end, ESX.PlayerData.job2.name)
    end
end

function UpdateSocietyblackbloodsMoney(inventory)
    societyblackbloodsmoney = ESX.Math.GroupDigits(inventory.blackMoney)
end

function UpdateSocietybloodsMoney(money)
    societybloodsmoney = ESX.Math.GroupDigits(money)
end

function bloodsboss()
    TriggerEvent('esx_society:openBossMenu', 'bloods', function(data, menu)
        menu.close()
    end, {wash = false})
end

function Deposerargentsale()
    ESX.TriggerServerCallback('bloods:getPlayerInventoryBlack', function(inventory)
        while DepositBlackbloods do
            Wait(0)
        end
    end)
end

function Retirerargentsale()
	ESX.TriggerServerCallback('bloods:getBlackMoneySociety', function(inventory)
	    while StockBlackbloods do
		    Wait(0)
	    end
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