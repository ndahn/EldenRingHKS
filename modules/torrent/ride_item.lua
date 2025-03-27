
function ExecRideItem()
    if c_HasActionRequest == FALSE then
        return FALSE
    end

    local hand = HAND_RIGHT
    local kind = env(GetEquipWeaponCategory, hand)
    if kind == WEAPON_CATEGORY_BACKHAND_SWORD then
        SetVariable("ItemWeaponType", 1)
    elseif kind == WEAPON_CATEGORY_DUELING_SHIELD then
        SetVariable("ItemWeaponType", 2)
    else
        SetVariable("ItemWeaponType", 0)
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
    local is_combo = env(GetSpEffectID, 100800)

    if is_combo == TRUE and item_type ~= ITEM_NIGHT_BELL then
        return FALSE
    end
    local pre_item_type = GetVariable("PreItemType")
    SetVariable("PreItemType", item_type)

    if item_type == ITEM_DRINK then
        if env(GetStateChangeType, CONDITION_TYPE_NO_EST) == TRUE then
            ExecEventAllBody("W_RideItemDrinkNothing")
        elseif IsNodeActive("RideItemDrinking_CMSG") == TRUE and pre_item_type == ITEM_DRINK then
            ExecEventAllBody("W_RideItemDrinking")
        else
            ExecEventAllBody("W_RideItemDrinkStart")
        end
    elseif item_type == ITEM_DRINK_MP then
        if env(GetStateChangeType, CONDITION_TYPE_NO_EST) == TRUE then
            ExecEventAllBody("W_RideItemDrinkNothing")
        elseif IsNodeActive("RideItemDrinking_CMSG") == TRUE and pre_item_type == ITEM_DRINK_MP then
            ExecEventAllBody("W_RideItemDrinking")
        else
            ExecEventAllBody("W_RideItemDrinkStart")
        end
    elseif item_type == ITEM_SUMMONHORSE then
        ExecRideOff(TRUE, FALSE)
    elseif item_type == ITEM_MEGANE then
        if env(GetStateChangeType, 15) == TRUE then
            ExecEventAllBody("W_RideItemMeganeEnd")
        else
            ExecEventAllBody("W_RideItemMeganeStart")
        end
    elseif item_type == 27 then
        if env(GetSpEffectID, 3245) == TRUE then
            ExecEventAllBody("W_RideItemLanternOff")
        else
            SetVariable("IndexItemUseAnim", item_type)
            ExecEventAllBody("W_RideItemOneShot")
        end
    elseif item_type == ITEM_ELIXIR then
        ExecEventAllBody("W_RideItemElixir")
    elseif item_type == ITEM_QUICK_THROW_KNIFE then
        if IsNodeActive("RideItemQuick1_CMSG") == TRUE or IsNodeActive("RideItemQuick3_CMSG") == TRUE then
            ExecEventAllBody("W_RideItemQuick2")
        elseif IsNodeActive("RideItemQuick2_CMSG") == TRUE then
            ExecEventAllBody("W_RideItemQuick3")
        else
            ExecEventAllBody("W_RideItemQuick1")
        end
    elseif item_type == ITEM_NIGHT_BELL then
        if is_combo == TRUE then
            ExecEventAllBody("W_RideItemCombo")
        else
            SetVariable("IndexItemUseAnim", item_type)
            ExecEventAllBody("W_RideItemOneShot")
        end
    elseif item_type == ITEM_NO_DRINK then
        if IsNodeActive("RideItemDrinking_CMSG") == TRUE then
            ExecEventAllBody("W_RideItemDrinkEmpty")
        else
            ExecEventAllBody("W_RideItemDrinkStart")
        end
    elseif item_type == ITEM_INVALID then
        ExecEventAllBody("W_RideItemInvalid")
    else
        SetVariable("IndexItemUseAnim", item_type)
        ExecEventAllBody("W_RideItemOneShot")
    end

    act(ApplyRideBlend, "Ride_Feed_AddBlend", 0)
    act(SetIsItemAnimationPlaying)
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    SetAIActionState()

    return TRUE
