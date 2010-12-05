--[[
    In-game Minimap Menu for my Tukui edit.

    To-do:
	-- Implement Actionbar Toggle.
	-- Implement my LFD / BG / Raid module.
	
	© 2010 Eclípsé
	
	Don't use without my permission, please respect this.
]]--


local Minimenu = CreateFrame("Frame", "TukuiMinimenu", UIParent)
TukuiDB.CreateUltimate(Minimenu, false, TukuiMinimap:GetWidth() + 4, TukuiCF["panels"].tinfoheight, "TOPLEFT", TukuiMinimap, "BOTTOMLEFT", 0, -3)
Minimenu:EnableMouse(true)
Minimenu:SetScript("OnEnter", TukuiDB.SetModifiedBackdrop)
Minimenu:SetScript("OnLeave", TukuiDB.SetOriginalBackdrop)

local MinimenuText = Minimenu:CreateFontString(nil, "OVERLAY")
MinimenuText:SetFont(TukuiCF["media"].custom_font_1, 12, "MONOCHROMEOUTLINE")
MinimenuText:SetPoint("CENTER", 0, 1)
MinimenuText:SetText("Minimenu")
TukuiDB.Color(MinimenuText)

local CheckLocked = function(index, var, text)
	if var == true then
		Minimenu[index].Text:SetText("Unlock " .. text)
		TukuiDB.Color(Minimenu[index].Text, false, true)

		if var == TukuiSaved.minimap_lock then
			TukuiToggleMinimap:EnableMouse(false)
		end
	elseif var == false then
		Minimenu[index].Text:SetText("Lock " .. text)
		TukuiDB.Color(Minimenu[index].Text, true, false)
		
		if var == TukuiSaved.minimap_lock then
			TukuiToggleMinimap:EnableMouse(true)
		end
	end
end

for i = 1, 4 do
	Minimenu[i] = CreateFrame("Frame", "MinimenuButton"..i, Minimenu)
	TukuiDB.CreateUltimate(Minimenu[i], false, Minimenu:GetWidth(), TukuiCF["panels"].tinfoheight, "CENTER")
	Minimenu[i]:EnableMouse(true)
	Minimenu[i]:Hide()
	Minimenu[i]:SetScript("OnEnter", TukuiDB.SetModifiedBackdrop)
	Minimenu[i]:SetScript("OnLeave", TukuiDB.SetOriginalBackdrop)

	Minimenu[i].Text = Minimenu[i]:CreateFontString(nil, "OVERLAY")
	Minimenu[i].Text:SetFont(TukuiCF["media"].custom_font_1, 12, "MONOCHROMEOUTLINE")
	Minimenu[i].Text:SetPoint("CENTER", 0, 1)
	TukuiDB.Color(Minimenu[i].Text)
	
	if i == 1 then
		Minimenu[i]:SetPoint("TOPLEFT", Minimenu, "BOTTOMLEFT", 0, TukuiDB.Scale(-3))
	else
		Minimenu[i]:SetPoint("TOPLEFT", Minimenu[i-1], "BOTTOMLEFT", 0, TukuiDB.Scale(-3))
	end
	
	if i == 1 then
		Minimenu[i]:SetScript("OnMouseDown", function() ToggleCalendar() end)

		Minimenu[i].Text:SetText("Calendar")
	elseif i == 2 then
		Minimenu[i]:SetScript("OnMouseDown", function()
			if TukuiSaved.actionbars_lock == true then
				TukuiSaved.actionbars_lock = false
				print(tukuilocal.actionbars_lockoff)
			elseif TukuiSaved.actionbars_lock == false then
				TukuiSaved.actionbars_lock = true
				print(tukuilocal.actionbars_lockon)
			end
			CheckLocked(i, TukuiSaved.actionbars_lock, "Actionbars")
		end)

		Minimenu[i]:SetScript("OnEvent", function() CheckLocked(i, TukuiSaved.actionbars_lock, "Actionbars") end)
	elseif i == 3 then 
		Minimenu[i]:SetScript("OnMouseDown", function()
			if TukuiSaved.minimap_lock == true then
				TukuiSaved.minimap_lock = false
				print(tukuilocal.minimap_lockoff)
			elseif TukuiSaved.minimap_lock == false then
				TukuiSaved.minimap_lock = true
				print(tukuilocal.minimap_lockon)
			end
			CheckLocked(i, TukuiSaved.minimap_lock, "Minimap")
		end)

		Minimenu[i]:SetScript("OnEvent", function() CheckLocked(i, TukuiSaved.minimap_lock, "Minimap") end)
	elseif i == 4 then
		Minimenu[i]:SetScript("OnMouseDown", function() 
			-- if TukuiSaved.lfg_shown == true then
				-- TukuiSaved.lfg_shown = false
			-- elseif TukuiSaved.lfg_shown == false then
				-- TukuiSaved.lfg_shown = true
			-- end
			-- lfd_check()
			ToggleFrame(LFDParentFrame)
		end)

		Minimenu[i].Text:SetText("LFG")
	end
	Minimenu[i]:RegisterEvent("PLAYER_ENTERING_WORLD")
end
Minimenu:RegisterEvent("PLAYER_ENTERING_WORLD")

Minimenu:SetScript("OnMouseDown", function()
	if InCombatLockdown() then return end
	for i = 1, 4 do
		if Minimenu[i]:IsShown() then
			Minimenu[i]:Hide()
		else
			Minimenu[i]:Show()
		end
	end
end)