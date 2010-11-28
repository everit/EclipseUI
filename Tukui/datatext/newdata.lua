local ecUI = ecUI

local font = TukuiCF["fonts"].datatext_font
local font_size = TukuiCF["fonts"].datatext_font_size
local font_style = TukuiCF["fonts"].datatext_font_style
local font_shadow = TukuiCF["fonts"].datatext_font_shadow
local font_position = TukuiCF["fonts"].datatext_xy_position

----- [[     Panels     ]] -----

local stat = CreateFrame("Frame")

for i = 1, 4 do
	stat[i] = CreateFrame("Frame", "TukuiStat"..i, UIParent)
	stat[i]:SetSize(70, TukuiCF["panels"].tinfoheight)
	stat[i]:EnableMouse(true)
	ecUI.SkinPanel(stat[i])
	
	stat[i].text = stat[i]:CreateFontString(nil, "OVERLAY")
	stat[i].text:SetFont(font, font_size, font_style)
	stat[i].text:SetSize(stat[i]:GetWidth() - 10, 12)
	stat[i].text:SetShadowOffset(font_shadow and 1 or 0, font_shadow and -1 or 0)
	stat[i].text:SetPoint("CENTER", font_position[1], font_position[2])
	
	-- if i == 3 or i == 4 then
		-- stat[i].bar = CreateFrame("StatusBar", nil, stat[i])
		-- stat[i].bar:SetPoint("TOPLEFT", stat[i], TukuiDB.Scale(2), TukuiDB.Scale(-2))
		-- stat[i].bar:SetPoint("BOTTOMRIGHT", stat[i], TukuiDB.Scale(-2), TukuiDB.Scale(2))
		-- stat[i].bar:SetStatusBarTexture(TukuiCF["customise"].texture)
		-- stat[i].bar:SetFrameLevel(stat[i]:GetFrameLevel())
	-- end

	if i == 1 then
		stat[i]:ClearAllPoints()
		stat[i]:SetPoint("TOPLEFT", TukuiMinimap, "TOPRIGHT", TukuiDB.Scale(3), 0)
		stat[i]:SetWidth(85)
	else
		stat[i]:ClearAllPoints()
		stat[i]:SetPoint("TOPLEFT", stat[i-1], "TOPRIGHT", TukuiDB.Scale(3), 0)
	end
end


----- [[     Time     ]] -----

stat[1]:HookScript("OnMouseDown", function(self, btn)
	if btn == "RightButton" then
		if ecSV.game_time == true then
			ecSV.game_time = false
			ecSV.local_time = true
		elseif ecSV.local_time == true then
			ecSV.game_time = true
			ecSV.local_time = false
		end
	elseif btn == "LeftButton" then
		if ecSV.hr_time == true then
			ecSV.hr_time = false
			hrmode = "Disabled"
		elseif ecSV.hr_time == false then
			ecSV.hr_time = true
			hrmode = "Enabled"
		end
	end
end)

local int4 = 1
local function TimeUpdate(self, t)
	local pendingCalendarInvites = CalendarGetNumPendingInvites()
	int4 = int4 - t
	
	if int4 < 0 then
		if ecSV.local_time == true then
			Hr24 = tonumber(date("%H"))
			Hr = tonumber(date("%I"))
			Min = date("%M")
			
			if ecSV.hr_time == true then
				if pendingCalendarInvites > 0 then
						stat[1].text:SetText(cStart .. "L: |r" .. "|cffFF0000" .. Hr24 .. ":" .. Min)
					else
						stat[1].text:SetText(cStart .. "L: |r" .. Hr24 .. ":" .. Min)
					end
				else
					if Hr24>=12 then
						if pendingCalendarInvites > 0 then
							stat[1].text:SetText(cStart .. "L: |r" .. "|cffFF0000" .. Hr .. ":" .. Min .. cStart .. " pm|r")
						else
							stat[1].text:SetText(cStart .. "L: |r" .. Hr .. ":" .. Min .. cStart .. " pm|r")
						end
				else
					if pendingCalendarInvites > 0 then
						stat[1].text:SetText(cStart .. "L: |r" .. "|cffFF0000" .. Hr .. ":" .. Min .. cStart .. " am|r")
					else
						stat[1].text:SetText(cStart .. "L: |r" .. Hr .. ":" .. Min .. cStart .. " am|r")
					end
				end
			end	
		elseif ecSV.game_time == true then
			local Hr, Min = GetGameTime()
			if Min<10 then Min = "0"..Min end
			if ecSV.hr_time == true then
				if pendingCalendarInvites > 0 then
					stat[1].text:SetText(cStart .. "S: |r" .. "|cffFF0000" .. Hr .. ":" .. Min)
				else
					stat[1].text:SetText(cStart .. "S: |r" .. Hr .. ":" .. Min)
				end
			elseif ecSV.hr_time == false then
				if Hr>=12 then
					if Hr>12 then Hr = Hr-12 end
					if pendingCalendarInvites > 0 then
						stat[1].text:SetText(cStart .. "S: |r" .. "|cffFF0000" .. Hr .. ":" .. Min .. cStart .. " pm|r")
					else
						stat[1].text:SetText(cStart .. "S: |r" .. Hr .. ":" .. Min .. cStart .. " pm|r")
					end
				else
					if Hr == 0 then Hr = 12 end
					if pendingCalendarInvites > 0 then
						stat[1].text:SetText(cStart .. "S: |r" .. "|cffFF0000" .. Hr .. ":" .. Min .. cStart .. " am|r")
					else
						stat[1].text:SetText(cStart .. "S: |r" .. Hr .. ":" .. Min .. cStart .. " am|r")
					end
				end
			end
		end
		int4 = 1
	end
