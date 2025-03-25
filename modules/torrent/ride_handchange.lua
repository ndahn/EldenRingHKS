
function ExecRideWeaponChange(blend_type)
    local startkind = WEAPON_CHANGE_REQUEST_INVALID
    local endKind = WEAPON_CHANGE_REQUEST_INVALID

    if env(ActionRequest, ACTION_ARM_CHANGE_WEAPON_R) == TRUE then
        startkind = GetWeaponChangeType(HAND_RIGHT)
        endKind = GetWeaponChangeType(HAND_RIGHT)
    elseif env(ActionRequest, ACTION_ARM_CHANGE_WEAPON_L) == TRUE then
        if c_Style == HAND_LEFT_BOTH then
            startkind = GetWeaponChangeType(HAND_LEFT) + 4
            endKind = GetWeaponChangeType(HAND_RIGHT) + 8
        else
            startkind = GetWeaponChangeType(HAND_LEFT)
            endKind = GetWeaponChangeType(HAND_LEFT)
        end
    else
        return FALSE
    end

    if startkind == WEAPON_CHANGE_REQUEST_INVALID then
        return FALSE
    end
    if env(GetGeneralTAEFlag, TAE_FLAG_CHARGING) == 1 or env(GetSpEffectID, 100280) == TRUE then
        ResetRequest()
        return FALSE
    end
    SetVariable("WeaponChangeType", startkind)
    SetVariable("RideWeaponChangeEndType", endKind)
    ExecEventAllBody("W_RideWeaponChangeStart")
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    SetAIActionState()
    return TRUE
end

function ExecRideHandChange(hand, is_force)
    if is_force == FALSE then
        if c_HasActionRequest == FALSE or env(IsPrecisionShoot) == TRUE then
            return FALSE
        end
        if env(IsCOMPlayer) == TRUE then
            if env(ActionRequest, ACTION_ARM_CHANGE_STYLE_R) == TRUE then
            elseif env(ActionRequest, ACTION_ARM_CHANGE_STYLE_L) == TRUE then
                hand = HAND_LEFT
            else
                return FALSE
            end
        elseif env(ActionDuration, ACTION_ARM_ACTION) <= 0 then
            return FALSE
        elseif env(ActionRequest, ACTION_ARM_R1) == TRUE or env(ActionRequest, ACTION_ARM_R2) == TRUE then
            if c_Style == HAND_RIGHT or c_Style == HAND_RIGHT_BOTH then
                hand = HAND_LEFT
            else
                hand = HAND_RIGHT
            end
        elseif env(ActionRequest, ACTION_ARM_L1) == TRUE or env(ActionRequest, ACTION_ARM_L2) == TRUE then
            if c_Style == HAND_RIGHT or c_Style == HAND_RIGHT_BOTH then
                hand = HAND_LEFT
            else
                hand = HAND_RIGHT
            end
        else
            return FALSE
        end
    end

    if env(GetGeneralTAEFlag, TAE_FLAG_CHARGING) == 1 or env(GetSpEffectID, 100280) == TRUE then
        ResetRequest()
        return FALSE
    end

    local style = c_Style
    local kind = GetHandChangeType(HAND_RIGHT)
    local leftKind = GetHandChangeType(HAND_LEFT)
    local sp_kind_L = env(GetEquipWeaponSpecialCategoryNumber, HAND_LEFT)
    local sp_kind_R = env(GetEquipWeaponSpecialCategoryNumber, HAND_RIGHT)

    if style == HAND_RIGHT or style == HAND_RIGHT_BOTH then
        if hand == HAND_RIGHT then
            return FALSE
        else
            if env(IsTwoHandPossible, HAND_LEFT) == FALSE then
                return FALSE
            end
            local firstKind = RIDE_RIGHT_TO_WAIST
            local endKind = RIDE_BOTHLEFT_FROM_WAIST
            if kind == WEAPON_CHANGE_REQUEST_RIGHT_WAIST then
                firstKind = RIDE_RIGHT_TO_WAIST
            elseif kind == WEAPON_CHANGE_REQUEST_RIGHT_BACK then
                firstKind = RIDE_RIGHT_TO_BACK
            elseif kind == WEAPON_CHANGE_REQUEST_RIGHT_SHOULDER then
                firstKind = RIDE_RIGHT_TO_SHOULDER
            else
                firstKind = RIDE_RIGHT_TO_SPEAR
            end

            if leftKind == WEAPON_CHANGE_REQUEST_LEFT_WAIST then
                endKind = RIDE_BOTHLEFT_FROM_WAIST
            elseif leftKind == WEAPON_CHANGE_REQUEST_LEFT_BACK then
                endKind = RIDE_BOTHLEFT_FROM_BACK
            elseif leftKind == WEAPON_CHANGE_REQUEST_LEFT_SHOULDER then
                endKind = RIDE_BOTHLEFT_FROM_SHOULDER
            else
                endKind = RIDE_BOTHLEFT_FROM_SPEAR
            end

            act(DebugLogOutput, "RideHandChange ToBothLeft start=" .. firstKind .. " end" .. endKind)
            SetHandChangeStyle(firstKind, endKind)
            act(Unknown9999, 2)
        end
    elseif style == HAND_LEFT_BOTH then
        local firstKind = RIDE_LEFT_TO_WAIST
        local endKind = RIDE_RIGHT_FROM_LEFTWAIST_FROM_MIDDLE
        if leftKind == WEAPON_CHANGE_REQUEST_LEFT_WAIST then
            firstKind = RIDE_LEFT_TO_WAIST
        elseif leftKind == WEAPON_CHANGE_REQUEST_LEFT_BACK then
            firstKind = RIDE_LEFT_TO_BACK
        elseif leftKind == WEAPON_CHANGE_REQUEST_LEFT_SHOULDER then
            firstKind = RIDE_LEFT_TO_SHOULDER
        else
            firstKind = RIDE_LEFT_TO_SPEAR
        end

        if kind == WEAPON_CHANGE_REQUEST_RIGHT_WAIST then
            endKind = RIDE_RIGHT_FROM_LEFTWAIST_FROM_MIDDLE
        elseif kind == WEAPON_CHANGE_REQUEST_RIGHT_BACK then
            endKind = RIDE_RIGHT_FROM_RIGHTBACK_FROM_MIDDLE
        elseif kind == WEAPON_CHANGE_REQUEST_RIGHT_SHOULDER then
            endKind = RIDE_RIGHT_FROM_RIGHTSHOULDER_FROM_MIDDLE
        else
            endKind = RIDE_RIGHT_FROM_RIGHTSPEAR_FROM_MIDDLE
        end

        SetHandChangeStyle(firstKind, endKind)
        act(Unknown9999, 1)
    end

    ExecEventAllBody("W_RideHandChangeStart")
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    SetAIActionState()

    return TRUE
