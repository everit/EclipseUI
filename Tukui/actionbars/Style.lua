local db = TukuiCF["actionbar"]

if not db.enable then return end

local font, font_size, font_style, font_shadow = TukuiCF["fonts"].actionbar_font, TukuiCF["fonts"].actionbar_font_size, TukuiCF["fonts"].actionbar_font_style, TukuiCF["fonts"].actionbar_font_shadow
local font_count_pos, font_hotkey_pos, font_macro_pos = TukuiCF["fonts"].actionbar_count_xy_position, TukuiCF["fonts"].actionbar_hotkey_xy_position, TukuiCF["fonts"].actionbar_macro_xy_position

local _G = _G
local media = TukuiCF["media"]
local securehandler = CreateFrame("Frame", nil, nil, "SecureHandlerBaseTemplate")
local replace = string.gsub

function style(self)
	local name = self:GetName()
	
	--> fixing a taint issue while changing totem flyout button in combat.
	if name:match("MultiCastActionButton") then return end 
	
	local action = self.action
	local Button = self
	local Icon = _G[name.."Icon"]
	local Count = _G[name.."Count"]
	local Flash	 = _G[name.."Flash"]
	local HotKey = _G[name.."HotKey"]
	local Border  = _G[name.."Border"]
	local Btname = _G[name.."Name"]
	local normal  = _G[name.."NormalTexture"]
 
	Flash:SetTexture("")
	Button:SetNormalTexture("")
 
	Border:Hide()
	Border = TukuiDB.dummy
 
	Count:ClearAllPoints()
	Count:SetPoint("BOTTOMRIGHT", font_count_pos[1], font_count_pos[2])
	Count:SetFont(font, font_size, font_style)
	Count:SetShadowOffset(font_shadow and 1 or 0, font_shadow and -1 or 0)

	Btname:ClearAllPoints()
	Btname:SetPoint("BOTTOM", font_macro_pos[1], font_macro_pos[2])
	Btname:SetFont(font, font_size, font_style)
	Btname:SetWidth(db.buttonsize)
	Btname:SetShadowOffset(font_shadow and 1 or 0, font_shadow and -1 or 0)
 
	if not _G[name.."Panel"] then
		-- resize all button not matching TukuiDB.buttonsize
		if self:GetHeight() ~= db.buttonsize then
			self:SetSize(db.buttonsize, db.buttonsize)
		end

		-- create the bg/border panel
		local panel = CreateFrame("Frame", name.."Panel", self)
		TukuiDB.CreateFadedPanel(panel, db.buttonsize, db.buttonsize, "CENTER", self, "CENTER", 0, 0)
 
		panel:SetFrameStrata(self:GetFrameStrata())
		panel:SetFrameLevel(self:GetFrameLevel() - 1)
 
		Icon:SetTexCoord(.09, .91, .09, .91)
		Icon:SetPoint("TOPLEFT", Button, TukuiDB.Scale(2), TukuiDB.Scale(-2))
		Icon:SetPoint("BOTTOMRIGHT", Button, TukuiDB.Scale(-2), TukuiDB.Scale(2))
	end

	HotKey:ClearAllPoints()
	HotKey:SetPoint("TOPRIGHT", font_hotkey_pos[1], font_hotkey_pos[2])
	HotKey:SetFont(font, font_size, font_style)
	HotKey:SetShadowOffset(font_shadow and 1 or 0, font_shadow and -1 or 0)
	HotKey.ClearAllPoints = TukuiDB.dummy
	HotKey.SetPoint = TukuiDB.dummy
 
	if not db.hotkey then
		HotKey:SetText("")
		HotKey:Hide()
		HotKey.Show = TukuiDB.dummy
	end
 
	if normal then
		normal:ClearAllPoints()
		normal:SetPoint("TOPLEFT")
		normal:SetPoint("BOTTOMRIGHT")
	end
end

