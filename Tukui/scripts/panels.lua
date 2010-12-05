local panels = TukuiCF["panels"]
local chat = TukuiCF["chat"]
local db = TukuiCF["actionbar"]

-- leaving this here incase some one wants to use it

-- local TopBar = CreateFrame("Frame", "TukuiTopBar", UIParent)
-- TukuiDB.CreateUltimate(TopBar, false, (GetScreenWidth() * TukuiDB.mult) * 2, 22, "TOP", UIParent, "TOP", 0, 5)
-- TopBar:SetFrameLevel(0)

-- local BottomBar = CreateFrame("Frame", "TukuiBottomBar", UIParent)
-- TukuiDB.CreateUltimate(BottomBar, false, (GetScreenWidth() * TukuiDB.mult) * 2, 22, "BOTTOM", UIParent, "BOTTOM", 0, -5)
-- BottomBar:SetFrameLevel(0)

local DataLeft = CreateFrame("Frame", "TukuiDataLeft", UIParent)
TukuiDB.CreateUltimate(DataLeft, false, panels.tinfowidth, panels.tinfoheight, "BOTTOMLEFT", UIParent, "BOTTOMLEFT", 8, 8)

local DataRight = CreateFrame("Frame", "TukuiDataRight", UIParent)
TukuiDB.CreateUltimate(DataRight, false, panels.tinfowidth, panels.tinfoheight, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -8, 8)

local ChatLeft = CreateFrame("Frame", "TukuiChatLeft", UIParent)
TukuiDB.CreateUltimate(ChatLeft, true, panels.tinfowidth, chat.chatheight - 3, "BOTTOM", DataLeft, "TOP", 0, 3)

local ChatRight = CreateFrame("Frame", "TukuiChatRight", UIParent)
TukuiDB.CreateUltimate(ChatRight, true, panels.tinfowidth, chat.chatheight - 3, "BOTTOM", DataRight, "TOP", 0, 3)

local LeftTabs = CreateFrame("Frame", "TukuiChatLeftTabs", UIParent)
TukuiDB.CreateUltimate(LeftTabs, false, panels.tinfowidth, panels.tinfoheight, "BOTTOM", ChatLeft, "TOP", 0, 3)

local RightTabs = CreateFrame("Frame", "TukuiChatRightTabs", UIParent)
TukuiDB.CreateUltimate(RightTabs, false, panels.tinfowidth, panels.tinfoheight, "BOTTOM", ChatRight, "TOP", 0, 3)

if db.enable == true then
	local BarBG = CreateFrame("Frame", "TukuiActionBarBackground", UIParent)
	TukuiDB.CreateUltimate(BarBG, true, (db.buttonsize * 12 + db.buttonspacing * 13) + 2, 100, "BOTTOM", UIParent, "BOTTOM", 0, 8)

	local RightBG = CreateFrame("Frame", "TukuiActionBarBackgroundRight", UIParent)
	TukuiDB.CreateUltimate(RightBG, true, (db.buttonsize * 12 + db.buttonspacing * 13) + 2, (db.buttonsize * 12 + db.buttonspacing * 13) + 2, "BOTTOMRIGHT", RightTabs, "TOPRIGHT", 0, 3)

	local PetBG = CreateFrame("Frame", "TukuiPetActionBarBackground", UIParent)
	TukuiDB.CreateUltimate(PetBG, true, 1, 1, "BOTTOMRIGHT", RightBG, "TOPRIGHT", 0, 3)
	if db.vertical_rightbars == true then
		PetBG:SetWidth((db.petbuttonsize + db.buttonspacing * 2) + 2)
		PetBG:SetHeight((db.petbuttonsize * NUM_PET_ACTION_SLOTS + db.buttonspacing * 11) + 2)
	else
		PetBG:SetWidth((db.petbuttonsize * NUM_PET_ACTION_SLOTS + db.buttonspacing * 11) + 2)
		PetBG:SetHeight((db.petbuttonsize + db.buttonspacing * 2) + 2)
	end
		
	local LeftSplitBG = CreateFrame("Frame", "TukuiLeftSplitBarBackground", UIParent)
	TukuiDB.CreateUltimate(LeftSplitBG, true, (db.buttonsize * 3 + db.buttonspacing * 4) + 2, (db.buttonsize * 2 + db.buttonspacing * 3) + 2, "BOTTOMRIGHT", BarBG, "BOTTOMLEFT", -6, 0)

	local RightSplitBG = CreateFrame("Frame", "TukuiRightSplitBarBackground", UIParent)
	TukuiDB.CreateUltimate(RightSplitBG, true, (db.buttonsize * 3 + db.buttonspacing * 4) + 2, (db.buttonsize * 2 + db.buttonspacing * 3) + 2, "BOTTOMLEFT", BarBG, "BOTTOMRIGHT", 6, 0)
end

-- if not db.hideshapeshift then
	-- local shiftbg = CreateFrame("Frame", "TukuiShapeShiftBarBackground", UIParent)
	-- shiftbg:RegisterEvent("PLAYER_LOGIN")
	-- shiftbg:RegisterEvent("PLAYER_ENTERING_WORLD")
	-- shiftbg:RegisterEvent("UPDATE_SHAPESHIFT_FORMS")
	-- shiftbg:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
	-- shiftbg:SetScript("OnEvent", function(self, event, ...)
		-- local forms = GetNumShapeshiftForms()
		-- if forms > 0 then
			-- if db.vertical_shapeshift == true then
				-- shiftbg:SetWidth(db.stancebuttonsize)
				-- shiftbg:SetHeight((db.stancebuttonsize * forms) + ((db.buttonspacing * forms) - 3 ))

				-- shiftbg:SetPoint("TOPLEFT", _G["ShapeshiftButton1"], "TOPLEFT")
			-- else
				-- shiftbg:SetWidth((db.stancebuttonsize * forms) + ((db.buttonspacing * forms) - 3))
				-- shiftbg:SetHeight(db.stancebuttonsize)

				-- shiftbg:SetPoint("TOPLEFT", _G["ShapeshiftButton1"], "TOPLEFT")
			-- end
		-- end
	-- end)
-- end

----- [[     Battleground Statistics Frame     ]] -----

-- if TukuiCF["datatext"].battleground == true then
	-- local bgframe = CreateFrame("Frame", "TukuiInfoLeftBattleGround", UIParent)
	-- TukuiDB.CreatePanel(bgframe, 1, 1, "TOPLEFT", UIParent, "BOTTOMLEFT", 0, 0)
	-- bgframe:SetAllPoints(dleft)
	-- bgframe:SetFrameStrata("LOW")
	-- bgframe:SetFrameLevel(0)
	-- bgframe:EnableMouse(true)
-- end
-- end