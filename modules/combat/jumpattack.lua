
function ExecFallAttack()
    if env(ActionRequest, ACTION_ARM_R1) == TRUE or env(ActionRequest, ACTION_ARM_R2) == TRUE or
        env(ActionRequest, ACTION_ARM_L1) == TRUE and IsEnableDualWielding() == HAND_RIGHT then
        local style = c_Style
        local hand = HAND_RIGHT

        if style == HAND_LEFT_BOTH then
            hand = HAND_LEFT
        end

        local is_arrow = GetEquipType(hand, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_ARROW,
            WEAPON_CATEGORY_LARGE_ARROW, WEAPON_CATEGORY_CROSSBOW, WEAPON_CATEGORY_BALLISTA)
        local is_staff = GetEquipType(hand, WEAPON_CATEGORY_STAFF)

        if env(ActionRequest, ACTION_ARM_R1) == TRUE or is_arrow == TRUE then
            if is_staff == TRUE then
                return FALSE
            end

            SetVariable("JumpAttackForm", 1)
            SetVariable("JumpAttackFormRequest", 0)
        elseif env(ActionRequest, ACTION_ARM_R2) == TRUE then
            SetVariable("JumpAttackForm", 2)
            SetVariable("JumpAttackFormRequest", 1)
        elseif env(ActionRequest, ACTION_ARM_L1) == TRUE then
            if IsEnableDualWielding() ~= HAND_RIGHT then
                return FALSE
            end

            SetVariable("JumpAttackForm", 3)
            SetVariable("JumpAttackFormRequest", 2)
        end

        if is_arrow == TRUE and (style == HAND_LEFT_BOTH or style == HAND_RIGHT_BOTH) and env(IsOutOfAmmo, hand) == TRUE then
            return FALSE
        end
        if GetEquipType(hand, WEAPON_CATEGORY_CROSSBOW) == TRUE and env(GetBoltLoadingState, hand) == FALSE then
            return FALSE
        end
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

        SetVariable("JumpAttack_Land", 0)
        ExecEventAllBody("W_JumpAttack_Start_Falling")
        return TRUE
    end
    return FALSE
end

--------------
-- Triggers --
--------------

function JumpAttackRight_Activate()
    SetAttackHand(HAND_RIGHT)
    SetGuardHand(HAND_LEFT)
end

function JumpAttackLeft_Activate()
    SetAttackHand(HAND_LEFT)
    SetGuardHand(HAND_LEFT)
end

function JumpAttackBoth_Activate()
    local hand = HAND_RIGHT
    if c_Style == HAND_LEFT_BOTH then
        hand = HAND_LEFT
    end
    SetAttackHand(hand)
    SetGuardHand(hand)
end

function Jump_LandAttack_Normal_onActivate()
    act(ResetInputQueue)
    SetAIActionState()
end

