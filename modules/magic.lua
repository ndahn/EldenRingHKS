
-- Table storing information about spells.
-- Concerns playing a "weapon retrieval" animation after
-- the spell was executed.
--
-- Table key: Magic ID (TAE ID minus 400)
-- Value 1: Right hand, magic cast from right hand
-- Value 2: Right hand, magic cast from left hand
-- Value 3: Left hand
--
-- TRUE: Weapon was sheathed during animation, play retrieval animation.
-- FALSE: Weapon was used to perform the magic, no retrieval animation.
MagicPutOppositeWeapon = {
    [0] = {TRUE, TRUE, TRUE},
    [1] = {FALSE, FALSE, TRUE},
    [2] = {FALSE, FALSE, TRUE},
    [3] = {FALSE, FALSE, TRUE},
    [4] = {FALSE, FALSE, TRUE},
    [5] = {TRUE, TRUE, TRUE},
    [6] = {TRUE, TRUE, TRUE},
    [7] = {TRUE, TRUE, TRUE},
    [8] = {FALSE, FALSE, TRUE},
    [9] = {FALSE, FALSE, TRUE},
    [10] = {FALSE, FALSE, TRUE},
    [11] = {FALSE, FALSE, TRUE},
    [12] = {FALSE, FALSE, TRUE},
    [13] = {FALSE, FALSE, TRUE},
    [14] = {TRUE, TRUE, TRUE},
    [15] = {TRUE, TRUE, TRUE},
    [16] = {FALSE, FALSE, TRUE},
    [17] = {FALSE, FALSE, TRUE},
    [18] = {FALSE, FALSE, TRUE},
    [19] = {FALSE, FALSE, TRUE},
    [20] = {FALSE, FALSE, TRUE},
    [21] = {FALSE, FALSE, TRUE},
    [22] = {TRUE, TRUE, TRUE},
    [23] = {FALSE, FALSE, TRUE},
    [24] = {TRUE, TRUE, TRUE},
    [25] = {FALSE, FALSE, TRUE},
    [26] = {FALSE, FALSE, TRUE},
    [27] = {FALSE, FALSE, TRUE},
    [28] = {FALSE, FALSE, TRUE},
    [29] = {FALSE, FALSE, TRUE},
    [30] = {FALSE, FALSE, TRUE},
    [31] = {FALSE, FALSE, TRUE},
    [32] = {FALSE, FALSE, TRUE},
    [33] = {FALSE, FALSE, TRUE},
    [34] = {FALSE, FALSE, TRUE},
    [35] = {FALSE, FALSE, TRUE},
    [36] = {FALSE, FALSE, TRUE},
    [37] = {FALSE, FALSE, TRUE},
    [38] = {FALSE, FALSE, TRUE},
    [39] = {FALSE, FALSE, TRUE},
    [40] = {FALSE, FALSE, TRUE},
    [41] = {FALSE, FALSE, TRUE},
    [42] = {FALSE, FALSE, TRUE},
    [43] = {FALSE, FALSE, TRUE},
    [44] = {FALSE, FALSE, TRUE},
    [45] = {FALSE, FALSE, TRUE},
    [46] = {FALSE, FALSE, TRUE},
    [47] = {FALSE, FALSE, TRUE},
    [48] = {TRUE, TRUE, TRUE},
    [49] = {FALSE, FALSE, TRUE},
    [50] = {TRUE, TRUE, TRUE},
    [51] = {TRUE, TRUE, TRUE},
    [52] = {FALSE, FALSE, TRUE},
    [53] = {FALSE, FALSE, TRUE},
    [54] = {TRUE, TRUE, TRUE},
    [55] = {TRUE, TRUE, TRUE},
    [56] = {TRUE, TRUE, TRUE},
    [57] = {TRUE, TRUE, TRUE},
    [58] = {TRUE, TRUE, TRUE},
    [59] = {FALSE, FALSE, TRUE},
    [60] = {TRUE, TRUE, TRUE},
    [61] = {FALSE, FALSE, TRUE},
    [62] = {FALSE, FALSE, TRUE},
    [63] = {FALSE, FALSE, TRUE},
    [64] = {FALSE, FALSE, TRUE},
    [65] = {FALSE, FALSE, TRUE},
    [66] = {FALSE, FALSE, TRUE},
    [67] = {TRUE, TRUE, TRUE},
    [68] = {FALSE, FALSE, TRUE},
    [69] = {FALSE, FALSE, TRUE},
    [70] = {FALSE, FALSE, TRUE},
    [71] = {TRUE, TRUE, TRUE},
    [72] = {FALSE, FALSE, TRUE},
    [73] = {FALSE, FALSE, TRUE},
    [74] = {TRUE, TRUE, TRUE},
    [75] = {FALSE, FALSE, TRUE},
    [76] = {FALSE, FALSE, TRUE},
    [77] = {FALSE, FALSE, TRUE},
    [78] = {FALSE, FALSE, TRUE},
    [79] = {FALSE, FALSE, TRUE},
    [80] = {FALSE, FALSE, TRUE},
    [81] = {TRUE, TRUE, TRUE},
    [82] = {TRUE, TRUE, TRUE},
    [83] = {FALSE, FALSE, TRUE},
    [84] = {FALSE, FALSE, TRUE},
    [85] = {FALSE, FALSE, TRUE},
    [86] = {TRUE, TRUE, TRUE},
    [87] = {TRUE, TRUE, TRUE},
    [88] = {TRUE, TRUE, TRUE},
    [89] = {TRUE, TRUE, TRUE},
    [90] = {TRUE, TRUE, TRUE},
    [91] = {TRUE, TRUE, TRUE},
    [92] = {FALSE, FALSE, TRUE},
    [93] = {FALSE, FALSE, TRUE},
    [94] = {FALSE, FALSE, TRUE},
    [95] = {FALSE, FALSE, TRUE},
    [96] = {FALSE, FALSE, TRUE},
    [97] = {FALSE, FALSE, TRUE},
    [98] = {TRUE, TRUE, TRUE},
    [99] = {FALSE, FALSE, TRUE},
    [100] = {FALSE, FALSE, TRUE},
    [101] = {FALSE, FALSE, TRUE},
    [102] = {TRUE, TRUE, TRUE},
    [103] = {FALSE, FALSE, TRUE},
    [104] = {FALSE, FALSE, TRUE},
    [105] = {TRUE, TRUE, TRUE},
    [106] = {FALSE, FALSE, TRUE},
    [107] = {FALSE, FALSE, TRUE},
    [108] = {FALSE, FALSE, TRUE},
    [109] = {FALSE, FALSE, TRUE},
    [110] = {FALSE, FALSE, TRUE},
    [111] = {FALSE, FALSE, TRUE},
    [112] = {FALSE, FALSE, TRUE},
    [113] = {FALSE, FALSE, TRUE},
    [114] = {FALSE, FALSE, TRUE},
    [115] = {TRUE, TRUE, TRUE},
    [116] = {TRUE, TRUE, TRUE},
    [117] = {FALSE, FALSE, TRUE},
    [118] = {FALSE, FALSE, TRUE},
    [119] = {FALSE, FALSE, TRUE},
    [120] = {TRUE, TRUE, TRUE},
    [121] = {TRUE, TRUE, TRUE},
    [122] = {TRUE, TRUE, TRUE},
    [123] = {TRUE, TRUE, TRUE},
    [124] = {FALSE, FALSE, TRUE},
    [125] = {TRUE, TRUE, TRUE},
    [126] = {FALSE, FALSE, TRUE},
    [127] = {FALSE, FALSE, TRUE},
    [128] = {TRUE, TRUE, TRUE},
    [129] = {TRUE, TRUE, TRUE},
    [130] = {TRUE, TRUE, TRUE},
    [131] = {TRUE, TRUE, TRUE},
    [132] = {FALSE, FALSE, TRUE},
    [133] = {TRUE, TRUE, TRUE},
    [134] = {FALSE, TRUE, TRUE},
    [135] = {TRUE, TRUE, TRUE},
    [136] = {TRUE, TRUE, TRUE},
    [137] = {TRUE, TRUE, TRUE},
    [138] = {FALSE, FALSE, TRUE},
    [139] = {FALSE, FALSE, TRUE},
    [140] = {FALSE, FALSE, TRUE},
    [141] = {FALSE, FALSE, TRUE},
    [142] = {FALSE, FALSE, TRUE},
    [143] = {FALSE, FALSE, TRUE},
    [144] = {TRUE, TRUE, TRUE},
    [145] = {FALSE, FALSE, TRUE},
    [146] = {TRUE, TRUE, TRUE},
    [147] = {TRUE, TRUE, TRUE},
    [148] = {FALSE, FALSE, TRUE},
    [149] = {FALSE, FALSE, TRUE},
    [150] = {TRUE, TRUE, TRUE},
    [151] = {FALSE, FALSE, TRUE},
    [152] = {TRUE, TRUE, TRUE},
    [153] = {FALSE, FALSE, TRUE},
    [154] = {FALSE, FALSE, TRUE},
    [155] = {FALSE, FALSE, TRUE},
    [156] = {TRUE, TRUE, TRUE},
    [157] = {TRUE, TRUE, TRUE},
    [158] = {FALSE, FALSE, TRUE},
    [159] = {TRUE, TRUE, TRUE},
    [160] = {FALSE, FALSE, TRUE},
    [161] = {TRUE, TRUE, TRUE}
}

