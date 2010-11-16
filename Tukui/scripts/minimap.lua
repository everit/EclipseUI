--------------------------------------------------------------------
-- MINIMAP BORDER
--------------------------------------------------------------------

local TukuiMinimap = CreateFrame("Frame", "TukuiMinimap", Minimap)
TukuiMinimap:RegisterEvent("ADDON_LOADED")
TukuiDB.CreatePanel(TukuiMinimap, 144, 144, "CENTER", Minimap, "CENTER", -0, 0)
TukuiMinimap:ClearAllPoints()
TukuiMinimap:SetPoint("TOPLEFT", TukuiDB.Scale(-2), TukuiDB.Scale(2))
TukuiMinimap:SetPoint("BOTTOMRIGHT", TukuiDB.Scale(2), TukuiDB.Scale(-2))

Minimap:ClearAllPoints()
Minimap:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", TukuiDB.Scale(-10), TukuiDB.Scale(-10))
Minimap:SetSize(TukuiMinimap:GetWidth(), TukuiMinimap:GetHeight())


----- [[     Toggle Button / Text     ]] -----

local Toggle = CreateFrame("Frame", "ToggleMinimap", UIParent)
Toggle:SetSize(TukuiMinimap:GetHeight() + 4, TukuiCF["panels"].tinfoheight)
Toggle:EnableMouse(true)
TukuiDB.SkinPanel(Toggle)

local Toggle_Text = Toggle:CreateFontString(nil, "OVERLAY")
Toggle_Text:SetFont(TukuiCF["media"].custom_font_1, 12, "MONOCHROMEOUTLINE")
Toggle_Text:SetPoint("CENTER", 2, 1)


----- [[     Mouse-over Functions     ]] -----

Toggle:SetScript("OnEnter", function()
	if InCombatLockdown() then return end
	if MinimapCluster:IsShown() then
		TukuiDB.FadeIn(Toggle)
	end
	TukuiDB.SetModifiedBackdrop(Toggle)
end)

Toggle:SetScript("OnLeave", function() 
	if MinimapCluster:IsShown() then
		TukuiDB.FadeOut(Toggle)
	end
	TukuiDB.SetOriginalBackdrop(Toggle)
end)


----- [[     Make Sure Toggle Button Fades On Combat     ]] -----

Toggle:RegisterEvent("PLAYER_REGEN_DISABLED")
Toggle:SetScript("OnEvent", function(self, event)
	if (event == "PLAYER_REGEN_DISABLED") then
		if Toggle:GetAlpha() > 0 then
			TukuiDB.FadeOut(Toggle)
		end
	end
end)


----- [[     Toggle / Minimap Set Up / Check Function     ]] -----

local minimap_check = function()
	if EclipseSettings.minimap_shown == true then
		Toggle:SetAlpha(0)

		Toggle:ClearAllPoints()
		Toggle:SetPoint("TOPRIGHT", TukuiMinimap, "BOTTOMRIGHT", 0, -3)
		
		Toggle_Text:SetText(cStart .. "Collapse")
		
		if not MinimapCluster:IsShown() then
			MinimapCluster:Show()
		end
	elseif EclipseSettings.minimap_shown == false then
		Toggle:SetAlpha(1)
		
		Toggle:ClearAllPoints()
		Toggle:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -8, -8)

		Toggle_Text:SetText(cStart .. "Expand")
		
		if MinimapCluster:IsShown() then
			MinimapCluster:Hide()
		end
	end
end


----- [[     Mouse-click Function     ]] -----

Toggle:SetScript("OnMouseDown", function()
	if not InCombatLockdown() then
		if EclipseSettings.minimap_shown == true then
			EclipseSettings.minimap_shown = false
		elseif EclipseSettings.minimap_shown == false then
			EclipseSettings.minimap_shown = true
		end
		minimap_check()
	else
		print(ERR_NOT_IN_COMBAT)
	end
end)
Toggle:RegisterEvent("PLAYER_ENTERING_WORLD")
Toggle:SetScript("OnEvent", minimap_check)

-- Hide Border
MinimapBorder:Hide()
MinimapBorderTop:Hide()

-- Hide Zoom Buttons
MinimapZoomIn:Hide()
MinimapZoomOut:Hide()

-- Hide Voice Chat Frame
MiniMapVoiceChatFrame:Hide()

-- Hide North texture at top
MinimapNorthTag:SetTexture(nil)

-- Hide Zone Frame
MinimapZoneTextButton:Hide()

-- Hide Tracking Button
MiniMapTracking:Hide()

-- Hide Calendar Button
GameTimeFrame:Hide()

