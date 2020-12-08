local _, AltMan = ...;

-- used to store references to frames
AltMan.Frames = {}
AltMan.Frames.alts = {}
AltMan.Texts = {}
AltMan.Texts.alts = {}

----------------------------------------------------------------------------
-- Displays the main frame of the addon
----------------------------------------------------------------------------
function AltMan:InitFrame()

    AltMan.frame:Hide(); -- we need to hide the frame since this method is called on load

    AltMan.frame:SetFrameStrata("MEDIUM");
    
    AltMan.frame:SetWidth(AltMan:GetFrameWidth()); -- Set these to whatever height/width is needed 
    
    AltMan.frame:EnableMouse(true)
    AltMan.frame:SetMovable(true)
    
    
    AltMan.frame:SetPoint("CENTER",0,0);
    
    AltMan:DrawHeader();
    
    AltMan:IncreaseMainFrameHeight(AltMan.constants.presentation.frame.paddingVertical);
    AltMan:DrawMainInfo();
    
    AltMan:IncreaseMainFrameHeight(AltMan.constants.presentation.frame.paddingVertical);
    AltMan:DrawAltsInfo();
    
    AltMan:IncreaseMainFrameHeight(AltMan.constants.presentation.frame.paddingVertical);
    
    AltMan:SetBackground(AltMan.frame)
    print("done", AltMan.frame:GetHeight())
end


----------------------------------------------------------------------------
-- Draws the header of the main frame
----------------------------------------------------------------------------
function AltMan:DrawHeader()
    AltMan.frame.header = CreateFrame("frame", "", AltMan.frame);
	AltMan.frame.header:SetFrameStrata("MEDIUM");
	AltMan.frame.header:SetPoint("TOPLEFT", 0, 0);
    
    local newFrameHeight = AltMan.constants.presentation.header.height
    AltMan.frame.header:SetHeight(newFrameHeight);
    AltMan.frame.header:SetWidth(AltMan:GetFrameWidth());

    -- update the main frame height
    AltMan:IncreaseMainFrameHeight(newFrameHeight);

    AltMan:SetBackground(AltMan.frame.header)
    
    AltMan.frame.header.title = AltMan.frame.header:CreateFontString(nil, nil, "GameFontNormalLarge");
    AltMan.frame.header.title:SetPoint("TOPLEFT", 7, -7);
    AltMan.frame.header.title:SetText("AltMan")
    
    AltMan:DrawCloseButton();
end


----------------------------------------------------------------------------
-- Draws the main info section
----------------------------------------------------------------------------
function AltMan:DrawMainInfo()
    AltMan.frame.maininfo = CreateFrame("frame", "", AltMan.frame);
	AltMan.frame.maininfo:SetFrameStrata("MEDIUM");
    AltMan.frame.maininfo:SetPoint(
        "TOPLEFT", 
        AltMan.constants.presentation.frame.paddingHorizontal, 
        -AltMan.frame:GetHeight()
    );

    AltMan.frame.maininfo:SetWidth(AltMan:GetFrameWidth() - AltMan.constants.presentation.frame.paddingHorizontal*2);
    
    AltMan:addLine("weeklyreset", 0)
    AltMan:addLine("dailyreset", 1)

    local newFrameHeight = AltMan.constants.presentation.lineheight * 2 -- the two lines from above and 1 extra for padding
    AltMan.frame.maininfo:SetHeight(newFrameHeight);

    AltMan:SetBackground(AltMan.frame.maininfo, 1, 0.5, 0)

    -- update the main frame height
    AltMan:IncreaseMainFrameHeight(newFrameHeight);
    
end



----------------------------------------------------------------------------
-- Draws the alts info section
----------------------------------------------------------------------------
function AltMan:DrawAltsInfo()
    AltMan.frame.altsinfo = CreateFrame("frame", "", AltMan.frame);
	AltMan.frame.altsinfo:SetFrameStrata("MEDIUM");
    AltMan.frame.altsinfo:SetPoint(
        "TOPLEFT", 
        AltMan.constants.presentation.frame.paddingHorizontal, 
        -AltMan.frame:GetHeight()
    );
    AltMan.frame.altsinfo:SetWidth(AltMan:GetFrameWidth() - AltMan.constants.presentation.frame.paddingHorizontal*2);
        
    AltMan:DrawDailyActivities();
    AltMan:IncreaseFrameHeight(AltMan.frame.altsinfo, AltMan.constants.presentation.frame.paddingVertical);
    AltMan:DrawWeeklyActivities();

    -- update the main frame height
    AltMan:IncreaseMainFrameHeight(AltMan.frame.altsinfo:GetHeight());
    
    AltMan:SetBackground(AltMan.frame.altsinfo, 0.5, 0.5, 0)
