if not TukuiCF["map"].enable == true then return end


----- [[     Local Variables     ]] -----

local mapscale = WORLDMAP_WINDOWED_SIZE
local font, font_size, font_style, font_shadow, font_position = TukuiCF["fonts"].map_font, TukuiCF["fonts"].map_font_size, TukuiCF["fonts"].map_font_style, TukuiCF["fonts"].map_font_shadow, TukuiCF["fonts"].map_button_xy_position
local infoheight = TukuiCF["panels"].tinfoheight


----- [[     Map Background     ]] -----

local map = CreateFrame("Frame", "TukuiMap", WorldMapDetailFrame)
TukuiDB.SkinPanel(map)


----- [[     Map Title Frame     ]] -----

local mapTitle = CreateFrame ("Frame", "TukuiMapTitle", WorldMapDetailFrame)
TukuiDB.SkinFadedPanel(mapTitle)
mapTitle:SetHeight(infoheight)


----- [[     Map Lock Button     ]] -----

local mapLock = CreateFrame ("Frame", "TukuiMapLock", WorldMapDetailFrame)
TukuiDB.CreatePanel(mapLock, 0, infoheight, "BOTTOMRIGHT", WorldMapDetailFrame, "TOPRIGHT", TukuiDB.Scale(2), TukuiDB.Scale(5))
mapLock:SetScale(1 / mapscale)
mapLock:SetFrameStrata("HIGH")
mapLock:EnableMouse(true)
mapLock:Hide()

local lockText = mapLock:CreateFontString(nil, "OVERLAY")
lockText:SetFont(font, font_size, font_style)
lockText:SetPoint("CENTER", font_position[1], font_position[2])
lockText:SetText(tukuilocal.map_move)
mapLock:SetWidth(lockText:GetWidth() + 20)
TukuiDB.Color(lockText)

-- hi blizzard, i'm just going to steal this code to fix quest blobs, thanks
-- greetings from eclípsé
mapLock:SetScript("OnMouseDown", function(self)
	if ( WORLDMAP_SETTINGS.selectedQuest ) then
		WorldMapBlobFrame:DrawBlob(WORLDMAP_SETTINGS.selectedQuestId, false)
	end
	WorldMapScreenAnchor:ClearAllPoints()
	WorldMapFrame:ClearAllPoints()
	WorldMapFrame:StartMoving()
end)

mapLock:SetScript("OnMouseUp", function(self)
	WorldMapFrame:StopMovingOrSizing()
	WorldMapBlobFrame_CalculateHitTranslations()
	if ( WORLDMAP_SETTINGS.selectedQuest and not WORLDMAP_SETTINGS.selectedQuest.completed ) then
		WorldMapBlobFrame:DrawBlob(WORLDMAP_SETTINGS.selectedQuestId, true)
	end		
	WorldMapScreenAnchor:StartMoving()
	WorldMapScreenAnchor:SetPoint("TOPLEFT", WorldMapFrame)
	WorldMapScreenAnchor:StopMovingOrSizing()
end)

mapLock:SetScript("OnEnter", TukuiDB.SetModifiedBackdrop)
mapLock:SetScript("OnLeave", TukuiDB.SetOriginalBackdrop)


----- [[     Map Close Button     ]] -----

local mapClose = CreateFrame ("Frame", "TukuiMapClose", WorldMapDetailFrame)
TukuiDB.CreatePanel(mapClose, 0, infoheight, "BOTTOMLEFT", WorldMapDetailFrame, "TOPLEFT", TukuiDB.Scale(-2), TukuiDB.Scale(5))
mapClose:SetScale(1 / mapscale)
mapClose:EnableMouse(true)
mapClose:SetFrameStrata("HIGH")
mapClose:Hide()

local closeText = mapClose:CreateFontString(nil, "OVERLAY")
closeText:SetFont(font, font_size, font_style)
closeText:SetPoint("CENTER", font_position[1], font_position[2])
closeText:SetText(tukuilocal.map_close)
TukuiDB.Color(closeText)

mapClose:SetWidth(closeText:GetWidth() + 20)

mapClose:SetScript("OnMouseUp", function(self) ToggleFrame(WorldMapFrame) end)

mapClose:SetScript("OnEnter", TukuiDB.SetModifiedBackdrop)
mapClose:SetScript("OnLeave", TukuiDB.SetOriginalBackdrop)


----- [[     Map Expand Button     ]] -----

local mapExpand = CreateFrame ("Frame", "TukuiMapExpand", WorldMapDetailFrame)
TukuiDB.CreatePanel(mapExpand, 0, infoheight, "TOPRIGHT", mapLock, "TOPLEFT", TukuiDB.Scale(-3), 0)
mapExpand:SetScale(1 / mapscale)
mapExpand:EnableMouse(true)
mapExpand:SetFrameStrata("HIGH")
mapExpand:Hide()

