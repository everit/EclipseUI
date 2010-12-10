if not TukuiCF["map"].enable == true then return end

local mapscale = WORLDMAP_WINDOWED_SIZE
local font = TukuiCF["fonts"].map_font
local font_size = TukuiCF["fonts"].map_font_size
local font_style = TukuiCF["fonts"].map_font_style
local font_shadow = TukuiCF["fonts"].map_font_shadow
local font_position = TukuiCF["fonts"].map_button_xy_position
local infoheight = TukuiCF["panels"].tinfoheight

local Map = CreateFrame("Frame", "TukuiMap", WorldMapDetailFrame)
TukuiDB.SetTemplate(Map)
TukuiDB.CreateShadow(Map)

local MapTitle = CreateFrame ("Frame", "TukuiMapTitle", WorldMapDetailFrame)
TukuiDB.CreateUltimate(MapTitle, true, 0, infoheight)

local MapLock = CreateFrame ("Frame", "TukuiMapLock", WorldMapDetailFrame)
TukuiDB.CreateUltimate(MapLock, false, 0, infoheight, "BOTTOMRIGHT", WorldMapDetailFrame, "TOPRIGHT", 2, 5)
MapLock:SetScale(1 / mapscale)
MapLock:SetFrameStrata("HIGH")
MapLock:EnableMouse(true)
MapLock:Hide()

local LockText = MapLock:CreateFontString(nil, "OVERLAY")
LockText:SetFont(font, font_size, font_style)
LockText:SetPoint("CENTER", font_position[1], font_position[2])
LockText:SetText(tukuilocal.map_move)
MapLock:SetWidth(LockText:GetWidth() + 20)
TukuiDB.Color(LockText)

MapLock:SetScript("OnMouseDown", function(self)
	if WORLDMAP_SETTINGS.advanced ~= 1 then return end
	if ( WORLDMAP_SETTINGS.selectedQuest ) then
		WorldMapBlobFrame:DrawBlob(WORLDMAP_SETTINGS.selectedQuestId, false)
	end
	WorldMapScreenAnchor:ClearAllPoints()
	WorldMapFrame:ClearAllPoints()
	WorldMapFrame:StartMoving()
end)

MapLock:SetScript("OnMouseUp", function(self)
	if WORLDMAP_SETTINGS.advanced ~= 1 then return end
	WorldMapFrame:StopMovingOrSizing()
	WorldMapBlobFrame_CalculateHitTranslations()
	if ( WORLDMAP_SETTINGS.selectedQuest and not WORLDMAP_SETTINGS.selectedQuest.completed ) then
		WorldMapBlobFrame:DrawBlob(WORLDMAP_SETTINGS.selectedQuestId, true)
	end		
	WorldMapScreenAnchor:StartMoving()
	WorldMapScreenAnchor:SetPoint("TOPLEFT", WorldMapFrame)
	WorldMapScreenAnchor:StopMovingOrSizing()
end)

MapLock:SetScript("OnEnter", TukuiDB.SetModifiedBackdrop)
MapLock:SetScript("OnLeave", TukuiDB.SetOriginalBackdrop)


----- [[     Map Close Button     ]] -----

local MapClose = CreateFrame ("Frame", "TukuiMapClose", WorldMapDetailFrame)
TukuiDB.CreateUltimate(MapClose, false, 0, infoheight, "BOTTOMLEFT", WorldMapDetailFrame, "TOPLEFT", -2, 5)
MapClose:SetScale(1 / mapscale)
MapClose:EnableMouse(true)
MapClose:SetFrameStrata("HIGH")
MapClose:Hide()

local CloseText = MapClose:CreateFontString(nil, "OVERLAY")
CloseText:SetFont(font, font_size, font_style)
CloseText:SetPoint("CENTER", font_position[1], font_position[2])
CloseText:SetText(tukuilocal.map_close)
TukuiDB.Color(CloseText)

MapClose:SetWidth(CloseText:GetWidth() + 20)

MapClose:SetScript("OnMouseUp", function(self) ToggleFrame(WorldMapFrame) end)

MapClose:SetScript("OnEnter", TukuiDB.SetModifiedBackdrop)
MapClose:SetScript("OnLeave", TukuiDB.SetOriginalBackdrop)


