local _, AltMan = ...

AltMan.UI = AltMan.UI or {}

----------------------------------------------------------------------------
-- Creates a new string
----------------------------------------------------------------------------
function AltMan.UI:CreateNewString(name, parent, horizontal, vertical, isHeading)
    parent[name] = parent:CreateFontString(nil, nil, "GameFontNormalSmall");
    parent[name]:SetPoint("TOPLEFT", horizontal, vertical);
    AltMan.UI:SetStringFormatting(parent[name], isHeading);
end


----------------------------------------------------------------------------
-- sets common formating to strings
----------------------------------------------------------------------------
function AltMan.UI:SetStringFormatting(stringToFormat, isHeading)

    local fontSize = AltMan.constants.presentation.fontSize;
    stringToFormat:SetTextColor(0.8, 0.8, 0.8, 1);
    stringToFormat:SetJustifyH("LEFT");

    if (isHeading) then
        fontSize = fontSize + 5
        stringToFormat:SetTextColor(0.8, 0.8, 0.1, 1);
    end

    stringToFormat:SetFont("Fonts\\FRIZQT__.TTF", fontSize);
end


----------------------------------------------------------------------------
-- sets the background to a frame
----------------------------------------------------------------------------
function AltMan.UI:SetBackground(parent, r, g, b)
    parent["background"] = parent:CreateTexture(nil, "BACKGROUND");
    parent["background"]:SetAllPoints();
    parent["background"]:SetDrawLayer("ARTWORK", 1);

    if (r == nil) then --if we don't have red value - assuming black (0,0,0)
        r=0
        b=0
        g=0
    elseif(g == nil) then -- if we have red value, but nor blue - then assuming gray (r,r,r)
        b=r
        g=r
    end

    parent["background"]:SetColorTexture(r, g, b, AltMan.constants.presentation.frameAlpha);
end


----------------------------------------------------------------------------
-- Shortcut method to increase the main frame height
----------------------------------------------------------------------------
function AltMan.UI:IncreaseMainFrameHeight(increase)
    AltMan.UI:IncreaseFrameHeight(AltMan.frame, increase);
end


----------------------------------------------------------------------------
-- Increases the height of a providede frame
----------------------------------------------------------------------------
function AltMan.UI:IncreaseFrameHeight(frame, increase)
    frame:SetHeight(frame:GetHeight() + increase);
end