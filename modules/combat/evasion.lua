c_RollingAngle = 0
c_ArtsRollingAngle = 0

function GetEvasionRequest()
    if env(GetStamina) < STAMINA_MINIMUM then
        return ATTACK_REQUEST_INVALID
    end
    if env(ActionRequest, ACTION_ARM_ROLLING) == TRUE then
        return ATTACK_REQUEST_ROLLING
    elseif env(ActionDuration, ACTION_ARM_L1) > 0 then
        if env(ActionRequest, ACTION_ARM_EMERGENCYSTEP) == TRUE then
            if env(IsEmergencyEvasionPossible, 0) == TRUE or env(IsEmergencyEvasionPossible, 1) == TRUE then
                return ATTACK_REQUEST_EMERGENCYSTEP
            end
        elseif env(ActionRequest, ACTION_ARM_BACKSTEP) == TRUE then
            return ATTACK_REQUEST_BACKSTEP
        else
            return ATTACK_REQUEST_INVALID
        end
    elseif env(ActionRequest, ACTION_ARM_BACKSTEP) == TRUE then
        return ATTACK_REQUEST_BACKSTEP
    end
    return ATTACK_REQUEST_INVALID
end

function ExecEvasion(backstep_limit, estep, is_usechainrecover)
    if c_HasActionRequest == FALSE then
        return FALSE
    end

    local request = GetEvasionRequest()

    if env(ActionRequest, ACTION_ARM_L3) == TRUE and c_IsStealth == FALSE then
        StealthTransitionIndexUpdate()
        ExecEvent("W_Stealth_to_Stealth_Idle")
        return TRUE
    elseif env(ActionRequest, ACTION_ARM_L3) == TRUE and c_IsStealth == TRUE then
        StealthTransitionIndexUpdate()
        ExecEvent("W_Stealth_to_Idle")
        return TRUE
    end
    if request == ATTACK_REQUEST_INVALID then
        return FALSE
    end
    if backstep_limit == TRUE and request == ATTACK_REQUEST_BACKSTEP and env(GetEventEzStateFlag, 0) == TRUE then
        return FALSE
    end

    SetWeightIndex()

    -----------------------
    -- Roll
    -----------------------
    if request == ATTACK_REQUEST_ROLLING then
        if is_usechainrecover == TRUE then
            local damagecount = GetVariable("DamageCount")
            if damagecount >= 4 then
                if env(GetEventEzStateFlag, 5) == FALSE then
                    return FALSE
                end
            elseif damagecount == 3 then
                if env(GetEventEzStateFlag, 4) == FALSE then
                    return FALSE
                end
            elseif damagecount == 2 then
                if env(GetEventEzStateFlag, 3) == FALSE then
                    return FALSE
                end
            elseif damagecount <= 1 and env(GetEventEzStateFlag, 2) == FALSE then
                if env(GetSpEffectID, 100720) == TRUE then
                    ResetRequest()
                end
                return FALSE
            end
        end

        if env(GetStamina) <= 0 then
            ResetRequest()
            return FALSE
        end
        if env(GetFallHeight) > 150 then
            return FALSE
        end

        local rollingEvent = "W_Rolling"
        local is_selfTrans = FALSE

        if IsNodeActive("Rolling_CMSG") == TRUE then
            is_selfTrans = TRUE
        end

        if estep == ESTEP_DOWN then
            rollingEvent = "W_EStepDown"
        elseif c_IsStealth == TRUE and GetVariable("EvasionWeightIndex") ~= EVASION_WEIGHT_INDEX_OVERWEIGHT then
            rollingEvent = "W_Stealth_Rolling"
        elseif is_selfTrans == TRUE then
            rollingEvent = rollingEvent .. "_Selftrans"
        end

        if env(GetSpEffectID, 102360) == FALSE then
            AddStamina(STAMINA_REDUCE_ROLLING)
        end

        if GetVariable("IsEnableToggleDashTest") == 2 then
            SetVariable("ToggleDash", 0)
        end

        local turn_angle_real = 200

        if GetVariable("IsLockon") == false and env(IsPrecisionShoot) == FALSE and env(IsCOMPlayer) == FALSE or
            env(GetSpEffectID, 100002) == TRUE then
            SetVariable("RollingOverweightIndex", 0)

            if is_selfTrans == TRUE then
                SetVariable("RollingDirectionIndex_SelfTrans", 0)
            else
                SetVariable("RollingDirectionIndex", 0)
            end
        elseif GetVariable("EvasionWeightIndex") == EVASION_WEIGHT_INDEX_OVERWEIGHT then
            if c_RollingAngle <= 45 and c_RollingAngle >= -45 then
                SetVariable("RollingOverweightIndex", 0)
            elseif c_RollingAngle > 45 and c_RollingAngle < 135 then
                SetVariable("RollingOverweightIndex", 3)
            elseif c_RollingAngle >= 135 then
                SetVariable("RollingOverweightIndex", 1)
            elseif c_RollingAngle < -45 and c_RollingAngle > -135 then
                SetVariable("RollingOverweightIndex", 2)
            else
                SetVariable("RollingOverweightIndex", 1)
            end

            act(TurnToLockonTargetImmediately)

            turn_angle_real = math.abs(GetVariable("TurnAngle") - c_RollingAngle)

            if turn_angle_real > 180 then
                turn_angle_real = 360 - turn_angle_real
            end
        else
            local turn_target_angle = 0
            local rollingDirection = 0

            if c_RollingAngle <= GetVariable("RollingAngleThresholdRightFrontTest") and c_RollingAngle >=
                GetVariable("RollingAngleThresholdLeftFrontTest") then
                rollingDirection = 0
                turn_target_angle = c_RollingAngle
            elseif c_RollingAngle > GetVariable("RollingAngleThresholdRightFrontTest") and c_RollingAngle <
                GetVariable("RollingAngleThresholdRightBackTest") then
                rollingDirection = 3
                turn_target_angle = c_RollingAngle - 90
            elseif c_RollingAngle < GetVariable("RollingAngleThresholdLeftFrontTest") and c_RollingAngle >
                GetVariable("RollingAngleThresholdLeftBackTest") then
                rollingDirection = 2
                turn_target_angle = c_RollingAngle + 90
            else
                rollingDirection = 1
                turn_target_angle = c_RollingAngle - 180
            end

            if is_selfTrans == TRUE then
                SetVariable("RollingDirectionIndex_SelfTrans", rollingDirection)
            else
                SetVariable("RollingDirectionIndex", rollingDirection)
            end

            if GetVariable("IsLockon") == true then
                act(TurnToLockonTargetImmediately, turn_target_angle)
            else
                act(FaceDirection, turn_target_angle)
            end

            turn_angle_real = math.abs(GetVariable("TurnAngle") - c_RollingAngle)

            if turn_angle_real > 180 then
                turn_angle_real = 360 - turn_angle_real
            end
        end

        SetVariable("TurnAngleReal", turn_angle_real)

        if is_selfTrans == TRUE then
            SetVariable("RollingAngleRealSelftrans", c_RollingAngle)
        else
            SetVariable("RollingAngleReal", c_RollingAngle)
        end

        ExecEventAllBody(rollingEvent)
    elseif request == ATTACK_REQUEST_EMERGENCYSTEP then
        if MoveStart(ALLBODY, Event_ChainRecover, FALSE) then
        else
            return FALSE
        end
    elseif request == ATTACK_REQUEST_BACKSTEP then
        ResetDamageCount()

        if env(GetStamina) <= 0 then
            ResetRequest()
            return FALSE
        end
        if env(GetSpEffectID, 102360) == FALSE then
            AddStamina(STAMINA_REDUCE_BACKSTEP)
        end

        if IsEnableGuard() == TRUE and IsGuard() == TRUE and GetVariable("EvasionWeightIndex") ~=
            EVASION_WEIGHT_INDEX_OVERWEIGHT then
            SetVariable("BackStepGuardLayer", 1)
            SetVariable("EnableTAE_BackStep", false)
            ExecEvent("W_DefaultBackStep")
            ExecEvent("W_BackStepGuardOn_UpperLayer")
        else
            SetVariable("BackStepGuardLayer", 0)
            SetVariable("EnableTAE_BackStep", true)
            ExecEventAllBody("W_DefaultBackStep")
        end
    else
        return FALSE
    end

    if GetVariable("IsEnableToggleDashTest") == 2 then
        SetVariable("ToggleDash", 0)
    end

    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    SetAIActionState()

    return TRUE
