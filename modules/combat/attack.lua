
-- Submodules
load_module("modules/combat/arrow.lua")
load_module("modules/combat/damage.lua")
load_module("modules/combat/evasion.lua")
load_module("modules/combat/guard.lua")
load_module("modules/combat/jumpattack.lua")
load_module("modules/combat/swordarts.lua")
load_module("modules/combat/throw.lua")


function SetAttackQueue(r1, r2, l1, l2, b1, b2)
    g_r1 = r1
    g_r2 = r2
    g_l1 = l1
    g_l2 = l2
    g_b1 = b1
    g_b2 = b2
end

function ClearAttackQueue()
    g_r1 = "W_AttackRightLight1"
    g_r2 = "W_AttackRightHeavy1Start"
    g_l1 = "W_AttackLeftLight1"
    g_l2 = "W_AttackLeftHeavy1"
    g_b1 = "W_AttackBothLight1"
    g_b2 = "W_AttackBothHeavy1Start"
end

function SetRightSpecialHeavyAttackGeneratorTransitionIndex()
    -- NOT Ornamental Straight Sword
    if env(GetEquipWeaponSpecialCategoryNumber, HAND_RIGHT) ~= 852 then
        SetVariable("ArtsTransition", 0)
        return
    end

    local style = c_Style

    if style == HAND_RIGHT then
        local hand = HAND_LEFT

        if g_Magichand == HAND_LEFT then
            hand = HAND_RIGHT
        end

        local changetype = GetHandChangeType(hand)

        if changetype == WEAPON_CHANGE_REQUEST_LEFT_WAIST then
            SetVariable("ArtsTransition", 1)
        elseif changetype == WEAPON_CHANGE_REQUEST_LEFT_BACK then
            SetVariable("ArtsTransition", 2)
        elseif changetype == WEAPON_CHANGE_REQUEST_LEFT_SHOULDER then
            SetVariable("ArtsTransition", 3)
        elseif changetype == WEAPON_CHANGE_REQUEST_LEFT_SPEAR then
            SetVariable("ArtsTransition", 4)
        elseif changetype == WEAPON_CHANGE_REQUEST_RIGHT_WAIST then
            SetVariable("ArtsTransition", 5)
        elseif changetype == WEAPON_CHANGE_REQUEST_RIGHT_BACK then
            SetVariable("ArtsTransition", 6)
        elseif changetype == WEAPON_CHANGE_REQUEST_RIGHT_SHOULDER then
            SetVariable("ArtsTransition", 7)
        elseif changetype == WEAPON_CHANGE_REQUEST_RIGHT_SPEAR then
            SetVariable("ArtsTransition", 8)
        else
            SetVariable("ArtsTransition", 0)
        end
    else
        SetVariable("ArtsTransition", 9)
    end
end

function GetAttackRequest(is_guard)
    local style = c_Style
    local is_both = FALSE
    local is_both_right = FALSE

    if style >= HAND_LEFT_BOTH then
        is_both = TRUE
    end

    if style == HAND_RIGHT_BOTH then
        is_both_right = TRUE
    end

    local hand = HAND_RIGHT
    if style == HAND_LEFT_BOTH then
        hand = HAND_LEFT
    end

    local is_arrow = GetEquipType(hand, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_ARROW, WEAPON_CATEGORY_LARGE_ARROW)
    local is_crossbow = GetEquipType(hand, WEAPON_CATEGORY_CROSSBOW)
    local is_ballista = GetEquipType(hand, WEAPON_CATEGORY_BALLISTA)
    local is_staff = GetEquipType(hand, WEAPON_CATEGORY_STAFF)
    local request_r1 = env(ActionRequest, ACTION_ARM_R1)
    local request_r2 = env(ActionRequest, ACTION_ARM_R2)
    local request_l1 = env(ActionRequest, ACTION_ARM_L1)
    local request_l2 = env(ActionRequest, ACTION_ARM_L2)

    if env(ActionDuration, ACTION_ARM_ACTION) > 0 then
        request_r1 = FALSE
        request_r2 = FALSE
        request_l1 = FALSE
        request_l2 = FALSE
    end

    -- R2
    if request_r1 == TRUE and is_staff == FALSE or request_r2 == TRUE and is_staff == TRUE then
        if is_both == TRUE then
            if is_arrow == TRUE then
                g_ArrowSlot = 0
                act(ChooseBowAndArrowSlot, 0)

                if style == HAND_LEFT_BOTH then
                    return ATTACK_REQUEST_ARROW_FIRE_LEFT
                else
                    return ATTACK_REQUEST_ARROW_FIRE_RIGHT
                end
            elseif is_crossbow == TRUE or is_ballista == TRUE then
                g_ArrowSlot = 0
                act(ChooseBowAndArrowSlot, 0)

                return ATTACK_REQUEST_BOTHRIGHT_CROSSBOW
            else
                return ATTACK_REQUEST_BOTH_LIGHT
            end
        elseif is_guard == TRUE then
            local is_spear = GetEquipType(HAND_RIGHT, WEAPON_CATEGORY_SPEAR)
            local is_rapier = GetEquipType(HAND_RIGHT, WEAPON_CATEGORY_RAPIER)
            local is_large_spear = GetEquipType(HAND_RIGHT, WEAPON_CATEGORY_LARGE_SPEAR)
            local is_large_rapier = GetEquipType(HAND_RIGHT, WEAPON_CATEGORY_LARGE_RAPIER)

            -- Shield Poke
            if is_spear == TRUE or is_rapier == TRUE or is_large_spear == TRUE or is_large_rapier == TRUE then
                if env(ActionDuration, ACTION_ARM_L1) > 0 then
                    return ATTACK_REQUEST_ATTACK_WHILE_GUARD
                else
                    return ATTACK_REQUEST_RIGHT_LIGHT
                end
            else
                if is_arrow == TRUE or is_ballista == TRUE then
                    return ATTACK_REQUEST_ARROW_BOTH_RIGHT
                end

                if is_crossbow == TRUE then
                    g_ArrowSlot = 0
                    act(ChooseBowAndArrowSlot, 0)
                    return ATTACK_REQUEST_RIGHT_CROSSBOW
                end
                return ATTACK_REQUEST_RIGHT_LIGHT
            end
        else
            if is_arrow == TRUE or is_ballista == TRUE then
                return ATTACK_REQUEST_ARROW_BOTH_RIGHT
            end

            if is_crossbow == TRUE then
                g_ArrowSlot = 0
                act(ChooseBowAndArrowSlot, 0)

                return ATTACK_REQUEST_RIGHT_CROSSBOW
            end
            return ATTACK_REQUEST_RIGHT_LIGHT
        end
    end

    -- R2
    if request_r2 == TRUE then
        -- Bow / Greatbow
        if is_arrow == TRUE then
            if is_both == TRUE then
                g_ArrowSlot = 1
                act(ChooseBowAndArrowSlot, 1)
                if style == HAND_LEFT_BOTH then
                    return ATTACK_REQUEST_ARROW_FIRE_LEFT2
                else
                    return ATTACK_REQUEST_ARROW_FIRE_RIGHT2
                end
            else
                return ATTACK_REQUEST_ARROW_BOTH_RIGHT
            end
            -- Crossbow
        elseif is_crossbow == TRUE then
            if is_both == TRUE then
                g_ArrowSlot = 1
                act(ChooseBowAndArrowSlot, 1)
                return ATTACK_REQUEST_BOTHRIGHT_CROSSBOW2
            else
                g_ArrowSlot = 1
                act(ChooseBowAndArrowSlot, 1)

                return ATTACK_REQUEST_RIGHT_CROSSBOW2
            end
            -- Ballista
        elseif is_ballista == TRUE then
            if is_both == TRUE then
                g_ArrowSlot = 1
                act(ChooseBowAndArrowSlot, 1)

                return ATTACK_REQUEST_BOTHRIGHT_CROSSBOW2
            else
                return ATTACK_REQUEST_ARROW_BOTH_RIGHT
            end
            -- 2H Heavy
        else
            local sp_kind = env(GetEquipWeaponSpecialCategoryNumber, hand)
            if IsWeaponCatalyst(sp_kind) == TRUE then
                return ATTACK_REQUEST_INVALID
            end
            if is_both == TRUE then
                return ATTACK_REQUEST_BOTH_HEAVY
                -- R1 Heavy
            else
                return ATTACK_REQUEST_RIGHT_HEAVY
            end
        end
    end
    -- L1
    if request_l1 == TRUE then
        if env(IsPrecisionShoot) == TRUE then
            return ATTACK_REQUEST_INVALID
        end
        local is_shield_left = GetEquipType(HAND_LEFT, WEAPON_CATEGORY_SMALL_SHIELD, WEAPON_CATEGORY_MIDDLE_SHIELD,
            WEAPON_CATEGORY_LARGE_SHIELD, WEAPON_CATEGORY_TORCH)
        local is_shield_right = GetEquipType(HAND_RIGHT, WEAPON_CATEGORY_SMALL_SHIELD, WEAPON_CATEGORY_MIDDLE_SHIELD,
            WEAPON_CATEGORY_LARGE_SHIELD, WEAPON_CATEGORY_TORCH)
        local sp_kind = env(GetEquipWeaponSpecialCategoryNumber, hand)
        if is_both == TRUE and sp_kind == 249 then
            return ATTACK_REQUEST_BOTH_LEFT
        end
        if is_shield_left == TRUE then
            return ATTACK_REQUEST_INVALID
        end
        if is_shield_right == TRUE and is_both_right == TRUE then
            return ATTACK_REQUEST_INVALID
        end
        is_arrow = GetEquipType(HAND_LEFT, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_ARROW,
            WEAPON_CATEGORY_LARGE_ARROW, WEAPON_CATEGORY_BALLISTA)
        is_crossbow = GetEquipType(HAND_LEFT, WEAPON_CATEGORY_CROSSBOW)
        if is_arrow == TRUE then
            if is_both == FALSE then
                return ATTACK_REQUEST_ARROW_BOTH_LEFT
            else
                return ATTACK_REQUEST_INVALID
            end
        elseif is_crossbow == TRUE then
            if is_both == FALSE then
                g_ArrowSlot = 0
                act(ChooseBowAndArrowSlot, 0)
                return ATTACK_REQUEST_LEFT_CROSSBOW
            else
                return ATTACK_REQUEST_INVALID
            end
        end
        is_staff = GetEquipType(HAND_LEFT, WEAPON_CATEGORY_STAFF)
        if is_staff == TRUE then
            return ATTACK_REQUEST_INVALID
        end
        is_arrow = GetEquipType(HAND_RIGHT, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_ARROW,
            WEAPON_CATEGORY_LARGE_ARROW, WEAPON_CATEGORY_CROSSBOW, WEAPON_CATEGORY_BALLISTA)
        if is_arrow == TRUE and is_both == TRUE then
            return ATTACK_REQUEST_INVALID
        end
        is_crossbow = GetEquipType(HAND_RIGHT, WEAPON_CATEGORY_CROSSBOW)
        if is_crossbow == TRUE and is_both == TRUE then
            return ATTACK_REQUEST_INVALID
        end
        local isEnableDualWielding = IsEnableDualWielding()
        if isEnableDualWielding == HAND_RIGHT then
            return ATTACK_REQUEST_DUAL_RIGHT
        elseif isEnableDualWielding == HAND_LEFT then
            return ATTACK_REQUEST_DUAL_LEFT
        end
        if IsWeaponCanGuard() == TRUE then
            return ATTACK_REQUEST_INVALID
        end
        return ATTACK_REQUEST_LEFT_HEAVY
    end
    -- L2
    if request_l2 == TRUE then
        act(DebugLogOutput, "action request ACTION_ARM_L2")
        if is_both == FALSE then
            is_arrow = GetEquipType(HAND_LEFT, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_ARROW,
                WEAPON_CATEGORY_LARGE_ARROW, WEAPON_CATEGORY_BALLISTA)
            is_crossbow = GetEquipType(HAND_LEFT, WEAPON_CATEGORY_CROSSBOW)
            if is_arrow == TRUE then
                return ATTACK_REQUEST_ARROW_BOTH_LEFT
            elseif is_crossbow == TRUE then
                g_ArrowSlot = 1
                act(ChooseBowAndArrowSlot, 1)
                return ATTACK_REQUEST_LEFT_CROSSBOW2
            end
            local sp_kind = env(GetEquipWeaponSpecialCategoryNumber, HAND_LEFT)
            if IsWeaponCatalyst(sp_kind) == TRUE then
                return ATTACK_REQUEST_INVALID
            end
        end
        if c_SwordArtsID == 399 then
            if is_both == FALSE then
                return ATTACK_REQUEST_LEFT_HEAVY
            else
                return ATTACK_REQUEST_BOTH_LIGHT
            end
        end
        if c_IsEnableSwordArts == TRUE then
            local swordartrequest = GetSwordArtsRequestNew()
            local is_arrowright = GetEquipType(HAND_RIGHT, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_ARROW,
                WEAPON_CATEGORY_LARGE_ARROW, WEAPON_CATEGORY_BALLISTA)
            if swordartrequest == SWORDARTS_REQUEST_RIGHT_STANCE and is_arrowright == TRUE then
                if style ~= HAND_RIGHT_BOTH then
                    return ATTACK_REQUEST_ARROW_BOTH_RIGHT
                else
                    return swordartrequest
                end
            else
                return swordartrequest
            end
        elseif is_both == TRUE then
            if GetEquipType(hand, WEAPON_CATEGORY_STAFF) == TRUE then
                return ATTACK_REQUEST_BOTH_LIGHT
            else
                return ATTACK_REQUEST_BOTH_HEAVY
            end
        else
            return ATTACK_REQUEST_LEFT_HEAVY
        end
    end
    return ATTACK_REQUEST_INVALID
end

