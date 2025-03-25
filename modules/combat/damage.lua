
function ExecAddDamage(damage_dir, attack_dir, damage_level, is_guard, is_damaged, is_justGuard)
    if is_damaged == FALSE then
        return
    end
    if env(GetBehaviorID, 2) == TRUE then
        return
    end
    if is_guard == TRUE and is_justGuard == TRUE and env(GetSpEffectID, 102022) == TRUE then
        return
    end

    if is_guard == TRUE then
        SetVariable("AddDamageGuardBlend", 1)
    else
        SetVariable("AddDamageLv0_Blend", 1)
        local pre_index = GetVariable("IndexDamageLv0_Random")
        local index = (pre_index + math.random(1, 2)) % 3
        SetVariable("IndexDamageLv0_Random", index)
    end

    if is_guard == TRUE and is_justGuard == TRUE then
        act(AddSpEffect, 102020)
        act(AddSpEffect, 102022)
        ExecEventNoReset("W_AddDamageJustGuardStartFront")
        return
    end

    if damage_dir == DAMAGE_DIR_LEFT then
        if attack_dir == ATTACK_DIR_FRONT then
            if is_guard == TRUE then
                ExecEventNoReset("W_AddDamageGuardStartLeft")
                return
            else
                ExecEventNoReset("W_AddDamageLv0")
                return
            end
        elseif attack_dir == ATTACK_DIR_UP then
            if is_guard == TRUE then
                ExecEventNoReset("W_AddDamageGuardStartLeft")
                return
            else
                ExecEventNoReset("W_AddDamageLv0")
                return
            end
        elseif attack_dir == ATTACK_DIR_DOWN then
            if is_guard == TRUE then
                ExecEventNoReset("W_AddDamageGuardStartLeft")
                return
            else
                ExecEventNoReset("W_AddDamageLv0")
                return
            end
        elseif attack_dir == ATTACK_DIR_LEFT then
            if is_guard == TRUE then
                ExecEventNoReset("W_AddDamageGuardStartFront")
                return
            else
                ExecEventNoReset("W_AddDamageLv0")
                return
            end
        elseif attack_dir == ATTACK_DIR_RIGHT then
            if is_guard == TRUE then
                ExecEventNoReset("W_AddDamageGuardStartBack")
                return
            else
                ExecEventNoReset("W_AddDamageLv0")
                return
            end
        end
    elseif damage_dir == DAMAGE_DIR_RIGHT then
        if attack_dir == ATTACK_DIR_FRONT then
            if is_guard == TRUE then
                ExecEventNoReset("W_AddDamageGuardStartRight")
                return
            else
                ExecEventNoReset("W_AddDamageLv0")
                return
            end
        elseif attack_dir == ATTACK_DIR_UP then
            if is_guard == TRUE then
                ExecEventNoReset("W_AddDamageGuardStartRight")
                return
            else
                ExecEventNoReset("W_AddDamageLv0")
                return
            end
        elseif attack_dir == ATTACK_DIR_DOWN then
            if is_guard == TRUE then
                ExecEventNoReset("W_AddDamageGuardStartRight")
                return
            else
                ExecEventNoReset("W_AddDamageLv0")
                return
            end
        elseif attack_dir == ATTACK_DIR_LEFT then
            if is_guard == TRUE then
                ExecEventNoReset("W_AddDamageGuardStartBack")
                return
            else
                ExecEventNoReset("W_AddDamageLv0")
                return
            end
        elseif attack_dir == ATTACK_DIR_RIGHT then
            if is_guard == TRUE then
                ExecEventNoReset("W_AddDamageGuardStartFront")
                return
            else
                ExecEventNoReset("W_AddDamageLv0")
                return
            end
        end
    elseif damage_dir == DAMAGE_DIR_FRONT then
        if attack_dir == ATTACK_DIR_FRONT then
            if is_guard == TRUE then
                ExecEventNoReset("W_AddDamageGuardStartFront")
                return
            else
                ExecEventNoReset("W_AddDamageLv0")
                return
            end
        elseif attack_dir == ATTACK_DIR_UP then
            if is_guard == TRUE then
                ExecEventNoReset("W_AddDamageGuardStartFront")
                return
            else
                ExecEventNoReset("W_AddDamageLv0")
                return
            end
        elseif attack_dir == ATTACK_DIR_DOWN then
            if is_guard == TRUE then
                ExecEventNoReset("W_AddDamageGuardStartFront")
                return
            else
                ExecEventNoReset("W_AddDamageLv0")
                return
            end
        elseif attack_dir == ATTACK_DIR_LEFT then
            if is_guard == TRUE then
                ExecEventNoReset("W_AddDamageGuardStartRight")
                return
            else
                ExecEventNoReset("W_AddDamageLv0")
                return
            end
        elseif attack_dir == ATTACK_DIR_RIGHT then
            if is_guard == TRUE then
                ExecEventNoReset("W_AddDamageGuardStartLeft")
                return
            else
                ExecEventNoReset("W_AddDamageLv0")
                return
            end
        end
    elseif damage_dir == DAMAGE_DIR_BACK then
        ExecEventNoReset("W_AddDamageLv0")
    end
