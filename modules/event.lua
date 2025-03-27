
function Event_Activate()
    ActivateRightArmAdd(START_FRAME_NONE)
    SetVariable("IsEventActivate", true)
end

function Event_Update()
    if GetVariable("IsEventActivate") == false then
        UpdateRightArmAdd()
    end

    SetVariable("IsEventActivate", false)
end

----------------------
-- Common functions --
----------------------

function EventCommonFunction()
    if env(GetEventEzStateFlag, 0) == FALSE then
        act(SetIsEventAnim)
    end

    act(SetCanChangeEquipmentOn)

    if env(HasThrowRequest) == TRUE then
        return TRUE
    end
    if ExecTalkDeath() == TRUE then
        return TRUE
    end
    if ExecDeath() == TRUE then
        return TRUE
    end
    if ExecTalkDamage() == TRUE then
        return TRUE
    end
    if env(GetSpEffectID, 9913) == FALSE and ExecDamage(FALSE) == TRUE then
        return TRUE
    end
    if ExecFallStart(FALL_TYPE_DEFAULT) == TRUE then
        return TRUE
    end
    if ExecTalk() == TRUE then
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

    local moveEvent = Event_MoveQuick

    if c_IsStealth == TRUE then
        moveEvent = Event_Stealth_Move
    end

    if MoveStartonCancelTiming(moveEvent, FALSE) == TRUE then
        return TRUE
    end
    return FALSE
end


Event_Activate = hookup_function(Event_Activate)
Event_Update = hookup_function(Event_Update)
EventCommonFunction = hookup_function(EventCommonFunction)
