
function ExecGesture()
    if c_HasActionRequest == FALSE then
        return FALSE
    end
    if env(ActionRequest, ACTION_ARM_GESTURE) == FALSE then
        return FALSE
    end

    local request = env(GetGestureRequestNumber)

    if request == 109 then
        request = 108
    elseif request == 113 or request == 116 then
        request = 110
    end

    local animID = 80000 + request * 10

    SetVariable("GestureID", request)

    if request == INVALID then
        return FALSE
    end

    local isloop = FALSE

    if env(DoesAnimExist, animID + 1) == TRUE then
        isloop = TRUE
    end

    if isloop == TRUE then
        if GetLocomotionState() == PLAYER_STATE_MOVE then
            ExecEventHalfBlend(Event_GestureLoopStart, UPPER)
            return TRUE
        else
            ExecEventHalfBlend(Event_GestureLoopStart, ALLBODY)
            return TRUE
        end
    elseif GetLocomotionState() == PLAYER_STATE_MOVE then
        ExecEventHalfBlend(Event_GestureStart, UPPER)
        return TRUE
    else
        ExecEventHalfBlend(Event_GestureStart, ALLBODY)
        return TRUE
    end
end

----------------------
-- Common functions --
----------------------

function GestureCommonFunction(blend_type)
    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
        return TRUE
    end
    if blend_type ~= UPPER and ExecQuickTurn(LOWER, TURN_TYPE_DEFAULT) == TRUE then
        return TRUE
    end
    if ExecJump() == TRUE then
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, ALLBODY) == TRUE then
        return TRUE
    end
    if ExecWeaponChange(ALLBODY) == TRUE then
        return TRUE
    end
    if ExecEvasion(FALSE, ESTEP_NONE, FALSE) == TRUE then
        return TRUE
    end
    if ExecItem(QUICKTYPE_NORMAL, ALLBODY) == TRUE then
        return TRUE
    end
    if ExecMagic(QUICKTYPE_NORMAL, ALLBODY, FALSE) == TRUE then
        return TRUE
    end
    if ExecArtsStanceOnCancelTiming(ALLBODY) == TRUE then
        return TRUE
    end
    if ExecAttack("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, ALLBODY, FALSE, FALSE, FALSE) == TRUE then
        return TRUE
    end
    if ExecGesture() == TRUE then
        return TRUE
    end
    return FALSE
end

function GestureLoopCommonFunction(blend_type, lower_state, is_start)
    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
        return TRUE
    end
    if blend_type ~= UPPER and ExecQuickTurn(LOWER, TURN_TYPE_DEFAULT) == TRUE then
        return TRUE
    end
    if ExecEvasion(FALSE, ESTEP_NONE, FALSE) == TRUE then
        return TRUE
    end

    local canmove = FALSE

    if env(GetEventEzStateFlag, 0) == TRUE then
        if env(HasActionRequest) == TRUE then
            ExecEventHalfBlend(Event_GestureEnd, lower_state)
            return TRUE
        end

        if canmove == FALSE and 0 < GetVariable("MoveSpeedLevel") then
            ExecEventHalfBlend(Event_GestureEnd, lower_state)
            return TRUE
        end
    end
    return FALSE
end

--------------
-- Triggers --
--------------

function GestureStart_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if GestureCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_GestureStart, lower_state, FALSE) == TRUE then
        return
    end
end

function GestureLoopStart_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if GestureLoopCommonFunction(blend_type, lower_state, TRUE) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        ExecEventHalfBlend(Event_GestureLoop, blend_type)
        return
    end
    if HalfBlendLowerCommonFunction(Event_GestureLoopStart, lower_state, FALSE) == TRUE then
        return
    end
end

function GestureLoop_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if GestureLoopCommonFunction(blend_type, lower_state, FALSE) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_GestureLoop, lower_state, FALSE) == TRUE then
        return
    end
end

function GestureEnd_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if GestureCommonFunction() == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_GestureEnd, lower_state, FALSE) == TRUE then
        return
    end
end


ExecGesture = hookup_function(ExecGesture)
GestureCommonFunction = hookup_function(GestureCommonFunction)
GestureLoopCommonFunction = hookup_function(GestureLoopCommonFunction)
GestureStart_Upper_onUpdate = hookup_function(GestureStart_Upper_onUpdate)
GestureLoopStart_Upper_onUpdate = hookup_function(GestureLoopStart_Upper_onUpdate)
GestureLoop_Upper_onUpdate = hookup_function(GestureLoop_Upper_onUpdate)
GestureEnd_Upper_onUpdate = hookup_function(GestureEnd_Upper_onUpdate)