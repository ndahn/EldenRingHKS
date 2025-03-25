
function IsUseStaminaItem(item_type)
    if item_type == ITEM_THROW_KNIFE or item_type == ITEM_THROW_BOTTLE or item_type == ITEM_QUICK_THROW_KNIFE or
        item_type == ITEM_THROW_SPEAR then
        return TRUE
    end
    return FALSE
end

function ExecItem(quick_type, blend_type)
    if c_HasActionRequest == FALSE then
        return FALSE
    end
    if env(ActionRequest, ACTION_ARM_USE_ITEM) == FALSE then
        return FALSE
    end
    if env(IsItemUseMenuOpened) == TRUE then
        return FALSE
    end
    if env(IsItemUseMenuOpening) == TRUE then
        ResetRequest()
        act(OpenMenuWhenUsingItem)
        return TRUE
    end

    act(UseItemDecision)

    local item_type = env(GetItemAnimType)
    local hand = HAND_RIGHT
    local kind = env(GetEquipWeaponCategory, hand)

    if IsUseStaminaItem(item_type) == TRUE and env(GetStamina) <= 0 then
        return FALSE
    end
    if blend_type == ALLBODY then
        if c_IsStealth == TRUE then
            if MoveStart(LOWER, Event_Stealth_Move, FALSE) == TRUE then
                blend_type = UPPER
            end
        elseif MoveStart(LOWER, Event_Move, FALSE) == TRUE then
            blend_type = UPPER
        end
    end

    if c_IsStealth == TRUE then
        if ExecStealthItem(blend_type, item_type) == TRUE then
            return TRUE
        end
        blend_type = ALLBODY
    end

    if item_type == ITEM_RECOVER then
        ExecEventHalfBlend(Event_ItemRecover, blend_type)
    elseif item_type == ITEM_WEAPON_ENCHANT then
        if kind == WEAPON_CATEGORY_BACKHAND_SWORD then
            SetVariable("ItemWeaponType", 1)
        elseif kind == WEAPON_CATEGORY_DUELING_SHIELD then
            SetVariable("ItemWeaponType", 2)
        else
            SetVariable("ItemWeaponType", 0)
        end
        ExecEventHalfBlend(Event_ItemWeaponEnchant, blend_type)
    elseif item_type == ITEM_THROW_KNIFE then
        ExecEventHalfBlend(Event_ItemThrowKnife, blend_type)
    elseif item_type == ITEM_THROW_BOTTLE then
        ExecEventHalfBlend(Event_ItemThrowBottle, blend_type)
    elseif item_type == ITEM_MEGANE then
        if env(GetStateChangeType, 15) == TRUE then
            ExecEventHalfBlend(Event_ItemMeganeEnd, ALLBODY)
        else
            ExecEventHalfBlend(Event_ItemMeganeStart, ALLBODY)
        end
    elseif item_type == ITEM_REPAIR then
        ExecEventHalfBlend(Event_ItemWeaponRepair, ALLBODY)
    elseif item_type == ITEM_PRAY then
        ExecEventHalfBlend(Event_ItemPrayMulti, blend_type)
    elseif item_type == ITEM_TRAP then
        ExecEventHalfBlend(Event_ItemTrap, blend_type)
    elseif item_type == ITEM_MESSAGE then
        ExecEventHalfBlend(Event_ItemMessage, ALLBODY)
    elseif item_type == ITEM_SOUL then
        ExecEventHalfBlend(Event_ItemSoul, blend_type)
    elseif item_type == ITEM_DRINK then
        if env(GetStateChangeType, CONDITION_TYPE_NO_EST) == TRUE then
            ExecEventHalfBlend(Event_ItemDrinkNothing, blend_type)
        elseif IsNodeActive("ItemDrinking_Upper_CMSG") == TRUE then
            SetInterruptType(INTERRUPT_USEITEM)
            ExecEventHalfBlend(Event_ItemDrinking, blend_type)
        else
            SetInterruptType(INTERRUPT_USEITEM)
            ExecEventHalfBlend(Event_ItemDrinkStart, blend_type)
        end
    elseif item_type == ITEM_TRANSFORM_DRAGONPRIEST then
        if env(GetSpEffectID, 19980) == TRUE or env(GetSpEffectID, 19981) == TRUE then
            SetVariable("ItemTransformType", 1)
        else
            SetVariable("ItemTransformType", 0)
        end
        ExecEventHalfBlend(Event_ItemTransformDragonPriest, blend_type)
    elseif item_type == ITEM_DRAGONTHROWSPEAR then
        ExecEventHalfBlend(Event_ItemDragonThrowSpearMax, blend_type)
    elseif item_type == ITEM_SHOCK_WAVE then
        ExecEventHalfBlend(Event_ItemShockWeaveStart, blend_type)
    elseif item_type == ITEM_THORN then
        ExecEventHalfBlend(Event_ItemThorn, blend_type)
    elseif item_type == ITEM_QUICK_WEAPON_ENCHANT then
        if kind == WEAPON_CATEGORY_DUELING_SHIELD then
            SetVariable("ItemWeaponType", 1)
        else
            SetVariable("ItemWeaponType", 0)
        end
        if quick_type == QUICKTYPE_NORMAL or quick_type == QUICKTYPE_RUN then
            ExecEventHalfBlend(Event_QuickItemEnchantNormal, blend_type)
        elseif quick_type == QUICKTYPE_DASH then
            ExecEventHalfBlend(Event_QuickItemEnchantDash, blend_type)
        elseif quick_type == QUICKTYPE_ROLLING or quick_type == QUICKTYPE_BACKSTEP then
            ExecEventHalfBlend(Event_QuickItemEnchantStep, blend_type)
        elseif quick_type == QUICKTYPE_ATTACK then
            if ForwardLeg() == 1 then
                ExecEventHalfBlend(Event_QuickItemEnchantAttackRight, blend_type)
            else
                ExecEventHalfBlend(Event_QuickItemEnchantAttackLeft, blend_type)
            end
        else
            return FALSE
        end
    elseif item_type == ITEM_QUICK_THROW_KNIFE then
        if quick_type == QUICKTYPE_NORMAL or quick_type == QUICKTYPE_RUN then
            ExecEventHalfBlend(Event_QuickItemThrowKnifeNormal, ALLBODY)
        elseif quick_type == QUICKTYPE_DASH then
            ExecEventHalfBlend(Event_QuickItemThrowKnifeDash, ALLBODY)
        elseif quick_type == QUICKTYPE_ROLLING or quick_type == QUICKTYPE_BACKSTEP then
            ExecEventHalfBlend(Event_QuickItemThrowKnifeStep, ALLBODY)
        elseif quick_type == QUICKTYPE_ATTACK then
            if ForwardLeg() == 1 then
                ExecEventHalfBlend(Event_QuickItemThrowKnifeAttackRight, ALLBODY)
            else
                ExecEventHalfBlend(Event_QuickItemThrowKnifeAttackLeft, ALLBODY)
            end
        elseif quick_type == QUICKTYPE_COMBO then
            if ForwardLeg() == 1 then
                ExecEventHalfBlend(Event_QuickItemThrowKnifeAttackRight2, ALLBODY)
            else
                ExecEventHalfBlend(Event_QuickItemThrowKnifeAttackLeft2, ALLBODY)
            end
        else
            return FALSE
        end
    elseif item_type == ITEM_QUICK_THROW_BOTTLE then
        return FALSE
    elseif item_type == ITEM_SWITCH_EXPLOSIVE then
        ExecEventHalfBlend(Event_ItemSwitchExplosive, blend_type)
    elseif item_type == ITEM_DRINK_MP then
        if env(GetStateChangeType, CONDITION_TYPE_NO_EST) == TRUE then
            ExecEventHalfBlend(Event_ItemDrinkNothing, blend_type)
        elseif IsNodeActive("ItemDrinkingMP_Upper_CMSG") == TRUE then
            SetInterruptType(INTERRUPT_USEITEM)
            ExecEventHalfBlend(Event_ItemDrinkingMP, blend_type)
        else
            SetInterruptType(INTERRUPT_USEITEM)
            ExecEventHalfBlend(Event_ItemDrinkStartMP, blend_type)
        end
    elseif item_type == ITEM_STRING_BOTTLE then
        ExecEventHalfBlend(Event_ItemThrowBackBottle, blend_type)
    elseif item_type == ITEM_CRY_SICKNESS then
        ExecEventHalfBlend(Event_ItemCrySickness, blend_type)
    elseif item_type == ITEM_CRY_SICKNESS_PHANTOM then
        ExecEventHalfBlend(Event_ItemCrySicknessPhantom, blend_type)
    elseif item_type == ITEM_TRANSFORM_GODMAN then
        if env(GetSpEffectID, 19982) == TRUE or env(GetSpEffectID, 19983) == TRUE then
            SetVariable("ItemTransformType", 1)
        else
            SetVariable("ItemTransformType", 0)
        end
        ExecEventHalfBlend(Event_ItemTransformGodman, blend_type)
    elseif item_type == 25 then
        ExecEventHalfBlend(Event_ItemDragonFullStartAfter, blend_type)
    elseif item_type == 26 then
        ExecEventHalfBlend(Event_ItemEatJerky, blend_type)
    elseif item_type == 27 then
        if env(GetSpEffectID, 3245) == TRUE then
            ExecEventHalfBlend(Event_ItemLanternOff, blend_type)
        else
            ExecEventHalfBlend(Event_ItemLanternOn, blend_type)
        end
    elseif item_type == ITEM_ELIXIR then
        SetInterruptType(INTERRUPT_USEITEM)
        ExecEventHalfBlend(Event_ItemElixir, blend_type)
    elseif item_type == ITEM_HORN then
        ExecEventHalfBlend(Event_ItemHorn, blend_type)
    elseif item_type == ITEM_COPY_SLEEP then
        ExecEventHalfBlend(Event_ItemCopySleep, blend_type)
    elseif item_type == ITEM_VOICE then -- Duplicate Condition #1
        ExecEventHalfBlend(Event_ItemVoice, blend_type)
    elseif item_type == ITEM_SUMMONHORSE then
        SetVariable("RideOnSummonTest", 0)
        SetVariable("IndexItemUseAnim", item_type)
        SetVariable("ItemDashSpeedIndex", 0)

        if GetVariable("MoveSpeedIndex") >= 1 then
            SetVariable("ItemDashSpeedIndex", 1)
        end
        if GetVariable("MoveSpeedLevel") >= 0.8999999761581421 then
            IsSummonDash = TRUE
        else
            IsSummonDash = FALSE
        end

        ExecEventHalfBlend(Event_ItemDash, blend_type)
    elseif item_type == ITEM_VOICE then -- Duplicate Condition #2
        ExecEventHalfBlend(Event_ItemReturnBuddy, blend_type)
    elseif item_type == ITEM_SUMMONBUDDY then
        ExecEventHalfBlend(Event_ItemSummonBuddy, blend_type)
    elseif item_type == ITEM_HOST then
        ExecEventHalfBlend(Event_ItemHost, blend_type)
    elseif item_type == ITEM_MULTIKICK then
        ExecEventHalfBlend(Event_ItemMultKick, blend_type)
    elseif item_type == ITEM_TONGUE then
        ExecEventHalfBlend(Event_ItemTongue, blend_type)
    elseif item_type == ITEM_HOLYSYMBOL then
        ExecEventHalfBlend(Event_ItemHolySymbol, blend_type)
    elseif item_type == ITEM_ELIXIR2 then
        SetInterruptType(INTERRUPT_USEITEM)
        ExecEventHalfBlend(Event_ItemElixir2, blend_type)
    elseif item_type == ITEM_DANCING_SWORDSMAN_FIRE then
        ExecEventHalfBlend(Event_ItemDancingSwordsmanFire, blend_type)
    elseif item_type == ITEM_SWITCH then
        ExecEventHalfBlend(Event_ItemSwitch, blend_type)
    elseif item_type == ITEM_ERDTREE then
        ExecEventHalfBlend(Event_ItemErdtree, blend_type)
    elseif item_type == ITEM_NIGHT_BELL then
        -- 100800 "[HKS] Item Combo Window"
        local is_combo = env(GetSpEffectID, 100800)

        if is_combo == TRUE then
            ExecEventHalfBlend(Event_ItemCombo, blend_type)
        elseif IsNodeActive("ItemOneshot_Upper") == TRUE then
            SetVariable("IndexItemUseAnim_SelfTrans", item_type)
            ExecEventHalfBlend(Event_ItemOneShot_SelfTrans, blend_type)
        else
            SetVariable("IndexItemUseAnim", item_type)
            ExecEventHalfBlend(Event_ItemOneShot, blend_type)
        end
    elseif item_type == 52 then
        ResetMimicry()
        if IsNodeActive("ItemOneshot_Upper") == TRUE then
            SetVariable("IndexItemUseAnim_SelfTrans", item_type)
            ExecEventHalfBlend(Event_ItemOneShot_SelfTrans, blend_type)
        else
            SetVariable("IndexItemUseAnim", item_type)
            ExecEventHalfBlend(Event_ItemOneShot, blend_type)
        end
    elseif item_type == ITEM_THROW_BIGBOTTLE then
        ExecEventHalfBlend(Event_ItemThrowBigBottle, blend_type)
    elseif item_type == ITEM_TRANSFORM_GODMAN_NPC then
        ExecEventHalfBlend(Event_ItemTransformGodmanNPC, blend_type)
    elseif item_type == ITEM_TRANSFORM_GODMANBREATH_NPC then
        ExecEventHalfBlend(Event_ItemTransformGodmanBreathNPC, blend_type)
    elseif item_type == ITEM_AROMAWIDE then
        ExecEventHalfBlend(Event_ItemAromaWide, blend_type)
    elseif item_type == ITEM_AROMAUP then
        ExecEventHalfBlend(Event_ItemAromaUp, blend_type)
    elseif item_type == ITEM_AROMAFRONT then
        ExecEventHalfBlend(Event_ItemAromaFront, blend_type)
    elseif item_type == ITEM_AROMADRINK then
        ExecEventHalfBlend(Event_ItemAromaDrink, blend_type)
    elseif item_type == ITEM_AROMABREATH then
        ExecEventHalfBlend(Event_ItemAromaBreath, blend_type)
    elseif item_type == ITEM_NO_DRINK then
        if IsNodeActive("ItemDrinkingMP_Upper_CMSG") == TRUE or IsNodeActive("ItemDrinking_Upper_CMSG") == TRUE then
            if blend_type == ALLBODY and MoveStart(LOWER, Event_MoveLong, FALSE) == TRUE then
                blend_type = UPPER
            end
            ExecEventHalfBlend(Event_ItemDrinkEmpty, blend_type)
        else
            ExecEventHalfBlend(Event_ItemDrinkStart, blend_type)
        end
    elseif item_type == ITEM_INVALID then
        ExecEventHalfBlend(Event_ItemInvalid, blend_type)
    elseif IsNodeActive("ItemOneshot_Upper") == TRUE then
        SetVariable("IndexItemUseAnim_SelfTrans", item_type)
        ExecEventHalfBlend(Event_ItemOneShot_SelfTrans, blend_type)
    else
        SetVariable("IndexItemUseAnim", item_type)
        ExecEventHalfBlend(Event_ItemOneShot, blend_type)
    end

    act(SetIsItemAnimationPlaying)
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    SetAIActionState()

    return TRUE