-- Decides whether to perform a "retrieve weapon" animation after finishing a magic spell.
-- See the above table for reference.
function GetMagicPutOppositeWeapon()
    local result = FALSE

    if MagicPutOppositeWeapon[g_MagicIndex] ~= nil then -- ivi: Sanity check for custom spells
        if c_Style == HAND_RIGHT then
            if g_Magichand == HAND_RIGHT then
                result = MagicPutOppositeWeapon[g_MagicIndex][1]
            else
                result = MagicPutOppositeWeapon[g_MagicIndex][2]
            end
        else
            result = MagicPutOppositeWeapon[g_MagicIndex][3]
        end
    end

    return result
end

function SetMagicGeneratorTransitionIndex()
    if GetMagicPutOppositeWeapon() == FALSE then
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

function IsWeaponCatalyst(sp_kind)
    local weaponCatalystSpKinds = {293 -- Carian Sorcery Sword
    }
    if Contains(weaponCatalystSpKinds, sp_kind) == TRUE then
        return TRUE
    end
    return FALSE
end

function IsMagicAnimExists(magic_type, anim_id)
    return env(DoesAnimExist, magic_type + 400, anim_id)
end

function IsQuickMagic()
    local magic_type = env(GetMagicAnimType)

    local magic_type_list = {MAGIC_REQUEST_STONE_SHOTGUN, MAGIC_REQUEST_QUICKENBULLET, MAGIC_REQUEST_QUICKSLASH,
                             MAGIC_REQUEST_QUICK_FLAME}

    if (magic_type == MAGIC_REQUEST_WEAPON_ENCHANT2 and c_Style == HAND_RIGHT) or Contains(magic_type_list, magic_type) ==
        TRUE then
        return TRUE
    end
    return FALSE
end

function IsWeaponEnchantMagic()
    local magic_type = env(GetMagicAnimType)

    local magic_type_list = {MAGIC_REQUEST_WEAPON_ENCHANT, MAGIC_REQUEST_WEAPON_ENCHANT2,
                             MAGIC_REQUEST_WEAPON_ENCHANT_B, MAGIC_REQUEST_THUNDER_ENCHANT, MAGIC_REQUEST_HOLY_ENCHANT}

    if Contains(magic_type_list, magic_type) == TRUE then
        return TRUE
    end
    return FALSE
end

function IsJumpMagic()
    local magic_type = env(GetMagicAnimType)

    local magic_type_list = {MAGIC_REQUEST_FLYING_BREATH, MAGIC_REQUEST_ELDER_DRAGON_BREATH}

    if Contains(magic_type_list, magic_type) == TRUE then
        return TRUE
    end
    return FALSE
end

function IsComboMagic()
    return IsMagicAnimExists(env(GetMagicAnimType), 45020)
end

function IsChargeMagic()
    return IsMagicAnimExists(env(GetMagicAnimType), 45011)
end

function CheckIfHoldMagic()
    local magic_type = env(GetMagicAnimType)
    local has_hold_anim = IsMagicAnimExists(magic_type, 45012)

    if not has_hold_anim then
        if magic_type ~= 35 then
            has_hold_anim = false
        else
            has_hold_anim = true
        end
    end
    return has_hold_anim
end

function IsStealthMagic(magic_type)
    local magic_type_list = {26, 114}

    if Contains(magic_type_list, magic_type) == TRUE then
        return TRUE
    end
    return FALSE
end

function IsRollingMagic(magic_type)
    local magic_type_list = {127}

    if Contains(magic_type_list, magic_type) == TRUE then
        return TRUE
    end
    return FALSE
end

