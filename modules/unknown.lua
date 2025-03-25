
--------------
-- Triggers --
--------------

function Event26001_onActivate()
    ResetEventState()
    act(SetTurnAnimCorrectionRate, 90)
end

function Event26001_onUpdate()
    act(SetIsTurnAnimInProgress)
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event26011_onActivate()
    ResetEventState()
    act(SetTurnAnimCorrectionRate, 90)
end

function Event26011_onUpdate()
    act(SetIsTurnAnimInProgress)
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event26020_onActivate()
    ResetEventState()
end

function Event26020_onUpdate()
    act(SetIsEventActionPossible, TRUE)
    if EventCommonFunction() == TRUE then
        act(SetIsEventActionPossible, FALSE)
        return
    end
end

function Event26030_onActivate()
    ResetEventState()
end

function Event26030_onUpdate()
    act(SetIsEventActionPossible, TRUE)
    if EventCommonFunction() == TRUE then
        act(SetIsEventActionPossible, FALSE)
        return
    end
end

function Event26021_onActivate()
    ResetEventState()
    act(SetTurnAnimCorrectionRate, 180)
end

function Event26021_onUpdate()
    act(SetIsTurnAnimInProgress)
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event26031_onActivate()
    ResetEventState()
    act(SetTurnAnimCorrectionRate, 180)
end

function Event26031_onUpdate()
    act(SetIsTurnAnimInProgress)
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event50050_onActivate()
    ResetEventState()
end

function Event50050_onUpdate()
    act(SetIsEventActionPossible, TRUE)
    if EventCommonFunction() == TRUE then
        act(SetIsEventActionPossible, FALSE)
        return
    end
end

function Event50050_onDeactivate()
    act(SetIsEventActionPossible, FALSE)
end

function Event50250_onActivate()
    ResetEventState()
end

function Event50250_onUpdate()
    act(SetIsEventActionPossible, TRUE)
    if EventCommonFunction() == TRUE then
        act(SetIsEventActionPossible, FALSE)
        return
    end
end

function Event50250_onDeactivate()
    act(SetIsEventActionPossible, FALSE)
end

function Event60000_onActivate()
    ResetEventState()
end

function Event60000_onUpdate()
    act(SetIsEventActionPossible, TRUE)
    if EventCommonFunction() == TRUE then
        act(SetIsEventActionPossible, FALSE)
        return
    end
end

function Event60000_onDeactivate()
    act(SetIsEventActionPossible, FALSE)
end

function Event60001_onActivate()
    ResetEventState()
end

function Event60001_onUpdate()
    act(SetIsEventActionPossible, TRUE)
    if EventCommonFunction() == TRUE then
        act(SetIsEventActionPossible, FALSE)
        return
    end
end

function Event60001_onDeactivate()
    act(SetIsEventActionPossible, FALSE)
end

function Event60002_onActivate()
    ResetEventState()
end

function Event60002_onUpdate()
    act(SetIsEventActionPossible, TRUE)
    if EventCommonFunction() == TRUE then
        act(SetIsEventActionPossible, FALSE)
        return
    end
end

function Event60002_onDeactivate()
    act(SetIsEventActionPossible, FALSE)
end

function Event60003_onActivate()
    ResetEventState()
end

function Event60003_onUpdate()
    act(SetIsEventActionPossible, TRUE)
    if EventCommonFunction() == TRUE then
        act(SetIsEventActionPossible, FALSE)
        return
    end
end

function Event60003_onDeactivate()
    act(SetIsEventActionPossible, FALSE)
end

function Event60010_onActivate()
    ResetEventState()
end

function Event60010_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60020_onActivate()
    ResetEventState()
end

function Event60020_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60030_onActivate()
    ResetEventState()
end

function Event60030_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60040_onActivate()
    ResetEventState()
end

function Event60040_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60060_onActivate()
    ResetEventState()
end

function Event60060_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60070_onActivate()
    ResetEventState()
end

function Event60070_onUpdate()
    act(SetIsEventActionPossible, TRUE)
    if EventCommonFunction() == TRUE then
        act(SetIsEventActionPossible, FALSE)
        return
    end
end

function Event60070_onDeactivate()
    act(SetIsEventActionPossible, FALSE)
end

function Event60071_onActivate()
    ResetEventState()
end

function Event60071_onUpdate()
    act(SetIsEventActionPossible, TRUE)
    if EventCommonFunction() == TRUE then
        act(SetIsEventActionPossible, FALSE)
        return
    end
end

function Event60071_onDeactivate()
    act(SetIsEventActionPossible, FALSE)
