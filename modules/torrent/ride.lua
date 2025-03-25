
Ride_HighJump_Height = 0
Ride_HeadDown_Rate = 0
Ride_Feed_Rate = 0
IsEnableFeedAddBlend = FALSE

-- Submodules
load_module("modules/torrent/ride_attack.lua")
load_module("modules/torrent/ride_damage.lua")
load_module("modules/torrent/ride_gesture.lua")
load_module("modules/torrent/ride_handchange.lua")
load_module("modules/torrent/ride_item.lua")
load_module("modules/torrent/ride_jump.lua")
load_module("modules/torrent/ride_magic.lua")


function ExecRideEventAnim()
    local eventID = env(GetEventID)
    if eventID <= -1 then
        return FALSE
    end
    if eventID == 60070 then
        ExecEventAllBody("W_Event160070")
    elseif eventID == 50250 then
        ExecEventAllBody("W_Event150250")
    else
        return FALSE
    end
    return TRUE
end

function Ride_Activate()
end

function Ride_Update()
    if IsEnableFeedAddBlend == TRUE then
        Ride_Feed_Rate = 1
        act(ApplyRideBlend, "Ride_Feed_AddBlend", 1)
    else
        Ride_Feed_Rate = ConvergeValue(0, Ride_Feed_Rate, 4, 4)
        act(ApplyRideBlend, "Ride_Feed_AddBlend", Ride_Feed_Rate)
    end

    if RIDE_ISENABLE_DOUBLEJUMP == FALSE and env(IsMountInFallLoop) == TRUE then
        RIDE_ISENABLE_DOUBLEJUMP = TRUE
    end
end

function Ride_Deactivate()
    if IsNodeActive("Jump_RideOff LayerGenerator") == FALSE then
        act(Dismount)
    end
end

function Ride_NoThrow_Activate()
    SetThrowInvalid()
end

function Ride_NoThrow_Update()
    SetThrowInvalid()

    local hand = HAND_RIGHT

    if c_Style == HAND_LEFT_BOTH then
        hand = HAND_LEFT
    end

    SetAttackHand(hand)
    SetGuardHand(hand)
end

function ExecRide()
    if env(IsSummoningRide) == TRUE then
        SetVariable("RideOnSummonTest", 1)
        FireRideEvent("W_RideOn", "W_RideOn", FALSE)
        return TRUE
    elseif env(ActionRequest, ACTION_ARM_RIDEON) == TRUE then
        act(Mounting)
        return TRUE
    end
    return FALSE
end

function FireRideEvent(upper_event, lower_event, lower_only)
    if lower_only == TRUE then
        act(PlayRideAnim, lower_event)
    else
        ExecEventAllBody(upper_event)
        act(PlayRideAnim, lower_event)
    end
end

function FireRideEventNoReset(upper_event, lower_event, lower_only)
    if lower_only == TRUE then
        act(PlayRideAnim, lower_event)
    else
        ExecEventNoReset(upper_event)
        act(PlayRideAnim, lower_event)
    end
end

-- Torrent Dismount
function ExecRideOff(is_force, rideOffAnyway)
    if is_force == FALSE and env(ActionRequest, ACTION_ARM_L3) == FALSE then
        return FALSE
    end
    if is_force == FALSE and (env(GetGeneralTAEFlag, TAE_FLAG_CHARGING) == 1 or env(GetSpEffectID, 100280) == TRUE) then
        ResetRequest()
        return FALSE
    end

    local unhorseDir = -1

    if env(GetMountReceivedDamageDirection, 2) == TRUE then
        unhorseDir = 2
    elseif env(GetMountReceivedDamageDirection, 3) == TRUE then
        unhorseDir = 3
    elseif env(GetMountReceivedDamageDirection, 1) == TRUE then
        unhorseDir = 1
    end

    if unhorseDir < 0 then
        if rideOffAnyway == FALSE then
            return FALSE
        else
            unhorseDir = 2
        end
    end

    local event = "W_RideOff"
    local event_under = "W_RideOff"

    if env(GetSpEffectID, 19995) == TRUE then
        event = "W_RideDamage_Fall_AbyssalForest"
        event_under = "W_RideDamage_Fall_AbyssalForest"
    elseif GetVariable("MoveSpeedLevel") >= 0.8999999761581421 and rideOffAnyway ~= TRUE then
        event = "W_Jump_RideOff"

        if GetVariable("MoveSpeedLevel") >= 1.5 or 1 <= GetVariable("ToggleDash") then
            event_under = "W_RideOffGallop"
            SetVariable("RideOff_Jump_Speed", 1)
        else
            event_under = "W_RideOffDash"
            SetVariable("RideOff_Jump_Speed", 0)
        end

        local style = c_Style

        if style == HAND_RIGHT then
            SetVariable("JumpAttack_HandCondition", 0)
        elseif style == HAND_RIGHT_BOTH then
            SetVariable("JumpAttack_HandCondition", 1)
        elseif style == HAND_LEFT_BOTH then
            if GetEquipType(HAND_LEFT, WEAPON_CATEGORY_CROSSBOW) == TRUE then
                SetVariable("JumpAttack_HandCondition", 4)
            else
                SetVariable("JumpAttack_HandCondition", 1)
            end
        end

        SetVariable("JumpAttackForm", 0)
        SetVariable("JumpUseMotion_Bool", false)
        SetVariable("JumpMotion_Override", 0.009999999776482582)
        SetVariable("JumpAttack_Land", 0)
        SetVariable("SwingPose", 0)
        SetVariable("IsEnableDirectionJumpTAE", true)

        if GetVariable("IsEnableToggleDashTest") == 2 then
            SetVariable("ToggleDash", 0)
        end
    elseif unhorseDir == 2 then
        SetVariable("Int16Variable02", 0)
    elseif unhorseDir == 3 then
        SetVariable("Int16Variable02", 1)
    elseif unhorseDir == 1 then
        SetVariable("Int16Variable02", 2)
    end

    FireRideEvent(event, event_under, FALSE)

    return TRUE
end