function ExecMagic(quick_type, blend_type, is_ride)
    if c_HasActionRequest == FALSE then
        return FALSE
    end
    if env(GetStamina) <= 0 then
        return FALSE
    end
    if env(ActionDuration, ACTION_ARM_ACTION) > 0 then
        return FALSE
    end
    if env(IsMagicUseMenuOpened) == TRUE then
        return FALSE
    end
    if c_IsStealth == TRUE then
        blend_type = ALLBODY
    end
    local style = c_Style
    local magic_hand = HAND_RIGHT
    local wep_hand = HAND_RIGHT
    local delayActRequestNo = -1
    local is_samagic = FALSE
    local sp_kind_R = env(GetEquipWeaponSpecialCategoryNumber, HAND_RIGHT)
    local sp_kind_L = env(GetEquipWeaponSpecialCategoryNumber, HAND_LEFT)
    local buttonR = ACTION_ARM_MAGIC_R
    local buttonL = ACTION_ARM_MAGIC_L

    if IsWeaponCatalyst(sp_kind_R) == TRUE then
        buttonR = ACTION_ARM_MAGIC_R2
    end
    if IsWeaponCatalyst(sp_kind_L) == TRUE and is_ride == FALSE then
        buttonL = ACTION_ARM_MAGIC_L2
    end

    if env(ActionRequest, buttonL) == TRUE and env(ActionRequest, buttonR) == FALSE and is_ride == TRUE then
        ResetRequest()
        return FALSE
    end

    -- Normal Catalysts
    -- R1/L1 (while riding)
    if env(ActionRequest, ACTION_ARM_MAGIC_R) == TRUE or env(ActionRequest, ACTION_ARM_MAGIC_L) == TRUE and is_ride ==
        TRUE then
        delayActRequestNo = ACTION_ARM_MAGIC_R
        if style == HAND_LEFT_BOTH then
            if GetEquipType(HAND_LEFT, WEAPON_CATEGORY_STAFF) == FALSE then
                return FALSE
            end
            wep_hand = HAND_LEFT
        else
            if GetEquipType(HAND_RIGHT, WEAPON_CATEGORY_STAFF) == FALSE then
                return FALSE
            end
            wep_hand = HAND_RIGHT
        end
        -- R2
    elseif env(ActionRequest, ACTION_ARM_MAGIC_R2) == TRUE then
        delayActRequestNo = ACTION_ARM_MAGIC_R2
        if style == HAND_LEFT_BOTH then
            local sp_kind = env(GetEquipWeaponSpecialCategoryNumber, HAND_LEFT)
            if IsWeaponCatalyst(sp_kind) == FALSE then
                return FALSE
            end
            wep_hand = HAND_LEFT
        else
            local sp_kind = env(GetEquipWeaponSpecialCategoryNumber, HAND_RIGHT)
            if IsWeaponCatalyst(sp_kind) == FALSE then
                return FALSE
            end
            wep_hand = HAND_RIGHT
        end
        -- L1
    elseif env(ActionRequest, ACTION_ARM_MAGIC_L) == TRUE then
        delayActRequestNo = ACTION_ARM_MAGIC_L
        if style == HAND_RIGHT_BOTH or style == HAND_LEFT_BOTH then
            return FALSE
        end
        if GetEquipType(HAND_LEFT, WEAPON_CATEGORY_STAFF) == FALSE then
            return FALSE
        end
        wep_hand = HAND_LEFT
        magic_hand = HAND_LEFT
        act(DebugLogOutput, "MagicLeft")
        -- L2
    elseif env(ActionRequest, ACTION_ARM_MAGIC_L2) == TRUE and is_ride == FALSE then
        delayActRequestNo = ACTION_ARM_MAGIC_L2
        if style == HAND_RIGHT then
            local sp_kind = env(GetEquipWeaponSpecialCategoryNumber, HAND_LEFT)
            if IsWeaponCatalyst(sp_kind) == FALSE then
                return FALSE
            end
            wep_hand = HAND_LEFT
            magic_hand = HAND_LEFT
        else
            return FALSE
        end
    else
        return FALSE
    end
    if env(IsMagicUseMenuOpening, wep_hand) == TRUE then
        ResetRequest()
        act(OpenMenuWhenUsingMagic, delayActRequestNo)
        return TRUE
    end
    act(DecideMagicUse)
    act(NotifyAIMagicCast)
    local magic_index = env(GetMagicAnimType)
    g_MagicIndex = magic_index
    g_Magichand = wep_hand
    local lastMagicMem = lastUsedMagicAnim
    lastUsedMagicAnim = magic_index
    if blend_type == ALLBODY and is_ride == FALSE then
        local move_event = Event_Move
        if IsStealthMagic(magic_index) == TRUE and c_IsStealth == TRUE then
            move_event = Event_Stealth_Move
        end
        if MoveStart(LOWER, move_event, FALSE) == TRUE then
            blend_type = UPPER
        end
    end
    if env(IsMagicUseable, wep_hand, 0) == FALSE then
        act(DebugLogOutput, "Event_MagicInvalid_Cannot_Use_Magic")
        SetVariable("IndexMagicHand", magic_hand)
        if is_ride == TRUE then
            ExecEventAllBody("W_RideMagicInvalid")
        else
            ExecEventHalfBlend(Event_MagicInvalid, blend_type)
        end
        act(SetIsMagicInUse, TRUE)
        act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
        SetAIActionState()
        return TRUE
    end

    if magic_index == 254 or magic_index == 255 then
        SetVariable("IndexMagicHand", magic_hand)
        if is_ride == TRUE then
            ExecEventAllBody("W_RideMagicInvalid")
        else
            act(DebugLogOutput, "Event_MagicInvalid_InvalidMagic")
            ExecEventHalfBlend(Event_MagicInvalid, blend_type)
        end
        act(SetIsMagicInUse, TRUE)
        act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
        SetAIActionState()
        return TRUE
    end

    -- Check if Player is Enchanting a Weapon in the Left Hand
    if IsWeaponEnchantMagic() == TRUE and c_Style == HAND_LEFT_BOTH then
        SetVariable("IndexMagicHand", magic_hand)
        act(DebugLogOutput, "Event_MagicInvalid_Left")
        ExecEventHalfBlend(Event_MagicInvalid, blend_type)
        act(SetIsMagicInUse, TRUE)
        act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
        SetAIActionState()
        return TRUE
    end

    -- Check if the Animation Type of the Magic is something related to Magic for Shields
    if magic_index == MAGIC_REQUEST_ORDER_SHIELD then
        if GetEquipType(HAND_LEFT, WEAPON_CATEGORY_LARGE_SHIELD) == TRUE then
            SetVariable("MagicRight_ShieldCategory", 1)
        end
    else
        SetVariable("MagicRight_ShieldCategory", 0)
    end

    if magic_index == MAGIC_REQUEST_GRAVITY or magic_index == MAGIC_REQUEST_METEOR or magic_index ==
        MAGIC_REQUEST_BLASTING or magic_index == MAGIC_REQUEST_DRILL or magic_index == MAGIC_REQUEST_MAGIC_SPARK or
        magic_index == 115 or magic_index == 120 or magic_index == 121 or magic_index == 157 or magic_index == 82 or
        magic_index == 150 or magic_index == 156 or magic_index == 161 then
        if IsWeaponCatalyst(env(GetEquipWeaponSpecialCategoryNumber, wep_hand)) == TRUE then
            SetVariable("Magic_SpecialStaffCategory", 2)
        else
            SetVariable("Magic_SpecialStaffCategory", 0)
        end
    elseif magic_index == 141 or magic_index == 128 or magic_index == 146 then
        if env(GetEquipWeaponSpecialCategoryNumber, wep_hand) == 290 then
            SetVariable("Magic_SpecialStaffCategory", 1)
        else
            SetVariable("Magic_SpecialStaffCategory", 0)
        end
    else
        SetVariable("Magic_SpecialStaffCategory", 0)
    end

    if magic_index == MAGIC_REQUEST_WEAPON_ENCHANT or magic_index == MAGIC_REQUEST_THUNDER_ENCHANT or magic_index ==
        MAGIC_REQUEST_WEAPON_ENCHANT_B or magic_index == MAGIC_REQUEST_HOLY_ENCHANT then
        if GetEquipType(HAND_RIGHT, WEAPON_CATEGORY_DUELING_SHIELD) == TRUE then
            SetVariable("Magic_DuelingShieldCategory", 1)
        else
            SetVariable("Magic_DuelingShieldCategory", 0)
        end
    else
        SetVariable("Magic_DuelingShieldCategory", 0)
    end

    local is_atk_auto_aim = FALSE
    if magic_index == MAGIC_REQUEST_WHIP or magic_index == MAGIC_REQUEST_SLASH or magic_index ==
        MAGIC_REQUEST_QUICKSLASH or magic_index == MAGIC_REQUEST_FLAME_GRAB or magic_index == MAGIC_REQUEST_CRUSH or
        magic_index == MAGIC_REQUEST_CHOP or magic_index == MAGIC_REQUEST_SCYTHE then
        is_atk_auto_aim = TRUE
    end

    if magic_index == 127 and env(GetSpEffectID, 19975) == TRUE then
        return TRUE
    end

    if ExecComboMagic(magic_hand, blend_type, lastMagicMem, magic_index) == TRUE then
    elseif ExecQuickMagic(magic_hand, quick_type, blend_type) == TRUE then
    elseif ExecStealthMagic(magic_hand, magic_index, blend_type) == TRUE then
    elseif is_ride == TRUE then
        ExecEventAllBody("W_RideMagicLaunch")
    elseif magic_hand == HAND_RIGHT and (magic_index ~= MAGIC_REQUEST_MAD_THROW or c_Style ~= HAND_LEFT_BOTH) then
        ExecEventHalfBlend(Event_MagicLaunchRight, blend_type)
    else
        ExecEventHalfBlend(Event_MagicLaunchLeft, blend_type)
    end

    act(SetIsMagicInUse, TRUE)
    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    SetAIActionState()

    return TRUE
end

function ExecQuickMagic(magic_hand, quick_type, blend_type)
    if env(IsOnMount) == TRUE or IsQuickMagic() == FALSE then
        return FALSE
    end
    if quick_type == QUICKTYPE_NORMAL or quick_type == QUICKTYPE_RUN then
        return FALSE
    elseif quick_type == QUICKTYPE_DASH then
        if magic_hand == HAND_RIGHT then
            ExecEventHalfBlend(Event_QuickMagicFireRightDash, blend_type)
            return TRUE
        else
            ExecEventHalfBlend(Event_QuickMagicFireLeftDash, blend_type)
            return TRUE
        end
    elseif quick_type == QUICKTYPE_ROLLING then
        if magic_hand == HAND_RIGHT then
            ExecEventHalfBlend(Event_QuickMagicFireRightStep, blend_type)
            return TRUE
        else
            ExecEventHalfBlend(Event_QuickMagicFireLeftStep, blend_type)
            return TRUE
        end
    elseif quick_type == QUICKTYPE_BACKSTEP then
        if magic_hand == HAND_RIGHT then
            ExecEventHalfBlend(Event_QuickMagicFireRightBackStep, blend_type)
            return TRUE
        else
            ExecEventHalfBlend(Event_QuickMagicFireLeftBackStep, blend_type)
            return TRUE
        end
    elseif quick_type == QUICKTYPE_ATTACK or quick_type == QUICKTYPE_COMBO then
        if ForwardLeg() == 1 then
            if magic_hand == HAND_RIGHT then
                ExecEventHalfBlend(Event_QuickMagicFireRightAttackRight, blend_type)
                return TRUE
            else
                ExecEventHalfBlend(Event_QuickMagicFireLeftAttackRight, blend_type)
                return TRUE
            end
        elseif magic_hand == HAND_RIGHT then
            ExecEventHalfBlend(Event_QuickMagicFireRightAttackLeft, blend_type)
            return TRUE
        else
            ExecEventHalfBlend(Event_QuickMagicFireLeftAttackLeft, blend_type)
            return TRUE
        end
    end
    return FALSE
end

function ExecComboMagic(magic_hand, blend_type, lastUsedMagicAnim, magicAnim)
    -- 100600 "[HKS] Right Combo Magic 1: Window"
    -- 100601 "[HKS] Right Combo Magic 2: Window"
    -- 100605 "[HKS] Left Combo Magic 1: Window"
    -- 100606 "[HKS] Left Combo Magic 2: Window"

    if lastUsedMagicAnim ~= magicAnim then
        return FALSE
    end
    if IsComboMagic() == FALSE then
        return FALSE
    end
    if env(IsOnMount) == TRUE then
        if env(GetSpEffectID, 100600) == TRUE then
            ExecEventAllBody("W_RideMagicFireCombo1")
            return TRUE
        elseif env(GetSpEffectID, 100601) == TRUE then
            ExecEventAllBody("W_RideMagicFireCombo2")
            return TRUE
        else
            return FALSE
        end
    elseif magic_hand == HAND_RIGHT then
        if env(GetSpEffectID, 100600) == TRUE then
            ExecEventHalfBlend(Event_MagicFireRight2, blend_type)
            return TRUE
        elseif env(GetSpEffectID, 100601) == TRUE then
            ExecEventHalfBlend(Event_MagicFireRight3, blend_type)
            return TRUE
        else
            return FALSE
        end
    elseif env(GetSpEffectID, 100605) == TRUE then
        ExecEventHalfBlend(Event_MagicFireLeft2, blend_type)
        return TRUE
    elseif env(GetSpEffectID, 100606) == TRUE then
        ExecEventHalfBlend(Event_MagicFireLeft3, blend_type)
        return TRUE
    else
        return FALSE
    end
