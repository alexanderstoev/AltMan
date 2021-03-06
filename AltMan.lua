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
main_frame:RegisterEvent("PLAYER_LOGOUT");
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
    elseif event == "PLAYER_LOGOUT" or event == "PLAYER_LEAVING_WORLD" then
        AltMan.DB:Store();
    end
end

----------------------------------------------------------------------------
-- Displays the main frame of the addon
----------------------------------------------------------------------------
function AltMan:OnLoad()

    AltMan.currentAltGUID = UnitGUID('player');

    AltMan.DB:Init();

    -- refresh the current character data
    AltMan.Data:PrepareData();

    AltMan.UI:InitMainFrame();

    -- create the basic layout and put labels
    AltMan.UI:DrawInfoSection("server-data", AltMan.Data.dataSourcesTypes["server-data"]);
    AltMan.UI:DrawInfoSection("alt-data-core", AltMan.Data.dataSourcesTypes["alt-data"]["core"]);
    AltMan.UI:DrawInfoSection("alt-data-daily", AltMan.Data.dataSourcesTypes["alt-data"]["daily"]);
    AltMan.UI:DrawInfoSection("alt-data-weekly", AltMan.Data.dataSourcesTypes["alt-data"]["weekly"]);
    AltMan.UI:AddAltsBackground();

    -- fill in data
    AltMan.UI:DrawInfoSubSection("server-data", "data", AltMan.Data:GetData("server-data"));

    local index = 0;
    for altKey, alt in Spairs(AltMan.Data.data["alt-data"], CompareAlts) do
        AltMan.UI:DrawInfoSubSection("alt-data-core", altKey, alt["core"], index);
        AltMan.UI:DrawInfoSubSection("alt-data-daily", altKey, alt["daily"], index);
        AltMan.UI:DrawInfoSubSection("alt-data-weekly", altKey, alt["weekly"], index);
        index = index + 1;
    end

    AltMan.UI:IncreaseMainFrameHeight(AltMan.constants.presentation.frame.paddingVertical);
end

----------------------------------------------------------------------------
-- Displays the main frame of the addon
----------------------------------------------------------------------------
function AltMan:Show(showResetControls)

    if (shown == true) then
        return
    end

    -- refresh the current character data
    AltMan.Data:RefreshCurrentAltData()

    -- fill in data
    AltMan.UI:RefreshData("server-data", "data", AltMan.Data:GetData("server-data"));

    for altKey, alt in Spairs(AltMan.Data.data["alt-data"], CompareAlts) do
        AltMan.UI:RefreshData("alt-data-core", altKey, alt["core"]);
        AltMan.UI:RefreshData("alt-data-daily", altKey, alt["daily"]);
        AltMan.UI:RefreshData("alt-data-weekly", altKey, alt["weekly"]);
    end

    AltMan.UI:updateHeights();

    AltMan.UI:ShowFrame();

    shown = true;

end

----------------------------------------------------------------------------
-- Clears all data for alts
----------------------------------------------------------------------------
function AltMan:ClearData()

    AltMan.Data.data["alt-data"] = {}
    AltManDB = {};
    AltMan.Data:RefreshCurrentAltData()
    ReloadUI();
end

----------------------------------------------------------------------------
-- Hides the main frame of the addon
----------------------------------------------------------------------------
function AltMan:Hide()
    AltMan.UI:HideFrame();
    shown = false;
end

---------------------------------------------------------------------------
-- Displays the main frame of the addon
----------------------------------------------------------------------------
SLASH_ALTMAN1 = "/zam";
SLASH_ALTMAN2 = "/alts";

SlashCmdList["ALTMAN"] = function(args)
    if (string.len(args) > 0) then
        if (args == "reset") then
            AltMan.UI:CreateRemoveButton();
            AltMan:Show();
        else
            print("AltMan help: No help so far. Arg = " .. args)
        end
    else
        AltMan:Show();
    end
end;
