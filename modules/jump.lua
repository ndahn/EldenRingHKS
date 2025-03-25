
function ExecJump()
    -- Note: Restored original value during full remake. Repo values was ACTION_ARM_JUMP instead of ACTION_ARM_CHANGE_STYLE
    -- note: Original decompile of 1.10 has ACTION_ARM_CHANGE_STYLE instead of jump
    if env(ActionRequest, ACTION_ARM_CHANGE_STYLE) == FALSE and env(IsAIJumpRequested) == FALSE then
        return FALSE
    end
    if env(GetStamina) <= 0 and env(IsAIJumpRequested) == FALSE then
        ResetRequest()
        return FALSE
    end

    if env(GetSpEffectID, 102360) == FALSE then
        AddStamina(STAMINA_REDUCE_JUMP)
    end
    SetWeightIndex()

    -- Jump: Overweight
    if GetVariable("EvasionWeightIndex") == EVASION_WEIGHT_INDEX_OVERWEIGHT and env(IsAIJumpRequested) == FALSE then
        local jumpangle = env(GetJumpAngle) * 0.009999999776482582

        if jumpangle > -45 and jumpangle < 45 then
            SetVariable("JumpOverweightIndex", 0)
        elseif jumpangle >= 0 and jumpangle <= 100 then
            SetVariable("JumpOverweightIndex", 3)
        elseif jumpangle >= -100 and jumpangle <= 0 then
            SetVariable("JumpOverweightIndex", 2)
        else
            SetVariable("JumpOverweightIndex", 1)
        end

        act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
        SetAIActionState()
        ExecEventAllBody("W_Jump_Overweight")

        return TRUE
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
    IS_ATTACKED_JUMPMAGIC = FALSE

    if GetVariable("IsEnableToggleDashTest") == 2 then
        SetVariable("ToggleDash", 0)
    end

    local JumpMoveLevel = 0

    if GetVariable("LocomotionState") == 1 and GetVariable("MoveSpeedIndex") == 2 then
        JumpMoveLevel = 2
    elseif GetVariable("MoveSpeedLevel") >= 0.6000000238418579 then
        JumpMoveLevel = 1
    end

    -- Ironjar Aromatic
    if env(GetSpEffectID, 503520) == TRUE then
        JumpMoveLevel = 0
        -- Unknown
    elseif env(GetSpEffectID, 5520) == TRUE then
        JumpMoveLevel = 0
        -- Slug: Slow
    elseif env(GetSpEffectID, 425) == TRUE then
        JumpMoveLevel = 0
        -- Sanguine Noble: Slow
    elseif env(GetSpEffectID, 4101) == TRUE then
        JumpMoveLevel = 0
        -- Sanguine Noble: Slow
    elseif env(GetSpEffectID, 4100) == TRUE then
        JumpMoveLevel = 0
        -- Unknown (DLC)
    elseif env(GetSpEffectID, 19670) == TRUE then
        JumpMoveLevel = 0
    end

    if JumpMoveLevel == 2 then
        if env(IsAIJumpRequested) == TRUE then
            act(NotifyAIOfJumpState)
        end

        act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
        SetAIActionState()
        ExecEvent("W_Jump_D")

        return TRUE
    elseif JumpMoveLevel == 1 then
        if GetVariable("IsLockon") == FALSE and env(IsPrecisionShoot) == FALSE and env(IsCOMPlayer) == FALSE then
            SetVariable("JumpDirection", 0)
            SetVariable("JumpAngle", 0)
        else
            local turn_target_angle = 0
            local jumpangle = env(GetJumpAngle) * 0.009999999776482582

            if jumpangle > -45 and jumpangle < 45 then
                turn_target_angle = jumpangle
                SetVariable("JumpDirection", 0)
                SetVariable("JumpAngle", 0)
            elseif jumpangle >= 0 and jumpangle <= 100 then
                turn_target_angle = jumpangle - 90
                SetVariable("JumpDirection", 3)
                SetVariable("JumpAngle", 90)
            elseif jumpangle >= -100 and jumpangle <= 0 then
                turn_target_angle = jumpangle + 90
                SetVariable("JumpDirection", 2)
                SetVariable("JumpAngle", -90)
            else
                turn_target_angle = jumpangle - 180
                SetVariable("JumpDirection", 1)
                SetVariable("JumpAngle", 180)
            end

            if GetVariable("IsLockon") == true then
                act(TurnToLockonTargetImmediately, turn_target_angle)
            else
                act(FaceDirection, turn_target_angle)
            end
        end

        SetVariable("IsEnableDirectionJumpTAE", true)

        if env(IsAIJumpRequested) == TRUE then
            act(NotifyAIOfJumpState)
        end

        act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
        SetAIActionState()
        ExecEvent("W_Jump_F")

        return TRUE
    else
        SetVariable("JumpReachSelector", 0)

        if env(IsAIJumpRequested) == TRUE then
            act(NotifyAIOfJumpState)
        end

        act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
        SetAIActionState()
        ExecEvent("W_Jump_N")

        return TRUE
    end
