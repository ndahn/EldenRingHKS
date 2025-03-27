
drawStanceNoSyncLoop_NoMP = 0

------------------------------------------
-- Core: Includes from common_define
------------------------------------------
-- ivi: Constants for distinction of regular numbers to what exactly these mean.
SWORD_ART_DIFF_CAT_DEFAULT = 0
SWORD_ART_DIFF_CAT_LARGE_WEAPON = 2
SWORD_ART_DIFF_CAT_POLEARM = 3
SWORD_ART_DIFF_CAT_LARGE_WEAPON_SMALL_SHIELD = 4
SWORD_ART_DIFF_CAT_POLEARM_SMALL_SHIELD = 5
SWORD_ART_DIFF_CAT_LARGE_WEAPON_LARGE_SHIELD = 8
SWORD_ART_DIFF_CAT_POLEARM_LARGE_SHIELD = 9

-- Stores possible override animations that exist for Sword Arts.
-- Key: Sword Art ID (TAE ID minus 600)
-- Possible values:
--
-- 0: Idle (Default or Large Rapier)
-- 2: Idle (Great Weapon)
-- 3: Idle (Polearm)
-- 4: Idle (Great Weapon) + Small Shield
-- 5: Idle (Polearm) + Small Shield
-- 8: Idle (Great Weapon) + Large Shield
-- 9: Idle (Polearm) + Large Shield
-- 20-59: Weapon Category
SwordArtsCategory = {
    [0] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [1] = {SWORD_ART_DIFF_CAT_DEFAULT, SWORD_ART_DIFF_CAT_LARGE_WEAPON, SWORD_ART_DIFF_CAT_POLEARM,
           WEAPON_CATEGORY_FIST, WEAPON_CATEGORY_DUELING_SHIELD},
    [2] = {SWORD_ART_DIFF_CAT_DEFAULT, WEAPON_CATEGORY_DUELING_SHIELD},
    [3] = {SWORD_ART_DIFF_CAT_DEFAULT, SWORD_ART_DIFF_CAT_LARGE_WEAPON, SWORD_ART_DIFF_CAT_POLEARM,
           WEAPON_CATEGORY_TWINBLADE, WEAPON_CATEGORY_BACKHAND_SWORD},
    [4] = {SWORD_ART_DIFF_CAT_DEFAULT, SWORD_ART_DIFF_CAT_LARGE_WEAPON, SWORD_ART_DIFF_CAT_POLEARM},
    [5] = {SWORD_ART_DIFF_CAT_DEFAULT, WEAPON_CATEGORY_DUELING_SHIELD},
    [6] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [7] = {SWORD_ART_DIFF_CAT_DEFAULT, SWORD_ART_DIFF_CAT_LARGE_WEAPON, SWORD_ART_DIFF_CAT_POLEARM},
    [8] = {SWORD_ART_DIFF_CAT_DEFAULT, SWORD_ART_DIFF_CAT_LARGE_WEAPON, SWORD_ART_DIFF_CAT_POLEARM,
           WEAPON_CATEGORY_DUELING_SHIELD},
    [9] = {SWORD_ART_DIFF_CAT_DEFAULT, SWORD_ART_DIFF_CAT_LARGE_WEAPON, SWORD_ART_DIFF_CAT_POLEARM,
           WEAPON_CATEGORY_DUELING_SHIELD},
    [10] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [11] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [12] = {SWORD_ART_DIFF_CAT_DEFAULT, SWORD_ART_DIFF_CAT_LARGE_WEAPON, SWORD_ART_DIFF_CAT_POLEARM},
    [13] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [14] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [15] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [16] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [17] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [18] = {SWORD_ART_DIFF_CAT_DEFAULT, SWORD_ART_DIFF_CAT_POLEARM},
    [19] = {SWORD_ART_DIFF_CAT_DEFAULT, WEAPON_CATEGORY_BACKHAND_SWORD},
    [20] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [21] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [22] = {SWORD_ART_DIFF_CAT_DEFAULT, SWORD_ART_DIFF_CAT_POLEARM, WEAPON_CATEGORY_TWINBLADE},
    [23] = {SWORD_ART_DIFF_CAT_DEFAULT, SWORD_ART_DIFF_CAT_POLEARM, WEAPON_CATEGORY_TWINBLADE},
    [24] = {SWORD_ART_DIFF_CAT_DEFAULT, SWORD_ART_DIFF_CAT_LARGE_WEAPON, SWORD_ART_DIFF_CAT_POLEARM,
            WEAPON_CATEGORY_TWINBLADE, WEAPON_CATEGORY_BACKHAND_SWORD},
    [25] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [50] = {SWORD_ART_DIFF_CAT_DEFAULT, WEAPON_CATEGORY_DUELING_SHIELD},
    [51] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [52] = {SWORD_ART_DIFF_CAT_DEFAULT, WEAPON_CATEGORY_TWINBLADE},
    [53] = {SWORD_ART_DIFF_CAT_DEFAULT, WEAPON_CATEGORY_DUELING_SHIELD},
    [54] = {SWORD_ART_DIFF_CAT_DEFAULT, SWORD_ART_DIFF_CAT_LARGE_WEAPON, WEAPON_CATEGORY_TWINBLADE},
    [55] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [56] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [57] = {SWORD_ART_DIFF_CAT_DEFAULT, SWORD_ART_DIFF_CAT_LARGE_WEAPON},
    [58] = {SWORD_ART_DIFF_CAT_DEFAULT, WEAPON_CATEGORY_BACKHAND_SWORD, WEAPON_CATEGORY_DUELING_SHIELD},
    [59] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [61] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [62] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [63] = {SWORD_ART_DIFF_CAT_DEFAULT, WEAPON_CATEGORY_BACKHAND_SWORD},
    [64] = {SWORD_ART_DIFF_CAT_DEFAULT, WEAPON_CATEGORY_FIST, WEAPON_CATEGORY_MARTIAL_ARTS,
            WEAPON_CATEGORY_DUELING_SHIELD, WEAPON_CATEGORY_BEAST_CLAW},
    [65] = {SWORD_ART_DIFF_CAT_DEFAULT, SWORD_ART_DIFF_CAT_POLEARM},
    [66] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [67] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [68] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [69] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [70] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [71] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [72] = {SWORD_ART_DIFF_CAT_DEFAULT, WEAPON_CATEGORY_BACKHAND_SWORD},
    [73] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [74] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [75] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [76] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [90] = {SWORD_ART_DIFF_CAT_DEFAULT, WEAPON_CATEGORY_LARGE_SHIELD, WEAPON_CATEGORY_SMALL_SHIELD,
            WEAPON_CATEGORY_DUELING_SHIELD},
    [91] = {SWORD_ART_DIFF_CAT_DEFAULT, SWORD_ART_DIFF_CAT_LARGE_WEAPON, SWORD_ART_DIFF_CAT_POLEARM,
            SWORD_ART_DIFF_CAT_LARGE_WEAPON_SMALL_SHIELD, SWORD_ART_DIFF_CAT_POLEARM_SMALL_SHIELD,
            SWORD_ART_DIFF_CAT_LARGE_WEAPON_LARGE_SHIELD, SWORD_ART_DIFF_CAT_POLEARM_LARGE_SHIELD,
            WEAPON_CATEGORY_LARGE_SHIELD, WEAPON_CATEGORY_SMALL_SHIELD, WEAPON_CATEGORY_DUELING_SHIELD},
    [92] = {SWORD_ART_DIFF_CAT_DEFAULT, WEAPON_CATEGORY_SHORT_SWORD, WEAPON_CATEGORY_CURVEDSWORD,
            WEAPON_CATEGORY_SMALL_SHIELD, WEAPON_CATEGORY_THROW_DAGGER},
    [93] = {SWORD_ART_DIFF_CAT_DEFAULT, SWORD_ART_DIFF_CAT_LARGE_WEAPON, SWORD_ART_DIFF_CAT_POLEARM},
    [94] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [95] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [96] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [97] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [98] = {SWORD_ART_DIFF_CAT_DEFAULT, WEAPON_CATEGORY_LARGE_SHIELD, WEAPON_CATEGORY_SMALL_SHIELD,
            WEAPON_CATEGORY_DUELING_SHIELD},
    [99] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [100] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [101] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [102] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [103] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [105] = {SWORD_ART_DIFF_CAT_DEFAULT, WEAPON_CATEGORY_LARGE_ARROW},
    [106] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [108] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [110] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [107] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [109] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [111] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [112] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [113] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [114] = {SWORD_ART_DIFF_CAT_DEFAULT, WEAPON_CATEGORY_DUELING_SHIELD},
    [115] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [116] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [117] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [118] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [130] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [131] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [132] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [133] = {SWORD_ART_DIFF_CAT_DEFAULT, WEAPON_CATEGORY_DUELING_SHIELD},
    [134] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [135] = {SWORD_ART_DIFF_CAT_DEFAULT, WEAPON_CATEGORY_DUELING_SHIELD},
    [136] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [137] = {SWORD_ART_DIFF_CAT_DEFAULT, WEAPON_CATEGORY_BACKHAND_SWORD, WEAPON_CATEGORY_LARGE_KATANA},
    [140] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [141] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [142] = {SWORD_ART_DIFF_CAT_DEFAULT, WEAPON_CATEGORY_DUELING_SHIELD},
    [143] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [144] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [150] = {SWORD_ART_DIFF_CAT_DEFAULT, SWORD_ART_DIFF_CAT_LARGE_WEAPON, WEAPON_CATEGORY_FIST,
             WEAPON_CATEGORY_MARTIAL_ARTS, WEAPON_CATEGORY_PERFUME_BOTTLE, WEAPON_CATEGORY_DUELING_SHIELD,
             WEAPON_CATEGORY_BEAST_CLAW},
    [151] = {SWORD_ART_DIFF_CAT_DEFAULT, WEAPON_CATEGORY_DUELING_SHIELD},
    [152] = {SWORD_ART_DIFF_CAT_DEFAULT, WEAPON_CATEGORY_DUELING_SHIELD},
    [155] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [156] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [157] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [160] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [165] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [166] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [167] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [168] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [196] = {SWORD_ART_DIFF_CAT_DEFAULT, SWORD_ART_DIFF_CAT_LARGE_WEAPON, SWORD_ART_DIFF_CAT_POLEARM},
    [256] = {SWORD_ART_DIFF_CAT_DEFAULT, WEAPON_CATEGORY_TWINBLADE},
    [257] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [258] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [260] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [261] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [262] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [263] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [264] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [265] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [269] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [273] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [274] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [276] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [277] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [278] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [279] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [280] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [281] = {SWORD_ART_DIFF_CAT_DEFAULT, WEAPON_CATEGORY_DUELING_SHIELD},
    [282] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [283] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [284] = {SWORD_ART_DIFF_CAT_DEFAULT, SWORD_ART_DIFF_CAT_LARGE_WEAPON, SWORD_ART_DIFF_CAT_POLEARM},
    [285] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [286] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [305] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [357] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [340] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [341] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [342] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [343] = {SWORD_ART_DIFF_CAT_DEFAULT},
    [399] = {SWORD_ART_DIFF_CAT_DEFAULT}
}