function RideReActionFunction()
    local isEnableForceRideOff = FALSE

    if env(IsAutomaticTesting) == TRUE then
        if env(InNoRidingArea) == TRUE and env(IsRidingPcMount) == TRUE and env(IsMountInFallLoop) == TRUE then
            isEnableForceRideOff = TRUE
        end
    elseif (env(InNoRidingArea) == TRUE or env(IsMultiplayer) == TRUE or env(GetSpEffectType, 433) == TRUE) and
        env(IsRidingPcMount) == TRUE and env(IsMountInFallLoop) == TRUE then
        isEnableForceRideOff = TRUE
    end

    if isEnableForceRideOff == TRUE then
        ExecRideOff(TRUE, TRUE)
        if env(GetSpEffectID, 19995) == FALSE then
            act(AddSpEffect, 181)
        end
        return TRUE
    end
    if ExecRideDeath() == TRUE then
        return TRUE
    end
    if ExecRideDamage() == TRUE then
        return TRUE
    end
    if ExecRideEventAnim() == TRUE then
        return TRUE
    end
    return FALSE
end

function ExecRideDeath()
    if env(GetDamageSpecialAttribute, 3) == TRUE then
        SetVariable("IndexRideDeath", RIDE_DEATH_TYPE_STONE)
        FireRideEvent("W_RideDeath", "W_RideDeath", FALSE)
        return TRUE
    elseif env(GetHP) <= 0 then
        if env(GetDamageSpecialAttribute, 6) == TRUE or env(GetSpecialAttribute) == 25 then
            SetVariable("IndexRideDeath", RIDE_DEATH_TYPE_MAD)
        else
            SetVariable("IndexRideDeath", RIDE_DEATH_TYPE_COMMON)
        end

        FireRideEvent("W_RideDeath", "W_RideDeath", FALSE)
        return TRUE
    elseif env(IsMountDead) <= 0 then
        FireRideEvent("W_RideDamage_Fall", "W_RideDeath", FALSE)
        return TRUE
    end
    return FALSE
end

