
function GetHalfBlendInfo()
    local blend_type = ALLBODY
    local lower_state = LOWER_IDLE
    if GetLocomotionState() == PLAYER_STATE_MOVE then
        blend_type = UPPER
        lower_state = LOWER_MOVE
    elseif IsLowerQuickTurn() == TRUE then
        if ExitQuickTurnLower() == TRUE then
            lower_state = LOWER_END_TURN
        else
            blend_type = UPPER
            lower_state = LOWER_TURN
        end
    end
    return blend_type, lower_state
end

function ExecEventHalfBlend(event_table, blend_type)
    if blend_type == ALLBODY then
        SetVariable("MoveSpeedLevelReal", 0)
        local lower_event = event_table[1]
        local upper_event = lower_event .. "_Upper"

        ExecEvents(lower_event, upper_event)

        for i = 2, #event_table, 1 do
            SetVariable("LowerDefaultState0" .. i - 2, event_table[i])
            SetVariable("UpperDefaultState0" .. i - 2, event_table[i])
        end
    elseif blend_type == LOWER then
        ExecEvent(event_table[1])

        for i = 2, #event_table, 1 do
            SetVariable("LowerDefaultState0" .. i - 2, event_table[i])
        end
    elseif blend_type == UPPER then
        ExecEvent(event_table[1] .. "_Upper")

        for i = 2, #event_table, 1 do
            SetVariable("UpperDefaultState0" .. i - 2, event_table[i])
        end
    end
end

function ExecEventHalfBlendNoReset(event_table, blend_type)
    if blend_type == ALLBODY then
        local lower_event = event_table[1]
        local upper_event = lower_event .. "_Upper"

        ExecEventNoReset(lower_event)
        ExecEventNoReset(upper_event)

        for i = 2, #event_table, 1 do
            SetVariable("LowerDefaultState0" .. i - 2, event_table[i])
            SetVariable("UpperDefaultState0" .. i - 2, event_table[i])
        end
    elseif blend_type == LOWER then
        ExecEventNoReset(event_table[1])

        for i = 2, #event_table, 1 do
            SetVariable("LowerDefaultState0" .. i - 2, event_table[i])
        end
    elseif blend_type == UPPER then
        ExecEventNoReset(event_table[1] .. "_Upper")

        for i = 2, #event_table, 1 do
            SetVariable("UpperDefaultState0" .. i - 2, event_table[i])
        end
    end
end

function ExecEventAllBody(event)
    SetVariable("MoveSpeedLevelReal", 0)
    ExecEvent(event)
end

----------------------
-- Common functions --
----------------------

function HalfBlendLowerCommonFunction(event, lower_state, to_idle_on_cancel, disable_stealth_move)
    if disable_stealth_move == nil then
        disable_stealth_move = FALSE
    end

    if lower_state == LOWER_MOVE then
        if ExecStopHalfBlend(event, to_idle_on_cancel) == TRUE then
            return TRUE
        end
    else
        local blend_type = LOWER

        if env(IsMoveCancelPossible) == TRUE then
            blend_type = ALLBODY
        end

        local move_event = Event_Move

        if c_IsStealth == TRUE and disable_stealth_move == FALSE then
            move_event = Event_Stealth_Move
        end

        if MoveStart(blend_type, move_event, FALSE) == TRUE then
            return TRUE
        end
        if lower_state == LOWER_END_TURN then
            ExecEventHalfBlendNoReset(event, LOWER)
            return TRUE
        end
    end
    return FALSE
end

function HalfBlendLowerCommonFunctionNoSync(event, lower_state, to_idle_on_cancel, is_fire_upper_on_move)
    if lower_state == LOWER_MOVE then
        if ExecStopHalfBlend(event, to_idle_on_cancel) == TRUE then
            return TRUE
        end
    else
        local blend_type = LOWER

        if env(IsMoveCancelPossible) == TRUE then
            blend_type = ALLBODY
        end

        if MoveStart(blend_type, Event_MoveNoSync, FALSE) == TRUE then
            if is_fire_upper_on_move == TRUE and blend_type == LOWER then
                ExecEventHalfBlend(event, UPPER)
            end
            return TRUE
        end
        if lower_state == LOWER_END_TURN then
            ExecEventHalfBlendNoReset(event, LOWER)
            return TRUE
        end
    end
    return FALSE
end

function HalfBlendUpperCommonFunction(lower_state)
    local exit_flag = FALSE

    if env(IsAnimEnd, 1) == TRUE then
        exit_flag = TRUE
    end

    if lower_state ~= LOWER_IDLE and env(GetEventEzStateFlag, 0) == TRUE then
        exit_flag = TRUE
    end

    if exit_flag == FALSE then
        return FALSE
    end
    if lower_state == LOWER_TURN then
        local turn_state = GetVariable("UpperDefaultState01")
        local event = Event_QuickTurnRight180Mirror

        if turn_state == QUICKTURN_LEFT180_DEF1 then
            event = Event_QuickTurnLeft180Mirror
        end

        ExecEventHalfBlendNoReset(event)
    elseif lower_state == LOWER_MOVE then
        if c_IsStealth == TRUE then
            ExecEventHalfBlendNoReset(Event_Stealth_Move, UPPER)
        else
            ExecEventHalfBlendNoReset(Event_Move, UPPER)
        end
    elseif c_IsStealth == TRUE then
        ExecEventNoReset("W_Stealth_Idle")
    else
        ExecEventNoReset("W_Idle")
    end
    return TRUE
end

--------------
-- Triggers --
--------------

function Event_onActivate()
    ResetEventState()
    SetVariable("TestIsEventBlend", 1)
    if GetVariable("TestIsEventBlend") then
        local testmoveangle = env(GetObjActTargetDirection)
        SetVariable("TestMoveAngle", testmoveangle)
        TestBlendrate = 0
    end
    blendtimemax = env(GetObjActRemainingInterpolateTime)
end

function Event_onUpdate()
    if GetVariable("TestIsEventBlend") then
        blendtime = env(GetObjActRemainingInterpolateTime)
        if blendtime > 0 then
            if blendtime > EVENT_BLEND_RATE * 2 then
                SetVariable("TestEventBlend_Move", 1)
                SetVariable("TestEventBlend_Event", 0)
            else
                local blendstoptime = blendtimemax / 2
                if blendstoptime < 300 then
                    blendstoptime = 300
                elseif blendstoptime > 750 then
                    blendstoptime = 750
                end
                local blendmove = (blendtime - 300) / EVENT_BLEND_RATE
                local blendevent = 1 - (blendtime - 300) / EVENT_BLEND_RATE
                if blendmove < 0 then
                    blendmove = 0
                end
                if blendevent > 1 then
                    blendevent = 1
                end
                SetVariable("TestEventBlend_Move", blendmove)
                SetVariable("TestEventBlend_Event", blendevent)
            end
        end
    end
end

function AddBlendSpeak_onUpdate()
    if env(IsAnimEnd, 2) == TRUE then
        SetVariable("AddBlendSpeakIndex", math.random(0, 2))
        act(DebugLogOutput, "AddBlendSpeak_end")
        ExecEventAllBody("W_AddBlendSpeak")
    end
end