-- Determines which override of a Sword Art animation to play, based on the size or type of the weapon.
-- The return of this func is processed to a different ID by the cases that use it.
--
-- artID: Weapon Arts ID (TAE id minus 600)
--      swordArtsTypeNew in SwordArtsParam
-- idleCat: Stay Anim Category (Idle animation index for weapon)
--      wepmotionOneHandId and wepmotionBothHandId in EquipParamWeapon
-- wepCat: Weapon Animation Category (TAE ID for weapon type)
--      wepmotionCategory in EquipParamWeapon
--
-- Possible returns:
--
-- 0: Idle (Default or Large Rapier)
-- 2: Idle (Great Weapon)
-- 3: Idle (Polearm)
-- 4: Idle (Great Weapon) + Small Shield
-- 5: Idle (Polearm) + Small Shield
-- 8: Idle (Great Weapon) + Large Shield
-- 9: Idle (Polearm) + Large Shield
-- 20-59: Weapon Category
function GetSwordArtsDiffCategory(artID, idleCat, wepCat)
    -- If TAE ID above 770 (except 796), no overrides, only a single default animation. Also DLC stuff
    if 170 <= artID and artID < 255 and artID ~= 196 or artID >= 300 and artID ~= 305 and artID ~= 357 and artID ~= 399 or
        artID == 275 or artID == 272 then
        return SWORD_ART_DIFF_CAT_DEFAULT
    end
    -- For TAE ID 769 (Radahn's Rain), return 45 (Greatbow)
    if artID == 169 then
        return WEAPON_CATEGORY_LARGE_ARROW
    end

    -- Allows some weapon categories to query for whether the Sword Art permits a cousin category.
    -- Only used to allow Claws to use Fist Sword Arts.
    local wep_cat1 = wepCat
    if wepCat == WEAPON_CATEGORY_CLAW then
        wep_cat1 = WEAPON_CATEGORY_FIST
    elseif wep_cat1 == WEAPON_CATEGORY_LIGHT_LARGE_SWORD then
        return 0
    end

    -- Idle animation TAEs. Two-hand is ignored.
    local idle_cat0 = idleCat
    if idle_cat0 >= 10 then
        idle_cat0 = idle_cat0 - 10
    end

    -- Override for heavy thrusting swords (usually 3)
    if wepCat == WEAPON_CATEGORY_LARGE_RAPIER then
        idle_cat0 = SWORD_ART_DIFF_CAT_DEFAULT
    end

    if (artID == 90 or artID == 98 or artID == 151 or artID == 152) and env(GetEquipWeaponCategory, c_SwordArtsHand) ==
        WEAPON_CATEGORY_DUELING_SHIELD and (c_Style == HAND_LEFT or c_Style == HAND_RIGHT) then
        return 0
    end

    -- ivi: CASE 0: Not in table
    if SwordArtsCategory[artID] == nil then
        return SWORD_ART_DIFF_CAT_DEFAULT
    end

    -- CASE 1: Shields
    if c_SwordArtsHand == HAND_LEFT and c_Style ~= HAND_LEFT_BOTH then
        local shield_cat = -1
        if idle_cat0 == 2 and wepCat == WEAPON_CATEGORY_SMALL_SHIELD then
            shield_cat = SWORD_ART_DIFF_CAT_LARGE_WEAPON_SMALL_SHIELD
        elseif idle_cat0 == 3 and wepCat == WEAPON_CATEGORY_SMALL_SHIELD then
            shield_cat = SWORD_ART_DIFF_CAT_POLEARM_SMALL_SHIELD
        elseif idle_cat0 == 2 and wepCat == WEAPON_CATEGORY_LARGE_SHIELD then
            shield_cat = SWORD_ART_DIFF_CAT_LARGE_WEAPON_LARGE_SHIELD
        elseif idle_cat0 == 3 and wepCat == WEAPON_CATEGORY_LARGE_SHIELD then
            shield_cat = SWORD_ART_DIFF_CAT_POLEARM_LARGE_SHIELD
        end
        if shield_cat ~= -1 then
            -- Only check if shields
            for i = 1, #SwordArtsCategory[artID], 1 do
                if SwordArtsCategory[artID][i] == shield_cat then
                    env(DebugLogOutput, "GetSwordArtsDiffCategory shield_cat:" .. shield_cat)
                    return shield_cat
                end
            end
        end
    end

    -- CASE 2: Weapon Categories
    for j = 1, #SwordArtsCategory[artID], 1 do
        if SwordArtsCategory[artID][j] == wepCat then
            env(DebugLogOutput, "GetSwordArtsDiffCategory wepCat0:" .. wepCat)
            return wepCat
        end
    end

    -- ivi: Additional check to avoid unnecessary second loop
    if wep_cat1 ~= nil then
        -- CASE 3: Auxiliary weapon category (Some weapon categories count the same as others)
        for j = 1, #SwordArtsCategory[artID], 1 do
            if SwordArtsCategory[artID][j] == wep_cat1 then
                env(DebugLogOutput, "GetSwordArtsDiffCategory wepCat1:" .. wep_cat1)
                return wep_cat1
            end
        end
    end

    -- Shield Arts (90 is Shield Bash, 99 is Thops Barrier)
    if artID >= 90 and artID <= 99 and (c_SwordArtsHand ~= HAND_LEFT or c_Style == HAND_LEFT_BOTH) then
        return SWORD_ART_DIFF_CAT_DEFAULT
    end

    -- CASE 4: Idle categories
    for j = 1, #SwordArtsCategory[artID], 1 do
        if SwordArtsCategory[artID][j] == idle_cat0 then
            env(DebugLogOutput, "GetSwordArtsDiffCategory idle_cat0:" .. idle_cat0)
            return idle_cat0
        end
    end

    return SWORD_ART_DIFF_CAT_DEFAULT
end

-- Table storing information about weapon arts.
-- Concerns playing a "weapon retrieval" animation after
-- the sword art was executed.
--
-- Table key: Sword Art ID (TAE ID minus 600)
-- Value 1: Right hand, weapon art cast from right hand
-- Value 2: Right hand, weapon art cast from left hand
-- Value 3: Left hand
--
-- TRUE: Weapon was sheathed during animation, play retrieval animation.
-- FALSE: Weapon was used to perform the sword art, no retrieval animation.
SwordArtPutOppositeWeapon = {
    [0] = {TRUE, FALSE, TRUE},
    [1] = {TRUE, FALSE, TRUE},
    [2] = {TRUE, FALSE, TRUE},
    [3] = {TRUE, FALSE, TRUE},
    -- 4 (Not present)
    [5] = {TRUE, FALSE, TRUE},
    [6] = {TRUE, FALSE, TRUE},
    [7] = {TRUE, FALSE, TRUE},
    [8] = {FALSE, FALSE, TRUE},
    [9] = {FALSE, FALSE, TRUE},
    [10] = {TRUE, FALSE, TRUE},
    [11] = {TRUE, FALSE, TRUE},
    [12] = {TRUE, FALSE, TRUE},
    [13] = {TRUE, FALSE, TRUE},
    [14] = {TRUE, FALSE, TRUE},
    [15] = {TRUE, FALSE, TRUE},
    [16] = {TRUE, FALSE, TRUE},
    [17] = {FALSE, FALSE, FALSE},
    [18] = {TRUE, FALSE, TRUE},
    [19] = {TRUE, FALSE, TRUE},
    [20] = {TRUE, FALSE, TRUE},
    -- 21 (Present)
    [22] = {TRUE, FALSE, TRUE},
    [23] = {TRUE, FALSE, TRUE},
    [24] = {FALSE, FALSE, TRUE},
    [25] = {TRUE, FALSE, TRUE},
    -- 26-49 (Not present)
    [50] = {FALSE, FALSE, TRUE},
    [51] = {TRUE, FALSE, TRUE},
    [52] = {TRUE, FALSE, TRUE},
    [53] = {FALSE, FALSE, TRUE},
    [54] = {TRUE, FALSE, TRUE},
    [55] = {TRUE, FALSE, FALSE},
    [56] = {TRUE, FALSE, TRUE},
    [57] = {TRUE, FALSE, TRUE},
    [58] = {TRUE, FALSE, TRUE},
    [59] = {TRUE, FALSE, TRUE},
    [61] = {TRUE, FALSE, TRUE},
    [62] = {TRUE, FALSE, FALSE},
    [63] = {TRUE, FALSE, TRUE},
    [64] = {FALSE, FALSE, TRUE},
    [65] = {TRUE, FALSE, TRUE},
    [66] = {TRUE, FALSE, TRUE},
    [67] = {TRUE, FALSE, TRUE},
    [68] = {TRUE, FALSE, TRUE},
    [69] = {TRUE, FALSE, TRUE},
    [70] = {TRUE, FALSE, TRUE},
    [71] = {TRUE, FALSE, TRUE},
    [72] = {TRUE, FALSE, TRUE},
    [73] = {TRUE, FALSE, TRUE},
    [74] = {FALSE, FALSE, TRUE},
    [75] = {TRUE, FALSE, TRUE},
    [76] = {TRUE, FALSE, TRUE},
    -- 77-89 (Not present)
    [90] = {TRUE, FALSE, TRUE},
    [91] = {FALSE, FALSE, FALSE},
    [92] = {FALSE, FALSE, TRUE},
    [93] = {FALSE, FALSE, TRUE},
    [94] = {FALSE, FALSE, TRUE},
    [95] = {FALSE, FALSE, TRUE},
    [96] = {FALSE, FALSE, TRUE},
    [97] = {FALSE, FALSE, TRUE},
    [98] = {TRUE, TRUE, TRUE},
    [99] = {FALSE, FALSE, FALSE},
    [100] = {FALSE, FALSE, FALSE},
    [101] = {FALSE, FALSE, FALSE},
    [102] = {FALSE, FALSE, FALSE},
    [103] = {FALSE, FALSE, FALSE},
    -- 104 (Not present)
    [105] = {FALSE, FALSE, FALSE},
    [106] = {FALSE, FALSE, FALSE},
    -- 107 (Not Present)
    [108] = {FALSE, FALSE, FALSE},
    -- 109 (Not present)
    [110] = {FALSE, FALSE, TRUE},
    [111] = {FALSE, FALSE, TRUE},
    [112] = {FALSE, FALSE, TRUE},
    [113] = {FALSE, FALSE, TRUE},
    [114] = {TRUE, FALSE, TRUE},
    [115] = {FALSE, FALSE, TRUE},
    [116] = {FALSE, FALSE, TRUE},
    [117] = {TRUE, FALSE, TRUE},
    [118] = {TRUE, FALSE, TRUE},
    -- 119-129 (Not present)
    [130] = {FALSE, FALSE, TRUE},
    [131] = {FALSE, FALSE, TRUE},
    [132] = {TRUE, FALSE, TRUE},
    [133] = {FALSE, FALSE, TRUE},
    [134] = {TRUE, FALSE, TRUE},
    [135] = {TRUE, FALSE, TRUE},
    [136] = {TRUE, FALSE, TRUE},
    [137] = {FALSE, FALSE, TRUE},
    [140] = {FALSE, FALSE, TRUE},
    [141] = {FALSE, FALSE, TRUE},
    [142] = {FALSE, FALSE, TRUE},
    [143] = {FALSE, FALSE, TRUE},
    [144] = {TRUE, FALSE, TRUE},
    [150] = {TRUE, FALSE, TRUE},
    [151] = {FALSE, FALSE, TRUE},
    [152] = {TRUE, TRUE, TRUE},
    [155] = {FALSE, FALSE, TRUE},
    [156] = {FALSE, FALSE, TRUE},
    [157] = {FALSE, FALSE, TRUE},
    [160] = {FALSE, FALSE, TRUE},
    [165] = {TRUE, FALSE, TRUE},
    [166] = {TRUE, FALSE, TRUE},
    [167] = {TRUE, FALSE, TRUE},
    [168] = {TRUE, FALSE, TRUE},
    [169] = {FALSE, FALSE, FALSE},
    [170] = {TRUE, FALSE, TRUE},
    [171] = {FALSE, FALSE, TRUE},
    [172] = {TRUE, FALSE, FALSE},
    [173] = {TRUE, FALSE, TRUE},
    [174] = {FALSE, FALSE, TRUE},
    [175] = {TRUE, FALSE, TRUE},
    [176] = {TRUE, FALSE, TRUE},
    [177] = {TRUE, FALSE, TRUE},
    [178] = {TRUE, FALSE, TRUE},
    [179] = {TRUE, FALSE, TRUE},
    -- 180
    -- 181
    [182] = {FALSE, FALSE, TRUE},
    [183] = {TRUE, FALSE, TRUE},
    [184] = {TRUE, FALSE, TRUE},
    [185] = {TRUE, FALSE, TRUE},
    [186] = {TRUE, FALSE, TRUE},
    [187] = {FALSE, FALSE, TRUE},
    [188] = {TRUE, FALSE, TRUE},
    [189] = {TRUE, FALSE, TRUE},
    [190] = {FALSE, FALSE, FALSE},
    [191] = {TRUE, FALSE, FALSE},
    [192] = {TRUE, FALSE, TRUE},
    [193] = {FALSE, FALSE, TRUE},
    [194] = {FALSE, FALSE, TRUE},
    [195] = {FALSE, TRUE, FALSE},
    [196] = {FALSE, FALSE, FALSE},
    [197] = {FALSE, FALSE, FALSE},
    [198] = {FALSE, FALSE, TRUE},
    [199] = {TRUE, FALSE, TRUE},
    [200] = {TRUE, FALSE, TRUE},
    [201] = {TRUE, TRUE, FALSE},
    [202] = {TRUE, TRUE, FALSE},
    [203] = {TRUE, FALSE, TRUE},
    [204] = {TRUE, FALSE, TRUE},
    [205] = {TRUE, FALSE, TRUE},
    [206] = {FALSE, FALSE, TRUE},
    [207] = {TRUE, FALSE, TRUE},
    [208] = {TRUE, FALSE, TRUE},
    [209] = {TRUE, FALSE, TRUE},
    [210] = {FALSE, FALSE, TRUE},
    [211] = {FALSE, FALSE, FALSE},
    [212] = {FALSE, FALSE, TRUE},
    [213] = {TRUE, FALSE, TRUE},
    [214] = {TRUE, FALSE, TRUE},
    [215] = {TRUE, FALSE, TRUE},
    [216] = {FALSE, FALSE, TRUE},
    [217] = {FALSE, FALSE, TRUE},
    [218] = {TRUE, FALSE, TRUE},
    [219] = {TRUE, FALSE, FALSE},
    [220] = {FALSE, FALSE, TRUE},
    [221] = {FALSE, FALSE, TRUE},
    [222] = {TRUE, FALSE, TRUE},
    [223] = {TRUE, FALSE, TRUE},
    [224] = {TRUE, FALSE, TRUE},
    [225] = {TRUE, FALSE, TRUE},
    [226] = {TRUE, FALSE, TRUE},
    [227] = {TRUE, FALSE, TRUE},
    [228] = {TRUE, FALSE, TRUE},
    [229] = {TRUE, FALSE, TRUE},
    [230] = {FALSE, FALSE, TRUE},
    [231] = {TRUE, FALSE, TRUE},
    [232] = {TRUE, FALSE, FALSE},
    [233] = {TRUE, FALSE, TRUE},
    [234] = {TRUE, FALSE, TRUE},
    [235] = {TRUE, FALSE, TRUE},
    [236] = {TRUE, FALSE, TRUE},
    [237] = {TRUE, FALSE, TRUE},
    [238] = {TRUE, FALSE, TRUE},
    [239] = {TRUE, FALSE, TRUE},
    [240] = {TRUE, FALSE, TRUE},
    [241] = {TRUE, FALSE, TRUE},
    [242] = {TRUE, FALSE, TRUE},
    [243] = {TRUE, FALSE, TRUE},
    [244] = {TRUE, FALSE, TRUE},
    [245] = {FALSE, FALSE, TRUE},
    [246] = {TRUE, FALSE, TRUE},
    [247] = {FALSE, FALSE, FALSE},
    [248] = {TRUE, FALSE, FALSE},
    [249] = {TRUE, FALSE, FALSE},
    [250] = {TRUE, FALSE, TRUE},
    [251] = {TRUE, FALSE, TRUE},
    [252] = {TRUE, FALSE, FALSE},
    [253] = {TRUE, FALSE, TRUE},
    [254] = {TRUE, FALSE, TRUE},
    [255] = {FALSE, FALSE, TRUE},
    [256] = {FALSE, FALSE, TRUE},
    [257] = {FALSE, FALSE, TRUE},
    [258] = {TRUE, FALSE, FALSE},
    [259] = {FALSE, FALSE, TRUE},
    [260] = {TRUE, FALSE, TRUE},
    [261] = {FALSE, FALSE, TRUE},
    [262] = {FALSE, FALSE, TRUE},
    [263] = {TRUE, FALSE, TRUE},
    [264] = {FALSE, FALSE, TRUE},
    [265] = {FALSE, FALSE, TRUE},
    [266] = {FALSE, FALSE, TRUE},
    [267] = {FALSE, FALSE, TRUE},
    [268] = {FALSE, FALSE, TRUE},
    [269] = {FALSE, FALSE, TRUE},
    [270] = {FALSE, FALSE, TRUE},
    [271] = {FALSE, FALSE, TRUE},
    [272] = {TRUE, FALSE, TRUE},
    [273] = {TRUE, FALSE, TRUE},
    [274] = {TRUE, FALSE, TRUE},
    [275] = {TRUE, FALSE, TRUE},
    [276] = {FALSE, FALSE, TRUE},
    [277] = {TRUE, FALSE, TRUE},
    [278] = {TRUE, FALSE, TRUE},
    [279] = {FALSE, FALSE, TRUE},
    [280] = {FALSE, FALSE, TRUE},
    [281] = {TRUE, FALSE, TRUE},
    [282] = {TRUE, FALSE, TRUE},
    [283] = {FALSE, FALSE, TRUE},
    [284] = {TRUE, FALSE, TRUE},
    [285] = {TRUE, FALSE, TRUE},
    [286] = {FALSE, FALSE, TRUE},
    [287] = {FALSE, FALSE, TRUE},
    [288] = {FALSE, FALSE, TRUE},
    [289] = {FALSE, FALSE, TRUE},
    [290] = {FALSE, FALSE, TRUE},
    [291] = {FALSE, FALSE, TRUE},
    [292] = {FALSE, FALSE, TRUE},
    [293] = {FALSE, FALSE, TRUE},
    [294] = {FALSE, FALSE, TRUE},
    [295] = {FALSE, FALSE, TRUE},
    [296] = {FALSE, FALSE, TRUE},
    [297] = {FALSE, FALSE, TRUE},
    [298] = {FALSE, FALSE, TRUE},
    [299] = {FALSE, FALSE, TRUE},
    [300] = {TRUE, FALSE, TRUE},
    [301] = {FALSE, FALSE, TRUE},
    [302] = {FALSE, FALSE, TRUE},
    [303] = {FALSE, FALSE, TRUE},
    [304] = {TRUE, FALSE, TRUE},
    [305] = {FALSE, FALSE, TRUE},
    [306] = {FALSE, FALSE, TRUE},
    [307] = {FALSE, FALSE, TRUE},
    [308] = {TRUE, FALSE, TRUE},
    [309] = {TRUE, FALSE, TRUE},
    [310] = {TRUE, FALSE, TRUE},
    [311] = {TRUE, FALSE, TRUE},
    [312] = {FALSE, FALSE, TRUE},
    [313] = {TRUE, FALSE, TRUE},
    [314] = {TRUE, FALSE, TRUE},
    [315] = {TRUE, FALSE, TRUE},
    [316] = {TRUE, FALSE, TRUE},
    [317] = {TRUE, FALSE, TRUE},
    [318] = {TRUE, FALSE, TRUE},
    [319] = {FALSE, FALSE, TRUE},
    [320] = {TRUE, FALSE, TRUE},
    [321] = {FALSE, FALSE, TRUE},
    [322] = {TRUE, FALSE, TRUE},
    [323] = {FALSE, FALSE, TRUE},
    [324] = {TRUE, TRUE, TRUE},
    [325] = {FALSE, FALSE, TRUE},
    [326] = {FALSE, FALSE, TRUE},
    [327] = {TRUE, FALSE, TRUE},
    [328] = {FALSE, FALSE, TRUE},
    [329] = {TRUE, FALSE, TRUE},
    [330] = {FALSE, FALSE, TRUE},
    [331] = {TRUE, FALSE, TRUE},
    [332] = {FALSE, FALSE, TRUE},
    [333] = {FALSE, FALSE, TRUE},
    [334] = {FALSE, FALSE, TRUE},
    [335] = {TRUE, FALSE, TRUE},
    [336] = {TRUE, FALSE, TRUE},
    [337] = {FALSE, FALSE, FALSE},
    [338] = {FALSE, FALSE, TRUE},
    [339] = {FALSE, FALSE, TRUE},
    [340] = {TRUE, FALSE, TRUE},
    [341] = {TRUE, FALSE, TRUE},
    [342] = {TRUE, FALSE, TRUE},
    [343] = {TRUE, FALSE, TRUE},
    [344] = {TRUE, FALSE, FALSE},
    [345] = {TRUE, FALSE, FALSE},
    [346] = {FALSE, FALSE, FALSE},
    [347] = {FALSE, FALSE, FALSE},
    [348] = {FALSE, FALSE, TRUE},
    [349] = {TRUE, FALSE, TRUE},
    [350] = {TRUE, FALSE, TRUE},
    [351] = {TRUE, FALSE, TRUE},
    [352] = {FALSE, FALSE, TRUE},
    [353] = {TRUE, FALSE, TRUE},
    [354] = {TRUE, FALSE, TRUE},
    [355] = {TRUE, FALSE, TRUE},
    [356] = {FALSE, FALSE, TRUE},
    [357] = {FALSE, FALSE, FALSE},
    [358] = {FALSE, FALSE, TRUE},
    [359] = {TRUE, FALSE, TRUE},
    [360] = {FALSE, FALSE, TRUE},
    [361] = {TRUE, FALSE, TRUE},
    [362] = {TRUE, FALSE, TRUE},
    [363] = {FALSE, FALSE, TRUE},
    [364] = {TRUE, FALSE, TRUE},
    [365] = {FALSE, FALSE, TRUE},
    [366] = {FALSE, FALSE, TRUE},
    [367] = {FALSE, FALSE, TRUE},
    [368] = {TRUE, FALSE, TRUE},
    [369] = {FALSE, FALSE, TRUE},
    [370] = {FALSE, FALSE, TRUE},
    [371] = {FALSE, FALSE, FALSE},
    [372] = {FALSE, FALSE, TRUE},
    [373] = {FALSE, FALSE, TRUE},
    [374] = {FALSE, FALSE, TRUE},
    [375] = {FALSE, FALSE, TRUE},
    [376] = {FALSE, FALSE, TRUE},
    [377] = {FALSE, FALSE, TRUE},
    [378] = {FALSE, FALSE, TRUE},
    [379] = {FALSE, FALSE, TRUE},
    [380] = {FALSE, FALSE, TRUE},
    [399] = {FALSE, FALSE, TRUE}
}

-- Decides whether to perform a "retrieve weapon" animation after finishing a Weapon Art.
-- See the above table for reference.
function GetSwordArtsPutOppositeWeapon()
    -- ivi: In Fromsoft's original code, this was nil by default. FALSE is more forgiving for custom weapon arts.
    local result = FALSE

    -- ivi: Add sanity check for absent entries (custom Sword Arts).
    if SwordArtPutOppositeWeapon[c_SwordArtsID] ~= nil then
        if c_Style == HAND_RIGHT then
            if HAND_RIGHT == c_SwordArtsHand then
                if c_SwordArtsID == 276 and GetVariable("SwordArtsRollingDirection") == 3 then
                    result = TRUE -- DLC special case
                else
                    result = SwordArtPutOppositeWeapon[c_SwordArtsID][1] -- Right hand, weapon art cast from right hand
                end
            else
                result = SwordArtPutOppositeWeapon[c_SwordArtsID][2] -- Right hand, weapon art cast from left hand
            end
        elseif env(GetEquipWeaponCategory, c_SwordArtsHand) == WEAPON_CATEGORY_THROW_DAGGER or
            env(GetEquipWeaponCategory, c_SwordArtsHand) == WEAPON_CATEGORY_BACKHAND_SWORD then
            result = SwordArtPutOppositeWeapon[c_SwordArtsID][1] -- DLC special case
        else
            result = SwordArtPutOppositeWeapon[c_SwordArtsID][3] -- Left hand
        end
    end

    return result
end

function SetArtCancelType()
    if IsEnableSwordArts() == TRUE then
        act(SetWeaponCancelType, env(GetWeaponCancelType, c_SwordArtsHand))
    else
        act(SetWeaponCancelType, 0)
    end
end

function GetSwordArtInfo()
    local style = c_Style
    local is_both = FALSE

    if style >= HAND_LEFT_BOTH then
        is_both = TRUE
    end

    local art_id = 0
    local art_hand = 0

    if is_both == TRUE then
        if style == HAND_RIGHT_BOTH then
            art_hand = HAND_RIGHT
        elseif style == HAND_LEFT_BOTH then
            art_hand = HAND_LEFT
        end

        art_id = env(GetSwordArtID, art_hand)
    else
        local weaponswordartid = env(GetSwordArtID, HAND_LEFT)

        if IsShieldArts(weaponswordartid) == FALSE and IsArrowStanceArts(weaponswordartid) == FALSE then
            art_hand = HAND_RIGHT
            art_id = env(GetSwordArtID, HAND_RIGHT)
        else
            art_hand = HAND_LEFT
            art_id = weaponswordartid
        end
    end

    if env(GetSpEffectID, 102150) == TRUE then
        art_id = 0
    elseif env(GetSpEffectID, 102151) == TRUE then
        art_id = 0
    end

    return art_id, art_hand
end

function IsEnableSwordArts()
    -- 17 is Torch Attack

    local style = c_Style
    local arts_id = c_SwordArtsID

    local sp_kind = env(GetEquipWeaponSpecialCategoryNumber, HAND_LEFT)

    if env(IsOnMount) == TRUE then
        return FALSE
    end

    if style ~= HAND_LEFT_BOTH and c_SwordArtsHand == 0 then
        if IsWeaponCatalyst(sp_kind) == TRUE then
            return FALSE
        end
        if IsShieldArts(arts_id) == TRUE then
            return TRUE
        else
            return FALSE
        end
    else
        if style == HAND_RIGHT and IsWeaponCatalyst(sp_kind) == TRUE then
            return FALSE
        end
        if arts_id ~= 17 and arts_id ~= SWORDARTS_INVALID then
            return TRUE
        end
    end
    return FALSE
end

function GreyOutSwordArtFE()
    if c_IsEnableSwordArts == FALSE then
        act(SetArtsPointFEDisplayState, 1)
        return
    end

    if c_SwordArtsID == SWORDARTS_PARRY then
        act(SetArtsPointFEDisplayState, 1)
    else
        act(SetArtsPointFEDisplayState, 0)
    end
end

function IsAttackSwordArts(arts_id)
    local aow_blacklist = {157, -- Raptor of the Mists
    160 -- White Shadow's Lure
    }
    local aow_whitelist = {273, -- Raging Beast
    276, -- Blind Spot
    313, -- Dynastic Sickleplay
    348 -- Discus Hurl
    }

    if IsShieldArts(arts_id) == TRUE or IsRollingArts(arts_id) == TRUE or IsEnchantArts(arts_id) == TRUE or
        Contains(aow_blacklist, arts_id) == TRUE then
        if Contains(aow_whitelist, arts_id) then
            return TRUE
        else
            return FALSE
        end
    else
        return TRUE
    end
end

function IsHalfBlendArts(arts_id)
    local aow_list = {20, -- Spinning Weapon
    58, -- Gravitas
    168, -- Zamor Ice Storm
    182, -- Knowledge Above All
    183, -- Devourer of Worlds
    184, -- Familal Rancor
    199, -- Spinning Weapon
    202, -- Tongues of Fire
    203, -- Oracular Bubble
    206, -- Sea of Magma
    213, -- Soul Stifler
    217, -- Glintstone Dart
    264, -- Wall of Sparks
    328, -- Euporia Vortex
    334, -- Feeble Lord's Frenzied Flame
    335 -- Repeating Fire
    }

    if Contains(aow_list, arts_id) == TRUE then
        return TRUE
    else
        return FALSE
    end
end

function IsEnchantArts(arts_id)
    if 130 <= arts_id and arts_id <= 140 then
        return TRUE
    else
        return FALSE
    end
end

function IsShieldArts(arts_id)
    local aow_list = {17, -- Torch Attack
    71, -- Firebreather
    90, -- Shield Bash
    91, -- Barricade Shield
    92, -- Parry
    93, -- Buckler Parry
    95, -- Carian Retaliation
    96, -- Storm Wall
    97, -- Golden Parry
    98, -- Shield Crash
    99, -- Thops's Barrier
    151, -- Vow of the Indomitable
    152, -- Holy Ground
    195, -- Fires of Slumber
    196, -- Golden Retaliation
    197, -- Contagious Fury
    201, -- Flame Spit
    202, -- Tongues of Fire
    207, -- Viper Bite
    211, -- Bear Witness!
    322, -- Sleep Evermore
    324, -- Moore's Charge
    348, -- Discus Hurl
    352, -- Revenge of the Night
    354, -- Blindfold of Happiness
    355, -- Blindfold of Happiness (2?)
    359, -- Roaring Bash
    399, -- Shield Strike
    334 -- Feeble Lord's Frenzied Flame
    }

    if Contains(aow_list, arts_id) == TRUE then
        return TRUE
    else
        return FALSE
    end
end

function IsStanceArts(arts_id)
    local aow_list = {10, -- Wild Strikes
    11, -- Spinning Strikes
    14, -- Unsheathe
    15, -- Square Off
    21, -- UNUSED
    25, -- Spinning Chain
    100, -- Through and Through
    101, -- Barrage
    102, -- Mighty Shot
    103, -- Enchanted Shot
    104, -- UNUSED
    105, -- Rain of Arrows
    106, -- UNUSED
    107, -- UNUSED
    108, -- Sky Shot
    169, -- Radahn's Rain
    178, -- Transient Moonlight
    219, -- Night-and-Flame Stance
    239, -- Spinning Wheel
    278, -- Overhead Stance
    279, -- Wing Stance
    309, -- Unending Dance
    318, -- Moon-and-Fire Stance
    335, -- Repeating Fire
    337, -- Fan Shot
    340, -- UNUSED
    341, -- UNUSED
    342, -- UNUSED
    343, -- UNUSED
    346, -- UNUSED
    347, -- UNUSED
    357, -- Igor's Drake Hunt
    371 -- Rancor Shot
    }

    if Contains(aow_list, arts_id) == TRUE then
        return TRUE
    else
        return FALSE
    end
end

function IsArrowStanceArts(arts_id)
    local aow_list = {100, -- Through and Through
    101, -- Barrage
    102, -- Mighty Shot
    103, -- Enchanted Shot
    104, -- UNUSED
    105, -- Rain of Arrows
    106, -- UNUSED
    107, -- UNUSED
    108, -- Sky Shot
    169, -- Radahn's Rain
    337, -- Fan Shot
    357, -- Igor's Drake Hunt
    371 -- Rancor Shot
    }

    if Contains(aow_list, arts_id) == TRUE then
        return TRUE
    else
        return FALSE
    end
end

function IsAttackStanceArts(arts_id)
    local aow_list = {10, -- Wild Strikes
    11, -- Spinning Strikes
    25, -- Spinning Chain
    239, -- Spinning Wheel
    309, -- Unending Dance
    340, -- UNUSED
    341 -- UNUSED
    }

    if Contains(aow_list, arts_id) == TRUE then
        return TRUE
    else
        return FALSE
    end
end

function IsRollingArts(arts_id)
    local aow_list = {155, -- Quickstep
    156, -- Bloodhound's Step
    273, -- Raging Beast
    276, -- Blind Spot
    313 -- Dynastic Sickleplay
    }

    if Contains(aow_list, arts_id) == TRUE then
        return TRUE
    else
        return FALSE
    end
end

function GetSwordArtsRequestNew()
    local style = c_Style
    local is_both = FALSE
    local arts_hand = c_SwordArtsHand
    local arts_id = c_SwordArtsID
    local request = SWORDART_REQUEST_INVALID
    local arts_category = arts_id + 600
    local animID = SWORDARTS_ANIM_ID_RIGHT_NORMAL

    if IsStanceArts(arts_id) == TRUE then
        request = SWORDARTS_REQUEST_RIGHT_STANCE
        animID = SWORDARTS_ANIM_ID_RIGHT_STANCE_START
    elseif env(GetSpEffectID, 100052) == TRUE then
        request = SWORDARTS_REQUEST_RIGHT_COMBO_1
        animID = SWORDARTS_ANIM_ID_RIGHT_COMBO_1
    elseif env(GetSpEffectID, 100053) == TRUE then
        request = SWORDARTS_REQUEST_RIGHT_COMBO_2
        animID = SWORDARTS_ANIM_ID_RIGHT_COMBO_2
    elseif IsRollingArts(arts_id) == TRUE then
        request = SWORDARTS_REQUEST_RIGHT_STEP
        animID = SWORDARTS_ANIM_ID_RIGHT_STEP_FRONT
    elseif (style == HAND_LEFT_BOTH or style == HAND_RIGHT_BOTH) and IsShieldArts(arts_id) == TRUE then
        request = SWORDARTS_REQUEST_BOTH_NORMAL
        animID = SWORDARTS_ANIM_ID_BOTH_NORMAL
    elseif arts_hand == HAND_LEFT and IsShieldArts(arts_id) == TRUE then
        request = SWORDARTS_REQUEST_LEFT_NORMAL
        animID = SWORDARTS_ANIM_ID_LEFT_NORMAL
    else
        request = SWORDARTS_REQUEST_RIGHT_NORMAL
        animID = SWORDARTS_ANIM_ID_RIGHT_NORMAL
    end

    act(DebugLogOutput,
        "SwordArtRequest " .. request .. " artsId=" .. arts_id .. "animID=a" .. arts_category .. "_" .. animID)

    return request
end

function HasSwordArtPoint(button, hand)
    return env(HasEnoughArtsPoints, button, hand)
end

function SetSwordArtsPointInfo(button, is_point_consume, to_state_event)
    local aow_list_noFPUse = {17, -- Torch Attack
    92, -- Parry
    93, -- Buckler Parry
    94, -- UNUSED
    112 -- Kick
    }

    local hand = c_SwordArtsHand

    if is_point_consume == TRUE then
        act(ReserveArtsPointsUse, button, hand)
    end

    local sel = 0
    local isNoMPUse = FALSE
    local artsID = env(GetSwordArtID, hand)

    if Contains(aow_list_noFPUse, artsID) == TRUE then
        isNoMPUse = TRUE
    end

    if env(HasEnoughArtsPoints, button, hand) == FALSE and isNoMPUse == FALSE then
        sel = 1
        act(DebugLogOutput, "no artspoint , hand=" .. hand)
    elseif env(IsAbilityInsufficient, hand) == TRUE and isNoMPUse == FALSE then
        sel = 1
        act(DebugLogOutput, "no ability , hand=" .. hand)
    end

    local val = "IsEnoughArtPointsL2"

    if button == ACTION_ARM_R1 then
        if c_SwordArtsID == 318 and IsNodeActive("DrawStanceRightAttackLight_Selector") == TRUE then
            val = "IsEnoughArtPointsR2_MesmerSowrdArts"
        else
            val = "IsEnoughArtPointsR1"
        end
    elseif button == ACTION_ARM_R2 then
        val = "IsEnoughArtPointsR2"
    elseif button == ACTION_ARM_L2 and c_SwordArtsID == 334 and
        (IsNodeActive("SwordArtsOneShot Selector00") == TRUE or
            IsNodeActive("SwordArtsHalfOneShotShieldBoth_Upper Selector") == TRUE or
            IsNodeActive("SwordArtsOneShotShieldLeft Selector01") == TRUE) then
        val = "IsEnoughArtPointsL2_MadTorchEnd"
    end

    if to_state_event ~= nil then
        if to_state_event == "W_SwordArtsOneShotComboEnd_2" then
            val = "IsEnoughArtPointsR2_2"
        elseif to_state_event == "W_SwordArtsOneShotComboEnd" then
            val = "IsEnoughArtPointsR2"
        end
    end

    if artsID == 309 or artsID == 318 then
        SetVariable("IsEnoughArtPointsL2_DrawStanceRightStart", sel)
    else
        SetVariable("IsEnoughArtPointsL2_DrawStanceRightStart", 0)
    end
    if artsID == 318 then
        SetVariable("IsEnoughArtPointsL2_DrawStanceRightEnd", sel)
    else
        SetVariable("IsEnoughArtPointsL2_DrawStanceRightEnd", 0)
    end
    if artsID == 334 then
        SetVariable("IsEnoughArtPointsL2_MadTorchEnd", sel)
    else
        SetVariable("IsEnoughArtPointsL2_MadTorchEnd", 0)
    end
    if artsID == 309 and IsNodeActive("DrawStanceNoSyncLoop_Upper Selector00") == TRUE then
        SetVariable("IsEnoughArtPointsL2_DrawStanceNoSyncLoop", sel)
    else
        SetVariable(val, sel)
    end
end

function RequestArtPointConsumption(button, hand)
    act(ReserveArtsPointsUse, button, hand)
end

function CheckIfNonGeneratorTransition()
    local kind_right = env(GetEquipWeaponCategory, HAND_RIGHT)
    local kind_left = env(GetEquipWeaponCategory, HAND_LEFT)

    if kind_left == WEAPON_CATEGORY_FIST then
        return TRUE
    end
    return FALSE
end

function SetArtsGeneratorTransitionIndex()
    if GetSwordArtsPutOppositeWeapon() == FALSE then
        SetVariable("ArtsTransition", 0)
        return
    end

    local style = c_Style

    if style == HAND_RIGHT then
        if CheckIfNonGeneratorTransition() == TRUE then
            SetVariable("ArtsTransition", 0)
            return
        end

        local hand = HAND_LEFT

        if c_SwordArtsHand == HAND_LEFT then
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
        local idle_cat = env(GetStayAnimCategory)

        if env(GetEquipWeaponCategory, c_SwordArtsHand) == 53 or env(GetEquipWeaponCategory, c_SwordArtsHand) == 58 then
            if c_SwordArtsHand == HAND_RIGHT then
                SetVariable("ArtsTransition", 1)
            else
                SetVariable("ArtsTransition", 2)
            end
            return
        elseif idle_cat < 10 then
            SetVariable("ArtsTransition", 0)
            return
        end
        SetVariable("ArtsTransition", 9)
    end
end

function ExecArtsStance(blend_type)
    if c_IsEnableSwordArts == FALSE then
        return FALSE
    end
    local arts_id = c_SwordArtsID
    local is_arrow = GetEquipType(c_SwordArtsHand, WEAPON_CATEGORY_ARROW, WEAPON_CATEGORY_SMALL_ARROW,
        WEAPON_CATEGORY_LARGE_ARROW)
    local is_crossbow = GetEquipType(HAND_LEFT, WEAPON_CATEGORY_CROSSBOW, WEAPON_CATEGORY_BALLISTA)

    if c_Style == HAND_RIGHT and (is_arrow == TRUE or is_crossbow == TRUE) then
        return FALSE
    end
    if IsAttackStanceArts(arts_id) == TRUE then
        if env(GetStamina) <= 0 then
            return FALSE
        end
        if env(ActionRequest, ACTION_ARM_L2) == FALSE then
            return FALSE
        end
    elseif GetEquipType(c_SwordArtsHand, WEAPON_CATEGORY_LARGE_ARROW) == TRUE then
        if env(ActionRequest, ACTION_ARM_L2) == FALSE or env(ActionDuration, ACTION_ARM_L2) <= 0 then
            return FALSE
        end
    elseif IsStanceArts(arts_id) == TRUE then
        if env(ActionDuration, ACTION_ARM_L2) <= 0 then
            return FALSE
        end
    else
        return FALSE
    end

    if c_IsStealth == TRUE then
        blend_type = ALLBODY
    end

    if blend_type == ALLBODY and MoveStart(LOWER, Event_Move, FALSE) == TRUE then
        blend_type = UPPER
    end

    SetVariable("SwordArtsOneShotComboCategory", 0)

    if c_SwordArtsID == 318 then
        SetSwordArtsPointInfo(ACTION_ARM_R1, TRUE)
    else
        SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)
    end

    if env(GetSpEffectID, 19921) == TRUE then
        ExecEventHalfBlendNoReset(Event_DrawStanceRightLoop, blend_type)
    else
        ExecEventHalfBlend(Event_DrawStanceRightStart, blend_type)
    end

    act(SetNpcAIAttackRequestIDAfterBlend, env(GetNpcAIAttackRequestID))
    SetAIActionState()

    return TRUE
