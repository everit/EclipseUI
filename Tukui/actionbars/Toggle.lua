--[[
    In-game Action Bar Toggle for my Tukui edit.

    To-do:
	-- ??
	
	© 2010 Eclípsé
	
	Don't use without my permission, please respect this.
]]--

local db = TukuiCF["actionbar"]

if not db.enable then return end

----- [[     Local Variables - Color / Text Values     ]] -----

local ecUI = ecUI

local barbg = TukuiActionBarBackground
local rightbbg = TukuiActionBarBackgroundRight
local splbg = TukuiLeftSplitBarBackground
local sprbg = TukuiRightSplitBarBackground
local petbg = TukuiPetActionBarBackground
local crtabs = TukuiChatRightTabs

local Toggle = CreateFrame("Frame", "TukuiToggleActionbar", UIParent)


----- [[     Text Function     ]] -----

local text_display = function(index, plus, neg)
	local p, m = "+", "-"
	if plus then
		Toggle[index].text:SetText(p)
		ecUI.Color(Toggle[index].text, false, false, true)
	elseif neg then
		Toggle[index].text:SetText(m)
		ecUI.Color(Toggle[index].text, true)
	end
end


----- [[     Action Bar Check + Change Functions     ]] -----

local bb_check = function()
	if ecSV.bottomrows == 1 then
		barbg:SetHeight(db.buttonsize + (db.buttonspacing * 2))
		splbg:SetHeight(db.buttonsize  + (db.buttonspacing * 2))
		sprbg:SetHeight(db.buttonsize + (db.buttonspacing * 2))
		
		text_display(1, true)
		
		if TukuiBar2:IsShown() then
			TukuiBar2:Hide()
		end
		
		if ecSV.splitbars == true then
			for i = 7, 12 do
				local b = _G["MultiBarLeftButton"..i]
				b:SetAlpha(0)
				b:SetScale(0.0001)		
			end
		end
		Toggle[4]:SetHeight(db.buttonsize + (db.buttonspacing * 2))
		Toggle[5]:SetHeight(db.buttonsize + (db.buttonspacing * 2))
	elseif ecSV.bottomrows == 2 then
		barbg:SetHeight((db.buttonsize * 2) + (db.buttonspacing * 3))
		splbg:SetHeight((db.buttonsize * 2) + (db.buttonspacing * 3))
		sprbg:SetHeight((db.buttonsize * 2) + (db.buttonspacing * 3))
		
		text_display(1, false, true)

		TukuiBar2:Show()
		
		if ecSV.splitbars == true then
			for i = 7, 12 do
				local b = _G["MultiBarLeftButton"..i]
				b:SetAlpha(1)
				b:SetScale(1)		
			end
		end
		Toggle[4]:SetHeight((db.buttonsize * 2) + (db.buttonspacing * 3))
		Toggle[5]:SetHeight((db.buttonsize * 2) + (db.buttonspacing * 3))
	end
end






local rbb_check = function()
	if ecSV.rightbars >= 1 then
		petbg:ClearAllPoints()
		if db.vertical_rightbars == true then
			petbg:SetPoint("BOTTOMRIGHT", rightbbg, "BOTTOMLEFT", -3, 0)
		else
			petbg:SetPoint("BOTTOMRIGHT", rightbbg, "TOPRIGHT", 0, 3)
		end
	else
		petbg:ClearAllPoints()
		petbg:SetPoint("BOTTOMRIGHT", crtabs, "TOPRIGHT", 0, 3)
	end
	
	if db.vertical_rightbars == true then
		petbg:SetWidth(db.petbuttonsize + (db.buttonspacing * 2))
		petbg:SetHeight((db.petbuttonsize * NUM_PET_ACTION_SLOTS) + (db.buttonspacing * 11))
	else
		petbg:SetWidth((db.petbuttonsize * NUM_PET_ACTION_SLOTS) + (db.buttonspacing * 11))
		petbg:SetHeight(db.petbuttonsize + (db.buttonspacing * 2))
	end
	
	if ecSV.rightbars == 1 then
		rightbbg:Show()
		if db.vertical_rightbars == true then
			rightbbg:SetWidth(db.buttonsize + (db.buttonspacing * 2))
		else
			rightbbg:SetHeight(db.buttonsize + (db.buttonspacing * 2))
		end
		
		if ecSV.splitbars ~= true and TukuiBar3:IsShown() then
			TukuiBar3:Hide()
		end
		if TukuiBar5:IsShown() then
			TukuiBar5:Hide()
		end
		TukuiBar4:Show()
	elseif ecSV.rightbars == 2 then
		rightbbg:Show()
		if db.vertical_rightbars == true then
			rightbbg:SetWidth((db.buttonsize * 2) + (db.buttonspacing * 3))
		else
			rightbbg:SetHeight((db.buttonsize * 2) + (db.buttonspacing * 3))
		end
		
		if ecSV.splitbars ~= true and TukuiBar3:IsShown() then
			TukuiBar3:Hide()
		end
		TukuiBar4:Show()
		TukuiBar5:Show()
	elseif ecSV.rightbars == 3 then
		rightbbg:Show()
		if db.vertical_rightbars == true then
			rightbbg:SetWidth((db.buttonsize * 3) + (db.buttonspacing * 4))
		else
			rightbbg:SetHeight((db.buttonsize * 3) + (db.buttonspacing * 4))
		end
		
		TukuiBar4:Show()
		TukuiBar5:Show()
		if ecSV.splitbars ~= true then
			TukuiBar3:Show()
			for i = 1, 12 do
				local b = _G["MultiBarLeftButton"..i]
				local b2 = _G["MultiBarLeftButton"..i-1]
				b:SetSize(db.buttonsize, db.buttonsize)
				b:ClearAllPoints()
				
				if i == 1 then
					b:SetPoint("TOPLEFT", rightbbg, db.buttonspacing, -db.buttonspacing)
				else
					if not ecSV.splitbars and db.vertical_rightbars == true then
						b:SetPoint("TOP", b2, "BOTTOM", 0, -db.buttonspacing)
					else
						b:SetPoint("LEFT", b2, "RIGHT", db.buttonspacing, 0)
					end
				end
			end
		end
	elseif ecSV.rightbars == 0 then
		rightbbg:Hide()

		if ecSV.splitbars ~= true then
			TukuiBar3:Hide()
		end
		TukuiBar4:Hide()
		TukuiBar5:Hide()
	end
