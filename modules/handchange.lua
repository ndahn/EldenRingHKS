HandChangeControlTest8_RelaeseA = TRUE

function GetWeaponChangeType(hand)
    local left_offset = 0
    local pos = env(GetWeaponStorageSpotType, hand)

    if hand == HAND_LEFT then
        left_offset = 4
    end

    if pos == 0 then
        return WEAPON_CHANGE_REQUEST_RIGHT_WAIST + left_offset
    elseif pos == 1 then
        return WEAPON_CHANGE_REQUEST_RIGHT_BACK + left_offset
    elseif pos == 2 then
        return WEAPON_CHANGE_REQUEST_RIGHT_SHOULDER + left_offset
    elseif pos == 3 then
        return WEAPON_CHANGE_REQUEST_RIGHT_SPEAR + left_offset
    end
    return WEAPON_CHANGE_REQUEST_INVALID
end

function SetHandChangeStyle(s, e)
    SetVariable("HandChangeStartIndex", s)
    SetVariable("HandChangeEndIndex", e)
end

function ExecWeaponChange(blend_type)
    local kind = WEAPON_CHANGE_REQUEST_INVALID

    if c_HasActionRequest == FALSE then
        return FALSE
    end
    if env(IsGeneralAnimCancelPossible) == FALSE and env(IsStayState) == FALSE then
        return FALSE
    end
    if env(GetSpEffectID, 100730) == TRUE then
        return FALSE
    end
    if env(ActionRequest, ACTION_ARM_R1) == TRUE or env(ActionRequest, ACTION_ARM_R2) == TRUE then
        if env(ActionDuration, ACTION_ARM_ACTION) > 0 then
            HandChangeTest_ToR1 = FALSE
            HandChangeTest_ToR2 = FALSE
            HandChangeTest_ToL1 = FALSE
            HandChangeTest_ToL2 = FALSE

            if env(ActionRequest, ACTION_ARM_R1) == TRUE then
                HandChangeTest_ToR1 = TRUE
            else
                HandChangeTest_ToR2 = TRUE
            end

            return ExecHandChange(HAND_RIGHT, TRUE, blend_type)
        end
    elseif (env(ActionRequest, ACTION_ARM_L1) == TRUE or env(ActionRequest, ACTION_ARM_L2) == TRUE) and
        env(ActionDuration, ACTION_ARM_ACTION) > 0 then
        HandChangeTest_ToR1 = FALSE
        HandChangeTest_ToR2 = FALSE
        HandChangeTest_ToL1 = FALSE
        HandChangeTest_ToL2 = FALSE

        if env(ActionRequest, ACTION_ARM_L1) == TRUE then
            HandChangeTest_ToL1 = TRUE
        else
            HandChangeTest_ToL2 = TRUE
        end

        return ExecHandChange(HAND_LEFT, TRUE, blend_type)
    end
    if env(ActionRequest, ACTION_ARM_CHANGE_WEAPON_R) == TRUE then
        kind = GetWeaponChangeType(HAND_RIGHT)
    elseif env(ActionRequest, ACTION_ARM_CHANGE_WEAPON_L) == TRUE then
        kind = GetWeaponChangeType(HAND_LEFT)
    else
        return FALSE
    end

    if kind == WEAPON_CHANGE_REQUEST_INVALID then
        return FALSE
    end

    SetVariable("WeaponChangeType", kind)

    if blend_type == ALLBODY and MoveStart(LOWER, Event_Move, FALSE) == TRUE then
        blend_type = UPPER
    end

    local event = Event_WeaponChangeStart

    if c_IsStealth == TRUE then
        event = Event_StealthWeaponChangeStart
    end

    ExecEventHalfBlend(event, blend_type)
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    SetAIActionState()

    return TRUE
end

function GetHandChangeType(hand)
    local left_offset = 0
    local pos = env(GetWeaponStorageSpotType, hand)

    if hand == HAND_LEFT then
        left_offset = 4
    end

    if pos == 0 then
        return WEAPON_CHANGE_REQUEST_RIGHT_WAIST + left_offset
    elseif pos == 1 then
        return WEAPON_CHANGE_REQUEST_RIGHT_BACK + left_offset
    elseif pos == 2 then
        return WEAPON_CHANGE_REQUEST_RIGHT_SHOULDER + left_offset
    elseif pos == 3 then
        return WEAPON_CHANGE_REQUEST_RIGHT_SPEAR + left_offset
    end
    return WEAPON_CHANGE_REQUEST_INVALID
end

