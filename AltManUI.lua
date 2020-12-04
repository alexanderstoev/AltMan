local _, AltMan = ...;

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
	self.frame.background:SetColorTexture(0, 0, 0, 0.7);
    
    self.frame:SetPoint("CENTER",0,0);
    
    self:DrawCloseButton();
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
-- Draws the close button
----------------------------------------------------------------------------
function AltMan:DrawCloseButton()
    self.frame.closeButton = CreateFrame("Button", "CloseButton", self.frame, "UIPanelCloseButton");
	self.frame.closeButton:ClearAllPoints();
	self.frame.closeButton:SetFrameStrata("HIGH");
	self.frame.closeButton:SetPoint("TOPRIGHT", 0, 0);
	self.frame.closeButton:SetScript("OnClick", function() self:Hide(); end);
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
-- Prepares and renders all data 
----------------------------------------------------------------------------
function AltMan:DrawContents()

    -- print labels column
    self:PrintColumn(AltMan.translations["en"]["labels"], self.frame, false);

    -- print alt data
    local numberOfAlts = 0;
    for currentAltKey, currentAlt in pairs(AltMan.Alts) do

        numberOfAlts = numberOfAlts + 1;

        local frame = CreateFrame("frame", "", self.frame);
        
        frame:SetFrameStrata("MEDIUM");
        
        frame:SetWidth(AltMan.constants.presentation.table.cellwidth);
        frame:SetHeight(AltMan.constants.presentation.frame.height);
        
        frame:SetPoint("TOPLEFT", AltMan.constants.presentation.table.cellwidth * (numberOfAlts), 0);
        if (math.fmod(numberOfAlts, 2) == 1) then
            frame.background = frame:CreateTexture(nil, "BACKGROUND");
            frame.background:SetAllPoints();
            frame.background:SetDrawLayer("ARTWORK", 1);
            frame.background:SetColorTexture(0, 0, 0, 0.7);   
        end
        self:PrintColumn(currentAlt, frame, true);
    end
end


----------------------------------------------------------------------------
-- Prints the data for a column section
-- sections: core data, daily and weekly activities
----------------------------------------------------------------------------
function AltMan:PrintColumnSection(section, row, dataObj, parent, isAltColumn)
    
    local currentRow = row;
    local rowHeight = AltMan.constants.presentation.table.cellheight;
    
    for _, altDataKey in pairs(section) do
        local fontString = parent:CreateFontString(nil, nil, "GameFontNormalSmall");
        fontString:SetPoint("TOPLEFT", AltMan.constants.presentation.frame.paddingHorizontal + 0, - AltMan.constants.presentation.frame.paddingVertical - currentRow * rowHeight);
        if (currentRow == 0 and isAltColumn) then
            local altClass = dataObj['class'];
            altClass = string.gsub(altClass, "%s+", ""); -- remove spaces e.g. Demon hunter -> Demonhunter
            altClass = string.upper(altClass); -- transform to uppercase e.g. Demonhunter -> DEMONHUNTER

            fontString:SetTextColor(
                RAID_CLASS_COLORS[altClass].r,
                RAID_CLASS_COLORS[altClass].g,
                RAID_CLASS_COLORS[altClass].b,
                RAID_CLASS_COLORS[altClass].a   
            );
            fontString:SetFont("Fonts\\FRIZQT__.TTF", 15);
        end
        fontString:SetText(dataObj[altDataKey]);
        fontString:SetJustifyH("LEFT");
        currentRow = currentRow + 1;
    end

    return currentRow;
end


----------------------------------------------------------------------------
-- Prints a colum
-- A labels colum or an alt colummn
----------------------------------------------------------------------------
function AltMan:PrintColumn(dataObj, parent, isAltColumn)
    local row = 0;
    row = self:PrintColumnSection(AltMan.altData, row, dataObj, parent, isAltColumn);
    row = row + 1;
    row = self:PrintColumnSection(AltMan.altActivities.daily, row, dataObj, parent, isAltColumn);
    row = row + 1;
    row = self:PrintColumnSection(AltMan.altActivities.weekly, row, dataObj, parent, isAltColumn);
end