
function SetAIActionState()
    act(SetAIAttackState, env(GetNpcAIAttackRequestIDAfterBlend))
end

function Replanning()
    act(DoAIReplanningAtCancelTiming)
end

function SetInterruptType(num)
    act(AINotifyAttackType, num)
end

function SetNpcTurnSpeed(turn_speed)
    if env(IsCOMPlayer) == TRUE and turn_speed >= 0 then
        act(SetTurnSpeed, turn_speed)
    end
end


SetAIActionState = hookup_function(SetAIActionState)
Replanning = hookup_function(Replanning)
SetInterruptType = hookup_function(SetInterruptType)
SetNpcTurnSpeed = hookup_function(SetNpcTurnSpeed)