end

function EventHalfBlend60071_Upper_onActivate()
    ResetEventState()
end

function EventHalfBlend60071_Upper_onUpdate()
    act(SetIsEventActionPossible, TRUE)
    act(Wait)
    local blend_type, lower_state = GetHalfBlendInfo()
    if EventCommonFunction() == TRUE then
        act(SetIsEventActionPossible, FALSE)
        return
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        act(SetIsEventActionPossible, FALSE)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        act(SetIsEventActionPossible, FALSE)
        return
    end
    if HalfBlendLowerCommonFunction(Event_EventHalfBlend60071, lower_state, FALSE) == TRUE then
        act(SetIsEventActionPossible, FALSE)
        return
    end
end

function EventHalfBlend60071_Upper_onDeactivate()
    act(SetIsEventActionPossible, FALSE)
end

function EventHalfBlend360070_Upper_onActivate()
    ResetEventState()
end

function EventHalfBlend360070_Upper_onUpdate()
    act(SetIsEventActionPossible, TRUE)
    act(Wait)
    local blend_type, lower_state = GetHalfBlendInfo()
    if EventCommonFunction() == TRUE then
        act(SetIsEventActionPossible, FALSE)
        return
    end
    if lower_state == LOWER_MOVE and env(IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Stealth_Move, UPPER)
        act(SetIsEventActionPossible, FALSE)
        return
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        act(SetIsEventActionPossible, FALSE)
        return
    end
    if HalfBlendLowerCommonFunction(Event_EventHalfBlend360070, lower_state, FALSE) == TRUE then
        act(SetIsEventActionPossible, FALSE)
        return
    end
end

function EventHalfBlend360070_Upper_onDeactivate()
    act(SetIsEventActionPossible, FALSE)
end

function Event60080_onActivate()
    ResetEventState()
end

function Event60080_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60090_onActivate()
    ResetEventState()
end

function Event60090_onUpdate()
    act(SetIsEventActionPossible, TRUE)
    if EventCommonFunction() == TRUE then
        act(SetIsEventActionPossible, FALSE)
        return
    end
end

function Event60090_onDeactivate()
    act(SetIsEventActionPossible, FALSE)
end

function Event60100_onActivate()
    ResetEventState()
end

function Event60100_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60110_onActivate()
    ResetEventState()
end

function Event60110_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60120_onActivate()
    ResetEventState()
end

function Event60120_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60130_onActivate()
    ResetEventState()
end

function Event60130_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60131_onActivate()
    ResetEventState()
end

function Event60131_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60160_onActivate()
    ResetEventState()
end

function Event60160_onUpdate()
    act(SetIsEventActionPossible, TRUE)
    if EventCommonFunction() == TRUE then
        act(SetIsEventActionPossible, FALSE)
        return
    end
end

function Event60160_onDeactivate()
    act(SetIsEventActionPossible, FALSE)
end

function Event60170_onActivate()
    ResetEventState()
end

function Event60170_onUpdate()
    act(SetIsEventActionPossible, TRUE)
    if EventCommonFunction() == TRUE then
        act(SetIsEventActionPossible, FALSE)
        return
    end
end

function Event60170_onDeactivate()
    act(SetIsEventActionPossible, FALSE)
end

function Event60180_onActivate()
    ResetEventState()
end

function Event60180_onUpdate()
    act(SetIsEventActionPossible, TRUE)
    if EventCommonFunction() == TRUE then
        act(SetIsEventActionPossible, FALSE)
        return
    end
end

function Event60180_onDeactivate()
    act(SetIsEventActionPossible, FALSE)
end

function Event60190_onActivate()
    ResetEventState()
end

function Event60190_onUpdate()
    act(SetIsEventActionPossible, TRUE)
    if EventCommonFunction() == TRUE then
        act(SetIsEventActionPossible, FALSE)
        return
    end
end

function Event60190_onDeactivate()
    act(SetIsEventActionPossible, FALSE)
end

function Event60200_onActivate()
    ResetEventState()
end

function Event60200_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60201_onActivate()
    ResetEventState()
end

function Event60201_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60202_onActivate()
    ResetEventState()
end

function Event60202_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60210_onActivate()
    ResetEventState()
end

function Event60210_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60220_onActivate()
    ResetEventState()
end

function Event60220_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60230_onActivate()
    ResetEventState()
end

function Event60230_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60231_onActivate()
    ResetEventState()
end

function Event60231_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60240_onActivate()
    ResetEventState()
end

