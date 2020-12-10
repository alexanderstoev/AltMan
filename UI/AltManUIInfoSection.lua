local _, AltMan = ...;

-- used to store references to frames
AltMan.UI = AltMan.UI or {}

----------------------------------------------------------------------------
-- Draws the main info section
----------------------------------------------------------------------------
function AltMan.UI:DrawInfoSection(type, data)

    -- add some padding on top
    AltMan.UI:IncreaseMainFrameHeight(AltMan.constants.presentation.frame.paddingVertical);

    -- init the info sections table if needed
    AltMan.frame.infoSections = AltMan.frame.infoSections or {}

    -- create and setup the frame
    AltMan.frame.infoSections[type] = CreateFrame("frame", "", AltMan.frame);
    AltMan.frame.infoSections[type]:SetFrameStrata("MEDIUM");
    AltMan.frame.infoSections[type]:SetPoint("TOPLEFT", AltMan.constants.presentation.frame.paddingHorizontal,
        -AltMan.frame:GetHeight());
    AltMan.frame.infoSections[type]:SetWidth(AltMan.UI:GetFrameWidth() -
                                                 AltMan.constants.presentation.frame.paddingHorizontal * 2);

    -- Create the heading for the section
    AltMan.UI:CreateNewString("heading", AltMan.frame.infoSections[type], 0, 0, true);
    AltMan.frame.infoSections[type].heading:SetText(AltMan.translations["en"]["headings"][type])
    AltMan.UI:IncreaseFrameHeight(AltMan.frame.infoSections[type], AltMan.constants.presentation.lineheight);

    -- create and setup the labels frame
    AltMan.frame.infoSections[type]["labels"] = CreateFrame("frame", "", AltMan.frame.infoSections[type]);
    AltMan.frame.infoSections[type]["labels"]:SetFrameStrata("MEDIUM");
    AltMan.frame.infoSections[type]["labels"]:SetPoint("TOPLEFT", 0, -AltMan.frame.infoSections[type]:GetHeight());
    AltMan.frame.infoSections[type]["labels"]:SetWidth(AltMan.constants.presentation.labelsFrameWidth);

    -- adjust the frames heights
    local newFrameHeight = sizeOfTable(data) * AltMan.constants.presentation.lineheight;
    AltMan.frame.infoSections[type]["labels"]:SetHeight(newFrameHeight);

    AltMan.UI:IncreaseFrameHeight(AltMan.frame.infoSections[type], AltMan.frame.infoSections[type]["labels"]:GetHeight());
    AltMan.UI:IncreaseMainFrameHeight(AltMan.frame.infoSections[type]:GetHeight());

    -- draw the labels
    AltMan.UI:DrawInfoSectionLabels(type, data)

end

----------------------------------------------------------------------------
--
----------------------------------------------------------------------------
function AltMan.UI:DrawInfoSectionLabels(type, data)
    local index = 0
    for _, entry in pairs(data) do
        AltMan.UI:CreateNewString(entry, AltMan.frame.infoSections[type]["labels"], 0,
            -index * AltMan.constants.presentation.lineheight);
        AltMan.frame.infoSections[type]["labels"][entry]:SetText(
            AltMan.translations["en"]["labels"][type .. "-" .. entry]);
        index = index + 1;
    end
end

----------------------------------------------------------------------------
--
----------------------------------------------------------------------------
function AltMan.UI:PrintInfoSection(type, key, data, index)

    index = index or 0;

    AltMan.frame.infoSections[type][key] = CreateFrame("frame", "", AltMan.frame.infoSections[type]);
    AltMan.frame.infoSections[type][key]:SetFrameStrata("MEDIUM");
    AltMan.frame.infoSections[type][key]:SetWidth(AltMan.constants.presentation.altFrameWidth);
    AltMan.frame.infoSections[type][key]:SetHeight(sizeOfTable(data) * AltMan.constants.presentation.lineheight);

    local positionX = index * AltMan.constants.presentation.altFrameWidth +
                          AltMan.constants.presentation.labelsFrameWidth + (index + 1) *
                          AltMan.constants.presentation.frame.paddingVertical;
    AltMan.frame.infoSections[type][key]:SetPoint("TOPLEFT", positionX, -AltMan.constants.presentation.lineheight); -- we always have a header section even if no string is printed
    -- AltMan.UI:SetBackground(AltMan.frame.infoSections[type][key], (0.2*index), 0.5, 0)

    local dataIndex = 0;
    for entry, value in pairs(data) do
        -- print(entry)
        AltMan.UI:CreateNewString(entry, AltMan.frame.infoSections[type][key], 0,
            -dataIndex * AltMan.constants.presentation.lineheight);
        AltMan.frame.infoSections[type][key][entry]:SetText(value);
        dataIndex = dataIndex + 1;
    end

end
