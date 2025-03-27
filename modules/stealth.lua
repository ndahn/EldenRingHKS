
function SetStealthState(state)
    SetVariable("StealthState", state)
end

function Stealth_Deactivate()
    SetStealthState(STEALTH_NONE)
end

function StealthActionCommonFunction(fall_type, r1, r2, l1, l2, b1, b2, quick_type)
    SetAIActionState()
    SetEnableAimMode()
    if ExecPassiveAction(FALSE, fall_type, FALSE) == TRUE then
        return TRUE
    end
    if ExecJump() == TRUE then
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, ALLBODY) == TRUE then
        return TRUE
    end
    if ExecGuardOnCancelTiming(FALSE, ALLBODY) == TRUE then
        return TRUE
    end
    if ExecWeaponChange(ALLBODY) == TRUE then
        return TRUE
    end
    if ExecEvasion(FALSE, ESTEP_NONE, FALSE) == TRUE then
        return TRUE
    end
    if ExecItem(quick_type, ALLBODY) == TRUE then
        return TRUE
    end
    if ExecMagic(quick_type, ALLBODY, FALSE) == TRUE then
        return TRUE
    end
    if ExecArtsStanceOnCancelTiming(ALLBODY) == TRUE then
        return TRUE
    end
    if ExecAttack(r1, r2, l1, l2, b1, b2, FALSE, ALLBODY, FALSE, FALSE, FALSE) == TRUE then
        return TRUE
    end
    if MoveStartonCancelTiming(Event_MoveLong, FALSE) == TRUE then
        return TRUE
    end
    return FALSE
end

function StealthItemOneShot_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if StealthItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_StealthItemOneShot, lower_state, FALSE) == TRUE then
        return
    end
end

function StealthItemOneShot_SelfTrans_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if StealthItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_StealthItemOneShot, lower_state, FALSE) == TRUE then
        return
    end
end

function StealthItemDrinkStart_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if StealthItemCommonFunction(blend_type) == TRUE then
        return
    end
    local isEnd = env(IsAnimEnd, 1)
    if env(GetEventEzStateFlag, 0) == TRUE or isEnd == TRUE then
        local item_type = env(GetItemAnimType)
        if item_type ~= ITEM_NO_DRINK then
            ExecEventHalfBlendNoReset(Event_StealthItemDrinking, blend_type)
            return
        elseif item_type == ITEM_NO_DRINK and isEnd == TRUE then
            ExecEventHalfBlendNoReset(Event_StealthItemDrinkEmpty, blend_type)
            return
        end
    end
    if HalfBlendLowerCommonFunction(Event_StealthItemOneShot, lower_state, FALSE) == TRUE then
        return
    end
end

function StealthItemDrinking_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if StealthItemCommonFunction(blend_type) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        ExecEventHalfBlendNoReset(Event_StealthItemDrinkEnd, blend_type)
        return
    end
    if HalfBlendLowerCommonFunction(Event_StealthItemOneShot, lower_state, FALSE) == TRUE then
        return
    end
end

function StealthItemDrinkEnd_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if StealthItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_StealthItemOneShot, lower_state, FALSE) == TRUE then
        return
    end
end

function StealthItemDrinkEmpty_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if StealthItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_StealthItemOneShot, lower_state, FALSE) == TRUE then
        return
    end
end

function StealthItemDrinkNothing_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if StealthItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_StealthItemOneShot, lower_state, FALSE) == TRUE then
        return
    end
end