end

function ExecArtsStanceOnCancelTiming(blend_type)
    if env(IsWeaponCancelPossible) == TRUE and ExecArtsStance(blend_type) == TRUE then
        return TRUE
    end
    return FALSE
end

----------------------
-- Common functions --
----------------------

function ArtsCommonFunction(r1, r2, l1, l2, b1, b2, guardcondition, artsr1, artsr2, gen_trans, can_throw, blend_type)
    if can_throw == FALSE then
        SetThrowAtkInvalid()
    end

    SetAIActionState()
    act(SetCanChangeEquipmentOff)

    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
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
    if ExecItem(QUICKTYPE_ATTACK, blend_type) == TRUE then
        ClearAttackQueue()
        return TRUE
    end
    if ExecMagic(QUICKTYPE_ATTACK, blend_type, FALSE) == TRUE then
        ClearAttackQueue()
        return TRUE
    end
    if ExecArtsStanceOnCancelTiming(ALLBODY) == TRUE then
        return TRUE
    end
    if ExecAttack(r1, r2, l1, l2, b1, b2, guardcondition, blend_type, artsr1, artsr2, FALSE) == TRUE then
        ClearAttackQueue()
        return TRUE
    end
    if ExecQuickTurnOnCancelTiming() == TRUE then
        ClearAttackQueue()
        return TRUE
    end
    if ExecJump() == TRUE then
        ClearAttackQueue()
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, blend_type) == TRUE then
        ClearAttackQueue()
        return TRUE
    end

    local guardcondition = FALSE

    if env(GetSpEffectID, 100410) == TRUE then
        guardcondition = TO_GUARDON
    end

    if c_SwordArtsID ~= 335 and ExecGuardOnCancelTiming(guardcondition, blend_type) == TRUE then
        ClearAttackQueue()
        return TRUE
    end
    if MoveStartonCancelTiming(Event_Move, gen_trans) == TRUE then
        ClearAttackQueue()
        return TRUE
    end
    if ExecGesture() == TRUE then
        ClearAttackQueue()
        return TRUE
    end
    return FALSE
end