end

function ExecStealthMagic(magic_hand, magic_type, blend_type)
    if c_IsStealth == FALSE then
        return FALSE
    end
    if IsStealthMagic(magic_type) == FALSE then
        return FALSE
    end
    if magic_hand == HAND_RIGHT then
        ExecEventHalfBlend(Event_StealthMagicRightLaunch, blend_type)
        return TRUE
    else
        ExecEventHalfBlend(Event_StealthMagicLeftLaunch, blend_type)
        return TRUE
    end
end

function ExecRollingMagic(magic_hand, magic_type, blend_type)
    if IsRollingMagic(magic_type) == FALSE then
        return FALSE
    end

    local rollingAngle = GetVariable("MoveAngle")
    local turn_target_angle = 0
    local rollingDirection = 0
    local turn_angle_real = 200

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
        turn_angle_real = math.abs(GetVariable("TurnAngle") - rollingAngle)
        if turn_angle_real > 180 then
            turn_angle_real = 360 - turn_angle_real
        end
    end

    SetVariable("RollingMagicDirection", rollingDirection)
    SetVariable("RollingAngleReal", rollingAngle)
    SetVariable("TurnAngleReal", turn_angle_real)

    if GetVariable("MoveSpeedLevel") < 0.10000000149011612 then
        if magic_hand == HAND_RIGHT then
            ExecEventHalfBlend(Event_MagicFireRight, blend_type)
            return TRUE
        else
            ExecEventHalfBlend(Event_MagicFireLeft, blend_type)
            return TRUE
        end
    elseif magic_hand == HAND_RIGHT then
        ExecEventHalfBlend(Event_RollingMagicRight, blend_type)
        return TRUE
    else
        ExecEventHalfBlend(Event_RollingMagicLeft, blend_type)
        return TRUE
    end
end

function ExecJumpMagic(jump_type)
    if c_HasActionRequest == FALSE then
        return FALSE
    end

    local wep_hand = HAND_RIGHT
    if c_Style == HAND_LEFT_BOTH then
        wep_hand = HAND_LEFT
    end

    local buttonR = ACTION_ARM_MAGIC_R
    local buttonL = ACTION_ARM_MAGIC_L

    local sp_kind = env(GetEquipWeaponSpecialCategoryNumber, wep_hand)
    if IsWeaponCatalyst(sp_kind) == TRUE then
        buttonR = ACTION_ARM_MAGIC_R2
    end

    local sp_kind_L = env(GetEquipWeaponSpecialCategoryNumber, HAND_LEFT)
    if c_Style == HAND_RIGHT and IsWeaponCatalyst(sp_kind_L) == TRUE then
        buttonL = ACTION_ARM_MAGIC_L2
    end

    if env(ActionRequest, buttonR) == FALSE and env(ActionRequest, buttonL) == FALSE then
        return FALSE
    end
    if env(GetStamina) <= 0 then
        ResetRequest()
        return FALSE
    end
    if GetVariable("JumpAttackForm") >= 1 or IS_ATTACKED_JUMPMAGIC == TRUE then
        ResetRequest()
        return FALSE
    end
    if env(IsMagicUseMenuOpened) == TRUE then
        return FALSE
    end

    local style = c_Style
    local magic_hand = HAND_RIGHT
    local wep_hand = HAND_RIGHT
    local delayActRequestNo = -1
    local is_samagic = FALSE

    if env(ActionRequest, buttonR) == TRUE then
        delayActRequestNo = ACTION_ARM_MAGIC_R

        if style == HAND_LEFT_BOTH then
            if GetEquipType(HAND_LEFT, WEAPON_CATEGORY_STAFF) == FALSE and IsWeaponCatalyst(sp_kind) == FALSE then
                return FALSE
            end

            wep_hand = HAND_LEFT
        else
            if GetEquipType(HAND_RIGHT, WEAPON_CATEGORY_STAFF) == FALSE and IsWeaponCatalyst(sp_kind) == FALSE then
                return FALSE
            end

            wep_hand = HAND_RIGHT
        end
    elseif env(ActionRequest, buttonL) == TRUE then
        delayActRequestNo = ACTION_ARM_MAGIC_L
        if style == HAND_RIGHT_BOTH or style == HAND_LEFT_BOTH then
            return FALSE
        end
        if GetEquipType(HAND_LEFT, WEAPON_CATEGORY_STAFF) == FALSE and IsWeaponCatalyst(sp_kind_L) == FALSE then
            return FALSE
        end

        wep_hand = HAND_LEFT
        magic_hand = HAND_LEFT
        act(DebugLogOutput, "MagicLeft")
    else
        return FALSE
    end

    act(DecideMagicUse)
    act(NotifyAIMagicCast)

    if IsJumpMagic() == FALSE and IsQuickMagic() == FALSE then
        ResetRequest()
        return FALSE
    end
    if env(IsMagicUseable, wep_hand, 0) == FALSE then
        ResetRequest()
        return FALSE
    end

    local magic_index = env(GetMagicAnimType)

    if magic_index == 254 or magic_index == 255 then
        ResetRequest()
        return FALSE
    end

    local is_atk_auto_aim = FALSE

    if magic_index == MAGIC_REQUEST_WHIP or magic_index == MAGIC_REQUEST_SLASH or magic_index ==
        MAGIC_REQUEST_QUICKSLASH or magic_index == MAGIC_REQUEST_FLAME_GRAB or magic_index == MAGIC_REQUEST_CRUSH or
        magic_index == MAGIC_REQUEST_CHOP or magic_index == MAGIC_REQUEST_SCYTHE then
        is_atk_auto_aim = TRUE
    end

    if IsJumpMagic() == TRUE then
        if magic_hand == HAND_RIGHT then
            ExecEventHalfBlend(Event_MagicFireRightJump, ALLBODY)
        else
            ExecEventHalfBlend(Event_MagicFireLeftJump, ALLBODY)
        end

        IS_ATTACKED_JUMPMAGIC = TRUE
        act(SetIsMagicInUse, TRUE)
        act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
        SetAIActionState()

        return TRUE
    elseif env(GetSpEffectID, 140) == TRUE and GetVariable("JumpAttackForm") == 0 then
        ExecEventSync("Event_JumpNormalAttack_Add")
        SetVariable("JumpAttackFormRequest", 3)
        SetVariable("JumpAttackForm", 4)

        if wep_hand == HAND_LEFT and c_Style == HAND_RIGHT then
            SetVariable("JumpAttack_HandCondition", 2)
        else
            SetVariable("JumpAttack_HandCondition", 0)
        end

        act(SetIsMagicInUse, TRUE)
        act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
        SetAIActionState()

        return TRUE
    elseif env(GetSpEffectID, 140) == FALSE and GetVariable("JumpAttack_Land") == 0 and GetVariable("JumpAttackForm") ==
        0 then
        SetVariable("JumpAttack_Land", 0)
        SetVariable("JumpAttackFormRequest", 3)
        SetVariable("JumpAttackForm", 4)

        if wep_hand == HAND_LEFT and c_Style == HAND_RIGHT then
            SetVariable("JumpAttack_HandCondition", 2)
        else
            SetVariable("JumpAttack_HandCondition", 0)
        end

        if jump_type == 0 then
            ExecEventNoReset("W_JumpAttack_Start_Falling")
        elseif jump_type == 1 then
            ExecEventNoReset("W_JumpAttack_Start_Falling_F")
        elseif jump_type == 2 then
            ExecEventNoReset("W_JumpAttack_Start_Falling_D")
        end

        act(SetIsMagicInUse, TRUE)
        act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
        SetAIActionState()

        return TRUE
    end
end

