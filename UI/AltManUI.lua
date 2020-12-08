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
    self.frame:Hide(); -- we need to hide the frame since this method is called on load

    self.frame:SetFrameStrata("MEDIUM");
    
    self.frame:SetWidth(self:GetFrameWidth()); -- Set these to whatever height/width is needed 
    self.frame:SetHeight(AltMan.constants.presentation.frame.height); -- for your Texture
    
    self.frame:EnableMouse(true)
    self.frame:SetMovable(true)
    
    self.frame.background = self.frame:CreateTexture(nil, "BACKGROUND");
	self.frame.background:SetAllPoints();
	self.frame.background:SetDrawLayer("ARTWORK", 1);
	self.frame.background:SetColorTexture(0, 0, 0, AltMan.constants.presentation.frame.alpha);
    
    self.frame:SetPoint("CENTER",0,0);
    
    self:DrawHeader();
end


----------------------------------------------------------------------------
-- Shows the main frame of the addon
----------------------------------------------------------------------------
function AltMan:ShowFrame()
    self.frame:Show();
end


----------------------------------------------------------------------------
-- Hides the main frame of the addon
----------------------------------------------------------------------------
function AltMan:HideFrame()
    self.frame:Hide();
end


----------------------------------------------------------------------------
-- Draws the header of the main frame
----------------------------------------------------------------------------
function AltMan:DrawHeader()
    self.frame.header = CreateFrame("frame", "", self.frame);
	self.frame.header:SetFrameStrata("MEDIUM");
	self.frame.header:SetPoint("TOPLEFT", 0, 0);
    
    self.frame.header:SetWidth(self:GetFrameWidth());
    self.frame.header:SetHeight(AltMan.constants.presentation.header.height);
    
    self.frame.header.background = self.frame.header:CreateTexture(nil, "BACKGROUND");
	self.frame.header.background:SetAllPoints();
	self.frame.header.background:SetDrawLayer("ARTWORK", 1);
	self.frame.header.background:SetColorTexture(0, 0, 0, AltMan.constants.presentation.frame.alpha);
    
    self.frame.header.title = self.frame.header:CreateFontString(nil, nil, "GameFontNormalLarge");
    self.frame.header.title:SetPoint("TOPLEFT", 7, -7);
    self.frame.header.title:SetText("AltMan")
    
    self:DrawCloseButton();
end


----------------------------------------------------------------------------
-- Draws the close button
----------------------------------------------------------------------------
function AltMan:DrawCloseButton()
    self.frame.header.closeButton = CreateFrame("Button", "CloseButton", self.frame.header, "UIPanelCloseButton");
	self.frame.header.closeButton:ClearAllPoints();
	self.frame.header.closeButton:SetFrameStrata("HIGH");
	self.frame.header.closeButton:SetPoint("TOPRIGHT", 0, 0);
	self.frame.header.closeButton:SetScript("OnClick", function() self:Hide(); end);
    
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
-- Renders frames for each alt 
----------------------------------------------------------------------------
function AltMan:DrawBackgroundFrames()
  
    local numberOfAlts = 0;
    for currentAltKey, currentAlt in pairs(AltMan.Alts) do

        numberOfAlts = numberOfAlts + 1;

        self.Frames.alts[currentAltKey] = CreateFrame("frame", "", self.frame);
        self.Frames.alts[currentAltKey]:SetWidth(AltMan.constants.presentation.table.cellwidth);
        self.Frames.alts[currentAltKey]:SetHeight(AltMan.constants.presentation.frame.height);
        self.Frames.alts[currentAltKey]:SetFrameStrata("MEDIUM");
        self.Frames.alts[currentAltKey]:SetPoint("TOPLEFT", AltMan.constants.presentation.table.cellwidth * (numberOfAlts), 0);

        if (math.fmod(numberOfAlts, 2) == 1) then
            self.Frames.alts[currentAltKey].background = self.Frames.alts[currentAltKey]:CreateTexture(nil, "BACKGROUND");
            self.Frames.alts[currentAltKey].background:SetAllPoints();
            self.Frames.alts[currentAltKey].background:SetDrawLayer("ARTWORK", 1);
            self.Frames.alts[currentAltKey].background:SetColorTexture(0, 0, 0, 0.7);   
        end
        
    end
end


