sArenaMixin = {}
sArenaFrameMixin = {}

sArenaMixin.layouts = {}
sArenaMixin.defaultSettings = {
    profile = {
        currentLayout = "Gladiuish",
        classColors = true,
        showNames = true,
        showArenaNumber = false,
        showDecimalsDR = true,
        showDecimalsClassIcon = true,
        statusText = {
            usePercentage = false,
            alwaysShow = true,
        },
        layoutSettings = {},
    }
}

sArenaMixin.pFont = "Interface\\AddOns\\sArena_MoP\\Prototype.ttf"

local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local UnitGUID = UnitGUID
local GetTime = GetTime
local UnitHealthMax = UnitHealthMax
local UnitHealth = UnitHealth
local UnitPowerMax = UnitPowerMax
local UnitPower = UnitPower
local UnitPowerType = UnitPowerType
local UnitIsDeadOrGhost = UnitIsDeadOrGhost
local testActive
local masqueOn
local TestTitle

function sArenaMixin:OldConvert()
    local oldDB = sArena3DB or sArena2DB or sArenaDB

    if not oldDB or not oldDB.profileKeys or not oldDB.profiles then
        print("No old sArena found. Are you sure it's enabled?")
        return
    end

    local newDB = sArena_MoPDB

    if not newDB.profileKeys then newDB.profileKeys = {} end
    if not newDB.profiles then newDB.profiles = {} end

    -- Migrate profileKeys
    for character, profileName in pairs(oldDB.profileKeys) do
        local newProfileName = profileName .. "(MoP-Imported)"
        newDB.profileKeys[character] = newProfileName

        -- Copy profile if it doesn't already exist
        if oldDB.profiles[profileName] and not newDB.profiles[newProfileName] then
            newDB.profiles[newProfileName] = CopyTable(oldDB.profiles[profileName])
        end
    end

    C_AddOns.DisableAddOn("sArena")
    sArena_MoPDB.reOpenOptions = true
    ReloadUI()
end

sArenaMixin.classIcons = {
    -- UpperLeftx, UpperLefty, LowerLeftx, LowerLefty, UpperRightx, UpperRighty, LowerRightx, LowerRighty
    ["WARRIOR"] = { 0, 0, 0, 0.25, 0.25, 0, 0.25, 0.25 },
    ["ROGUE"] = { 0.5, 0, 0.5, 0.25, 0.75, 0, 0.75, 0.25 },
    ["DRUID"] = { 0.75, 0, 0.75, 0.25, 1, 0, 1, 0.25 },
    ["WARLOCK"] = { 0.75, 0.25, 0.75, 0.5, 1, 0.25, 1, 0.5 },
    ["HUNTER"] = { 0, 0.25, 0, 0.5, 0.25, 0.25, 0.25, 0.5 },
    ["PRIEST"] = { 0.5, 0.25, 0.5, 0.5, 0.75, 0.25, 0.75, 0.5 },
    ["PALADIN"] = { 0, 0.5, 0, 0.75, 0.25, 0.5, 0.25, 0.75 },
    ["SHAMAN"] = { 0.25, 0.25, 0.25, 0.5, 0.5, 0.25, 0.5, 0.5 },
    ["MAGE"] = { 0.25, 0, 0.25, 0.25, 0.5, 0, 0.5, 0.25 },
    ["DEATHKNIGHT"] = { 0.25, 0.5, 0.25, 0.75, 0.5, 0.5, 0.50, 0.75 },
    ["MONK"] = { 0.5,  0.5,  0.5,  0.75, 0.75, 0.5,  0.75, 0.75 },
}

sArenaMixin.croppedClassIcons = {
    ["WARRIOR"]     = { 0.02, 0.02, 0.02, 0.23, 0.23, 0.02, 0.23, 0.23 },
    ["ROGUE"]       = { 0.52, 0.02, 0.52, 0.23, 0.73, 0.02, 0.73, 0.23 },
    ["DRUID"]       = { 0.77, 0.02, 0.77, 0.23, 0.98, 0.02, 0.98, 0.23 },
    ["WARLOCK"]     = { 0.77, 0.27, 0.77, 0.48, 0.98, 0.27, 0.98, 0.48 },
    ["HUNTER"]      = { 0.02, 0.27, 0.02, 0.48, 0.23, 0.27, 0.23, 0.48 },
    ["PRIEST"]      = { 0.52, 0.27, 0.52, 0.48, 0.73, 0.27, 0.73, 0.48 },
    ["PALADIN"]     = { 0.02, 0.52, 0.02, 0.73, 0.23, 0.52, 0.23, 0.73 },
    ["SHAMAN"]      = { 0.27, 0.27, 0.27, 0.48, 0.48, 0.27, 0.48, 0.48 },
    ["MAGE"]        = { 0.27, 0.02, 0.27, 0.23, 0.48, 0.02, 0.48, 0.23 },
    ["DEATHKNIGHT"] = { 0.27, 0.52, 0.27, 0.73, 0.48, 0.52, 0.48, 0.73 },
    ["MONK"]        = { 0.52, 0.52, 0.52, 0.73, 0.73, 0.52, 0.73, 0.73 },
}

local db
local emptyLayoutOptionsTable = {
    notice = {
        name = "The selected layout doesn't appear to have any settings.",
        type = "description",
    }
}
local blizzFrame

local function UpdateBlizzVisibility(instanceType)
    -- Hide Blizzard Arena Frames while in Arena
    if (InCombatLockdown()) then return end
    if (not C_AddOns.IsAddOnLoaded("Blizzard_ArenaUI")) then return end

    if (not blizzFrame) then
        blizzFrame = CreateFrame("Frame")
        blizzFrame:Hide()
    end

    local prepFrame = _G["ArenaPrepFrames"]
    local enemyFrame = _G["ArenaEnemyFrames"]
    if prepFrame then
        prepFrame:SetParent(blizzFrame)
    end
    if enemyFrame then
        enemyFrame:SetParent(blizzFrame)
    end
end

function sArenaMixin:HandleArenaStart()
    for i = 1, 5 do
        local frame = self["arena" .. i]
        if frame:IsShown() then break end
        if UnitExists("arena"..i) then
            frame:UpdateVisible()
            frame:UpdatePlayer("seen")
        end
    end
end

local matchStartedMessages = {
    ["The Arena battle has begun!"] = true, -- English / Default
    ["¡La batalla en arena ha comenzado!"] = true, -- esES / esMX
    ["A batalha na Arena começou!"] = true, -- ptBR
    ["Der Arenakampf hat begonnen!"] = true, -- deDE
    ["Le combat d'arène commence\194\160!"] = true, -- frFR
    ["Бой начался!"] = true, -- ruRU
    ["투기장 전투가 시작되었습니다!"] = true, -- koKR
    ["竞技场战斗开始了！"] = true, -- zhCN
    ["竞技场的战斗开始了！"] = true, -- zhCN (Wotlk)
    ["競技場戰鬥開始了！"] = true, -- zhTW
}

local function IsMatchStartedMessage(msg)
    return matchStartedMessages[msg]
end

-- Parent Frame
function sArenaMixin:OnLoad()
    self:RegisterEvent("PLAYER_LOGIN")
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
end

local combatEvents = {
    ["SPELL_CAST_SUCCESS"] = true,
    ["SPELL_AURA_APPLIED"] = true,
    ["SPELL_INTERRUPT"] = true,
    ["SPELL_AURA_REMOVED"] = true,
    ["SPELL_AURA_BROKEN"] = true,
    ["SPELL_AURA_REFRESH"] = true,
}