function ExecFallMagic()
    if c_HasActionRequest == FALSE then
        return FALSE
    end
    if env(ActionRequest, ACTION_ARM_MAGIC_R) == FALSE and env(ActionRequest, ACTION_ARM_MAGIC_L) == FALSE and
        env(ActionRequest, ACTION_ARM_MAGIC_R2) == FALSE and env(ActionRequest, ACTION_ARM_MAGIC_L2) == FALSE then
        return FALSE
    end
    if env(GetStamina) <= 0 then
        ResetRequest()
        return FALSE
    end
    if GetVariable("JumpAttackForm") >= 1 or IS_ATTACKED_JUMPMAGIC == TRUE then
        ResetRequest()
        return FALSE
    end
    if env(IsMagicUseMenuOpened) == TRUE then
        return FALSE
    end

    local style = c_Style
    local magic_hand = HAND_RIGHT
    local wep_hand = HAND_RIGHT
    local delayActRequestNo = -1
    local is_samagic = FALSE

    if env(ActionRequest, ACTION_ARM_MAGIC_R) == TRUE then
        delayActRequestNo = ACTION_ARM_MAGIC_R
        if style == HAND_LEFT_BOTH then
            if GetEquipType(HAND_LEFT, WEAPON_CATEGORY_STAFF) == FALSE then
                return FALSE
            end

            wep_hand = HAND_LEFT
        else
            if GetEquipType(HAND_RIGHT, WEAPON_CATEGORY_STAFF) == FALSE then
                return FALSE
            end

            wep_hand = HAND_RIGHT
        end
    elseif env(ActionRequest, ACTION_ARM_MAGIC_L) == TRUE then
        delayActRequestNo = ACTION_ARM_MAGIC_L
        if style == HAND_RIGHT_BOTH or style == HAND_LEFT_BOTH then
            return FALSE
        end
        if GetEquipType(HAND_LEFT, WEAPON_CATEGORY_STAFF) == FALSE then
            return FALSE
        end

        wep_hand = HAND_LEFT
        magic_hand = HAND_LEFT
        act(DebugLogOutput, "MagicLeft")
    elseif env(ActionRequest, ACTION_ARM_MAGIC_R2) == TRUE then
        delayActRequestNo = ACTION_ARM_MAGIC_R2

        if style == HAND_LEFT_BOTH then
            local sp_kind = env(GetEquipWeaponSpecialCategoryNumber, HAND_LEFT)

            if IsWeaponCatalyst(sp_kind) == FALSE then
                return FALSE
            end

            wep_hand = HAND_LEFT
        else
            local sp_kind = env(GetEquipWeaponSpecialCategoryNumber, HAND_RIGHT)

            if IsWeaponCatalyst(sp_kind) == FALSE then
                return FALSE
            end

            wep_hand = HAND_RIGHT
        end
    elseif env(ActionRequest, ACTION_ARM_MAGIC_L2) == TRUE then
        delayActRequestNo = ACTION_ARM_MAGIC_L2

        if style == HAND_RIGHT_BOTH or style == HAND_LEFT_BOTH then
            return FALSE
        end

        local sp_kind = env(GetEquipWeaponSpecialCategoryNumber, HAND_LEFT)

        if IsWeaponCatalyst(sp_kind) == FALSE then
            return FALSE
        end

        wep_hand = HAND_LEFT
        magic_hand = HAND_LEFT
        act(DebugLogOutput, "MagicLeft")
    else
        return FALSE
    end

    act(DecideMagicUse)
    act(NotifyAIMagicCast)

    if IsJumpMagic() == FALSE and IsQuickMagic() == FALSE then
        ResetRequest()
        return FALSE
    end
    if env(IsMagicUseable, wep_hand, 0) == FALSE then
        ResetRequest()
        return FALSE
    end

    local magic_index = env(GetMagicAnimType)

    if magic_index == 254 or magic_index == 255 then
        ResetRequest()
        return FALSE
    end

    local is_atk_auto_aim = FALSE

    if magic_index == MAGIC_REQUEST_WHIP or magic_index == MAGIC_REQUEST_SLASH or magic_index ==
        MAGIC_REQUEST_QUICKSLASH or magic_index == MAGIC_REQUEST_FLAME_GRAB or magic_index == MAGIC_REQUEST_CRUSH or
        magic_index == MAGIC_REQUEST_CHOP or magic_index == MAGIC_REQUEST_SCYTHE then
        is_atk_auto_aim = TRUE
    end

    if IsJumpMagic() == TRUE then
        if magic_hand == HAND_RIGHT then
            ExecEventHalfBlend(Event_MagicFireRightJump, ALLBODY)
        else
            ExecEventHalfBlend(Event_MagicFireLeftJump, ALLBODY)
        end

        IS_ATTACKED_JUMPMAGIC = TRUE
        act(SetIsMagicInUse, TRUE)
        act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
        SetAIActionState()

        return TRUE
    else

        SetVariable("JumpAttack_Land", 0)
        SetVariable("JumpAttackFormRequest", 3)
        SetVariable("JumpAttackForm", 4)

        if wep_hand == HAND_LEFT and c_Style == HAND_RIGHT then
            SetVariable("JumpAttack_HandCondition", 2)
        else
            SetVariable("JumpAttack_HandCondition", 0)
        end

        ExecEventNoReset("W_JumpAttack_Start_Falling")
        act(SetIsMagicInUse, TRUE)
        act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
        SetAIActionState()

        return TRUE
    end
end

----------------------
-- Common functions --
----------------------