function ArtsParryCommonFunction()
    SetAIActionState()

    if ExecPassiveAction(TRUE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
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
    if ExecArtsStanceOnCancelTiming(ALLBODY) == TRUE then
        return TRUE
    end
    if ExecAttack("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, ALLBODY, FALSE, FALSE, FALSE) == TRUE then
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
    if MoveStartonCancelTiming(Event_Move, FALSE) == TRUE then
        return TRUE
    end
    if ExecGesture() == TRUE then
        return TRUE
    end
    return FALSE
end

function ArtsStanceCommonFunction(r1, r2, l1, l2, b1, b2, blend_type, turn_type, artsr1, artsr2, is_stance_end,
    enable_turn)
    if is_stance_end == FALSE then
        SetThrowAtkInvalid()
    end

    SetAIActionState()
    act(SetCanChangeEquipmentOff)

    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
        return TRUE
    end
    if ExecJump() == TRUE then
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, blend_type) == TRUE then
        return TRUE
    end
    if c_SwordArtsID ~= 335 and env(ActionDuration, ACTION_ARM_L1) < 440 and ExecGuardOnCancelTiming(FALSE, blend_type) ==
        TRUE then
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
    if ExecMagic(QUICKTYPE_NORMAL, ALLBODY, FALSE) == TRUE then
        return TRUE
    end
    if is_stance_end == TRUE and ExecArtsStanceOnCancelTiming(blend_type) == TRUE then
        return TRUE
    end
    if ExecAttack(r1, r2, l1, l2, b1, b2, FALSE, blend_type, artsr1, artsr2, FALSE) == TRUE then
        return TRUE
    end
    if blend_type ~= UPPER and enable_turn and ExecQuickTurn(LOWER, turn_type) == TRUE then
        return TRUE
    end
    if MoveStartonCancelTiming(Event_Move, FALSE) == TRUE then
        if is_stance_end == TRUE then
            SetArtsGeneratorTransitionIndex()
        end

        ClearAttackQueue()
        return TRUE
    end
    return FALSE
end

function ArtsChargeShotCommonFunction()
    SetAIActionState()

    if env(GetEventEzStateFlag, 1) == FALSE then
        act(SetTurnSpeed, 0)
    end

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
    if ExecItem(QUICKTYPE_NORMAL, blend_type) == TRUE then
        return TRUE
    end
    if ExecMagic(QUICKTYPE_NORMAL, ALLBODY, FALSE) == TRUE then
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

function SwordArts_Activate()
    local hand = c_SwordArtsHand
    SetAttackHand(hand)
    SetGuardHand(hand)
    ActivateRightArmAdd(START_FRAME_NONE)
end

function SwordArts_Update()
    UpdateRightArmAdd()
end

function DrawStanceRightStart_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if GetEquipType(c_SwordArtsHand, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_ARROW, WEAPON_CATEGORY_LARGE_ARROW) ==
        TRUE then
        act(SetIsPreciseShootingPossible)
        if ArrowCommonFunction(blend_type, FALSE, TURN_TYPE_STANCE) == TRUE then
            return
        end
        if ArrowStanceCommonFunction(blend_type, FALSE) == TRUE then
            return
        end
    end
    if GetEquipType(c_SwordArtsHand, WEAPON_CATEGORY_CROSSBOW) == TRUE then
        act(SetIsPreciseShootingPossible)
        if CrossbowStanceCommonFunction(blend_type, FALSE) == TRUE then
            return
        end
    end
    local r1 = "W_DrawStanceRightAttackLight"
    local r2 = "W_DrawStanceRightAttackHeavy"
    local b1 = "W_DrawStanceRightAttackLight"
    local b2 = "W_DrawStanceRightAttackHeavy"
    if c_SwordArtsID == 239 or c_SwordArtsID == 309 then
        r1 = "W_AttackRightLight2"
        r2 = "W_AttackRightHeavy1Start"
        b1 = "W_AttackBothLight2"
        b2 = "W_AttackBothHeavy1Start"
    end

    if env(GetSpEffectID, 100530) == TRUE then
        r1 = "W_SwordArtsStanceAttackLightStart"
        r2 = "W_SwordArtsStanceAttackHeavyStart"
        b1 = "W_SwordArtsStanceAttackLightStart"
        b2 = "W_SwordArtsStanceAttackHeavyStart"
    elseif env(GetSpEffectID, 100540) == TRUE then
        r1 = "W_SwordArtsStanceAttackLight180"
        r2 = "W_SwordArtsStanceAttackHeavy180"
        b1 = "W_SwordArtsStanceAttackLight180"
        b2 = "W_SwordArtsStanceAttackHeavy180"
    end
    local enable_turn = TRUE
    if c_SwordArtsID == 309 then
        enable_turn = FALSE
    end
    if ArtsStanceCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, blend_type,
        TURN_TYPE_STANCE, TRUE, TRUE, FALSE, enable_turn) == TRUE then
        return
    end

    if env(GetSpEffectID, 19945) == TRUE then
        SetVariable("DrawStanceRightEndType", 1)
    else
        SetVariable("DrawStanceRightEndType", 0)
    end

    if env(GetGeneralTAEFlag, 10) == TRUE and
        (env(ActionDuration, ACTION_ARM_L2) < 200 or env(ActionCancelRequest, ACTION_ARM_L2) == TRUE) then
        ExecEventHalfBlend(Event_DrawStanceRightEnd, blend_type)
        return
    end
    if env(IsAnimEnd, 1) == TRUE or env(GetEventEzStateFlag, 0) == TRUE then
        local index = c_SwordArtsID
        if index == 10 or index == 11 or index == 340 or index == 341 or index == 309 then
            drawStanceNoSyncLoop_NoMP = GetVariable("IsEnoughArtPointsL2")
            ExecEventHalfBlendNoReset(Event_DrawStanceNoSyncLoop, blend_type)
        else
            ExecEventHalfBlendNoReset(Event_DrawStanceRightLoop, blend_type)
        end
        return
    end
    if HalfBlendLowerCommonFunction(Event_DrawStanceRightStart, lower_state, FALSE) == TRUE then
        return
    end
end

function DrawStanceRightLoop_Upper_onUpdate()
    if c_SwordArtsID == 318 then
        SetSwordArtsPointInfo(ACTION_ARM_R1, TRUE)
    else
        SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)
    end
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if GetEquipType(c_SwordArtsHand, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_ARROW, WEAPON_CATEGORY_LARGE_ARROW) ==
        TRUE then
        act(DebugLogOutput, "ArrowStanceRightLoop")
        act(SetIsPreciseShootingPossible)
        if ArrowCommonFunction(blend_type, FALSE, TURN_TYPE_STANCE) == TRUE then
            return
        end
        if ArrowStanceCommonFunction(blend_type, FALSE) == TRUE then
            return
        end
    end
    if GetEquipType(c_SwordArtsHand, WEAPON_CATEGORY_CROSSBOW) == TRUE then
        act(SetIsPreciseShootingPossible)
        if CrossbowStanceCommonFunction(blend_type, FALSE) == TRUE then
            return
        end
    end
    local r1 = "W_DrawStanceRightAttackLight"
    local r2 = "W_DrawStanceRightAttackHeavy"
    local b1 = "W_DrawStanceRightAttackLight"
    local b2 = "W_DrawStanceRightAttackHeavy"
    if c_SwordArtsID == 239 then
        r1 = "W_AttackRightLight2"
        r2 = "W_AttackRightHeavy1Start"
        b1 = "W_AttackBothLight2"
        b2 = "W_AttackBothHeavy1Start"
    end
    if env(GetSpEffectID, 100530) == TRUE then
        r1 = "W_SwordArtsStanceAttackLightStart"
        r2 = "W_SwordArtsStanceAttackHeavyStart"
        b1 = "W_SwordArtsStanceAttackLightStart"
        b2 = "W_SwordArtsStanceAttackHeavyStart"
    elseif env(GetSpEffectID, 100540) == TRUE then
        r1 = "W_SwordArtsStanceAttackLight180"
        r2 = "W_SwordArtsStanceAttackHeavy180"
        b1 = "W_SwordArtsStanceAttackLight180"
        b2 = "W_SwordArtsStanceAttackHeavy180"
    end
    if ArtsStanceCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, blend_type,
        TURN_TYPE_STANCE, TRUE, TRUE, FALSE, TRUE) == TRUE then
        return
    end

    if env(GetSpEffectID, 19945) == TRUE then
        SetVariable("DrawStanceRightEndType", 1)
    else
        SetVariable("DrawStanceRightEndType", 0)
    end

    if c_SwordArtsID == 239 then
        if env(GetStamina) <= 0 then
            ExecEventHalfBlend(Event_DrawStanceRightEnd, blend_type)
            return
        end
        if GetVariable("IsEnoughArtPointsL2") == 1 then
            ExecEventHalfBlend(Event_DrawStanceRightEnd, blend_type)
            return
        end
    end
    if c_SwordArtsID == 25 and env(GetStamina) <= 0 then
        ExecEventHalfBlend(Event_DrawStanceRightEnd, blend_type)
        return
    end
    if GetEquipType(c_SwordArtsHand, WEAPON_CATEGORY_LARGE_ARROW) == TRUE and MoveStartonCancelTiming(Event_Move, FALSE) ==
        TRUE then
        return
    end
    if env(ActionDuration, ACTION_ARM_L2) <= 0 or env(ActionCancelRequest, ACTION_ARM_L2) == TRUE then
        ExecEventHalfBlend(Event_DrawStanceRightEnd, blend_type)
        return
    end
    if GetEquipType(c_SwordArtsHand, WEAPON_CATEGORY_LARGE_ARROW) == FALSE and c_SwordArtsID ~= 105 and c_SwordArtsID ~=
        108 and c_SwordArtsID ~= 169 and HalfBlendLowerCommonFunction(Event_DrawStanceRightLoop, lower_state, FALSE) ==
        TRUE then
        return
    end
end

function DrawStanceNoSyncLoop_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 90, 90)
    end
    local r1 = "W_DrawStanceRightAttackLight"
    local r2 = "W_DrawStanceRightAttackHeavy"
    local b1 = "W_DrawStanceRightAttackLight"
    local b2 = "W_DrawStanceRightAttackHeavy"

    if env(GetSpEffectID, 100530) == TRUE then
        r1 = "W_SwordArtsStanceAttackLightStart"
        r2 = "W_SwordArtsStanceAttackHeavyStart"
        b1 = "W_SwordArtsStanceAttackLightStart"
        b2 = "W_SwordArtsStanceAttackHeavyStart"
    elseif env(GetSpEffectID, 100540) == TRUE then
        r1 = "W_SwordArtsStanceAttackLight180"
        r2 = "W_SwordArtsStanceAttackHeavy180"
        b1 = "W_SwordArtsStanceAttackLight180"
        b2 = "W_SwordArtsStanceAttackHeavy180"
    end
    if ArtsStanceCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, blend_type,
        TURN_TYPE_STANCE, TRUE, TRUE, FALSE, FALSE) == TRUE then
        return
    end

    if env(GetSpEffectID, 19945) == TRUE then
        SetVariable("DrawStanceRightEndType", 1)
    else
        SetVariable("DrawStanceRightEndType", 0)
    end

    if env(GetEventEzStateFlag, 0) == TRUE and
        (env(ActionDuration, ACTION_ARM_L2) <= 0 or env(ActionCancelRequest, ACTION_ARM_L2) == TRUE or env(GetStamina) <=
            0 or drawStanceNoSyncLoop_NoMP == FALSE and GetVariable("IsEnoughArtPointsL2") == 1 or
            drawStanceNoSyncLoop_NoMP == FALSE and GetVariable("IsEnoughArtPointsL2_DrawStanceNoSyncLoop") == 1) then
        ExecEventHalfBlend(Event_DrawStanceRightEnd, blend_type)
        return
    end
    if HalfBlendLowerCommonFunctionNoSync(Event_DrawStanceNoSyncLoop, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function DrawStanceNoSyncLoopMax_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 90, 90)
    end
    local r1 = "W_DrawStanceRightAttackMaxLight"
    local r2 = "W_DrawStanceRightAttackMaxHeavy"
    local b1 = "W_DrawStanceRightAttackMaxLight"
    local b2 = "W_DrawStanceRightAttackMaxHeavy"
    if env(GetSpEffectID, 100530) == TRUE then
        r1 = "W_DrawStanceRightAttackMaxLightR90"
        r2 = "W_DrawStanceRightAttackMaxHeavyR90"
        b1 = "W_DrawStanceRightAttackMaxLightR90"
        b2 = "W_DrawStanceRightAttackMaxHeavyR90"
    elseif env(GetSpEffectID, 100540) == TRUE then
        r1 = "W_DrawStanceRightAttackMaxLight180"
        r2 = "W_DrawStanceRightAttackMaxHeavy180"
        b1 = "W_DrawStanceRightAttackMaxLight180"
        b2 = "W_DrawStanceRightAttackMaxHeavy180"
    elseif env(GetSpEffectID, 100550) == TRUE then
        r1 = "W_DrawStanceRightAttackMaxLightL90"
        r2 = "W_DrawStanceRightAttackMaxHeavyL90"
        b1 = "W_DrawStanceRightAttackMaxLightL90"
        b2 = "W_DrawStanceRightAttackMaxHeavyL90"
    end
    if ArtsStanceCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, blend_type, TRUE, TRUE,
        FALSE, FALSE) == TRUE then
        return
    end

    if env(GetSpEffectID, 19945) == TRUE then
        SetVariable("DrawStanceRightEndType", 1)
    else
        SetVariable("DrawStanceRightEndType", 0)
    end

    if env(ActionDuration, ACTION_ARM_L2) <= 0 or env(ActionCancelRequest, ACTION_ARM_L2) == TRUE then
        ExecEventHalfBlend(Event_DrawStanceRightEnd, blend_type)
        return
    end
    local sp_kind = env(GetEquipWeaponSpecialCategoryNumber, c_SwordArtsHand)
    if sp_kind == 248 and env(GetStamina) <= 0 then
        ExecEventHalfBlend(Event_DrawStanceRightEnd, blend_type)
        return
    end
    if HalfBlendLowerCommonFunctionNoSync(Event_DrawStanceRightLoopMaxNoSync, lower_state, FALSE, TRUE) == TRUE then
        return
    end
end

function DrawStanceRightEnd_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    end
    if GetEquipType(c_SwordArtsHand, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_ARROW, WEAPON_CATEGORY_LARGE_ARROW) ==
        TRUE then
        act(SetIsPreciseShootingPossible)
        if ArrowCommonFunction(blend_type, FALSE, TURN_TYPE_STANCE) == TRUE then
            return
        end
    end
    local enable_turn = TRUE
    if c_SwordArtsID == 309 then
        enable_turn = FALSE
    end
    if ArtsStanceCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", blend_type, TURN_TYPE_DEFAULT, FALSE,
        FALSE, TRUE, enable_turn) == TRUE then
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        SetArtsGeneratorTransitionIndex()
        return
    end
    if lower_state == LOWER_END_TURN then
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
    elseif HalfBlendLowerCommonFunction(Event_DrawStanceRightEnd, lower_state, FALSE) == TRUE then
        return
    end
end

function DrawStanceRightAttackLight_onUpdate()
    if GetEquipType(c_SwordArtsHand, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_ARROW, WEAPON_CATEGORY_LARGE_ARROW) ==
        TRUE then
        act(SetIsPreciseShootingPossible)
        if ArrowCommonFunction(ALLBODY, TRUE, TURN_TYPE_DEFAULT) == TRUE then
            return
        end
        if env(GetSpEffectID, 100280) == TRUE and
            (g_ArrowSlot == 0 and env(ActionDuration, ACTION_ARM_R1) <= 0 or g_ArrowSlot == 1 and
                env(ActionDuration, ACTION_ARM_R2) <= 0) then
            ExecEventAllBody("W_DrawStanceRightAttackLightCancel")
            return
        end
        if ArrowStanceCommonFunction(ALLBODY, TRUE) == TRUE then
            return
        end
    end

    local r1 = "W_AttackRightLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b1 = "W_AttackBothLight1"
    local b2 = "W_AttackBothHeavy1Start"

    if env(GetEquipWeaponCategory, HAND_RIGHT) == WEAPON_CATEGORY_STRAIGHT_SWORD then
        r1 = "W_AttackRightLight2"
        r2 = "W_AttackRightHeavy2Start"
        b1 = "W_AttackBothLight2"
        b2 = "W_AttackBothHeavy2Start"
    end

    local artsr1 = FALSE
    local artsr2 = FALSE

    if env(GetSpEffectID, 19921) == TRUE and env(ActionDuration, ACTION_ARM_L2) > 0 then
        r1 = "W_DrawStanceRightAttackLight"
        r2 = "W_DrawStanceRightAttackHeavy"
        b1 = "W_DrawStanceRightAttackLight"
        b2 = "W_DrawStanceRightAttackHeavy"
        artsr1 = TRUE
        artsr2 = TRUE
    end

    if c_SwordArtsID == 318 then
        if env(GetSpEffectID, 100054) == TRUE then
            r1 = "W_SwordArtsOneShotComboEnd_MesmerSowrdArts"
            b1 = "W_SwordArtsOneShotComboEnd_MesmerSowrdArts"
        elseif env(GetSpEffectID, 100055) == TRUE then
            r1 = "W_SwordArtsOneShotComboEnd_2"
            b1 = "W_SwordArtsOneShotComboEnd_2"
        end
    end

    if ArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, artsr1, artsr2, TRUE,
        FALSE, ALLBODY) == TRUE then
        return
    end
    if env(GetEventEzStateFlag, 0) == TRUE then
        local blend_type = ALLBODY
        if c_SwordArtsID ~= 105 and c_SwordArtsID ~= 108 and c_SwordArtsID ~= 169 and
            MoveStart(LOWER, Event_Move, FALSE) == TRUE then
            blend_type = UPPER
        end
        if env(ActionDuration, ACTION_ARM_L2) <= 0 then
            ExecEventHalfBlend(Event_DrawStanceRightEnd, blend_type)
        else
            ExecEventHalfBlend(Event_DrawStanceRightLoop, blend_type)
        end
    end
    if env(IsAnimEnd, 0) == TRUE then
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
end

function DrawStanceRightAttackLightCancel_onUpdate()
    if GetEquipType(c_SwordArtsHand, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_ARROW, WEAPON_CATEGORY_LARGE_ARROW) ==
        TRUE then
        act(SetIsPreciseShootingPossible)
        if ArrowCommonFunction(ALLBODY, TRUE, TURN_TYPE_DEFAULT) == TRUE then
            return
        end
        if ArrowStanceCommonFunction(ALLBODY, TRUE) == TRUE then
            return
        end
    end

    local r1 = "W_AttackRightLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b1 = "W_AttackBothLight1"
    local b2 = "W_AttackBothHeavy1Start"

    if ArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, FALSE, FALSE, TRUE, FALSE,
        ALLBODY) == TRUE then
        return
    end
    if env(GetEventEzStateFlag, 0) == TRUE then
        local blend_type = ALLBODY
        if MoveStart(LOWER, Event_Move, FALSE) == TRUE then
            blend_type = UPPER
        end
        if env(ActionDuration, ACTION_ARM_L2) <= 0 then
            ExecEventHalfBlend(Event_DrawStanceRightEnd, blend_type)
        else
            ExecEventHalfBlend(Event_DrawStanceRightLoop, blend_type)
        end
    end
    if env(IsAnimEnd, 0) == TRUE then
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
end

function DrawStanceHalfRightAttackLight_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if GetEquipType(c_SwordArtsHand, WEAPON_CATEGORY_CROSSBOW) == TRUE and env(ActionDuration, ACTION_ARM_L2) > 0 then
        act(SetIsPreciseShootingPossible)
        if CrossbowStanceCommonFunction(blend_type, TRUE) == TRUE then
            return
        end
    end
    local r1 = "W_AttackRightLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b1 = "W_AttackBothLight1"
    local b2 = "W_AttackBothHeavy1Start"
    if ArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, FALSE, FALSE, TRUE, FALSE,
        ALLBODY) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_DEFAULT)
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_DrawStanceHalfRightAttackLight, lower_state, FALSE) == TRUE then
        return
    end
