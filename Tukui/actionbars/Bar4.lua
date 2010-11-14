local db = TukuiCF["actionbar"]

if not db.enable then return end

local TukuiBar4 = CreateFrame("Frame", "TukuiBar4", UIParent)
TukuiBar4:SetAllPoints(TukuiActionBarBackground)
MultiBarRight:SetParent(TukuiBar4)
TukuiBar4:Hide()

for i = 1, 12 do
	local b = _G["MultiBarRightButton"..i]
	local b2 = _G["MultiBarRightButton"..i-1]
	b:SetSize(db.buttonsize, db.buttonsize)
	b:ClearAllPoints()
	
	if i == 1 then
		if db.vertical_rightbars == true then
			b:SetPoint("TOPRIGHT", TukuiActionBarBackgroundRight)
		else
			b:SetPoint("BOTTOMLEFT", TukuiActionBarBackgroundRight)
		end
	else
		if db.vertical_rightbars == true then
			b:SetPoint("TOP", b2, "BOTTOM", 0, -db.buttonspacing)
		else
			b:SetPoint("LEFT", b2, "RIGHT", db.buttonspacing, 0)
		end
	end	
end
