------------------------------------------------------
--- Hit Rating
------------------------------------------------------
 
if TukuiCF["datatext"].hitrating and TukuiCF["datatext"].hitrating > 0 then
	local db = TukuiCF.fonts
	local font, font_size, font_style, font_shadow = db.datatext_font, db.datatext_font_size, db.datatext_font_style, db.datatext_font_shadow

	local Stat = CreateFrame("Frame")
	Stat:SetFrameStrata("BACKGROUND")
 	Stat:SetFrameLevel(3)

	local Text  = TukuiDataLeft:CreateFontString(nil, "OVERLAY")
	Text:SetFont(font, font_size, font_style)
	Text:SetShadowOffset(font_shadow and 1 or 0, font_shadow and -1 or 0)
	TukuiDB.PP(TukuiCF["datatext"].hitrating, Text)
 
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
	end
	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 10)
end