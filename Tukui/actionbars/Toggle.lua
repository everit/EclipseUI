--[[
    In-game Action Bar Toggle for my Tukui edit.

    To-do:
	-- ??
	
	© 2010 Eclípsé
	
	Don't use without my permission, please respect this.
]]--

local db = TukuiCF["actionbar"]

if not db.enable then return end

local BarBG = TukuiActionBarBackground
local RightBG = TukuiActionBarBackgroundRight
local LeftSplitBG = TukuiLeftSplitBarBackground
local RightSplitBG = TukuiRightSplitBarBackground
local PetBG = TukuiPetActionBarBackground
local RightTabs = TukuiChatRightTabs

local Toggle = CreateFrame("Frame", "TukuiToggleActionbar", UIParent)

local ToggleText = function(index, text, plus, neg)
	if plus then
		Toggle[index].Text:SetText(text)
		TukuiDB.Color(Toggle[index].Text, false, false, true)
	elseif neg then
		Toggle[index].Text:SetText(text)
		TukuiDB.Color(Toggle[index].Text, true)
	end
end

local MainBars = function()
	if TukuiSaved.bottomrows == 1 then
		BarBG:SetHeight((db.buttonsize + db.buttonspacing * 2) + 2)
		LeftSplitBG:SetHeight((db.buttonsize  + db.buttonspacing * 2) + 2)
		RightSplitBG:SetHeight((db.buttonsize + db.buttonspacing * 2) + 2)
		
		ToggleText(1, "+", true)
		
		if TukuiBar2:IsShown() then
			TukuiBar2:Hide()
		end
		
		if TukuiSaved.splitbars == true then
			for i = 7, 12 do
				local b = _G["MultiBarLeftButton"..i]
				b:SetAlpha(0)
				b:SetScale(0.0001)		
			end
		end
	elseif TukuiSaved.bottomrows == 2 then
		BarBG:SetHeight((db.buttonsize * 2 + db.buttonspacing * 3) + 2)
		LeftSplitBG:SetHeight((db.buttonsize * 2 + db.buttonspacing * 3) + 2)
		RightSplitBG:SetHeight((db.buttonsize * 2 + db.buttonspacing * 3) + 2)

		ToggleText(1, "-", false, true)
		
		TukuiBar2:Show()
		
		if TukuiSaved.splitbars == true then
			for i = 7, 12 do
				local b = _G["MultiBarLeftButton"..i]
				b:SetAlpha(1)
				b:SetScale(1)		
			end
		end
	end	
	Toggle[4]:SetHeight(LeftSplitBG:GetHeight())
	Toggle[5]:SetHeight(RightSplitBG:GetHeight())
end

local RightBars = function()
	if TukuiSaved.rightbars >= 1 then
		PetBG:ClearAllPoints()
		if db.vertical_rightbars == true then
			PetBG:SetPoint("BOTTOMRIGHT", RightBG, "BOTTOMLEFT", -3, 0)
		else
			PetBG:SetPoint("BOTTOMRIGHT", RightBG, "TOPRIGHT", 0, 3)
		end
	else
		PetBG:ClearAllPoints()
		PetBG:SetPoint("BOTTOMRIGHT", RightTabs, "TOPRIGHT", 0, 3)
	end
	
	if TukuiSaved.rightbars == 1 then
		RightBG:Show()
		if db.vertical_rightbars == true then
			RightBG:SetWidth((db.buttonsize + db.buttonspacing * 2) + 2)
		else
			RightBG:SetHeight((db.buttonsize + db.buttonspacing * 2) + 2)
		end
		
		if TukuiSaved.splitbars ~= true and TukuiBar3:IsShown() then
			TukuiBar3:Hide()
		end
		if TukuiBar5:IsShown() then
			TukuiBar5:Hide()
		end
		TukuiBar4:Show()
	elseif TukuiSaved.rightbars == 2 then
		RightBG:Show()
		if db.vertical_rightbars == true then
			RightBG:SetWidth((db.buttonsize * 2 + db.buttonspacing * 3) + 2)
		else
			RightBG:SetHeight((db.buttonsize * 2 + db.buttonspacing * 3) + 2)
		end
		
		if TukuiSaved.splitbars ~= true and TukuiBar3:IsShown() then
			TukuiBar3:Hide()
		end
		TukuiBar4:Show()
		TukuiBar5:Show()
	elseif TukuiSaved.rightbars == 3 then
		RightBG:Show()
		if db.vertical_rightbars == true then
			RightBG:SetWidth((db.buttonsize * 3 + db.buttonspacing * 4) + 2)
		else
			RightBG:SetHeight((db.buttonsize * 3 + db.buttonspacing * 4) + 2)
		end
		
		TukuiBar4:Show()
		TukuiBar5:Show()
		if TukuiSaved.splitbars ~= true then
			TukuiBar3:Show()
			for i = 1, 12 do
				local b = _G["MultiBarLeftButton"..i]
				local b2 = _G["MultiBarLeftButton"..i-1]
				b:SetSize(db.buttonsize, db.buttonsize)
				b:ClearAllPoints()
				
				if i == 1 then
					b:SetPoint("TOPLEFT", RightBG, 5, -5)
				else
					if not TukuiSaved.splitbars and db.vertical_rightbars == true then
						b:SetPoint("TOP", b2, "BOTTOM", 0, -db.buttonspacing)
					else
						b:SetPoint("LEFT", b2, "RIGHT", db.buttonspacing, 0)
					end
				end
			end
		end
	elseif TukuiSaved.rightbars == 0 then
		RightBG:Hide()

		if TukuiSaved.splitbars ~= true then
			TukuiBar3:Hide()
		end
		TukuiBar4:Hide()
		TukuiBar5:Hide()
	end