end

function SwordArtsStanceAttackLightStart_onUpdate()
    local r1 = "W_AttackRightLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b1 = "W_AttackBothLight1"
    local b2 = "W_AttackBothHeavy1Start"
    if env(GetEquipWeaponCategory, HAND_RIGHT) == WEAPON_CATEGORY_STRAIGHT_SWORD then
        r1 = "W_AttackRightLight2"
        r2 = "W_AttackRightHeavy2Start"
        b1 = "W_AttackBothLight2"
        b2 = "W_AttackBothHeavy2Start"
    end
    if ArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, FALSE, FALSE, TRUE, FALSE,
        ALLBODY) == TRUE then
        return
    end
    if env(IsAnimEnd, 0) == TRUE then
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
end

function SwordArtsStanceAttackLight180_onUpdate()
    local r1 = "W_AttackRightLight1"
    local r2 = "W_AttackBothRightHeavy1Start"
    local b1 = "W_AttackBothLight1"
    local b2 = "W_AttackBothHeavy1Start"

    if env(GetEquipWeaponCategory, HAND_RIGHT) == WEAPON_CATEGORY_STRAIGHT_SWORD then
        r1 = "W_AttackRightLight2"
        r2 = "W_AttackRightHeavy2Start"
        b1 = "W_AttackBothLight2"
        b2 = "W_AttackBothHeavy2Start"
    end
    if ArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, FALSE, FALSE, TRUE, FALSE,
        ALLBODY) == TRUE then
        return
    end
    if env(IsAnimEnd, 0) == TRUE then
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
end

function DrawStanceRightAttackHeavy_onUpdate()
    local r1 = "W_AttackRightLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b1 = "W_AttackBothLight1"
    local b2 = "W_AttackBothHeavy1Start"

    if env(GetSpEffectID, 100250) == TRUE then
        r2 = "W_DrawStanceRightAttackHeavy2"
        b2 = "W_DrawStanceRightAttackHeavy2"
    else
        r2 = "W_AttackRightHeavy1Start"
        b2 = "W_AttackBothHeavy1Start"
    end

    if env(GetEquipWeaponCategory, HAND_RIGHT) == WEAPON_CATEGORY_STRAIGHT_SWORD then
        r1 = "W_AttackRightLight2"
        r2 = "W_AttackRightHeavy2Start"
        b1 = "W_AttackBothLight2"
        b2 = "W_AttackBothHeavy2Start"
    end

    if ArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, FALSE, FALSE, TRUE, FALSE,
        ALLBODY) == TRUE then
        return
    end
    if env(IsAnimEnd, 0) == TRUE then
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
end

function DrawStanceRightAttackHeavy2_onUpdate()
    if ArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, FALSE, FALSE, TRUE, FALSE,
        ALLBODY) == TRUE then
        return
    end
end

function SwordArtsStanceAttackHeavyStart_onUpdate()
    local r1 = "W_AttackRightLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b1 = "W_AttackBothLight1"
    local b2 = "W_AttackBothHeavy1Start"
    if env(GetEquipWeaponCategory, HAND_RIGHT) == WEAPON_CATEGORY_STRAIGHT_SWORD then
        r1 = "W_AttackRightLight2"
        r2 = "W_AttackRightHeavy2Start"
        b1 = "W_AttackBothLight2"
        b2 = "W_AttackBothHeavy2Start"
    end
    if ArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, FALSE, FALSE, TRUE, FALSE,
        ALLBODY) == TRUE then
        return
    end
    if env(IsAnimEnd, 0) == TRUE then
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
end

function SwordArtsStanceAttackHeavy180_onUpdate()
    local r1 = "W_AttackRightLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b1 = "W_AttackBothLight1"
    local b2 = "W_AttackBothHeavy1Start"

    if env(GetEquipWeaponCategory, HAND_RIGHT) == WEAPON_CATEGORY_STRAIGHT_SWORD then
        r1 = "W_AttackRightLight2"
        r2 = "W_AttackRightHeavy2Start"
        b1 = "W_AttackBothLight2"
        b2 = "W_AttackBothHeavy2Start"
    end
    if ArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, FALSE, FALSE, TRUE, FALSE,
        ALLBODY) == TRUE then
        return
    end
    if env(IsAnimEnd, 0) == TRUE then
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
end

function SwordArtsOneShot_onUpdate()
    local canThrow = FALSE
    if c_SwordArtsID == 130 or c_SwordArtsID == 55 or c_SwordArtsID == 323 then
        canThrow = TRUE
    end
    if env(GetSpEffectID, 102050) == TRUE then
        act(LockonFixedAngleCancel)
    end
    local r1 = "W_AttackRightLight1"
    local b1 = "W_AttackBothLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b2 = "W_AttackBothHeavy1Start"

    if env(GetSpEffectID, 100054) == TRUE then
        r1 = "W_SwordArtsOneShotComboEnd"
        b1 = "W_SwordArtsOneShotComboEnd"
    elseif env(GetSpEffectID, 100055) == TRUE then
        r1 = "W_SwordArtsOneShotComboEnd_2"
        b1 = "W_SwordArtsOneShotComboEnd_2"
    end
    if env(GetSpEffectID, 100050) == TRUE then
        r2 = "W_SwordArtsOneShotComboEnd"
        b2 = "W_SwordArtsOneShotComboEnd"
    elseif env(GetSpEffectID, 100051) == TRUE then
        r2 = "W_SwordArtsOneShotComboEnd_2"
        b2 = "W_SwordArtsOneShotComboEnd_2"
    end
    if c_SwordArtsID == 157 or c_SwordArtsID == 113 then
        r1 = "W_AttackRightLightStep"
        b1 = "W_AttackBothLightStep"
    end
    if c_SwordArtsID == 1 or c_SwordArtsID == 2 or c_SwordArtsID == 6 or c_SwordArtsID == 7 or c_SwordArtsID == 130 or
        c_SwordArtsID == 131 or c_SwordArtsID == 170 or c_SwordArtsID == 171 or c_SwordArtsID == 191 or c_SwordArtsID ==
        198 or c_SwordArtsID == 65 or c_SwordArtsID == 243 or c_SwordArtsID == 283 or c_SwordArtsID == 300 or
        c_SwordArtsID == 370 then
        r1 = "W_AttackRightLight2"
        b1 = "W_AttackBothLight2"
    end
    if (c_SwordArtsID == 115 or c_SwordArtsID == 116 or c_SwordArtsID == 193) and env(GetSpEffectID, 100660) == TRUE then
        if env(IsTruelyLanding) == TRUE then
            ExecEventAllBody("W_SwordArtsLoopEnd")
        else
            ExecEventAllBody("W_SwordArtsLoopLoop")
        end
    end
    if c_SwordArtsID == 229 or c_SwordArtsID == 323 then
        if env(IsAnimEnd, 0) == TRUE then
            ExecEventAllBody("W_SwordArtsLoopEnd")
        elseif env(GetSpEffectID, 100670) == TRUE and env(IsTruelyLanding) == TRUE then
            ExecEventAllBody("W_SwordArtsLoopEnd")
        end
    end
    if ArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, TRUE, TRUE, TRUE, canThrow,
        ALLBODY) == TRUE then
        return
    end
    if env(ActionDuration, ACTION_ARM_L2) <= 0 then
        if env(GetSpEffectID, 100285) == TRUE then
            local idle_cat = env(GetStayAnimCategory)
            local wep_cat = env(GetEquipWeaponCategory, c_SwordArtsHand)
            local arts_cat = GetSwordArtsDiffCategory(c_SwordArtsID, idle_cat, wep_cat)
            local arts_idx = 0

            if arts_cat == WEAPON_CATEGORY_LARGE_SHIELD then
                arts_idx = 1
            elseif arts_cat == WEAPON_CATEGORY_SMALL_SHIELD then
                arts_idx = 2
            elseif arts_cat == WEAPON_CATEGORY_DUELING_SHIELD then
                arts_idx = 3
            elseif arts_cat == SWORD_ART_DIFF_CAT_LARGE_WEAPON then
                arts_idx = 4
            elseif arts_cat == SWORD_ART_DIFF_CAT_POLEARM then
                arts_idx = 5
            end

            SetVariable("SwordArtsChargeCategory", arts_idx)
            ExecEventAllBody("W_SwordArtsChargeCancelEarly")
            return
        elseif env(GetSpEffectID, 100286) == TRUE then
            ExecEventAllBody("W_SwordArtsChargeCancelLate")
            return
        end
    end
    if c_SwordArtsID == 356 then
        act(ReserveArtsPointsUse, ACTION_ARM_L2, c_SwordArtsHand)
        if env(HasEnoughArtsPoints, ACTION_ARM_L2, c_SwordArtsHand) == FALSE and env(GetSpEffectID, 100285) == TRUE then
            ExecEventAllBody("W_SwordArtsChargeCancelEarly")
        end
    end
    if env(IsAnimEnd, 0) == TRUE then
        local arts_category = c_SwordArtsID + 600
        local loop_animID = SWORDARTS_ANIM_ID_RIGHT_LOOP
        if env(DoesAnimExist, arts_category, loop_animID) == TRUE and
            (c_SwordArtsID ~= 201 and c_SwordArtsID ~= 202 or GetVariable("IsEnoughArtPointsL2") == FALSE) then
            if env(ActionDuration, ACTION_ARM_L2) > 0 then
                ExecEventAllBody("W_SwordArtsLoopLoop")
            else
                ExecEventAllBody("W_SwordArtsLoopEnd")
            end
            return
        end
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
end

function SwordArtsOneShot_Sub_onUpdate()
    local canThrow = FALSE
    local r1 = "W_AttackRightLight1"
    local b1 = "W_AttackBothLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b2 = "W_AttackBothHeavy1Start"

    if ArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, TRUE, TRUE, TRUE, canThrow,
        ALLBODY) == TRUE then
        return
    end
    if env(ActionDuration, ACTION_ARM_L2) <= 0 and env(GetSpEffectID, 100285) == TRUE then
        if GetVariable("SwordArtsSubCategory") == 0 then
            SetVariable("SwordArtsSubCategory2", 0)
        elseif GetVariable("SwordArtsSubCategory") == 1 then
            SetVariable("SwordArtsSubCategory2", 1)
        end
        ExecEventAllBody("W_SwordArtsChargeCancelEarly_Sub")
        return
    end
    if env(IsAnimEnd, 0) == TRUE then
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
end

function SwordArtsHalfOneShot_Upper_onUpdate()
    local canThrow = FALSE
    if c_SwordArtsID == 130 or c_SwordArtsID == 55 then
        canThrow = TRUE
    end

    local blend_type, lower_state = GetHalfBlendInfo()
    local r1 = "W_AttackRightLight1"
    local b1 = "W_AttackBothLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b2 = "W_AttackBothHeavy1Start"

    if env(GetSpEffectID, 100054) == TRUE then
        r1 = "W_SwordArtsOneShotComboEnd"
        b1 = "W_SwordArtsOneShotComboEnd"
    elseif env(GetSpEffectID, 100055) == TRUE then
        r1 = "W_SwordArtsOneShotComboEnd_2"
        b1 = "W_SwordArtsOneShotComboEnd_2"
    end
    if env(GetSpEffectID, 100050) == TRUE then
        r2 = "W_SwordArtsOneShotComboEnd"
        b2 = "W_SwordArtsOneShotComboEnd"
    elseif env(GetSpEffectID, 100051) == TRUE then
        r2 = "W_SwordArtsOneShotComboEnd_2"
        b2 = "W_SwordArtsOneShotComboEnd_2"
    end

    if ArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, TRUE, TRUE, TRUE, canThrow,
        blend_type) == TRUE then
        return
    end
    if env(ActionDuration, ACTION_ARM_L2) <= 0 then
        if env(GetSpEffectID, 100285) == TRUE then
            if IsHalfBlendArts(c_SwordArtsID) == TRUE then
                ExecEventHalfBlend(Event_SwordArtsHalfChargeCancelEarly, blend_type)
            else
                ExecEventAllBody("W_SwordArtsChargeCancelEarly")
            end
            return
        elseif env(GetSpEffectID, 100286) == TRUE then
            ExecEventAllBody("W_SwordArtsChargeCancelLate")
            return
        end
    end

    if c_SwordArtsID == 206 and env(ActionDuration, ACTION_ARM_L2) <= 0 and env(GetSpEffectID, 100700) == FALSE then
        ExecEventHalfBlend(Event_SwordArtsHalfLoopEnd, blend_type)
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        local arts_category = c_SwordArtsID + 600
        local loop_animID = SWORDARTS_ANIM_ID_RIGHT_LOOP
        if env(DoesAnimExist, arts_category, loop_animID) == TRUE and
            (c_SwordArtsID ~= 201 and c_SwordArtsID ~= 202 or GetVariable("IsEnoughArtPointsL2") == FALSE) then
            if c_SwordArtsID == 334 then
                SetVariable("IsMadTorch", 1)
            else
                SetVariable("IsMadTorch", 0)
            end

            if env(ActionDuration, ACTION_ARM_L2) > 0 then
                if c_SwordArtsID == 334 and GetVariable("IsEnoughArtPointsL2_MadTorchEnd") == TRUE then
                    ExecEventHalfBlend(Event_SwordArtsHalfLoopEnd, blend_type)
                else
                    ExecEventHalfBlend(Event_SwordArtsHalfLoopLoop, blend_type)
                end
            else
                ExecEventHalfBlend(Event_SwordArtsHalfLoopEnd, blend_type)
            end
            return
        end

        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_DEFAULT)
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_SwordArtsHalfOneShot, lower_state, FALSE) == TRUE then
        return
    end
end

function SwordArtsOneShotComboEnd_onUpdate()
    local r1 = "W_AttackRightLight1"
    local b1 = "W_AttackBothLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b2 = "W_AttackBothHeavy1Start"

    if env(GetSpEffectID, 100054) == TRUE then
        r1 = "W_SwordArtsOneShotComboEnd"
        b1 = "W_SwordArtsOneShotComboEnd"
    elseif env(GetSpEffectID, 100055) == TRUE then
        r1 = "W_SwordArtsOneShotComboEnd_2"
        b1 = "W_SwordArtsOneShotComboEnd_2"
    end
    if env(GetSpEffectID, 100050) == TRUE then
        r2 = "W_SwordArtsOneShotComboEnd"
        b2 = "W_SwordArtsOneShotComboEnd"
    elseif env(GetSpEffectID, 100051) == TRUE then
        r2 = "W_SwordArtsOneShotComboEnd_2"
        b2 = "W_SwordArtsOneShotComboEnd_2"
    end
    if c_SwordArtsID == 113 then
        r1 = "W_AttackRightLightStep"
        b1 = "W_AttackBothLightStep"
    end
    if env(ActionDuration, ACTION_ARM_L2) <= 0 then
        if env(GetSpEffectID, 100285) == TRUE then
            ExecEventAllBody("W_SwordArtsChargeCancelEarly2")
            return
        elseif env(GetSpEffectID, 100286) == TRUE then
            ExecEventAllBody("W_SwordArtsChargeCancelEarly2")
            return
        end
    end
    if ArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, TRUE, TRUE, TRUE, FALSE,
        ALLBODY) == TRUE then
        return
    end
    if env(IsAnimEnd, 0) == TRUE then
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
end

function SwordArtsOneShotComboEnd_MesmerSowrdArts_onUpdate()
    local r1 = "W_AttackRightLight1"
    local b1 = "W_AttackBothLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b2 = "W_AttackBothHeavy1Start"

    if env(GetSpEffectID, 100054) == TRUE then
        r1 = "W_SwordArtsOneShotComboEnd"
        b1 = "W_SwordArtsOneShotComboEnd"
    elseif env(GetSpEffectID, 100055) == TRUE then
        r1 = "W_SwordArtsOneShotComboEnd_2"
        b1 = "W_SwordArtsOneShotComboEnd_2"
    end
    if env(GetSpEffectID, 100050) == TRUE then
        r2 = "W_SwordArtsOneShotComboEnd"
        b2 = "W_SwordArtsOneShotComboEnd"
    elseif env(GetSpEffectID, 100051) == TRUE then
        r2 = "W_SwordArtsOneShotComboEnd_2"
        b2 = "W_SwordArtsOneShotComboEnd_2"
    end
    if c_SwordArtsID == 113 then
        r1 = "W_AttackRightLightStep"
        b1 = "W_AttackBothLightStep"
    end
    if env(ActionDuration, ACTION_ARM_L2) <= 0 then
        if env(GetSpEffectID, 100285) == TRUE then
            ExecEventAllBody("W_SwordArtsChargeCancelEarly2")
            return
        elseif env(GetSpEffectID, 100286) == TRUE then
            ExecEventAllBody("W_SwordArtsChargeCancelEarly2")
            return
        end
    end
    if ArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, TRUE, TRUE, TRUE, FALSE,
        ALLBODY) == TRUE then
        return
    end
    if env(IsAnimEnd, 0) == TRUE then
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
end

function SwordArtsHalfOneShotComboEnd_Upper_onUpdate()
    local canThrow = FALSE
    if c_SwordArtsID == 130 or c_SwordArtsID == 55 then
        canThrow = TRUE
    end

    local blend_type, lower_state = GetHalfBlendInfo()
    local r1 = "W_AttackRightLight1"
    local b1 = "W_AttackBothLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b2 = "W_AttackBothHeavy1Start"

    if env(GetSpEffectID, 100054) == TRUE then
        r1 = "W_SwordArtsOneShotComboEnd"
        b1 = "W_SwordArtsOneShotComboEnd"
    elseif env(GetSpEffectID, 100055) == TRUE then
        r1 = "W_SwordArtsOneShotComboEnd_2"
        b1 = "W_SwordArtsOneShotComboEnd_2"
    end
    if env(GetSpEffectID, 100050) == TRUE then
        r2 = "W_SwordArtsOneShotComboEnd"
        b2 = "W_SwordArtsOneShotComboEnd"
    elseif env(GetSpEffectID, 100051) == TRUE then
        r2 = "W_SwordArtsOneShotComboEnd_2"
        b2 = "W_SwordArtsOneShotComboEnd_2"
    end
    if ArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, TRUE, TRUE, TRUE, canThrow,
        blend_type) == TRUE then
        return
    end
    if env(ActionDuration, ACTION_ARM_L2) <= 0 then
        if env(GetSpEffectID, 100285) == TRUE then
            ExecEventAllBody("W_SwordArtsChargeCancelEarly2")
            return
        elseif env(GetSpEffectID, 100286) == TRUE then
            ExecEventAllBody("W_SwordArtsChargeCancelEarly2")
            return
        end
    end
    if env(IsAnimEnd, 1) == TRUE then
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_DEFAULT)
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_SwordArtsHalfOneShotCombo1, lower_state, FALSE) == TRUE then
        return
    end