function Event60240_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60241_onActivate()
    ResetEventState()
end

function Event60241_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60250_onActivate()
    ResetEventState()
end

function Event60250_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60260_onActivate()
    ResetEventState()
end

function Event60260_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60265_onActivate()
    ResetEventState()
end

function Event60265_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60270_onActivate()
    ResetEventState()
end

function Event60270_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60370_onActivate()
    ResetEventState()
end

function Event60370_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60380_onActivate()
    ResetEventState()
end

function Event60380_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60390_onActivate()
    ResetEventState()
end

function Event60390_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60400_onActivate()
    ResetEventState()
end

function Event60400_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60450_onActivate()
    ResetEventState()
end

function Event60450_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60451_onActivate()
    ResetEventState()
end

function Event60451_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60455_onActivate()
    ResetEventState()
end

function Event60455_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60456_onActivate()
    ResetEventState()
end

function Event60455_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60460_onActivate()
    ResetEventState()
end

function Event60460_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60470_onActivate()
    ResetEventState()
end

function Event60470_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60471_onActivate()
    ResetEventState()
end

function Event60471_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60472_onActivate()
    ResetEventState()
end

function Event60472_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60473_onActivate()
    ResetEventState()
end

function Event60473_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60480_onActivate()
    ResetEventState()
end

function Event60480_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60481_onActivate()
    ResetEventState()
end

function Event60481_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60482_onActivate()
    ResetEventState()
end

function Event60482_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60490_onActivate()
    ResetEventState()
end

function Event60490_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60500_onActivate()
    ResetEventState()
end

function Event60500_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60501_onActivate()
    ResetEventState()
end

function Event60501_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60502_onActivate()
    ResetEventState()
end

function Event60502_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60503_onActivate()
    ResetEventState()
end

function Event60503_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60504_onActivate()
    ResetEventState()
end

function Event60504_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60505_onActivate()
    ResetEventState()
end

function Event60505_onUpdate()
    if env(IsAnimEnd, 1) == TRUE then
        act(ChangeBuddyState)
    end
end

function Event60505_onDeactivate()
    act(ChangeBuddyState)
end

function Event60520_onActivate()
    ResetEventState()
end

function Event60520_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60521_onActivate()
    ResetEventState()
end

function Event60521_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60522_onActivate()
    ResetEventState()
end

function Event60522_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60523_onActivate()
    ResetEventState()
end

function Event60523_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60524_onActivate()
    ResetEventState()
end

function Event60524_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60525_onActivate()
    ResetEventState()
end

function Event60525_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60530_onActivate()
    ResetEventState()
end

function Event60530_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60550_onActivate()
    ResetEventState()
end

function Event60550_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60560_onActivate()
    ResetEventState()
end

function Event60560_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60750_onActivate()
    ResetEventState()
end

function Event60750_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60760_onActivate()
    ResetEventState()
end

function Event60760_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60780_onActivate()
    ResetEventState()
end

function Event60780_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60790_onActivate()
    ResetEventState()
end

function Event60790_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60800_onActivate()
    ResetEventState()
end

function Event60800_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60810_onActivate()
    ResetEventState()
end

function Event60810_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event60811_onActivate()
    ResetEventState()
end

function Event60811_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event63000_onActivate()
    ResetEventState()
end

function Event63000_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event63010_onActivate()
    ResetEventState()
end

function Event63010_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event63020_onActivate()
    ResetEventState()
end

function Event63020_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event63021_onActivate()
    ResetEventState()
end

function Event63040_onActivate()
    ResetEventState()
end

function Event63040_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event63050_onActivate()
    ResetEventState()
end

function Event63050_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event63060_onActivate()
    ResetEventState()
end

function Event63060_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event63061_onActivate()
    ResetEventState()
end

function Event63061_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event63070_onActivate()
    ResetEventState()
end

function Event63070_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event63080_onActivate()
    ResetEventState()
end

function Event63080_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event63090_onActivate()
    ResetEventState()
end

function Event63090_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event65012_onActivate()
    ResetEventState()
end

function Event65012_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event65013_onActivate()
    ResetEventState()
end

function Event65013_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event67000_onActivate()
    ResetEventState()
end

function Event67000_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event67001_onActivate()
    ResetEventState()
end

function Event67001_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event67010_onActivate()
    ResetEventState()
end

function Event67010_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event67011_onActivate()
    ResetEventState()
end

function Event67011_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event67020_onActivate()
    ResetEventState()
end

function Event67020_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event67030_onActivate()
    ResetEventState()
end

function Event67030_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event67040_onActivate()
    ResetEventState()
