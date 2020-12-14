local _, AltMan = ...;

AltMan.DataSources = AltMan.DataSources or {}

function AltMan.DataSources.weeklyreset()

    -- calculate the sring value
    local _secToWeekly = C_DateAndTime.GetSecondsUntilWeeklyReset();
    if (_secToWeekly < AltMan.constants.secondsinday) then
        return AltMan.translations["en"]["maininfo"]["weeklyreset"]["today"];
    elseif (_secToWeekly < 2 * AltMan.constants.secondsinday) then
        return AltMan.translations["en"]["maininfo"]["weeklyreset"]["tomorrow"];
    else
        return AltMan.translations["en"]["maininfo"]["weeklyreset"]["in"] .. " " .. GetRemainingTime(_secToWeekly)
    end

end