end

function ExecJumpLoopDirect(jump_type)
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

    if GetVariable("IsEnableToggleDashTest") == 2 then
        SetVariable("ToggleDash", 0)
    end

    if jump_type == 2 then
        ExecEvent("W_Jump_Loop")
        return TRUE
    elseif GetVariable("MoveSpeedLevel") >= 0.6000000238418579 then
        SetVariable("IsEnableDirectionJumpTAE", true)
        ExecEvent("W_Jump_Loop")
        return TRUE
    else
        SetVariable("JumpReachSelector", 0)
        ExecEvent("W_Jump_Loop")
        return TRUE
    end
end

-- Called from:
-- JumpAttack_Start_Falling_onUpdate
-- JumpAttack_Start_Falling_F_onUpdate
-- JumpAttack_Start_Falling_D_onUpdate
-- JumpCommonFunction
-- Jump_Loop_onUpdate
function Act_Jump()
    SetEnableAimMode()

    if env(GetSpEffectID, 32) == FALSE then
        SetThrowAtkInvalid()
    end

    local damage_type = env(GetReceivedDamageType)

    if damage_type == DAMAGE_TYPE_DEATH_FALLING then
        ExecEventAllBody("W_FallDeath")
        return TRUE
    elseif env(GetHP) <= 0 and
        (env(GetSpecialAttribute) == DAMAGE_ELEMENT_POISON or env(GetSpecialAttribute) == DAMAGE_ELEMENT_BLIGHT) then
        SetVariable("IndexDeath", DEATH_TYPE_POISON)
        ExecEventAllBody("W_DeathStart")
        return TRUE
    end

    local height = env(GetFallHeight) / 100

    if env(IsTruelyLanding) == TRUE and IsLandDead(height) == TRUE then
        if height > 8 then
            SetVariable("IndexDeath", DEATH_TYPE_LAND)
        else
            SetVariable("IndexDeath", DEATH_TYPE_LAND_LOW)
        end

        ExecEventAllBody("W_DeathStart")
        return TRUE
    end
    if ExecDamage(FALSE, FALSE) == TRUE then
        return TRUE
    end
end

----------------------
-- Common functions --
----------------------

