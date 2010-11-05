local db = TukuiCF.fonts
local font, font_size, font_style, font_shadow = db.datatext_font, db.datatext_font_size, db.datatext_font_style, db.datatext_font_shadow

local rep = CreateFrame("Frame", "TukuiReputation", UIParent)
if UnitLevel("player") ~= MAX_PLAYER_LEVEL then
	TukuiDB.CreatePanel(rep, 150, TukuiDB.infoheight, "TOPLEFT", TukuiExperience, "TOPRIGHT", 3, 0)
else
	TukuiDB.CreatePanel(rep, 150, TukuiDB.infoheight, "TOPLEFT", TukuiTimeStats, "TOPRIGHT", 3, 0)
end
rep:EnableMouse(true)

local bar = CreateFrame("StatusBar", "TukuiReputationBar", rep)
bar:SetPoint("TOPLEFT", rep, TukuiDB.Scale(2), TukuiDB.Scale(-2))
bar:SetPoint("BOTTOMRIGHT", rep, TukuiDB.Scale(-2), TukuiDB.Scale(2))
bar:SetStatusBarTexture(TukuiCF["general"].game_texture)
rep.bar = bar

local text = bar:CreateFontString(nil, "LOW")
text:SetFont(font, font_size, font_style)
text:SetShadowOffset(font_shadow and 1 or 0, font_shadow and -1 or 0)
text:SetPoint("CENTER", rep, 0, 1)
rep.text = text

local factioncolors = {
	{ r = .9, g = .3, b = .3 }, -- Hated
	{ r = .7, g = .3, b = .3 }, -- Hostile
	{ r = .7, g = .3, b = .3 }, -- Unfriendly
	{ r = .8, g = .7, b = .4 }, -- Neutral
	{ r = .3, g = .7, b = .3 }, -- Friendly
	{ r = .3, g = .7, b = .3 }, -- Honored
	{ r = .3, g = .7, b = .3 }, -- Revered
	{ r = .3, g = .9, b = .3 }, -- Exalted
}

local function event(self, event, ...)
	local _, id, min, max, value = GetWatchedFactionInfo()
	local colors = factioncolors[id]
	
	bar:SetMinMaxValues(min, max)
	bar:SetValue(value)
	
	if id > 0 then
		text:SetText((value - min) .. " / " .. (max - min))
		bar:SetStatusBarColor(colors.r, colors.g, colors.b)
		
		rep:Show()
	else
		rep:Hide()
	end
end

rep:HookScript("OnEnter", function()
	local name, id, min, max, value = GetWatchedFactionInfo()
	local colors = factioncolors[id]
	
	local perMax = max - min
	local perGValue = value - min
	local perNValue = max - value
	
	local perGain = format("%.1f%%", (perGValue / perMax) * 100)
	local perNeed = format("%.1f%%", (perNValue / perMax) * 100)

	GameTooltip:SetOwner(rep, "ANCHOR_BOTTOMRIGHT", -rep:GetWidth(), TukuiDB.Scale(-3))
	GameTooltip:ClearLines()
	GameTooltip:AddLine(cStart .. "Reputation:|r")
	GameTooltip:AddLine" "
	GameTooltip:AddDoubleLine(cStart .. "Faction: |r", name, 1, 1, 1, 1, 1, 1)
	GameTooltip:AddDoubleLine(cStart .. "Standing: |r", _G['FACTION_STANDING_LABEL'..id], 1, 1, 1, colors.r, colors.g, colors.b)
	GameTooltip:AddDoubleLine(cStart .. "Gained: |r", value - min .. " (" .. perGain .. ")", 1, 1, 1, 1, 1, 1)
	GameTooltip:AddDoubleLine(cStart .. "Needed: |r", max - value .. " (" .. perNeed .. ")", 1, 1, 1, .8, .2, .2)
	GameTooltip:AddDoubleLine(cStart .. "Total: |r", max - min, 1, 1, 1, 1, 1, 1)
	
	GameTooltip:Show()
end)
rep:HookScript("OnLeave", function() GameTooltip:Hide() end)

rep:RegisterEvent("UPDATE_FACTION")
rep:RegisterEvent("PLAYER_ENTERING_WORLD")
rep:HookScript("OnEvent", event)
