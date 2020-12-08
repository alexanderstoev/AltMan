local _, AltMan = ...

----------------------------------------------------------------------------
-- Creates a new string
----------------------------------------------------------------------------
function AltMan:CreateNewString(name, parent, horizontal, vertical, isHeading)
    parent[name] = parent:CreateFontString(nil, nil, "GameFontNormalSmall");
    parent[name]:SetPoint("TOPLEFT", horizontal, vertical);
    AltMan:SetStringFormatting(parent[name], isHeading);
end


----------------------------------------------------------------------------
-- sets common formating to strings
----------------------------------------------------------------------------
function AltMan:SetStringFormatting(stringToFormat, isHeading)
    
    local fontSize = AltMan.constants.presentation.fontSize;
    if (isHeading) then
        fontSize = fontSize + 5
    end

    stringToFormat:SetFont("Fonts\\FRIZQT__.TTF", fontSize);
    stringToFormat:SetTextColor(0.8, 0.8, 0.8, 1);
end


----------------------------------------------------------------------------
-- sets the background to a frame
----------------------------------------------------------------------------
function AltMan:SetBackground(parent)
    parent["background"] = parent:CreateTexture(nil, "BACKGROUND");
    parent["background"]:SetAllPoints();
    parent["background"]:SetDrawLayer("ARTWORK", 1);
    parent["background"]:SetColorTexture(0, 0, 0, AltMan.constants.presentation.frame.alpha);
end
 