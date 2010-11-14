local db = TukuiCF["unitframes"]

if not db.enable then return end

----- [[     Local Variables     ]] -----

local font, font_size, font_style, font_shadow, font_position = TukuiCF["fonts"].unitframe_font, TukuiCF["fonts"].unitframe_font_size, TukuiCF["fonts"].unitframe_font_style, TukuiCF["fonts"].unitframe_font_shadow, TukuiCF["fonts"].unitframe_y_position


local texture = TukuiCF["general"].game_texture


----- [[     Layout     ]] -----

local function Shared(self, unit)
	self.colors = TukuiDB.oUF_colors
	
	self:RegisterForClicks("LeftButtonDown", "RightButtonDown")
	self:SetScript('OnEnter', UnitFrame_OnEnter)
	self:SetScript('OnLeave', UnitFrame_OnLeave)
	
	self.menu = TukuiDB.SpawnMenu
	
	
	----- [[     Health Bars + Backgrounds / Borders     ]] -----
	
	local health = CreateFrame("StatusBar", nil, self)
	health:SetPoint("TOPLEFT", TukuiDB.mult, -TukuiDB.mult)
	health:SetPoint("BOTTOMRIGHT", -TukuiDB.mult, TukuiDB.mult)
	health:SetStatusBarTexture(texture)
	self.Health = health

	local hBg = health:CreateTexture(nil, "BORDER")
	hBg:SetAllPoints()
	hBg:SetTexture(.05, .05, .05)
	self.Health.bg = hBg

	local hBorder = CreateFrame("Frame", nil, health)
	hBorder:SetFrameLevel(health:GetFrameLevel() - 1)
	hBorder:SetPoint("TOPLEFT", TukuiDB.Scale(-2), TukuiDB.Scale(2))
	hBorder:SetPoint("BOTTOMRIGHT", TukuiDB.Scale(2), TukuiDB.Scale(-2))
	TukuiDB.SkinPanel(hBorder)
	TukuiDB.Kill(hBorder.bg)
	self.Health.border = hBorder		

	----- [[     Health Colors / Settings     ]] -----
	
	health.frequentUpdates = true

	if db.showsmooth == true then
		health.Smooth = true
	end

	if db.classcolor == true then
		health.colorTapping = true
		health.colorDisconnected = true
		health.colorReaction = true
		health.colorClass = true
		hBg.multiplier = 0.3
	else
		health.colorTapping = false
		health.colorDisconnected = false
		health.colorClass = false
		health.colorReaction = false
		health:SetStatusBarColor(unpack(db.health_color))
		hBg:SetVertexColor(unpack(db.health_bg_color))
	end


	----- [[     Unit Name     ]] -----
	
	local Name = health:CreateFontString(nil, "OVERLAY")
	Name:SetPoint("CENTER", health, "CENTER", 0, 1)
	Name:SetJustifyH("CENTER")
	Name:SetFont(font, font_size, font_style)
	Name:SetShadowOffset(font_shadow and 1 or 0, font_shadow and -1 or 0)
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
	
	local ReadyCheck = health:CreateTexture(nil, "OVERLAY")
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

	return self
end

oUF:RegisterStyle('TukuiDpsParty', Shared)
oUF:Factory(function(self)
	oUF:SetActiveStyle("TukuiDpsParty")

	local party = self:SpawnHeader("oUF_TukuiDpsParty", nil, "solo,party", 
	'oUF-initialConfigFunction', [[
		local header = self:GetParent()
		self:SetWidth(header:GetAttribute('initial-width'))
		self:SetHeight(header:GetAttribute('initial-height'))
	]],
	"initial-width", (TukuiCF["panels"].tinfowidth / 5) - 4.3,
	"initial-height", 24,	
	"showParty", true, 
	"showSolo", true, --TukuiCF["unitframes"].show_solomode,
	"showPlayer", db.showplayerinparty, 
	"groupFilter", "1,2,3,4,5,6,7,8", 
	"groupingOrder", "1,2,3,4,5,6,7,8", 
	"groupBy", "GROUP", 
	"xOffset", 5,
	"point", "LEFT"
	)
	party:SetPoint("BOTTOMLEFT", TukuiChatLeftTabs, "TOPLEFT", 1, 4)
end)