local function stylesmallbutton(normal, button, icon, name, pet)
	local Flash	 = _G[name.."Flash"]
	button:SetNormalTexture("")
	
	-- another bug fix reported by Affli in t12 beta
	button.SetNormalTexture = TukuiDB.dummy
	
	Flash:SetTexture(media.buttonhover)
	
	if not _G[name.."Panel"] then
		if pet then
			button:SetSize(db.petbuttonsize, db.petbuttonsize)
			
			local panel = CreateFrame("Frame", name.."Panel", button)
			TukuiDB.CreateFadedPanel(panel, db.petbuttonsize, db.petbuttonsize, "CENTER", button, "CENTER", 0, 0)
			panel:SetFrameStrata(button:GetFrameStrata())
			panel:SetFrameLevel(button:GetFrameLevel() - 1)

			-- let's kill auto-castable triangles instead
			TukuiDB.Kill(_G[name.."AutoCastable"])

			local shine = _G[name.."Shine"] -- fix stupid auto-cast shine around pet buttons
			shine:SetSize(TukuiDB.Scale(db.petbuttonsize), TukuiDB.Scale(db.petbuttonsize))
		else
			button:SetSize(db.stancebuttonsize, db.stancebuttonsize)
			
			local panel = CreateFrame("Frame", name.."Panel", button)
			TukuiDB.CreateFadedPanel(panel, db.stancebuttonsize, db.stancebuttonsize, "CENTER", button, "CENTER", 0, 0)
			panel:SetFrameStrata(button:GetFrameStrata())
			panel:SetFrameLevel(button:GetFrameLevel() - 1)
		end
		
		icon:SetTexCoord(.09, .91, .09, .91)
		icon:ClearAllPoints()
		icon:SetPoint("TOPLEFT", button, TukuiDB.Scale(2), TukuiDB.Scale(-2))
		icon:SetPoint("BOTTOMRIGHT", button, TukuiDB.Scale(-2), TukuiDB.Scale(2))
	end
	
	normal:ClearAllPoints()
	normal:SetPoint("TOPLEFT")
	normal:SetPoint("BOTTOMRIGHT")
end

function TukuiDB.StyleShift()
	for i=1, NUM_SHAPESHIFT_SLOTS do
		local name = "ShapeshiftButton"..i
		local button  = _G[name]
		local icon  = _G[name.."Icon"]
		local normal  = _G[name.."NormalTexture"]
		stylesmallbutton(normal, button, icon, name)
		
		if GetNumShapeshiftForms() > 1 then
			local _, _, isActive, _ = GetShapeshiftFormInfo(i)

			if isActive then
				SetDesaturation(icon, nil)
			else
				SetDesaturation(icon, 1)
			end
		end
		
		button:SetCheckedTexture(nil)
	end
end

function TukuiDB.TukuiShiftBarUpdate()
	local numForms = GetNumShapeshiftForms()
	local texture, name, isActive, isCastable
	local button, icon, cooldown
	local start, duration, enable
	for i = 1, NUM_SHAPESHIFT_SLOTS do
		button = _G["ShapeshiftButton"..i]
		icon = _G["ShapeshiftButton"..i.."Icon"]
		if i <= numForms then
			texture, name, isActive, isCastable = GetShapeshiftFormInfo(i)
			icon:SetTexture(texture)
			
			cooldown = _G["ShapeshiftButton"..i.."Cooldown"]
			if texture then
				cooldown:SetAlpha(1)
			else
				cooldown:SetAlpha(0)
			end
			
			start, duration, enable = GetShapeshiftFormCooldown(i)
			CooldownFrame_SetTimer(cooldown, start, duration, enable)
			
			if GetNumShapeshiftForms() > 1 then
				if isActive then
					SetDesaturation(icon, nil)
				else
					SetDesaturation(icon, 1)
				end
			end

			if isActive then
				ShapeshiftBarFrame.lastSelected = button:GetID()
				button:SetChecked(1)
			else
				button:SetChecked(0)
			end

			if isCastable then
				icon:SetVertexColor(1.0, 1.0, 1.0)
			else
				icon:SetVertexColor(0.4, 0.4, 0.4)
			end
		end
	end
end

function TukuiDB.StylePet()
	for i=1, NUM_PET_ACTION_SLOTS do
		local name = "PetActionButton"..i
		local button  = _G[name]
		local icon  = _G[name.."Icon"]
		local normal  = _G[name.."NormalTexture2"]
		stylesmallbutton(normal, button, icon, name, true)
	end
end