end

function ExecPassiveAction(is_parry, fall_type, is_attackwhileguard)
    if env(HasThrowRequest) == TRUE then
        ResetDamageCount()
        return TRUE
    end
    if ExecDeath() == TRUE then
        return TRUE
    end
    if env(ActionRequest, ACTION_ARM_BUDDY_DISAPPEAR) == TRUE then
        ExecEventAllBody("W_Event60505")
        return TRUE
    end
    if ExecTalk() == TRUE then
        ResetDamageCount()
        return TRUE
    end
    if ExecMovableEventAnim() == TRUE then
        ResetDamageCount()
        return TRUE
    end
    if env(CheckForEventAnimPlaybackRequest) == TRUE then
        ResetDamageCount()
        return TRUE
    end
    if ExecDamage(is_parry, is_attackwhileguard) == TRUE then
        return TRUE
    end
    if ExecFallStart(fall_type) == TRUE then
        ResetDamageCount()
        return TRUE
    end
    return FALSE
end

function CalcDamageCount()
    act(DebugLogOutput, "Calc DamageCount")

    if env(GetBehaviorID, 9) == TRUE then
        SetVariable("UseChainRecover", 1)
        return
    else
        local damagecount = GetVariable("DamageCount")

        SetVariable("DamageCount", damagecount + 1)
        SetVariable("UseChainRecover", 1)
    end
end

function ResetDamageCount()
    SetVariable("DamageCount", 0)
    SetVariable("UseChainRecover", 0)
end

