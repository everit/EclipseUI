-- fuck you blizzard, greetings from eclípsé
-- temporary shit until they decide to pick up the slack

local db = TukuiCF.fonts
local font, font_size, font_style, font_shadow = db.datatext_font, db.datatext_font_size, db.datatext_font_style, db.datatext_font_shadow

local frame = CreateFrame("Button", "TukuiReturnToGraveyard", UIParent)
frame:Hide()

local OnEvent = function(self, event, ...)
	if UnitIsGhost("player") then
		self:Show()
		TukuiDB.CreatePanel(frame, 0, 25, "TOPLEFT", TukuiMinimap, "BOTTOMLEFT", 0, TukuiDB.Scale(-3))
		frame:SetPoint("TOPRIGHT", TukuiMinimap, "BOTTOMRIGHT", 0, TukuiDB.Scale(-3))
		frame:SetScript("OnEnter", TukuiDB.SetModifiedBackdrop)
		frame:SetScript("OnLeave", TukuiDB.SetOriginalBackdrop)
		frame:SetScript("OnMouseDown", function() PortGraveyard() end)

		local text = frame:CreateFontString(nil, "OVERLAY", frame)
		text:SetFont(font, font_size, font_style)
		text:SetPoint("TOP")
		text:SetPoint("BOTTOM")
		text:SetText(RETURN_TO_GRAVEYARD)
	else
		self:Hide()
	end
end
frame:RegisterEvent('PLAYER_ALIVE')
frame:RegisterEvent('PLAYER_UNGHOST')
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", OnEvent)