end

function Evasion_Activate()
    ActivateRightArmAdd(START_FRAME_A02)
end

function Evasion_Update()
    UpdateRightArmAdd()
end

function Evasion_Deactivate()
end

function SetRollingTurnCondition(is_selftrans)
    local rolling_angle = "RollingAngleReal"

    if is_selftrans == TRUE then
        rolling_angle = "RollingAngleRealSelftrans"
    end

    if GetVariable("IsLockon") == true then
        local angle = GetVariable("TurnAngleReal")
        if angle > 180 then
            SetTurnSpeed(0)
        elseif angle > 90 then
            SetTurnSpeed(360)
        end
    elseif env(IsPrecisionShoot) == TRUE then
        SetTurnSpeed(0)
        SetVariable("TurnAngleReal", 300)
    elseif math.abs(GetVariable(rolling_angle)) > 0.0010000000474974513 then
        SetTurnSpeed(0)
    elseif GetVariable("TurnAngleReal") > 200 then
        SetTurnSpeed(0)
    end
end

----------------------
-- Common functions --
----------------------

function EvasionCommonFunction(fall_type, r1, r2, l1, l2, b1, b2, quick_type)
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
    if IsNodeActive("BackStepGuardOn_UpperLayer Selector") == TRUE then
        act(DebugLogOutput, "BackStepGuardOn")
        if ExecGuardOnCancelTiming(TO_GUARDON, ALLBODY) == TRUE then
            return TRUE
        end
        if env(ActionRequest, ACTION_ARM_L1) == TRUE or env(ActionDuration, ACTION_ARM_L1) > 0 then
            act(DebugLogOutput, "BackStepGuard_ToGuardOn")
        end
    elseif ExecGuardOnCancelTiming(FALSE, ALLBODY) == TRUE then
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
    if ExecAttack(r1, r2, l1, l2, b1, b2, FALSE, ALLBODY, FALSE, FALSE, TRUE) == TRUE then
        return TRUE
    end
    if MoveStartonCancelTiming(Event_MoveLong, FALSE) == TRUE then
        return TRUE
    end
    return FALSE