end

--------------
-- Triggers --
--------------

function RideItemDrinkStart_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    act(ResetInputQueue)
end

function RideItemDrinkStart_onUpdate()
    SetAIActionState()
    act(DisallowAdditiveTurning, TRUE)
    act(SetIsItemAnimationPlaying)

    if RideReActionFunction() == TRUE then
        return
    end
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local isEnd = env(IsAnimEnd, 1)

    if env(GetEventEzStateFlag, 0) == TRUE or isEnd == TRUE then
        local item_type = env(GetItemAnimType)
        if item_type ~= ITEM_NO_DRINK then
            ExecEventNoReset("W_RideItemDrinking")
            return
        elseif item_type == ITEM_NO_DRINK and isEnd == TRUE then
            ExecEventNoReset("W_RideItemDrinkEmpty")
            return
        end
    end

    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end
    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
end

function RideItemDrinking_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    act(ResetInputQueue)
end

function RideItemDrinking_onUpdate()
    SetAIActionState()
    act(SetIsItemAnimationPlaying)

    if RideReActionFunction() == TRUE then
        return
    end
    if ExecRideItem() == TRUE then
        return TRUE
    end
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        ExecEventNoReset("W_RideItemDrinkEnd")
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
end

function RideItemDrinkEnd_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    act(ResetInputQueue)
end

function RideItemDrinkEnd_onUpdate()
    SetAIActionState()
    act(SetIsItemAnimationPlaying)

    if RideReActionFunction() == TRUE then
        return
    end
    if ExecRideItem() == TRUE then
        return TRUE
    end
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 1) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
end

function RideItemDrinkEmpty_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    act(ResetInputQueue)
end

function RideItemDrinkEmpty_onUpdate()
    SetAIActionState()
    act(SetIsItemAnimationPlaying)

    if RideReActionFunction() == TRUE then
        return
    end
    if ExecRideItem() == TRUE then
        return TRUE
    end
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        ExecEventNoReset("W_RideIdle")
    end
end

function RideItemInvalid_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    act(ResetInputQueue)
end

function RideItemInvalid_onUpdate()
    SetAIActionState()
    act(SetIsItemAnimationPlaying)

    if RideReActionFunction() == TRUE then
        return
    end
    if ExecRideItem() == TRUE then
        return TRUE
    end
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 1) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end
    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        ExecEventNoReset("W_RideIdle")
    end
end

function RideItemDrinkNothing_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    act(ResetInputQueue)
end

function RideItemDrinkNothing_onUpdate()
    SetAIActionState()
    act(SetIsItemAnimationPlaying)

    if RideReActionFunction() == TRUE then
        return
    end
    if ExecRideItem() == TRUE then
        return TRUE
    end
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        ExecEventNoReset("W_RideIdle")
    end
end

function RideItemWhistle_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    act(ResetInputQueue)
end

function RideItemWhistle_onUpdate()
    SetAIActionState()
    act(SetIsItemAnimationPlaying)

    if RideReActionFunction() == TRUE then
        return
    end
    if ExecRideItem() == TRUE then
        return TRUE
    end
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        ExecEventNoReset("W_RideIdle")
    end
end

function RideItemElixir_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    act(ResetInputQueue)
end

function RideItemElixir_onUpdate()
    SetAIActionState()
    act(SetIsItemAnimationPlaying)

    if RideReActionFunction() == TRUE then
        return
    end
    if ExecRideItem() == TRUE then
        return TRUE
    end
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        ExecEventNoReset("W_RideIdle")
    end
end

function RideItemHorn_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    act(ResetInputQueue)
end

function RideItemHorn_onUpdate()
    SetAIActionState()
    act(SetIsItemAnimationPlaying)

    if RideReActionFunction() == TRUE then
        return
    end
    if ExecRideItem() == TRUE then
        return TRUE
    end
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        ExecEventNoReset("W_RideIdle")
    end
end

