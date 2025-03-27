
function ExecArrowBothJumpLandAttack()
    local is_both_arrow = FALSE
    local is_both_large_arrow = FALSE
    local is_both_ballista = FALSE
    local arrowHand = 0
    local fireEvent = Event_AttackArrowRightFireMove
    local loopEvent = Event_AttackArrowRightLoop

    if c_Style == HAND_RIGHT_BOTH then
        is_both_large_arrow = GetEquipType(HAND_RIGHT, WEAPON_CATEGORY_LARGE_ARROW)
        is_both_ballista = GetEquipType(HAND_RIGHT, WEAPON_CATEGORY_BALLISTA)
        arrowHand = 1

        if is_both_ballista == TRUE then
            fireEvent = Event_AttackCrossbowBothRightFire
            loopEvent = Event_AttackCrossbowBothRightLoop
        end
    elseif c_Style == HAND_LEFT_BOTH then
        is_both_large_arrow = GetEquipType(HAND_LEFT, WEAPON_CATEGORY_LARGE_ARROW, WEAPON_CATEGORY_BALLISTA)
        is_both_ballista = GetEquipType(HAND_LEFT, WEAPON_CATEGORY_BALLISTA)
        arrowHand = 0

        if is_both_ballista == TRUE then
            fireEvent = Event_AttackCrossbowBothRightFire
            loopEvent = Event_AttackCrossbowBothRightLoop
        else
            fireEvent = Event_AttackArrowLeftFireMove
            loopEvent = Event_AttackArrowLeftLoop
        end
    end

    if is_both_large_arrow == FALSE and is_both_ballista == FALSE then
        return FALSE
    end
    if g_ArrowSlot == 0 then
        act(ChooseBowAndArrowSlot, 0)
        if env(IsOutOfAmmo, arrowHand) == TRUE then
            if is_both_ballista == TRUE then
                ExecEventHalfBlend(Event_AttackCrossbowBothRightEmpty, ALLBODY)
            else
                ExecEventAllBody("W_NoArrow")
            end
            return TRUE
        end
        if 0 < env(ActionDuration, ACTION_ARM_R1) then
            ExecEventHalfBlend(loopEvent, ALLBODY)
            return TRUE
        elseif 1 <= GetVariable("JumpAttack_HandCondition") then
            ExecEventHalfBlend(fireEvent, ALLBODY)
            return TRUE
        end
    else
        act(ChooseBowAndArrowSlot, 1)

        if env(IsOutOfAmmo, arrowHand) == TRUE then
            if is_both_ballista == TRUE then
                ExecEventHalfBlend(Event_AttackCrossbowBothRightEmpty, ALLBODY)
            else
                ExecEventAllBody("W_NoArrow")
            end
            return TRUE
        end
        if 0 < env(ActionDuration, ACTION_ARM_R2) then
            ExecEventHalfBlend(loopEvent, ALLBODY)
            return TRUE
        elseif 1 <= GetVariable("JumpAttack_HandCondition") then
            ExecEventHalfBlend(fireEvent, ALLBODY)
            return TRUE
        end
    end
    return FALSE
end

----------------------
-- Common functions --
----------------------

function ArrowCommonFunction(blend_type, is_allbody_turn, turn_type, is_stance_end)
    SetAIActionState()

    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
        return TRUE
    end
    if c_IsStealth == FALSE then
        if is_allbody_turn == TRUE then
            if ExecQuickTurnOnCancelTiming() == TRUE then
                return TRUE
            end
        elseif blend_type ~= UPPER and ExecQuickTurn(LOWER, turn_type) == TRUE then
            return FALSE
        end
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
    if ExecItem(QUICKTYPE_NORMAL, blend_type) == TRUE then
        return TRUE
    end
    if is_stance_end == TRUE and ExecArtsStanceOnCancelTiming(blend_type) == TRUE then
        return TRUE
    end
    return FALSE
end