function ExecHandChange(hand, is_force, blend_type, no_reset)
    if is_force == FALSE then
        if env(IsCOMPlayer) ~= TRUE then
            return FALSE
        end
        if c_HasActionRequest == FALSE or env(IsPrecisionShoot) == TRUE then
            return FALSE
        end
        if env(ActionRequest, ACTION_ARM_CHANGE_STYLE_R) == TRUE and env(ActionDuration, ACTION_ARM_R1) < 100 then
        elseif env(ActionRequest, ACTION_ARM_CHANGE_STYLE_L) == TRUE and env(ActionDuration, ACTION_ARM_L1) < 100 then
            hand = HAND_LEFT
        else
            return FALSE
        end
    end

    local style = c_Style
    local kind = nil

    if style == HAND_RIGHT then
        if hand == HAND_RIGHT then
            if env(IsTwoHandPossible, HAND_RIGHT) == FALSE then
                return FALSE
            end
            kind = GetHandChangeType(HAND_LEFT)
            if kind == WEAPON_CHANGE_REQUEST_LEFT_WAIST then
                if IsDualBladeSpecific(HAND_RIGHT) == TRUE then
                    SetHandChangeStyle(LEFT_TO_WAIST, LEFT_FROM_WAIST)
                else
                    SetHandChangeStyle(LEFT_TO_WAIST, BOTH_FROM_ALL)
                end
            elseif kind == WEAPON_CHANGE_REQUEST_LEFT_BACK then
                if IsDualBladeSpecific(HAND_RIGHT) == TRUE then
                    SetHandChangeStyle(LEFT_TO_BACK, LEFT_FROM_BACK)
                else
                    SetHandChangeStyle(LEFT_TO_BACK, BOTH_FROM_ALL)
                end
            elseif kind == WEAPON_CHANGE_REQUEST_LEFT_SHOULDER then
                if IsDualBladeSpecific(HAND_RIGHT) == TRUE then
                    SetHandChangeStyle(LEFT_TO_SHOULDER, LEFT_FROM_SHOULDER)
                else
                    SetHandChangeStyle(LEFT_TO_SHOULDER, BOTH_FROM_ALL)
                end
            elseif kind == WEAPON_CHANGE_REQUEST_LEFT_SPEAR then
                if IsDualBladeSpecific(HAND_RIGHT) == TRUE then
                    SetHandChangeStyle(LEFT_TO_SPEAR, LEFT_FROM_SPEAR)
                else
                    SetHandChangeStyle(LEFT_TO_SPEAR, BOTH_FROM_ALL)
                end
            elseif IsDualBladeSpecific(HAND_RIGHT) == TRUE then
                SetHandChangeStyle(LEFT_TO_SPEAR, LEFT_FROM_SPEAR)
            else
                SetHandChangeStyle(LEFT_TO_SPEAR, BOTH_FROM_ALL)
            end
            act(Unknown9999, 1)
        else
            if env(IsTwoHandPossible, HAND_LEFT) == FALSE then
                return FALSE
            end
            kind = GetHandChangeType(HAND_RIGHT)
            if kind == WEAPON_CHANGE_REQUEST_RIGHT_WAIST then
                if IsDualBladeSpecific(HAND_LEFT) == TRUE then
                    SetHandChangeStyle(RIGHT_TO_WAIST, RIGHT_FROM_WAIST)
                else
                    SetHandChangeStyle(RIGHT_TO_WAIST, BOTHLEFT_FROM_ALL)
                end
            elseif kind == WEAPON_CHANGE_REQUEST_RIGHT_BACK then
                if IsDualBladeSpecific(HAND_LEFT) == TRUE then
                    SetHandChangeStyle(RIGHT_TO_BACK, RIGHT_FROM_BACK)
                else
                    SetHandChangeStyle(RIGHT_TO_BACK, BOTHLEFT_FROM_ALL)
                end
            elseif kind == WEAPON_CHANGE_REQUEST_RIGHT_SHOULDER then
                if IsDualBladeSpecific(HAND_LEFT) == TRUE then
                    SetHandChangeStyle(RIGHT_TO_SHOULDER, RIGHT_FROM_SHOULDER)
                else
                    SetHandChangeStyle(RIGHT_TO_SHOULDER, BOTHLEFT_FROM_ALL)
                end
            elseif kind == WEAPON_CHANGE_REQUEST_RIGHT_SPEAR then
                if IsDualBladeSpecific(HAND_LEFT) == TRUE then
                    SetHandChangeStyle(RIGHT_TO_SPEAR, RIGHT_FROM_SPEAR)
                else
                    SetHandChangeStyle(RIGHT_TO_SPEAR, BOTHLEFT_FROM_ALL)
                end
            elseif IsDualBladeSpecific(HAND_RIGHT) == TRUE then
                SetHandChangeStyle(RIGHT_TO_BACK, RIGHT_FROM_BACK)
            else
                SetHandChangeStyle(RIGHT_TO_BACK, BOTHLEFT_FROM_ALL)
            end
            act(Unknown9999, 2)
        end
    elseif style == HAND_RIGHT_BOTH then
        kind = GetHandChangeType(HAND_LEFT)
        if kind == WEAPON_CHANGE_REQUEST_LEFT_WAIST then
            SetHandChangeStyle(BOTH_TO_WAIST, LEFT_FROM_WAIST)
        elseif kind == WEAPON_CHANGE_REQUEST_LEFT_BACK then
            SetHandChangeStyle(BOTH_TO_BACK, LEFT_FROM_BACK)
        elseif kind == WEAPON_CHANGE_REQUEST_LEFT_SHOULDER then
            SetHandChangeStyle(BOTH_TO_SHOULDER, LEFT_FROM_SHOULDER)
        else
            SetHandChangeStyle(BOTH_TO_BACK, LEFT_FROM_BACK)
        end
        act(Unknown9999, 3)
    elseif style == HAND_LEFT_BOTH then
        kind = GetHandChangeType(HAND_RIGHT)
        if kind == WEAPON_CHANGE_REQUEST_RIGHT_WAIST then
            SetHandChangeStyle(BOTHRIGHT_TO_WAIST, RIGHT_FROM_WAIST)
        elseif kind == WEAPON_CHANGE_REQUEST_RIGHT_BACK then
            SetHandChangeStyle(BOTHRIGHT_TO_BACK, RIGHT_FROM_BACK)
        elseif kind == WEAPON_CHANGE_REQUEST_RIGHT_SHOULDER then
            SetHandChangeStyle(BOTHRIGHT_TO_SHOULDER, RIGHT_FROM_SHOULDER)
        else
            SetHandChangeStyle(BOTHRIGHT_TO_BACK, RIGHT_FROM_SPEAR)
        end
        act(Unknown9999, 1)
    end
    if blend_type == ALLBODY then
        local move_event = Event_Move
        if c_IsStealth == TRUE then
            move_event = Event_Stealth_Move
        end
        if MoveStart(LOWER, move_event, FALSE) == TRUE then
            blend_type = UPPER
        end
    end
    local event = Event_HandChangeStart
    if c_IsStealth == TRUE then
        event = Event_StealthHandChangeStart
    end
    if no_reset == TRUE then
        ExecEventHalfBlendNoReset(event, blend_type)
    else
        ExecEventHalfBlend(event, blend_type)
    end
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    SetAIActionState()
    return TRUE
