local db = TukuiCF["actionbar"]

if not db.enable then return end

local TukuiBar5 = CreateFrame("Frame", "TukuiBar5", UIParent) 
TukuiBar5:SetAllPoints(TukuiActionBarBackground)
MultiBarBottomRight:SetParent(TukuiBar5)
TukuiBar5:Hide()

for i = 1, 12 do
	local b = _G["MultiBarBottomRightButton"..i]
	local b2 = _G["MultiBarBottomRightButton"..i-1]
	b:SetSize(db.buttonsize, db.buttonsize)
	b:ClearAllPoints()
	
	if i == 1 then
		if db.vertical_rightbars == true then
			b:SetPoint("TOPRIGHT", _G["MultiBarRightButton1"], "TOPLEFT", -3, 0)
		else
			b:SetPoint("BOTTOMLEFT", _G["MultiBarRightButton1"], "TOPLEFT", 0, 3)
		end
	else
		if db.vertical_rightbars == true then
			b:SetPoint("TOP", b2, "BOTTOM", 0, -db.buttonspacing)
		else
			b:SetPoint("LEFT", b2, "RIGHT", db.buttonspacing, 0)
		end
	end
end
