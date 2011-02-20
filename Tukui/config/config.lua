local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

C["general"] = {
	["autoscale"] = true,                               -- mainly enabled for users that don't want to mess with the config file
	["uiscale"] = 0.71,                                 -- set your value (between 0.64 and 1) of your uiscale if autoscale is off
	["overridelowtohigh"] = false,                      -- EXPERIMENTAL ONLY! override lower version to higher version on a lower reso.
	["multisampleprotect"] = true,                      -- i don't recommend this because of shitty border but, voila!
}

C["unitframes"] = {
	-- Gen.
	["enable"] = true,                                  -- do i really need to explain this?
	
	-- Colors
	["enemyhcolor"] = false,                            -- enemy target (players) color by hostility, very useful for healer.
	["unicolor"] = true,                               -- enable unicolor theme
		-- if unicolor == true then it uses these colors
		["healthColor"] = { .15, .15, .15 },
		["healthBgColor"] = { .05, .05, .05 },
	
	-- Castbar
	["unitcastbar"] = true,                             -- enable tukui castbar
	["cblatency"] = false,                              -- enable castbar latency
	["cbicons"] = true,                                 -- enable icons on castbar
	["cbclasscolor"] = false,
		-- if cbclasscolor == false then it uses this color
		["cbcustomcolor"] = { .15, .15, .15 },
		
	-- Auras
	["auratimer"] = true,                               -- enable timers on buffs/debuffs
	["auratextscale"] = 11,                             -- the font size of buffs/debuffs timers on unitframes
	["playerauras"] = false,                            -- enable auras
	["targetauras"] = false,                             -- enable auras on target unit frame
	["totdebuffs"] = false,                             -- enable tot debuffs (high reso only)
	["focusdebuffs"] = true,                             -- enable focus debuffs
	["focusbuffs"] = true,                             -- enable focus buffs
	["onlyselfdebuffs"] = false,                        -- display only our own debuffs applied on target
	["onlyselfbuffs"] = true,                        -- display only our own buffs applied on target
	["buffrows"] = 2,                       
	["debuffrows"] = 2,                        
	
	-- Misc.
	["charportrait"] = false,                           -- do i really need to explain this?
	["showtotalhpmp"] = false,                          -- change the display of info text on player and target with XXXX/Total.
	["targetpowerpvponly"] = true,                      -- enable power text on pvp target only
	["showsmooth"] = true,                              -- enable smooth bar
	["lowThreshold"] = 20,                              -- global low threshold, for low mana warning.
	["combatfeedback"] = false,                          -- enable combattext on player and target.
	["playeraggro"] = true,                             -- color player border to red if you have aggro on current target.

	-- Party / Raid
		-- Gen.
		["showrange"] = true,                               -- show range opacity on raidframes
		["raidalphaoor"] = 0.3,                             -- alpha of unitframes when unit is out of range
		["showplayerinparty"] = true,                      -- show my player frame in party
		["showsymbols"] = true,	                            -- show symbol.
		["aggro"] = true,                                   -- show aggro on all raids layouts
		["raidunitdebuffwatch"] = true,                     -- track important spell to watch in pve for grid mode.
		["healcomm"] = true,                               -- enable healprediction support.

		-- Heal
		["healthvertical"] = true,
		["healthdeficit"] = false,	
		
		-- Dps
		["hidepower"] = false,
	

	-- Extra Frames
	["maintank"] = false,                               -- enable maintank
	["mainassist"] = false,                             -- enable mainassist
	["showboss"] = true,                                -- enable boss unit frames for PVELOL encounters.
	-- ["showfocustarget"] = false,					-- show focus target
	
	-- priest only plugin
	["weakenedsoulbar"] = true,                         -- show weakened soul bar
	
	-- class bar
	["classbar"] = true,                                -- enable tukui classbar over player unit
}

C["arena"] = {
	["unitframes"] = true,                              -- enable tukz arena unitframes (requirement : tukui unitframes enabled)
}

C["auras"] = {
	["player"] = true,                                  -- enable tukui buffs/debuffs
}

C["actionbar"] = {
	["enable"] = true,                                  -- enable tukui action bars
	["hotkey"] = true,                                 -- enable hotkey display because it was a lot requested
	["hideshapeshift"] = true,                         -- hide shapeshift or totembar because it was a lot requested.
	["showgrid"] = true,                                -- show grid on empty button
	["buttonsize"] = 27,                                -- normal buttons size
	["petbuttonsize"] = 27,                             -- pet & stance buttons size
	["stancebuttonsize"] = 27,                             -- pet & stance buttons size
	["buttonspacing"] = 4,                              -- buttons spacing
	["vertical_rightbars"] = false,
}

