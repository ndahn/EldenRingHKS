
function SetBonfireIndex()
    SetVariable("IndexBonfire", 0)
end

function SetEnableMimicry()
    g_EnableMimicry = TRUE
end

function ResetMimicry()
    act(AddSpEffect, 503041)
end

function SetAttackHand(hand)
    act(WeaponParameterReference, hand)
end

function SetGuardHand(hand)
    act(SetThrowPossibilityState_Attacker, hand)
end

function GetEquipType(hand, ...)
    local buff = {...}
    local kind = {}
    local num = 1

    if hand == HAND_BOTH then
        kind[1] = env(GetEquipWeaponCategory, HAND_LEFT)
        kind[2] = env(GetEquipWeaponCategory, HAND_RIGHT)
        num = 2
    else
        kind[1] = env(GetEquipWeaponCategory, hand)
    end

    for i = 1, num, 1 do
        for j = 1, #buff, 1 do
            if kind[i] == buff[j] then
                return TRUE
            end
        end
    end
    return FALSE
end

function GetEquipTypeHandStyle(arg)
    if c_Style == HAND_LEFT_BOTH then
        local kind = env(GetEquipWeaponCategory, HAND_LEFT)
        return kind
    else
        local kind = env(GetEquipWeaponCategory, HAND_RIGHT)
        return kind
    end
end

function IsHandStyleBoth(arg)
    if c_Style == HAND_RIGHT_BOTH or c_Style == HAND_LEFT_BOTH then
        return TRUE
    end
    return FALSE
end

function SetEnableAimMode()
    if env(ActionDuration, ACTION_ARM_ACTION) > 0 then
        return
    end

    local style = c_Style
    local isRide = env(IsOnMount)

    if isRide == TRUE then
        if style == HAND_LEFT_BOTH then
            if GetEquipType(HAND_LEFT, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_ARROW, WEAPON_CATEGORY_CROSSBOW) ==
                TRUE then
                act(SetIsPreciseShootingPossible)
            end
        elseif GetEquipType(HAND_RIGHT, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_ARROW, WEAPON_CATEGORY_CROSSBOW) ==
            TRUE then
            act(SetIsPreciseShootingPossible)
        end
    elseif style == HAND_LEFT_BOTH then
        if GetEquipType(HAND_LEFT, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_ARROW, WEAPON_CATEGORY_LARGE_ARROW,
            WEAPON_CATEGORY_CROSSBOW, WEAPON_CATEGORY_BALLISTA) == TRUE then
            act(SetIsPreciseShootingPossible)
        end
    elseif style == HAND_RIGHT_BOTH and
        GetEquipType(HAND_RIGHT, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_ARROW, WEAPON_CATEGORY_LARGE_ARROW,
            WEAPON_CATEGORY_CROSSBOW, WEAPON_CATEGORY_BALLISTA) == TRUE then
        act(SetIsPreciseShootingPossible)
    end
end

function AddStamina(num)
    act(SetStaminaRecoveryDisabled)
    act(ChangeStamina, num)
end

function SetStyleSpecialEffect()
    -- 100620 "[HKS] Right Hand Style"
    -- 100621 "[HKS] Left Hand Style"

    if c_Style == HAND_LEFT_BOTH then
        if env(GetSpEffectID, 100621) == FALSE then
            act(AddSpEffect, 100621)
        end
    elseif env(GetSpEffectID, 100620) == FALSE then
        act(AddSpEffect, 100620)
    end
end

function IsDualBladeSpecific(hand)
    if hand == HAND_LEFT then
        return env(IsTwinSwords, 0)
    else
        return env(IsTwinSwords, 1)
    end
end

