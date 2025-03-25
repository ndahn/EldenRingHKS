
function LadderStart()
    local event_command = GetLadderEventCommand(TRUE)

    if event_command == LADDER_ACTION_START_BOTTOM then
        ExecEvent("W_LadderAttachBottom")
        return TRUE
    elseif event_command == LADDER_ACTION_START_TOP then
        ExecEvent("W_LadderAttachTop")
        return TRUE
    end
    return FALSE
end

function LadderSetActionState(state)
    act(SetLadderActionState, state)
end

function LadderSendCommand(event_call)
    act(SendMessageIDToEvents, event_call)
end

function GetLadderEventCommand(is_start)
    if env(IsCOMPlayer) == FALSE then
        return env(GetCommandIDFromEvent, 0)
    else
        local req_up = env(ActionRequest, ACTION_ARM_LADDERUP)
        local req_down = env(ActionRequest, ACTION_ARM_LADDERDOWN)

        if is_start == TRUE then
            if req_up == TRUE then
                return LADDER_ACTION_START_BOTTOM
            elseif req_down == TRUE then
                return LADDER_ACTION_START_TOP
            end
        elseif req_up == TRUE then
            if env(IsReachTopOfLadder) == TRUE then
                return LADDER_EVENT_COMMAND_END_TOP
            else
                return LADDER_EVENT_COMMAND_UP
            end
        elseif req_down == TRUE then
            if env(IsReachBottomOfLadder) == TRUE then
                return LADDER_EVENT_COMMAND_END_BOTTOM
            else
                return LADDER_EVENT_COMMAND_DOWN
            end
        end

        return INVALID
    end
end

function ExecLadderMove(hand)
    local sp_action = env(ActionDuration, ACTION_ARM_SP_MOVE)

    if sp_action == 0 then
        if Flag_LadderJump == LADDER_JUMP_WHEN_RELEASE and env(ActionRequest, ACTION_ARM_BACKSTEP) == TRUE and
            env(IsOnLastRungOfLadder) == FALSE then
            LadderSendCommand(LADDER_EVENT_COMMAND_EXIT)
            LadderSetActionState(LADDER_ACTION_INVALID)
            ExecEvent("W_LadderDrop")
            return TRUE
        end

        Flag_LadderJump = LADDER_JUMP_SP_RELEASED
    elseif sp_action < 150 then
        if Flag_LadderJump == LADDER_JUMP_SP_RELEASED then
            Flag_LadderJump = LADDER_JUMP_WHEN_RELEASE
        end
    else
        Flag_LadderJump = LADDER_JUMP_INVALID
    end

    local event_command = GetLadderEventCommand(FALSE)

    if event_command <= 0 then
        return FALSE
    end
    if event_command == LADDER_EVENT_COMMAND_UP then
        if env(IsCOMPlayer) == TRUE and env(DoesLadderHaveCharacters, LADDER_UP_CHECK_DIST, 1, 1) == TRUE then
            if hand == HAND_STATE_RIGHT then
                ExecEvent("W_LadderAttackUpRight")
            else
                ExecEvent("W_LadderAttackUpLeft")
            end
            return TRUE
        end

        if env(IsSomeoneOnLadder, LADDER_UP_CHECK_DIST, 0) == TRUE then
            return FALSE
        end
        if env(ActionDuration, ACTION_ARM_SP_MOVE) > 0 then
            SetVariable("IsFastUp", TRUE)
        else
            SetVariable("IsFastUp", FALSE)
        end

        if hand == HAND_STATE_LEFT then
            ExecEvent("W_LadderUpLeft")
        else
            ExecEvent("W_LadderUpRight")
        end

        return TRUE
    elseif event_command == LADDER_EVENT_COMMAND_DOWN then
        if env(IsCOMPlayer) == TRUE and env(DoesLadderHaveCharacters, LADDER_DOWN_CHECK_DIST, 0, 1) == TRUE then
            if hand == HAND_STATE_RIGHT then
                ExecEvent("W_LadderAttackDownRight")
            else
                ExecEvent("W_LadderAttackDownLeft")
            end
            return TRUE
        end
        if env(IsSomeoneUnderLadder, LADDER_DOWN_CHECK_DIST, 0) == TRUE then
            return FALSE
        end
        if env(ActionDuration, ACTION_ARM_SP_MOVE) > 0 then
            ExecEvent("W_LadderCoastStart")
            return TRUE
        end
        if hand == HAND_STATE_LEFT then
            ExecEvent("W_LadderDownLeft")
        else
            ExecEvent("W_LadderDownRight")
        end

        return TRUE
    elseif event_command == LADDER_EVENT_COMMAND_END_TOP then
        if hand == HAND_STATE_LEFT then
            ExecEvent("W_LadderEndTopLeft")
        else
            ExecEvent("W_LadderEndTopRight")
        end

        return TRUE
    elseif event_command == LADDER_EVENT_COMMAND_END_BOTTOM then
        if hand == HAND_STATE_LEFT then
            ExecEvent("W_LadderEndBottomLeft")
        else
            ExecEvent("W_LadderEndBottomRight")
        end

        return TRUE
    end
    return FALSE
