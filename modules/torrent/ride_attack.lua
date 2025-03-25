
function ExecRideAttack(r1, r2, l1, l2)
    local attackHand = HAND_RIGHT

    if c_Style == HAND_LEFT_BOTH then
        attackHand = HAND_LEFT
    end

    local is_arrow = GetEquipType(attackHand, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_ARROW,
        WEAPON_CATEGORY_CROSSBOW)
    local is_staff = GetEquipType(attackHand, WEAPON_CATEGORY_STAFF)
    local sp_kind = env(GetEquipWeaponSpecialCategoryNumber, attackHand)
    local is_weaponStaff = FALSE
    if IsWeaponCatalyst(sp_kind) == TRUE then
        is_weaponStaff = TRUE
    end

    if env(ActionDuration, ACTION_ARM_ACTION) > 0 then
        return FALSE
    end
    if env(GetStamina) < 0 then
        ResetRequest()
        return FALSE
    end
    if env(ActionRequest, 0) == TRUE and is_staff == FALSE or env(ActionRequest, 1) == TRUE and is_staff == TRUE then
        act(ResetInputQueue)
        SetVariable("RideAttackHand", HAND_RIGHT)
        if is_arrow == TRUE then
            if GetEquipType(attackHand, WEAPON_CATEGORY_CROSSBOW) == TRUE and env(GetBoltLoadingState, attackHand) ==
                FALSE then
                if attackHand == HAND_LEFT then
                    ExecEventAllBody("W_RideAttackCrossbowLeftReload")
                else
                    ExecEventAllBody("W_RideAttackCrossbowRightReload")
                end
                return TRUE
            end
            g_ArrowSlot = 0
            act(ChooseBowAndArrowSlot, 0)

            if env(IsOutOfAmmo, attackHand) == TRUE then
                ExecEventAllBody("W_RideNoArrow")
                return TRUE
            end
            ExecEventAllBody("W_RideAttackArrowStart")
            return TRUE
        end
        ExecEventAllBody(r1)
    elseif env(ActionRequest, 1) == TRUE and is_weaponStaff == FALSE then
        act(ResetInputQueue)
        SetVariable("RideAttackHand", HAND_RIGHT)

        if is_arrow == TRUE then
            if GetEquipType(attackHand, WEAPON_CATEGORY_CROSSBOW) == TRUE and env(GetBoltLoadingState, attackHand) ==
                FALSE then
                if attackHand == HAND_LEFT then
                    ExecEventAllBody("W_RideAttackCrossbowLeftReload")
                else
                    ExecEventAllBody("W_RideAttackCrossbowRightReload")
                end
                return TRUE
            end
            g_ArrowSlot = 1
            act(ChooseBowAndArrowSlot, 1)
            if env(IsOutOfAmmo, attackHand) == TRUE then
                ExecEventAllBody("W_RideNoArrow")
                return TRUE
            end
            ExecEventAllBody("W_RideAttackArrowStart")
            return TRUE
        elseif GetEquipType(attackHand, WEAPON_CATEGORY_STAFF) == TRUE then
            return FALSE
        end

        ExecEventAllBody(r2)
    elseif env(ActionRequest, 2) == TRUE or env(ActionRequest, 3) == TRUE and is_staff == TRUE then
        act(ResetInputQueue)
        SetVariable("RideAttackHand", HAND_LEFT)

        if is_arrow == TRUE then
            return FALSE
        end

        ExecEventAllBody(l1)
    elseif env(ActionRequest, 3) == TRUE then
        act(ResetInputQueue)
        SetVariable("RideAttackHand", HAND_LEFT)

        if is_arrow == TRUE then
            return FALSE
        end

        ExecEventAllBody(l2)
    else
        return FALSE
    end

    SetInterruptType(INTERRUPT_FINDATTACK)
    return TRUE
end

function IsEnableRideAttackHard2(hand)
    local style = c_Style

    if style == HAND_LEFT_BOTH then
        hand = HAND_LEFT
    end

    local kind = env(GetEquipWeaponCategory, hand)

    if kind == WEAPON_CATEGORY_RAPIER or kind == WEAPON_CATEGORY_LARGE_RAPIER then
        return TRUE
    else
        return FALSE
    end
end

----------------------
-- Common functions --
----------------------

function RideAttackCommonFunction(r1, r2, l1, l2)
    if RideCommonFunction(r1, r2, l1, l2) == TRUE then
        return TRUE
    end
    if c_Style == HAND_LEFT_BOTH then
        SetAttackHand(HAND_LEFT)
        SetGuardHand(HAND_LEFT)
    else
        SetAttackHand(HAND_RIGHT)
        SetGuardHand(HAND_RIGHT)
    end
    return FALSE
