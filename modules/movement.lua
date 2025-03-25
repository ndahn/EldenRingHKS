
function GetMoveSpeed(stick_level)
    local speed = GetVariable("MoveSpeedLevelReal")
    local inc_val = ACCELERATION_WALK_SPEED_UP
    local dec_val = ACCELERATION_SPEED_DOWN
    if stick_level == 2 then
        inc_val = ACCELERATION_DASH_SPEED_UP
        dec_val = ACCELERATION_DASH_SPEED_DOWN
    end
    local ret = ConvergeValue(stick_level, speed, inc_val, dec_val)
    return ret
end

function SetTurnSpeed(turn_speed)
    act(SetTurnSpeed, turn_speed)
end

function SetWeightIndex()
    local weight = math.mod(env(GetMoveAnimParamID), 20)

    if weight == WEIGHT_LIGHT then
        SetVariable("MoveWeightIndex", MOVE_WEIGHT_LIGHT)
        SetVariable("EvasionWeightIndex", EVASION_WEIGHT_INDEX_LIGHT)
    elseif weight == WEIGHT_NORMAL then
        SetVariable("MoveWeightIndex", MOVE_WEIGHT_NORMAL)
        SetVariable("EvasionWeightIndex", EVASION_WEIGHT_INDEX_MEDIUM)
    elseif weight == WEIGHT_HEAVY then
        SetVariable("MoveWeightIndex", MOVE_WEIGHT_HEAVY)
        SetVariable("EvasionWeightIndex", EVASION_WEIGHT_INDEX_HEAVY)
    elseif weight == WEIGHT_OVERWEIGHT then
        SetVariable("MoveWeightIndex", MOVE_WEIGHT_HEAVY)
        SetVariable("EvasionWeightIndex", EVASION_WEIGHT_INDEX_OVERWEIGHT)
    elseif weight == WEIGHT_SUPERLIGHT then
        SetVariable("MoveWeightIndex", MOVE_WEIGHT_SUPERLIGHT)
        SetVariable("EvasionWeightIndex", EVASION_WEIGHT_INDEX_SUPERLIGHT)
    else
        SetVariable("MoveWeightIndex", 0)
    end

    if env(GetSpEffectID, 503520) == TRUE and weight ~= WEIGHT_OVERWEIGHT then
        SetVariable("MoveWeightIndex", MOVE_WEIGHT_HEAVY)
        SetVariable("EvasionWeightIndex", EVASION_WEIGHT_INDEX_HEAVY)
    elseif env(GetSpEffectID, 5520) == TRUE and weight ~= WEIGHT_OVERWEIGHT then
        SetVariable("MoveWeightIndex", MOVE_WEIGHT_HEAVY)
        SetVariable("EvasionWeightIndex", EVASION_WEIGHT_INDEX_HEAVY)
    elseif env(GetSpEffectID, 425) == TRUE and weight ~= WEIGHT_OVERWEIGHT then
        SetVariable("MoveWeightIndex", MOVE_WEIGHT_HEAVY)
        SetVariable("EvasionWeightIndex", EVASION_WEIGHT_INDEX_HEAVY)
    elseif env(GetSpEffectID, 4101) == TRUE and weight ~= WEIGHT_OVERWEIGHT then
        SetVariable("MoveWeightIndex", MOVE_WEIGHT_HEAVY)
        SetVariable("EvasionWeightIndex", EVASION_WEIGHT_INDEX_HEAVY)
    elseif env(GetSpEffectID, 4100) == TRUE and weight ~= WEIGHT_OVERWEIGHT then
        SetVariable("MoveWeightIndex", MOVE_WEIGHT_HEAVY)
    elseif env(GetSpEffectID, 19670) == TRUE and weight ~= WEIGHT_OVERWEIGHT then
        SetVariable("MoveWeightIndex", MOVE_WEIGHT_HEAVY)
        SetVariable("EvasionWeightIndex", EVASION_WEIGHT_INDEX_HEAVY)
    end
end