function JumpCommonFunction(jump_type)
    act(AIJumpState)

    if GetVariable("JumpAttackForm") == 0 then
        act(NotifyAIOfBehaviourState, IDX_AINOTE_STATETYPE, IDX_AINOTE_STATETYPE_JUMP_NONATTACK)
    elseif env(GetSpEffectID, 102050) == TRUE then
        act(LockonFixedAngleCancel)
    end

    act(DisallowAdditiveTurning, TRUE)
    local height = env(GetFallHeight) / 100
    local equip_arm_no = 1

    if c_Style == HAND_LEFT_BOTH then
        equip_arm_no = 0
    end

    -- Jump
    if Act_Jump() == TRUE then
        return TRUE
    end
    -- Jump Fall
    if env(GetSpEffectID, 145) == FALSE and GetVariable("JumpAttack_Land") == 0 then
        hkbFireEvent("W_Jump_Loop")
        return TRUE
    end

    local arrowHand = HAND_RIGHT

    if c_Style == HAND_LEFT_BOTH then
        arrowHand = HAND_LEFT
    end

    local is_arrow = GetEquipType(arrowHand, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_ARROW,
        WEAPON_CATEGORY_LARGE_ARROW, WEAPON_CATEGORY_CROSSBOW, WEAPON_CATEGORY_BALLISTA)

    if GetVariable("JumpAttackForm") == 0 and is_arrow == TRUE then
        if env(ActionRequest, ACTION_ARM_R1) == TRUE then
            act(ChooseBowAndArrowSlot, 0)
            g_ArrowSlot = 0
        elseif env(ActionRequest, ACTION_ARM_R2) == TRUE then
            act(ChooseBowAndArrowSlot, 1)
            g_ArrowSlot = 1
        end
    end

    local is_staff = GetEquipType(equip_arm_no, WEAPON_CATEGORY_STAFF)
    local wep_hand = HAND_RIGHT

    if c_Style == HAND_LEFT_BOTH then
        wep_hand = HAND_LEFT
    end

    local isWeaponStaff = FALSE
    local sp_kind = env(GetEquipWeaponSpecialCategoryNumber, wep_hand)

    if IsWeaponCatalyst(sp_kind) == TRUE then
        isWeaponStaff = TRUE
    end

    -- Magic
    if ExecJumpMagic(jump_type) == TRUE then
        -- Catalyst: R1
    elseif is_staff == TRUE and env(ActionRequest, ACTION_ARM_R1) == TRUE then
        -- Weapon Catalyst: R2
    elseif isWeaponStaff == TRUE and env(ActionRequest, ACTION_ARM_R2) == TRUE then
        -- Bow
    elseif is_arrow == TRUE and (c_Style == HAND_RIGHT_BOTH or c_Style == HAND_LEFT_BOTH) and
        env(IsOutOfAmmo, arrowHand) == TRUE then
        -- Crossbow
    elseif GetEquipType(arrowHand, WEAPON_CATEGORY_CROSSBOW) == TRUE and
        (env(GetBoltLoadingState, arrowHand) == FALSE or env(IsOutOfAmmo, arrowHand) == TRUE) then
        -- Jump Attack
    elseif env(GetSpEffectID, 140) == TRUE and GetVariable("JumpAttackForm") == 0 then
        if env(ActionRequest, ACTION_ARM_R1) == TRUE or is_arrow == TRUE and env(ActionRequest, ACTION_ARM_R2) == TRUE then
            ExecEventSync("Event_JumpNormalAttack_Add")
            SetVariable("JumpAttackFormRequest", 0)
            SetVariable("JumpAttackForm", 1)
            SetInterruptType(INTERRUPT_FINDATTACK)
            act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
            SetAIActionState()

            return TRUE
        elseif env(ActionRequest, ACTION_ARM_R2) == TRUE then
            ExecEventSync("Event_JumpNormalAttack_Add")
            SetVariable("JumpAttackFormRequest", 1)
            SetVariable("JumpAttackForm", 2)
            SetInterruptType(INTERRUPT_FINDATTACK)
            act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
            SetAIActionState()

            return TRUE
        elseif env(ActionRequest, ACTION_ARM_L1) == TRUE and IsEnableDualWielding() == HAND_RIGHT then
            ExecEventSync("Event_JumpNormalAttack_Add")
            SetVariable("JumpAttackFormRequest", 2)
            SetVariable("JumpAttackForm", 3)
            SetInterruptType(INTERRUPT_FINDATTACK)
            act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
            SetAIActionState()

            return TRUE
        end
        if env(GetSpEffectID, 98) == TRUE and env(IsTruelyLanding) == TRUE and env(GetSpEffectID, 140) == FALSE then
            if jump_type == 0 then
                SetVariable("JumpAttack_Land", 1)
                SetVariable("JumpMotion_Override", 0)
                if GetVariable("JumpMotion_Override") < 0.009999999776482582 then
                    SetVariable("JumpUseMotion_Bool", 1)
                end
            elseif jump_type >= 1 then
                ExecEventAllBody("W_Jump_Attack_Land_F")
            end

            return TRUE
        end
    elseif env(GetSpEffectID, 140) == FALSE and GetVariable("JumpAttack_Land") == 0 and GetVariable("JumpAttackForm") ==
        0 then
        SetVariable("JumpAttack_Land", 0)

        if env(ActionRequest, ACTION_ARM_R1) == TRUE or is_arrow == TRUE and env(ActionRequest, ACTION_ARM_R2) == TRUE then
            SetVariable("JumpAttackFormRequest", 0)
            SetInterruptType(INTERRUPT_FINDATTACK)
            act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
            SetAIActionState()

            if jump_type == 0 then
                ExecEventNoReset("W_JumpAttack_Start_Falling")
            elseif jump_type == 1 then
                ExecEventNoReset("W_JumpAttack_Start_Falling_F")
            elseif jump_type == 2 then
                ExecEventNoReset("W_JumpAttack_Start_Falling_D")
            end

            return TRUE
        elseif env(ActionRequest, ACTION_ARM_R2) == TRUE then
            SetVariable("JumpAttackFormRequest", 1)
            SetInterruptType(INTERRUPT_FINDATTACK)
            act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
            SetAIActionState()
            if jump_type == 0 then
                ExecEventNoReset("W_JumpAttack_Start_Falling")
            elseif jump_type == 1 then
                ExecEventNoReset("W_JumpAttack_Start_Falling_F")
            elseif jump_type == 2 then
                ExecEventNoReset("W_JumpAttack_Start_Falling_D")
            end

            return TRUE
        elseif env(ActionRequest, ACTION_ARM_L1) == TRUE and IsEnableDualWielding() == HAND_RIGHT then
            SetInterruptType(INTERRUPT_FINDATTACK)
            act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
            SetAIActionState()
            SetVariable("JumpAttackFormRequest", 2)
            if jump_type == 0 then
                ExecEventNoReset("W_JumpAttack_Start_Falling")
            elseif jump_type == 1 then
                ExecEventNoReset("W_JumpAttack_Start_Falling_F")
            elseif jump_type == 2 then
                ExecEventNoReset("W_JumpAttack_Start_Falling_D")
            end

            return TRUE
        end
    end
    -- Landing
    if env(GetSpEffectID, 98) == TRUE and env(IsTruelyLanding) == TRUE and env(GetSpEffectID, 140) == FALSE and
        env(IsAIJumping) == FALSE then
        local landIndex = GetLandIndex(height, FALSE)
        SetVariable("LandIndex", landIndex)

        if GetVariable("JumpAttackForm") == 0 then
            local JumpMoveLevel = 0

            if GetVariable("MoveSpeedLevel") > 1.100000023841858 then
                JumpMoveLevel = 2
            elseif GetVariable("MoveSpeedLevel") > 0.6000000238418579 then
                JumpMoveLevel = 1
            end

            -- Ironjar Aromatic
            if TRUE == env(GetSpEffectID, 503520) then
                JumpMoveLevel = 0
                -- Unknown
            elseif TRUE == env(GetSpEffectID, 5520) then
                JumpMoveLevel = 0
                -- Slug: Slow
            elseif TRUE == env(GetSpEffectID, 425) then
                JumpMoveLevel = 0
                -- Sanguine Noble: Slow
            elseif TRUE == env(GetSpEffectID, 4101) then
                JumpMoveLevel = 0
                -- Sanguine Noble: Slow
            elseif TRUE == env(GetSpEffectID, 4100) then
                JumpMoveLevel = 0
            elseif env(GetSpEffectID, 19670) == TRUE then
                JumpMoveLevel = 0
            end

            if JumpMoveLevel == 2 then
                hkbFireEvent("W_Jump_Land_To_Dash")
            elseif JumpMoveLevel == 1 then
                SetVariable("JumpLandMoveDirection", GetVariable("MoveDirection"))
                hkbFireEvent("W_Jump_Land_To_Run")
            elseif jump_type == 0 then
                ExecEventNoReset("W_Jump_Land_N")
            elseif jump_type == 1 then
                ExecEventNoReset("W_Jump_Land_F")
            elseif jump_type == 2 then
                ExecEventNoReset("W_Jump_Land_D")
            end

            return TRUE
        else
            if jump_type == 0 then
                SetVariable("JumpAttack_Land", 1)
                SetVariable("JumpMotion_Override", 0)

                if GetVariable("JumpMotion_Override") < 0.009999999776482582 then
                    SetVariable("JumpUseMotion_Bool", 1)
                end
            elseif jump_type >= 1 then
                ExecEventAllBody("W_Jump_Attack_Land_F")
            end
            return TRUE
        end
        -- 146 "[HKS] Swing Window"
    elseif env(GetSpEffectID, 146) == TRUE and GetVariable("JumpAttackForm") ~= 0 then
        SetVariable("SwingPose", 4)

        if jump_type == 0 then
            ExecEventNoReset("W_Jump_Land_N")
        elseif jump_type == 1 then
            ExecEventNoReset("W_Jump_Land_F")
        elseif jump_type == 2 then
            ExecEventNoReset("W_Jump_Land_D")
        end

        return TRUE
    elseif env(GetEventEzStateFlag, 0) == TRUE and GetVariable("JumpAttackForm") ~= 0 and ExecArrowBothJumpLandAttack() ==
        TRUE then
        return TRUE
    end
    return FALSE