function TukuiDB.TukuiPetBarUpdate(self, event)
	local petActionButton, petActionIcon, petAutoCastableTexture, petAutoCastShine
	for i=1, NUM_PET_ACTION_SLOTS, 1 do
		local buttonName = "PetActionButton" .. i
		petActionButton = _G[buttonName]
		petActionIcon = _G[buttonName.."Icon"]
		petAutoCastableTexture = _G[buttonName.."AutoCastable"]
		petAutoCastShine = _G[buttonName.."Shine"]
		local name, subtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(i)
		
		if not isToken then
			petActionIcon:SetTexture(texture)
			petActionButton.tooltipName = name
		else
			petActionIcon:SetTexture(_G[texture])
			petActionButton.tooltipName = _G[name]
		end
		
		petActionButton.isToken = isToken
		petActionButton.tooltipSubtext = subtext

		if isActive and name ~= "PET_ACTION_FOLLOW" then
			petActionButton:SetChecked(1)
			if IsPetAttackAction(i) then
				PetActionButton_StartFlash(petActionButton)
			end
		else
			petActionButton:SetChecked(0)
			if IsPetAttackAction(i) then
				PetActionButton_StopFlash(petActionButton)
			end			
		end
		
		if autoCastAllowed then
			petAutoCastableTexture:Show()
		else
			petAutoCastableTexture:Hide()
		end
		
		if autoCastEnabled then
			AutoCastShine_AutoCastStart(petAutoCastShine)
		else
			AutoCastShine_AutoCastStop(petAutoCastShine)
		end
		
		-- grid display
		if name then
			if not db.showgrid then
				petActionButton:SetAlpha(1)
			end			
		else
			if not db.showgrid then
				petActionButton:SetAlpha(0)
			end
		end
		
		if texture then
			if GetPetActionSlotUsable(i) then
				SetDesaturation(petActionIcon, nil)
			else
				SetDesaturation(petActionIcon, 1)
			end
			petActionIcon:Show()
		else
			petActionIcon:Hide()
		end
		
		-- between level 1 and 10 on cata, we don't have any control on Pet. (I lol'ed so hard)
		-- Setting desaturation on button to true until you learn the control on class trainer.
		-- you can at least control "follow" button.
		if not PetHasActionBar() and texture and name ~= "PET_ACTION_FOLLOW" then
			PetActionButton_StopFlash(petActionButton)
			SetDesaturation(petActionIcon, 1)
			petActionButton:SetChecked(0)
		end
	end
end


local function updatehotkey(self, actionButtonType)
	local hotkey = _G[self:GetName() .. 'HotKey']
	local text = hotkey:GetText()
	
	text = replace(text, '(s%-)', 'S')
	text = replace(text, '(a%-)', 'A')
	text = replace(text, '(c%-)', 'C')
	text = replace(text, '(Mouse Button )', 'M')
	text = replace(text, '(Middle Mouse)', 'M3')
	text = replace(text, '(Num Pad )', 'N')
	text = replace(text, '(Page Up)', 'PU')
	text = replace(text, '(Page Down)', 'PD')
	text = replace(text, '(Spacebar)', 'SpB')
	text = replace(text, '(Insert)', 'Ins')
	text = replace(text, '(Home)', 'Hm')
	text = replace(text, '(Delete)', 'Del')
	
	if hotkey:GetText() == _G['RANGE_INDICATOR'] then
		hotkey:SetText('')
	else
		hotkey:SetText(text)
	end
	
	hotkey:ClearAllPoints()
	hotkey:SetPoint("TOPRIGHT", TukuiDB.Scale(-1), 0)
	hotkey:SetFont(font, font_size, font_style)
	hotkey:SetShadowOffset(font_shadow and 1 or 0, font_shadow and -1 or 0)
 
	if not db.hotkey then
		hotkey:SetText("")
		hotkey:Hide()
		hotkey.Show = TukuiDB.dummy
	end
end

-- rescale cooldown spiral to fix texture.
local buttonNames = { "ActionButton",  "MultiBarBottomLeftButton", "MultiBarBottomRightButton", "MultiBarLeftButton", "MultiBarRightButton", "ShapeshiftButton", "PetActionButton"}
for _, name in ipairs( buttonNames ) do
	for index = 1, 12 do
		local buttonName = name .. tostring(index)
		local button = _G[buttonName]
		local cooldown = _G[buttonName .. "Cooldown"]
 
		if ( button == nil or cooldown == nil ) then
			break
		end
		
		cooldown:ClearAllPoints()
		cooldown:SetPoint("TOPLEFT", button, "TOPLEFT", 2, -2)
		cooldown:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 2)
	end
end

local buttons = 0
local function SetupFlyoutButton()
	for i=1, buttons do
		--prevent error if you don't have max ammount of buttons
		if _G["SpellFlyoutButton"..i] then
			style(_G["SpellFlyoutButton"..i])
			TukuiDB.StyleButton(_G["SpellFlyoutButton"..i], true)
		end
	end
end
SpellFlyout:HookScript("OnShow", SetupFlyoutButton)

-- Reposition flyout buttons depending on what tukui bar the button is parented to
local function FlyoutButtonPos(self, buttons, direction)
	for i=1, buttons do
		local parent = SpellFlyout:GetParent()
		if not _G["SpellFlyoutButton"..i] then return end
		
		if InCombatLockdown() then return end
 
		if direction == "LEFT" then
			if i == 1 then
				_G["SpellFlyoutButton"..i]:ClearAllPoints()
				_G["SpellFlyoutButton"..i]:SetPoint("RIGHT", parent, "LEFT", -4, 0)
			else
				_G["SpellFlyoutButton"..i]:ClearAllPoints()
				_G["SpellFlyoutButton"..i]:SetPoint("RIGHT", _G["SpellFlyoutButton"..i-1], "LEFT", -4, 0)
			end
		else
			if i == 1 then
				_G["SpellFlyoutButton"..i]:ClearAllPoints()
				_G["SpellFlyoutButton"..i]:SetPoint("BOTTOM", parent, "TOP", 0, 4)
			else
				_G["SpellFlyoutButton"..i]:ClearAllPoints()
				_G["SpellFlyoutButton"..i]:SetPoint("BOTTOM", _G["SpellFlyoutButton"..i-1], "TOP", 0, 4)
			end
		end
	end