function GetLocomotionState()
    local state = GetVariable("LowerDefaultState00")

    if state == MOVE_DEF0 or state == STEALTHMOVE_DEF0 then
        if env(GetSpEffectID, 100000) == TRUE then
            return PLAYER_STATE_MOVE
        elseif env(GetSpEffectID, 100001) == TRUE then
            return PLAYER_STATE_MOVE
        elseif env(GetSpEffectID, 100002) == TRUE then
            return PLAYER_STATE_MOVE
        end
    end
    return PLAYER_STATE_IDLE
end

function SpeedUpdate()
    local stick_level = GetVariable("MoveSpeedLevel")
    local move_angle = GetVariable("MoveAngle")
    local is_aim = env(IsPrecisionShoot)
    local is_lockon = GetVariable("IsLockon")

    if is_aim == TRUE then
        if stick_level > 1 then
            stick_level = 1
        end
    elseif env(GetSpEffectID, 100020) == TRUE and stick_level > 1 then
        stick_level = 1
    end

    local speed = GetMoveSpeed(stick_level)
    SetVariable("MoveSpeedLevelReal", speed)

    if env(GetStamina) <= 0 then
        act(AddSpEffect, 100020)
    end

    local weight = math.mod(env(GetMoveAnimParamID), 20)

    if is_aim == TRUE then
        ChangeMoveSpeedIndex(0)
    elseif weight == WEIGHT_OVERWEIGHT then
        ChangeMoveSpeedIndex(0)
    elseif env(GetSpEffectID, 503520) == TRUE then
        ChangeMoveSpeedIndex(0)
    elseif env(GetSpEffectID, 4101) == TRUE then -- Duplicate Condition #1
        ChangeMoveSpeedIndex(0)
    elseif g_IsMimicry == TRUE then
        if stick_level > 1.100000023841858 then
            ResetMimicry()
        else
            ChangeMoveSpeedIndex(0)
        end
    elseif env(GetSpEffectID, 4101) == TRUE then -- Duplicate Condition #2
        if stick_level > 1.100000023841858 then
            ChangeMoveSpeedIndex(1)
        end
    elseif env(GetSpEffectID, 425) == TRUE or env(GetSpEffectID, 19670) == TRUE then
        if stick_level > 1.100000023841858 then
            ChangeMoveSpeedIndex(1)
        end
    elseif env(GetSpEffectID, 100220) == TRUE then
        ChangeMoveSpeedIndex(2)
    else
        local runLevel = 0.6000000238418579

        if GetVariable("IsEnableToggleDashTest") >= 1 and GetVariable("MoveSpeedIndex") >= 1 then
            runLevel = 0.4000000059604645
        end

        -- Sprint (stick + O)
        if stick_level > 1.100000023841858 then
            if env(GetSpEffectID, 100020) == TRUE then
                ChangeMoveSpeedIndex(1)
                SetVariable("ToggleDash", 0)
            else
                act(LockonFixedAngleCancel)
                ChangeMoveSpeedIndex(2)
            end
            -- Normal Walk (stick)
        elseif runLevel < stick_level then
            ChangeMoveSpeedIndex(1)
            if env(GetSpEffectID, 100002) == FALSE and
                (GetVariable("IsEnableToggleDashTest") >= 2 or env(GetSpEffectID, 100301) == FALSE) then
                SetVariable("ToggleDash", 0)
            end
            -- Stop
        else
            ChangeMoveSpeedIndex(0)
            if env(GetSpEffectID, 100002) == FALSE and
                (GetVariable("IsEnableToggleDashTest") >= 2 or env(GetSpEffectID, 100301) == FALSE) then
                SetVariable("ToggleDash", 0)
            end
        end
    end

    if env(GetSpEffectID, 100002) == TRUE then
        act(SetStaminaRecoveryDisabled)
    end
end

function ChangeMoveSpeedIndex(index)
    SetVariable("MoveSpeedIndex", index)
    if index >= 2 then
        SetVariable("MoveSpeedIndexBLR", 1)
    else
        SetVariable("MoveSpeedIndexBLR", index)
    end
end

function StealthTransitionIndexUpdate()
    local move_speed_level = GetVariable("MoveSpeedLevel")
    local MoveIndex = GetVariable("MoveSpeedIndex")
    if MoveIndex == 2 then
        SetVariable("StealthTransitionIndex", 3)
    elseif MoveIndex == 1 then
        SetVariable("StealthTransitionIndex", 2)
    elseif move_speed_level > 0 then
        SetVariable("StealthTransitionIndex", 1)
    else
        SetVariable("StealthTransitionIndex", 0)
    end