function sArenaMixin:OnEvent(event, ...)
    if (event == "COMBAT_LOG_EVENT_UNFILTERED") then
        local _, combatEvent, _, sourceGUID, _, _, _, destGUID, _, _, _, spellID, _, _, auraType =CombatLogGetCurrentEventInfo()
        if not combatEvents[combatEvent] then return end
        for i = 1, 5 do

            if (sourceGUID == UnitGUID("arena" .. i)) then
                local ArenaFrame = self["arena" .. i]
                ArenaFrame:FindRacial(combatEvent, spellID)
                ArenaFrame:FindTrinket(combatEvent, spellID)
            end

            if (destGUID == UnitGUID("arena" .. i)) then
                local ArenaFrame = self["arena" .. i]
                ArenaFrame:FindInterrupt(combatEvent, spellID)

                if (auraType == "DEBUFF") then
                    ArenaFrame:FindDR(combatEvent, spellID)
                end
            end
        end
    elseif (event == "PLAYER_LOGIN") then
        self:Initialize()
        self:SetupCastColor()
        self:SetupGrayTrinket()
        self:AddMasqueSupport()
        self:SetupCustomCD()
        self:SetDRBorderShownStatus()
        if sArena_MoPDB.reOpenOptions then
            sArena_MoPDB.reOpenOptions = nil
            C_Timer.After(0.5, function()
                LibStub("AceConfigDialog-3.0"):Open("sArena")
            end)
        end
        self:UnregisterEvent("PLAYER_LOGIN")
    elseif (event == "PLAYER_ENTERING_WORLD") then
        local _, instanceType = IsInInstance()
        UpdateBlizzVisibility(instanceType)
        self:SetMouseState(true)

        if (instanceType == "arena") then
            if TestTitle then
                TestTitle:Hide()
            end
            self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
            self:RegisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL")
        else
            self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
            self:UnregisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL")
        end
    elseif event == "CHAT_MSG_BG_SYSTEM_NEUTRAL" then
        local msg = ...
        if IsMatchStartedMessage(msg) then
            C_Timer.After(0.5, function()
                self:HandleArenaStart()
            end)
        end
    end
end

local function ChatCommand(input)
    if not input or input:trim() == "" then
        LibStub("AceConfigDialog-3.0"):Open("sArena")
    elseif input:trim():lower() == "convert" then
        sArenaMixin:OldConvert()
    else
        LibStub("AceConfigCmd-3.0").HandleCommand("sArena", "sarena", "sArena", input)
    end
end

function sArenaMixin:Initialize()
    if (db) then return end

    if C_AddOns.IsAddOnLoaded("sArena") and not db then
        C_Timer.After(5, function()
            print("Disable normal sArena to use sArena |cff00ff96MoP Classic|r|A:raceicon-pandaren-male:16:16|a")
        end)
    end

    self.db = LibStub("AceDB-3.0"):New("sArena_MoPDB", self.defaultSettings, true)
    db = self.db

    self:UpdateDRTimeSetting()

    db.RegisterCallback(self, "OnProfileChanged", "RefreshConfig")
    db.RegisterCallback(self, "OnProfileCopied", "RefreshConfig")
    db.RegisterCallback(self, "OnProfileReset", "RefreshConfig")
    self.optionsTable.handler = self
    self.optionsTable.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(db)
    LibStub("AceConfig-3.0"):RegisterOptionsTable("sArena", self.optionsTable)
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions("sArena", "sArena |cff00ff96MoP|r|A:raceicon-pandaren-male:16:16|a")
    LibStub("AceConfigDialog-3.0"):SetDefaultSize("sArena", 700, 620)
    LibStub("AceConsole-3.0"):RegisterChatCommand("sarena", ChatCommand)

    self:SetLayout(_, db.profile.currentLayout)
end

function sArenaMixin:RefreshConfig()
    self:SetLayout(_, db.profile.currentLayout)
end


function sArenaMixin:ApplyPrototypeFont(frame)
    local enable = db.profile.layoutSettings[db.profile.currentLayout].fontPrototype

    if not enable and (not frame.changedFonts or next(frame.changedFonts) == nil) then
        return
    end

    if not frame.changedFonts then
        frame.changedFonts = {}
    end

    local function updateFont(obj, newSize, newFlags)
        if not obj then return end

        local currentFont, currentSize, currentFlags = obj:GetFont()

        if enable then
            -- Save original font only once
            if not frame.changedFonts[obj] then
                frame.changedFonts[obj] = { currentFont, currentSize, currentFlags }
            end

            obj:SetFont(sArenaMixin.pFont, newSize or currentSize, newFlags or currentFlags)
        else
            local original = frame.changedFonts[obj]
            if original then
                obj:SetFont(unpack(original))
                frame.changedFonts[obj] = nil
            end
        end
    end

    updateFont(frame.Name)
    updateFont(frame.SpecNameText, 9, "THINOUTLINE")
    updateFont(frame.HealthText)
    updateFont(frame.PowerText)
    updateFont(frame.CastBar and frame.CastBar.Text, nil, "THINOUTLINE")
end

function sArenaMixin:SetupCastColor()
    for i = 1, 5 do
        local frame = self["arena" .. i]
        local castBar = frame.CastBar
        castBar:HookScript("OnEvent", function(self)
            if self.BorderShield:IsShown() then
                self:SetStatusBarColor(0.7, 0.7, 0.7, 1)
            end
        end)
        castBar.BorderShield:ClearAllPoints()
        castBar.BorderShield:SetPoint("CENTER", castBar.Icon, "CENTER", 8, -1)
    end
end

function sArenaFrameMixin:SetTextureCrop(texture, crop)
    if not texture then return end
    if crop then
        texture:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    else
        texture:SetTexCoord(0, 1, 0, 1)
    end
end

function sArenaMixin:SetupGrayTrinket()
    for i = 1, 5 do
        local frame = self["arena" .. i]
        local cooldown = frame.Trinket.Cooldown
        cooldown:HookScript("OnCooldownDone", function()
            frame.Trinket.Texture:SetDesaturated(false)
        end)
    end
end


function sArenaMixin:CreateCustomCooldown(cooldown, showDecimals)
    local text = cooldown.sArenaText or cooldown:CreateFontString(nil, "OVERLAY", "NumberFontNormal")
    if not cooldown.sArenaText then
        cooldown.sArenaText = text

        local f, s, o = cooldown.Text:GetFont()
        text:SetFont(f, s, o)

        local r, g, b, a = cooldown.Text:GetShadowColor()
        local x, y = cooldown.Text:GetShadowOffset()
        text:SetShadowColor(r, g, b, a)
        text:SetShadowOffset(x, y)

        text:SetPoint("CENTER", cooldown, "CENTER", 0, -1)
        text:SetJustifyH("CENTER")
        text:SetJustifyV("MIDDLE")
    end

    cooldown:SetHideCountdownNumbers(showDecimals)

    if showDecimals then
        cooldown:SetScript("OnUpdate", function()
            local start, duration = cooldown:GetCooldownTimes()
            start, duration = start / 1000, duration / 1000
            local remaining = (start + duration) - GetTime()

            if remaining > 0 then
                if remaining < 6 then
                    text:SetFormattedText("%.1f", remaining)
                elseif remaining < 60 then
                    text:SetFormattedText("%d", remaining)
                elseif remaining < 3600 then
                    local m, s = math.floor(remaining / 60), math.floor(remaining % 60)
                    text:SetFormattedText("%d:%02d", m, s)
                else
                    text:SetFormattedText("%dh", math.floor(remaining / 3600))
                end
            else
                text:SetText("")
            end
        end)
    else
        cooldown:SetScript("OnUpdate", nil)
        text:SetText(nil)
    end