end

function ExecStealthItem(blend_type, item_type)
    if item_type ~= ITEM_RECOVER and item_type ~= ITEM_SOUL and item_type ~= ITEM_DRINK and item_type ~= ITEM_DRINK_MP and
        item_type ~= ITEM_NO_DRINK and item_type ~= ITEM_EATJERKY and item_type ~= ITEM_ELIXIR and item_type ~=
        ITEM_SUMMONBUDDY and item_type ~= ITEM_RETURNBUDDY and item_type ~= ITEM_ELIXIR2 and item_type ~= ITEM_INVALID then
        return FALSE
    end
    if blend_type == ALLBODY and MoveStart(LOWER, Event_Stealth_Move, FALSE) == TRUE then
        blend_type = UPPER
    end

    -- Flasks
    if item_type == ITEM_DRINK or item_type == ITEM_DRINK_MP then
        if env(GetStateChangeType, CONDITION_TYPE_NO_EST) == TRUE then
            ExecEventHalfBlend(Event_StealthItemDrinkNothing, blend_type)
        elseif IsNodeActive("StealthItemDrinking_Upper_CMSG") == TRUE then
            SetInterruptType(INTERRUPT_USEITEM)
            ExecEventHalfBlend(Event_StealthItemDrinking, blend_type)
        else
            SetInterruptType(INTERRUPT_USEITEM)
            ExecEventHalfBlend(Event_StealthItemDrinkStart, blend_type)
        end
    elseif item_type == ITEM_NO_DRINK then
        if IsNodeActive("StealthItemDrinkingMP_Upper_CMSG") == TRUE or IsNodeActive("StealthItemDrinking_Upper_CMSG") ==
            TRUE then
            ExecEventHalfBlend(Event_StealthItemDrinkEmpty, blend_type)
        else
            ExecEventHalfBlend(Event_StealthItemDrinkStart, blend_type)
        end
    elseif IsNodeActive("StealthItemOneShot_Blend") == TRUE then
        SetVariable("IndexItemUseAnim_SelfTrans", item_type)
        ExecEventHalfBlend(Event_StealthItemOneShot_SelfTrans, blend_type)
    else
        SetVariable("IndexItemUseAnim", item_type)
        ExecEventHalfBlend(Event_StealthItemOneShot, blend_type)
    end

    act(SetIsItemAnimationPlaying)
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    SetAIActionState()

    return TRUE
