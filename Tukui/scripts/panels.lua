-- ACTION BAR PANEL
TukuiDB.buttonsize = TukuiDB.Scale(27)
TukuiDB.petbuttonsize = TukuiDB.Scale(27)
TukuiDB.stancebuttonsize = TukuiDB.Scale(27)

TukuiDB.buttonspacing = TukuiDB.Scale(3)

-- set left and right info panel width
TukuiCF["panels"] = {["tinfowidth"] = 370}

----- [[     Local Variables     ]] -----

local panels = TukuiCF["panels"]
local chat = TukuiCF["chat"]

local db = TukuiCF["actionbar"]

-- fucking move this shit later
if db.vertical_rightbars then
	TukuiCF["panels"].tinfowidth = 350
else
	TukuiCF["panels"].tinfowidth = (TukuiDB.buttonsize * 12) + (TukuiDB.buttonspacing * 11) -- force this if vertical rightbars are disabled so people don't go "OMG ACTION BUTTONS DON'T FIT SIDE/CHAT PANELS"
end

TukuiDB.infoheight = 21

----- [[     Top "Art" Panel     ]] -----

local tbar = CreateFrame("Frame", "TukuiTopBar", UIParent)
TukuiDB.CreatePanel(tbar, (GetScreenWidth() * UIParent:GetEffectiveScale()) * 2, 22, "TOP", UIParent, "TOP", 0, 5)
tbar:SetFrameLevel(0)


----- [[     Bottom "Art" Panel     ]] -----

local bbar = CreateFrame("Frame", "TukuiBottomBar", UIParent)
TukuiDB.CreatePanel(bbar, (GetScreenWidth() * UIParent:GetEffectiveScale()) * 2, 22, "BOTTOM", UIParent, "BOTTOM", 0, -5)
bbar:SetFrameLevel(0)


----- [[     Left Data Panel     ]] -----

local dleft = CreateFrame("Frame", "TukuiDataLeft", UIParent)
TukuiDB.CreatePanel(dleft, TukuiCF["panels"].tinfowidth, TukuiDB.infoheight, "BOTTOMLEFT", UIParent, "BOTTOMLEFT", 8, 8)


----- [[     Right Data Panel     ]] -----

local dright = CreateFrame("Frame", "TukuiDataRight", UIParent)
TukuiDB.CreatePanel(dright, TukuiCF["panels"].tinfowidth, TukuiDB.infoheight, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -8, 8)


----- [[     Left Chat Background and Tabs     ]] -----

local cleft = CreateFrame("Frame", "TukuiChatLeft", UIParent)
TukuiDB.CreateFadedPanel(cleft, TukuiCF["panels"].tinfowidth, TukuiCF["chat"].chatheight - 3, "BOTTOM", dleft, "TOP", 0, 3)

local cltabs = CreateFrame("Frame", "TukuiChatLeftTabs", UIParent)
TukuiDB.CreatePanel(cltabs, TukuiCF["panels"].tinfowidth, TukuiDB.infoheight, "BOTTOM", cleft, "TOP", 0, 3)


----- [[     Right Chat Background and Tabs     ]] -----

local cright = CreateFrame("Frame", "TukuiChatRight", UIParent)
TukuiDB.CreateFadedPanel(cright, TukuiCF["panels"].tinfowidth, TukuiCF["chat"].chatheight - 3, "BOTTOM", dright, "TOP", 0, 3)

local crtabs = CreateFrame("Frame", "TukuiChatRightTabs", UIParent)
TukuiDB.CreatePanel(crtabs, TukuiCF["panels"].tinfowidth, TukuiDB.infoheight, "BOTTOM", cright, "TOP", 0, 3)


----- [[     Dummy Frames     ]] -----

local barbg = CreateFrame("Frame", "TukuiActionBarBackground", UIParent)
if db.tukui_default == true and not TukuiDB.lowversion then
	barbg:SetWidth((TukuiDB.buttonsize * 24) + (TukuiDB.buttonspacing * 23))
else
	barbg:SetWidth((TukuiDB.buttonsize * 12) + (TukuiDB.buttonspacing * 11))
end
barbg:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 8)
if db.bottomrows == 2 then
	barbg:SetHeight((TukuiDB.buttonsize * 2) + (TukuiDB.buttonspacing * 1))
else
	barbg:SetHeight(TukuiDB.buttonsize)
end


