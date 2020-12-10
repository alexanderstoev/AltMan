local _, AltMan = ...;

-- used to store references to frames
AltMan.UI = AltMan.UI or {}


----------------------------------------------------------------------------
-- Displays the main frame of the addon
----------------------------------------------------------------------------
function AltMan.UI:InitMainFrame()

    AltMan.frame:Hide(); -- we need to hide the frame since this method is called on load
    AltMan.frame:SetFrameStrata("MEDIUM");
    AltMan.frame:SetWidth(AltMan.UI:GetFrameWidth()); -- Set these to whatever height/width is needed 
    AltMan.frame:EnableMouse(true)
    AltMan.frame:SetMovable(true)
    AltMan.frame:SetPoint("CENTER",0,0);
    
    AltMan.UI:DrawHeader();
    
    AltMan.UI:SetBackground(AltMan.frame)
    print("done", AltMan.frame:GetHeight())
end


----------------------------------------------------------------------------
-- Draws the header of the main frame
----------------------------------------------------------------------------
function AltMan.UI:DrawHeader()
    AltMan.frame.header = CreateFrame("frame", "", AltMan.frame);
	AltMan.frame.header:SetFrameStrata("MEDIUM");
	AltMan.frame.header:SetPoint("TOPLEFT", 0, 0);
    
    local newFrameHeight = AltMan.constants.presentation.header.height
    AltMan.frame.header:SetHeight(newFrameHeight);
    AltMan.frame.header:SetWidth(AltMan.UI:GetFrameWidth());

    -- update the main frame height
    AltMan.UI:IncreaseMainFrameHeight(newFrameHeight);

    AltMan.UI:SetBackground(AltMan.frame.header)
    
    AltMan.frame.header.title = AltMan.frame.header:CreateFontString(nil, nil, "GameFontNormalLarge");
    AltMan.frame.header.title:SetPoint("TOPLEFT", 7, -7);
    AltMan.frame.header.title:SetText("AltMan")
    
    AltMan.UI:DrawCloseButton();
end


----------------------------------------------------------------------------
-- calculates the main frame width based on 
-- the number of alts + 1 (because of the labels column)
-- the width for a column
----------------------------------------------------------------------------
function AltMan.UI:GetFrameWidth()
    return (AltMan.TotalAlts ) * AltMan.constants.presentation.table.cellwidth + AltMan.constants.presentation.labelsFrameWidth;
end


----------------------------------------------------------------------------
-- Draws the close button
----------------------------------------------------------------------------
function AltMan.UI:DrawCloseButton()
    AltMan.frame.header.closeButton = CreateFrame("Button", "CloseButton", AltMan.frame.header, "UIPanelCloseButton");
    AltMan.frame.header.closeButton:ClearAllPoints();
    AltMan.frame.header.closeButton:SetFrameStrata("HIGH");
    AltMan.frame.header.closeButton:SetPoint("TOPRIGHT", 0, 0);
    AltMan.frame.header.closeButton:SetScript("OnClick", function() AltMan:Hide(); end);
end


----------------------------------------------------------------------------
-- Shows the main frame of the addon
----------------------------------------------------------------------------
function AltMan.UI:ShowFrame()
    AltMan.frame:Show();
end


----------------------------------------------------------------------------
-- Hides the main frame of the addon
----------------------------------------------------------------------------
function AltMan.UI:HideFrame()
    AltMan.frame:Hide();
end
