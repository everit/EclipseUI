local ecUI = ecUI

----- [[     Minimap Border     ]] -----

local TukuiMinimap = CreateFrame("Frame", "TukuiMinimap", Minimap)
TukuiMinimap:RegisterEvent("ADDON_LOADED")
TukuiDB.CreateUltimate(TukuiMinimap, false, 136, 136, "CENTER")
TukuiMinimap:SetPoint("TOPLEFT", TukuiDB.Scale(-2), TukuiDB.Scale(2))
TukuiMinimap:SetPoint("BOTTOMRIGHT", TukuiDB.Scale(2), TukuiDB.Scale(-2))

Minimap:ClearAllPoints()
Minimap:SetPoint("TOPLEFT", UIParent, "TOPLEFT", TukuiDB.Scale(10), TukuiDB.Scale(-10))
Minimap:SetSize(TukuiMinimap:GetWidth(), TukuiMinimap:GetHeight())

local Toggle = CreateFrame("Frame", "TukuiToggleMinimap", UIParent)
Toggle:EnableMouse(true)

local ToggleText = Toggle:CreateFontString(nil, "OVERLAY")
ToggleText:SetFont(TukuiCF["media"].custom_font_1, 12, "MONOCHROMEOUTLINE")
ToggleText:SetPoint("CENTER", TukuiDB.Scale(2), TukuiDB.Scale(1))
TukuiDB.Color(ToggleText)

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

local MinimapCheck = function()
	if TukuiSaved.minimap_shown == true then
		Toggle:ClearAllPoints()
		TukuiDB.CreateUltimate(Toggle, false, 80, 15, "BOTTOM", TukuiMinimap, "BOTTOM", 0, 4)
		Toggle:SetFrameLevel(Minimap:GetFrameLevel() + 3)
		
		Toggle:SetAlpha(0)

		ToggleText:SetText("Collapse")
		
		if not MinimapCluster:IsShown() then
			MinimapCluster:Show()
		end
		
		TukuiMinimenu:ClearAllPoints()
		TukuiMinimenu:SetPoint("TOPLEFT", TukuiMinimap, "BOTTOMLEFT", 0, TukuiDB.Scale(-3))
	elseif TukuiSaved.minimap_shown == false then		
		local point, relativeTo, relativePoint, xOfs, yOfs = Minimap:GetPoint()	
		Toggle:ClearAllPoints()		
		TukuiDB.CreateUltimate(Toggle, false, TukuiMinimap:GetWidth() + 4, TukuiCF["panels"].tinfoheight, point, relativeTo, relativePoint, xOfs - 2, yOfs + 2)

		Toggle:SetAlpha(1)

		ToggleText:SetText("Expand")
		
		if MinimapCluster:IsShown() then
			MinimapCluster:Hide()
		end
		
		TukuiMinimenu:ClearAllPoints()
		TukuiMinimenu:SetPoint("TOPLEFT", Toggle, "BOTTOMLEFT", 0, TukuiDB.Scale(-3))
	end
end

Toggle:SetScript("OnMouseDown", function()
	if TukuiSaved.minimap_shown == true then
		TukuiSaved.minimap_shown = false
	elseif TukuiSaved.minimap_shown == false then
		TukuiSaved.minimap_shown = true
	end
	MinimapCheck()
end)

Toggle:RegisterEvent("PLAYER_ENTERING_WORLD")
Toggle:RegisterEvent("PLAYER_REGEN_ENABLED")
Toggle:RegisterEvent("PLAYER_REGEN_DISABLED")
Toggle:SetScript("OnEvent", function(self, event)
	if (event == "PLAYER_REGEN_DISABLED") then
		if Toggle:GetAlpha() > 0 and TukuiSaved.minimap_shown == true then
			TukuiDB.FadeOut(Toggle)
		end
		Toggle:EnableMouse(false)
	elseif (event == "PLAYER_REGEN_ENABLED") then
		Toggle:EnableMouse(true)
	end
	MinimapCheck()
end)

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

GuildInstanceDifficulty:ClearAllPoints()
GuildInstanceDifficulty:SetParent(Minimap)
GuildInstanceDifficulty:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 0, 0)

local function UpdateLFG()
	MiniMapLFGFrame:ClearAllPoints()
	MiniMapLFGFrame:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", TukuiDB.Scale(2), TukuiDB.Scale(1))
	MiniMapLFGFrameBorder:Hide()
end
hooksecurefunc("MiniMapLFG_UpdateIsShown", UpdateLFG)
LFDSearchStatus:ClearAllPoints()
LFDSearchStatus:SetPoint("TOPLEFT", MiniMapLFGFrame,"BOTTOMLEFT", 0, 0)

-- Enable mouse scrolling
Minimap:EnableMouseWheel(true)
Minimap:SetScript("OnMouseWheel", function(self, d)
	if d > 0 then
		_G.MinimapZoomIn:Click()
	elseif d < 0 then
		_G.MinimapZoomOut:Click()
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
	
    {text = HELP_BUTTON,
    func = function() ToggleHelpFrame() end},
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