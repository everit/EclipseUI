--[[
    MultiCastActionBar Skin
	
	(C)2010 Darth Android / Telroth - The Venture Co.

]]

-- if not Mod_AddonSkins or select(2,UnitClass("player")) ~= "SHAMAN" then return end

local TukVer = tonumber(TukuiDB.version)

Mod_AddonSkins = CreateFrame("Frame")
local Mod_AddonSkins = Mod_AddonSkins

local function skinButton(self, button)
	self:SkinFrame(button)
	TukuiDB.StyleButton(button)
	-- Crazy hacks which only work because self = Skin *AND* self = config
	local name = button:GetName()
	local icon = _G[name.."Icon"]
	if icon then
		icon:SetTexCoord(unpack(self.buttonZoom))
		icon:SetDrawLayer("ARTWORK")
		icon:ClearAllPoints()
		icon:SetPoint("TOPLEFT",button,"TOPLEFT",self.borderWidth, -self.borderWidth)
		icon:SetPoint("BOTTOMRIGHT",button,"BOTTOMRIGHT",-self.borderWidth, self.borderWidth)
	end
end
Mod_AddonSkins.SkinFrame = function(self, frame)
	-- To cope with V10 -> V11 changes, all functions which take 1 argument have the argument simply duplicated.
	TukuiDB.SetTemplate(frame,frame)
end
-- Support for shadows from authors that have a CreateShadow() method defined. This can cause issues if the author's function
-- can't handle being called multiple times on the same frame.
if TukuiDB.CreateShadow then
	Mod_AddonSkins.SkinBackgroundFrame = function(self, frame)
		self:SkinFrame(frame)
		--TukuiDB.CreateShadow(frame,frame)
	end
else
	Mod_AddonSkins.SkinBackgroundFrame = Mod_AddonSkins.SkinFrame
end
Mod_AddonSkins.SkinButton = skinButton
Mod_AddonSkins.normTexture = TukuiCF.media.normTex
Mod_AddonSkins.bgTexture = TukuiCF.media.blank
Mod_AddonSkins.font = TukuiCF.media.font
Mod_AddonSkins.smallFont = TukuiCF.media.font
Mod_AddonSkins.fontSize = 12
Mod_AddonSkins.buttonSize = TukuiDB.Scale(27,27)
Mod_AddonSkins.buttonSpacing = TukuiDB.Scale(4,4)
Mod_AddonSkins.borderWidth = TukuiDB.Scale(2,2)
Mod_AddonSkins.buttonZoom = {.09,.91,.09,.91}
Mod_AddonSkins.barSpacing = TukuiDB.Scale(1,1)
Mod_AddonSkins.barHeight = TukuiDB.Scale(20,20)
Mod_AddonSkins.skins = {}
Mod_AddonSkins.__index = Mod_AddonSkins

-- TukUI-Specific Integration Support

local CustomSkin = setmetatable(CustomSkin or {},Mod_AddonSkins)

function Mod_AddonSkins:RegisterSkin(name, initFunc)
	self = Mod_AddonSkins -- Static function
	if type(initFunc) ~= "function" then error("initFunc must be a function!",2) end
	self.skins[name] = initFunc
	if name == "LibSharedMedia" then -- Load LibSharedMedia early.
		initFunc(self, CustomSkin, self, CustomSkin, CustomSkin)
		self.skins[name] = nil
	end
end

Mod_AddonSkins:RegisterEvent("PLAYER_LOGIN")
Mod_AddonSkins:SetScript("OnEvent",function(self)
	self:UnregisterEvent("PLAYER_LOGIN")
	self:SetScript("OnEvent",nil)
	-- Initialize all skins
	for name, func in pairs(self.skins) do
		func(self,CustomSkin,self,CustomSkin,CustomSkin) -- Mod_AddonSkins functions as skin, layout, and config.
	end
end)