end


function AltMan:DrawDailyActivities() 
    AltMan.frame.altsinfo.daily = CreateFrame("frame", "", AltMan.frame.altsinfo);
	AltMan.frame.altsinfo.daily:SetFrameStrata("MEDIUM");
    AltMan.frame.altsinfo.daily:SetPoint("TOPLEFT", 0, AltMan.frame.altsinfo:GetHeight());
    AltMan.frame.altsinfo.daily:SetWidth(AltMan:GetFrameWidth() - AltMan.constants.presentation.frame.paddingHorizontal*2);

    local newFrameHeight = 0
    AltMan:CreateNewString("daiilylabel", AltMan.frame.altsinfo.daily, 0, 0, true);
    AltMan.frame.altsinfo.daily["daiilylabel"]:SetText("Daily activities");
    newFrameHeight = newFrameHeight + AltMan.constants.presentation.lineheight;

    AltMan.frame.altsinfo.daily:SetHeight(newFrameHeight);
    AltMan:IncreaseFrameHeight(AltMan.frame.altsinfo, newFrameHeight);
    AltMan:SetBackground(AltMan.frame.altsinfo.daily, 0, 0.2, 0.2)

end

function AltMan:DrawWeeklyActivities() 
    AltMan.frame.altsinfo.weekly = CreateFrame("frame", "", AltMan.frame.altsinfo);
	AltMan.frame.altsinfo.weekly:SetFrameStrata("MEDIUM");
    AltMan.frame.altsinfo.weekly:SetPoint("TOPLEFT", 0, -AltMan.frame.altsinfo:GetHeight());
    AltMan.frame.altsinfo.weekly:SetWidth(AltMan:GetFrameWidth() - AltMan.constants.presentation.frame.paddingHorizontal*2);
    AltMan:SetBackground(AltMan.frame.altsinfo.weekly, 0.2, 0.2, 0)
    
    local newFrameHeight = 70;
    AltMan.frame.altsinfo.weekly:SetHeight(newFrameHeight);
    AltMan:IncreaseFrameHeight(AltMan.frame.altsinfo, newFrameHeight);
end


----------------------------------------------------------------------------
-- calculates the main frame width based on 
-- the number of alts + 1 (because of the labels column)
-- the width for a column
----------------------------------------------------------------------------
function AltMan:GetFrameWidth()
    return (AltMan.TotalAlts + 1) * AltMan.constants.presentation.table.cellwidth;
end


----------------------------------------------------------------------------
-- Shows the main frame of the addon
----------------------------------------------------------------------------
function AltMan:ShowFrame()
    AltMan.frame:Show();
end


----------------------------------------------------------------------------
-- Hides the main frame of the addon
----------------------------------------------------------------------------
function AltMan:HideFrame()
    AltMan.frame:Hide();
end



----------------------------------------------------------------------------
-- Draws the close button
----------------------------------------------------------------------------
function AltMan:DrawCloseButton()
    AltMan.frame.header.closeButton = CreateFrame("Button", "CloseButton", AltMan.frame.header, "UIPanelCloseButton");
	AltMan.frame.header.closeButton:ClearAllPoints();
	AltMan.frame.header.closeButton:SetFrameStrata("HIGH");
	AltMan.frame.header.closeButton:SetPoint("TOPRIGHT", 0, 0);
    AltMan.frame.header.closeButton:SetScript("OnClick", function() AltMan:Hide(); end);
end


----------------------------------------------------------------------------
-- calculates and prints a line in the main info frame
----------------------------------------------------------------------------
function AltMan:addLine(source, index)

    -- create the string frame
    AltMan:CreateNewString(source, AltMan.frame.maininfo, 0, -index*AltMan.constants.presentation.lineheight);

    -- calculate the sring value
    local dataString = AltMan.DataSources[source]()
    
    AltMan.frame.maininfo[source]:SetText(dataString);
end
