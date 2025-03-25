
function IsWeaponCanGuard()
    local style = c_Style
    local kind = 0
    local pos = 0
    if style == HAND_RIGHT then
        kind = env(GetEquipWeaponCategory, HAND_LEFT)
        pos = 2
    elseif style == HAND_LEFT_BOTH then
        kind = env(GetEquipWeaponCategory, HAND_LEFT)
        pos = 3
    else
        kind = env(GetEquipWeaponCategory, HAND_RIGHT)
        pos = 3
    end

    for i = 1, #WeaponCategoryID, 1 do
        if WeaponCategoryID[i][1] == kind then
            local canguard = WeaponCategoryID[i][pos]
            return canguard
        end
    end
end

function IsEnableGuard()
    local style = c_Style
    local hand = HAND_LEFT

    if style == HAND_RIGHT_BOTH then
        hand = HAND_RIGHT
    end

    local sp_kind = env(GetEquipWeaponSpecialCategoryNumber, hand)

    if style == HAND_RIGHT and GetEquipType(hand, WEAPON_CATEGORY_STAFF) == TRUE then
        return FALSE
    end
    if sp_kind == 249 and (style == HAND_LEFT_BOTH or style == HAND_RIGHT_BOTH) then
        return FALSE
    end
    if IsWeaponCanGuard() == FALSE then
        return FALSE
    end
    if IsEnableDualWielding() ~= -1 then
        return FALSE
    end
    return TRUE
end

function ExecGuard(event, blend_type)
    if env(ActionDuration, ACTION_ARM_ACTION) > 0 then
        return FALSE
    end
    if c_IsStealth == TRUE then
        blend_type = ALLBODY
    end
    if env(ActionRequest, ACTION_ARM_L1) == TRUE or env(ActionDuration, ACTION_ARM_L1) > 0 then
        if env(GetStamina) <= 0 then
            return FALSE
        end
        if IsEnableGuard() == TRUE then
            local style = c_Style
            local hand = HAND_LEFT

            if style == HAND_RIGHT_BOTH then
                hand = HAND_RIGHT
            end

            local kind = env(GetEquipWeaponCategory, hand)
            local sp_kind = env(GetEquipWeaponSpecialCategoryNumber, hand)
            local guardindex = env(GetGuardMotionCategory, hand)

            if kind == WEAPON_CATEGORY_DUELING_SHIELD then
                guardindex = GUARD_STYLE_DUELINGSHIELD
            end

            -- Set Torch Color
            if kind == WEAPON_CATEGORY_TORCH and style == HAND_RIGHT then
                guardindex = GUARD_STYLE_TORCH

                if sp_kind == 291 then
                    SetVariable("IndexTorchColor", 1) -- Ghostflame Torch
                elseif sp_kind == 292 then
                    SetVariable("IndexTorchColor", 2) -- St. Trina's Torch
                elseif sp_kind == 288 then
                    SetVariable("IndexTorchColor", 3) -- Nanaya's Torch
                else
                    SetVariable("IndexTorchColor", 0) -- Torch
                end
            elseif sp_kind == 240 and style == HAND_RIGHT then
                guardindex = GUARD_STYLE_TORCH
            elseif style == HAND_RIGHT_BOTH or style == HAND_LEFT_BOTH then
                if env(GetStayAnimCategory) ~= 15 and env(GetStayAnimCategory) ~= 0 and env(GetStayAnimCategory) ~= 2 and
                    env(GetStayAnimCategory) ~= 3 then
                    guardindex = GUARD_STYLE_DEFAULT
                end
                if kind == WEAPON_CATEGORY_DUELING_SHIELD then
                    guardindex = GUARD_STYLE_DUELINGSHIELD
                end
            end

            if env(GetSpEffectID, 172) == TRUE then
                SetVariable("GuardStartType", 1)
            else
                SetVariable("GuardStartType", 0)
            end

            SetVariable("IndexGuardStyle", guardindex)

            if blend_type == ALLBODY and MoveStart(LOWER, Event_MoveLong, FALSE) == TRUE then
                blend_type = UPPER
            end

            if env(GetSpEffectID, 102000) == TRUE and event ~= Event_GuardOn then
                local is_after_additive_just_guard = FALSE
                if env(GetSpEffectID, 102020) == TRUE or env(GetSpEffectID, 102022) == TRUE then
                    is_after_additive_just_guard = TRUE
                end
                if env(GetSpEffectID, 102002) == TRUE and is_after_additive_just_guard == FALSE then
                    event = Event_GuardStart_JustGuard2
                elseif env(GetSpEffectID, 102003) == TRUE and is_after_additive_just_guard == FALSE then
                    event = Event_GuardStart_JustGuard3
                elseif env(GetSpEffectID, 102004) == TRUE and is_after_additive_just_guard == FALSE then
                    if IsNodeActive("GuardStart_JustGuard4_Upper Selector") == TRUE then
                        event = Event_GuardStart_JustGuard4_SelfTrans
                    else
                        event = Event_GuardStart_JustGuard4
                    end
                elseif event ~= Event_GuardStart then
                elseif IsNodeActive("GuardStart_JustGuard_Upper Selector") == TRUE then
                    event = Event_GuardStart_JustGuard_SelfTrans
                else
                    event = Event_GuardStart_JustGuard
                end
            end

            act(AddSpEffect, 102021)
            ExecEventHalfBlend(event, blend_type)

            return TRUE
        end
    end
    return FALSE