end

function ExecLadderItem(hand)
    if c_HasActionRequest == FALSE then
        return FALSE
    end
    if env(ActionRequest, ACTION_ARM_USE_ITEM) == FALSE then
        return FALSE
    end
    if env(IsItemUseMenuOpened) == TRUE then
        return FALSE
    end
    if env(IsItemUseMenuOpening) == TRUE then
        ResetRequest()
        act(OpenMenuWhenUsingItem)
        return TRUE
    end

    act(UseItemDecision)

    local item_type = env(GetItemAnimType)
    local event = "W_ItemLadderInvalid"
    local event_hand = "Left"

    if hand == HAND_STATE_RIGHT then
        event_hand = "Right"
    end

    if item_type == ITEM_RECOVER then
        event = "W_ItemLadderRecover"
    elseif item_type == ITEM_SOUL then
        event = "W_ItemLadderSoul"
    elseif item_type == ITEM_EATJERKY then
        event = "W_ItemLadderEatJerky"
    elseif item_type == ITEM_ELIXIR then
        event = "W_ItemLadderElixir"
    elseif item_type == ITEM_ELIXIR2 then
        event = "W_ItemLadderElixir2"
    elseif item_type == ITEM_DRINK then
        if env(GetStateChangeType, CONDITION_TYPE_NO_EST) == TRUE then
            event = "W_ItemLadderDrinkNothing"
        elseif IsNodeActive("ItemLadderDrinkingRight_CMSG") == TRUE then
            event = "W_ItemLadderDrinking"
            event_hand = "Right"
        elseif IsNodeActive("ItemLadderDrinkingLeft_CMSG") == TRUE then
            event = "W_ItemLadderDrinking"
            event_hand = "Left"
        else
            event = "W_ItemLadderDrinkStart"
        end
    elseif item_type == ITEM_DRINK_MP then
        if env(GetStateChangeType, CONDITION_TYPE_NO_EST) == TRUE then
            event = "W_ItemLadderDrinkNothing"
        elseif IsNodeActive("ItemLadderDrinkingRight_CMSG00") == TRUE then
            event = "W_ItemLadderDrinkingMP"
            event_hand = "Right"
        elseif IsNodeActive("ItemLadderDrinkingLeft_CMSG00") == TRUE then
            event = "W_ItemLadderDrinkingMP"
            event_hand = "Left"
        else
            event = "W_ItemLadderDrinkMPStart"
        end
    elseif item_type == ITEM_NO_DRINK then
        if IsNodeActive("ItemLadderDrinkingMPRight_CMSG") == TRUE or IsNodeActive("ItemLadderDrinkingRight_CMSG") ==
            TRUE then
            event = "W_ItemLadderDrinkEmpty"
            event_hand = "Right"
        elseif IsNodeActive("ItemLadderDrinkingLeft_CMSG") == TRUE or IsNodeActive("ItemLadderDrinkingMPLeft_CMSG") ==
            TRUE then
            event = "W_ItemLadderDrinkEmpty"
            event_hand = "Left"
        else
            event = "W_ItemLadderDrinkStart"
        end
    end

    act(SetIsItemAnimationPlaying)
    ExecEvent(event .. event_hand)

    return TRUE
