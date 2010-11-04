if UnitLevel("player") == MAX_PLAYER_LEVEL then return end

local db = TukuiCF.fonts
local font, font_size, font_style, font_shadow = db.datatext_font, db.datatext_font_size, db.datatext_font_style, db.datatext_font_shadow


local xp = CreateFrame("Frame", "TukuiExperience", UIParent)
-- if TukuiCF["datatext"].stat_block then
	TukuiDB.CreatePanel(xp, 150, TukuiDB.infoheight, "TOPLEFT", TukuiTimeStats, "TOPLEFT", TukuiTimeStats:GetWidth() + 3, 0)
	-- xp:HookScript("OnUpdate", function(self) xp:SetPoint("TOPLEFT", TukuiTimeStats, "TOPLEFT", TukuiTimeStats:GetWidth() + 3, 0) end)
-- else
	-- TukuiDB.CreatePanel(xp, 150, TukuiDB.infoheight, "TOPLEFT", UIParent, "TOPLEFT", 8, -8)
-- end
xp:EnableMouse(true)

local bar = CreateFrame("StatusBar", "TukuiExperienceBar", xp)
bar:SetPoint("TOPLEFT", xp, TukuiDB.Scale(2), TukuiDB.Scale(-2))
bar:SetPoint("BOTTOMRIGHT", xp, TukuiDB.Scale(-2), TukuiDB.Scale(2))
bar:SetStatusBarTexture(TukuiCF["media"].blank)
xp.bar = bar

local rbar = CreateFrame("StatusBar", "TukuiExperienceRestedBar", xp)
rbar:SetPoint("TOPLEFT", xp, TukuiDB.Scale(2), TukuiDB.Scale(-2))
rbar:SetPoint("BOTTOMRIGHT", xp, TukuiDB.Scale(-2), TukuiDB.Scale(2))
rbar:SetStatusBarTexture(TukuiCF["media"].blank)
rbar:SetFrameLevel(bar:GetFrameLevel() - 1)
xp.rbar = rbar

local text = bar:CreateFontString(nil, "LOW")
text:SetFont(font, font_size, font_style)
text:SetShadowOffset(font_shadow and 1 or 0, font_shadow and -1 or 0)
text:SetPoint("CENTER", xp, 0, 1)
xp.text = text

local rtext = bar:CreateFontString(nil, "LOW")
rtext:SetFont(font, font_size, font_style)
rtext:SetShadowOffset(font_shadow and 1 or 0, font_shadow and -1 or 0)
rtext:SetPoint("CENTER", xp, 0, 1)
xp.rtext = rtext

local xpcolors = {
	{ r = .3, g = .3, b = .8 }, -- Normal Bar
	{ r = .8, g = .3, b = .3 }, -- Rested Bar
}

local function shortvalue(value)
	if value >= 1e6 then
		return ("%.1fm"):format(value / 1e6):gsub("%.?0+([km])$", "%1")
	elseif value >= 1e4 or value <= -1e4 then
		return ("%.1fk"):format(value / 1e3):gsub("%.?0+([km])$", "%1")
	else
		return value
	end
end

local function event(self, event, ...)
	local currValue = UnitXP("player")
	local maxValue = UnitXPMax("player")
	local restXP = GetXPExhaustion()

	bar:SetMinMaxValues(0, maxValue)
	bar:SetValue(currValue)
	
	if restXP ~= nil and restXP > 0 then
		rbar:SetAlpha(1)
		rbar:SetMinMaxValues(0, maxValue)
		rbar:SetValue(currValue + restXP)
		rbar:SetStatusBarColor(xpcolors[2].r, xpcolors[2].g, xpcolors[2].b)
		restXP = shortvalue(restXP)
	else
		rbar:SetAlpha(0)
	end

	currValue = shortvalue(currValue)
	maxValue = shortvalue(maxValue)

	if IsResting() then
		rtext:SetAlpha(1)
		rtext:SetText(TUTORIAL_TITLE30) -- rofl, thanks blizzard
		text:SetAlpha(0)
	else
		text:SetAlpha(1)
		rtext:SetAlpha(0)
	end
	
	if restXP then
		text:SetText(currValue .. " / " .. maxValue .. " R: " .. restXP)
	else
		text:SetText(currValue .. " / " .. maxValue)	
	end
	
	bar:SetStatusBarColor(xpcolors[1].r, xpcolors[1].g, xpcolors[1].b)
end

xp:HookScript("OnEnter", function()
	local currValue = UnitXP("player")
	local maxValue = UnitXPMax("player")
	local restXP = GetXPExhaustion()
	
	local perMax = maxValue - currValue
	local perGain = format("%.1f%%", (currValue / maxValue) * 100)
	local perRem = format("%.1f%%", (perMax / maxValue) * 100)
	
	local bars = format("%.1f", currValue / maxValue * 20)

	GameTooltip:SetOwner(xp, "ANCHOR_BOTTOMRIGHT", -xp:GetWidth(), TukuiDB.Scale(-3))
	GameTooltip:ClearLines()
	GameTooltip:AddLine(cStart .. "Experience:|r")
	GameTooltip:AddLine" "
	GameTooltip:AddDoubleLine(cStart .. "Bars: |r", bars.." / 20", _, _, _, 1, 1, 1)
	GameTooltip:AddDoubleLine(cStart .. "Gained: |r", shortvalue(currValue).." ("..perGain..")", _, _, _, 1, 1, 1)
	GameTooltip:AddDoubleLine(cStart .. "Remaining: |r", shortvalue(maxValue - currValue).." ("..perRem..")", _, _, _, xpcolors[1].r, xpcolors[1].g, xpcolors[1].b)
	GameTooltip:AddDoubleLine(cStart .. "Total: |r", shortvalue(maxValue), _, _, _, 1, 1, 1)
	if restXP ~= nil and restXP > 0 then
		GameTooltip:AddDoubleLine(cStart .. "Rested: |r", shortvalue(restXP).." ("..format("%.f%%", restXP / maxValue * 100)..")", _, _, _, xpcolors[2].r, xpcolors[2].g, xpcolors[2].b)
	end
	
	if IsResting() then
		text:SetAlpha(1)
		rtext:SetAlpha(0)
	end
	
	GameTooltip:Show()
end)
xp:HookScript("OnLeave", function()
	if IsResting() then
		text:SetAlpha(0)
		rtext:SetAlpha(1)
	end
	GameTooltip:Hide() 
end)

xp:RegisterEvent("PLAYER_XP_UPDATE")
xp:RegisterEvent("PLAYER_LEVEL_UP")
xp:RegisterEvent("UPDATE_EXHAUSTION")
xp:RegisterEvent("PLAYER_ENTERING_WORLD")
xp:RegisterEvent("PLAYER_UPDATE_RESTING")
xp:HookScript("OnEvent", event)