function Jump_LandAttack_Normal_onUpdate()
    SetAIActionState()

    if EvasionCommonFunction(FALL_TYPE_DEFAULT, "W_AttackRightLight2", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", "W_AttackBothLight2", "W_AttackBothHeavy1Start", QUICKTYPE_ROLLING) == TRUE then
        return
    end
end

function Jump_LandAttack_Normal_onDeactivate()
    SetVariable("JumpAttackForm", 0)
    SetVariable("SwingPose", 0)
end

function Jump_LandAttack_Hard_onActivate()
    act(ResetInputQueue)
    SetAIActionState()
end

function Jump_LandAttack_Hard_onUpdate()
    SetAIActionState()

    if EvasionCommonFunction(FALL_TYPE_DEFAULT, "W_AttackRightLight2", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", "W_AttackBothLight2", "W_AttackBothHeavy1Start", QUICKTYPE_ROLLING) == TRUE then
        return
    end
end

function Jump_LandAttack_Hard_onDeactivate()
    SetVariable("JumpAttackForm", 0)
    SetVariable("SwingPose", 0)
end

function Jump_Attack_Land_F_onUpdate()
    if JumpLandCommonFunction() == TRUE then
        return
    end
    if env(GetSpEffectID, 146) == TRUE then
        SetVariable("SwingPose", 4)
        hkbFireEvent("W_Jump_Land_N")
        return
    end
end

function JumpAttack_Start_Falling_onActivate()
    act(ResetInputQueue)
    act(AIJumpState)
    SetAIActionState()
end

function JumpAttack_Start_Falling_onUpdate()
    act(AIJumpState)
    SetAIActionState()

    if Act_Jump() == TRUE then
        return
    end
    if GetVariable("JumpAttackFormRequest") == 0 then
        SetVariable("JumpAttackForm", 1)
    elseif GetVariable("JumpAttackFormRequest") == 1 then
        SetVariable("JumpAttackForm", 2)
    elseif GetVariable("JumpAttackFormRequest") == 2 then
        SetVariable("JumpAttackForm", 3)
    end

    if env(GetSpEffectID, 98) == TRUE and env(IsTruelyLanding) == TRUE and env(GetSpEffectID, 140) == FALSE and
        GetVariable("JumpAttack_Land") == 0 then
        local height = env(GetFallHeight) / 100
        local landIndex = GetLandIndex(height, FALSE)
        if landIndex == LAND_HEAVY then
            SetVariable("JumpAttack_Land", 2)
        else
            SetVariable("JumpAttack_Land", 1)
        end
        return
    end
    if env(GetSpEffectID, 146) == TRUE then
        if GetVariable("JumpAttack_Land") == 2 then
            SetVariable("SwingPose", 5)
        else
            SetVariable("SwingPose", 4)
        end
        hkbFireEvent("W_Jump_Land_N")
        return
    end
    if env(GetEventEzStateFlag, 0) == TRUE and ExecArrowBothJumpLandAttack() == TRUE then
        return
    end
    if EvasionCommonFunction(FALL_TYPE_DEFAULT, "W_AttackRightLight2", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", "W_AttackBothLightStep", "W_AttackBothHeavy1Start", QUICKTYPE_ROLLING) == TRUE then
        return
    end
end

function JumpAttack_Start_Falling_F_onActivate()
    act(ResetInputQueue)
    act(AIJumpState)
    SetAIActionState()
end

function JumpAttack_Start_Falling_F_onUpdate()
    act(AIJumpState)
    SetAIActionState()

    if Act_Jump() == TRUE then
        return
    end
    if GetVariable("JumpAttackFormRequest") == 0 then
        SetVariable("JumpAttackForm", 1)
    elseif GetVariable("JumpAttackFormRequest") == 1 then
        SetVariable("JumpAttackForm", 2)
    elseif GetVariable("JumpAttackFormRequest") == 2 then
        SetVariable("JumpAttackForm", 3)
    end

    if GetVariable("JumpAttackForm") >= 0 then
    end

    if env(GetSpEffectID, 98) == TRUE and env(IsTruelyLanding) == TRUE and env(GetSpEffectID, 140) == FALSE then
        SetVariable("JumpAttack_Land", 1)
        return
    end
    if env(GetSpEffectID, 146) == TRUE then
        SetVariable("SwingPose", 4)
        hkbFireEvent("W_Jump_Land_F")
        return
    end
    if env(GetEventEzStateFlag, 0) == TRUE and ExecArrowBothJumpLandAttack() == TRUE then
        return
    end
    if EvasionCommonFunction(FALL_TYPE_DEFAULT, "W_AttackRightLight2", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", "W_AttackBothLightStep", "W_AttackBothHeavy1Start", QUICKTYPE_ROLLING) == TRUE then
        return
    end
end

function JumpAttack_Start_Falling_D_onActivate()
    act(ResetInputQueue)
    act(AIJumpState)
    SetAIActionState()
end

function JumpAttack_Start_Falling_D_onUpdate()
    act(AIJumpState)
    SetAIActionState()

    if Act_Jump() == TRUE then
        return
    end
    if GetVariable("JumpAttackFormRequest") == 0 then
        SetVariable("JumpAttackForm", 1)
    elseif GetVariable("JumpAttackFormRequest") == 1 then
        SetVariable("JumpAttackForm", 2)
    elseif GetVariable("JumpAttackFormRequest") == 2 then
        SetVariable("JumpAttackForm", 3)
    end

    if GetVariable("JumpAttackForm") >= 0 then
    end

    if env(GetSpEffectID, 98) == TRUE and env(IsTruelyLanding) == TRUE and env(GetSpEffectID, 140) == FALSE then
        SetVariable("JumpAttack_Land", 1)
        return
    end
    if env(GetSpEffectID, 146) == TRUE then
        SetVariable("SwingPose", 4)
        hkbFireEvent("W_Jump_Land_D")
        return
    end
    if env(GetEventEzStateFlag, 0) == TRUE and ExecArrowBothJumpLandAttack() == TRUE then
        return
    end
    if EvasionCommonFunction(FALL_TYPE_DEFAULT, "W_AttackRightLight2", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", "W_AttackBothLightStep", "W_AttackBothHeavy1Start", QUICKTYPE_ROLLING) == TRUE then
        return
    end
end
