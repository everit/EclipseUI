--[[
    In-game Action Bar Toggle for my Tukui edit.

    To-do:
	-- Big code clean up..
	-- Pull some other code from other files into this one, would work better.
	
	© 2010 Eclípsé
]]--

local db = TukuiCF["actionbar"]

if not db.enable then return end

----- [[     Color / Text Values     ]] -----

local c_increase, c_decrease = {.3, .3, .9}, {.9, .3, .3}
local plus, minus = "+", "-"


----- [[     Action Bar Toggle Buttons     ]] -----

local Toggle = CreateFrame("Frame")

for i = 1, 5 do
	Toggle[i] = CreateFrame("Frame", "TukuiToggle"..i, UIParent)
	Toggle[i]:EnableMouse(true)
	Toggle[i]:SetAlpha(0)
	
	if i == 1 then
		TukuiDB.CreatePanel(Toggle[i], ((db.buttonsize * 2) + db.buttonspacing), db.buttonsize / 2, "BOTTOM", TukuiActionBarBackground, "TOP", 0, 3)
	elseif i == 2 then
		TukuiDB.CreatePanel(Toggle[i], db.buttonsize, TukuiChatRightTabs:GetHeight(), "TOPRIGHT", TukuiChatRightTabs, "TOPRIGHT")
		Toggle[i]:SetFrameLevel(TukuiChatRightTabs:GetFrameLevel() + 1)
		TukuiDB.Kill(Toggle[i].shadow)
	elseif i == 3 then
		TukuiDB.CreatePanel(Toggle[i], db.buttonsize, TukuiChatRightTabs:GetHeight(), "TOPRIGHT", Toggle[i-1], "TOPLEFT", -3, 0)
		Toggle[i]:SetFrameLevel(TukuiChatRightTabs:GetFrameLevel() + 1)
		TukuiDB.Kill(Toggle[i].shadow)
	elseif i == 4 then
		TukuiDB.CreatePanel(Toggle[i], db.buttonsize / 2, ((db.buttonsize * 2) + (db.buttonspacing * 1)), "BOTTOMRIGHT", TukuiLeftSplitBarBackground, "BOTTOMLEFT", -3, 0)
	elseif i == 5 then
		TukuiDB.CreatePanel(Toggle[i], db.buttonsize / 2, ((db.buttonsize * 2) + (db.buttonspacing * 1)), "BOTTOMLEFT", TukuiRightSplitBarBackground, "BOTTOMRIGHT", 3, 0)
	end
end

----- [[     Action Bar Adjust Text     ]] -----

for i = 1, 5 do
	Toggle[i].text = Toggle[i]:CreateFontString(nil, "OVERLAY")
	Toggle[i].text:SetFont(TukuiCF["media"].custom_font_1, 12, "MONOCHROMEOUTLINE")
	Toggle[i].text:SetPoint("CENTER", 2, 1)
	
	if i == 2 then
		Toggle[i].text:SetText(plus)
		Toggle[i].text:SetTextColor(unpack(c_increase))
	elseif i == 3 then
		Toggle[i].text:SetText(minus)
		Toggle[i].text:SetTextColor(unpack(c_decrease))	
	end
end


----- [[     Action Bar Check + Change Functions     ]] -----

local bb_check = function()
	if EclipseSettings.bottomrows == 1 then
		TukuiActionBarBackground:SetHeight(db.buttonsize)
		
		Toggle[1].text:SetText(plus)
		Toggle[1].text:SetTextColor(unpack(c_increase))
		
		if TukuiBar2:IsShown() then
			TukuiBar2:Hide()
		end
		
		if EclipseSettings.splitbars == true then
			for i = 7, 12 do
				local b = _G["MultiBarLeftButton"..i]
				b:SetAlpha(0)
				b:SetScale(0.0001)
			end
		end
		Toggle[4]:SetHeight(db.buttonsize)
		Toggle[5]:SetHeight(db.buttonsize)
	elseif EclipseSettings.bottomrows == 2 then
		TukuiActionBarBackground:SetHeight((db.buttonsize * 2) + (db.buttonspacing * 1))
		
		Toggle[1].text:SetText(minus)
		Toggle[1].text:SetTextColor(unpack(c_decrease))

		TukuiBar2:Show()
		
		if EclipseSettings.splitbars == true then
			for i = 7, 12 do
				local b = _G["MultiBarLeftButton"..i]
				b:SetAlpha(1)
				b:SetScale(1)
			end
		end
		Toggle[4]:SetHeight((db.buttonsize * 2) + (db.buttonspacing * 1))
		Toggle[5]:SetHeight((db.buttonsize * 2) + (db.buttonspacing * 1))
	end