end

function JumpLandCommonFunction()
    SetEnableAimMode()

    if env(GetSpEffectID, 141) == TRUE then
        if EvasionCommonFunction(FALL_TYPE_DEFAULT, "W_Jump_LandAttack_Normal", "W_Jump_LandAttack_Hard",
            "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_Jump_LandAttack_Normal", "W_Jump_LandAttack_Hard",
            QUICKTYPE_ROLLING) == TRUE then
            return TRUE
        end
    elseif GetVariable("JumpAttackForm") == 1 or GetVariable("JumpAttackForm") == 2 or GetVariable("JumpAttackForm") ==
        3 then
        if env(GetEventEzStateFlag, 0) == TRUE and ExecArrowBothJumpLandAttack() == TRUE then
            return TRUE
        end

        local r1 = "W_AttackRightLightSubStart"
        local b1 = "W_AttackBothLightSubStart"

        if g_ComboReset == TRUE then
            r1 = "W_AttackRightLight1"
            b1 = "W_AttackBothLight1"
        end

        if EvasionCommonFunction(FALL_TYPE_DEFAULT, r1, "W_AttackRightHeavy1Start", "W_AttackLeftLight2",
            "W_AttackLeftHeavy1", b1, "W_AttackBothHeavy1Start", QUICKTYPE_ROLLING) == TRUE then
            return TRUE
        end
    elseif EvasionCommonFunction(FALL_TYPE_DEFAULT, "W_AttackRightLight1", "W_AttackRightHeavy1Start",
        "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", QUICKTYPE_ROLLING) ==
        TRUE then
        return TRUE
    end
    return FALSE
