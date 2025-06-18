local function getLayoutTable()
    local t = {}

    for k, _ in pairs(sArenaMixin.layouts) do
        t[k] = sArenaMixin.layouts[k].name and sArenaMixin.layouts[k].name or k
    end

    return t
end

local function validateCombat()
    if (InCombatLockdown()) then
        return "Must leave combat first."
    end

    return true
end

local growthValues = { "Down", "Up", "Right", "Left" }

local drCategories = {
    ["Incapacitate"] = "Incapacitate",
    ["Stun"] = "Stun",
    ["Root"] = "Root",
    ["Fear"] = "Fear",
    ["Silence"] = "Silence",
    ["Disarm"] = "Disarm",
    ["Disorient"] = "Disorient",
    ["Horror"] = "Horror",
    ["Cyclone"] = "Cyclone",
    ["MindControl"] = "MindControl",
    ["RandomStun"] = "RandomStun",
    ["RandomRoot"] = "RandomRoot",
    ["Charge"] = "Charge",
}

local racialCategories = {
    ["Human"] = "Human",
    ["Scourge"] = "Undead",
    ["Gnome"] = "Gnome",
    ["Dwarf"] = "Dwarf",
    ["Orc"] = "Orc",
    ["Tauren"] = "Tauren",
    ["BloodElf"] = "BloodElf",
    ["Troll"] = "Troll",
    ["Draenei"] = "Draenei",
    ["NightElf"] = "NightElf",
    ["Goblin"] = "Goblin",
    ["Worgen"] = "Worgen",
    ["Pandaren"] = "Pandaren",
}

