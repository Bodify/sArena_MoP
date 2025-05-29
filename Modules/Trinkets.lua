function sArenaFrameMixin:FindTrinket(event, spellID)
    if (event ~= "SPELL_CAST_SUCCESS") then return end

    local trinket = self.Trinket

    if (spellID == 42292 or spellID == 59752) then
        trinket.Cooldown:SetCooldown(GetTime(), 120);
    end
end

function sArenaFrameMixin:UpdateTrinketEquippedStatus()
    local unit = self.unit
    local faction, _ = UnitFactionGroup(unit)

    if (faction == "Alliance") then
        self.Trinket.Texture:SetTexture(133452)
    else
        self.Trinket.Texture:SetTexture(133453)
    end
end

function sArenaFrameMixin:UpdateTrinket(arg1, arg2)
    local spellID, startTime, duration = C_PvP.GetArenaCrowdControlInfo(self.unit)
    local trinket = self.Trinket
    --if DLAPI then DLAPI.DebugLog("UpdateTrinket", "UpdateTrinket spellID: " .. spellID .. " startTime: " .. startTime .. " duration: " .. duration) end

    if (spellID) then
        --local spellInfo = C_Spell.GetSpellInfo(spellID)
        if (spellID ~= trinket.spellID) then
            local _, spellTextureNoOverride = C_Spell.GetSpellTexture(spellID)
            trinket.spellID = spellID
            --trinket.Texture:SetTexture(spellTextureNoOverride)
            self:UpdateTrinketEquippedStatus()
        end
        if (startTime ~= 0 and duration ~= 0 and trinket.Texture:GetTexture()) then
            trinket.Cooldown:SetCooldown(startTime / 1000.0, duration / 1000.0)
            trinket.Texture:SetDesaturated(true)
        else
            trinket.Cooldown:Clear()
            trinket.Texture:SetDesaturated(false)
        end
    else
        self:UpdateTrinketEquippedStatus()
    end
end

function sArenaFrameMixin:ResetTrinket()
    self.Trinket.spellID = nil
    self.Trinket.Texture:SetTexture(nil)
    self.Trinket.Cooldown:Clear()
    self.Trinket.Texture:SetDesaturated(false)
end
