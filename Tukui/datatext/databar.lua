--[[
    My Experience / Reputation / Location / Return to Graveyard bar all wrapped into one toggleable solution.

    To-do:
	-- Clean up code.
	
	© 2010 Eclípsé
]]--

local font = TukuiCF["fonts"].datatext_font
local font_size = TukuiCF["fonts"].datatext_font_size
local font_style = TukuiCF["fonts"].datatext_font_style
local font_shadow = TukuiCF["fonts"].datatext_font_shadow
local font_position = TukuiCF["fonts"].datatext_xy_position

local maxlevel = UnitLevel("player") == MAX_PLAYER_LEVEL

local DataBar = CreateFrame("Frame")

local Colors = {
	{ r = .3, g = .3, b = .8 }, -- Normal Bar
	{ r = .8, g = .3, b = .3 }, -- Rested Bar
	
	{ r = .9, g = .3, b = .3 }, -- Hated
	{ r = .7, g = .3, b = .3 }, -- Hostile
	{ r = .7, g = .3, b = .3 }, -- Unfriendly
	{ r = .8, g = .7, b = .4 }, -- Neutral
	{ r = .3, g = .7, b = .3 }, -- Friendly
	{ r = .3, g = .7, b = .3 }, -- Honored
	{ r = .3, g = .7, b = .3 }, -- Revered
	{ r = .3, g = .9, b = .3 }, -- Exalted
}

local function ShortValue(value)
	if value >= 1e6 then
		return ("%.1fm"):format(value / 1e6):gsub("%.?0+([km])$", "%1")
	elseif value >= 1e4 or value <= -1e4 then
		return ("%.1fk"):format(value / 1e3):gsub("%.?0+([km])$", "%1")
	else
		return value
	end
end

local function Location(self, event)
	if maxlevel then
		DataBar[1].bar:Hide()
		DataBar[2].bar:Hide()
		DataBar[1]:Hide() 
	end

	if UnitIsGhost("player") then
		DataBar[2].text:SetText(RETURN_TO_GRAVEYARD)
	else
		local loc = GetMinimapZoneText()
		local pvpType, isFFA, zonePVPStatus = GetZonePVPInfo()

		if (pvpType == "sanctuary") then
			loc = "|cff69C9EF"..loc.."|r" -- light blue
		elseif (pvpType == "friendly") then
			loc = "|cff00ff00"..loc.."|r" -- green
		elseif (pvpType == "contested") then
			loc = "|cffffff00"..loc.."|r" -- yellow
		elseif (pvpType == "hostile" or pvpType == "combat" or pvpType == "arena" or not pvpType) then
			loc = "|cffff0000"..loc.."|r" -- red
		else
			loc = loc -- white
		end

		DataBar[2].text:SetText(loc)
	end
end

local function Experience()
	if maxlevel then
		DataBar[1].bar:Hide()
		DataBar[2].bar:Hide()
		DataBar[1]:Hide() 
		return 
	else
		local currValue = UnitXP("player")
		local maxValue = UnitXPMax("player")
		local restXP = GetXPExhaustion()

		DataBar[1].bar:SetMinMaxValues(0, maxValue)
		DataBar[1].bar:SetValue(currValue)
		
		if restXP ~= nil and restXP > 0 then
			DataBar[2].bar:SetPoint("TOPLEFT", DataBar[1], TukuiDB.Scale(2), TukuiDB.Scale(-2))
			DataBar[2].bar:SetPoint("BOTTOMRIGHT", DataBar[1], TukuiDB.Scale(-2), TukuiDB.Scale(2))
			DataBar[2].bar:SetAlpha(1)
			DataBar[2].bar:SetMinMaxValues(0, maxValue)
			DataBar[2].bar:SetValue(currValue + restXP)
			DataBar[2].bar:SetStatusBarColor(Colors[2].r, Colors[2].g, Colors[2].b)
			restXP = ShortValue(restXP)
		else
			DataBar[2].bar:SetAlpha(0)
		end

		currValue = ShortValue(currValue)
		maxValue = ShortValue(maxValue)
		
		if restXP then
			DataBar[1].text:SetText(currValue .. " / " .. maxValue .. " R: " .. restXP)
		else
			DataBar[1].text:SetText(currValue .. " / " .. maxValue)	
		end

		DataBar[1].bar:SetStatusBarColor(Colors[1].r, Colors[1].g, Colors[1].b)
	end
end

local function Reputation()
	if maxlevel then
		DataBar[1].bar:Hide()
		DataBar[2].bar:Hide()
		DataBar[1]:Hide() 
	end

	local _, id, min, max, value = GetWatchedFactionInfo()
	local Colors = Colors[id+2]
	
	DataBar[3].bar:SetMinMaxValues(min, max)
	DataBar[3].bar:SetValue(value)
	
	if id > 0 then
		DataBar[3].text:SetText((value - min) .. " / " .. (max - min))
		DataBar[3].bar:SetStatusBarColor(Colors.r, Colors.g, Colors.b)
		DataBar[3].bar:Show()
	else
		DataBar[3].text:SetText("No Reputation Tracked")
	end
end

local SetupBars = function(f, n, s, a1, a, a2, x, y, t)
	f.bar:SetAlpha(n)
	f:SetWidth(s)

	f:ClearAllPoints()
	f:SetPoint(a1, a, a2, x, y)
	
	f.text:SetText(t)
