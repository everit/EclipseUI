local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

-- Chat Frames
local TukuiChatLeft = CreateFrame("Frame", "TukuiChatLeft", UIParent)
TukuiChatLeft:CreatePanel("Transparent", T.InfoLeftRightWidth, C["chat"].height, "BOTTOMLEFT", UIParent, "BOTTOMLEFT", 8, 8)  -- C["chat"].height

local TukuiChatRight = CreateFrame("Frame", "TukuiChatRight", UIParent)
TukuiChatRight:CreatePanel("Transparent", T.InfoLeftRightWidth, C["chat"].height, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -8, 8) -- C["chat"].height

-- Chat Tabs
local TukuiTabsLeft = CreateFrame("Frame", "TukuiTabsLeft", UIParent)
TukuiTabsLeft:CreatePanel("Default", 1, 23, "TOPLEFT", TukuiChatLeft, "TOPLEFT", 5, -5)
TukuiTabsLeft:Point("TOPRIGHT", TukuiChatLeft, "TOPRIGHT", -5, -5)
TukuiTabsLeft:SetFrameLevel(TukuiChatLeft:GetFrameLevel() + 1)

local TukuiTabsRight = CreateFrame("Frame", "TukuiTabsRight", UIParent)
TukuiTabsRight:CreatePanel("Default", 1, 23, "TOPLEFT", TukuiChatRight, "TOPLEFT", 5, -5)
TukuiTabsRight:Point("TOPRIGHT", TukuiChatRight, "TOPRIGHT", -5, -5)
TukuiTabsRight:SetFrameLevel(TukuiChatRight:GetFrameLevel() + 1)

-- Data Frames
local TukuiInfoLeft = CreateFrame("Frame", "TukuiInfoLeft", UIParent)
TukuiInfoLeft:CreatePanel("Default", 1, 23, "BOTTOMLEFT", TukuiChatLeft, "BOTTOMLEFT", 5, 5)
TukuiInfoLeft:Point("BOTTOMRIGHT", TukuiChatLeft, "BOTTOMRIGHT", -5, 5)
TukuiInfoLeft:SetFrameLevel(TukuiChatLeft:GetFrameLevel() + 1)

local TukuiInfoRight = CreateFrame("Frame", "TukuiInfoRight", UIParent)
TukuiInfoRight:CreatePanel("Default", 1, 23, "BOTTOMLEFT", TukuiChatRight, "BOTTOMLEFT", 5, 5)
TukuiInfoRight:Point("BOTTOMRIGHT", TukuiChatRight, "BOTTOMRIGHT", -5, 5)
TukuiInfoRight:SetFrameLevel(TukuiChatRight:GetFrameLevel() + 1)




-- Action Bars
if C["actionbar"].enable then
	local TukuiBar1 = CreateFrame("Frame", "TukuiBar1", UIParent, "SecureHandlerStateTemplate")
	TukuiBar1:CreatePanel("Transparent", (T.buttonsize * 12) + (T.buttonspacing * 13) + 2, (T.buttonsize * 2) + (T.buttonspacing * 3) + 2, "BOTTOM", UIParent, "BOTTOM", 0, 31)

	local TukuiBar2 = CreateFrame("Frame", "TukuiBar2", UIParent)
	TukuiBar2:SetAllPoints(TukuiBar1)--("BOTTOM")
	
	local TukuiBar3 = CreateFrame("Frame", "TukuiBar3", UIParent)
	TukuiBar3:SetAllPoints(TukuiBar1)--Point("BOTTOM")

	local TukuiBar4 = CreateFrame("Frame", "TukuiBar4", UIParent)
	TukuiBar2:SetAllPoints(TukuiBar1)--Point("BOTTOM")

	local TukuiSplitBarLeft = CreateFrame("Frame", "TukuiSplitBarLeft", UIParent)
	TukuiSplitBarLeft:CreatePanel("Transparent", (T.buttonsize * 3) + (T.buttonspacing * 4) + 2, TukuiBar1:GetHeight(), "BOTTOMRIGHT", TukuiBar1, "BOTTOMLEFT", -6, 0)

	local TukuiSplitBarRight = CreateFrame("Frame", "TukuiSplitBarRight", UIParent)
	TukuiSplitBarRight:CreatePanel("Transparent", (T.buttonsize * 3) + (T.buttonspacing * 4) + 2, TukuiBar1:GetHeight(), "BOTTOMLEFT", TukuiBar1, "BOTTOMRIGHT", 6, 0)

	local TukuiRightBar = CreateFrame("Frame", "TukuiRightBar", UIParent)
	TukuiRightBar:CreatePanel("Transparent", (T.buttonsize * 12 + T.buttonspacing * 13) + 2,  (T.buttonsize * 12 + T.buttonspacing * 13) + 2, "BOTTOMRIGHT", TukuiChatRight, "TOPRIGHT", 0, 150)

	local TukuiPetBar = CreateFrame("Frame", "TukuiPetBar", UIParent)
	TukuiPetBar:CreatePanel("Transparent", 1, 1, "BOTTOMRIGHT", TukuiBar1, "TOPRIGHT", 0, 0)
	if C["actionbar"].vertical_rightbars == true then
		TukuiPetBar:Width((T.petbuttonsize * NUM_PET_ACTION_SLOTS + T.buttonspacing * 11) + 2)
		TukuiPetBar:Height((T.petbuttonsize + T.buttonspacing * 2) + 2)
	else
		TukuiPetBar:Width((T.petbuttonsize * NUM_PET_ACTION_SLOTS + T.buttonspacing * 11) + 2)
		TukuiPetBar:Height((T.petbuttonsize + T.buttonspacing * 2) + 2)
	end
