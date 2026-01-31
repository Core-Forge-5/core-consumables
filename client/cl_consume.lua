--#region Helpers
local function DebugPrint(...)
    if Config and Config.Debug then
        print('[core-consumables][DEBUG]', ...)
    end
end
-- Layout Buffs and what they do
local function ApplyTimedBuff(buffName, buffData)
    CreateThread(function()
        local ped = PlayerPedId()
        local value = buffData.value or 1.0
        local duration = buffData.duration or 10
        if Config.Debug == true then
            DebugPrint('Applying buff:', buffName, 'value:', value, 'duration:', duration)
        end
        if buffName == 'speed' then
            SetRunSprintMultiplierForPlayer(PlayerId(), value)
            Wait(duration * 1000)
            SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
            if Config.Debug == true then
                DebugPrint('Speed buff expired')
            end
        elseif buffName == 'strength' then
            SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
            SetWeaponDamageModifier(`WEAPON_UNARMED`, value)
            Wait(duration * 1000)
            SetWeaponDamageModifier(`WEAPON_UNARMED`, 1.0)
            if Config.Debug == true then
                DebugPrint('Strength buff expired')
            end
        else
            if Config.Debug == true then
                DebugPrint('Unknown Buff')
            end
        end
    end)
end
-- Clean up Function
local function CleanupEffects()
    StopScreenEffect("DrugsTrevorClownsFight")
    StopScreenEffect("DrugsTrevorClownsFightIn")
    StopScreenEffect("DrugsTrevorClownsFightOut")
    StopScreenEffect("DrugsMichaelAliensFight")
    StopScreenEffect("DrugsMichaelAliensFightIn")
    StopScreenEffect("DrugsMichaelAliensFightOut")
    StopScreenEffect("PeyoteIn")
    StopScreenEffect("PeyoteOut")
    StopScreenEffect("PeyoteEndIn")
    StopScreenEffect("PeyoteEndOut")
    StopScreenEffect("DMT_flight")
    StopScreenEffect("DMT_flight_intro")
    StopAllScreenEffects()
    ClearTimecycleModifier()
    ClearExtraTimecycleModifier()
    ShakeGameplayCam("DRUNK_SHAKE", 0.0)
    ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.0)
    ShakeGameplayCam("JOLT_SHAKE", 0.0)
    ShakeGameplayCam("HAND_SHAKE", 0.0)
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
    Wait(500)
    StopAllScreenEffects()
    ClearTimecycleModifier()
    ClearExtraTimecycleModifier()
end
--#endregion
--#region Visual effects
local function EcstasyEffect()
    if Config.Debug == true then
        DebugPrint('Setting evidence status: widepupils')
    end
    TriggerEvent('evidence:client:SetStatus', 'widepupils', 200)
    local ped = PlayerPedId()
    StartScreenEffect("HeistCelebPass", 3.0, 0)
    SetTimecycleModifier("drug_flying_base")
    RestorePlayerStamina(PlayerId(), 1.0)
    local duration = 60                     -- Cycles
    local timer = 0                         -- Start at 0
    while timer < duration do
        Wait(800)                           -- Time of each cycle in ms
        timer = timer + 1
        RestorePlayerStamina(PlayerId(), 0.5)
        if math.random(1, 100) < 50 then
            SetFlash(0, 0, 600, 4000, 400)
        end
        if math.random(1, 100) < 15 then
            StartScreenEffect("SuccessNeutral", 2.0, 0)
        end
    end
    CleanupEffects()
    if IsPedRunning(ped) then
        SetPedToRagdoll(ped, math.random(1500, 2500), math.random(1500, 2500), 3, 0, 0, 0)
    end
end
-- Classic stoned filter
local function StonedMonkey()
    if Config.Debug == true then
        DebugPrint('Setting evidence status: weedsmell')
    end
    TriggerEvent('evidence:client:SetStatus', 'weedsmell', 200)
    local ped = PlayerPedId()
    SetTimecycleModifier("stoned_monkeys")
    local duration = 45
    local timer = 0
    while timer < duration do
        Wait(700)
        timer = timer + 1
    end
    CleanupEffects()
