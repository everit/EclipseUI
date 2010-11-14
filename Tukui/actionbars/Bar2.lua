local db = TukuiCF["actionbar"]

if not db.enable then return end

local TukuiBar2 = CreateFrame("Frame", "TukuiBar2", UIParent)
TukuiBar2:SetAllPoints(TukuiActionBarBackground)
MultiBarBottomLeft:SetParent(TukuiBar2)
TukuiBar2:Hide()

for i = 1, 12 do
	local b = _G["MultiBarBottomLeftButton"..i]
	local b2 = _G["MultiBarBottomLeftButton"..i-1]
	b:SetSize(db.buttonsize, db.buttonsize)
	b:ClearAllPoints()
	
	if i == 1 then
		b:SetPoint("BOTTOM", ActionButton1, "TOP", 0, db.buttonspacing)
	else
		b:SetPoint("LEFT", b2, "RIGHT", db.buttonspacing, 0)
	end
end