local expandText = mapExpand:CreateFontString(nil, "OVERLAY", mapExpand)
expandText:SetFont(font, font_size, font_style)
expandText:SetPoint("CENTER", font_position[1], font_position[2])
expandText:SetText(tukuilocal.map_expand)
TukuiDB.Color(expandText)

mapExpand:SetWidth(expandText:GetWidth() + 20)

mapExpand:SetScript("OnMouseUp", function(self) 
	WorldMapFrame_ToggleWindowSize()
end)

mapExpand:SetScript("OnEnter", TukuiDB.SetModifiedBackdrop)
mapExpand:SetScript("OnLeave", TukuiDB.SetOriginalBackdrop)


----- [[     Register This Shit     ]] -----

local addon = CreateFrame('Frame')
addon:RegisterEvent('PLAYER_ENTERING_WORLD')
addon:RegisterEvent("PLAYER_REGEN_ENABLED")
addon:RegisterEvent("PLAYER_REGEN_DISABLED")


----- [[     Reposition/Hide/Show Elements In Small Map Mode     ]] -----

local SmallerMapSkin = function()
	mapTitle:SetScale(1 / mapscale)
	mapTitle:SetFrameStrata("MEDIUM")
	mapTitle:SetFrameLevel(20)
	mapTitle:SetPoint("TOPLEFT", mapClose, "TOPRIGHT", 3, 0)
	mapTitle:SetPoint("TOPRIGHT", mapExpand, "TOPLEFT", -3, 0)
	
	map:SetScale(1 / mapscale)
	map:SetPoint("TOPLEFT", WorldMapDetailFrame, TukuiDB.Scale(-2), TukuiDB.Scale(2))
	map:SetPoint("BOTTOMRIGHT", WorldMapDetailFrame, TukuiDB.Scale(2), TukuiDB.Scale(-2))
	map:SetFrameStrata("MEDIUM")
	map:SetFrameLevel(20)
	
	-- move buttons / texts and hide default border
	WorldMapButton:SetAllPoints(WorldMapDetailFrame)
	
	WorldMapFrame:SetFrameStrata("MEDIUM")
	WorldMapFrame:SetClampedToScreen(true) 
	
	WorldMapDetailFrame:SetFrameStrata("MEDIUM")
	
	WorldMapTitleButton:Show()	
	mapLock:Show()
	mapClose:Show()
	mapExpand:Show()
	mapTitle:Show()
	
	WorldMapFrameMiniBorderLeft:Hide()
	WorldMapFrameMiniBorderRight:Hide()
	WorldMapFrameCloseButton:Hide()
	WorldMapFrameSizeUpButton:Hide()
	
	WorldMapQuestShowObjectives:ClearAllPoints()
	WorldMapQuestShowObjectives:SetPoint("BOTTOMRIGHT", WorldMapButton, "BOTTOMRIGHT", 0, TukuiDB.Scale(-1))
	WorldMapQuestShowObjectives:SetFrameStrata("HIGH")
	
	WorldMapQuestShowObjectivesText:SetFont(font, font_size, font_style)
	WorldMapQuestShowObjectivesText:SetShadowOffset(font_shadow and 1 or 0, font_shadow and -1 or 0)
	WorldMapQuestShowObjectivesText:ClearAllPoints()
	WorldMapQuestShowObjectivesText:SetPoint("RIGHT", WorldMapQuestShowObjectives, "LEFT", TukuiDB.Scale(-4), TukuiDB.Scale(1))
	
	WorldMapTrackQuest:ClearAllPoints()
	WorldMapTrackQuest:SetPoint("BOTTOMLEFT", WorldMapButton, "BOTTOMLEFT", 0, TukuiDB.Scale(-1))
	WorldMapTrackQuest:SetFrameStrata("HIGH")
	
	WorldMapTrackQuestText:SetFont(font, font_size, font_style)
	WorldMapTrackQuestText:SetShadowOffset(font_shadow and 1 or 0, font_shadow and -1 or 0)

	WorldMapFrameTitle:ClearAllPoints()
	WorldMapFrameTitle:SetParent(mapTitle)
	WorldMapFrameTitle:SetPoint("CENTER", TukuiCF["fonts"].datatext_xy_position[1], TukuiCF["fonts"].datatext_xy_position[2])
	WorldMapFrameTitle:SetJustifyH("CENTER")
	WorldMapFrameTitle:SetJustifyV("MIDDLE")
	WorldMapFrameTitle:SetFont(font, font_size, font_style)
	WorldMapFrameTitle:SetShadowOffset(font_shadow and 1 or 0, font_shadow and -1 or 0)

	WorldMapTitleButton:SetFrameStrata("MEDIUM")
	WorldMapTooltip:SetFrameStrata("TOOLTIP")
	
	-- 3.3.3, hide the dropdown added into this patch
	WorldMapLevelDropDown:SetAlpha(0)
	WorldMapLevelDropDown:SetScale(0.00001)
	
	-- fix tooltip not hidding after leaving quest # tracker icon
	hooksecurefunc("WorldMapQuestPOI_OnLeave", function() WorldMapTooltip:Hide() end)