function Stealth_to_Stealth_Idle_onUpdate()
    act(SwitchMotion, TRUE)
    act(SetAllowedThrowAttackType, THROW_STATE_STEALTH)
    SetEnableAimMode()
    SetStealthState(STEALTH_TO_STEALTHIDLE)
    SpeedUpdate()
    StealthTransitionIndexUpdate()
    if GetVariable("MoveSpeedIndex") == 2 then
        act(LockonFixedAngleCancel)
    end
    if env(IsMoveCancelPossible) == TRUE and GetVariable("MoveSpeedLevel") > 0 then
        MoveStart(ALLBODY, Event_Stealth_Move, FALSE)
        return
    end
    if StealthActionCommonFunction(FALL_TYPE_DEFAULT, "W_AttackRightLightStealth", "W_AttackRightHeavy1Start",
        "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLightStealth", "W_AttackBothHeavy1Start",
        QUICKTYPE_ROLLING) == TRUE then
        return
    end
end

function Stealth_to_Idle_onUpdate()
    act(SwitchMotion, TRUE)
    act(SetAllowedThrowAttackType, THROW_STATE_STEALTH)
    SetEnableAimMode()
    SetStealthState(STEALTH_TO_IDLE)
    SpeedUpdate()
    StealthTransitionIndexUpdate()
    if GetVariable("MoveSpeedIndex") == 2 then
        act(LockonFixedAngleCancel)
    end
    if env(IsMoveCancelPossible) == TRUE and GetVariable("MoveSpeedLevel") > 0 then
        MoveStart(ALLBODY, Event_Move, FALSE)
        return
    else
    end
    if StealthActionCommonFunction(FALL_TYPE_DEFAULT, "W_AttackRightLightStealth", "W_AttackRightHeavy1Start",
        "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLightStealth", "W_AttackBothHeavy1Start",
        QUICKTYPE_ROLLING) == TRUE then
        return
    end
end

function Stealth_Idle_onUpdate()
    act(Wait)
    act(SetAllowedThrowAttackType, THROW_STATE_STEALTH)
    SetEnableAimMode()
    SetStealthState(STEALTH_IDLE)
    if IdleCommonFunction() == TRUE then
        return
    end
    if ExecArtsStance(ALLBODY) == TRUE then
        return
    end
    if ExecGuard(Event_GuardStart, ALLBODY) == TRUE then
        return
    end
end

function Stealth_Move_onActivate()
    act(SwitchMotion, TRUE)
end

function Stealth_Move_onUpdate()
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

function Stealth_Move_Upper_onUpdate()
    act(SetAllowedThrowAttackType, THROW_STATE_STEALTH)
    SetWeightIndex()
    if MoveCommonFunction(UPPER) == TRUE then
        return
    end
end

function StealthStopCommonFunction(is_dash_stop)
    act(Wait)
    act(SwitchMotion, TRUE)
    act(SetAllowedThrowAttackType, THROW_STATE_STEALTH)
    SetEnableAimMode()
    SetStealthState(STEALTH_STOP)
    if StopCommonFunction(is_dash_stop) == TRUE then
        return TRUE
    end
    if env(IsAnimEnd, 1) == TRUE then
        ExecEventAllBody("W_Stealth_Idle")
        return TRUE
    end
    return FALSE
end

function StealthDashStop_onUpdate()
    if StealthStopCommonFunction(TRUE) == TRUE then
        return
    end
end

function StealthRunStopFront_onUpdate()
    if StealthStopCommonFunction(FALSE) == TRUE then
        return
    end
end

function StealthRunStopBack_onUpdate()
    if StealthStopCommonFunction(FALSE) == TRUE then
        return
    end
end

function StealthRunStopLeft_onUpdate()
    if StealthStopCommonFunction(FALSE) == TRUE then
        return
    end
end

function StealthRunStopRight_onUpdate()
    if StealthStopCommonFunction(FALSE) == TRUE then
        return
    end
end