end

function IsLowerQuickTurn()
    if GetVariable("LowerDefaultState00") == QUICKTURN_DEF0 and env(GetSpEffectID, 100010) == TRUE then
        return TRUE
    end
    return FALSE
end

function IsLowerBackStep()
    if GetVariable("LowerDefaultState00") == BACKSTEP_DEF0 then
        return TRUE
    end
    return FALSE
end

function MoveStart(blend_type, event, gen_hand)
    -- 100200 "[HKS] Gesture Anim"

    if GetVariable("MoveSpeedLevel") <= 0 then
        return FALSE
    end

    if env(GetSpEffectID, 100200) == TRUE then
        return FALSE
    end

    if blend_type ~= LOWER then
        if gen_hand == FALSE then
            SetVariable("ArtsTransition", 0)
        else
            SetArtsGeneratorTransitionIndex()
        end
    end

    SetBonfireIndex()

    local stealth_state = GetVariable("StealthState")

    if (stealth_state == STEALTH_TO_STEALTHIDLE or stealth_state == STEALTH_TO_IDLE) and
        GetVariable("StealthTransitionIndex") > 0 then
        ExecEventHalfBlendNoReset(event, blend_type)
        return TRUE
    end

    if GetLocomotionState() ~= PLAYER_STATE_MOVE then
        SetVariable("MoveSpeedLevelReal", 0)
        SpeedUpdate()
    end

    ExecEventHalfBlend(event, blend_type)

    return TRUE
end

function MoveStartonCancelTiming(event, gen_hand)
    if env(IsMoveCancelPossible) == TRUE then
        if GetLocomotionState() == PLAYER_STATE_MOVE then
            if MoveStart(UPPER, event, gen_hand) == TRUE then
                return TRUE
            end
        elseif MoveStart(ALLBODY, event, gen_hand) == TRUE then
            return TRUE
        end
    end
    return FALSE
end

function SetMoveType()
    -- 100130 "[HKS] Stance - SetMoveType 1"
    -- 100140 "[HKS] Stance - SetMoveType 2"
    -- 100150 "[HKS] Stance - SetMoveType 0"
    -- 100160 "[HKS] Stance - SetMoveType 3"
    -- Unknown (DLC) "[HKS] Stance - SetMoveType 4"
    -- Unknown (DLC) "[HKS] Stance - SetMoveType 5"

    if env(GetSpEffectID, 100130) == TRUE then
        SetVariable("MoveType", ConvergeValue(1, hkbGetVariable("MoveType"), 5, 5))
        SetVariable("StanceMoveType", 1)
    elseif env(GetSpEffectID, 100140) == TRUE then
        SetVariable("MoveType", ConvergeValue(1, hkbGetVariable("MoveType"), 5, 5))
        SetVariable("StanceMoveType", 2)
    elseif env(GetSpEffectID, 100150) == TRUE then
        SetVariable("MoveType", ConvergeValue(1, hkbGetVariable("MoveType"), 5, 5))
        SetVariable("StanceMoveType", 0)
    elseif env(GetSpEffectID, 100160) == TRUE then
        SetVariable("MoveType", ConvergeValue(1, hkbGetVariable("MoveType"), 5, 5))
        SetVariable("StanceMoveType", 3)
    elseif env(GetSpEffectID, 19920) == TRUE then
        SetVariable("MoveType", ConvergeValue(1, hkbGetVariable("MoveType"), 5, 5))
        SetVariable("StanceMoveType", 4)
    elseif env(GetSpEffectID, 19930) == TRUE then
        SetVariable("MoveType", ConvergeValue(1, hkbGetVariable("MoveType"), 5, 5))
        SetVariable("StanceMoveType", 5)
    else
        SetVariable("MoveType", ConvergeValue(0, hkbGetVariable("MoveType"), 5, 5))
    end
end

