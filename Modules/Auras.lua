sArenaMixin.interruptList = {
	[1766] = 5, 	-- Kick (Rogue)
	[2139] = 6, 	-- Counterspell (Mage)
	[6552] = 4, 	-- Pummel (Warrior)
	[33871] = 6, 	-- Shield Bash (Warrior)
	[24259] = 6, 	-- Spell Lock (Warlock)
	[43523] = 5,	-- Unstable Affliction (Warlock)
	[16979] = 4, 	-- Feral Charge (Druid)
	[26679] = 6, 	-- Deadly Throw (Rogue)
	[57994] = 3, 	-- Wind Shear (Shaman)
    [116705] = 4,   -- Spear Hand Strike (Monk)

    [78675] = 6, -- Solar Beam
    [113286] = 6, -- Solar Beam (Symbiosis)
}

sArenaMixin.auraList = {
    -- Special
    [122465] = 10, -- Dematerialize

    -- Full CC (Stuns and Disorients)
    [33786] = 9,  -- Cyclone (Disorient)
    [58861] = 9,  -- Bash (Spirit Wolves)
    [5211]  = 9,  -- Bash
    [6789]  = 9,  -- Death Coil
    [1833]  = 9,  -- Cheap Shot
    [7922]  = 9,  -- Charge Stun
    [12809] = 9,  -- Concussion Blow
    [44572] = 9,  -- Deep Freeze
    [60995] = 9,  -- Demon Charge
    [47481] = 9,  -- Gnaw
    [853]   = 9,  -- Hammer of Justice
    [85388] = 9,  -- Throwdown
    [90337] = 9,  -- Bad Manner
    [20253] = 9,  -- Intercept
    [30153] = 9,  -- Pursuit
    [24394] = 9,  -- Intimidation
    [408]   = 9,  -- Kidney Shot
    [22570] = 9,  -- Maim
    [9005]  = 9,  -- Pounce
    [64058] = 9,  -- Psychic Horror
    [6572]  = 9,  -- Ravage
    [30283] = 9,  -- Shadowfury
    [46968] = 9,  -- Shockwave
    [39796] = 9,  -- Stoneclaw Stun
    [20549] = 9,  -- War Stomp
    [61025]  = 9, -- Polymorph: Serpent
    [82691]  = 9, -- Ring of Frost
    [115078] = 9, -- Paralysis
    [76780]  = 9, -- Bind Elemental
    [107079] = 9, -- Quaking Palm (Racial)
    [99]     = 9, -- Disorienting Roar
    [123393] = 9, -- Glyph of Breath of Fire
    [108194] = 9, -- Asphyxiate
    [91797]  = 9, -- Monstrous Blow (Dark Transformation)
    [113801] = 9, -- Bash (Treants)
    [117526] = 9, -- Binding Shot
    [56626]  = 9, -- Sting (Wasp)
    [50519]  = 9, -- Sonic Blast
    [118271] = 9, -- Combustion
    [119392] = 9, -- Charging Ox Wave
    [122242] = 9, -- Clash
    [120086] = 9, -- Fists of Fury
    [119381] = 9, -- Leg Sweep
    [115752] = 9, -- Blinding Light (Glyphed)
    [110698] = 9, -- Hammer of Justice (Symbiosis)
    [119072] = 9, -- Holy Wrath
    [105593] = 9, -- Fist of Justice
    [118345] = 9, -- Pulverize (Primal Earth Elemental)
    [118905] = 9, -- Static Charge (Capacitor Totem)
    [89766]  = 9, -- Axe Toss (Felguard)
    [22703]  = 9, -- Inferno Effect
    [107570] = 9, -- Storm Bolt
    [132169] = 9, -- Storm Bolt
    [113004] = 9, -- Intimidating Roar (Symbiosis)
    [113056] = 9, -- Intimidating Roar (Symbiosis 2)
    [118699] = 9, -- Fear (alt ID)
    [113792] = 9, -- Psychic Terror (Psyfiend)
    [115268] = 9, -- Mesmerize (Shivarra)
    [104045] = 9, -- Sleep (Metamorphosis)
    [20511]  = 9, -- Intimidating Shout (secondary)

    -- Stun Procs
    [34510] = 9,  -- Stun (various procs)
    [20170] = 9,  -- Seal of Justice
    [12355] = 9,  -- Impact
    [23454] = 9,  -- Stun

    -- Disorient / Incapacitate / Fear / Charm
    [2094]  = 9,  -- Blind
    [31661] = 9,  -- Dragon's Breath
    [5782]  = 9,  -- Fear
    [3355]  = 9,  -- Freezing Trap
    [1776]  = 9,  -- Gouge
    [51514] = 9,  -- Hex
    [2637]  = 9,  -- Hibernate
    [5484]  = 9,  -- Howl of Terror
    [49203] = 9,  -- Hungering Cold
    [5246]  = 9,  -- Intimidating Shout
    [605]   = 9,  -- Mind Control
    [118]   = 9,  -- Polymorph
    [28271] = 9,  -- Polymorph: Turtle
    [28272] = 9,  -- Polymorph: Pig
    [61721] = 9,  -- Polymorph: Rabbit
    [61780] = 9,  -- Polymorph: Turkey
    [61305] = 9,  -- Polymorph: Black Cat
    [8122]  = 9,  -- Psychic Scream
    [20066] = 9,  -- Repentance
    [6770]  = 9,  -- Sap
    [1513]  = 9,  -- Scare Beast
    [19503] = 9,  -- Scatter Shot
    [6358]  = 9,  -- Seduction
    [9484]  = 9,  -- Shackle Undead
    [1090]  = 9,  -- Sleep
    [10326] = 9,  -- Turn Evil
    [1450679] = 9, -- Turn Evil
    [19386] = 9,  -- Wyvern Sting
    [88625] = 9,  -- Chastise
    [710]   = 9,  -- Banish
    [105421] = 9, -- Blinding Light
    [113506] = 9, -- Cyclone (Symbiosis)

    -- Immunities
    [46924]  = 7, -- Bladestorm
    [19263]  = 7, -- Deterrence
    [47585]  = 7, -- Dispersion
    [642]    = 7, -- Divine Shield
    [498]    = 7, -- Divine Protection
    [45438]  = 7, -- Ice Block
    [34692]  = 7, -- The Beast Within
    [26064]  = 7, -- Shell Shield
    [19574]  = 7, -- Bestial Wrath
    [1022]   = 7, -- Hand of Protection
    [3169]   = 7, -- Invulnerability
    [20230]  = 7, -- Retaliation
    [16621]  = 7, -- Self Invulnerability
    [92681]  = 7, -- Phase Shift
    [20594]  = 7, -- Stoneform
    [31224]  = 7, -- Cloak of Shadows
    [110788] = 7, -- Cloak of Shadows (Symbiosis)
    [27827]  = 7, -- Spirit of Redemption

    -- Anti-CCs
    [48707]  = 7, -- Anti-Magic Shell
    [23920]  = 7, -- Spell Reflection
    [137562] = 7, -- Nimble Brew
    [8178]   = 7, -- Grounding Totem Effect
    [6940]   = 7, -- Hand of Sacrifice
    [5384]   = 7, -- Feign Death
    [34471]  = 7, -- The Beast Within

    -- Silences
    [25046] = 6, -- Arcane Torrent
    [1330]  = 6, -- Garrote
    [15487] = 6, -- Silence (Priest)
    [18498] = 6, -- Silenced - Gag Order (Warrior)
    [18469] = 6, -- Silenced - Improved Counterspell (Mage)
    [55021] = 6, -- Silenced - Improved Counterspell (Mage alt)
    [18425] = 6, -- Silenced - Improved Kick (Rogue)
    [34490] = 6, -- Silencing Shot (Hunter)
    [24259] = 6, -- Spell Lock (Felhunter)
    [47476] = 6, -- Strangulate (Death Knight)
    [43523] = 6, -- Unstable Affliction (Silence effect)
    [114238] = 6, -- Glyph of Fae Silence
    [102051] = 6, -- Frostjaw
    [137460] = 6, -- Ring of Peace (Silence)
    [115782] = 6, -- Optical Blast (Observer)
    [50613]  = 6, -- Arcane Torrent (Runic Power)
    [28730]  = 6, -- Arcane Torrent (Mana)
    [69179]  = 6, -- Arcane Torrent (Rage)
    [80483]  = 6, -- Arcane Torrent (Focus)

    [1766]   = 6, -- Kick (Rogue)
    [2139]   = 6, -- Counterspell (Mage)
    [6552]   = 6, -- Pummel (Warrior)
    [19647]  = 6, -- Spell Lock (Warlock)
    [47528]  = 6, -- Mind Freeze (Death Knight)
    [57994]  = 6, -- Wind Shear (Shaman)
    [91802]  = 6, -- Shambling Rush (Death Knight)
    -- [96231] = 6, -- Rebuke (Paladin) -- intentionally commented out
    [106839] = 6, -- Skull Bash (Feral)
    [115781] = 6, -- Optical Blast (Warlock)
    [116705] = 6, -- Spear Hand Strike (Monk)
    [132409] = 6, -- Spell Lock (Warlock)
    [147362] = 6, -- Countershot (Hunter)
    [171138] = 6, -- Shadow Lock (Warlock)
    [183752] = 6, -- Consume Magic (Demon Hunter)
    [187707] = 6, -- Muzzle (Hunter)
    [212619] = 6, -- Call Felhunter (Warlock)
    [231665] = 6, -- Avenger's Shield (Paladin)
    [351338] = 6, -- Quell (Evoker)
    [97547]  = 6, -- Solar Beam
    [113286] = 6, -- Solar Beam
    [78675] = 6, -- Solar Beam
    [81261] = 6, -- Solar Beam

    [110575] = 5.6, -- Icebound Fortitude (Druid)
    [48792]  = 5.6, -- Icebound Fortitude
    [122783] = 5.6, -- Diffuse Magic
    [116849] = 5.6, -- life Cocoon
    [122470] = 5.6, -- Touch of Karma

    [132158] = 5.5, -- Natures Swiftness
    [378081] = 5.5, -- Natures Swiftness

    -- Disarms
    [676]    = 5, -- Disarm
    [15752]  = 5, -- Disarm
    [14251]  = 5, -- Riposte
    [51722]  = 5, -- Dismantle
    [50541]  = 5, -- Clench (Scorpid)
    [91644]  = 5, -- Snatch (Bird of Prey)
    [117368] = 5, -- Grapple Weapon
    [126458] = 5, -- Grapple Weapon (Symbiosis)
    [137461] = 5, -- Ring of Peace (Disarm)
    [118093] = 5, -- Disarm (Voidwalker/Voidlord)


    -- Roots
    [339]    = 4, -- Entangling Roots
    [19975]  = 4, -- Entangling Roots (Nature's Grasp talent)
    [25999]  = 4, -- Boar Charge
    [4167]   = 4, -- Web
    [122]    = 4, -- Frost Nova
    [33395]  = 4, -- Freeze (Water Elemental)
    [19306]  = 4, -- Counterattack
    [96294]  = 4, -- Chains of Ice (Chilblains)
    [113275] = 4, -- Entangling Roots (Symbiosis)
    [113770] = 4, -- Entangling Roots (?)
    [102359] = 4, -- Mass Entanglement
    [128405] = 4, -- Narrow Escape
    [90327]  = 4, -- Lock Jaw (Dog)
    [54706]  = 4, -- Venom Web Spray (Silithid)
    [50245]  = 4, -- Pin (Crab)
    [110693] = 4, -- Frost Nova (Symbiosis)
    [116706] = 4, -- Disable
    [87194]  = 4, -- Glyph of Mind Blast
    [114404] = 4, -- Void Tendrils
    [115197] = 4, -- Partial Paralysis
    [63685]  = 4, -- Freeze (Frost Shock)
    [107566] = 4, -- Staggering Shout
    [115757] = 4, -- Frost nova
    [105771] = 4, -- Warbringer


    -- Root Proc
    [35963]  = 4, -- Improved Wing Clip
    [19185]  = 4, -- Entrapment
    [23694]  = 4, -- Improved Hamstring
    [64803]  = 4, -- Entrapment
    [111340] = 4, -- Ice Ward
    [123407] = 4, -- Spinning Fire Blossom
    [64695]  = 4, -- Earthgrab Totem


    -- Refreshments
    [22734]  = 3, -- Drink
    [28612]  = 3, -- Cojured Food
    [33717]  = 3, -- Cojured Food

    -- Offensive Buffs
    [124280] = 2, -- Touch of Karma
    [13750]  = 2, -- Adrenaline Rush
    [12042]  = 2, -- Arcane Power
    [31884]  = 2, -- Avenging Wrath
    [34936]  = 2, -- Backlash
    [50334]  = 2, -- Berserk
    [2825]   = 2, -- Bloodlust
    [14177]  = 2, -- Cold Blood
    [12292]  = 2, -- Death Wish
    [16166]  = 2, -- Elemental Mastery
    [12051]  = 2, -- Evocation
    [18708]  = 2, -- Fel Domination
    [12472]  = 2, -- Icy Veins
    [29166]  = 2, -- Innervate
    [32182]  = 2, -- Heroism
    [51690]  = 2, -- Killing Spree
    [47241]  = 2, -- Metamorphasis
    [17941]  = 2, -- Shadow Trance
    [10060]  = 2, -- Power Infusion
    [12043]  = 2, -- Presence of Mind
    [3045]   = 2, -- Rapid Fire
    [1719]   = 2, -- Recklessness
    [51713]  = 2, -- Shadow Dance

    -- Defensive Buffs
    [3411]   = 1, -- Intervene
    [53476]  = 1, -- Intervene (Hunter Pet)
    [871]    = 1, -- Shield Wall
    [33206]  = 1, -- Pain Suppresion
    [47788]  = 1, -- Guardian Spirit
    [47000]  = 1, -- Improved Blink
    [5277]   = 1, -- Evasion
    [30823]  = 1, -- Shamanistic Rage
    [18499]  = 1, -- Berserker Rage
    [55694]  = 1, -- Enraged Regeneration
    [31842]  = 1, -- Divine Favor
    [31821]  = 1, -- Aura Mastery
    [1044]   = 1, -- Hand of Freedom
    [22812]  = 1, -- Barkskin
    [16188]  = 1, -- Nature's Swiftness
    [50461]  = 1, -- Anti-Magic Zone
    [47484]  = 1, -- Huddle

    [5487] = 0.5, -- Bear Form
    [783] = 0.5, -- Travel Form
    [768] = 0.5, -- Cat Form
    [24858] = 0.5, -- Moonkin Form

    [108199] = 0, -- Gorefiend's Grasp
    [102793] = 0, -- Ursol's Vortex
    [61391]  = 0, -- Typhoon
    [13812]  = 0, -- Glyph of Explosive Trap
    [51490]  = 0, -- Thunderstorm
    [6360]   = 0, -- Whiplash
    [115770] = 0, -- Fellash


    -- Miscellaneous
    [41425]  = 0, -- Hypothermia
    [66]     = 0, -- Invisibility
    [6346]   = 0, -- Fear Ward
    [2457]   = 0, -- Battle Stance
    [2458]   = 0, -- Berserker Stance
    [71]     = 0, -- Defensive Stance



    -- ##########################
    -- Cata Bonus Ones, mop above
    -- ##########################
    -- *** Controlled Stun Effects ***
    [93433] = 9, -- Burrow Attack (Worm)
    [83046] = 9, -- Improved Polymorph (Rank 1)
    [83047] = 9, -- Improved Polymorph (Rank 2)
    [2812]  = 9, -- Holy Wrath
    --[88625] = "Stunned", -- Holy Word: Chastise
    [93986] = 9, -- Aura of Foreboding
    [54786] = 9, -- Demon Leap

    -- *** Non-controlled Stun Effects ***
    [85387] = 9, -- Aftermath
    [15283] = 9, -- Stunning Blow (Weapon Proc)
    [56]    = 9, -- Stun (Weapon Proc)

    -- *** Fear Effects ***
    [5134]  = 9, -- Flash Bomb Fear (Item)

    -- *** Controlled Root Effects ***
    [96293] = 4, -- Chains of Ice (Chilblains Rank 1)
    [87193] = 4, -- Paralysis

    -- *** Non-controlled Root Effects ***
    [47168] = 4, -- Improved Wing Clip
    [83301] = 4, -- Improved Cone of Cold (Rank 1)
    [83302] = 4, -- Improved Cone of Cold (Rank 2)
    [55080] = 4, -- Shattered Barrier (Rank 1)
    [83073] = 4, -- Shattered Barrier (Rank 2)
    [50479] = 6, -- Nether Shock (Nether Ray)
    [86759] = 6, -- Silenced - Improved Kick (Rank 2)
}

function sArenaFrameMixin:FindInterrupt(event, spellID)
	local interruptDuration = sArenaMixin.interruptList[spellID]

	if (not interruptDuration) then return end
	if (event ~= "SPELL_INTERRUPT" and event ~= "SPELL_CAST_SUCCESS") then return end

	local unit = self.unit
	local _, _, _, _, _, _, notInterruptable = UnitChannelInfo(unit)

	if (event == "SPELL_INTERRUPT" or notInterruptable == false) then
		self.currentInterruptSpellID = spellID
		self.currentInterruptDuration = interruptDuration
		self.currentInterruptExpirationTime = GetTime() + interruptDuration
		self.currentInterruptTexture = GetSpellTexture(spellID)
		self:FindAura()
		C_Timer.After(interruptDuration, function()
			self.currentInterruptSpellID = nil
			self.currentInterruptDuration = 0
			self.currentInterruptExpirationTime = 0
			self.currentInterruptTexture = nil
			self:FindAura()
		end)
	end
end

function sArenaFrameMixin:FindAura()
    local unit = self.unit
    local auraList = sArenaMixin.auraList

    local currentSpellID, currentDuration, currentExpirationTime, currentTexture
    local currentPriority, currentRemaining = 0, 0

    if self.currentInterruptSpellID then
        currentSpellID = self.currentInterruptSpellID
        currentDuration = self.currentInterruptDuration
        currentExpirationTime = self.currentInterruptExpirationTime
        currentTexture = self.currentInterruptTexture
        currentPriority = 5.9 -- Below Silence, need to clean list
        currentRemaining = currentExpirationTime - GetTime()
    end

    for i = 1, 2 do
        local filter = (i == 1 and "HELPFUL" or "HARMFUL")

        for n = 1, 30 do
            local aura = C_UnitAuras.GetAuraDataByIndex(unit, n, filter)
            if not aura then break end

            local spellID = aura.spellId
            local duration = aura.duration or 0
            local expirationTime = aura.expirationTime or 0
            local texture = aura.icon

            local priority = auraList[spellID]
            if priority then
                local remaining = expirationTime - GetTime()

                if (priority > currentPriority)
                    or (priority == currentPriority and remaining > currentRemaining)
                then
                    currentSpellID = spellID
                    currentDuration = duration
                    currentExpirationTime = expirationTime
                    currentTexture = texture
                    currentPriority = priority
                    currentRemaining = remaining
                end
            end
        end
    end

    if currentSpellID then
        self.currentAuraSpellID = currentSpellID
        self.currentAuraStartTime = currentExpirationTime - currentDuration
        self.currentAuraDuration = currentDuration
        self.currentAuraTexture = currentTexture
    else
        self.currentAuraSpellID = nil
        self.currentAuraStartTime = 0
        self.currentAuraDuration = 0
        self.currentAuraTexture = nil
    end

    self:UpdateClassIcon()
end