function ExecAttack(r1, r2, l1, l2, b1, b2, is_guard, blend_type, artsr1, artsr2, is_stealth_rolling)
    local cur_stamina = env(GetStamina)

    if cur_stamina <= 0 and GetVariable("StaminaComboResetTest") == 1 then
        g_ComboReset = TRUE
    end

    local request = GetAttackRequest(is_guard)

    if request == ATTACK_REQUEST_INVALID then
        return FALSE
    end

    act(DebugLogOutput, "ExecAttack request=" .. request)

    local style = c_Style
    local swordartpoint_hand = HAND_RIGHT
    local atk_hand = HAND_RIGHT
    local guard_hand = HAND_RIGHT
    local is_find_atk = TRUE

    if cur_stamina <= 0 then
        ResetRequest()
        return FALSE
    end

    local is_Dual = FALSE
    g_ComboReset = FALSE

    if c_Style == HAND_LEFT_BOTH then
        swordartpoint_hand = HAND_LEFT
    end

    act(SetDamageMotionBlendRatio, 0)

    if env(IsSpecialTransitionPossible) == TRUE then
        r1 = "W_AttackRightLight1"
        l1 = "W_AttackLeftLight1"
        b1 = "W_AttackBothLight1"

        -- 132 "[HKS] Recovery Window: Heavy Attack"
        -- Applied in TAE
        if env(GetSpEffectID, 132) == FALSE then
            r2 = "W_AttackRightHeavy1Start"
            l2 = "W_AttackLeftHeavy1"
            b2 = "W_AttackBothHeavy1Start"
        end
    end

    -- 133 "[HKS] Switch Heavy to Heavy Sub"
    -- Applied in TAE
    if env(GetSpEffectID, 133) == TRUE then
        if r2 == "W_AttackRightHeavy1Start" then
            r2 = "W_AttackRightHeavy1SubStart"
        end

        if b2 == "W_AttackBothHeavy1Start" then
            b2 = "W_AttackBothHeavy1SubStart"
        end
        -- 134 "[HKS] Switch Heavy Sub to Heavy"
        -- Applied in TAE
    elseif env(GetSpEffectID, 134) == TRUE then
        if r2 == "W_AttackRightHeavy1SubStart" then
            r2 = "W_AttackRightHeavy1Start"
        end

        if b2 == "W_AttackBothHeavy1SubStart" then
            b2 = "W_AttackBothHeavy1Start"
        end
    end

    local isAfterAdditiveJustGuard = FALSE
    if IsNodeActive("Guard_Upper LayerGenerator") == TRUE and env(GetSpEffectID, 102020) == TRUE then
        isAfterAdditiveJustGuard = TRUE
    end

    -- 173 "[HKS] Guard Counter: End"
    -- 174 "[HKS] Guard Counter: Window"
    if env(GetSpEffectID, 173) == TRUE or env(GetSpEffectID, 174) == TRUE or isAfterAdditiveJustGuard == TRUE then
        if c_Style == HAND_RIGHT_BOTH then
            atk_hand = HAND_RIGHT
            guard_hand = HAND_RIGHT
        elseif c_Style == HAND_LEFT_BOTH then
            atk_hand = HAND_LEFT
            guard_hand = HAND_LEFT
        end

        -- Guard Counter Window
        -- If the player is holding a valid weapon, and has pressed R2, play Guard Counter anim
        if GetEquipType(atk_hand, WEAPON_CATEGORY_STAFF, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_ARROW,
            WEAPON_CATEGORY_LARGE_ARROW, WEAPON_CATEGORY_CROSSBOW, WEAPON_CATEGORY_BALLISTA) == FALSE and
            env(ActionRequest, ACTION_ARM_R2) == TRUE then
            if c_Style == HAND_RIGHT_BOTH or c_Style == HAND_LEFT_BOTH then
                ExecEventAllBody("W_AttackBothHeavyCounter")
            else
                ExecEventAllBody("W_AttackRightHeavyCounter")
            end

            return TRUE
        end
        -- Otherwise, if in Guard Counter Window, mulch the request
        if env(GetSpEffectID, 174) == TRUE then
            return FALSE
        end
    end

    -- 100630 "[HKS] Throw related"
    if env(GetSpEffectID, 100630) == TRUE and ExecFallAttack() == TRUE then
        return TRUE
    end
    if request == ATTACK_REQUEST_RIGHT_LIGHT then
        if artsr1 == TRUE then
            SetSwordArtsPointInfo(ACTION_ARM_R1, TRUE, r1)

            if r1 == "W_DrawStanceRightAttackLight" then
                SetSwordArtsWepCategory_DrawStanceRightAttackLight()
            end
        end

        if c_SwordArtsID == 318 then
            if r1 == "W_SwordArtsOneShotComboEnd_MesmerSowrdArts" then
                SetSwordArtsPointInfo(ACTION_ARM_R1, TRUE)
            elseif r1 == "W_SwordArtsOneShotComboEnd_2" then
                SetSwordArtsPointInfo(ACTION_ARM_R1, TRUE)
                local val = GetVariable("IsEnoughArtPointsR1")
                SetVariable("IsEnoughArtPointsR2", val)
            end
        end

        --- 135 "[HKS] Light Sub Start Type 0"
        --- 136 "[HKS] Light Sub Start Type 1"
        --- 137 "[HKS] Light Sub Start Type 2"
        --- 138 "[HKS] Light Sub Start Type 3"
        if r1 == "W_AttackRightLightSubStart" then
            if env(GetSpEffectID, 135) == TRUE then
                SetVariable("AttackLightSubStartType", 0)
            elseif env(GetSpEffectID, 136) == TRUE then
                SetVariable("AttackLightSubStartType", 1)
            elseif env(GetSpEffectID, 137) == TRUE then
                SetVariable("AttackLightSubStartType", 2)
            elseif env(GetSpEffectID, 138) == TRUE then
                SetVariable("AttackLightSubStartType", 3)
            else
                r1 = "W_AttackRightLight2"
            end
        end

        if r1 == "W_AttackRightLightStealth" and IsUseStealthAttack(FALSE) == FALSE then
            r1 = "W_AttackRightLightStep"
        end

        if GetEquipType(HAND_RIGHT, WEAPON_CATEGORY_STAFF) == TRUE and r1 ~= "W_AttackRightLight2" and r1 ~=
            "W_AttackRightLight3" then
            r1 = "W_AttackRightLight1"
        end

        if env(GetSpEffectID, 19903) == TRUE then
            r1 = "W_AttackRightLight3"
        elseif env(GetSpEffectID, 19904) == TRUE then
            r1 = "W_AttackRightLight4"
        end
        if env(GetSpEffectID, 19915) == TRUE then
            r1 = "W_AttackRightLight2"
        end
        ExecEventAllBody(r1)

    elseif request == ATTACK_REQUEST_RIGHT_HEAVY then
        if (c_SwordArtsID == 313 or c_SwordArtsID == 273) and
            (r2 == "W_SwordArtsOneShotComboEnd" or r2 == "W_SwordArtsOneShotComboEnd_2") then
            artsr2 = TRUE
            SetVariable("SwordArtsOneShotComboCategory", 0)
        end

        if artsr2 == TRUE then
            SetSwordArtsPointInfo(ACTION_ARM_R2, TRUE, r2)
        end

        local IsEnableSpecialAttack = FALSE

        -- Barbaric Roar: Heavy Special
        if env(GetSpEffectID, 1681) == TRUE or env(GetSpEffectID, 1686) == TRUE then
            IsEnableSpecialAttack = TRUE
            SetVariable("AttackRightHeavySpecialType", 0)
        end

        -- War Cry: Heavy Special
        if env(GetSpEffectID, 1811) == TRUE or env(GetSpEffectID, 1816) == TRUE then
            IsEnableSpecialAttack = TRUE
            SetVariable("AttackRightHeavySpecialType", 1)
        end

        -- Unknown: Heavy Special
        if env(GetSpEffectID, 1716) == TRUE then
            IsEnableSpecialAttack = TRUE
            SetVariable("AttackRightHeavySpecialType", 0)
        end

        -- Unknown: Heavy Special
        if env(GetSpEffectID, 1721) == TRUE then
            IsEnableSpecialAttack = TRUE
            SetVariable("AttackRightHeavySpecialType", 0)
        end

        -- Unknown (DLC): Heavy Special
        if env(GetSpEffectID, 102101) == TRUE then
            IsEnableSpecialAttack = TRUE
            SetVariable("AttackRightHeavySpecialType", 0)
        end

        if IsEnableSpecialAttack == TRUE then
            if r2 == "W_AttackRightHeavy1Start" then
                r2 = "W_AttackRightHeavySpecial1Start"
            elseif r2 == "W_AttackRightHeavy1SubStart" then
                r2 = "W_AttackRightHeavySpecial1SubStart"
            elseif r2 == "W_AttackRightHeavy2Start" then
                r2 = "W_AttackRightHeavySpecial2Start"
            end
        end

        if env(GetSpEffectID, 1681) == FALSE and env(GetSpEffectID, 1686) == FALSE and env(GetSpEffectID, 1811) == FALSE and
            env(GetSpEffectID, 1816) == FALSE and env(GetSpEffectID, 19912) == TRUE then
            r2 = "W_AttackRightHeavy2Start"
        end

        ExecEventAllBody(r2)
    elseif request == ATTACK_REQUEST_LEFT_LIGHT then
        atk_hand = HAND_LEFT
        guard_hand = HAND_LEFT
        ExecEventAllBody(l1)
    elseif request == ATTACK_REQUEST_LEFT_HEAVY then
        atk_hand = HAND_LEFT
        guard_hand = HAND_LEFT
        ExecEventAllBody(l2)
    elseif request == ATTACK_REQUEST_BOTH_LIGHT then
        if c_SwordArtsID == 318 and r1 == "W_SwordArtsOneShotComboEnd_MesmerSowrdArts" then
            artsr1 = TRUE
        end
        if artsr1 == TRUE then
            SetSwordArtsPointInfo(ACTION_ARM_R1, TRUE, b1)
            if b1 == "W_DrawStanceRightAttackLight" then
                SetSwordArtsWepCategory_DrawStanceRightAttackLight()
            end
        end

        --- 135 "[HKS] Light Sub Start Type 0"
        --- 136 "[HKS] Light Sub Start Type 1"
        --- 137 "[HKS] Light Sub Start Type 2"
        --- 138 "[HKS] Light Sub Start Type 3"
        if b1 == "W_AttackBothLightSubStart" then
            if env(GetSpEffectID, 135) == TRUE then
                SetVariable("AttackLightSubStartType", 0)
            elseif env(GetSpEffectID, 136) == TRUE then
                SetVariable("AttackLightSubStartType", 1)
            elseif env(GetSpEffectID, 137) == TRUE then
                SetVariable("AttackLightSubStartType", 2)
            elseif env(GetSpEffectID, 138) == TRUE then
                SetVariable("AttackLightSubStartType", 3)
            else
                b1 = "W_AttackBothLight2"
            end
        end

        if b1 == "W_AttackBothLightStealth" and IsUseStealthAttack(FALSE) == FALSE then
            b1 = "W_AttackBothLightStep"
        end

        local staff_hand = HAND_RIGHT

        if c_Style == HAND_LEFT_BOTH then
            staff_hand = HAND_LEFT
        end

        if GetEquipType(staff_hand, WEAPON_CATEGORY_STAFF) == TRUE and b1 ~= "W_AttackBothLight2" and b1 ~=
            "W_AttackBothLight3" then
            b1 = "W_AttackBothLight1"
        end

        if env(GetSpEffectID, 19903) == TRUE then
            b1 = "W_AttackBothLight3"
        elseif env(GetSpEffectID, 19904) == TRUE then
            b1 = "W_AttackBothLight4"
        end

        if env(GetSpEffectID, 19915) == TRUE then
            b1 = "W_AttackBothLight2"
        end

        if style == HAND_RIGHT_BOTH then
            atk_hand = HAND_RIGHT
        elseif style == HAND_LEFT_BOTH then
            atk_hand = HAND_LEFT
        end

        if env(GetEquipWeaponCategory, atk_hand) == WEAPON_CATEGORY_DUELING_SHIELD then
            guard_hand = atk_hand
            if is_guard == TRUE and env(ActionDuration, ACTION_ARM_L1) > 0 then
                b1 = "W_AttackBothLightGuard"
            end
        end

        ExecEventAllBody(b1)
    elseif request == ATTACK_REQUEST_BOTH_LEFT then
        if l1 ~= "W_AttackBothLeftSpecial2" and l1 ~= "W_AttackBothLeftSpecial3" and l1 ~= "W_AttackBothLeftSpecial4" and
            l1 ~= "W_AttackBothLeftSpecial5" then
            l1 = "W_AttackBothLeftSpecial1"
        end

        ExecEventAllBody(l1)
    elseif request == ATTACK_REQUEST_BOTH_HEAVY then
        -- DLC 1.13.1: Dynastic Sickleplay, Raging Beast
        if (c_SwordArtsID == 313 or c_SwordArtsID == 273) and
            (r2 == "W_SwordArtsOneShotComboEnd" or r2 == "W_SwordArtsOneShotComboEnd_2") then
            artsr2 = TRUE
            SetVariable("SwordArtsOneShotComboCategory", 0)
        end

        if artsr2 == TRUE then
            SetSwordArtsPointInfo(ACTION_ARM_R2, TRUE, b2)
        end

        local IsEnableSpecialAttack = FALSE

        -- Barbaric Roar: Heavy Special
        if c_Style == HAND_RIGHT_BOTH then
            if env(GetSpEffectID, 1681) == TRUE or env(GetSpEffectID, 1686) == TRUE then
                IsEnableSpecialAttack = TRUE
                SetVariable("AttackRightHeavySpecialType", 0)
            end
        elseif c_Style == HAND_LEFT_BOTH and (env(GetSpEffectID, 1683) == TRUE or env(GetSpEffectID, 1688) == TRUE) then
            IsEnableSpecialAttack = TRUE
            SetVariable("AttackRightHeavySpecialType", 0)
        end

        -- War Cry: Heavy Special
        if c_Style == HAND_RIGHT_BOTH then
            if env(GetSpEffectID, 1811) == TRUE or env(GetSpEffectID, 1816) == TRUE or env(GetSpEffectID, 1861) == TRUE then
                IsEnableSpecialAttack = TRUE
                SetVariable("AttackRightHeavySpecialType", 1)
            end
        elseif c_Style == HAND_LEFT_BOTH and
            (env(GetSpEffectID, 1813) == TRUE or env(GetSpEffectID, 1818) == TRUE or env(GetSpEffectID, 1863) == TRUE) then
            IsEnableSpecialAttack = TRUE
            SetVariable("AttackRightHeavySpecialType", 1)
        end

        -- Unknown: Heavy Special
        if c_Style == HAND_RIGHT_BOTH then
            if env(GetSpEffectID, 1716) == TRUE then
                IsEnableSpecialAttack = TRUE
                SetVariable("AttackRightHeavySpecialType", 0)
            end
        elseif c_Style == HAND_LEFT_BOTH and env(GetSpEffectID, 1718) == TRUE then
            IsEnableSpecialAttack = TRUE
            SetVariable("AttackRightHeavySpecialType", 0)
        end

        -- Unknown: Heavy Special
        if c_Style == HAND_RIGHT_BOTH then
            if env(GetSpEffectID, 1721) == TRUE then
                IsEnableSpecialAttack = TRUE
                SetVariable("AttackRightHeavySpecialType", 0)
            end
        elseif c_Style == HAND_LEFT_BOTH and env(GetSpEffectID, 1723) == TRUE then
            IsEnableSpecialAttack = TRUE
            SetVariable("AttackRightHeavySpecialType", 0)
        end

        if c_Style == HAND_RIGHT_BOTH then
            if env(GetSpEffectID, 102101) == TRUE then
                IsEnableSpecialAttack = TRUE
                SetVariable("AttackRightHeavySpecialType", 0)
            end
        elseif c_Style == HAND_LEFT_BOTH and env(GetSpEffectID, 102106) == TRUE then
            IsEnableSpecialAttack = TRUE
            SetVariable("AttackRightHeavySpecialType", 0)
        end

        if IsEnableSpecialAttack == TRUE then
            if b2 == "W_AttackBothHeavy1Start" then
                b2 = "W_AttackBothHeavySpecial1Start"
            elseif b2 == "W_AttackBothHeavy1SubStart" then
                b2 = "W_AttackBothHeavySpecial1SubStart"
            elseif b2 == "W_AttackBothHeavy2Start" then
                b2 = "W_AttackBothHeavySpecial2Start"
            end
        end

        if env(GetSpEffectID, 1681) == FALSE and env(GetSpEffectID, 1686) == FALSE and env(GetSpEffectID, 1811) == FALSE and
            env(GetSpEffectID, 1816) == FALSE and env(GetSpEffectID, 19912) == TRUE then
            b2 = "W_AttackBothHeavy2Start"
        end
        if style == HAND_RIGHT_BOTH then
            atk_hand = HAND_RIGHT
        elseif style == HAND_LEFT_BOTH then
            atk_hand = HAND_LEFT
        end
        if env(GetEquipWeaponCategory, atk_hand) == WEAPON_CATEGORY_DUELING_SHIELD then
            guard_hand = atk_hand
        end

        ExecEventAllBody(b2)
    elseif request == ATTACK_REQUEST_DUAL_RIGHT then
        if r1 == "W_AttackRightLightDash" then
            l1 = "W_AttackDualDash"
        elseif r1 == "W_AttackRightLightStep" then
            l1 = "W_AttackDualRolling"
        elseif r1 == "W_AttackRightBackstep" then
            l1 = "W_AttackDualBackStep"
        elseif r1 == "W_AttackRightLightStealth" then
            if IsUseStealthAttack(TRUE) == FALSE then
                l1 = "W_AttackDualRolling"
            else
                l1 = "W_AttackDualStealth"
            end
        elseif l1 == "W_AttackLeftLight1" then
            l1 = "W_AttackDualLight1"
        elseif l1 == "W_AttackLeftLight2" then
            l1 = "W_AttackDualLight2"
        elseif l1 == "W_AttackLeftLight3" then
            l1 = "W_AttackDualLight3"
        elseif l1 == "W_AttackLeftLight4" then
            l1 = "W_AttackDualLight4"
        elseif l1 == "W_AttackLeftLight5" then
            l1 = "W_AttackDualLight5"
        elseif l1 == "W_AttackLeftLight6" then
            l1 = "W_AttackDualLight6"
        elseif l1 == "W_AttackDualLightSubStart" then
            l1 = "W_AttackDualLightSubStart"
        else
            l1 = "W_AttackDualLight1"
        end

        if env(GetSpEffectID, 19903) == TRUE then
            l1 = "W_AttackDualLight3"
        elseif env(GetSpEffectID, 19904) == TRUE then
            l1 = "W_AttackDualLight4"
        end

        if l1 == "W_AttackDualLightSubStart" then
            if env(GetSpEffectID, 135) == TRUE then
                SetVariable("AttackLightSubStartType", 0)
            else
                l1 = "W_AttackDualLight2"
            end
        end

        is_Dual = TRUE
        ExecEventAllBody(l1)
    elseif request == ATTACK_REQUEST_ARROW_BOTH_RIGHT then
        if c_Style ~= HAND_RIGHT_BOTH and c_Style ~= HAND_LEFT_BOTH and ExecHandChange(HAND_RIGHT, TRUE, blend_type) ==
            TRUE then
            return TRUE
        end
        return FALSE
    elseif request == ATTACK_REQUEST_ARROW_BOTH_LEFT then
        if c_Style ~= HAND_RIGHT_BOTH and c_Style ~= HAND_LEFT_BOTH and ExecHandChange(HAND_LEFT, TRUE, blend_type) ==
            TRUE then
            return TRUE
        end
        return FALSE
    elseif request == ATTACK_REQUEST_LEFT_REVERSAL then
        ExecEventAllBody("W_AttackLeftReversal")
    elseif request == SWORDARTS_REQUEST_LEFT_NORMAL then
        SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)
        atk_hand = HAND_LEFT
        guard_hand = HAND_LEFT

        if IsAttackSwordArts(c_SwordArtsID) == FALSE then
            is_find_atk = FALSE
        end

        local idle_cat = env(GetStayAnimCategory)
        local wep_cat = env(GetEquipWeaponCategory, c_SwordArtsHand)
        local arts_cat = GetSwordArtsDiffCategory(c_SwordArtsID, idle_cat, wep_cat)
        local arts_idx = 0

        if arts_cat == SWORD_ART_DIFF_CAT_LARGE_WEAPON then
            arts_idx = 1
        elseif arts_cat == SWORD_ART_DIFF_CAT_POLEARM then
            arts_idx = 2
        elseif arts_cat == SWORD_ART_DIFF_CAT_LARGE_WEAPON_SMALL_SHIELD then
            arts_idx = 3
        elseif arts_cat == SWORD_ART_DIFF_CAT_POLEARM_SMALL_SHIELD then
            arts_idx = 4
        elseif arts_cat == SWORD_ART_DIFF_CAT_LARGE_WEAPON_LARGE_SHIELD then
            arts_idx = 5
        elseif arts_cat == SWORD_ART_DIFF_CAT_POLEARM_LARGE_SHIELD then
            arts_idx = 6
        elseif arts_cat == WEAPON_CATEGORY_SHORT_SWORD then
            arts_idx = 7
        elseif arts_cat == WEAPON_CATEGORY_CURVEDSWORD then
            arts_idx = 8
        elseif arts_cat == WEAPON_CATEGORY_LARGE_SHIELD then
            arts_idx = 9
        elseif arts_cat == WEAPON_CATEGORY_SMALL_SHIELD then
            arts_idx = 10
        elseif arts_cat == WEAPON_CATEGORY_DUELING_SHIELD then
            arts_idx = 11
        end

        SetVariable("SwordArtsOneShotShieldCategory", arts_idx)

        -- Torch Attack
        if c_SwordArtsID == 17 then
            SetVariable("SwordArtsOneShotComboCategory", 0)
        end

        if IsHalfBlendArts(c_SwordArtsID) == TRUE then
            ExecEventHalfBlend(Event_SwordArtsHalfOneShotShieldLeft, blend_type)
        else
            ExecEventAllBody("W_SwordArtsOneShotShieldLeft")
        end
    elseif request == SWORDARTS_REQUEST_BOTH_NORMAL then
        SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)

        if IsAttackSwordArts(c_SwordArtsID) == FALSE then
            is_find_atk = FALSE
        end

        local idle_cat = env(GetStayAnimCategory)
        local wep_cat = env(GetEquipWeaponCategory, c_SwordArtsHand)
        local arts_cat = GetSwordArtsDiffCategory(c_SwordArtsID, idle_cat, wep_cat)

        if IsHalfBlendArts(c_SwordArtsID) == TRUE and c_SwordArtsID ~= 334 and c_SwordArtsID ~= 354 and c_SwordArtsID ~=
            355 then
            if c_SwordArtsHand == HAND_LEFT then
                local arts_idx = 0

                if arts_cat == SWORD_ART_DIFF_CAT_LARGE_WEAPON then
                    arts_idx = 1
                elseif arts_cat == SWORD_ART_DIFF_CAT_POLEARM then
                    arts_idx = 2
                elseif arts_cat == SWORD_ART_DIFF_CAT_LARGE_WEAPON_SMALL_SHIELD then
                    arts_idx = 3
                elseif arts_cat == SWORD_ART_DIFF_CAT_POLEARM_SMALL_SHIELD then
                    arts_idx = 4
                elseif arts_cat == SWORD_ART_DIFF_CAT_LARGE_WEAPON_LARGE_SHIELD then
                    arts_idx = 5
                elseif arts_cat == SWORD_ART_DIFF_CAT_POLEARM_LARGE_SHIELD then
                    arts_idx = 6
                elseif arts_cat == WEAPON_CATEGORY_SHORT_SWORD then
                    arts_idx = 7
                elseif arts_cat == WEAPON_CATEGORY_CURVEDSWORD then
                    arts_idx = 8
                elseif arts_cat == WEAPON_CATEGORY_LARGE_SHIELD then
                    arts_idx = 9
                elseif arts_cat == WEAPON_CATEGORY_SMALL_SHIELD then
                    arts_idx = 10
                elseif arts_cat == WEAPON_CATEGORY_DUELING_SHIELD then
                    arts_idx = 11
                end

                SetVariable("SwordArtsOneShotShieldCategory", arts_idx)
                ExecEventHalfBlend(Event_SwordArtsHalfOneShotShieldLeft, blend_type)
            else
                local arts_idx = 0

                if arts_cat == SWORD_ART_DIFF_CAT_LARGE_WEAPON then
                    arts_idx = 1
                elseif arts_cat == SWORD_ART_DIFF_CAT_POLEARM then
                    arts_idx = 2
                elseif arts_cat == WEAPON_CATEGORY_SHORT_SWORD or arts_cat == WEAPON_CATEGORY_THROW_DAGGER then
                    arts_idx = 3
                elseif arts_cat == WEAPON_CATEGORY_TWINBLADE then
                    arts_idx = 4
                elseif arts_cat == WEAPON_CATEGORY_CURVEDSWORD then
                    arts_idx = 5
                elseif arts_cat == WEAPON_CATEGORY_FIST or arts_cat == WEAPON_CATEGORY_MARTIAL_ARTS or arts_cat ==
                    WEAPON_CATEGORY_PERFUME_BOTTLE or arts_cat == WEAPON_CATEGORY_BEAST_CLAW then
                    arts_idx = 6
                elseif arts_cat == WEAPON_CATEGORY_LARGE_SHIELD then
                    arts_idx = 7
                elseif arts_cat == WEAPON_CATEGORY_SMALL_SHIELD then
                    arts_idx = 8
                elseif arts_cat == WEAPON_CATEGORY_BACKHAND_SWORD then
                    arts_idx = 9
                elseif arts_cat == WEAPON_CATEGORY_DUELING_SHIELD then
                    arts_idx = 10
                end

                SetVariable("SwordArtsOneShotCategory", arts_idx)
                ExecEventHalfBlend(Event_SwordArtsHalfOneShot, blend_type)
            end
        else
            local arts_idx = 0

            if arts_cat == WEAPON_CATEGORY_SHORT_SWORD then
                arts_idx = 1
            elseif arts_cat == WEAPON_CATEGORY_CURVEDSWORD then
                arts_idx = 2
            elseif arts_cat == WEAPON_CATEGORY_LARGE_SHIELD then
                arts_idx = 3
            elseif arts_cat == WEAPON_CATEGORY_SMALL_SHIELD then
                arts_idx = 4
            elseif arts_cat == WEAPON_CATEGORY_DUELING_SHIELD then
                arts_idx = 5
            end

            SetVariable("SwordArtsOneShotShieldCategory", arts_idx)
            if IsHalfBlendArts(c_SwordArtsID) == TRUE then
                ExecEventHalfBlend(Event_SwordArtsHalfOneShotShieldBoth, blend_type)
            else
                ExecEventAllBody("W_SwordArtsOneShotShieldBoth")
            end
        end
    elseif request == SWORDARTS_REQUEST_RIGHT_NORMAL then
        SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)

        if IsAttackSwordArts(c_SwordArtsID) == FALSE then
            is_find_atk = FALSE
        end

        local idle_cat = env(GetStayAnimCategory)
        local wep_cat = env(GetEquipWeaponCategory, c_SwordArtsHand)
        local arts_cat = GetSwordArtsDiffCategory(c_SwordArtsID, idle_cat, wep_cat)
        local arts_idx = 0

        if arts_cat == SWORD_ART_DIFF_CAT_LARGE_WEAPON or arts_cat == WEAPON_CATEGORY_LARGE_KATANA then
            arts_idx = 1
        elseif arts_cat == SWORD_ART_DIFF_CAT_POLEARM then
            arts_idx = 2
        elseif arts_cat == WEAPON_CATEGORY_SHORT_SWORD or arts_cat == WEAPON_CATEGORY_THROW_DAGGER then
            arts_idx = 3
        elseif arts_cat == WEAPON_CATEGORY_TWINBLADE then
            arts_idx = 4
        elseif arts_cat == WEAPON_CATEGORY_CURVEDSWORD then
            arts_idx = 5
        elseif arts_cat == WEAPON_CATEGORY_FIST or arts_cat == WEAPON_CATEGORY_MARTIAL_ARTS or arts_cat ==
            WEAPON_CATEGORY_PERFUME_BOTTLE or arts_cat == WEAPON_CATEGORY_BEAST_CLAW then
            arts_idx = 6
        elseif arts_cat == WEAPON_CATEGORY_LARGE_SHIELD then
            arts_idx = 7
        elseif arts_cat == WEAPON_CATEGORY_SMALL_SHIELD then
            arts_idx = 8
        elseif arts_cat == WEAPON_CATEGORY_BACKHAND_SWORD then
            arts_idx = 9
        elseif arts_cat == WEAPON_CATEGORY_DUELING_SHIELD then
            arts_idx = 10
        elseif c_SwordArtsID == 328 and env(GetSpEffectID, 19875) == TRUE and GetVariable("IsEnoughArtPointsL2") == 0 then
            arts_idx = 12
        elseif c_SwordArtsID == 328 and env(GetSpEffectID, 19874) == TRUE and GetVariable("IsEnoughArtPointsL2") == 0 then
            arts_idx = 11
        end

        SetVariable("SwordArtsOneShotCategory", arts_idx)
        local combo_idx = 0

        if arts_cat == SWORD_ART_DIFF_CAT_LARGE_WEAPON then
            combo_idx = 1
        elseif arts_cat == SWORD_ART_DIFF_CAT_POLEARM then
            combo_idx = 2
        elseif arts_cat == WEAPON_CATEGORY_TWINBLADE then
            combo_idx = 3
        elseif arts_cat == WEAPON_CATEGORY_CURVEDSWORD or arts_cat == WEAPON_CATEGORY_MARTIAL_ARTS or arts_cat ==
            WEAPON_CATEGORY_BEAST_CLAW then
            combo_idx = 4
        elseif arts_cat == WEAPON_CATEGORY_BACKHAND_SWORD then
            combo_idx = 5
        elseif arts_cat == WEAPON_CATEGORY_DUELING_SHIELD then
            combo_idx = 6
        end

        SetVariable("SwordArtsOneShotComboCategory", combo_idx)
        SetVariable("SwordArtsSubCategory", 0)

        if c_SwordArtsID == 261 then
            if env(GetSpEffectID, 102355) == TRUE then
                SetVariable("SwordArtsSubCategory", 0)
                ExecEventAllBody("W_SwordArtsOneShot_Sub")
            elseif env(GetSpEffectID, 102356) == TRUE then
                SetVariable("SwordArtsSubCategory", 1)
                ExecEventAllBody("W_SwordArtsOneShot_Sub")
            else
                ExecEventAllBody("W_SwordArtsOneShot")
            end
        elseif IsHalfBlendArts(c_SwordArtsID) == TRUE then
            ExecEventHalfBlend(Event_SwordArtsHalfOneShot, blend_type)
        else
            ExecEventAllBody("W_SwordArtsOneShot")
        end
    elseif request == SWORDARTS_REQUEST_RIGHT_STEP then
        act(DebugLogOutput, "SwordArtsRolling request" .. request)

        if IsAttackSwordArts(c_SwordArtsID) == FALSE then
            is_find_atk = FALSE
        end

        local rollingAngle = c_ArtsRollingAngle

        if GetVariable("MoveSpeedLevel") > 0.20000000298023224 then
            rollingAngle = GetVariable("MoveAngle")
        end

        local turn_target_angle = 0
        local rollingDirection = 0
        local turn_angle_real = 200
        local is_self_trans = FALSE
        local is_self_trans_2 = FALSE
        local arts_id = c_SwordArtsID
        if IsNodeActive("SwordArtsRolling Selector MP") == TRUE or
            IsNodeActive("SwordArtsRolling Selector MP_SelfTrans2") == TRUE then
            is_self_trans = TRUE
        elseif (arts_id == 155 or arts_id == 156) and
            (IsNodeActive("SwordArtsRolling Selector MP_SelfTrans") == TRUE or env(GetSpEffectID, 100710) == TRUE) then
            is_self_trans_2 = TRUE
        end

        if GetVariable("IsLockon") == false and env(IsPrecisionShoot) == FALSE and env(IsCOMPlayer) == FALSE or
            env(GetSpEffectID, 100002) == TRUE then
            rollingDirection = 0
        else
            if rollingAngle <= GetVariable("RollingAngleThresholdRightFrontTest") and rollingAngle >=
                GetVariable("RollingAngleThresholdLeftFrontTest") then
                rollingDirection = 0
                turn_target_angle = rollingAngle
            elseif rollingAngle > GetVariable("RollingAngleThresholdRightFrontTest") and rollingAngle <
                GetVariable("RollingAngleThresholdRightBackTest") then
                rollingDirection = 3
                turn_target_angle = rollingAngle - 90
            elseif rollingAngle < GetVariable("RollingAngleThresholdLeftFrontTest") and rollingAngle >
                GetVariable("RollingAngleThresholdLeftBackTest") then
                rollingDirection = 2
                turn_target_angle = rollingAngle + 90
            else
                rollingDirection = 1
                turn_target_angle = rollingAngle - 180
            end

            if arts_id == 276 then
                if rollingAngle <= 0 and rollingAngle >= -180 then
                    rollingDirection = 2
                    turn_target_angle = rollingAngle + 90
                elseif rollingAngle > 0 and rollingAngle < 180 then
                    rollingDirection = 3
                    turn_target_angle = rollingAngle - 90
                else
                    rollingDirection = 2
                    turn_target_angle = rollingAngle + 90
                end
            end

            if arts_id == 313 then
                if GetVariable("MoveSpeedLevel") < 0.20000000298023224 then
                    rollingDirection = 0
                    turn_target_angle = rollingAngle
                elseif rollingAngle <= 0 and rollingAngle >= -120 then
                    rollingDirection = 2
                    turn_target_angle = rollingAngle + 90
                elseif rollingAngle > 0 and rollingAngle < 120 then
                    rollingDirection = 3
                    turn_target_angle = rollingAngle - 90
                else
                    rollingDirection = 1
                    turn_target_angle = rollingAngle - 180
                end
            end

            turn_angle_real = math.abs(GetVariable("TurnAngle") - rollingAngle)

            if turn_angle_real > 180 then
                turn_angle_real = 360 - turn_angle_real
            end

            if arts_id ~= 276 then
                if GetVariable("IsLockon") == true then
                    act(TurnToLockonTargetImmediately, turn_target_angle)
                else
                    act(FaceDirection, turn_target_angle)
                end
            end
        end

        if is_self_trans == TRUE then
            if arts_id == 155 or arts_id == 156 then
                SetVariable("SwordArtsRollingArtsCategory", 0)
            else
                SetVariable("SwordArtsRollingArtsCategory", 1)
            end
            SetVariable("SwordArtsRollingDirection_SelfTrans", rollingDirection)
            SetVariable("RollingAngleRealSelftrans", rollingAngle)
        elseif is_self_trans_2 == TRUE then
            SetVariable("SwordArtsRollingDirection_SelfTrans2", rollingDirection)
            SetVariable("RollingAngleReal", rollingAngle)
        else
            SetVariable("SwordArtsRollingDirection", rollingDirection)
            SetVariable("RollingAngleReal", rollingAngle)
        end

        SetVariable("TurnAngleReal", turn_angle_real)
        SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)

        if env(GetSpEffectID, 102360) == FALSE and arts_id ~= 313 then
            if GetVariable("IsEnoughArtPointsL2") == 1 then
                AddStamina(STAMINA_REDUCE_ARTS_QUICKSTEP * STAMINA_CONSUMERATE_LOWSTATUS)
            else
                AddStamina(STAMINA_REDUCE_ARTS_QUICKSTEP)
            end
        end
        local arts_idx = 0
        if arts_id == 155 or arts_id == 156 then
            SetWeightIndex()
            if GetVariable("EvasionWeightIndex") == MOVE_WEIGHT_LIGHT then
                arts_idx = 1
            end
        end
        SetVariable("SwordArtsRollingWeightCategory", arts_idx)
        act(AddSpEffect, 100710)
        if is_self_trans == TRUE then
            ExecEventAllBody("W_SwordArtsRolling_SelfTrans")
        elseif is_self_trans_2 == TRUE then
            ExecEventAllBody("W_SwordArtsRolling_SelfTrans2")
        elseif (arts_id == 276 or arts_id == 313) and GetVariable("IsLockon") == true and env(GetSpEffectID, 100002) ==
            TRUE then
            ExecEventAllBody("W_SwordArtsRolling_Sub")
        else
            ExecEventAllBody("W_SwordArtsRolling")
        end
    elseif request == SWORDARTS_REQUEST_RIGHT_COMBO_1 then
        if IsAttackSwordArts(c_SwordArtsID) == FALSE then
            is_find_atk = FALSE
        end

        SetSwordArtsPointInfo(ACTION_ARM_R2, TRUE)

        if IsHalfBlendArts(c_SwordArtsID) == TRUE then
            ExecEventHalfBlend(Event_SwordArtsHalfOneShotCombo1, blend_type)
        else
            ExecEventAllBody("W_SwordArtsOneShotComboEnd")
        end
    elseif request == SWORDARTS_REQUEST_RIGHT_COMBO_2 then
        if IsAttackSwordArts(c_SwordArtsID) == FALSE then
            is_find_atk = FALSE
        end

        SetSwordArtsPointInfo(ACTION_ARM_R2, TRUE, "W_SwordArtsOneShotComboEnd_2")

        if IsHalfBlendArts(c_SwordArtsID) == TRUE then
            ExecEventHalfBlend(Event_SwordArtsHalfOneShotCombo2, blend_type)
        else
            ExecEventAllBody("W_SwordArtsOneShotComboEnd_2")
        end
    elseif request == ATTACK_REQUEST_ARROW_FIRE_RIGHT or request == ATTACK_REQUEST_ARROW_FIRE_RIGHT2 then
        is_find_atk = FALSE

        if env(IsOutOfAmmo, 1) == TRUE then
            ExecEventAllBody("W_NoArrow")
        elseif env(GetEquipWeaponCategory, HAND_RIGHT) == WEAPON_CATEGORY_LARGE_ARROW then
            ExecEventHalfBlend(Event_AttackArrowRightStart, ALLBODY)
        elseif GetEquipType(HAND_RIGHT, WEAPON_CATEGORY_SMALL_ARROW) == TRUE and
            (c_IsStealth == FALSE and r1 == "W_AttackRightLightStep" or is_stealth_rolling == TRUE or r1 ==
                "W_AttackRightLightDash" or r1 == "W_AttackRightBackstep") then
            ExecEventAllBody("W_AttackArrowRightFireStep")
        elseif c_IsStealth == TRUE then
            ExecEventHalfBlend(Event_StealthAttackArrowStart, ALLBODY)
        else
            ExecEventHalfBlend(Event_AttackArrowRightStart, blend_type)
        end
    elseif request == ATTACK_REQUEST_ARROW_FIRE_LEFT or request == ATTACK_REQUEST_ARROW_FIRE_LEFT2 then
        is_find_atk = FALSE

        if env(IsOutOfAmmo, 0) == TRUE then
            ExecEventAllBody("W_NoArrow")
        elseif env(GetEquipWeaponCategory, HAND_LEFT) == WEAPON_CATEGORY_LARGE_ARROW then
            ExecEventHalfBlend(Event_AttackArrowLeftStart, ALLBODY)
        elseif GetEquipType(HAND_LEFT, WEAPON_CATEGORY_SMALL_ARROW) == TRUE and
            (c_IsStealth == FALSE and r1 == "W_AttackRightLightStep" or is_stealth_rolling == TRUE or r1 ==
                "W_AttackRightLightDash" or r1 == "W_AttackRightBackstep") then
            ExecEventAllBody("W_AttackArrowLeftFireStep")
        elseif c_IsStealth == TRUE then
            ExecEventHalfBlend(Event_StealthAttackArrowStart, ALLBODY)
        else
            ExecEventHalfBlend(Event_AttackArrowLeftStart, blend_type)
        end
    elseif request == ATTACK_REQUEST_RIGHT_CROSSBOW or request == ATTACK_REQUEST_RIGHT_CROSSBOW2 then
        is_find_atk = FALSE

        if blend_type == ALLBODY then
            local move_event = Event_Move

            if c_IsStealth == TRUE then
                move_event = Event_Stealth_Move
            end

            if MoveStart(LOWER, move_event, FALSE) == TRUE then
                blend_type = UPPER
            end
        end

        local crossbowHand = HAND_RIGHT

        if c_Style == HAND_LEFT_BOTH then
            crossbowHand = HAND_LEFT
        end

        if env(IsOutOfAmmo, 1) == TRUE then
            if c_IsStealth == TRUE and GetEquipType(crossbowHand, WEAPON_CATEGORY_BALLISTA) == FALSE then
                ExecEventHalfBlend(Event_StealthAttackCrossbowRightEmpty, blend_type)
            else
                ExecEventHalfBlend(Event_AttackCrossbowRightEmpty, blend_type)
            end
        elseif env(GetBoltLoadingState, 1) == FALSE and GetEquipType(crossbowHand, WEAPON_CATEGORY_BALLISTA) == FALSE then
            if c_IsStealth == TRUE then
                ExecEventHalfBlend(Event_StealthAttackCrossbowRightReload, blend_type)
            else
                ExecEventHalfBlend(Event_AttackCrossbowRightReload, blend_type)
            end
        elseif c_IsStealth == TRUE and GetEquipType(crossbowHand, WEAPON_CATEGORY_BALLISTA) == FALSE then
            ExecEventHalfBlend(Event_StealthAttackCrossbowRightStart, blend_type)
        else
            ExecEventHalfBlend(Event_AttackCrossbowRightStart, blend_type)
        end
    elseif request == ATTACK_REQUEST_LEFT_CROSSBOW or request == ATTACK_REQUEST_LEFT_CROSSBOW2 then
        is_find_atk = FALSE
        atk_hand = HAND_LEFT
        guard_hand = HAND_LEFT

        if blend_type == ALLBODY then
            local move_event = Event_Move

            if c_IsStealth == TRUE and GetEquipType(HAND_LEFT, WEAPON_CATEGORY_BALLISTA) == FALSE then
                move_event = Event_Stealth_Move
            end

            if MoveStart(LOWER, move_event, FALSE) == TRUE then
                blend_type = UPPER
            end
        end

        if env(IsOutOfAmmo, 0) == TRUE then
            if c_IsStealth == TRUE and GetEquipType(HAND_LEFT, WEAPON_CATEGORY_BALLISTA) == FALSE then
                ExecEventHalfBlend(Event_StealthAttackCrossbowLeftEmpty, blend_type)
            else
                ExecEventHalfBlend(Event_AttackCrossbowLeftEmpty, blend_type)
            end
        elseif env(GetBoltLoadingState, 0) == FALSE and GetEquipType(HAND_LEFT, WEAPON_CATEGORY_BALLISTA) == FALSE then
            if c_IsStealth == TRUE then
                ExecEventHalfBlend(Event_StealthAttackCrossbowLeftReload, blend_type)
            else
                ExecEventHalfBlend(Event_AttackCrossbowLeftReload, blend_type)
            end
        elseif c_IsStealth == TRUE and GetEquipType(HAND_LEFT, WEAPON_CATEGORY_BALLISTA) == FALSE then
            ExecEventHalfBlend(Event_StealthAttackCrossbowLeftStart, blend_type)
        else
            ExecEventHalfBlend(Event_AttackCrossbowLeftStart, blend_type)
        end
    elseif request == ATTACK_REQUEST_BOTHRIGHT_CROSSBOW or request == ATTACK_REQUEST_BOTHRIGHT_CROSSBOW2 then
        is_find_atk = FALSE

        if blend_type == ALLBODY then
            local move_event = Event_Move

            if c_IsStealth == TRUE then
                move_event = Event_Stealth_Move
            end

            if MoveStart(LOWER, move_event, FALSE) == TRUE then
                blend_type = UPPER
            end
        end

        local arrowHand = 0

        if c_Style == HAND_RIGHT_BOTH then
            arrowHand = 1
        end

        if env(IsOutOfAmmo, arrowHand) == TRUE then
            if c_IsStealth == TRUE and GetEquipType(arrowHand, WEAPON_CATEGORY_BALLISTA) == FALSE then
                ExecEventHalfBlend(Event_StealthAttackCrossbowBothRightEmpty, blend_type)
            else
                ExecEventHalfBlend(Event_AttackCrossbowBothRightEmpty, blend_type)
            end
        elseif env(GetBoltLoadingState, arrowHand) == FALSE and GetEquipType(arrowHand, WEAPON_CATEGORY_BALLISTA) ==
            FALSE then
            local reloadEvent = Event_AttackCrossbowBothRightReload

            if c_IsStealth == TRUE then
                if c_Style == HAND_LEFT_BOTH then
                    reloadEvent = Event_StealthAttackCrossbowBothLeftReload
                else
                    reloadEvent = Event_StealthAttackCrossbowBothRightReload
                end
            elseif c_Style == HAND_LEFT_BOTH then
                reloadEvent = Event_AttackCrossbowBothLeftReload
            else
                reloadEvent = Event_AttackCrossbowBothRightReload
            end
            ExecEventHalfBlend(reloadEvent, blend_type)
        elseif c_IsStealth == TRUE and GetEquipType(arrowHand, WEAPON_CATEGORY_BALLISTA) == FALSE then
            ExecEventHalfBlend(Event_StealthAttackCrossbowBothRightStart, blend_type)
        else
            ExecEventHalfBlend(Event_AttackCrossbowBothRightStart, blend_type)
        end
    elseif request == ATTACK_REQUEST_BOTHLEFT_CROSSBOW or request == ATTACK_REQUEST_BOTHLEFT_CROSSBOW2 then
        is_find_atk = FALSE

        if blend_type == ALLBODY then
            local move_event = Event_Move

            if c_IsStealth == TRUE then
                move_event = Event_Stealth_Move
            end

            if MoveStart(LOWER, move_event, FALSE) == TRUE then
                blend_type = UPPER
            end
        end

        if env(IsOutOfAmmo, 0) == TRUE then
            if c_IsStealth == TRUE and GetEquipType(HAND_LEFT, WEAPON_CATEGORY_BALLISTA) == FALSE then
                ExecEventHalfBlend(Event_StealthAttackCrossbowBothLeftEmpty, blend_type)
            else
                ExecEventHalfBlend(Event_AttackCrossbowBothLeftEmpty, blend_type)
            end
        elseif env(GetBoltLoadingState, 0) == FALSE and GetEquipType(HAND_LEFT, WEAPON_CATEGORY_BALLISTA) == FALSE then
            if c_IsStealth == TRUE then
                ExecEventHalfBlend(Event_AttackCrossbowBothLeftReload, blend_type)
            else
                ExecEventHalfBlend(Event_AttackCrossbowBothLeftReload, blend_type)
            end
        elseif c_IsStealth == TRUE and GetEquipType(HAND_LEFT, WEAPON_CATEGORY_BALLISTA) == FALSE then
            ExecEventHalfBlend(Event_StealthAttackCrossbowBothLeftStart, blend_type)
        else
            ExecEventHalfBlend(Event_AttackCrossbowBothLeftStart, blend_type)
        end
    elseif request == ATTACK_REQUEST_ATTACK_WHILE_GUARD then
        guard_hand = HAND_LEFT
        local index = env(GetGuardMotionCategory, HAND_LEFT)

        if env(GetEquipWeaponCategory, HAND_LEFT) == WEAPON_CATEGORY_DUELING_SHIELD then
            index = 3
        end

        if GetEquipType(HAND_LEFT, WEAPON_CATEGORY_TORCH) == TRUE then
            index = 2
            SetVariable("IsAttackWhileTorchGuard", TRUE)
        else
            SetVariable("IsAttackWhileTorchGuard", FALSE)
        end

        SetVariable("IndexAttackWhileGuard", index)
        ExecEventAllBody("W_AttackRightWhileGuard")
    else
        return FALSE
    end

    if is_find_atk == TRUE then
        SetInterruptType(INTERRUPT_FINDATTACK)
    end

    if style == HAND_RIGHT_BOTH then
        atk_hand = HAND_RIGHT
    elseif style == HAND_LEFT_BOTH then
        atk_hand = HAND_LEFT
    end

    SetAttackHand(atk_hand)
    SetGuardHand(guard_hand)

    if is_Dual == TRUE then
        act(SetThrowPossibilityState_Defender, 400000)
    end

    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    SetAIActionState()

    return TRUE