end

local splbb_check = function()
	if ecSV.splitbars == true then
		for i = 1, 12 do
			local b = _G["MultiBarLeftButton"..i]
			local b2 = _G["MultiBarLeftButton"..i-1]
			b:ClearAllPoints()
			if i == 1 then
				b:SetPoint("BOTTOMLEFT", splbg, db.buttonspacing, db.buttonspacing)
			else
				if i == 4 then
					b:SetPoint("BOTTOMLEFT", sprbg, db.buttonspacing, db.buttonspacing)
				elseif i == 7 then
					b:SetPoint("BOTTOMLEFT", _G["MultiBarLeftButton1"], "TOPLEFT", 0, db.buttonspacing)
				elseif i == 10 then
					b:SetPoint("BOTTOMLEFT", _G["MultiBarLeftButton4"], "TOPLEFT", 0, db.buttonspacing)
				else
					b:SetPoint("LEFT", b2, "RIGHT", db.buttonspacing, 0)
				end
			end
		end		

		if ecSV.rightbars == 3 then
			rightbbg:Show()
			if db.vertical_rightbars == true then
			rightbbg:SetWidth((db.buttonsize * 2) + (db.buttonspacing * 3))
				else
				rightbbg:SetHeight((db.buttonsize * 2) + (db.buttonspacing * 3))
			end
		end
		
		Toggle[4]:ClearAllPoints()
		Toggle[5]:ClearAllPoints()
		Toggle[4]:SetPoint("BOTTOMRIGHT", splbg, "BOTTOMLEFT", -3, 0)
		Toggle[5]:SetPoint("BOTTOMLEFT", sprbg, "BOTTOMRIGHT", 3, 0)
	
		text_display(4, false, true)
		text_display(5, false, true)
	
		TukuiBar3:Show()
		
		if ecSV.bottomrows == 1 then
			for i = 7, 12 do
				local b = _G["MultiBarLeftButton"..i]
				b:SetAlpha(0)
				b:SetScale(0.0001)		
			end
		elseif ecSV.bottomrows == 2 then
			for i = 7, 12 do
				local b = _G["MultiBarLeftButton"..i]
				b:SetAlpha(1)
				b:SetScale(1)		
			end
		end
		splbg:Show()
		sprbg:Show()
	elseif ecSV.splitbars == false then
		for i = 1, 12 do
			local b = _G["MultiBarLeftButton"..i]
			local b2 = _G["MultiBarLeftButton"..i-1]
			b:ClearAllPoints()
			if i == 1 then
				b:SetPoint("TOPLEFT", rightbbg, db.buttonspacing, -db.buttonspacing)
			else
				b:SetPoint("LEFT", b2, "RIGHT", db.buttonspacing, 0)
			end
		end
		
		Toggle[4]:ClearAllPoints()
		Toggle[5]:ClearAllPoints()
		Toggle[4]:SetPoint("BOTTOMRIGHT", barbg, "BOTTOMLEFT", -3, 0)
		Toggle[5]:SetPoint("BOTTOMLEFT", barbg, "BOTTOMRIGHT", 3, 0)

		text_display(4, true)
		text_display(5, true)
	
		rbb_check()

		for i = 7, 12 do
			local b = _G["MultiBarLeftButton"..i]
			b:SetAlpha(1)
			b:SetScale(1)		
		end

		splbg:Hide()
		sprbg:Hide()
	end
end