function CrossbowCommonFunction(blend_type, is_nonturn)
    SetAIActionState()
    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
        return TRUE
    end
    if is_nonturn == FALSE and blend_type ~= UPPER and ExecQuickTurn(LOWER, TURN_TYPE_DEFAULT) == TRUE then
        return FALSE
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
    if ExecAttack("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, blend_type, FALSE, FALSE, FALSE) == TRUE then
        return TRUE
    end
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    return FALSE
end

function ArrowLowerCommonFunction(event, lower_state, to_idle_on_cancel)
    if lower_state == LOWER_MOVE then
        if ExecStopHalfBlend(event, to_idle_on_cancel) == TRUE then
            return
        end
    else
        if lower_state ~= LOWER_TURN then
            local style = c_Style
            local hand = HAND_RIGHT

            if style == HAND_LEFT_BOTH then
                hand = HAND_LEFT
            end

            if env(GetEquipWeaponCategory, hand) ~= WEAPON_CATEGORY_LARGE_ARROW then
                local move_event = Event_Move

                if c_IsStealth == TRUE then
                    move_event = Event_Stealth_Move
                end

                if MoveStart(LOWER, move_event, FALSE) == TRUE then
                    return
                end
            elseif env(IsPrecisionShoot) == FALSE and MoveStartonCancelTiming(Event_Move, FALSE) == TRUE then
                return
            end
        end

        if lower_state == LOWER_END_TURN then
            ExecEventHalfBlendNoReset(event, LOWER)
        end
    end
end

--------------------
-- Arrow Triggers --
--------------------

function AttackArrowRight_Activate()
    local hand = HAND_RIGHT
    if c_Style == HAND_LEFT_BOTH then
        hand = HAND_LEFT
    end
    SetAttackHand(hand)
    SetGuardHand(hand)
end

function AttackArrowLeft_Activate()
    local hand = HAND_RIGHT
    if c_Style == HAND_LEFT_BOTH then
        hand = HAND_LEFT
    end
    SetAttackHand(hand)
    SetGuardHand(hand)
end

function AttackArrowRightStart_Upper_onUpdate()
    act(SetIsPreciseShootingPossible)
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if ArrowCommonFunction(blend_type, FALSE, TURN_TYPE_STANCE) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        if g_ArrowSlot == 0 then
            if env(ActionDuration, ACTION_ARM_R1) > 0 then
                ExecEventHalfBlend(Event_AttackArrowRightLoop, blend_type)
                return
            else
                ExecEventHalfBlend(Event_AttackArrowRightFireMove, blend_type)
                return
            end
        elseif env(ActionDuration, ACTION_ARM_R2) > 0 then
            ExecEventHalfBlend(Event_AttackArrowRightLoop, blend_type)
            return
        else
            ExecEventHalfBlend(Event_AttackArrowRightFireMove, blend_type)
            return
        end
    end
    if ArrowLowerCommonFunction(Event_AttackArrowRightStart, lower_state, FALSE) == TRUE then
        return
    end
end

function AttackArrowRightStartContinue_Upper_onUpdate()
    act(SetIsPreciseShootingPossible)
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if ArrowCommonFunction(blend_type, FALSE, TURN_TYPE_STANCE) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        if g_ArrowSlot == 0 then
            if env(ActionDuration, ACTION_ARM_R1) > 0 then
                ExecEventHalfBlend(Event_AttackArrowRightLoop, blend_type)
                return
            else
                ExecEventHalfBlend(Event_AttackArrowRightFireMove, blend_type)
                return
            end
        elseif env(ActionDuration, ACTION_ARM_R2) > 0 then
            ExecEventHalfBlend(Event_AttackArrowRightLoop, blend_type)
            return
        else
            ExecEventHalfBlend(Event_AttackArrowRightFireMove, blend_type)
            return
        end
    end
    if ArrowLowerCommonFunction(Event_AttackArrowRightStartContinue, lower_state, FALSE) == TRUE then
        return
    end
end

function AttackArrowRightLoop_Upper_onUpdate()
    act(SetIsPreciseShootingPossible)
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if ArrowCommonFunction(blend_type, FALSE, TURN_TYPE_STANCE) == TRUE then
        return
    end
    if g_ArrowSlot == 0 then
        if 0 >= env(ActionDuration, ACTION_ARM_R1) then
            ExecEventHalfBlend(Event_AttackArrowRightFireMove, blend_type)
            return
        end
    elseif 0 >= env(ActionDuration, ACTION_ARM_R2) then
        ExecEventHalfBlend(Event_AttackArrowRightFireMove, blend_type)
        return
    end
    if ArrowLowerCommonFunction(Event_AttackArrowRightLoop, lower_state, FALSE) == TRUE then
        return
    end
end

function AttackArrowRightFire_onUpdate()
    act(SetIsPreciseShootingPossible)
    if ArrowCommonFunction(ALLBODY, TRUE, TURN_TYPE_DEFAULT) == TRUE then
        return
    end
    if env(GetStamina) > 0 then
        local request = GetAttackRequest(FALSE)
        if request == ATTACK_REQUEST_ARROW_FIRE_RIGHT or request == ATTACK_REQUEST_ARROW_FIRE_RIGHT2 then
            if env(GetEquipWeaponCategory, HAND_RIGHT) ~= WEAPON_CATEGORY_LARGE_ARROW then
                if env(IsOutOfAmmo, 1) == TRUE then
                    ExecEventAllBody("W_NoArrow")
                    return
                else
                    SetVariable("NoAmmo", 0)
                    ExecEventHalfBlend(Event_AttackArrowRightStartContinue, ALLBODY)
                    return
                end
            elseif env(IsOutOfAmmo, 1) == TRUE then
                ExecEventAllBody("W_NoArrow")
                return
            else
                ExecEventHalfBlend(Event_AttackArrowRightStartContinue, ALLBODY)
                return
            end
        end
    end
    if MoveStartonCancelTiming(Event_Move, FALSE) == TRUE then
        return
    end
end

function AttackArrowRightFireMove_Upper_onUpdate()
    act(SetIsPreciseShootingPossible)
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if ArrowCommonFunction(blend_type, TRUE, TURN_TYPE_DEFAULT) == TRUE then
        return
    end
    if env(GetStamina) > 0 then
        local request = GetAttackRequest(FALSE)
        if request == ATTACK_REQUEST_ARROW_FIRE_RIGHT or request == ATTACK_REQUEST_ARROW_FIRE_RIGHT2 then
            if env(GetEquipWeaponCategory, HAND_RIGHT) ~= WEAPON_CATEGORY_LARGE_ARROW then
                if env(IsOutOfAmmo, 1) == TRUE then
                    ExecEventAllBody("W_NoArrow")
                    return
                else
                    SetVariable("NoAmmo", 0)
                    act(DebugLogOutput, "AttackArrowRightStartContinue 0")
                    ExecEventHalfBlend(Event_AttackArrowRightStartContinue, blend_type)
                    act(DebugLogOutput, "AttackArrowRightStartContinue")
                    return
                end
            elseif env(IsOutOfAmmo, 1) == TRUE then
                ExecEventAllBody("W_NoArrow")
                return
            else
                ExecEventHalfBlend(Event_AttackArrowRightStartContinue, blend_type)
                return
            end
        end
    end
    if MoveStartonCancelTiming(Event_Move, FALSE) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if ArrowLowerCommonFunction(Event_AttackArrowRightFireMove, lower_state, FALSE) == TRUE then
        return
    end
end

function AttackArrowRightFireDash_onUpdate()
    act(SetIsPreciseShootingPossible)
    if ArrowCommonFunction(ALLBODY, TRUE, TURN_TYPE_DEFAULT) == TRUE then
        return
    end
    if env(GetStamina) > 0 then
        local request = GetAttackRequest(FALSE)
        if request == ATTACK_REQUEST_ARROW_FIRE_RIGHT or request == ATTACK_REQUEST_ARROW_FIRE_RIGHT2 then
            if env(GetEquipWeaponCategory, HAND_RIGHT) ~= WEAPON_CATEGORY_LARGE_ARROW then
                if env(IsOutOfAmmo, 1) == TRUE then
                    ExecEventAllBody("W_NoArrow")
                    return
                else
                    SetVariable("NoAmmo", 0)
                    ExecEventHalfBlend(Event_AttackArrowRightStartContinue, ALLBODY)
                    return
                end
            elseif env(IsOutOfAmmo, 1) == TRUE then
                ExecEventAllBody("W_NoArrow")
                return
            else
                ExecEventHalfBlend(Event_AttackArrowRightStartContinue, ALLBODY)
                return
            end
        end
    end
    if MoveStartonCancelTiming(Event_Move, FALSE) == TRUE then
        return
    end
end

function AttackArrowRightFireStep_onUpdate()
    act(SetIsPreciseShootingPossible)
    if ArrowCommonFunction(ALLBODY, TRUE, TURN_TYPE_DEFAULT) == TRUE then
        return
    end
    if env(GetStamina) > 0 then
        local request = GetAttackRequest(FALSE)
        if request == ATTACK_REQUEST_ARROW_FIRE_RIGHT or request == ATTACK_REQUEST_ARROW_FIRE_RIGHT2 then
            if env(GetEquipWeaponCategory, HAND_RIGHT) ~= WEAPON_CATEGORY_LARGE_ARROW then
                if env(IsOutOfAmmo, 1) == TRUE then
                    ExecEventAllBody("W_NoArrow")
                    return
                else
                    SetVariable("NoAmmo", 0)
                    ExecEventHalfBlend(Event_AttackArrowRightStartContinue, ALLBODY)
                    return
                end
            elseif env(IsOutOfAmmo, 1) == TRUE then
                ExecEventAllBody("W_NoArrow")
                return
            else
                ExecEventHalfBlend(Event_AttackArrowRightStartContinue, ALLBODY)
                return
            end
        end
    end
    if MoveStartonCancelTiming(Event_Move, FALSE) == TRUE then
        return
    end
end

function AttackArrowLeftStart_Upper_onUpdate()
    act(SetIsPreciseShootingPossible)
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if ArrowCommonFunction(blend_type, FALSE, TURN_TYPE_STANCE) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        if g_ArrowSlot == 0 then
            if env(ActionDuration, ACTION_ARM_R1) > 0 then
                ExecEventHalfBlend(Event_AttackArrowLeftLoop, blend_type)
                return
            else
                ExecEventHalfBlend(Event_AttackArrowLeftFireMove, blend_type)
                return
            end
        elseif env(ActionDuration, ACTION_ARM_R2) > 0 then
            ExecEventHalfBlend(Event_AttackArrowLeftLoop, blend_type)
            return
        else
            ExecEventHalfBlend(Event_AttackArrowLeftFireMove, blend_type)
            return
        end
    end
    if ArrowLowerCommonFunction(Event_AttackArrowLeftStart, lower_state, FALSE) == TRUE then
        return
    end
end

function AttackArrowLeftStartContinue_Upper_onUpdate()
    act(SetIsPreciseShootingPossible)
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if ArrowCommonFunction(blend_type, FALSE, TURN_TYPE_STANCE) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        if g_ArrowSlot == 0 then
            if env(ActionDuration, ACTION_ARM_R1) > 0 then
                ExecEventHalfBlend(Event_AttackArrowLeftLoop, blend_type)
                return
            else
                ExecEventHalfBlend(Event_AttackArrowLeftFireMove, blend_type)
                return
            end
        elseif env(ActionDuration, ACTION_ARM_R2) > 0 then
            ExecEventHalfBlend(Event_AttackArrowLeftLoop, blend_type)
            return
        else
            ExecEventHalfBlend(Event_AttackArrowLeftFireMove, blend_type)
            return
        end
    end
    if ArrowLowerCommonFunction(Event_AttackArrowLeftStartContinue, lower_state, FALSE) == TRUE then
        return
    end
end

function AttackArrowLeftLoop_Upper_onUpdate()
    act(SetIsPreciseShootingPossible)
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if ArrowCommonFunction(blend_type, FALSE, TURN_TYPE_STANCE) == TRUE then
        return
    end
    if g_ArrowSlot == 0 then
        if 0 >= env(ActionDuration, ACTION_ARM_R1) then
            ExecEventHalfBlend(Event_AttackArrowLeftFireMove, blend_type)
            return
        end
    elseif 0 >= env(ActionDuration, ACTION_ARM_R2) then
        ExecEventHalfBlend(Event_AttackArrowLeftFireMove, blend_type)
        return
    end
    if ArrowLowerCommonFunction(Event_AttackArrowLeftLoop, lower_state, FALSE) == TRUE then
        return
    end
end

function AttackArrowLeftFire_onUpdate()
    act(SetIsPreciseShootingPossible)
    if ArrowCommonFunction(ALLBODY, TRUE, TURN_TYPE_DEFAULT) == TRUE then
        return
    end
    if env(GetStamina) <= 0 then
        return
    end
    local request = GetAttackRequest(FALSE)
    if request == ATTACK_REQUEST_ARROW_FIRE_LEFT or request == ATTACK_REQUEST_ARROW_FIRE_LEFT2 then
        if env(GetEquipWeaponCategory, HAND_LEFT) ~= WEAPON_CATEGORY_LARGE_ARROW then
            if env(IsOutOfAmmo, 0) == TRUE then
                ExecEventAllBody("W_NoArrow")
                return
            else
                if env(GetEquipWeaponCategory, HAND_LEFT) == WEAPON_CATEGORY_ARROW then
                    ExecEventHalfBlend(Event_AttackArrowLeftStartContinue, ALLBODY)
                else
                    ExecEventHalfBlend(Event_AttackArrowLeftStart, ALLBODY)
                end
                return
            end
        elseif env(IsOutOfAmmo, 0) == TRUE then
            ExecEventAllBody("W_NoArrow")
            return
        else
            ExecEventHalfBlend(Event_AttackArrowLeftStart, ALLBODY)
            return
        end
    end
    if MoveStartonCancelTiming(Event_Move, FALSE) == TRUE then
        return
    end
end

function AttackArrowLeftFireMove_Upper_onUpdate()
    act(SetIsPreciseShootingPossible)
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if ArrowCommonFunction(blend_type, TRUE, TURN_TYPE_DEFAULT) == TRUE then
        return
    end
    if env(GetStamina) > 0 then
        local request = GetAttackRequest(FALSE)
        if request == ATTACK_REQUEST_ARROW_FIRE_LEFT or request == ATTACK_REQUEST_ARROW_FIRE_LEFT2 then
            if env(GetEquipWeaponCategory, HAND_LEFT) ~= WEAPON_CATEGORY_LARGE_ARROW then
                if env(IsOutOfAmmo, 0) == TRUE then
                    ExecEventAllBody("W_NoArrow")
                    return
                else
                    SetVariable("NoAmmo", 0)
                    ExecEventHalfBlend(Event_AttackArrowLeftStartContinue, blend_type)
                    return
                end
            elseif env(IsOutOfAmmo, 0) == TRUE then
                ExecEventAllBody("W_NoArrow")
                return
            else
                ExecEventHalfBlend(Event_AttackArrowLeftStartContinue, blend_type)
                return
            end
        end
    end
    if MoveStartonCancelTiming(Event_Move, FALSE) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if ArrowLowerCommonFunction(Event_AttackArrowLeftFireMove, lower_state, FALSE) == TRUE then
        return
    end
end

function AttackArrowLeftFireDash_onUpdate()
    act(SetIsPreciseShootingPossible)
    if ArrowCommonFunction(ALLBODY, TRUE, TURN_TYPE_DEFAULT) == TRUE then
        return
    end
    if MoveStartonCancelTiming(Event_Move, FALSE) == TRUE then
        return
    end
end

function AttackArrowLeftFireStep_onUpdate()
    act(SetIsPreciseShootingPossible)
    if ArrowCommonFunction(ALLBODY, TRUE, TURN_TYPE_DEFAULT) == TRUE then
        return
    end
    if MoveStartonCancelTiming(Event_Move, FALSE) == TRUE then
        return
    end
end

function NoArrow_onUpdate()
    if ArrowCommonFunction(ALLBODY, TRUE, TURN_TYPE_DEFAULT) == TRUE then
        return
    end
    if MoveStartonCancelTiming(Event_Move, FALSE) == TRUE then
        return
    end
end

function StealthAttackArrow_Activate()
    local hand = HAND_RIGHT
    if c_Style == HAND_LEFT_BOTH then
        hand = HAND_LEFT
    end
    SetAttackHand(hand)
end

function StealthAttackArrowStart_Upper_onActivate()
    act(ResetInputQueue)
end

function StealthAttackArrowStart_Upper_onUpdate()
    act(SetIsPreciseShootingPossible)
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if ArrowCommonFunction(blend_type, FALSE, TURN_TYPE_STANCE) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        if g_ArrowSlot == 0 then
            if env(ActionDuration, ACTION_ARM_R1) > 0 then
                ExecEventHalfBlend(Event_StealthAttackArrowLoop, blend_type)
                return
            else
                ExecEventAllBody("W_StealthAttackArrowShot")
                return
            end
        elseif env(ActionDuration, ACTION_ARM_R2) > 0 then
            ExecEventHalfBlend(Event_StealthAttackArrowLoop, blend_type)
            return
        else
            ExecEventAllBody("W_StealthAttackArrowShot")
            return
        end
    end
    if ArrowLowerCommonFunction(Event_StealthAttackArrowStart, lower_state, FALSE) == TRUE then
        return
    end
end

function StealthAttackArrowStartContinue_Upper_onActivate()
    act(ResetInputQueue)
end

function StealthAttackArrowStartContinue_Upper_onUpdate()
    act(SetIsPreciseShootingPossible)
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if ArrowCommonFunction(blend_type, FALSE, TURN_TYPE_STANCE) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        if g_ArrowSlot == 0 then
            if env(ActionDuration, ACTION_ARM_R1) > 0 then
                ExecEventHalfBlend(Event_StealthAttackArrowLoop, blend_type)
                return
            else
                ExecEventAllBody("W_StealthAttackArrowShot")
                return
            end
        elseif env(ActionDuration, ACTION_ARM_R2) > 0 then
            ExecEventHalfBlend(Event_StealthAttackArrowLoop, blend_type)
            return
        else
            ExecEventAllBody("W_StealthAttackArrowShot")
            return
        end
    end
    if ArrowLowerCommonFunction(Event_StealthAttackArrowStartContinue, lower_state, FALSE) == TRUE then
        return
    end
end

function StealthAttackArrowLoop_Upper_onUpdate()
    act(SetIsPreciseShootingPossible)
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if ArrowCommonFunction(blend_type, FALSE, TURN_TYPE_STANCE) == TRUE then
        return
    end
    if g_ArrowSlot == 0 then
        if 0 >= env(ActionDuration, ACTION_ARM_R1) then
            ExecEventAllBody("W_StealthAttackArrowShot")
            return
        end
    elseif 0 >= env(ActionDuration, ACTION_ARM_R2) then
        ExecEventAllBody("W_StealthAttackArrowShot")
        return
    end
    if ArrowLowerCommonFunction(Event_StealthAttackArrowLoop, lower_state, FALSE) == TRUE then
        return
    end
end

function StealthAttackArrowShot_onUpdate()
    act(SetIsPreciseShootingPossible)
    SetStealthState(STEALTH_ATTACK_ARROWSHOT)
    if ArrowCommonFunction(blend_type, FALSE, TURN_TYPE_STANCE) == TRUE then
        return
    end
    if env(GetStamina) > 0 then
        local request = GetAttackRequest(FALSE)
        local hand = HAND_RIGHT
        local IsContinue = FALSE
        if request == ATTACK_REQUEST_ARROW_FIRE_RIGHT or request == ATTACK_REQUEST_ARROW_FIRE_RIGHT2 then
            IsContinue = TRUE
        elseif request == ATTACK_REQUEST_ARROW_FIRE_LEFT or request == ATTACK_REQUEST_ARROW_FIRE_LEFT2 then
            IsContinue = TRUE
            hand = HAND_LEFT
        end
        if IsContinue == TRUE then
            if env(GetEquipWeaponCategory, hand) ~= WEAPON_CATEGORY_LARGE_ARROW then
                if env(IsOutOfAmmo, hand) == TRUE then
                    ExecEventAllBody("W_NoArrow")
                    return
                else
                    SetVariable("NoAmmo", 0)
                    ExecEventHalfBlend(Event_StealthAttackArrowStartContinue, ALLBODY)
                    return
                end
            elseif env(IsOutOfAmmo, hand) == TRUE then
                ExecEventAllBody("W_NoArrow")
                return
            else
                ExecEventHalfBlend(Event_StealthAttackArrowStartContinue, ALLBODY)
                return
            end
        end
    end
    if env(IsMoveCancelPossible) == TRUE then
        if 0 < GetVariable("MoveSpeedLevel") then
            MoveStart(ALLBODY, Event_Stealth_Move, FALSE)
            return
        else
            hkbFireEvent("W_Stealth_Idle")
            return
        end
    end
end

-----------------------
-- Crossbow Triggers --
-----------------------

function AttackCrossbowRight_Activate()
    local hand = HAND_RIGHT
    if c_Style == HAND_LEFT_BOTH then
        hand = HAND_LEFT
    end
    SetAttackHand(hand)
    SetGuardHand(hand)
end

function AttackCrossbowLeft_Activate()
    SetAttackHand(HAND_LEFT)
    SetGuardHand(HAND_LEFT)
    ActivateRightArmAdd(START_FRAME_A02)
end

function AttackCrossbowLeft_Update()
    UpdateRightArmAdd()
end

function AttackCrossbowRightStart_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if CrossbowCommonFunction(blend_type, FALSE) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE or env(GetEventEzStateFlag, 0) == TRUE then
        if g_ArrowSlot == 0 then
            if env(ActionDuration, ACTION_ARM_R1) > 0 then
                ExecEventHalfBlend(Event_AttackCrossbowRightLoop, blend_type)
                return
            else
                ExecEventHalfBlend(Event_AttackCrossbowRightFire, blend_type)
                return
            end
        elseif env(ActionDuration, ACTION_ARM_R2) > 0 then
            ExecEventHalfBlend(Event_AttackCrossbowRightLoop, blend_type)
            return
        else
            ExecEventHalfBlend(Event_AttackCrossbowRightFire, blend_type)
            return
        end
    end
    if HalfBlendLowerCommonFunction(Event_AttackCrossbowRightLoop, lower_state, FALSE) == TRUE then
        return
    end
end

function AttackCrossbowRightLoop_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if CrossbowCommonFunction(blend_type, FALSE) == TRUE then
        return
    end
    if g_ArrowSlot == 0 then
        if 0 >= env(ActionDuration, ACTION_ARM_R1) then
            ExecEventHalfBlend(Event_AttackCrossbowRightFire, blend_type)
            return
        end
    elseif 0 >= env(ActionDuration, ACTION_ARM_R2) then
        ExecEventHalfBlend(Event_AttackCrossbowRightFire, blend_type)
        return
    end
    if HalfBlendLowerCommonFunction(Event_AttackCrossbowRightLoop, lower_state, FALSE) == TRUE then
        return
    end
end

function AttackCrossbowRightFire_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if CrossbowCommonFunction(blend_type, TRUE) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_AttackCrossbowRightFire, lower_state, FALSE) == TRUE then
        return
    end