-- Courtesy Blizzard Inc.
-- I wouldn't have to copy these if they'd just make them not local >.>
SLOT_EMPTY_TCOORDS = {
	[EARTH_TOTEM_SLOT] = {
		left	= 66 / 128,
		right	= 96 / 128,
		top		= 3 / 256,
		bottom	= 33 / 256,
	},
	[FIRE_TOTEM_SLOT] = {
		left	= 67 / 128,
		right	= 97 / 128,
		top		= 100 / 256,
		bottom	= 130 / 256,
	},
	[WATER_TOTEM_SLOT] = {
		left	= 39 / 128,
		right	= 69 / 128,
		top		= 209 / 256,
		bottom	= 239 / 256,
	},
	[AIR_TOTEM_SLOT] = {
		left	= 66 / 128,
		right	= 96 / 128,
		top		= 36 / 256,
		bottom	= 66 / 256,
	},
}

Mod_AddonSkins:RegisterSkin("Blizzard_TotemBar",function(Skin,skin,Layout,layout,config)
	-- Skin Flyout
	function Skin:SkinMCABFlyoutFrame(flyout)
		flyout.top:SetTexture(nil)
		flyout.middle:SetTexture(nil)
		self:SkinFrame(flyout)
		flyout:SetBackdropBorderColor(0,0,0,0)
		flyout:SetBackdropColor(0,0,0,0)
		-- Skin buttons
		local last = nil
		for _,button in ipairs(flyout.buttons) do
			self:SkinButton(button)
			if not InCombatLockdown() then
				button:SetSize(config.buttonSize,config.buttonSize)
				button:ClearAllPoints()
				button:SetPoint("BOTTOM",last,"TOP",0,config.borderWidth)
			end			
			if button:IsVisible() then last = button end
		end
		flyout.buttons[1]:SetPoint("BOTTOM",flyout,"BOTTOM")
		if flyout.type == "slot" then
			local tcoords = SLOT_EMPTY_TCOORDS[flyout.parent:GetID()]
			flyout.buttons[1].icon:SetTexCoord(tcoords.left,tcoords.right,tcoords.top,tcoords.bottom)
		end
		-- Skin Close button
		local close = MultiCastFlyoutFrameCloseButton
		self:SkinButton(close)
		
		-- close:GetHighlightTexture():SetTexture([[Interface\Buttons\ButtonHilight-Square]])
	    close:GetHighlightTexture():SetPoint("TOPLEFT",close,"TOPLEFT",config.borderWidth,-config.borderWidth)
	    close:GetHighlightTexture():SetPoint("BOTTOMRIGHT",close,"BOTTOMRIGHT",-config.borderWidth,config.borderWidth)
	    close:GetNormalTexture():SetTexture(nil)
		close:ClearAllPoints()
		close:SetPoint("BOTTOMLEFT",last,"TOPLEFT",0,config.buttonSpacing)
		close:SetPoint("BOTTOMRIGHT",last,"TOPRIGHT",0,config.buttonSpacing)
		close:SetHeight(config.buttonSpacing*3)
		
		flyout:ClearAllPoints()
		flyout:SetPoint("BOTTOM",flyout.parent,"TOP",0,config.buttonSpacing)
	end
	hooksecurefunc("MultiCastFlyoutFrame_ToggleFlyout",function(self) skin:SkinMCABFlyoutFrame(self) end)
	
	function Skin:SkinMCABFlyoutOpenButton(button, parent)
		self:SkinButton(button)
	    -- button:GetHighlightTexture():SetPoint("TOPLEFT",button,"TOPLEFT",config.borderWidth,-config.borderWidth)
	    -- button:GetHighlightTexture():SetPoint("BOTTOMRIGHT",button,"BOTTOMRIGHT",-config.borderWidth,config.borderWidth)
		
	    button:GetNormalTexture():SetTexture(nil)
		button:SetHeight(config.buttonSpacing*4)
		button:ClearAllPoints()
		button:SetPoint("BOTTOMLEFT", parent, "TOPLEFT")
		button:SetPoint("BOTTOMRIGHT", parent, "TOPRIGHT")
		button:SetBackdropColor(0,0,0,0)
		button:SetBackdropBorderColor(0,0,0,0)
		if not button.visibleBut then
			button.visibleBut = CreateFrame("Frame",nil,button)
			button.visibleBut:SetHeight(config.buttonSpacing*3)
			button.visibleBut:SetPoint("TOPLEFT")
			button.visibleBut:SetPoint("TOPRIGHT")
			button.visibleBut.highlight = button.visibleBut:CreateTexture(nil,"HIGHLIGHT")
			button.visibleBut.highlight:SetTexture([[Interface\Buttons\ButtonHilight-Square]])
			button.visibleBut.highlight:SetPoint("TOPLEFT",button,"TOPLEFT",config.borderWidth,-config.borderWidth)
			button.visibleBut.highlight:SetPoint("BOTTOMRIGHT",button,"BOTTOMRIGHT",-config.borderWidth,config.borderWidth)
			self:SkinFrame(button.visibleBut)
		end
	end
	hooksecurefunc("MultiCastFlyoutFrameOpenButton_Show",function(button,_, parent) skin:SkinMCABFlyoutOpenButton(button, parent) end)
	
	local bordercolors = {
		{.23,.45,.13},    -- Earth
		{.58,.23,.10},    -- Fire
		{.19,.48,.60},   -- Water
		{.42,.18,.74},   -- Air
		{.39,.39,.12}    -- Summon / Recall
	}
	
	function Skin:SkinMCABSlotButton(button, index)
		self:SkinFrame(button)
		button.overlayTex:SetTexture(nil)
		button.background:SetDrawLayer("ARTWORK")
		button.background:ClearAllPoints()
		button.background:SetPoint("TOPLEFT",button,"TOPLEFT",config.borderWidth,-config.borderWidth)
		button.background:SetPoint("BOTTOMRIGHT",button,"BOTTOMRIGHT",-config.borderWidth,config.borderWidth)
		button:SetSize(config.buttonSize, config.buttonSize)
		button:SetBackdropBorderColor(unpack(bordercolors[((index-1) % 4) + 1]))
	end
	hooksecurefunc("MultiCastSlotButton_Update",function(self, slot) skin:SkinMCABSlotButton(self, slot) end)
	
	-- Skin the actual totem buttons
	function Skin:SkinMCABActionButton(button, index)
		self:SkinFrame(button)
		self:SkinButton(button)
		button.overlayTex:SetTexture(nil)
		button.overlayTex:Hide()
		if not InCombatLockdown() then button:SetAllPoints(button.slotButton) end
		button:SetBackdropBorderColor(unpack(bordercolors[((index-1) % 4) + 1]))
		button:SetBackdropColor(0,0,0,0)
	end
	hooksecurefunc("MultiCastActionButton_Update",function(actionButton, actionId, actionIndex, slot) skin:SkinMCABActionButton(actionButton,actionIndex) end)
	
	-- Skin the summon and recall buttons
	function Skin:SkinMCABSpellButton(button, index)
		if not button then return end
		self:SkinButton(button)
		self:SkinBackgroundFrame(button)
		button:SetBackdropBorderColor(unpack(bordercolors[((index-1)%5)+1]))
		if not InCombatLockdown() then button:SetSize(config.buttonSize, config.buttonSize) end
		_G[button:GetName().."Highlight"]:SetTexture(nil)
		_G[button:GetName().."NormalTexture"]:SetTexture(nil)
	end
	hooksecurefunc("MultiCastSummonSpellButton_Update", function(self) skin:SkinMCABSpellButton(self,0) end)
	hooksecurefunc("MultiCastRecallSpellButton_Update", function(self) skin:SkinMCABSpellButton(self,5) end)
	
	local frame = MultiCastActionBarFrame
end)