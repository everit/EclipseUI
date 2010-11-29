--[[

	This is temporary until I re-code it.
	
]]--


local barWidth, barHeight = 200, 4
local barTexture = TukuiCF["customise"].texture

local fadeIn = 0.5
local fadeOut = 0.5
local frameFadeIn = 0.2
local frameFadeOut = 0.2

local hideOOC = true
local hideNoEnergy = true
local inCombat = false
local visible = true
local powerType = nil
local unit = "player"
local points = 0


local eComboBar = CreateFrame("Frame", "eComboBar", UIParent)
function eComboBar:createFrame()
	self:SetWidth(barWidth)
	self:SetHeight(barHeight)
	self:SetPoint("CENTER", UIParent, "CENTER", 0, 70)
	
	self.backdrop = CreateFrame("Frame", "eComboBarBackground", self)
	TukuiDB.CreatePanel(self.backdrop, 1, 1, "TOPLEFT", self, "TOPLEFT", 0, 0)
	self.backdrop:SetPoint("TOPLEFT", self, "TOPLEFT", -TukuiDB.Scale(2), TukuiDB.Scale(2))
	self.backdrop:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", TukuiDB.Scale(2), -TukuiDB.Scale(2))
	
	self.comboWidth = ((self:GetWidth() - 4) / 5)
	
	self.CPoints = {}
	local xoff = 0
		for i = 1, 5 do
			self.CPoints[i] = eComboBar:CreateTexture(nil, "BACKGROUND")
			self.CPoints[i]:SetTexture(barTexture)
			self.CPoints[i]:SetPoint("TOPLEFT", self, "TOPLEFT", xoff, 0)
			self.CPoints[i]:SetPoint("BOTTOMRIGHT", self, "BOTTOMLEFT", xoff + self.comboWidth, 0)
			xoff = xoff + self.comboWidth + TukuiDB.Scale(1)
			self.CPoints[i]:SetAlpha(0)
	end			
	self.CPoints[1]:SetVertexColor(0.69, 0.31, 0.31)		
	self.CPoints[2]:SetVertexColor(0.69, 0.31, 0.31)
	self.CPoints[3]:SetVertexColor(0.65, 0.63, 0.35)
	self.CPoints[4]:SetVertexColor(0.65, 0.63, 0.35)
	self.CPoints[5]:SetVertexColor(0.33, 0.59, 0.33)

	self:RegisterEvent("PLAYER_LOGIN")
	self:RegisterEvent("UNIT_DISPLAYPOWER")
	self:RegisterEvent("UNIT_COMBO_POINTS")
	self:RegisterEvent("PLAYER_TARGET_CHANGED")
	if hideOOC then
		self:RegisterEvent("PLAYER_REGEN_DISABLED")
		self:RegisterEvent("PLAYER_REGEN_ENABLED")
	end
	self:RegisterEvent("UNIT_ENTERED_VEHICLE")
	self:RegisterEvent("UNIT_EXITED_VEHICLE")

	self:SetScript("OnEvent", self.event)
end

function eComboBar:toggleCombo()
	if not hideOOC and not hideNoEnergy then
		return
	end

	if hideNoEnergy then
		if powerType == SPELL_POWER_ENERGY then
			if hideOOC then
				if not visible and points > 0 then
					UIFrameFadeIn(self, frameFadeIn)
					visible = true
				end
			elseif not visible and points > 0 then
				UIFrameFadeIn(self, frameFadeIn)
				visible = true
			end
		else
			if visible then
				UIFrameFadeOut(self, frameFadeOut)
				visible = false
			end
			return
		end
	end
end

function eComboBar:updateCombo()
	local pt = GetComboPoints(unit)
	if pt == points then
		self:toggleCombo()
		return
	end
	
	if pt > points then
		for i = points + 1, pt do
			UIFrameFadeIn(self.CPoints[i], fadeIn)
		end
	else
		for i = pt + 1, points do
			UIFrameFadeOut(self.CPoints[i], fadeOut)
			UIFrameFadeOut(self, frameFadeOut)
			visible = false
		end
	end
	
	points = pt
	
	self:toggleCombo()
end

function eComboBar:event(event, ...)
	if event == "PLAYER_LOGIN" then
		if powerType ~= nil then return end

		powerType, _ = UnitPowerType("player")
		if UnitHasVehicleUI("player") then
			local powervehicle, _ = UnitPowerType("vehicle")
			if powervehicle == SPELL_POWER_ENERGY then
				unit = "vehicle"
				powerType = powervehicle
			end
		end

		if hideOOC or (hideNoEnergy and powerType ~= SPELL_POWER_ENERGY) then
			visible = false
			self:SetAlpha(0)
		end
	elseif event == "UNIT_COMBO_POINTS" then
		local curunit = select(1, ...)
		if curunit ~= unit then return end
		
		self:updateCombo()
	elseif event == "PLAYER_TARGET_CHANGED" then
		self:updateCombo()
	elseif event == "PLAYER_REGEN_DISABLED" then
		incombat = true

		self:toggleCombo()
	elseif event == "PLAYER_REGEN_ENABLED" then
		incombat = false

		self:toggleCombo()
	elseif event == "UNIT_DISPLAYPOWER" then
		local curunit = select(1, ...)
		if curunit ~= unit then return end
		
		powerType, _ = UnitPowerType(unit)

		self:toggleCombo()
	elseif event == "UNIT_ENTERED_VEHICLE" then
		local curunit = select(1, ...)
		if curunit ~= "player" then return end

		local powervehicle, _ = UnitPowerType("vehicle")
		if powervehicle == SPELL_POWER_ENERGY then
			unit = "vehicle"
			points = 0
			powerType = powervehicle

			self:toggleCombo()
		end
	elseif event == "UNIT_EXITED_VEHICLE" then
		local curunit = select(1, ...)
		if curunit ~= "player" then return end

		unit = "player"
		points = 0
		powerType, _ = UnitPowerType(unit)

		self:toggleCombo()
	end
end

eComboBar:createFrame()


------------------------------------------------------------
-- /command
------------------------------------------------------------

-- local combomover = CreateFrame("Frame", nil, UIParent)
-- combomover:SetAllPoints(eComboBarBackground)
-- TukuiDB.SkinPanel(combomover)
-- combomover:SetAlpha(0)
-- eComboBar:SetMovable(true)
-- eComboBar:SetUserPlaced(true)
-- local move = false
-- local function movecombo()
	-- if move == false then
		-- move = true
		-- combomover:SetAlpha(1)
		-- eComboBar:EnableMouse(true)
		-- eComboBar:RegisterForDrag("LeftButton", "RightButton")
		-- eComboBar:SetScript("OnDragStart", function(self) self:StartMoving() end)
		-- eComboBar:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
	-- elseif move == true then
		-- move = false
		-- combomover:SetAlpha(0)
		-- eComboBar:EnableMouse(false)
	-- end
-- end
-- SLASH_MOVECOMBO1 = "/cp"
-- SlashCmdList["MOVECOMBO"] = movecombo