end

----------------------
-- Common functions --
----------------------

function ItemCommonFunction(blend_type)
    act(SetCanChangeEquipmentOff)
    if env(GetStateChangeType, 15) == FALSE then
        act(SetIsItemAnimationPlaying)
    end

    if GetVariable("IsEnableToggleDashTest") == 2 then
        SetVariable("ToggleDash", 0)
    end

    if GetVariable("MoveSpeedLevel") <= 0 then
        act(FallPreventionAssist)
    end

    SetAIActionState()

    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
        return TRUE
    end
    if blend_type ~= UPPER and ExecQuickTurn(LOWER, TURN_TYPE_DEFAULT) == TRUE then
        return TRUE
    end
    if ExecJump() == TRUE then
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, blend_type) == TRUE then
        return TRUE
    end
    if ExecGuardOnCancelTiming(FALSE, blend_type) == TRUE then
        return TRUE
    end
    if ExecWeaponChange(blend_type) == TRUE then
        return TRUE
    end
    if ExecEvasion(FALSE, ESTEP_NONE, FALSE) == TRUE then
        return TRUE
    end
    if ExecArtsStanceOnCancelTiming(blend_type) == TRUE then
        return TRUE
    end
    if ExecAttack("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, blend_type, FALSE, FALSE, FALSE) == TRUE then
        return TRUE
    end
    if ExecItem(QUICKTYPE_NORMAL, blend_type) == TRUE then
        return TRUE
    end
    if ExecMagic(QUICKTYPE_NORMAL, blend_type, FALSE) == TRUE then
        return TRUE
    end
    if MoveStartonCancelTiming(Event_Move, FALSE) == TRUE then
        return TRUE
    end
    return FALSE
end

function StealthItemCommonFunction(blend_type)
    act(SetIsItemAnimationPlaying)

    if GetVariable("IsEnableToggleDashTest") == 2 then
        SetVariable("ToggleDash", 0)
    end

    if GetVariable("MoveSpeedLevel") <= 0 then
        act(FallPreventionAssist)
    end

    SetAIActionState()

    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
        return TRUE
    end
    if blend_type ~= UPPER and ExecQuickTurn(LOWER, TURN_TYPE_DEFAULT) == TRUE then
        return TRUE
    end
    if ExecJump() == TRUE then
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, blend_type) == TRUE then
        return TRUE
    end
    if ExecGuardOnCancelTiming(FALSE, blend_type) == TRUE then
        return TRUE
    end
    if ExecWeaponChange(blend_type) == TRUE then
        return TRUE
    end
    if ExecEvasion(FALSE, ESTEP_NONE, FALSE) == TRUE then
        return TRUE
    end
    if ExecArtsStanceOnCancelTiming(blend_type) == TRUE then
        return TRUE
    end
    if ExecAttack("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, blend_type, FALSE, FALSE, FALSE) == TRUE then
        return TRUE
    end
    if ExecItem(QUICKTYPE_NORMAL, blend_type) == TRUE then
        return TRUE
    end
    if ExecMagic(QUICKTYPE_NORMAL, blend_type, FALSE) == TRUE then
        return TRUE
    end
    if MoveStartonCancelTiming(Event_Stealth_Move, FALSE) == TRUE then
        act(DebugLogOutput, "StealthItemCommonFunction MoveStartonCancelTiming")
        return TRUE
    end
    return FALSE
end

function QuickItemCommonFunction(g_r1, g_r2, g_l1, g_l2, g_b1, g_b2, blend_type, quick_type)
    act(SetIsItemAnimationPlaying)

    if GetVariable("MoveSpeedLevel") <= 0 then
        act(FallPreventionAssist)
    end

    SetAIActionState()

    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
        ClearAttackQueue()
        return TRUE
    end
    if ExecJump() == TRUE then
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, blend_type) == TRUE then
        ClearAttackQueue()
        return TRUE
    end
    if ExecGuardOnCancelTiming(FALSE, blend_type) == TRUE then
        ClearAttackQueue()
        return TRUE
    end
    if ExecWeaponChange(blend_type) == TRUE then
        ClearAttackQueue()
        return TRUE
    end
    if ExecEvasion(FALSE, ESTEP_NONE, FALSE) == TRUE then
        ClearAttackQueue()
        return TRUE
    end
    if ExecArtsStanceOnCancelTiming(blend_type) == TRUE then
        ClearAttackQueue()
        return TRUE
    end
    if ExecAttack(g_r1, g_r2, g_l1, g_l2, g_b1, g_b2, FALSE, blend_type, FALSE, FALSE, FALSE) == TRUE then
        ClearAttackQueue()
        return TRUE
    end
    if ExecItem(quick_type, blend_type) == TRUE then
        ClearAttackQueue()
        return TRUE
    end
    if ExecMagic(QUICKTYPE_ATTACK, ALLBODY, FALSE) == TRUE then
        ClearAttackQueue()
        return TRUE
    end
    if MoveStartonCancelTiming(Event_Move, FALSE) == TRUE then
        ClearAttackQueue()
        return TRUE
    end
    return FALSE