function MagicCommonFunction(blend_type, quick_type, is_throw)
    if GetVariable("IsEnableToggleDashTest") == 2 then
        SetVariable("ToggleDash", 0)
    end

    if GetVariable("MoveSpeedLevel") <= 0 then
        act(FallPreventionAssist)
    end

    if is_throw ~= TRUE then
        SetThrowAtkInvalid()
    end

    SetAIActionState()
    act(SetIsMagicInUse, TRUE)

    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
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
    if ExecItem(QUICKTYPE_NORMAL, blend_type) == TRUE then
        return TRUE
    end
    if ExecMagic(QUICKTYPE_NORMAL, blend_type, FALSE) == TRUE then
        return TRUE
    end
    if ExecArtsStanceOnCancelTiming(ALLBODY) == TRUE then
        return TRUE
    end
    if ExecAttack("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, blend_type, FALSE, FALSE, FALSE) == TRUE then
        return TRUE
    end
    return FALSE
end

--------------
-- Triggers --
--------------

function Magic_Upper_Activate()
end

function MagicRight_Upper_Activate()
    local style = c_Style
    act(DebugLogOutput, "MagicRight_Upper_Activate check" .. style .. " ==" .. HAND_LEFT_BOTH)
    if style == HAND_LEFT_BOTH then
        SetAttackHand(HAND_LEFT)
        SetGuardHand(HAND_LEFT)
    else
        SetAttackHand(HAND_RIGHT)
        SetGuardHand(HAND_RIGHT)
    end
    ActivateRightArmAdd(START_FRAME_NONE)
end

function MagicRight_Upper_Update()
    UpdateRightArmAdd()
end

function MagicLeft_Upper_Activate()
    act(DebugLogOutput, "MagicLeft_Upper_Activate")
    SetAttackHand(HAND_LEFT)
    SetGuardHand(HAND_LEFT)
    ActivateRightArmAdd(START_FRAME_A02)
end

function MagicLeft_Upper_Update()
    UpdateRightArmAdd()
end

function MagicLaunchRight_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    local magic_index = env(GetMagicAnimType)
    if MagicCommonFunction(blend_type, QUICKTYPE_NORMAL, FALSE) == TRUE then
        return
    end
    if env(GetMagicAnimType) ~= MAGIC_REQUEST_CRYSTAL_MOON and blend_type ~= UPPER and
        ExecQuickTurn(LOWER, TURN_TYPE_DEFAULT) == TRUE then
        return TRUE
    end
    if env(IsAnimEndBySkillCancel) == TRUE or env(IsAnimEnd, 1) == TRUE then
        if ExecRollingMagic(HAND_RIGHT, magic_index, blend_type) == TRUE then
            return
        else
            ExecEventHalfBlend(Event_MagicFireRight, blend_type)
            return
        end
    end
    if HalfBlendLowerCommonFunction(Event_MagicLaunchRight, lower_state, FALSE) == TRUE then
        return
    end
end

function MagicLoopRight_Upper_onUpdate()
    act(NotifyAIOfBehaviourState, IDX_AINOTE_STATETYPE, IDX_AINOTE_STATETYPE_CHARGEMAGIC)
    local blend_type, lower_state = GetHalfBlendInfo()
    if MagicCommonFunction(blend_type, QUICKTYPE_NORMAL, FALSE) == TRUE then
        return
    end
    local wep_hand = HAND_RIGHT
    if c_Style == HAND_LEFT_BOTH then
        wep_hand = HAND_LEFT
    end

    local button = ACTION_ARM_R1
    local sp_kind = env(GetEquipWeaponSpecialCategoryNumber, wep_hand)
    if IsWeaponCatalyst(sp_kind) == TRUE then
        button = ACTION_ARM_R2
    end

    if env(ActionDuration, button) <= 0 or env(IsMagicUseable, wep_hand, 1) == FALSE or env(GetStamina) <= 0 then
        local magic_index = env(GetMagicAnimType)
        if magic_index == MAGIC_REQUEST_EX_LARGE_ARROW then
            ExecEventHalfBlend(Event_MagicFireRightCancel2, blend_type)
        else
            ExecEventHalfBlend(Event_MagicFireRightCancel, blend_type)
        end
        return
    end
    if HalfBlendLowerCommonFunction(Event_MagicLoopRight, lower_state, FALSE) == TRUE then
        return
    end
end

function MagicFireRight_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    local is_throw = FALSE
    local magic_index = env(GetMagicAnimType)
    if magic_index == MAGIC_REQUEST_MAD_THROW then
        is_throw = TRUE
    end
    if MagicCommonFunction(ALLBODY, QUICKTYPE_NORMAL, is_throw) == TRUE then
        return
    end
    local wep_hand = HAND_RIGHT
    if c_Style == HAND_LEFT_BOTH then
        wep_hand = HAND_LEFT
    end

    local button = ACTION_ARM_R1
    local sp_kind = env(GetEquipWeaponSpecialCategoryNumber, wep_hand)
    if IsWeaponCatalyst(sp_kind) == TRUE then
        button = ACTION_ARM_R2
    end

    if env(GetSpEffectID, 100610) == TRUE and
        (env(ActionDuration, button) <= 0 or env(IsMagicUseable, wep_hand, 1) == FALSE) then
        ExecEventHalfBlend(Event_MagicFireRightCancel, blend_type)
        return
    end

    if CheckIfHoldMagic() == TRUE and (env(IsAnimEndBySkillCancel) == TRUE or env(IsAnimEnd, 1) == TRUE) then
        if env(ActionDuration, button) > 0 then
            ExecEventHalfBlend(Event_MagicLoopRight, blend_type)
            return
        else
            ExecEventHalfBlend(Event_MagicFireRightCancel, blend_type)
            return
        end
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        SetMagicGeneratorTransitionIndex()
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        SetMagicGeneratorTransitionIndex()
        return
    end
    if HalfBlendLowerCommonFunction(Event_MagicFireRight, lower_state, FALSE) == TRUE then
        SetMagicGeneratorTransitionIndex()
        return
    end
end

function MagicFireRightCancel_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if MagicCommonFunction(ALLBODY, QUICKTYPE_NORMAL, FALSE) == TRUE then
        return
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        SetMagicGeneratorTransitionIndex()
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        SetMagicGeneratorTransitionIndex()
        return
    end
    if HalfBlendLowerCommonFunction(Event_MagicFireRightCancel, lower_state, FALSE) == TRUE then
        SetMagicGeneratorTransitionIndex()
        return
    end
end

function MagicLaunchLeft_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    local magic_index = env(GetMagicAnimType)
    if MagicCommonFunction(blend_type, QUICKTYPE_NORMAL, FALSE) == TRUE then
        return
    end
    if env(GetMagicAnimType) ~= MAGIC_REQUEST_CRYSTAL_MOON and blend_type ~= UPPER and
        ExecQuickTurn(LOWER, TURN_TYPE_DEFAULT) == TRUE then
        return TRUE
    end
    if env(IsAnimEndBySkillCancel) == TRUE or env(IsAnimEnd, 1) == TRUE then
        if ExecRollingMagic(HAND_LEFT, magic_index, blend_type) == TRUE then
            return
        else
            ExecEventHalfBlend(Event_MagicFireLeft, blend_type)
        end
    end
    if HalfBlendLowerCommonFunction(Event_MagicLaunchLeft, lower_state, FALSE) == TRUE then
        return
    end
end

function MagicLoopLeft_Upper_onUpdate()
    act(NotifyAIOfBehaviourState, IDX_AINOTE_STATETYPE, IDX_AINOTE_STATETYPE_CHARGEMAGIC)
    local blend_type, lower_state = GetHalfBlendInfo()
    if MagicCommonFunction(blend_type, QUICKTYPE_NORMAL, FALSE) == TRUE then
        return
    end
    local button = ACTION_ARM_L1
    local sp_kind = env(GetEquipWeaponSpecialCategoryNumber, HAND_LEFT)
    if IsWeaponCatalyst(sp_kind) == TRUE then
        button = ACTION_ARM_L2
    end
    if env(ActionDuration, button) <= 0 or env(IsMagicUseable, HAND_LEFT, 1) == FALSE or env(GetStamina) <= 0 then
        local magic_index = env(GetMagicAnimType)
        if magic_index == MAGIC_REQUEST_EX_LARGE_ARROW then
            ExecEventHalfBlend(Event_MagicFireLeftCancel2, blend_type)
        else
            ExecEventHalfBlend(Event_MagicFireLeftCancel, blend_type)
        end
    end
    if HalfBlendLowerCommonFunction(Event_MagicLoopLeft, lower_state, FALSE) == TRUE then
        return
    end
end

function MagicFireLeftCancel_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if MagicCommonFunction(ALLBODY, QUICKTYPE_NORMAL, FALSE) == TRUE then
        return
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        SetMagicGeneratorTransitionIndex()
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        SetMagicGeneratorTransitionIndex()
        return
    end
    if HalfBlendLowerCommonFunction(Event_MagicFireLeftCancel, lower_state, FALSE) == TRUE then
        SetMagicGeneratorTransitionIndex()
        return
    end
end

function MagicFireRight2_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if MagicCommonFunction(ALLBODY, QUICKTYPE_NORMAL, FALSE) == TRUE then
        return
    end
    local mp_condition = 0
    if GetVariable("IndexChargeMagicType") == 2 then
        mp_condition = 33
    end
    local wep_hand = HAND_RIGHT
    if c_Style == HAND_LEFT_BOTH then
        wep_hand = HAND_LEFT
    end
    local button = ACTION_ARM_R1
    local sp_kind = env(GetEquipWeaponSpecialCategoryNumber, wep_hand)
    if IsWeaponCatalyst(sp_kind) == TRUE then
        button = ACTION_ARM_R2
    end
    if env(GetSpEffectID, 100610) == TRUE and (env(ActionDuration, button) <= 0 or mp_condition >= env(GetFP)) then
        ExecEventHalfBlend(Event_MagicFireRightCancel2, blend_type)
        return
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_MagicFireRight2, lower_state, FALSE) == TRUE then
        return
    end
end

function MagicFireRight3_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if MagicCommonFunction(ALLBODY, QUICKTYPE_NORMAL, FALSE) == TRUE then
        return
    end
    local mp_condition = 0
    if GetVariable("IndexChargeMagicType") == 2 then
        mp_condition = 33
    end
    local wep_hand = HAND_RIGHT
    if c_Style == HAND_LEFT_BOTH then
        wep_hand = HAND_LEFT
    end
    local button = ACTION_ARM_R1
    local sp_kind = env(GetEquipWeaponSpecialCategoryNumber, wep_hand)
    if IsWeaponCatalyst(sp_kind) == TRUE then
        button = ACTION_ARM_R2
    end
    if env(GetSpEffectID, 100610) == TRUE and (env(ActionDuration, button) <= 0 or mp_condition >= env(GetFP)) then
        ExecEventHalfBlend(Event_MagicFireRightCancel3, blend_type)
        return
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_MagicFireRight3, lower_state, FALSE) == TRUE then
        return
    end
end

function MagicFireLeft_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    local is_throw = FALSE
    local magic_index = env(GetMagicAnimType)
    if magic_index == MAGIC_REQUEST_MAD_THROW then
        is_throw = TRUE
    end
    if MagicCommonFunction(ALLBODY, QUICKTYPE_NORMAL, is_throw) == TRUE then
        return
    end

    local button = ACTION_ARM_L1
    local sp_kind = env(GetEquipWeaponSpecialCategoryNumber, HAND_LEFT)
    if IsWeaponCatalyst(sp_kind) == TRUE then
        button = ACTION_ARM_L2
    end

    if env(GetSpEffectID, 100610) == TRUE and
        (env(ActionDuration, button) <= 0 or env(IsMagicUseable, HAND_LEFT, 1) == FALSE) then
        ExecEventHalfBlend(Event_MagicFireLeftCancel, blend_type)
        return
    end
    if CheckIfHoldMagic() == TRUE and (env(IsAnimEndBySkillCancel) == TRUE or env(IsAnimEnd, 1) == TRUE) then
        if env(ActionDuration, button) > 0 then
            ExecEventHalfBlend(Event_MagicLoopLeft, blend_type)
            return
        else
            ExecEventHalfBlend(Event_MagicFireLeftCancel, blend_type)
            return
        end
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        SetMagicGeneratorTransitionIndex()
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        SetMagicGeneratorTransitionIndex()
        return
    end
    if HalfBlendLowerCommonFunction(Event_MagicFireLeft, lower_state, FALSE) == TRUE then
        SetMagicGeneratorTransitionIndex()
        return
    end
