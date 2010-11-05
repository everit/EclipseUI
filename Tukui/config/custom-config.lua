--[[    
	
	!!YOU CAN KEEP THIS FILE WHEN UPDATING!!
	
	So how does this work?
	
	Overall: Overwrites configuration for all your characters.
	
	Characater: Overwrites configuration for the character(s) name(s) listed.
	
	Class: Overwrites configuration for the characters class(es) listed.
	
]] --


----- [[     Overall Custom Config     ]] -----

TukuiCF["unitframes"].classcolor = true

TukuiCF["actionbar"].split_bar = true
TukuiCF["actionbar"].rightbars = 1
TukuiCF["actionbar"].vertical_rightbars = false
TukuiCF["actionbar"].tukui_default = false

TukuiCF["datatext"].location = false
TukuiCF["datatext"].classcolor = false
TukuiCF["datatext"].color = { 0, .6, 1 }

TukuiCF["media"].bordercolor = { .125, .125, .125, 1 }
TukuiCF["media"].backdropcolor = { 0, 0, 0, 1 }
TukuiCF["media"].fadedbackdropcolor = { 0, 0, 0, .7 }


----- [[     Character Custom Config     ]] -----

if TukuiDB.myname == "Your name here" then
	-- Config here
end


----- [[     Class Custom Config     ]] -----

if TukuiDB.myclass == "PRIEST" then
	-- Config here
end