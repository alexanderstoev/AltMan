local _, AltMan = ...;

AltMan.DataSources = AltMan.DataSources or {}

function AltMan.DataSources.dailyreset()

    -- calculate the sring value
    local _drString = AltMan.translations["en"]["maininfo"]["dailyreset"]["daily"];
    local _secToDaily = C_DateAndTime.GetSecondsUntilDailyReset();

    if (_secToDaily < AltMan.constants.secondsinhour) then
        _drString = _drString .. AltMan.translations["en"]["maininfo"]["dailyreset"]["lessthanhour"];
    else
        _drString = _drString .. AltMan.translations["en"]["maininfo"]["dailyreset"]["in"] ..
                        math.floor(0.5 + _secToDaily / AltMan.constants.secondsinhour) .. -- hacky way for rounding
                        AltMan.translations["en"]["maininfo"]["dailyreset"]["hours"]
    end

    return _drString;

end