end

function MagicFireRightCancel2_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if MagicCommonFunction(ALLBODY, QUICKTYPE_NORMAL, FALSE) == TRUE then
        return
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        SetMagicGeneratorTransitionIndex()
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        SetMagicGeneratorTransitionIndex()
        return
    end
    if HalfBlendLowerCommonFunction(Event_MagicFireRight2, lower_state, FALSE) == TRUE then
        SetMagicGeneratorTransitionIndex()
        return
    end
end

function MagicFireRightCancel3_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if MagicCommonFunction(ALLBODY, QUICKTYPE_NORMAL, FALSE) == TRUE then
        return
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_MagicFireRight3, lower_state, FALSE) == TRUE then
        return
    end
end

function MagicFireLeftCancel2_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if MagicCommonFunction(ALLBODY, QUICKTYPE_NORMAL, FALSE) == TRUE then
        return
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        SetMagicGeneratorTransitionIndex()
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        SetMagicGeneratorTransitionIndex()
        return
    end
    if HalfBlendLowerCommonFunction(Event_MagicFireLeft2, lower_state, FALSE) == TRUE then
        SetMagicGeneratorTransitionIndex()
        return
    end
end

function MagicFireLeft2_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if MagicCommonFunction(ALLBODY, QUICKTYPE_NORMAL, FALSE) == TRUE then
        return
    end

    local button = ACTION_ARM_L1
    local sp_kind = env(GetEquipWeaponSpecialCategoryNumber, HAND_LEFT)
    if IsWeaponCatalyst(sp_kind) == TRUE then
        button = ACTION_ARM_L2
    end

    if env(GetSpEffectID, 100610) == TRUE and
        (env(ActionDuration, button) <= 0 or env(IsMagicUseable, HAND_LEFT, 1) == FALSE) then
        ExecEventHalfBlend(Event_MagicFireLeftCancel2, blend_type)
        return
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_MagicFireLeft2, lower_state, FALSE) == TRUE then
        return
    end
end

function MagicFireLeftCancel3_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if MagicCommonFunction(ALLBODY, QUICKTYPE_NORMAL, FALSE) == TRUE then
        return
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_MagicFireLeftCancel3, lower_state, FALSE) == TRUE then
        return
    end
end

function MagicFireLeft3_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if MagicCommonFunction(ALLBODY, QUICKTYPE_NORMAL, FALSE) == TRUE then
        return
    end

    local button = ACTION_ARM_L1
    local sp_kind = env(GetEquipWeaponSpecialCategoryNumber, HAND_LEFT)
    if IsWeaponCatalyst(sp_kind) == TRUE then
        button = ACTION_ARM_L2
    end

    if env(GetSpEffectID, 100610) == TRUE and
        (env(ActionDuration, button) <= 0 or env(IsMagicUseable, HAND_LEFT, 1) == FALSE) then
        ExecEventHalfBlend(Event_MagicFireLeftCancel3, blend_type)
        return
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_MagicFireLeftCancel3, lower_state, FALSE) == TRUE then
        return
    end
end

function QuickMagicFireRightDash_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if MagicCommonFunction(blend_type, QUICKTYPE_ATTACK, FALSE) == TRUE then
        return
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_QuickMagicFireRightDash, lower_state, FALSE) == TRUE then
        return
    end
end

function QuickMagicFireRightStep_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if MagicCommonFunction(blend_type, QUICKTYPE_ATTACK, FALSE) == TRUE then
        return
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_QuickMagicFireRightStep, lower_state, FALSE) == TRUE then
        return
    end
end

function QuickMagicFireRightBackStep_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if MagicCommonFunction(blend_type, QUICKTYPE_ATTACK, FALSE) == TRUE then
        return
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_QuickMagicFireRightBackStep, lower_state, FALSE) == TRUE then
        return
    end
end

function QuickMagicFireRightAttackLeft_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if MagicCommonFunction(blend_type, QUICKTYPE_ATTACK, FALSE) == TRUE then
        return
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_QuickMagicFireRightAttackLeft, lower_state, FALSE) == TRUE then
        return
    end
end

function QuickMagicFireRightAttackRight_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if MagicCommonFunction(blend_type, QUICKTYPE_ATTACK, FALSE) == TRUE then
        return
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_QuickMagicFireRightAttackRight, lower_state, FALSE) == TRUE then
        return
    end
end

function QuickMagicFireLeftDash_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if MagicCommonFunction(blend_type, QUICKTYPE_ATTACK, FALSE) == TRUE then
        return
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_QuickMagicFireLeftDash, lower_state, FALSE) == TRUE then
        return
    end
end

function QuickMagicFireLeftStep_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if MagicCommonFunction(blend_type, QUICKTYPE_ATTACK, FALSE) == TRUE then
        return
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_QuickMagicFireLeftStep, lower_state, FALSE) == TRUE then
        return
    end
end

function QuickMagicFireLeftBackStep_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if MagicCommonFunction(blend_type, QUICKTYPE_ATTACK, FALSE) == TRUE then
        return
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_QuickMagicFireLeftBackStep, lower_state, FALSE) == TRUE then
        return
    end
end

function QuickMagicFireLeftAttackRight_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if MagicCommonFunction(blend_type, QUICKTYPE_ATTACK, FALSE) == TRUE then
        return
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_QuickMagicFireLeftAttackRight, lower_state, FALSE) == TRUE then
        return
    end
end

function QuickMagicFireLeftAttackLeft_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if MagicCommonFunction(blend_type, QUICKTYPE_ATTACK, FALSE) == TRUE then
        return
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_QuickMagicFireLeftAttackRight, lower_state, FALSE) == TRUE then
        return
    end
end

function MagicFireRightJump_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if MagicCommonFunction(ALLBODY, QUICKTYPE_NORMAL, FALSE) == TRUE then
        return
    end
    local wep_hand = HAND_RIGHT
    if c_Style == HAND_LEFT_BOTH then
        wep_hand = HAND_LEFT
    end

    local button = ACTION_ARM_R1
    local sp_kind = env(GetEquipWeaponSpecialCategoryNumber, wep_hand)
    if IsWeaponCatalyst(sp_kind) == TRUE then
        button = ACTION_ARM_R2
    end

    if env(GetSpEffectID, 100610) == TRUE and
        (env(ActionDuration, button) <= 0 or env(IsMagicUseable, wep_hand, 1) == FALSE) then
        ExecEventHalfBlend(Event_MagicFireRightJumpCancel, blend_type)
        return
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_MagicFireRightJump, lower_state, FALSE) == TRUE then
        return
    end
end

function MagicFireRightJumpCancel_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if MagicCommonFunction(ALLBODY, QUICKTYPE_NORMAL, FALSE) == TRUE then
        return
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_MagicFireRightJumpCancel, lower_state, FALSE) == TRUE then
        return
    end
end

function MagicFireLeftJump_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if MagicCommonFunction(ALLBODY, QUICKTYPE_NORMAL, FALSE) == TRUE then
        return
    end
    local wep_hand = HAND_LEFT
    local button = ACTION_ARM_L1
    local sp_kind = env(GetEquipWeaponSpecialCategoryNumber, wep_hand)
    if IsWeaponCatalyst(sp_kind) == TRUE then
        button = ACTION_ARM_L2
    end
    if env(GetSpEffectID, 100610) == TRUE and
        (env(ActionDuration, button) <= 0 or env(IsMagicUseable, wep_hand, 1) == FALSE) then
        ExecEventHalfBlend(Event_MagicFireRightJumpCancel, blend_type)
        return
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_MagicFireLeftJump, lower_state, FALSE) == TRUE then
        return
    end
end

function MagicFireLeftJumpCancel_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if MagicCommonFunction(ALLBODY, QUICKTYPE_NORMAL, FALSE) == TRUE then
        return
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_MagicFireLeftJumpCancel, lower_state, FALSE) == TRUE then
        return
    end
end

function StealthMagicRightLaunch_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if MagicCommonFunction(blend_type, QUICKTYPE_NORMAL, FALSE) == TRUE then
        return
    end
    if env(IsAnimEndBySkillCancel) == TRUE or env(IsAnimEnd, 1) == TRUE then
        ExecEventHalfBlend(Event_StealthMagicRightFire, blend_type)
        return
    end
    if HalfBlendLowerCommonFunction(Event_StealthMagicRightLaunch, lower_state, FALSE, FALSE) == TRUE then
        return
    end