end

--------------
-- Triggers --
--------------

function Jump_Activate()
    Jump_InitWeaponRef = FALSE
    Jump_LeftWeaponRef = FALSE
    ActivateRightArmAdd(START_FRAME_A02)
    ResetDamageCount()
end

function Jump_Update()
    UpdateRightArmAdd()
    if Jump_LeftWeaponRef == FALSE and
        (IsNodeActive("Jump_N Selector_Magic_Left") == TRUE or IsNodeActive("Jump_F Selector_Magic_Left") == TRUE or
            IsNodeActive("Jump_D Selector_Magic_Left") == TRUE or IsNodeActive("Jump_Loop_Magic_Left_CMSG") == TRUE or
            IsNodeActive("Jump_Land_Common_Magic_Left_Swing_Selector") == TRUE or
            IsNodeActive("JumpMagic_Start_Falling_ConditionSelector_Left") == TRUE or
            IsNodeActive("JumpMagic_Start_Falling_F_ConditionSelector_Left") == TRUE or
            IsNodeActive("JumpMagic_Start_Falling_D_ConditionSelector_Left") == TRUE or
            IsNodeActive("JumpMagic_Start_Falling_D_ConditionSelector_Left") == TRUE) then
        SetAttackHand(HAND_LEFT)
        SetGuardHand(HAND_LEFT)
        Jump_InitWeaponRef = TRUE
        Jump_LeftWeaponRef = TRUE
    end

    if Jump_InitWeaponRef == FALSE then
        local hand = HAND_RIGHT

        if c_Style == HAND_LEFT_BOTH then
            hand = HAND_LEFT
        end

        SetAttackHand(hand)
        SetGuardHand(hand)
        Jump_InitWeaponRef = TRUE
        act(SetThrowPossibilityState_Defender, 400000)
    end
