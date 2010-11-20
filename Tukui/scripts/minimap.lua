--------------------------------------------------------------------
-- MINIMAP BORDER
--------------------------------------------------------------------

local TukuiMinimap = CreateFrame("Frame", "TukuiMinimap", Minimap)
TukuiMinimap:RegisterEvent("ADDON_LOADED")
TukuiDB.CreatePanel(TukuiMinimap, 136, 136, "CENTER", Minimap, "CENTER", -0, 0)
TukuiMinimap:ClearAllPoints()
TukuiMinimap:SetPoint("TOPLEFT", TukuiDB.Scale(-2), TukuiDB.Scale(2))
TukuiMinimap:SetPoint("BOTTOMRIGHT", TukuiDB.Scale(2), TukuiDB.Scale(-2))

Minimap:ClearAllPoints()
Minimap:SetPoint("TOPLEFT", UIParent, "TOPLEFT", TukuiDB.Scale(10), TukuiDB.Scale(-10))
Minimap:SetSize(TukuiMinimap:GetWidth(), TukuiMinimap:GetHeight())


----- [[     Toggle Button / Text     ]] -----

local Toggle = CreateFrame("Frame", "ToggleMinimap", UIParent)
Toggle:SetSize(80, 15)
Toggle:EnableMouse(true)
TukuiDB.SkinPanel(Toggle)

local Toggle_Text = Toggle:CreateFontString(nil, "OVERLAY")
Toggle_Text:SetFont(TukuiCF["media"].custom_font_1, 12, "MONOCHROMEOUTLINE")
Toggle_Text:SetPoint("CENTER", 2, 1)
TukuiDB.Color(Toggle_Text)


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
		Toggle:SetPoint("BOTTOM", TukuiMinimap, "BOTTOM", 0, TukuiDB.Scale(4))
		
		Toggle_Text:SetText("Collapse")
		
		if not MinimapCluster:IsShown() then
			MinimapCluster:Show()
		end
	elseif EclipseSettings.minimap_shown == false then
		local point, relativeTo, relativePoint, xOfs, yOfs = Minimap:GetPoint()

		Toggle:SetAlpha(1)
		
		Toggle:ClearAllPoints()
		Toggle:SetPoint(point, relativeTo, relativePoint, xOfs - 2, yOfs + 2)

		Toggle_Text:SetText("Expand")
		
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
    -- {text = LFG_TITLE,
    -- func = function() ToggleFrame(LFDParentFrame) end},
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


LFDSearchStatus:ClearAllPoints()
LFDSearchStatus:SetPoint("TOPLEFT", TukuiMinimap, "TOPRIGHT", 3, 0)










-- local f = CreateFrame("Frame", nil, UIParent)
-- f:SetPoint("BOTTOMLEFT", TukuiMinimap, "BOTTOMRIGHT", 3,0)
-- f:SetWidth(10)
-- f:SetAlpha(1)
-- f:SetHeight(20)
-- TukuiDB.SkinPanel(f)

-- local a_low = 10
-- local a_high = 100

-- local n = {
	-- 10,
-- }
	
-- local speed = 60

-- local move_UP = function (self,t,target,N)
	-- n[N] = n[N] + t * speed
	-- if n[N] < a_high then
		-- target:SetWidth(n[N])
	-- else
		-- self:Hide()
		-- n[N] = a_high
		-- target:SetWidth(a_high)
	-- end
-- end

-- local move_DOWN = function (self,t,target,N)
	-- n[N] = n[N] - t * speed
	-- if n[N] > a_low then
		-- target:SetWidth(n[N])
	-- else
		-- self:Hide()
		-- n[N] = a_low
		-- target:SetWidth(a_low)
	-- end
-- end

-- local left_up = CreateFrame("Frame") 
-- local left_down = CreateFrame("Frame")

-- left_up:Hide()
-- left_down:Hide()

-- local Toggle2 = CreateFrame("Frame", "ToggleButton", UIParent)
-- Toggle2:SetWidth(20)
-- Toggle2:SetHeight(20)
-- Toggle2:EnableMouse(true)
-- TukuiDB.SkinPanel(Toggle2)
-- Toggle2:SetPoint("TOPLEFT", f, "TOPRIGHT", 3, 0)

	-- local Toggletext = Toggle2:CreateFontString(nil, "OVERLAY")
	-- Toggletext:SetFont(TukuiCF["media"].custom_font_1, 12, "MONOCHROMEOUTLINE")
	-- Toggletext:SetPoint("CENTER", 2, 1)
	
-- left_up:SetScript("OnUpdate",function(self,t) move_UP(self,t,f,1) end)
-- left_down:SetScript("OnUpdate",function(self,t) move_DOWN(self,t,f,1) end)

-- Toggle2:SetScript("OnMouseDown",function() 
	-- if EclipseSettings.chatcur[1] == a_low then
		-- EclipseSettings.chatcur[1] = a_high
		-- left_up:Show()
		-- left_down:Hide()
		-- Toggletext:SetText("+")
	-- else 
		-- EclipseSettings.chatcur[1] = a_low
		-- left_up:Hide()
		-- left_down:Show()
				-- Toggletext:SetText("-")

	-- end
-- end)	