end

function AttackCrossbowRightReload_Upper_onUpdate()
    act(Set4DirectionMovementThreshold, 60, 80, 60, 60)
    local blend_type, lower_state = GetHalfBlendInfo()
    if CrossbowCommonFunction(blend_type, TRUE) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_AttackCrossbowRightReload, lower_state, FALSE) == TRUE then
        return
    end
end

function AttackCrossbowRightEmpty_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if CrossbowCommonFunction(blend_type, TRUE) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_AttackCrossbowRightEmpty, lower_state, FALSE) == TRUE then
        return
    end
end

function AttackCrossbowLeftStart_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if CrossbowCommonFunction(blend_type, FALSE) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE or env(GetEventEzStateFlag, 0) == TRUE then
        if g_ArrowSlot == 0 then
            if env(ActionDuration, ACTION_ARM_L1) > 0 then
                ExecEventHalfBlend(Event_AttackCrossbowLeftLoop, blend_type)
                return
            else
                ExecEventHalfBlend(Event_AttackCrossbowLeftFire, blend_type)
                return
            end
        elseif env(ActionDuration, ACTION_ARM_L2) > 0 then
            ExecEventHalfBlend(Event_AttackCrossbowLeftLoop, blend_type)
            return
        else
            ExecEventHalfBlend(Event_AttackCrossbowLeftFire, blend_type)
            return
        end
    end
    if HalfBlendLowerCommonFunction(Event_AttackCrossbowLeftLoop, lower_state, FALSE) == TRUE then
        return
    end