-- Hide Mail Button
MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:SetPoint("TOPRIGHT", Minimap, TukuiDB.Scale(3), TukuiDB.Scale(4))
MiniMapMailBorder:Hide()
MiniMapMailIcon:SetTexture("Interface\\AddOns\\Tukui\\media\\textures\\mail")

-- Move battleground icon
MiniMapBattlefieldFrame:ClearAllPoints()
MiniMapBattlefieldFrame:SetPoint("BOTTOMRIGHT", Minimap, TukuiDB.Scale(3), 0)
MiniMapBattlefieldBorder:Hide()

-- Hide world map button
MiniMapWorldMapButton:Hide()

-- shitty 3.3 flag to move
MiniMapInstanceDifficulty:ClearAllPoints()
MiniMapInstanceDifficulty:SetParent(Minimap)
MiniMapInstanceDifficulty:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 0, 0)

-- GhostFrame under minimap
GhostFrameContentsFrame:SetWidth(TukuiDB.Scale(148))
GhostFrameContentsFrame:ClearAllPoints()
GhostFrameContentsFrame:SetPoint("CENTER")
GhostFrameContentsFrame.SetPoint = TukuiDB.dummy
GhostFrame:SetFrameStrata("HIGH")
GhostFrame:SetFrameLevel(10)
GhostFrame:ClearAllPoints()
GhostFrame:SetPoint("TOP", Minimap, "BOTTOM", 0, TukuiDB.Scale(-25))
GhostFrameContentsFrameIcon:SetAlpha(0)
GhostFrameContentsFrameText:ClearAllPoints()
GhostFrameContentsFrameText:SetPoint("CENTER")

local function UpdateLFG()
	MiniMapLFGFrame:ClearAllPoints()
	MiniMapLFGFrame:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", TukuiDB.Scale(2), TukuiDB.Scale(1))
	MiniMapLFGFrameBorder:Hide()
end
hooksecurefunc("MiniMapLFG_UpdateIsShown", UpdateLFG)

-- Enable mouse scrolling
Minimap:EnableMouseWheel(true)
Minimap:SetScript("OnMouseWheel", function(self, d)
	if d > 0 then
		_G.MinimapZoomIn:Click()
	elseif d < 0 then
		_G.MinimapZoomOut:Click()
	end
end)

TukuiMinimap:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_TimeManager" then
		-- Hide Game Time
		TukuiDB.Kill(TimeManagerClockButton)
	end
end)

----------------------------------------------------------------------------------------
-- Right click menu
----------------------------------------------------------------------------------------

local menuFrame = CreateFrame("Frame", "MinimapRightClickMenu", UIParent, "UIDropDownMenuTemplate")
local menuList = {
    {text = CHARACTER_BUTTON,
    func = function() ToggleCharacter("PaperDollFrame") end},
    {text = SPELLBOOK_ABILITIES_BUTTON,
    func = function() ToggleFrame(SpellBookFrame) end},
    {text = TALENTS_BUTTON,
    func = function() if not PlayerTalentFrame then LoadAddOn("Blizzard_TalentUI") end PlayerTalentFrame_Toggle() end},
    {text = ACHIEVEMENT_BUTTON,
    func = function() ToggleAchievementFrame() end},
    {text = QUESTLOG_BUTTON,
    func = function() ToggleFrame(QuestLogFrame) end},
    {text = SOCIAL_BUTTON,
    func = function() ToggleFriendsFrame(1) end},
    {text = PLAYER_V_PLAYER,
    func = function() ToggleFrame(PVPFrame) end},
    {text = ACHIEVEMENTS_GUILD_TAB,
    func = function() if IsInGuild() then if not GuildFrame then LoadAddOn("Blizzard_GuildUI") end GuildFrame_Toggle() end end},
    {text = LFG_TITLE,
    func = function() ToggleFrame(LFDParentFrame) end},
    {text = L_LFRAID,
    func = function() ToggleFrame(LFRParentFrame) end},
    {text = HELP_BUTTON,
    func = function() ToggleHelpFrame() end},
    {text = L_CALENDAR,
    func = function()
    if(not CalendarFrame) then LoadAddOn("Blizzard_Calendar") end
        Calendar_Toggle()
    end},
}

Minimap:SetScript("OnMouseUp", function(self, btn)
	if btn == "RightButton" then
		ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, self)
	elseif btn == "MiddleButton" then
		EasyMenu(menuList, menuFrame, "cursor", 0, 0, "MENU", 2)
	else
		Minimap_OnClick(self)
	end
end)


-- Set Square Map Mask
Minimap:SetMaskTexture('Interface\\ChatFrame\\ChatFrameBackground')

-- For others mods with a minimap button, set minimap buttons position in square mode.
function GetMinimapShape() return 'SQUARE' end

-- reskin LFG dropdown
TukuiDB.SetTemplate(LFDSearchStatus)