end

-- Checks the max combo length
function IsEnableNextAttack(cur_attack_num, hand)
    local style = c_Style

    if style == HAND_LEFT_BOTH then
        hand = HAND_LEFT
    end

    local max_num = GetAttackMaxNumber(hand)
    DebugPrint(3, env(GetEquipWeaponCategory, hand))
    DebugPrint(4, max_num)
    DebugPrint(5, cur_attack_num)

    if cur_attack_num < max_num then
        return TRUE
    else
        return FALSE
    end
end

-- Get the maximum supported combo length for each type
function GetAttackMaxNumber(hand)
    local kind = env(GetEquipWeaponCategory, hand)
    local sp_kind = env(GetEquipWeaponSpecialCategoryNumber, hand)
    local max_num = 1

    if sp_kind == 249 then
        if c_Style == HAND_LEFT_BOTH or c_Style == HAND_RIGHT_BOTH then
            max_num = 4
        elseif hand == HAND_LEFT then
            max_num = 5
        else
            max_num = 5
        end
        return max_num
    end

    if sp_kind == 255 then
        if c_Style == HAND_LEFT_BOTH or c_Style == HAND_RIGHT_BOTH then
            max_num = 4
        elseif hand == HAND_LEFT then
            max_num = 6
        else
            max_num = 6
        end
        return max_num
    end

    if sp_kind == 257 then
        if c_Style == HAND_LEFT_BOTH or c_Style == HAND_RIGHT_BOTH then
            max_num = 4
        elseif hand == HAND_LEFT then
            max_num = 6
        else
            max_num = 6
        end
        return max_num
    end

    if sp_kind == 258 then
        if c_Style == HAND_LEFT_BOTH or c_Style == HAND_RIGHT_BOTH then
            max_num = 4
        elseif hand == HAND_LEFT then
            max_num = 5
        else
            max_num = 5
        end
        return max_num
    end

    if kind == WEAPON_CATEGORY_ARROW or kind == WEAPON_CATEGORY_LARGE_ARROW or kind == WEAPON_CATEGORY_CROSSBOW or kind ==
        WEAPON_CATEGORY_SMALL_ARROW then
        max_num = 1
    elseif kind == WEAPON_CATEGORY_EXTRALARGE_SWORD or kind == WEAPON_CATEGORY_EXTRALARGE_AXHAMMER or kind ==
        WEAPON_CATEGORY_LARGE_SPEAR or kind == WEAPON_CATEGORY_LARGE_SHIELD or kind == WEAPON_CATEGORY_STAFF then
        max_num = 3
    elseif kind == WEAPON_CATEGORY_TORCH or kind == WEAPON_CATEGORY_LARGE_SWORD or kind == WEAPON_CATEGORY_FLAIL or kind ==
        WEAPON_CATEGORY_LARGE_AX or kind == WEAPON_CATEGORY_LARGE_HAMMER or kind == WEAPON_CATEGORY_SPEAR or kind ==
        WEAPON_CATEGORY_HALBERD or kind == WEAPON_CATEGORY_LARGE_CURVEDSWORD or kind == WEAPON_CATEGORY_SMALL_SHIELD or
        kind == WEAPON_CATEGORY_MIDDLE_SHIELD or kind == WEAPON_CATEGORY_LARGE_SCYTHE or kind == WEAPON_CATEGORY_WHIP or
        kind == WEAPON_CATEGORY_PERFUME_BOTTLE or kind == WEAPON_CATEGORY_DUELING_SHIELD or kind ==
        WEAPON_CATEGORY_LARGE_KATANA or kind == WEAPON_CATEGORY_BEAST_CLAW then
        max_num = 4
    elseif kind == WEAPON_CATEGORY_STRAIGHT_SWORD or kind == WEAPON_CATEGORY_TWINBLADE or kind == WEAPON_CATEGORY_KATANA or
        kind == WEAPON_CATEGORY_AX or kind == WEAPON_CATEGORY_HAMMER or kind == WEAPON_CATEGORY_LARGE_RAPIER or kind ==
        WEAPON_CATEGORY_LIGHT_LARGE_SWORD then
        max_num = 5
    elseif kind == WEAPON_CATEGORY_SHORT_SWORD or kind == WEAPON_CATEGORY_CLAW or kind == WEAPON_CATEGORY_RAPIER or kind ==
        WEAPON_CATEGORY_CURVEDSWORD or kind == WEAPON_CATEGORY_FIST or kind == WEAPON_CATEGORY_MARTIAL_ARTS or kind ==
        WEAPON_CATEGORY_THROW_DAGGER or kind == WEAPON_CATEGORY_BACKHAND_SWORD then
        max_num = 6
    end

    return max_num