function IsEnableDualWielding()
    if c_Style == HAND_RIGHT_BOTH or c_Style == HAND_LEFT_BOTH then
        return -1
    end

    local rightKind = env(GetEquipWeaponCategory, HAND_RIGHT)
    local leftKind = env(GetEquipWeaponCategory, HAND_LEFT)
    local rightSpecialKind = env(GetEquipWeaponSpecialCategoryNumber, HAND_RIGHT)
    local leftSpecialKind = env(GetEquipWeaponSpecialCategoryNumber, HAND_LEFT)

    if rightKind == WEAPON_CATEGORY_SHORT_SWORD then
        if rightSpecialKind == 104 then
            if leftSpecialKind == 104 then
                return HAND_RIGHT
            end
        elseif rightSpecialKind == 262 then
            if leftSpecialKind == 262 then
                return HAND_RIGHT
            end
        elseif leftKind == WEAPON_CATEGORY_SHORT_SWORD and leftSpecialKind ~= 104 and leftSpecialKind ~= 262 then
            return HAND_RIGHT
        end
    elseif rightKind == WEAPON_CATEGORY_CLAW then
        if leftKind == WEAPON_CATEGORY_CLAW then
            return HAND_RIGHT
        end
    elseif rightKind == WEAPON_CATEGORY_STRAIGHT_SWORD then
        if leftKind == WEAPON_CATEGORY_STRAIGHT_SWORD then
            return HAND_RIGHT
        end
    elseif rightKind == WEAPON_CATEGORY_TWINBLADE then
        if leftKind == WEAPON_CATEGORY_TWINBLADE then
            return HAND_RIGHT
        end
    elseif rightKind == WEAPON_CATEGORY_LARGE_SWORD then
        if leftKind == WEAPON_CATEGORY_LARGE_SWORD then
            return HAND_RIGHT
        end
    elseif rightKind == WEAPON_CATEGORY_EXTRALARGE_SWORD then
        if leftKind == WEAPON_CATEGORY_EXTRALARGE_SWORD then
            return HAND_RIGHT
        end
    elseif rightKind == WEAPON_CATEGORY_RAPIER then
        if leftKind == WEAPON_CATEGORY_RAPIER or leftSpecialKind == 262 then
            return HAND_RIGHT
        end
    elseif rightKind == WEAPON_CATEGORY_CURVEDSWORD then
        if leftKind == WEAPON_CATEGORY_CURVEDSWORD then
            return HAND_RIGHT
        end
    elseif rightKind == WEAPON_CATEGORY_KATANA then
        if leftKind == WEAPON_CATEGORY_KATANA or leftSpecialKind == 104 then
            return HAND_RIGHT
        end
    elseif rightKind == WEAPON_CATEGORY_HAMMER then
        if leftKind == WEAPON_CATEGORY_HAMMER then
            return HAND_RIGHT
        end
    elseif rightKind == WEAPON_CATEGORY_AX then
        if leftKind == WEAPON_CATEGORY_AX then
            return HAND_RIGHT
        end
    elseif rightKind == WEAPON_CATEGORY_EXTRALARGE_AXHAMMER then
        if leftKind == WEAPON_CATEGORY_EXTRALARGE_AXHAMMER then
            return HAND_RIGHT
        end
    elseif rightKind == WEAPON_CATEGORY_LARGE_AX then
        if leftKind == WEAPON_CATEGORY_LARGE_AX then
            return HAND_RIGHT
        end
    elseif rightKind == WEAPON_CATEGORY_LARGE_HAMMER then
        if leftKind == WEAPON_CATEGORY_LARGE_HAMMER then
            return HAND_RIGHT
        end
    elseif rightKind == WEAPON_CATEGORY_FLAIL then
        if leftKind == WEAPON_CATEGORY_FLAIL then
            return HAND_RIGHT
        end
    elseif rightKind == WEAPON_CATEGORY_SPEAR then
        if leftKind == WEAPON_CATEGORY_SPEAR then
            return HAND_RIGHT
        end
    elseif rightKind == WEAPON_CATEGORY_LARGE_SPEAR then
        if leftKind == WEAPON_CATEGORY_LARGE_SPEAR then
            return HAND_RIGHT
        end
    elseif rightKind == WEAPON_CATEGORY_LARGE_RAPIER then
        if leftKind == WEAPON_CATEGORY_LARGE_RAPIER then
            return HAND_RIGHT
        end
    elseif rightKind == WEAPON_CATEGORY_HALBERD then
        if leftKind == WEAPON_CATEGORY_HALBERD then
            return HAND_RIGHT
        end
    elseif rightKind == WEAPON_CATEGORY_LARGE_CURVEDSWORD then
        if leftKind == WEAPON_CATEGORY_LARGE_CURVEDSWORD then
            return HAND_RIGHT
        end
    elseif rightKind == WEAPON_CATEGORY_FIST then
        if leftKind == WEAPON_CATEGORY_FIST then
            return HAND_RIGHT
        end
    elseif rightKind == WEAPON_CATEGORY_WHIP then
        if leftKind == WEAPON_CATEGORY_WHIP then
            return HAND_RIGHT
        end
    elseif rightKind == WEAPON_CATEGORY_LARGE_SCYTHE then
        if leftKind == WEAPON_CATEGORY_LARGE_SCYTHE then
            return HAND_RIGHT
        end
    elseif rightKind == WEAPON_CATEGORY_THROW_DAGGER then
        if leftKind == WEAPON_CATEGORY_THROW_DAGGER then
            return HAND_RIGHT
        end
    elseif rightKind == WEAPON_CATEGORY_MARTIAL_ARTS then
        if leftKind == WEAPON_CATEGORY_MARTIAL_ARTS then
            return HAND_RIGHT
        end
    elseif rightKind == WEAPON_CATEGORY_PERFUME_BOTTLE then
        if leftKind == WEAPON_CATEGORY_PERFUME_BOTTLE then
            return HAND_RIGHT
        end
    elseif rightKind == WEAPON_CATEGORY_DUELING_SHIELD then
        return -1
    elseif rightKind == WEAPON_CATEGORY_BACKHAND_SWORD then
        if leftKind == WEAPON_CATEGORY_BACKHAND_SWORD then
            return HAND_RIGHT
        end
    elseif rightKind == WEAPON_CATEGORY_LIGHT_LARGE_SWORD then
        if leftKind == WEAPON_CATEGORY_LIGHT_LARGE_SWORD then
            return HAND_RIGHT
        end
    elseif rightKind == WEAPON_CATEGORY_LARGE_KATANA then
        if leftKind == WEAPON_CATEGORY_LARGE_KATANA then
            return HAND_RIGHT
        end
    elseif rightKind == WEAPON_CATEGORY_BEAST_CLAW and leftKind == WEAPON_CATEGORY_BEAST_CLAW then
        return HAND_RIGHT
    end

    return -1
