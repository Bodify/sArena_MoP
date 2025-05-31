sArenaMixin = {}
sArenaFrameMixin = {}
sArenaCastingBarExtensionMixin = {}

sArenaMixin.layouts = {}
sArenaMixin.defaultSettings = {
    profile = {
        currentLayout = "Gladiuish",
        classColors = true,
        showNames = true,
        showArenaNumber = false,
        statusText = {
            usePercentage = false,
            alwaysShow = true,
        },
        layoutSettings = {},
    }
}

sArenaMixin.pFont = "Interface\\AddOns\\sArena_MoP\\Prototype.ttf"

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
        blizzFrame = CreateFrame("Frame", nil, UIParent)
        blizzFrame:SetSize(1, 1)
        blizzFrame:SetPoint("RIGHT", UIParent, "RIGHT", 500, 0)
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


-- Parent Frame
function sArenaMixin:OnLoad()
    self:RegisterEvent("PLAYER_LOGIN")
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
end

function sArenaMixin:OnEvent(event)
    if (event == "PLAYER_LOGIN") then
        self:Initialize()
        self:SetupCastColor()
        self:SetupGrayTrinket()
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
            self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
        else
            self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
        end
    elseif (event == "COMBAT_LOG_EVENT_UNFILTERED") then
        local _, combatEvent, _, sourceGUID, _, _, _, destGUID, _, _, _, spellID, _, _, auraType =
            CombatLogGetCurrentEventInfo()

        for i = 1, 5 do
            local ArenaFrame = self["arena" .. i]

            if (sourceGUID == UnitGUID("arena" .. i)) then
                ArenaFrame:FindRacial(combatEvent, spellID)
            end

            if (sourceGUID == UnitGUID("arena" .. i)) then
                ArenaFrame:FindTrinket(combatEvent, spellID)
            end

            if (destGUID == UnitGUID("arena" .. i)) then
                ArenaFrame:FindInterrupt(combatEvent, spellID)

                if (auraType == "DEBUFF") then
                    ArenaFrame:FindDR(combatEvent, spellID)
                end
            end
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

function sArenaMixin:SetupGrayTrinket()
    for i = 1, 5 do
        local frame = self["arena" .. i]
        local cooldown = frame.Trinket.Cooldown
        cooldown:HookScript("OnCooldownDone", function()
            frame.Trinket.Texture:SetDesaturated(false)
        end)
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

    for i = 1, 5 do
        local frame = self["arena" .. i]
        frame:ResetLayout()
        self.layouts[layout]:Initialize(frame)
        frame:UpdatePlayer()
        sArenaMixin:ApplyPrototypeFont(frame)
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

    --RegisterUnitWatch(self, false)

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
                self.Name:SetText(GetUnitName(unit))
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

function sArenaFrameMixin:UpdateVisible()
    if (InCombatLockdown()) then
        self:RegisterEvent("PLAYER_REGEN_ENABLED")
        return
    end

    local _, instanceType = IsInInstance()
    local id = self:GetID()
    if (instanceType == "arena" and (GetNumArenaOpponentSpecs() >= id or GetNumArenaOpponents() >= id)) then
        self:Show()
    else
        self:Hide()
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
        self.Name:SetText(GetUnitName(unit))
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

	-- Could do SetPortraitTexture() since its hooked anyway in my other addon
	if (texture == "class") then
        if db.profile.layoutSettings[db.profile.currentLayout].replaceClassIcon and self.specTexture then
            self.ClassIcon:SetTexture(self.specTexture)
            self.ClassIcon:SetTexCoord(0, 1, 0, 1)
        else
            self.ClassIcon:SetTexture("Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES")
            self.ClassIcon:SetTexCoord(unpack(sArenaMixin.classIcons[self.class]))
        end
		return
	end
	self.ClassIcon:SetTexCoord(0, 1, 0, 1)
	self.ClassIcon:SetTexture(texture)
end

-- Returns the spec icon texture based on arena unit ID (1-5)
function sArenaFrameMixin:UpdateSpecIcon()
    if not db.profile.layoutSettings[db.profile.currentLayout].replaceClassIcon then
        self.SpecIcon.Texture:SetTexture(self.specTexture)
        self.SpecIcon:Show()
    else
        self.SpecIcon:Hide()
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

    local f = self.Trinket
    f:ClearAllPoints()
    f:SetSize(0, 0)
    f.Texture:SetTexCoord(0, 1, 0, 1)

    f = self.Racial
    f:ClearAllPoints()
    f:SetSize(0, 0)
    f.Texture:SetTexCoord(0, 1, 0, 1)

    f = self.SpecIcon
    f:ClearAllPoints()
    f:SetSize(0, 0)
    f:SetScale(1)
    f.Texture:RemoveMaskTexture(f.Mask)
    f.Texture:SetTexCoord(0, 1, 0, 1)

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
        self.HealthText:SetText(ceil((hp / hpMax) * 100) .. "%")
        self.PowerText:SetText(ceil((pp / ppMax) * 100) .. "%")
    else
        self.HealthText:SetText(AbbreviateLargeNumbers(hp))
        self.PowerText:SetText(AbbreviateLargeNumbers(pp))
    end