end

-- Get the maximum supported combo length for each dual type
function GetDualAttackMaxNumber(hand)
    local kind = env(GetEquipWeaponCategory, hand)
    local max_num = 1

    if kind == WEAPON_CATEGORY_EXTRALARGE_SWORD or kind == WEAPON_CATEGORY_EXTRALARGE_AXHAMMER or kind ==
        WEAPON_CATEGORY_LARGE_SPEAR or kind == WEAPON_CATEGORY_LARGE_SWORD or kind == WEAPON_CATEGORY_LARGE_AX or kind ==
        WEAPON_CATEGORY_LARGE_HAMMER or kind == WEAPON_CATEGORY_SPEAR or kind == WEAPON_CATEGORY_HALBERD or kind ==
        WEAPON_CATEGORY_LARGE_CURVEDSWORD or kind == WEAPON_CATEGORY_LARGE_SCYTHE or kind == WEAPON_CATEGORY_WHIP or
        kind == WEAPON_CATEGORY_LARGE_KATANA then
        max_num = 3
    elseif kind == WEAPON_CATEGORY_STRAIGHT_SWORD or kind == WEAPON_CATEGORY_TWINBLADE or kind == WEAPON_CATEGORY_KATANA or
        kind == WEAPON_CATEGORY_AX or kind == WEAPON_CATEGORY_HAMMER or kind == WEAPON_CATEGORY_FLAIL or kind ==
        WEAPON_CATEGORY_LARGE_RAPIER or kind == WEAPON_CATEGORY_SHORT_SWORD or kind == WEAPON_CATEGORY_RAPIER or kind ==
        WEAPON_CATEGORY_CURVEDSWORD or kind == WEAPON_CATEGORY_PERFUME_BOTTLE or kind == WEAPON_CATEGORY_DUELING_SHIELD or
        kind == WEAPON_CATEGORY_LIGHT_LARGE_SWORD or kind == WEAPON_CATEGORY_BEAST_CLAW then
        max_num = 4
    elseif kind == WEAPON_CATEGORY_CLAW or kind == WEAPON_CATEGORY_FIST or kind == WEAPON_CATEGORY_THROW_DAGGER or kind ==
        WEAPON_CATEGORY_MARTIAL_ARTS or kind == WEAPON_CATEGORY_BACKHAND_SWORD then
        max_num = 6
    end

    return max_num