function ExecDamage(is_parry, is_attackwhileguard)
    local damage_level = env(GetDamageLevel)
    local damage_type = env(GetReceivedDamageType)
    local is_damaged = env(HasReceivedAnyDamage)
    if env(GetSpEffectType, 32) == TRUE and env(GetSpEffectID, 19925) == FALSE then
        act(SetDamageAnimType, DAMAGE_FLAG_SMALL)
        ResetRequest()
        ExecEventAllBody("W_DamageBind")
        Replanning()

        return TRUE
    end
    if env(GetDamageSpecialAttribute, 5) == TRUE then
        ExecEventAllBody("W_DamageSleepResist")
        return TRUE
    end
    if env(GetDamageSpecialAttribute, 6) == TRUE then
        ExecEventAllBody("W_DamageMad")
        return TRUE
    end
    if env(GetDamageSpecialAttribute, 2) == TRUE or env(GetDamageSpecialAttribute, 4) == TRUE then
        if damage_level == DAMAGE_LEVEL_NONE then
            if IsNodeActive("SwordArtsOneShot Selector") == TRUE and c_SwordArtsID == 136 then
            elseif env(GetSpEffectID, 6340) == TRUE or env(GetSpEffectID, 1650) == TRUE or env(GetSpEffectID, 1851) ==
                TRUE then
            else
                damage_level = DAMAGE_LEVEL_SMALL
            end
        elseif damage_level ~= DAMAGE_LEVEL_SMALL and damage_level ~= DAMAGE_LEVEL_MIDDLE and damage_level ==
            DAMAGE_LEVEL_MINIMUM then
        end
    end

    if damage_level <= DAMAGE_LEVEL_NONE and (is_damaged == FALSE or env(IsPartDamageAdditiveBlendInvalid) == TRUE) and
        (damage_type == DAMAGE_TYPE_INVALID or damage_type == DAMAGE_TYPE_WEAK_POINT or damage_type ==
            DAMAGE_LEVEL_MINIMUM) then
        return FALSE
    end
    if env(GetBehaviorID, 1) == TRUE then
        return FALSE
    end
    -- Raptors of the Mist Dodge
    if env(GetSpEffectID, 100500) == TRUE then
        ExecEventAllBody("W_SwordArtsStandDodge")
        act(AddSpEffect, 5635)
        ResetDamageCount()

        return TRUE
    end

    local attack_dir = env(GetAtkDirection)
    local damage_angle = env(GetReceivedDamageDirection)
    local style = c_Style

    if damage_type == DAMAGE_TYPE_PARRY then
        ExecEventAllBody("W_DamageParry")
        return TRUE
    end

    if damage_type >= DAMAGE_TYPE_GUARDED and damage_type <= DAMAGE_TYPE_WALL_LEFT then
        DebugPrint(1, damage_type)
        Replanning()

        if damage_type == DAMAGE_TYPE_GUARDED or damage_type == DAMAGE_TYPE_GUARDED_LEFT then
            if damage_type == DAMAGE_TYPE_GUARDED_LEFT then
                SetVariable("GuardDamageIndex", 2)
            elseif style == HAND_RIGHT then
                SetVariable("GuardDamageIndex", 0)
            elseif style == HAND_LEFT or style == HAND_RIGHT_BOTH then
                SetVariable("GuardDamageIndex", 1)
            else
                SetVariable("GuardDamageIndex", 0)
            end

            if damage_level == DAMAGE_LEVEL_NONE or damage_level == DAMAGE_LEVEL_MINIMUM then
                act(SetDamageAnimType, DAMAGE_FLAG_SMALL)
                ExecEventAllBody("W_Repelled_Small")
            elseif damage_level == DAMAGE_LEVEL_SMALL then
                act(SetDamageAnimType, DAMAGE_FLAG_SMALL)
                ExecEventAllBody("W_Repelled_Small")
            elseif damage_level == DAMAGE_LEVEL_MIDDLE or damage_level == DAMAGE_LEVEL_LARGE or damage_level ==
                DAMAGE_LEVEL_EXLARGE or damage_level == DAMAGE_LEVEL_PUSH or damage_level == DAMAGE_LEVEL_FLING or
                damage_level == DAMAGE_LEVEL_SMALL_BLOW or damage_level == DAMAGE_LEVEL_UPPER or damage_level ==
                DAMAGE_LEVEL_EX_BLAST or damage_level == DAMAGE_LEVEL_BREATH then
                act(SetDamageAnimType, DAMAGE_FLAG_LARGE)
                ExecEventAllBody("W_Repelled_Large")
            else
                act(SetDamageAnimType, DAMAGE_FLAG_SMALL)
                ExecEventAllBody("W_Repelled_Small")
            end

            return TRUE
        elseif damage_type == DAMAGE_TYPE_GUARDBREAK then
            if is_parry == TRUE then
                return FALSE
            end
            if env(GetSpEffectID, 175) == TRUE then
                return FALSE
            end

            local guardindex = GUARD_STYLE_DEFAULT

            if style == HAND_RIGHT then
                guardindex = env(GetGuardMotionCategory, HAND_LEFT)

                if GetEquipType(HAND_LEFT, WEAPON_CATEGORY_TORCH) == TRUE then
                    SetVariable("IsTorchGuard", TRUE)
                else
                    SetVariable("IsTorchGuard", FALSE)
                end

                if env(GetEquipWeaponCategory, HAND_LEFT) == WEAPON_CATEGORY_DUELING_SHIELD then
                    guardindex = 3
                end

                if env(GetEquipWeaponCategory, HAND_RIGHT) == WEAPON_CATEGORY_DUELING_SHIELD then
                    guardindex = 3
                    if env(GetSpEffectID, 176) == TRUE then
                        SetVariable("GuardBreakDuelingShieldState", 1)
                    end
                end
            elseif style == HAND_LEFT_BOTH then
                SetVariable("IsTorchGuard", FALSE)

                if env(GetStayAnimCategory) == 15 then
                    guardindex = env(GetGuardMotionCategory, HAND_LEFT)
                end

                if env(GetEquipWeaponCategory, HAND_LEFT) == WEAPON_CATEGORY_DUELING_SHIELD then
                    guardindex = 3
                end
            elseif style == HAND_RIGHT_BOTH then
                SetVariable("IsTorchGuard", FALSE)

                if env(GetStayAnimCategory) == 15 then
                    guardindex = env(GetGuardMotionCategory, HAND_RIGHT)
                end

                if env(GetEquipWeaponCategory, HAND_RIGHT) == WEAPON_CATEGORY_DUELING_SHIELD then
                    guardindex = 3
                end
            end

            SetVariable("IndexGuard", guardindex)
            act(SetDamageAnimType, DAMAGE_FLAG_GUARD_BREAK)

            if c_SwordArtsID == 202 and style == HAND_RIGHT and c_SwordArtsHand == HAND_RIGHT then
                ExecEventAllBody("W_GuardBreakRight")
            else
                ExecEventAllBody("W_GuardBreak")
            end

            return TRUE
        elseif damage_type == DAMAGE_TYPE_WALL_RIGHT then
            if style == HAND_RIGHT_BOTH or style == HAND_LEFT_BOTH then
                SetVariable("GuardDamageIndex", 1)
            else
                SetVariable("GuardDamageIndex", 0)
            end

            act(SetDamageAnimType, DAMAGE_FLAG_GUARD_BREAK)
            ExecEventAllBody("W_Repelled_Wall")

            return TRUE
        elseif damage_type == DAMAGE_TYPE_WALL_LEFT then
            if style == HAND_LEFT_BOTH then
                SetVariable("GuardDamageIndex", 1)
            else
                SetVariable("GuardDamageIndex", 2)
            end

            act(SetDamageAnimType, DAMAGE_FLAG_GUARD_BREAK)
            ExecEventAllBody("W_Repelled_Wall")

            return TRUE
        elseif damage_type == DAMAGE_TYPE_GUARDBREAK_BLAST then
            act(SetDamageAnimType, DAMAGE_FLAG_SMALL_BLOW)
            ExecEventAllBody("W_DamageLv7_SmallBlow")

            return TRUE
        elseif damage_type == DAMAGE_TYPE_GUARDBREAK_FLING then
            act(SetDamageAnimType, DAMAGE_FLAG_FLING)
            ExecEventAllBody("W_DamageLv6_Fling")

            return TRUE
        end
    elseif damage_type == DAMAGE_TYPE_GUARD then
        if is_parry == TRUE or is_attackwhileguard == TRUE then
            return FALSE
        end
        if env(GetSpEffectID, 175) == TRUE then
            return FALSE
        end
        if env(GetSpEffectID, 176) == TRUE then
            return FALSE
        end

        local guardindex = GUARD_STYLE_DEFAULT

        if style == HAND_RIGHT then
            guardindex = env(GetGuardMotionCategory, HAND_LEFT)

            if GetEquipType(HAND_LEFT, WEAPON_CATEGORY_TORCH) == TRUE then
                SetVariable("IsTorchGuard", TRUE)
            else
                SetVariable("IsTorchGuard", FALSE)
            end

            if env(GetEquipWeaponCategory, HAND_LEFT) == WEAPON_CATEGORY_DUELING_SHIELD then
                guardindex = 3
            end
        elseif style == HAND_LEFT_BOTH then
            SetVariable("IsTorchGuard", FALSE)

            if env(GetStayAnimCategory) == 15 then
                guardindex = env(GetGuardMotionCategory, HAND_LEFT)
            end

            if env(GetEquipWeaponCategory, HAND_LEFT) == WEAPON_CATEGORY_DUELING_SHIELD then
                guardindex = 3
            end
        elseif style == HAND_RIGHT_BOTH then
            SetVariable("IsTorchGuard", FALSE)

            if env(GetStayAnimCategory) == 15 then
                guardindex = env(GetGuardMotionCategory, HAND_RIGHT)
            end

            if env(GetEquipWeaponCategory, HAND_RIGHT) == WEAPON_CATEGORY_DUELING_SHIELD then
                guardindex = 3
            end
        end

        SetVariable("IndexGuard", guardindex)

        local guard_damage_level = env(GetGuardLevelAction)

        if env(GetSpEffectID, 171) == TRUE and guard_damage_level < 3 then
            guard_damage_level = 3
        end

        if guard_damage_level > 0 then
            if guard_damage_level == 1 then
                act(SetDamageAnimType, DAMAGE_FLAG_GUARD_SMALL)
                if env(GetSpEffectID, 102001) == TRUE or env(GetSpEffectID, 102011) == TRUE or
                    env(GetSpEffectID, 102013) == TRUE or env(GetSpEffectID, 102015) == TRUE then
                    SetJustGuardSucceedEffect(1)
                    ExecEventAllBody("W_GuardDamageSmall_JustGuard")
                else
                    ExecEventAllBody("W_GuardDamageSmall")
                end
            elseif guard_damage_level == 3 then
                act(SetDamageAnimType, DAMAGE_FLAG_GUARD_LARGE)
                if env(GetSpEffectID, 102001) == TRUE or env(GetSpEffectID, 102011) == TRUE or
                    env(GetSpEffectID, 102013) == TRUE or env(GetSpEffectID, 102015) == TRUE then
                    SetJustGuardSucceedEffect(2)
                    ExecEventAllBody("W_GuardDamageMiddle_JustGuard")
                else
                    ExecEventAllBody("W_GuardDamageMiddle")
                end
            elseif guard_damage_level == 4 then
                act(SetDamageAnimType, DAMAGE_FLAG_GUARD_EXLARGE)
                if env(GetSpEffectID, 102001) == TRUE or env(GetSpEffectID, 102011) == TRUE or
                    env(GetSpEffectID, 102013) == TRUE or env(GetSpEffectID, 102015) == TRUE then
                    SetJustGuardSucceedEffect(2)
                    ExecEventAllBody("W_GuardDamageLarge_JustGuard")
                else
                    ExecEventAllBody("W_GuardDamageLarge")
                end
            else
                act(SetDamageAnimType, DAMAGE_FLAG_GUARD_LARGE)
                if env(GetSpEffectID, 102001) == TRUE or env(GetSpEffectID, 102011) == TRUE or
                    env(GetSpEffectID, 102013) == TRUE or env(GetSpEffectID, 102015) == TRUE then
                    SetJustGuardSucceedEffect(2)
                    ExecEventAllBody("W_GuardDamageMiddle_JustGuard")
                else
                    ExecEventAllBody("W_GuardDamageMiddle")
                end
            end

            return TRUE
        else
            if env(GetSpEffectID, 102001) == TRUE or env(GetSpEffectID, 102011) == TRUE or env(GetSpEffectID, 102013) ==
                TRUE or env(GetSpEffectID, 102015) == TRUE then
                SetJustGuardSucceedEffect(1)
                ExecAddDamage(damage_angle, attack_dir, damage_level, TRUE, is_damaged, TRUE)
            else
                ExecAddDamage(damage_angle, attack_dir, damage_level, TRUE, is_damaged, FALSE)
            end
            return FALSE
        end
    end

    if env(GetKnockbackDistance) < 0 then
        if damage_angle == DAMAGE_DIR_LEFT then
            damage_angle = DAMAGE_DIR_RIGHT
        elseif damage_angle == DAMAGE_DIR_RIGHT then
            damage_angle = DAMAGE_DIR_LEFT
        elseif damage_angle == DAMAGE_DIR_FRONT then
            damage_angle = DAMAGE_DIR_BACK
        elseif damage_angle == DAMAGE_DIR_BACK then
            damage_angle = DAMAGE_DIR_FRONT
        end
    end

    if env(GetSpEffectID, 89) == TRUE or env(GetSpEffectID, 100640) == TRUE then
        if damage_level == DAMAGE_LEVEL_EXLARGE then
            act(RequestAIJumpInterupt)
        elseif damage_level == DAMAGE_LEVEL_LARGE or damage_level == DAMAGE_LEVEL_PUSH or damage_level ==
            DAMAGE_LEVEL_FLING or damage_level == DAMAGE_LEVEL_SMALL_BLOW or damage_level == DAMAGE_LEVEL_UPPER or
            damage_level == DAMAGE_LEVEL_EX_BLAST or damage_level == DAMAGE_LEVEL_BREATH or env(GetIsWeakPoint) == TRUE then
            act(RequestAIJumpInterupt)
            damage_level = DAMAGE_LEVEL_SMALL_BLOW
        elseif damage_level == DAMAGE_LEVEL_MIDDLE or damage_level == DAMAGE_LEVEL_SMALL then
            CalcDamageCount()
            act(RequestAIJumpInterupt)
            hkbFireEvent("W_JumpDamage_Start")
            SetVariable("Int16Variable04", 0)
            act(SetDamageAnimType, 3)
            ResetRequest()
            return TRUE
        else
            damage_level = DAMAGE_LEVEL_NONE
        end
    end
    local height = env(GetFallHeight) / 100
    if env(IsFalling) == TRUE and env(GetBehaviorID, 10) == TRUE and height >= 10 then
        damage_level = DAMAGE_LEVEL_NONE
    end
    if env(GetIsWeakPoint) == TRUE and env(GetBehaviorID, 15) == FALSE then
        CalcDamageCount()
        SetVariable("DamageDirection", damage_angle)
        act(SetDamageAnimType, DAMAGE_FLAG_WEAK)
        ExecEventAllBody("W_DamageWeak")
        Replanning()

        return TRUE
    elseif damage_level == DAMAGE_LEVEL_NONE then
        ExecAddDamage(damage_angle, attack_dir, damage_level, FALSE, is_damaged, FALSE)

        return FALSE
    elseif damage_level == DAMAGE_LEVEL_SMALL then
        CalcDamageCount()
        SetVariable("DamageDirection", damage_angle)
        SetVariable("IndexDamageLv1_Small_AttackDirection", attack_dir)
        act(SetDamageAnimType, DAMAGE_FLAG_SMALL)
        ExecEventAllBody("W_DamageLv1_Small")
        Replanning()

        return TRUE
    elseif damage_level == DAMAGE_LEVEL_MIDDLE then
        CalcDamageCount()
        SetVariable("DamageDirection", damage_angle)
        SetVariable("IndexDamageLv2_Middle_AttackDirection", attack_dir)
        act(SetDamageAnimType, DAMAGE_FLAG_MEDIUM)
        ExecEventAllBody("W_DamageLv2_Middle")
        Replanning()

        return TRUE
    elseif damage_level == DAMAGE_LEVEL_LARGE then
        CalcDamageCount()
        SetVariable("DamageDirection", damage_angle)
        SetVariable("IndexDamageLv3_Large_AttackDirection", attack_dir)
        act(SetDamageAnimType, DAMAGE_FLAG_LARGE)
        Replanning()

        if env(GetBehaviorID, 3) == TRUE then
            ExecEventAllBody("W_DamageLarge2")
            return TRUE
        else
            ExecEventAllBody("W_DamageLv3_Large")
            return TRUE
        end
    elseif damage_level == DAMAGE_LEVEL_EXLARGE then
        ResetDamageCount()
        SetVariable("DamageDirection", damage_angle)
        act(SetDamageAnimType, DAMAGE_FLAG_LARGE_BLOW)
        ExecEventAllBody("W_DamageLv4_ExLarge")
        Replanning()

        return TRUE
    elseif damage_level == DAMAGE_LEVEL_EX_BLAST then
        ResetDamageCount()
        SetVariable("DamageDirection", damage_angle)
        act(SetDamageAnimType, DAMAGE_FLAG_LARGE_BLOW)
        ExecEventAllBody("W_DamageLV10_ExBlast")
        Replanning()

        return TRUE
    elseif damage_level == DAMAGE_LEVEL_PUSH then
        if env(GetBehaviorID, 14) == TRUE then
            act(AddSpEffect, 19865)
        end
        CalcDamageCount()
        SetVariable("DamageDirection", damage_angle)
        act(SetDamageAnimType, DAMAGE_FLAG_PUSH)
        ExecEventAllBody("W_DamageLv5_Push")
        Replanning()

        return TRUE
    elseif damage_level == DAMAGE_LEVEL_SMALL_BLOW then
        ResetDamageCount()
        SetVariable("DamageDirection", damage_angle)
        act(SetDamageAnimType, DAMAGE_FLAG_SMALL_BLOW)
        ExecEventAllBody("W_DamageLv7_SmallBlow")
        Replanning()

        return TRUE
    elseif damage_level == DAMAGE_LEVEL_UPPER then
        ResetDamageCount()
        SetVariable("DamageDirection", damage_angle)
        act(SetDamageAnimType, DAMAGE_FLAG_LARGE_BLOW)
        if env(GetBehaviorID, 10) == TRUE then
            SetVariable("DamageLv9_Behavior", 1)
        elseif env(GetBehaviorID, 13) == TRUE then
            SetVariable("DamageLv9_Behavior", 2)
        else
            SetVariable("DamageLv9_Behavior", 0)
        end
        ExecEventAllBody("W_DamageLv9_Upper")
        Replanning()

        return TRUE
    elseif damage_level == DAMAGE_LEVEL_MINIMUM then
        CalcDamageCount()

        local pre_index = GetVariable("IndexDamageLv8_Minimum_Random")
        local index = (pre_index + math.random(1, 2)) % 3

        SetVariable("IndexDamageLv8_Minimum_Random", index)
        act(SetDamageAnimType, DAMAGE_FLAG_MINIMUM)
        ExecEventAllBody("W_DamageLv8_Minimum")
        Replanning()

        return TRUE
    elseif damage_level == DAMAGE_LEVEL_FLING then
        ResetDamageCount()
        SetVariable("DamageDirection", damage_angle)
        act(SetDamageAnimType, DAMAGE_FLAG_FLING)
        ExecEventAllBody("W_DamageLv6_Fling")
        Replanning()

        return TRUE
    elseif damage_level == DAMAGE_LEVEL_BREATH then
        ResetDamageCount()
        SetVariable("DamageDirection", damage_angle)
        act(SetDamageAnimType, DAMAGE_FLAG_BREATH)
        ExecEventAllBody("W_DamageLv11_Breath")
        Replanning()

        return TRUE
    end
    return FALSE