end

function SwordArtsOneShotComboEnd_2_onUpdate()
    local r1 = "W_AttackRightLight1"
    local b1 = "W_AttackBothLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b2 = "W_AttackBothHeavy1Start"

    if env(GetSpEffectID, 100054) == TRUE then
        r1 = "W_SwordArtsOneShotComboEnd"
        b1 = "W_SwordArtsOneShotComboEnd"
    elseif env(GetSpEffectID, 100055) == TRUE then
        r1 = "W_SwordArtsOneShotComboEnd_2"
        b1 = "W_SwordArtsOneShotComboEnd_2"
    end
    if env(GetSpEffectID, 100050) == TRUE then
        r2 = "W_SwordArtsOneShotComboEnd"
        b2 = "W_SwordArtsOneShotComboEnd"
    elseif env(GetSpEffectID, 100051) == TRUE then
        r2 = "W_SwordArtsOneShotComboEnd_2"
        b2 = "W_SwordArtsOneShotComboEnd_2"
    end
    if ArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, TRUE, TRUE, TRUE, FALSE,
        ALLBODY) == TRUE then
        return
    end
    if env(IsAnimEnd, 0) == TRUE then
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
end

function SwordArtsHalfOneShotComboEnd_2_Upper_onUpdate()
    local canThrow = FALSE
    if c_SwordArtsID == 130 or c_SwordArtsID == 55 then
        canThrow = TRUE
    end

    local blend_type, lower_state = GetHalfBlendInfo()
    local r1 = "W_AttackRightLight1"
    local b1 = "W_AttackBothLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b2 = "W_AttackBothHeavy1Start"

    if env(GetSpEffectID, 100054) == TRUE then
        r1 = "W_SwordArtsOneShotComboEnd"
        b1 = "W_SwordArtsOneShotComboEnd"
    elseif env(GetSpEffectID, 100055) == TRUE then
        r1 = "W_SwordArtsOneShotComboEnd_2"
        b1 = "W_SwordArtsOneShotComboEnd_2"
    end
    if env(GetSpEffectID, 100050) == TRUE then
        r2 = "W_SwordArtsOneShotComboEnd"
        b2 = "W_SwordArtsOneShotComboEnd"
    elseif env(GetSpEffectID, 100051) == TRUE then
        r2 = "W_SwordArtsOneShotComboEnd_2"
        b2 = "W_SwordArtsOneShotComboEnd_2"
    end
    if ArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, TRUE, TRUE, TRUE, canThrow,
        blend_type) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_DEFAULT)
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_SwordArtsHalfOneShotCombo2, lower_state, FALSE) == TRUE then
        return
    end
end

function SwordArtsOneShotShieldLeft_onUpdate()
    local index = SWORDARTS_PARRY + GetVariable("SwordArtsOneShotShieldIndex")
    local canThrow = FALSE

    if index == SWORDARTS_PARRY or index == SWORDARTS_SPELL_PARRY or index == SWORDARTS_PROJECTILE_PARRY or index ==
        SWORDARTS_BUCKLER_PARRY or index == SWORDARTS_DAGGER_PARRY then
        canThrow = TRUE
    end

    if env(ActionDuration, ACTION_ARM_L2) <= 0 then
        local idle_cat = env(GetStayAnimCategory)
        local wep_cat = env(GetEquipWeaponCategory, c_SwordArtsHand)
        local arts_cat = GetSwordArtsDiffCategory(c_SwordArtsID, idle_cat, wep_cat)
        local arts_idx = 0

        if arts_cat == WEAPON_CATEGORY_LARGE_SHIELD then
            arts_idx = 1
        elseif arts_cat == WEAPON_CATEGORY_SMALL_SHIELD then
            arts_idx = 2
        end

        SetVariable("SwordArtsOneShotShieldCancelCategory", arts_idx)

        if env(GetSpEffectID, 100285) == TRUE then
            ExecEventAllBody("W_SwordArtsOneShotShieldLeft_Cancel")
        elseif env(GetSpEffectID, 100286) == TRUE then
            ExecEventAllBody("W_SwordArtsOneShotShieldLeft_Cancel")
        end
    end
    if ArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, TRUE, TRUE, canThrow, ALLBODY) == TRUE then
        return
    end
    if env(IsAnimEnd, 0) == TRUE then
        local arts_category = c_SwordArtsID + 600
        local loop_animID = SWORDARTS_ANIM_ID_RIGHT_LOOP
        if env(DoesAnimExist, arts_category, loop_animID) == TRUE and
            (c_SwordArtsID ~= 201 and c_SwordArtsID ~= 202 or GetVariable("IsEnoughArtPointsL2") == FALSE) then
            if env(ActionDuration, ACTION_ARM_L2) > 0 then
                ExecEventAllBody("W_SwordArtsLeftLoopLoop")
            else
                ExecEventAllBody("W_SwordArtsLeftLoopEnd")
            end
            return
        end
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
end

function SwordArtsLeftGuardCounter_onUpdate()
    local canThrow = FALSE
    if ArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, TRUE, TRUE, canThrow, ALLBODY) == TRUE then
        return
    end

    if env(IsAnimEnd, 0) == TRUE then
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
end

function SwordArtsBothGuardCounter_onUpdate()
    local canThrow = FALSE
    if ArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, TRUE, TRUE, canThrow, ALLBODY) == TRUE then
        return
    end

    if env(IsAnimEnd, 0) == TRUE then
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
end

function SwordArtsHalfOneShotShieldLeft_Upper_onUpdate()
    local index = SWORDARTS_PARRY + GetVariable("SwordArtsOneShotShieldIndex")
    local canThrow = FALSE
    if index == SWORDARTS_PARRY or index == SWORDARTS_SPELL_PARRY or index == SWORDARTS_PROJECTILE_PARRY or index ==
        SWORDARTS_BUCKLER_PARRY or index == SWORDARTS_DAGGER_PARRY then
        canThrow = TRUE
    end
    local blend_type, lower_state = GetHalfBlendInfo()
    local idle_cat = env(GetStayAnimCategory)
    local wep_cat = env(GetEquipWeaponCategory, c_SwordArtsHand)
    local arts_cat = GetSwordArtsDiffCategory(c_SwordArtsID, idle_cat, wep_cat)
    local arts_idx = 0

    if arts_cat == WEAPON_CATEGORY_LARGE_SHIELD then
        arts_idx = 1
    elseif arts_cat == WEAPON_CATEGORY_SMALL_SHIELD then
        arts_idx = 2
    end

    SetVariable("SwordArtsOneShotShieldCancelCategory", arts_idx)

    if 0 >= env(ActionDuration, ACTION_ARM_L2) then
        if env(GetSpEffectID, 100285) == TRUE then
            ExecEventAllBody("W_SwordArtsOneShotShieldLeft_Cancel")
        elseif env(GetSpEffectID, 100286) == TRUE then
            ExecEventAllBody("W_SwordArtsOneShotShieldLeft_Cancel")
        end
    end
    if ArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, TRUE, FALSE, canThrow, ALLBODY) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        local arts_category = c_SwordArtsID + 600
        local loop_animID = SWORDARTS_ANIM_ID_RIGHT_LOOP
        if env(DoesAnimExist, arts_category, loop_animID) == TRUE and
            (c_SwordArtsID ~= 201 and c_SwordArtsID ~= 202 or GetVariable("IsEnoughArtPointsL2") == FALSE) then
            if 0 < env(ActionDuration, ACTION_ARM_L2) then
                if c_SwordArtsID == 334 then
                    SetVariable("IsMadTorch", 1)
                else
                    SetVariable("IsMadTorch", 0)
                end
                if c_SwordArtsID == 334 and GetVariable("IsEnoughArtPointsL2") == TRUE then
                    ExecEventHalfBlend(Event_SwordArtsHalfLeftLoopEnd, blend_type)
                else
                    ExecEventHalfBlend(Event_SwordArtsHalfLeftLoopLoop, blend_type)
                end
            else
                ExecEventHalfBlend(Event_SwordArtsHalfLeftLoopEnd, blend_type)
            end
            return
        end
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_DEFAULT)
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_SwordArtsHalfOneShotShieldLeft, lower_state, FALSE) == TRUE then
        return
    end
end

function SwordArtsOneShotShieldLeft_Cancel_onUpdate()
    local index = SWORDARTS_PARRY + GetVariable("SwordArtsOneShotShieldIndex")
    local canThrow = FALSE
    if index == SWORDARTS_PARRY or index == SWORDARTS_SPELL_PARRY or index == SWORDARTS_PROJECTILE_PARRY or index ==
        SWORDARTS_BUCKLER_PARRY or index == SWORDARTS_DAGGER_PARRY then
        canThrow = TRUE
    end
    if ArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, TRUE, FALSE, canThrow, ALLBODY) == TRUE then
        return
    end
    if env(IsAnimEnd, 0) == TRUE then
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
end

function SwordArtsOneShotShieldBoth_onUpdate()
    local index = SWORDARTS_PARRY + GetVariable("SwordArtsOneShotShieldIndex")
    local canThrow = FALSE
    if index == SWORDARTS_PARRY or index == SWORDARTS_SPELL_PARRY or index == SWORDARTS_PROJECTILE_PARRY or index ==
        SWORDARTS_BUCKLER_PARRY or index == SWORDARTS_DAGGER_PARRY then
        canThrow = TRUE
    end
    if env(ActionDuration, ACTION_ARM_L2) <= 0 then
        local idle_cat = env(GetStayAnimCategory)
        local wep_cat = env(GetEquipWeaponCategory, c_SwordArtsHand)
        local arts_cat = GetSwordArtsDiffCategory(c_SwordArtsID, idle_cat, wep_cat)
        local arts_idx = 0

        if arts_cat == 47 then
            arts_idx = 1
        elseif arts_cat == 48 then
            arts_idx = 2
        elseif arts_cat == 57 then
            arts_idx = 3
        end
        SetVariable("SwordArtsOneShotShieldCancelCategory", arts_idx)
        if env(GetSpEffectID, 100285) == TRUE then
            ExecEventAllBody("W_SwordArtsOneShotShieldBoth_Cancel")
        elseif env(GetSpEffectID, 100286) == TRUE then
            ExecEventAllBody("W_SwordArtsOneShotShieldBoth_Cancel")
        end
    end
    if ArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, TRUE, TRUE, canThrow, ALLBODY) == TRUE then
        return
    end
    if env(IsAnimEnd, 0) == TRUE then
        local arts_category = c_SwordArtsID + 600
        local loop_animID = SWORDARTS_ANIM_ID_RIGHT_LOOP
        if env(DoesAnimExist, arts_category, loop_animID) == TRUE and
            (c_SwordArtsID ~= 201 and c_SwordArtsID ~= 202 or GetVariable("IsEnoughArtPointsL2") == FALSE) then
            if env(ActionDuration, ACTION_ARM_L2) > 0 then
                ExecEventAllBody("W_SwordArtsBothLoopLoop")
            else
                ExecEventAllBody("W_SwordArtsBothLoopEnd")
            end
            return
        end
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
end

function SwordArtsOneShotShieldBoth_Cancel_onUpdate()
    local index = SWORDARTS_PARRY + GetVariable("SwordArtsOneShotShieldIndex")
    local canThrow = FALSE
    if index == SWORDARTS_PARRY or index == SWORDARTS_SPELL_PARRY or index == SWORDARTS_PROJECTILE_PARRY or index ==
        SWORDARTS_BUCKLER_PARRY or index == SWORDARTS_DAGGER_PARRY then
        canThrow = TRUE
    end
    if ArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, TRUE, FALSE, canThrow, ALLBODY) == TRUE then
        return
    end
    if env(IsAnimEnd, 0) == TRUE then
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
end

function SwordArtsHalfOneShotShieldBoth_Upper_onUpdate()
    local index = SWORDARTS_PARRY + GetVariable("SwordArtsOneShotShieldIndex")
    local canThrow = FALSE
    if index == SWORDARTS_PARRY or index == SWORDARTS_SPELL_PARRY or index == SWORDARTS_PROJECTILE_PARRY or index ==
        SWORDARTS_BUCKLER_PARRY or index == SWORDARTS_DAGGER_PARRY then
        canThrow = TRUE
    end
    local blend_type, lower_state = GetHalfBlendInfo()
    local idle_cat = env(GetStayAnimCategory)
    local wep_cat = env(GetEquipWeaponCategory, c_SwordArtsHand)
    local arts_cat = GetSwordArtsDiffCategory(c_SwordArtsID, idle_cat, wep_cat)

    local arts_idx = 0
    if arts_cat == 47 then
        arts_idx = 1
    elseif arts_cat == 48 then
        arts_idx = 2
    end
    SetVariable("SwordArtsOneShotShieldCancelCategory", arts_idx)
    if 0 >= env(ActionDuration, ACTION_ARM_L2) then
        if env(GetSpEffectID, 100285) == TRUE then
            ExecEventAllBody("W_SwordArtsOneShotShieldBoth_Cancel")
        elseif env(GetSpEffectID, 100286) == TRUE then
            ExecEventAllBody("W_SwordArtsOneShotShieldBoth_Cancel")
        end
    end
    if ArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, TRUE, FALSE, canThrow, ALLBODY) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        local arts_category = c_SwordArtsID + 600
        local loop_animID = SWORDARTS_ANIM_ID_RIGHT_LOOP
        if env(DoesAnimExist, arts_category, loop_animID) == TRUE and
            (c_SwordArtsID ~= 201 and c_SwordArtsID ~= 202 or GetVariable("IsEnoughArtPointsL2") == FALSE) then
            if 0 < env(ActionDuration, ACTION_ARM_L2) then
                if c_SwordArtsID == 334 then
                    SetVariable("IsMadTorch", 1)
                else
                    SetVariable("IsMadTorch", 0)
                end
                if c_SwordArtsID == 334 and GetVariable("IsEnoughArtPointsL2") == TRUE then
                    ExecEventHalfBlend(Event_SwordArtsHalfBothLoopEnd, blend_type)
                else
                    ExecEventHalfBlend(Event_SwordArtsHalfBothLoopLoop, blend_type)
                end
            else
                ExecEventHalfBlend(Event_SwordArtsHalfBothLoopEnd, blend_type)
            end
            return
        end
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_DEFAULT)
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_SwordArtsHalfOneShotShieldBoth, lower_state, FALSE) == TRUE then
        return
    end
end

function SwordArtsRolling_onUpdate()
    SetEnableAimMode()
    local r1 = "W_AttackRightLightStep"
    local b1 = "W_AttackBothLightStep"
    local r2 = "W_AttackRightHeavy1Start"
    local b2 = "W_AttackBothHeavy1Start"
    if GetVariable("SwordArtsRollingDirection") ~= 0 then
        r1 = "W_AttackRightBackstep"
        b1 = "W_AttackBothBackstep"
    end

    if env(GetSpEffectID, 100054) == TRUE then
        r1 = "W_SwordArtsOneShotComboEnd"
        b1 = "W_SwordArtsOneShotComboEnd"
    elseif env(GetSpEffectID, 100055) == TRUE then
        r1 = "W_SwordArtsOneShotComboEnd_2"
        b1 = "W_SwordArtsOneShotComboEnd_2"
    end

    if env(GetSpEffectID, 100050) == TRUE then
        r2 = "W_SwordArtsOneShotComboEnd"
        b2 = "W_SwordArtsOneShotComboEnd"
    elseif env(GetSpEffectID, 100051) == TRUE then
        r2 = "W_SwordArtsOneShotComboEnd_2"
        b2 = "W_SwordArtsOneShotComboEnd_2"
    end

    if EvasionCommonFunction(FALL_TYPE_DEFAULT, r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2,
        QUICKTYPE_ROLLING) == TRUE then
        return
    end
    if env(IsAnimEnd, 0) == TRUE then
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
end

function SwordArtsRolling_SelfTrans_onUpdate()
    SetEnableAimMode()
    local r1 = "W_AttackRightLightStep"
    local b1 = "W_AttackBothLightStep"
    local r2 = "W_AttackRightHeavy1Start"
    local b2 = "W_AttackBothHeavy1Start"

    if GetVariable("SwordArtsRollingDirection") ~= 0 then
        r1 = "W_AttackRightBackstep"
        b1 = "W_AttackBothBackstep"
    end

    if env(GetSpEffectID, 100054) == TRUE then
        r1 = "W_SwordArtsOneShotComboEnd"
        b1 = "W_SwordArtsOneShotComboEnd"
    elseif env(GetSpEffectID, 100055) == TRUE then
        r1 = "W_SwordArtsOneShotComboEnd_2"
        b1 = "W_SwordArtsOneShotComboEnd_2"
    end

    if env(GetSpEffectID, 100050) == TRUE then
        r2 = "W_SwordArtsOneShotComboEnd"
        b2 = "W_SwordArtsOneShotComboEnd"
    elseif env(GetSpEffectID, 100051) == TRUE then
        r2 = "W_SwordArtsOneShotComboEnd_2"
        b2 = "W_SwordArtsOneShotComboEnd_2"
    end

    if EvasionCommonFunction(FALL_TYPE_DEFAULT, r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2,
        QUICKTYPE_ROLLING) == TRUE then
        return
    end
    if env(IsAnimEnd, 0) == TRUE then
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
end

function SwordArtsRolling_SelfTrans2_onUpdate()
    SetEnableAimMode()
    local r1 = "W_AttackRightLightStep"
    local b1 = "W_AttackBothLightStep"
    local r2 = "W_AttackRightHeavy1Start"
    local b2 = "W_AttackBothHeavy1Start"

    if GetVariable("SwordArtsRollingDirection") ~= 0 then
        r1 = "W_AttackRightBackstep"
        b1 = "W_AttackBothBackstep"
    end

    if env(GetSpEffectID, 100054) == TRUE then
        r1 = "W_SwordArtsOneShotComboEnd"
        b1 = "W_SwordArtsOneShotComboEnd"
    elseif env(GetSpEffectID, 100055) == TRUE then
        r1 = "W_SwordArtsOneShotComboEnd_2"
        b1 = "W_SwordArtsOneShotComboEnd_2"
    end

    if env(GetSpEffectID, 100050) == TRUE then
        r2 = "W_SwordArtsOneShotComboEnd"
        b2 = "W_SwordArtsOneShotComboEnd"
    elseif env(GetSpEffectID, 100051) == TRUE then
        r2 = "W_SwordArtsOneShotComboEnd_2"
        b2 = "W_SwordArtsOneShotComboEnd_2"
    end

    if EvasionCommonFunction(FALL_TYPE_DEFAULT, r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2,
        QUICKTYPE_ROLLING) == TRUE then
        return
    end
    if env(IsAnimEnd, 0) == TRUE then
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
end