end

----------------------
-- Common functions --
----------------------

function WeaponChangeCommonFunction(blend_type)
    SetAIActionState()
    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
        return TRUE
    end
    if ExecJump() == TRUE then
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, blend_type) == TRUE then
        return TRUE
    end
    if ExecGuardOnCancelTiming(FALSE, blend_type) == TRUE then
        return TRUE
    end
    if ExecWeaponChange(blend_type) == TRUE then
        return TRUE
    end
    if ExecEvasion(FALSE, ESTEP_NONE, FALSE) == TRUE then
        return TRUE
    end
    if ExecItem(QUICKTYPE_NORMAL, blend_type) == TRUE then
        return TRUE
    end
    if ExecMagic(QUICKTYPE_NORMAL, blend_type, FALSE) == TRUE then
        return TRUE
    end
    if ExecArtsStanceOnCancelTiming(blend_type) == TRUE then
        return TRUE
    end
    local r1 = "W_AttackRightLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b1 = "W_AttackBothLight1"
    local b2 = "W_AttackBothHeavy1Start"
    if env(GetSpEffectID, 100002) == TRUE and env(ActionDuration, ACTION_ARM_SP_MOVE) > 0 then
        r1 = "W_AttackRightLightDash"
        r2 = "W_AttackRightHeavyDash"
        b1 = "W_AttackBothDash"
        b2 = "W_AttackBothHeavyDash"
    end
    if ExecAttack(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, blend_type, FALSE, FALSE, FALSE) ==
        TRUE then
        return TRUE
    end
    if blend_type ~= UPPER and ExecQuickTurn(LOWER, TURN_TYPE_DEFAULT) == TRUE then
        return TRUE
    end
    return FALSE
end

