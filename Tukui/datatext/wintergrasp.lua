if TukuiCF["datatext"].wintergrasp and TukuiCF["datatext"].wintergrasp > 0 then
	local db = TukuiCF.fonts
	local font, font_size, font_style, font_shadow = db.datatext_font, db.datatext_font_size, db.datatext_font_style, db.datatext_font_shadow

	local Stat = CreateFrame("Frame")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("BACKGROUND")
 	Stat:SetFrameLevel(3)

	local Text  = TukuiDataLeft:CreateFontString(nil, "OVERLAY")
	Text:SetFont(font, font_size, font_style)
	Text:SetShadowOffset(font_shadow and 1 or 0, font_shadow and -1 or 0)
	TukuiDB.PP(TukuiCF["datatext"].wintergrasp, Text)
	
	FormatTime = function(time)
		local hr, m, s, text
		if time <= 0 then
			text = ""
		elseif(time < 3600 and time > 60) then
			hr = floor(time / 3600)
			m = floor(mod(time, 3600) / 60 + 1)
			text = format("%d" .. cStart .. " M", m)
		elseif(time < 60 and time > 10) then
			m = floor(time / 60)
			s = mod(time, 60)
			text = (m == 0 and format("%d", s))
		elseif time < 10 then
			s = mod(time, 60)
			text = (format("|cffce3a19%d", s))
		else
			hr = floor(time / 3600)
			m = floor(mod(time, 3600) / 60 + 1)
			text = format("%d" .. cStart .. " Hr " .. cEnd .. "%d" .. cStart .. " M", hr, m)
		end
		text = format("|cffffffff".."%s", text)
		return text
	end

	local function Update(self)
		local wgtime = GetWintergraspWaitTime() or nil
		local inInstance, instanceType = IsInInstance()
			if not ( instanceType == "none" ) then
				Text:SetText(cStart .. "WG: " .. cEnd .. QUEUE_TIME_UNAVAILABLE)
			elseif wgtime == nil then
				Text:SetText(cStart .. "WG: " .. cEnd .. WINTERGRASP_IN_PROGRESS)
			else
				Text:SetText(cStart .. "WG: " .. cEnd .. FormatTime(wgtime))
			end
		self:SetAllPoints(Text)
	end
	
	Stat:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, TukuiDB.Scale(6));
		GameTooltip:ClearAllPoints()
		GameTooltip:SetPoint("BOTTOM", self, "TOP", 0, TukuiDB.mult)
		GameTooltip:ClearLines()

		local control = QUEUE_TIME_UNAVAILABLE
		inInstance, instanceType = IsInInstance()
		if not ( instanceType == "none" ) then
			wgtime = QUEUE_TIME_UNAVAILABLE
		elseif wgtime == nil then
			wgtime = WINTERGRASP_IN_PROGRESS
		else
			SetMapByID(485)
			for i = 1, GetNumMapLandmarks() do
				local index = select(3, GetMapLandmarkInfo(i))
				if index == 46 then
					control = "|cFF69CCF0"..FACTION_ALLIANCE.."|r"
				elseif index == 48 then
					control = "|cFFC41F3B"..FACTION_HORDE.."|r"
				end
			end
			SetMapToCurrentZone()
		end
		if TukuiDB.level >= 68 then
			GameTooltip:AddDoubleLine(cStart .. tukuilocal.datatext_control .. cEnd, control, _, _, _, 1, 1, 1)
		end
		GameTooltip:Show()
	end)
	
	Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
	Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
	Stat:RegisterEvent("PLAYER_LOGIN")
	Stat:SetScript("OnUpdate", Update)
	Stat:SetScript("OnMouseDown", function() ToggleFrame(WorldMapFrame) SetMapZoom(4 , 11) end)
	Update(Stat, 10)
end
