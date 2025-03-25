
function IsLandDead(height)
    if env(GetHP) <= 0 then
        return TRUE
    elseif height > 20 and env(IsInvincibleDebugMode) == FALSE and env(GetStateChangeType, 266) == FALSE then
        return TRUE
    end
    return FALSE
end

function GetLandIndex(height, is_jump)
    if 8 < height then
        return LAND_HEAVY
    elseif height > 4 then
        return LAND_MIDDLE
    elseif is_jump == TRUE and height > 0 then
        return LAND_JUMP
    else
        return LAND_DEFAULT
    end
end

----------------------
-- Common functions --
----------------------

function FallCommonFunction(is_enable_falling_death, is_jump, fall_style)
    local height = env(GetFallHeight) / 100
    local damage_type = env(GetReceivedDamageType)
    local style = c_Style
    if damage_type == DAMAGE_TYPE_DEATH_FALLING then
        if fall_style == FALL_FACEUP then
            ExecEventAllBody("W_FallDeathFaceUp")
        elseif fall_style == FALL_FACEDOWN then
            ExecEventAllBody("W_FallDeathFaceDown")
        else
            ExecEventAllBody("W_FallDeath")
        end
        return TRUE
    end
    if is_enable_falling_death ~= TRUE or not (height >= 60) or env(GetStateChangeType, 266) == TRUE then
    else
        if fall_style == FALL_FACEUP then
            ExecEventAllBody("W_FallDeathFaceUp")
        elseif fall_style == FALL_FACEDOWN then
            ExecEventAllBody("W_FallDeathFaceDown")
        else
            ExecEventAllBody("W_FallDeath")
        end
        return TRUE
    end

    act(SetCanChangeEquipmentOn)

    if env(IsLanding) == TRUE then
        IS_ATTACKED_JUMPMAGIC = FALSE

        if env(GetStateChangeType, 266) == TRUE then
            Replanning()
            SetVariable("LandIndex", LAND_MIDDLE)
            ExecEventAllBody("W_Land")
            return TRUE
        end
        if fall_style == FALL_DEFAULT then
            if IsLandDead(height) == TRUE then
                if height > 8 then
                    SetVariable("IndexDeath", DEATH_TYPE_LAND)
                else
                    SetVariable("IndexDeath", DEATH_TYPE_LAND_LOW)
                end

                ExecEventAllBody("W_DeathStart")

                return TRUE
            else
                if height > 1.2999999523162842 then
                    local landIndex = GetLandIndex(height, is_jump)

                    SetVariable("LandIndex", landIndex)
                    Replanning()
                    local JumpMoveLevel = 0

                    if landIndex ~= LAND_HEAVY then
                        if GetVariable("MoveSpeedLevel") > 1.100000023841858 then
                            JumpMoveLevel = 2
                        elseif GetVariable("MoveSpeedLevel") > 0.6000000238418579 then
                            JumpMoveLevel = 1
                        end
                    end

                    if env(GetSpEffectID, 503520) == TRUE then
                        JumpMoveLevel = 0
                    elseif env(GetSpEffectID, 5520) == TRUE then
                        JumpMoveLevel = 0
                    elseif env(GetSpEffectID, 425) == TRUE then
                        JumpMoveLevel = 0
                    elseif env(GetSpEffectID, 4101) == TRUE then
                        JumpMoveLevel = 0
                    elseif env(GetSpEffectID, 4100) == TRUE then
                        JumpMoveLevel = 0
                    elseif env(GetSpEffectID, 19670) == TRUE then
                        JumpMoveLevel = 0
                    end
                    if JumpMoveLevel == 2 then
                        ExecEventNoReset("W_Jump_Land_To_Dash")
                        return TRUE
                    elseif JumpMoveLevel == 1 then
                        SetVariable("JumpLandMoveDirection", GetVariable("MoveDirection"))
                        ExecEventNoReset("W_Jump_Land_To_Run")
                        return TRUE
                    else
                        ExecEventAllBody("W_Land")
                    end
                else
                    act(Unknown9999)

                    if height > 0.30000001192092896 then
                        ExecEventAllBody("W_LandLow")
                    else
                        ExecEventAllBody("W_Idle")
                    end
                end
                return TRUE
            end
        elseif fall_style == FALL_FACEUP then
            if IsLandDead(height) == TRUE then
                SetVariable("IndexDeath", DEATH_TYPE_LAND_FACEUP)
                ExecEventAllBody("W_DeathStart")
            else
                Replanning()
                ExecEventAllBody("W_LandFaceUp")
            end

            return TRUE
        elseif fall_style == FALL_FACEDOWN then
            if IsLandDead(height) == TRUE then
                SetVariable("IndexDeath", DEATH_TYPE_LAND_FACEDOWN)
                ExecEventAllBody("W_DeathStart")
            else
                Replanning()
                ExecEventAllBody("W_LandFaceDown")
            end

            return TRUE
        elseif fall_style == FALL_LADDER then
            if IsLandDead(height) == TRUE then
                SetVariable("IndexDeath", DEATH_TYPE_LAND)
                ExecEventAllBody("W_DeathStart")
            else
                Replanning()
                ExecEventAllBody("W_LadderFallLanding")
            end

            return TRUE
        end
    end

    local arrowHand = HAND_RIGHT

    if style == HAND_LEFT_BOTH then
        arrowHand = HAND_LEFT
    end

    local is_arrow = GetEquipType(arrowHand, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_ARROW,
        WEAPON_CATEGORY_LARGE_ARROW, WEAPON_CATEGORY_CROSSBOW, WEAPON_CATEGORY_BALLISTA)

    if is_arrow == TRUE then
        if env(ActionRequest, 0) == TRUE then
            act(ChooseBowAndArrowSlot, 0)
            g_ArrowSlot = 0
        elseif env(ActionRequest, 1) == TRUE then
            act(ChooseBowAndArrowSlot, 1)
            g_ArrowSlot = 1
        end
    end

    if fall_style == FALL_DEFAULT and height >= 0.20000000298023224 then
        if ExecFallMagic() == TRUE then
            return TRUE
        elseif ExecFallAttack() == TRUE then
            return TRUE
        end
    end

    return FALSE