----- [[     Map Expand Button     ]] -----

local MapExpand = CreateFrame ("Frame", "TukuiMapExpand", WorldMapDetailFrame)
TukuiDB.CreateUltimate(MapExpand, false, 0, infoheight, "TOPRIGHT", MapLock, "TOPLEFT", -3, 0)
MapExpand:SetScale(1 / mapscale)
MapExpand:EnableMouse(true)
MapExpand:SetFrameStrata("HIGH")
MapExpand:Hide()

local expandText = MapExpand:CreateFontString(nil, "OVERLAY", MapExpand)
expandText:SetFont(font, font_size, font_style)
expandText:SetPoint("CENTER", font_position[1], font_position[2])
expandText:SetText(tukuilocal.map_expand)
TukuiDB.Color(expandText)

MapExpand:SetWidth(expandText:GetWidth() + 20)

MapExpand:SetScript("OnMouseUp", function(self) 
	WorldMapFrame_ToggleWindowSize()
end)

MapExpand:SetScript("OnEnter", TukuiDB.SetModifiedBackdrop)
MapExpand:SetScript("OnLeave", TukuiDB.SetOriginalBackdrop)


----- [[     Register This Shit     ]] -----

local addon = CreateFrame('Frame')
addon:RegisterEvent('PLAYER_ENTERING_WORLD')
addon:RegisterEvent("PLAYER_REGEN_ENABLED")
addon:RegisterEvent("PLAYER_REGEN_DISABLED")


----- [[     Reposition/Hide/Show Elements In Small Map Mode     ]] -----

local SmallerMapSkin = function()
	MapTitle:SetScale(1 / mapscale)
	MapTitle:SetFrameStrata("MEDIUM")
	MapTitle:SetFrameLevel(20)
	MapTitle:ClearAllPoints()
	MapTitle:SetPoint("TOPLEFT", MapClose, "TOPRIGHT", 3, 0)
	MapTitle:SetPoint("TOPRIGHT", MapExpand, "TOPLEFT", -3, 0)
	
	Map:SetScale(1 / mapscale)
	Map:SetPoint("TOPLEFT", WorldMapDetailFrame, TukuiDB.Scale(-2), TukuiDB.Scale(2))
	Map:SetPoint("BOTTOMRIGHT", WorldMapDetailFrame, TukuiDB.Scale(2), TukuiDB.Scale(-2))
	Map:SetFrameStrata("MEDIUM")
	Map:SetFrameLevel(20)
	
	-- move buttons / texts and hide default border
	WorldMapButton:SetAllPoints(WorldMapDetailFrame)
	
	WorldMapFrame:SetFrameStrata("MEDIUM")
	WorldMapFrame:SetClampedToScreen(true) 
	
	WorldMapDetailFrame:SetFrameStrata("MEDIUM")
	
	WorldMapTitleButton:Show()	
	MapLock:Show()
	MapClose:Show()
	MapExpand:Show()
	MapTitle:Show()
	
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

	WorldMapShowDigSites:ClearAllPoints()
	WorldMapShowDigSites:SetPoint("TOPLEFT", WorldMapButton, "TOPLEFT", TukuiDB.Scale(1), TukuiDB.Scale(-1))
	WorldMapShowDigSites:SetFrameStrata("HIGH")
	
	WorldMapShowDigSitesText:SetFont(font, font_size, font_style)
	WorldMapShowDigSitesText:SetShadowOffset(font_shadow and 1 or 0, font_shadow and -1 or 0)

	WorldMapFrameTitle:ClearAllPoints()
	WorldMapFrameTitle:SetParent(MapTitle)
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
	MapLock:Hide()
	MapClose:Hide()
	MapExpand:Hide()
	MapTitle:Hide()
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
		
		MapLock:EnableMouse(false) -- even though we hide map on combat enter, this kills the button usage if the user tries to re-open and move
	elseif event == "PLAYER_REGEN_ENABLED" then
		WorldMapBlobFrame.Show = WorldMapBlobFrame:Show()
		WorldMapBlobFrame:Show()

		WatchFrame_Update()
		
		MapLock:EnableMouse(true) -- re-enable when leaving combat
	end
end
addon:SetScript("OnEvent", OnEvent)