end

function IsEnableSpecialAttack(hand)
    local style = c_Style

    if style == HAND_LEFT_BOTH then
        hand = HAND_LEFT
    end

    local kind = env(GetEquipWeaponCategory, hand)
    local sp_kind = env(GetEquipWeaponSpecialCategoryNumber, HAND_RIGHT)

    if sp_kind == 254 or sp_kind == 251 then
        return TRUE
    end

    if GetEquipType(hand, WEAPON_CATEGORY_RAPIER, WEAPON_CATEGORY_CURVEDSWORD, WEAPON_CATEGORY_LARGE_RAPIER,
        WEAPON_CATEGORY_BEAST_CLAW, WEAPON_CATEGORY_THROW_DAGGER, WEAPON_CATEGORY_LARGE_KATANA,
        WEAPON_CATEGORY_PERFUME_BOTTLE) == TRUE then
        return TRUE
    else
        return FALSE
    end
end

function IsUseStealthAttack(is_dual)
    -- 110 Broadsword
    -- 182 Morning Star
    -- 207 Serpent-Hunter
    -- 832 Starscourge Greatsword
    -- 852 Ornamental Straight Sword

    if is_dual == TRUE then
        if GetEquipType(HAND_RIGHT, WEAPON_CATEGORY_STRAIGHT_SWORD, WEAPON_CATEGORY_TWINBLADE, WEAPON_CATEGORY_RAPIER,
            WEAPON_CATEGORY_CURVEDSWORD, WEAPON_CATEGORY_SPEAR, WEAPON_CATEGORY_LARGE_SPEAR,
            WEAPON_CATEGORY_BACKHAND_SWORD) == TRUE then
            return TRUE
        end
    elseif c_Style == HAND_RIGHT_BOTH or c_Style == HAND_LEFT_BOTH then
        local hand = HAND_RIGHT

        if c_Style == HAND_LEFT_BOTH then
            hand = HAND_LEFT
        end

        local specialcategory = env(GetEquipWeaponSpecialCategoryNumber, hand)

        if specialcategory == 110 or specialcategory == 832 or specialcategory == 852 or specialcategory == 255 or
            specialcategory == 257 then
            return FALSE
        end
        if specialcategory == 182 or specialcategory == 207 then
            return TRUE
        end
        if GetEquipType(hand, WEAPON_CATEGORY_TORCH, WEAPON_CATEGORY_STRAIGHT_SWORD, WEAPON_CATEGORY_TWINBLADE,
            WEAPON_CATEGORY_EXTRALARGE_SWORD, WEAPON_CATEGORY_RAPIER, WEAPON_CATEGORY_LARGE_RAPIER,
            WEAPON_CATEGORY_CURVEDSWORD, WEAPON_CATEGORY_BACKHAND_SWORD) == TRUE then
            return TRUE
        end
    else
        local hand = HAND_RIGHT
        local specialcategory = env(GetEquipWeaponSpecialCategoryNumber, HAND_RIGHT)

        if specialcategory == 110 then
            return FALSE
        end
        if specialcategory == 182 or specialcategory == 207 then
            return TRUE
        end
        if GetEquipType(hand, WEAPON_CATEGORY_TORCH, WEAPON_CATEGORY_STRAIGHT_SWORD, WEAPON_CATEGORY_TWINBLADE,
            WEAPON_CATEGORY_EXTRALARGE_SWORD, WEAPON_CATEGORY_RAPIER, WEAPON_CATEGORY_LARGE_RAPIER,
            WEAPON_CATEGORY_CURVEDSWORD, WEAPON_CATEGORY_BACKHAND_SWORD) == TRUE then
            return TRUE
        end
    end
    return FALSE