end
-- Classic drunk filter
local function AlcoholEffect()
    if Config.Debug == true then
        DebugPrint('Setting evidence status: heavyalcohol')
    end
    TriggerEvent('evidence:client:SetStatus', 'heavyalcohol', 200)
    StartScreenEffect("DrugsDrivingIn", 3.0, 0)
    SetTimecycleModifier("Drunk")
    SetRunSprintMultiplierForPlayer(PlayerId(), 0.45)
    local duration = 55
    local timer = 0
    while timer < duration do
        Wait(1100)
        timer = timer + 1
        ShakeGameplayCam("ROAD_VIBRATION_SHAKE", 0.5)
        if math.random(1, 100) < 30 then
            ShakeGameplayCam("DRUNK_SHAKE", 0.8)
        end
    end
    CleanupEffects()
end
-- This one is a saturation increase filter
local function CokeEffect()
    if Config.Debug == true then
        DebugPrint('Setting evidence status: widepupils')
    end
    TriggerEvent('evidence:client:SetStatus', 'widepupils', 200)
    local ped = PlayerPedId()
    SetTimecycleModifier("drug_flying_base")
    local duration = 25
    local timer = 0
    while timer < duration do
        Wait(600)
        timer = timer + 1
        RestorePlayerStamina(PlayerId(), 0.8)
        if math.random(1, 100) < 25 and IsPedRunning(ped) then
            SetPedToRagdoll(ped, math.random(500, 1500), math.random(500, 1500), 2, 0, 0, 0)
        end
    end
    CleanupEffects()
    if IsPedRunning(ped) then
        SetPedToRagdoll(ped, math.random(2000, 3500), math.random(2000, 3500), 3, 0, 0, 0)
    end
end
-- This one is a warm hazy filter with short duration to balance its potential use as a armor source
local function HeroinEffect()
    if Config.Debug == true then
        DebugPrint('Setting evidence status: heavybreath')
        DebugPrint('Setting evidence status: confused')
    end
    TriggerEvent('evidence:client:SetStatus', 'heavybreath', 200)
    TriggerEvent('evidence:client:SetStatus', 'confused', 200)
    local ped = PlayerPedId()
    local player = PlayerId()
    -- Stumble (Not quite a fall over)
    SetPedToRagdoll(ped, 230, 300, 0, false, false, false)
    Wait(600)  -- Let ped be standup before effects

    -- Warm Hazy
    SetTimecycleModifier("drug_deadman")  -- heavy, warmth
    SetTimecycleModifierStrength(0.50)    -- start soft

    -- Layer for extra warmth
    SetExtraTimecycleModifier("NG_filmic02")
    SetExtraTimecycleModifierStrength(0.50)

    local duration = 18
    local timer = 0

    while timer < duration do
        Wait(1000)
        timer = timer + 1
        -- Pulse the ExtraTimecycleModifyierStrength
        local pulse = 0.70 + math.sin(timer * 0.12) * 0.15   -- subtle wave
        SetTimecycleModifierStrength(pulse)
        SetExtraTimecycleModifierStrength(pulse)
    end

    CleanupEffects()
end
-- This one is a purple drunk like filter
local function LeanEffect()
    if Config.Debug == true then
        DebugPrint('Setting evidence status: heavybreath')
        DebugPrint('Setting evidence status: confused')
    end
    TriggerEvent('evidence:client:SetStatus', 'heavybreath', 200)
    TriggerEvent('evidence:client:SetStatus', 'confused', 200)
    SetTimecycleModifier("Drunk")
    SetRunSprintMultiplierForPlayer(PlayerId(), 0.6)
    local duration = 70
    local timer = 0
    while timer < duration do
        Wait(1200)
        timer = timer + 1
        if math.random(1, 100) < 20 then
            SetFlash(128, 0, 128, 3000, 128)  -- purple haze
        end
    end
    CleanupEffects()
end
-- This one is like a green staticky filter
local function MushroomEffect()
    if Config.Debug == true then
        DebugPrint('Setting evidence status: widepupils')
    end
    TriggerEvent('evidence:client:SetStatus', 'widepupils', 200)
    SetTimecycleModifier("stoned")
    local duration = 100
    local timer = 0
    while timer < duration do
        Wait(850)
        timer = timer + 1
        local waveIntensity = 0.1 + math.sin(timer * 0.2) * 0.05
        ShakeGameplayCam("HAND_SHAKE", waveIntensity)
    end
    CleanupEffects()