end

function ExecLadderAttack(hand)
    if env(GetStamina) <= 0 then
        return FALSE
    end
    if env(ActionRequest, ACTION_ARM_R1) == TRUE then
        if hand == HAND_STATE_RIGHT then
            ExecEvent("W_LadderAttackUpRight")
        else
            ExecEvent("W_LadderAttackUpLeft")
        end

        return TRUE
    elseif env(ActionRequest, ACTION_ARM_R2) == TRUE then
        if hand == HAND_STATE_RIGHT then
            ExecEvent("W_LadderAttackDownRight")
        else
            ExecEvent("W_LadderAttackDownLeft")
        end
        return TRUE
    end
    return FALSE
end

function CheckLadderDamage(hand)
    local damage_flag = Flag_LadderDamage

    if damage_flag == LADDER_DAMAGE_SMALL then
        act(ChangeStamina, -30)

        if ExecLadderFall() == TRUE then
            return TRUE
        end
        if hand == HAND_STATE_LEFT then
            ExecEvent("W_LadderDamageSmallLeft")
        else
            ExecEvent("W_LadderDamageSmallRight")
        end
    elseif damage_flag == LADDER_DAMAGE_LARGE then
        act(ChangeStamina, -40)

        if ExecLadderFall() == TRUE then
            return TRUE
        end
        if hand == HAND_STATE_LEFT then
            ExecEvent("W_LadderDamageLargeLeft")
        else
            ExecEvent("W_LadderDamageLargeRight")
        end
    else
        Flag_LadderDamage = LADDER_DAMAGE_NONE
        return FALSE
    end

    Flag_LadderDamage = LADDER_DAMAGE_NONE

    return TRUE
end

function ExecLadderDamageIdle(hand)
    if env(HasReceivedAnyDamage) == FALSE then
        return FALSE
    end
    if env(GetStamina) <= 80 then
        act(ChangeStamina, -40)

        if ExecLadderFall() == TRUE then
            return TRUE
        end
        if hand == HAND_STATE_LEFT then
            ExecEvent("W_LadderDamageLargeLeft")
        else
            ExecEvent("W_LadderDamageLargeRight")
        end
    else
        act(ChangeStamina, -30)
        if ExecLadderFall() == TRUE then
            return TRUE
        end
        if hand == HAND_STATE_LEFT then
            ExecEvent("W_LadderDamageSmallLeft")
        else
            ExecEvent("W_LadderDamageSmallRight")
        end
    end
    return TRUE
end

function ExecLadderDamageMove()
    if env(HasReceivedAnyDamage) == FALSE then
        return FALSE
    end
    if env(GetStamina) <= 80 then
        Flag_LadderDamage = LADDER_DAMAGE_LARGE
    else
        Flag_LadderDamage = LADDER_DAMAGE_SMALL
    end
    return TRUE