end

function Event67040_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event67050_onActivate()
    ResetEventState()
end

function Event67050_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event67060_onActivate()
    ResetEventState()
end

function Event67060_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event67070_onActivate()
    ResetEventState()
end

function Event67070_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event67080_onActivate()
    ResetEventState()
end

function Event67080_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event67090_onActivate()
    ResetEventState()
end

function Event67090_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event67080_onActivate()
    ResetEventState()
end

function Event67080_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event67100_onActivate()
    ResetEventState()
end

function Event67100_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event68043_onActivate()
    ResetEventState()
end

function Event68043_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event68110_onActivate()
    ResetEventState()
end

function Event68110_onUpdate()
    if env(IsAnimEnd, 1) == TRUE then
        ExecEvent("W_BonfireLevelUpLoop")
        return
    end
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event69000_onActivate()
    ResetEventState()
end

function Event69000_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event69001_onActivate()
    ResetEventState()
end

function Event69001_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event69002_onActivate()
    ResetEventState()
end

function Event69002_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event69003_onActivate()
    ResetEventState()
end

function Event69003_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event69010_onActivate()
    ResetEventState()
end

function Event69010_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event69030_onActivate()
    ResetEventState()
end

function Event69030_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event6000_onActivate()
    ResetEventState()
end

function Event6000_onUpdate()
    act(SetIsEventActionPossible, TRUE)
    if EventCommonFunction() == TRUE then
        act(SetIsEventActionPossible, FALSE)
        return
    end
end

function Event6000_onDeactivate()
    act(SetIsEventActionPossible, FALSE)
end

function Event6001_onActivate()
    ResetEventState()
end

function Event6001_onUpdate()
    if env(GetSpEffectID, 10665) == TRUE then
        act(SetIsEventActionPossible, FALSE)
    else
        act(SetIsEventActionPossible, TRUE)
    end
    if EventCommonFunction() == TRUE then
        act(SetIsEventActionPossible, FALSE)
        return
    end
end

function Event6001_onDeactivate()
    act(SetIsEventActionPossible, FALSE)
end

function Event6002_onActivate()
    ResetEventState()
end

function Event6002_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event17140_onActivate()
    ResetEventState()
end

function Event18140_onActivate()
    ResetEventState()
end

function Event18140_onUpdate()
    act(SetDeathStay, TRUE)
end

function Event18140_onDeactivate()
    act(SetDeathStay, FALSE)
end

function Event99999_onActivate()
    ResetEventState()
end

function Event99999_onUpdate()
    if EventCommonFunction() == TRUE then
        return
    end
end

function Event150250_onActivate()
    ResetEventState()
end

function Event150250_onUpdate()
    act(SetIsEventActionPossible, TRUE)
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        act(SetIsEventActionPossible, FALSE)
        return
    end
    local lower_only = TRUE
    local enable_turn = FALSE
    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end
    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        act(SetIsEventActionPossible, FALSE)
        return
    end
end

function Event150250_onDeactivate()
    act(SetIsEventActionPossible, FALSE)
end

function Event160070_onActivate()
    ResetEventState()
end

function Event160070_onUpdate()
    act(SetIsEventActionPossible, TRUE)
    if RideCommonFunction("W_RideAttack_R_Top", "W_RideAttack_R_Hard1_Start", "W_RideAttack_L_Top",
        "W_RideAttack_L_Hard1_Start") == TRUE then
        act(SetIsEventActionPossible, FALSE)
        return
    end
    local lower_only = TRUE
    local enable_turn = FALSE
    if env(MovementRequest) == TRUE or env(IsAnimEnd, 0) == TRUE then
        lower_only = FALSE
        enable_turn = TRUE
    end
    if RideRequestFunction(RIDE_MOVE_TYPE_OTHER, enable_turn, lower_only) == TRUE then
        act(SetIsEventActionPossible, FALSE)
        return
    end
end

function Event160070_onDeactivate()
    act(SetIsEventActionPossible, FALSE)
end

function Event360070_onActivate()
    ResetEventState()
end

function Event360070_onUpdate()
    act(SetIsEventActionPossible, TRUE)
    if env(IsAnimEnd, 0) == TRUE then
        ExecEventAllBody("W_Stealth_Idle")
        act(SetIsEventActionPossible, FALSE)
        return
    end
    if EventCommonFunction() == TRUE then
        act(SetIsEventActionPossible, FALSE)
        return
    end
end

function Event360070_onDeactivate()
    act(SetIsEventActionPossible, FALSE)
end