end

local SplitBars = function()
	if TukuiSaved.splitbars == true then
		for i = 1, 12 do
			local b = _G["MultiBarLeftButton"..i]
			local b2 = _G["MultiBarLeftButton"..i-1]
			b:ClearAllPoints()
			if i == 1 then
				b:SetPoint("BOTTOMLEFT", LeftSplitBG, 5, 5)
			else
				if i == 4 then
					b:SetPoint("BOTTOMLEFT", RightSplitBG, 5, 5)
				elseif i == 7 then
					b:SetPoint("BOTTOMLEFT", _G["MultiBarLeftButton1"], "TOPLEFT", 0, db.buttonspacing)
				elseif i == 10 then
					b:SetPoint("BOTTOMLEFT", _G["MultiBarLeftButton4"], "TOPLEFT", 0, db.buttonspacing)
				else
					b:SetPoint("LEFT", b2, "RIGHT", db.buttonspacing, 0)
				end
			end
		end		

		if TukuiSaved.rightbars == 3 then
			RightBG:Show()
			if db.vertical_rightbars == true then
				RightBG:SetWidth((db.buttonsize * 2 + db.buttonspacing * 3) + 2)
			else
				RightBG:SetHeight((db.buttonsize * 2 + db.buttonspacing * 3) + 2)
			end
		end
		
		Toggle[4]:ClearAllPoints()
		Toggle[5]:ClearAllPoints()
		Toggle[4]:SetPoint("BOTTOMRIGHT", LeftSplitBG, "BOTTOMLEFT", -3, 0)
		Toggle[5]:SetPoint("BOTTOMLEFT", RightSplitBG, "BOTTOMRIGHT", 3, 0)
	
		ToggleText(4, ">", false, true)
		ToggleText(5, "<", false, true)
	
		TukuiBar3:Show()
		
		if TukuiSaved.bottomrows == 1 then
			for i = 7, 12 do
				local b = _G["MultiBarLeftButton"..i]
				b:SetAlpha(0)
				b:SetScale(0.0001)		
			end
		elseif TukuiSaved.bottomrows == 2 then
			for i = 7, 12 do
				local b = _G["MultiBarLeftButton"..i]
				b:SetAlpha(1)
				b:SetScale(1)		
			end
		end
		LeftSplitBG:Show()
		RightSplitBG:Show()
	elseif TukuiSaved.splitbars == false then
		for i = 1, 12 do
			local b = _G["MultiBarLeftButton"..i]
			local b2 = _G["MultiBarLeftButton"..i-1]
			b:ClearAllPoints()
			if i == 1 then
				b:SetPoint("TOPLEFT", RightBG, db.buttonspacing, -db.buttonspacing)
			else
				b:SetPoint("LEFT", b2, "RIGHT", db.buttonspacing, 0)
			end
		end
		
		Toggle[4]:ClearAllPoints()
		Toggle[5]:ClearAllPoints()
		Toggle[4]:SetPoint("BOTTOMRIGHT", BarBG, "BOTTOMLEFT", -3, 0)
		Toggle[5]:SetPoint("BOTTOMLEFT", BarBG, "BOTTOMRIGHT", 3, 0)

		ToggleText(4, "<", true)
		ToggleText(5, ">", true)
	
		RightBars()

		for i = 7, 12 do
			local b = _G["MultiBarLeftButton"..i]
			b:SetAlpha(1)
			b:SetScale(1)		
		end

		LeftSplitBG:Hide()
		RightSplitBG:Hide()
	end
end