end

----------------------
-- Common functions --
----------------------

function DamageCommonFunction(guardcondition, estep, fall_type)
    if ExecPassiveAction(FALSE, fall_type, FALSE) == TRUE then
        return TRUE
    end

    SetVariable("ToggleDash", 0)
    SetEnableAimMode()

    if c_SwordArtsID == 352 and (c_SwordArtsHand == HAND_LEFT or c_Style == HAND_RIGHT_BOTH) and
        env(GetSpEffectID, 102340) == TRUE and 0 < env(ActionDuration, ACTION_ARM_L2) then
        if c_Style == HAND_RIGHT_BOTH or c_Style == HAND_LEFT_BOTH then
            SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)
            ExecEventAllBody("W_SwordArtsBothGuardCounter")
            return TRUE
        else
            SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)
            ExecEventAllBody("W_SwordArtsLeftGuardCounter")
            return TRUE
        end
    end

    if ExecJump() == TRUE then
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, ALLBODY) == TRUE then
        ResetDamageCount()
        return TRUE
    end
    if ExecWeaponChange(ALLBODY) == TRUE then
        ResetDamageCount()
        return TRUE
    end

    local is_usechainrecover = GetVariable("UseChainRecover")

    if ExecEvasion(TRUE, estep, is_usechainrecover) == TRUE then
        return TRUE
    end
    if ExecItem(QUICKTYPE_NORMAL, ALLBODY) == TRUE then
        ResetDamageCount()
        return TRUE
    end
    if ExecMagic(QUICKTYPE_NORMAL, ALLBODY, FALSE) == TRUE then
        ResetDamageCount()
        return TRUE
    end
    if ExecArtsStanceOnCancelTiming(ALLBODY) == TRUE then
        ResetDamageCount()
        return TRUE
    end
    if ExecAttack("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", guardcondition, ALLBODY, FALSE, FALSE, FALSE) == TRUE then
        ResetDamageCount()
        return TRUE
    end
    if env(IsMoveCancelPossible) == TRUE then
        ResetDamageCount()
    end
    if ExecQuickTurnOnCancelTiming() == TRUE then
        return TRUE
    end
    if ExecGuardOnCancelTiming(guardcondition, ALLBODY) == TRUE then
        ResetDamageCount()
        return TRUE
    end
    if MoveStartonCancelTiming(Event_Move, FALSE) == TRUE then
        ResetDamageCount()
        return TRUE
    end
    return FALSE