end

function AttackCrossbowLeftLoop_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if CrossbowCommonFunction(blend_type, FALSE) == TRUE then
        return
    end
    if g_ArrowSlot == 0 then
        if 0 >= env(ActionDuration, ACTION_ARM_L1) then
            ExecEventHalfBlend(Event_AttackCrossbowLeftFire, blend_type)
            return
        end
    elseif 0 >= env(ActionDuration, ACTION_ARM_L2) then
        ExecEventHalfBlend(Event_AttackCrossbowLeftFire, blend_type)
        return
    end
    if HalfBlendLowerCommonFunction(Event_AttackCrossbowLeftLoop, lower_state, FALSE) == TRUE then
        return
    end
end

function AttackCrossbowLeftFire_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if CrossbowCommonFunction(blend_type, TRUE) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_AttackCrossbowLeftFire, lower_state, FALSE) == TRUE then
        return
    end
end

function AttackCrossbowLeftReload_Upper_onUpdate()
    act(Set4DirectionMovementThreshold, 60, 45, 60, 60)
    local blend_type, lower_state = GetHalfBlendInfo()
    if CrossbowCommonFunction(blend_type, TRUE) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_AttackCrossbowLeftReload, lower_state, FALSE) == TRUE then
        return
    end
end

function AttackCrossbowLeftEmpty_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if CrossbowCommonFunction(blend_type, TRUE) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_AttackCrossbowLeftEmpty, lower_state, FALSE) == TRUE then
        return
    end
end

