local _, AltMan = ...;

if (AltMan.DataSources == nil) then AltMan.DataSources = {} end

AltMan.DataSources.worldquests = function()
    return AltMan.translations["en"]["worldquestsreminder"];
end
