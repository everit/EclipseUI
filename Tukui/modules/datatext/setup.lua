local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

if C["datatext"].classcolor then
	local color = RAID_CLASS_COLORS[TukuiDB.myclass]
	T.cStart = ("|cff%.2x%.2x%.2x"):format(color.r * 255, color.g * 255, color.b * 255)
else
	local r, g, b = unpack(C["datatext"].color)
	T.cStart = ("|cff%.2x%.2x%.2x"):format(r * 255, g * 255, b * 255)
end
T.cEnd = "|r"


T.PP = function(p, obj)
	local TukuiInfoLeft = TukuiInfoLeft
	local TukuiInfoRight = TukuiInfoRight
	
	if p == 1 then
		obj:SetParent(TukuiInfoLeft)
		obj:Height(TukuiInfoLeft:GetHeight())
		obj:Point("LEFT", TukuiInfoLeft, 20, 1)
	elseif p == 2 then
		obj:SetParent(TukuiInfoLeft)
		obj:Height(TukuiInfoLeft:GetHeight())
		obj:Point("CENTER", TukuiInfoLeft, 0, 1)
	elseif p == 3 then
		obj:SetParent(TukuiInfoLeft)
		obj:Height(TukuiInfoLeft:GetHeight())
		obj:Point("RIGHT", TukuiInfoLeft, -20, 1)
	elseif p == 4 then
		obj:SetParent(TukuiInfoRight)
		obj:Height(TukuiInfoRight:GetHeight())
		obj:Point("LEFT", TukuiInfoRight, 20, 1)
	elseif p == 5 then
		obj:SetParent(TukuiInfoRight)
		obj:Height(TukuiInfoRight:GetHeight())
		obj:Point("CENTER", TukuiInfoRight, 0, 1)
	elseif p == 6 then
		obj:SetParent(TukuiInfoRight)
		obj:Height(TukuiInfoRight:GetHeight())
		obj:Point("RIGHT", TukuiInfoRight, -20, 1)
	end
end