end

function Jump_Overweight_onActivate()
    SetAIActionState()
end

function Jump_Overweight_onUpdate()
    SetAIActionState()

    if EvasionCommonFunction(FALL_TYPE_DEFAULT, "W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", QUICKTYPE_ROLLING) == TRUE then
        return
    end
end

function Jump_Overweight_onDeactivate()
    act(DisallowAdditiveTurning, FALSE)
end

function Jump_N_onActivate()
    act(AIJumpState)
    SetAIActionState()
end

function Jump_N_onUpdate()
    SetAIActionState()
    JUMP_STATE_1 = 1
    JUMP_STATE_2 = 0
    JUMP_STATE_3 = 0

    if GetVariable("JumpReachSelector") == 0 and 0 < GetVariable("MoveSpeedLevel") then
        SetVariable("JumpReachSelector", 1)

        if GetVariable("IsLockon") == true then
            local jumpangle = GetVariable("MoveAngle")
            if jumpangle > -45 and jumpangle < 45 then
                SetVariable("JumpDirection", 0)
            elseif jumpangle >= 45 and jumpangle <= 135 then
                SetVariable("JumpDirection", 3)
            elseif jumpangle >= -135 and jumpangle <= -45 then
                SetVariable("JumpDirection", 2)
            else
                SetVariable("JumpDirection", 1)
            end
        else
            SetVariable("JumpDirection", 0)
        end
    end

    if JumpCommonFunction(0) == TRUE then
        return
    end
end

function Jump_N_onDeactivate()
    act(DisallowAdditiveTurning, FALSE)
end

function Jump_F_onActivate()
    act(AIJumpState)
    SetAIActionState()
end

function Jump_F_onUpdate()
    SetAIActionState()
    JUMP_STATE_1 = 0
    JUMP_STATE_2 = 1
    JUMP_STATE_3 = 0

    local rolling_angle = GetVariable("JumpAngle")
    local addratio = 0.4000000059604645
    local endratio = 1
    endratio = 1 + addratio * math.abs(math.sin(math.rad(2 * rolling_angle)))
    endratio = math.abs(endratio)
    act(SetMovementScaleMult, endratio)

    if JumpCommonFunction(1) == TRUE then
        return
    end
end

function Jump_F_onDeactivate()
    act(DisallowAdditiveTurning, FALSE)
end

function Jump_D_onActivate()
    act(AIJumpState)
    SetAIActionState()
end

function Jump_D_onUpdate()
    SetAIActionState()
    JUMP_STATE_1 = 0
    JUMP_STATE_2 = 0
    JUMP_STATE_3 = 1

    if GetVariable("JumpAttackForm") == 0 then
        act(LockonFixedAngleCancel)
    end

    if JumpCommonFunction(2) == TRUE then
        return
    end
end

function Jump_D_onDeactivate()
    act(DisallowAdditiveTurning, FALSE)
end

