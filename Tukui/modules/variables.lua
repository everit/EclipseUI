----- [[     Set Up Table Values On Initial Login If They Don't Exist     ]] -----

if not EclipseSettings then
	EclipseSettings = {
		["minimap_shown"] = true,
		
		["bottomrows"] = 1,
		["rightbars"] = 1,
		["splitbars"] = false,
		
		["24h_time"] = false,
		["local_time"] = true,
		["game_time"] = false,
		
		["location_shown"] = true,
		["experience_shown"] = false,
		["reputation_shown"] = false,
	}	
end


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



