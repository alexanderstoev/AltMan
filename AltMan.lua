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
-- Displays the main frame of the addon
----------------------------------------------------------------------------
function AltMan:OnLoad()
    

    if (AltManDB == nil) then
        AltManDB = {}
    end
    
    -- always reset the current addon version
    -- In the future this will be used for data migtation to newer versions
    AltManDB["version"] = "0.0.1";
    
    -- check if we have any data loaded
    if (AltManDB.alts == nil) then
        AltManDB.alts = {}
    end
    -- refresh the current character data
    AltMan:RefreshCharacterData();
    
    AltMan.UI:InitFrame();
    
end


----------------------------------------------------------------------------
-- Recalculates the data for the current character
-- and store is in the AltManDB variable which is persisted
----------------------------------------------------------------------------
function AltMan:RefreshCharacterData() 
    -- refresh the current character data
    AltManDB.alts[UnitGUID('player')] = self:GetCurrentCharacterData();
    AltMan:LoadAlts(AltManDB.alts);
end

---------------------------------------------------------------------------
-- Displays the main frame of the addon
----------------------------------------------------------------------------
SLASH_ALTMAN1 = "/zam";
SLASH_ALTMAN2 = "/alts";

SlashCmdList["ALTMAN"] = function (args) 
    if(string.len(args) > 0) then
        print("Alt Man help: No help so far. You've added " .. args)
    else
        AltMan:Show();
    end
end;