function HandChangeCommonFunction(blend_type)
    SetAIActionState()

    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
        return TRUE
    end
    if ExecJump() == TRUE then
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, blend_type) == TRUE then
        return TRUE
    end
    if ExecGuardOnCancelTiming(FALSE, blend_type) == TRUE then
        return TRUE
    end
    if ExecWeaponChange(blend_type) == TRUE then
        return TRUE
    end
    if ExecEvasion(FALSE, ESTEP_NONE, FALSE) == TRUE then
        return TRUE
    end
    if ExecGuardOnCancelTiming(FALSE, blend_type) == TRUE then
        return TRUE
    end
    if ExecItem(QUICKTYPE_NORMAL, blend_type) == TRUE then
        return TRUE
    end
    if ExecMagic(QUICKTYPE_NORMAL, blend_type, FALSE) == TRUE then
        return TRUE
    end
    if ExecArtsStanceOnCancelTiming(blend_type) == TRUE then
        return TRUE
    end
    local r1 = "W_AttackRightLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b1 = "W_AttackBothLight1"
    local b2 = "W_AttackBothHeavy1Start"
    if env(GetSpEffectID, 100002) == TRUE and env(ActionDuration, ACTION_ARM_SP_MOVE) > 0 then
        r1 = "W_AttackRightLightDash"
        r2 = "W_AttackRightHeavyDash"
        b1 = "W_AttackBothDash"
        b2 = "W_AttackBothHeavyDash"
    end
    if ExecAttack(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, blend_type, FALSE, FALSE, FALSE) ==
        TRUE then
        return TRUE
    end
    if blend_type ~= UPPER and ExecQuickTurn(LOWER, TURN_TYPE_DEFAULT) == TRUE then
        return TRUE
    end
    return FALSE
end

--------------
-- Triggers --
--------------

function WeaponChangeStart_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if WeaponChangeCommonFunction(blend_type) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        ExecEventHalfBlendNoReset(Event_WeaponChangeEnd, blend_type)
        return
    end
    if HalfBlendLowerCommonFunction(Event_WeaponChangeStartMirror, lower_state, FALSE) == TRUE then
        return
    end
end

function StealthWeaponChangeStart_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if WeaponChangeCommonFunction(blend_type) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        ExecEventHalfBlendNoReset(Event_StealthWeaponChangeEnd, blend_type)
        return
    end
    if HalfBlendLowerCommonFunction(Event_StealthWeaponChangeStart, lower_state, FALSE) == TRUE then
        return
    end
end

function WeaponChangeEnd_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if WeaponChangeCommonFunction(blend_type) == TRUE then
        return
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_WeaponChangeEndMirror, lower_state, FALSE) == TRUE then
        return
    end
end

function StealthWeaponChangeEnd_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if WeaponChangeCommonFunction(blend_type) == TRUE then
        return
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Stealth_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_StealthWeaponChangeEnd, lower_state, FALSE) == TRUE then
        return
    end
end

function HandChangeStart_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if HandChangeCommonFunction(blend_type) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        ExecEventHalfBlendNoReset(Event_HandChangeEnd, blend_type)
        return
    end
    if HalfBlendLowerCommonFunction(Event_HandChangeStartMirror, lower_state, FALSE) == TRUE then
        return
    end
end

function StealthHandChangeStart_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if HandChangeCommonFunction(blend_type) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        ExecEventHalfBlendNoReset(Event_StealthHandChangeEnd, blend_type)
        return
    end
    if HalfBlendLowerCommonFunction(Event_StealthHandChangeStart, lower_state, FALSE) == TRUE then
        return
    end
end

function HandChangeEnd_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if HandChangeCommonFunction(blend_type) == TRUE then
        return
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_HandChangeEndMirror, lower_state, FALSE) == TRUE then
        return
    end
end

function HandChangeEnd_Upper_onDeactivate()
    HandChangeTest_ToR1 = FALSE
    HandChangeTest_ToR2 = FALSE
    HandChangeTest_ToL1 = FALSE
    HandChangeTest_ToL2 = FALSE
end

function StealthHandChangeEnd_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if HandChangeCommonFunction(blend_type) == TRUE then
        return
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Stealth_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_StealthHandChangeEnd, lower_state, FALSE) == TRUE then
        return
    end
end

function StealthHandChangeEnd_Upper_onDeactivate()
    HandChangeTest_ToR1 = FALSE
    HandChangeTest_ToR2 = FALSE
    HandChangeTest_ToL1 = FALSE
    HandChangeTest_ToL2 = FALSE
end