end

function sArenaMixin:SetupCustomCD()
    if C_AddOns.IsAddOnLoaded("OmniCC") then return end

    for i = 1, 5 do
        local frame = self["arena" .. i]

        -- Class icon cooldown
        self:CreateCustomCooldown(frame.ClassIconCooldown, self.db.profile.showDecimalsClassIcon)

        -- DR frames
        for _, category in ipairs(self.drCategories) do
            local drFrame = frame[category]
            if drFrame and drFrame.Cooldown then
                self:CreateCustomCooldown(drFrame.Cooldown, self.db.profile.showDecimalsDR)
            end
        end
    end
end

function sArenaMixin:SetDRBorderShownStatus()
    for i = 1, 5 do
        local frame = self["arena" .. i]
        -- DR frames
        for _, category in ipairs(self.drCategories) do
            local drFrame = frame[category]
            if drFrame then
                if self.db.profile.disableDRBorder then
                    drFrame.Border:Hide()
                    drFrame.Border.hidden = true
                elseif drFrame.Border.hidden then
                    drFrame.Border:Show()
                    drFrame.Border.hidden = nil
                end
            end
        end
    end
end

function sArenaMixin:SetLayout(_, layout)
    if (InCombatLockdown()) then return end

    if not self.db then
        self.db = db
    end
    if not self.arena1 then
        for i = 1, 5 do
            local globalName = "sArenaEnemyFrame" .. i
            self["arena" .. i] = _G[globalName]
        end
    end

    layout = sArenaMixin.layouts[layout] and layout or "Gladiuish"

    db.profile.currentLayout = layout
    self.layoutdb = self.db.profile.layoutSettings[layout]

    self:RemovePixelBorders()

    for i = 1, 5 do
        local frame = self["arena" .. i]
        frame:ResetLayout()
        self.layouts[layout]:Initialize(frame)
        frame:UpdatePlayer()
        sArenaMixin:ApplyPrototypeFont(frame)
        frame:UpdateDRCooldownReverse()
    end

    self.optionsTable.args.layoutSettingsGroup.args = self.layouts[layout].optionsTable and
        self.layouts[layout].optionsTable or emptyLayoutOptionsTable
    LibStub("AceConfigRegistry-3.0"):NotifyChange("sArena")

    local _, instanceType = IsInInstance()
    if (instanceType ~= "arena" and self.arena1:IsShown()) then
        self:Test()
    end
end

function sArenaMixin:SetupDrag(frameToClick, frameToMove, settingsTable, updateMethod)
    frameToClick:HookScript("OnMouseDown", function()
        if (InCombatLockdown()) then return end

        if (IsShiftKeyDown() and IsControlKeyDown() and not frameToMove.isMoving) then
            frameToMove:StartMoving()
            frameToMove.isMoving = true
        end
    end)

    frameToClick:HookScript("OnMouseUp", function()
        if (InCombatLockdown()) then return end

        if (frameToMove.isMoving) then
            frameToMove:StopMovingOrSizing()
            frameToMove.isMoving = false

            local settings = db.profile.layoutSettings[db.profile.currentLayout]

            if (settingsTable) then
                settings = settings[settingsTable]
            end

            local parentX, parentY = frameToMove:GetParent():GetCenter()
            local frameX, frameY = frameToMove:GetCenter()
            local scale = frameToMove:GetScale()

            frameX = ((frameX * scale) - parentX) / scale
            frameY = ((frameY * scale) - parentY) / scale

            -- Round to 1 decimal place
            frameX = floor(frameX * 10 + 0.5) / 10
            frameY = floor(frameY * 10 + 0.5) / 10

            settings.posX, settings.posY = frameX, frameY
            self[updateMethod](self, settings)
            LibStub("AceConfigRegistry-3.0"):NotifyChange("sArena")
        end
    end)
end

function sArenaMixin:SetMouseState(state)
    for i = 1, 5 do
        local frame = self["arena" .. i]
        frame.CastBar:EnableMouse(state)
        for i = 1, #self.drCategories do
            frame[self.drCategories[i]]:EnableMouse(state)
        end
        frame.SpecIcon:EnableMouse(state)
        frame.Trinket:EnableMouse(state)
        frame.Racial:EnableMouse(state)
    end
end

-- Arena Frames

local function ResetTexture(texturePool, t)
    if (texturePool) then
        t:SetParent(texturePool.parent)
    end

    t:SetTexture(nil)
    t:SetColorTexture(0, 0, 0, 0)
    t:SetVertexColor(1, 1, 1, 1)
    t:SetDesaturated()
    t:SetTexCoord(0, 1, 0, 1)
    t:ClearAllPoints()
    t:SetSize(0, 0)
    t:Hide()
end

function sArenaFrameMixin:OnLoad()
    local unit = "arena" .. self:GetID()
    self.parent = self:GetParent()

    self:RegisterEvent("PLAYER_LOGIN")
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("UNIT_NAME_UPDATE")
    self:RegisterEvent("ARENA_PREP_OPPONENT_SPECIALIZATIONS")
    self:RegisterEvent("ARENA_COOLDOWNS_UPDATE")
    self:RegisterEvent("ARENA_OPPONENT_UPDATE")
    self:RegisterEvent("ARENA_CROWD_CONTROL_SPELL_UPDATE")
    self:RegisterUnitEvent("UNIT_HEALTH", unit)
    self:RegisterUnitEvent("UNIT_MAXHEALTH", unit)
    self:RegisterUnitEvent("UNIT_POWER_UPDATE", unit)
    self:RegisterUnitEvent("UNIT_MAXPOWER", unit)
    self:RegisterUnitEvent("UNIT_DISPLAYPOWER", unit)
    self:RegisterUnitEvent("UNIT_AURA", unit)

    self:RegisterForClicks("AnyUp")
    self:SetAttribute("*type1", "target")
    self:SetAttribute("*type2", "focus")
    self:SetAttribute("unit", unit)
    self.unit = unit

    CastingBarFrame_SetUnit(self.CastBar, unit, false, true)

    self.healthbar = self.HealthBar

    self.TexturePool = CreateTexturePool(self, "ARTWORK", nil, nil, ResetTexture)
end