end

----------------------
-- Common functions --
----------------------

function AttackCommonFunction(r1, r2, l1, l2, b1, b2, guardcondition, use_atk_queue, comboCount, gen_hand)
    if gen_hand == nil then
        gen_hand = FALSE
    end

    SetVariable("ToggleDash", 0)

    act(FallPreventionAssist)
    SetThrowAtkInvalid()
    SetAIActionState()

    if env(GetSpEffectID, 102050) == TRUE then
        act(LockonFixedAngleCancel)
    end

    local bool = FALSE

    if guardcondition == TO_GUARDON then
        bool = TRUE
    end

    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, bool) == TRUE then
        return TRUE
    end
    if ExecWeaponChange(ALLBODY) == TRUE then
        return TRUE
    end
    if ExecEvasion(FALSE, ESTEP_NONE, FALSE) == TRUE then
        return TRUE
    end
    if ExecItem(QUICKTYPE_ATTACK, ALLBODY) == TRUE then
        if use_atk_queue == TRUE then
            SetAttackQueue(r1, r2, l1, l2, b1, b2)
        end
        return TRUE
    end
    if ExecMagic(QUICKTYPE_ATTACK, ALLBODY, FALSE) == TRUE then
        return TRUE
    end
    if ExecAttack(r1, r2, l1, l2, b1, b2, guardcondition, ALLBODY, FALSE, FALSE, FALSE) == TRUE then
        if use_atk_queue == TRUE then
            SetAttackQueue(r1, r2, l1, l2, b1, b2)
        end
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
    if ExecGuardOnCancelTiming(guardcondition, ALLBODY) == TRUE then
        return TRUE
    end
    if ExecArtsStanceOnCancelTiming(ALLBODY) == TRUE then
        return TRUE
    end
    local move_event = Event_Move
    if env(GetSpEffectID, 102051) == TRUE then
        move_event = Event_MoveLong
    end
    if MoveStartonCancelTiming(move_event, gen_hand) == TRUE then
        return TRUE
    end
    if ExecGesture() == TRUE then
        return TRUE
    end
    return FALSE
end

function ChainRecoverCommonFunction()
    SetAIActionState()

    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
        return TRUE
    end
    if ExecJump() == TRUE then
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, blend_type) == TRUE then
        return TRUE
    end
    if ExecWeaponChange(blend_type) == TRUE then
        return TRUE
    end
    if ExecEvasion(FALSE, ESTEP_NONE, FALSE) == TRUE then
        return TRUE
    end
    if ExecGuardOnCancelTiming(FALSE, blend_type) == TRUE then
        return TRUE
    end
    if ExecItem(QUICKTYPE_NORMAL, blend_type) == TRUE then
        return TRUE
    end
    if ExecMagic(QUICKTYPE_NORMAL, ALLBODY, FALSE) == TRUE then
        return TRUE
    end
    if ExecArtsStanceOnCancelTiming(blend_type) == TRUE then
        return TRUE
    end
    if ExecAttack("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, blend_type, FALSE, FALSE, FALSE) == TRUE then
        return TRUE
    end
    if blend_type ~= UPPER and ExecQuickTurn(LOWER, TURN_TYPE_DEFAULT) == TRUE then
        return TRUE
    end
    return FALSE
end

--------------
-- Triggers --
--------------

function EStepDown_onUpdate()
    SetThrowAtkInvalid()
    SetEnableAimMode()

    if EvasionCommonFunction(FALL_TYPE_DEFAULT, "W_AttackRightLightStep", "W_AttackRightHeavy1Start",
        "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLightStep", "W_AttackBothHeavy1Start",
        QUICKTYPE_ROLLING) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        ExecEventAllBody("W_Idle")
        return
    end
    SetRollingTurnCondition(FALSE)
end

function ChainRecover_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()

    if ChainRecoverCommonFunction() == TRUE then
        return
    end
    if lower_state == LOWER_MOVE and env(IsAnimEnd, 1) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendLowerCommonFunction(Event_ChainRecoverMirror, lower_state, FALSE) == TRUE then
        return
    end
end

function Repelled_Wall_onUpdate()
    act(FallPreventionAssist)

    if DamageCommonFunction(FALSE, ESTEP_NONE, FALL_TYPE_DEFAULT) == TRUE then
        return
    end
end

function Repelled_Small_onUpdate()
    if DamageCommonFunction(FALSE, ESTEP_NONE, FALL_TYPE_DEFAULT) == TRUE then
        return
    end
end

function Repelled_Large_onUpdate()
    if DamageCommonFunction(FALSE, ESTEP_NONE, FALL_TYPE_DEFAULT) == TRUE then
        return
    end
end

function AttackRight_Activate()
    SetAttackHand(HAND_RIGHT)
    SetGuardHand(HAND_RIGHT)
    ActivateRightArmAdd(START_FRAME_NONE)
end

function AttackRight_Update()
    UpdateRightArmAdd()
end

function AttackRightWhileGuard_Activate()
    SetAttackHand(HAND_RIGHT)
    SetGuardHand(HAND_LEFT)
end

function AttackRightLight1_onUpdate()
    local r1 = "W_AttackRightLight2"

    if g_ComboReset == TRUE then
        r1 = "W_AttackRightLight1"
    end

    if AttackCommonFunction(r1, "W_AttackRightHeavy1SubStart", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight2", "W_AttackBothHeavy1Start", FALSE, TRUE, 1) == TRUE then
        return
    end
end

function AttackRightLight2_onUpdate()
    if IsEnableNextAttack(2, HAND_RIGHT) == TRUE then
        local r1 = "W_AttackRightLight3"
        if g_ComboReset == TRUE then
            r1 = "W_AttackRightLight1"
        end
        if AttackCommonFunction(r1, "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
            "W_AttackBothLight3", "W_AttackBothHeavy1Start", FALSE, TRUE, 2) == TRUE then
            return
        end
    elseif AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
        return
    end
end

function AttackRightLight3_onUpdate()
    if IsEnableNextAttack(3, HAND_RIGHT) == TRUE then
        local r1 = "W_AttackRightLight4"
        if g_ComboReset == TRUE then
            r1 = "W_AttackRightLight1"
        end
        if AttackCommonFunction(r1, "W_AttackRightHeavy1SubStart", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
            "W_AttackBothLight4", "W_AttackBothHeavy1Start", FALSE, TRUE, 3) == TRUE then
            return
        end
    elseif AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
        return
    end
end

function AttackRightLight4_onUpdate()
    if IsEnableNextAttack(4, HAND_RIGHT) == TRUE then
        local r1 = "W_AttackRightLight5"
        if g_ComboReset == TRUE then
            r1 = "W_AttackRightLight1"
        end
        if AttackCommonFunction(r1, "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
            "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 4) == TRUE then
            return
        end
    elseif AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", "W_AttackBothLight2", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
        return
    end
end

function AttackRightLight5_onUpdate()
    if IsEnableNextAttack(5, HAND_RIGHT) == TRUE then
        local r1 = "W_AttackRightLight6"
        if g_ComboReset == TRUE then
            r1 = "W_AttackRightLight1"
        end
        if AttackCommonFunction(r1, "W_AttackRightHeavy1SubStart", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
            "W_AttackBothLight6", "W_AttackBothHeavy1Start", FALSE, TRUE, 5) == TRUE then
            return
        end
    elseif AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
        return
    end
end

function AttackRightLight6_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
        return
    end
end

function AttackRightLightStep_onUpdate()
    local r1 = "W_AttackRightLightSubStart"
    if g_ComboReset == TRUE then
        r1 = "W_AttackRightLight1"
    end
    if AttackCommonFunction(r1, "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 1) == TRUE then
        return
    end
end

function AttackRightLightStealth_onUpdate()
    local r1 = "W_AttackRightLightSubStart"
    if g_ComboReset == TRUE then
        r1 = "W_AttackRightLight1"
    end
    if AttackCommonFunction(r1, "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 1) == TRUE then
        return
    end
end

function AttackRightLightFastStep_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
        return
    end
end

function AttackRightLightDash_onUpdate()
    local r1 = "W_AttackRightLightSubStart"
    if g_ComboReset == TRUE then
        r1 = "W_AttackRightLight1"
    end
    if AttackCommonFunction(r1, "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 1) == TRUE then
        return
    end
end

function AttackRightHeavyDash_onUpdate()
    local r1 = "W_AttackRightLightSubStart"
    if g_ComboReset == TRUE then
        r1 = "W_AttackRightLight1"
    end
    if AttackCommonFunction(r1, "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 1) == TRUE then
        return
    end
end

function AttackRightWhileGuard_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", TO_GUARDON, TRUE, 0) == TRUE then
        return
    end
end

function AttackRightHeavy1SubStart_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy2Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy2Start", FALSE, TRUE, 0) == TRUE then
        return
    end
    if env(GetEventEzStateFlag, 0) == TRUE or env(IsAnimEnd, 1) == TRUE then
        act(SetSpecialInterpolation, 0, TRUE)
        ExecEventAllBody("W_AttackRightHeavy1Start")
        return
    end
end

function AttackRightLightSubStart_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy2Start", FALSE, TRUE, 0) == TRUE then
        return
    end
    if env(GetEventEzStateFlag, 0) == TRUE or env(IsAnimEnd, 1) == TRUE then
        act(SetSpecialInterpolation, 0, TRUE)
        ExecEventAllBody("W_AttackRightLight2")
        return
    end
end

function AttackRightHeavy1Start_onUpdate()
    act(SetSpecialInterpolation, 0, FALSE)
    if IsEnableSpecialAttack(HAND_RIGHT) == TRUE and 0 < env(ActionDuration, ACTION_ARM_R2) and 0 <
        env(ActionDuration, ACTION_ARM_SP_MOVE) and env(GetSpEffectID, 100290) == TRUE then
        ExecEventAllBody("W_AttackRightSpecial1")
        return
    end
    local r1 = "W_AttackRightLightSubStart"
    if g_ComboReset == TRUE then
        r1 = "W_AttackRightLight1"
    end
    if AttackCommonFunction(r1, "W_AttackRightHeavy2Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 1) == TRUE then
        return
    end
    if 0 >= env(ActionDuration, ACTION_ARM_R2) and
        (env(GetGeneralTAEFlag, TAE_FLAG_CHARGING) == 1 or env(GetSpEffectID, 100280) == TRUE) then
        ExecEventAllBody("W_AttackRightHeavy1End")
        return
    end
end

function AttackRightHeavy1End_onUpdate()
    local r1 = "W_AttackRightLightSubStart"
    if g_ComboReset == TRUE then
        r1 = "W_AttackRightLight1"
    end
    if AttackCommonFunction(r1, "W_AttackRightHeavy2Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy2Start", FALSE, TRUE, 1) == TRUE then
        return
    end
end

function AttackRightHeavy2Start_onUpdate()
    if IsEnableSpecialAttack(HAND_RIGHT) == TRUE and env(ActionDuration, ACTION_ARM_R2) > 0 and
        env(ActionDuration, ACTION_ARM_SP_MOVE) > 0 and env(GetSpEffectID, 100290) == TRUE then
        if env(GetEquipWeaponSpecialCategoryNumber, HAND_RIGHT) == 953 then
            ExecEventAllBody("W_AttackRightSpecial1")
        else
            ExecEventAllBody("W_AttackRightSpecial2")
        end
        return
    end
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
        return
    end
    if env(ActionDuration, ACTION_ARM_R2) <= 0 and
        (env(GetGeneralTAEFlag, TAE_FLAG_CHARGING) == 1 or env(GetSpEffectID, 100280) == TRUE) then
        ExecEventAllBody("W_AttackRightHeavy2End")
        return
    end
end

function AttackRightHeavy2End_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
        return
    end
end

function AttackRightHeavySpecial1SubStart_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy2Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy2Start", FALSE, TRUE, 0) == TRUE then
        return
    end
    if env(GetEventEzStateFlag, 0) == TRUE or env(IsAnimEnd, 1) == TRUE then
        act(SetSpecialInterpolation, 0, TRUE)
        ExecEventAllBody("W_AttackRightHeavySpecial1Start")
        return
    end
end

function AttackRightHeavySpecial1Start_onUpdate()
    act(SetSpecialInterpolation, 0, FALSE)
    if env(IsAnimEnd, 0) == TRUE then
        SetRightSpecialHeavyAttackGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
    local gen_trans = FALSE
    if env(GetEquipWeaponSpecialCategoryNumber, HAND_RIGHT) == 852 then
        gen_trans = TRUE
    end
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy2Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy2Start", FALSE, TRUE, 0, gen_trans) == TRUE then
        return
    end
    if 0 >= env(ActionDuration, ACTION_ARM_R2) and
        (env(GetGeneralTAEFlag, TAE_FLAG_CHARGING) == 1 or env(GetSpEffectID, 100280) == TRUE) then
        ExecEventAllBody("W_AttackRightHeavySpecial1End")
        return
    end
end

function AttackRightHeavySpecial1End_onUpdate()
    if env(IsAnimEnd, 0) == TRUE then
        SetRightSpecialHeavyAttackGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
    local gen_trans = FALSE
    if env(GetEquipWeaponSpecialCategoryNumber, HAND_RIGHT) == 852 then
        gen_trans = TRUE
    end
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy2Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy2Start", FALSE, TRUE, 0, gen_trans) == TRUE then
        return
    end
end

function AttackRightHeavySpecial2Start_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
        return
    end
    if 0 >= env(ActionDuration, ACTION_ARM_R2) and
        (env(GetGeneralTAEFlag, TAE_FLAG_CHARGING) == 1 or env(GetSpEffectID, 100280) == TRUE) then
        ExecEventAllBody("W_AttackRightHeavySpecial2End")
        return
    end
end

function AttackRightHeavySpecial2End_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
        return
    end
end

function AttackRightSpecial1_onUpdate()
    if AttackCommonFunction("W_AttackRightBackstep", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
        return
    end
end

function AttackRightSpecial2_onUpdate()
    if AttackCommonFunction("W_AttackRightBackstep", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
        return
    end
end

function AttackRightBackstep_onUpdate()
    local r1 = "W_AttackRightLightSubStart"
    if g_ComboReset == TRUE then
        r1 = "W_AttackRightLight1"
    end
    if AttackCommonFunction(r1, "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 1) == TRUE then
        return
    end
end

function AttackLeft_Activate()
    SetAttackHand(HAND_LEFT)
    SetGuardHand(HAND_LEFT)
    ActivateRightArmAdd(START_FRAME_A02)
end

function AttackLeft_Update()
    SetVariable("IndexDamageParryHand", 1)
    UpdateRightArmAdd()
end

function AttackLeft_Deactivate()
    SetVariable("IndexDamageParryHand", 0)
end

function AttackLeftLight1_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
        return
    end
end

function AttackLeftHeavy1_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", nil, "W_AttackLeftHeavy2",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
        return
    end
end

function AttackLeftHeavy2_onUpdate()
    if IsEnableNextAttack(2, HAND_LEFT) == TRUE then
        if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", nil, "W_AttackLeftHeavy3",
            "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
            return
        end
    elseif AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", nil, "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
        return
    end
end

function AttackLeftHeavy3_onUpdate()
    if IsEnableNextAttack(3, HAND_LEFT) == TRUE then
        if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", nil, "W_AttackLeftHeavy4",
            "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 3) == TRUE then
            return
        end
    elseif AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", nil, "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
        return
    end
end

function AttackLeftHeavy4_onUpdate()
    if IsEnableNextAttack(4, HAND_LEFT) == TRUE then
        if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", nil, "W_AttackLeftHeavy5",
            "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
            return
        end
    elseif AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", nil, "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
        return
    end
end

function AttackLeftHeavy5_onUpdate()
    if IsEnableNextAttack(5, HAND_LEFT) == TRUE then
        if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", nil, "W_AttackLeftHeavy6",
            "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
            return
        end
    elseif AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", nil, "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
        return
    end
end

function AttackLeftHeavy6_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", nil, "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
        return
    end
end

function AttackDual_Activate()
    SetAttackHand(HAND_RIGHT)
    SetGuardHand(HAND_LEFT)
    act(SetThrowPossibilityState_Defender, 400000)
end

function AttackDualLight1_onUpdate()
    local l1 = "W_AttackLeftLight2"
    if g_ComboReset == TRUE or GetDualAttackMaxNumber(HAND_RIGHT) <= 1 then
        l1 = "W_AttackLeftLight1"
    end
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", l1, "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 1) == TRUE then
        return
    end
end

function AttackDualLight2_onUpdate()
    local l1 = "W_AttackLeftLight3"
    if g_ComboReset == TRUE or GetDualAttackMaxNumber(HAND_RIGHT) <= 2 then
        l1 = "W_AttackLeftLight1"
    end
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", l1, "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 1) == TRUE then
        return
    end
end

function AttackDualLight3_onUpdate()
    local l1 = "W_AttackLeftLight4"
    if g_ComboReset == TRUE or GetDualAttackMaxNumber(HAND_RIGHT) <= 3 then
        l1 = "W_AttackLeftLight1"
    end
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", l1, "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 1) == TRUE then
        return
    end
end

function AttackDualLight4_onUpdate()
    local l1 = "W_AttackLeftLight5"
    if g_ComboReset == TRUE or GetDualAttackMaxNumber(HAND_RIGHT) <= 4 then
        l1 = "W_AttackLeftLight1"
    end
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", l1, "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 1) == TRUE then
        return
    end
end

function AttackDualLight5_onUpdate()
    local l1 = "W_AttackLeftLight6"
    if g_ComboReset == TRUE or GetDualAttackMaxNumber(HAND_RIGHT) <= 5 then
        l1 = "W_AttackLeftLight1"
    end
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", l1, "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 1) == TRUE then
        return
    end
end

function AttackDualLight6_onUpdate()
    local l1 = "W_AttackLeftLight1"
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", l1, "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 1) == TRUE then
        return
    end
end

function AttackDualDash_onUpdate()
    local l1 = "W_AttackDualLightSubStart"
    if g_ComboReset == TRUE then
        l1 = "W_AttackLeftLight1"
    end
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", l1, "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 1) == TRUE then
        return
    end
end

function AttackDualRolling_onUpdate()
    local l1 = "W_AttackDualLightSubStart"
    if g_ComboReset == TRUE then
        l1 = "W_AttackLeftLight1"
    end
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", l1, "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 1) == TRUE then
        return
    end
end

function AttackDualStealth_onUpdate()
    local l1 = "W_AttackDualLightSubStart"
    if g_ComboReset == TRUE then
        l1 = "W_AttackLeftLight1"
    end
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", l1, "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 1) == TRUE then
        return
    end
end

function AttackDualBackStep_onUpdate()
    local l1 = "W_AttackDualLightSubStart"
    if g_ComboReset == TRUE then
        l1 = "W_AttackLeftLight1"
    end
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", l1, "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 1) == TRUE then
        return
    end
end

function AttackDualLightSubStart_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
        return
    end

    if env(GetEventEzStateFlag, 0) == TRUE or env(IsAnimEnd, 1) == TRUE then
        act(SetSpecialInterpolation, 0, TRUE)
        ExecEventAllBody("W_AttackDualLight2")
        return
    end
end

function AttackBoth_Activate()
    local hand = HAND_RIGHT
    if c_Style == HAND_LEFT_BOTH then
        hand = HAND_LEFT
    end
    SetAttackHand(hand)
    SetGuardHand(hand)
end

function AttackBothLight1_onUpdate()
    local b1 = "W_AttackBothLight2"
    if g_ComboReset == TRUE then
        b1 = "W_AttackBothLight1"
    end
    if AttackCommonFunction("W_AttackRightLight2", "W_AttackRightHeavy1Start", "W_AttackBothLeft2",
        "W_AttackLeftHeavy1", b1, "W_AttackBothHeavy1SubStart", FALSE, TRUE, 1) == TRUE then
        return
    end
end

function AttackBothLight2_onUpdate()
    if IsEnableNextAttack(2, HAND_RIGHT) == TRUE then
        local b1 = "W_AttackBothLight3"
        if g_ComboReset == TRUE then
            b1 = "W_AttackBothLight1"
        end
        if AttackCommonFunction("W_AttackRightLight3", "W_AttackRightHeavy1Start", "W_AttackBothLeft3",
            "W_AttackLeftHeavy1", b1, "W_AttackBothHeavy1Start", FALSE, TRUE, 2) == TRUE then
            return
        end
    elseif AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
        return
    end
end

function AttackBothLight3_onUpdate()
    if IsEnableNextAttack(3, HAND_RIGHT) == TRUE then
        local b1 = "W_AttackBothLight4"
        if g_ComboReset == TRUE then
            b1 = "W_AttackBothLight1"
        end
        if AttackCommonFunction("W_AttackRightLight4", "W_AttackRightHeavy1Start", "W_AttackBothLeft2",
            "W_AttackLeftHeavy1", b1, "W_AttackBothHeavy1SubStart", FALSE, TRUE, 3) == TRUE then
            return
        end
    elseif AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
        return
    end
end

function AttackBothLight4_onUpdate()
    if IsEnableNextAttack(4, HAND_RIGHT) == TRUE then
        local b1 = "W_AttackBothLight5"
        if g_ComboReset == TRUE then
            b1 = "W_AttackBothLight1"
        end
        if AttackCommonFunction("W_AttackRightLight5", "W_AttackRightHeavy1Start", "W_AttackBothLeft2",
            "W_AttackLeftHeavy1", b1, "W_AttackBothHeavy1SubStart", FALSE, TRUE, 4) == TRUE then
            return
        end
    elseif AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
        return
    end
end

function AttackBothLight5_onUpdate()
    if IsEnableNextAttack(5, HAND_RIGHT) == TRUE then
        local b1 = "W_AttackBothLight6"
        if g_ComboReset == TRUE then
            b1 = "W_AttackBothLight1"
        end
        if AttackCommonFunction("W_AttackRightLight6", "W_AttackRightHeavy1Start", "W_AttackBothLeft2",
            "W_AttackLeftHeavy1", b1, "W_AttackBothHeavy1SubStart", FALSE, TRUE, 5) == TRUE then
            return
        end
    elseif AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
        return
    end
end

function AttackBothLight6_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackBothLeft2",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1SubStart", FALSE, TRUE, 0) == TRUE then
        return
    end