function ExecQuickTurn(blend_type, turn_type)
    if blend_type == LOWER and IsLowerQuickTurn() == TRUE then
        return FALSE
    end
    if GetVariable("IsLockon") == false then
        return FALSE
    end

    if env(GetSpEffectID, 19946) == TRUE then
        return FALSE
    end

    local turn_angle = GetVariable("TurnAngle")
    if math.abs(turn_angle) < 45 then
        return FALSE
    end

    SetVariable("TurnType", turn_type)
    if turn_angle >= 45 then
        ExecEventHalfBlend(Event_QuickTurnRight180, blend_type)
    else
        ExecEventHalfBlend(Event_QuickTurnLeft180, blend_type)
    end
    return TRUE
end

function ExecDashTurn()
    if GetVariable("MoveSpeedLevel") <= 0 then
        return FALSE
    end

    local angle = math.abs(hkbGetVariable("TurnAngle"))
    if angle > 90 then
        ExecEventAllBody("W_Dash180")
        return TRUE
    end

    return FALSE
end

function ExitQuickTurnLower()
    if env(IsAnimEnd, 2) == TRUE or env(GetEventEzStateFlag, 1) == TRUE then
        return TRUE
    end
    if GetVariable("IsLockon") == false then
        return TRUE
    end
    return FALSE
end

function ExecQuickTurnOnCancelTiming()
    if env(IsMoveCancelPossible) == FALSE then
        return FALSE
    end
    if ExecQuickTurn(ALLBODY, TURN_TYPE_DEFAULT) == TRUE then
        return TRUE
    end
    return FALSE
end

function ExecFallStart(fall_type)
    if env(IsFalling) == FALSE then
        return FALSE
    end
    if fall_type == FALL_TYPE_DEFAULT then
        ExecEventAllBody("W_FallStart")
    elseif fall_type == FALL_TYPE_JUMP then
        if env(GetGeneralTAEFlag, 0) == TRUE then
            ExecEventAllBody("W_FallJumpStart")
        else
            ExecEventNoReset("W_FallStart")
        end
    elseif fall_type == FALL_TYPE_FACEDOWN_LOOP then
        ExecEventAllBody("W_FallLoopFaceDown")
    elseif fall_type == FALL_TYPE_FACEDOWN then
        ExecEventAllBody("W_FallStartFaceDown")
    elseif fall_type == FALL_TYPE_FACEUP_LOOP then
        ExecEventAllBody("W_FallLoopFaceUp")
    elseif fall_type == FALL_TYPE_FACEUP then
        ExecEventAllBody("W_FallStartFaceUp")
    else
        local damage_angle = env(GetReceivedDamageDirection)
        if damage_angle == DAMAGE_DIR_BACK then
            if fall_type == FALL_TYPE_FORCE_LOOP then
                ExecEventAllBody("W_FallLoopFaceDown")
            else
                ExecEventAllBody("W_FallStartFaceDown")
            end
        elseif fall_type == FALL_TYPE_FORCE_LOOP then
            ExecEventAllBody("W_FallLoopFaceUp")
        else
            ExecEventAllBody("W_FallStartFaceUp")
        end
    end
    return TRUE
end

function ExecMovableEventAnim()
    local eventID = env(GetEventID)
    local commandID = env(GetCommandIDFromEvent, 0)
    if eventID <= -1 and not (commandID >= 60070 and commandID <= 60071) then
        return FALSE
    end
    local event = Event_EventHalfBlend60071
    if eventID == 60071 or commandID == 60071 then
        event = Event_EventHalfBlend60071
    elseif eventID == 60070 or commandID == 60070 then
        if c_IsStealth == TRUE then
            event = Event_EventHalfBlend360070
        else
            event = Event_EventHalfBlend60071
        end
    else
        ExecEventAllBody("W_Event" .. eventID)
        return TRUE
    end
    local lower_state = ALLBODY
    local locomotion = GetVariable("LocomotionState")
    if locomotion == PLAYER_STATE_MOVE then
        lower_state = UPPER
    end
    ExecEventHalfBlend(event, lower_state)
    return TRUE
end