function SwordArtsRolling_Sub_onUpdate()
    local rollingAngle = c_ArtsRollingAngle
    rollingAngle = GetVariable("MoveAngle")
    local turn_target_angle = 0
    local rollingDirection = 0

    if c_SwordArtsID == 276 then
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

    if c_SwordArtsID == 313 then
        if rollingAngle <= 0 and rollingAngle >= -120 then
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

    SetVariable("SwordArtsRollingDirection", rollingDirection)
    SetVariable("RollingAngleReal", rollingAngle)

    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1",
        "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy2Start", FALSE, TRUE, 0) == TRUE then
        return
    end

    if env(GetEventEzStateFlag, 0) == TRUE or env(IsAnimEnd, 1) == TRUE then
        act(SetSpecialInterpolation, 0, TRUE)
        ExecEventAllBody("W_SwordArtsRolling")
        return
    end
end

function SwordArtsLoopLoop_onUpdate()
    if c_SwordArtsID == 115 or c_SwordArtsID == 116 or c_SwordArtsID == 193 then
        local height = env(GetFallHeight) / 100
        local damage_type = env(GetReceivedDamageType)
        if damage_type == DAMAGE_TYPE_DEATH_FALLING then
            ExecEventAllBody("W_FallDeath")
            return TRUE
        end
        if not (height >= 60) or env(GetStateChangeType, 266) == TRUE then
        else
            ExecEventAllBody("W_FallDeath")
            return TRUE
        end
        if env(GetSpEffectID, 100670) == TRUE and env(IsTruelyLanding) == TRUE then
            ExecEventAllBody("W_SwordArtsLoopEnd")
        end
    elseif c_SwordArtsID == 13 then
        SetSwordArtsPointInfo(ACTION_ARM_R2, TRUE)
        if env(ActionDuration, ACTION_ARM_L2) <= 0 or env(GetStamina) <= 0 or
            env(HasEnoughArtsPoints, ACTION_ARM_R2, c_SwordArtsHand) == FALSE then
            ExecEventAllBody("W_SwordArtsLoopEnd")
            return
        end
    elseif env(ActionDuration, ACTION_ARM_L2) <= 0 or env(GetStamina) <= 0 or GetVariable("IsEnoughArtPointsL2") == 0 and
        env(HasEnoughArtsPoints, ACTION_ARM_L2, c_SwordArtsHand) == FALSE then
        ExecEventAllBody("W_SwordArtsLoopEnd")
        return
    end
    if ArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, TRUE, TRUE, FALSE, ALLBODY) == TRUE then
        return
    end
end

function SwordArtsHalfLoopLoop_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if c_SwordArtsID == 334 then
        SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)
    end
    if ArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, TRUE, TRUE, canThrow, blend_type) == TRUE then
        return
    end
    if c_SwordArtsID == 334 then
        SetVariable("IsMadTorch", 1)
        if env(GetSpEffectID, 100700) == FALSE and
            (env(ActionDuration, ACTION_ARM_L2) <= 0 or env(GetStamina) <= 0 or GetVariable("IsEnoughArtPointsL2") == 1 and
                env(HasEnoughArtsPoints, ACTION_ARM_L2, c_SwordArtsHand) == FALSE) then
            ExecEventHalfBlend(Event_SwordArtsHalfLoopEnd, blend_type)
            return
        end
    else
        SetVariable("IsMadTorch", 0)
        if env(GetSpEffectID, 100700) == FALSE and
            (env(ActionDuration, ACTION_ARM_L2) <= 0 or env(GetStamina) <= 0 or GetVariable("IsEnoughArtPointsL2") == 0 and
                env(HasEnoughArtsPoints, ACTION_ARM_L2, c_SwordArtsHand) == FALSE) then
            ExecEventHalfBlend(Event_SwordArtsHalfLoopEnd, blend_type)
            return
        end
    end
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_DEFAULT)
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_SwordArtsHalfLoopLoop, lower_state, FALSE) == TRUE then
        return
    end
end

function SwordArtsLoopEnd_onUpdate()
    if ArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, TRUE, TRUE, FALSE, ALLBODY) == TRUE then
        return
    end
    if env(IsAnimEnd, 0) == TRUE then
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
end

function SwordArtsHalfLoopEnd_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, TRUE, TRUE, canThrow, blend_type) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_DEFAULT)
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_SwordArtsHalfLoopEnd, lower_state, FALSE) == TRUE then
        return
    end
end

function SwordArtsBothLoopLoop_onUpdate()
    if env(ActionDuration, ACTION_ARM_L2) <= 0 then
        ExecEventAllBody("W_SwordArtsBothLoopEnd")
        return
    end
    if ArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, TRUE, FALSE, canThrow, ALLBODY) == TRUE then
        return
    end
end

function SwordArtsBothLoopEnd_onUpdate()
    if ArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, TRUE, TRUE, FALSE, ALLBODY) == TRUE then
        return
    end
    if env(IsAnimEnd, 0) == TRUE then
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
end

function SwordArtsHalfBothLoopLoop_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)
    if ArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, TRUE, FALSE, canThrow, ALLBODY) == TRUE then
        return
    end
    if env(ActionDuration, ACTION_ARM_L2) <= 0 or env(ActionCancelRequest, ACTION_ARM_L2) == TRUE or env(GetStamina) <=
        0 or GetVariable("IsEnoughArtPointsL2") == 1 then
        if c_SwordArtsID == 334 then
            SetVariable("IsMadTorch", 1)
        else
            SetVariable("IsMadTorch", 0)
        end
        ExecEventHalfBlend(Event_SwordArtsHalfBothLoopEnd, blend_type)
        return
    end
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_DEFAULT)
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_SwordArtsHalfBothLoopLoop, lower_state, FALSE) == TRUE then
        return
    end
end

function SwordArtsHalfBothLoopEnd_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, TRUE, TRUE, canThrow, blend_type) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_DEFAULT)
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_SwordArtsHalfBothLoopEnd, lower_state, FALSE) == TRUE then
        return
    end
end

function SwordArtsHalfLeftLoopLoop_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)
    if ArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, TRUE, FALSE, canThrow, ALLBODY) == TRUE then
        return
    end
    if env(ActionDuration, ACTION_ARM_L2) <= 0 or env(ActionCancelRequest, ACTION_ARM_L2) == TRUE or env(GetStamina) <=
        0 or GetVariable("IsEnoughArtPointsL2") == 1 then
        if c_SwordArtsID == 334 then
            SetVariable("IsMadTorch", 1)
        else
            SetVariable("IsMadTorch", 0)
        end
        ExecEventHalfBlend(Event_SwordArtsHalfLeftLoopEnd, blend_type)
        return
    end
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_DEFAULT)
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_SwordArtsHalfLeftLoopLoop, lower_state, FALSE) == TRUE then
        return
    end
end

function SwordArtsHalfLeftLoopEnd_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, TRUE, TRUE, canThrow, blend_type) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_DEFAULT)
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_SwordArtsHalfLeftLoopEnd, lower_state, FALSE) == TRUE then
        return
    end
end

function SwordArtsLeftLoopLoop_onUpdate()
    if env(ActionDuration, ACTION_ARM_L2) <= 0 then
        ExecEventAllBody("W_SwordArtsLeftLoopEnd")
        return
    end
    if ArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, TRUE, FALSE, canThrow, ALLBODY) == TRUE then
        return
    end
end

function SwordArtsHalfLeftLoopLoop_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)
    if ArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, TRUE, FALSE, canThrow, ALLBODY) == TRUE then
        return
    end
    if env(ActionDuration, ACTION_ARM_L2) <= 0 or env(ActionCancelRequest, ACTION_ARM_L2) == TRUE or env(GetStamina) <=
        0 or GetVariable("IsEnoughArtPointsL2") == 1 then
        ExecEventHalfBlend(Event_SwordArtsHalfLeftLoopEnd, blend_type)
        return
    end
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_DEFAULT)
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_SwordArtsHalfLeftLoopLoop, lower_state, FALSE) == TRUE then
        return
    end
end

function SwordArtsLeftLoopEnd_onUpdate()
    if ArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, TRUE, FALSE, FALSE, ALLBODY) == TRUE then
        return
    end
    if env(IsAnimEnd, 0) == TRUE then
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
end

function SwordArtsHalfLeftLoopEnd_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1",
        "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, TRUE, TRUE, canThrow, blend_type) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_DEFAULT)
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_SwordArtsHalfLeftLoopEnd, lower_state, FALSE) == TRUE then
        return
    end
end

function SwordArtsChargeCancelEarly_onUpdate()
    if env(IsAnimEnd, 0) == TRUE then
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end

    if env(GetSpEffectID, 102050) == TRUE then
        act(LockonFixedAngleCancel)
    end

    local r1 = "W_AttackRightLight1"
    local b1 = "W_AttackBothLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b2 = "W_AttackBothHeavy1Start"

    if c_SwordArtsID == 198 or c_SwordArtsID == 283 or c_SwordArtsID == 300 or c_SwordArtsID == 370 then
        r1 = "W_AttackRightLight2"
        b1 = "W_AttackBothLight2"
    end

    if env(GetSpEffectID, 100054) == TRUE then
        r1 = "W_SwordArtsOneShotComboEnd"
        b1 = "W_SwordArtsOneShotComboEnd"
    elseif env(GetSpEffectID, 100055) == TRUE then
        r1 = "W_SwordArtsOneShotComboEnd_2"
        b1 = "W_SwordArtsOneShotComboEnd_2"
    end

    if env(GetSpEffectID, 100050) == TRUE then
        r2 = "W_SwordArtsOneShotComboEnd"
        b2 = "W_SwordArtsOneShotComboEnd"
    elseif env(GetSpEffectID, 100051) == TRUE then
        r2 = "W_SwordArtsOneShotComboEnd_2"
        b2 = "W_SwordArtsOneShotComboEnd_2"
    end

    if ArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, TRUE, TRUE, TRUE, FALSE,
        ALLBODY) == TRUE then
        return
    end
    if env(IsAnimEnd, 0) == TRUE then
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
end

function SwordArtsChargeCancelLate_onUpdate()
    if env(IsAnimEnd, 0) == TRUE then
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
    local r1 = "W_AttackRightLight1"
    local b1 = "W_AttackBothLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b2 = "W_AttackBothHeavy1Start"
    if env(GetSpEffectID, 100054) == TRUE then
        r1 = "W_SwordArtsOneShotComboEnd"
        b1 = "W_SwordArtsOneShotComboEnd"
    elseif env(GetSpEffectID, 100055) == TRUE then
        r1 = "W_SwordArtsOneShotComboEnd_2"
        b1 = "W_SwordArtsOneShotComboEnd_2"
    end
    if env(GetSpEffectID, 100050) == TRUE then
        r2 = "W_SwordArtsOneShotComboEnd"
        b2 = "W_SwordArtsOneShotComboEnd"
    elseif env(GetSpEffectID, 100051) == TRUE then
        r2 = "W_SwordArtsOneShotComboEnd_2"
        b2 = "W_SwordArtsOneShotComboEnd_2"
    end

    if ArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, TRUE, TRUE, TRUE, FALSE,
        ALLBODY) == TRUE then
        return
    end
end

function SwordArtsChargeCancelEarly2_onUpdate()
    if env(IsAnimEnd, 0) == TRUE then
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
    local r1 = "W_AttackRightLight1"
    local b1 = "W_AttackBothLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b2 = "W_AttackBothHeavy1Start"
    if env(GetSpEffectID, 100054) == TRUE then
        r1 = "W_SwordArtsOneShotComboEnd"
        b1 = "W_SwordArtsOneShotComboEnd"
    elseif env(GetSpEffectID, 100055) == TRUE then
        r1 = "W_SwordArtsOneShotComboEnd_2"
        b1 = "W_SwordArtsOneShotComboEnd_2"
    end
    if env(GetSpEffectID, 100050) == TRUE then
        r2 = "W_SwordArtsOneShotComboEnd"
        b2 = "W_SwordArtsOneShotComboEnd"
    elseif env(GetSpEffectID, 100051) == TRUE then
        r2 = "W_SwordArtsOneShotComboEnd_2"
        b2 = "W_SwordArtsOneShotComboEnd_2"
    end

    if ArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, TRUE, TRUE, TRUE, FALSE,
        ALLBODY) == TRUE then
        return
    end
end

function SwordArtsChargeCancelEarly_Sub_onUpdate()
    local r1 = "W_AttackRightLight1"
    local b1 = "W_AttackBothLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b2 = "W_AttackBothHeavy1Start"

    if ArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, TRUE, TRUE, TRUE, FALSE,
        ALLBODY) == TRUE then
        return
    end
    if env(IsAnimEnd, 0) == TRUE then
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
end

function SwordArtsHalfChargeCancelEarly_Upper_onUpdate()
    local r1 = "W_AttackRightLight1"
    local b1 = "W_AttackBothLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b2 = "W_AttackBothHeavy1Start"
    local blend_type, lower_state = GetHalfBlendInfo()
    if env(GetSpEffectID, 100054) == TRUE then
        r1 = "W_SwordArtsOneShotComboEnd"
        b1 = "W_SwordArtsOneShotComboEnd"
    elseif env(GetSpEffectID, 100055) == TRUE then
        r1 = "W_SwordArtsOneShotComboEnd_2"
        b1 = "W_SwordArtsOneShotComboEnd_2"
    end
    if env(GetSpEffectID, 100050) == TRUE then
        r2 = "W_SwordArtsOneShotComboEnd"
        b2 = "W_SwordArtsOneShotComboEnd"
    elseif env(GetSpEffectID, 100051) == TRUE then
        r2 = "W_SwordArtsOneShotComboEnd_2"
        b2 = "W_SwordArtsOneShotComboEnd_2"
    end

    if ArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, TRUE, TRUE, TRUE, FALSE,
        ALLBODY) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        SetArtsGeneratorTransitionIndex()
        ExecEventAllBody("W_Idle")
        return
    end
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_DEFAULT)
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_SwordArtsHalfChargeCancelEarly, lower_state, FALSE) == TRUE then
        return
    end
end

function SwordArtsStandDodge_onUpdate()
    if ExecDamage(FALSE, FALSE) == TRUE then
        return TRUE
    end
    if ExecFallAttack() == TRUE then
        return
    end
    if env(IsFalling) == TRUE or env(IsAnimEnd, 0) == TRUE then
        ExecEventAllBody("W_FallLoop")
        return
    end
end

function SwordArtsLeft_Activate()
    SetAttackHand(HAND_LEFT)
    SetGuardHand(HAND_LEFT)
end

function SwordArtsArrowStanceStart_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    act(SetIsPreciseShootingPossible)
    if ArrowCommonFunction(blend_type, FALSE, TURN_TYPE_STANCE) == TRUE then
        return
    end
    if ArrowStanceCommonFunction(blend_type, FALSE) == TRUE then
        return
    end
    if env(GetEventEzStateFlag, 0) == TRUE and
        (env(ActionDuration, ACTION_ARM_L2) <= 0 or env(ActionCancelRequest, ACTION_ARM_L2) == TRUE) then
        ExecEventHalfBlend(Event_SwordArtsArrowStanceEnd, blend_type)
        if lower_state == LOWER_MOVE then
            ExecEventHalfBlendNoReset(Event_Move, LOWER)
        end
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        ExecEventHalfBlend(Event_SwordArtsArrowStanceLoop, blend_type)
        return
    end
    if HalfBlendLowerCommonFunction(Event_SwordArtsArrowStanceStartMirror, lower_state, FALSE) == TRUE then
        return
    end
end

function SetSwordArtsWepCategory_DrawStanceRightAttackLight()
    local idle_cat = env(GetStayAnimCategory)
    local wep_cat = env(GetEquipWeaponCategory, c_SwordArtsHand)
    local arts_cat = GetSwordArtsDiffCategory(c_SwordArtsID, idle_cat, wep_cat)
    local arts_idx = 0

    if arts_cat == WEAPON_CATEGORY_LARGE_ARROW then
        arts_idx = 1
    end
    SetVariable("DrawStanceRightAttackLightCategory", arts_idx)
end

function ArrowStanceCommonFunction(blend_type, checkHold)
    local request = GetAttackRequest(FALSE)
    local arrowHand = HAND_RIGHT
    if c_Style == HAND_LEFT_BOTH then
        arrowHand = HAND_LEFT
    end
    if (request == ATTACK_REQUEST_ARROW_FIRE_LEFT or request == ATTACK_REQUEST_ARROW_FIRE_RIGHT) and
        (checkHold == FALSE or env(ActionDuration, ACTION_ARM_L2) > 0) then
        g_ArrowSlot = 0
        act(ChooseBowAndArrowSlot, 0)
        if env(IsOutOfAmmo, arrowHand) == TRUE then
            ExecEventAllBody("W_NoArrow")
            return TRUE
        end
        if env(GetStamina) > 0 then
            SetSwordArtsPointInfo(ACTION_ARM_R1, TRUE)
            SetSwordArtsWepCategory_DrawStanceRightAttackLight()
            ExecEventAllBody("W_DrawStanceRightAttackLight")
            return TRUE
        end
    elseif (request == ATTACK_REQUEST_ARROW_FIRE_LEFT2 or request == ATTACK_REQUEST_ARROW_FIRE_RIGHT2) and
        (checkHold == FALSE or env(ActionDuration, ACTION_ARM_L2) > 0) then
        act(ResetInputQueue)
        g_ArrowSlot = 1
        act(ChooseBowAndArrowSlot, 1)
        if env(IsOutOfAmmo, arrowHand) == TRUE then
            ExecEventAllBody("W_NoArrow")
            return TRUE
        end
        if env(GetStamina) > 0 then
            SetSwordArtsPointInfo(ACTION_ARM_R1, TRUE)
            SetSwordArtsWepCategory_DrawStanceRightAttackLight()
            ExecEventAllBody("W_DrawStanceRightAttackLight")
            return TRUE
        end
    end
    return FALSE
end

