
function RideJumpCommonFunction(jump_type, lower_only, isSecond, isHighJump)
    act(DisallowAdditiveTurning, TRUE)
    SetVariable("Int16Variable01", 1)
    local damage_type = env(GetReceivedDamageType)

    if damage_type == DAMAGE_TYPE_DEATH_FALLING and isHighJump == FALSE and env(GetSpEffectID, 185) == FALSE then
        FireRideEvent("W_RideDeath", "W_RideDeath", FALSE)
        return TRUE
    end

    local height = env(GetMountFallHeight) / 100

    if env(IsMountTrulyLanding) == TRUE and IsLandDead(height) == TRUE and isHighJump == FALSE and
        env(GetSpEffectID, 185) == FALSE then
        act(DebugLogOutput, height)
        FireRideEvent("W_RideDeath", "W_RideDeath", FALSE)
        return
    end
    if RideReActionFunction() == TRUE then
        return TRUE
    end
    if env(ActionRequest, 6) == TRUE and env(GetSpEffectID, 100902) == TRUE and RIDE_ISENABLE_DOUBLEJUMP == TRUE then
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

            RIDE_ISENABLE_DOUBLEJUMP = FALSE
            return TRUE
        end
    end

    if env(IsMountTrulyLanding) == TRUE and env(GetMountSpEffectID, 98) == TRUE and env(GetMountSpEffectID, 140) ==
        FALSE then
        if GetVariable("MoveSpeedLevel") > 1.5 then
            FireRideEvent("W_RideJump_Land_To_Gallop", "W_RideJump_Land_To_Gallop", lower_only)
            return TRUE
        elseif GetVariable("MoveSpeedLevel") > 0.6000000238418579 then
            FireRideEvent("W_RideJump_Land_To_Dash", "W_RideJump_Land_To_Dash", lower_only)
            return TRUE
        end

        local landEvent = "W_RideJump_Land_N"

        if jump_type == 3 then
            landEvent = "W_RideJump_Land_D"
        elseif jump_type == 2 then
            landEvent = "W_RideJump_Land_F"
        end

        act(DebugLogOutput, landEvent)
        FireRideEvent(landEvent, landEvent, lower_only)
        return TRUE
    end

    local enable_jumpAttack = TRUE
    local attackHand = HAND_RIGHT

    if c_Style == HAND_LEFT_BOTH then
        attackHand = HAND_LEFT
    end

    if GetEquipType(attackHand, WEAPON_CATEGORY_ARROW, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_CROSSBOW) == TRUE then
        enable_jumpAttack = FALSE
    end

    local is_staff = GetEquipType(attackHand, WEAPON_CATEGORY_STAFF)

    if enable_jumpAttack == TRUE then
        if env(ActionRequest, ACTION_ARM_R1) == TRUE and is_staff == FALSE or env(ActionRequest, ACTION_ARM_R2) == TRUE and
            is_staff == TRUE then
            SetVariable("RideJumpAttack_Land", 0)
            SetVariable("IndexRideJumpType", jump_type)
            ExecEventAllBody("W_RideAttack_Jump_R")
            RideJumpLoop_IsSecond = isSecond
            return TRUE
        elseif env(ActionRequest, ACTION_ARM_L1) == TRUE and is_staff == FALSE or env(ActionRequest, ACTION_ARM_L2) ==
            TRUE and is_staff == TRUE then
            SetVariable("RideJumpAttack_Land", 0)
            SetVariable("IndexRideJumpType", jump_type)
            ExecEventAllBody("W_RideAttack_Jump_L")
            RideJumpLoop_IsSecond = isSecond
            return TRUE
        end
    end

    if env(IsAnimEnd, 0) == TRUE and lower_only == FALSE then
        SetVariable("IndexRideJumpType", jump_type)
        if isHighJump == TRUE then
            ExecEventNoReset("W_RideJumpHigh_FallLoop")
        elseif isSecond == TRUE then
            ExecEventNoReset("W_RideJump2_Loop")
        else
            ExecEventNoReset("W_RideJump_Loop")
        end
        return TRUE
    end
    return FALSE
end

--------------
-- Triggers --
--------------

function RideJump_N_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
end

function RideJump_N_onUpdate()
    if RideJumpCommonFunction(0, FALSE, FALSE, FALSE) == TRUE then
        return
    end
end

function RideJump_F_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
end

function RideJump_F_onUpdate()
    if RideJumpCommonFunction(2, FALSE, FALSE, FALSE) == TRUE then
        return
    end
end

function RideJump_D_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
end

function RideJump_D_onUpdate()
    if RideJumpCommonFunction(3, FALSE, FALSE, FALSE) == TRUE then
        return
    end
end

function RideJump_Loop_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
end

