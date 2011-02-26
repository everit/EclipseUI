--[[	
	(C)2010 Darth Android / Telroth-Black Dragonflight
]]

Mod_AddonSkins = CreateFrame("Frame")
local Mod_AddonSkins = Mod_AddonSkins
local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

local function skinFrame(self, frame)
	--Unfortionatly theres not a prettier way of doing this
	if frame:GetParent():GetName() == "Recount_ConfigWindow" then
		frame:SetTemplate("Transparent")
		frame:SetFrameStrata("BACKGROUND")
	elseif frame:GetName() == "OmenBarList" or 
	frame:GetName() == "OmenTitle" or 
	frame:GetName() == "DXEPane" or 
	frame:GetName() == "SkadaBG" or 
	frame:GetParent():GetName() == "Recount_MainWindow" or 
	frame:GetParent():GetName() == "Recount_GraphWindow" or 
	frame:GetParent():GetName() == "Recount_DetailWindow" then
		frame:SetTemplate("Transparent")
		if frame:GetParent():GetName() ~= "Recount_GraphWindow" and frame:GetParent():GetName() ~= "Recount_DetailWindow" then
			frame:SetFrameStrata("MEDIUM")
		else
			frame:SetFrameStrata("BACKGROUND")
		end
	else
		frame:SetTemplate("Default")
	end
end
local function skinButton(self, button)
	skinFrame(self, button)
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

Mod_AddonSkins.SkinFrame = skinFrame
Mod_AddonSkins.SkinBackgroundFrame = skinFrame
Mod_AddonSkins.SkinButton = skinButton
Mod_AddonSkins.normTexture = C.media.normTex
Mod_AddonSkins.bgTexture = C.media.blank
Mod_AddonSkins.font = C.media.uffont
Mod_AddonSkins.smallFont = C.media.uffont
Mod_AddonSkins.fontSize = 12
Mod_AddonSkins.buttonSize = 27,27
Mod_AddonSkins.buttonSpacing = C.buttonspacing,C.buttonspacing
Mod_AddonSkins.borderWidth = 2,2
Mod_AddonSkins.buttonZoom = {.09,.91,.09,.91}
Mod_AddonSkins.barSpacing = 1,1
Mod_AddonSkins.barHeight = 20,20
Mod_AddonSkins.skins = {}

-- Dummy function expected by some skins
function dummy() end


function Mod_AddonSkins:RegisterSkin(name, initFunc)
	self = Mod_AddonSkins -- Static function
	if type(initFunc) ~= "function" then error("initFunc must be a function!",2) end
	self.skins[name] = initFunc
end

Mod_AddonSkins:RegisterEvent("PLAYER_LOGIN")
Mod_AddonSkins:RegisterEvent("PLAYER_ENTERING_WORLD")
Mod_AddonSkins:SetScript("OnEvent",function(self, event, addon)
	if event == "PLAYER_LOGIN" then
		-- Initialize all skins
		for name, func in pairs(self.skins) do
			func(self,self,self,self,self) -- Mod_AddonSkins functions as skin, layout, and config.
		end
		self:UnregisterEvent("PLAYER_LOGIN")
	elseif event == "PLAYER_ENTERING_WORLD" then
		self:SetScript("OnEvent",nil)
		-- Embed Right
		if C["skin"].embedright == "Skada" and IsAddOnLoaded("Skada") then
			SkadaBarWindowSkada:ClearAllPoints()
			SkadaBarWindowSkada:SetPoint("TOPRIGHT", TukuiChatRight, "TOPRIGHT", -2, -12)
				SkadaBarWindowSkada:SetFrameLevel(2)
				if SkadaBG then
					SkadaBG:SetFrameStrata("MEDIUM")	
					SkadaBG:ClearAllPoints()
					SkadaBG:SetPoint("TOPRIGHT", SkadaBarWindowSkada, "TOPRIGHT", -2, -45)
					SkadaBarWindowSkada:SetFrameStrata("HIGH")
				end
	
			--trick game into firing OnShow script so we can adjust the frame levels
			SkadaBarWindowSkada:Hide()
			SkadaBarWindowSkada:Show()
		end
		if C["skin"].embedright == "Recount" and IsAddOnLoaded("Recount") then
			Recount.db.profile.FrameStrata = "4-HIGH"
			Recount_MainWindow:ClearAllPoints()
			Recount_MainWindow:SetPoint("TOPLEFT", TukuiChatRight,"TOPLEFT", 0, 2)
			Recount_MainWindow:SetPoint("BOTTOMRIGHT", TukuiChatRight,"BOTTOMRIGHT", 0, 0)
			Recount.db.profile.MainWindowWidth = (374)
		elseif IsAddOnLoaded("Recount") then
			Recount.db.profile.FrameStrata = "4-HIGH"
		end
		if C["skin"].embedright == "Omen" and IsAddOnLoaded("Omen") then
			Omen.UpdateTitleBar = function() end
			OmenTitle:Kill()
			if IsAddOnLoaded("Omen") then
				OmenBarList:SetFrameStrata("HIGH")
			end
			OmenBarList:ClearAllPoints()
			OmenBarList:SetAllPoints(TukuiChatRight)
		end
				
		if C["chat"].showbackdrop == true and IsAddOnLoaded("KLE") and KLEAlertsTopStackAnchor and C["skin"].hookkleright == true and E.RightChat == true then
			KLEAlertsTopStackAnchor:ClearAllPoints()
			KLEAlertsTopStackAnchor:SetPoint("BOTTOM", TukuiChatRight, "TOP", 13, 18)			
		elseif IsAddOnLoaded("KLE") and KLEAlertsTopStackAnchor and C["skin"].hookkleright == true then
			KLEAlertsTopStackAnchor:ClearAllPoints()
			KLEAlertsTopStackAnchor:SetPoint("BOTTOM", TukuiChatRight, "TOP", 13, -5)
		end		
	end
end)