end

function ExecDeath()
    if env(GetReceivedDamageType) == DAMAGE_TYPE_DEATH or env(GetHP) <= 0 then
        if env(GetSpEffectID, 560) == TRUE then
            return FALSE
        end

        local damage_angle = env(GetReceivedDamageDirection)
        SetVariable("DamageDirection", damage_angle)

        if env(GetKnockbackDistance) < 0 then
            if damage_angle == DAMAGE_DIR_LEFT then
                damage_angle = DAMAGE_DIR_RIGHT
            elseif damage_angle == DAMAGE_DIR_RIGHT then
                damage_angle = DAMAGE_DIR_LEFT
            elseif damage_angle == DAMAGE_DIR_FRONT then
                damage_angle = DAMAGE_DIR_BACK
            elseif damage_angle == DAMAGE_DIR_BACK then
                damage_angle = DAMAGE_DIR_FRONT
            end
        end

        local damage_level = env(GetDamageLevel)

        if env(GetDamageSpecialAttribute, 3) == TRUE then
            SetVariable("IndexDeath", DEATH_TYPE_STONE)
        elseif env(GetSpEffectID, 19700) == TRUE then
            SetVariable("IndexDeath", DEATH_TYPE_CRY)
        elseif env(GetSpEffectID, 102351) == TRUE then
            SetVariable("IndexDeath", DEATH_TYPE_SLEEP)
        elseif env(GetSpEffectID, 9913) == TRUE then
            SetVariable("IndexDeath", DEATH_TYPE_TRINA_EVENT)
        elseif env(GetSpecialAttribute) == 25 then
            act(DebugLogOutput, "DEATY_TYPE_MAD")
            SetVariable("IndexDeath", DEATH_TYPE_MAD)
        elseif env(IsOnLadder) == TRUE then
            SetVariable("IndexDeath", DEATH_TYPE_LADDER)
        elseif env(GetIsWeakPoint) == TRUE then
            SetVariable("IndexDeath", DEATH_TYPE_WEAK)
        elseif damage_level == DAMAGE_LEVEL_EXLARGE or damage_level == DAMAGE_LEVEL_SMALL_BLOW then
            SetVariable("IndexDeath", DEATH_TYPE_BLAST)
        elseif damage_level == DAMAGE_LEVEL_UPPER then
            SetVariable("IndexDeath", DEATH_TYPE_UPPER)
        elseif damage_level == DAMAGE_LEVEL_FLING then
            SetVariable("IndexDeath", DEATH_TYPE_FLING)
        elseif env(GetSpecialAttribute) == DAMAGE_ELEMENT_POISON or env(GetSpecialAttribute) == DAMAGE_ELEMENT_BLIGHT then
            SetVariable("IndexDeath", DEATH_TYPE_POISON)
        else
            local damageState = 0
            local physicalType = env(GetPhysicalAttribute)
            local elementType = env(GetSpecialAttribute)
            local deathRandom = math.random(0, 100)

            if elementType == DAMAGE_ELEMENT_FIRE then
                damageState = 4
            elseif physicalType == DAMAGE_PHYSICAL_SLASH and deathRandom < 70 then
                damageState = 1
            elseif physicalType == DAMAGE_PHYSICAL_THRUST and deathRandom < 70 then
                damageState = 2
            elseif physicalType == DAMAGE_PHYSICAL_BLUNT and deathRandom < 70 then
                damageState = 3
            end

            SetVariable("DamageState", damageState)

            act(DebugLogOutput, "DeathStart DamageState=" .. damageState .. " rand=" .. deathRandom)
            local isMad = env(GetDamageSpecialAttribute, 6)
            act(DebugLogOutput, "elementType=" .. elementType .. " IsMad=" .. isMad)

            if damage_angle == DAMAGE_DIR_BACK then
                SetVariable("IndexDeath", DEATH_TYPE_COMMON_BACK)
            else
                SetVariable("IndexDeath", DEATH_TYPE_COMMON)
            end
        end

        ExecEventAllBody("W_DeathStart")
        return TRUE
    elseif env(IsInvincibleDebugMode) == FALSE then
        if env(GetStateChangeType, CONDITION_TYPE_STONE) == TRUE or env(GetStateChangeType, CONDITION_TYPE_CRYSTAL) ==
            TRUE or env(GetDamageSpecialAttribute, 3) == TRUE then
            SetVariable("IndexDeath", DEATH_TYPE_STONE)
            ExecEventAllBody("W_DeathStart")
            return TRUE
        elseif env(GetSpEffectID, 19700) == TRUE then
            SetVariable("IndexDeath", DEATH_TYPE_CRY)
            ExecEventAllBody("W_DeathStart")
            return TRUE
        elseif env(GetSpEffectID, 102351) == TRUE then
            SetVariable("IndexDeath", DEATH_TYPE_SLEEP)
            ExecEventAllBody("W_DeathStart")
            return TRUE
        end
    end
