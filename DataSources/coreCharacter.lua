local _, AltMan = ...;

if (AltMan.DataSources== nil) then
    AltMan.DataSources = {}
end    

AltMan.DataSources.name = function () 
    return UnitName("player");
end

AltMan.DataSources.class = function () 
    return UnitClass("player");
end

AltMan.DataSources.level = function () 
    return UnitLevel("player");
end