end

function sArenaFrameMixin:UpdateStatusTextVisible()
    self.HealthText:SetShown(db.profile.statusText.alwaysShow)
    self.PowerText:SetShown(db.profile.statusText.alwaysShow)
end

local testPlayers = {
    {
        class = "HUNTER",
        specIcon = 461112,
        castName = "Cobra Shot",
        castIcon = 461114,
        unint = true,
        racial = 136225,
        specName = "Beast Mastery",
        name = "Despytimes",
    },
    {
        class = "SHAMAN",
        specIcon = 136048,
        castName = "Lightning Bolt",
        castIcon = 136048,
        racial = 135923,
        specName = "Elemental",
        name = "Bluecheese",
    },
    {
        class = "SHAMAN",
        specIcon = 136048,
        castName = "Feet Up",
        castIcon = 133029,
        racial = 135923,
        specName = "Elemental",
        name = "Whaazzlasso",
    },
    {
        class = "DRUID",
        specIcon = 136041,
        castName = "Regrowth",
        castIcon = 136085,
        racial = 132089,
        specName = "Restoration",
        name = "Metaphors",
    },
    {
        class = "WARLOCK",
        specIcon = 136145,
        castName = "Howl of Terror",
        castIcon = 136147,
        racial = 135726,
        specName = "Affliction",
        name = "Chan",
    },
    {
        class = "WARRIOR",
        specIcon = 132355,
        castName = "Slam",
        castIcon = 132340,
        racial = 132309,
        specName = "Arms",
        name = "Trillebartom",
        unint = true,
    },
    {
        class = "PRIEST",
        specIcon = 135940,
        castName = "Penance",
        castIcon = 237545,
        racial = 136187,
        specName = "Discipline",
        name = "Hydra",
    },
    {
        class = "MAGE",
        specIcon = 135932,
        castName = "Frostbolt",
        castIcon = 135846,
        racial = 136129,
        specName = "Frost",
        name = "Raiku",
    },
    {
        class = "MAGE",
        specIcon = 135932,
        castName = "Arcane Blast",
        castIcon = 135735,
        racial = 136129,
        specName = "Arcane",
        name = "Ziqo",
    },
    {
        class = "PALADIN",
        specIcon = 236264,
        castName = "Feet Up",
        castIcon = 133029,
        racial = 136129,
        specName = "Retribution",
        name = "Judgewhaazz",
    },
    {
        class = "DEATHKNIGHT",
        specIcon = 135775,
        racial = 136145,
        specName = "Unholy",
        name = "Darthchan",
    },
    {
        class = "ROGUE",
        specIcon = 132320,
        racial = 132089,
        specName = "Subtlety",
        name = "Nahj",
    },
}

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


local function Shuffle(t)
    for i = #t, 2, -1 do
        local j = math.random(i)
        t[i], t[j] = t[j], t[i]
    end
end

function sArenaMixin:Test()
    local _, instanceType = IsInInstance()
    if (InCombatLockdown() or instanceType == "arena") then return end

    local currTime = GetTime()

    Shuffle(testPlayers)

    for i = 1, 5 do
        local frame = self["arena" .. i]
        local data = testPlayers[i]

        frame:Show()
        frame:SetAlpha(1)

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
        if db.profile.layoutSettings[db.profile.currentLayout].replaceClassIcon then
            frame.SpecIcon:Hide()
            frame.SpecIcon.Texture:SetTexture(nil)
            frame.ClassIcon:SetTexture(data.specIcon, true)
            frame.ClassIcon:SetTexCoord(0, 1, 0, 1)
        else
            frame.SpecIcon:Show()
            frame.SpecIcon.Texture:SetTexture(data.specIcon)
            frame.ClassIcon:SetTexture("Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES", true)
            frame.ClassIcon:SetTexCoord(unpack(self.classIcons[data.class]))
        end
        frame.SpecNameText:SetText(data.specName)
        frame.SpecNameText:SetShown(db.profile.layoutSettings[db.profile.currentLayout].showSpecManaText)

        frame.ClassIconCooldown:SetCooldown(currTime, math.random(20, 60))

        frame.Name:SetText((db.profile.showArenaNumber and "arena" .. i) or data.name)
        frame.Name:SetShown(db.profile.showNames)

        -- Trinket
        frame.Trinket.Texture:SetTexture(133453)
        frame.Trinket.Texture:SetDesaturated(false)
        frame.Trinket.Cooldown:SetCooldown(currTime, math.random(20, 60))

        -- Racial
        frame.Racial.Texture:SetTexture(data.racial or 132089)
        frame.Racial.Cooldown:SetCooldown(currTime, math.random(20, 60))

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
        for n = 1, 5 do
            local drFrame = frame[self.drCategories[n]]
            drFrame.Icon:SetTexture(132298)
            drFrame:Show()
            drFrame.Cooldown:SetCooldown(currTime, n == 1 and 60 or math.random(20, 50))

            if (n == 1) then
                drFrame.Border:SetVertexColor(1, 0, 0, 1)
            else
                drFrame.Border:SetVertexColor(0, 1, 0, 1)
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
    end
end