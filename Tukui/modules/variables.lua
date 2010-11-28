----- [[     Set Up Tukui Tables     ]] -----

TukuiCF = { }
TukuiDB = { }
tukuilocal = { }


----- [[     Set Up Tukui Variables     ]] -----

TukuiDB.dummy = function() return end
TukuiDB.myname, _ = UnitName("player")
_, TukuiDB.myclass = UnitClass("player") 
TukuiDB.client = GetLocale() 
TukuiDB.resolution = GetCurrentResolution()
TukuiDB.getscreenresolution = select(TukuiDB.resolution, GetScreenResolutions())
TukuiDB.version = GetAddOnMetadata("Tukui", "Version")
TukuiDB.incombat = UnitAffectingCombat("player")
TukuiDB.patch = GetBuildInfo()
TukuiDB.level = UnitLevel("player")


----- [[     Set Up ecUI Variables     ]] -----

ecUI = { }

----- [[     Set Up Table Values     ]] -----

if not ecSV then
	ecSV = {
		["minimap_shown"] = true,
		["locked_minimap"] = false,
		
		["bottomrows"] = 1,
		["rightbars"] = 1,
		["splitbars"] = false,
		["locked_actionbars"] = false,
		
		["24h_time"] = false,
		["local_time"] = true,
		["game_time"] = false,
		
		["experience_shown"] = false,
		["location_shown"] = true,
		["reputation_shown"] = false,
		["lfg_shown"] = false,
	}	
end

