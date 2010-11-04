local db = TukuiCF["actionbar"]

if not db.enable == true then return end

local TukuiBar5 = CreateFrame("Frame","TukuiBar5",UIParent) 
TukuiBar5:SetAllPoints(TukuiActionBarBackground)
MultiBarBottomRight:SetParent(TukuiBar5)

for i= 1, 12 do
	local b = _G["MultiBarBottomRightButton"..i]
	local b2 = _G["MultiBarBottomRightButton"..i-1]
	b:ClearAllPoints()
	b:SetSize(TukuiDB.buttonsize, TukuiDB.buttonsize)
	if i == 1 then
	
		if db.tukui_default == true then
			if db.rightbars > 1 and db.bottomrows == 1 then
				b:SetPoint("TOPLEFT", TukuiActionBarBackgroundRight)
			else
				b:SetPoint("BOTTOM", ActionButton1, "TOP", 0, TukuiDB.buttonspacing)
			end
		else
			if db.split_bar == true or db.rightbars == 2 then
				b:SetPoint("TOPLEFT", TukuiActionBarBackgroundRight)
			else
				if db.vertical_rightbars == true then
					b:SetPoint("TOP", TukuiActionBarBackgroundRight)
				else
					b:SetPoint("LEFT", TukuiActionBarBackgroundRight)
				end
			end
		end
		
	else		
		if db.vertical_rightbars == true then
			b:SetPoint("TOP", b2, "BOTTOM", 0, -TukuiDB.buttonspacing)
		else
			b:SetPoint("LEFT", b2, "RIGHT", TukuiDB.buttonspacing, 0)
		end
	end
end

if (db.tukui_default == true and db.bottomrows == 1 and db.rightbars < 2) or (not db.tukui_default and db.rightbars < 2) then
	TukuiBar5:Hide()
end