----------------------------------------------------------------------------
-- Prepares and prints all data 
----------------------------------------------------------------------------
function AltMan:PrintData()
    
    -- print labels column
    self:RenderColumn(AltMan.translations["en"]["labels"], self.frame, false, "labels");
    
    -- fillin the labels. They won't change
    for _, dataKey in pairs(AltMan.altData) do
        AltMan.Texts.alts["labels"][dataKey]:SetText(AltMan.translations["en"]["labels"][dataKey]);
    end
    for _, dataKey in pairs(AltMan.altActivities.daily) do
        AltMan.Texts.alts["labels"][dataKey]:SetText(AltMan.translations["en"]["labels"][dataKey]);
    end
    for _, dataKey in pairs(AltMan.altActivities.weekly) do
        AltMan.Texts.alts["labels"][dataKey]:SetText(AltMan.translations["en"]["labels"][dataKey]);
    end

    -- print the alts columns
    for currentAltKey, currentAlt in pairs(AltMan.Alts) do
        -- print("currentAltKey", currentAltKey)
        self:RenderColumn(currentAlt, self.Frames.alts[currentAltKey], true, currentAltKey);
    end

end


----------------------------------------------------------------------------
-- Prints a colum
-- A labels colum or an alt colummn
----------------------------------------------------------------------------
function AltMan:RenderColumn(dataObj, parent, isAltColumn, currentAltKey)
    local row = 0;
    row = self:RenderColumnSection(AltMan.altData, row, dataObj, parent, isAltColumn, currentAltKey);
    row = row + 1;
    row = self:RenderColumnSection(AltMan.altActivities.daily, row, dataObj, parent, isAltColumn, currentAltKey);
    row = row + 1;
    row = self:RenderColumnSection(AltMan.altActivities.weekly, row, dataObj, parent, isAltColumn, currentAltKey);
end


----------------------------------------------------------------------------
-- Creates texts for a column section
-- sections: core data, daily and weekly activities
----------------------------------------------------------------------------
function AltMan:RenderColumnSection(section, row, dataObj, parent, isAltColumn, currentAltKey)
    
    local currentRow = row;
    local rowHeight = AltMan.constants.presentation.table.cellheight;
    
    for _, altDataKey in pairs(section) do

        if (AltMan.Texts.alts[currentAltKey] == nil) then
            AltMan.Texts.alts[currentAltKey] = {}
        end
        
        AltMan.Texts.alts[currentAltKey][altDataKey] = parent:CreateFontString(nil, nil, "GameFontNormalSmall");
        AltMan.Texts.alts[currentAltKey][altDataKey]:SetPoint("TOPLEFT", AltMan.constants.presentation.frame.paddingHorizontal + 0, - AltMan.constants.presentation.frame.paddingVertical - currentRow * rowHeight);
        if (currentRow == 0 and isAltColumn) then
            local altClass = dataObj['class'];
            altClass = string.gsub(altClass, "%s+", ""); -- remove spaces e.g. Demon hunter -> Demonhunter
            altClass = string.upper(altClass); -- transform to uppercase e.g. Demonhunter -> DEMONHUNTER

            AltMan.Texts.alts[currentAltKey][altDataKey]:SetTextColor(
                RAID_CLASS_COLORS[altClass].r,
                RAID_CLASS_COLORS[altClass].g,
                RAID_CLASS_COLORS[altClass].b,
                RAID_CLASS_COLORS[altClass].a   
            );
            AltMan.Texts.alts[currentAltKey][altDataKey]:SetFont("Fonts\\FRIZQT__.TTF", 15);
        end

        AltMan.Texts.alts[currentAltKey][altDataKey]:SetJustifyH("LEFT");
        currentRow = currentRow + 1;
    end

    return currentRow;
end


----------------------------------------------------------------------------
-- Updates texts for a column section
-- sections: core data, daily and weekly activities
----------------------------------------------------------------------------
function AltMan:PrintAltsData()
    
    for currentAltKey, currentAlt in pairs(AltMan.Alts) do
        for _, dataKey in pairs(AltMan.altData) do
            AltMan.Texts.alts[currentAltKey][dataKey]:SetText(currentAlt[dataKey]);
        end
        for _, dataKey in pairs(AltMan.altActivities.daily) do
            AltMan.Texts.alts[currentAltKey][dataKey]:SetText(currentAlt[dataKey]);
        end
        for _, dataKey in pairs(AltMan.altActivities.weekly) do
            AltMan.Texts.alts[currentAltKey][dataKey]:SetText(currentAlt[dataKey]);
        end
    end

end