end
-- Peyote
local function PeyoteEffect()
    if Config.Debug == true then
        DebugPrint('Setting evidence status: widepupils')
    end
    TriggerEvent('evidence:client:SetStatus', 'widepupils', 200)
    StartScreenEffect("PeyoteIn", 1.5, false)
    Wait(1400)  -- Let transition play out a bit
    SetTimecycleModifier("drug_flying_base")
    local duration = 80
    local timer = 0
    while timer < duration do
        Wait(1000)
        timer = timer + 1
        if math.random(1, 100) < 45 then
            ShakeGameplayCam("HAND_SHAKE", 0.1)
        end
    end
    StartScreenEffect("PeyoteOut", 4.0, false)
    Wait(4000)
    CleanupEffects()
end

local function XanEffect()
    if Config.Debug == true then
        DebugPrint('Setting evidence status: alcohol')
        DebugPrint('Setting evidence status: confused')
    end
    TriggerEvent('evidence:client:SetStatus', 'alcohol', 200)
    TriggerEvent('evidence:client:SetStatus', 'confused', 200)
    SetTimecycleModifier("BlackOut")
    local duration = 35
    local timer = 0
    while timer < duration do
        Wait(900)
        timer = timer + 1
    end
    CleanupEffects()
    local ped = PlayerPedId()
    SetPedToRagdoll(ped, math.random(4000, 6000), math.random(4000, 6000), 2, 0, 0, 0)  -- blackout passout
end

--#endregion

--region Logic
local function ApplyEffect(effect)
    CreateThread(function()
        if Config.Debug == true then
            DebugPrint('Applying visual effect:', effect)
        end
        CleanupEffects()

        if effect == 'ecstacy' then
            EcstasyEffect()
        elseif effect == 'stoned' then
            StonedMonkey()
        elseif effect == 'coke' then
            CokeEffect()
        elseif effect == 'heroin' then
            HeroinEffect()
        elseif effect == 'lean' then
            LeanEffect()
        elseif effect == 'alcohol' then
            AlcoholEffect()
        elseif effect == 'mushroom' then
            MushroomEffect()
        elseif effect == 'peyote' then
            PeyoteEffect()
        elseif effect == 'xan' then
            XanEffect()
        else
            if Config.Debug == true then
                DebugPrint('Unknown effect:', effect)
            end
        end
    end)
end

local function DoProgress(time, label, anim, prop)
    if Config.Debug == true then
        DebugPrint('Progress start:', label, 'time:', time)
    end

    local ped = PlayerPedId()

    local success = lib.progressBar({
        duration = time,
        label = label,
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            combat = true,
            car = true
        },
        anim = anim and {
            dict = anim.dict,
            clip = anim.clip,
            flag = anim.flag or 49
        } or nil,
        prop = prop,
    })
    if Config.Debug == true then
        DebugPrint('Progress result:', success)
    end
    return success
end

-- ox_inventory export
exports('consumeItem', function(item, slot)
    if Config.Debug == true then
        DebugPrint('consumeItem called:', item.name, 'slot:', slot)
    end
    local cfg = Consume[item.name]
    if not cfg then
        if Config.Debug == true then
            DebugPrint('No consume config found for:', item.name)
        end
        return false
    end

    local ped = PlayerPedId()

    -- progress
    if not DoProgress(
        cfg.time or 3000,
        cfg.text or ('Using ' .. item.label .. '...'),
        cfg.anim,
        cfg.prop
    ) then
        if Config.Debug == true then
            DebugPrint('Consumption cancelled:', item.name)
        end
        return false
    end

    -- stats
    for stat, val in pairs(cfg.add or {}) do
        if Config.Debug == true then
            DebugPrint('Applying stat:', stat, 'value:', val)
        end
        if stat == 'health' then
            SetEntityHealth(ped, math.min(200, GetEntityHealth(ped) + val))

        elseif stat == 'armor' then
            local Armor = GetPedArmour(ped)
            SetPedArmour(ped, Armor + val)

        elseif stat == 'hunger' or stat == 'thirst' or stat == 'stress' then
            TriggerServerEvent('core-consumables:server:updateStatus', stat, val)

        elseif stat == 'buffs' then
            for buffName, buffData in pairs(val) do
                DebugPrint('Applying buff from item:', buffName)
                ApplyTimedBuff(buffName, buffData)
            end
        end
    end

    -- FX
    if cfg.effect then
        if Config.Debug == true then
            DebugPrint('Triggering effect from item:', cfg.effect)
        end
        ApplyEffect(cfg.effect)
    end

    if Config.Debug == true then
        DebugPrint('Sending consume event to server:', item.name)
    end
    TriggerServerEvent('core-consumables:server:consume', item.name)
    if Config.Debug == true then
        DebugPrint('Item consumed successfully:', item.name)
    end
    return true
end)
--#endregion