function sArenaMixin:GetLayoutOptionsTable(layoutName)
    local optionsTable = {
        arenaFrames = {
            order = 1,
            name = "Arena Frames",
            type = "group",
            get = function(info) return info.handler.db.profile.layoutSettings[layoutName][info[#info]] end,
            set = function(info, val)
                self:UpdateFrameSettings(info.handler.db.profile.layoutSettings[layoutName], info,
                    val)
            end,
            args = {
                positioning = {
                    order = 1,
                    name = "Positioning",
                    type = "group",
                    inline = true,
                    args = {
                        posX = {
                            order = 1,
                            name = "Horizontal",
                            type = "range",
                            min = -1000,
                            max = 1000,
                            step = 0.1,
                            bigStep = 1,
                        },
                        posY = {
                            order = 2,
                            name = "Vertical",
                            type = "range",
                            min = -1000,
                            max = 1000,
                            step = 0.1,
                            bigStep = 1,
                        },
                        spacing = {
                            order = 3,
                            name = "Spacing",
                            desc = "Spacing between each arena frame",
                            type = "range",
                            min = 0,
                            max = 100,
                            step = 1,
                        },
                        growthDirection = {
                            order = 4,
                            name = "Growth Direction",
                            type = "select",
                            style = "dropdown",
                            values = growthValues,
                        },
                    },
                },
                sizing = {
                    order = 2,
                    name = "Sizing",
                    type = "group",
                    inline = true,
                    args = {
                        scale = {
                            order = 1,
                            name = "Scale",
                            type = "range",
                            min = 0.1,
                            max = 5.0,
                            softMin = 0.5,
                            softMax = 3.0,
                            step = 0.01,
                            bigStep = 0.1,
                            isPercent = true,
                        },
                        classIconFontSize = {
                            order = 2,
                            name = "Class Icon CD Font Size",
                            desc = "Only works with Blizzard cooldown count (not OmniCC)",
                            type = "range",
                            min = 2,
                            max = 48,
                            softMin = 4,
                            softMax = 32,
                            step = 1,
                        },
                    },
                },
            },
        },
        specIcon = {
            order = 2,
            name = "Spec Icons",
            type = "group",
            get = function(info) return info.handler.db.profile.layoutSettings[layoutName].specIcon[info[#info]] end,
            set = function(info, val)
                self:UpdateSpecIconSettings(
                    info.handler.db.profile.layoutSettings[layoutName].specIcon, info, val)
            end,
            args = {
                positioning = {
                    order = 1,
                    name = "Positioning",
                    type = "group",
                    inline = true,
                    args = {
                        posX = {
                            order = 1,
                            name = "Horizontal",
                            type = "range",
                            min = -500,
                            max = 500,
                            softMin = -200,
                            softMax = 200,
                            step = 0.1,
                            bigStep = 1,
                        },
                        posY = {
                            order = 2,
                            name = "Vertical",
                            type = "range",
                            min = -500,
                            max = 500,
                            softMin = -200,
                            softMax = 200,
                            step = 0.1,
                            bigStep = 1,
                        },
                    },
                },
                sizing = {
                    order = 2,
                    name = "Sizing",
                    type = "group",
                    inline = true,
                    args = {
                        scale = {
                            order = 1,
                            name = "Scale",
                            type = "range",
                            min = 0.1,
                            max = 5.0,
                            softMin = 0.5,
                            softMax = 3.0,
                            step = 0.01,
                            bigStep = 0.1,
                            isPercent = true,
                        },
                    },
                },
            },
        },
        trinket = {
            order = 3,
            name = "Trinkets",
            type = "group",
            get = function(info) return info.handler.db.profile.layoutSettings[layoutName].trinket[info[#info]] end,
            set = function(info, val)
                self:UpdateTrinketSettings(
                    info.handler.db.profile.layoutSettings[layoutName].trinket, info, val)
            end,
            args = {
                positioning = {
                    order = 1,
                    name = "Positioning",
                    type = "group",
                    inline = true,
                    args = {
                        posX = {
                            order = 1,
                            name = "Horizontal",
                            type = "range",
                            min = -500,
                            max = 500,
                            softMin = -200,
                            softMax = 200,
                            step = 0.1,
                            bigStep = 1,
                        },
                        posY = {
                            order = 2,
                            name = "Vertical",
                            type = "range",
                            min = -500,
                            max = 500,
                            softMin = -200,
                            softMax = 200,
                            step = 0.1,
                            bigStep = 1,
                        },
                    },
                },
                sizing = {
                    order = 2,
                    name = "Sizing",
                    type = "group",
                    inline = true,
                    args = {
                        scale = {
                            order = 1,
                            name = "Scale",
                            type = "range",
                            min = 0.1,
                            max = 5.0,
                            softMin = 0.5,
                            softMax = 3.0,
                            step = 0.001,
                            bigStep = 0.1,
                            isPercent = true,
                        },
                        fontSize = {
                            order = 3,
                            name = "Font Size",
                            desc = "Only works with Blizzard cooldown count (not OmniCC)",
                            type = "range",
                            min = 2,
                            max = 48,
                            softMin = 4,
                            softMax = 32,
                            step = 1,
                        },
                    },
                },
            },
        },
        racial = {
            order = 4,
            name = "Racials",
            type = "group",
            get = function(info) return info.handler.db.profile.layoutSettings[layoutName].racial[info[#info]] end,
            set = function(info, val)
                self:UpdateRacialSettings(
                    info.handler.db.profile.layoutSettings[layoutName].racial, info, val)
            end,
            args = {
                positioning = {
                    order = 1,
                    name = "Positioning",
                    type = "group",
                    inline = true,
                    args = {
                        posX = {
                            order = 1,
                            name = "Horizontal",
                            type = "range",
                            min = -500,
                            max = 500,
                            softMin = -200,
                            softMax = 200,
                            step = 0.1,
                            bigStep = 1,
                        },
                        posY = {
                            order = 2,
                            name = "Vertical",
                            type = "range",
                            min = -500,
                            max = 500,
                            softMin = -200,
                            softMax = 200,
                            step = 0.1,
                            bigStep = 1,
                        },
                    },
                },
                sizing = {
                    order = 2,
                    name = "Sizing",
                    type = "group",
                    inline = true,
                    args = {
                        scale = {
                            order = 1,
                            name = "Scale",
                            type = "range",
                            min = 0.1,
                            max = 5.0,
                            softMin = 0.5,
                            softMax = 3.0,
                            step = 0.001,
                            bigStep = 0.1,
                            isPercent = true,
                        },
                        fontSize = {
                            order = 3,
                            name = "Font Size",
                            desc = "Only works with Blizzard cooldown count (not OmniCC)",
                            type = "range",
                            min = 2,
                            max = 48,
                            softMin = 4,
                            softMax = 32,
                            step = 1,
                        },
                    },
                },
            },
        },
        castBar = {
            order = 5,
            name = "Cast Bars",
            type = "group",
            get = function(info) return info.handler.db.profile.layoutSettings[layoutName].castBar[info[#info]] end,
            set = function(info, val)
                self:UpdateCastBarSettings(info.handler.db.profile.layoutSettings[layoutName].castBar, info, val)
                if sArenaMixin.RefreshMasque then
                    sArenaMixin:RefreshMasque()
                end
            end,
            args = {
                positioning = {
                    order = 1,
                    name = "Positioning",
                    type = "group",
                    inline = true,
                    args = {
                        posX = {
                            order = 1,
                            name = "Horizontal",
                            type = "range",
                            min = -500,
                            max = 500,
                            softMin = -200,
                            softMax = 200,
                            step = 0.1,
                            bigStep = 1,
                        },
                        posY = {
                            order = 2,
                            name = "Vertical",
                            type = "range",
                            min = -500,
                            max = 500,
                            softMin = -200,
                            softMax = 200,
                            step = 0.1,
                            bigStep = 1,
                        },
                    },
                },
                sizing = {
                    order = 2,
                    name = "Sizing",
                    type = "group",
                    inline = true,
                    args = {
                        scale = {
                            order = 1,
                            name = "Scale",
                            type = "range",
                            min = 0.1,
                            max = 5.0,
                            softMin = 0.5,
                            softMax = 3.0,
                            step = 0.01,
                            bigStep = 0.1,
                            isPercent = true,
                        },
                        width = {
                            order = 2,
                            name = "Width",
                            type = "range",
                            min = 10,
                            max = 400,
                            step = 1,
                        },
                        iconScale = {
                            order = 3,
                            name = "Icon Scale",
                            type = "range",
                            min = 0.1,
                            max = 5.0,
                            softMin = 0.5,
                            softMax = 3.0,
                            step = 0.01,
                            bigStep = 0.1,
                            isPercent = true,
                        },
                    },
                },
            },
        },
        dr = {
            order = 6,
            name = "Diminishing Returns",
            type = "group",
            get = function(info) return info.handler.db.profile.layoutSettings[layoutName].dr[info[#info]] end,
            set = function(info, val)
                self:UpdateDRSettings(info.handler.db.profile.layoutSettings[layoutName].dr, info, val)
                if sArenaMixin.RefreshMasque then
                    sArenaMixin:RefreshMasque()
                end
            end,
            args = {
                positioning = {
                    order = 1,
                    name = "Positioning",
                    type = "group",
                    inline = true,
                    args = {
                        posX = {
                            order = 1,
                            name = "Horizontal",
                            type = "range",
                            min = -500,
                            max = 500,
                            softMin = -200,
                            softMax = 200,
                            step = 0.1,
                            bigStep = 1,
                        },
                        posY = {
                            order = 2,
                            name = "Vertical",
                            type = "range",
                            min = -500,
                            max = 500,
                            softMin = -200,
                            softMax = 200,
                            step = 0.1,
                            bigStep = 1,
                        },
                        spacing = {
                            order = 3,
                            name = "Spacing",
                            type = "range",
                            min = 0,
                            max = 32,
                            softMin = 0,
                            softMax = 32,
                            step = 1,
                        },
                        growthDirection = {
                            order = 4,
                            name = "Growth Direction",
                            type = "select",
                            style = "dropdown",
                            values = growthValues,
                        },
                    },
                },
                sizing = {
                    order = 2,
                    name = "Sizing",
                    type = "group",
                    inline = true,
                    args = {
                        size = {
                            order = 1,
                            name = "Size",
                            type = "range",
                            min = 2,
                            max = 128,
                            softMin = 8,
                            softMax = 64,
                            step = 1,
                            -- get = function(info)
                            --     return info.handler.db.profile.size or 24
                            -- end,
                            -- set = function(info, val)
                            --     info.handler.db.profile.size = val
                            --     if info.handler.RefreshMasque then
                            --         info.handler:RefreshMasque()
                            --     end
                            -- end,
                        },
                        borderSize = {
                            order = 2,
                            name = "Border Size",
                            type = "range",
                            min = 0,
                            max = 24,
                            softMin = 1,
                            softMax = 16,
                            step = 0.1,
                            bigStep = 1,
                        },
                        fontSize = {
                            order = 3,
                            name = "Font Size",
                            desc = "Only works with Blizzard cooldown count (not OmniCC)",
                            type = "range",
                            min = 2,
                            max = 48,
                            softMin = 4,
                            softMax = 32,
                            step = 1,
                        },
                    },
                },
                drCategorySizing = {
                    order = 3,
                    name = "DR Specific Size Adjustment",
                    type = "group",
                    inline = true,
                    args = {},
                },
            },
        },
    }

    local drCategoryOrder = {
        Incapacitate = 1,
        Stun         = 2,
        Root         = 3,
        Fear         = 4,
        Silence      = 5,
        Disarm       = 6,
        Disorient    = 7,
        Horror       = 8,
        Cyclone      = 9,
        MindControl  = 10,
        RandomStun   = 11,
        RandomRoot   = 12,
        Charge       = 13,
    }

    for categoryKey, categoryName in pairs(drCategories) do
        optionsTable.dr.args.drCategorySizing.args[categoryKey] = {
            order = drCategoryOrder[categoryKey],
            name = categoryName,
            type = "range",
            min = -25,
            max = 25,
            softMin = -10,
            softMax = 20,
            step = 1,
            get = function(info)
                local dr = info.handler.db.profile.layoutSettings[layoutName].dr
                dr.drCategorySizeOffsets = dr.drCategorySizeOffsets or {}
                return dr.drCategorySizeOffsets[info[#info]] or 0
            end,
            set = function(info, val)
                local dr = info.handler.db.profile.layoutSettings[layoutName].dr
                dr.drCategorySizeOffsets = dr.drCategorySizeOffsets or {}
                dr.drCategorySizeOffsets[info[#info]] = val
                self:UpdateDRSettings(dr, info)
            end,
        }
    end



    return optionsTable
end

function sArenaMixin:UpdateFrameSettings(db, info, val)
    if (val) then
        db[info[#info]] = val
    end

    self:ClearAllPoints()
    self:SetPoint("CENTER", UIParent, "CENTER", db.posX, db.posY)
    self:SetScale(db.scale)

    local growthDirection = db.growthDirection
    local spacing = db.spacing

    for i = 1, 5 do
        local text = self["arena" .. i].ClassIconCooldown.Text
        text:SetFont(text.fontFile, db.classIconFontSize, "OUTLINE")
        local sArenaText = self["arena" .. i].ClassIconCooldown.sArenaText
        if sArenaText then
            sArenaText:SetFont(text.fontFile, db.classIconFontSize, "OUTLINE")
        end
    end

    for i = 2, 5 do
        local frame = self["arena" .. i]
        local prevFrame = self["arena" .. i - 1]

        frame:ClearAllPoints()
        if (growthDirection == 1) then
            frame:SetPoint("TOP", prevFrame, "BOTTOM", 0, -spacing)
        elseif (growthDirection == 2) then
            frame:SetPoint("BOTTOM", prevFrame, "TOP", 0, spacing)
        elseif (growthDirection == 3) then
            frame:SetPoint("LEFT", prevFrame, "RIGHT", spacing, 0)
        elseif (growthDirection == 4) then
            frame:SetPoint("RIGHT", prevFrame, "LEFT", -spacing, 0)
        end
    end
end

function sArenaMixin:UpdateCastBarSettings(db, info, val)
    if (val) then
        db[info[#info]] = val
    end

    for i = 1, 5 do
        local frame = self["arena" .. i]

        frame.CastBar:ClearAllPoints()
        frame.CastBar:SetPoint("CENTER", frame, "CENTER", db.posX, db.posY)
        frame.CastBar:SetScale(db.scale)
        frame.CastBar:SetWidth(db.width)
        frame.CastBar.Icon:SetScale(db.iconScale)
    end
end

function sArenaMixin:UpdateDRSettings(db, info, val)
    local categories = {
        "Incapacitate",
        "Stun",
        "RandomStun",
        "RandomRoot",
        "Root",
        "Disarm",
        "Fear",
        "Disorient",
        "Silence",
        "Horror",
        "MindControl",
        "Cyclone",
        "Charge",
    }

    if (val) then
        db[info[#info]] = val
    end

    local categorySizeOffsets = db.drCategorySizeOffsets or {}

    for i = 1, 5 do
        local frame = self["arena" .. i]
        frame:UpdateDRPositions()

        for n = 1, #categories do
            local category = categories[n]
            local dr = frame[category]

            local offset = categorySizeOffsets[category] or 0
            local size = db.size + offset

            dr:SetSize(size, size)
            dr.Border:SetPoint("TOPLEFT", dr, "TOPLEFT", -db.borderSize or 1, db.borderSize or 1)
            dr.Border:SetPoint("BOTTOMRIGHT", dr, "BOTTOMRIGHT", db.borderSize or 1, -db.borderSize or 1)

            local text = dr.Cooldown.Text
            text:SetFont(text.fontFile, db.fontSize, "OUTLINE")
            local sArenaText = dr.Cooldown.sArenaText
            if sArenaText then
                sArenaText:SetFont(text.fontFile, db.fontSize, "OUTLINE")
            end
        end
    end

    self:UpdateGlobalDRSettings()
end

function sArenaMixin:UpdateGlobalDRSettings()
    local categories = {
        "Incapacitate",
        "Stun",
        "RandomStun",
        "RandomRoot",
        "Root",
        "Disarm",
        "Fear",
        "Disorient",
        "Silence",
        "Horror",
        "MindControl",
        "Cyclone",
        "Charge",
    }

    local drSwipeOff = self.db.profile.drSwipeOff
    local drTextOn = self.db.profile.drTextOn

    for i = 1, 5 do
        local frame = self["arena" .. i]
        frame:UpdateDRPositions()

        for n = 1, #categories do
            local category = categories[n]
            local dr = frame[category]
            if drSwipeOff then
                dr.Cooldown:SetDrawSwipe(false)
                dr.Cooldown:SetDrawEdge(false)
            else
                dr.Cooldown:SetDrawSwipe(true)
                dr.Cooldown:SetDrawEdge(true)
            end

            if drTextOn then
                dr.DRTextFrame:Show()
            else
                dr.DRTextFrame:Hide()
            end
        end
    end
end

function sArenaMixin:UpdateSpecIconSettings(db, info, val)
    if (val) then
        db[info[#info]] = val
    end

    for i = 1, 5 do
        local frame = self["arena" .. i]

        frame.SpecIcon:ClearAllPoints()
        frame.SpecIcon:SetPoint("CENTER", frame, "CENTER", db.posX, db.posY)
        frame.SpecIcon:SetScale(db.scale)
    end
end

function sArenaMixin:UpdateTrinketSettings(db, info, val)
    if (val) then
        db[info[#info]] = val
    end

    for i = 1, 5 do
        local frame = self["arena" .. i]

        frame.Trinket:ClearAllPoints()
        frame.Trinket:SetPoint("CENTER", frame, "CENTER", db.posX, db.posY)
        frame.Trinket:SetScale(db.scale)

        local text = self["arena" .. i].Trinket.Cooldown.Text
        text:SetFont(text.fontFile, db.fontSize, "OUTLINE")
    end
end

function sArenaMixin:UpdateRacialSettings(db, info, val)
    if (val) then
        db[info[#info]] = val
    end

    for i = 1, 5 do
        local frame = self["arena" .. i]

        frame.Racial:ClearAllPoints()
        frame.Racial:SetPoint("CENTER", frame, "CENTER", db.posX, db.posY)
        frame.Racial:SetScale(db.scale)

        local text = self["arena" .. i].Racial.Cooldown.Text
        text:SetFont(text.fontFile, db.fontSize, "OUTLINE")
    end
end

if C_AddOns.IsAddOnLoaded("sArena") then
    sArenaMixin.optionsTable = {
        type = "group",
        childGroups = "tab",
        validate = validateCombat,
        args = {
            oldConvert = {
                order = 1,
                name = "Old sArena",
                desc = "Converter for old sArena",
                type = "group",
                args = {
                    description = {
                        order = 1,
                        type = "description",
                        name = "|A:services-icon-warning:16:16|aOld sArena is enabled|A:services-icon-warning:16:16|a\n\nIf you want to copy over your old settings to sArena |cff00ff96MoP Classic|r click the button below.",
                        fontSize = "medium",
                    },
                    convertButton = {
                        order = 2,
                        type = "execute",
                        name = "Convert Settings",
                        func = sArenaMixin.OldConvert,
                        width = "normal",
                    },
                    banner = {
                        order = 3,
                        type = "description",
                        name = "|A:accountupgradebanner-classic:240:420|a",
                    },
                },
            },
        },
    }
else
    sArenaMixin.optionsTable = {
        type = "group",
        childGroups = "tab",
        validate = validateCombat,
        args = {
            setLayout = {
                order = 1,
                name = "Layout",
                type = "select",
                style = "dropdown",
                get = function(info) return info.handler.db.profile.currentLayout end,
                set = "SetLayout",
                values = getLayoutTable,
            },
            test = {
                order = 2,
                name = "Test",
                type = "execute",
                func = "Test",
                width = "half",
            },
            hide = {
                order = 3,
                name = "Hide",
                type = "execute",
                func = function(info)
                    for i = 1, 5 do
                        info.handler["arena" .. i]:OnEvent("PLAYER_ENTERING_WORLD")
                        --RegisterUnitWatch(info.handler["arena" .. i], false)
                    end
                end,
                width = "half",
            },
            dragNotice = {
                order = 4,
                name = "|cffff3300     |T132961:16|t Ctrl+shift+click to drag stuff|r",
                type = "description",
                fontSize = "medium",
                width = 1.5,
            },
            layoutSettingsGroup = {
                order = 5,
                name = "Layout Settings",
                desc = "These settings apply only to the selected layout",
                type = "group",
                args = {},
            },
            globalSettingsGroup = {
                order = 6,
                name = "Global Settings",
                desc = "These settings apply to all layouts",
                type = "group",
                childGroups = "tree",
                args = {
                    framesGroup = {
                        order = 1,
                        name = "Arena Frames",
                        type = "group",
                        args = {
                            statusText = {
                                order = 5,
                                name = "Status Text",
                                type = "group",
                                inline = true,
                                args = {
                                    alwaysShow = {
                                        order = 1,
                                        name = "Always Show",
                                        desc = "If disabled, text only shows on mouseover",
                                        type = "toggle",
                                        get = function(info) return info.handler.db.profile.statusText.alwaysShow end,
                                        set = function(info, val)
                                            info.handler.db.profile.statusText.alwaysShow = val
                                            for i = 1, 5 do
                                                info.handler["arena" .. i]:UpdateStatusTextVisible()
                                            end
                                        end,
                                    },
                                    usePercentage = {
                                        order = 2,
                                        name = "Use Percentage",
                                        type = "toggle",
                                        get = function(info) return info.handler.db.profile.statusText.usePercentage end,
                                        set = function(info, val)
                                            info.handler.db.profile.statusText.usePercentage = val

                                            local _, instanceType = IsInInstance()
                                            if (instanceType ~= "arena" and info.handler.arena1:IsShown()) then
                                                info.handler:Test()
                                            end
                                        end,
                                    },
                                },
                            },
                            misc = {
                                order = 6,
                                name = "Miscellaneous",
                                type = "group",
                                inline = true,
                                args = {
                                    classColors = {
                                        order = 1,
                                        name = "Use Class Colors",
                                        desc = "When disabled, health bars will be green",
                                        type = "toggle",
                                        width = "full",
                                        get = function(info) return info.handler.db.profile.classColors end,
                                        set = function(info, val)
                                            local db = info.handler.db
                                            db.profile.classColors = val

                                            for i = 1, 5 do
                                                local frame = info.handler["arena" .. i]
                                                local class = frame.tempClass
                                                local color = RAID_CLASS_COLORS[class]

                                                if val and color then
                                                    frame.HealthBar:SetStatusBarColor(color.r, color.g, color.b, 1)
                                                else
                                                    frame.HealthBar:SetStatusBarColor(0, 1, 0, 1)
                                                end
                                            end
                                        end,
                                    },
                                    showDecimalsClassIcon = {
                                        order = 2,
                                        name = "Show Decimals on Class Icon",
                                        desc = "Show Decimals on Class Icon when duration is below 6 seconds.\n\nOnly for non-OmniCC users.",
                                        type = "toggle",
                                        width = "full",
                                        get = function(info) return info.handler.db.profile.showDecimalsClassIcon end,
                                        set = function(info, val)
                                            info.handler.db.profile.showDecimalsClassIcon = val
                                            info.handler:SetupCustomCD()
                                        end
                                    },
                                    showNames = {
                                        order = 3,
                                        name = "Show Names",
                                        type = "toggle",
                                        width = "full",
                                        get = function(info) return info.handler.db.profile.showNames end,
                                        set = function(info, val)
                                            info.handler.db.profile.showNames = val
                                            info.handler.db.profile.showArenaNumber = false
                                            for i = 1, 5 do
                                                local frame = info.handler["arena" .. i]
                                                frame.Name:SetShown(val)
                                                frame.Name:SetText(frame.tempName or "name")
                                            end
                                        end,
                                    },
                                    showArenaNumber = {
                                        order = 4,
                                        name = "Show Arena Number",
                                        type = "toggle",
                                        width = "full",
                                        get = function(info) return info.handler.db.profile.showArenaNumber end,
                                        set = function(info, val)
                                            info.handler.db.profile.showArenaNumber = val
                                            info.handler.db.profile.showNames = false
                                            for i = 1, 5 do
                                                info.handler["arena" .. i].Name:SetShown(val)
                                                info.handler["arena" .. i].Name:SetText("arena"..i)
                                            end
                                        end,
                                    },
                                    hideClassIcon = {
                                        order = 5,
                                        name = "Hide Class Icon",
                                        type = "toggle",
                                        width = "full",
                                        desc = "Hide the Class Icon and only show Auras when they are active.",
                                        get = function(info) return info.handler.db.profile.hideClassIcon end,
                                        set = function(info, val)
                                            info.handler.db.profile.hideClassIcon = val
                                            for i = 1, 5 do
                                                if val then
                                                    info.handler["arena" .. i].ClassIcon:SetTexture(nil)
                                                else
                                                    if info.handler["arena" .. i].replaceClassIcon then
                                                        info.handler["arena" .. i].ClassIcon:SetTexture(info.handler["arena" .. i].tempSpecIcon)
                                                    else
                                                        info.handler["arena" .. i].ClassIcon:SetTexture("Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES", true)
                                                    end
                                                end
                                            end
                                        end,
                                    },
                                    colorTrinket = {
                                        order = 6,
                                        name = "Color Trinket",
                                        type = "toggle",
                                        width = "full",
                                        desc = "Replace Trinket texture with a solid green color when it's up and red when it's on cooldown.",
                                        get = function(info) return info.handler.db.profile.colorTrinket end,
                                        set = function(info, val)
                                            info.handler.db.profile.colorTrinket = val
                                            for i = 1, 5 do
                                                if val then
                                                    if i <= 2 then
                                                        info.handler["arena" .. i].Trinket.Texture:SetColorTexture(0,1,0)
                                                        info.handler["arena" .. i].Trinket.Cooldown:Clear()
                                                    else
                                                        info.handler["arena" .. i].Trinket.Texture:SetColorTexture(1,0,0)
                                                    end
                                                else
                                                    info.handler["arena" .. i].Trinket.Texture:SetTexture(133453)
                                                end
                                            end
                                        end,
                                    },
                                },
                            },
                            masque = {
                                order = 7,
                                name = "Masque",
                                type = "group",
                                inline = true,
                                args = {
                                    enableMasque = {
                                        order = 1,
                                        name = "Enable Masque Support",
                                        desc = "Click to enable Masque support to reskin Icon borders.",
                                        type = "toggle",
                                        width = "full",
                                        get = function(info) return info.handler.db.profile.enableMasque end,
                                        set = function(info, val)
                                            info.handler.db.profile.enableMasque = val
                                            info.handler:AddMasqueSupport()
                                            info.handler:Test()
                                        end
                                    },
                                },
                            },
                        },
                    },
                    drGroup = {
                        order = 2,
                        name = "Diminishing Returns",
                        type = "group",
                        args = {
                            drOptions = {
                                order = 1,
                                type = "group",
                                name = "Options",
                                inline = true,
                                args = {
                                    drResetTime = {
                                        order = 1,
                                        name = "DR Reset Time",
                                        desc = "Blizzard uses a dynamic timer for DR resets, typically ranging between 15 and 20 seconds.\n\nSetting this to 20 seconds is the safest option, but you can lower it slightly (e.g., 18.5) for more aggressive tracking.",
                                        type = "range",
                                        min = 15,
                                        max = 20,
                                        step = 0.1,
                                        bigStep = 0.5,
                                        get = function(info)
                                            return info.handler.db.profile.drResetTime or 20
                                        end,
                                        set = function(info, val)
                                            info.handler.db.profile.drResetTime = val
                                            info.handler:UpdateDRTimeSetting()
                                        end,
                                    },
                                    showDecimalsDR = {
                                        order = 2,
                                        name = "Show Decimals on DR's",
                                        desc = "Show Decimals on DR's when duration is below 6 seconds.\n\nOnly for non-OmniCC users.",
                                        type = "toggle",
                                        width = "full",
                                        get = function(info) return info.handler.db.profile.showDecimalsDR end,
                                        set = function(info, val)
                                            info.handler.db.profile.showDecimalsDR = val
                                            info.handler:SetupCustomCD()
                                        end
                                    },
                                    invertDRCooldown = {
                                        order = 3,
                                        name = "Reverse Swipe Animation",
                                        desc = "Reverses the DR cooldown swipe direction.",
                                        type = "toggle",
                                        width = "full",
                                        get = function(info) return info.handler.db.profile.invertDRCooldown end,
                                        set = function(info, val)
                                            info.handler.db.profile.invertDRCooldown = val
                                            for i = 1, 5 do
                                                info.handler["arena" .. i]:UpdateDRCooldownReverse()
                                            end
                                        end
                                    },
                                    drSwipeOff = {
                                        order = 4,
                                        name = "Disable Swipe Animation",
                                        desc = "Disables the spiral cooldown swipe on DR icons.",
                                        type = "toggle",
                                        width = "full",
                                        get = function(info)
                                            return info.handler.db.profile.drSwipeOff
                                        end,
                                        set = function(info, val)
                                            info.handler.db.profile.drSwipeOff = val
                                            info.handler:UpdateGlobalDRSettings()
                                        end,
                                    },
                                    drTextOn = {
                                        order = 5,
                                        name = "Show DR Text",
                                        desc = "Show text on DR icons displaying the current DR status.",
                                        type = "toggle",
                                        width = "full",
                                        get = function(info)
                                            return info.handler.db.profile.drTextOn
                                        end,
                                        set = function(info, val)
                                            info.handler.db.profile.drTextOn = val
                                            info.handler:UpdateGlobalDRSettings()
                                        end,
                                    },
                                    disableDRBorder = {
                                        order = 6,
                                        name = "Disable DR Border",
                                        type = "toggle",
                                        width = "full",
                                        get = function(info) return info.handler.db.profile.disableDRBorder end,
                                        set = function(info, val)
                                            info.handler.db.profile.disableDRBorder = val
                                            info.handler:SetDRBorderShownStatus()
                                            info.handler:Test()
                                        end
                                    },
                                },
                            },
                            categories = {
                                order = 2,
                                name = "Categories",
                                type = "multiselect",
                                get = function(info, key) return info.handler.db.profile.drCategories[key] end,
                                set = function(info, key, val) info.handler.db.profile.drCategories[key] = val end,
                                values = drCategories,
                            },
                        },
                    },
                    racialGroup = {
                        order = 3,
                        name = "Racials",
                        type = "group",
                        args = {
                            categories = {
                                order = 1,
                                name = "Categories",
                                type = "multiselect",
                                get = function(info, key) return info.handler.db.profile.racialCategories[key] end,
                                set = function(info, key, val) info.handler.db.profile.racialCategories[key] = val end,
                                values = racialCategories,
                            },
                            racialOptions = {
                                order = 1,
                                type = "group",
                                name = "Options",
                                inline = true,
                                args = {
                                    swapHumanTrinket = {
                                        order = 1,
                                        name = "Swap Trinket with Human Racial",
                                        desc = "Swap the Trinket texture with Human Racial for Humans and hide the Racial Icon.",
                                        type = "toggle",
                                        width = "full",
                                        get = function(info) return info.handler.db.profile.swapHumanTrinket end,
                                        set = function(info, val)
                                            info.handler.db.profile.swapHumanTrinket = val
                                        end,
                                    },
                                }
                            }
                        },
                    },
                },
            },
            oldConvert = {
                order = 7,
                name = "Old sArena",
                desc = "Converter for old sArena",
                type = "group",
                args = {
                    description = {
                        order = 1,
                        type = "description",
                        name = "This will import your old sArena settings into the new sArena |cff00ff96MoP Classic|r version.\n\nMake sure both addons are enabled, then click the button below.",
                        fontSize = "medium",
                    },
                    convertButton = {
                        order = 2,
                        type = "execute",
                        name = "Convert Settings",
                        func = sArenaMixin.OldConvert,
                        width = "normal",
                    },
                },
            },
        },
    }
end

