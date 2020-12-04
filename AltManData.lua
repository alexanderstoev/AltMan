local _, AltMan = ...;

AltMan.Alts = {};
AltMan.TotalAlts = 0;

AltMan.altData = {
    "name", "class", "level" -- general alt data
}
AltMan.altActivities = {}
AltMan.altActivities.daily = {
    "mawdailies", "worldquests", "covenantcalling" -- daily activities
}
AltMan.altActivities.weekly = {
    "mythicplus", "dungeonquests", "resquesouls", "animaquest", "soulash" -- weekly activities
}

function AltMan:GetCurrentCharacterData()
    local character = {}
    for _, altDataKey in pairs(AltMan.altData) do
        character[altDataKey] = AltMan.DataSources[altDataKey]()
    end
    return character
end;

function AltMan:LoadAlts(alts)
    AltMan.Alts = alts;
    AltMan.TotalAlts = sizeOfTable(alts);
end