function RideJump_Loop_onUpdate()
    if env(GetSpEffectID, 19935) == TRUE then
        if env(IsHamariFallDeath, 20) == TRUE and env(GetSpEffectID, 185) == FALSE then
            FireRideEvent("W_RideDeath", "W_RideDeath", FALSE)
            return
        end
    elseif env(IsHamariFallDeath, 12) == TRUE and env(GetSpEffectID, 185) == FALSE then
        FireRideEvent("W_RideDeath", "W_RideDeath", FALSE)
        return
    end
    if env(GetSpiritspringJumpHeight) > 0 or env(GetSpEffectID, 183) == TRUE then
        act(AddSpEffect, 186)
    end
    if RideJumpCommonFunction(GetVariable("IndexRideJumpType"), FALSE, FALSE, FALSE) == TRUE then
        return
    end
end

function RideJump2_N_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
end

function RideJump2_N_onUpdate()
    if RideJumpCommonFunction(0, FALSE, TRUE, FALSE) == TRUE then
        return
    end
end

function RideJump2_F_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
end

function RideJump2_F_onUpdate()
    if RideJumpCommonFunction(2, FALSE, TRUE, FALSE) == TRUE then
        return
    end
end

function RideJump2_D_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
end

function RideJump2_D_onUpdate()
    if RideJumpCommonFunction(3, FALSE, TRUE) == TRUE then
        return
    end
end

function RideJump2_Loop_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
end

function RideJump2_Loop_onUpdate()
    if env(GetSpEffectID, 19935) == TRUE then
        if env(IsHamariFallDeath, 20) == TRUE then
            FireRideEvent("W_RideDeath", "W_RideDeath", FALSE)
            return
        end
    elseif env(IsHamariFallDeath, 12) == TRUE then
        FireRideEvent("W_RideDeath", "W_RideDeath", FALSE)
        return
    end
    if env(GetSpiritspringJumpHeight) > 0 or env(GetSpEffectID, 183) == TRUE then
        act(AddSpEffect, 186)
    end
    if RideJumpCommonFunction(GetVariable("IndexRideJumpType"), FALSE, TRUE, FALSE) == TRUE then
        return
    end
end

function RideJump_Land_N_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
end

function RideJump_Land_N_onUpdate()
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end
    if env(IsMoveCancelPossible) == TRUE then
        local moveType = RIDE_MOVE_TYPE_IDLE
        if env(IsAnimEnd, 0) == TRUE then
            moveType = RIDE_MOVE_TYPE_OTHER
        end
        if RideRequestFunction(moveType, TRUE, FALSE) == TRUE then
            return
        end
    end
    if env(IsAnimEnd, 0) == TRUE then
        FireRideEvent("W_RideIdle", "W_RideIdle", FALSE)
    end
end

function RideJump_Land_F_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
end

function RideJump_Land_F_onUpdate()
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

function RideJump_Land_D_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
end

function RideJump_Land_D_onUpdate()
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

function RideJump_Land_To_Dash_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
end

function RideJump_Land_To_Dash_onUpdate()
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

function RideJump_Land_To_Gallop_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
end

function RideJump_Land_To_Gallop_onUpdate()
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

function RideJumpHigh_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
end

function RideJumpHigh_onUpdate()
    act(AddSpEffect, 185)
    if env(ActionRequest, 6) == TRUE then
        FireRideEvent("W_RideJumpHigh2", "W_RideJumpHigh2", FALSE)
        RIDE_ISENABLE_DOUBLEJUMP = FALSE
        return
    end
    if env(IsAnimEnd, 0) == TRUE or env(GetEventEzStateFlag, 0) == TRUE then
        rideJumpHighLoop_StopTime = 0
        lastFallHeight = 0
        rideJumpHighLoop_IsStop = FALSE
        FireRideEvent("W_RideJumpHighLoop", "W_RideJumpHighLoop", FALSE)
        return
    end
    if RideJumpCommonFunction(0, FALSE, FALSE, TRUE) == TRUE then
        return
    end
end

function RideJumpHighLoop_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
end

function RideJumpHighLoop_onUpdate()
    act(AddSpEffect, 185)
    local fallHeight = env(GetMountFallHeight)
    local dT = env(ObtainedDT) / 1000
    local upSpeed = (fallHeight - lastFallHeight) / dT
    if upSpeed < 50 then
        rideJumpHighLoop_IsStop = TRUE
        rideJumpHighLoop_StopTime = rideJumpHighLoop_StopTime + dT
        act(DebugLogOutput,
            "RideJumpHigh current=" .. fallHeight .. "cm target=" .. Ride_HighJump_Height .. "cm upSpeed=" .. upSpeed ..
                "cm stopTime=" .. rideJumpHighLoop_StopTime)
        if rideJumpHighLoop_StopTime > 5 then
            act(DebugLogOutput, "RideJumpHigh Force end")
            FireRideEvent("W_RideJumpHighEnd", "W_RideJumpHighEnd", FALSE)
            return
        end
    else
        rideJumpHighLoop_IsStop = FALSE
        rideJumpHighLoop_StopTime = 0
        act(DebugLogOutput,
            "RideJumpHigh current=" .. fallHeight .. "cm target=" .. Ride_HighJump_Height .. "cm upSpeed=" .. upSpeed)
    end
    if -fallHeight > Ride_HighJump_Height then
        FireRideEvent("W_RideJumpHighEnd", "W_RideJumpHighEnd", FALSE)
        return
    end
    lastFallHeight = fallHeight
    if RideJumpCommonFunction(0, FALSE, FALSE, TRUE) == TRUE then
        return
    end