end
hooksecurefunc("WorldMap_ToggleSizeDown", function() SmallerMapSkin() end)


----- [[     Hide/Show Elements In Big Map Mode     ]] -----

local BiggerMapSkin = function()
	-- 3.3.3, show the dropdown added into this patch
	WorldMapLevelDropDown:SetAlpha(1)
	WorldMapLevelDropDown:SetScale(1)
	
	WorldMapFrameCloseButton:Show()
	mapLock:Hide()
	mapClose:Hide()
	mapExpand:Hide()
	mapTitle:Hide()
end
hooksecurefunc("WorldMap_ToggleSizeUp", function() BiggerMapSkin() end)


----- [[     Hide/Show/Disable/Enable Elements When Entering/Leaving Combat - Taint Fixer!     ]] -----

local OnEvent = function(self, event)
	if event == "PLAYER_ENTERING_WORLD" then
		ShowUIPanel(WorldMapFrame)
		HideUIPanel(WorldMapFrame)
	elseif event == "PLAYER_REGEN_DISABLED" then
		HideUIPanel(WorldMapFrame)
		WorldMapBlobFrame:Hide()
		WorldMapBlobFrame.Show = TukuiDB.dummy

		WatchFrame_Update()
		
		mapLock:EnableMouse(false) -- even though we hide map on combat enter, this kills the button usage if the user tries to re-open and move
	elseif event == "PLAYER_REGEN_ENABLED" then
		WorldMapBlobFrame.Show = WorldMapBlobFrame:Show()
		WorldMapBlobFrame:Show()

		WatchFrame_Update()
		
		mapLock:EnableMouse(true) -- re-enable when leaving combat
	end
end
addon:SetScript("OnEvent", OnEvent)


----- [[     Tiny Map     ]] -----

local tinymap = CreateFrame("Frame", "TukuiTinyMapMover", UIParent)
tinymap:SetPoint("CENTER")
tinymap:SetSize(223, 150)
tinymap:EnableMouse(true)
tinymap:SetMovable(true)
tinymap:RegisterEvent("ADDON_LOADED")
tinymap:SetPoint("CENTER", UIParent, 0, 0)
tinymap:SetFrameLevel(20)
tinymap:Hide()


----- [[     Tiny Map Background     ]] -----

local tinymapbg = CreateFrame("Frame", nil, tinymap)
tinymapbg:SetAllPoints()
tinymapbg:SetFrameLevel(tinymap:GetFrameLevel() - 10)
TukuiDB.SkinPanel(tinymapbg)


----- [[     Tiny Map Show/Hide/Click Functions     ]] -----

tinymap:SetScript("OnEvent", function(self, event, addon)
	if addon ~= "Blizzard_BattlefieldMinimap" then return end

	-- show holder
	self:Show()

	BattlefieldMinimap:HookScript("OnShow", function() -- use hookscript instead otherwise tinymap doesn't function correctly
		TukuiDB.Kill(BattlefieldMinimapCorner)
		TukuiDB.Kill(BattlefieldMinimapBackground)
		TukuiDB.Kill(BattlefieldMinimapTab)
		TukuiDB.Kill(BattlefieldMinimapTabLeft)
		TukuiDB.Kill(BattlefieldMinimapTabMiddle)
		TukuiDB.Kill(BattlefieldMinimapTabRight)
		BattlefieldMinimap:SetParent(self)
		BattlefieldMinimap:SetPoint("TOPLEFT", self, "TOPLEFT", 2, -2)
		BattlefieldMinimap:SetFrameStrata(self:GetFrameStrata())
		BattlefieldMinimap:SetFrameLevel(self:GetFrameLevel() + 1)
		BattlefieldMinimapCloseButton:ClearAllPoints()
		BattlefieldMinimapCloseButton:SetPoint("TOPRIGHT", -4, 0)
		BattlefieldMinimapCloseButton:SetFrameLevel(self:GetFrameLevel() + 1)
		self:SetScale(1)
		self:SetAlpha(1)
	end)

	BattlefieldMinimap:HookScript("OnHide", function() -- use hookscript instead otherwise tinymap doesn't function correctly
		self:SetScale(0.00001)
		self:SetAlpha(0)
	end)

	self:SetScript("OnMouseUp", function(self, btn)
		if btn == "LeftButton" then
			self:StopMovingOrSizing()
			if OpacityFrame:IsShown() then OpacityFrame:Hide() end -- seem to be a bug with default ui in 4.0, we hide it on next click
		elseif btn == "RightButton" then
			ToggleDropDownMenu(1, nil, BattlefieldMinimapTabDropDown, self:GetName(), 0, -4)
			if OpacityFrame:IsShown() then OpacityFrame:Hide() end -- seem to be a bug with default ui in 4.0, we hide it on next click
		end
	end)

	self:SetScript("OnMouseDown", function(self, btn)
		if btn == "LeftButton" then
			if BattlefieldMinimapOptions.locked then
				return
			else
				self:StartMoving()
			end
		end
	end)
end)