function RideItemQuick1_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    act(ResetInputQueue)
end

function RideItemQuick1_onUpdate()
    SetAIActionState()
    act(SetIsItemAnimationPlaying)

    if RideReActionFunction() == TRUE then
        return
    end
    if ExecRideItem() == TRUE then
        return TRUE
    end
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 1) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end
    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        ExecEventNoReset("W_RideIdle")
    end
end

function RideItemQuick2_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    act(ResetInputQueue)
end

function RideItemQuick2_onUpdate()
    SetAIActionState()
    act(SetIsItemAnimationPlaying)

    if RideReActionFunction() == TRUE then
        return
    end
    if ExecRideItem() == TRUE then
        return TRUE
    end
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 1) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        ExecEventNoReset("W_RideIdle")
    end
end

function RideItemQuick3_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    act(ResetInputQueue)
end

function RideItemQuick3_onUpdate()
    SetAIActionState()
    act(SetIsItemAnimationPlaying)

    if RideReActionFunction() == TRUE then
        return
    end
    if ExecRideItem() == TRUE then
        return TRUE
    end
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 1) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        ExecEventNoReset("W_RideIdle")
    end
end

function RideItemOneShot_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    act(ResetInputQueue)
end

function RideItemOneShot_onUpdate()
    if GetVariable("PreItemType") == ITEM_HORSE_FEED then
        IsEnableFeedAddBlend = TRUE
    end

    act(SetIsItemAnimationPlaying)
    SetAIActionState()

    if RideReActionFunction() == TRUE then
        return
    end
    if ExecRideItem() == TRUE then
        return TRUE
    end
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
    local item_type = env(GetItemAnimType)

    if item_type == ITEM_DRAGONTHROWSPEAR and env(ActionDuration, ACTION_ARM_USE_ITEM) <= 0 and
        (env(GetGeneralTAEFlag, TAE_FLAG_CHARGING) == 1 or env(GetSpEffectID, 100280) == TRUE) then
        ExecEvent("W_RideItemDragonThrowSpearCancel")
        return
    end

    if env(IsAnimEnd, 1) == TRUE then
        ExecEventNoReset("W_RideIdle")
    end
end

function RideItemOneShot_onDeactivate()
    IsEnableFeedAddBlend = FALSE
end

function RideItemDragonThrowSpearCancel_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    act(ResetInputQueue)
end

function RideItemDragonThrowSpearCancel_onUpdate()
    act(SetIsItemAnimationPlaying)
    SetAIActionState()

    if RideReActionFunction() == TRUE then
        return
    end
    if ExecRideItem() == TRUE then
        return TRUE
    end
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end

    if env(IsAnimEnd, 1) == TRUE then
        ExecEventNoReset("W_RideIdle")
    end
end

function RideItemLanternOff_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    act(ResetInputQueue)
end

function RideItemLanternOff_onUpdate()
    act(SetIsItemAnimationPlaying)
    SetAIActionState()

    if RideReActionFunction() == TRUE then
        return
    end
    if ExecRideItem() == TRUE then
        return TRUE
    end
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        ExecEventNoReset("W_RideIdle")
    end
end

function RideItemCombo_onActivate()
    SetAIActionState()
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    act(ResetInputQueue)
end

function RideItemCombo_onUpdate()
    act(SetIsItemAnimationPlaying)
    SetAIActionState()

    if RideReActionFunction() == TRUE then
        return
    end
    if ExecRideItem() == TRUE then
        return TRUE
    end
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        ExecEventNoReset("W_RideIdle")
    end
end

function RideItemMeganeStart_onUpdate()
    act(SetIsItemAnimationPlaying)
    SetAIActionState()

    if RideReActionFunction() == TRUE then
        return
    end
    if ExecRideItem() == TRUE then
        return TRUE
    end
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
end

function RideItemMeganeLoop_onUpdate()
    SetAIActionState()
    if env(GetStateChangeType, 15) == FALSE then
        act(SetIsItemAnimationPlaying)
    end

    if RideReActionFunction() == TRUE then
        return
    end
    if ExecRideItem() == TRUE then
        return TRUE
    end
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
end

