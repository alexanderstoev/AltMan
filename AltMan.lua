local _, AltMan = ...;
_G["AltMan"] = AltMan;

local shown = false;

function AltMan:Show()
    
    if (shown) then
        return
    end

    self:LoadAlts();

    local main_frame = CreateFrame("frame", "AltManFrame", UIParent);
    AltMan.frame = main_frame;

    self.frame:SetFrameStrata("MEDIUM");

    self.frame:SetWidth(AltMan:GetFrameWidth()); -- Set these to whatever height/width is needed 
    self.frame:SetHeight(AltMan.constants.presentation.frame.height); -- for your Texture
    self.frame:EnableMouse(true)
    self.frame:SetMovable(true)

    self.frame.background = self.frame:CreateTexture(nil, "BACKGROUND");
	self.frame.background:SetAllPoints();
	self.frame.background:SetDrawLayer("ARTWORK", 1);
	self.frame.background:SetColorTexture(0, 0, 0, 0.7);
    
    self.frame:SetPoint("CENTER",0,0);
    
    self:GetContents();
    self:GetCloseButton();

    shown = true;

end

function AltMan:GetContents()

    -- print labels column
    AltMan:PrintColumn(AltMan.translations["en"]["labels"], self.frame, false);

    -- print alt data
    for k, v in pairs(AltMan.Alts) do
        local frame = CreateFrame("frame", "", self.frame);
        
        frame:SetFrameStrata("MEDIUM");
        
        frame:SetWidth(AltMan.constants.presentation.table.cellwidth);
        frame:SetHeight(AltMan.constants.presentation.frame.height);
        
        frame:SetPoint("TOPLEFT", AltMan.constants.presentation.table.cellwidth * (k), 0);
        if (math.fmod(k, 2) == 1) then
            frame.background = frame:CreateTexture(nil, "BACKGROUND");
            frame.background:SetAllPoints();
            frame.background:SetDrawLayer("ARTWORK", 1);
            frame.background:SetColorTexture(0, 0, 0, 0.7);   
        end
        AltMan:PrintColumn(v, frame, true);
    end
end


function AltMan:GetFrameWidth()
    return AltMan.constants.presentation.table.cellwidth + AltMan.TotalAlts * AltMan.constants.presentation.table.cellwidth;
end

function AltMan:GetCloseButton()
    self.frame.closeButton = CreateFrame("Button", "CloseButton", self.frame, "UIPanelCloseButton");
	self.frame.closeButton:ClearAllPoints();
	self.frame.closeButton:SetFrameStrata("HIGH");
	self.frame.closeButton:SetPoint("TOPRIGHT", 0, 0);
	self.frame.closeButton:SetScript("OnClick", function() AltMan:HideInterface(); end);
end


function AltMan:PrintColumnSection(section, row, dataObj, parent, isAltColumn)
    
    local currentRow = row;
    local rowHeight = AltMan.constants.presentation.table.cellheight;
    
    for _, altDataKey in pairs(section) do
        local fontString = parent:CreateFontString(nil, nil, "GameFontNormalSmall");
        fontString:SetPoint("TOPLEFT", AltMan.constants.presentation.frame.paddingHorizontal + 0, - AltMan.constants.presentation.frame.paddingVertical - currentRow * rowHeight);
        if (currentRow == 0 and isAltColumn) then
            fontString:SetTextColor(
                RAID_CLASS_COLORS[dataObj['class']].r,
                RAID_CLASS_COLORS[dataObj['class']].g,
                RAID_CLASS_COLORS[dataObj['class']].b,
                RAID_CLASS_COLORS[dataObj['class']].a   
            );
            fontString:SetFont("Fonts\\FRIZQT__.TTF", 15);
        end
        fontString:SetText(dataObj[altDataKey]);
        currentRow = currentRow + 1;
    end

return currentRow;
end

function AltMan:PrintColumn(dataObj, parent, isAltColumn)
    local row = 0;
    row = AltMan:PrintColumnSection(AltMan.altData, row, dataObj, parent, isAltColumn);
    row = row + 1;
    row = AltMan:PrintColumnSection(AltMan.altActivities.daily, row, dataObj, parent, isAltColumn);
    row = row + 1;
    row = AltMan:PrintColumnSection(AltMan.altActivities.weekly, row, dataObj, parent, isAltColumn);
end

function AltMan:HideInterface()
    shown = false;
    self.frame:Hide();
end

function AltMan:OnLoad()
	print("AltMan Loaded!")
end

SLASH_ALTMAN1 = "/zam";
SLASH_ALTMAN2 = "/alts";


local function AltManSlashHandler (args) 
    if(string.len(args) > 0) then
        print("Alt Man help: No help so far. You've added " .. args)
    else
        print("Loading AltMan...")
        AltMan:Show();
    end
end

SlashCmdList["ALTMAN"] = AltManSlashHandler;