C["bags"] = {
	["enable"] = true,                                  -- enable an all in one bag mod that fit tukui perfectly
}

C["map"] = {
	["enable"] = true,                                  -- reskin the map to fit tukui
}

C["loot"] = {
	["lootframe"] = true,                               -- reskin the loot frame to fit tukui
	["rolllootframe"] = true,                           -- reskin the roll frame to fit tukui
	["autogreed"] = true,                               -- auto-dez or auto-greed item at max level, auto-greed Frozen orb
}

C["cooldown"] = {
	["enable"] = true,                                  -- do i really need to explain this?
	["treshold"] = 8,                                   -- show decimal under X seconds and text turn red
}

C["datatext"] = {
	["armor"] = 0,                                      -- show your armor value against the level mob you are currently targeting
	["avd"] = 0,                                        -- show your current avoidance against the level of the mob your targeting
	["bags"] = 0,                                       -- show space used in bags on panels
	["crit"] = 0,                                       -- show your crit rating on panels.
	["currency"] = 0,                                   -- show your tracked currency on panels
	["dps_text"] = 0,                                   -- show a dps meter on panels
	["dur"] = 6,                                        -- show your equipment durability on panels.
	["fps_ms"] = 4,                                     -- show fps and ms on panels
	["friends"] = 3,                                    -- show number of friends connected.
	["gold"] = 0,                                       -- show your current gold on panels
	["guild"] = 2,                                      -- show number on guildmate connected on panels
	["haste"] = 0,                                      -- show your haste rating on panels.
	["hit"] = 0,
	["hps_text"] = 0,                                   -- show a heal meter on panels
	["mastery"] = 0,
	["micromenu"] = 0,
	["power"] = 0,                                      -- show your attackpower/spellpower/healpower/rangedattackpower whatever stat is higher gets displayed
	["system"] = 5,                                      -- show total memory and others systems infos on panels
	["wowtime"] = 1,                                    -- show time on panels

	["battleground"] = true,                            -- enable 3 stats in battleground only that replace stat1,stat2,stat3.
	["time24"] = false,                                  -- set time to 24h format.
	["localtime"] = true,                              -- set time to local time instead of server time.
	["fontsize"] = 12,                                  -- font size for panels.
	["style"] = "MONOCHROMEOUTLINE", 
	
	["classcolor"] = false,
		["color"] = { .4, .4, .4 },
}

C["chat"] = {
	["enable"] = true,                                  -- blah
	["whispersound"] = true,                            -- play a sound when receiving whisper
}

C["nameplate"] = {
	["enable"] = true,                                  -- enable nice skinned nameplates that fit into tukui
	["showhealth"] = false,				                -- show health text on nameplate
	["enhancethreat"] = false,			                -- threat features based on if your a tank or not
	["overlap"] = false,				                -- allow nameplates to overlap
	["combat"] = false,					                -- only show enemy nameplates in-combat.
	["goodcolor"] = {75/255,  175/255, 76/255},	        -- good threat color (tank shows this with threat, everyone else without)
	["badcolor"] = {0.78, 0.25, 0.25},			        -- bad threat color (opposite of above)
	["transitioncolor"] = {218/255, 197/255, 92/255},	-- threat color when gaining threat
}

C["tooltip"] = {
	["enable"] = true,                                  -- true to enable this mod, false to disable
	["hidecombat"] = false,                             -- hide bottom-right tooltip when in combat
	["hidebuttons"] = false,                            -- always hide action bar buttons tooltip.
	["hideuf"] = false,                                 -- hide tooltip on unitframes
	["cursor"] = false,                                 -- tooltip via cursor only
}

C["merchant"] = {
	["sellgrays"] = true,                               -- automaticly sell grays?
	["autorepair"] = true,                              -- automaticly repair?
	["sellmisc"] = true,                                -- sell defined items automatically
}

C["error"] = {
	["enable"] = true,                                  -- true to enable this mod, false to disable
	filter = {                                          -- what messages to not hide
		[INVENTORY_FULL] = true,                        -- inventory is full will not be hidden by default
	},
}

C["invite"] = { 
	["autoaccept"] = true,                              -- auto-accept invite from guildmate and friends.
}

C["buffreminder"] = {
	["enable"] = true,                                  -- this is now the new innerfire warning script for all armor/aspect class.
	["sound"] = true,                                   -- enable warning sound notification for reminder.
}