end

local rbb_check = function()
	if EclipseSettings.rightbars >= 1 then
		TukuiPetActionBarBackground:ClearAllPoints()
		if db.vertical_rightbars == true then
			TukuiPetActionBarBackground:SetPoint("BOTTOMRIGHT", TukuiActionBarBackgroundRight, "BOTTOMLEFT", -3, 0)
		else
			TukuiPetActionBarBackground:SetPoint("BOTTOMRIGHT", TukuiActionBarBackgroundRight, "TOPRIGHT", 0, 3)
		end
	else
		TukuiPetActionBarBackground:ClearAllPoints()
		TukuiPetActionBarBackground:SetPoint("BOTTOMRIGHT", TukuiChatRightTabs, "TOPRIGHT", 0, 3)
	end
	
	if db.vertical_rightbars == true then
		TukuiPetActionBarBackground:SetWidth(db.petbuttonsize)
		TukuiPetActionBarBackground:SetHeight((db.petbuttonsize * NUM_PET_ACTION_SLOTS) + (db.buttonspacing * 9))
	else
		TukuiPetActionBarBackground:SetWidth((db.petbuttonsize * NUM_PET_ACTION_SLOTS) + (db.buttonspacing * 9))
		TukuiPetActionBarBackground:SetHeight(db.petbuttonsize)
	end
	
	if EclipseSettings.rightbars == 1 then

		TukuiActionBarBackgroundRight:Show()
		if db.vertical_rightbars == true then
			TukuiActionBarBackgroundRight:SetWidth(db.buttonsize)
		else
			TukuiActionBarBackgroundRight:SetHeight(db.buttonsize)
		end
		
		if EclipseSettings.splitbars ~= true and TukuiBar3:IsShown() then
			TukuiBar3:Hide()
		end
		if TukuiBar5:IsShown() then
			TukuiBar5:Hide()
		end
		TukuiBar4:Show()
	elseif EclipseSettings.rightbars == 2 then
		TukuiActionBarBackgroundRight:Show()
		if db.vertical_rightbars == true then
			TukuiActionBarBackgroundRight:SetWidth((db.buttonsize * 2) + db.buttonspacing)
		else
			TukuiActionBarBackgroundRight:SetHeight((db.buttonsize * 2) + db.buttonspacing)
		end
		
		if EclipseSettings.splitbars ~= true and TukuiBar3:IsShown() then
			TukuiBar3:Hide()
		end
		TukuiBar4:Show()
		TukuiBar5:Show()
	elseif EclipseSettings.rightbars == 3 then
		TukuiActionBarBackgroundRight:Show()
		if db.vertical_rightbars == true then
			TukuiActionBarBackgroundRight:SetWidth((db.buttonsize * 3) + (db.buttonspacing * 2))
		else
			TukuiActionBarBackgroundRight:SetHeight((db.buttonsize * 3) + (db.buttonspacing * 2))
		end
		
		TukuiBar4:Show()
		TukuiBar5:Show()
		if EclipseSettings.splitbars ~= true then
			TukuiBar3:Show()
			for i = 1, 12 do
				local b = _G["MultiBarLeftButton"..i]
				local b2 = _G["MultiBarLeftButton"..i-1]
				b:SetSize(db.buttonsize, db.buttonsize)
				b:ClearAllPoints()
				
				if i == 1 then
					b:SetPoint("TOPLEFT", TukuiActionBarBackgroundRight)
				else
					if not EclipseSettings.splitbars and db.vertical_rightbars == true then
						b:SetPoint("TOP", b2, "BOTTOM", 0, -db.buttonspacing)
					else
						b:SetPoint("LEFT", b2, "RIGHT", db.buttonspacing, 0)
					end
				end
			end
		end
	elseif EclipseSettings.rightbars == 0 then
		TukuiActionBarBackgroundRight:Hide()

		if EclipseSettings.splitbars ~= true then
			TukuiBar3:Hide()
		end
		TukuiBar4:Hide()
		TukuiBar5:Hide()
	end
end

