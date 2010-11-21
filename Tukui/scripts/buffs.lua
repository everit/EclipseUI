local font, font_size, font_style, font_shadow, font_count_pos, font_duration_pos = TukuiCF["fonts"].aura_font, TukuiCF["fonts"].aura_font_size, TukuiCF["fonts"].aura_font_style, TukuiCF["fonts"].aura_font_shadow, TukuiCF["fonts"].aura_count_xy_position, TukuiCF["fonts"].aura_duration_xy_position

ConsolidatedBuffs:ClearAllPoints()
ConsolidatedBuffs:SetPoint("LEFT", Minimap, "LEFT", TukuiDB.Scale(0), TukuiDB.Scale(0))
ConsolidatedBuffs:SetSize(16, 16)
ConsolidatedBuffsIcon:SetTexture(nil)
ConsolidatedBuffs.SetPoint = TukuiDB.dummy

local rowbuffs = 16

TemporaryEnchantFrame:ClearAllPoints()
TemporaryEnchantFrame:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 0, TukuiDB.Scale(-16))
TemporaryEnchantFrame.SetPoint = TukuiDB.dummy

TempEnchant1:ClearAllPoints()
TempEnchant2:ClearAllPoints()
TempEnchant1:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", TukuiDB.Scale(-8), TukuiDB.Scale(-8))
TempEnchant2:SetPoint("RIGHT", TempEnchant1, "LEFT", TukuiDB.Scale(-3), 0)

WorldStateAlwaysUpFrame:SetFrameStrata("BACKGROUND")
WorldStateAlwaysUpFrame:SetFrameLevel(0)

for i = 1, 3 do
	local f = CreateFrame("Frame", nil, _G["TempEnchant"..i])
	TukuiDB.CreatePanel(f, 30, 30, "CENTER", _G["TempEnchant"..i], "CENTER", 0, 0)	
	_G["TempEnchant"..i.."Border"]:Hide()
	_G["TempEnchant"..i.."Icon"]:SetTexCoord(.09, .91, .09, .91)
	_G["TempEnchant"..i.."Icon"]:SetPoint("TOPLEFT", _G["TempEnchant"..i], TukuiDB.Scale(2), TukuiDB.Scale(-2))
	_G["TempEnchant"..i.."Icon"]:SetPoint("BOTTOMRIGHT", _G["TempEnchant"..i], TukuiDB.Scale(-2), TukuiDB.Scale(2))
	_G["TempEnchant"..i]:SetHeight(TukuiDB.Scale(30))
	_G["TempEnchant"..i]:SetWidth(TukuiDB.Scale(30))	
	_G["TempEnchant"..i.."Duration"]:ClearAllPoints()
	_G["TempEnchant"..i.."Duration"]:SetPoint("BOTTOM", font_duration_pos[1], font_duration_pos[2])
	_G["TempEnchant"..i.."Duration"]:SetFont(font, font_size, font_style)
	_G["TempEnchant"..i.."Duration"]:SetShadowOffset(font_shadow and 1 or 0, font_shadow and -1 or 0)
end

local function StyleBuffs(buttonName, index, debuff)
	local buff		= _G[buttonName..index]
	local icon		= _G[buttonName..index.."Icon"]
	local border	= _G[buttonName..index.."Border"]
	local duration	= _G[buttonName..index.."Duration"]
	local count 	= _G[buttonName..index.."Count"]
	if icon and not _G[buttonName..index.."Panel"] then
		icon:SetTexCoord(.09, .91, .09, .91)
		icon:SetPoint("TOPLEFT", buff, TukuiDB.Scale(2), TukuiDB.Scale(-2))
		icon:SetPoint("BOTTOMRIGHT", buff, TukuiDB.Scale(-2), TukuiDB.Scale(2))
		
		buff:SetHeight(TukuiDB.Scale(30))
		buff:SetWidth(TukuiDB.Scale(30))

		duration:ClearAllPoints()
		duration:SetPoint("BOTTOM", font_duration_pos[1], font_duration_pos[2])
		duration:SetFont(font, font_size, font_style)
		duration:SetShadowOffset(font_shadow and 1 or 0, font_shadow and -1 or 0)
		
		count:ClearAllPoints()
		count:SetPoint("TOPRIGHT", font_count_pos[1], font_count_pos[2])
		count:SetFont(font, font_size, font_style)
		count:SetShadowOffset(font_shadow and 1 or 0, font_shadow and -1 or 0)

		local panel = CreateFrame("Frame", buttonName..index.."Panel", buff)
		TukuiDB.CreatePanel(panel, 30, 30, "CENTER", buff, "CENTER", 0, 0)
		panel:SetFrameLevel(buff:GetFrameLevel() - 1)
		panel:SetFrameStrata(buff:GetFrameStrata())
	end
	if border then border:Hide() end
