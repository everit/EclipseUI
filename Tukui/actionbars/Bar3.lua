local db = TukuiCF["actionbar"]

if not db.enable then return end

local TukuiBar3 = CreateFrame("Frame", "TukuiBar3", UIParent)
TukuiBar3:SetAllPoints(TukuiActionBarBackground)
MultiBarLeft:SetParent(TukuiBar3)
TukuiBar3:Hide()

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