function AttackCrossbowBothLeftStart_Upper_onUpdate()
    act(SetIsPreciseShootingPossible)
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if CrossbowCommonFunction(blend_type, FALSE) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        if g_ArrowSlot == 0 then
            if env(ActionDuration, ACTION_ARM_L1) > 0 then
                ExecEventHalfBlend(Event_AttackCrossbowBothLeftLoop, blend_type)
                return
            else
                ExecEventHalfBlend(Event_AttackCrossbowBothLeftFire, blend_type)
                return
            end
        elseif env(ActionDuration, ACTION_ARM_l2) > 0 then
            ExecEventHalfBlend(Event_AttackCrossbowBothLeftLoop, blend_type)
            return
        else
            ExecEventHalfBlend(Event_AttackCrossbowBothLeftFire, blend_type)
            return
        end
    end
    if HalfBlendLowerCommonFunction(Event_AttackCrossbowBothLeftLoop, lower_state, FALSE) == TRUE then
        return
    end
end

function AttackCrossbowBothLeftLoop_Upper_onUpdate()
    act(SetIsPreciseShootingPossible)
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if CrossbowCommonFunction(blend_type, FALSE) == TRUE then
        return
    end
    if g_ArrowSlot == 0 then
        if 0 >= env(ActionDuration, ACTION_ARM_L1) then
            ExecEventHalfBlend(Event_AttackCrossbowBothLeftFire, blend_type)
            return
        end
    elseif 0 >= env(ActionDuration, ACTION_ARM_L2) then
        ExecEventHalfBlend(Event_AttackCrossbowBothLeftFire, blend_type)
        return
    end
    if HalfBlendLowerCommonFunction(Event_AttackCrossbowBothLeftLoop, lower_state, FALSE) == TRUE then
        return
    end
end

function AttackCrossbowBothLeftFire_Upper_onUpdate()
    act(SetIsPreciseShootingPossible)
    local blend_type, lower_state = GetHalfBlendInfo()
    if CrossbowCommonFunction(blend_type, TRUE) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_AttackCrossbowBothLeftFire, lower_state, FALSE) == TRUE then
        return
    end
end

function AttackCrossbowBothLeftReload_Upper_onUpdate()
    act(Set4DirectionMovementThreshold, 60, 80, 60, 60)
    local blend_type, lower_state = GetHalfBlendInfo()
    if CrossbowCommonFunction(blend_type, TRUE) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_AttackCrossbowBothLeftReload, lower_state, FALSE) == TRUE then
        return
    end
end

function AttackCrossbowBothLeftEmpty_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if CrossbowCommonFunction(blend_type, TRUE) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_AttackCrossbowBothLeftEmpty, lower_state, FALSE) == TRUE then
        return
    end
end

function AttackCrossbowBothRightStart_Upper_onUpdate()
    act(SetIsPreciseShootingPossible)
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if CrossbowCommonFunction(blend_type, FALSE) == TRUE then
        return
    end
    local fireEvent = Event_AttackCrossbowBothRightFire
    if c_Style == HAND_LEFT_BOTH then
        fireEvent = Event_AttackCrossbowBothLeftFire
    end
    if env(IsAnimEnd, 1) == TRUE or env(GetEventEzStateFlag, 0) == TRUE then
        if g_ArrowSlot == 0 then
            if env(ActionDuration, ACTION_ARM_R1) > 0 then
                ExecEventHalfBlend(Event_AttackCrossbowBothRightLoop, blend_type)
                return
            else
                ExecEventHalfBlend(fireEvent, blend_type)
                return
            end
        elseif env(ActionDuration, ACTION_ARM_R2) > 0 then
            ExecEventHalfBlend(Event_AttackCrossbowBothRightLoop, blend_type)
            return
        else
            ExecEventHalfBlend(fireEvent, blend_type)
            return
        end
    end

    fireEvent = HalfBlendLowerCommonFunction
    fireEvent = fireEvent(Event_AttackCrossbowBothRightLoop, lower_state, FALSE)

    if fireEvent == TRUE then
        return
    end
end

function AttackCrossbowBothRightStartContinue_Upper_onUpdate()
    act(SetIsPreciseShootingPossible)
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if CrossbowCommonFunction(blend_type, FALSE) == TRUE then
        return
    end
    local fireEvent = Event_AttackCrossbowBothRightFire
    if c_Style == HAND_LEFT_BOTH then
        fireEvent = Event_AttackCrossbowBothLeftFire
    end
    if env(IsAnimEnd, 1) == TRUE or env(GetEventEzStateFlag, 0) == TRUE then
        if g_ArrowSlot == 0 then
            if env(ActionDuration, ACTION_ARM_R1) > 0 then
                ExecEventHalfBlend(Event_AttackCrossbowBothRightLoop, blend_type)
                return
            else
                ExecEventHalfBlend(fireEvent, blend_type)
                return
            end
        elseif env(ActionDuration, ACTION_ARM_R2) > 0 then
            ExecEventHalfBlend(Event_AttackCrossbowBothRightLoop, blend_type)
            return
        else
            ExecEventHalfBlend(fireEvent, blend_type)
            return
        end
    end

    fireEvent = HalfBlendLowerCommonFunction
    fireEvent = fireEvent(Event_AttackCrossbowBothRightLoop, lower_state, FALSE)

    if fireEvent == TRUE then
        return
    end
end

function AttackCrossbowBothRightLoop_Upper_onUpdate()
    act(SetIsPreciseShootingPossible)
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if CrossbowCommonFunction(blend_type, FALSE) == TRUE then
        return
    end
    local fireEvent = Event_AttackCrossbowBothRightFire
    if c_Style == HAND_LEFT_BOTH then
        fireEvent = Event_AttackCrossbowBothLeftFire
    end
    if g_ArrowSlot == 0 then
        if 0 >= env(ActionDuration, ACTION_ARM_R1) then
            ExecEventHalfBlend(fireEvent, blend_type)
            return
        end
    elseif 0 >= env(ActionDuration, ACTION_ARM_R2) then
        ExecEventHalfBlend(fireEvent, blend_type)
        return
    end

    fireEvent = HalfBlendLowerCommonFunction
    fireEvent = fireEvent(Event_AttackCrossbowBothRightLoop, lower_state, FALSE)

    if fireEvent == TRUE then
        return
    end
end

function AttackCrossbowBothRightFire_Upper_onUpdate()
    act(SetIsPreciseShootingPossible)
    local attackHand = HAND_RIGHT

    if c_Style == HAND_LEFT_BOTH then
        attackHand = HAND_LEFT
    end

    local blend_type, lower_state = GetHalfBlendInfo()

    if CrossbowCommonFunction(blend_type, TRUE) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_AttackCrossbowBothRightFire, lower_state, FALSE) == TRUE then
        return
    end
end

function AttackCrossbowBothRightReload_Upper_onUpdate()
    act(SetIsPreciseShootingPossible)
    act(Set4DirectionMovementThreshold, 60, 80, 60, 60)
    local blend_type, lower_state = GetHalfBlendInfo()

    if CrossbowCommonFunction(blend_type, TRUE) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_AttackCrossbowBothRightReload, lower_state, FALSE) == TRUE then
        return
    end
end

function AttackCrossbowBothRightEmpty_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()

    if CrossbowCommonFunction(blend_type, TRUE) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_AttackCrossbowBothRightEmpty, lower_state, FALSE) == TRUE then
        return
    end
end

function StealthAttackCrossbowRightStart_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if CrossbowCommonFunction(blend_type, FALSE) == TRUE then
        return
    end

    if env(IsAnimEnd, 1) == TRUE then
        if g_ArrowSlot == 0 then
            if env(ActionDuration, ACTION_ARM_R1) > 0 then
                ExecEventHalfBlend(Event_StealthAttackCrossbowRightLoop, blend_type)
                return
            else
                ExecEventHalfBlend(Event_StealthAttackCrossbowRightFire, blend_type)
                return
            end
        elseif env(ActionDuration, ACTION_ARM_R2) > 0 then
            ExecEventHalfBlend(Event_StealthAttackCrossbowRightLoop, blend_type)
            return
        else
            ExecEventHalfBlend(Event_StealthAttackCrossbowRightFire, blend_type)
            return
        end
    end
    if HalfBlendLowerCommonFunction(Event_StealthAttackCrossbowRightLoop, lower_state, FALSE) == TRUE then
        return
    end
