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
    [114028] = 10, -- Mass Spell Reflection
    [23920]  = 10, -- Spell Reflection
    [8178]   = 10, -- Grounding Totem Effect

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
    [96201] = 9, -- Web Wrap
    [132168] = 9, -- Shockwave
    [118895] = 9, -- Dragon Roar
    [115001] = 9, -- Remorseless Winter
    [122057] = 9, -- Clash
    [102795] = 9, -- Bear Hug
    [77505] = 9, -- Earthquake
    [15618] = 9, -- Snap Kick
    [113953] = 9, -- Paralysis
    [137143] = 9, -- Blood Horror

    -- Stun Procs
    [34510] = 9,  -- Stun (various procs)
    [20170] = 9,  -- Seal of Justice
    [12355] = 9,  -- Impact
    [23454] = 9,  -- Stun

    -- Disorient / Incapacitate / Fear / Charm
    [2094]  = 9,  -- Blind
    [31661] = 9,  -- Dragon's Breath
    [5782]  = 9,  -- Fear
    [130616] = 9, -- Fear (Glyphed)
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
    [145067] = 9, -- Turn Evil
    [19386] = 9,  -- Wyvern Sting
    [88625] = 9,  -- Chastise
    [710]   = 9,  -- Banish
    [105421] = 9, -- Blinding Light
    [113506] = 9, -- Cyclone (Symbiosis)
    [126355] = 9, -- Paralyzing Quill
    [126246] = 9, -- Lullaby
    [91800] = 9,   -- Gnaw (Ghoul stun)
    [64044] = 9, -- Psychic Horror (alt ID)
    [31117]  = 9, -- UA silence (on dispel)
    [126423] = 9, -- Petrifying Gaze (Basilisk pet) -- TODO: verify category

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
    [20594]  = 7, -- Stoneform -- FIX
    [31224]  = 7, -- Cloak of Shadows
    [110788] = 7, -- Cloak of Shadows (Symbiosis)
    [27827]  = 7, -- Spirit of Redemption
    [49039] = 7, -- Lichborne
    [148467] = 7, -- Deterrence

    -- Anti-CCs
    [115018] = 7, -- Desecrated Ground (All CC Immunity)
    [48707]  = 7, -- Anti-Magic Shell
    [137562] = 7, -- Nimble Brew
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
    [31935] = 6, -- Avenger's Shield
    [116709] = 6, -- Spear Hand Strike
    [142895] = 6, -- Silence (Ring of Peace?)

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
    [142896] = 5, -- Disarmed
    [116844] = 5, -- Ring of Peace (Silence / Disarm)

    -- Big defensives
    [116849] = 4.5, -- life Cocoon
    [110575] = 4.5, -- Icebound Fortitude (Druid)
    [48792]  = 4.5, -- Icebound Fortitude
    [122783] = 4.5, -- Diffuse Magic
    [122470] = 4.5, -- Touch of Karma
    [132158] = 4.5, -- Natures's Swiftness
    [378081] = 4.5, -- Natures's Swiftness
    [16188]  = 4.5, -- Nature's Swiftness

    -- Roots
    [339]    = 4, -- Entangling Roots
    [19975]  = 4, -- Entangling Roots (Nature's Grasp talent)
    [25999]  = 4, -- Boar Charge
    [4167]   = 4, -- Web
    [122]    = 4, -- Frost Nova
    [33395]  = 4, -- Freeze (Water Elemental)
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
    [53148] = 4, -- Charge
    [136634] = 4, -- Narrow Escape
    --[127797] = 4, -- Ursol's Vortex
    [81210] = 4, -- Net
    [35963]  = 4, -- Improved Wing Clip
    [19185]  = 4, -- Entrapment
    [23694]  = 4, -- Improved Hamstring
    [64803]  = 4, -- Entrapment
    [111340] = 4, -- Ice Ward
    [123407] = 4, -- Spinning Fire Blossom
    [64695]  = 4, -- Earthgrab Totem
    [91807] = 4,   -- Shambling Rush


    -- Defensive Buffs
    [115610] = 2.5, -- Temporal Shield
    [147833] = 2.4, -- Intervene
    [114029] = 2.4, -- Safeguard
    [3411]   = 2.4, -- Intervene
    [53476]  = 2.4, -- Intervene (Hunter Pet)
    [111264] = 2.3, -- Ice Ward (Buff)
    [89485]  = 2.3, -- Inner Focus (instant cast immunity)
    [113862] = 2.3, -- Greater Invisibility (90% dmg reduction)
    [111397] = 2.3, -- Blood Horror (flee on attack)
    [45182] = 2.2, -- Cheating Death (85% reduced inc dmg)
    [31821]  = 2.2, -- Aura Mastery
    [53480] = 2.1,   -- Roar of Sacrifice
    [124280] = 2, -- Touch of Karma
    [871]    = 2, -- Shield Wall
    [33206]  = 2, -- Pain Suppresion
    [47788]  = 2, -- Guardian Spirit
    [47000]  = 2, -- Improved Blink
    [5277]   = 2, -- Evasion
    [30823]  = 2, -- Shamanistic Rage
    [18499]  = 2, -- Berserker Rage
    [55694]  = 2, -- Enraged Regeneration
    [31842]  = 2, -- Divine Favor
    [1044]   = 2, -- Hand of Freedom
    [22812]  = 2, -- Barkskin
    [50461]  = 2, -- Anti-Magic Zone
    [47484]  = 2, -- Huddle
    [97463]  = 2, -- Rallying Cry
    [1966]  = 2, -- Feint
    [86669] = 2, -- Guardian of Ancient Kings
    [108359] = 2, -- Dark Regeneration
    [108416] = 2, -- Sacrificial Pact
    [104773] = 2, -- Unending Resolve
    [110913] = 2, -- Dark Bargain
    [79206] = 2, -- Spiritwalker's Grace (movement casting)
    [108271] = 2, -- Astral Shift
    [108281] = 2, -- Ancestral Guidance (healing)
    [31616] = 2, -- Nature’s Guardian
    [114052] = 2, -- Ascendance (Restoration)
    [61336] = 2, -- Survival Instincts
    [106922] = 2, -- Might of Ursoc
    [122278] = 2, -- Dampen Harm
    [120954] = 2, -- Fortifying Brew
    [115176] = 2, -- Zen Meditation
    [81782] = 2,   -- Power Word: Barrier
    [109964] = 2, -- Spirit Shell (Buff)
    [29166]  = 1.9, -- Innervate
    [114908] = 1.8, -- Spirit Shell (Absorb Shield)
    [64901] = 1.8, -- Hymn of Hope
    [98007] = 1.8,   -- Spirit Link Totem
    [25771] = 0.3,  -- Forbearance (debuff)

    [11426]  = 0.9, -- Ice Barrier
    [114214] = 1, -- Angelic Bulwark
    [114893] = 1,  -- Stone Bulwark Totem
    [145629] = 1,  -- Anti-Magic Zone
    [76577] = 0.8, -- Smoke Bomb



    -- Offensive Buffs
    [13750]  = 1, -- Adrenaline Rush
    [12042]  = 1, -- Arcane Power
    [31884]  = 1, -- Avenging Wrath
    [34936]  = 1, -- Backlash
    [50334]  = 1, -- Berserk
    [2825]   = 1, -- Bloodlust
    [14177]  = 1, -- Cold Blood
    [12292]  = 1, -- Death Wish
    [16166]  = 1, -- Elemental Mastery
    [12051]  = 1, -- Evocation
    [18708]  = 1, -- Fel Domination
    [12472]  = 1, -- Icy Veins
    [32182]  = 1, -- Heroism
    [51690]  = 1, -- Killing Spree
    [47241]  = 1, -- Metamorphasis
    [17941]  = 1, -- Shadow Trance
    [10060]  = 1, -- Power Infusion
    [12043]  = 4.6, -- Presence of Mind
    [3045]   = 1, -- Rapid Fire
    [1719]   = 1, -- Recklessness
    [51713]  = 1, -- Shadow Dance
    [107574] = 1, -- Avatar
    --[79140]  = 1, -- Vendetta
    [121471] = 1, -- Shadow Blades
    [83853] = 1, -- Combustion
    [105809] = 1, -- Holy Avenger
    [86698] = 1, -- Guardian of Ancient Kings (alt)
    [113858] = 1, -- Dark Soul: Instability
    [113860] = 1, -- Dark Soul: Misery
    [113861] = 1, -- Dark Soul: Knowledge
    [114050] = 1, -- Ascendance (Enhancement)
    [114051] = 1, -- Ascendance (Elemental)
    [102543] = 1, -- Incarnation: King of the Jungle
    [102560] = 1, -- Incarnation: Chosen of Elune
    [106951] = 1, -- Berserk
    [124974] = 1, -- Nature’s Vigil
    [51271] = 1, -- Pillar of Frost
    [49206] = 1, -- Summon Gargoyle
    [114868] = 1, -- Soul Reaper (Buff)
    [137639] = 1, -- Storm, Earth, and Fire
    [12328]  = 1, -- Sweeping Strikes
    [113656] = 0.8, -- Fists of Fury



    -- Misc
    [77616] = 0.7, -- Dark Simulacrum (Buff, has spell)
    [41635] = 0.5, -- Prayer of Mending
    [64844] = 0.5, -- Divine Hymn
    [116841] = 0.5, -- Tiger's Lust (70% speed)
    [114896] = 0.5,  -- Windwalk Totem
    [114206] = 0.5,  -- Skull Banner


    -- Slows
    [50435] = 0.4, -- Chilblains (50%)
    [12323]  = 0.4, -- Piercing Howl (50%)
    [113092] = 0.4, -- Frost Bomb (70%)
    [120]   = 0.4, -- Cone of Cold (70%)
    [60947]  = 0.4, -- Nightmare (30%)
    [1715]  = 0.4,   -- Hamstring (50%)

    [34709] = 0.6, -- Shadow Sight (Arena Eye)

    -- Forms
    [5487] = 0.5, -- Bear Form
    [783] = 0.5, -- Travel Form
    [768] = 0.5, -- Cat Form
    [24858] = 0.5, -- Moonkin Form


    -- Refreshments
    [22734]  = 0.2, -- Drink
    [28612]  = 0.2, -- Cojured Food
    [33717]  = 0.2, -- Cojured Food

    [108366] = 0.1, -- Soul Leech

    [108199] = 0, -- Gorefiend's Grasp
    [102793] = 0, -- Ursol's Vortex
    [61391]  = 0, -- Typhoon
    [13812]  = 0, -- Glyph of Explosive Trap
    [51490]  = 0, -- Thunderstorm
    [6360]   = 0, -- Whiplash
    [115770] = 0, -- Fellash
    [114018] = 0, -- Shroud of Concealment
    [110960] = 0, -- Greater Invisibility (Invis)


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
    --[2812]  = 9, -- Holy Wrath
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



















local asd = {
      -- Special
    --[77606] = 10, -- Dark Simulacrum (Debuff)
    [77616] = 3.5, -- Dark Simulacrum (Buff, has spell)

    -- Anti-CCs
    [115018] = 7.5, -- Desecrated Ground (All CC Immunity)

    -- Immunities
    [49039] = 7, -- Lichborne
    [148467] = 7, -- Deterrence



    -- Disarms
    [142896] = 5, -- Disarmed
    [116844] = 5, -- Ring of Peace (Silence / Disarm)

    -- Offensive Buffs
    [51271] = 2, -- Pillar of Frost
    [49206] = 2, -- Summon Gargoyle
    [114868] = 2, -- Soul Reaper (Buff)

    -- Slows
    [50435] = 0.6, -- Chilblains (50%)
    [12323]  = 0.6, -- Piercing Howl (50%)
    [113092] = 0.6, -- Frost Bomb (70%)
    [120]   = 0.6, -- Cone of Cold (70%)
    [60947]  = 0.6, -- Nightmare (30%)
    [1715]  = 0.6,   -- Hamstring (50%)

    -- Offensive Buffs
    [107574] = 2, -- Avatar
    [113344] = 2, -- Bloodbath (alt)
    [12328]  = 2, -- Sweeping Strikes
    [79140]  = 2, -- Vendetta
    [121471] = 2, -- Shadow Blades
    [83853] = 2, -- Combustion
    [105809] = 2, -- Holy Avenger
    [86698] = 2, -- Guardian of Ancient Kings (alt)
    [113858] = 2, -- Dark Soul: Instability
    [113860] = 2, -- Dark Soul: Misery
    [113861] = 2, -- Dark Soul: Knowledge
    [114050] = 2, -- Ascendance (Enhancement)
    [114051] = 2, -- Ascendance (Elemental)
    [102543] = 2, -- Incarnation: King of the Jungle
    [102560] = 2, -- Incarnation: Chosen of Elune
    [106951] = 2, -- Berserk
    [124974] = 2, -- Nature’s Vigil

    -- Defensive Buffs
    [97463]  = 1, -- Rallying Cry
    [114029] = 1, -- Safeguard
    [147833] = 1, -- Intervene
    [1966]  = 1, -- Feint
    [45182] = 1, -- Cheating Death (85% reduced inc dmg)
    [113862] = 1, -- Greater Invisibility (90% dmg reduction)
    [86669] = 1, -- Guardian of Ancient Kings
    [108359] = 1, -- Dark Regeneration
    [111397] = 1, -- Blood Horror (flee on attack)
    [108416] = 1, -- Sacrificial Pact
    [104773] = 1, -- Unending Resolve
    [110913] = 1, -- Dark Bargain
    [79206] = 1, -- Spiritwalker's Grace (movement casting)
    [108271] = 1, -- Astral Shift
    [108281] = 1, -- Ancestral Guidance (healing)
    [31616] = 1, -- Nature’s Guardian
    [114052] = 1, -- Ascendance (Restoration)
    [61336] = 1, -- Survival Instincts
    [106922] = 1, -- Might of Ursoc
    [122278] = 1, -- Dampen Harm
    [120954] = 1, -- Fortifying Brew
    [115176] = 1, -- Zen Meditation
    [81782] = 1,   -- Power Word: Barrier
    [53480] = 1,   -- Roar of Sacrifice

    -- Lesser
    [11426]  = 0.9, -- Ice Barrier
    [115610] = 1.1, -- Temporal Shield
    [114214] = 1, -- Angelic Bulwark
    [108366] = 1, -- Soul Leech
    [114893] = 1,  -- Stone Bulwark Totem
    [145629] = 1,  -- Anti-Magic Zone

    -- Misc
    [114018] = 0, -- Shroud of Concealment
    [111264] = 3.5, -- Ice Ward (Buff)
    [110960] = 0, -- Greater Invisibility (Invis)
    [89485]  = 3.5, -- Inner Focus (instant cast immunity)
    [109964] = 1, -- Spirit Shell (Buff)
    [114908] = 0.9, -- Spirit Shell (Absorb Shield)
    [64901] = 0.5, -- Hymn of Hope
    [25771] = 0.5,  -- Forbearance (debuff)
    [98007] = 0.5,   -- Spirit Link Totem

    -- Full CC (Stuns and Disorients)


    -- Misc
    --[81700]  = 1, -- Archangel (healing boost)
    [41635] = 0.5, -- Prayer of Mending
    [64844] = 0.5, -- Divine Hymn
    [116841] = 0.5, -- Tiger's Lust (70% speed)
    [114896] = 0.5,  -- Windwalk Totem
    [114206] = 0.5,  -- Skull Banner


    --[117405] = 9, -- Binding Shot (Will get stunned if move out)

    -- Offensive Cooldowns
    [113656] = 0.5, -- Fists of Fury
    [137639] = 2, -- Storm, Earth, and Fire

    -- CC
    [91800] = 9,   -- Gnaw (Ghoul stun)
    [64044] = 9, -- Psychic Horror (alt ID)
    [31117]  = 9, -- UA silence (on dispel)
    [91807] = 4,   -- Shambling Rush (root)
    --[19577]  = 9, -- Intimidation (???)
    [126423] = 9, -- Petrifying Gaze (Basilisk pet) -- TODO: verify category

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
