local _, AltMan = ...;

-- used to store references to frames
AltMan.UI = AltMan.UI or {}

local dataOrder = AltMan.Data.dataSourcesTypes

----------------------------------------------------------------------------
-- Draws a main info section e.g. server data, daily, weekly etc
----------------------------------------------------------------------------
function AltMan.UI:DrawInfoSection(type, data)

    -- add some padding on top
    AltMan.UI:IncreaseMainFrameHeight(AltMan.constants.presentation.frame.paddingVertical);

    -- init the info sections table if needed
    AltMan.frame.infoSections = AltMan.frame.infoSections or {}

    -- create and setup the frame
    AltMan.frame.infoSections[type] = CreateFrame("frame", "", AltMan.frame);
    AltMan.frame.infoSections[type]:SetFrameStrata("MEDIUM");
    AltMan.frame.infoSections[type]:SetPoint("TOPLEFT", AltMan.frame, "TOPLEFT",
        AltMan.constants.presentation.frame.paddingHorizontal, -AltMan.frame:GetHeight());

    AltMan.frame.infoSections[type]:SetWidth(AltMan.UI:GetFrameWidth() -
                                                 AltMan.constants.presentation.frame.paddingHorizontal * 2);

    -- Create the heading for the section
    AltMan.UI:CreateNewString("heading", AltMan.frame.infoSections[type], 0, 0, true);
    AltMan.frame.infoSections[type].heading:SetText(AltMan.translations["en"]["headings"][type])
    AltMan.UI:IncreaseFrameHeight(AltMan.frame.infoSections[type], AltMan.constants.presentation.lineheight);

    -- create and setup the labels frame
    AltMan.frame.infoSections[type]["labels"] = CreateFrame("frame", "", AltMan.frame.infoSections[type]);
    AltMan.frame.infoSections[type]["labels"]:SetFrameStrata("MEDIUM");
    AltMan.frame.infoSections[type]["labels"]:SetPoint("TOPLEFT", AltMan.frame.infoSections[type], "TOPLEFT", 0,
        -AltMan.frame.infoSections[type]:GetHeight());
    AltMan.frame.infoSections[type]["labels"]:SetWidth(AltMan.constants.presentation.labelsFrameWidth);

    -- adjust the frames heights
    local newFrameHeight = sizeOfTable(data) * AltMan.constants.presentation.lineheight;
    AltMan.frame.infoSections[type]["labels"]:SetHeight(newFrameHeight);

    AltMan.UI:IncreaseFrameHeight(AltMan.frame.infoSections[type], AltMan.frame.infoSections[type]["labels"]:GetHeight());
    AltMan.UI:IncreaseMainFrameHeight(AltMan.frame.infoSections[type]:GetHeight());

    -- draw the labels
    AltMan.UI:DrawInfoSectionLabels(type)
end

----------------------------------------------------------------------------
-- Draws the labels for a section
----------------------------------------------------------------------------
function AltMan.UI:DrawInfoSectionLabels(type)

    local order = dataOrder[type]

    local subType = string.gsub(type, "alt%-data%-", "");
    if not (subType == type) then
        order = dataOrder["alt-data"][subType]
    end

    local index = 0
    for _, entry in Spairs(order, CompareDataSources) do
        AltMan.UI:CreateNewString(entry, AltMan.frame.infoSections[type]["labels"], 0,
            -index * AltMan.constants.presentation.lineheight);

        AltMan.frame.infoSections[type]["labels"][entry]:SetText(
            AltMan.translations["en"]["labels"][type .. "-" .. entry]);

        index = index + 1;
    end
end

----------------------------------------------------------------------------
-- Used to draw the actual server or alts data
----------------------------------------------------------------------------
function AltMan.UI:DrawInfoSubSection(type, key, data, index)

    index = index or 0;

    AltMan.frame.infoSections[type][key] = CreateFrame("frame", "", AltMan.frame.infoSections[type]);
    AltMan.frame.infoSections[type][key]:SetFrameStrata("MEDIUM");
    AltMan.frame.infoSections[type][key]:SetWidth(AltMan.constants.presentation.altFrameWidth);
    AltMan.frame.infoSections[type][key]:SetHeight(sizeOfTable(data) * AltMan.constants.presentation.lineheight);

    local positionX = index * AltMan.constants.presentation.altFrameWidth +
                          AltMan.constants.presentation.labelsFrameWidth + (index + 1) *
                          AltMan.constants.presentation.frame.paddingVertical;

    AltMan.frame.infoSections[type][key]:SetPoint("TOPLEFT", AltMan.frame.infoSections[type], "TOPLEFT", positionX,
        -AltMan.constants.presentation.lineheight); -- we always have a header section even if no string is printed

    local order = dataOrder[type]

    local subType = string.gsub(type, "alt%-data%-", "");
    if not (subType == type) then
        order = dataOrder["alt-data"][subType]
    end

    local dataIndex = 0;
    for _, dataKey in Spairs(order, CompareDataSources) do
        AltMan.UI:CreateNewString(dataKey, AltMan.frame.infoSections[type][key], 0,
            -dataIndex * AltMan.constants.presentation.lineheight);

        if (dataKey == "class") then
            local altClass = data[dataKey];
            altClass = string.gsub(altClass, "%s+", ""); -- remove spaces e.g. Demon hunter -> Demonhunter
            altClass = string.upper(altClass); -- transform to uppercase e.g. Demonhunter -> DEMONHUNTER

            AltMan.frame.infoSections[type][key][dataKey]:SetTextColor(RAID_CLASS_COLORS[altClass].r,
                RAID_CLASS_COLORS[altClass].g, RAID_CLASS_COLORS[altClass].b, RAID_CLASS_COLORS[altClass].a);
        end

        dataIndex = dataIndex + 1;
    end