end

function StealthAttackCrossbowRightLoop_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if CrossbowCommonFunction(blend_type, FALSE) == TRUE then
        return
    end
    if g_ArrowSlot == 0 then
        if 0 >= env(ActionDuration, ACTION_ARM_R1) then
            ExecEventHalfBlend(Event_StealthAttackCrossbowRightFire, blend_type)
            return
        end
    elseif 0 >= env(ActionDuration, ACTION_ARM_R2) then
        ExecEventHalfBlend(Event_StealthAttackCrossbowRightFire, blend_type)
        return
    end
    if HalfBlendLowerCommonFunction(Event_StealthAttackCrossbowRightLoop, lower_state, FALSE) == TRUE then
        return
    end
end

function StealthAttackCrossbowRightFire_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if CrossbowCommonFunction(blend_type, TRUE) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_StealthAttackCrossbowRightFire, lower_state, FALSE) == TRUE then
        return
    end
    if env(IsMoveCancelPossible) == TRUE then
        if GetVariable("MoveSpeedLevel") > 0 then
            MoveStart(ALLBODY, Event_Stealth_Move, FALSE)
            return
        else
            hkbFireEvent("W_Stealth_Idle")
            return
        end
    end
end

function StealthAttackCrossbowRightEmpty_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if CrossbowCommonFunction(blend_type, TRUE) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_StealthAttackCrossbowRightEmpty, lower_state, FALSE) == TRUE then
        return
    end
    if env(IsMoveCancelPossible) == TRUE then
        if GetVariable("MoveSpeedLevel") > 0 then
            MoveStart(ALLBODY, Event_Stealth_Move, FALSE)
            return
        else
            hkbFireEvent("W_Stealth_Idle")
            return
        end
    end
end

function StealthAttackCrossbowRightReload_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if CrossbowCommonFunction(blend_type, TRUE) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_StealthAttackCrossbowRightReload, lower_state, FALSE) == TRUE then
        return
    end
    if env(IsMoveCancelPossible) == TRUE then
        if GetVariable("MoveSpeedLevel") > 0 then
            MoveStart(ALLBODY, Event_Stealth_Move, FALSE)
            return
        else
            hkbFireEvent("W_Stealth_Idle")
            return
        end
    end
end

function StealthAttackCrossbowLeftStart_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if CrossbowCommonFunction(blend_type, FALSE) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        if g_ArrowSlot == 0 then
            if env(ActionDuration, ACTION_ARM_L1) > 0 then
                ExecEventHalfBlend(Event_StealthAttackCrossbowLeftLoop, blend_type)
                return
            else
                ExecEventHalfBlend(Event_StealthAttackCrossbowLeftFire, blend_type)
                return
            end
        elseif env(ActionDuration, ACTION_ARM_L2) > 0 then
            ExecEventHalfBlend(Event_StealthAttackCrossbowLeftLoop, blend_type)
            return
        else
            ExecEventHalfBlend(Event_StealthAttackCrossbowLeftFire, blend_type)
            return
        end
    end
    if HalfBlendLowerCommonFunction(Event_StealthAttackCrossbowLeftLoop, lower_state, FALSE) == TRUE then
        return
    end
    if env(IsMoveCancelPossible) == TRUE then
        if 0 < GetVariable("MoveSpeedLevel") then
            MoveStart(ALLBODY, Event_Stealth_Move, FALSE)
            return
        else
            hkbFireEvent("W_Stealth_Idle")
            return
        end
    end
end

function StealthAttackCrossbowLeftLoop_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if CrossbowCommonFunction(blend_type, FALSE) == TRUE then
        return
    end
    if g_ArrowSlot == 0 then
        if 0 >= env(ActionDuration, ACTION_ARM_L1) then
            ExecEventHalfBlend(Event_StealthAttackCrossbowLeftFire, blend_type)
            return
        end
    elseif 0 >= env(ActionDuration, ACTION_ARM_L2) then
        ExecEventHalfBlend(Event_StealthAttackCrossbowLeftFire, blend_type)
        return
    end
    if HalfBlendLowerCommonFunction(Event_StealthAttackCrossbowLeftLoop, lower_state, FALSE) == TRUE then
        return
    end
end

function StealthAttackCrossbowLeftFire_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if CrossbowCommonFunction(blend_type, TRUE) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_StealthAttackCrossbowLeftFire, lower_state, FALSE) == TRUE then
        return
    end
    if env(IsMoveCancelPossible) == TRUE then
        if GetVariable("MoveSpeedLevel") > 0 then
            MoveStart(ALLBODY, Event_Stealth_Move, FALSE)
            return
        else
            hkbFireEvent("W_Stealth_Idle")
            return
        end
    end
end

function StealthAttackCrossbowLeftEmpty_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if CrossbowCommonFunction(blend_type, TRUE) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_StealthAttackCrossbowLeftEmpty, lower_state, FALSE) == TRUE then
        return
    end
    if env(IsMoveCancelPossible) == TRUE then
        if GetVariable("MoveSpeedLevel") > 0 then
            MoveStart(ALLBODY, Event_Stealth_Move, FALSE)
            return
        else
            hkbFireEvent("W_Stealth_Idle")
            return
        end
    end
end

function StealthAttackCrossbowLeftReload_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if CrossbowCommonFunction(blend_type, TRUE) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_StealthAttackCrossbowLeftReload, lower_state, FALSE) == TRUE then
        return
    end
    if env(IsMoveCancelPossible) == TRUE then
        if GetVariable("MoveSpeedLevel") > 0 then
            MoveStart(ALLBODY, Event_Stealth_Move, FALSE)
            return
        else
            hkbFireEvent("W_Stealth_Idle")
            return
        end
    end
end

function StealthAttackCrossbowBothLeftStart_Upper_onUpdate()
    act(SetIsPreciseShootingPossible)
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if CrossbowCommonFunction(blend_type, FALSE) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        if g_ArrowSlot == 0 then
            if env(ActionDuration, ACTION_ARM_L1) > 0 then
                ExecEventHalfBlend(Event_StealthAttackCrossbowBothLeftLoop, blend_type)
                return
            else
                ExecEventHalfBlend(Event_StealthAttackCrossbowBothLeftFire, blend_type)
                return
            end
        elseif env(ActionDuration, ACTION_ARM_l2) > 0 then
            ExecEventHalfBlend(Event_StealthAttackCrossbowBothLeftLoop, blend_type)
            return
        else
            ExecEventHalfBlend(Event_StealthAttackCrossbowBothLeftFire, blend_type)
            return
        end
    end
    if HalfBlendLowerCommonFunction(Event_StealthAttackCrossbowBothLeftLoop, lower_state, FALSE) == TRUE then
        return
    end
end

function StealthAttackCrossbowBothLeftLoop_Upper_onUpdate()
    act(SetIsPreciseShootingPossible)
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if CrossbowCommonFunction(blend_type, FALSE) == TRUE then
        return
    end
    if g_ArrowSlot == 0 then
        if 0 >= env(ActionDuration, ACTION_ARM_L1) then
            ExecEventHalfBlend(Event_StealthAttackCrossbowBothLeftFire, blend_type)
            return
        end
    elseif 0 >= env(ActionDuration, ACTION_ARM_L2) then
        ExecEventHalfBlend(Event_StealthAttackCrossbowBothLeftFire, blend_type)
        return
    end
    if HalfBlendLowerCommonFunction(Event_StealthAttackCrossbowBothLeftLoop, lower_state, FALSE) == TRUE then
        return
    end