end

function StealthMagicRightFire_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if MagicCommonFunction(blend_type, QUICKTYPE_NORMAL, FALSE) == TRUE then
        return
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Stealth_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_StealthMagicRightFire, lower_state, FALSE, FALSE) == TRUE then
        return
    end
end

function StealthMagicLeftLaunch_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if MagicCommonFunction(blend_type, QUICKTYPE_NORMAL, FALSE) == TRUE then
        return
    end
    if env(IsAnimEndBySkillCancel) == TRUE or env(IsAnimEnd, 1) == TRUE then
        ExecEventHalfBlend(Event_StealthMagicLeftFire, blend_type)
        return
    end
    if HalfBlendLowerCommonFunction(Event_StealthMagicLeftLaunch, lower_state, FALSE, FALSE) == TRUE then
        return
    end
end

function StealthMagicLeftFire_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if MagicCommonFunction(blend_type, QUICKTYPE_NORMAL, FALSE) == TRUE then
        return
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Stealth_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_StealthMagicLeftFire, lower_state, FALSE, FALSE) == TRUE then
        return
    end
end

function RollingMagicRight_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if MagicCommonFunction(blend_type, QUICKTYPE_NORMAL, FALSE) == TRUE then
        return
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_RollingMagicRight, lower_state, FALSE) == TRUE then
        return
    end
end

function RollingMagicLeft_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if MagicCommonFunction(blend_type, QUICKTYPE_NORMAL, FALSE) == TRUE then
        return
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_RollingMagicLeft, lower_state, FALSE) == TRUE then
        return
    end
end

function MagicInvalid_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if MagicCommonFunction(ALLBODY, QUICKTYPE_ATTACK, FALSE) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_MagicInvalidMirror, lower_state, FALSE) == TRUE then
        return
    end
end

function SAMagic_Default_onUpdate()
    SetVariable("SAMagicBlendRate", 0)
end


GetMagicPutOppositeWeapon = hookup_function(GetMagicPutOppositeWeapon)
SetMagicGeneratorTransitionIndex = hookup_function(SetMagicGeneratorTransitionIndex)
IsWeaponCatalyst = hookup_function(IsWeaponCatalyst)
IsMagicAnimExists = hookup_function(IsMagicAnimExists)
IsQuickMagic = hookup_function(IsQuickMagic)
IsWeaponEnchantMagic = hookup_function(IsWeaponEnchantMagic)
IsJumpMagic = hookup_function(IsJumpMagic)
IsComboMagic = hookup_function(IsComboMagic)
IsChargeMagic = hookup_function(IsChargeMagic)
CheckIfHoldMagic = hookup_function(CheckIfHoldMagic)
IsStealthMagic = hookup_function(IsStealthMagic)
IsRollingMagic = hookup_function(IsRollingMagic)
ExecMagic = hookup_function(ExecMagic)
ExecQuickMagic = hookup_function(ExecQuickMagic)
ExecComboMagic = hookup_function(ExecComboMagic)
ExecStealthMagic = hookup_function(ExecStealthMagic)
ExecRollingMagic = hookup_function(ExecRollingMagic)
ExecJumpMagic = hookup_function(ExecJumpMagic)
ExecFallMagic = hookup_function(ExecFallMagic)
MagicCommonFunction = hookup_function(MagicCommonFunction)
Magic_Upper_Activate = hookup_function(Magic_Upper_Activate)
MagicRight_Upper_Activate = hookup_function(MagicRight_Upper_Activate)
MagicRight_Upper_Update = hookup_function(MagicRight_Upper_Update)
MagicLeft_Upper_Activate = hookup_function(MagicLeft_Upper_Activate)
MagicLeft_Upper_Update = hookup_function(MagicLeft_Upper_Update)
MagicLaunchRight_Upper_onUpdate = hookup_function(MagicLaunchRight_Upper_onUpdate)
MagicLoopRight_Upper_onUpdate = hookup_function(MagicLoopRight_Upper_onUpdate)
MagicFireRight_Upper_onUpdate = hookup_function(MagicFireRight_Upper_onUpdate)
MagicFireRightCancel_Upper_onUpdate = hookup_function(MagicFireRightCancel_Upper_onUpdate)
MagicLaunchLeft_Upper_onUpdate = hookup_function(MagicLaunchLeft_Upper_onUpdate)
MagicLoopLeft_Upper_onUpdate = hookup_function(MagicLoopLeft_Upper_onUpdate)
MagicFireLeftCancel_Upper_onUpdate = hookup_function(MagicFireLeftCancel_Upper_onUpdate)
MagicFireRight2_Upper_onUpdate = hookup_function(MagicFireRight2_Upper_onUpdate)
MagicFireRight3_Upper_onUpdate = hookup_function(MagicFireRight3_Upper_onUpdate)
MagicFireLeft_Upper_onUpdate = hookup_function(MagicFireLeft_Upper_onUpdate)
MagicFireRightCancel2_Upper_onUpdate = hookup_function(MagicFireRightCancel2_Upper_onUpdate)
MagicFireRightCancel3_Upper_onUpdate = hookup_function(MagicFireRightCancel3_Upper_onUpdate)
MagicFireLeftCancel2_Upper_onUpdate = hookup_function(MagicFireLeftCancel2_Upper_onUpdate)
MagicFireLeft2_Upper_onUpdate = hookup_function(MagicFireLeft2_Upper_onUpdate)
MagicFireLeftCancel3_Upper_onUpdate = hookup_function(MagicFireLeftCancel3_Upper_onUpdate)
MagicFireLeft3_Upper_onUpdate = hookup_function(MagicFireLeft3_Upper_onUpdate)
QuickMagicFireRightDash_Upper_onUpdate = hookup_function(QuickMagicFireRightDash_Upper_onUpdate)
QuickMagicFireRightStep_Upper_onUpdate = hookup_function(QuickMagicFireRightStep_Upper_onUpdate)
QuickMagicFireRightBackStep_Upper_onUpdate = hookup_function(QuickMagicFireRightBackStep_Upper_onUpdate)
QuickMagicFireRightAttackLeft_Upper_onUpdate = hookup_function(QuickMagicFireRightAttackLeft_Upper_onUpdate)
QuickMagicFireRightAttackRight_Upper_onUpdate = hookup_function(QuickMagicFireRightAttackRight_Upper_onUpdate)
QuickMagicFireLeftDash_Upper_onUpdate = hookup_function(QuickMagicFireLeftDash_Upper_onUpdate)
QuickMagicFireLeftStep_Upper_onUpdate = hookup_function(QuickMagicFireLeftStep_Upper_onUpdate)
QuickMagicFireLeftBackStep_Upper_onUpdate = hookup_function(QuickMagicFireLeftBackStep_Upper_onUpdate)
QuickMagicFireLeftAttackRight_Upper_onUpdate = hookup_function(QuickMagicFireLeftAttackRight_Upper_onUpdate)
QuickMagicFireLeftAttackLeft_Upper_onUpdate = hookup_function(QuickMagicFireLeftAttackLeft_Upper_onUpdate)
MagicFireRightJump_Upper_onUpdate = hookup_function(MagicFireRightJump_Upper_onUpdate)
MagicFireRightJumpCancel_Upper_onUpdate = hookup_function(MagicFireRightJumpCancel_Upper_onUpdate)
MagicFireLeftJump_Upper_onUpdate = hookup_function(MagicFireLeftJump_Upper_onUpdate)
MagicFireLeftJumpCancel_Upper_onUpdate = hookup_function(MagicFireLeftJumpCancel_Upper_onUpdate)
StealthMagicRightLaunch_Upper_onUpdate = hookup_function(StealthMagicRightLaunch_Upper_onUpdate)
StealthMagicRightFire_Upper_onUpdate = hookup_function(StealthMagicRightFire_Upper_onUpdate)
StealthMagicLeftLaunch_Upper_onUpdate = hookup_function(StealthMagicLeftLaunch_Upper_onUpdate)
StealthMagicLeftFire_Upper_onUpdate = hookup_function(StealthMagicLeftFire_Upper_onUpdate)
RollingMagicRight_Upper_onUpdate = hookup_function(RollingMagicRight_Upper_onUpdate)
RollingMagicLeft_Upper_onUpdate = hookup_function(RollingMagicLeft_Upper_onUpdate)
MagicInvalid_Upper_onUpdate = hookup_function(MagicInvalid_Upper_onUpdate)
SAMagic_Default_onUpdate = hookup_function(SAMagic_Default_onUpdate)
