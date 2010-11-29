--[[
    In-game Minimap Menu for my Tukui edit.

    To-do:
	-- Implement Actionbar Toggle.
	-- Implement my LFD / BG / Raid module.
	
	© 2010 Eclípsé
	
	Don't use without my permission, please respect this.
]]--


local MiniMenu = CreateFrame("Frame", "MiniMenu", UIParent)
MiniMenu:SetSize(TukuiMinimap:GetWidth() + 4, TukuiCF["panels"].tinfoheight)
MiniMenu:EnableMouse(true)
ecUI.SkinPanel(MiniMenu)
MiniMenu:SetScript("OnEnter", TukuiDB.SetModifiedBackdrop)
MiniMenu:SetScript("OnLeave", TukuiDB.SetOriginalBackdrop)

local MiniMenuText = MiniMenu:CreateFontString(nil, "OVERLAY")
MiniMenuText:SetFont(TukuiCF["media"].custom_font_1, 12, "MONOCHROMEOUTLINE")
MiniMenuText:SetPoint("CENTER", 0, 1)
MiniMenuText:SetText("MiniMenu")
ecUI.Color(MiniMenuText)

local check_locked = function(index, var, text)
	if var == true then
		MiniMenu[index].text:SetText("Unlock " .. text)
		ecUI.Color(MiniMenu[index].text, false, true)

		if var == ecSV.locked_minimap then
			TukuiToggleMinimap:EnableMouse(false)
		end
	elseif var == false then
		MiniMenu[index].text:SetText("Lock " .. text)
		ecUI.Color(MiniMenu[index].text, true, false)
		
		if var == ecSV.locked_minimap then
			TukuiToggleMinimap:EnableMouse(true)
		end
	end
end

for i = 1, 4 do
	MiniMenu[i] = CreateFrame("Frame", "MiniMenuButton"..i, MiniMenu)
	MiniMenu[i]:SetSize(MiniMenu:GetWidth(), TukuiCF["panels"].tinfoheight)
	MiniMenu[i]:EnableMouse(true)
	ecUI.SkinPanel(MiniMenu[i])
	MiniMenu[i]:Hide()
	MiniMenu[i]:SetScript("OnEnter", TukuiDB.SetModifiedBackdrop)
	MiniMenu[i]:SetScript("OnLeave", TukuiDB.SetOriginalBackdrop)

	MiniMenu[i].text = MiniMenu[i]:CreateFontString(nil, "OVERLAY")
	MiniMenu[i].text:SetFont(TukuiCF["media"].custom_font_1, 12, "MONOCHROMEOUTLINE")
	MiniMenu[i].text:SetPoint("CENTER", 0, 1)
	ecUI.Color(MiniMenu[i].text)
	
	if i == 1 then
		MiniMenu[i]:SetPoint("TOPLEFT", MiniMenu, "BOTTOMLEFT", 0, TukuiDB.Scale(-3))
	else
		MiniMenu[i]:SetPoint("TOPLEFT", MiniMenu[i-1], "BOTTOMLEFT", 0, TukuiDB.Scale(-3))
	end
	
	if i == 1 then
		MiniMenu[i]:SetScript("OnMouseDown", function() ToggleCalendar() end)

		MiniMenu[i].text:SetText("Calender")
	elseif i == 2 then
		MiniMenu[i]:SetScript("OnMouseDown", function()
			if ecSV.locked_actionbars == true then
				ecSV.locked_actionbars = false
			elseif ecSV.locked_actionbars == false then
				ecSV.locked_actionbars = true
			end
			check_locked(i, ecSV.locked_actionbars, "Actionbars")
		end)

		MiniMenu[i]:SetScript("OnEvent", function() check_locked(i, ecSV.locked_actionbars, "Actionbars") end)
	elseif i == 3 then 
		MiniMenu[i]:SetScript("OnMouseDown", function()
			if ecSV.locked_minimap == true then
				ecSV.locked_minimap = false
			elseif ecSV.locked_minimap == false then
				ecSV.locked_minimap = true
			end
			check_locked(i, ecSV.locked_minimap, "Minimap")
		end)

		MiniMenu[i]:SetScript("OnEvent", function() check_locked(i, ecSV.locked_minimap, "Minimap") end)
	elseif i == 4 then
		MiniMenu[i]:SetScript("OnMouseDown", function() 
			-- if ecSV.lfg_shown == true then
				-- ecSV.lfg_shown = false
			-- elseif ecSV.lfg_shown == false then
				-- ecSV.lfg_shown = true
			-- end
			-- lfd_check()
			ToggleFrame(LFDParentFrame)
		end)

		MiniMenu[i].text:SetText("LFG / BG / Raid")
	end
	MiniMenu[i]:RegisterEvent("PLAYER_ENTERING_WORLD")
end
MiniMenu:RegisterEvent("PLAYER_ENTERING_WORLD")

MiniMenu:SetScript("OnMouseDown", function()
	if InCombatLockdown() then return end
	for i = 1, 4 do
		if MiniMenu[i]:IsShown() then
			MiniMenu[i]:Hide()
		else
			MiniMenu[i]:Show()
		end
	end
end)