end

function LandCommonFunction()
    act(SetCanChangeEquipmentOn)

    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
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
    if ExecArtsStanceOnCancelTiming(ALLBODY) == TRUE then
        return TRUE
    end
    if ExecAttack("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, ALLBODY, FALSE, FALSE, FALSE) == TRUE then
        return TRUE
    end
    if MoveStartonCancelTiming(Event_Move, FALSE) == TRUE then
        return TRUE
    end
    return FALSE
end

--------------
-- Triggers --
--------------

function FallStart_onUpdate()
    if FallCommonFunction(TRUE, FALSE, FALL_DEFAULT) == TRUE then
        return
    end
end

function FallJumpStart_onUpdate()
    if FallCommonFunction(TRUE, TRUE, FALL_DEFAULT) == TRUE then
        return
    end
end

function FallLoop_onUpdate()
    if env(GetSpEffectID, 19935) == TRUE then
        if env(IsHamariFallDeath, 20) == TRUE then
            ExecEvent("W_FallDeath")
            return
        end
    elseif env(IsHamariFallDeath, 12) == TRUE then
        ExecEvent("W_FallDeath")
        return
    end
    if FallCommonFunction(TRUE, FALSE, FALL_DEFAULT) == TRUE then
        return
    end
end

function Land_onUpdate()
    if LandCommonFunction() == TRUE then
        return
    end
end

function LandLow_onActivate()
    act(Wait)
end

function LandLow_onUpdate()
    if IdleCommonFunction() == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        ExecEventAllBody("W_Idle")
        return
    end
end

function FallStartFaceUp_onUpdate()
    if FallCommonFunction(TRUE, FALSE, FALL_FACEUP) == TRUE then
        return
    end
end

function FallStartFaceDown_onUpdate()
    if FallCommonFunction(TRUE, FALSE, FALL_FACEDOWN) == TRUE then
        return
    end
end

function FallLoopFaceUp_onUpdate()
    if env(GetSpEffectID, 19935) == TRUE then
        if env(IsHamariFallDeath, 20) == TRUE then
            ExecEvent("W_FallDeathFaceUp")
            return
        end
    elseif env(IsHamariFallDeath, 12) == TRUE then
        ExecEvent("W_FallDeathFaceUp")
        return
    end
    if FallCommonFunction(TRUE, FALSE, FALL_FACEUP) == TRUE then
        return
    end
end

function FallLoopFaceDown_onUpdate()
    if env(GetSpEffectID, 19935) == TRUE then
        if env(IsHamariFallDeath, 20) == TRUE then
            ExecEvent("W_FallDeathFaceDown")
            return
        end
    elseif env(IsHamariFallDeath, 12) == TRUE then
        ExecEvent("W_FallDeathFaceDown")
        return
    end
    if FallCommonFunction(TRUE, FALSE, FALL_FACEDOWN) == TRUE then
        return
    end
end

function LandFaceUp_onUpdate()
    if LandCommonFunction() == TRUE then
        return
    end
end

function LandFaceDown_onUpdate()
    if LandCommonFunction() == TRUE then
        return
    end
end