end

--------------
-- Triggers --
--------------

function Item_Upper_Activate()
    ActivateRightArmAdd(START_FRAME_NONE)
end

function Item_Upper_Update()
    UpdateRightArmAdd()
end

function QuickItemEnchantNormal_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if QuickItemCommonFunction(g_r1, g_r2, g_l1, g_l2, g_b1, g_b2, blend_type, QUICKTYPE_NORMAL) == TRUE then
        return
    end
    if blend_type ~= UPPER and ExecQuickTurn(LOWER, TURN_TYPE_DEFAULT) == TRUE then
        return TRUE
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        ClearAttackQueue()
        return
    end
    if HalfBlendLowerCommonFunction(Event_QuickItemEnchantNormal, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function QuickItemEnchantDash_Upper_onActivate()
    act(LockonFixedAngleCancel)
end

function QuickItemEnchantDash_Upper_onUpdate()
    act(LockonFixedAngleCancel)
    local r1 = "W_AttackRightLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b1 = "W_AttackBothLight1"
    local b2 = "W_AttackBothHeavy1Start"
    if GetVariable("MoveSpeedIndex") >= 1 then
        r1 = "W_AttackRightLightDash"
        r2 = "W_AttackRightHeavyDash"
        b1 = "W_AttackBothDash"
        b2 = "W_AttackBothHeavyDash"
    end
    local blend_type, lower_state = GetHalfBlendInfo()
    if QuickItemCommonFunction(r1, r2, g_l1, g_l2, b1, b2, blend_type, QUICKTYPE_NORMAL) == TRUE then
        return
    end
    if env(GetSpEffectID, 100220) == FALSE and
        HalfBlendLowerCommonFunction(Event_StopHalfBlendDashStop, lower_state, FALSE) == TRUE then
        SetVariable("MoveSpeedLevelReal", 0)
        return
    end
    if env(IsMoveCancelPossible) == TRUE then
        ExecEvent("W_Idle")
        return
    end
end

function QuickItemEnchantStep_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()

    if QuickItemCommonFunction(g_r1, g_r2, g_l1, g_l2, g_b1, g_b2, blend_type, QUICKTYPE_NORMAL) == TRUE then
        return
    end

    if blend_type ~= UPPER and ExecQuickTurn(LOWER, TURN_TYPE_DEFAULT) == TRUE then
        return TRUE
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        ClearAttackQueue()
        return
    end

    if HalfBlendLowerCommonFunction(Event_QuickItemEnchantStep, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function QuickItemEnchantAttackRight_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()

    if QuickItemCommonFunction(g_r1, g_r2, g_l1, g_l2, g_b1, g_b2, blend_type, QUICKTYPE_NORMAL) == TRUE then
        return
    end

    if blend_type ~= UPPER and ExecQuickTurn(LOWER, TURN_TYPE_DEFAULT) == TRUE then
        return TRUE
    end

    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        ClearAttackQueue()
        return
    end

    if HalfBlendLowerCommonFunction(Event_QuickItemEnchantAttackRight, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function QuickItemEnchantAttackLeft_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()

    if QuickItemCommonFunction(g_r1, g_r2, g_l1, g_l2, g_b1, g_b2, blend_type, QUICKTYPE_NORMAL) == TRUE then
        return
    end

    if blend_type ~= UPPER and ExecQuickTurn(LOWER, TURN_TYPE_DEFAULT) == TRUE then
        return TRUE
    end

    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        ClearAttackQueue()
        return
    end

    if HalfBlendLowerCommonFunction(Event_QuickItemEnchantAttackLeft, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function QuickItemThrowKnifeNormal_Upper_onUpdate()
    if QuickItemCommonFunction(g_r1, g_r2, g_l1, g_l2, g_b1, g_b2, ALLBODY, QUICKTYPE_COMBO) == TRUE then
        return
    end
end

function QuickItemThrowKnifeDash_Upper_onUpdate()
    if QuickItemCommonFunction(g_r1, g_r2, g_l1, g_l2, g_b1, g_b2, ALLBODY, QUICKTYPE_COMBO) == TRUE then
        return
    end
end

function QuickItemThrowKnifeStep_Upper_onUpdate()
    if QuickItemCommonFunction(g_r1, g_r2, g_l1, g_l2, g_b1, g_b2, ALLBODY, QUICKTYPE_COMBO) == TRUE then
        return
    end
end

function QuickItemThrowKnifeAttackRight_Upper_onUpdate()
    if QuickItemCommonFunction(g_r1, g_r2, g_l1, g_l2, g_b1, g_b2, ALLBODY, QUICKTYPE_COMBO) == TRUE then
        return
    end
end

function QuickItemThrowKnifeAttackRight2_Upper_onUpdate()
    if QuickItemCommonFunction(g_r1, g_r2, g_l1, g_l2, g_b1, g_b2, ALLBODY, QUICKTYPE_ATTACK) == TRUE then
        return
    end
end

function QuickItemThrowKnifeAttackLeft_Upper_onUpdate()
    if QuickItemCommonFunction(g_r1, g_r2, g_l1, g_l2, g_b1, g_b2, ALLBODY, QUICKTYPE_COMBO) == TRUE then
        return
    end
end

function QuickItemThrowKnifeAttackLeft2_Upper_onUpdate()
    if QuickItemCommonFunction(g_r1, g_r2, g_l1, g_l2, g_b1, g_b2, ALLBODY, QUICKTYPE_ATTACK) == TRUE then
        return
    end
end

function ItemRecover_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemRecover, lower_state, FALSE) == TRUE then
        return
    end
end

function ItemEatJerky_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemRecover, lower_state, FALSE) == TRUE then
        return
    end
end

function ItemLanternOn_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemRecover, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemLanternOff_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemRecover, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemElixir_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemRecover, lower_state, FALSE) == TRUE then
        return
    end
end

function ItemHorn_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemRecover, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemWeaponEnchant_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemWeaponEnchant, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemThrowKnife_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemThrowKnife, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemThrowBottle_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemThrowBottle, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemMeganeStart_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        act(RemoveBinoculars)
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        ExecEventHalfBlend(Event_ItemMeganeLoop, blend_type)
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemMeganeStart, lower_state, FALSE, TRUE) == TRUE then
        act(RemoveBinoculars)
        return
    end