end

function StealthAttackCrossbowBothLeftFire_Upper_onUpdate()
    act(SetIsPreciseShootingPossible)
    local blend_type, lower_state = GetHalfBlendInfo()
    if CrossbowCommonFunction(blend_type, TRUE) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_StealthAttackCrossbowBothLeftFire, lower_state, FALSE) == TRUE then
        return
    end
    if env(IsMoveCancelPossible) == TRUE then
        if GetVariable("MoveSpeedLevel") > 0 then
            MoveStart(ALLBODY, Event_Stealth_Move, FALSE)
            return
        else
            hkbFireEvent("W_Stealth_Idle")
            return
        end
    end
end

function StealthAttackCrossbowBothLeftEmpty_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if CrossbowCommonFunction(blend_type, TRUE) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_StealthAttackCrossbowBothLeftEmpty, lower_state, FALSE) == TRUE then
        return
    end
    if env(IsMoveCancelPossible) == TRUE then
        if GetVariable("MoveSpeedLevel") > 0 then
            MoveStart(ALLBODY, Event_Stealth_Move, FALSE)
            return
        else
            hkbFireEvent("W_Stealth_Idle")
            return
        end
    end
end

function StealthAttackCrossbowBothLeftReload_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if CrossbowCommonFunction(blend_type, TRUE) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_StealthAttackCrossbowBothLeftReload, lower_state, FALSE) == TRUE then
        return
    end
    if env(IsMoveCancelPossible) == TRUE then
        if GetVariable("MoveSpeedLevel") > 0 then
            MoveStart(ALLBODY, Event_Stealth_Move, FALSE)
            return
        else
            hkbFireEvent("W_Stealth_Idle")
            return
        end
    end
end

function StealthAttackCrossbowBothRightStart_Upper_onUpdate()
    act(SetIsPreciseShootingPossible)
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if CrossbowCommonFunction(blend_type, FALSE) == TRUE then
        return
    end
    local fireEvent = Event_StealthAttackCrossbowBothRightFire
    if c_Style == HAND_LEFT_BOTH then
        fireEvent = Event_StealthAttackCrossbowBothLeftFire
    end
    if env(IsAnimEnd, 1) == TRUE then
        if g_ArrowSlot == 0 then
            if env(ActionDuration, ACTION_ARM_R1) > 0 then
                ExecEventHalfBlend(Event_StealthAttackCrossbowBothRightLoop, blend_type)
                return
            else
                ExecEventHalfBlend(fireEvent, blend_type)
                return
            end
        elseif env(ActionDuration, ACTION_ARM_R2) > 0 then
            ExecEventHalfBlend(Event_StealthAttackCrossbowBothRightLoop, blend_type)
            return
        else
            ExecEventHalfBlend(fireEvent, blend_type)
            return
        end
    end

    fireEvent = HalfBlendLowerCommonFunction
    fireEvent = fireEvent(Event_StealthAttackCrossbowBothRightLoop, lower_state, FALSE)

    if fireEvent == TRUE then
        return
    end
end

function StealthAttackCrossbowBothRightLoop_Upper_onUpdate()
    act(SetIsPreciseShootingPossible)
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if CrossbowCommonFunction(blend_type, FALSE) == TRUE then
        return
    end
    local fireEvent = Event_StealthAttackCrossbowBothRightFire
    if c_Style == HAND_LEFT_BOTH then
        fireEvent = Event_StealthAttackCrossbowBothLeftFire
    end
    if g_ArrowSlot == 0 then
        if 0 >= env(ActionDuration, ACTION_ARM_R1) then
            ExecEventHalfBlend(fireEvent, blend_type)
            return
        end
    elseif 0 >= env(ActionDuration, ACTION_ARM_R2) then
        ExecEventHalfBlend(fireEvent, blend_type)
        return
    end

    fireEvent = HalfBlendLowerCommonFunction
    fireEvent = fireEvent(Event_StealthAttackCrossbowBothRightLoop, lower_state, FALSE)

    if fireEvent == TRUE then
        return
    end
end

function StealthAttackCrossbowBothRightFire_Upper_onUpdate()
    act(SetIsPreciseShootingPossible)
    local blend_type, lower_state = GetHalfBlendInfo()

    if CrossbowCommonFunction(blend_type, TRUE) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_StealthAttackCrossbowBothRightFire, lower_state, FALSE) == TRUE then
        return
    end
    if env(IsMoveCancelPossible) == TRUE then
        if GetVariable("MoveSpeedLevel") > 0 then
            MoveStart(ALLBODY, Event_Stealth_Move, FALSE)
            return
        else
            hkbFireEvent("W_Stealth_Idle")
            return
        end
    end
end

function StealthAttackCrossbowBothRightReload_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()

    if CrossbowCommonFunction(blend_type, TRUE) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_StealthAttackCrossbowBothRightReload, lower_state, FALSE) == TRUE then
        return
    end
    if env(IsMoveCancelPossible) == TRUE then
        if GetVariable("MoveSpeedLevel") > 0 then
            MoveStart(ALLBODY, Event_Stealth_Move, FALSE)
            return
        else
            hkbFireEvent("W_Stealth_Idle")
            return
        end
    end
end

function StealthAttackCrossbowBothRightEmpty_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()

    if CrossbowCommonFunction(blend_type, TRUE) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_StealthAttackCrossbowBothRightEmpty, lower_state, FALSE) == TRUE then
        return
    end
    if env(IsMoveCancelPossible) == TRUE then
        if GetVariable("MoveSpeedLevel") > 0 then
            MoveStart(ALLBODY, Event_Stealth_Move, FALSE)
            return
        else
            hkbFireEvent("W_Stealth_Idle")
            return
        end
    end
end


