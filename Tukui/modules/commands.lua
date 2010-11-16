----- [[     Heal Layout Command     ]] -----

local function HEAL()
	DisableAddOn("TukuiDps")
	EnableAddOn("TukuiHeal")
	ReloadUI()
end
SLASH_HEAL1 = "/heal"
SlashCmdList["HEAL"] = HEAL


----- [[     Dps Layout Command     ]] -----

local function DPS()
	DisableAddOn("TukuiHeal")
	EnableAddOn("TukuiDps")
	ReloadUI()
end
SLASH_DPS1 = "/dps"
SlashCmdList["DPS"] = DPS