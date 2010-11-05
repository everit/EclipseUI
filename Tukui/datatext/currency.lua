if TukuiCF["datatext"].currency and TukuiCF["datatext"].currency > 0 then
	local font, font_size, font_style, font_shadow = TukuiCF["fonts"].datatext_font, TukuiCF["fonts"].datatext_font_size, TukuiCF["fonts"].datatext_font_style, TukuiCF["fonts"].datatext_font_shadow

	local Stat = CreateFrame("Frame")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)

	local Text  = TukuiDataLeft:CreateFontString(nil, "OVERLAY")
	Text:SetFont(font, font_size, font_style)
	Text:SetShadowOffset(font_shadow and 1 or 0, font_shadow and -1 or 0)
	TukuiDB.PP(TukuiCF["datatext"].currency, Text)
	
	local function OnEvent(self, event)	
		h_name, h_count, h_icon = GetCurrencyInfo(392) -- Honor Points
		c_name, c_count, c_icon = GetCurrencyInfo(390) -- Conquest Points
		j_name, j_count, j_icon = GetCurrencyInfo(395) -- Justice Points
	
		local honor = ""
		local conquest = ""
		local justice = ""
		if h_count > 0 then
			honor = (cStart .. "H: " .. cEnd .. h_count .. " ")
		end
		if c_count > 0 then
			conquest = (cStart .. "C: " .. cEnd .. c_count .. " ")
		end
		if j_count > 0 then
			justice = (cStart .. "J: " .. cEnd .. j_count)
		end
	
		if h_count == 0 and c_count == 0 and j_count == 0 then
			Text:SetText(cStart .. "No Points") 
		else
			Text:SetText(honor .. conquest .. justice) 
		end
		
		self:SetAllPoints(Text)
	end
	
	Stat:RegisterEvent("HONOR_CURRENCY_UPDATE")
	Stat:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
	Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
	Stat:SetScript("OnEvent", OnEvent)
	Stat:SetScript("OnMouseDown", function() ToggleCharacter("TokenFrame") end)
end