function sArenaFrameMixin:OnEvent(event, eventUnit, arg1, arg2)
    local unit = self.unit

    if (eventUnit and eventUnit == unit) then
        if (event == "UNIT_NAME_UPDATE") then
            if (db.profile.showArenaNumber) then
                self.Name:SetText(unit)
            elseif (db.profile.showNames) then
                self.Name:SetText(UnitName(unit))
            end
        elseif (event == "ARENA_OPPONENT_UPDATE") then
            self:UpdatePlayer(arg1)
        elseif (event == "ARENA_COOLDOWNS_UPDATE") then
            -- if DLAPI then DLAPI.DebugLog("ARENA_COOLDOWNS_UPDATE", "ARENA_COOLDOWNS_UPDATE") end
             self:UpdateTrinket(arg1, arg2)
        elseif (event == "ARENA_CROWD_CONTROL_SPELL_UPDATE") then
            -- arg1 == spellID
            if (arg1 ~= self.Trinket.spellID) then
                if arg1 ~= 0 then
                    --local _, spellTextureNoOverride = C_Spell.GetSpellTexture(arg1)
                    self.Trinket.spellID = arg1
                    --self.Trinket.Texture:SetTexture(spellTextureNoOverride)
                    self:UpdateTrinketIcon()
                else
                    self:UpdateTrinketIcon()
                end
            end
        elseif (event == "UNIT_AURA") then
            self:FindAura()
        elseif (event == "UNIT_HEALTH") then
            self:SetLifeState()
            self:SetStatusText()
            local currentHealth = UnitHealth(unit)
            if (currentHealth ~= self.currentHealth) then
                self.HealthBar:SetValue(currentHealth)
                self.currentHealth = currentHealth
            end
        elseif (event == "UNIT_MAXHEALTH") then
            self.HealthBar:SetMinMaxValues(0, UnitHealthMax(unit))
            self.HealthBar:SetValue(UnitHealth(unit))
        elseif (event == "UNIT_POWER_UPDATE") then
            self:SetStatusText()
            self.PowerBar:SetValue(UnitPower(unit))
        elseif (event == "UNIT_MAXPOWER") then
            self.PowerBar:SetMinMaxValues(0, UnitPowerMax(unit))
            self.PowerBar:SetValue(UnitPower(unit))
        elseif (event == "UNIT_DISPLAYPOWER") then
            local _, powerType = UnitPowerType(unit)
            self:SetPowerType(powerType)
            self.PowerBar:SetMinMaxValues(0, UnitPowerMax(unit))
            self.PowerBar:SetValue(UnitPower(unit))
        end
    elseif (event == "PLAYER_LOGIN") then
        self:UnregisterEvent("PLAYER_LOGIN")

        if (not db) then
            self.parent:Initialize()
        end

        self:Initialize()
    elseif (event == "PLAYER_ENTERING_WORLD") or (event == "ARENA_PREP_OPPONENT_SPECIALIZATIONS") then
        self.Name:SetText("")
        self.CastBar:Hide()
        self.specTexture = nil
        self.class = nil
        self.currentClassIconTexture = nil
        self.currentClassIconStartTime = 0
        self:UpdateVisible()
        self:UpdatePlayer()
        self:ResetTrinket()
        self:ResetRacial()
        self:ResetDR()
    elseif (event == "PLAYER_REGEN_ENABLED") then
        self:UnregisterEvent("PLAYER_REGEN_ENABLED")
        self:UpdateVisible()
    end
end

function sArenaFrameMixin:Initialize()
    self:SetMysteryPlayer()
    self.parent:SetupDrag(self, self.parent, nil, "UpdateFrameSettings")
    self.parent:SetupDrag(self.CastBar, self.CastBar, "castBar", "UpdateCastBarSettings")
    self.parent:SetupDrag(self[sArenaMixin.drCategories[1]], self[sArenaMixin.drCategories[1]], "dr", "UpdateDRSettings")
    self.parent:SetupDrag(self.SpecIcon, self.SpecIcon, "specIcon", "UpdateSpecIconSettings")
    self.parent:SetupDrag(self.Trinket, self.Trinket, "trinket", "UpdateTrinketSettings")
    self.parent:SetupDrag(self.Racial, self.Racial, "racial", "UpdateRacialSettings")
end

function sArenaFrameMixin:OnEnter()
    UnitFrame_OnEnter(self)

    self.HealthText:Show()
    self.PowerText:Show()
end

function sArenaFrameMixin:OnLeave()
    UnitFrame_OnLeave(self)

    self:UpdateStatusTextVisible()
end

local function GetNumArenaOpponentsFallback()
    local count = 0
    for i = 1, 5 do
        if UnitExists("arena" .. i) then
            count = count + 1
        end
    end
    return count
end

function sArenaFrameMixin:UpdateVisible()
    if InCombatLockdown() then
        self:RegisterEvent("PLAYER_REGEN_ENABLED")
        return
    end

    local _, instanceType = IsInInstance()
    if instanceType ~= "arena" then
        self:Hide()
        return
    end

    local id = self:GetID()
    local numSpecs = GetNumArenaOpponentSpecs()
    local numOpponents = (numSpecs == 0) and GetNumArenaOpponentsFallback() or numSpecs

    if numOpponents >= id then
        self:Show()
    else
        self:Hide()
    end
end


local function addToMasque(frame, masqueGroup)
    masqueGroup:AddButton(frame)
end

function sArenaMixin:AddMasqueSupport()
    if not self.db.profile.enableMasque or masqueOn or not C_AddOns.IsAddOnLoaded("Masque") then return end
    local Masque = LibStub("Masque", true)
    masqueOn = true

    local sArenaClass = Masque:Group("sArena |cff00ff96MoP Classic|r|A:raceicon-pandaren-male:16:16|a", "Class/Aura")
    local sArenaTrinket = Masque:Group("sArena |cff00ff96MoP Classic|r|A:raceicon-pandaren-male:16:16|a", "Trinket")
    local sArenaSpecIcon = Masque:Group("sArena |cff00ff96MoP Classic|r|A:raceicon-pandaren-male:16:16|a", "SpecIcon")
    local sArenaRacial = Masque:Group("sArena |cff00ff96MoP Classic|r|A:raceicon-pandaren-male:16:16|a", "Racial")
    local sArenaDRs = Masque:Group("sArena |cff00ff96MoP Classic|r|A:raceicon-pandaren-male:16:16|a", "DRs")
    local sArenaFrame = Masque:Group("sArena |cff00ff96MoP Classic|r|A:raceicon-pandaren-male:16:16|a", "Frame")
    local sArenaCastbar = Masque:Group("sArena |cff00ff96MoP Classic|r|A:raceicon-pandaren-male:16:16|a", "Castbar")
    local sArenaCastbarIcon = Masque:Group("sArena |cff00ff96MoP Classic|r|A:raceicon-pandaren-male:16:16|a", "Castbar Icon")

    function sArenaMixin:RefreshMasque()
        sArenaClass:ReSkin(true)
        sArenaTrinket:ReSkin(true)
        sArenaSpecIcon:ReSkin(true)
        sArenaRacial:ReSkin(true)
        sArenaDRs:ReSkin(true)
        sArenaFrame:ReSkin(true)
        sArenaCastbarIcon:ReSkin(true)
    end

    local function MsqSkinIcon(frame, group)
        local skinWrapper = CreateFrame("Frame")
        skinWrapper:SetParent(frame)
        skinWrapper:SetSize(30, 30)
        skinWrapper:SetAllPoints(frame.Icon)
        frame.MSQ = skinWrapper
        frame.Icon:Hide()
        frame.SkinnedIcon = skinWrapper:CreateTexture(nil, "BACKGROUND")
        frame.SkinnedIcon:SetSize(30, 30)
        frame.SkinnedIcon:SetPoint("CENTER")
        frame.SkinnedIcon:SetTexture(frame.Icon:GetTexture())
        hooksecurefunc(frame.Icon, "SetTexture", function(_, tex)
            skinWrapper:SetScale(frame.Icon:GetScale())
            frame.SkinnedIcon:SetTexture(tex)
        end)
        group:AddButton(skinWrapper, {
            Icon = frame.SkinnedIcon,
        })
    end

    for i = 1, 5 do
        local frame = self["arena" .. i]
        frame.FrameMsq = CreateFrame("Frame", nil, frame)
        frame.FrameMsq:SetFrameStrata("HIGH")
        frame.FrameMsq:SetPoint("TOPLEFT", frame.HealthBar, "TOPLEFT", 0, 0)
        frame.FrameMsq:SetPoint("BOTTOMRIGHT", frame.PowerBar, "BOTTOMRIGHT", 0, 0)

        frame.ClassIconMsq = CreateFrame("Frame", nil, frame)
        frame.ClassIconMsq:SetFrameStrata("DIALOG")
        frame.ClassIconMsq:SetAllPoints(frame.ClassIcon)

        frame.SpecIconMsq = CreateFrame("Frame", nil, frame)
        frame.SpecIconMsq:SetFrameStrata("DIALOG")
        frame.SpecIconMsq:SetAllPoints(frame.SpecIcon)

        frame.TrinketMsq = CreateFrame("Frame", nil, frame)
        frame.TrinketMsq:SetFrameStrata("DIALOG")
        frame.TrinketMsq:SetAllPoints(frame.Trinket)

        frame.RacialMsq = CreateFrame("Frame", nil, frame)
        frame.RacialMsq:SetFrameStrata("DIALOG")
        frame.RacialMsq:SetAllPoints(frame.Racial)

        frame.CastBarMsq = CreateFrame("Frame", nil, frame.CastBar)
        frame.CastBarMsq:SetFrameStrata("HIGH")
        frame.CastBarMsq:SetAllPoints(frame.CastBar)

        addToMasque(frame.FrameMsq, sArenaFrame)
        addToMasque(frame.ClassIconMsq, sArenaClass)
        addToMasque(frame.SpecIconMsq, sArenaSpecIcon)
        addToMasque(frame.TrinketMsq, sArenaTrinket)
        addToMasque(frame.RacialMsq, sArenaRacial)
        addToMasque(frame.CastBarMsq, sArenaCastbar)
        MsqSkinIcon(frame.CastBar, sArenaCastbarIcon)

        frame.CastBar.MSQ:SetFrameStrata("DIALOG")

        -- DR frames
        for _, category in ipairs(self.drCategories) do
            local drFrame = frame[category]
            if drFrame then
                addToMasque(drFrame, sArenaDRs)
            end
        end
    end