end

local function UpdateBuffAnchors()
	buttonName = "BuffButton"
	local buff, previousBuff, aboveBuff
	local numBuffs = 0
	for i=1, BUFF_ACTUAL_DISPLAY do
		local buff = _G[buttonName..i]
		StyleBuffs(buttonName, i, false)
		
		-- Leaving this here just in case someone want to use it
		-- This enable buff border coloring according to Type
		-- local dtype = select(5, UnitBuff("player",index))		
		-- local color
		-- if (dtype ~= nil) then
			-- color = DebuffTypeColor[dtype]
		-- else
			-- color = DebuffTypeColor["none"]
		-- end
		-- _G[buttonName..index.."Panel"]:SetBackdropBorderColor(color.r * 0.6, color.g * 0.6, color.b * 0.6)
		
		if ( buff.consolidated ) then
			if ( buff.parent == BuffFrame ) then
				buff:SetParent(ConsolidatedBuffsContainer)
				buff.parent = ConsolidatedBuffsContainer
			end
		else
			numBuffs = numBuffs + 1
			buff:ClearAllPoints()
			if ( (numBuffs > 1) and (mod(numBuffs, rowbuffs) == 1) ) then
				if ( numBuffs == rowbuffs+1 ) then
					buff:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", TukuiDB.Scale(-8), TukuiDB.Scale(-55))
				else
					buff:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", TukuiDB.Scale(-8), TukuiDB.Scale(-103))
				end
				aboveBuff = buff;
			elseif ( numBuffs == 1 ) then
				local mainhand, _, _, offhand, _, _, thrown = GetWeaponEnchantInfo()
				
				if (mainhand and offhand and thrown) and not UnitHasVehicleUI("player") then
					buff:SetPoint("RIGHT", TempEnchant3, "LEFT", TukuiDB.Scale(-3), 0)
				elseif ((mainhand and offhand) or (mainhand and thrown) or (offhand and thrown)) and not UnitHasVehicleUI("player") then
					buff:SetPoint("RIGHT", TempEnchant2, "LEFT", TukuiDB.Scale(-3), 0)
				elseif ((mainhand and not offhand and not thrown) or (offhand and not mainhand and not thrown) or (thrown and not mainhand and not offhand)) and not UnitHasVehicleUI("player") then
					buff:SetPoint("RIGHT", TempEnchant1, "LEFT", TukuiDB.Scale(-3), 0)
				else
					buff:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", TukuiDB.Scale(-8), TukuiDB.Scale(-8))
				end
			else
				buff:SetPoint("RIGHT", previousBuff, "LEFT", TukuiDB.Scale(-3), 0)
			end
			previousBuff = buff
		end		
	end
end

local function UpdateDebuffAnchors(buttonName, index)
	local debuff = _G[buttonName..index];
	StyleBuffs(buttonName, index, true)
	local dtype = select(5, UnitDebuff("player",index))      
	local color
	if (dtype ~= nil) then
		color = DebuffTypeColor[dtype]
	else
		color = DebuffTypeColor["none"]
	end
	_G[buttonName..index.."Panel"]:SetBackdropBorderColor(color.r * 0.6, color.g * 0.6, color.b * 0.6)
	debuff:ClearAllPoints()
	if index == 1 then
		debuff:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", TukuiDB.Scale(-8), TukuiDB.Scale(-103))
	else
		debuff:SetPoint("RIGHT", _G[buttonName..(index-1)], "LEFT", TukuiDB.Scale(-3), 0)
	end
end

SecondsToTimeAbbrev = function(time)
local hr, m, s, text
	if time <= 0 then text = ""
	elseif(time < 3600 and time > 60) then
		hr = floor(time / 3600)
		m = floor(mod(time, 3600) / 60 + 1)
		text = format("%d" .. cStart .. " M", m)
	elseif(time < 60 and time > 10) then
		m = floor(time / 60)
		s = mod(time, 60)
		text = (m == 0 and format("%d", s))
	elseif time < 10 then
		s = mod(time, 60)
		text = (format("|cffce3a19%d", s))
	else
		hr = floor(time / 3600 + 1)
		text = format("%d" .. cStart .. " H", hr)
	end
	text = format("|cffffffff".."%s", text)
	return text
end

hooksecurefunc("BuffFrame_UpdateAllBuffAnchors", UpdateBuffAnchors)
hooksecurefunc("DebuffButton_UpdateAnchors", UpdateDebuffAnchors)