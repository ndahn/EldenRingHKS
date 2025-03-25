
--------------
-- Triggers --
--------------

function RideDamage_onUpdate()
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end
    if (env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE) and
        RideRequestFunction(RIDE_MOVE_TYPE_OTHER, TRUE, FALSE) == TRUE then
        return
    end
end

function RideDamage_M_onUpdate()
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end
    if (env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE) and
        RideRequestFunction(RIDE_MOVE_TYPE_OTHER, TRUE, FALSE) == TRUE then
        return
    end
end

function RideDamage_H_onUpdate()
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end
    if (env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE) and
        RideRequestFunction(RIDE_MOVE_TYPE_OTHER, TRUE, FALSE) == TRUE then
        return
    end
end

function RideDamageSmall_onUpdate()
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end
    if (env(MovementRequest) == TRUE or env(IsAnimEnd, 1) == TRUE) and
        RideRequestFunction(RIDE_MOVE_TYPE_OTHER, TRUE, FALSE) == TRUE then
        return
    end
end

function RideDamageMiddle_onUpdate()
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end
    if (env(MovementRequest) == TRUE or env(IsAnimEnd, 1) == TRUE) and
        RideRequestFunction(RIDE_MOVE_TYPE_OTHER, TRUE, FALSE) == TRUE then
        return
    end
end

function RideDamageLarge_onUpdate()
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end
    if (env(MovementRequest) == TRUE or env(IsAnimEnd, 1) == TRUE) and
        RideRequestFunction(RIDE_MOVE_TYPE_OTHER, TRUE, FALSE) == TRUE then
        return
    end
end

function RideDamageExLarge_onUpdate()
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end
    if (env(MovementRequest) == TRUE or env(IsAnimEnd, 1) == TRUE) and
        RideRequestFunction(RIDE_MOVE_TYPE_OTHER, TRUE, FALSE) == TRUE then
        return
    end
end

function RideDamageWeakTop_onUpdate()
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end
    if (env(MovementRequest) == TRUE or env(IsAnimEnd, 1) == TRUE) and
        RideRequestFunction(RIDE_MOVE_TYPE_OTHER, TRUE, FALSE) == TRUE then
        return
    end
end

function RideDamageWeakUnder_onUpdate()
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        return
    end
    if (env(MovementRequest) == TRUE or env(IsAnimEnd, 1) == TRUE) and
        RideRequestFunction(RIDE_MOVE_TYPE_OTHER, TRUE, FALSE) == TRUE then
        return
    end
end

function RideFireDamageBlend_Default_onUpdate()
    SetVariable("BlendRideDamageFire", 0)
    act(ApplyRideBlend, "BlendRiddenDamageFire", 0)
end

function RideDamage_Fall_onUpdate()
    act(SetAllowedThrowDefenseType, 0)
    act(SetAllowedThrowAttackType, 1)
    SetAIActionState()
    SetVariable("Int16Variable01", 0)
    act(Dismount)

    if DamageCommonFunction(FALSE, ESTEP_NONE, FALL_TYPE_FORCE) == TRUE then
        return TRUE
    end
    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        ExecEventAllBody("W_Idle")
        return
    end
end

function RideDamage_Fall_AbyssalForest_onUpdate()
    act(SetAllowedThrowDefenseType, 0)
    act(SetAllowedThrowAttackType, 1)
    SetAIActionState()
    SetVariable("Int16Variable01", 0)

    if DamageCommonFunction(FALSE, ESTEP_NONE, FALL_TYPE_FORCE) == TRUE then
        return TRUE
    end

    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        ExecEventAllBody("W_Idle")
        return
    end
end

function RideDamage_Fall_AbyssalForest_onDeactivate()
    act(Dismount)
end

function RideDamageMad_onUpdate()
    act(SetAllowedThrowDefenseType, 0)
    act(SetAllowedThrowAttackType, 1)
    SetAIActionState()
    SetVariable("Int16Variable01", 0)

    if env(GetSpecialAttribute) == 25 and 0 >= env(GetHP) and env(IsOnMount) == TRUE then
        SetVariable("IndexRideDeath", RIDE_DEATH_TYPE_MAD)
        FireRideEvent("W_RideDeath", "W_RideDeath", FALSE)
        return
    end

    act(Dismount)

    if DamageCommonFunction(FALSE, ESTEP_NONE, FALL_TYPE_FORCE) == TRUE then
        return TRUE
    end
    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        ExecEventAllBody("W_Idle")
        return
    end
end

function RideDamageBind_Start_onUpdate()
    act(SetIsMagicInUse, 0)
    act(SetAllowedThrowDefenseType, 0)
    act(SetAllowedThrowAttackType, 1)
    SetAIActionState()
    SetVariable("Int16Variable01", 0)
    act(Dismount)

    if DamageCommonFunction(FALSE, ESTEP_NONE, FALL_TYPE_FORCE) == TRUE then
        return TRUE
    end
    if env(IsAnimEnd, 0) == TRUE then
        ExecEventAllBody("W_RideDamageBind_Loop")
        return
    end
end

function RideDamageBind_Loop_onUpdate()
    act(SetIsMagicInUse, 0)
    act(SetAllowedThrowDefenseType, 0)
    act(SetAllowedThrowAttackType, 1)
    SetAIActionState()
    SetVariable("Int16Variable01", 0)
    act(Dismount)
    if DamageCommonFunction(FALSE, ESTEP_NONE, FALL_TYPE_FORCE) == TRUE then
        return TRUE
    end
    if env(GetSpEffectType, 32) == FALSE then
        ExecEventAllBody("W_RideDamageBind_End")
    end
end

function RideDamageBind_End_onUpdate()
    act(SetIsMagicInUse, 0)
    act(SetAllowedThrowDefenseType, 0)
    act(SetAllowedThrowAttackType, 1)
    SetAIActionState()
    SetVariable("Int16Variable01", 0)
    act(Dismount)
    if DamageCommonFunction(FALSE, ESTEP_NONE, FALL_TYPE_FORCE) == TRUE then
        return TRUE
    end
    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        act(SetDamageAnimType, DAMAGE_FLAG_SMALL)
        ExecEventAllBody("W_Idle")
        return
    end
end