function ExecRideDamage()
    local damage_level = env(GetDamageLevel)
    local damage_type = env(GetReceivedDamageType)
    local is_damaged = env(HasReceivedAnyDamage)
    local damage_angle = env(GetReceivedDamageDirection)
    local damage_level_under = env(GetMountDamageLevel)
    local damage_type_under = env(GetMountRecievedDamageType)
    local is_damaged_under = env(HasMountReceivedAnyDamage)
    local damage_angle_under = env(GetMountRecievedDamageAngle)

    if damage_type == DAMAGE_TYPE_PARRY then
        FireRideEvent("W_RideDamage_Fall", "W_RideRun_End", FALSE)
        return TRUE
    end
    if damage_type == DAMAGE_TYPE_WALL_RIGHT or damage_type == DAMAGE_TYPE_WALL_LEFT then
        if GetVariable("RideAttackHand") == HAND_LEFT then
            SetVariable("GuardDamageIndex", 2)
        else
            SetVariable("GuardDamageIndex", 0)
        end

        ExecEventAllBody("W_RideRepelledWall")
        return TRUE
    elseif damage_type == DAMAGE_TYPE_GUARDED or damage_type == DAMAGE_TYPE_GUARDED_LEFT then
        Replanning()

        if GetVariable("RideAttackHand") == HAND_LEFT then
            SetVariable("GuardDamageIndex", 2)
        else
            SetVariable("GuardDamageIndex", 0)
        end

        if damage_level == DAMAGE_LEVEL_NONE or damage_level == DAMAGE_LEVEL_MINIMUM or damage_level ==
            DAMAGE_LEVEL_SMALL then
            SetVariable("DamageDirection", 2)
            act(SetDamageAnimType, DAMAGE_FLAG_SMALL)
            ExecEventAllBody("W_RideRepelledSmall")
            return TRUE
        else
            act(SetDamageAnimType, DAMAGE_FLAG_LARGE)
            SetVariable("DamageDirection", 2)
            ExecEventAllBody("W_RideRepelledLarge")
            return TRUE
        end
    elseif damage_type == DAMAGE_TYPE_GUARD then
        if env(GetSpEffectID, 175) == TRUE then
            return FALSE
        end
        if env(GetSpEffectID, 176) == TRUE then
            return FALSE
        end
        FireRideEvent("W_Ride_SA_Add_Guard", "W_Ride_SA_Add", FALSE)
        SetVariable("Ride_SA_Add_Blend", 1)
        act(ApplyRideBlend, "Ride_SA_Add_Blend", 1)
        return FALSE
    elseif damage_type == DAMAGE_TYPE_GUARDBREAK then
        act(SetDamageAnimType, DAMAGE_FLAG_LARGE)
        SetVariable("DamageDirection", 2)
        ExecEventAllBody("W_RideRepelledLarge")
        return TRUE
    end
    if env(IsMountFalling) == TRUE then
        FireRideEvent("W_RideFall_Start", "W_RideFall_Start", FALSE)
        return TRUE
    end
    if env(GetPoise) <= 0 and (damage_level > DAMAGE_LEVEL_NONE or damage_level_under > DAMAGE_LEVEL_NONE) and
        (is_damaged == TRUE or is_damaged_under == TRUE) then
        FireRideEvent("W_RideDamage_Fall", "W_RideRun_End", FALSE)
        return TRUE
    end
    if env(GetDamageSpecialAttribute, 5) == TRUE then
        FireRideEvent("W_RideDamage_Fall", "W_RideRun_End", FALSE)
        return TRUE
    end
    if env(GetDamageSpecialAttribute, 6) == TRUE then
        FireRideEvent("W_RideDamageMad", "W_RideRun_End", FALSE)
        Replanning()
        return TRUE
    end
    if env(GetSpEffectType, 32) == TRUE then
        FireRideEvent("W_RideDamageBind_Start", "W_RideDeath", FALSE)
        Replanning()
        return TRUE
    end
    if (env(GetSpecialAttribute) == 5 or env(GetMountSpecialAttribute) == 5) and GetVariable("MoveSpeedLevel") > 1.5 then
        SetVariable("DamageDirection", 2)
        act(ApplyRideBlend, "DamageDirection", 2)
        SetVariable("RideDamageDefaultState", 1)
        act(ApplyRideBlend, "RideDamageDefaultState", 1)
        act(ApplyDamageFlag, DAMAGE_FLAG_MIDDLE)
        Replanning()
        FireRideEvent("W_RideDamageMiddle", "W_Ride_DamageMiddle", FALSE)
        return TRUE
    elseif env(GetSpecialAttribute) == 8 or env(GetMountSpecialAttribute) == 8 then
        SetVariable("DamageDirection", 2)
        act(ApplyRideBlend, "DamageDirection", 2)
        SetVariable("RideDamageDefaultState", 1)
        act(ApplyRideBlend, "RideDamageDefaultState", 1)
        act(ApplyDamageFlag, DAMAGE_FLAG_MIDDLE)
        Replanning()
        FireRideEvent("W_RideDamageMiddle", "W_Ride_DamageMiddle", FALSE)
        return TRUE
    end
    if env(GetDamageSpecialAttribute, 2) == TRUE or env(GetDamageSpecialAttribute, 4) == TRUE then
        if damage_level == DAMAGE_LEVEL_NONE then
            damage_level = DAMAGE_LEVEL_SMALL
        elseif damage_level ~= DAMAGE_LEVEL_SMALL and damage_level ~= DAMAGE_LEVEL_MIDDLE and damage_level ==
            DAMAGE_LEVEL_MINIMUM then
        end
    end
    if damage_level <= DAMAGE_LEVEL_NONE and damage_level_under <= DAMAGE_LEVEL_NONE and
        (is_damaged == FALSE and is_damaged_under == FALSE or env(IsPartDamageAdditiveBlendInvalid) == TRUE) and
        (damage_type == DAMAGE_TYPE_INVALID or damage_type == DAMAGE_TYPE_WEAK_POINT or damage_type ==
            DAMAGE_LEVEL_MINIMUM) and
        (damage_type_under == DAMAGE_TYPE_INVALID or damage_type_under == DAMAGE_TYPE_WEAK_POINT or damage_type_under ==
            DAMAGE_LEVEL_MINIMUM) then
        return FALSE
    end

    SetVariable("BlendRideDamageFire", 0)
    act(ApplyRideBlend, "BlendRideDamageFire", 0)
    SetVariable("Ride_SA_Add_Blend", 0)
    act(ApplyRideBlend, "Ride_SA_Add_Blend", 0)

    if env(GetSpecialAttribute) == 5 or env(GetSpecialAttribute) == 8 or env(GetMountSpecialAttribute) == 5 or
        env(GetMountSpecialAttribute) == 8 then
        return FALSE
    end
    if env(GetIsWeakPoint) == TRUE then
        SetVariable("DamageDirection", 2)
        act(ApplyRideBlend, "DamageDirection", 2)
        act(ApplyDamageFlag, DAMAGE_FLAG_WEAK)
        FireRideEvent("W_RideDamageWeakTop", "W_Ride_DamageWeakTop", FALSE)
        Replanning()

        return TRUE
    elseif env(GetMountIsWeakPoint) == TRUE then
        SetVariable("DamageDirection", 2)
        act(ApplyRideBlend, "DamageDirection", 2)
        act(ApplyDamageFlag, DAMAGE_FLAG_WEAK)
        FireRideEvent("W_RideDamageWeakUnder", "W_Ride_DamageWeakUnder", FALSE)
        Replanning()

        return TRUE
    elseif damage_level == DAMAGE_LEVEL_EXLARGE or damage_level == DAMAGE_LEVEL_SMALL_BLOW or damage_level ==
        DAMAGE_LEVEL_UPPER or damage_level == DAMAGE_LEVEL_EX_BLAST or damage_level == DAMAGE_LEVEL_BREATH or
        damage_level_under == DAMAGE_LEVEL_EXLARGE or damage_level_under == DAMAGE_LEVEL_SMALL_BLOW or
        damage_level_under == DAMAGE_LEVEL_UPPER or damage_level_under == DAMAGE_LEVEL_EX_BLAST or damage_level_under ==
        DAMAGE_LEVEL_BREATH then
        local damage_angle_real = damage_angle

        if damage_level <= DAMAGE_LEVEL_NONE then
            damage_angle_real = damage_angle_under
        end

        SetVariable("DamageDirection", damage_angle_real)
        act(ApplyRideBlend, "DamageDirection", damage_angle_real)
        act(ApplyDamageFlag, DAMAGE_FLAG_LARGE_BLOW)
        FireRideEvent("W_RideDamageExLarge", "W_Ride_DamageExLarge", FALSE)
        Replanning()

        return TRUE
    elseif damage_level == DAMAGE_LEVEL_LARGE or damage_level == DAMAGE_LEVEL_FLING or damage_level_under ==
        DAMAGE_LEVEL_LARGE or damage_level_under == DAMAGE_LEVEL_FLING then
        if env(GetSpecialAttribute) == DAMAGE_ELEMENT_FIRE or env(GetMountSpecialAttribute) == DAMAGE_ELEMENT_FIRE then
            SetVariable("BlendRideDamageFire", 1)
            act(ApplyRideBlend, "BlendRideDamageFire", 1)
            act(ApplyRideBlend, "IndexFireRideDamageVariation", 0)
            FireRideEvent("W_RideFireMiddleDamageBlend_Add", "W_Ride_FireMiddleDamageBlend_Add", FALSE)
        end

        SetVariable("DamageDirection", 2)
        act(ApplyRideBlend, "DamageDirection", 2)
        SetVariable("RideDamageDefaultState", 2)
        act(ApplyRideBlend, "RideDamageDefaultState", 2)
        act(ApplyDamageFlag, DAMAGE_FLAG_LARGE)
        FireRideEvent("W_RideDamageLarge", "W_Ride_DamageLarge", FALSE)
        Replanning()

        return TRUE
    elseif damage_level == DAMAGE_LEVEL_MIDDLE or damage_level == DAMAGE_LEVEL_PUSH or damage_level_under ==
        DAMAGE_LEVEL_MIDDLE or damage_level_under == DAMAGE_LEVEL_PUSH then
        if env(GetSpecialAttribute) == DAMAGE_ELEMENT_FIRE or env(GetMountSpecialAttribute) == DAMAGE_ELEMENT_FIRE then
            SetVariable("BlendRideDamageFire", 1)
            act(ApplyRideBlend, "BlendRideDamageFire", 1)
            act(ApplyRideBlend, "IndexFireRideDamageVariation", 0)
            FireRideEvent("W_RideFireMiddleDamageBlend_Add", "W_Ride_FireMiddleDamageBlend_Add", FALSE)
        end

        SetVariable("DamageDirection", 2)
        act(ApplyRideBlend, "DamageDirection", 2)
        SetVariable("RideDamageDefaultState", 1)
        act(ApplyRideBlend, "RideDamageDefaultState", 1)
        act(ApplyDamageFlag, DAMAGE_FLAG_MEDIUM)
        FireRideEvent("W_RideDamageMiddle", "W_Ride_DamageMiddle", FALSE)
        Replanning()

        return TRUE
    elseif damage_level == DAMAGE_LEVEL_SMALL or damage_level_under == DAMAGE_LEVEL_SMALL then
        if env(GetSpecialAttribute) == DAMAGE_ELEMENT_FIRE or env(GetMountSpecialAttribute) == DAMAGE_ELEMENT_FIRE then
            SetVariable("BlendRideDamageFire", 1)
            act(ApplyRideBlend, "BlendRideDamageFire", 1)
            act(ApplyRideBlend, "IndexFireRideDamageVariation", 0)
            FireRideEvent("W_RideFireSmallDamageBlend_Add", "W_Ride_FireSmallDamageBlend_Add", FALSE)
        end

        SetVariable("DamageDirection", 2)
        act(ApplyRideBlend, "DamageDirection", 2)
        SetVariable("RideDamageDefaultState", 0)
        act(ApplyRideBlend, "RideDamageDefaultState", 0)
        act(ApplyDamageFlag, DAMAGE_FLAG_SMALL)
        FireRideEvent("W_RideDamageSmall", "W_Ride_DamageSmall", FALSE)
        Replanning()

        return TRUE
    elseif damage_level == DAMAGE_LEVEL_NONE or damage_level == DAMAGE_LEVEL_MINIMUM or damage_level_under ==
        DAMAGE_LEVEL_NONE or damage_level_under == DAMAGE_LEVEL_MINIMUM then
        local index = 0

        SetVariable("IndexRide_SA_Add_Random", index)
        act(ApplyRideBlend, "IndexRide_SA_Add_Random", index)
        act(ApplyDamageFlag, DAMAGE_FLAG_MINIMUM)
        FireRideEvent("W_Ride_SA_Add", "W_Ride_SA_Add", FALSE)
        SetVariable("Ride_SA_Add_Blend", 1)
        act(ApplyRideBlend, "Ride_SA_Add_Blend", 1)
    end
    return FALSE