function ExecStop()
    -- 100200 "[HKS] Gesture Anim"

    if GetVariable("MoveSpeedLevel") > 0 and env(GetSpEffectID, 100200) == FALSE then
        return FALSE
    end

    local stop_speed = GetVariable("MoveSpeedLevelReal")
    local movedirection = GetVariable("MoveDirection")
    local stop_speed_threshold = 0.3499999940395355

    SetVariable("ToggleDash", 0)
    SetWeightIndex()

    if GetVariable("EvasionWeightIndex") == EVASION_WEIGHT_INDEX_OVERWEIGHT and stop_speed > 0.3499999940395355 then
        stop_speed = stop_speed_threshold
    end

    if stop_speed >= 0 and stop_speed <= 1 then
        if stop_speed <= stop_speed_threshold then
            if c_IsStealth == TRUE then
                ExecEventAllBody("W_Stealth_Idle")
            else
                ExecEventAllBody("W_Idle")
            end
        elseif c_IsStealth == TRUE then
            if movedirection == 0 then
                ExecEventAllBody("W_StealthRunStopFront")
            elseif movedirection == 1 then
                ExecEventAllBody("W_StealthRunStopBack")
            elseif movedirection == 2 then
                ExecEventAllBody("W_StealthRunStopLeft")
            elseif movedirection == 3 then
                ExecEventAllBody("W_StealthRunStopRight")
            end
        elseif movedirection == 0 then
            ExecEventAllBody("W_RunStopFront")
        elseif movedirection == 1 then
            ExecEventAllBody("W_RunStopBack")
        elseif movedirection == 2 then
            ExecEventAllBody("W_RunStopLeft")
        elseif movedirection == 3 then
            ExecEventAllBody("W_RunStopRight")
        end
    elseif stop_speed > 1 then
        if c_IsStealth == TRUE then
            ExecEventAllBody("W_StealthDashStop")
        else
            ExecEventAllBody("W_DashStop")
        end
    elseif c_IsStealth == TRUE then
        ExecEventAllBody("W_Stealth_Idle")
    else
        ExecEventAllBody("W_Idle")
    end
    return TRUE
end

function ExecStopHalfBlend(event, to_idle)
    -- 100200 "[HKS] Gesture Anim"

    if GetVariable("MoveSpeedLevel") > 0 and env(GetSpEffectID, 100200) == FALSE then
        return FALSE
    end

    SetVariable("LocomotionState", 0)
    if to_idle == TRUE then
        ExecEventNoReset("W_Idle")
        return TRUE
    end

    ExecEventHalfBlendNoReset(event, LOWER)
    return TRUE
end

----------------------
-- Common functions --
----------------------

function MoveCommonFunction(blend_type)
    act(Wait)
    act(AllowBuddyWarp)
    SetEnableAimMode()

    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
        return TRUE
    end
    if LadderStart() == TRUE then
        return TRUE
    end
    if ExecJump() == TRUE then
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, blend_type) == TRUE then
        return TRUE
    end
    if ExecWeaponChange(blend_type) == TRUE then
        return TRUE
    end
    if ExecEvasion(FALSE, ESTEP_NONE, FALSE) == TRUE then
        return TRUE
    end
    if ExecGuard(Event_GuardStart, blend_type) == TRUE then
        return TRUE
    end

    local speed = GetVariable("MoveSpeedIndex")

    if speed == 2 then
        if ExecItem(QUICKTYPE_DASH, blend_type) == TRUE then
            return TRUE
        end
    elseif speed == 1 then
        if ExecItem(QUICKTYPE_RUN, blend_type) == TRUE then
            return TRUE
        end
    elseif ExecItem(QUICKTYPE_NORMAL, blend_type) == TRUE then
        return TRUE
    end

    if speed == 2 then
        if ExecMagic(QUICKTYPE_DASH, blend_type, FALSE) == TRUE then
            return TRUE
        end
    elseif ExecMagic(QUICKTYPE_NORMAL, blend_type, FALSE) == TRUE then
        return TRUE
    end

    if ExecArtsStance(blend_type) == TRUE then
        return TRUE
    end
    if ExecRide() == TRUE then
        return TRUE
    end

    local r1 = "W_AttackRightLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b1 = "W_AttackBothLight1"
    local b2 = "W_AttackBothHeavy1Start"

    if speed == 2 then
        r1 = "W_AttackRightLightDash"
        r2 = "W_AttackRightHeavyDash"
        b1 = "W_AttackBothDash"
        b2 = "W_AttackBothHeavyDash"
    elseif c_IsStealth == TRUE then
        r1 = "W_AttackRightLightStealth"
        b1 = "W_AttackBothLightStealth"
    end
    if ExecAttack(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, UPPER, FALSE, FALSE, FALSE) == TRUE then
        return TRUE
    end
    if ExecGesture() == TRUE then
        return TRUE
    end
    if ExecStop() == TRUE then
        return TRUE
    end
    return FALSE