end

--------------
-- Triggers --
--------------

function DeathIdle_onActivate()
    act(SetDeathStay, TRUE)
end

function DeathIdle_onDeactivate()
    act(SetDeathStay, FALSE)
end


SetBonfireIndex = hookup_function(SetBonfireIndex)
SetEnableMimicry = hookup_function(SetEnableMimicry)
ResetMimicry = hookup_function(ResetMimicry)
SetAttackHand = hookup_function(SetAttackHand)
SetGuardHand = hookup_function(SetGuardHand)
GetEquipType = hookup_function(GetEquipType)
GetEquipTypeHandStyle = hookup_function(GetEquipTypeHandStyle)
IsHandStyleBoth = hookup_function(IsHandStyleBoth)
SetEnableAimMode = hookup_function(SetEnableAimMode)
AddStamina = hookup_function(AddStamina)
SetStyleSpecialEffect = hookup_function(SetStyleSpecialEffect)
IsDualBladeSpecific = hookup_function(IsDualBladeSpecific)
IsEnableDualWielding = hookup_function(IsEnableDualWielding)
ExecDeath = hookup_function(ExecDeath)
DeathIdle_onActivate = hookup_function(DeathIdle_onActivate)
DeathIdle_onDeactivate = hookup_function(DeathIdle_onDeactivate)