end

function RideRequestFunction(ride_move_type, enable_turn, lower_only)
    if env(IsOnMount) == FALSE then
        act(Dismount)
        ExecEventAllBody("W_Idle")

        return TRUE
    end
    if enable_turn == TRUE then
        if GetVariable("MoveSpeedLevel") >= 0.8999999761581421 then
            SetVariable("Int16Variable01", 1)
        else
            SetVariable("Int16Variable01", 0)
        end

        local turn_angle = GetVariable("TurnAngle")

        if math.abs(turn_angle) >= 135 and RIDE_TURN_STATE == 0 then
            if turn_angle < 0 then
                FireRideEvent("W_RideTurn_Left180", "W_RideTurn_Left180", FALSE)
            else
                FireRideEvent("W_RideTurn_Right180", "W_RideTurn_Right180", FALSE)
            end
            return TRUE
        end
    end

    if ExecRideStop(ride_move_type, lower_only) == TRUE then
        if lower_only == FALSE then
            return TRUE
        else
            return FALSE
        end
    end

    local move_speed_level = GetVariable("MoveSpeedLevel")
    local move_angle = GetVariable("MoveAngle")
    local next_ride_move_type = RIDE_MOVE_TYPE_IDLE

    -- Out of Stamina: limit move speed
    if env(GetSpEffectID, 100020) == TRUE and move_speed_level > 1 then
        move_speed_level = 1
    end

    if math.abs(move_angle) <= 45 then
        -- Gallop
        if move_speed_level > 1.5 or GetVariable("IsEnableToggleDashTest") >= 1 and GetVariable("ToggleDash") == 1 and
            GetVariable("MoveSpeedLevel") >= 0.8999999761581421 then
            next_ride_move_type = RIDE_MOVE_TYPE_GALLOP
            -- Dash
        elseif move_speed_level > 0.6000000238418579 then
            next_ride_move_type = RIDE_MOVE_TYPE_DASH
            -- Idle
        elseif move_speed_level > 0 then
            next_ride_move_type = RIDE_MOVE_TYPE_WALK
        else
            next_ride_move_type = RIDE_MOVE_TYPE_IDLE
        end
    end

    if ride_move_type ~= next_ride_move_type or env(GetMountSpEffectID, 101008) == TRUE then
        if next_ride_move_type == RIDE_MOVE_TYPE_IDLE then
            if GetVariable("IsEnableToggleDashTest") == 4 then
                SetVariable("ToggleDash", 0)
            end

            if env(GetMountSpEffectID, 101005) == FALSE and env(GetMountSpEffectID, 101006) == FALSE and
                env(GetMountSpEffectID, 101007) == FALSE then
                FireRideEvent("W_RideIdle", "W_RideIdle", lower_only)
            else
                return FALSE
            end
        elseif next_ride_move_type == RIDE_MOVE_TYPE_WALK then
            if GetVariable("IsEnableToggleDashTest") == 4 then
                SetVariable("ToggleDash", 0)
            end
            FireRideEvent("W_RideWalk", "W_RideWalk", lower_only)
        elseif next_ride_move_type == RIDE_MOVE_TYPE_DASH then
            if env(GetSpEffectID, 100901) == TRUE and
                (ride_move_type == RIDE_MOVE_TYPE_IDLE or ride_move_type == RIDE_MOVE_TYPE_OTHER) and lower_only == TRUE then
                FireRideEvent("W_RideDash", "W_RideRun", lower_only)
            else
                FireRideEvent("W_RideDash", "W_RideDash", lower_only)
            end
        elseif env(GetSpEffectID, 100901) == TRUE and
            (ride_move_type == RIDE_MOVE_TYPE_IDLE or ride_move_type == RIDE_MOVE_TYPE_OTHER) and lower_only == TRUE then
            FireRideEvent("W_RideDash", "W_RideRun", lower_only)
        else
            FireRideEvent("W_RideGallop", "W_RideGallop", lower_only)
        end

        if lower_only == FALSE then
            return TRUE
        end
    end
    return FALSE
end

function ExecRideStop(ride_move_type, lower_only)
    local move_speed_level = GetVariable("MoveSpeedLevel")

    if move_speed_level > 0 then
        return FALSE
    end
    if env(GetMountSpEffectID, 101005) == TRUE or env(GetMountSpEffectID, 101006) == TRUE or
        env(GetMountSpEffectID, 101007) == TRUE then
        return FALSE
    end

    local stop_speed_type = ride_move_type

    if ride_move_type == RIDE_MOVE_TYPE_IDLE or ride_move_type == RIDE_MOVE_TYPE_OTHER then
        if env(GetMountSpEffectID, 101000) == TRUE then
            stop_speed_type = RIDE_MOVE_TYPE_WALK
        elseif env(GetMountSpEffectID, 101001) == TRUE then
            stop_speed_type = RIDE_MOVE_TYPE_DASH
        elseif env(GetMountSpEffectID, 101002) == TRUE then
            stop_speed_type = RIDE_MOVE_TYPE_GALLOP
        end
    end

    if stop_speed_type == RIDE_MOVE_TYPE_IDLE or stop_speed_type == RIDE_MOVE_TYPE_OTHER then
        return FALSE
    end
    if stop_speed_type == RIDE_MOVE_TYPE_WALK then
        FireRideEvent("W_RideWalk_End", "W_RideWalk_End", lower_only)
    elseif stop_speed_type == RIDE_MOVE_TYPE_DASH then
        FireRideEvent("W_RideDash_End", "W_RideDash_End", lower_only)
    else
        FireRideEvent("W_RideGallop_End", "W_RideGallop_End", lower_only)
    end
    return TRUE
