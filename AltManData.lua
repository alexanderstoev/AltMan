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
    
    character = AltMan:GetDataGroupValues(character, AltMan.altData);
    character = AltMan:GetDataGroupValues(character, AltMan.altActivities.daily);
    character = AltMan:GetDataGroupValues(character, AltMan.altActivities.weekly);
    
    return character
end;


function AltMan:GetDataGroupValues(character, dataGroup)
    for _, dataGroupEntry in pairs(dataGroup) do
        -- first check if we have a data source for the entry
        if (not (AltMan.DataSources[dataGroupEntry] == nil)) then
            character[dataGroupEntry] = AltMan.DataSources[dataGroupEntry]()
        end
    end
    return character;
end


function AltMan:LoadAlts(alts)
    AltMan.Alts = alts;
    AltMan.TotalAlts = sizeOfTable(alts);
end