end

function RideJumpHighEnd_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
end

function RideJumpHighEnd_onUpdate()
    act(AddSpEffect, 185)
    if env(ActionRequest, 6) == TRUE then
        FireRideEvent("W_RideJumpHigh2", "W_RideJumpHigh2", FALSE)
        RIDE_ISENABLE_DOUBLEJUMP = FALSE
        return
    end
    if RideJumpCommonFunction(0, FALSE, FALSE, TRUE) == TRUE then
        return
    end
end

function RideJumpHigh2_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
end

function RideJumpHigh2_onUpdate()
    act(AddSpEffect, 185)
    if RideJumpCommonFunction(0, FALSE, FALSE, TRUE) == TRUE then
        return
    end
end

function RideJumpHigh_FallLoop_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
end

function RideJumpHigh_FallLoop_onUpdate()
    act(AddSpEffect, 185)
    if RideJumpCommonFunction(GetVariable("IndexRideJumpType"), FALSE, FALSE, TRUE) == TRUE then
        return
    end
end

function RideJump_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
end

function RideJump_onUpdate()
    SetAIActionState()
    if GetVariable("IsEnableToggleDashTest") == 2 or GetVariable("IsEnableToggleDashTest") == 4 then
        SetVariable("ToggleDash", 0)
    end
    act(DisallowAdditiveTurning, TRUE)
    SetVariable("Int16Variable01", 1)
    if RideReActionFunction() == TRUE then
        SetVariable("Int16Variable05", 0)
        return
    end
    if env(IsMountInFallLoop) == FALSE then
        if env(ActionRequest, ACTION_ARM_R1) == TRUE and env(GetMountSpEffectID, 98) == TRUE then
            act(ResetInputQueue)
            SetVariable("RideJumpAttack_Land", 0)
            ExecEventAllBody("W_RideAttack_Jump_R")
            return
        elseif env(ActionRequest, ACTION_ARM_R2) == TRUE and 0 < env(ActionDuration, 1) and env(GetMountSpEffectID, 98) ==
            FALSE then
            act(ResetInputQueue)
            SetVariable("Int16Variable05", 0)
            hkbFireEvent("W_RideAttack_R_Hard1_Start")
            return
        elseif env(ActionRequest, ACTION_ARM_L1) == TRUE and env(GetMountSpEffectID, 98) == TRUE then
            act(ResetInputQueue)
            SetVariable("RideJumpAttack_Land", 0)
            ExecEventAllBody("W_RideAttack_Jump_L")
            return
        elseif env(ActionRequest, ACTION_ARM_L2) == TRUE and 0 < env(ActionDuration, 3) then
            act(ResetInputQueue)
            SetVariable("Int16Variable05", 0)
            hkbFireEvent("W_RideAttack_L_Hard1_Start")
            return
        end
    elseif RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end
    if env(MovementRequest) == TRUE and GetVariable("MoveSpeedLevel") > 0 and env(IsMountFalling) == FALSE and
        RideRequestFunction(RIDE_MOVE_TYPE_OTHER, TRUE, FALSE) == TRUE then
        SetVariable("Int16Variable05", 0)
        return
    end
    if env(IsAnimEnd, 0) == TRUE then
        FireRideEvent("W_RideIdle", "W_RideIdle", FALSE)
        SetVariable("Int16Variable05", 0)
        return
    end
end

function Jump_RideOff_onActivate()
    act(AIJumpState)
    SetAIActionState()
end

function Jump_RideOff_onUpdate()
    SetAIActionState()
    JUMP_STATE_1 = 0
    JUMP_STATE_2 = 0
    JUMP_STATE_3 = 1

    if GetVariable("JumpAttackForm") == 0 then
        act(LockonFixedAngleCancel)
    end

    if JumpCommonFunction(2) == TRUE then
        act(Dismount)
        return
    end
end

function Jump_RideOff_onDeactivate()
    act(Dismount)
    act(DisallowAdditiveTurning, FALSE)
end

function Jump_Loop_onActivate()
    SetAIActionState()
end
