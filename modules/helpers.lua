function ExecEvent(state)
    ResetRequest()
    hkbFireEvent(state)
end

function ExecEventSync(state)
    ResetRequest()
    act(PlayEventSync, state)
end

function ExecEventNoReset(state)
    hkbFireEvent(state)
end

function ExecEventSyncNoReset(state)
    act(PlayEventSync, state)
end

function ExecEvents(...)
    local buff = {...}

    for i = 1, #buff, 1 do
        ExecEvent(buff[i])
    end
end

function ResetEventState()
    SetVariable("MoveSpeedLevelReal", 0)
    ResetRequest()
end

function SetVariable(name, value)
    act(SetHavokVariable, name, value)
end

function GetVariable(variable)
    return hkbGetVariable(variable)
end

function IsNodeActive(...)
    local buff = {...}

    for i = 1, #buff, 1 do
        if hkbIsNodeActive(buff[i]) then
            return TRUE
        end
    end
    return FALSE
end

function CheckActionRequest()
    return env(HasActionRequest)
end

function ResetRequest()
    act(ResetInputQueue)
end

function SetBaseCategory()
    SetVariable("IndexBaseCategory", GetBaseCategory())
end

function GetBaseCategory()
    -- Stay Anim is Weapon Motion Position ID
    local basecategoryid = 0
    local index = 0
    basecategoryid = env(GetStayAnimCategory)

    if basecategoryid == 0 then
        index = 0
    elseif basecategoryid == 2 or basecategoryid == 12 then
        index = 1
    elseif basecategoryid == 3 or basecategoryid == 13 then
        index = 2
    end
    return index
end

function GetDeltaTime()
    return env(ObtainedDT) / 1000
end

function CopyLocalMatrix(source, dest)
    local sourceMatrix = hkbGetBoneLocalSpace(source)
    hkbSetBoneLocalSpace(dest, sourceMatrix)
end

function CopyModelMatrix(source, dest)
    local sourceMatrix = hkbGetBoneModelSpace(source)
    hkbSetBoneModelSpace(dest, sourceMatrix)
end

function CalculateFootTarget2(source, YaxisOffset, dest)
    local sourceMatrix = hkbGetBoneModelSpace(dest)
    local sourcePosition = hkbGetBoneModelSpace(source):getTranslation()
    sourcePosition[1] = sourcePosition[1] + YaxisOffset
    sourceMatrix:setTranslation(sourcePosition)
    hkbSetBoneModelSpace(dest, sourceMatrix)
end

function Master_Layer_onGenerate()
    local offset = 0.8659999966621399
    CalculateFootTarget2("L_Foot", offset, "L_Foot_Target2")
    CopyModelMatrix("L_Foot", "L_Foot_Target")
    CalculateFootTarget2("R_Foot", offset, "R_Foot_Target2")
    CopyModelMatrix("R_Foot", "R_Foot_Target")
end

function ModifiersLayer_onGenerate()
    CopyLocalMatrix("Neck", "Collar")
end

function Contains(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return TRUE
        end
    end

    return FALSE
end