end

function sArenaFrameMixin:UpdatePlayer(unitEvent)
    local unit = self.unit

    self:GetClass()
    self:FindAura()

    if ((unitEvent and unitEvent ~= "seen") or (UnitGUID(self.unit) == nil)) then
        self:SetMysteryPlayer()
        return
    end

    C_PvP.RequestCrowdControlSpell(unit)

    self:UpdateTrinket()
    self:UpdateRacial()

    -- Prevent castbar and other frames from intercepting mouse clicks during a match
    if (unitEvent == "seen") then
        self.parent:SetMouseState(false)
    end

    self.hideStatusText = false

    if (db.profile.showNames) then
        self.Name:SetText(UnitName(unit))
        self.Name:SetShown(true)
    elseif (db.profile.showArenaNumber) then
        self.Name:SetText(self.unit)
        self.Name:SetShown(true)
    end

    self:UpdateStatusTextVisible()
    self:SetStatusText()

    self:OnEvent("UNIT_MAXHEALTH", unit)
    self:OnEvent("UNIT_HEALTH", unit)
    self:OnEvent("UNIT_MAXPOWER", unit)
    self:OnEvent("UNIT_POWER_UPDATE", unit)
    self:OnEvent("UNIT_DISPLAYPOWER", unit)

    local color = RAID_CLASS_COLORS[select(2, UnitClass(unit))]

    if (color and db.profile.classColors) then
        self.HealthBar:SetStatusBarColor(color.r, color.g, color.b, 1.0)
    else
        self.HealthBar:SetStatusBarColor(0, 1.0, 0, 1.0)
    end
end

function sArenaFrameMixin:SetMysteryPlayer()
    local f = self.HealthBar
    f:SetMinMaxValues(0, 100)
    f:SetValue(100)
    f:SetStatusBarColor(0.5, 0.5, 0.5)

    f = self.PowerBar
    f:SetMinMaxValues(0, 100)
    f:SetValue(100)
    f:SetStatusBarColor(0.5, 0.5, 0.5)

    self.hideStatusText = true
    self:SetStatusText()

    self.DeathIcon:Hide()
end

function sArenaFrameMixin:GetClass()
    local _, instanceType = IsInInstance()

    if (instanceType ~= "arena") then
        self.specTexture = nil
        self.class = nil
        self.classLocal = nil
        self.specName = nil
        self.SpecIcon:Hide()
        self.SpecNameText:SetText("")
    elseif (not self.class) then
        local id = self:GetID()
        if (GetNumArenaOpponentSpecs() >= id) then
            local specID = GetArenaOpponentSpec(id)
            if (specID > 0) then
                local _, specName, _, specTexture, _, class, classLocal = GetSpecializationInfoByID(specID)
                self.class = class
                self.classLocal = classLocal
                self.specName = specName
                self.SpecNameText:SetText(specName)
                self.SpecNameText:SetShown(db.profile.layoutSettings[db.profile.currentLayout].showSpecManaText)
                self.specTexture = specTexture
                self.class = class
                self:UpdateSpecIcon()
            end
        end

        if (not self.class and UnitExists(self.unit)) then
            self.classLocal, self.class = UnitClass(self.unit)
        end
    end
end


function sArenaFrameMixin:UpdateClassIcon()
	if (self.currentAuraSpellID and self.currentAuraDuration > 0 and self.currentClassIconStartTime ~= self.currentAuraStartTime) then
		self.ClassIconCooldown:SetCooldown(self.currentAuraStartTime, self.currentAuraDuration)
		self.currentClassIconStartTime = self.currentAuraStartTime
	elseif (self.currentAuraDuration == 0) then
		self.ClassIconCooldown:Clear()
		self.currentClassIconStartTime = 0
	end

	local texture = self.currentAuraSpellID and self.currentAuraTexture or self.class and "class" or 134400

	if (self.currentClassIconTexture == texture) then return end

	self.currentClassIconTexture = texture

    if (texture == "class") then
        if db.profile.hideClassIcon then
            self.ClassIcon:SetTexture(nil)
            if self.ClassIconMsq then
                self.ClassIconMsq:Hide()
            end
            if self.PixelBorders and self.PixelBorders.classIcon then
                self.PixelBorders.classIcon:Hide()
            end
        elseif db.profile.layoutSettings[db.profile.currentLayout].replaceClassIcon and self.specTexture then
            self.ClassIcon:SetTexture(self.specTexture)
            self:SetTextureCrop(self.ClassIcon, db.profile.layoutSettings[db.profile.currentLayout].cropIcons)
            if self.ClassIconMsq then
                self.ClassIconMsq:Show()
            end
            if self.PixelBorders and self.PixelBorders.classIcon then
                self.PixelBorders.classIcon:Show()
            end
        else
            self.ClassIcon:SetTexture("Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES")
            self.ClassIcon:SetTexCoord(unpack(db.profile.layoutSettings[db.profile.currentLayout].cropIcons and sArenaMixin.croppedClassIcons[self.class] or sArenaMixin.classIcons[self.class]))
            if self.ClassIconMsq then
                self.ClassIconMsq:Show()
            end
            if self.PixelBorders and self.PixelBorders.classIcon then
                self.PixelBorders.classIcon:Show()
            end
        end
		return
	end
	self:SetTextureCrop(self.ClassIcon, db and db.profile.layoutSettings[db.profile.currentLayout].cropIcons)
	self.ClassIcon:SetTexture(texture)
    if self.ClassIconMsq then
        self.ClassIconMsq:Show()
    end
    if self.PixelBorders and self.PixelBorders.classIcon then
        self.PixelBorders.classIcon:Show()
    end
