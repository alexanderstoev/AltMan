local _, AltMan = ...;

if (AltMan.DataSources== nil) then
    AltMan.DataSources = {}
end

AltMan.DataSources.mythicplus = function () 
    return C_MythicPlus.GetWeeklyChestRewardLevel()
end