end

function ItemMeganeLoop_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        act(RemoveBinoculars)
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemMeganeLoop, lower_state, FALSE) == TRUE then
        act(RemoveBinoculars)
        return
    end
end

function ItemMeganeEnd_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemMeganeEnd, lower_state, FALSE) == TRUE then
        return
    end
end

function ItemWeaponRepair_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemWeaponRepair, lower_state, FALSE) == TRUE then
        return
    end
end

function ItemSoul_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemSoul, lower_state, FALSE) == TRUE then
        return
    end
end

function ItemMessage_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemMessage, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemPray_Upper_onUpdate()
    act(SetAllowedThrowDefenseType, 255)
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if GetVariable("RideOnSummonTest") == 1 then
        if env(IsMovingOnMount) == TRUE then
            FireRideEvent("W_RideOn", "W_RideOn", FALSE)
            return TRUE
        elseif env(IsIdleOnMount) == TRUE then
            ExecEventAllBody("W_Idle")
            return TRUE
        end
    elseif env(IsSummoningRide) == TRUE then
        if env(IsNewRidingTest) == TRUE then
            SetVariable("RideOnSummonTest", 1)
            FireRideEvent("W_RideOn", "W_RideOn", FALSE)
        else
            SetVariable("RideOnSummonTest", 0)
            ExecEventAllBody("W_RideAdjustFromCalling")
        end
        return TRUE
    elseif env(GetEventEzStateFlag, 0) == TRUE then
        act(Mounting)
        return TRUE
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemPray, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemTrap_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemTrap, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemDrinkStart_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    local isEnd = env(IsAnimEnd, 1)
    if env(GetEventEzStateFlag, 0) == TRUE or isEnd == TRUE then
        local item_type = env(GetItemAnimType)
        if item_type ~= ITEM_NO_DRINK then
            ExecEventHalfBlendNoReset(Event_ItemDrinking, blend_type)
            return
        elseif item_type == ITEM_NO_DRINK and isEnd == TRUE then
            ExecEventHalfBlendNoReset(Event_ItemDrinkEmpty, blend_type)
            return
        end
    end
    if HalfBlendLowerCommonFunction(Event_ItemDrinkStart, lower_state, FALSE) == TRUE then
        return
    end
end

function ItemDrinkNothing_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemDrinkNothing, lower_state, FALSE) == TRUE then
        return
    end