end

-- Returns the spec icon texture based on arena unit ID (1-5)
function sArenaFrameMixin:UpdateSpecIcon()
    if not db.profile.layoutSettings[db.profile.currentLayout].replaceClassIcon then
        self.SpecIcon.Texture:SetTexture(self.specTexture)
        self.SpecIcon:Show()
        if self.SpecIconMsq then
            self.SpecIconMsq:Show()
        end
    else
        self.SpecIcon:Hide()
        if self.SpecIconMsq then
            self.SpecIconMsq:Hide()
        end
    end
end

local function ResetStatusBar(f)
    f:ClearAllPoints()
    f:SetSize(0, 0)
    f:SetScale(1)
end

local function ResetFontString(f)
    f:SetDrawLayer("OVERLAY", 1)
    f:SetJustifyH("CENTER")
    f:SetJustifyV("MIDDLE")
    f:SetTextColor(1, 0.82, 0, 1)
    f:SetShadowColor(0, 0, 0, 1)
    f:SetShadowOffset(1, -1)
    f:ClearAllPoints()
    f:Hide()
end

function sArenaFrameMixin:ResetLayout()
    self.currentClassIconTexture = nil
    self.currentClassIconStartTime = 0

    ResetTexture(nil, self.ClassIcon)
    ResetStatusBar(self.HealthBar)
    ResetStatusBar(self.PowerBar)
    ResetStatusBar(self.CastBar)
    self.CastBar:SetHeight(16)

    self.ClassIconCooldown:SetUseCircularEdge(false)

    self.ClassIcon:RemoveMaskTexture(self.ClassIconMask)

    if self.NameBackground then
        self.NameBackground:Hide()
    end

    local cropIcons = db.profile.layoutSettings[db.profile.currentLayout].cropIcons

    local f = self.Trinket
    f:ClearAllPoints()
    f:SetSize(0, 0)
    self:SetTextureCrop(f.Texture, cropIcons)

    f = self.ClassIcon
    self:SetTextureCrop(f, cropIcons)

    f = self.Racial
    f:ClearAllPoints()
    f:SetSize(0, 0)
    self:SetTextureCrop(f.Texture, cropIcons)

    f = self.SpecIcon
    f:ClearAllPoints()
    f:SetSize(0, 0)
    f:SetScale(1)
    f.Texture:RemoveMaskTexture(f.Mask)
    self:SetTextureCrop(f.Texture, cropIcons)

    f = self.Name
    ResetFontString(f)
    f:SetDrawLayer("ARTWORK", 2)
    f:SetFontObject("SystemFont_Shadow_Small2")

    f = self.SpecNameText
    ResetFontString(f)
    f:SetDrawLayer("ARTWORK", 2)
    f:SetFontObject("SystemFont_Shadow_Small2")

    f = self.HealthText
    ResetFontString(f)
    f:SetDrawLayer("ARTWORK", 2)
    f:SetFontObject("Game10Font_o1")
    f:SetTextColor(1, 1, 1, 1)

    f = self.PowerText
    ResetFontString(f)
    f:SetDrawLayer("ARTWORK", 2)
    f:SetFontObject("Game10Font_o1")
    f:SetTextColor(1, 1, 1, 1)

    f = self.CastBar
    f.Icon:SetTexCoord(0, 1, 0, 1)

    self.TexturePool:ReleaseAll()
end

function sArenaFrameMixin:SetPowerType(powerType)
    local color = PowerBarColor[powerType]
    if color then
        self.PowerBar:SetStatusBarColor(color.r, color.g, color.b)
    end
end

function sArenaFrameMixin:SetLifeState()
    local unit = self.unit
    local isDead = UnitIsDeadOrGhost(unit) and not AuraUtil.FindAuraByName(GetSpellInfo(5384), unit, "HELPFUL")

    self.DeathIcon:SetShown(isDead)
    self.hideStatusText = isDead
    if (isDead) then
        self:ResetDR()
    end
end

function sArenaFrameMixin:SetStatusText(unit)
    if (self.hideStatusText) then
        self.HealthText:SetFontObject("Game10Font_o1")
        self.HealthText:SetText("")
        self.PowerText:SetFontObject("Game10Font_o1")
        self.PowerText:SetText("")
        return
    end

    if (not unit) then
        unit = self.unit
    end

    local hp = UnitHealth(unit)
    local hpMax = UnitHealthMax(unit)
    local pp = UnitPower(unit)
    local ppMax = UnitPowerMax(unit)

    if (db.profile.statusText.usePercentage) then
        local hpPercent = (hpMax > 0) and ceil((hp / hpMax) * 100) or 0
        local ppPercent = (ppMax > 0) and ceil((pp / ppMax) * 100) or 0

        self.HealthText:SetText(hpPercent .. "%")
        self.PowerText:SetText(ppPercent .. "%")
    else
        self.HealthText:SetText(AbbreviateLargeNumbers(hp))
        self.PowerText:SetText(AbbreviateLargeNumbers(pp))
    end
end

function sArenaFrameMixin:UpdateStatusTextVisible()
    self.HealthText:SetShown(db.profile.statusText.alwaysShow)
    self.PowerText:SetShown(db.profile.statusText.alwaysShow)
end