if db.split_bar == true then
	local leftsbg = CreateFrame("Frame", "TukuiLeftSplitBarBackground", UIParent)
	leftsbg:SetWidth((TukuiDB.buttonsize * 3) + (TukuiDB.buttonspacing * 2))
	leftsbg:SetPoint("RIGHT", barbg, "LEFT", -10, 0)

	if db.bottomrows == 2 then
		leftsbg:SetHeight((TukuiDB.buttonsize * 2) + (TukuiDB.buttonspacing * 1))
	else
		leftsbg:SetHeight(TukuiDB.buttonsize)
	end

	local rightsbg = CreateFrame("Frame", "TukuiRightSplitBarBackground", UIParent)
	rightsbg:SetWidth((TukuiDB.buttonsize * 3) + (TukuiDB.buttonspacing * 2))
	rightsbg:SetPoint("LEFT", barbg, "RIGHT", 10, 0)

	if db.bottomrows == 2 then
		rightsbg:SetHeight((TukuiDB.buttonsize * 2) + (TukuiDB.buttonspacing * 1))
	else
		rightsbg:SetHeight(TukuiDB.buttonsize)
	end
end


local rightbbg = CreateFrame("Frame", "TukuiActionBarBackgroundRight", UIParent)
rightbbg:SetPoint("BOTTOMRIGHT", crtabs, "TOPRIGHT", 0, 3)
if db.vertical_rightbars == true then
	rightbbg:SetHeight((TukuiDB.buttonsize * 12) + (TukuiDB.buttonspacing * 11))
	if db.rightbars == 1 then
		rightbbg:SetWidth(TukuiDB.buttonsize)
	elseif db.split_bar == true and db.rightbars > 2 then
		rightbbg:SetWidth((TukuiDB.buttonsize * 2) + (TukuiDB.buttonspacing * 1))
	elseif not db.split_bar and db.rightbars == 3 then
		rightbbg:SetWidth((TukuiDB.buttonsize * 3) + (TukuiDB.buttonspacing * 2))
	else
		rightbbg:Hide()
	end
else
	rightbbg:SetWidth((TukuiDB.buttonsize * 12) + (TukuiDB.buttonspacing * 11))
	if db.rightbars == 1 then
		rightbbg:SetHeight(TukuiDB.buttonsize)
	elseif db.split_bar == true and db.rightbars > 2 then
		rightbbg:SetHeight((TukuiDB.buttonsize * 2) + (TukuiDB.buttonspacing * 1))
	elseif not db.split_bar and db.rightbars == 3 then
		rightbbg:SetHeight((TukuiDB.buttonsize * 3) + (TukuiDB.buttonspacing * 2))
	else
		rightbbg:Hide()
	end
end


local petbg = CreateFrame("Frame", "TukuiPetActionBarBackground", UIParent)
if db.vertical_rightbars == true then
	petbg:SetWidth(TukuiDB.petbuttonsize)
	petbg:SetHeight((TukuiDB.petbuttonsize * NUM_PET_ACTION_SLOTS) + (TukuiDB.buttonspacing * 9))

	if db.rightbars > 0 then
		petbg:SetPoint("BOTTOMRIGHT", rightbbg, "BOTTOMLEFT", -3, 0)
	else
		petbg:SetPoint("BOTTOMRIGHT", crtabs, "TOPRIGHT", 0, 3)
	end
else
	petbg:SetWidth((TukuiDB.petbuttonsize * NUM_PET_ACTION_SLOTS) + (TukuiDB.buttonspacing * 9))
	petbg:SetHeight(TukuiDB.petbuttonsize)

	if db.rightbars > 0 then
		petbg:SetPoint("BOTTOMRIGHT", rightbbg, "TOPRIGHT", 0, 3)
	else
		petbg:SetPoint("BOTTOMRIGHT", crtabs, "TOPRIGHT", 0, 3)
	end
end
	

----- [[     Battleground Statistics Frame     ]] -----

if TukuiCF["datatext"].battleground == true then
	local bgframe = CreateFrame("Frame", "TukuiInfoLeftBattleGround", UIParent)
	TukuiDB.CreatePanel(bgframe, 1, 1, "TOPLEFT", UIParent, "BOTTOMLEFT", 0, 0)
	bgframe:SetAllPoints(dleft)
	bgframe:SetFrameStrata("LOW")
	bgframe:SetFrameLevel(0)
	bgframe:EnableMouse(true)
end