end
stat[1]:SetScript("OnUpdate", TimeUpdate)
TimeUpdate(stat[1], 10)

stat[1]:SetScript("OnEnter", function()
	GameTooltip:SetOwner(stat[1], "ANCHOR_BOTTOMRIGHT", -stat[1]:GetWidth(), TukuiDB.Scale(-3))
	GameTooltip:ClearLines()

	if not ecSV.game_time == true then
		Hr24 = tonumber(date("%H"))
		Hr = tonumber(date("%I"))
		Min = date("%M")

		if ecSV.hr_time == true then
			GameTooltip:AddDoubleLine(cStart .. tukuilocal.datatext_localtime, Hr24 .. ":" .. Min, _, _, _, 1, 1, 1)
		else
			if Hr24>=12 then
				GameTooltip:AddDoubleLine(cStart .. tukuilocal.datatext_localtime, Hr .. ":" .. Min .. " pm|r", _, _, _, 1, 1, 1)
			else
				GameTooltip:AddDoubleLine(cStart .. tukuilocal.datatext_localtime, Hr .. ":" .. Min .. " am|r", _, _, _, 1, 1, 1)
			end
		end	
	else
		local Hr, Min = GetGameTime()
		if Min<10 then Min = "0"..Min end
		if ecSV.hr_time == true then
			GameTooltip:AddDoubleLine(cStart .. tukuilocal.datatext_servertime, Hr .. ":" .. Min, _, _, _, 1, 1, 1)
		else
			if Hr>=12 then
				if Hr>12 then Hr = Hr-12 end
				GameTooltip:AddDoubleLine(cStart .. tukuilocal.datatext_servertime, Hr .. ":" .. Min .. " pm|r", _, _, _, 1, 1, 1)
			else
			if Hr == 0 then Hr = 12 end
			GameTooltip:AddDoubleLine(cStart .. tukuilocal.datatext_servertime, Hr .. ":" .. Min .. " am|r", _, _, _, 1, 1, 1)
		end
	end
end

GameTooltip:AddLine" "
GameTooltip:AddDoubleLine(cStart .. "Right-click:", "Local or Server Time", _, _, _, 1, 1, 1)
GameTooltip:AddDoubleLine(cStart .. "Left-click:", "Format 24H or AM/PM", _, _, _, 1, 1, 1)
GameTooltip:AddDoubleLine(cStart .. "Middle-click:", "Show Calender", _, _, _, 1, 1, 1)

GameTooltip:Show()
end)
stat[1]:SetScript("OnLeave", function() GameTooltip:Hide() end)


----- [[     Memory     ]] -----

local colorme = string.format("%02x%02x%02x", 1*255, 1*255, 1*255)

local function formatMem(memory, color)
	if color then
		statColor = { "|cff"..colorme, "|r" }
	else
		statColor = { "", "" }
	end

	local mb, kb = (cStart .. "mb|r"), (cStart .. "kb|r")
	
	local mult = 10^1
	if memory > 999 then
		local mem = floor((memory/1024) * mult + 0.5) / mult
		if mem % 1 == 0 then
			return mem..string.format(".0 %s" .. mb .. "%s", unpack(statColor))
		else
			return mem..string.format(" %s" .. mb .. "%s", unpack(statColor))
		end
	else
		local mem = floor(memory * mult + 0.5) / mult
			if mem % 1 == 0 then
				return mem..string.format(".0 %s" .. kb .. "%s", unpack(statColor))
			else
				return mem..string.format(" %s" .. kb .. "%s", unpack(statColor))
			end
	end
end

local Total, Mem, MEMORY_TEXT, LATENCY_TEXT, Memory

local function RefreshMem(self)
	Memory = {}

	UpdateAddOnMemoryUsage()
	Total = 0
	for i = 1, GetNumAddOns() do
		Mem = GetAddOnMemoryUsage(i)
		Memory[i] = { select(2, GetAddOnInfo(i)), Mem, IsAddOnLoaded(i) }
		Total = Total + Mem
	end

	MEMORY_TEXT = formatMem(Total, true)
	table.sort(Memory, function(a, b)
		if a and b then
			return a[2] > b[2]
		end
	end)

