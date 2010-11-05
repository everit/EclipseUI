----- [[     Setup Datatext Coloring     ]] -----

if TukuiCF["datatext"].classcolor == true then
	local _,class = UnitClass("player")
	local r, g, b = unpack(oUF.colors.class[class])
	cStart = ("|cff%.2x%.2x%.2x"):format(r * 255, g * 255, b * 255)
else
	local r, g, b = unpack(TukuiCF["datatext"].color)
	cStart = ("|cff%.2x%.2x%.2x"):format(r * 255, g * 255, b * 255)
end
cEnd = "|r"


----- [[     Datatext Panel Positions     ]] -----

function TukuiDB.PP(p, obj)
	local left = TukuiDataLeft
	local right = TukuiDataRight
	
	if p == 1 then
		obj:SetHeight(left:GetHeight())
		obj:SetPoint("LEFT", left, TukuiDB.Scale(20), 0)
		obj:SetPoint('TOP', left)
		obj:SetPoint('BOTTOM', left, 0, TukuiDB.Scale(1))
	elseif p == 2 then
		obj:SetHeight(left:GetHeight())
		obj:SetPoint('TOP', left)
		obj:SetPoint('BOTTOM', left, 0, TukuiDB.Scale(1))
	elseif p == 3 then
		obj:SetHeight(left:GetHeight())
		obj:SetPoint("RIGHT", left, TukuiDB.Scale(-20), 0)
		obj:SetPoint('TOP', left)
		obj:SetPoint('BOTTOM', left, 0, TukuiDB.Scale(1))
	elseif p == 4 then
		obj:SetHeight(right:GetHeight())
		obj:SetPoint("LEFT", right, TukuiDB.Scale(20), 0)
		obj:SetPoint('TOP', right)
		obj:SetPoint('BOTTOM', right, 0, TukuiDB.Scale(1))
	elseif p == 5 then
		obj:SetHeight(right:GetHeight())
		obj:SetPoint('TOP', right)
		obj:SetPoint('BOTTOM', right, 0, TukuiDB.Scale(1))
	elseif p == 6 then
		obj:SetHeight(right:GetHeight())
		obj:SetPoint("RIGHT", right, TukuiDB.Scale(-20), 0)
		obj:SetPoint('TOP', right)
		obj:SetPoint('BOTTOM', right, 0, TukuiDB.Scale(1))
	end
end
