local _, AltMan = ...;

AltMan.DataSources = AltMan.DataSources or {}

function AltMan.DataSources.weeklyreset()
    -- calculate the sring value
    local _wrString = AltMan.translations["en"]["maininfo"]["weeklyreset"]["weeklyreset"]
    local _secToWeeklyReset = C_DateAndTime.GetSecondsUntilWeeklyReset();

    if (_secToWeeklyReset < AltMan.constants.secondsinday) then
        _wrString = _wrString .. AltMan.translations["en"]["maininfo"]["weeklyreset"]["today"];
    else
        _wrString = _wrString .. AltMan.translations["en"]["maininfo"]["weeklyreset"]["in"] .. 
            math.floor(_secToWeeklyReset/AltMan.constants.secondsinday) .. 
            AltMan.translations["en"]["maininfo"]["weeklyreset"]["days"]
    end

    return _wrString;

end