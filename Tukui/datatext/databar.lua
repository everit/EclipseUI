--[[
    My Experience / Reputation / Location / Return to Graveyard bar all wrapped into one toggleable solution.

    To-do:
	-- Clean up code.
	
	© 2010 Eclípsé
]]--

----- [[     Local Variables     ]] -----

local ecUI = ecUI
local font = TukuiCF["fonts"].datatext_font
local font_size = TukuiCF["fonts"].datatext_font_size
local font_style = TukuiCF["fonts"].datatext_font_style
local font_shadow = TukuiCF["fonts"].datatext_font_shadow
local font_position = TukuiCF["fonts"].datatext_xy_position

local maxlevel = UnitLevel("player") == MAX_PLAYER_LEVEL
local collapsed, expanded = 15, 200


----- [[     Panels     ]] -----

local frame = CreateFrame("Frame")

for i = 1, 3 do
	frame[i] = CreateFrame("Frame", "TukuiDataFrame"..i, UIParent)
	frame[i]:SetSize(200, TukuiCF["panels"].tinfoheight)
	frame[i]:EnableMouse(true)
	ecUI.SkinPanel(frame[i])
	
	frame[i].bar = CreateFrame("StatusBar", "TukuiDataBar"..i, frame[i])
	frame[i].bar:SetPoint("TOPLEFT", frame[i], TukuiDB.Scale(2), TukuiDB.Scale(-2))
	frame[i].bar:SetPoint("BOTTOMRIGHT", frame[i], TukuiDB.Scale(-2), TukuiDB.Scale(2))
	frame[i].bar:SetStatusBarTexture(TukuiCF["customise"].texture)
	frame[i].bar:SetFrameLevel(frame[i]:GetFrameLevel() + 1)
	frame[i].bar:SetAlpha(0)
	
	if i == 2 then
		frame[i].bar:SetFrameLevel(frame[i-1].bar:GetFrameLevel() - 1)
	end
	
	frame[i].dummy = CreateFrame("Frame", frame[i]:GetName().."Dummy"..i, frame[i])
	frame[i].dummy:SetAllPoints()
	
	frame[i].text = frame[i].dummy:CreateFontString(nil, "OVERLAY")
	frame[i].text:SetFont(font, font_size, font_style)
	frame[i].text:SetShadowOffset(font_shadow and 1 or 0, font_shadow and -1 or 0)
	frame[i].text:SetPoint("CENTER", frame[i], "CENTER", 2, font_position[2])
end

local expframe = frame[1]
local locframe = frame[2]
local repframe = frame[3]



----- [[     Color Table     ]] -----

