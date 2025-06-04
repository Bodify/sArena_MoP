function sArenaFrameMixin:FindTrinket(event, spellID)
    if (event ~= "SPELL_CAST_SUCCESS") then return end

    local trinket = self.Trinket

    if (spellID == 42292 or spellID == 59752) then
        trinket.Cooldown:SetCooldown(GetTime(), 120);
    end
end

function sArenaFrameMixin:UpdateTrinketIcon()
    local unit = self.unit

    if self.parent.db.profile.colorTrinket then
        self.Trinket.Texture:SetColorTexture(0,1,0)
    else
        local faction, _ = UnitFactionGroup(unit)
        if (faction == "Alliance") then
            self.Trinket.Texture:SetTexture(133452)
        else
            self.Trinket.Texture:SetTexture(133453)
        end
    end

    if self.TrinketMsq then
        self.TrinketMsq:Show()
    end

    if self.PixelBorders and self.PixelBorders.trinket then
        self.PixelBorders.trinket:Show()
    end

    if self.parent.db.profile.swapHumanTrinket and self.race == "Human" then
        self:UpdateRacial(true)
    end
end

function sArenaFrameMixin:UpdateTrinket(arg1, arg2)
    local spellID, itemID, startTime, duration = C_PvP.GetArenaCrowdControlInfo(self.unit)
    local trinket = self.Trinket
    --if DLAPI then DLAPI.DebugLog("UpdateTrinket", "UpdateTrinket spellID: " .. spellID .. " startTime: " .. startTime .. " duration: " .. duration) end

    if (spellID) then
        --local spellInfo = C_Spell.GetSpellInfo(spellID)
        if (spellID ~= trinket.spellID) then
            --local _, spellTextureNoOverride = C_Spell.GetSpellTexture(spellID)
            trinket.spellID = spellID
            --trinket.Texture:SetTexture(spellTextureNoOverride)
            self:UpdateTrinketIcon()
        end
        if (startTime ~= 0 and duration ~= 0 and trinket.Texture:GetTexture()) then
            trinket.Cooldown:SetCooldown(startTime / 1000.0, duration / 1000.0)
            if self.parent.db.profile.colorTrinket then
                self.Trinket.Texture:SetColorTexture(1,0,0)
            else
                trinket.Texture:SetDesaturated(true)
            end
        else
            trinket.Cooldown:Clear()
            if self.parent.db.profile.colorTrinket then
                self.Trinket.Texture:SetColorTexture(0,1,0)
            else
                trinket.Texture:SetDesaturated(false)
            end
        end
    else
        self:UpdateTrinketIcon()
    end
end

function sArenaFrameMixin:ResetTrinket()
    self.Trinket.spellID = nil
    self.Trinket.Texture:SetTexture(nil)
    self.Trinket.Cooldown:Clear()
    self.Trinket.Texture:SetDesaturated(false)
    if self.TrinketMsq then
        self.TrinketMsq:Hide()
    end
    if self.PixelBorders and self.PixelBorders.trinket then
        self.PixelBorders.trinket:Hide()
    end
end