end

function ItemDrinking_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        ExecEventHalfBlendNoReset(Event_ItemDrinkEnd, blend_type)
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemDrinking, lower_state, FALSE) == TRUE then
        return
    end
end

function ItemDrinkEnd_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemDrinkEnd, lower_state, FALSE) == TRUE then
        return
    end
end

function ItemShockWeaveStart_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemShockWeaveStart, lower_state, FALSE) == TRUE then
        return
    end
end

function ItemShockWeaveEnd_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemShockWeaveEnd, lower_state, FALSE) == TRUE then
        return
    end
end

function ItemDrinkStartMP_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if env(GetEventEzStateFlag, 0) == TRUE then
        ExecEventHalfBlendNoReset(Event_ItemDrinkingMP, blend_type)
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemDrinkStartMP, lower_state, FALSE) == TRUE then
        return
    end
end

function ItemDrinkingMP_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        ExecEventHalfBlendNoReset(Event_ItemDrinkEnd, blend_type)
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemDrinkingMP, lower_state, FALSE) == TRUE then
        return
    end
end

function ItemThrowSpear_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemThrowSpear, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function DragonFullStartAfter_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemThrowSpear, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemPrayMulti_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemPrayMulti, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemReturnBuddy_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemReturnBuddy, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemSummonBuddy_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemSummonBuddy, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemCopySleep_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemCopySleep, lower_state, FALSE) == TRUE then
        return
    end
end

function ItemVoice_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemVoice, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemHolySymbol_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemHolySymbol, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemHost_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemHost, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemMultKick_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemMultKick, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemTongue_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemTongue, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemThrowBackBottle_Upper_onUpdate()
    act(LockonFixedAngleCancel)
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemThrowBackBottle, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemAromaWide_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemAromaWide, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemAromaUp_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemAromaUp, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemAromaBreath_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemAromaBreath, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemAromaDrink_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemAromaDrink, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemAromaFront_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemAromaFront, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemDrinkEmpty_Upper_onActivate()
    if env(IsCOMPlayer) == TRUE then
        act(AddSpEffect, 5630)
    end
end

function ItemDrinkEmpty_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemDrinkEmpty, lower_state, FALSE) == TRUE then
        return
    end
end

function ItemDragonThrowSpearMax_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemDragonThrowSpearMax, lower_state, FALSE, TRUE) == TRUE then
        return
    end
    if env(ActionDuration, ACTION_ARM_USE_ITEM) <= 0 and
        (env(GetGeneralTAEFlag, TAE_FLAG_CHARGING) == 1 or env(GetSpEffectID, 100280) == TRUE) then
        ExecEventHalfBlend(Event_ItemDragonThrowSpearCancel, blend_type)
        return
    end
end

function ItemDragonThrowSpearCancel_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemDragonThrowSpearCancel, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemThrowBigBottle_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemThrowBigBottle, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemDancingSwordsmanFire_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemDancingSwordsmanFire, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemTransformDragonPriest_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemTransformDragonPriest, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemTransformGodman_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemTransformGodman, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemTransformGodmanNPC_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemTransformGodmanNPC, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemTransformGodmanBreathNPC_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemTransformGodmanBreathNPC, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemCrySickness_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemCrySickness, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemCrySicknessPhantom_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemCrySicknessPhantom, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemSwitchExplosive_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemSwitchExplosive, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemSwitch_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemSwitch, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemThorn_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemThorn, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemErdtree_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemErdtree, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemElixir2_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemElixir2, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemOneShot_Upper_onUpdate()
    if GetVariable("IndexItemUseAnim") == 52 then
        SetEnableMimicry()
    end
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemOneShot, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemOneShot_SelfTrans_Upper_onUpdate()
    if GetVariable("IndexItemUseAnim_SelfTrans") == 52 then
        SetEnableMimicry()
    end
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemOneShot_SelfTrans, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemCombo_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemCombo, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

IsSummonDash = FALSE

function ItemDash_Upper_onUpdate()
    act(LockonFixedAngleCancel)
    act(SetAllowedThrowDefenseType, 255)
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if GetLocomotionState() == PLAYER_STATE_MOVE and GetVariable("MoveSpeedIndex") >= 1 and
        GetVariable("ItemDashSpeedIndex") == 0 then
        act(DebugLogOutput, "SummonHorse ChangeSpeedIndex")
        IsSummonDash = TRUE
        SetVariable("ItemDashSpeedIndex", 1)
    end
    if env(IsSummoningRide) == TRUE then
        act(DebugLogOutput, "SummonHorse SummonRequest true")
        if env(IsNewRidingTest) == TRUE and IsSummonDash == TRUE then
            act(DebugLogOutput, "SummonHorse RideOnDash")
            SetVariable("RideOnSummonTest", 2)
            FireRideEvent("W_RideOn", "W_RideOnDash", FALSE)
        elseif env(IsNewRidingTest) == TRUE then
            act(DebugLogOutput, "SummonHorse RideOn")
            SetVariable("RideOnSummonTest", 1)
            FireRideEvent("W_RideOn", "W_RideOn", FALSE)
        else
            SetVariable("RideOnSummonTest", 0)
            ExecEventAllBody("W_RideAdjustFromCalling")
        end
        return
    elseif env(GetEventEzStateFlag, 0) == TRUE then
        if GetVariable("MoveSpeedLevel") >= 0.8999999761581421 then
        else
            IsSummonDash = FALSE
        end
        if env(IsAnimEnd, 1) == TRUE then
            ExecEventAllBody("W_Idle")
        end
        act(Mounting)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemDash, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemInvalid_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_ItemInvalid, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function ItemLadderRecoverRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_RIGHT)
    if LadderItemCommonFunction(HAND_STATE_RIGHT, FALSE) == TRUE then
        return
    end
end

function ItemLadderSoulRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_RIGHT)
    if LadderItemCommonFunction(HAND_STATE_RIGHT, FALSE) == TRUE then
        return
    end
end

function ItemLadderElixirRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_RIGHT)
    if LadderItemCommonFunction(HAND_STATE_RIGHT, FALSE) == TRUE then
        return
    end
end

function ItemLadderElixir2Right_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_RIGHT)
    if LadderItemCommonFunction(HAND_STATE_RIGHT, FALSE) == TRUE then
        return
    end
end

function ItemLadderEatJerkyRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_RIGHT)
    if LadderItemCommonFunction(HAND_STATE_RIGHT, FALSE) == TRUE then
        return
    end
end

function ItemLadderDrinkStartRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_RIGHT)
    if LadderItemCommonFunction(HAND_STATE_RIGHT, TRUE) == TRUE then
        return
    end
    local isEnd = env(IsAnimEnd, 1)
    if env(GetEventEzStateFlag, 0) == TRUE or isEnd == TRUE then
        local item_type = env(GetItemAnimType)
        if item_type ~= ITEM_NO_DRINK then
            ExecEvent("W_ItemLadderDrinkingRight")
            return
        elseif item_type == ITEM_NO_DRINK and isEnd == TRUE then
            ExecEvent("W_ItemLadderDrinkEmptyRight")
            return
        end
    end
end

function ItemLadderDrinkingRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_RIGHT)
    if LadderItemCommonFunction(HAND_STATE_RIGHT, TRUE) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        ExecEvent("W_ItemLadderDrinkEndRight")
        return
    end
end

function ItemLadderDrinkMPStartRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_RIGHT)
    if LadderItemCommonFunction(HAND_STATE_RIGHT, TRUE) == TRUE then
        return
    end
    if env(GetEventEzStateFlag, 0) == TRUE then
        ExecEvent("W_ItemLadderDrinkingMPRight")
        return
    end
end

function ItemLadderDrinkingMPRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_RIGHT)
    if LadderItemCommonFunction(HAND_STATE_RIGHT, TRUE) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        ExecEvent("W_ItemLadderDrinkEndRight")
        return
    end
end

function ItemLadderDrinkEndRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_RIGHT)
    if LadderItemCommonFunction(HAND_STATE_RIGHT, FALSE) == TRUE then
        return
    end
end

function ItemLadderDrinkEmptyRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_RIGHT)
    if LadderItemCommonFunction(HAND_STATE_RIGHT, FALSE) == TRUE then
        return
    end
end

function ItemLadderDrinkNothingRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_RIGHT)
    if LadderItemCommonFunction(HAND_STATE_RIGHT, FALSE) == TRUE then
        return
    end
end

function ItemLadderInvalidRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_RIGHT)
    if LadderItemCommonFunction(HAND_STATE_RIGHT, FALSE) == TRUE then
        return
    end
end

function ItemLadderRecoverLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_LEFT)
    if LadderItemCommonFunction(HAND_STATE_LEFT, FALSE) == TRUE then
        return
    end
end

function ItemLadderSoulLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_LEFT)
    if LadderItemCommonFunction(HAND_STATE_LEFT, FALSE) == TRUE then
        return
    end
end

function ItemLadderElixirLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_LEFT)
    if LadderItemCommonFunction(HAND_STATE_LEFT, FALSE) == TRUE then
        return
    end
end

function ItemLadderElixir2Left_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_LEFT)
    if LadderItemCommonFunction(HAND_STATE_LEFT, FALSE) == TRUE then
        return
    end
end

function ItemLadderEatJerkyLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_LEFT)
    if LadderItemCommonFunction(HAND_STATE_LEFT, FALSE) == TRUE then
        return
    end
end

function ItemLadderDrinkStartLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_LEFT)
    if LadderItemCommonFunction(HAND_STATE_LEFT, TRUE) == TRUE then
        return
    end
    local isEnd = env(IsAnimEnd, 1)
    if env(GetEventEzStateFlag, 0) == TRUE or isEnd == TRUE then
        local item_type = env(GetItemAnimType)
        if item_type ~= ITEM_NO_DRINK then
            ExecEvent("W_ItemLadderDrinkingLeft")
            return
        elseif item_type == ITEM_NO_DRINK and isEnd == TRUE then
            ExecEvent("W_ItemLadderDrinkEmptyLeft")
            return
        end
    end
end

function ItemLadderDrinkingLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_LEFT)
    if LadderItemCommonFunction(HAND_STATE_LEFT, TRUE) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        ExecEvent("W_ItemLadderDrinkEndLeft")
        return
    end
end

function ItemLadderDrinkMPStartLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_LEFT)
    if LadderItemCommonFunction(HAND_STATE_LEFT, TRUE) == TRUE then
        return
    end
    if env(GetEventEzStateFlag, 0) == TRUE then
        ExecEvent("W_ItemLadderDrinkingMPLeft")
        return
    end
end

function ItemLadderDrinkingMPLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_LEFT)
    if LadderItemCommonFunction(HAND_STATE_LEFT, TRUE) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        ExecEvent("W_ItemLadderDrinkEndLeft")
        return
    end
end

function ItemLadderDrinkEndLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_LEFT)
    if LadderItemCommonFunction(HAND_STATE_LEFT, FALSE) == TRUE then
        return
    end
end

function ItemLadderDrinkEmptyLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_LEFT)
    if LadderItemCommonFunction(HAND_STATE_LEFT, FALSE) == TRUE then
        return
    end
end

function ItemLadderDrinkNothingLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_LEFT)
    if LadderItemCommonFunction(HAND_STATE_LEFT, FALSE) == TRUE then
        return
    end
end

function ItemLadderInvalidLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_LEFT)
    if LadderItemCommonFunction(HAND_STATE_LEFT, FALSE) == TRUE then
        return
    end
end