end

--------------
-- Triggers --
--------------

function Damage_Activate()
    ActivateRightArmAdd(START_FRAME_NONE)
end

function Damage_Update()
    UpdateRightArmAdd()
end

function Damage_NoThrowDef_Update()
    if env(GetSpEffectID, 30) == FALSE and env(GetSpEffectID, 19970) == FALSE and env(GetSpEffectID, 19865) == FALSE then
        SetThrowDefInvalid()
    end
end

function DamageSABreak_onUpdate()
    if DamageCommonFunction(FALSE, ESTEP_NONE, FALL_TYPE_FORCE) == TRUE then
        return
    end
end

function DamageSleepResist_onUpdate()
    if DamageCommonFunction(FALSE, ESTEP_NONE, FALL_TYPE_FORCE) == TRUE then
        return
    end
end

function DamageMad_onUpdate()
    if DamageCommonFunction(FALSE, ESTEP_NONE, FALL_TYPE_FORCE) == TRUE then
        return
    end
end

function DamageBind_onActivate()
    ResetRequest()
end

function DamageBind_onUpdate()
    act(SetIsMagicInUse, 0)
    act(SetAllowedThrowDefenseType, 0)
    act(SetAllowedThrowAttackType, 0)

    if DamageCommonFunction(FALSE, ESTEP_NONE, FALL_TYPE_FORCE) == TRUE then
        return
    end
    if env(GetSpEffectType, 32) == FALSE then
        ExecEventAllBody("W_Idle")
    end
