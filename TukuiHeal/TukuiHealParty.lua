local db = TukuiCF["unitframes"]

if not db.enable then return end

----- [[     Local Variables     ]] -----

local ecUI = ecUI
local font = TukuiCF["fonts"].unitframe_font
local font_size = TukuiCF["fonts"].unitframe_font_size
local font_style = TukuiCF["fonts"].unitframe_font_style
local font_shadow = TukuiCF["fonts"].unitframe_font_shadow
local font_position = TukuiCF["fonts"].unitframe_y_position

local texture = TukuiCF["customise"].texture


----- [[     Layout     ]] -----

local function Shared(self, unit)
	self.colors = TukuiDB.oUF_colors
	
	self:RegisterForClicks("AnyUp")
	self:SetScript('OnEnter', UnitFrame_OnEnter)
	self:SetScript('OnLeave', UnitFrame_OnLeave)
	
	self.menu = TukuiDB.SpawnMenu
	
	
	----- [[     Health / Power Bars + Backgrounds / Borders     ]] -----
	
	local health = CreateFrame("StatusBar", nil, self)
	health:SetPoint("TOPLEFT", TukuiDB.mult, -TukuiDB.mult)
	health:SetPoint("TOPRIGHT", -TukuiDB.mult, TukuiDB.mult)
	if unit:find("partypet") then
		health:SetHeight(20)
	else
		health:SetHeight(30)
	end
	health:SetStatusBarTexture(texture)
	self.Health = health

	if db.healthvertical == true then
		health:SetOrientation('VERTICAL')
	end

	local hBg = health:CreateTexture(nil, "BORDER")
	hBg:SetAllPoints()
	hBg:SetTexture(unpack(db.health_bg_color))
	self.Health.bg = hBg

	local hBorder = CreateFrame("Frame", nil, health)
	hBorder:SetFrameLevel(health:GetFrameLevel() - 1)
	hBorder:SetAllPoints()
	ecUI.CreateOuterBorder(hBorder)
	self.Health.border = hBorder		

	local power = CreateFrame("StatusBar", nil, self)
	power:SetPoint("TOPLEFT", health, "BOTTOMLEFT", 0, TukuiDB.Scale(-3))
	power:SetPoint("TOPRIGHT", health, "BOTTOMRIGHT", 0, TukuiDB.Scale(-3))
	if unit:find("partypet") then
		power:SetHeight(0)
	else
		power:SetHeight(4)
	end
	power:SetStatusBarTexture(texture)
	self.Power = power

	local pBg = power:CreateTexture(nil, "BORDER")
	pBg:SetAllPoints()
	pBg:SetTexture(texture)
	pBg.multiplier = 0.3
	self.Power.bg = pBg

	local pBorder = CreateFrame("Frame", nil, power)
	pBorder:SetFrameLevel(power:GetFrameLevel() - 1)
	pBorder:SetAllPoints()
	ecUI.CreateOuterBorder(pBorder)
	self.Power.border = pBorder

	local frame = CreateFrame("Frame", nil, health)
	frame:SetFrameLevel(health:GetFrameLevel() - 1)
	frame:SetPoint("TOPLEFT", health, TukuiDB.Scale(-2), TukuiDB.Scale(2))
	frame:SetPoint("BOTTOMRIGHT", power, TukuiDB.Scale(2), TukuiDB.Scale(-2))
	frame:SetBackdrop({
		bgFile = texture,
		insets = { left = -TukuiDB.mult, right = -TukuiDB.mult, top = -TukuiDB.mult, bottom = -TukuiDB.mult }
	})
	frame:SetBackdropColor(unpack(TukuiCF["media"].bordercolor))
	ecUI.CreateOuterBorder(frame)
	TukuiDB.CreateShadow(frame)
	self.frame = frame			
	
	
	----- [[     Health and Power Colors / Settings     ]] -----
	
	health.frequentUpdates = true
	power.frequentUpdates = true

	if db.showsmooth == true then
		health.Smooth = true
		power.Smooth = true
	end

	if db.classcolor == true then
		health.colorTapping = true
		health.colorDisconnected = true
		health.colorReaction = true
		health.colorClass = true
		
		power.colorPower = true
	else
		health.colorTapping = false
		health.colorDisconnected = false
		health.colorClass = false
		health.colorReaction = false
		health:SetStatusBarColor(unpack(db.health_color))

		power.colorTapping = true
		power.colorDisconnected = true
		power.colorClass = true
		power.colorReaction = true
	end


	----- [[     Unit Name     ]] -----
	
	local Name = health:CreateFontString(nil, "OVERLAY")
	if unit:find("partypet") then
		Name:SetPoint("CENTER", health, "CENTER", 0, 1)
	else
		Name:SetPoint("CENTER", health, "CENTER", 0, 0)
	end
	Name:SetJustifyH("CENTER")
	Name:SetFont(font, font_size, font_style)
	Name:SetShadowOffset(font_shadow and 1 or 0, font_shadow and -1 or 0)
	Name.frequentUpdates = 0.2
	if db.classcolor == true then
		self:Tag(Name, "[Tukui:name_short][Tukui:dead][Tukui:afk]")
	else
		self:Tag(Name, "[Tukui:getnamecolor][Tukui:name_short][Tukui:dead][Tukui:afk]")
	end
	self.Name = Name
	
	
	----- [[     Leader Icon     ]] -----
	
    local leader = health:CreateTexture(nil, "OVERLAY")
    leader:SetHeight(TukuiDB.Scale(12))
    leader:SetWidth(TukuiDB.Scale(12))
    leader:SetPoint("TOPLEFT", 0, 6)
	self.Leader = leader
	
	
	----- [[     LFD Role Icon     ]] -----
	
    local LFDRole = health:CreateTexture(nil, "OVERLAY")
    LFDRole:SetHeight(TukuiDB.Scale(6))
    LFDRole:SetWidth(TukuiDB.Scale(6))
	LFDRole:SetPoint("TOPRIGHT", TukuiDB.Scale(-2), TukuiDB.Scale(-2))
	LFDRole:SetTexture("Interface\\AddOns\\Tukui\\media\\textures\\lfdicons.blp")
	self.LFDRole = LFDRole
	
	
	----- [[     Masterlooter Icon     ]] -----
	
    local MasterLooter = health:CreateTexture(nil, "OVERLAY")
    MasterLooter:SetHeight(TukuiDB.Scale(12))
    MasterLooter:SetWidth(TukuiDB.Scale(12))
	self.MasterLooter = MasterLooter
    self:RegisterEvent("PARTY_LEADER_CHANGED", TukuiDB.MLAnchorUpdate)
    self:RegisterEvent("PARTY_MEMBERS_CHANGED", TukuiDB.MLAnchorUpdate)
	
	
	----- [[     Aggro     ]] -----
	
	if TukuiCF["unitframes"].aggro == true then
		table.insert(self.__elements, TukuiDB.UpdateThreat)
		self:RegisterEvent('PLAYER_TARGET_CHANGED', TukuiDB.UpdateThreat)
		self:RegisterEvent('UNIT_THREAT_LIST_UPDATE', TukuiDB.UpdateThreat)
		self:RegisterEvent('UNIT_THREAT_SITUATION_UPDATE', TukuiDB.UpdateThreat)
    end
	
	
	----- [[     Raid Icons     ]] -----
	
	if TukuiCF["unitframes"].showsymbols == true then
		local RaidIcon = health:CreateTexture(nil, 'OVERLAY')
		RaidIcon:SetHeight(TukuiDB.Scale(18))
		RaidIcon:SetWidth(TukuiDB.Scale(18))
		RaidIcon:SetPoint('CENTER', self, 'TOP')
		RaidIcon:SetTexture("Interface\\AddOns\\Tukui\\media\\textures\\raidicons.blp") -- thx hankthetank for texture
		self.RaidIcon = RaidIcon
	end
	
	
	----- [[     Readycheck Icon     ]] -----
	
	local ReadyCheck = self.Power:CreateTexture(nil, "OVERLAY")
	ReadyCheck:SetHeight(TukuiDB.Scale(12))
	ReadyCheck:SetWidth(TukuiDB.Scale(12))
	ReadyCheck:SetPoint('CENTER')
	self.ReadyCheck = ReadyCheck
	

	----- [[     Debuff Highlight     ]] -----
	
	self.DebuffHighlightAlpha = 1
	self.DebuffHighlightBackdrop = true
	self.DebuffHighlightFilter = true
	
	--local picon = self.Health:CreateTexture(nil, 'OVERLAY')
	--picon:SetPoint('CENTER', self.Health)
	--picon:SetSize(16, 16)
	--picon:SetTexture[[Interface\AddOns\Tukui\media\textures\picon]]
	--picon.Override = TukuiDB.Phasing
	--self.PhaseIcon = picon
	
	if db.showrange == true then
		local range = {insideAlpha = 1, outsideAlpha = TukuiCF["unitframes"].raidalphaoor}
		self.Range = range
	end
	
	if db.showsmooth == true then
		health.Smooth = true
		power.Smooth = true
	end
	
	if db.healcomm == true then
		local mhpb = CreateFrame('StatusBar', nil, self.Health)
		mhpb:SetStatusBarTexture(texture)
		mhpb:SetStatusBarColor(0, 1, 0.5, 0.25)
		mhpb:SetFrameLevel(health:GetFrameLevel())
		
		local ohpb = CreateFrame('StatusBar', nil, self.Health)
		ohpb:SetStatusBarTexture(texture)
		ohpb:SetStatusBarColor(0, 1, 0, 0.25)
		ohpb:SetFrameLevel(health:GetFrameLevel())
		
		if db.healthvertical == true then
			mhpb:SetPoint('BOTTOMLEFT', self.Health:GetStatusBarTexture(), 'TOPLEFT', 0, 0)
			mhpb:SetPoint('BOTTOMRIGHT', self.Health:GetStatusBarTexture(), 'TOPRIGHT', 0, 0)

			ohpb:SetPoint('BOTTOMLEFT', mhpb:GetStatusBarTexture(), 'TOPLEFT', 0, 0)
			ohpb:SetPoint('BOTTOMRIGHT', mhpb:GetStatusBarTexture(), 'TOPRIGHT', 0, 0)
			
			mhpb:SetHeight(health:GetHeight())
			ohpb:SetHeight(health:GetHeight())

			ohpb:SetOrientation('VERTICAL')
			mhpb:SetOrientation('VERTICAL')
		
		else
			mhpb:SetPoint('TOPLEFT', self.Health:GetStatusBarTexture(), 'TOPRIGHT', 0, 0)
			mhpb:SetPoint('BOTTOMLEFT', self.Health:GetStatusBarTexture(), 'BOTTOMRIGHT', 0, 0)

			ohpb:SetPoint('TOPLEFT', mhpb:GetStatusBarTexture(), 'TOPRIGHT', 0, 0)
			ohpb:SetPoint('BOTTOMLEFT', mhpb:GetStatusBarTexture(), 'BOTTOMRIGHT', 0, 0)
			
			mhpb:SetWidth(150)
			ohpb:SetWidth(150)

			ohpb:SetOrientation('HORIZONTAL')
			mhpb:SetOrientation('HORIZONTAL')
		end

		self.HealPrediction = {
			myBar = mhpb,
			otherBar = ohpb,
			maxOverflow = 1,
		}
	end
	
	
	
	if TukuiCF["unitframes"].raidunitdebuffwatch == true then
		-- AuraWatch (corner icon)
		TukuiDB.createAuraWatch(self, unit)
		
		-- Raid Debuffs (big middle icon)
		local RaidDebuffs = CreateFrame('Frame', nil, self)
		RaidDebuffs:SetHeight(TukuiDB.Scale(22))
		RaidDebuffs:SetWidth(TukuiDB.Scale(22))
		RaidDebuffs:SetPoint('CENTER', health, "CENTER", 0, 0)
		RaidDebuffs:SetFrameStrata(health:GetFrameStrata())
		RaidDebuffs:SetFrameLevel(health:GetFrameLevel() + 2)
		
		TukuiDB.SetTemplate(RaidDebuffs)
		
		RaidDebuffs.icon = RaidDebuffs:CreateTexture(nil, 'OVERLAY')
		RaidDebuffs.icon:SetTexCoord(.1,.9,.1,.9)
		RaidDebuffs.icon:SetPoint("TOPLEFT", TukuiDB.Scale(2), TukuiDB.Scale(-2))
		RaidDebuffs.icon:SetPoint("BOTTOMRIGHT", TukuiDB.Scale(-2), TukuiDB.Scale(2))
		
		-- just in case someone want to add this feature, uncomment to enable it
		--[[
		if TukuiCF["unitframes"].auratimer then
			RaidDebuffs.cd = CreateFrame('Cooldown', nil, RaidDebuffs)
			RaidDebuffs.cd:SetPoint("TOPLEFT", TukuiDB.Scale(2), TukuiDB.Scale(-2))
			RaidDebuffs.cd:SetPoint("BOTTOMRIGHT", TukuiDB.Scale(-2), TukuiDB.Scale(2))
			RaidDebuffs.cd.noOCC = true -- remove this line if you want cooldown number on it
		end
		--]]
		
		RaidDebuffs.count = RaidDebuffs:CreateFontString(nil, 'OVERLAY')
		RaidDebuffs.count:SetFont(font, 12, font_style)
		RaidDebuffs.count:SetPoint('BOTTOMRIGHT', RaidDebuffs, 'BOTTOMRIGHT', 0, 2)
		RaidDebuffs.count:SetTextColor(1, .9, 0)
		
		self.RaidDebuffs = RaidDebuffs
    end
	
	return self