local specTemplates = {
    BM_HUNTER = {
        class = "HUNTER",
        specIcon = 461112,
        castName = "Cobra Shot",
        castIcon = 461114,
        racial = 132089,
        specName = "Beast Mastery",
        unint = true,
    },
    MM_HUNTER = {
        class = "HUNTER",
        specIcon = 461113,
        castName = "Aimed Shot",
        castIcon = 132222,
        racial = 136225,
        specName = "Marksmanship",
        unint = true,
    },
    ELE_SHAMAN = {
        class = "SHAMAN",
        specIcon = 136048,
        castName = "Lightning Bolt",
        castIcon = 136048,
        racial = 135923,
        specName = "Elemental",
    },
    ENH_SHAMAN = {
        class = "SHAMAN",
        specIcon = 136039,
        castName = "Stormstrike",
        castIcon = 132314,
        racial = 135923,
        specName = "Enhancement",
    },
    RESTO_SHAMAN = {
        class = "SHAMAN",
        specIcon = 136052,
        castName = "Healing Wave",
        castIcon = 136052,
        racial = 135726,
        specName = "Restoration",
    },
    RESTO_DRUID = {
        class = "DRUID",
        specIcon = 136041,
        castName = "Regrowth",
        castIcon = 136085,
        racial = 132089,
        specName = "Restoration",
    },
    AFF_WARLOCK = {
        class = "WARLOCK",
        specIcon = 136145,
        castName = "Fear",
        castIcon = 136183,
        racial = 135726,
        specName = "Affliction",
    },
    ARMS_WARRIOR = {
        class = "WARRIOR",
        specIcon = 132355,
        castName = "Slam",
        castIcon = 132340,
        racial = 132309,
        specName = "Arms",
        unint = true,
    },
    DISC_PRIEST = {
        class = "PRIEST",
        specIcon = 135940,
        castName = "Penance",
        castIcon = 237545,
        racial = 136187,
        specName = "Discipline",
    },
    HOLY_PRIEST = {
        class = "PRIEST",
        specIcon = 237542,
        castName = "Holy Fire",
        castIcon = 135972,
        racial = 136187,
        specName = "Holy",
    },
    FERAL_DRUID = {
        class = "DRUID",
        specIcon = 132115,
        castName = "Cyclone",
        castIcon = 132469,
        racial = 132089,
        specName = "Feral",
    },
    FROST_MAGE = {
        class = "MAGE",
        specIcon = 135846,
        castName = "Frostbolt",
        castIcon = 135846,
        racial = 136129,
        specName = "Frost",
    },
    ARCANE_MAGE = {
        class = "MAGE",
        specIcon = 135932,
        castName = "Arcane Blast",
        castIcon = 135735,
        racial = 136129,
        specName = "Arcane",
    },
    FIRE_MAGE = {
        class = "MAGE",
        specIcon = 135810,
        castName = "Pyroblast",
        castIcon = 135808,
        racial = 135991,
        specName = "Fire",
    },
    RET_PALADIN = {
        class = "PALADIN",
        specIcon = 135873,
        castName = "Feet Up",
        castIcon = 133029,
        racial = 136129,
        specName = "Retribution",
    },
    UNHOLY_DK = {
        class = "DEATHKNIGHT",
        specIcon = 135775,
        racial = 135726,
        specName = "Unholy",
    },
    SUB_ROGUE = {
        class = "ROGUE",
        specIcon = 132320,
        racial = 132089,
        specName = "Subtlety",
    },
}

local testPlayers = {
    { template = "BM_HUNTER", name = "Despytimes" },
    { template = "MM_HUNTER", name = "Jellybeans" },
    { template = "ELE_SHAMAN", name = "Bluecheese" },
    { template = "ENH_SHAMAN", name = "Saul" },
    { template = "RESTO_SHAMAN", name = "Cdew" },
    { template = "RESTO_SHAMAN", name = "Absterge" },
    { template = "RESTO_SHAMAN", name = "Lontarito" },
    { template = "ELE_SHAMAN", name = "Whaazzlasso", castName = "Feet Up", castIcon = 133029 },
    { template = "RESTO_DRUID", name = "Metaphors" },
    { template = "RESTO_DRUID", name = "Flop" },
    { template = "FERAL_DRUID", name = "Sodapoopin" },
    { template = "FERAL_DRUID", name = "Bean" },
    { template = "FERAL_DRUID", name = "Snupy" },
    { template = "AFF_WARLOCK", name = "Chan" },
    { template = "ARMS_WARRIOR", name = "Trillebartom" },
    { template = "DISC_PRIEST", name = "Hydra" },
    { template = "HOLY_PRIEST", name = "Mehhx" },
    { template = "FROST_MAGE", name = "Raiku (46)" },
    { template = "FROST_MAGE", name = "Samiyam" },
    { template = "FROST_MAGE", name = "Aeghis" },
    { template = "FROST_MAGE", name = "Venruki" },
    { template = "FROST_MAGE", name = "Xaryu" },
    { template = "FIRE_MAGE", name = "Hansol" },
    { template = "ARCANE_MAGE", name = "Ziqo" },
    { template = "ARCANE_MAGE", name = "Mmrklepter" },
    { template = "RET_PALADIN", name = "Judgewhaazz" },
    { template = "UNHOLY_DK", name = "Darthchan" },
    { template = "UNHOLY_DK", name = "Mes" },
    { template = "SUB_ROGUE", name = "Nahj" },
    { template = "SUB_ROGUE", name = "Cshero" },
    { template = "SUB_ROGUE", name = "Pshero" },
    { template = "SUB_ROGUE", name = "Whaazz" },
    { template = "SUB_ROGUE", name = "Pikawhoo" },
    { template = "ARMS_WARRIOR", name = "Magnusz" },
}

local function ExpandTemplates()
    for _, player in ipairs(testPlayers) do
        local template = specTemplates[player.template]
        if template then
            for k, v in pairs(template) do
                if player[k] == nil then
                    player[k] = v
                end
            end
            player.template = nil
        end
    end
    testActive = true
end