end

local int, int10 = 10, 1
local function MemUpdate(self, t)
	int = int - t
	int10 = int10 - t
	if int < 0 then
		RefreshMem(self)
		int = 10
	end
	if int10 < 0 then
		local memC

		if Total > 5000 then
			memC = format("|cffCC3333 %s|r ", MEMORY_TEXT)
		elseif Total > 2500 then
			memC = format("|cffFDD842 %s|r ", MEMORY_TEXT)
		else
			memC = format("|cff32DC46 %s|r ", MEMORY_TEXT)
		end

		stat[2].text:SetText(memC)
		int10 = 1
	end
end

stat[2]:SetScript("OnMouseDown", function() collectgarbage("collect") MemUpdate(stat[2], 20) end)
stat[2]:SetScript("OnUpdate", MemUpdate) 

stat[2]:SetScript("OnEnter", function()
	if not InCombatLockdown() then
		local bandwidth = GetAvailableBandwidth()
		GameTooltip:SetOwner(stat[2], "ANCHOR_BOTTOMRIGHT", -stat[2]:GetWidth(), TukuiDB.Scale(-3))
		GameTooltip:ClearLines()
		if bandwidth ~= 0 then
			GameTooltip:AddDoubleLine(cStart .. tukuilocal.datatext_bandwidth,format("%s ".. cStart .. "Mbps",bandwidth), _, _, _, 1, 1, 1)
			GameTooltip:AddDoubleLine(cStart .. tukuilocal.datatext_download,format("%s%%", floor(GetDownloadedPercentage()*100+0.5)), _, _, _, 1, 1, 1)
			GameTooltip:AddLine' ' 
		end
		GameTooltip:AddDoubleLine(cStart .. tukuilocal.datatext_totalmemusage, formatMem(Total), _, _, _, 1, 1, 1)
		GameTooltip:AddLine' '
		for i = 1, #Memory do
			if Memory[i][3] then 
				local red = Memory[i][2]/Total*2
				local green = 1 - red
				GameTooltip:AddDoubleLine(Memory[i][1], formatMem(Memory[i][2], false), 1, 1, 1, red, green+1, 0)						
			end
		end
		GameTooltip:Show()
	end
end)
stat[2]:SetScript("OnLeave", function() GameTooltip:Hide() end)
MemUpdate(stat[2], 20)


----- [[     Fps     ]] -----

local int2 = 1
local function FpsUpdate(self, t)
	int2 = int2 - t
	if int2 < 0 then
		local fps = floor(GetFramerate())
		local color_fps
		
		-- stat[3].bar:SetMinMaxValues(0, 180)
		-- stat[3].bar:SetValue(fps)

		if fps >= 50 then
			color_fps = "|cff32DC46"..floor(GetFramerate()).."|r"
			-- stat[3].bar:SetStatusBarColor(.3, .9, .3)
		elseif fps >= 25 then
			color_fps = "|cffFDD842"..floor(GetFramerate()).."|r"
			-- stat[3].bar:SetStatusBarColor(.8, .7, .4)
		elseif fps >= 0 then
			color_fps = "|cffCC3333"..floor(GetFramerate()).."|r"
			-- stat[3].bar:SetStatusBarColor(.9, .3, .3)
		end
		
		stat[3].text:SetText(cStart .. tukuilocal.datatext_fps .. color_fps)
		
		int2 = 1
	end	
end
stat[3]:SetScript("OnUpdate", FpsUpdate)
FpsUpdate(stat[3], 10)


----- [[     Latency     ]] -----

local int3 = 1
local function LatencyUpdate(self, t)
	int3 = int3 - t
	if int3 < 0 then
		local _, _, ms = GetNetStats()
		local color_ms

		-- stat[4].bar:SetMinMaxValues(0, 500)
		-- stat[4].bar:SetValue(ms)
		
		if ms >= 300 then
			color_ms = "|cffCC3333"..select(3, GetNetStats()).."|r"
			-- stat[4].bar:SetStatusBarColor(.9, .3, .3)
		elseif ms >= 200 then
			color_ms = "|cffFDD842"..select(3, GetNetStats()).."|r"
			-- stat[4].bar:SetStatusBarColor(.8, .7, .4)
		elseif ms >= 0 then
			color_ms = "|cff32DC46"..select(3, GetNetStats()).."|r"
			-- stat[4].bar:SetStatusBarColor(.3, .9, .3)
		end

		stat[4].text:SetText(cStart .. tukuilocal.datatext_ms .. color_ms)

		int3 = 1
	end	
end
stat[4]:SetScript("OnUpdate", LatencyUpdate)
LatencyUpdate(stat[4], 10)