end

function RideJumpAttackCommonFunction()
    if env(GetSpEffectID, 19935) == TRUE then
        if env(IsHamariFallDeath, 20) == TRUE and env(GetSpEffectID, 185) == FALSE then
            FireRideEvent("W_RideDeath", "W_RideDeath", FALSE)
            return
        end
    elseif env(IsHamariFallDeath, 12) == TRUE and env(GetSpEffectID, 185) == FALSE then
        FireRideEvent("W_RideDeath", "W_RideDeath", FALSE)
        return
    end
end

--------------
-- Triggers --
--------------

function RideRepelledWall_onUpdate()
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
end

function RideRepelledSmall_onUpdate()
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
end

function RideRepelledLarge_onUpdate()
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
end

function RideAttack_BackKick_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    act(ResetInputQueue)
end

function RideAttack_BackKick_onUpdate()
    SetAIActionState()
    act(DisallowAdditiveTurning, TRUE)

    if RideAttackCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
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

function RideAttack_BackKick_onDeactivate()
    act(DisallowAdditiveTurning, FALSE)
end

function RideAttack_R_Top_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    act(ResetInputQueue)
end

function RideAttack_R_Top_onUpdate()
    SetAIActionState()
    act(DisallowAdditiveTurning, TRUE)

    if RideAttackCommonFunction("W_RideAttack_R_Top02", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
end

function RideAttack_R_Top_onDeactivate()
    act(DisallowAdditiveTurning, FALSE)
end

function RideAttack_R_Top02_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    act(ResetInputQueue)
end

function RideAttack_R_Top02_onUpdate()
    SetAIActionState()
    act(DisallowAdditiveTurning, TRUE)

    if RideAttackCommonFunction("W_RideAttack_R_Top03", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
end

function RideAttack_R_Top02_onDeactivate()
    act(DisallowAdditiveTurning, FALSE)
end

function RideAttack_R_Top03_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    act(ResetInputQueue)
end

function RideAttack_R_Top03_onUpdate()
    SetAIActionState()
    act(DisallowAdditiveTurning, TRUE)

    if RideAttackCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
end

function RideAttack_R_Top03_onDeactivate()
    act(DisallowAdditiveTurning, FALSE)
end

function RideAttack_R_Hard1_Start_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    act(ResetInputQueue)
    SetVariable("RideAttack_JumpCondition", 0)
end

function RideAttack_R_Hard1_Start_onUpdate()
    SetAIActionState()
    act(DisallowAdditiveTurning, TRUE)
    local r2 = "W_RideAttack_R_Hard1_Start"

    if IsEnableRideAttackHard2(HAND_RIGHT) == TRUE and env(GetEquipWeaponSpecialCategoryNumber, HAND_RIGHT) ~= 241 then
        r2 = "W_RideAttack_R_Hard2_Start"
    end

    if RideAttackCommonFunction("W_RideAttack_R_Top", r2, "W_RideAttack_L_Top", "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end

    local attackHand = HAND_RIGHT

    if c_Style == HAND_LEFT_BOTH then
        attackHand = HAND_LEFT
    end

    local isShield = GetEquipType(attackHand, WEAPON_CATEGORY_LARGE_SHIELD, WEAPON_CATEGORY_SMALL_SHIELD,
        WEAPON_CATEGORY_MIDDLE_SHIELD)

    if env(ActionRequest, 6) == TRUE and
        (env(GetGeneralTAEFlag, TAE_FLAG_CHARGING) == 1 or env(GetSpEffectID, 100280) == TRUE) and isShield == FALSE then
        local jumpEvent = "W_RideJump_N"
        if GetVariable("MoveSpeedLevel") >= 1.5 then
            jumpEvent = "W_RideJump_D"
        elseif GetVariable("MoveSpeedLevel") >= 0.6000000238418579 then
            jumpEvent = "W_RideJump_F"
        end
        if env(GetSpEffectID, 102360) == FALSE then
            act(ChangeStamina, STAMINA_REDUCE_RIDE_JUMP)
        end
        SetVariable("RideJumpAttack_Land", 0)
        FireRideEvent("W_RideAttack_Jump_R_Hard1", jumpEvent, FALSE)
        return TRUE
    end
    if env(ActionDuration, ACTION_ARM_R2) <= 0 and
        (env(GetGeneralTAEFlag, TAE_FLAG_CHARGING) == 1 or env(GetSpEffectID, 100280) == TRUE) then
        ExecEventAllBody("W_RideAttack_R_Hard1_End")
        return
    end
end

function RideAttack_R_Hard1_Start_onDeactivate()
    act(DisallowAdditiveTurning, FALSE)
end

function RideAttack_R_Hard1_End_onActivate()
    act(ResetInputQueue)
end

function RideAttack_R_Hard1_End_onUpdate()
    act(DisallowAdditiveTurning, TRUE)
    local r2 = "W_RideAttack_R_Hard1_Start"

    if IsEnableRideAttackHard2(HAND_RIGHT) == TRUE and env(GetEquipWeaponSpecialCategoryNumber, HAND_RIGHT) ~= 241 then
        r2 = "W_RideAttack_R_Hard2_Start"
    end

    if RideAttackCommonFunction("W_RideAttack_R_Top", r2, "W_RideAttack_L_Top", "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if env(GetSpEffectID, 131) == FALSE and
        (GetVariable("RideAttack_JumpCondition") == 0 or env(IsMoveCancelPossible) == TRUE) and
        RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
end

function RideAttack_R_Hard1_End_onDeactivate()
    act(DisallowAdditiveTurning, FALSE)
end

function RideAttack_R_Hard2_Start_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    act(ResetInputQueue)
    SetVariable("RideAttack_JumpCondition", 0)
end

function RideAttack_R_Hard2_Start_onUpdate()
    SetAIActionState()
    act(DisallowAdditiveTurning, TRUE)

    if RideAttackCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end

    local attackHand = HAND_RIGHT

    if c_Style == HAND_LEFT_BOTH then
        attackHand = HAND_LEFT
    end

    local isShield = GetEquipType(attackHand, WEAPON_CATEGORY_LARGE_SHIELD, WEAPON_CATEGORY_SMALL_SHIELD,
        WEAPON_CATEGORY_MIDDLE_SHIELD)

    if env(ActionRequest, 6) == TRUE and
        (env(GetGeneralTAEFlag, TAE_FLAG_CHARGING) == 1 or env(GetSpEffectID, 100280) == TRUE) and isShield == FALSE then
        local jumpEvent = "W_RideJump_N"
        if GetVariable("MoveSpeedLevel") >= 1.5 then
            jumpEvent = "W_RideJump_D"
        elseif GetVariable("MoveSpeedLevel") >= 0.6000000238418579 then
            jumpEvent = "W_RideJump_F"
        end
        if env(GetSpEffectID, 102360) == FALSE then
            act(ChangeStamina, STAMINA_REDUCE_RIDE_JUMP)
        end
        SetVariable("RideJumpAttack_Land", 0)
        FireRideEvent("W_RideAttack_Jump_R_Hard2", jumpEvent, FALSE)
        return TRUE
    end
    if env(ActionDuration, ACTION_ARM_R2) <= 0 and
        (env(GetGeneralTAEFlag, TAE_FLAG_CHARGING) == 1 or env(GetSpEffectID, 100280) == TRUE) then
        ExecEventAllBody("W_RideAttack_R_Hard2_End")
        return
    end
end

function RideAttack_R_Hard2_Start_onDeactivate()
    act(DisallowAdditiveTurning, FALSE)
end

function RideAttack_R_Hard2_End_onActivate()
    act(ResetInputQueue)
end

function RideAttack_R_Hard2_End_onUpdate()
    act(DisallowAdditiveTurning, TRUE)

    if RideAttackCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if env(GetSpEffectID, 131) == FALSE and RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
end

function RideAttack_R_Hard2_End_onDeactivate()
    act(DisallowAdditiveTurning, FALSE)
end

function RideAttack_L_Hard1_Start_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    act(ResetInputQueue)
    SetVariable("RideAttack_JumpCondition", 0)
end

function RideAttack_L_Hard1_Start_onUpdate()
    SetAIActionState()
    act(DisallowAdditiveTurning, TRUE)
    local l2 = "W_RideAttack_L_Hard1_Start"

    if IsEnableRideAttackHard2(HAND_RIGHT) == TRUE and env(GetEquipWeaponSpecialCategoryNumber, HAND_RIGHT) ~= 241 then
        l2 = "W_RideAttack_L_Hard2_Start"
    end

    if RideAttackCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top", l2) == TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end

    local attackHand = HAND_RIGHT

    if c_Style == HAND_LEFT_BOTH then
        attackHand = HAND_LEFT
    end

    local isShield = GetEquipType(attackHand, WEAPON_CATEGORY_LARGE_SHIELD, WEAPON_CATEGORY_SMALL_SHIELD,
        WEAPON_CATEGORY_MIDDLE_SHIELD)

    if env(ActionRequest, 6) == TRUE and
        (env(GetGeneralTAEFlag, TAE_FLAG_CHARGING) == 1 or env(GetSpEffectID, 100280) == TRUE) and isShield == FALSE then
        local jumpEvent = "W_RideJump_N"
        if GetVariable("MoveSpeedLevel") >= 1.5 then
            jumpEvent = "W_RideJump_D"
        elseif GetVariable("MoveSpeedLevel") >= 0.6000000238418579 then
            jumpEvent = "W_RideJump_F"
        end
        if env(GetSpEffectID, 102360) == FALSE then
            act(ChangeStamina, STAMINA_REDUCE_RIDE_JUMP)
        end
        SetVariable("RideJumpAttack_Land", 0)
        FireRideEvent("W_RideAttack_Jump_L_Hard1", jumpEvent, FALSE)
        return TRUE
    end
    if env(ActionDuration, ACTION_ARM_L2) <= 0 and
        (env(GetGeneralTAEFlag, TAE_FLAG_CHARGING) == 1 or env(GetSpEffectID, 100280) == TRUE) then
        ExecEventAllBody("W_RideAttack_L_Hard1_End")
        return
    end
end

function RideAttack_L_Hard1_Start_onDeactivate()
    act(DisallowAdditiveTurning, FALSE)
end

function RideAttack_L_Hard1_End_onActivate()
    act(ResetInputQueue)
end

function RideAttack_L_Hard1_End_onUpdate()
    act(DisallowAdditiveTurning, TRUE)
    local l2 = "W_RideAttack_L_Hard1_Start"

    if IsEnableRideAttackHard2(HAND_RIGHT) == TRUE and env(GetEquipWeaponSpecialCategoryNumber, HAND_RIGHT) ~= 241 then
        l2 = "W_RideAttack_L_Hard2_Start"
    end

    if RideAttackCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top", l2) == TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if env(GetSpEffectID, 131) == FALSE and RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
end

function RideAttack_L_Hard1_End_onDeactivate()
    act(DisallowAdditiveTurning, FALSE)
end

function RideAttack_L_Hard2_Start_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    act(ResetInputQueue)
    SetVariable("RideAttack_JumpCondition", 0)
end

function RideAttack_L_Hard2_Start_onUpdate()
    SetAIActionState()
    act(DisallowAdditiveTurning, TRUE)

    if RideAttackCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end

    local attackHand = HAND_RIGHT

    if c_Style == HAND_LEFT_BOTH then
        attackHand = HAND_LEFT
    end

    local isShield = GetEquipType(attackHand, WEAPON_CATEGORY_LARGE_SHIELD, WEAPON_CATEGORY_SMALL_SHIELD,
        WEAPON_CATEGORY_MIDDLE_SHIELD)

    if env(ActionRequest, 6) == TRUE and
        (env(GetGeneralTAEFlag, TAE_FLAG_CHARGING) == 1 or env(GetSpEffectID, 100280) == TRUE) and isShield == FALSE then
        local jumpEvent = "W_RideJump_N"
        if GetVariable("MoveSpeedLevel") >= 1.5 then
            jumpEvent = "W_RideJump_D"
        elseif GetVariable("MoveSpeedLevel") >= 0.6000000238418579 then
            jumpEvent = "W_RideJump_F"
        end

        if env(GetSpEffectID, 102360) == FALSE then
            act(ChangeStamina, STAMINA_REDUCE_RIDE_JUMP)
        end

        SetVariable("RideJumpAttack_Land", 0)
        FireRideEvent("W_RideAttack_Jump_L_Hard2", jumpEvent, FALSE)
        return TRUE
    end
    if env(ActionDuration, ACTION_ARM_L2) <= 0 and
        (env(GetGeneralTAEFlag, TAE_FLAG_CHARGING) == 1 or env(GetSpEffectID, 100280) == TRUE) then
        ExecEventAllBody("W_RideAttack_L_Hard2_End")
        return
    end
end

function RideAttack_L_Hard2_Start_onDeactivate()
    act(DisallowAdditiveTurning, FALSE)
end

function RideAttack_L_Hard2_End_onActivate()
    act(ResetInputQueue)
end

function RideAttack_L_Hard2_End_onUpdate()
    act(DisallowAdditiveTurning, TRUE)

    if RideAttackCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if env(GetSpEffectID, 131) == FALSE and RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
end

function RideAttack_L_Hard2_End_onDeactivate()
    act(DisallowAdditiveTurning, FALSE)
end

function RideAttack_L_Top_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    act(ResetInputQueue)
end

function RideAttack_L_Top_onUpdate()
    SetAIActionState()
    act(DisallowAdditiveTurning, TRUE)
    local r1 = "W_RideAttack_R_Top"

    if RideAttackCommonFunction(r1, "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top02", "W_RideAttack_L_Hard1_Start") ==
        TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
end

function RideAttack_L_Top_onDeactivate()
    act(DisallowAdditiveTurning, FALSE)
end

function RideAttack_L_Top02_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    act(ResetInputQueue)
end

function RideAttack_L_Top02_onUpdate()
    SetAIActionState()
    act(DisallowAdditiveTurning, TRUE)
    local r1 = "W_RideAttack_R_Top"

    if RideAttackCommonFunction(r1, "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top03", "W_RideAttack_L_Hard1_Start") ==
        TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
end

function RideAttack_L_Top02_onDeactivate()
    act(DisallowAdditiveTurning, FALSE)
end

function RideAttack_L_Top03_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    act(ResetInputQueue)
end

function RideAttack_L_Top03_onUpdate()
    SetAIActionState()
    act(DisallowAdditiveTurning, TRUE)
    local r1 = "W_RideAttack_R_Top"

    if RideAttackCommonFunction(r1, "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top", "W_RideAttack_L_Hard1_Start") ==
        TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
end

function RideAttack_L_Top03_onDeactivate()
    act(DisallowAdditiveTurning, FALSE)
end

function RideAttackArrowStart_onUpdate()
    SetAIActionState()
    act(SetIsPreciseShootingPossible)
    act(DisallowAdditiveTurning, TRUE)

    if RideAttackCommonFunction() == TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        if g_ArrowSlot == 0 then
            if env(ActionDuration, ACTION_ARM_R1) > 0 then
                ExecEventAllBody("W_RideAttackArrowLoop")
                return
            else
                local fireEvent = "W_RideAttackArrowFire"

                if c_Style == HAND_LEFT_BOTH and GetEquipType(HAND_LEFT, WEAPON_CATEGORY_CROSSBOW) == TRUE then
                    fireEvent = "W_RideAttackCrossbowLeftFire"
                end

                ExecEventAllBody(fireEvent)
                return
            end
        elseif env(ActionDuration, ACTION_ARM_R2) > 0 then
            ExecEventAllBody("W_RideAttackArrowLoop")
            return
        else
            local fireEvent = "W_RideAttackArrowFire"

            if c_Style == HAND_LEFT_BOTH and GetEquipType(HAND_LEFT, WEAPON_CATEGORY_CROSSBOW) == TRUE then
                fireEvent = "W_RideAttackCrossbowLeftFire"
            end

            ExecEventAllBody(fireEvent)
            return
        end
    end
end

function RideAttackArrowStartContinue_onUpdate()
    SetAIActionState()
    act(SetIsPreciseShootingPossible)
    act(DisallowAdditiveTurning, TRUE)

    if RideAttackCommonFunction() == TRUE then
        return
    end
    if RideReActionFunction() == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        if g_ArrowSlot == 0 then
            if env(ActionDuration, ACTION_ARM_R1) > 0 then
                hkbFireEvent("W_RideAttackArrowLoop")
                return
            else
                hkbFireEvent("W_RideAttackArrowFire")
                return
            end
        elseif env(ActionDuration, ACTION_ARM_R2) > 0 then
            hkbFireEvent("W_RideAttackArrowLoop")
            return
        else
            hkbFireEvent("W_RideAttackArrowFire")
            return
        end
    end
    if ExecRideItem() == TRUE then
        return TRUE
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
end

function RideAttackArrowLoop_onUpdate()
    SetAIActionState()
    act(SetIsPreciseShootingPossible)
    act(DisallowAdditiveTurning, TRUE)

    if RideAttackCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
    if g_ArrowSlot == 0 then
        if env(ActionDuration, ACTION_ARM_R1) <= 0 then
            local fireEvent = "W_RideAttackArrowFire"

            if c_Style == HAND_LEFT_BOTH and GetEquipType(HAND_LEFT, WEAPON_CATEGORY_CROSSBOW) == TRUE then
                fireEvent = "W_RideAttackCrossbowLeftFire"
            end

            ExecEventAllBody(fireEvent)
            return
        end
    elseif env(ActionDuration, ACTION_ARM_R2) <= 0 then
        local fireEvent = "W_RideAttackArrowFire"

        if c_Style == HAND_LEFT_BOTH and GetEquipType(HAND_LEFT, WEAPON_CATEGORY_CROSSBOW) == TRUE then
            fireEvent = "W_RideAttackCrossbowLeftFire"
        end

        ExecEventAllBody(fireEvent)
        return
    end
end

function RideAttackArrowFire_onUpdate()
    SetAIActionState()
    act(SetIsPreciseShootingPossible)
    act(DisallowAdditiveTurning, TRUE)
    local arrowHand = 1

    if c_Style == HAND_LEFT_BOTH then
        arrowHand = 0
    end

    local is_crossbow = GetEquipType(arrowHand, WEAPON_CATEGORY_CROSSBOW)

    if env(ActionRequest, 0) == TRUE and is_crossbow == FALSE then
        act(ResetInputQueue)
        g_ArrowSlot = 0
        act(ChooseBowAndArrowSlot, 0)
        if env(IsOutOfAmmo, arrowHand) == TRUE then
            ExecEventAllBody("W_RideNoArrow")
            return TRUE
        end
        ExecEventAllBody("W_RideAttackArrowStartContinue")
        return TRUE
    elseif env(ActionRequest, 1) == TRUE and env(ActionDuration, 1) > 0 and is_crossbow == FALSE then
        act(ResetInputQueue)
        g_ArrowSlot = 1
        act(ChooseBowAndArrowSlot, 1)

        if env(IsOutOfAmmo, arrowHand) == TRUE then
            ExecEventAllBody("W_RideNoArrow")
            return TRUE
        end
        ExecEventAllBody("W_RideAttackArrowStartContinue")
        return TRUE
    end
    if RideAttackCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
    if env(IsAnimEnd, 0) == TRUE then
        hkbFireEvent("W_RideIdle")
    end
end

function RideAttackArrowFire_onDeactivate()
    act(DisallowAdditiveTurning, FALSE)
end

function RideAttackCrossbowLeftFire_onUpdate()
    SetAIActionState()
    act(SetIsPreciseShootingPossible)
    act(DisallowAdditiveTurning, TRUE)
    local arrowHand = 1

    if c_Style == HAND_LEFT_BOTH then
        arrowHand = 0
    end

    local is_crossbow = GetEquipType(arrowHand, WEAPON_CATEGORY_CROSSBOW)

    if env(ActionRequest, 0) == TRUE and is_crossbow == FALSE then
        act(ResetInputQueue)
        g_ArrowSlot = 0
        act(ChooseBowAndArrowSlot, 0)
        if env(IsOutOfAmmo, arrowHand) == TRUE then
            ExecEventAllBody("W_RideNoArrow")
            return TRUE
        end
        ExecEventAllBody("W_RideAttackArrowStartContinue")
        return TRUE
    elseif env(ActionRequest, 1) == TRUE and env(ActionDuration, 1) > 0 and is_crossbow == FALSE then
        act(ResetInputQueue)
        g_ArrowSlot = 1
        act(ChooseBowAndArrowSlot, 1)
        if env(IsOutOfAmmo, arrowHand) == TRUE then
            ExecEventAllBody("W_RideNoArrow")
            return TRUE
        end
        ExecEventAllBody("W_RideAttackArrowStartContinue")
        return TRUE
    end
    if RideAttackCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
    if env(IsAnimEnd, 0) == TRUE then
        hkbFireEvent("W_RideIdle")
    end
end

function RideAttackCrossbowLeftFire_onDeactivate()
    act(DisallowAdditiveTurning, FALSE)
end

function RideNoArrow_onUpdate()
    SetAIActionState()
    act(SetIsPreciseShootingPossible)

    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
    if env(IsAnimEnd, 0) == TRUE then
        hkbFireEvent("W_RideIdle")
    end
end

function RideAttackCrossbowRightReload_onUpdate()
    SetAIActionState()
    act(SetIsPreciseShootingPossible)

    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
    if env(IsAnimEnd, 0) == TRUE then
        hkbFireEvent("W_RideIdle")
    end
end

function RideAttackCrossbowLeftReload_onUpdate()
    SetAIActionState()
    act(SetIsPreciseShootingPossible)

    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        hkbFireEvent("W_RideIdle")
    end
end

function RideAttack_Jump_R_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
end

function RideAttack_Jump_R_onUpdate()
    SetAIActionState()
    act(DisallowAdditiveTurning, TRUE)
    SetVariable("Int16Variable01", 1)
    RideJumpAttackCommonFunction()

    if GetVariable("RideJumpAttack_Land") == 1 then
        if RideCommonFunction("W_RideAttack_R_Top02", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
            "W_RideAttack_L_Hard1_Start") == TRUE then
            return
        end
        if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
            if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, TRUE, FALSE) == TRUE then
                return
            end
        else
            if ExecRideStop(RIDE_MOVE_TYPE_OTHER, TRUE) == TRUE then
                return
            end
            if (env(GetMountSpEffectID, 101100) == TRUE or env(GetMountSpEffectID, 101006) == TRUE or
                env(GetMountSpEffectID, 101005) == TRUE) and GetVariable("MoveSpeedLevel") > 0 and
                RideRequestFunction(RIDE_MOVE_TYPE_OTHER, FALSE, TRUE) == TRUE then
                return
            end
        end
    elseif env(GetMountSpEffectID, 98) == TRUE and env(IsTruelyLanding) == TRUE and env(GetMountSpEffectID, 140) ==
        FALSE then
        SetVariable("RideJumpAttack_Land", 1)
        RideJumpCommonFunction(GetVariable("IndexRideJumpType"), TRUE, FALSE, FALSE)
    elseif env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        if RideJumpLoop_IsSecond == TRUE then
            FireRideEvent("W_RideJump2_Loop", "W_RideJump2_Loop", FALSE)
        else
            FireRideEvent("W_RideJump_Loop", "W_RideJump_Loop", FALSE)
        end
        return
    end
end

function RideAttack_Jump_R_Hard1_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
end

function RideAttack_Jump_R_Hard1_onUpdate()
    SetAIActionState()
    act(DisallowAdditiveTurning, TRUE)
    SetVariable("Int16Variable01", 1)

    if GetVariable("RideJumpAttack_Land") == 1 then
        local r2 = "W_RideAttack_R_Hard1_Start"
        if IsEnableRideAttackHard2(HAND_RIGHT) == TRUE and env(GetEquipWeaponSpecialCategoryNumber, HAND_RIGHT) ~= 241 then
            r2 = "W_RideAttack_R_Hard2_Start"
        end
        if RideCommonFunction("W_RideAttack_R_Top", r2, "W_RideAttack_L_Top", "W_RideAttack_L_Hard1_Start") == TRUE then
            return
        end
        if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
            if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, TRUE, FALSE) == TRUE then
                return
            end
        else
            if ExecRideStop(RIDE_MOVE_TYPE_OTHER, TRUE) == TRUE then
                return
            end
            if (env(GetMountSpEffectID, 101100) == TRUE or env(GetMountSpEffectID, 101006) == TRUE or
                env(GetMountSpEffectID, 101005) == TRUE) and GetVariable("MoveSpeedLevel") > 0 and
                RideRequestFunction(RIDE_MOVE_TYPE_OTHER, FALSE, TRUE) == TRUE then
                return
            end
        end
    elseif env(GetMountSpEffectID, 98) == TRUE and env(IsTruelyLanding) == TRUE and env(GetMountSpEffectID, 140) ==
        FALSE then
        SetVariable("RideJumpAttack_Land", 1)
        RideJumpCommonFunction(GetVariable("IndexRideJumpType"), TRUE, FALSE, FALSE)
    elseif env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        FireRideEvent("W_RideJump_Loop", "W_RideJump_Loop", FALSE)
        return
    end
end

function RideAttack_Jump_R_Hard2_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
end

function RideAttack_Jump_R_Hard2_onUpdate()
    SetAIActionState()
    act(DisallowAdditiveTurning, TRUE)
    SetVariable("Int16Variable01", 1)

    if GetVariable("RideJumpAttack_Land") == 1 then
        if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
            "W_RideAttack_L_Hard1_Start") == TRUE then
            return
        end
        if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
            if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, TRUE, FALSE) == TRUE then
                return
            end
        else
            if ExecRideStop(RIDE_MOVE_TYPE_OTHER, TRUE) == TRUE then
                return
            end
            if (env(GetMountSpEffectID, 101100) == TRUE or env(GetMountSpEffectID, 101006) == TRUE or
                env(GetMountSpEffectID, 101005) == TRUE) and GetVariable("MoveSpeedLevel") > 0 and
                RideRequestFunction(RIDE_MOVE_TYPE_OTHER, FALSE, TRUE) == TRUE then
                return
            end
        end
    elseif env(GetMountSpEffectID, 98) == TRUE and env(IsTruelyLanding) == TRUE and env(GetMountSpEffectID, 140) ==
        FALSE then
        SetVariable("RideJumpAttack_Land", 1)
        RideJumpCommonFunction(GetVariable("IndexRideJumpType"), TRUE, FALSE, FALSE)
    elseif env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        FireRideEvent("W_RideJump_Loop", "W_RideJump_Loop", FALSE)
        return
    end
