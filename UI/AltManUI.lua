local _, AltMan = ...;

-- used to store references to frames
AltMan.UI = AltMan.UI or {}
AltMan.Frames = {}
AltMan.Frames.alts = {}
AltMan.Texts = {}
AltMan.Texts.alts = {}


----------------------------------------------------------------------------
-- Draws the main info section
----------------------------------------------------------------------------
function AltMan.UI:DrawInfo(data)
    
    AltMan.UI:IncreaseMainFrameHeight(AltMan.constants.presentation.frame.paddingVertical);

    AltMan.frame.maininfo = CreateFrame("frame", "", AltMan.frame);
	AltMan.frame.maininfo:SetFrameStrata("MEDIUM");
    AltMan.frame.maininfo:SetPoint(
        "TOPLEFT", 
        AltMan.constants.presentation.frame.paddingHorizontal, 
        -AltMan.frame:GetHeight()
    );

    AltMan.frame.maininfo:SetWidth(AltMan.UI:GetFrameWidth() - AltMan.constants.presentation.frame.paddingHorizontal*2);
    
    local index = 0;
    for k,v in pairs(data) do
        -- create the string frame
        AltMan.UI:CreateNewString(k, AltMan.frame.maininfo, 0, -index*AltMan.constants.presentation.lineheight);
        index = index + 1
    end

    local newFrameHeight = AltMan.constants.presentation.lineheight * (index)
    AltMan.frame.maininfo:SetHeight(newFrameHeight);

    -- AltMan.UI:SetBackground(AltMan.frame.maininfo, 1, 0.5, 0)

    -- update the main frame height
    AltMan.UI:IncreaseMainFrameHeight(newFrameHeight);
    
end

function AltMan.UI:PrintMainInfo(data)
    for k,v in pairs(data) do
        AltMan.frame.maininfo[k]:SetText(v);
    end
end


function AltMan.UI:InitAltSection() 
    AltMan.UI:IncreaseMainFrameHeight(AltMan.constants.presentation.frame.paddingVertical);

    AltMan.frame.altsSection = CreateFrame("frame", "", AltMan.frame);
	AltMan.frame.altsSection:SetFrameStrata("MEDIUM");
    AltMan.frame.altsSection:SetPoint(
        "TOPLEFT", 
        AltMan.constants.presentation.frame.paddingHorizontal, 
        -AltMan.frame:GetHeight()
    );
    AltMan.frame.altsSection:SetWidth(AltMan.UI:GetFrameWidth() - AltMan.constants.presentation.frame.paddingHorizontal*2);
end

function AltMan.UI:DrawAltInfo(type, data) 
    
end

----------------------------------------------------------------------------
-- Draws the alts info section
----------------------------------------------------------------------------
function AltMan.UI:DrawAltsInfo()

    AltMan.UI:IncreaseMainFrameHeight(AltMan.constants.presentation.frame.paddingVertical);

    AltMan.frame.altsinfo = CreateFrame("frame", "", AltMan.frame);
	AltMan.frame.altsinfo:SetFrameStrata("MEDIUM");
    AltMan.frame.altsinfo:SetPoint(
        "TOPLEFT", 
        AltMan.constants.presentation.frame.paddingHorizontal, 
        -AltMan.frame:GetHeight()
    );
    AltMan.frame.altsinfo:SetWidth(AltMan.UI:GetFrameWidth() - AltMan.constants.presentation.frame.paddingHorizontal*2);
        
    AltMan.UI:DrawAltCoreData();
    AltMan.UI:IncreaseFrameHeight(AltMan.frame.altsinfo, AltMan.constants.presentation.frame.paddingVertical);
    AltMan.UI:DrawDailyActivities();
    AltMan.UI:IncreaseFrameHeight(AltMan.frame.altsinfo, AltMan.constants.presentation.frame.paddingVertical);
    AltMan.UI:DrawWeeklyActivities();

    -- update the main frame height
    AltMan.UI:IncreaseMainFrameHeight(AltMan.frame.altsinfo:GetHeight());
    
    -- AltMan.UI:SetBackground(AltMan.frame.altsinfo, 0.5, 0.5, 0)
end


