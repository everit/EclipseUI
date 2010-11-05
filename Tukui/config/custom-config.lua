--[[    
	
	!!YOU CAN KEEP THIS FILE WHEN UPDATING!!
	
	So how does this work?
	
	Overall: Overwrites configuration for all your characters.
	
	Characater: Overwrites configuration for the character(s) name(s) listed.
	
	Class: Overwrites configuration for the characters class(es) listed.
	
]] --


----- [[     Overall Custom Config     ]] -----

TukuiCF["general"].game_texture = TukuiCF["media"].custom_texture_1

TukuiCF["unitframes"].classcolor = false

TukuiCF["actionbar"].split_bar = true
TukuiCF["actionbar"].rightbars = 1
TukuiCF["actionbar"].vertical_rightbars = false
TukuiCF["actionbar"].tukui_default = false

TukuiCF["datatext"].location = false
TukuiCF["datatext"].classcolor = true
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



----- [[     Support for TelUI_AddonSkins     ]] -----

local TelUI_AddonSkins = CreateFrame("Frame")

TelUI_AddonSkins:RegisterEvent("ADDON_LOADED")
TelUI_AddonSkins:SetScript("OnEvent", function(self, event, addon)
	if not addon == "TelUI_AddonSkins" then return end

	CustomSkin = { }
	
	CustomSkin.normTexture = TukuiCF["general"].game_texture
	CustomSkin.bgTexture = TukuiCF["general"].game_texture
	CustomSkin.font = TukuiCF["fonts"].datatext_font
	CustomSkin.smallFont = TukuiCF["fonts"].datatext_font
	CustomSkin.fontSize = TukuiCF["fonts"].datatext_font_size
	CustomSkin.fontFlags = TukuiCF["fonts"].datatext_font_style
	CustomSkin.buttonSize = TukuiCF["actionbar"].buttonsize
	CustomSkin.buttonSpacing = TukuiCF["actionbar"].buttonspacing
	CustomSkin.borderWidth = TukuiDB.Scale(2)
	CustomSkin.buttonZoom = { .08, .92, .08, .92 }
	CustomSkin.barSpacing = TukuiDB.Scale(1)
	CustomSkin.barHeight = TukuiCF["panels"].infoheight
	
	function CustomSkin:SkinBackgroundFrame(frame)
		self:SkinFrame(frame)
		TukuiDB.CreateOverlay(frame)
		TukuiDB.CreateShadow(frame)
	end

	self:UnregisterEvent("ADDON_LOADED")
end)