end

function ExecLadderFall()
    if env(GetStamina) > 0 and env(GetDamageSpecialAttribute, 5) == FALSE then
        return FALSE
    end
    ExecEvent("W_LadderFallStart")
    return TRUE
end

function ExecLadderDeath()
    local hp = env(GetHP)

    if hp <= 0 or env(GetStateChangeType, CONDITION_TYPE_STONE) == TRUE or
        env(GetStateChangeType, CONDITION_TYPE_CRYSTAL) == TRUE or env(GetDamageSpecialAttribute, 3) == TRUE then
        ExecEvent("W_LadderDeathStart")
        return TRUE
    end
    return FALSE
end

--------------
-- Triggers --
--------------

function LadderIdleCommonFunction(hand)
    act(SetCanChangeEquipmentOn)

    if ExecLadderDeath() == TRUE then
        return TRUE
    end
    if ExecLadderDamageIdle(hand) == TRUE then
        return TRUE
    end
    if ExecLadderAttack(hand) == TRUE then
        return TRUE
    end
    if ExecLadderItem(hand) == TRUE then
        return TRUE
    end
    if ExecLadderMove(hand) == TRUE then
        return TRUE
    end
    return FALSE
end

function LadderMoveCommonFunction(hand, is_no_damage)
    act(SetCanChangeEquipmentOn)

    if ExecLadderDeath() == TRUE then
        return TRUE
    end

    if is_no_damage == FALSE and ExecLadderDamageMove() == TRUE then
    end

    if env(IsAnimEnd, 1) == TRUE then
        if CheckLadderDamage(hand) == TRUE then
            return TRUE
        end
        if ExecLadderAttack(hand) == TRUE then
            return TRUE
        end
        if ExecLadderItem(hand) == TRUE then
            return TRUE
        end
        if ExecLadderMove(hand) == TRUE then
            return TRUE
        end
        if hand == HAND_STATE_LEFT then
            ExecEvent("W_LadderIdleLeft")
        else
            ExecEvent("W_LadderIdleRight")
        end

        return TRUE
    end
    return FALSE
end

function LadderAttackCommonFunction(hand)
    act(SetCanChangeEquipmentOn)

    if ExecLadderDeath() == TRUE then
        return TRUE
    end
    if ExecLadderDamageIdle(hand) == TRUE then
        return TRUE
    end

    if env(IsAnimEnd, 1) == TRUE then
        if ExecLadderAttack(hand) == TRUE then
            return TRUE
        end
        if ExecLadderItem(hand) == TRUE then
            return TRUE
        end
        if ExecLadderMove(hand) == TRUE then
            return TRUE
        end
        if hand == HAND_STATE_LEFT then
            ExecEvent("W_LadderIdleLeft")
        else
            ExecEvent("W_LadderIdleRight")
        end

        return TRUE
    end
    return FALSE
end

function LadderDamageCommonFunction(hand)
    act(SetCanChangeEquipmentOn)

    if ExecLadderDeath() == TRUE then
        return TRUE
    end
    if ExecLadderDamageIdle(hand) == TRUE then
        return TRUE
    end
    if env(IsAnimEnd, 1) == TRUE then
        if ExecLadderAttack(hand) == TRUE then
            return TRUE
        end
        if ExecLadderItem(hand) == TRUE then
            return TRUE
        end
        if ExecLadderMove(hand) == TRUE then
            return TRUE
        end
        if hand == HAND_STATE_RIGHT then
            ExecEvent("W_LadderIdleRight")
        else
            ExecEvent("W_LadderIdleLeft")
        end

        return TRUE
    end
    return FALSE
end