end

--------------
-- Triggers --
--------------

function DefaultBackStep_onActivate()
    ResetDamageCount()
end

function DefaultBackStep_onUpdate()
    act(SetCanChangeEquipmentOff)
    act(DisallowAdditiveTurning, TRUE)

    if EvasionCommonFunction(FALL_TYPE_DEFAULT, "W_AttackRightBackstep", "W_AttackRightHeavy1Start",
        "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothBackstep", "W_AttackBothHeavy1Start",
        QUICKTYPE_BACKSTEP) == TRUE then
        return
    end
end

function DefaultBackStep_onDeactivate()
    act(DisallowAdditiveTurning, FALSE)
end

function BackStepGuardOn_UpperLayer_onUpdate()
    act(SetCanChangeEquipmentOff)
    if ExecGuardOnCancelTiming(TO_GUARDON, ALLBODY) == TRUE then
        return
    end
    if IsGuard() == FALSE then
        SetVariable("EnableTAE_BackStep", true)
        ExecEventNoReset("W_BackStepGuardEnd_UpperLayer")
        return
    end
end

function BackStepGuardEnd_UpperLayer_onUpdate()
    act(SetCanChangeEquipmentOff)
    if env(IsAnimEnd, 1) == TRUE or env(GetEventEzStateFlag, 0) == TRUE then
        ExecEventSyncNoReset("Event_BackStepGuardOut")
    end
end

function Rolling_onUpdate()
    act(DisallowAdditiveTurning, TRUE)
    SetThrowAtkInvalid()

    if env(GetSpEffectID, 100390) == TRUE then
        ResetDamageCount()
    end

    SetEnableAimMode()

    if EvasionCommonFunction(FALL_TYPE_DEFAULT, "W_AttackRightLightStep", "W_AttackRightHeavy1Start",
        "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLightStep", "W_AttackBothHeavy1Start",
        QUICKTYPE_ROLLING) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        ExecEventAllBody("W_Idle")
        return
    end
    SetRollingTurnCondition(FALSE)
end

function Rolling_onDeactivate()
    act(DisallowAdditiveTurning, FALSE)
end

function Rolling_Selftrans_onUpdate()
    act(DisallowAdditiveTurning, TRUE)
    SetThrowAtkInvalid()

    if env(GetSpEffectID, 100390) == TRUE then
        ResetDamageCount()
    end

    SetEnableAimMode()

    if EvasionCommonFunction(FALL_TYPE_DEFAULT, "W_AttackRightLightStep", "W_AttackRightHeavy1Start",
        "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLightStep", "W_AttackBothHeavy1Start",
        QUICKTYPE_ROLLING) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        ExecEventAllBody("W_Idle")
        return
    end
    SetRollingTurnCondition(TRUE)
end

function Rolling_Selftrans_onDeactivate()
    act(DisallowAdditiveTurning, FALSE)
end
