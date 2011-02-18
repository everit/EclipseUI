local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

-- Chat Frames
local TukuiChatLeft = CreateFrame("Frame", "TukuiChatLeft", UIParent)
TukuiChatLeft:CreatePanel("Transparent", T.InfoLeftRightWidth, 165, "BOTTOMLEFT", UIParent, "BOTTOMLEFT", 8, 8)  -- C["chat"].height

local TukuiChatRight = CreateFrame("Frame", "TukuiChatRight", UIParent)
TukuiChatRight:CreatePanel("Transparent", T.InfoLeftRightWidth, 165, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -8, 8) -- C["chat"].height

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

-- local TukuiInfoTop = CreateFrame("Frame", "TukuiInfoTop", UIParent)
-- TukuiInfoTop:CreatePanel("Default", 50, 25, "TOP", UIParent, "TOP", 0, -8)
-- TukuiInfoTop:SetFrameLevel(3)
-- TukuiInfoTop:SetFrameStrata("LOW")
-- TukuiInfoTopShadow:SetFrameStrata("BACKGROUND")

-- local TukuiInfoTop2 = CreateFrame("Frame", "TukuiInfoTop2", UIParent)
-- TukuiInfoTop2:CreatePanel("Default", 120, 19, "CENTER", TukuiInfoTop, "CENTER", 0, 0)
-- TukuiInfoTop2:SetFrameStrata("LOW")

-- Action Bars
local TukuiBar1 = CreateFrame("Frame", "TukuiBar1", UIParent, "SecureHandlerStateTemplate")
TukuiBar1:CreatePanel("Transparent", (T.buttonsize * 12) + (T.buttonspacing * 13) + 2, (T.buttonsize * 2) + (T.buttonspacing * 3) + 2, "BOTTOM", UIParent, "BOTTOM", 0, 8)

local TukuiSplitBarLeft = CreateFrame("Frame", "TukuiSplitBarLeft", UIParent)
TukuiSplitBarLeft:CreatePanel("Transparent", (T.buttonsize * 3) + (T.buttonspacing * 4) + 2, TukuiBar1:GetHeight(), "BOTTOMRIGHT", TukuiBar1, "BOTTOMLEFT", -6, 0)

local TukuiSplitBarRight = CreateFrame("Frame", "TukuiSplitBarRight", UIParent)
TukuiSplitBarRight:CreatePanel("Transparent", (T.buttonsize * 3) + (T.buttonspacing * 4) + 2, TukuiBar1:GetHeight(), "BOTTOMLEFT", TukuiBar1, "BOTTOMRIGHT", 6, 0)

local TukuiRightBar = CreateFrame("Frame", "TukuiRightBar", UIParent)
TukuiRightBar:CreatePanel("Transparent", (T.buttonsize * 12 + T.buttonspacing * 13) + 2,  (T.buttonsize * 12 + T.buttonspacing * 13) + 2, "BOTTOMRIGHT", TukuiChatRight, "TOPRIGHT", 0, 3)

local TukuiPetBar = CreateFrame("Frame", "TukuiPetBar", UIParent)
TukuiPetBar:CreatePanel("Transparent", 1, 1, "BOTTOMRIGHT", TukuiRightBar, "TOPRIGHT", 0, 3)
if C["actionbar"].vertical_rightbars == true then
	TukuiPetBar:Width((T.petbuttonsize + T.buttonspacing * 2) + 2)
	TukuiPetBar:Height((T.petbuttonsize * NUM_PET_ACTION_SLOTS + T.buttonspacing * 11) + 2)
else
	TukuiPetBar:Width((T.petbuttonsize * NUM_PET_ACTION_SLOTS + T.buttonspacing * 11) + 2)
	TukuiPetBar:Height((T.petbuttonsize + T.buttonspacing * 2) + 2)
end

if not C["actionbar"].hideshapeshift then
	local TukuiShiftBarBG = CreateFrame("Frame", "TukuiShiftBarBG", UIParent)
	TukuiShiftBarBG:RegisterEvent("PLAYER_LOGIN")
	TukuiShiftBarBG:RegisterEvent("PLAYER_ENTERING_WORLD")
	TukuiShiftBarBG:RegisterEvent("UPDATE_SHAPESHIFT_FORMS")
	TukuiShiftBarBG:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
	TukuiShiftBarBG:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	TukuiShiftBarBG:SetScript("OnEvent", function(self, event, ...)
		local forms = GetNumShapeshiftForms()
		if forms > 0 then
			-- if db.vertical_shapeshift == true then
				-- TukuiDB.CreateSpecial(ShiftBG, true, true, false, db.stancebuttonsize + 10, (db.stancebuttonsize * forms) + (db.buttonspacing * forms + 1) + 5, "TOPLEFT", _G["ShapeshiftButton1"], "TOPLEFT", -5, 5)
				-- ShiftBG:Show()
			-- else
				TukuiShiftBarBG:CreatePanel("Transparent", (T.stancebuttonsize * forms) + (T.buttonspacing * forms + 1) + 5, T.stancebuttonsize + 10, "TOPLEFT",  _G["ShapeshiftButton1"], "TOPLEFT", -5, 5)
				TukuiShiftBarBG:Show()
			-- end
				TukuiShiftBarBG:SetFrameLevel(10)

		else
			TukuiShiftBarBG:Hide()
		end
	end)
end