function CrossbowStanceCommonFunction(blend_type, IsShooting)
    local request = GetAttackRequest(FALSE)
    local arrowHand = HAND_RIGHT
    if c_Style == HAND_LEFT_BOTH then
        arrowHand = HAND_LEFT
    end
    if IsShooting == TRUE then
        if env(ActionDuration, ACTION_ARM_L2) > 0 and
            (request == ATTACK_REQUEST_RIGHT_CROSSBOW or request == ATTACK_REQUEST_LEFT_CROSSBOW or request ==
                ATTACK_REQUEST_BOTHRIGHT_CROSSBOW or request == ATTACK_REQUEST_BOTHLEFT_CROSSBOW or request ==
                ATTACK_REQUEST_RIGHT_CROSSBOW2 or request == ATTACK_REQUEST_LEFT_CROSSBOW2 or request ==
                ATTACK_REQUEST_BOTHRIGHT_CROSSBOW2 or request == ATTACK_REQUEST_BOTHLEFT_CROSSBOW2) then
            ExecEventHalfBlend(Event_DrawStanceRightStart, blend_type)
            return TRUE
        end
    elseif (request == ATTACK_REQUEST_RIGHT_CROSSBOW or request == ATTACK_REQUEST_LEFT_CROSSBOW or request ==
        ATTACK_REQUEST_BOTHRIGHT_CROSSBOW or request == ATTACK_REQUEST_BOTHLEFT_CROSSBOW) and
        env(ActionDuration, ACTION_ARM_L2) > 0 then
        g_ArrowSlot = 0
        act(ChooseBowAndArrowSlot, 0)
        if env(IsOutOfAmmo, arrowHand) == TRUE then
            ExecEventHalfBlend(Event_AttackCrossbowRightEmpty, blend_type)
            return TRUE
        end
        if env(GetStamina) > 0 then
            SetSwordArtsPointInfo(ACTION_ARM_R1, TRUE)
            SetSwordArtsWepCategory_DrawStanceRightAttackLight()
            if IsHalfBlendArts(c_SwordArtsID) == TRUE then
                local blend_type, lower_state = GetHalfBlendInfo()
                ExecEventHalfBlend(Event_DrawStanceHalfRightAttackLight, blend_type)
            else
                ExecEventAllBody("W_DrawStanceRightAttackLight")
            end
            return TRUE
        end
    elseif (request == ATTACK_REQUEST_RIGHT_CROSSBOW2 or request == ATTACK_REQUEST_LEFT_CROSSBOW2 or request ==
        ATTACK_REQUEST_BOTHRIGHT_CROSSBOW2 or request == ATTACK_REQUEST_BOTHLEFT_CROSSBOW2) and
        env(ActionDuration, ACTION_ARM_L2) > 0 then
        act(ResetInputQueue)
        g_ArrowSlot = 1
        act(ChooseBowAndArrowSlot, 1)

        if env(IsOutOfAmmo, arrowHand) == TRUE then
            ExecEventHalfBlend(Event_AttackCrossbowRightEmpty, blend_type)
            return TRUE
        end
        if env(GetStamina) > 0 then
            SetSwordArtsPointInfo(ACTION_ARM_R1, TRUE)
            SetSwordArtsWepCategory_DrawStanceRightAttackLight()

            if IsHalfBlendArts(c_SwordArtsID) == TRUE then
                local blend_type, lower_state = GetHalfBlendInfo()
                ExecEventHalfBlend(Event_DrawStanceHalfRightAttackLight, blend_type)
            else
                ExecEventAllBody("W_DrawStanceRightAttackLight")
            end
            return TRUE
        end
    end
    return FALSE
end

function SwordArtsArrowStanceLoop_Upper_onUpdate()
    act(SetIsPreciseShootingPossible)
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if ArrowCommonFunction(blend_type, FALSE, TURN_TYPE_STANCE) == TRUE then
        return
    end
    if ArrowStanceCommonFunction(blend_type, FALSE) == TRUE then
        return
    end
    if env(ActionDuration, ACTION_ARM_L2) <= 0 or env(ActionCancelRequest, ACTION_ARM_L2) == TRUE then
        ExecEventHalfBlend(Event_SwordArtsArrowStanceEnd, blend_type)
        return
    end
    if HalfBlendLowerCommonFunction(Event_SwordArtsArrowStanceLoop, lower_state, FALSE) == TRUE then
        return
    end
end

function SwordArtsArrowDrawStart_Upper_onUpdate()
    act(SetIsPreciseShootingPossible)
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if ArrowCommonFunction(blend_type, FALSE, TURN_TYPE_STANCE) == TRUE then
        return
    end
    if env(IsAnimEnd, 1) == TRUE then
        ExecEventHalfBlend(Event_SwordArtsArrowDrawLoop, blend_type)
        return
    end
    if HalfBlendLowerCommonFunction(Event_SwordArtsArrowStanceStartMirror, lower_state, FALSE) == TRUE then
        return
    end
end

function SwordArtsArrowDrawLoop_Upper_onUpdate()
    act(SetIsPreciseShootingPossible)
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_STANCE)
    end
    if ArrowCommonFunction(blend_type, FALSE, TURN_TYPE_STANCE) == TRUE then
        return
    end
    if g_ArrowSlot == 0 and 0 >= env(ActionDuration, ACTION_ARM_R1) or g_ArrowSlot == 1 and 0 >=
        env(ActionDuration, ACTION_ARM_R2) then
        SetSwordArtsPointInfo(ACTION_ARM_R1, TRUE)
        ExecEventAllBody("W_SwordArtsArrowFire")
        return
    end
    if HalfBlendLowerCommonFunction(Event_SwordArtsArrowStanceLoop, lower_state, FALSE) == TRUE then
        return
    end
end

function SwordArtsArrowFire_onUpdate()
    act(SetIsPreciseShootingPossible)
    if ArrowCommonFunction(ALLBODY, TRUE, TURN_TYPE_DEFAULT) == TRUE then
        return
    end
    if env(GetSpEffectID, 100280) == TRUE and
        (g_ArrowSlot == 0 and env(ActionDuration, ACTION_ARM_R1) <= 0 or g_ArrowSlot == 1 and
            env(ActionDuration, ACTION_ARM_R2) <= 0) then
        ExecEventAllBody("W_SwordArtsArrowFireEnd")
        return
    end
    if ArrowStanceCommonFunction(ALLBODY, TRUE) == TRUE then
        return
    end
    if env(GetEventEzStateFlag, 0) == TRUE or env(IsAnimEnd, 0) == TRUE then
        if env(ActionDuration, ACTION_ARM_L2) > 0 then
            ExecEventHalfBlendNoReset(Event_SwordArtsArrowStanceLoop, ALLBODY)
            return
        else
            ExecEventHalfBlend(Event_SwordArtsArrowStanceEnd, ALLBODY)
            return
        end
    end
end

function SwordArtsArrowFireEnd_onUpdate()
    act(SetIsPreciseShootingPossible)
    if ArrowCommonFunction(ALLBODY, TRUE, TURN_TYPE_DEFAULT) == TRUE then
        return
    end
    if ArrowStanceCommonFunction(ALLBODY, TRUE) == TRUE then
        return
    end
    if env(GetEventEzStateFlag, 0) == TRUE or env(IsAnimEnd, 0) == TRUE then
        if env(ActionDuration, ACTION_ARM_L2) > 0 then
            ExecEventHalfBlendNoReset(Event_SwordArtsArrowStanceLoop, ALLBODY)
            return
        else
            ExecEventHalfBlend(Event_SwordArtsArrowStanceEnd, ALLBODY)
            return
        end
    end
end

function SwordArtsArrowStanceEnd_Upper_onUpdate()
    act(SetIsPreciseShootingPossible)
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act(LockonSystemUnableToTurnAngle, 45, 45)
    elseif lower_state == LOWER_TURN then
        SetVariable("TurnType", TURN_TYPE_DEFAULT)
    end
    if ArrowCommonFunction(blend_type, FALSE, TURN_TYPE_DEFAULT) == TRUE then
        return
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return
    end
    if HalfBlendLowerCommonFunction(Event_SwordArtsArrowStanceEnd, lower_state, TRUE) == TRUE then
        return
    end
end


GetSwordArtsDiffCategory = hookup_function(GetSwordArtsDiffCategory)
GetSwordArtsPutOppositeWeapon = hookup_function(GetSwordArtsPutOppositeWeapon)
SetArtCancelType = hookup_function(SetArtCancelType)
GetSwordArtInfo = hookup_function(GetSwordArtInfo)
IsEnableSwordArts = hookup_function(IsEnableSwordArts)
GreyOutSwordArtFE = hookup_function(GreyOutSwordArtFE)
IsAttackSwordArts = hookup_function(IsAttackSwordArts)
IsHalfBlendArts = hookup_function(IsHalfBlendArts)
IsEnchantArts = hookup_function(IsEnchantArts)
IsShieldArts = hookup_function(IsShieldArts)
IsStanceArts = hookup_function(IsStanceArts)
IsArrowStanceArts = hookup_function(IsArrowStanceArts)
IsAttackStanceArts = hookup_function(IsAttackStanceArts)
IsRollingArts = hookup_function(IsRollingArts)
GetSwordArtsRequestNew = hookup_function(GetSwordArtsRequestNew)
HasSwordArtPoint = hookup_function(HasSwordArtPoint)
SetSwordArtsPointInfo = hookup_function(SetSwordArtsPointInfo)
RequestArtPointConsumption = hookup_function(RequestArtPointConsumption)
CheckIfNonGeneratorTransition = hookup_function(CheckIfNonGeneratorTransition)
SetArtsGeneratorTransitionIndex = hookup_function(SetArtsGeneratorTransitionIndex)
ExecArtsStance = hookup_function(ExecArtsStance)
ExecArtsStanceOnCancelTiming = hookup_function(ExecArtsStanceOnCancelTiming)
ArtsCommonFunction = hookup_function(ArtsCommonFunction)
ArtsParryCommonFunction = hookup_function(ArtsParryCommonFunction)
ArtsStanceCommonFunction = hookup_function(ArtsStanceCommonFunction)
ArtsChargeShotCommonFunction = hookup_function(ArtsChargeShotCommonFunction)
SwordArts_Activate = hookup_function(SwordArts_Activate)
SwordArts_Update = hookup_function(SwordArts_Update)
DrawStanceRightStart_Upper_onUpdate = hookup_function(DrawStanceRightStart_Upper_onUpdate)
DrawStanceRightLoop_Upper_onUpdate = hookup_function(DrawStanceRightLoop_Upper_onUpdate)
DrawStanceNoSyncLoop_Upper_onUpdate = hookup_function(DrawStanceNoSyncLoop_Upper_onUpdate)
DrawStanceNoSyncLoopMax_Upper_onUpdate = hookup_function(DrawStanceNoSyncLoopMax_Upper_onUpdate)
DrawStanceRightEnd_Upper_onUpdate = hookup_function(DrawStanceRightEnd_Upper_onUpdate)
DrawStanceRightAttackLight_onUpdate = hookup_function(DrawStanceRightAttackLight_onUpdate)
DrawStanceRightAttackLightCancel_onUpdate = hookup_function(DrawStanceRightAttackLightCancel_onUpdate)
DrawStanceHalfRightAttackLight_Upper_onUpdate = hookup_function(DrawStanceHalfRightAttackLight_Upper_onUpdate)
SwordArtsStanceAttackLightStart_onUpdate = hookup_function(SwordArtsStanceAttackLightStart_onUpdate)
SwordArtsStanceAttackLight180_onUpdate = hookup_function(SwordArtsStanceAttackLight180_onUpdate)
DrawStanceRightAttackHeavy_onUpdate = hookup_function(DrawStanceRightAttackHeavy_onUpdate)
DrawStanceRightAttackHeavy2_onUpdate = hookup_function(DrawStanceRightAttackHeavy2_onUpdate)
SwordArtsStanceAttackHeavyStart_onUpdate = hookup_function(SwordArtsStanceAttackHeavyStart_onUpdate)
SwordArtsStanceAttackHeavy180_onUpdate = hookup_function(SwordArtsStanceAttackHeavy180_onUpdate)
SwordArtsOneShot_onUpdate = hookup_function(SwordArtsOneShot_onUpdate)
SwordArtsOneShot_Sub_onUpdate = hookup_function(SwordArtsOneShot_Sub_onUpdate)
SwordArtsHalfOneShot_Upper_onUpdate = hookup_function(SwordArtsHalfOneShot_Upper_onUpdate)
SwordArtsOneShotComboEnd_onUpdate = hookup_function(SwordArtsOneShotComboEnd_onUpdate)
SwordArtsOneShotComboEnd_MesmerSowrdArts_onUpdate = hookup_function(SwordArtsOneShotComboEnd_MesmerSowrdArts_onUpdate)
SwordArtsHalfOneShotComboEnd_Upper_onUpdate = hookup_function(SwordArtsHalfOneShotComboEnd_Upper_onUpdate)
SwordArtsOneShotComboEnd_2_onUpdate = hookup_function(SwordArtsOneShotComboEnd_2_onUpdate)
SwordArtsHalfOneShotComboEnd_2_Upper_onUpdate = hookup_function(SwordArtsHalfOneShotComboEnd_2_Upper_onUpdate)
SwordArtsOneShotShieldLeft_onUpdate = hookup_function(SwordArtsOneShotShieldLeft_onUpdate)
SwordArtsLeftGuardCounter_onUpdate = hookup_function(SwordArtsLeftGuardCounter_onUpdate)
SwordArtsBothGuardCounter_onUpdate = hookup_function(SwordArtsBothGuardCounter_onUpdate)
SwordArtsHalfOneShotShieldLeft_Upper_onUpdate = hookup_function(SwordArtsHalfOneShotShieldLeft_Upper_onUpdate)
SwordArtsOneShotShieldLeft_Cancel_onUpdate = hookup_function(SwordArtsOneShotShieldLeft_Cancel_onUpdate)
SwordArtsOneShotShieldBoth_onUpdate = hookup_function(SwordArtsOneShotShieldBoth_onUpdate)
SwordArtsOneShotShieldBoth_Cancel_onUpdate = hookup_function(SwordArtsOneShotShieldBoth_Cancel_onUpdate)
SwordArtsHalfOneShotShieldBoth_Upper_onUpdate = hookup_function(SwordArtsHalfOneShotShieldBoth_Upper_onUpdate)
SwordArtsRolling_onUpdate = hookup_function(SwordArtsRolling_onUpdate)
SwordArtsRolling_SelfTrans_onUpdate = hookup_function(SwordArtsRolling_SelfTrans_onUpdate)
SwordArtsRolling_SelfTrans2_onUpdate = hookup_function(SwordArtsRolling_SelfTrans2_onUpdate)
SwordArtsRolling_Sub_onUpdate = hookup_function(SwordArtsRolling_Sub_onUpdate)
SwordArtsLoopLoop_onUpdate = hookup_function(SwordArtsLoopLoop_onUpdate)
SwordArtsHalfLoopLoop_Upper_onUpdate = hookup_function(SwordArtsHalfLoopLoop_Upper_onUpdate)
SwordArtsLoopEnd_onUpdate = hookup_function(SwordArtsLoopEnd_onUpdate)
SwordArtsHalfLoopEnd_Upper_onUpdate = hookup_function(SwordArtsHalfLoopEnd_Upper_onUpdate)
SwordArtsBothLoopLoop_onUpdate = hookup_function(SwordArtsBothLoopLoop_onUpdate)
SwordArtsBothLoopEnd_onUpdate = hookup_function(SwordArtsBothLoopEnd_onUpdate)
SwordArtsHalfBothLoopLoop_Upper_onUpdate = hookup_function(SwordArtsHalfBothLoopLoop_Upper_onUpdate)
SwordArtsHalfBothLoopEnd_Upper_onUpdate = hookup_function(SwordArtsHalfBothLoopEnd_Upper_onUpdate)
SwordArtsHalfLeftLoopLoop_Upper_onUpdate = hookup_function(SwordArtsHalfLeftLoopLoop_Upper_onUpdate)
SwordArtsHalfLeftLoopEnd_Upper_onUpdate = hookup_function(SwordArtsHalfLeftLoopEnd_Upper_onUpdate)
SwordArtsLeftLoopLoop_onUpdate = hookup_function(SwordArtsLeftLoopLoop_onUpdate)
SwordArtsHalfLeftLoopLoop_Upper_onUpdate = hookup_function(SwordArtsHalfLeftLoopLoop_Upper_onUpdate)
SwordArtsLeftLoopEnd_onUpdate = hookup_function(SwordArtsLeftLoopEnd_onUpdate)
SwordArtsHalfLeftLoopEnd_Upper_onUpdate = hookup_function(SwordArtsHalfLeftLoopEnd_Upper_onUpdate)
SwordArtsChargeCancelEarly_onUpdate = hookup_function(SwordArtsChargeCancelEarly_onUpdate)
SwordArtsChargeCancelLate_onUpdate = hookup_function(SwordArtsChargeCancelLate_onUpdate)
SwordArtsChargeCancelEarly2_onUpdate = hookup_function(SwordArtsChargeCancelEarly2_onUpdate)
SwordArtsChargeCancelEarly_Sub_onUpdate = hookup_function(SwordArtsChargeCancelEarly_Sub_onUpdate)
SwordArtsHalfChargeCancelEarly_Upper_onUpdate = hookup_function(SwordArtsHalfChargeCancelEarly_Upper_onUpdate)
SwordArtsStandDodge_onUpdate = hookup_function(SwordArtsStandDodge_onUpdate)
SwordArtsLeft_Activate = hookup_function(SwordArtsLeft_Activate)
SwordArtsArrowStanceStart_Upper_onUpdate = hookup_function(SwordArtsArrowStanceStart_Upper_onUpdate)
SetSwordArtsWepCategory_DrawStanceRightAttackLight = hookup_function(SetSwordArtsWepCategory_DrawStanceRightAttackLight)
ArrowStanceCommonFunction = hookup_function(ArrowStanceCommonFunction)
CrossbowStanceCommonFunction = hookup_function(CrossbowStanceCommonFunction)
SwordArtsArrowStanceLoop_Upper_onUpdate = hookup_function(SwordArtsArrowStanceLoop_Upper_onUpdate)
SwordArtsArrowDrawStart_Upper_onUpdate = hookup_function(SwordArtsArrowDrawStart_Upper_onUpdate)
SwordArtsArrowDrawLoop_Upper_onUpdate = hookup_function(SwordArtsArrowDrawLoop_Upper_onUpdate)
SwordArtsArrowFire_onUpdate = hookup_function(SwordArtsArrowFire_onUpdate)
SwordArtsArrowFireEnd_onUpdate = hookup_function(SwordArtsArrowFireEnd_onUpdate)
SwordArtsArrowStanceEnd_Upper_onUpdate = hookup_function(SwordArtsArrowStanceEnd_Upper_onUpdate)