end

function ExecRideDashAccelerate()
    if env(GetStamina) <= 0 or env(GetSpEffectID, 100020) == TRUE then
        ResetRequest()
        return FALSE
    end

    local testControl = 3

    if testControl == 2 or testControl == 12 then
        SetVariable("IsEnableToggleDashTest", 0)

        if env(ActionRequest, ACTION_ARM_ROLLING) == TRUE and env(GetStamina) <= 0 then
            ResetRequest()
        end

        local evasionRequest = GetEvasionRequest()
        if evasionRequest == ATTACK_REQUEST_ROLLING then
            if env(GetSpEffectID, 102360) == FALSE then
                act(ChangeStamina, STAMINA_REDUCE_RIDE_DASH)
            end
            if IsNodeActive("RideDashAccelerate CMSG") == TRUE or IsNodeActive("RideDashAccelerateContinue CMSG") ==
                TRUE then
                FireRideEvent("W_RideDashAccelerateContinue", "W_RideDashAccelerateContinue", FALSE)
            else
                FireRideEvent("W_RideDashAccelerate", "W_RideDashAccelerate", FALSE)
            end
            return TRUE
        end
    elseif testControl == 3 or testControl == 13 then
        SetVariable("IsEnableToggleDashTest", 4)
        local evasionRequest = env(ActionRequest, ACTION_ARM_SP_MOVE)

        if evasionRequest == TRUE and env(GetStamina) <= 0 then
            ResetRequest()
        end
        if env(GetSpEffectID, 100903) == TRUE then
            return FALSE
        end
        -- "O" Pressed
        if evasionRequest == TRUE then
            if env(GetSpEffectID, 102360) == FALSE then
                act(ChangeStamina, STAMINA_REDUCE_RIDE_DASH)
            end

            SetVariable("ToggleDash", 1)

            if IsNodeActive("RideDashAccelerate CMSG") == TRUE or IsNodeActive("RideDashAccelerateContinue CMSG") ==
                TRUE then
                FireRideEvent("W_RideDashAccelerateContinue", "W_RideDashAccelerateContinue", FALSE)
            else
                FireRideEvent("W_RideDashAccelerate", "W_RideDashAccelerate", FALSE)
            end
            return TRUE
        end
    else
        SetVariable("IsEnableToggleDashTest", 0)
        if RideDashAccelerateTest == 0 and env(ActionDuration, ACTION_ARM_SP_MOVE) > 0 then
            act(DebugLogOutput, "RideDashAccel")
        end

        local evasionRequest = env(ActionDuration, ACTION_ARM_SP_MOVE)

        if (env(IsStayState) == TRUE or env(IsGeneralAnimCancelPossible) == TRUE) and evasionRequest > 0 and 0 >=
            RideDashAccelerateTest and env(GetStamina) > 0 then
            if env(GetSpEffectID, 102360) == FALSE then
                act(ChangeStamina, STAMINA_REDUCE_RIDE_DASH)
            end
            if IsNodeActive("RideDashAccelerate CMSG") == TRUE or IsNodeActive("RideDashAccelerateContinue CMSG") ==
                TRUE then
                FireRideEvent("W_RideDashAccelerateContinue", "W_RideDashAccelerateContinue", FALSE)
            else
                FireRideEvent("W_RideDashAccelerate", "W_RideDashAccelerate", FALSE)
            end
            return TRUE
        end

        RideDashAccelerateTest = env(ActionDuration, ACTION_ARM_SP_MOVE)

        if IsNodeActive("RideDashAccelerate CMSG") == FALSE and IsNodeActive("RideDashAccelerateContinue CMSG") == FALSE then
            if env(ActionRequest, ACTION_ARM_ROLLING) == TRUE and env(GetStamina) <= 0 then
                ResetRequest()
            end

            local evasionRequest = GetEvasionRequest()

            if evasionRequest == ATTACK_REQUEST_ROLLING and env(GetStamina) > 0 then
                if env(GetSpEffectID, 102360) == FALSE then
                    act(ChangeStamina, STAMINA_REDUCE_RIDE_DASH)
                end

                if IsNodeActive("RideDashAccelerate CMSG") == TRUE or IsNodeActive("RideDashAccelerateContinue CMSG") ==
                    TRUE then
                    FireRideEvent("W_RideDashAccelerateContinue", "W_RideDashAccelerateContinue", FALSE)
                else
                    FireRideEvent("W_RideDashAccelerate", "W_RideDashAccelerate", FALSE)
                end
                return TRUE
            end
        end
    end
    return FALSE
end

----------------------
-- Common functions --
----------------------