ExecArrowBothJumpLandAttack = hookup_function(ExecArrowBothJumpLandAttack)
ArrowCommonFunction = hookup_function(ArrowCommonFunction)
CrossbowCommonFunction = hookup_function(CrossbowCommonFunction)
ArrowLowerCommonFunction = hookup_function(ArrowLowerCommonFunction)
AttackArrowRight_Activate = hookup_function(AttackArrowRight_Activate)
AttackArrowLeft_Activate = hookup_function(AttackArrowLeft_Activate)
AttackArrowRightStart_Upper_onUpdate = hookup_function(AttackArrowRightStart_Upper_onUpdate)
AttackArrowRightStartContinue_Upper_onUpdate = hookup_function(AttackArrowRightStartContinue_Upper_onUpdate)
AttackArrowRightLoop_Upper_onUpdate = hookup_function(AttackArrowRightLoop_Upper_onUpdate)
AttackArrowRightFire_onUpdate = hookup_function(AttackArrowRightFire_onUpdate)
AttackArrowRightFireMove_Upper_onUpdate = hookup_function(AttackArrowRightFireMove_Upper_onUpdate)
AttackArrowRightFireDash_onUpdate = hookup_function(AttackArrowRightFireDash_onUpdate)
AttackArrowRightFireStep_onUpdate = hookup_function(AttackArrowRightFireStep_onUpdate)
AttackArrowLeftStart_Upper_onUpdate = hookup_function(AttackArrowLeftStart_Upper_onUpdate)
AttackArrowLeftStartContinue_Upper_onUpdate = hookup_function(AttackArrowLeftStartContinue_Upper_onUpdate)
AttackArrowLeftLoop_Upper_onUpdate = hookup_function(AttackArrowLeftLoop_Upper_onUpdate)
AttackArrowLeftFire_onUpdate = hookup_function(AttackArrowLeftFire_onUpdate)
AttackArrowLeftFireMove_Upper_onUpdate = hookup_function(AttackArrowLeftFireMove_Upper_onUpdate)
AttackArrowLeftFireDash_onUpdate = hookup_function(AttackArrowLeftFireDash_onUpdate)
AttackArrowLeftFireStep_onUpdate = hookup_function(AttackArrowLeftFireStep_onUpdate)
NoArrow_onUpdate = hookup_function(NoArrow_onUpdate)
StealthAttackArrow_Activate = hookup_function(StealthAttackArrow_Activate)
StealthAttackArrowStart_Upper_onActivate = hookup_function(StealthAttackArrowStart_Upper_onActivate)
StealthAttackArrowStart_Upper_onUpdate = hookup_function(StealthAttackArrowStart_Upper_onUpdate)
StealthAttackArrowStartContinue_Upper_onActivate = hookup_function(StealthAttackArrowStartContinue_Upper_onActivate)
StealthAttackArrowStartContinue_Upper_onUpdate = hookup_function(StealthAttackArrowStartContinue_Upper_onUpdate)
StealthAttackArrowLoop_Upper_onUpdate = hookup_function(StealthAttackArrowLoop_Upper_onUpdate)
StealthAttackArrowShot_onUpdate = hookup_function(StealthAttackArrowShot_onUpdate)
AttackCrossbowRight_Activate = hookup_function(AttackCrossbowRight_Activate)
AttackCrossbowLeft_Activate = hookup_function(AttackCrossbowLeft_Activate)
AttackCrossbowLeft_Update = hookup_function(AttackCrossbowLeft_Update)
AttackCrossbowRightStart_Upper_onUpdate = hookup_function(AttackCrossbowRightStart_Upper_onUpdate)
AttackCrossbowRightLoop_Upper_onUpdate = hookup_function(AttackCrossbowRightLoop_Upper_onUpdate)
AttackCrossbowRightFire_Upper_onUpdate = hookup_function(AttackCrossbowRightFire_Upper_onUpdate)
AttackCrossbowRightReload_Upper_onUpdate = hookup_function(AttackCrossbowRightReload_Upper_onUpdate)
AttackCrossbowRightEmpty_Upper_onUpdate = hookup_function(AttackCrossbowRightEmpty_Upper_onUpdate)
AttackCrossbowLeftStart_Upper_onUpdate = hookup_function(AttackCrossbowLeftStart_Upper_onUpdate)
AttackCrossbowLeftLoop_Upper_onUpdate = hookup_function(AttackCrossbowLeftLoop_Upper_onUpdate)
AttackCrossbowLeftFire_Upper_onUpdate = hookup_function(AttackCrossbowLeftFire_Upper_onUpdate)
AttackCrossbowLeftReload_Upper_onUpdate = hookup_function(AttackCrossbowLeftReload_Upper_onUpdate)
AttackCrossbowLeftEmpty_Upper_onUpdate = hookup_function(AttackCrossbowLeftEmpty_Upper_onUpdate)
AttackCrossbowBothLeftStart_Upper_onUpdate = hookup_function(AttackCrossbowBothLeftStart_Upper_onUpdate)
AttackCrossbowBothLeftLoop_Upper_onUpdate = hookup_function(AttackCrossbowBothLeftLoop_Upper_onUpdate)
AttackCrossbowBothLeftFire_Upper_onUpdate = hookup_function(AttackCrossbowBothLeftFire_Upper_onUpdate)
AttackCrossbowBothLeftReload_Upper_onUpdate = hookup_function(AttackCrossbowBothLeftReload_Upper_onUpdate)
AttackCrossbowBothLeftEmpty_Upper_onUpdate = hookup_function(AttackCrossbowBothLeftEmpty_Upper_onUpdate)
AttackCrossbowBothRightStart_Upper_onUpdate = hookup_function(AttackCrossbowBothRightStart_Upper_onUpdate)
AttackCrossbowBothRightStartContinue_Upper_onUpdate = hookup_function(AttackCrossbowBothRightStartContinue_Upper_onUpdate)
AttackCrossbowBothRightLoop_Upper_onUpdate = hookup_function(AttackCrossbowBothRightLoop_Upper_onUpdate)
AttackCrossbowBothRightFire_Upper_onUpdate = hookup_function(AttackCrossbowBothRightFire_Upper_onUpdate)
AttackCrossbowBothRightReload_Upper_onUpdate = hookup_function(AttackCrossbowBothRightReload_Upper_onUpdate)
AttackCrossbowBothRightEmpty_Upper_onUpdate = hookup_function(AttackCrossbowBothRightEmpty_Upper_onUpdate)
StealthAttackCrossbowRightStart_Upper_onUpdate = hookup_function(StealthAttackCrossbowRightStart_Upper_onUpdate)
StealthAttackCrossbowRightLoop_Upper_onUpdate = hookup_function(StealthAttackCrossbowRightLoop_Upper_onUpdate)
StealthAttackCrossbowRightFire_Upper_onUpdate = hookup_function(StealthAttackCrossbowRightFire_Upper_onUpdate)
StealthAttackCrossbowRightEmpty_Upper_onUpdate = hookup_function(StealthAttackCrossbowRightEmpty_Upper_onUpdate)
StealthAttackCrossbowRightReload_Upper_onUpdate = hookup_function(StealthAttackCrossbowRightReload_Upper_onUpdate)
StealthAttackCrossbowLeftStart_Upper_onUpdate = hookup_function(StealthAttackCrossbowLeftStart_Upper_onUpdate)
StealthAttackCrossbowLeftLoop_Upper_onUpdate = hookup_function(StealthAttackCrossbowLeftLoop_Upper_onUpdate)
StealthAttackCrossbowLeftFire_Upper_onUpdate = hookup_function(StealthAttackCrossbowLeftFire_Upper_onUpdate)
StealthAttackCrossbowLeftEmpty_Upper_onUpdate = hookup_function(StealthAttackCrossbowLeftEmpty_Upper_onUpdate)
StealthAttackCrossbowLeftReload_Upper_onUpdate = hookup_function(StealthAttackCrossbowLeftReload_Upper_onUpdate)
StealthAttackCrossbowBothLeftStart_Upper_onUpdate = hookup_function(StealthAttackCrossbowBothLeftStart_Upper_onUpdate)
StealthAttackCrossbowBothLeftLoop_Upper_onUpdate = hookup_function(StealthAttackCrossbowBothLeftLoop_Upper_onUpdate)
StealthAttackCrossbowBothLeftFire_Upper_onUpdate = hookup_function(StealthAttackCrossbowBothLeftFire_Upper_onUpdate)
StealthAttackCrossbowBothLeftEmpty_Upper_onUpdate = hookup_function(StealthAttackCrossbowBothLeftEmpty_Upper_onUpdate)
StealthAttackCrossbowBothLeftReload_Upper_onUpdate = hookup_function(StealthAttackCrossbowBothLeftReload_Upper_onUpdate)
StealthAttackCrossbowBothRightStart_Upper_onUpdate = hookup_function(StealthAttackCrossbowBothRightStart_Upper_onUpdate)
StealthAttackCrossbowBothRightLoop_Upper_onUpdate = hookup_function(StealthAttackCrossbowBothRightLoop_Upper_onUpdate)
StealthAttackCrossbowBothRightFire_Upper_onUpdate = hookup_function(StealthAttackCrossbowBothRightFire_Upper_onUpdate)
StealthAttackCrossbowBothRightReload_Upper_onUpdate = hookup_function(StealthAttackCrossbowBothRightReload_Upper_onUpdate)
StealthAttackCrossbowBothRightEmpty_Upper_onUpdate = hookup_function(StealthAttackCrossbowBothRightEmpty_Upper_onUpdate)