function RideItemMeganeEnd_onUpdate()
    SetAIActionState()
    act(SetIsItemAnimationPlaying)

    if RideReActionFunction() == TRUE then
        return
    end
    if ExecRideItem() == TRUE then
        return TRUE
    end
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        ExecEventNoReset("W_RideIdle")
    end
end


ExecRideItem = hookup_function(ExecRideItem)
RideItemDrinkStart_onActivate = hookup_function(RideItemDrinkStart_onActivate)
RideItemDrinkStart_onUpdate = hookup_function(RideItemDrinkStart_onUpdate)
RideItemDrinking_onActivate = hookup_function(RideItemDrinking_onActivate)
RideItemDrinking_onUpdate = hookup_function(RideItemDrinking_onUpdate)
RideItemDrinkEnd_onActivate = hookup_function(RideItemDrinkEnd_onActivate)
RideItemDrinkEnd_onUpdate = hookup_function(RideItemDrinkEnd_onUpdate)
RideItemDrinkEmpty_onActivate = hookup_function(RideItemDrinkEmpty_onActivate)
RideItemDrinkEmpty_onUpdate = hookup_function(RideItemDrinkEmpty_onUpdate)
RideItemInvalid_onActivate = hookup_function(RideItemInvalid_onActivate)
RideItemInvalid_onUpdate = hookup_function(RideItemInvalid_onUpdate)
RideItemDrinkNothing_onActivate = hookup_function(RideItemDrinkNothing_onActivate)
RideItemDrinkNothing_onUpdate = hookup_function(RideItemDrinkNothing_onUpdate)
RideItemWhistle_onActivate = hookup_function(RideItemWhistle_onActivate)
RideItemWhistle_onUpdate = hookup_function(RideItemWhistle_onUpdate)
RideItemElixir_onActivate = hookup_function(RideItemElixir_onActivate)
RideItemElixir_onUpdate = hookup_function(RideItemElixir_onUpdate)
RideItemHorn_onActivate = hookup_function(RideItemHorn_onActivate)
RideItemHorn_onUpdate = hookup_function(RideItemHorn_onUpdate)
RideItemQuick1_onActivate = hookup_function(RideItemQuick1_onActivate)
RideItemQuick1_onUpdate = hookup_function(RideItemQuick1_onUpdate)
RideItemQuick2_onActivate = hookup_function(RideItemQuick2_onActivate)
RideItemQuick2_onUpdate = hookup_function(RideItemQuick2_onUpdate)
RideItemQuick3_onActivate = hookup_function(RideItemQuick3_onActivate)
RideItemQuick3_onUpdate = hookup_function(RideItemQuick3_onUpdate)
RideItemOneShot_onActivate = hookup_function(RideItemOneShot_onActivate)
RideItemOneShot_onUpdate = hookup_function(RideItemOneShot_onUpdate)
RideItemOneShot_onDeactivate = hookup_function(RideItemOneShot_onDeactivate)
RideItemDragonThrowSpearCancel_onActivate = hookup_function(RideItemDragonThrowSpearCancel_onActivate)
RideItemDragonThrowSpearCancel_onUpdate = hookup_function(RideItemDragonThrowSpearCancel_onUpdate)
RideItemLanternOff_onActivate = hookup_function(RideItemLanternOff_onActivate)
RideItemLanternOff_onUpdate = hookup_function(RideItemLanternOff_onUpdate)
RideItemCombo_onActivate = hookup_function(RideItemCombo_onActivate)
RideItemCombo_onUpdate = hookup_function(RideItemCombo_onUpdate)
RideItemMeganeStart_onUpdate = hookup_function(RideItemMeganeStart_onUpdate)
RideItemMeganeLoop_onUpdate = hookup_function(RideItemMeganeLoop_onUpdate)
RideItemMeganeEnd_onUpdate = hookup_function(RideItemMeganeEnd_onUpdate)