----- [[     Action Bar Toggle Buttons / Text     ]] -----

for i = 1, 5 do
	Toggle[i] = CreateFrame("Frame", "TukuiToggle"..i, Toggle)
	-- Toggle[i]:EnableMouse(true)
	Toggle[i]:SetAlpha(0)
	
	Toggle[i].text = Toggle[i]:CreateFontString(nil, "OVERLAY")
	Toggle[i].text:SetFont(TukuiCF["media"].custom_font_1, 12, "MONOCHROMEOUTLINE")
	Toggle[i].text:SetPoint("CENTER", 2, 1)
	
	if i == 1 then
		TukuiDB.CreatePanel(Toggle[i], ((db.buttonsize * 12) + (db.buttonspacing * 13)), db.buttonsize / 2, "BOTTOM", barbg, "TOP", 0, 3)
		
		Toggle[i]:SetScript("OnMouseDown", function()
			ecSV.bottomrows = ecSV.bottomrows + 1

			if ecSV.bottomrows > 2 then
				ecSV.bottomrows = 1
			end

			bb_check()
		end)
		Toggle[i]:SetScript("OnEvent", bb_check)
	elseif i == 2 then
		TukuiDB.CreatePanel(Toggle[i], db.buttonsize, crtabs:GetHeight(), "TOPRIGHT", crtabs, "TOPRIGHT")
		Toggle[i]:SetFrameLevel(crtabs:GetFrameLevel() + 1)
		Toggle[i].shadow:Hide()
		
		text_display(i, true)
		
		Toggle[2]:SetScript("OnMouseDown", function()
			ecSV.rightbars = ecSV.rightbars + 1
			
			if ecSV.splitbars == true and ecSV.rightbars > 2 then
				ecSV.rightbars = 0
			elseif ecSV.rightbars > 3 then
				ecSV.rightbars = 0
			end

			rbb_check()
		end)
		Toggle[i]:SetScript("OnEvent", bb_check)
	elseif i == 3 then
		TukuiDB.CreatePanel(Toggle[i], db.buttonsize, crtabs:GetHeight(), "TOPRIGHT", Toggle[i-1], "TOPLEFT", -3, 0)
		Toggle[i]:SetFrameLevel(crtabs:GetFrameLevel() + 1)
		Toggle[i].shadow:Hide()
		
		text_display(i, false, true)
		
		Toggle[i]:SetScript("OnMouseDown", function()
			ecSV.rightbars = ecSV.rightbars - 1

			if ecSV.splitbars == true and ecSV.rightbars > 2 then
				ecSV.rightbars = 1
			elseif ecSV.rightbars < 0 then
				if ecSV.splitbars == true then
					ecSV.rightbars = 2
				else
					ecSV.rightbars = 3
				end
			end
			rbb_check()
		end)
		Toggle[i]:SetScript("OnEvent", rbb_check)
	elseif i == 4 then
		TukuiDB.CreatePanel(Toggle[i], db.buttonsize / 2, ((db.buttonsize * 2) + (db.buttonspacing * 3)), "BOTTOMRIGHT", splbg, "BOTTOMLEFT", -3, 0)
		
		Toggle[i]:SetScript("OnMouseDown", function()
			if ecSV.splitbars == false then
				ecSV.splitbars = true
			elseif ecSV.splitbars == true then
				ecSV.splitbars = false
			end
			splbb_check()
		end)
		Toggle[i]:SetScript("OnEvent", splbb_check)
	elseif i == 5 then
		TukuiDB.CreatePanel(Toggle[i], db.buttonsize / 2, ((db.buttonsize * 2) + (db.buttonspacing * 3)), "BOTTOMLEFT", sprbg, "BOTTOMRIGHT", 3, 0)
		
		Toggle[i]:SetScript("OnMouseDown", function()
			if ecSV.splitbars == false then
				ecSV.splitbars = true
			elseif ecSV.splitbars == true then
				ecSV.splitbars = false
			end
			splbb_check()
		end)
		Toggle[i]:SetScript("OnEvent", splbb_check)
	end
	Toggle[i]:RegisterEvent("PLAYER_ENTERING_WORLD")
	Toggle[i]:RegisterEvent("PLAYER_REGEN_DISABLED")
	Toggle[i]:RegisterEvent("PLAYER_REGEN_ENABLED")

	Toggle[i]:SetScript("OnEnter", function()
		if InCombatLockdown() then return end
		ecUI.FadeIn(Toggle[i])
	end)

	Toggle[i]:SetScript("OnLeave", function()
		ecUI.FadeOut(Toggle[i])
	end)

	Toggle[i]:SetScript("OnUpdate", function() 
		if ecSV.locked_actionbars == true then
			Toggle[i]:EnableMouse(false)
		elseif ecSV.locked_actionbars == false then
			Toggle[i]:EnableMouse(true)
		end
	end)		
end

Toggle:RegisterEvent("PLAYER_ENTERING_WORLD")