end

function RideAttack_Jump_L_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
end

function RideAttack_Jump_L_onUpdate()
    SetAIActionState()
    act(DisallowAdditiveTurning, TRUE)
    SetVariable("Int16Variable01", 1)
    RideJumpAttackCommonFunction()

    if GetVariable("RideJumpAttack_Land") == 1 then
        if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top02",
            "W_RideAttack_L_Hard1_Start") == TRUE then
            return
        end
        if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
            if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, TRUE, FALSE) == TRUE then
                return
            end
        else
            if ExecRideStop(RIDE_MOVE_TYPE_OTHER, TRUE) == TRUE then
                return
            end
            if (env(GetMountSpEffectID, 101100) == TRUE or env(GetMountSpEffectID, 101006) == TRUE or
                env(GetMountSpEffectID, 101005) == TRUE) and GetVariable("MoveSpeedLevel") > 0 and
                RideRequestFunction(RIDE_MOVE_TYPE_OTHER, FALSE, TRUE) == TRUE then
                return
            end
        end
    elseif env(GetMountSpEffectID, 98) == TRUE and env(IsTruelyLanding) == TRUE and env(GetMountSpEffectID, 140) ==
        FALSE then
        SetVariable("RideJumpAttack_Land", 1)
        RideJumpCommonFunction(GetVariable("IndexRideJumpType"), TRUE, FALSE, FALSE)
    elseif env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        FireRideEvent("W_RideJump_Loop", "W_RideJump_Loop", FALSE)
        return
    end
