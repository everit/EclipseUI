local db = TukuiCF["actionbar"]

if not db.enable then return end

local TukuiBar3 = CreateFrame("Frame","TukuiBar3",UIParent)
TukuiBar3:SetAllPoints(TukuiActionBarBackground)
MultiBarLeft:SetParent(TukuiBar3)

for i= 1, 12 do
	local b = _G["MultiBarLeftButton"..i]
	local b2 = _G["MultiBarLeftButton"..i-1]
	b:ClearAllPoints()
	b:SetSize(db.buttonsize, db.buttonsize)
	if i == 1 then
		if db.tukui_default == true then
			if db.rightbars > 2 and db.bottomrows == 1 then
				b:SetPoint("TOPLEFT", TukuiActionBarBackgroundRight)
			else
				b:SetPoint("LEFT", MultiBarBottomRightButton12, "RIGHT", db.buttonspacing, 0)
			end
		else
			if db.split_bar == true then
				b:SetPoint("BOTTOMLEFT", TukuiLeftSplitBarBackground)
			else
				b:SetPoint("TOPLEFT", TukuiActionBarBackgroundRight)
			end
		end
	else
		if db.split_bar == true then
			if i == 4 then
				b:SetPoint("BOTTOMLEFT", TukuiRightSplitBarBackground)
			elseif i == 7 then
				b:SetPoint("BOTTOMLEFT", MultiBarLeftButton1, "TOPLEFT", 0, db.buttonspacing)
			elseif i == 10 then
				b:SetPoint("BOTTOMLEFT", MultiBarLeftButton4, "TOPLEFT", 0, db.buttonspacing)
			else
				b:SetPoint("LEFT", b2, "RIGHT", db.buttonspacing, 0)
			end
		else
			if db.vertical_rightbars == true then
				b:SetPoint("TOP", b2, "BOTTOM", 0, -db.buttonspacing)
			else
				b:SetPoint("LEFT", b2, "RIGHT", db.buttonspacing, 0)
			end
		end
	end
end

if not db.tukui_default and db.split_bar == true and db.bottomrows == 1 then
	for i = 7, 12 do
		local b = _G["MultiBarLeftButton"..i]
		b:SetAlpha(0)
		b:SetScale(0.0001)
	end
end

if db.tukui_default == true and db.bottomrows == 1 and db.rightbars < 3 then
	TukuiBar3:Hide()
end