end

function DamageLv1_Small_onUpdate()
    act(SetMovementScaleMult, 0)
    if DamageCommonFunction(FALSE, ESTEP_NONE, FALL_TYPE_FORCE) == TRUE then
        return
    end
end

function DamageLv2_Middle_onUpdate()
    act(SetMovementScaleMult, 0)
    if DamageCommonFunction(FALSE, ESTEP_NONE, FALL_TYPE_FORCE) == TRUE then
        return
    end
end

function DamageLv3_Large_onUpdate()
    act(SetMovementScaleMult, 0)

    if DamageCommonFunction(FALSE, ESTEP_NONE, FALL_TYPE_FORCE) == TRUE then
        return
    end
end

function DamageLarge2_onUpdate()
    act(SetMovementScaleMult, 0)

    if DamageCommonFunction(FALSE, ESTEP_NONE, FALL_TYPE_FORCE) == TRUE then
        return
    end
end

function DamageWeak_onUpdate()
    if DamageCommonFunction(FALSE, ESTEP_NONE, FALL_TYPE_FORCE) == TRUE then
        return
    end
end

function DamageLv8_Minimum_onUpdate()
    if DamageCommonFunction(FALSE, ESTEP_NONE, FALL_TYPE_FORCE) == TRUE then
        return
    end
