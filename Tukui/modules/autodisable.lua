------------------------------------------------------------------------
-- force this if vertical rightbars are disabled so people don't go "OMG ACTION BUTTONS DON'T FIT SIDE/CHAT PANELS"
------------------------------------------------------------------------

if not TukuiCF["actionbar"].vertical_rightbars then
	TukuiCF["panels"].tinfowidth = (TukuiCF["actionbar"].buttonsize * 12) + (TukuiCF["actionbar"].buttonspacing * 13)
end

------------------------------------------------------------------------
-- prevent people from being HURR DURR DERP DERP DERP
------------------------------------------------------------------------

-- if TukuiCF["unitframes"].buffrows > 2 then
	-- TukuiCF["unitframes"].buffrows = 2
-- end

-- if TukuiCF["unitframes"].debuffrows > 3 then
	-- TukuiCF["unitframes"].debuffrows = 3
-- end

------------------------------------------------------------------------
-- overwrite font for some language
------------------------------------------------------------------------

if TukuiDB.client == "ruRU" then
	TukuiCF["media"].uffont = TukuiCF["media"].ru_uffont
	TukuiCF["media"].font = TukuiCF["media"].ru_font
	TukuiCF["media"].dmgfont = TukuiCF["media"].ru_dmgfont
elseif TukuiDB.client == "zhTW" then
	TukuiCF["media"].uffont = TukuiCF["media"].tw_uffont
	TukuiCF["media"].font = TukuiCF["media"].tw_font
	TukuiCF["media"].dmgfont = TukuiCF["media"].tw_dmgfont
elseif TukuiDB.client == "koKR" then
	TukuiCF["media"].uffont = TukuiCF["media"].kr_uffont
	TukuiCF["media"].font = TukuiCF["media"].kr_font
	TukuiCF["media"].dmgfont = TukuiCF["media"].kr_dmgfont
end