function RideCommonFunction(r1, r2, l1, l2)
    Ride_HeadDown_Rate = EaseInOutVal(g_TimeActEditor_07, Ride_HeadDown_Rate, 0.800000011920929, 1.5,
        "EaseInOutStartVal1", "EaseInOutTargetVal1", "EaseInOutTimer1")
    act(ApplyRideBlend, "AddBlend02", Ride_HeadDown_Rate)

    if RideReActionFunction() == TRUE then
        return TRUE
    end
    if ExecRideDashAccelerate() == TRUE then
        return TRUE
    end
    if ExecRideWeaponChange() == TRUE then
        return TRUE
    end
    if ExecRideOff(FALSE, FALSE) == TRUE then
        return TRUE
    end

    local attackHand = HAND_RIGHT

    if c_Style == HAND_LEFT_BOTH then
        attackHand = HAND_LEFT
    end

    local isShield = GetEquipType(attackHand, WEAPON_CATEGORY_LARGE_SHIELD, WEAPON_CATEGORY_SMALL_SHIELD,
        WEAPON_CATEGORY_MIDDLE_SHIELD)

    if env(ActionRequest, 6) == TRUE and
        (env(GetGeneralTAEFlag, TAE_FLAG_CHARGING) ~= 1 and env(GetSpEffectID, 100280) == FALSE or isShield == TRUE) then
        if env(GetStamina) <= 0 then
            ResetRequest()
        else
            local highJumpHeight = env(GetSpiritspringJumpHeight)

            -- Normal Spiritspring Jump
            if highJumpHeight > 0 then
                act(DebugLogOutput, "RideJumpHigh Height=" .. highJumpHeight .. "cm")
                Ride_HighJump_Height = highJumpHeight + 700
                FireRideEvent("W_RideJumpHigh", "W_RideJumpHigh", FALSE)
                return TRUE
            end

            -- Normal Jump
            if env(GetSpEffectID, 102360) == FALSE then
                act(ChangeStamina, STAMINA_REDUCE_RIDE_JUMP)
            end

            if 1.5 <= GetVariable("MoveSpeedLevel") then
                FireRideEvent("W_RideJump_D", "W_RideJump_D", FALSE)
            elseif GetVariable("MoveSpeedLevel") >= 0.6000000238418579 then
                FireRideEvent("W_RideJump_F", "W_RideJump_F", FALSE)
            else
                FireRideEvent("W_RideJump_N", "W_RideJump_N", FALSE)
            end
            return TRUE
        end
    end

    if ExecRideHandChange(HAND_RIGHT, FALSE) == TRUE then
        return TRUE
    end
    if ExecRideMagic() == TRUE then
        return TRUE
    end
    if ExecRideAttack(r1, r2, l1, l2) == TRUE then
        return TRUE
    end
    if ExecRideItem() == TRUE then
        return TRUE
    end
    if ExecRideGesture() == TRUE then
        return TRUE
    end
    return FALSE
end

function RideFallCommonFunction()
    local damage_type = env(GetReceivedDamageType)

    if damage_type == DAMAGE_TYPE_DEATH_FALLING and env(GetSpEffectID, 185) == FALSE then
        FireRideEvent("W_RideDeath", "W_RideDeath", FALSE)
        return TRUE
    end
    if env(ActionRequest, 6) == TRUE and env(GetSpEffectID, 100902) == TRUE and RIDE_ISENABLE_DOUBLEJUMP == TRUE then
        local height = env(GetMountFallHeight) / 100
        if env(GetStamina) <= 0 or height > DISABLEJUMP_FALLDIST then
            ResetRequest()
        else
            if env(GetSpEffectID, 102360) == FALSE then
                act(ChangeStamina, STAMINA_REDUCE_RIDE_JUMP)
            end

            if GetVariable("MoveSpeedLevel") >= 1.5 then
                FireRideEvent("W_RideJump2_D", "W_RideJump2_D", FALSE)
            elseif GetVariable("MoveSpeedLevel") >= 0.6000000238418579 then
                FireRideEvent("W_RideJump2_F", "W_RideJump2_F", FALSE)
            else
                FireRideEvent("W_RideJump2_N", "W_RideJump2_N", FALSE)
            end
        end

        RIDE_ISENABLE_DOUBLEJUMP = FALSE
        return TRUE
    end
    return FALSE
end

--------------
-- Triggers --
--------------

function RideAdjust_onUpdate()
    act(SetAllowedThrowDefenseType, 255)

    if env(IsMovingOnMount) == TRUE then
        FireRideEvent("W_RideOn", "W_RideOn", FALSE)
        return TRUE
    elseif env(IsIdleOnMount) == TRUE then
        ExecEventAllBody("W_Idle")
        return TRUE
    end
end

function RideAdjustFromCalling_onUpdate()
    act(SetAllowedThrowDefenseType, 255)

    if env(IsMovingOnMount) == TRUE then
        if GetVariable("RideOnSummonTest") == 1 then
            FireRideEvent("W_RideOn", "W_RideOn", FALSE)
        else
            ExecEventAllBody("W_RideOn")
        end
        return TRUE
    elseif env(IsIdleOnMount) == TRUE then
        ExecEventAllBody("W_Idle")
        return TRUE
    end
end

function RideOn_onUpdate()
    act(ApplyRideBlend, "AddBlend02", 0)
    Ride_HeadDown_Rate = 0
    act(SetAllowedThrowDefenseType, 255)
    SetAIActionState()
    SetVariable("Int16Variable01", 0)
    local lower_only = TRUE

    if env(IsMoveCancelPossible) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
    elseif env(GetEventEzStateFlag, 0) ~= TRUE then
        return
    end

    local move_speed_level = GetVariable("MoveSpeedLevel")
    local move_angle = GetVariable("MoveAngle")
    local next_ride_move_type = RIDE_MOVE_TYPE_IDLE

    if math.abs(move_angle) <= 45 then
        if move_speed_level > 1.5 or GetVariable("IsEnableToggleDashTest") >= 1 and GetVariable("ToggleDash") == 1 and
            GetVariable("MoveSpeedLevel") >= 0.8999999761581421 then
            next_ride_move_type = RIDE_MOVE_TYPE_GALLOP
        elseif move_speed_level > 0.6000000238418579 then
            next_ride_move_type = RIDE_MOVE_TYPE_DASH
        elseif move_speed_level > 0 then
            next_ride_move_type = RIDE_MOVE_TYPE_WALK
        else
            next_ride_move_type = RIDE_MOVE_TYPE_IDLE
        end
    end

    if next_ride_move_type == RIDE_MOVE_TYPE_IDLE then
        if lower_only == FALSE then
            FireRideEvent("W_RideIdle", "W_RideIdle", lower_only)
        end
    elseif next_ride_move_type == RIDE_MOVE_TYPE_WALK then
        FireRideEvent("W_RideWalk", "W_RideWalk", lower_only)
    elseif next_ride_move_type == RIDE_MOVE_TYPE_DASH then
        FireRideEvent("W_RideDash", "W_RideDash", lower_only)
    else
        FireRideEvent("W_RideGallop", "W_RideGallop", lower_only)
    end
end

function RideOff_onUpdate()
    act(SetAllowedThrowDefenseType, 0)
    act(SetAllowedThrowAttackType, 1)
    SetAIActionState()
    SetVariable("Int16Variable01", 0)

    if EvasionCommonFunction(FALL_TYPE_DEFAULT, "W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", QUICKTYPE_NORMAL) == TRUE then
        act(Dismount)
        return
    end
    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        act(Dismount)
        ExecEventAllBody("W_Idle")
        return TRUE
    end
end

function RideIdle_onActivate()
    act(Wait)
