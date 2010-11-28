-- here we kill all shit stuff on default UI that we don't need!

function TukuiDB.Kill(object)
	if object.UnregisterAllEvents then
		object:UnregisterAllEvents()
	end
	object.Show = TukuiDB.dummy
	object:Hide()
end

local Kill = CreateFrame("Frame")
Kill:RegisterEvent("ADDON_LOADED")
Kill:RegisterEvent("PLAYER_LOGIN")
Kill:SetScript("OnEvent", function(self, event, addon)
	if event == "PLAYER_LOGIN" then
		if IsAddOnLoaded("TukuiDps") or IsAddOnLoaded("TukuiHeal") then
			InterfaceOptionsFrameCategoriesButton10:SetScale(0.00001)
			InterfaceOptionsFrameCategoriesButton10:SetAlpha(0)		
			InterfaceOptionsFrameCategoriesButton11:SetScale(0.00001)
			InterfaceOptionsFrameCategoriesButton11:SetAlpha(0)
			TukuiDB.Kill(CompactPartyFrame)
			TukuiDB.Kill(CompactRaidFrameManager)
			TukuiDB.Kill(CompactRaidFrameContainer)
		end	
	else
		if addon == "Blizzard_AchievementUI" then
			if TukuiCF.tooltip.enable then
				hooksecurefunc("AchievementFrameCategories_DisplayButton", function(button) button.showTooltipFunc = nil end)
			end
		end
		
		if addon == "Blizzard_TimeManager" then
			-- Hide Game Time
			TukuiDB.Kill(TimeManagerClockButton)
		end

		if addon ~= "Tukui" then return end
		
		TukuiDB.Kill(StreamingIcon)
		TukuiDB.Kill(Advanced_UseUIScale)
		TukuiDB.Kill(Advanced_UIScaleSlider)
		TukuiDB.Kill(PartyMemberBackground)
		TukuiDB.Kill(TutorialFrameAlertButton)
		
		TukuiDB.Kill(InterfaceOptionsUnitFramePanelPartyBackground)

		-- make sure boss or arena frame is always disabled when running tukui
		SetCVar("showArenaEnemyFrames", 0)
		
		-- if TukuiCF.arena.unitframes then
			-- TukuiDB.Kill(InterfaceOptionsUnitFramePanelArenaEnemyFrames)
			-- TukuiDB.Kill(InterfaceOptionsUnitFramePanelArenaEnemyCastBar)
			-- TukuiDB.Kill(InterfaceOptionsUnitFramePanelArenaEnemyPets)
		-- end
		
		if TukuiCF.chat.enable then
			SetCVar("WholeChatWindowClickable", 0)
			SetCVar("ConversationMode", "inline")
			TukuiDB.Kill(InterfaceOptionsSocialPanelWholeChatWindowClickable)
			TukuiDB.Kill(InterfaceOptionsSocialPanelConversationMode)
		end
		
		-- if TukuiCF.unitframes.enable then
			-- InterfaceOptionsFrameCategoriesButton9:SetScale(0.00001)
			-- InterfaceOptionsFrameCategoriesButton9:SetAlpha(0)	
			-- InterfaceOptionsFrameCategoriesButton9:SetScale(0.00001)
			-- InterfaceOptionsFrameCategoriesButton9:SetAlpha(0)
		-- end
		
		if TukuiCF.actionbar.enable then
			TukuiDB.Kill(InterfaceOptionsActionBarsPanelBottomLeft)
			TukuiDB.Kill(InterfaceOptionsActionBarsPanelBottomRight)
			TukuiDB.Kill(InterfaceOptionsActionBarsPanelRight)
			TukuiDB.Kill(InterfaceOptionsActionBarsPanelRightTwo)
			TukuiDB.Kill(InterfaceOptionsActionBarsPanelAlwaysShowActionBars)
		end
		
		TukuiDB.Kill(MinimapBorder)
		TukuiDB.Kill(MinimapBorderTop)
		TukuiDB.Kill(MinimapZoomIn)
		TukuiDB.Kill(MinimapZoomOut)
		TukuiDB.Kill(MiniMapVoiceChatFrame)
		TukuiDB.Kill(MinimapNorthTag)
		TukuiDB.Kill(MinimapZoneTextButton)
		TukuiDB.Kill(MiniMapTracking)
		TukuiDB.Kill(GameTimeFrame)
		TukuiDB.Kill(MiniMapWorldMapButton)
	end
end)