function AltMan.UI:DrawAltCoreData() 
    AltMan.frame.altsinfo.core = CreateFrame("frame", "", AltMan.frame.altsinfo);
	AltMan.frame.altsinfo.core:SetFrameStrata("MEDIUM");
    AltMan.frame.altsinfo.core:SetPoint("TOPLEFT", 0, -AltMan.frame.altsinfo:GetHeight());
    AltMan.frame.altsinfo.core:SetWidth(AltMan.UI:GetFrameWidth() - AltMan.constants.presentation.frame.paddingHorizontal*2);
    
    local newFrameHeight = 0
    AltMan.UI:CreateNewString("daiilylabel", AltMan.frame.altsinfo.core, 0, 0, true);
    AltMan.frame.altsinfo.core["daiilylabel"]:SetText("Baba mara");
    newFrameHeight = newFrameHeight + AltMan.constants.presentation.lineheight;
    
    

    AltMan.frame.altsinfo.core:SetHeight(newFrameHeight);
    
    -- update the main frame height
    AltMan.UI:IncreaseFrameHeight(AltMan.frame.altsinfo, newFrameHeight);

    AltMan.UI:SetBackground(AltMan.frame.altsinfo.core, 0, 0.2, 0.2)

end


function AltMan.UI:DrawColumn(dataObjs)
end


function AltMan.UI:DrawDailyActivities() 
    AltMan.frame.altsinfo.daily = CreateFrame("frame", "", AltMan.frame.altsinfo);
	AltMan.frame.altsinfo.daily:SetFrameStrata("MEDIUM");
    AltMan.frame.altsinfo.daily:SetPoint("TOPLEFT", 0, -AltMan.frame.altsinfo:GetHeight());
    AltMan.frame.altsinfo.daily:SetWidth(AltMan.UI:GetFrameWidth() - AltMan.constants.presentation.frame.paddingHorizontal*2);

    local newFrameHeight = 0
    AltMan.UI:CreateNewString("daiilylabel", AltMan.frame.altsinfo.daily, 0, 0, true);
    AltMan.frame.altsinfo.daily["daiilylabel"]:SetText("Daily activities");
    newFrameHeight = newFrameHeight + AltMan.constants.presentation.lineheight;
    
    AltMan.frame.altsinfo.daily:SetHeight(newFrameHeight);
    AltMan.UI:IncreaseFrameHeight(AltMan.frame.altsinfo, newFrameHeight);
    -- AltMan.UI:SetBackground(AltMan.frame.altsinfo.daily, 0, 0.2, 0.2)
    
end

function AltMan.UI:DrawWeeklyActivities() 
    AltMan.frame.altsinfo.weekly = CreateFrame("frame", "", AltMan.frame.altsinfo);
	AltMan.frame.altsinfo.weekly:SetFrameStrata("MEDIUM");
    AltMan.frame.altsinfo.weekly:SetPoint("TOPLEFT", 0, -AltMan.frame.altsinfo:GetHeight());
    AltMan.frame.altsinfo.weekly:SetWidth(AltMan.UI:GetFrameWidth() - AltMan.constants.presentation.frame.paddingHorizontal*2);
    
    local newFrameHeight = 0;
    AltMan.UI:CreateNewString("weeklylabel", AltMan.frame.altsinfo.weekly, 0, 0, true);
    AltMan.frame.altsinfo.weekly["weeklylabel"]:SetText("Weekly activities");
    newFrameHeight = newFrameHeight + AltMan.constants.presentation.lineheight;
    
    AltMan.frame.altsinfo.weekly:SetHeight(newFrameHeight);
    AltMan.UI:IncreaseFrameHeight(AltMan.frame.altsinfo, newFrameHeight);
    -- AltMan.UI:SetBackground(AltMan.frame.altsinfo.weekly, 0.2, 0.2, 0)
end





----------------------------------------------------------------------------
-- calculates and prints a line in the main info frame
----------------------------------------------------------------------------
function AltMan.UI:addLine(source, index)

    -- create the string frame
    AltMan.UI:CreateNewString(source, AltMan.frame.maininfo, 0, -index*AltMan.constants.presentation.lineheight);

    -- calculate the sring value
    local dataString = AltMan.DataSources[source]()
    
    AltMan.frame.maininfo[source]:SetText(dataString);
end