function Jump_Loop_onUpdate()
    SetAIActionState()
    act(DisallowAdditiveTurning, TRUE)

    if env(GetSpEffectID, 19935) == TRUE then
        if env(IsHamariFallDeath, 20) == TRUE then
            ExecEvent("W_FallDeath")
            return
        end
    elseif env(IsHamariFallDeath, 12) == TRUE then
        ExecEvent("W_FallDeath")
        return
    end

    local height = env(GetFallHeight) / 100

    if not (height >= 60) or env(GetStateChangeType, 266) == TRUE then
    else
        ExecEventAllBody("W_FallDeath")
        return TRUE
    end
    if Act_Jump() == TRUE then
        return
    end

    local equip_arm_no = 1

    if c_Style == HAND_LEFT_BOTH then
        equip_arm_no = 0
    end

    local arrowHand = 1

    if c_Style == HAND_LEFT_BOTH then
        arrowHand = 0
    end

    local is_arrow = GetEquipType(arrowHand, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_ARROW,
        WEAPON_CATEGORY_LARGE_ARROW, WEAPON_CATEGORY_CROSSBOW, WEAPON_CATEGORY_BALLISTA)

    if is_arrow == TRUE then
        if env(ActionRequest, 0) == TRUE then
            act(ChooseBowAndArrowSlot, 0)
            g_ArrowSlot = 0
        elseif env(ActionRequest, 1) == TRUE then
            act(ChooseBowAndArrowSlot, 1)
            g_ArrowSlot = 1
        end
    end

    if ExecJumpMagic(0) == TRUE then
    elseif env(GetEquipWeaponCategory, equip_arm_no) == WEAPON_CATEGORY_STAFF and env(ActionRequest, 0) == TRUE then
    elseif is_arrow == TRUE and
        (c_Style == HAND_RIGHT_BOTH or c_Style == HAND_LEFT_BOTH or GetEquipType(arrowHand, WEAPON_CATEGORY_CROSSBOW) ==
            TRUE) and env(IsOutOfAmmo, arrowHand) == TRUE then
    elseif GetEquipType(arrowHand, WEAPON_CATEGORY_CROSSBOW) == TRUE and env(GetBoltLoadingState, arrowHand) == FALSE then
    elseif env(ActionRequest, ACTION_ARM_R1) == TRUE and GetVariable("JumpAttackForm") == 0 then
        SetVariable("JumpAttackForm", 1)
        SetVariable("JumpAttackFormRequest", 0)
        hkbFireEvent("W_JumpAttack_Start_Falling")
        return
    elseif env(ActionRequest, ACTION_ARM_R2) == TRUE and GetVariable("JumpAttackForm") == 0 then
        if is_arrow == TRUE then
            SetVariable("JumpAttackForm", 1)
            SetVariable("JumpAttackFormRequest", 0)
            hkbFireEvent("W_JumpAttack_Start_Falling")
            return
        end
        SetVariable("JumpAttackForm", 2)
        SetVariable("JumpAttackFormRequest", 1)
        hkbFireEvent("W_JumpAttack_Start_Falling")
        return
    elseif env(ActionRequest, ACTION_ARM_L1) == TRUE and IsEnableDualWielding() == HAND_RIGHT then
        SetVariable("JumpAttackForm", 3)
        SetVariable("JumpAttackFormRequest", 2)
        hkbFireEvent("W_JumpAttack_Start_Falling")
        return
    end

    if 1 <= GetVariable("JumpAttackForm") then
        act(ResetInputQueue)
    end

    local landIndex = GetLandIndex(height, FALSE)

    if env(GetSpEffectID, 141) == TRUE then
        SetVariable("SwingPose", 0)
    elseif env(GetSpEffectID, 142) == TRUE then
        SetVariable("SwingPose", 0)
    elseif env(GetSpEffectID, 143) == TRUE then
        SetVariable("SwingPose", 0)
    elseif env(GetSpEffectID, 144) == TRUE then
        if landIndex == LAND_HEAVY then
            SetVariable("SwingPose", 3)
        else
            SetVariable("SwingPose", 2)
        end
    elseif env(GetSpEffectID, 145) == TRUE then
        SetVariable("SwingPose", 4)
    elseif landIndex == LAND_HEAVY then
        SetVariable("SwingPose", 3)
    else
        SetVariable("SwingPose", 2)
    end

    if env(GetSpEffectID, 98) == TRUE and env(IsTruelyLanding) == TRUE then
        SetVariable("LandIndex", landIndex)
        local JumpMoveLevel = 0

        if landIndex == 0 and GetVariable("JumpAttackForm") == 0 then
            if GetVariable("MoveSpeedLevel") > 1.100000023841858 then
                JumpMoveLevel = 2
            elseif GetVariable("MoveSpeedLevel") > 0.6000000238418579 then
                JumpMoveLevel = 1
            end
        end

        if env(GetSpEffectID, 503520) == TRUE then
            JumpMoveLevel = 0
        elseif env(GetSpEffectID, 5520) == TRUE then
            JumpMoveLevel = 0
        elseif env(GetSpEffectID, 425) == TRUE then
            JumpMoveLevel = 0
        elseif env(GetSpEffectID, 4101) == TRUE then
            JumpMoveLevel = 0
        elseif env(GetSpEffectID, 4100) == TRUE then
            JumpMoveLevel = 0
        elseif env(GetSpEffectID, 19670) == TRUE then
            JumpMoveLevel = 0
        end

        if JumpMoveLevel == 2 then
            ExecEventNoReset("W_Jump_Land_To_Dash")
            return
        elseif JumpMoveLevel == 1 then
            SetVariable("JumpLandMoveDirection", GetVariable("MoveDirection"))
            ExecEventNoReset("W_Jump_Land_To_Run")
            return
        end

        if landIndex > 0 then
            ResetRequest()
        end

        if JUMP_STATE_1 == 1 then
            ExecEventNoReset("W_Jump_Land_N")
        elseif JUMP_STATE_2 == 1 then
            ExecEventNoReset("W_Jump_Land_F")
        elseif JUMP_STATE_3 == 1 then
            ExecEventNoReset("W_Jump_Land_D")
        else
            ExecEventNoReset("W_Jump_Land_N")
        end
        return
    end
