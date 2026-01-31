Config = {}
Config.Debug = true

-- Inside add you can add or subtract
-- You can have health, armor, food, water and stress,
-- Inside buffs you can have strength or speed value is a multiplier and duration is miliseconds
-- Example:
-- add = { health = 50, armor = 20, hunger = 20, thirst = 20, stress = -10, buffs = { strength = {value=1.4, duration=120}, speed={value=1.4, duration=120} } },
-- You can also add your own inside client/cl_consume.lua line 365 for stats and line 8 for buffs

Consume = {
    --#region Define
    drug_moonshine = {                                               -- ox_inventory item name
        time = 3000,                                                 -- Use Time
        effect = 'alcohol',                                          -- Effect name
        progressbartext = "Drinking ",                               -- Progress bar text, Example: "Using " then it will add the items in game name after
        remove = true,                                               -- Only needed for items that should not be removed (missing or true = true) false will not remove
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
    --#endregion
    drug_mushroom_dry = {
        time = 2500,
        effect = 'mushroom',
        progressbartext = "Eating ",
        add = { stress = -10, buffs = {} },
        anim = {
            dict = 'mp_player_inteat@burger',
            clip = 'mp_player_int_eat_burger'
        },
        prop = {
            model = 'prop_cs_burger_01',
            bone = 18905,                                           --Left Hand
            pos = vector3(0.13, 0.05, 0.02),
            rot = vector3(-50.0, 0.0, 0.0)
        }
    },
    drug_lean = {
        time = 3000,
        effect = 'lean',
        progressbartext = "Sipping ",
        add = { stress = -10, armor = 10, buffs = {} },
        anim = {
            dict = 'amb@world_human_drinking@coffee@male@idle_a',
            clip = 'idle_c'
        },
        prop = {
            model = 'prop_plastic_cup_02',
            bone = 18905,
            pos = vector3(0.13, 0.02, 0.02),
            rot = vector3(-120.0, 0.0, 0.0)
        }
    },
    drug_coke_bag = {
        time = 2000,
        effect = 'coke',
        progressbartext = "Snorting ",
        add = { stress = -10, buffs = { strength = {value=1.4, duration=120}, speed={value=1.4, duration=120} } },
        anim = {
            dict = 'move_p_m_two_idles@generic',
            clip = 'fidget_sniff_fingers'
        }
    },
    drug_heroin_bag = {
        time = 5000,
        effect = 'heroin',
        progressbartext = "Shooting Up ",
        add = { stress = -10, armor = 20, buffs = {} },
        anim = {
            dict = 'rcmpaparazzo1ig_4',
            clip = 'miranda_shooting_up'
        },
        prop = {
            model = 'prop_syringe_01',
            bone = 18905,
            pos = vector3(0.11, 0.03, 0.0),
            rot = vector3(-124.0, 0.0, 0.0)
        }
    },
    drug_peyote_mescaline = {
        time = 1000,
        effect = 'peyote',
        progressbartext = "Eating ",
        add = {
            stress = -10,
            buffs = {}
        },
        anim = {
            dict = 'mp_player_inteat@burger',
            clip = 'mp_player_int_eat_burger',
        },
        prop = {
            model = 'prop_cs_burger_01',
            bone = 18905,
            pos = vector3(0.13, 0.05, 0.02),
            rot = vector3(-50.0, 0.0, 0.0)
        }
    },
    drug_xanax = {
        time = 1000,
        effect = 'xan',
        progressbartext = "Taking ",
        add = {
            stress = -100,
            armor = 5,
            hunger = - 2,
            thirst = -2,
            buffs = {}},
        anim = {
            dict = 'mp_player_inteat@burger',
            clip = 'mp_player_int_eat_burger'
        }
    },
}