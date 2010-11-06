if TukuiCF["datatext"].hitrating and TukuiCF["datatext"].hitrating > 0 then
	local font, font_size, font_style, font_shadow = TukuiCF["fonts"].datatext_font, TukuiCF["fonts"].datatext_font_size, TukuiCF["fonts"].datatext_font_style, TukuiCF["fonts"].datatext_font_shadow

	local Stat = CreateFrame("Frame")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("BACKGROUND")
 	Stat:SetFrameLevel(3)

	local Text  = TukuiDataLeft:CreateFontString(nil, "OVERLAY")
	Text:SetFont(font, font_size, font_style)
	Text:SetShadowOffset(font_shadow and 1 or 0, font_shadow and -1 or 0)
	TukuiDB.PP(TukuiCF["datatext"].hitrating, Text)
	
	local spellTable = {
		[0] = 4,
		[1] = 5,
		[2] = 6,
		[3] = 17,
	}
	
	local meleeTable = {
		[0] = 5,
		[1] = 5.5,
		[2] = 6,
		[3] = 8,
	}
 
	local int = 1
 
	local function Update(self, t)
		int = int - t
		local base, posBuff, negBuff = UnitAttackPower("player")
		local effective = base + posBuff + negBuff
		local Rbase, RposBuff, RnegBuff = UnitRangedAttackPower("player")
		local Reffective = Rbase + RposBuff + RnegBuff
	 
		Rattackpwr = Reffective
		spellpwr = GetSpellBonusDamage(7)
		attackpwr = effective
	 
		if int < 0 then
			if attackpwr > spellpwr and select(2, UnitClass("Player")) ~= "HUNTER" then
				rating = format("%.2f", GetCombatRatingBonus(6))
			elseif select(2, UnitClass("Player")) == "HUNTER" then
				rating = format("%.2f", GetCombatRatingBonus(7))
			else
				rating = format("%.2f", GetCombatRatingBonus(8))
			end
			
			Text:SetText(rating.. "% " .. cStart .. HIT) -- use wow locale

			int = 1
		end
		self:SetAllPoints(Text)
	end
	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 10)
	
	local function missPercent(level, hitpercent, type)
		local result
		
		if (type == "SPELL") then
			result = spellTable[level] - hitpercent
		elseif (type == "MELEE") then
			result = meleeTable[level] - hitpercent
		else
			error("Wrong type-parameter to function 'missPercent'")
		end
		
		if result < 0 then
			result = 0
		end
		return result
	end
	
	Stat:SetScript("OnEnter", function(self)
		local spellhitrating = GetCombatRating(CR_HIT_MELEE)
		local spellhitpercent = format("%.2f", GetCombatRatingBonus(CR_HIT_SPELL))
		local meleehitrating = GetCombatRating(CR_HIT_SPELL)
		local meleehitpercent = format("%.2f", GetCombatRatingBonus(CR_HIT_MELEE))
		
		if not InCombatLockdown() then
			GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, TukuiDB.Scale(6));
			GameTooltip:ClearAllPoints()
			GameTooltip:SetPoint("BOTTOM", self, "TOP", 0, TukuiDB.mult)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(cStart .. HIT)
			GameTooltip:AddDoubleLine("Hitrating", cStart .. meleehitrating, 1, 1, 1)
			GameTooltip:AddDoubleLine("Melee Hit %", cStart .. meleehitpercent .. "%",  1, 1, 1)
			GameTooltip:AddDoubleLine("Spell Hit %", cStart .. spellhitpercent .. "%",  1, 1, 1)
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine(cStart .. "            Melee")
			GameTooltip:AddDoubleLine(cStart .. LEVEL, cStart .. MISS)
			GameTooltip:AddDoubleLine(UnitLevel("player")    , cStart .. missPercent(0, meleehitpercent, "MELEE") .. "%", 1, 1, 1)
			GameTooltip:AddDoubleLine(UnitLevel("player") + 1, cStart .. missPercent(1, meleehitpercent, "MELEE") .. "%", 1, 1, 1)
			GameTooltip:AddDoubleLine(UnitLevel("player") + 2, cStart .. missPercent(2, meleehitpercent, "MELEE") .. "%", 1, 1, 1)
			GameTooltip:AddDoubleLine(UnitLevel("player") + 3, cStart .. missPercent(3, meleehitpercent, "MELEE") .. "%", 1, 1, 1)
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine(cStart .. "            Spells")
			GameTooltip:AddDoubleLine(cStart .. LEVEL, cStart .. MISS)
			GameTooltip:AddDoubleLine(UnitLevel("player")    , cStart .. missPercent(0, spellhitpercent, "SPELL") .. "%", 1, 1, 1)
			GameTooltip:AddDoubleLine(UnitLevel("player") + 1, cStart .. missPercent(1, spellhitpercent, "SPELL") .. "%", 1, 1, 1)
			GameTooltip:AddDoubleLine(UnitLevel("player") + 2, cStart .. missPercent(2, spellhitpercent, "SPELL") .. "%", 1, 1, 1)
			GameTooltip:AddDoubleLine(UnitLevel("player") + 3, cStart .. missPercent(3, spellhitpercent, "SPELL") .. "%", 1, 1, 1)
			GameTooltip:Show()
		end
	end)
	Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
	Stat:SetScript("OnMouseDown", function() ToggleCharacter("PaperDollFrame") end)
end