function Stealth_Rolling_onUpdate()
    act(SetAllowedThrowAttackType, THROW_STATE_STEALTH)
    SetWeightIndex()
    SetStealthState(STEALTH_ROLLING)
    if env(IsAnimEnd, 1) == TRUE then
        hkbFireEvent("W_Stealth_Idle")
        return
    end
    if env(IsMoveCancelPossible) == TRUE and MoveStart(ALLBODY, Event_Stealth_Move, FALSE) == TRUE then
        return
    end
    if EvasionCommonFunction(FALL_TYPE_DEFAULT, "W_AttackRightLightStep", "W_AttackRightHeavy1Start",
        "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLightStep", "W_AttackBothHeavy1Start",
        QUICKTYPE_ROLLING) == TRUE then
        return
    end
    SetRollingTurnCondition(FALSE)
end

function Stealth_RollingSelftrans_onUpdate()
    act(SetAllowedThrowAttackType, THROW_STATE_STEALTH)
    SetWeightIndex()
    SetStealthState(STEALTH_ROLLING_SELFTRANS)
    if env(IsAnimEnd, 1) == TRUE and MoveStart(ALLBODY, Event_Stealth_Move, FALSE) == TRUE then
        return
    end
    if env(IsMoveCancelPossible) == TRUE and GetVariable("MoveSpeedLevel") <= 0 then
        MoveStart(ALLBODY, Event_Stealth_Move, FALSE)
        return
    end
    if EvasionCommonFunction(FALL_TYPE_DEFAULT, "W_AttackRightLightStep", "W_AttackRightHeavy1Start",
        "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLightStep", "W_AttackBothHeavy1Start",
        QUICKTYPE_ROLLING) == TRUE then
        return
    end
    SetRollingTurnCondition(TRUE)
end


SetStealthState = hookup_function(SetStealthState)
Stealth_Deactivate = hookup_function(Stealth_Deactivate)
StealthActionCommonFunction = hookup_function(StealthActionCommonFunction)
StealthItemOneShot_Upper_onUpdate = hookup_function(StealthItemOneShot_Upper_onUpdate)
StealthItemOneShot_SelfTrans_Upper_onUpdate = hookup_function(StealthItemOneShot_SelfTrans_Upper_onUpdate)
StealthItemDrinkStart_Upper_onUpdate = hookup_function(StealthItemDrinkStart_Upper_onUpdate)
StealthItemDrinking_Upper_onUpdate = hookup_function(StealthItemDrinking_Upper_onUpdate)
StealthItemDrinkEnd_Upper_onUpdate = hookup_function(StealthItemDrinkEnd_Upper_onUpdate)
StealthItemDrinkEmpty_Upper_onUpdate = hookup_function(StealthItemDrinkEmpty_Upper_onUpdate)
StealthItemDrinkNothing_Upper_onUpdate = hookup_function(StealthItemDrinkNothing_Upper_onUpdate)
Stealth_to_Stealth_Idle_onUpdate = hookup_function(Stealth_to_Stealth_Idle_onUpdate)
Stealth_to_Idle_onUpdate = hookup_function(Stealth_to_Idle_onUpdate)
Stealth_Idle_onUpdate = hookup_function(Stealth_Idle_onUpdate)
Stealth_Move_onActivate = hookup_function(Stealth_Move_onActivate)
Stealth_Move_onUpdate = hookup_function(Stealth_Move_onUpdate)
Stealth_Move_Upper_onUpdate = hookup_function(Stealth_Move_Upper_onUpdate)
StealthStopCommonFunction = hookup_function(StealthStopCommonFunction)
StealthDashStop_onUpdate = hookup_function(StealthDashStop_onUpdate)
StealthRunStopFront_onUpdate = hookup_function(StealthRunStopFront_onUpdate)
StealthRunStopBack_onUpdate = hookup_function(StealthRunStopBack_onUpdate)
StealthRunStopLeft_onUpdate = hookup_function(StealthRunStopLeft_onUpdate)
StealthRunStopRight_onUpdate = hookup_function(StealthRunStopRight_onUpdate)
Stealth_Rolling_onUpdate = hookup_function(Stealth_Rolling_onUpdate)
Stealth_RollingSelftrans_onUpdate = hookup_function(Stealth_RollingSelftrans_onUpdate)
