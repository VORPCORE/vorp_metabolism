
local function screenEffect(effect, durationMinutes)
    local durationMilliseconds = durationMinutes * 60000 -- Convert minutes to milliseconds
    AnimpostfxPlay(effect)
    Wait(durationMilliseconds)
    AnimpostfxStop(effect)
end

local function playAnimCoffee(propName)
    local playerCoords = GetEntityCoords(PlayerPedId())
    local coffeeProp = CreateObject(joaat(propName), playerCoords.x, playerCoords.y, playerCoords.z, true, true, false)
    Citizen.InvokeNative(0x669655FFB29EF1A9, coffeeProp, 0, "CTRL_cupFill", 1.0)
    TaskItemInteraction_2(PlayerPedId(), GetHashKey("CONSUMABLE_COFFEE"), coffeeProp,
        GetHashKey("P_MUGCOFFEE01X_PH_R_HAND"), GetHashKey("DRINK_COFFEE_HOLD"), 1, 0, -1082130432)
end

local function loadAnimDict(dict)
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)
        while (not HasAnimDictLoaded(dict)) do
            Wait(100)
        end
    end
end

local function playAnimBandage(propName)
    local playerCoords = GetEntityCoords(PlayerPedId())
    local dict = "mini_games@story@mob4@heal_jules@bandage@arthur"
    local anim = "tourniquet_slow"

    loadAnimDict(dict)

    local hashItem = GetHashKey(propName)

    local prop = CreateObject(hashItem, playerCoords.x, playerCoords.y, playerCoords.z, true, true, false)
    PROPS[#PROPS + 1] = prop
    local boneIndex = GetEntityBoneIndexByName(PlayerPedId(), "SKEL_L_HAND")

    Wait(1000)

    TaskPlayAnim(PlayerPedId(), dict, anim, 1.0, 8.0, 5000, 31, 0.0, false, false, false)
    AttachEntityToEntity(prop, PlayerPedId(), boneIndex, 0.10, 0.0, 0.03, 0.0, -60.0, -90.0, true, true, false, true, 1,
        true, false, false)
    Wait(6000)

    DeleteObject(prop)
    ClearPedSecondaryTask(PlayerPedId())
end

local function playAnimSyringe(propName)
    local playerCoords = GetEntityCoords(PlayerPedId())
    local dict = "mech_inventory@item@stimulants@inject@quick"
    local anim = "quick_stimulant_inject_lhand"

    loadAnimDict(dict)

    local hashItem = GetHashKey(propName)
    local prop = CreateObject(hashItem, playerCoords.x, playerCoords.y, playerCoords.z, true, true, false)
    local boneIndex = GetEntityBoneIndexByName(PlayerPedId(), "SKEL_L_HAND")
    PROPS[#PROPS + 1] = prop
    Wait(1000)
    TaskPlayAnim(PlayerPedId(), dict, anim, 1.0, 8.0, 5000, 31, 0.0, false, false, false)
    AttachEntityToEntity(prop, PlayerPedId(), boneIndex, 0.10, 0.0, 0.03, 0.0, -80.0, -90.0, true, true, false, true, 1,
        true, false, false)
    Wait(2000) -- 6000

    DeleteObject(prop)
    ClearPedSecondaryTask(PlayerPedId())
end

local function playAnimStew(propName)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local stewProp = CreateObject(propName, playerCoords.x, playerCoords.y, playerCoords.z, true, true, false)
    PROPS[#PROPS + 1] = stewProp
    local stewSpoonProp = CreateObject("p_beefstew_spoon01x", playerCoords.x, playerCoords.y, playerCoords.z, true, true,
        false)
    PROPS[#PROPS + 1] = stewSpoonProp
    Citizen.InvokeNative(0x669655FFB29EF1A9, stewProp, 0, "Stew_Fill", 1.0)
    Citizen.InvokeNative(0xCAAF2BCCFEF37F77, stewProp, 20)
    Citizen.InvokeNative(0xCAAF2BCCFEF37F77, stewSpoonProp, 82)
    TaskItemInteraction_2(playerPed, 599184882, stewProp, joaat("p_bowl04x_stew_PH_L_HAND"), -583731576, 1, 0, -1.0)
    TaskItemInteraction_2(playerPed, 599184882, stewSpoonProp, joaat("p_spoon01x_PH_R_HAND"), -583731576, 1, 0, -1.0)
    Citizen.InvokeNative(0xB35370D5353995CB, playerPed, -583731576, 1.0)
end

local function playAnimDrink(propName)
    local playerCoords = GetEntityCoords(PlayerPedId())
    local dict = "amb_rest_drunk@world_human_drinking@male_a@idle_a"
    local anim = "idle_a"

    if (not IsPedMale(PlayerPedId())) then
        dict = "amb_rest_drunk@world_human_drinking@female_a@idle_b"
        anim = "idle_b"
    end

    loadAnimDict(dict)

    local hashItem = GetHashKey(propName)

    local prop = CreateObject(hashItem, playerCoords.x, playerCoords.y, playerCoords.z, true, true, false)
    local boneIndex = GetEntityBoneIndexByName(PlayerPedId(), "SKEL_R_HAND") -- SKEL_R_Finger12
    PROPS[#PROPS + 1] = prop
    Wait(1000)

    TaskPlayAnim(PlayerPedId(), dict, anim, 1.0, 8.0, 5000, 31, 0.0, false, false, false)
    AttachEntityToEntity(prop, PlayerPedId(), boneIndex, 0.08, -0.04, -0.05, -75.0, 0.0, 0.0, true, true, false, true, 1,
        true, false, false)
    Wait(5300) -- 6000

    DeleteObject(prop)
    ClearPedSecondaryTask(PlayerPedId())
end

local function playAnimEat(propName)
    local playerCoords = GetEntityCoords(PlayerPedId())
    local dict = "mech_inventory@clothing@bandana"
    local anim = "NECK_2_FACE_RH"

    loadAnimDict(dict)

    local hashItem = GetHashKey(propName)

    local prop = CreateObject(hashItem, playerCoords.x, playerCoords.y, playerCoords.z + 0.2, true, true, false)
    local boneIndex = GetEntityBoneIndexByName(PlayerPedId(), "SKEL_R_HAND") -- SKEL_R_Finger12
    PROPS[#PROPS + 1] = prop
    Wait(1000)

    TaskPlayAnim(PlayerPedId(), dict, anim, 1.0, 8.0, 5000, 31, 0.0, false, false, false)
    AttachEntityToEntity(prop, PlayerPedId(), boneIndex, 0.08, -0.04, -0.05, -75.0, 0.0, 0.0, true, true, false, true, 1,
        true, false, false)
    -- AttachEntityToEntity(prop, PlayerPedId(), boneIndex, 0.02, 0.028, 0.001, 15.0, 175.0, 0.0, true, true, false, true, 1, true)
    Wait(5300) -- 6000

    DeleteObject(prop)
    ClearPedSecondaryTask(PlayerPedId())
    RemoveAnimDict(dict)
end

RegisterNetEvent('vorpmetabolism:useItem', function(index, _)
    PlaySoundFrontend("Core_Fill_Up", "Consumption_Sounds", true, 0)
    local value = Config.ItemsToUse[index]
    if not value then return end

    if (value.Thirst and value.Thirst > 0) then
        local newThirst = PlayerStatus.Thirst + value.Thirst

        if (newThirst > 1000) then
            newThirst = 1000
        end

        if (newThirst < 0) then
            newThirst = 0
        end

        PlayerStatus.Thirst = newThirst
    end

    if (value.Hunger and value.Hunger > 0) then
        local newHunger = PlayerStatus.Hunger + value.Hunger

        if (newHunger > 1000) then
            newHunger = 1000
        end

        if (newHunger < 0) then
            newHunger = 0
        end

        PlayerStatus.Hunger = newHunger
    end

    if (value.Metabolism and value.Metabolism > 0) then
        local newMetabolism = PlayerStatus.Metabolism + value.Metabolism

        if (newMetabolism > 10000) then
            newMetabolism = 10000
        end

        if (newMetabolism < -10000) then
            newMetabolism = -10000
        end

        PlayerStatus.Metabolism = newMetabolism
    end

    if (value.Stamina and value.Stamina > 0) then
        local stamina = GetAttributeCoreValue(PlayerPedId(), 1)
        local newStamina = stamina + value.Stamina

        if (newStamina > 100) then
            newStamina = 100
        end

        Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 1, newStamina) -- SetAttributeCoreValue native
    end

    if (value.InnerCoreHealth and value.InnerCoreHealth > 0) then
        local health = GetAttributeCoreValue(PlayerPedId(), 0)
        local newhealth = health + value.InnerCoreHealth

        if (newhealth > 100) then
            newhealth = 100
        end

        Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 0, newhealth) -- SetAttributeCoreValue native
    end

    if (value.OuterCoreHealth and value.OuterCoreHealth > 0) then
        local health = GetEntityHealth(PlayerPedId())
        local newhealth = health + value.OuterCoreHealth
        SetEntityHealth(PlayerPedId(), newhealth, 0)
    end

    -- Golds
    if (value.OuterCoreHealthGold and value.OuterCoreHealthGold > 0.0) then
        EnableAttributeOverpower(PlayerPedId(), 0, value.OuterCoreHealthGold + 0.0, true)
    end
    if (value.InnerCoreHealthGold and value.InnerCoreHealthGold > 0.0) then
        EnableAttributeOverpower(PlayerPedId(), 0, value.InnerCoreHealthGold + 0.0, true)
    end

    if (value.OuterCoreStaminaGold and value.OuterCoreStaminaGold > 0.0) then
        EnableAttributeOverpower(PlayerPedId(), 1, value.OuterCoreStaminaGold + 0.0, true)
    end
    if (value.InnerCoreStaminaGold and value.InnerCoreStaminaGold > 0.0) then
        EnableAttributeOverpower(PlayerPedId(), 1, value.InnerCoreStaminaGold + 0.0, true)
    end

    if value.Animation then
        if (value.Animation == "eat") then
            playAnimEat(value.PropName)
        elseif (value.Animation == "stew") then
            playAnimStew(value.PropName)
        elseif (value.Animation == "drink") then
            playAnimDrink(value.PropName)
        elseif (value.Animation == "coffee") then
            playAnimCoffee(value.PropName)
        elseif (value.Animation == "syringe") then
            playAnimSyringe(value.PropName)
        elseif (value.Animation == "bandage") then
            playAnimBandage(value.PropName)
        end
    end

    if value.Effect and value.Effect ~= "" then
        screenEffect(value.Effect, value.EffectDuration)
    end
end)


-- On Resource Start
AddEventHandler('onResourceStart', function(resourceName)
    if Config.DevMode then
        if (GetCurrentResourceName() == resourceName) then
            TriggerServerEvent("vorpmetabolism:GetStatus")
        end
    end
end)