function LadderEndCommonFunction()
    act(SetCanChangeEquipmentOn)

    if ExecLadderDeath() == TRUE then
        LadderSetActionState(LADDER_ACTION_INVALID)
        return TRUE
    end
    if ExecFallStart(FALL_TYPE_DEFAULT) == TRUE then
        LadderSetActionState(LADDER_ACTION_INVALID)
        return TRUE
    end
    if ExecJump() == TRUE then
        LadderSetActionState(LADDER_ACTION_INVALID)
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, ALLBODY) == TRUE then
        LadderSetActionState(LADDER_ACTION_INVALID)
        return TRUE
    end
    if ExecGuardOnCancelTiming(FALSE, ALLBODY) == TRUE then
        LadderSetActionState(LADDER_ACTION_INVALID)
        return TRUE
    end
    if ExecWeaponChange(ALLBODY) == TRUE then
        LadderSetActionState(LADDER_ACTION_INVALID)
        return TRUE
    end
    if ExecEvasion(FALSE, ESTEP_NONE, FALSE) == TRUE then
        LadderSetActionState(LADDER_ACTION_INVALID)
        return TRUE
    end
    if ExecItem(QUICKTYPE_NORMAL, ALLBODY) == TRUE then
        LadderSetActionState(LADDER_ACTION_INVALID)
        return TRUE
    end
    if ExecMagic(QUICKTYPE_NORMAL, ALLBODY, FALSE) == TRUE then
        LadderSetActionState(LADDER_ACTION_INVALID)
    end
    if ExecArtsStanceOnCancelTiming(ALLBODY) == TRUE then
        LadderSetActionState(LADDER_ACTION_INVALID)
        return TRUE
    end
    if ExecAttack("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, ALLBODY, FALSE, FALSE, FALSE) == TRUE then
        LadderSetActionState(LADDER_ACTION_INVALID)
        return TRUE
    end
    if MoveStartonCancelTiming(Event_Move, FALSE) == TRUE then
        LadderSetActionState(LADDER_ACTION_INVALID)
        return TRUE
    end
    return FALSE
end

function LadderItemCommonFunction(hand, tonext)
    act(SetIsItemAnimationPlaying)
    act(SetCanChangeEquipmentOn)
    if ExecLadderDeath() == TRUE then
        return TRUE
    end
    if ExecLadderDamageIdle(hand) == TRUE then
        return TRUE
    end
    if env(IsAnimEnd, 1) == TRUE then
        if ExecLadderItem(hand) == TRUE then
            return TRUE
        end
        if tonext == FALSE then
            if ExecLadderAttack(hand) == TRUE then
                return TRUE
            end
            if ExecLadderMove(hand) == TRUE then
                return TRUE
            end
            if hand == HAND_STATE_RIGHT then
                ExecEvent("W_LadderIdleRight")
            else
                ExecEvent("W_LadderIdleLeft")
            end
            return TRUE
        end
        return FALSE
    end
    return FALSE
end

function LadderCoastCommonFunction(hand, is_start)
    act(SetCanChangeEquipmentOn)

    if ExecLadderDeath() == TRUE then
        return TRUE
    end
    if ExecLadderDamageMove() == TRUE then
    end

    if is_start == FALSE then
        if env(IsOnLastRungOfLadder) == TRUE then
            ExecEvent("W_LadderCoastLanding")
            return TRUE
        end

        local event_command = GetLadderEventCommand(FALSE)

        if env(ActionDuration, ACTION_ARM_SP_MOVE) <= 0 or env(MovementRequestDuration) <= 0 or event_command > 0 and
            event_command ~= LADDER_EVENT_COMMAND_DOWN or env(IsSomeoneUnderLadder, LADDER_DOWN_CHECK_DIST, 0) == TRUE then
            act(LadderSlideDownCancel)
            if env(GetNumberOfRungsBelowOnLadder) % 2 == 0 then
                ExecEvent("W_LadderCoastStopRight")
            else
                ExecEvent("W_LadderCoastStopLeft")
            end
            return TRUE
        end
    elseif env(IsAnimEnd, 1) == TRUE then
        if CheckLadderDamage(hand) == TRUE then
            return TRUE
        end
        ExecEvent("W_LadderCoastLeft")
        return TRUE
    end
    return FALSE
end

--------------
-- Triggers --
--------------

function Ladder_Activate()
    act(ClearSlopeInfo)
    act(SetCanChangeEquipmentOn)
    Flag_LadderDamage = LADDER_DAMAGE_NONE
    Flag_LadderJump = LADDER_JUMP_INVALID
    SetThrowInvalid()
end

function Ladder_Update()
    SetThrowInvalid()
    LadderSetActionState(INVALID)
end

function LadderAttachBottom_onUpdate()
    if env(IsObjActInterpolatedMotion) == TRUE then
        return
    end
    ExecEvent("W_LadderStartBottom")
end

function LadderAttachTop_onUpdate()
    if env(IsObjActInterpolatedMotion) == TRUE then
        return
    end
    ExecEvent("W_LadderStartTop")
end

function LadderStartTop_onActivate()
    act(ClearSlopeInfo)
end

function LadderStartTop_onUpdate()
    LadderSetActionState(LADDER_ACTION_START_TOP)
    if LadderMoveCommonFunction(HAND_STATE_LEFT, TRUE) == TRUE then
        return
    end
end

function LadderStartBottom_onActivate()
    act(ClearSlopeInfo)
end

function LadderStartBottom_onUpdate()
    LadderSetActionState(LADDER_ACTION_START_BOTTOM)
    if LadderMoveCommonFunction(HAND_STATE_LEFT, TRUE) == TRUE then
        return
    end
end

function LadderUpRight_onActivate()
    LadderSendCommand(LADDER_CALL_UP)
end

function LadderUpRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_UP_RIGHT)
    if LadderMoveCommonFunction(HAND_STATE_LEFT, FALSE) == TRUE then
        return
    end
