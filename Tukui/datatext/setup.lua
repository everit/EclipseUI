----- [[     Datatext Panel Positions     ]] -----

local font_position = TukuiCF["fonts"].datatext_xy_position

function TukuiDB.PP(p, obj)
	local left = TukuiDataLeft
	local right = TukuiDataRight
	
	if p == 1 then
		obj:SetHeight(left:GetHeight())
		obj:SetPoint("LEFT", left, TukuiDB.Scale(20), font_position[2])
	elseif p == 2 then
		obj:SetHeight(left:GetHeight())
		obj:SetPoint('CENTER', left, font_position[1], font_position[2])
	elseif p == 3 then
		obj:SetHeight(left:GetHeight())
		obj:SetPoint("RIGHT", left, TukuiDB.Scale(-20), font_position[2])
	elseif p == 4 then
		obj:SetHeight(right:GetHeight())
		obj:SetPoint("LEFT", right, TukuiDB.Scale(20), font_position[2])
	elseif p == 5 then
		obj:SetHeight(right:GetHeight())
		obj:SetPoint('CENTER', right, font_position[1], font_position[2])
	elseif p == 6 then
		obj:SetHeight(right:GetHeight())
		obj:SetPoint("RIGHT", right, TukuiDB.Scale(-20), font_position[2])
	end
end
