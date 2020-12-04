local _, AltMan = ...;
_G["AltMan"] = AltMan;

local shown = false;

local frameWidth = 120;
local frameHeight = 200;

local altWidth = 120;
local labelsWidth = 120;

function AltMan:Show()
    
    if (shown) then
        return
    end

    local main_frame = CreateFrame("frame", "AltManFrame", UIParent);
    AltMan.frame = main_frame;

    self.frame:SetFrameStrata("MEDIUM");

    self.frame:SetWidth(AltMan:GetFrameWidth()); -- Set these to whatever height/width is needed 
    self.frame:SetHeight(frameHeight); -- for your Texture
    
    self.frame.background = self.frame:CreateTexture(nil, "BACKGROUND");
	self.frame.background:SetAllPoints();
	self.frame.background:SetDrawLayer("ARTWORK", 1);
	self.frame.background:SetColorTexture(0, 0, 0, 0.5);
    
    self.frame:SetPoint("CENTER",0,0);
    
    self:GetCloseButton()

    shown = true;

end

function AltMan:GetFrameWidth()
    local numberOfAlts = 2; -- TODO: Make a getter function to load the alts
    return labelsWidth + numberOfAlts*altWidth;
end

function AltMan:GetCloseButton()
    self.frame.closeButton = CreateFrame("Button", "CloseButton", self.frame, "UIPanelCloseButton");
	self.frame.closeButton:ClearAllPoints();
	self.frame.closeButton:SetPoint("TOPRIGHT", 0, 0);
	self.frame.closeButton:SetScript("OnClick", function() AltMan:HideInterface(); end);
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