end

function LadderUpLeft_onActivate()
    LadderSendCommand(LADDER_CALL_UP)
end

function LadderUpLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_UP_LEFT)
    if LadderMoveCommonFunction(HAND_STATE_RIGHT, FALSE) == TRUE then
        return
    end
end

function LadderDownLeft_onActivate()
    LadderSendCommand(LADDER_CALL_DOWN)
end

function LadderDownLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_DOWN_LEFT)
    if LadderMoveCommonFunction(HAND_STATE_RIGHT, FALSE) == TRUE then
        return
    end
end

function LadderDownRight_onActivate()
    LadderSendCommand(LADDER_CALL_DOWN)
end

function LadderDownRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_DOWN_RIGHT)
    if LadderMoveCommonFunction(HAND_STATE_LEFT, FALSE) == TRUE then
        return
    end
end

function LadderEndBottomLeft_onActivate()
    LadderSendCommand(LADDER_EVENT_COMMAND_EXIT)
end

function LadderEndBottomLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_END_BOTTOM)
    if LadderEndCommonFunction() == TRUE then
        return
    end
end

function LadderEndBottomRight_onActivate()
    LadderSendCommand(LADDER_CALL_DOWN)
end

function LadderEndBottomRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_END_BOTTOM)
    if LadderEndCommonFunction() == TRUE then
        return
    end
end

function LadderEndTopLeft_onActivate()
    LadderSendCommand(LADDER_CALL_UP)
end

function LadderEndTopLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_END_TOP)
    if LadderEndCommonFunction() == TRUE then
        return
    end
end

function LadderEndTopRight_onActivate()
    LadderSendCommand(LADDER_CALL_UP)
end

function LadderEndTopRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_END_TOP)
    if LadderEndCommonFunction() == TRUE then
        return
    end
end

function LadderIdleLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_LEFT)
    if LadderIdleCommonFunction(HAND_STATE_LEFT) == TRUE then
        return
    end
end

function LadderIdleRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_RIGHT)
    if LadderIdleCommonFunction(HAND_STATE_RIGHT) == TRUE then
        return
    end
end

function LadderAttackUpRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_ATTACK_UP_RIGHT)
    if LadderAttackCommonFunction(HAND_STATE_RIGHT) == TRUE then
        return
    end