end
 
--Hide the Mouseover texture and attempt to find the ammount of buttons to be skinned
local function styleflyout(self)
	self.FlyoutBorder:SetAlpha(0)
	self.FlyoutBorderShadow:SetAlpha(0)
	
	SpellFlyoutHorizontalBackground:SetAlpha(0)
	SpellFlyoutVerticalBackground:SetAlpha(0)
	SpellFlyoutBackgroundEnd:SetAlpha(0)
	
	for i=1, GetNumFlyouts() do
		local x = GetFlyoutID(i)
		local _, _, numSlots, isKnown = GetFlyoutInfo(x)
		if isKnown then
			buttons = numSlots
			break
		end
	end
	
	--Change arrow direction depending on what bar the button is on
	local arrowDistance
	if ((SpellFlyout and SpellFlyout:IsShown() and SpellFlyout:GetParent() == self) or GetMouseFocus() == self) then
			arrowDistance = 5
	else
			arrowDistance = 2
	end
	
	if (self:GetParent() == MultiBarBottomRight) then
		self.FlyoutArrow:ClearAllPoints()
		self.FlyoutArrow:SetPoint("LEFT", self, "LEFT", -arrowDistance, 0)
		SetClampedTextureRotation(self.FlyoutArrow, 270)
		FlyoutButtonPos(self,buttons,"LEFT")
	elseif (self:GetParent() == MultiBarLeft and not TukuiDB.lowversion) then
		self.FlyoutArrow:ClearAllPoints()
		self.FlyoutArrow:SetPoint("TOP", self, "TOP", 0, arrowDistance)
		SetClampedTextureRotation(self.FlyoutArrow, 0)
		FlyoutButtonPos(self,buttons,"UP")	
	elseif not self:GetParent():GetParent() == "SpellBookSpellIconsFrame" then
		FlyoutButtonPos(self,buttons,"UP")
	end
end


function TukuiDB.StyleButton(b, checked) 
    local name = b:GetName() 
    local button          = _G[name]

	local hover = b:CreateTexture("frame", nil, self)
	hover:SetTexture(1, 1, 1, 0.3)
	hover:SetSize(button:GetWidth(), button:GetHeight())
	hover:SetPoint("TOPLEFT", button, 2, -2)
	hover:SetPoint("BOTTOMRIGHT", button, -2, 2)
	button:SetHighlightTexture(hover)

	local pushed = b:CreateTexture("frame", nil, self)
	pushed:SetTexture(0.9, 0.8, 0.1, 0.3)
		pushed:SetSize(button:GetWidth(), button:GetHeight())
	pushed:SetPoint("TOPLEFT", button, 2, -2)
	pushed:SetPoint("BOTTOMRIGHT", button, -2, 2)
	button:SetPushedTexture(pushed)
 
	if checked then
		local checked = b:CreateTexture("frame", nil, self)
		checked:SetTexture(1, 1, 1, 0.3)
		checked:SetSize(button:GetWidth(), button:GetHeight())
		checked:SetPoint("TOPLEFT", button, 2, -2)
		checked:SetPoint("BOTTOMRIGHT", button, -2, 2)
		button:SetCheckedTexture(checked)
	end
end


do
	for i = 1, 12 do
		TukuiDB.StyleButton(_G["ActionButton"..i], true)
		TukuiDB.StyleButton(_G["MultiBarBottomLeftButton"..i], true)
		TukuiDB.StyleButton(_G["MultiBarBottomRightButton"..i], true)
		TukuiDB.StyleButton(_G["MultiBarLeftButton"..i], true)
		TukuiDB.StyleButton(_G["MultiBarRightButton"..i], true)
	end

	for i=1, 10 do
		TukuiDB.StyleButton(_G["ShapeshiftButton"..i], true)
		TukuiDB.StyleButton(_G["PetActionButton"..i], true)
	end
end

hooksecurefunc("ActionButton_Update", style)
hooksecurefunc("ActionButton_UpdateHotkeys", updatehotkey)
hooksecurefunc("ActionButton_UpdateFlyout", styleflyout)
