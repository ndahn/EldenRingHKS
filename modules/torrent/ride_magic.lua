
function ExecRideMagic()
    if ExecMagic(QUICKTYPE_NORMAL, ALLBODY, TRUE) == TRUE then
        return TRUE
    else
        return FALSE
    end
end

--------------
-- Triggers --
--------------

function RideMagicLaunch_onUpdate()
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end
    if env(IsAnimEndBySkillCancel) == TRUE or env(IsAnimEnd, 0) == TRUE then
        ExecEventAllBody("W_RideMagicFire")
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

function RideMagicLaunch_Upper_onUpdate()
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end
    if env(IsAnimEndBySkillCancel) == TRUE or env(IsAnimEnd, 0) == TRUE then
        ExecEventAllBody("W_RideMagicFire")
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

function RideMagicFire_onUpdate()
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local wep_hand = HAND_RIGHT

    if c_Style == HAND_LEFT_BOTH then
        wep_hand = HAND_LEFT
    end

    local buttonR = ACTION_ARM_R1
    local buttonL = ACTION_ARM_L1
    local sp_kind = env(GetEquipWeaponSpecialCategoryNumber, wep_hand)

    if IsWeaponCatalyst(sp_kind) == TRUE then
        buttonR = ACTION_ARM_R2
        buttonL = ACTION_ARM_L2
    end

    if env(GetSpEffectID, 100610) == TRUE and
        (env(ActionDuration, buttonR) <= 0 and env(ActionDuration, buttonL) <= 0 or env(IsMagicUseable, wep_hand, 1) ==
            FALSE) then
        ExecEventAllBody("W_RideMagicFireCancel")
        return
    end
    if CheckIfHoldMagic() == TRUE and (env(IsAnimEndBySkillCancel) == TRUE or env(IsAnimEnd, 0) == TRUE) then
        if env(ActionDuration, buttonR) > 0 then
            ExecEventAllBody("W_RideMagicLoop")
            return
        else
            ExecEventAllBody("W_RideMagicFireCancel")
            return
        end
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

function RideMagicLoop_onUpdate()
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local wep_hand = HAND_RIGHT

    if c_Style == HAND_LEFT_BOTH then
        wep_hand = HAND_LEFT
    end

    local buttonR = ACTION_ARM_R1
    local buttonL = ACTION_ARM_L1
    local sp_kind = env(GetEquipWeaponSpecialCategoryNumber, wep_hand)

    if IsWeaponCatalyst(sp_kind) == TRUE then
        buttonR = ACTION_ARM_R2
        buttonL = ACTION_ARM_L2
    end

    if env(ActionDuration, buttonR) <= 0 and env(ActionDuration, buttonL) <= 0 and env(ActionDuration, buttonL) <= 0 or
        env(IsMagicUseable, wep_hand, 1) == FALSE or env(GetStamina) <= 0 then
        local magic_index = env(GetMagicAnimType)
        if magic_index == MAGIC_REQUEST_EX_LARGE_ARROW then
            ExecEventAllBody("W_RideMagicFireCombo1Cancel")
        else
            ExecEventAllBody("W_RideMagicFireCancel")
        end
        return
    end

    local lower_only = TRUE
    local enable_turn = FALSE

    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        return
    end
end

function RideMagicFireCancel_onUpdate()
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

function RideMagicFireCombo1_onUpdate()
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local wep_hand = HAND_RIGHT

    if c_Style == HAND_LEFT_BOTH then
        wep_hand = HAND_LEFT
    end

    local buttonR = ACTION_ARM_R1
    local buttonL = ACTION_ARM_L1
    local sp_kind = env(GetEquipWeaponSpecialCategoryNumber, wep_hand)
    if IsWeaponCatalyst(sp_kind) == TRUE then
        buttonR = ACTION_ARM_R2
        buttonL = ACTION_ARM_L2
    end

    if env(GetSpEffectID, 100610) == TRUE and
        (env(ActionDuration, buttonR) <= 0 and env(ActionDuration, buttonL) <= 0 or env(IsMagicUseable, wep_hand, 1) ==
            FALSE) then
        ExecEventAllBody("W_RideMagicFireCombo1Cancel")
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

function RideMagicFireCombo1Cancel_onUpdate()
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

function RideMagicFireCombo2_onUpdate()
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end

    local wep_hand = HAND_RIGHT

    if c_Style == HAND_LEFT_BOTH then
        wep_hand = HAND_LEFT
    end

    local buttonR = ACTION_ARM_R1
    local buttonL = ACTION_ARM_L1
    local sp_kind = env(GetEquipWeaponSpecialCategoryNumber, wep_hand)
    if IsWeaponCatalyst(sp_kind) == TRUE then
        buttonR = ACTION_ARM_R2
        buttonL = ACTION_ARM_L2
    end

    if env(GetSpEffectID, 100610) == TRUE and
        (env(ActionDuration, buttonR) <= 0 and env(ActionDuration, buttonL) <= 0 or env(IsMagicUseable, wep_hand, 1) ==
            FALSE) then
        ExecEventAllBody("W_RideMagicFireCombo2Cancel")
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

function RideMagicFireCombo2Cancel_onUpdate()
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

function RideMagicInvalid_onUpdate()
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


ExecRideMagic = hookup_function(ExecRideMagic)
RideMagicLaunch_onUpdate = hookup_function(RideMagicLaunch_onUpdate)
RideMagicLaunch_Upper_onUpdate = hookup_function(RideMagicLaunch_Upper_onUpdate)
RideMagicFire_onUpdate = hookup_function(RideMagicFire_onUpdate)
RideMagicLoop_onUpdate = hookup_function(RideMagicLoop_onUpdate)
RideMagicFireCancel_onUpdate = hookup_function(RideMagicFireCancel_onUpdate)
RideMagicFireCombo1_onUpdate = hookup_function(RideMagicFireCombo1_onUpdate)
RideMagicFireCombo1Cancel_onUpdate = hookup_function(RideMagicFireCombo1Cancel_onUpdate)
RideMagicFireCombo2_onUpdate = hookup_function(RideMagicFireCombo2_onUpdate)
RideMagicFireCombo2Cancel_onUpdate = hookup_function(RideMagicFireCombo2Cancel_onUpdate)
RideMagicInvalid_onUpdate = hookup_function(RideMagicInvalid_onUpdate)