local splbb_check = function()
	if EclipseSettings.splitbars == true then
		for i = 1, 12 do
			local b = _G["MultiBarLeftButton"..i]
			local b2 = _G["MultiBarLeftButton"..i-1]
			b:ClearAllPoints()
			if i == 1 then
				b:SetPoint("BOTTOMLEFT", TukuiLeftSplitBarBackground)
			else
				if i == 4 then
					b:SetPoint("BOTTOMLEFT", TukuiRightSplitBarBackground)
				elseif i == 7 then
					b:SetPoint("BOTTOMLEFT", _G["MultiBarLeftButton1"], "TOPLEFT", 0, db.buttonspacing)
				elseif i == 10 then
					b:SetPoint("BOTTOMLEFT", _G["MultiBarLeftButton4"], "TOPLEFT", 0, db.buttonspacing)
				else
					b:SetPoint("LEFT", b2, "RIGHT", db.buttonspacing, 0)
				end
			end
		end		

		if EclipseSettings.rightbars == 3 then
			TukuiActionBarBackgroundRight:Show()
			if db.vertical_rightbars == true then
			TukuiActionBarBackgroundRight:SetWidth((db.buttonsize * 2) + (db.buttonspacing))
				else
				TukuiActionBarBackgroundRight:SetHeight((db.buttonsize * 2) + (db.buttonspacing))
			end
		end
		
		Toggle[4]:ClearAllPoints()
		Toggle[5]:ClearAllPoints()
		Toggle[4]:SetPoint("BOTTOMRIGHT", TukuiLeftSplitBarBackground, "BOTTOMLEFT", -3, 0)
		Toggle[5]:SetPoint("BOTTOMLEFT", TukuiRightSplitBarBackground, "BOTTOMRIGHT", 3, 0)
	

		Toggle[4].text:SetText(minus)
		Toggle[5].text:SetText(minus)
		Toggle[4].text:SetTextColor(unpack(c_decrease))
		Toggle[5].text:SetTextColor(unpack(c_decrease))
	
		TukuiBar3:Show()
		
		if EclipseSettings.bottomrows == 1 then
			for i = 7, 12 do
				local b = _G["MultiBarLeftButton"..i]
				b:SetAlpha(0)
				b:SetScale(0.0001)
			end
		elseif EclipseSettings.bottomrows == 2 then
			for i = 7, 12 do
				local b = _G["MultiBarLeftButton"..i]
				b:SetAlpha(1)
				b:SetScale(1)
			end
		end
	elseif EclipseSettings.splitbars == false then
		for i = 1, 12 do
			local b = _G["MultiBarLeftButton"..i]
			local b2 = _G["MultiBarLeftButton"..i-1]
			b:ClearAllPoints()
			if i == 1 then
				b:SetPoint("TOPLEFT", TukuiActionBarBackgroundRight)
			else
				b:SetPoint("LEFT", b2, "RIGHT", db.buttonspacing, 0)
			end
		end
		
		Toggle[4]:ClearAllPoints()
		Toggle[5]:ClearAllPoints()
		Toggle[4]:SetPoint("BOTTOMRIGHT", TukuiActionBarBackground, "BOTTOMLEFT", -3, 0)
		Toggle[5]:SetPoint("BOTTOMLEFT", TukuiActionBarBackground, "BOTTOMRIGHT", 3, 0)

		Toggle[4].text:SetText(plus)
		Toggle[5].text:SetText(plus)
		Toggle[4].text:SetTextColor(unpack(c_increase))
		Toggle[5].text:SetTextColor(unpack(c_increase))
	
		rbb_check()

		for i = 7, 12 do
			local b = _G["MultiBarLeftButton"..i]
			b:SetAlpha(1)
			b:SetScale(1)
		end

		TukuiLeftSplitBarBackground:Hide()
		TukuiRightSplitBarBackground:Hide()
	end
end


----- [[     Action Bar Mouse Down Functions     ]] -----

Toggle[1]:SetScript("OnMouseDown", function()
	if not InCombatLockdown() then
		if EclipseSettings.bottomrows == 1 then
			EclipseSettings.bottomrows = 2
		elseif EclipseSettings.bottomrows == 2 then
			EclipseSettings.bottomrows = 1
		end
		bb_check()
	else
		print(ERR_NOT_IN_COMBAT)
	end
end)
Toggle[1]:RegisterEvent("PLAYER_ENTERING_WORLD")
Toggle[1]:SetScript("OnEvent", bb_check)

Toggle[2]:SetScript("OnMouseDown", function()
	if not InCombatLockdown() then
		if EclipseSettings.rightbars == 1 then
			EclipseSettings.rightbars = 2
		elseif EclipseSettings.rightbars == 2 then
			if EclipseSettings.splitbars == true then
				EclipseSettings.rightbars = 0
			else
				EclipseSettings.rightbars = 3
			end
		elseif EclipseSettings.rightbars == 3 then
			EclipseSettings.rightbars = 0
		elseif EclipseSettings.rightbars == 0 then
			EclipseSettings.rightbars = 1
		end
		rbb_check()
	else
		print(ERR_NOT_IN_COMBAT)
	end
end)
Toggle[2]:RegisterEvent("PLAYER_ENTERING_WORLD")
Toggle[2]:SetScript("OnEvent", bb_check)