end

oUF:RegisterStyle('TukuiHealParty', Shared)
oUF:Factory(function(self)
	oUF:SetActiveStyle("TukuiHealParty")

	local party = self:SpawnHeader("oUF_TukuiHealParty", nil, "solo,party", 
	'oUF-initialConfigFunction', [[
		local header = self:GetParent()
		self:SetWidth(header:GetAttribute('initial-width'))
		self:SetHeight(header:GetAttribute('initial-height'))
	]],
	"initial-width", 70,
	"initial-height", 41,	
	"showParty", true, 
	-- "showSolo", true, 
	"showPlayer", db.showplayerinparty, 
	"groupFilter", "1,2,3,4,5,6,7,8", 
	"groupingOrder", "1,2,3,4,5,6,7,8", 
	"groupBy", "GROUP", 
	"xOffset", 5,
	"point", "LEFT"
	)
	party:SetPoint("TOP", UIParent, "BOTTOM", 0, TukuiDB.Scale(230))
	
	local pets = {}
	for i = 1, 5 do 
		pets[i] = oUF:Spawn('partypet'..i, 'oUF_TukuiPartyPet'..i) 
		pets[i]:SetSize((TukuiCF["panels"].tinfowidth / 5) - 4.3, 21)
		if i == 1 then
			if db.showplayerinparty == true then
				pets[i]:SetPoint('BOTTOMLEFT', party, 'TOPLEFT', (TukuiCF["panels"].tinfowidth / 5) - 4.3 + 5, 6)
			else
				pets[i]:SetPoint('BOTTOMLEFT', party, 'TOPLEFT', 0, 6)
			end
		else
			pets[i]:SetPoint('TOPLEFT', pets[i-1], 'TOPRIGHT', 3, 0)
		end
	end
	
	local PetsFuckOffSeriously = CreateFrame("Frame")
	PetsFuckOffSeriously:RegisterEvent("PLAYER_ENTERING_WORLD")
	PetsFuckOffSeriously:RegisterEvent("RAID_ROSTER_UPDATE")
	PetsFuckOffSeriously:RegisterEvent("PARTY_LEADER_CHANGED")
	PetsFuckOffSeriously:RegisterEvent("PARTY_MEMBERS_CHANGED")
	PetsFuckOffSeriously:SetScript("OnEvent", function(self)
		if InCombatLockdown() then
			self:RegisterEvent("PLAYER_REGEN_ENABLED")
		else
			self:UnregisterEvent("PLAYER_REGEN_ENABLED")
			local numraid = GetNumRaidMembers()
			if numraid > 5  then
				for i,v in ipairs(pets) do v:Disable() end
			else
				for i,v in ipairs(pets) do v:Enable() end
			end
		end
	end)
end)