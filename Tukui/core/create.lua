local mult = TukuiDB.mult
local scale = TukuiDB.Scale

local db = TukuiCF["media"]
local texture = TukuiCF["customise"].texture

local Textures = {
	Normal = {
		bgFile = texture,
		edgeFile = db.blank,
		tile = false,
		tileSize = 0,
		edgeSize = mult,
		insets = { left = -mult, right = -mult, top = -mult, bottom = -mult }
	},
	
	Shadow = {
		edgeFile = db.glowTex, 
		edgeSize = 3,
		insets = { left = mult, right = mult, top = mult, bottom = mult }
	},
	
	Border = {
		edgeFile = db.blank, 
		edgeSize = mult, 
		insets = { left = mult, right = mult, top = mult, bottom = mult }
	},

	Blank = {
		bgFile = db.blank,
		edgeFile = db.blank,
		tile = false,
		tileSize = 0,
		edgeSize = mult,
		insets = { left = -mult, right = -mult, top = -mult, bottom = -mult }
	},
}

function TukuiDB.CreateShadow(f)
	if f.shadow then return end
	local shadow = CreateFrame("Frame", f:GetName() and f:GetName() .. "Shadow" or nil, f)
	shadow:SetFrameLevel(0)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:SetPoint("TOPLEFT", scale(-3), scale(3))
	shadow:SetPoint("BOTTOMRIGHT", scale(3), scale(-3))
	shadow:SetBackdrop(Textures.Shadow)
	shadow:SetBackdropColor(0, 0, 0, 0)
	shadow:SetBackdropBorderColor(0, 0, 0, .75)
	f.shadow = shadow
end

function TukuiDB.CreateOverlay(f)
	if f.overlay then return end
	local overlay = f:CreateTexture(f:GetName() and f:GetName().."Overlay" or nil, "BORDER", f)
	overlay:ClearAllPoints()
	overlay:SetPoint("TOPLEFT", mult, -mult)
	overlay:SetPoint("BOTTOMRIGHT", -mult, mult)
	overlay:SetTexture(texture)
	overlay:SetVertexColor(.05, .05, .05)
	f.overlay = overlay
end

function TukuiDB.CreateBorder(f, inner, outer)
	if inner then
		if f.iborder then return end
		local border = CreateFrame("Frame", f:GetName() and f:GetName() .. "InnerBorder" or nil, f)
		border:SetPoint("TOPLEFT", mult, -mult)
		border:SetPoint("BOTTOMRIGHT", -mult, mult)
		border:SetBackdrop(Textures.Border)
		border:SetBackdropBorderColor(unpack(db.backdropcolor))
		f.iborder = border
	end
	
	if outer then
		if f.oborder then return end
		local border = CreateFrame("Frame", f:GetName() and f:GetName() .. "OuterBorder" or nil, f)
		border:SetPoint("TOPLEFT", -mult, mult)
		border:SetPoint("BOTTOMRIGHT", mult, -mult)
		border:SetFrameLevel(f:GetFrameLevel() + 1)
		border:SetBackdrop(Textures.Border)
		border:SetBackdropBorderColor(unpack(db.backdropcolor))
		f.oborder = border
	end
end


----- [[     Create Panels     ]] -----

function TukuiDB.CreatePanel(f, w, h, a1, p, a2, x, y)
	f:SetSize(scale(w), scale(h))
	f:SetFrameLevel(1)
	f:SetFrameStrata("BACKGROUND")
	f:SetPoint(a1, p, a2, x, y)
	
	f:SetBackdrop(Textures.Normal)
	f:SetBackdropColor(unpack(db.backdropcolor))
	f:SetBackdropBorderColor(unpack(db.bordercolor))
end

function TukuiDB.CreateUltimate(f, fade, w, h, a1, p, a2, x, y)
	f:SetSize(scale(w), scale(h))
	f:SetFrameLevel(1)
	f:SetFrameStrata("BACKGROUND")
	
	if a1 then
		f:SetPoint(a1, p, a2, x, y)
	end
	
	TukuiDB.CreateShadow(f)
	
	if fade then
		TukuiDB.CreateBorder(f, true, true)
		
		f:SetBackdrop(Textures.Blank)
		f:SetBackdropColor(unpack(db.fadedbackdropcolor))
		f:SetBackdropBorderColor(unpack(db.bordercolor))
	else
		TukuiDB.CreateOverlay(f)
		
		f:SetBackdrop(Textures.Normal)
		f:SetBackdropColor(unpack(db.backdropcolor))
		f:SetBackdropBorderColor(unpack(db.bordercolor))
	end
end

function TukuiDB.SetTemplate(f)
	f:SetBackdrop(Textures.Blank)
	f:SetBackdropColor(unpack(db.backdropcolor))
	f:SetBackdropBorderColor(unpack(db.bordercolor))
end

function TukuiDB.FadeIn(f)
	UIFrameFadeIn(f, .4, f:GetAlpha(), 1)
end
	
function TukuiDB.FadeOut(f)
	UIFrameFadeOut(f, .8, f:GetAlpha(), 0)
end

function TukuiDB.Color(f, red, green, blue)
	if red then
		f:SetTextColor(.9, .3, .3)
	elseif green then
		f:SetTextColor(.3, .9, .3)
	elseif blue then
		f:SetTextColor(.3, .3, .9)	
	else
		if TukuiCF["datatext"].classcolor == true then
			local color = RAID_CLASS_COLORS[TukuiDB.myclass]
			f:SetTextColor(color.r, color.g, color.b)
			
			cStart = ("|cff%.2x%.2x%.2x"):format(color.r * 255, color.g * 255, color.b * 255)
		else
			local r, g, b = unpack(TukuiCF["datatext"].color)
			f:SetTextColor(r, g, b)
			
			cStart = ("|cff%.2x%.2x%.2x"):format(r * 255, g * 255, b * 255)
		end
	end
end
cEnd = "|r"

function TukuiDB.SetModifiedBackdrop(f)
	if TukuiCF["datatext"].classcolor == true then
		local color = RAID_CLASS_COLORS[TukuiDB.myclass]
		f:SetBackdropBorderColor(color.r, color.g, color.b)
	else
		local r, g, b = unpack(TukuiCF["datatext"].color)
		f:SetBackdropBorderColor(r, g, b)	
	end
end

function TukuiDB.SetOriginalBackdrop(f)
	f:SetBackdropBorderColor(unpack(TukuiCF["media"].bordercolor))
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