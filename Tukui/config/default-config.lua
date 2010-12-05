----- [[     General Settings     ]] -----

TukuiCF["general"] = {
	["autoscale"] = true,                  -- mainly enabled for users that don't want to mess with the config file
	["uiscale"] = 0.71,                    -- set your value (between 0.64 and 1) of your uiscale if autoscale is off
	["overridelowtohigh"] = false,         -- EXPERIMENTAL ONLY! override lower version to higher version on a lower reso.
	["multisampleprotect"] = true,         -- i don't recommend this because of shitty border but, voila!
}

----- [[      Customise Settings     ]] -----

TukuiCF["customise"] = {
	["texture"] = TukuiCF["media"].custom_texture_1,
}

----- [[     Unitframe Settings     ]] -----

TukuiCF["unitframes"] = {
	["enable"] = true,                     -- do i really need to explain this?
	["unitcastbar"] = true,                -- enable tukui castbar
	["cblatency"] = false,                 -- enable castbar latency
	["cbicons"] = true,                    -- enable icons on castbar
	["auratimer"] = true,                  -- enable timers on buffs/debuffs
	["auratextscale"] = 11,                -- the font size of buffs/debuffs timers on unitframes
	["playerauras"] = false,               -- enable auras
	["targetauras"] = true,                -- enable auras on target unit frame
	["highThreshold"] = 80,                -- hunter high threshold
	["lowThreshold"] = 20,                 -- global low threshold, for low mana warning.
	["targetpowerpvponly"] = true,         -- enable power text on pvp target only
	["totdebuffs"] = false,                -- enable tot debuffs (high reso only)
	["focusdebuffs"] = false,              -- enable focus debuffs 
	["showfocustarget"] = false,           -- show focus target
	-- ["showtotalhpmp"] = false,             -- change the display of info text on player and target with XXXX/Total.
	["showsmooth"] = true,                 -- enable smooth bar
	["showthreat"] = true,                 -- enable the threat bar anchored to info left panel.
	["charportrait"] = false,              -- do i really need to explain this?
	["maintank"] = false,                  -- enable maintank
	["mainassist"] = false,                -- enable mainassist
	["combatfeedback"] = false,             -- enable combattext on player and target.
	["playeraggro"] = true,                -- color player border to red if you have aggro on current target.
	["positionbychar"] = true,             -- save X, Y position with /uf (movable frame) per character instead of per account.
	["healcomm"] = true,                  -- enable healprediction support.

	["showrange"] = true,                  -- show range opacity on raidframes
	["raidalphaoor"] = 0.3,                -- alpha of unitframes when unit is out of range
	["showsymbols"] = true,	               -- show symbol.
	["aggro"] = true,                      -- show aggro on all raids layouts
	["raidunitdebuffwatch"] = false,        -- track important spell to watch in pve for grid mode.
	["healthvertical"] = true,         -- enable vertical grow on health bar for grid mode.
	["showplayerinparty"] = true,         -- show my player frame in party
	
	["showboss"] = true,                   -- enable boss unit frames for PVELOL encounters.

	-- ["ws_show_player"] = true,             -- show weakened soul bar on player unit
	-- ["ws_show_target"] = true,             -- show weakened soul bar on target unit
	
	["runebar"] = false,                    -- enable tukui runebar plugin
	["totemtimer"] = false,                 -- enable tukui totem timer plugin
	
	["classcolor"] = false,
	["health_color"] = { .15, .15, .15 },
	["health_bg_color"] = { .05, .05, .05},
	
	["showvalues"] = true,
	["showpercentage"] = false,
	["onlyplayerdebuffs"] = true,
	["onlyplayerbuffs"] = true,
	["buffrows"] = 1,
	["debuffrows"] = 1,
}

----- [[     Actionbar Settings     ]] -----

TukuiCF["actionbar"] = {
	["enable"] = true,                     -- enable tukz action bars
	
	["hotkey"] = true,                     -- enable hotkey display because it was a lot requested
	["showgrid"] = true,                   -- show grid on empty button

	["hideshapeshift"] = false,            -- hide shapeshift or totembar because it was a lot requested.
	
	["vertical_rightbars"] = true,
	["vertical_shapeshift"] = false,

	["buttonsize"] = 27,
	["petbuttonsize"] = 27,
	["stancebuttonsize"] = 27,
	["buttonspacing"] = 4,
}

----- [[     Datatext Settings     ]] -----