end

-- Location panel from Eclipse edit
local TukuiLocationPanel = CreateFrame("Frame", "TukuiLocationPanel", UIParent)
TukuiLocationPanel:CreatePanel("Default", 54, 23, "TOP", UIParent, "TOP", 0, -5)
TukuiLocationPanel:CreateShadow("Default")

local Text  = TukuiLocationPanel:CreateFontString(nil, "LOW")
Text:SetFont(unpack(T.Fonts.dFont.setfont))
Text:Point("CENTER", 1, 0)
local function OnEvent(self, event)
    local location = GetMinimapZoneText()
    local pvpType, isFFA, zonePVPStatus = GetZonePVPInfo()
    if (pvpType == "sanctuary") then
        location = "|cff69C9EF"..location.."|r" -- light blue
    elseif (pvpType == "friendly") then
        location = "|cff00ff00"..location.."|r" -- green
    elseif (pvpType == "contested") then
        location = "|cffffff00"..location.."|r" -- yellow
    elseif (pvpType == "hostile" or pvpType == "combat" or pvpType == "arena" or not pvpType) then
        location = "|cffff0000"..location.."|r" -- red
    else
        location = location -- white
    end
    Text:SetText(location)
    TukuiLocationPanel:SetWidth(Text:GetWidth() + 24)
end
TukuiLocationPanel:RegisterEvent("PLAYER_ENTERING_WORLD")
TukuiLocationPanel:RegisterEvent("ZONE_CHANGED_NEW_AREA")
TukuiLocationPanel:RegisterEvent("ZONE_CHANGED")
TukuiLocationPanel:RegisterEvent("ZONE_CHANGED_INDOORS")
TukuiLocationPanel:SetScript("OnEvent", OnEvent)

--local statsmiddle = CreateFrame("Frame", "statsmiddle", TukuiBar1)
--statsmiddle:CreatePanel("Default", ((TukuiBar1:GetWidth() + 4) / 1) -4, 19, "TOPLEFT", TukuiBar1, "BOTTOMLEFT", 0, -4)

local statsleft = CreateFrame("Frame", "statsleft", TukuiBar1)
statsleft:CreatePanel("Default", ((TukuiSplitBarLeft:GetWidth() + 4) / 1) -4, 19, "TOPLEFT", TukuiSplitBarLeft, "BOTTOMLEFT", 0, -3)

local statsright = CreateFrame("Frame", "statsright", TukuiBar1)
statsright:CreatePanel("Default", ((TukuiSplitBarRight:GetWidth() + 4) / 1) -4, 19, "TOPLEFT", TukuiSplitBarRight, "BOTTOMLEFT", 0, -3)

-- Top & Bottom Panel
local tbar = CreateFrame("Frame", "tbar", UIParent)
tbar:CreatePanel("Default", (GetScreenWidth() * T.mult) * 2, 17, "TOP", UIParent, "TOP", T.Scale(-4), T.Scale(0))
tbar:SetFrameLevel(0)
tbar:SetAlpha(0.8)
tbar:CreateShadow("Default")

local bbar = CreateFrame("Frame", " bbar", UIParent)
bbar:CreatePanel("Default", (GetScreenWidth() * T.mult) * 2, 17, "BOTTOM", UIParent, "BOTTOM", T.Scale(4), T.Scale(0))
bbar:SetFrameLevel(0)
bbar:SetAlpha(0.8)
bbar:CreateShadow("Default")