for i = 1, 5 do
	Toggle[i] = CreateFrame("Frame", "TukuiToggle"..i, Toggle)
	Toggle[i]:EnableMouse(true)
	Toggle[i]:SetAlpha(0)
	
	Toggle[i].Text = Toggle[i]:CreateFontString(nil, "OVERLAY")
	Toggle[i].Text:SetFont(TukuiCF["media"].custom_font_1, 12, "MONOCHROMEOUTLINE")
	Toggle[i].Text:SetPoint("CENTER", 2, 1)
	
	if i == 1 then
		TukuiDB.CreateUltimate(Toggle[i], false, db.buttonsize * 12 + db.buttonspacing * 13, db.buttonsize / 2, "BOTTOM", BarBG, "TOP", 0, 3)
		
		Toggle[i]:SetScript("OnMouseDown", function()
			TukuiSaved.bottomrows = TukuiSaved.bottomrows + 1

			if TukuiSaved.bottomrows > 2 then
				TukuiSaved.bottomrows = 1
			end
			
			MainBars()
		end)
		Toggle[i]:SetScript("OnEvent", MainBars)
	elseif i == 2 then
		TukuiDB.CreateUltimate(Toggle[i], false, db.buttonsize, RightTabs:GetHeight() - 6, "RIGHT", RightTabs, "RIGHT", -3, 0)
		Toggle[i]:SetFrameLevel(RightTabs:GetFrameLevel() + 1)
		Toggle[i].shadow:Hide()
	
		if db.vertical_rightbars then
			ToggleText(i, ">", false, true)
		else
			ToggleText(i, "-", false, true)
		end
		
		Toggle[i]:SetScript("OnMouseDown", function()
			TukuiSaved.rightbars = TukuiSaved.rightbars - 1

			if TukuiSaved.splitbars == true and TukuiSaved.rightbars > 2 then
				TukuiSaved.rightbars = 1
			elseif TukuiSaved.rightbars < 0 then
				if TukuiSaved.splitbars == true then
					TukuiSaved.rightbars = 2
				else
					TukuiSaved.rightbars = 3
				end
			end
			RightBars()
		end)
		Toggle[i]:SetScript("OnEvent", RightBars)	
	elseif i == 3 then
		TukuiDB.CreateUltimate(Toggle[i], false, db.buttonsize, RightTabs:GetHeight() - 6, "TOPRIGHT", Toggle[i-1], "TOPLEFT", -3, 0)
		Toggle[i]:SetFrameLevel(RightTabs:GetFrameLevel() + 1)
		Toggle[i].shadow:Hide()
	
	if db.vertical_rightbars then
			ToggleText(i, "<", true)
		else
			ToggleText(i, "+", true)
		end
		
		Toggle[i]:SetScript("OnMouseDown", function()
			TukuiSaved.rightbars = TukuiSaved.rightbars + 1
			
			if TukuiSaved.splitbars == true and TukuiSaved.rightbars > 2 then
				TukuiSaved.rightbars = 0
			elseif TukuiSaved.rightbars > 3 then
				TukuiSaved.rightbars = 0
			end

			RightBars()
		end)
		Toggle[i]:SetScript("OnEvent", RightBars)
	elseif i == 4 then
		TukuiDB.CreateUltimate(Toggle[i], false, db.buttonsize / 2, ((db.buttonsize * 2) + (db.buttonspacing * 3)), "BOTTOMRIGHT", LeftSplitBG, "BOTTOMLEFT", -3, 0)
		
		Toggle[i]:SetScript("OnMouseDown", function()
			if TukuiSaved.splitbars == false then
				TukuiSaved.splitbars = true
			elseif TukuiSaved.splitbars == true then
				TukuiSaved.splitbars = false
			end
			SplitBars()
		end)
		Toggle[i]:SetScript("OnEvent", SplitBars)

	elseif i == 5 then
		TukuiDB.CreateUltimate(Toggle[i], false, db.buttonsize / 2, ((db.buttonsize * 2) + (db.buttonspacing * 3)), "BOTTOMLEFT", RightSplitBG, "BOTTOMRIGHT", 3, 0)
		
		Toggle[i]:SetScript("OnMouseDown", function()
			if TukuiSaved.splitbars == false then
				TukuiSaved.splitbars = true
			elseif TukuiSaved.splitbars == true then
				TukuiSaved.splitbars = false
			end
			SplitBars()
		end)
		Toggle[i]:SetScript("OnEvent", SplitBars)

	end
	Toggle[i]:RegisterEvent("PLAYER_ENTERING_WORLD")
	Toggle[i]:RegisterEvent("PLAYER_REGEN_DISABLED")
	Toggle[i]:RegisterEvent("PLAYER_REGEN_ENABLED")

	Toggle[i]:SetScript("OnEnter", function()
		if InCombatLockdown() then return end
		TukuiDB.FadeIn(Toggle[i])
	end)

	Toggle[i]:SetScript("OnLeave", function()
		TukuiDB.FadeOut(Toggle[i])
	end)

	Toggle[i]:SetScript("OnUpdate", function() 
		if TukuiSaved.actionbars_lock == true then
			Toggle[i]:EnableMouse(false)
		elseif TukuiSaved.actionbars_lock == false then
			Toggle[i]:EnableMouse(true)
		end
	end)		
end
Toggle:RegisterEvent("PLAYER_ENTERING_WORLD")