end

function QuickTurnCommonFunction()
    act(SetCanChangeEquipmentOff)
    act(AllowBuddyWarp)

    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
        return TRUE
    end
    if ExecJump() == TRUE then
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, UPPER) == TRUE then
        return TRUE
    end
    if ExecGuardOnCancelTiming(FALSE, UPPER) == TRUE then
        return TRUE
    end
    if ExecWeaponChange(UPPER) == TRUE then
        return TRUE
    end
    if ExecEvasion(FALSE, ESTEP_NONE, FALSE) == TRUE then
        return TRUE
    end
    if ExecItem(QUICKTYPE_NORMAL, UPPER) == TRUE then
        return TRUE
    end
    if ExecMagic(QUICKTYPE_NORMAL, UPPER, FALSE) == TRUE then
        return TRUE
    end
    if ExecArtsStanceOnCancelTiming(UPPER) == TRUE then
        return TRUE
    end
    if ExecAttack("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, UPPER, FALSE, FALSE, FALSE) == TRUE then
        return TRUE
    end
    if MoveStartonCancelTiming(Event_Move, FALSE) == TRUE then
        return TRUE
    end
    return FALSE
end


function IdleCommonFunction()
    if env(IsCOMPlayer) == TRUE then
        act(LockonSystemUnableToTurnAngle, 15, 15)
    else
        act(LockonSystemUnableToTurnAngle, 45, 45)
    end

    act(Wait)
    act(AllowBuddyWarp)
    SetEnableAimMode()

    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
        return TRUE
    end
    if LadderStart() == TRUE then
        return TRUE
    end
    if c_IsStealth == FALSE and ExecQuickTurn(ALLBODY, TURN_TYPE_DEFAULT) == TRUE then
        return TRUE
    end
    if ExecJump() == TRUE then
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, ALLBODY) == TRUE then
        return TRUE
    end
    if ExecGuard(Event_GuardStart, ALLBODY) == TRUE then
        return TRUE
    end
    if ExecWeaponChange(ALLBODY) == TRUE then
        return TRUE
    end
    if ExecEvasion(FALSE, ESTEP_NONE, FALSE) == TRUE then
        return TRUE
    end
    if ExecItem(QUICKTYPE_NORMAL, ALLBODY) == TRUE then
        return TRUE
    end
    if ExecMagic(QUICKTYPE_NORMAL, ALLBODY, FALSE) == TRUE then
        return TRUE
    end
    if ExecArtsStance(ALLBODY) == TRUE then
        return TRUE
    end
    if ExecRide() == TRUE then
        return TRUE
    end

    local r1 = "W_AttackRightLight1"
    local b1 = "W_AttackBothLight1"

    if c_IsStealth == TRUE then
        r1 = "W_AttackRightLightStealth"
        b1 = "W_AttackBothLightStealth"
    end

    if ExecAttack(r1, "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1,
        "W_AttackBothHeavy1Start", FALSE, ALLBODY, FALSE, FALSE, FALSE) == TRUE then
        return TRUE
    end
    if c_IsStealth == TRUE then
        if MoveStart(ALLBODY, Event_Stealth_Move, FALSE) == TRUE then
            return TRUE
        end
    elseif MoveStart(ALLBODY, Event_Move, FALSE) == TRUE then
        return TRUE
    end

    if ExecGesture() == TRUE then
        return TRUE
    end
    return FALSE
end

