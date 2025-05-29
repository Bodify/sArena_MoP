local layoutName = "Gladiuish"
local layout = {}

layout.defaultSettings = {
    posX = 355,
    posY = 131,
    scale = 1.2,
    classIconFontSize = 14,
    spacing = 35,
    growthDirection = 1,
    specIcon = {
        posX = -21,
        posY = -2,
        scale = 1,
    },
    trinket = {
        posX = 104,
        posY = 0,
        scale = 1,
        fontSize = 14,
    },
    racial = {
        posX = 180,
        posY = 0,
        scale = 0.8,
        fontSize = 14,
    },
    castBar = {
        posX = 1,
        posY = -20.5,
        scale = 1.6,
        width = 103,
    },
    dr = {
        posX = -101,
        posY = 0,
        size = 28,
        borderSize = 2.5,
        fontSize = 12,
        spacing = 6,
        growthDirection = 4,
    },
    statusText = {
        usePercentage = true,
        alwaysShow = true,
    },

    -- custom layout settings
    width = 168,
    height = 44,
    powerBarHeight = 9,
    mirrored = true,
    classicBars = false,
    fontPrototype = true,
    replaceClassIcon = true,
    showSpecManaText = true,
}

local function getSetting(info)
    return layout.db[info[#info]]
end

local function setSetting(info, val)
    layout.db[info[#info]] = val

    for i = 1, 5 do
        local frame = info.handler["arena" .. i]
        frame:SetSize(layout.db.width, layout.db.height)
        frame.ClassIcon:SetSize(layout.db.height, layout.db.height)
        frame.DeathIcon:SetSize(layout.db.height * 0.8, layout.db.height * 0.8)
        frame.PowerBar:SetHeight(layout.db.powerBarHeight)
        layout:UpdateOrientation(frame)
        layout:UpdateTextures(frame)
        layout:UpdateTextures(frame)
    end
    sArenaMixin:RefreshConfig()
end

local function setupOptionsTable(self)
    layout.optionsTable = self:GetLayoutOptionsTable(layoutName)

    layout.optionsTable.arenaFrames.args.positioning.args.mirrored = {
        order = 5,
        name = "Mirrored Frames",
        type = "toggle",
        width = "full",
        get = getSetting,
        set = setSetting,
    }

    layout.optionsTable.arenaFrames.args.sizing.args.width = {
        order = 3,
        name = "Width",
        type = "range",
        min = 40,
        max = 400,
        step = 1,
        get = getSetting,
        set = setSetting,
    }

    layout.optionsTable.arenaFrames.args.sizing.args.height = {
        order = 4,
        name = "Height",
        type = "range",
        min = 2,
        max = 100,
        step = 1,
        get = getSetting,
        set = setSetting,
    }

    layout.optionsTable.arenaFrames.args.sizing.args.powerBarHeight = {
        order = 5,
        name = "Power Bar Height",
        type = "range",
        min = 1,
        max = 50,
        step = 1,
        get = getSetting,
        set = setSetting,
    }

    layout.optionsTable.arenaFrames.args.other = {
        order = 0.5,
        name = "Other",
        type = "group",
        inline = true,
        args = {
            replaceClassIcon = {
                order = 1,
                name = "Replace Class Icon",
                desc = "Replace Class Icon with Spec Icon",
                type = "toggle",
                get = getSetting,
                set = setSetting,
            },
            showSpecManaText = {
                order = 2,
                name = "Spec Text on Manabar",
                type = "toggle",
                get = getSetting,
                set = setSetting,
            },
            fontPrototype = {
                order = 3,
                name = "Prototype Font",
                desc = "Use Prototype Font",
                type = "toggle",
                get = getSetting,
                set = setSetting,
            },
            classicBars = {
                order = 4,
                name = "Classic Bar Textures",
                type = "toggle",
                get = getSetting,
                set = setSetting,
            },
        }
    }
end

function layout:Initialize(frame)
    self.db = frame.parent.db.profile.layoutSettings[layoutName]
    sArenaMixin.useSpecClassIcon = true

    if (not self.optionsTable) then
        setupOptionsTable(frame.parent)
    end

    if (frame:GetID() == 5) then
        frame.parent:UpdateCastBarSettings(self.db.castBar)
        frame.parent:UpdateDRSettings(self.db.dr)
        frame.parent:UpdateFrameSettings(self.db)
        frame.parent:UpdateSpecIconSettings(self.db.specIcon)
        frame.parent:UpdateTrinketSettings(self.db.trinket)
        frame.parent:UpdateRacialSettings(self.db.racial)
    end

    self:UpdateOrientation(frame)

    frame:SetSize(self.db.width, self.db.height)
    frame.SpecIcon:SetSize(22, 22)
    frame.Trinket:SetSize(41, 41)
    frame.Racial:SetSize(41, 41)
    frame.Name:SetTextColor(1,1,1)
    frame.SpecNameText:SetTextColor(1,1,1)

    frame.Trinket.Cooldown:SetSwipeTexture(1)
    frame.Trinket.Cooldown:SetSwipeColor(0, 0, 0, 0.6)


    frame.PowerBar:SetHeight(self.db.powerBarHeight)

    frame.ClassIcon:SetSize(self.db.height-4, self.db.height-4)
    frame.ClassIcon:Show()

    local f = frame.Name
    f:SetJustifyH("LEFT")
    f:SetFontObject("Game10Font_o1")
    f:SetPoint("LEFT", frame.HealthBar, "LEFT", 3, -1)
    f:SetHeight(12)



    f = frame.DeathIcon
    f:ClearAllPoints()
    f:SetPoint("CENTER", frame.HealthBar, "CENTER", 0, -1)
    f:SetSize(self.db.height * 0.8, self.db.height * 0.8)

    frame.HealthText:SetPoint("RIGHT", frame.HealthBar, "RIGHT", 0, -1)
    frame.HealthText:SetShadowOffset(0, 0)

    frame.PowerText:SetPoint("CENTER", frame.PowerBar)
    frame.PowerText:SetShadowOffset(0, 0)
    frame.PowerText:SetAlpha(0)

    frame.SpecNameText:SetPoint("LEFT", frame.PowerBar, "LEFT", 3, 0)
    if not self.db.fontPrototype then
        local f,s,o = frame.SpecNameText:GetFont()
        frame.SpecNameText:SetFont(f,9,"THINOUTLINE")
    end
    --frame.CastBar.Text:SetFontObject("Game10Font_o1")

    -- Health bar underlay
    if not frame.hpUnderlay then
        frame.hpUnderlay = frame:CreateTexture(nil, "BACKGROUND", nil, 1)
        frame.hpUnderlay:SetPoint("TOPLEFT", frame.HealthBar, "TOPLEFT")
        frame.hpUnderlay:SetPoint("BOTTOMRIGHT", frame.HealthBar, "BOTTOMRIGHT")
        frame.hpUnderlay:SetColorTexture(0, 0, 0, 0.65)
        frame.hpUnderlay:Show()
    end

    -- Power bar underlay
    if not frame.ppUnderlay then
        frame.ppUnderlay = frame:CreateTexture(nil, "BACKGROUND", nil, 1)
        frame.ppUnderlay:SetPoint("TOPLEFT", frame.PowerBar, "TOPLEFT")
        frame.ppUnderlay:SetPoint("BOTTOMRIGHT", frame.PowerBar, "BOTTOMRIGHT")
        frame.ppUnderlay:SetColorTexture(0, 0, 0, 0.65)
        frame.ppUnderlay:Show()
    end

    self:UpdateTextures(frame)
end

function layout:UpdateOrientation(frame)
    local healthBar = frame.HealthBar
    local powerBar = frame.PowerBar
    local classIcon = frame.ClassIcon

    healthBar:ClearAllPoints()
    powerBar:ClearAllPoints()
    classIcon:ClearAllPoints()
    frame.ClassIcon:SetSize(self.db.height-4, self.db.height-4)

    if (self.db.mirrored) then
        healthBar:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, -2)
        healthBar:SetPoint("BOTTOMLEFT", powerBar, "TOPLEFT")

        powerBar:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 2)
        powerBar:SetPoint("LEFT", classIcon, "RIGHT", 0, 0)

        classIcon:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, -2)
    else
        healthBar:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, -2)
        healthBar:SetPoint("BOTTOMRIGHT", powerBar, "TOPRIGHT")

        powerBar:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0, 2)
        powerBar:SetPoint("RIGHT", classIcon, "LEFT", 0, 0)

        classIcon:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, -2)
    end
end

function layout:UpdateTextures(frame)
    local texture = self.db.classicBars and "Interface\\TargetingFrame\\UI-StatusBar" or
        "Interface\\RaidFrame\\Raid-Bar-Hp-Fill"

    frame.CastBar.typeInfo = {
        filling = texture,
        full = texture,
        glow = texture
    }
    frame.CastBar:SetStatusBarTexture(texture)
    frame.HealthBar:SetStatusBarTexture(texture)
    frame.PowerBar:SetStatusBarTexture(texture)
end


sArenaMixin.layouts[layoutName] = layout
sArenaMixin.defaultSettings.profile.layoutSettings[layoutName] = layout.defaultSettings