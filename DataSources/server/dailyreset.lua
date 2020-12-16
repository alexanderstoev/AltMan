local _, AltMan = ...;

AltMan.DataSources = AltMan.DataSources or {}

function AltMan.DataSources.dailyreset()

    -- calculate the sring value
    local _secToDaily = C_DateAndTime.GetSecondsUntilDailyReset();
    return AltMan.translations["en"]["maininfo"]["dailyreset"]["in"] .. " " .. GetRemainingTime(_secToDaily)

end