function StopCommonFunction(is_dash_stop)
    act(Wait)

    if is_dash_stop == TRUE then
        if c_IsStealth == TRUE then
            act(LockonSystemUnableToTurnAngle, 0, 0)
        else
            act(LockonSystemUnableToTurnAngle, 180, 180)
        end
    elseif env(IsCOMPlayer) == TRUE then
        act(LockonSystemUnableToTurnAngle, 15, 15)
    else
        act(LockonSystemUnableToTurnAngle, 45, 45)
    end

    SetEnableAimMode()

    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
        return TRUE
    end
    if LadderStart() == TRUE then
        return TRUE
    end
    if is_dash_stop == FALSE and c_IsStealth == FALSE and ExecQuickTurn(ALLBODY, TURN_TYPE_DEFAULT) == TRUE then
        return TRUE
    end
    if ExecJump() == TRUE then
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, ALLBODY) == TRUE then
        return TRUE
    end
    if ExecGuard(Event_GuardStart, ALLBODY) == TRUE then
        return TRUE
    end
    if ExecWeaponChange(ALLBODY) == TRUE then
        return TRUE
    end
    if ExecEvasion(FALSE, ESTEP_NONE, FALSE) == TRUE then
        return TRUE
    end
    if ExecItem(QUICKTYPE_NORMAL, ALLBODY) == TRUE then
        return TRUE
    end
    if ExecMagic(QUICKTYPE_NORMAL, ALLBODY, FALSE) == TRUE then
        return TRUE
    end
    if ExecArtsStance(ALLBODY) == TRUE then
        return TRUE
    end
    if ExecRide() == TRUE then
        return TRUE
    end

    local r1 = "W_AttackRightLight1"
    local b1 = "W_AttackBothLight1"

    if c_IsStealth == TRUE then
        r1 = "W_AttackRightLightStealth"
        b1 = "W_AttackBothLightStealth"
    end

    if ExecAttack(r1, "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1,
        "W_AttackBothHeavy1Start", FALSE, ALLBODY, FALSE, FALSE, FALSE) == TRUE then
        return TRUE
    end
    if env(GetSpEffectID, 100170) == TRUE then
        act(LockonFixedAngleCancel)
        if ExecDashTurn() == TRUE then
            return TRUE
        end
    end

    if c_IsStealth == TRUE then
        if MoveStart(ALLBODY, Event_Stealth_Move, FALSE) == TRUE then
            return TRUE
        end
    elseif MoveStart(ALLBODY, Event_Move, FALSE) == TRUE then
        return TRUE
    end

    if ExecGesture() == TRUE then
        return TRUE
    end
    return FALSE
end

--------------
-- Triggers --
--------------

function Move_Activate()
    SetWeightIndex()
end

function Move_Update()
    SetWeightIndex()
end

function Move_onActivate()
    act(SwitchMotion, TRUE)
end

function Move_onUpdate()
    act(SwitchMotion, TRUE)

    local move_speed = GetVariable("MoveSpeedIndex")

    if move_speed == 2 then
        SetThrowAtkInvalid()
    end

    if g_TimeActEditor_08 >= 1 then
        act(Set4DirectionMovementThreshold, GetVariable("MagicRightWalkAngle_FrontLeft"),
            GetVariable("MagicRightWalkAngle_FrontRight"), GetVariable("MagicRightWalkAngle_BackLeft"),
            GetVariable("MagicRightWalkAngle_BackRight"))
    elseif 1 <= g_TimeActEditor_09 then
        act(Set4DirectionMovementThreshold, GetVariable("MagicLeftWalkAngle_FrontLeft"),
            GetVariable("MagicLeftWalkAngle_FrontRight"), GetVariable("MagicLeftWalkAngle_BackLeft"),
            GetVariable("MagicLeftWalkAngle_BackRight"))
    elseif hkbGetVariable("MoveType") < 0.5 then
        act(Set4DirectionMovementThreshold, 60, 45, 60, 60)
    elseif hkbGetVariable("StanceMoveType") == 0 then
        act(Set4DirectionMovementThreshold, 70, 40, 60, 20)
    else
        act(Set4DirectionMovementThreshold, 40, 70, 60, 20)
    end

    SpeedUpdate()

    if env(IsCOMPlayer) == TRUE then
        local npc_turn_speed = 240

        if move_speed == 2 then
            npc_turn_speed = 180
        else
            local dir = GetVariable("MoveDirection")
            if dir == 0 then
                npc_turn_speed = 90
            end
        end

        SetTurnSpeed(npc_turn_speed)
    end

    if hkbGetVariable("MoveDirection") == 3 or hkbGetVariable("MoveDirection") == 2 then
        act(SetMovementScaleMult, 0.9599999785423279)
    elseif hkbGetVariable("MoveDirection") == 1 then
        act(SetMovementScaleMult, 0.9599999785423279)
    elseif hkbGetVariable("MoveDirection") == 0 then
        act(SetMovementScaleMult, 0.9800000190734863)
    end