local colors = {
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


----- [[     Short Value Function     ]] -----

local function shortvalue(value)
	if value >= 1e6 then
		return ("%.1fm"):format(value / 1e6):gsub("%.?0+([km])$", "%1")
	elseif value >= 1e4 or value <= -1e4 then
		return ("%.1fk"):format(value / 1e3):gsub("%.?0+([km])$", "%1")
	else
		return value
	end
end


----- [[     Location / Return To Graveyard Function     ]] -----

local function location(self, event)
	if maxlevel then
		expframe.bar:Hide()
		locframe.bar:Hide()
		expframe:Hide() 
	end

	if UnitIsGhost("player") then
		locframe.text:SetText(RETURN_TO_GRAVEYARD)
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

		locframe.text:SetText(loc)
	end
end


----- [[     Experience Functon     ]] -----

local function experience()
	if maxlevel then
		expframe.bar:Hide()
		locframe.bar:Hide()
		expframe:Hide()
		return 
	else
		local currValue = UnitXP("player")
		local maxValue = UnitXPMax("player")
		local restXP = GetXPExhaustion()

		expframe.bar:SetMinMaxValues(0, maxValue)
		expframe.bar:SetValue(currValue)
		
		if restXP ~= nil and restXP > 0 then
			locframe.bar:SetPoint("TOPLEFT", expframe, TukuiDB.Scale(2), TukuiDB.Scale(-2))
			locframe.bar:SetPoint("BOTTOMRIGHT", expframe, TukuiDB.Scale(-2), TukuiDB.Scale(2))
			locframe.bar:SetAlpha(1)
			locframe.bar:SetMinMaxValues(0, maxValue)
			locframe.bar:SetValue(currValue + restXP)
			locframe.bar:SetStatusBarColor(colors[2].r, colors[2].g, colors[2].b)
			restXP = shortvalue(restXP)
		else
			locframe.bar:SetAlpha(0)
		end

		currValue = shortvalue(currValue)
		maxValue = shortvalue(maxValue)
		
		if restXP then
			expframe.text:SetText(currValue .. " / " .. maxValue .. " R: " .. restXP)
		else
			expframe.text:SetText(currValue .. " / " .. maxValue)	
		end

		expframe.bar:SetStatusBarColor(colors[1].r, colors[1].g, colors[1].b)
	end
end


----- [[     Reputation Function     ]] -----

local function reputation()
	if maxlevel then
		expframe.bar:Hide()
		locframe.bar:Hide()
		expframe:Hide() 
	end

	local _, id, min, max, value = GetWatchedFactionInfo()
	local colors = colors[id+2]
	
	repframe.bar:SetMinMaxValues(min, max)
	repframe.bar:SetValue(value)
	
	if id > 0 then
		repframe.text:SetText((value - min) .. " / " .. (max - min))
		repframe.bar:SetStatusBarColor(colors.r, colors.g, colors.b)
		repframe.bar:Show()
	else
		repframe.text:SetText(cStart .. "No Reputation Tracked")
	end
end


----- [[     Set Up / Check Function     ]] -----

local um = function(f, n, s, a1, a, a2, x, y, t)
	f.bar:SetAlpha(n)
	f:SetWidth(s)

	f:ClearAllPoints()
	f:SetPoint(a1, a, a2, x, y)
	
	f.text:SetText(cStart .. t)
end

local function setup()
	if ecSV.experience_shown == true then
		um(expframe, 1, expanded, "TOP", UIParent, "TOP", 0, TukuiDB.Scale(-8), "")
		um(locframe, 1, collapsed, "TOPRIGHT", expframe, "TOPLEFT", TukuiDB.Scale(-3), 0, "L")
		um(repframe, 0, collapsed, "TOPRIGHT", locframe, "TOPLEFT", TukuiDB.Scale(-3), 0, "R")
		
		experience()
	elseif ecSV.location_shown == true then
		um(locframe, 0, expanded, "TOP", UIParent, "TOP", 0, TukuiDB.Scale(-8), "")
		um(expframe, 0, collapsed, "TOPLEFT", locframe, "TOPRIGHT", TukuiDB.Scale(3), 0, "E")
		um(repframe, 0, collapsed, "TOPRIGHT", locframe, "TOPLEFT", TukuiDB.Scale(-3), 0, "R")

		location()
	elseif ecSV.reputation_shown == true then
		um(repframe, 1, expanded, "TOP", UIParent, "TOP", 0, TukuiDB.Scale(-8), "")
		um(locframe, 0, collapsed, "TOPLEFT", repframe, "TOPRIGHT", TukuiDB.Scale(3), 0, "L")
		um(expframe, 0, collapsed, "TOPLEFT", locframe, "TOPRIGHT", TukuiDB.Scale(3), 0, "E")

		reputation()
	end
end
frame:SetScript("OnEvent", setup)

----- [[     Register Events     ]] -----

frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
frame:RegisterEvent("ZONE_CHANGED")
frame:RegisterEvent("ZONE_CHANGED_INDOORS")
frame:RegisterEvent("PLAYER_XP_UPDATE")
frame:RegisterEvent("PLAYER_LEVEL_UP")
frame:RegisterEvent("UPDATE_EXHAUSTION")
frame:RegisterEvent("PLAYER_UPDATE_RESTING")
frame:RegisterEvent("UPDATE_FACTION")
frame:RegisterEvent('PLAYER_ALIVE')
frame:RegisterEvent('PLAYER_UNGHOST')


----- [[     Mouse-click Functions     ]] -----

expframe:SetScript("OnMouseDown", function()
	ecSV.experience_shown = true
	ecSV.location_shown = false
	ecSV.reputation_shown = false
	setup()
end)

locframe:SetScript("OnMouseDown", function()
	ecSV.experience_shown = false
	ecSV.location_shown = true
	ecSV.reputation_shown = false
	setup()
end)

repframe:SetScript("OnMouseDown", function()
	ecSV.experience_shown = false
	ecSV.location_shown = false
	ecSV.reputation_shown = true
	setup()
end)