end

function Jump_Loop_onDeactivate()
    act(DisallowAdditiveTurning, FALSE)
end

function Jump_Land_N_onUpdate()
    if JumpLandCommonFunction() == TRUE then
        return
    end
end

function Jump_Land_N_onDeactivate()
    SetVariable("JumpAttack_Land", 0)
end

function Jump_Land_F_onUpdate()
    if JumpLandCommonFunction() == TRUE then
        return
    end
end

function Jump_Land_D_onUpdate()
    if JumpLandCommonFunction() == TRUE then
        return
    end
end

function Jump_Land_To_Run_onUpdate()
    act(SwitchMotion, TRUE)
    SetEnableAimMode()
    SetVariable("JumpLandMoveDirection", GetVariable("MoveDirection"))
    SetVariable("MoveSpeedLevelReal", 1)

    if ExecStop() == TRUE then
        return
    end
    if env(IsMoveCancelPossible) == TRUE and MoveStart(ALLBODY, Event_MoveLong, FALSE) == TRUE then
        return
    end
    if EvasionCommonFunction(FALL_TYPE_DEFAULT, "W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", QUICKTYPE_NORMAL) == TRUE then
        return
    end
end

function Jump_Land_To_Dash_onUpdate()
    act(LockonFixedAngleCancel)
    SetEnableAimMode()
    SetVariable("MoveSpeedLevelReal", 2)

    if ExecStop() == TRUE then
        return
    end
    if env(IsMoveCancelPossible) == TRUE and MoveStart(ALLBODY, Event_MoveLong, FALSE) == TRUE then
        return
    end
    if EvasionCommonFunction(FALL_TYPE_DEFAULT, "W_AttackRightLightDash", "W_AttackRightHeavyDash",
        "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothDash", "W_AttackBothHeavyDash", QUICKTYPE_NORMAL) ==
        TRUE then
        return
    end
end

function JumpDamage_Start_onActivate()
    act(ResetInputQueue)
end

function JumpDamage_Start_onUpdate()
    JUMP_STATE_1 = 1
    JUMP_STATE_2 = 0
    JUMP_STATE_3 = 0
    act(DenyEventAnimPlaybackRequest)
    local height = env(GetFallHeight) / 100
    local damage_type = env(GetReceivedDamageType)

    if env(GetSpEffectID, 19935) == TRUE then
        if env(IsHamariFallDeath, 20) == TRUE then
            ExecEventAllBody("W_FallDeath")
            return
        end
    elseif env(IsHamariFallDeath, 12) == TRUE then
        ExecEventAllBody("W_FallDeath")
        return
    end

    if env(GetSpEffectID, 98) == TRUE and env(IsTruelyLanding) == TRUE then
        hkbFireEvent("W_JumpDamage_Land")
        return
    end
end

function JumpDamage_Land_onActivate()
    act(ResetInputQueue)
end

function JumpDamage_Land_onUpdate()
    act(DenyEventAnimPlaybackRequest)
    if EvasionCommonFunction(FALL_TYPE_DEFAULT, "W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", QUICKTYPE_ROLLING) == TRUE then
        return
    end
end