end

function RideIdle_onUpdate()
    act(Wait)
    SetVariable("Int16Variable01", 0)
    SetEnableAimMode()

    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end
    if RideRequestFunction(RIDE_MOVE_TYPE_IDLE, TRUE, FALSE) == TRUE then
        return
    end
    if GetVariable("IsEnableToggleDashTest") >= 1 then
        SetVariable("ToggleDash", 0)
    end
end

function RideWalk_onUpdate()
    act(Wait)
    SetEnableAimMode()

    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end
    if RideRequestFunction(RIDE_MOVE_TYPE_WALK, TRUE, FALSE) == TRUE then
        return
    end
    if GetVariable("IsEnableToggleDashTest") >= 1 then
        SetVariable("ToggleDash", 0)
    end
end

function RideWalk_End_onUpdate()
    act(Wait)
    SetEnableAimMode()

    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end
    if env(IsAnimEnd, 0) == TRUE then
        FireRideEvent("W_RideIdle", "W_RideIdle", FALSE)
    end

    if RideRequestFunction(RIDE_MOVE_TYPE_IDLE, TRUE, FALSE) == TRUE then
        return
    end
end

function RideOnDash_onUpdate()
    act(SetAllowedThrowDefenseType, 255)
    SetAIActionState()
    SetVariable("Int16Variable01", 0)
    local lower_only = TRUE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
    elseif env(GetEventEzStateFlag, 0) ~= TRUE then
        return
    end

    local move_speed_level = GetVariable("MoveSpeedLevel")
    local move_angle = GetVariable("MoveAngle")
    local next_ride_move_type = RIDE_MOVE_TYPE_IDLE

    if math.abs(move_angle) <= 45 then
        if move_speed_level > 1.5 or GetVariable("IsEnableToggleDashTest") >= 1 and GetVariable("ToggleDash") == 1 and
            GetVariable("MoveSpeedLevel") >= 0.8999999761581421 then
            next_ride_move_type = RIDE_MOVE_TYPE_GALLOP
        elseif move_speed_level > 0.6000000238418579 then
            next_ride_move_type = RIDE_MOVE_TYPE_DASH
        elseif move_speed_level > 0 then
            next_ride_move_type = RIDE_MOVE_TYPE_WALK
        else
            next_ride_move_type = RIDE_MOVE_TYPE_IDLE
        end
    end

    if next_ride_move_type == RIDE_MOVE_TYPE_IDLE then
        if lower_only == FALSE then
            FireRideEvent("W_RideIdle", "W_RideIdle", lower_only)
        end
    elseif next_ride_move_type == RIDE_MOVE_TYPE_WALK then
        FireRideEvent("W_RideWalk", "W_RideWalk", lower_only)
    elseif next_ride_move_type == RIDE_MOVE_TYPE_DASH then
        FireRideEvent("W_RideDash", "W_RideDash", lower_only)
    else
        FireRideEvent("W_RideGallop", "W_RideGallop", lower_only)
    end
end

function RideDash_onUpdate()
    act(Wait)
    SetEnableAimMode()

    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end
    if RideRequestFunction(RIDE_MOVE_TYPE_DASH, TRUE, FALSE) == TRUE then
        return
    end
    if GetVariable("IsEnableToggleDashTest") >= 1 then
        SetVariable("ToggleDash", 0)
    end
end

-- Initial Movement after "O" Press (approx 6 seconds)
function RideDashAccelerate_onUpdate()
    act(Wait)
    SetEnableAimMode()

    if env(GetStamina) <= 0 then
        act(AddSpEffect, 100020)
    end

    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end
    if ExecRideStop(RIDE_MOVE_TYPE_OTHER, FALSE) == TRUE then
        return
    end
    if (env(IsMoveCancelPossible) == TRUE or env(IsAnimEnd, 0) == TRUE) and
        RideRequestFunction(RIDE_MOVE_TYPE_OTHER, TRUE, FALSE) == TRUE then
        return
    end
end

-- Initial Movement after secondary "O" Press during Dash (approx 6 seconds)
function RideDashAccelerateContinue_onUpdate()
    act(Wait)
    SetEnableAimMode()

    if env(GetStamina) <= 0 then
        act(AddSpEffect, 100020)
    end

    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end
    if ExecRideStop(RIDE_MOVE_TYPE_OTHER, FALSE) == TRUE then
        return
    end
    if (env(IsMoveCancelPossible) == TRUE or env(IsAnimEnd, 0) == TRUE) and
        RideRequestFunction(RIDE_MOVE_TYPE_OTHER, TRUE, FALSE) == TRUE then
        return
    end
end

function RideMoveStaminaConsume()
    if env(IsOnMount) == FALSE then
        return
    end
    if env(GetStamina) <= 0 then
        act(AddSpEffect, 100020)
    end

    -- Gallop
    if env(GetMountSpEffectID, 101002) == TRUE then
        act(SetStaminaRecoveryDisabled)
        local dT = GetDeltaTime()
        dash_dt_sum = dash_dt_sum + dT

        if dash_dt_sum > 0.06499999761581421 then
            dash_dt_sum = 0
            if env(GetSpEffectID, 102360) == FALSE then
                act(ChangeStamina, -1)
            end
        end
    end
end

function RideDash_End_onUpdate()
    act(Wait)
    SetEnableAimMode()

    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end
    if env(IsAnimEnd, 0) == TRUE then
        FireRideEvent("W_RideIdle", "W_RideIdle", FALSE)
    end

    if RideRequestFunction(RIDE_MOVE_TYPE_IDLE, TRUE, FALSE) == TRUE then
        return
    end
end

-- Sustained Movement after "O" Press
function RideGallop_onUpdate()
    act(Wait)
    SetEnableAimMode()
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end
    if RideRequestFunction(RIDE_MOVE_TYPE_GALLOP, TRUE, FALSE) == TRUE then
        return
    end
    if GetVariable("IsEnableToggleDashTest") >= 1 then
    end
end

function RideGallop_End_onUpdate()
    act(Wait)
    SetEnableAimMode()

    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end
    if env(IsAnimEnd, 0) == TRUE then
        FireRideEvent("W_RideIdle", "W_RideIdle", FALSE)
    end

    if RideRequestFunction(RIDE_MOVE_TYPE_IDLE, TRUE, FALSE) == TRUE then
        return
    end
end

function Ride_SA_Add_Default_onUpdate()
    SetVariable("Ride_SA_Add_Blend", 0)
    act(ApplyRideBlend, "BlendRidden_SA_Add", 0)