end

function MoveNoSync_onActivate()
    act(SwitchMotion, TRUE)
end

function MoveNoSync_onUpdate()
    Move_onUpdate()
end

function Move_Upper_onActivate()
    act(Wait)
end

function Move_Upper_onUpdate()
    SetEnableMimicry()

    if MoveCommonFunction(UPPER) == TRUE then
        SetVariable("ArtsTransition", 0)
    end
end

function Idle_onActivate()
    SetVariable("MoveSpeedLevelReal", 0)
    ClearAttackQueue()
    act(Wait)
    act(RequestThrowAnimInterrupt)
    act(DisallowAdditiveTurning, TRUE)
end

function Idle_onUpdate()
    SetEnableMimicry()

    if IdleCommonFunction() == TRUE then
        SetVariable("ArtsTransition", 0)
    end
end

function Idle_onDeactivate()
    act(DisallowAdditiveTurning, FALSE)
end

function DashStop_onActivate()
    act(Wait)
end

function DashStop_onUpdate()
    if StopCommonFunction(TRUE) == TRUE then
        return
    end
end

function RunStopFront_onActivate()
    act(Wait)
end

function RunStopFront_onUpdate()
    SetEnableMimicry()

    if StopCommonFunction(FALSE) == TRUE then
        return
    end
end

function RunStopBack_onActivate()
    act(Wait)
end

function RunStopBack_onUpdate()
    SetEnableMimicry()
    if StopCommonFunction(FALSE) == TRUE then
        return
    end
end

function RunStopLeft_onActivate()
    act(Wait)
end

function RunStopLeft_onUpdate()
    SetEnableMimicry()
    if StopCommonFunction(FALSE) == TRUE then
        return
    end
end

function RunStopRight_onActivate()
    act(Wait)
end

function RunStopRight_onUpdate()
    SetEnableMimicry()

    if StopCommonFunction(FALSE) == TRUE then
        return
    end
end

function WalkStopFront_onActivate()
    act(Wait)
end

function WalkStopFront_onUpdate()
    SetEnableMimicry()

    if StopCommonFunction(FALSE) == TRUE then
        return
    end
end

function WalkStopBack_onActivate()
    act(Wait)
end

function WalkStopBack_onUpdate()
    SetEnableMimicry()

    if StopCommonFunction(FALSE) == TRUE then
        return
    end
end

function WalkStopLeft_onActivate()
    act(Wait)
end

function WalkStopLeft_onUpdate()
    SetEnableMimicry()

    if StopCommonFunction(FALSE) == TRUE then
        return
    end
end

function WalkStopRight_onActivate()
    act(Wait)
end

function WalkStopRight_onUpdate()
    SetEnableMimicry()

    if StopCommonFunction(FALSE) == TRUE then
        return
    end
end

function Dash180_onActivate()
    act(SetIsTurnAnimInProgress)
end

function Dash180_onUpdate()
    act(SetIsTurnAnimInProgress)

    if QuickTurnCommonFunction() == TRUE then
        return
    end
end

function QuickTurnLeft180_Upper_onUpdate()
    if QuickTurnCommonFunction() == TRUE then
        return
    end
    if GetVariable("IsLockon") == false then
        ExecEventNoReset("W_Idle")
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        ExecEventNoReset("W_Idle")
        return
    end
end

function QuickTurnRight180_Upper_onUpdate()
    if QuickTurnCommonFunction() == TRUE then
        return
    end
    if GetVariable("IsLockon") == false then
        ExecEventNoReset("W_Idle")
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        ExecEventNoReset("W_Idle")
        return
    end
end