end

function RideAttack_Jump_L_Hard1_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
end

function RideAttack_Jump_L_Hard1_onUpdate()
    SetAIActionState()
    act(DisallowAdditiveTurning, TRUE)
    SetVariable("Int16Variable01", 1)

    if GetVariable("RideJumpAttack_Land") == 1 then
        local l2 = "W_RideAttack_L_Hard1_Start"
        if IsEnableRideAttackHard2(HAND_RIGHT) == TRUE and env(GetEquipWeaponSpecialCategoryNumber, HAND_RIGHT) ~= 241 then
            l2 = "W_RideAttack_L_Hard2_Start"
        end
        if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top", l2) == TRUE then
            return
        end
        if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
            if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, TRUE, FALSE) == TRUE then
                return
            end
        else
            if ExecRideStop(RIDE_MOVE_TYPE_OTHER, TRUE) == TRUE then
                return
            end
            if (env(GetMountSpEffectID, 101100) == TRUE or env(GetMountSpEffectID, 101006) == TRUE or
                env(GetMountSpEffectID, 101005) == TRUE) and GetVariable("MoveSpeedLevel") > 0 and
                RideRequestFunction(RIDE_MOVE_TYPE_OTHER, FALSE, TRUE) == TRUE then
                return
            end
        end
    elseif env(GetMountSpEffectID, 98) == TRUE and env(IsTruelyLanding) == TRUE and env(GetMountSpEffectID, 140) ==
        FALSE then
        SetVariable("RideJumpAttack_Land", 1)
        RideJumpCommonFunction(GetVariable("IndexRideJumpType"), TRUE, FALSE, FALSE)
    elseif env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        FireRideEvent("W_RideJump_Loop", "W_RideJump_Loop", FALSE)
        return
    end
