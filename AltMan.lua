local _, AltMan = ...;
_G["AltMan"] = AltMan;

local shown = false; -- used to track if we have the window shown
local ADDON_NAME = "AltMan";

local main_frame = CreateFrame("frame", "AltManFrame", UIParent);

main_frame:RegisterForDrag("LeftButton");
main_frame:SetMovable();
main_frame:SetScript("OnDragStart", main_frame.StartMoving)
main_frame:SetScript("OnDragStop", main_frame.StopMovingOrSizing)

main_frame:RegisterEvent("ADDON_LOADED");
main_frame:RegisterEvent("PLAYER_LEAVING_WORLD");
main_frame:SetScript("OnEvent", function(self, ...)
    local event, loaded = ...;
    if (loaded == ADDON_NAME) then
        AltMan:EventsDispatcher(event)
    end
end)
AltMan.frame = main_frame;

----------------------------------------------------------------------------
-- Dispatches the events to the proper handlers
----------------------------------------------------------------------------
function AltMan:EventsDispatcher(event)
    if event == "ADDON_LOADED" then
        self:OnLoad();
    end
end


----------------------------------------------------------------------------
-- Displays the main frame of the addon
----------------------------------------------------------------------------
function AltMan:OnLoad()

    AltMan.DB:Init();

    -- refresh the current character data
    AltMan.Data:PrepareData();

    AltMan.UI:InitMainFrame();
    AltMan.UI:DrawInfoSection("server-data", AltMan.Data:GetData("server-data"));
    AltMan.UI:DrawInfoSection("alt-data-core", AltMan.Data:GetData("alt-data-core"));
    AltMan.UI:DrawInfoSection("alt-data-daily", AltMan.Data:GetData("alt-data-daily"));
    AltMan.UI:DrawInfoSection("alt-data-weekly", AltMan.Data:GetData("alt-data-weekly"));

    AltMan.UI:IncreaseMainFrameHeight(AltMan.constants.presentation.frame.paddingVertical);
end


----------------------------------------------------------------------------
-- Displays the main frame of the addon
----------------------------------------------------------------------------
function AltMan:Show()
    if (shown == true) then
        return
    end

    -- refresh the current character data
    AltMan:RefreshCharacterData();

    AltMan.UI:ShowFrame();
    -- self:PrintAltsData()

    shown = true;

end


----------------------------------------------------------------------------
-- Hides the main frame of the addon
----------------------------------------------------------------------------
function AltMan:Hide()
    AltMan.UI:HideFrame();
    shown = false;
end


----------------------------------------------------------------------------
-- Recalculates the data for the current character
-- and store is in the AltManDB variable which is persisted
----------------------------------------------------------------------------
function AltMan:RefreshCharacterData()
    -- refresh the current character data
    AltManDB.alts[UnitGUID('player')] = self:GetCurrentCharacterData();
    -- AltMan:LoadAlts(AltManDB.alts);
end

---------------------------------------------------------------------------
-- Displays the main frame of the addon
----------------------------------------------------------------------------
SLASH_ALTMAN1 = "/zam";
SLASH_ALTMAN2 = "/alts";

SlashCmdList["ALTMAN"] = function (args)
    if(string.len(args) > 0) then
        print("AltMan help: No help so far. You've added " .. args)
    else
        AltMan:Show();
    end
end;