end

function AttackBothLeft1_onUpdate()
    if AttackCommonFunction("W_AttackRightLight2", "W_AttackRightHeavy1Start", "W_AttackBothLeft2",
        "W_AttackLeftHeavy1", "W_AttackBothLight2", "W_AttackBothHeavy1Start", FALSE, TRUE, 1) == TRUE then
        return
    end
end

function AttackBothLeft2_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackBothLeft3",
        "W_AttackLeftHeavy1", "W_AttackBothLight3", "W_AttackBothHeavy1Start", FALSE, TRUE, 2) == TRUE then
        return
    end
end

function AttackBothLeft3_onUpdate()
    if AttackCommonFunction("W_AttackRightLight2", "W_AttackRightHeavy1Start", "W_AttackBothLeft2",
        "W_AttackLeftHeavy1", "W_AttackBothLight2", "W_AttackBothHeavy1Start", FALSE, TRUE, 3) == TRUE then
        return
    end
end

function AttackBothLeftDash_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackBothLeft1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
        return
    end
end

function AttackBothLeftStep_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackBothLeft1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
        return
    end
end

function AttackBothLeftSpecial1_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackBothLeftSpecial2",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
        return
    end
end

function AttackBothLeftSpecial2_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackBothLeftSpecial3",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
        return
    end
end

function AttackBothLeftSpecial3_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackBothLeftSpecial4",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
        return
    end
end

function AttackBothLeftSpecial4_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackBothLeftSpecial5",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
        return
    end
end

function AttackBothLeftSpecial5_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
        return
    end
end

function AttackBothLightSubStart_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy2Start", FALSE, TRUE, 0) == TRUE then
        return
    end
    if env(GetEventEzStateFlag, 0) == TRUE or env(IsAnimEnd, 1) == TRUE then
        act(SetSpecialInterpolation, 0, TRUE)
        ExecEventAllBody("W_AttackBothLight2")
        return
    end
end

function AttackBothHeavy1SubStart_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackBothLeft1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy2Start", FALSE, TRUE, 0) == TRUE then
        return
    end
    if env(GetEventEzStateFlag, 0) == TRUE or env(IsAnimEnd, 1) == TRUE then
        act(SetSpecialInterpolation, 0, TRUE)
        ExecEventAllBody("W_AttackBothHeavy1Start")
        return
    end
end

function AttackBothHeavy1Start_onUpdate()
    act(SetSpecialInterpolation, 0, FALSE)
    if IsEnableSpecialAttack(HAND_RIGHT) == TRUE and 0 < env(ActionDuration, ACTION_ARM_R2) and 0 <
        env(ActionDuration, ACTION_ARM_SP_MOVE) and env(GetSpEffectID, 100290) == TRUE then
        ExecEventAllBody("W_AttackBothSpecial1")
        return
    end
    local b1 = "W_AttackBothLightSubStart"
    if g_ComboReset == TRUE then
        b1 = "W_AttackBothLight1"
    end
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy2Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", b1, "W_AttackBothHeavy2Start", FALSE, TRUE, 1) == TRUE then
        return
    end
    if 0 >= env(ActionDuration, ACTION_ARM_R2) and
        (env(GetGeneralTAEFlag, TAE_FLAG_CHARGING) == 1 or env(GetSpEffectID, 100280) == TRUE) then
        ExecEventAllBody("W_AttackBothHeavy1End")
        return
    end
end

function AttackBothHeavy1End_onUpdate()
    local b1 = "W_AttackBothLightSubStart"
    if g_ComboReset == TRUE then
        b1 = "W_AttackBothLight1"
    end
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy2Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", b1, "W_AttackBothHeavy2Start", FALSE, TRUE, 1) == TRUE then
        return
    end
end

function AttackBothHeavy2Start_onUpdate()
    if IsEnableSpecialAttack(HAND_RIGHT) == TRUE and env(ActionDuration, ACTION_ARM_R2) > 0 and
        env(ActionDuration, ACTION_ARM_SP_MOVE) > 0 and env(GetSpEffectID, 100290) == TRUE then
        local hand = HAND_RIGHT
        if c_Style == HAND_LEFT_BOTH then
            hand = HAND_LEFT
        end
        if env(GetEquipWeaponSpecialCategoryNumber, hand) == 953 then
            ExecEventAllBody("W_AttackBothSpecial1")
        else
            ExecEventAllBody("W_AttackBothSpecial2")
        end
        return
    end
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackBothLeft1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
        return
    end
    if env(ActionDuration, ACTION_ARM_R2) <= 0 and
        (env(GetGeneralTAEFlag, TAE_FLAG_CHARGING) == 1 or env(GetSpEffectID, 100280) == TRUE) then
        ExecEventAllBody("W_AttackBothHeavy2End")
        return
    end
end

function AttackBothHeavy2End_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackBothLeft1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
        return
    end
end

function AttackBothHeavySpecial1SubStart_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackBothLeft1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy2Start", FALSE, TRUE, 0) == TRUE then
        return
    end
    if env(GetEventEzStateFlag, 0) == TRUE or env(IsAnimEnd, 1) == TRUE then
        act(SetSpecialInterpolation, 0, TRUE)
        ExecEventAllBody("W_AttackBothHeavySpecial1Start")
        return
    end
end

function AttackBothHeavySpecial1Start_onUpdate()
    act(SetSpecialInterpolation, 0, FALSE)
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackBothLeft1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy2Start", FALSE, TRUE, 0) == TRUE then
        return
    end
    if 0 >= env(ActionDuration, ACTION_ARM_R2) and
        (env(GetGeneralTAEFlag, TAE_FLAG_CHARGING) == 1 or env(GetSpEffectID, 100280) == TRUE) then
        ExecEventAllBody("W_AttackBothHeavySpecial1End")
        return
    end
end

function AttackBothHeavySpecial1End_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackBothLeft1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy2Start", FALSE, TRUE, 0) == TRUE then
        return
    end
end

function AttackBothHeavySpecial2Start_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackBothLeft1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
        return
    end
    if 0 >= env(ActionDuration, ACTION_ARM_R2) and
        (env(GetGeneralTAEFlag, TAE_FLAG_CHARGING) == 1 or env(GetSpEffectID, 100280) == TRUE) then
        ExecEventAllBody("W_AttackBothHeavySpecial2End")
        return
    end