end

function IsGuard()
    if env(ActionRequest, ACTION_ARM_L1) == TRUE or env(ActionDuration, ACTION_ARM_L1) > 0 then
        return TRUE
    end
    return FALSE
end

function ExecGuardOnCancelTiming(guardcondition, blend_type)
    if env(IsGuardFromAtkCancel) == FALSE then
        return FALSE
    end

    act(DebugLogOutput, "ExecGuardOnCancelTiming " .. guardcondition)

    if guardcondition == TO_GUARDON and env(GetSpEffectID, 102000) == TRUE and env(ActionRequest, ACTION_ARM_L1) == TRUE then
        guardcondition = FALSE
    end

    if guardcondition == TO_GUARDON then
        if ExecGuard(Event_GuardOn, blend_type) == TRUE then
            return TRUE
        end
    elseif ExecGuard(Event_GuardStart, blend_type) == TRUE then
        return TRUE
    end

    return FALSE
end

function SetJustGuardSucceedEffect(level)
    if env(GetSpEffectID, 102010) == TRUE or env(GetSpEffectID, 102009) == TRUE then
        act(AddSpEffect, 102010)
    elseif env(GetSpEffectID, 102008) == TRUE then
        if level > 1 then
            act(AddSpEffect, 102010)
        else
            act(AddSpEffect, 102009)
        end
    elseif env(GetSpEffectID, 102007) == TRUE then
        if level > 2 then
            act(AddSpEffect, 102010)
        elseif level == 2 then
            act(AddSpEffect, 102009)
        else
            act(AddSpEffect, 102008)
        end
    elseif level > 3 then
        act(AddSpEffect, 102010)
    elseif level == 3 then
        act(AddSpEffect, 102009)
    elseif level == 2 then
        act(AddSpEffect, 102008)
    else
        act(AddSpEffect, 102007)
    end
    act(AddSpEffect, 102019)
end

function SetJustGuardReinputState()
    if env(ActionDuration, ACTION_ARM_L1) > 0 then
        if JUSTGUARD_RELEASE_GUARD_BUTTON == TRUE then
            if env(GetSpEffectID, 102018) == TRUE or env(GetSpEffectID, 102017) == TRUE or env(GetSpEffectID, 102016) ==
                TRUE or env(GetSpEffectID, 102015) == TRUE then
                act(AddSpEffect, 102017)
            elseif env(GetSpEffectID, 102014) == TRUE or env(GetSpEffectID, 102013) == TRUE then
                act(AddSpEffect, 102015)
            elseif env(GetSpEffectID, 102012) == TRUE or env(GetSpEffectID, 102011) == TRUE then
                act(AddSpEffect, 102013)
            else
                act(AddSpEffect, 102011)
            end
        end
        JUSTGUARD_RELEASE_GUARD_BUTTON = FALSE
    else
        JUSTGUARD_RELEASE_GUARD_BUTTON = TRUE
    end
end

----------------------
-- Common functions --
----------------------

