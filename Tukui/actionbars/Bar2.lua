local db = TukuiCF["actionbar"]

if not db.enable then return end

local TukuiBar2 = CreateFrame("Frame","TukuiBar2",UIParent)
TukuiBar2:SetAllPoints(TukuiActionBarBackground)
MultiBarBottomLeft:SetParent(TukuiBar2)

for i=1, 12 do
	local b = _G["MultiBarBottomLeftButton"..i]
	local b2 = _G["MultiBarBottomLeftButton"..i-1]
	b:ClearAllPoints()
	b:SetSize(TukuiDB.buttonsize, TukuiDB.buttonsize)
	if i == 1 then
		if db.tukui_default == true then
			b:SetPoint("LEFT", ActionButton12, "RIGHT", TukuiDB.buttonspacing, 0)
		else
			if db.mainbar_swap == true then
				b:SetPoint("TOPLEFT", ActionButton1, "BOTTOMLEFT", 0, -TukuiDB.buttonspacing)
			else
				b:SetPoint("BOTTOMLEFT", ActionButton1, "TOPLEFT", 0, TukuiDB.buttonspacing)
			end
		end
	else
		b:SetPoint("LEFT", b2, "RIGHT", TukuiDB.buttonspacing, 0)
	end
end

if not db.tukui_default and db.bottomrows == 1 then
	TukuiBar2:Hide()
end