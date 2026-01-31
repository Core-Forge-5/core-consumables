## Core-Consumables
Add drugs, food, drinks with effects in minutes.

# Config
```lua
    drug_moonshine = {
        time = 3000,                                                 -- Use Time
        effect = 'moonshine',                                        -- Effect name
        progressbartext = "Drinking ",                               -- Progress bar text, Example: "Using " then it will add the items in game name after
        remove = true,                                               -- Only needed for items that should not be removed:   missing or true = remove fals = do not remove
        add = { stress = -10, buffs = {} },                          -- What to add or remove more examples below
        anim = {
            dict = 'amb@world_human_drinking@coffee@male@idle_a',    -- Animation dictionary
            clip = 'idle_c'                                          -- Animation name
        },
        prop = {
            model = 'prop_beer_bottle',                              -- Prop name 
            bone = 57005,                                            -- Right hand
            pos = vector3(0.14, -0.05, -0.05),                       -- Offset for the prop
            rot = vector3(-80.0, 0.0, 0.0)                           -- Rotation for the prop
        }
    },
```

# Drug Effects
```lua
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
```
... And More, Easy to add your own easy to modify. Just edit and restart the resource, then use the drug or item to test.

[![Core-Consumables Demo](https://img.youtube.com/vi/QVQX1PRcEMA/0.jpg)](https://www.youtube.com/watch?v=QVQX1PRcEMA)

This is also availible on my tebex: 
[https://core-forge.tebex.io/](https://core-forge.tebex.io/package/7255680/)

Github profile:
[Github Profile](https://github.com/Core-Forge-5)

Github repo:
[Github](https://github.com/Core-Forge-5/core-consumables)