function GuardCommonFunction(is_guard_end, blend_type, is_just_guard)
    act(Wait)

    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
        return TRUE
    end
    if env(GetSpEffectID, 170) == TRUE then
        return FALSE
    end
    if LadderStart() == TRUE then
        return TRUE
    end
    if blend_type ~= UPPER and ExecQuickTurn(LOWER, TURN_TYPE_DEFAULT) == TRUE then
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
    if is_guard_end == TRUE then
        if ExecArtsStanceOnCancelTiming(blend_type) == TRUE then
            return TRUE
        end
    elseif env(ActionRequest, ACTION_ARM_L2) == TRUE and ExecArtsStance(blend_type) == TRUE then
        return TRUE
    end

    if GetVariable("MoveSpeedIndex") == 2 then
        if ExecItem(QUICKTYPE_DASH, blend_type) == TRUE then
            return TRUE
        end
    elseif GetVariable("MoveSpeedIndex") == 1 then
        if ExecItem(QUICKTYPE_RUN, blend_type) == TRUE then
            return TRUE
        end
    elseif ExecItem(QUICKTYPE_NORMAL, blend_type) == TRUE then
        return TRUE
    end
    if GetVariable("MoveSpeedIndex") == 2 then
        if ExecMagic(QUICKTYPE_DASH, blend_type, FALSE) == TRUE then
            return TRUE
        end
    elseif GetVariable("MoveSpeedIndex") == 1 then
        if ExecMagic(QUICKTYPE_RUN, blend_type, FALSE) == TRUE then
            return TRUE
        end
    elseif ExecMagic(QUICKTYPE_NORMAL, blend_type, FALSE) == TRUE then
        return TRUE
    end

    if GetVariable("MoveSpeedLevelReal") > 1.100000023841858 then
        if ExecAttack("W_AttackRightLightDash", "W_AttackRightHeavyDash", nil, "W_AttackLeftHeavy1", "W_AttackBothDash",
            "W_AttackBothHeavyDash", FALSE, UPPER, FALSE, FALSE, FALSE) == TRUE then
            return TRUE
        end
    else
        local guard_attack = TRUE

        if is_guard_end == TRUE then
            guard_attack = FALSE
        end

        if ExecAttack("W_AttackRightLight1", "W_AttackRightHeavy1Start", nil, "W_AttackLeftHeavy1",
            "W_AttackBothLight1", "W_AttackBothHeavy1Start", guard_attack, blend_type, FALSE, FALSE, FALSE) == TRUE then
            return TRUE
        end
    end

    if is_just_guard == TRUE then
        if env(GetSpEffectID, 20100006) == TRUE and JUSTGUARD_IS_FIRSTFRAME == FALSE and
            (env(ActionCancelRequest, ACTION_ARM_L1) == TRUE or env(ActionDuration, ACTION_ARM_L1) <= 0) then
            ExecEventHalfBlendNoReset(Event_GuardEnd, blend_type)
            return TRUE
        end
        JUSTGUARD_IS_FIRSTFRAME = FALSE
        if env(ActionRequest, ACTION_ARM_L1) == TRUE and ExecGuard(Event_GuardStart, blend_type) == TRUE then
            return TRUE
        end
    elseif is_guard_end == FALSE then
        if env(ActionCancelRequest, ACTION_ARM_L1) == TRUE or env(ActionDuration, ACTION_ARM_L1) <= 0 then
            ExecEventHalfBlendNoReset(Event_GuardEnd, blend_type)
            return TRUE
        end
    elseif (env(ActionRequest, ACTION_ARM_L1) == TRUE or env(ActionDuration, ACTION_ARM_L1) > 0) and
        ExecGuard(Event_GuardStart, blend_type) == TRUE then
        return TRUE
    end
    return FALSE
end

function JustGuardStartCommonFunction(event)
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
        act(DisallowAdditiveTurning, TRUE)
    else
        act(DisallowAdditiveTurning, FALSE)
    end
    if GuardCommonFunction(FALSE, blend_type, TRUE) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE or env(GetEventEzStateFlag, 0) == TRUE then
        ExecEventHalfBlend(Event_GuardOn, blend_type)
        return
    end
    if HalfBlendLowerCommonFunction(event, lower_state, FALSE) == TRUE then
        return
    end
end

--------------
-- Triggers --
--------------

function Guard_Activate()
    local hand = HAND_LEFT

    if c_Style == HAND_RIGHT_BOTH then
        hand = HAND_RIGHT
    end

    act(DebugLogOutput, "Guard_Activate ( ) ")
    SetGuardHand(hand)
    ActivateRightArmAdd(START_FRAME_NONE)
end