end

function DamageLv6_Fling_onUpdate()
    if DamageCommonFunction(FALSE, ESTEP_DOWN, FALL_TYPE_FACEDOWN_LOOP) == TRUE then
        return
    end
end

function DamageLv4_ExLarge_onUpdate()
    if DamageCommonFunction(FALSE, ESTEP_DOWN, FALL_TYPE_FORCE_LOOP) == TRUE then
        return
    end
end

function DamageLv5_Push_onUpdate()
    act(SetMovementScaleMult, 0)

    if DamageCommonFunction(FALSE, ESTEP_NONE, FALL_TYPE_FORCE) == TRUE then
        return
    end
end

function DamageLv7_SmallBlow_onUpdate()
    if DamageCommonFunction(FALSE, ESTEP_DOWN, FALL_TYPE_FORCE_LOOP) == TRUE then
        return
    end
end

function DamageLv9_Upper_onUpdate()
    if DamageCommonFunction(FALSE, ESTEP_DOWN, FALL_TYPE_FACEDOWN_LOOP) == TRUE then
        return
    end
end

function DamageLV10_ExBlast_onUpdate()
    if DamageCommonFunction(FALSE, ESTEP_DOWN, FALL_TYPE_FORCE_LOOP) == TRUE then
        return
    end
end

function DamageLv11_Breath_onUpdate()
    if DamageCommonFunction(FALSE, ESTEP_DOWN, FALL_TYPE_FORCE_LOOP) == TRUE then
        return
    end
end

function DamageParry_onUpdate()
    if DamageCommonFunction(FALSE, ESTEP_NONE, FALL_TYPE_DEFAULT) == TRUE then
        return
    end
end

function AddDamageDefault_onUpdate()
    SetVariable("AddDamageBlend", 0)
end

function AddDamageDefaultGuard_onUpdate()
    SetVariable("AddDamageGuardBlend", 0)
end

function DamageDirNoAdd_onUpdate()
    SetVariable("DamageDirBlendRate", 0)
end

function AddDamageLv0_Default_onUpdate()
    SetVariable("AddDamageLv0_Blend", 0)
end
