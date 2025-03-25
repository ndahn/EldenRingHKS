
function ExecRideGesture()
    if c_HasActionRequest == FALSE then
        return FALSE
    end
    if env(ActionRequest, ACTION_ARM_GESTURE) == FALSE then
        return FALSE
    else
        ResetRequest()
        return FALSE
    end

    local request = env(GetGestureRequestNumber)

    if request == INVALID then
        return FALSE
    end

    local isloop = FALSE
    local upper_only = TRUE

    if request == 9 then
    elseif request == 1 then
        upper_only = FALSE
    end

    if isloop == TRUE then
        SetVariable("IndexGesture", request)
        ExecEventAllBody("W_RideGesture")
        return TRUE
    elseif upper_only == FALSE then
        SetVariable("IndexGesture", request)
        act(ApplyRideBlend, "IndexGesture", request)
        FireRideEvent("W_RideGesture", "W_RideGesture")
    else
        SetVariable("IndexGesture", request)
        ExecEventAllBody("W_RideGestureUpper")
        return TRUE
    end
    return FALSE
end

--------------
-- Triggers --
--------------

function RideGesture_onUpdate()
    SetAIActionState()
    act(DisallowAdditiveTurning, TRUE)

    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
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

function RideGestureUpper_onUpdate()
    SetAIActionState()

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