function Guard_Update()
    UpdateRightArmAdd()
    local hand = HAND_LEFT
    if c_Style == HAND_RIGHT_BOTH then
        hand = HAND_RIGHT
    end
    if env(GetEquipWeaponSpecialCategoryNumber, hand) == 289 then
        act(AddSpEffect, 19860)
    end
end

function GuardDamage_Active()
    ActivateRightArmAdd(START_FRAME_A02)
end

function GuardDamage_Update()
    UpdateRightArmAdd()
end

function BackStepGuardOn_Upper_Active()
    ActivateRightArmAdd(START_FRAME_A02)
end

function BackStepGuardOn_Upper_Update()
    UpdateRightArmAdd()
end

function BackStepGuardEnd_Upper_Active()
    ActivateRightArmAdd(START_FRAME_A02)
end

function BackStepGuardEnd_Upper_Update()
    UpdateRightArmAdd()
end

function GuardStart_Upper_onActivate()
    act(Wait)
end

function GuardStart_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()

    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
        act(DisallowAdditiveTurning, TRUE)
    else
        act(DisallowAdditiveTurning, FALSE)
    end

    if GuardCommonFunction(FALSE, blend_type, FALSE) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE or env(GetEventEzStateFlag, 0) == TRUE then
        ExecEventHalfBlend(Event_GuardOn, blend_type)
        return
    end
    if HalfBlendLowerCommonFunction(Event_GuardStart, lower_state, FALSE) == TRUE then
        return
    end
end

function GuardStart_Upper_onDeactivate()
    act(DisallowAdditiveTurning, FALSE)
end

function GuardOn_Upper_onActivate()
    act(Wait)
end

function GuardOn_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()

    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
        act(DisallowAdditiveTurning, TRUE)
    else
        act(DisallowAdditiveTurning, FALSE)
    end

    if GuardCommonFunction(FALSE, blend_type, FALSE) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_GuardOn, lower_state, FALSE) == TRUE then
        return
    end
end

function GuardOn_Upper_onDeactivate()
    act(DisallowAdditiveTurning, FALSE)
end

function GuardEnd_Upper_onActivate()
    act(Wait)
end

function GuardEnd_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()

    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
        act(DisallowAdditiveTurning, TRUE)
    else
        act(DisallowAdditiveTurning, FALSE)
    end

    if GuardCommonFunction(TRUE, blend_type, FALSE) == TRUE then
        return
    end
    if lower_state == LOWER_MOVE and (env(IsAnimEnd, 1) == TRUE or env(GetEventEzStateFlag, 0) == TRUE) then
        ExecEventHalfBlendNoReset(Event_MoveQuick, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_GuardEnd, lower_state, FALSE) == TRUE then
        return
    end
end

function GuardStart_JustGuard_Upper_onActivate()
    act(Wait)
    JUSTGUARD_IS_FIRSTFRAME = TRUE
end

function GuardStart_JustGuard_Upper_onUpdate()
    JustGuardStartCommonFunction(Event_GuardStart_JustGuard)
end

function GuardStart_JustGuard_Upper_onDeactivate()
    act(DisallowAdditiveTurning, FALSE)
end

function GuardStart_JustGuard_SelfTrans_Upper_onActivate()
    act(Wait)
    JUSTGUARD_IS_FIRSTFRAME = TRUE
end

function GuardStart_JustGuard_SelfTrans_Upper_onUpdate()
    JustGuardStartCommonFunction(Event_GuardStart_JustGuard)
end

function GuardStart_JustGuard_SelfTrans_Upper_onDeactivate()
    act(DisallowAdditiveTurning, FALSE)
end

function GuardStart_JustGuard2_Upper_onActivate()
    act(Wait)
    JUSTGUARD_IS_FIRSTFRAME = TRUE
end

function GuardStart_JustGuard2_Upper_onUpdate()
    JustGuardStartCommonFunction(Event_GuardStart_JustGuard2)
end

function GuardStart_JustGuard2_Upper_onDeactivate()
    act(DisallowAdditiveTurning, FALSE)
end

function GuardStart_JustGuard3_Upper_onActivate()
    act(Wait)
    JUSTGUARD_IS_FIRSTFRAME = TRUE
end

function GuardStart_JustGuard3_Upper_onUpdate()
    JustGuardStartCommonFunction(Event_GuardStart_JustGuard3)
end

