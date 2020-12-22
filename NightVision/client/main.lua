ESX              = nil
local PlayerData = {}
local canNightVision = false
local isMale = false
local isFemale = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:playerJob')
AddEventHandler('esx:playerJob', function(job)
    PlayerData.job = job
end)

--Getting active the night vision effect while changing through helmets
Citizen.CreateThread(function()
    while true do       
        if IsControlJustReleased(0, 112) then
            local gender = nil
            local fegender = nil
            isNightvision = not isNightvision
            TriggerEvent('skinchanger:getSkin', function(skin)
                local helmet = skin.helmet_1

                if skin.sex == 0 then
                    isMale = true
                else
                    isMale = false
                end

                if skin.sex == 1 then 
                    isFemale = true
                else
                    isFemale = false
                end

                if helmet == 116 or helmet == 117 then
                    canNightVision = true
                else 
                    canNightVision = false
                end
            end)

            if isMale then
                gender = 0
            else
                gender = 1
            end

            if isFemale then
                fegender = 0
            else
                fegender = 1
            end

            if canNightVision and isNightvision then
                TriggerEvent('skinchanger:loadSkin', {
                    sex = gender,
                    sex = fegender,
                    helmet_1 = 116
                })
                SetNightvision(true)
            elseif canNightVision and isNightvision == false then
                TriggerEvent('skinchanger:loadSkin', {
                    sex = gender,
                    sex = fegender,
                    helmet_1 = 117
                })
                SetNightvision(false)
            end
        end
        Citizen.Wait(5)
    end
end)