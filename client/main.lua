local fire = {}

local function Anim()
    local pid = PlayerPedId()
    RequestAnimDict("amb@prop_human_bum_bin@idle_b")
    while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do Citizen.Wait(0) end
        TaskPlayAnim(pid,"amb@prop_human_bum_bin@idle_b","idle_d",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
        TaskStartScenarioInPlace(pid, "WORLD_HUMAN_STAND_FIRE", 0, true)
        Wait(Config.AnimTime * 1000)
        ClearPedTasks(pid)
        StopAnimTask(pid, "amb@prop_human_bum_bin@idle_b","idle_d", 1.0)
end

RegisterNetEvent('experience_studio:startLight')
AddEventHandler('experience_studio:startLight', function()
    local ped = GetPlayerPed(-1)
    local offset = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.5, 0.0)
    Anim()
    local fireId = StartScriptFire(offset.x, offset.y, offset.z -1, 1, true)
    table.insert(fire, {id = fireId, time = Config.FireTimeRemaning*1000})
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        if #fire > 0 then
            for k, _ in pairs(fire) do
                fire[k].time = fire[k].time - 100
                if fire[k].time == 0 then
                    RemoveScriptFire(fire[k].id)
                    table.remove(fire, k)
                end
            end
        end
    end
end)