function GuardStart_JustGuard3_Upper_onDeactivate()
    act(DisallowAdditiveTurning, FALSE)
end

function GuardStart_JustGuard4_Upper_onActivate()
    act(Wait)
    JUSTGUARD_IS_FIRSTFRAME = TRUE
end

function GuardStart_JustGuard4_Upper_onUpdate()
    JustGuardStartCommonFunction(Event_GuardStart_JustGuard4)
end

function GuardStart_JustGuard4_Upper_onDeactivate()
    act(DisallowAdditiveTurning, FALSE)
end

function GuardStart_JustGuard4_SelfTrans_Upper_onActivate()
    act(Wait)
    JUSTGUARD_IS_FIRSTFRAME = TRUE
end

function GuardStart_JustGuard4_SelfTrans_Upper_onUpdate()
    JustGuardStartCommonFunction(Event_GuardStart_JustGuard4_SelfTrans)
end

function GuardStart_JustGuard4_SelfTrans_Upper_onDeactivate()
    act(DisallowAdditiveTurning, FALSE)
end

function GuardDamageSmall_onActivate()
    JUSTGUARD_RELEASE_GUARD_BUTTON = FALSE
end

function GuardDamageSmall_onUpdate()
    act(SetStaminaRecoveryDisabled)

    if DamageCommonFunction(TO_GUARDON, ESTEP_NONE, FALL_TYPE_DEFAULT) == TRUE then
        return
    end

    if env(GetSpEffectID, 102000) == TRUE then
        SetJustGuardReinputState()
    end
end

function GuardDamageMiddle_onActivate()
    JUSTGUARD_RELEASE_GUARD_BUTTON = FALSE
end

function GuardDamageMiddle_onUpdate()
    act(SetStaminaRecoveryDisabled)

    if DamageCommonFunction(TO_GUARDON, ESTEP_NONE, FALL_TYPE_DEFAULT) == TRUE then
        return
    end

    if env(GetSpEffectID, 102000) == TRUE then
        SetJustGuardReinputState()
    end
end

function GuardDamageLarge_onActivate()
    JUSTGUARD_RELEASE_GUARD_BUTTON = FALSE
end

function GuardDamageLarge_onUpdate()
    act(SetStaminaRecoveryDisabled)

    if DamageCommonFunction(TO_GUARDON, ESTEP_NONE, FALL_TYPE_DEFAULT) == TRUE then
        return
    end
    if env(GetSpEffectID, 102000) == TRUE then
        SetJustGuardReinputState()
    end
end

function GuardDamageSmall_JustGuard_onActivate()
    JUSTGUARD_RELEASE_GUARD_BUTTON = FALSE
end

function GuardDamageSmall_JustGuard_onUpdate()
    act(SetStaminaRecoveryDisabled)
    if DamageCommonFunction(TO_GUARDON, ESTEP_NONE, FALL_TYPE_DEFAULT) == TRUE then
        return
    end
    SetJustGuardReinputState()
end

function GuardDamageMiddle_JustGuard_onActivate()
    JUSTGUARD_RELEASE_GUARD_BUTTON = FALSE
end

function GuardDamageMiddle_JustGuard_onUpdate()
    act(SetStaminaRecoveryDisabled)
    if DamageCommonFunction(TO_GUARDON, ESTEP_NONE, FALL_TYPE_DEFAULT) == TRUE then
        return
    end
    SetJustGuardReinputState()
end

function GuardDamageLarge_JustGuard_onActivate()
    JUSTGUARD_RELEASE_GUARD_BUTTON = FALSE
end

function GuardDamageLarge_JustGuard_onUpdate()
    act(SetStaminaRecoveryDisabled)
    if DamageCommonFunction(TO_GUARDON, ESTEP_NONE, FALL_TYPE_DEFAULT) == TRUE then
        return
    end
    SetJustGuardReinputState()
end

function GuardDamageExLarge_onUpdate()
    if DamageCommonFunction(FALSE, ESTEP_DOWN, FALL_TYPE_DEFAULT) == TRUE then
        return
    end
end

function GuardBreak_onUpdate()
    if DamageCommonFunction(FALSE, ESTEP_NONE, FALL_TYPE_DEFAULT) == TRUE then
        return
    end
end

function GuardBreakRight_onUpdate()
    if DamageCommonFunction(FALSE, ESTEP_NONE, FALL_TYPE_DEFAULT) == TRUE then
        return
    end
end