end

function RideAttack_Jump_L_Hard2_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
end

function RideAttack_Jump_L_Hard2_onUpdate()
    SetAIActionState()
    act(DisallowAdditiveTurning, TRUE)
    SetVariable("Int16Variable01", 1)

    if GetVariable("RideJumpAttack_Land") == 1 then
        if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
            "W_RideAttack_L_Hard1_Start") == TRUE then
            return
        end
        if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
            if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, TRUE, FALSE) == TRUE then
                return
            end
        else
            if ExecRideStop(RIDE_MOVE_TYPE_OTHER, TRUE) == TRUE then
                return
            end
            if (env(GetMountSpEffectID, 101100) == TRUE or env(GetMountSpEffectID, 101006) == TRUE or
                env(GetMountSpEffectID, 101005) == TRUE) and GetVariable("MoveSpeedLevel") > 0 and
                RideRequestFunction(RIDE_MOVE_TYPE_OTHER, FALSE, TRUE) == TRUE then
                return
            end
        end
    elseif env(GetMountSpEffectID, 98) == TRUE and env(IsTruelyLanding) == TRUE and env(GetMountSpEffectID, 140) ==
        FALSE then
        SetVariable("RideJumpAttack_Land", 1)
        RideJumpCommonFunction(GetVariable("IndexRideJumpType"), TRUE, FALSE, FALSE)
    elseif env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        FireRideEvent("W_RideJump_Loop", "W_RideJump_Loop", FALSE)
        return
    end
end