end

function RideDeath_Idle_onActivate()
    act(SetDeathStay, TRUE)
end

function RideDeath_Idle_onDeactivate()
    act(SetDeathStay, FALSE)
end

function RideTurn_Left180_onUpdate()
    RIDE_TURN_STATE = 1
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end
    if env(MovementRequest) == TRUE and GetVariable("MoveSpeedLevel") > 0 and
        RideRequestFunction(RIDE_MOVE_TYPE_OTHER, TRUE, FALSE) == TRUE then
        return
    end
    if env(IsAnimEnd, 0) == TRUE then
        FireRideEvent("W_RideIdle", "W_RideIdle", FALSE)
        return
    end
end

function RideTurn_Left180_onDeactivate()
    RIDE_TURN_STATE = 0
end

function RideTurn_Right180_onUpdate()
    RIDE_TURN_STATE = 1
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end
    if env(MovementRequest) == TRUE and GetVariable("MoveSpeedLevel") > 0 and
        RideRequestFunction(RIDE_MOVE_TYPE_OTHER, TRUE, FALSE) == TRUE then
        return
    end
    if env(IsAnimEnd, 0) == TRUE then
        FireRideEvent("W_RideIdle", "W_RideIdle", FALSE)
        return
    end
end

function RideTurn_Right180_onDeactivate()
    RIDE_TURN_STATE = 0
end

function RideTurn_Left90_onUpdate()
    RIDE_TURN_STATE = 1
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end
    if env(MovementRequest) == TRUE and RideRequestFunction(RIDE_MOVE_TYPE_OTHER, TRUE, FALSE) == TRUE then
        return
    end
    if env(IsAnimEnd, 0) == TRUE then
        FireRideEvent("W_RideIdle", "W_RideIdle", FALSE)
        return
    end
end

function RideTurn_Left90_onDeactivate()
    RIDE_TURN_STATE = 0
end

function RideTurn_Right90_onUpdate()
    RIDE_TURN_STATE = 1
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end
    if env(MovementRequest) == TRUE and RideRequestFunction(RIDE_MOVE_TYPE_OTHER, TRUE, FALSE) == TRUE then
        return
    end
    if env(IsAnimEnd, 0) == TRUE then
        FireRideEvent("W_RideIdle", "W_RideIdle", FALSE)
        return
    end
end

function RideFall_Start_onUpdate()
    if RideFallCommonFunction() == TRUE then
        return
    end
    if env(IsMountInFallLoop) == TRUE then
        local height = env(GetMountFallHeight)
        if IsLandDead(height / 100) == TRUE then
            FireRideEvent("W_RideDeath", "W_RideDeath", FALSE)
            return
        end
        if height < 900 and height >= 200 then
            if GetVariable("MoveSpeedLevel") > 1.5 then
                FireRideEvent("W_RideJump_Land_To_Gallop", "W_RideJump_Land_To_Gallop", lower_only)
                return
            elseif GetVariable("MoveSpeedLevel") > 0.6000000238418579 then
                FireRideEvent("W_RideJump_Land_To_Dash", "W_RideJump_Land_To_Dash", lower_only)
                return
            else
                FireRideEvent("W_RideFall_Land", "W_RideFall_Land", FALSE)
                return
            end
        elseif height >= 200 then
            FireRideEvent("W_RideFall_Land", "W_RideFall_Land", FALSE)
            return
        elseif GetVariable("MoveSpeedLevel") > 1.5 or GetVariable("IsEnableToggleDashTest") >= 1 and
            GetVariable("ToggleDash") == 1 and GetVariable("MoveSpeedLevel") >= 0.8999999761581421 then
            FireRideEvent("W_RideGallop", "W_RideGallop", FALSE)
            return
        elseif GetVariable("MoveSpeedLevel") >= 0.6000000238418579 then
            FireRideEvent("W_RideDash", "W_RideDash", FALSE)
            return
        elseif GetVariable("MoveSpeedLevel") > 0 then
            FireRideEvent("W_RideWalk", "W_RideWalk", FALSE)
            return
        else
            FireRideEvent("W_RideIdle", "W_RideIdle", FALSE)
            return
        end
    end
    if env(IsAnimEnd, 0) == TRUE then
        FireRideEvent("W_RideFall_Loop", "W_RideFall_Loop", FALSE)
        return
    end
end

function RideFall_Loop_onUpdate()
    if RideFallCommonFunction() == TRUE then
        return
    end
    if env(GetSpiritspringJumpHeight) > 0 or env(GetSpEffectID, 183) == TRUE then
        act(AddSpEffect, 186)
    end

    if env(GetSpEffectID, 19935) == TRUE then
        if env(IsHamariFallDeath, 20) == TRUE and env(GetSpEffectID, 185) == FALSE then
            FireRideEvent("W_RideDeath", "W_RideDeath", FALSE)
            return
        end
    elseif env(IsHamariFallDeath, 12) == TRUE and env(GetSpEffectID, 185) == FALSE then
        FireRideEvent("W_RideDeath", "W_RideDeath", FALSE)
        return
    end
    if env(IsMountInFallLoop) == TRUE then
        local height = env(GetMountFallHeight)
        if IsLandDead(height / 100) == TRUE and env(GetSpEffectID, 185) == FALSE then
            FireRideEvent("W_RideDeath", "W_RideDeath", FALSE)
            return
        end
        if height < 900 then
            if GetVariable("MoveSpeedLevel") > 1.5 then
                FireRideEvent("W_RideJump_Land_To_Gallop", "W_RideJump_Land_To_Gallop", lower_only)
                return
            elseif GetVariable("MoveSpeedLevel") > 0.6000000238418579 then
                FireRideEvent("W_RideJump_Land_To_Dash", "W_RideJump_Land_To_Dash", lower_only)
                return
            end
        end
        FireRideEvent("W_RideFall_Land", "W_RideFall_Land", FALSE)
        return
    end
end

function RideFall_Land_onUpdate()
    if RideFallCommonFunction() == TRUE then
        return
    end
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end
    if env(IsMoveCancelPossible) == TRUE or env(IsAnimEnd, 0) == TRUE then
        local moveType = RIDE_MOVE_TYPE_IDLE
        if env(IsAnimEnd, 0) == TRUE then
            moveType = RIDE_MOVE_TYPE_OTHER
        end
        if RideRequestFunction(moveType, TRUE, FALSE) == TRUE then
            return
        end
    end
end

function RideTurn_Right90_onDeactivate()
    RIDE_TURN_STATE = 0
end
