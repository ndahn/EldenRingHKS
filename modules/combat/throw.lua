
function SetThrowDefBlendWeight()
    if env(DoesAnimExist, GetVariable("ThrowID") + 4) == FALSE then
        return
    end
    local regist_num = env(GetThrowDefenseCount)
    local dT = GetDeltaTime()
    local blend_weight = GetVariable("ThrowHoldBlendWeight")
    local is_holding = GetVariable("ThrowHolding")
    local no_regist_time = GetVariable("ThrowNoRegistTime")
    if regist_num > 0 then
        is_holding = true
    end
    if is_holding == true then
        if regist_num <= 0 then
            no_regist_time = no_regist_time + dT
        end
        if no_regist_time > 0.699999988079071 then
            is_holding = false
        else
            blend_weight = blend_weight + 2 * dT
            if blend_weight > 0.9900000095367432 then
                blend_weight = 0.9900000095367432
            end
            SetVariable("IsEnableTAEThrowHold", true)
        end
    else
        no_regist_time = 0
        blend_weight = blend_weight - 4 * dT
        if blend_weight < 0.009999999776482582 then
            blend_weight = 0.009999999776482582
            SetVariable("IsEnableTAEThrowHold", false)
        else
            SetVariable("IsEnableTAEThrowHold", true)
        end
    end
    SetVariable("ThrowHoldBlendWeight", blend_weight)
    SetVariable("ThrowHolding", is_holding)
    SetVariable("ThrowNoRegistTime", no_regist_time)
end

function SetThrowAtkInvalid()
    act(SetAllowedThrowAttackType, THROW_STATE_INVALID)
end

function SetThrowDefInvalid()
    act(SetAllowedThrowDefenseType, THROW_STATE_INVALID)
end

function SetThrowInvalid()
    act(SetAllowedThrowAttackType, THROW_STATE_INVALID)
    act(SetAllowedThrowDefenseType, THROW_STATE_INVALID)
end

----------------------
-- Common functions --
----------------------

function ThrowCommonFunction(estep)
    if env(IsThrowing) == FALSE then
        if ExecDeath() == TRUE then
            return TRUE
        end
        if env(CheckForEventAnimPlaybackRequest) == TRUE then
            return TRUE
        end
        if ExecDamage(FALSE) == TRUE then
            return TRUE
        end
    end

    if ExecFallStart(FALL_TYPE_DEFAULT) == TRUE then
        return TRUE
    end
    if ExecQuickTurnOnCancelTiming() == TRUE then
        return TRUE
    end
    if ExecJump() == TRUE then
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, ALLBODY) == TRUE then
        return TRUE
    end
    if ExecGuardOnCancelTiming(FALSE, ALLBODY) == TRUE then
        return TRUE
    end
    if ExecWeaponChange(ALLBODY) == TRUE then
        return TRUE
    end
    if ExecEvasion(FALSE, estep, FALSE) == TRUE then
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
    if MoveStartonCancelTiming(Event_MoveQuick, FALSE) == TRUE then
        return TRUE
    end
    return FALSE
end

function BackStabCommonFunction()
    SetAIActionState()

    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
        return TRUE
    end
    if ExecWeaponChange(ALLBODY) == TRUE then
        return TRUE
    end
    if ExecEvasion(FALSE, ESTEP_NONE, FALSE) == TRUE then
        return TRUE
    end
    if ExecItem(QUICKTYPE_ATTACK, ALLBODY) == TRUE then
        return TRUE
    end
    if ExecMagic(QUICKTYPE_ATTACK, ALLBODY, FALSE) == TRUE then
        return TRUE
    end
    if ExecAttack("W_AttackRightLight2", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight2", "W_AttackBothHeavy1Start", FALSE, ALLBODY, FALSE, FALSE, FALSE) == TRUE then
        return TRUE
    end
    if ExecQuickTurnOnCancelTiming() == TRUE then
        return TRUE
    end
    if ExecJump() == TRUE then
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, ALLBODY) == TRUE then
        return TRUE
    end
    if ExecGuardOnCancelTiming(FALSE, ALLBODY) == TRUE then
        return TRUE
    end
    if ExecArtsStanceOnCancelTiming(ALLBODY) == TRUE then
        return TRUE
    end
    if MoveStartonCancelTiming(Event_Move, FALSE) == TRUE then
        return TRUE
    end
    if ExecGesture() == TRUE then
        return TRUE
    end
    return FALSE
end

--------------
-- Triggers --
--------------

function ThrowBackStab_Activate()
    act(InvokeBackstab)
    local hand = HAND_RIGHT
    if c_Style == HAND_LEFT_BOTH then
        hand = HAND_LEFT
    end
    SetAttackHand(hand)
    SetGuardHand(hand)
end

function ThrowBackStab_onActivate()
    SetVariable("ThrowHandIndex", 0)
end

function ThrowBackStab_onUpdate()
    if env(HasThrowRequest) == FALSE then
        if BackStabCommonFunction() == TRUE then
            return
        end
    else
        ResetRequest()
        return
    end
end

function Throw_Activate()
    ResetRequest()
    SetVariable("MoveSpeedLevelReal", 0)
    SetThrowInvalid()
    local id = env(GetThrowAnimID)
    if id >= 0 then
        SetVariable("ThrowID", id)
    end
    if c_Style == HAND_LEFT_BOTH then
        SetAttackHand(HAND_LEFT)
        SetGuardHand(HAND_LEFT)
    else
        SetAttackHand(HAND_RIGHT)
        SetGuardHand(HAND_RIGHT)
    end
    SetVariable("ThrowHandIndex", 0)
    SetVariable("ThrowHoldBlendWeight", 0)
    SetVariable("ThrowHolding", false)
    SetVariable("ThrowNoRegistTime", 0)
end

function Throw_Update()
    SetThrowInvalid()
end

function Throw_Deactivate()
    act(RequestThrowAnimInterrupt)
end

function ThrowAtk_onActivate()
    Replanning()
end

function ThrowAtk_onUpdate()
    if ThrowCommonFunction(FALSE) == TRUE then
        act(RequestThrowAnimInterrupt)
        return
    end
end

function ThrowDef_onActivate()
    Replanning()
end

function ThrowDef_onUpdate()
    if env(GetSpEffectID, 19682) == TRUE and env(GetSpEffectID, 19681) == TRUE then
        act(AddSpEffect, 19680)
    end
    if env(GetEventEzStateFlag, 0) == TRUE and env(GetSpEffectID, 19680) == TRUE then
        SetVariable("IndexDeath", DEATH_TYPE_CHARM)
        ExecEvent("W_DeathStart")
        return
    end
    SetThrowDefBlendWeight()
    if env(IsThrowSelfDeath) == TRUE then
        ExecEvent("ThrowDeath")
        return
    end
    if env(IsThrowSuccess) == TRUE then
        ExecEvent("W_ThrowEscape")
        return
    end
    if ThrowCommonFunction(ESTEP_DOWN) == TRUE then
        act(RequestThrowAnimInterrupt)
        return
    end
end

function ThrowEscape_onUpdate()
    if ThrowCommonFunction() == TRUE then
        act(RequestThrowAnimInterrupt)
        return
    end
end

function ThrowDeath_onActivate()
    act(SetThrowState, THROW_TYPE_DEATH)
end

function ThrowDeathIdle_onActivate()
    act(SetThrowState, THROW_TYPE_INVALID)
end