end

function LadderAttackUpLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_ATTACK_UP_LEFT)
    if LadderAttackCommonFunction(HAND_STATE_LEFT) == TRUE then
        return
    end
end

function LadderAttackDownRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_ATTACK_DOWN_RIGHT)
    if LadderAttackCommonFunction(HAND_STATE_RIGHT) == TRUE then
        return
    end
end

function LadderAttackDownLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_ATTACK_DOWN_RIGHT)
    if LadderAttackCommonFunction(HAND_STATE_LEFT) == TRUE then
        return
    end
end

function LadderCoastStart_onUpdate()
    LadderSetActionState(LADDER_ACTION_COAST_START)
    if LadderCoastCommonFunction(HAND_STATE_LEFT, TRUE) == TRUE then
        return
    end
end

function LadderCoastRight_onActivate()
    LadderSendCommand(LADDER_CALL_DOWN)
end

function LadderCoastRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_COAST_RIGHT)
    if LadderCoastCommonFunction(HAND_STATE_LEFT, FALSE) == TRUE then
        return
    end
end

function LadderCoastLeft_onActivate()
    LadderSendCommand(LADDER_CALL_DOWN)
end

function LadderCoastLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_COAST_LEFT)
    if LadderCoastCommonFunction(HAND_STATE_RIGHT, FALSE) == TRUE then
        return
    end
end

function LadderCoastStopLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_COAST_STOP)
    if LadderMoveCommonFunction(HAND_STATE_LEFT, FALSE) == TRUE then
        return
    end
end

function LadderCoastStopRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_COAST_STOP)
    if LadderMoveCommonFunction(HAND_STATE_RIGHT, FALSE) == TRUE then
        return
    end
end

function LadderCoastLanding_onActivate()
    LadderSendCommand(LADDER_CALL_DOWN)
end

function LadderCoastLanding_onUpdate()
    LadderSetActionState(LADDER_ACTION_COAST_LANDING)
    if LadderEndCommonFunction() == TRUE then
        return
    end
end

function LadderDamageLargeRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_DAMAGE_LARGE)
    if LadderDamageCommonFunction(HAND_STATE_RIGHT) == TRUE then
        return
    end
end

function LadderDamageSmallRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_DAMAGE_SMALL)
    if LadderDamageCommonFunction(HAND_STATE_RIGHT) == TRUE then
        return
    end
end

function LadderDamageLargeLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_DAMAGE_LARGE)
    if LadderDamageCommonFunction(HAND_STATE_LEFT) == TRUE then
        return
    end
end

function LadderDamageSmallLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_DAMAGE_SMALL)
    if LadderDamageCommonFunction(HAND_STATE_LEFT) == TRUE then
        return
    end
end

function LadderDeathStart_onActivate()
    LadderSendCommand(LADDER_EVENT_COMMAND_EXIT)
end

function LadderDeathLoop_onUpdate()
    if env(IsLanding) == TRUE then
        ExecEvent("LadderDeathLand")
    end
    local height = env(GetFallHeight) / 100
    if height > 60 then
        ExecEvent("W_LadderDeathIdle")
    end
end

function LadderDeathIdle_onActivate()
    act(SetDeathStay, TRUE)
end

function LadderDeathIdle_onDeactivate()
    act(SetDeathStay, FALSE)
end

function LadderFallStart_onActivate()
    LadderSendCommand(LADDER_EVENT_COMMAND_EXIT)
end

function LadderFallLoop_onUpdate()
    if FallCommonFunction(TRUE, FALSE, FALL_LADDER) == TRUE then
        return
    end
end

function LadderFallLanding_onUpdate()
    if LandCommonFunction() == TRUE then
        return
    end
end

function LadderDrop_onUpdate()
    act(SetMovementScaleMult, math.random(160, 200) / 100)
    act(SetCanChangeEquipmentOn)
    if env(IsFalling) == TRUE then
        ExecEventAllBody("W_FallLoop")
        return
    end
end