Toggle[3]:SetScript("OnMouseDown", function()
	if not InCombatLockdown() then
		if EclipseSettings.rightbars == 3 then
			if EclipseSettings.splitbars == true then
				EclipseSettings.rightbars = 1
			else
				EclipseSettings.rightbars = 2
			end
		elseif EclipseSettings.rightbars == 2 then
			EclipseSettings.rightbars = 1
		elseif EclipseSettings.rightbars == 1 then
			EclipseSettings.rightbars = 0
		elseif EclipseSettings.rightbars == 0 then
			if EclipseSettings.splitbars == true then
				EclipseSettings.rightbars = 2
			else
				EclipseSettings.rightbars = 3
			end
		end
		rbb_check()
	else
		print(ERR_NOT_IN_COMBAT)
	end
end)
Toggle[3]:RegisterEvent("PLAYER_ENTERING_WORLD")
Toggle[3]:SetScript("OnEvent", rbb_check)

Toggle[4]:SetScript("OnMouseDown", function()
	if not InCombatLockdown() then
		if EclipseSettings.splitbars == false then
			EclipseSettings.splitbars = true
		elseif EclipseSettings.splitbars == true then
			EclipseSettings.splitbars = false
		end
		splbb_check()
	else
		print(ERR_NOT_IN_COMBAT)
	end
end)
Toggle[4]:RegisterEvent("PLAYER_ENTERING_WORLD")
Toggle[4]:SetScript("OnEvent", splbb_check)

Toggle[5]:SetScript("OnMouseDown", function()
	if not InCombatLockdown() then
		if EclipseSettings.splitbars == false then
			EclipseSettings.splitbars = true
		elseif EclipseSettings.splitbars == true then
			EclipseSettings.splitbars = false
		end
		splbb_check()
	else
		print(ERR_NOT_IN_COMBAT)
	end
end)
Toggle[5]:RegisterEvent("PLAYER_ENTERING_WORLD")
Toggle[5]:SetScript("OnEvent", splbb_check)


----- [[     Action Bar Mouse Over Functions     ]] -----

Toggle[1]:SetScript("OnEnter", function()
	if InCombatLockdown() then return end
	TukuiDB.FadeIn(Toggle[1])
end)

Toggle[1]:SetScript("OnLeave", function()
	TukuiDB.FadeOut(Toggle[1])
end)

Toggle[2]:SetScript("OnEnter", function()
	if InCombatLockdown() then return end
	TukuiDB.FadeIn(Toggle[2])
end)

Toggle[2]:SetScript("OnLeave", function()
	TukuiDB.FadeOut(Toggle[2])
end)

Toggle[3]:SetScript("OnEnter", function()
	if InCombatLockdown() then return end
	TukuiDB.FadeIn(Toggle[3])
end)

Toggle[3]:SetScript("OnLeave", function()
	TukuiDB.FadeOut(Toggle[3])
end)

Toggle[4]:SetScript("OnEnter", function()
	if InCombatLockdown() then return end
	TukuiDB.FadeIn(Toggle[4])
	TukuiDB.FadeIn(Toggle[5])
end)

Toggle[4]:SetScript("OnLeave", function()
	TukuiDB.FadeOut(Toggle[4])
	TukuiDB.FadeOut(Toggle[5])
end)

Toggle[5]:SetScript("OnEnter", function()
	if InCombatLockdown() then return end
	TukuiDB.FadeIn(Toggle[4])
	TukuiDB.FadeIn(Toggle[5])
end)

Toggle[5]:SetScript("OnLeave", function()
	TukuiDB.FadeOut(Toggle[4])
	TukuiDB.FadeOut(Toggle[5])
end)


----- [[     Function To Make Sure Buttons Fade If We Enter Combat     ]] -----

Toggle[1]:RegisterEvent("PLAYER_REGEN_DISABLED")
Toggle[1]:SetScript("OnEvent", function(self, event)
	if (event == "PLAYER_REGEN_DISABLED") then
		if Toggle[1]:GetAlpha() > 0 then
			TukuiDB.FadeOut(Toggle[1])
		end
		if Toggle[2]:GetAlpha() > 0 then
			TukuiDB.FadeOut(Toggle[2])
		end		
		if Toggle[3]:GetAlpha() > 0 then
			TukuiDB.FadeOut(Toggle[3])
		end
		if Toggle[4]:GetAlpha() > 0 then
			TukuiDB.FadeOut(Toggle[4])
		end
		if Toggle[5]:GetAlpha() > 0 then
			TukuiDB.FadeOut(Toggle[5])
		end
	end
end)