end

--------------
-- Triggers --
--------------

function RideWeaponChangeStart_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    act(ResetInputQueue)
end

function RideWeaponChangeStart_onUpdate()
    SetAIActionState()
    act(DisallowAdditiveTurning, TRUE)

    if RideReActionFunction() == TRUE then
        return
    end
    if env(IsAnimEnd, 0) == TRUE then
        ExecEventAllBody("W_RideWeaponChangeEnd")
    end

    local lower_only = TRUE

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, FALSE, lower_only) == TRUE then
        return
    end
end

function RideWeaponChangeStart_onDeactivate()
    act(DisallowAdditiveTurning, FALSE)
end

function RideWeaponChangeEnd_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    act(ResetInputQueue)
end

function RideWeaponChangeEnd_onUpdate()
    SetAIActionState()
    act(DisallowAdditiveTurning, TRUE)

    if RideReActionFunction() == TRUE then
        return
    end
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
    if env(IsMoveCancelPossible) == TRUE then
        ExecEventNoReset("W_RideIdle")
    end
end

function RideWeaponChangeEnd_onDeactivate()
    act(DisallowAdditiveTurning, FALSE)
end

function RideHandChangeStart_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    act(ResetInputQueue)
end

function RideHandChangeStart_onUpdate()
    SetAIActionState()
    act(DisallowAdditiveTurning, TRUE)

    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local lower_only = TRUE

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, FALSE, lower_only) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        ExecEventAllBody("W_RideHandChangeEnd")
        return
    end
end

function RideHandChangeStart_onDeactivate()
    act(DisallowAdditiveTurning, FALSE)
end

function RideHandChangeEnd_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    act(ResetInputQueue)
end

function RideHandChangeEnd_onUpdate()
    SetAIActionState()
    act(DisallowAdditiveTurning, TRUE)
    if RideReActionFunction() == TRUE then
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
    if env(IsMoveCancelPossible) == TRUE then
        ExecEventNoReset("W_RideIdle")
    end
end

function RideHandChangeEnd_onDeactivate()
    act(DisallowAdditiveTurning, FALSE)
end