local function Shuffle()
    local classMap = {}
    local uniqueClassPlayers = {}

    for _, player in ipairs(testPlayers) do
        if not classMap[player.class] then
            classMap[player.class] = {}
        end
        table.insert(classMap[player.class], player)
    end

    for _, classPlayers in pairs(classMap) do
        local randomIndex = math.random(#classPlayers)
        table.insert(uniqueClassPlayers, classPlayers[randomIndex])
    end

    for i = #uniqueClassPlayers, 2, -1 do
        local j = math.random(i)
        uniqueClassPlayers[i], uniqueClassPlayers[j] = uniqueClassPlayers[j], uniqueClassPlayers[i]
    end

    return uniqueClassPlayers
end

local classPowerType = {
    WARRIOR = "RAGE",
    ROGUE = "ENERGY",
    DRUID = "ENERGY",
    PALADIN = "MANA",
    HUNTER = "FOCUS",
    DEATHKNIGHT = "RUNIC_POWER",
    SHAMAN = "MANA",
    MAGE = "MANA",
    WARLOCK = "MANA",
    PRIEST = "MANA",
}

function sArenaMixin:Test()
    local _, instanceType = IsInInstance()
    if (InCombatLockdown() or instanceType == "arena") then return end

    local currTime = GetTime()
    if not testActive then
        ExpandTemplates()
    end
    local shuffledPlayers = Shuffle()
    local cropIcons = db.profile.layoutSettings[db.profile.currentLayout].replaceClassIcon
    local replaceClassIcon = db.profile.layoutSettings[db.profile.currentLayout].replaceClassIcon
    local hideClassIcon = db.profile.hideClassIcon
    local colorTrinket = db.profile.colorTrinket

    local topFrame

    for i = 1, 5 do
        local frame = self["arena" .. i]
        local data = shuffledPlayers[i]

        if i == 1 then
            topFrame = frame
        end

        if masqueOn and frame.masqueHidden then
            frame.FrameMsq:Show()
            frame.ClassIconMsq:Show()
            frame.SpecIconMsq:Show()
            frame.TrinketMsq:Show()
            frame.RacialMsq:Show()
            frame.CastBarMsq:Show()
        end

        frame.tempName = data.name
        frame.tempClass = data.class
        frame.tempSpecIcon = data.specIcon
        frame.replaceClassIcon = replaceClassIcon

        frame:Show()
        frame:SetAlpha(1)
        if frame.PixelBorders and not frame.PixelBorders.hide then
            frame.PixelBorders.trinket:Show()
            frame.PixelBorders.racial:Show()
        end

        frame.HealthBar:SetMinMaxValues(0, 100)
        frame.HealthBar:SetValue(100)

        if i == 4 then
            frame.HealthBar:SetValue(60)
        elseif i == 5 then
            frame.HealthBar:SetValue(25)
        end

        frame.PowerBar:SetMinMaxValues(0, 100)
        frame.PowerBar:SetValue(100)

        -- Class Icon and Spec Icon + Spec Name
        if hideClassIcon then
            frame.ClassIcon:SetTexture(nil)
            if frame.ClassIconMsq then
                frame.ClassIconMsq:Hide()
            end
            if frame.SpecIconMsq then
                frame.SpecIconMsq:Hide()
            end
        else
            if replaceClassIcon then
                frame.SpecIcon:Hide()
                frame.SpecIcon.Texture:SetTexture(nil)
                if frame.SpecIconMsq then
                    frame.SpecIconMsq:Hide()
                end
                frame.ClassIcon:SetTexture(data.specIcon, true)
                frame:SetTextureCrop(self.ClassIcon, cropIcons)
            else
                frame.SpecIcon:Show()
                frame.SpecIcon.Texture:SetTexture(data.specIcon)
                if frame.SpecIconMsq then
                    frame.SpecIconMsq:Show()
                end
                frame.ClassIcon:SetTexture("Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES", true)
                frame.ClassIcon:SetTexCoord(unpack(cropIcons and self.croppedClassIcons[data.class] or self.classIcons[data.class]))
            end
            if frame.ClassIconMsq then
                frame.ClassIconMsq:Show()
            end
        end
        frame.SpecNameText:SetText(data.specName)
        frame.SpecNameText:SetShown(db.profile.layoutSettings[db.profile.currentLayout].showSpecManaText)

        frame.ClassIconCooldown:SetCooldown(currTime, math.random(60, 145))

        frame.Name:SetText((db.profile.showArenaNumber and "arena" .. i) or data.name)
        frame.Name:SetShown(db.profile.showNames or db.profile.showArenaNumber)

        -- Trinket
        if colorTrinket then
            if i <= 2 then
                frame.Trinket.Texture:SetColorTexture(0,1,0)
                frame.Trinket.Cooldown:Clear()
            else
                frame.Trinket.Texture:SetColorTexture(1,0,0)
            end
        else
            frame.Trinket.Texture:SetTexture(133453)
            frame.Trinket.Texture:SetDesaturated(false)
        end
        frame.Trinket.Cooldown:SetCooldown(currTime, math.random(20, 60))
        if frame.TrinketMsq then
            frame.TrinketMsq:Show()
        end

        -- Racial
        frame.Racial.Texture:SetTexture(data.racial or 132089)
        frame.Racial.Cooldown:SetCooldown(currTime, math.random(20, 60))
        if frame.RacialMsq then
            frame.RacialMsq:Show()
        end

        -- Colors
        local color = RAID_CLASS_COLORS[data.class]
        if (db.profile.classColors and color) then
            frame.HealthBar:SetStatusBarColor(color.r, color.g, color.b, 1)
        else
            frame.HealthBar:SetStatusBarColor(0, 1, 0, 1)
        end

        local powerType = classPowerType[data.class] or "MANA"
        local powerColor = PowerBarColor[powerType] or { r = 0, g = 0, b = 1 }

        frame.PowerBar:SetStatusBarColor(powerColor.r, powerColor.g, powerColor.b)

        -- DR Frames
        local drsEnabled = #self.drCategories
        if drsEnabled > 0 then
            for n = 1, 5 do
                local drFrame = frame[self.drCategories[n]]
                drFrame.Icon:SetTexture(132298)
                drFrame:Show()
                drFrame.Cooldown:SetCooldown(currTime, n == 1 and 60 or math.random(20, 50))

                if (n == 1) then
                    drFrame.Border:SetVertexColor(1, 0, 0, 1)
                    if frame.PixelBorder then
                        frame.PixelBorder:SetVertexColor(1, 0, 0, 1)
                    end
                    drFrame.DRTextFrame.DRText:SetText("%")
                    drFrame.DRTextFrame.DRText:SetTextColor(1, 0, 0) -- red
                    if drFrame.__MSQ_New_Normal then
                        drFrame.__MSQ_New_Normal:SetDesaturated(true)
                        drFrame.__MSQ_New_Normal:SetVertexColor(1, 0, 0, 1)
                    end
                else
                    drFrame.Border:SetVertexColor(0, 1, 0, 1)
                    if frame.PixelBorder then
                        frame.PixelBorder:SetVertexColor(0, 1, 0, 1)
                    end
                    drFrame.DRTextFrame.DRText:SetText("½")
                    drFrame.DRTextFrame.DRText:SetTextColor(0, 1, 0) -- green
                    if drFrame.__MSQ_New_Normal then
                        drFrame.__MSQ_New_Normal:SetDesaturated(true)
                        drFrame.__MSQ_New_Normal:SetVertexColor(0, 1, 0, 1)
                    end
                end
            end
        end

        -- Cast Bar
        if data.castName then
            frame.CastBar.fadeOut = nil
            frame.CastBar:Show()
            frame.CastBar:SetAlpha(1)
            frame.CastBar.Icon:SetTexture(data.castIcon)
            frame.CastBar.Text:SetText(data.castName)
            if data.unint then
                frame.CastBar.BorderShield:Show()
                frame.CastBar:SetStatusBarColor(0.7, 0.7, 0.7, 1)
            else
                frame.CastBar.BorderShield:Hide()
                frame.CastBar:SetStatusBarColor(1, 0.7, 0, 1)
            end
        else
            frame.CastBar.fadeOut = nil
            frame.CastBar:Hide()
            frame.CastBar:SetAlpha(0)
        end

        frame.hideStatusText = false
        frame:SetStatusText("player")
        frame:UpdateStatusTextVisible()

        if masqueOn and not db.profile.enableMasque and frame.FrameMsq then
            frame.FrameMsq:Hide()
            frame.ClassIconMsq:Hide()
            frame.SpecIconMsq:Hide()
            frame.TrinketMsq:Hide()
            frame.RacialMsq:Hide()
            frame.CastBarMsq:Hide()
            frame.masqueHidden = true
        end
    end

    if not TestTitle then
        local f = CreateFrame("Frame")
        TestTitle = f

        local t = f:CreateFontString(nil, "OVERLAY")
        t:SetFontObject("GameFontHighlightLarge")
        t:SetFont(self.pFont, 12, "OUTLINE")
        t:SetText("|T132961:16|t Ctrl+Shift+Click to drag|r")
        t:SetPoint("BOTTOM", topFrame, "TOP", 17, 17)

        local bg = f:CreateTexture(nil, "BACKGROUND", nil, -1)
        bg:SetPoint("TOPLEFT", t, "TOPLEFT", -6, 4)
        bg:SetPoint("BOTTOMRIGHT", t, "BOTTOMRIGHT", 6, -3)
        bg:SetAtlas("PetList-ButtonBackground")

        local t2 = f:CreateFontString(nil, "OVERLAY")
        t2:SetFontObject("GameFontHighlightLarge")
        t2:SetFont(self.pFont, 22, "OUTLINE")
        t2:SetText("sArena |cff00ff96MoP|r|A:raceicon-pandaren-male:12:12|a")
        t2:SetPoint("BOTTOM", t, "TOP", 0, 5)
    end

    TestTitle:Show()

    if masqueOn then
        sArenaMixin:RefreshMasque()
        for i = 1, 5 do
            local frame = self["arena" .. i]
            for n = 1, 5 do
                local drFrame = frame[self.drCategories[n]]
                if drFrame.__MSQ_New_Normal then
                    drFrame.__MSQ_New_Normal:SetDesaturated(true)
                    drFrame.__MSQ_New_Normal:SetVertexColor(0, 1, 0, 1)
                end
            end
        end
    end
end