TukuiCF["datatext"] = {
	["bags"] = 0,                          -- show space used in bags on panels
	["gold"] = 2,                          -- show your current gold on panels
	["guild"] = 0,                         -- show number on guildmate connected on panels
	["friends"] = 3,                       -- show number of friends connected.
	["dps_text"] = 0,                      -- show a dps meter on panels
	["hps_text"] = 0,                      -- show a heal meter on panels
	["power"] = 6,                         -- show your attackpower/spellpower/healpower/rangedattackpower whatever stat is higher gets displayed
	["haste"] = 0,                         -- show your haste rating on panels.
	["crit"] = 0,                          -- show your crit rating on panels.
	["avd"] = 0,                           -- show your current avoidance against the level of the mob your targeting
	["armor"] = 0,                         -- show your armor value against the level mob you are currently targeting
	["currency"] = 5,                      -- show your tracked currency on panels
	["hitrating"] = 0,
	["wintergrasp"] = 4,
	["dur"] = 1,
	
	-- ["battleground"] = true,               -- enable 3 stats in battleground only that replace stat1,stat2,stat3.
	
	["classcolor"] = false,
		["color"] = { 0, .6, 1 },
}

----- [[     Chat Settings     ]] -----

TukuiCF["chat"] = {
	["enable"] = true,                     -- blah
	["whispersound"] = false,               -- play a sound when receiving whisper
	
	["chatheight"] = 140,						-- Set the height of your chat here!
}

----- [[     Panel Settings     ]] -----

TukuiCF["panels"] = {
	["tinfowidth"] = 370,
	["tinfoheight"] = 21,
}

----- [[     Arena Settings     ]] -----

TukuiCF["arena"] = {
	["unitframes"] = false,                 -- enable tukz arena unitframes (requirement : tukui unitframes enabled)
	["spelltracker"] = false,               -- enable tukz enemy spell tracker (an afflicted3 or interruptbar alternative)
}

----- [[     Nameplate Settings     ]] -----

TukuiCF["nameplate"] = {
	["enable"] = true,                     -- enable nice skinned nameplates that fit into tukui
}

----- [[     Bag Settings     ]] -----

TukuiCF["bags"] = {
	["enable"] = true,                     -- enable an all in one bag mod that fit tukui perfectly
}

----- [[     Map Settings     ]] -----

TukuiCF["map"] = {
	["enable"] = true,                     -- reskin the map to fit tukui
}

----- [[     Loot Settings     ]] -----

TukuiCF["loot"] = {
	["lootframe"] = true,                  -- reskin the loot frame to fit tukui
	["rolllootframe"] = true,              -- reskin the roll frame to fit tukui
	["autogreed"] = true,                  -- auto-dez or auto-greed item at max level, auto-greed Frozen orb
}

----- [[     Cooldown Settings     ]] -----

TukuiCF["cooldown"] = {
	["enable"] = true,                     -- do i really need to explain this?
	["treshold"] = 8,                      -- show decimal under X seconds and text turn red
}

----- [[     Tooltip Settings     ]] -----

TukuiCF["tooltip"] = {
	["enable"] = true,                     -- true to enable this mod, false to disable
	["hidecombat"] = false,                -- hide bottom-right tooltip when in combat
	["hidebuttons"] = false,               -- always hide action bar buttons tooltip.
	["hideuf"] = false,                    -- hide tooltip on unitframes
	["cursor"] = false,                    -- tooltip via cursor only
}

----- [[     Merchant Settings     ]] -----

TukuiCF["merchant"] = {
	["sellgrays"] = true,                  -- automaticly sell grays?
	["autorepair"] = true,                 -- automaticly repair?
}

----- [[     Error Settings     ]] -----

TukuiCF["error"] = {
	["enable"] = false,                     -- true to enable this mod, false to disable
	filter = {                             -- what messages to not hide
		["Inventory is full."] = true,     -- inventory is full will not be hidden by default
	},
}

----- [[     Invite Settings     ]] -----

TukuiCF["invite"] = { 
	["autoaccept"] = true,                 -- auto-accept invite from guildmate and friends.
}

----- [[     Buff Reminder Settings     ]] -----

TukuiCF["buffreminder"] = {
	["enable"] = true,                     -- this is now the new innerfire warning script for all armor/aspect class.
	["sound"] = false,                      -- enable warning sound notification for reminder.
}

----- [[     Other Settings     ]] -----

TukuiCF["others"] = {
	["pvpautorelease"] = true,             -- enable auto-release in bg or wintergrasp. (not working for shaman, sorry)
	["move_watchframe"] = true,
}