end

function AttackBothHeavySpecial2End_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackBothLeft1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
        return
    end
end

function AttackBothSpecial1_onUpdate()
    if AttackCommonFunction("W_AttackRightBackstep", "W_AttackRightHeavy1Start", "W_AttackBothLeft1",
        "W_AttackLeftHeavy1", "W_AttackBothBackstep", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
        return
    end
end

function AttackBothSpecial2_onUpdate()
    if AttackCommonFunction("W_AttackRightBackstep", "W_AttackRightHeavy1Start", "W_AttackBothLeft1",
        "W_AttackLeftHeavy1", "W_AttackBothBackstep", "W_AttackBothHeavy1Start", FALSE, TRUE, 0) == TRUE then
        return
    end
end

function AttackBothDash_onUpdate()
    local b1 = "W_AttackBothLightSubStart"
    if g_ComboReset == TRUE then
        b1 = "W_AttackBothLight1"
    end
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", b1, "W_AttackBothHeavy1Start", FALSE, TRUE, 1) == TRUE then
        return
    end
end

function AttackBothHeavyDash_onUpdate()
    local b1 = "W_AttackBothLightSubStart"
    if g_ComboReset == TRUE then
        b1 = "W_AttackBothLight1"
    end
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", b1, "W_AttackBothHeavy1Start", FALSE, TRUE, 1) == TRUE then
        return
    end
end

function AttackBothLightStep_onUpdate()
    local b1 = "W_AttackBothLightSubStart"
    if g_ComboReset == TRUE then
        b1 = "W_AttackBothLight1"
    end
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", b1, "W_AttackBothHeavy1Start", FALSE, TRUE, 1) == TRUE then
        return
    end
end

function AttackBothLightStealth_onUpdate()
    local b1 = "W_AttackBothLightSubStart"
    if g_ComboReset == TRUE then
        b1 = "W_AttackBothLight1"
    end
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", b1, "W_AttackBothHeavy1Start", FALSE, TRUE, 1) == TRUE then
        return
    end
end

function AttackBothBackstep_onUpdate()
    local b1 = "W_AttackBothLightSubStart"
    if g_ComboReset == TRUE then
        b1 = "W_AttackBothLight1"
    end
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", b1, "W_AttackBothHeavy1Start", FALSE, TRUE, 1) == TRUE then
        return
    end
end

function AttackBothLightGuard_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", TO_GUARDON, TRUE, 0) == TRUE then
        return
    end
end

function AttackRightLightCounter_onUpdate()
    local r1 = "W_AttackRightLightSubStart"
    if g_ComboReset == TRUE then
        r1 = "W_AttackRightLight1"
    end
    if AttackCommonFunction(r1, "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight2", "W_AttackBothHeavy1Start", FALSE, TRUE, 1) == TRUE then
        return
    end
end

function AttackRightHeavyCounter_onUpdate()
    local r1 = "W_AttackRightLightSubStart"
    local b1 = "W_AttackBothLightSubStart"
    if g_ComboReset == TRUE then
        r1 = "W_AttackRightLight1"
        b1 = "W_AttackBothLight1"
    end
    if AttackCommonFunction(r1, "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1,
        "W_AttackBothHeavy1Start", FALSE, TRUE, 1) == TRUE then
        return
    end
end

function AttackBothLightCounter_onUpdate()
    local r1 = "W_AttackRightLightSubStart"
    local b1 = "W_AttackBothLightSubStart"

    if g_ComboReset == TRUE then
        r1 = "W_AttackRightLight1"
        b1 = "W_AttackBothLight1"
    end

    if AttackCommonFunction(r1, "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLightSubStart", "W_AttackBothHeavy1Start", FALSE, TRUE, 1) == TRUE then
        return
    end
end

function AttackBothHeavyCounter_onUpdate()
    local b1 = "W_AttackBothLightSubStart"
    if g_ComboReset == TRUE then
        b1 = "W_AttackBothLight1"
    end
    if AttackCommonFunction("W_AttackRightLight2", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", b1, "W_AttackBothHeavy1Start", FALSE, TRUE, 1) == TRUE then
        return
    end
end


SetAttackQueue = hookup_function(SetAttackQueue)
ClearAttackQueue = hookup_function(ClearAttackQueue)
SetRightSpecialHeavyAttackGeneratorTransitionIndex = hookup_function(SetRightSpecialHeavyAttackGeneratorTransitionIndex)
GetAttackRequest = hookup_function(GetAttackRequest)
ExecAttack = hookup_function(ExecAttack)
IsEnableNextAttack = hookup_function(IsEnableNextAttack)
GetAttackMaxNumber = hookup_function(GetAttackMaxNumber)
GetDualAttackMaxNumber = hookup_function(GetDualAttackMaxNumber)
IsEnableSpecialAttack = hookup_function(IsEnableSpecialAttack)
IsUseStealthAttack = hookup_function(IsUseStealthAttack)
AttackCommonFunction = hookup_function(AttackCommonFunction)
ChainRecoverCommonFunction = hookup_function(ChainRecoverCommonFunction)
EStepDown_onUpdate = hookup_function(EStepDown_onUpdate)
ChainRecover_Upper_onUpdate = hookup_function(ChainRecover_Upper_onUpdate)
Repelled_Wall_onUpdate = hookup_function(Repelled_Wall_onUpdate)
Repelled_Small_onUpdate = hookup_function(Repelled_Small_onUpdate)
Repelled_Large_onUpdate = hookup_function(Repelled_Large_onUpdate)
AttackRight_Activate = hookup_function(AttackRight_Activate)
AttackRight_Update = hookup_function(AttackRight_Update)
AttackRightWhileGuard_Activate = hookup_function(AttackRightWhileGuard_Activate)
AttackRightLight1_onUpdate = hookup_function(AttackRightLight1_onUpdate)
AttackRightLight2_onUpdate = hookup_function(AttackRightLight2_onUpdate)
AttackRightLight3_onUpdate = hookup_function(AttackRightLight3_onUpdate)
AttackRightLight4_onUpdate = hookup_function(AttackRightLight4_onUpdate)
AttackRightLight5_onUpdate = hookup_function(AttackRightLight5_onUpdate)
AttackRightLight6_onUpdate = hookup_function(AttackRightLight6_onUpdate)
AttackRightLightStep_onUpdate = hookup_function(AttackRightLightStep_onUpdate)
AttackRightLightStealth_onUpdate = hookup_function(AttackRightLightStealth_onUpdate)
AttackRightLightFastStep_onUpdate = hookup_function(AttackRightLightFastStep_onUpdate)
AttackRightLightDash_onUpdate = hookup_function(AttackRightLightDash_onUpdate)
AttackRightHeavyDash_onUpdate = hookup_function(AttackRightHeavyDash_onUpdate)
AttackRightWhileGuard_onUpdate = hookup_function(AttackRightWhileGuard_onUpdate)
AttackRightHeavy1SubStart_onUpdate = hookup_function(AttackRightHeavy1SubStart_onUpdate)
AttackRightLightSubStart_onUpdate = hookup_function(AttackRightLightSubStart_onUpdate)
AttackRightHeavy1Start_onUpdate = hookup_function(AttackRightHeavy1Start_onUpdate)
AttackRightHeavy1End_onUpdate = hookup_function(AttackRightHeavy1End_onUpdate)
AttackRightHeavy2Start_onUpdate = hookup_function(AttackRightHeavy2Start_onUpdate)
AttackRightHeavy2End_onUpdate = hookup_function(AttackRightHeavy2End_onUpdate)
AttackRightHeavySpecial1SubStart_onUpdate = hookup_function(AttackRightHeavySpecial1SubStart_onUpdate)
AttackRightHeavySpecial1Start_onUpdate = hookup_function(AttackRightHeavySpecial1Start_onUpdate)
AttackRightHeavySpecial1End_onUpdate = hookup_function(AttackRightHeavySpecial1End_onUpdate)
AttackRightHeavySpecial2Start_onUpdate = hookup_function(AttackRightHeavySpecial2Start_onUpdate)
AttackRightHeavySpecial2End_onUpdate = hookup_function(AttackRightHeavySpecial2End_onUpdate)
AttackRightSpecial1_onUpdate = hookup_function(AttackRightSpecial1_onUpdate)
AttackRightSpecial2_onUpdate = hookup_function(AttackRightSpecial2_onUpdate)
AttackRightBackstep_onUpdate = hookup_function(AttackRightBackstep_onUpdate)
AttackLeft_Activate = hookup_function(AttackLeft_Activate)
AttackLeft_Update = hookup_function(AttackLeft_Update)
AttackLeft_Deactivate = hookup_function(AttackLeft_Deactivate)
AttackLeftLight1_onUpdate = hookup_function(AttackLeftLight1_onUpdate)
AttackLeftHeavy1_onUpdate = hookup_function(AttackLeftHeavy1_onUpdate)
AttackLeftHeavy2_onUpdate = hookup_function(AttackLeftHeavy2_onUpdate)
AttackLeftHeavy3_onUpdate = hookup_function(AttackLeftHeavy3_onUpdate)
AttackLeftHeavy4_onUpdate = hookup_function(AttackLeftHeavy4_onUpdate)
AttackLeftHeavy5_onUpdate = hookup_function(AttackLeftHeavy5_onUpdate)
AttackLeftHeavy6_onUpdate = hookup_function(AttackLeftHeavy6_onUpdate)
AttackDual_Activate = hookup_function(AttackDual_Activate)
AttackDualLight1_onUpdate = hookup_function(AttackDualLight1_onUpdate)
AttackDualLight2_onUpdate = hookup_function(AttackDualLight2_onUpdate)
AttackDualLight3_onUpdate = hookup_function(AttackDualLight3_onUpdate)
AttackDualLight4_onUpdate = hookup_function(AttackDualLight4_onUpdate)
AttackDualLight5_onUpdate = hookup_function(AttackDualLight5_onUpdate)
AttackDualLight6_onUpdate = hookup_function(AttackDualLight6_onUpdate)
AttackDualDash_onUpdate = hookup_function(AttackDualDash_onUpdate)
AttackDualRolling_onUpdate = hookup_function(AttackDualRolling_onUpdate)
AttackDualStealth_onUpdate = hookup_function(AttackDualStealth_onUpdate)
AttackDualBackStep_onUpdate = hookup_function(AttackDualBackStep_onUpdate)
AttackDualLightSubStart_onUpdate = hookup_function(AttackDualLightSubStart_onUpdate)
AttackBoth_Activate = hookup_function(AttackBoth_Activate)
AttackBothLight1_onUpdate = hookup_function(AttackBothLight1_onUpdate)
AttackBothLight2_onUpdate = hookup_function(AttackBothLight2_onUpdate)
AttackBothLight3_onUpdate = hookup_function(AttackBothLight3_onUpdate)
AttackBothLight4_onUpdate = hookup_function(AttackBothLight4_onUpdate)
AttackBothLight5_onUpdate = hookup_function(AttackBothLight5_onUpdate)
AttackBothLight6_onUpdate = hookup_function(AttackBothLight6_onUpdate)
AttackBothLeft1_onUpdate = hookup_function(AttackBothLeft1_onUpdate)
AttackBothLeft2_onUpdate = hookup_function(AttackBothLeft2_onUpdate)
AttackBothLeft3_onUpdate = hookup_function(AttackBothLeft3_onUpdate)
AttackBothLeftDash_onUpdate = hookup_function(AttackBothLeftDash_onUpdate)
AttackBothLeftStep_onUpdate = hookup_function(AttackBothLeftStep_onUpdate)
AttackBothLeftSpecial1_onUpdate = hookup_function(AttackBothLeftSpecial1_onUpdate)
AttackBothLeftSpecial2_onUpdate = hookup_function(AttackBothLeftSpecial2_onUpdate)
AttackBothLeftSpecial3_onUpdate = hookup_function(AttackBothLeftSpecial3_onUpdate)
AttackBothLeftSpecial4_onUpdate = hookup_function(AttackBothLeftSpecial4_onUpdate)
AttackBothLeftSpecial5_onUpdate = hookup_function(AttackBothLeftSpecial5_onUpdate)
AttackBothLightSubStart_onUpdate = hookup_function(AttackBothLightSubStart_onUpdate)
AttackBothHeavy1SubStart_onUpdate = hookup_function(AttackBothHeavy1SubStart_onUpdate)
AttackBothHeavy1Start_onUpdate = hookup_function(AttackBothHeavy1Start_onUpdate)
AttackBothHeavy1End_onUpdate = hookup_function(AttackBothHeavy1End_onUpdate)
AttackBothHeavy2Start_onUpdate = hookup_function(AttackBothHeavy2Start_onUpdate)
AttackBothHeavy2End_onUpdate = hookup_function(AttackBothHeavy2End_onUpdate)
AttackBothHeavySpecial1SubStart_onUpdate = hookup_function(AttackBothHeavySpecial1SubStart_onUpdate)
AttackBothHeavySpecial1Start_onUpdate = hookup_function(AttackBothHeavySpecial1Start_onUpdate)
AttackBothHeavySpecial1End_onUpdate = hookup_function(AttackBothHeavySpecial1End_onUpdate)
AttackBothHeavySpecial2Start_onUpdate = hookup_function(AttackBothHeavySpecial2Start_onUpdate)
AttackBothHeavySpecial2End_onUpdate = hookup_function(AttackBothHeavySpecial2End_onUpdate)
AttackBothSpecial1_onUpdate = hookup_function(AttackBothSpecial1_onUpdate)
AttackBothSpecial2_onUpdate = hookup_function(AttackBothSpecial2_onUpdate)
AttackBothDash_onUpdate = hookup_function(AttackBothDash_onUpdate)
AttackBothHeavyDash_onUpdate = hookup_function(AttackBothHeavyDash_onUpdate)
AttackBothLightStep_onUpdate = hookup_function(AttackBothLightStep_onUpdate)
AttackBothLightStealth_onUpdate = hookup_function(AttackBothLightStealth_onUpdate)
AttackBothBackstep_onUpdate = hookup_function(AttackBothBackstep_onUpdate)
AttackBothLightGuard_onUpdate = hookup_function(AttackBothLightGuard_onUpdate)
AttackRightLightCounter_onUpdate = hookup_function(AttackRightLightCounter_onUpdate)
AttackRightHeavyCounter_onUpdate = hookup_function(AttackRightHeavyCounter_onUpdate)
AttackBothLightCounter_onUpdate = hookup_function(AttackBothLightCounter_onUpdate)
AttackBothHeavyCounter_onUpdate = hookup_function(AttackBothHeavyCounter_onUpdate)
