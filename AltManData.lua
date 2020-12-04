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
    "dungeonquests", "resquesouls", "animaquest", "soulash" -- weekly activities
}


function AltMan:LoadAlts()
    AltMan.Alts = {};
    table.insert(AltMan.Alts, {
        ["name"] = "Babamara",
        ["class"] = "MAGE",
        ["level"] = 51,
        ["soulash"] = 250
    });
    table.insert(AltMan.Alts, {
        ["name"] = "Stormfel",
        ["class"] = "DEMONHUNTER",
        ["level"] = 60,
        ["soulash"] = 850
    });
    table.insert(AltMan.Alts, {
        ["name"] = "Leliamara",
        ["class"] = "DEMONHUNTER",
        ["level"] = 58,
        ["soulash"] = 80
    });
    AltMan.TotalAlts = table.getn(AltMan.Alts);
end