end

----------------------------------------------------------------------------
-- refreshes the data printed on the frame
----------------------------------------------------------------------------
function AltMan.UI:RefreshData(type, key, data)
    for entry, value in pairs(data) do
        AltMan.frame.infoSections[type][key][entry]:SetText(value);
    end
end

function AltMan.UI:AddAltsBackground()

    local _, _, _, _, dy = AltMan.frame.infoSections["alt-data-core"]:GetPoint();
    local index = 0;
    local w = AltMan.constants.presentation.altFrameWidth + AltMan.constants.presentation.frame.paddingHorizontal * 2;
    local lw = AltMan.constants.presentation.labelsFrameWidth;
    local wh = AltMan.frame:GetHeight();
    local r, g, b;

    AltMan.frame.altsBackround = {}
    for altKey, alt in Spairs(AltMan.Data.data["alt-data"], CompareAlts) do
        AltMan.frame.altsBackround[altKey] = CreateFrame("frame", "", AltMan.frame);
        AltMan.frame.altsBackround[altKey]:SetFrameStrata("MEDIUM");
        AltMan.frame.altsBackround[altKey]:SetPoint("TOPLEFT", AltMan.frame, "TOPLEFT", index * w + lw, dy);
        AltMan.frame.altsBackround[altKey]:SetWidth(w);
        AltMan.frame.altsBackround[altKey]:SetHeight(wh + dy);

        local grey = AltMan.constants.presentation.evenCharGrey;
        if (math.fmod((index + 1), 2) == 0) then
            grey = grey * 2;
        end
        AltMan.UI:SetBackground(AltMan.frame.altsBackround[altKey], grey);
        index = index + 1
    end
end

----------------------------------------------------------------------------
--
----------------------------------------------------------------------------
function AltMan.UI:updateHeights()

    -- server data section will not move. 
    -- famous last words?
    local newHeight = 0;
    local altsBGStartPoint = 0;

    -- check alt core data
    local _, _, _, _, dy = AltMan.frame.infoSections["alt-data-core"]:GetPoint();
    newHeight = HandleAltSection("core");
    altsBGStartPoint = dy;

    AltMan.frame.infoSections["alt-data-daily"]:SetPoint("TOPLEFT", AltMan.frame, "TOPLEFT",
        AltMan.constants.presentation.frame.paddingHorizontal, -newHeight -
            AltMan.constants.presentation.frame.paddingVertical + dy);
    _, _, _, _, dy = AltMan.frame.infoSections["alt-data-daily"]:GetPoint();
    newHeight = HandleAltSection("daily");

    AltMan.frame.infoSections["alt-data-weekly"]:SetPoint("TOPLEFT", AltMan.frame, "TOPLEFT",
        AltMan.constants.presentation.frame.paddingHorizontal, -newHeight -
            AltMan.constants.presentation.frame.paddingVertical + dy);
    _, _, _, _, dy = AltMan.frame.infoSections["alt-data-weekly"]:GetPoint()
    newHeight = HandleAltSection("weekly");

    local newMainFrameHeigt = -dy + newHeight + AltMan.constants.presentation.frame.paddingVertical;

    AltMan.frame:SetHeight(newMainFrameHeigt)

    for k, v in pairs(AltMan.frame.altsBackround) do
        AltMan.frame.altsBackround[k]:SetHeight(newMainFrameHeigt + altsBGStartPoint);
    end
end

function HandleAltSection(type)

    local infoSection = "alt-data-" .. type;

    local currentSubSectionHeight = 0;
    for _, dataKey in Spairs(dataOrder["alt-data"][type], CompareDataSources) do
        local maxHeight = 0;

        for altKey, alt in Spairs(AltMan.Data.data["alt-data"], CompareAlts) do

            local currentStringHeight = AltMan.frame.infoSections[infoSection][altKey][dataKey]:GetStringHeight();
            if (maxHeight < currentStringHeight) then
                maxHeight = currentStringHeight
            end

        end
        MoveAltRow(infoSection, dataKey, currentSubSectionHeight)
        currentSubSectionHeight = currentSubSectionHeight - maxHeight - AltMan.constants.presentation.textPadding;
    end

    for altKey, alt in Spairs(AltMan.Data.data["alt-data"], CompareAlts) do
        AltMan.frame.infoSections[infoSection][altKey]:SetHeight(-currentSubSectionHeight);
    end

    local newHeight = -currentSubSectionHeight + AltMan.constants.presentation.lineheight

    AltMan.frame.infoSections[infoSection]:SetHeight(newHeight);
    return newHeight;
end

function MoveAltRow(infoSection, dataKey, newTop)

    AltMan.frame.infoSections[infoSection]["labels"][dataKey]:SetPoint("TOPLEFT",
        AltMan.frame.infoSections[infoSection]["labels"], "TOPLEFT", 0, newTop)

    for altKey, alt in Spairs(AltMan.Data.data["alt-data"], CompareAlts) do
        AltMan.frame.infoSections[infoSection][altKey][dataKey]:SetPoint("TOPLEFT",
            AltMan.frame.infoSections[infoSection][altKey], "TOPLEFT", 0, newTop)
    end
end