end

local function CheckBars()
	local collapsed, expanded = 25, 200

	if TukuiSaved.experience_shown == true then
		SetupBars(DataBar[1], 1, expanded, "TOP", UIParent, "TOP", 0, TukuiDB.Scale(-8), "")
		SetupBars(DataBar[2], 1, collapsed, "TOPRIGHT", DataBar[1], "TOPLEFT", TukuiDB.Scale(-3), 0, "L")
		SetupBars(DataBar[3], 0, collapsed, "TOPRIGHT", DataBar[2], "TOPLEFT", TukuiDB.Scale(-3), 0, "R")
		
		Experience()
	elseif TukuiSaved.location_shown == true then
		SetupBars(DataBar[2], 0, expanded, "TOP", UIParent, "TOP", 0, TukuiDB.Scale(-8), "")
		SetupBars(DataBar[1], 0, collapsed, "TOPLEFT", DataBar[2], "TOPRIGHT", TukuiDB.Scale(3), 0, "E")
		SetupBars(DataBar[3], 0, collapsed, "TOPRIGHT", DataBar[2], "TOPLEFT", TukuiDB.Scale(-3), 0, "R")

		Location()
	elseif TukuiSaved.reputation_shown == true then
		SetupBars(DataBar[3], 1, expanded, "TOP", UIParent, "TOP", 0, TukuiDB.Scale(-8), "")
		SetupBars(DataBar[2], 0, collapsed, "TOPLEFT", DataBar[3], "TOPRIGHT", TukuiDB.Scale(3), 0, "L")
		SetupBars(DataBar[1], 0, collapsed, "TOPLEFT", DataBar[2], "TOPRIGHT", TukuiDB.Scale(3), 0, "E")

		Reputation()
	end
end

for i = 1, 3 do
	DataBar[i] = CreateFrame("Frame", "TukuiDataFrame"..i, UIParent)
	TukuiDB.CreateUltimate(DataBar[i], false, 200, TukuiCF["panels"].tinfoheight, "CENTER")
	DataBar[i]:EnableMouse(true)
	
	DataBar[i].bar = CreateFrame("StatusBar", "TukuiDataBar"..i, DataBar[i])
	DataBar[i].bar:SetPoint("TOPLEFT", DataBar[i], TukuiDB.Scale(2), TukuiDB.Scale(-2))
	DataBar[i].bar:SetPoint("BOTTOMRIGHT", DataBar[i], TukuiDB.Scale(-2), TukuiDB.Scale(2))
	DataBar[i].bar:SetStatusBarTexture(TukuiCF["customise"].texture)
	DataBar[i].bar:SetFrameLevel(DataBar[i]:GetFrameLevel() + 1)
	DataBar[i].bar:SetAlpha(0)
	
	if i == 1 then
		DataBar[i]:SetScript("OnMouseDown", function()
			TukuiSaved.experience_shown = true
			TukuiSaved.location_shown = false
			TukuiSaved.reputation_shown = false
			CheckBars()
		end)
	elseif i == 2 then
		DataBar[i].bar:SetFrameLevel(DataBar[i-1].bar:GetFrameLevel() - 1)

		DataBar[i]:SetScript("OnMouseDown", function()
			if UnitIsGhost("player") and TukuiSaved.location_shown == true then
				PortGraveyard()
			end

			TukuiSaved.experience_shown = false
			TukuiSaved.location_shown = true
			TukuiSaved.reputation_shown = false
			
			CheckBars()
		end)
	elseif i == 3 then
		DataBar[i]:SetScript("OnMouseDown", function()
			if TukuiSaved.reputation_shown == true then
				ToggleCharacter("ReputationFrame")
			end

			TukuiSaved.experience_shown = false
			TukuiSaved.location_shown = false
			TukuiSaved.reputation_shown = true
			
			CheckBars()
		end)
	end

	DataBar[i].dummy = CreateFrame("Frame", DataBar[i]:GetName().."Dummy"..i, DataBar[i])
	DataBar[i].dummy:SetAllPoints()
	
	DataBar[i].text = DataBar[i].dummy:CreateFontString(nil, "OVERLAY")
	DataBar[i].text:SetFont(font, font_size, font_style)
	DataBar[i].text:SetShadowOffset(font_shadow and 1 or 0, font_shadow and -1 or 0)
	DataBar[i].text:SetPoint("CENTER", DataBar[i], "CENTER", 2, font_position[2])
	TukuiDB.Color(DataBar[i].text)
end
DataBar:SetScript("OnEvent", CheckBars)
DataBar:RegisterEvent("PLAYER_ENTERING_WORLD")
DataBar:RegisterEvent("ZONE_CHANGED_NEW_AREA")
DataBar:RegisterEvent("ZONE_CHANGED")
DataBar:RegisterEvent("ZONE_CHANGED_INDOORS")
DataBar:RegisterEvent("PLAYER_XP_UPDATE")
DataBar:RegisterEvent("PLAYER_LEVEL_UP")
DataBar:RegisterEvent("UPDATE_EXHAUSTION")
DataBar:RegisterEvent("PLAYER_UPDATE_RESTING")
DataBar:RegisterEvent("UPDATE_FACTION")
DataBar:RegisterEvent('PLAYER_ALIVE')
DataBar:RegisterEvent('PLAYER_UNGHOST')