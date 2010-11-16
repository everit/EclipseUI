----- [[     Local Variables     ]] -----

local panels = TukuiCF["panels"]
local chat = TukuiCF["chat"]
local db = TukuiCF["actionbar"]


----- [[     Top "Art" Panel     ]] -----

local tbar = CreateFrame("Frame", "TukuiTopBar", UIParent)
TukuiDB.CreatePanel(tbar, (GetScreenWidth() * TukuiDB.mult) * 2, 22, "TOP", UIParent, "TOP", 0, TukuiDB.Scale(5))
tbar:SetFrameLevel(0)


----- [[     Bottom "Art" Panel     ]] -----

local bbar = CreateFrame("Frame", "TukuiBottomBar", UIParent)
TukuiDB.CreatePanel(bbar, (GetScreenWidth() * TukuiDB.mult) * 2, 22, "BOTTOM", UIParent, "BOTTOM", 0, TukuiDB.Scale(-5))
bbar:SetFrameLevel(0)


----- [[     Left Data Panel     ]] -----

local dleft = CreateFrame("Frame", "TukuiDataLeft", UIParent)
TukuiDB.CreatePanel(dleft, panels.tinfowidth, panels.tinfoheight, "BOTTOMLEFT", UIParent, "BOTTOMLEFT", TukuiDB.Scale(8), TukuiDB.Scale(8))


----- [[     Right Data Panel     ]] -----

local dright = CreateFrame("Frame", "TukuiDataRight", UIParent)
TukuiDB.CreatePanel(dright, panels.tinfowidth, panels.tinfoheight, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", TukuiDB.Scale(-8), TukuiDB.Scale(8))


----- [[     Left Chat Background and Tabs     ]] -----

local cleft = CreateFrame("Frame", "TukuiChatLeft", UIParent)
TukuiDB.CreateFadedPanel(cleft, panels.tinfowidth, chat.chatheight - 3, "BOTTOM", dleft, "TOP", 0, TukuiDB.Scale(3))

local cltabs = CreateFrame("Frame", "TukuiChatLeftTabs", UIParent)
TukuiDB.CreatePanel(cltabs, panels.tinfowidth, panels.tinfoheight, "BOTTOM", cleft, "TOP", 0, TukuiDB.Scale(3))


----- [[     Right Chat Background and Tabs     ]] -----

local cright = CreateFrame("Frame", "TukuiChatRight", UIParent)
TukuiDB.CreateFadedPanel(cright, panels.tinfowidth, chat.chatheight - 3, "BOTTOM", dright, "TOP", 0, TukuiDB.Scale(3))

local crtabs = CreateFrame("Frame", "TukuiChatRightTabs", UIParent)
TukuiDB.CreatePanel(crtabs, panels.tinfowidth, panels.tinfoheight, "BOTTOM", cright, "TOP", 0, TukuiDB.Scale(3))


----- [[     Action Bar Panels     ]] -----

local barbg = CreateFrame("Frame", "TukuiActionBarBackground", UIParent)
barbg:SetWidth((db.buttonsize * 12) + (db.buttonspacing * 11))
barbg:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 8)

local rightbbg = CreateFrame("Frame", "TukuiActionBarBackgroundRight", UIParent)
rightbbg:SetPoint("BOTTOMRIGHT", crtabs, "TOPRIGHT", 0, 3)
if db.vertical_rightbars == true then
	rightbbg:SetHeight((db.buttonsize * 12) + (db.buttonspacing * 11))
else
	rightbbg:SetWidth((db.buttonsize * 12) + (db.buttonspacing * 11))
end

local splbg = CreateFrame("Frame", "TukuiLeftSplitBarBackground", UIParent)
splbg:SetWidth((db.buttonsize * 3) + (db.buttonspacing * 2))
splbg:SetHeight((db.buttonsize * 2) + (db.buttonspacing * 1))
splbg:SetPoint("BOTTOMRIGHT", barbg, "BOTTOMLEFT", -10, 0)

local sprbg = CreateFrame("Frame", "TukuiRightSplitBarBackground", UIParent)
sprbg:SetWidth((db.buttonsize * 3) + (db.buttonspacing * 2))
sprbg:SetHeight((db.buttonsize * 2) + (db.buttonspacing * 1))
sprbg:SetPoint("BOTTOMLEFT", barbg, "BOTTOMRIGHT", 10, 0)

local petbg = CreateFrame("Frame", "TukuiPetActionBarBackground", UIParent)

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