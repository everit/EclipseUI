--[[    
	
	!!YOU CAN KEEP THIS FILE WHEN UPDATING!!
	
	-- Character: Overwrites configuration for the character(s) name(s) listed. --
	
	if TukuiDB.myname == "Eclípsé" then
		TukuiCF["general"].game_texture = custom_texture_1
		
		TukuiCF["actionbar"].buttonsize = 28
		TukuiCF["actionbar"].vertical_rightbars = false
	end
	
	
	-- Class: Overwrites configuration for the characters class(es) listed. --
	
	if TukuiDB.myname == "PRIEST" then
		TukuiCF["general"].game_texture = normTex
		
		TukuiCF["actionbar"].buttonsize = 26
		TukuiCF["actionbar"].vertical_rightbars = true
	end
]] --



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
	
	CustomSkin.normTexture = TukuiCF["customise"].texture
	CustomSkin.bgTexture = TukuiCF["customise"].texture
	CustomSkin.font = TukuiCF["fonts"].datatext_font
	CustomSkin.smallFont = TukuiCF["fonts"].datatext_font
	CustomSkin.fontSize = TukuiCF["fonts"].datatext_font_size
	CustomSkin.fontFlags = TukuiCF["fonts"].datatext_font_style
	CustomSkin.buttonSize = TukuiCF["actionbar"].buttonsize
	CustomSkin.buttonSpacing = TukuiCF["actionbar"].buttonspacing
	CustomSkin.borderWidth = TukuiDB.Scale(2)
	CustomSkin.buttonZoom = { .08, .92, .08, .92 }
	CustomSkin.barSpacing = TukuiDB.Scale(1)
	CustomSkin.barHeight = TukuiCF["panels"].tinfoheight
	
	function CustomSkin:SkinBackgroundFrame(frame)
		self:SkinFrame(frame)
		ecUI.CreateOverlay(frame)
		TukuiDB.CreateShadow(frame)
	end

	self:UnregisterEvent("ADDON_LOADED")
end)

