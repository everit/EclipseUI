----- [[     Textures     ]] -----

local db = TukuiCF["media"]
local mult = TukuiDB.mult
local scale = TukuiDB.Scale
local g_tex = TukuiCF["general"].game_texture


----- [[     Textures     ]] -----

local textures = {
	normbg = {
		bgFile = g_tex,
		edgeFile = db.blank,
		tile = false,
		tileSize = 0,
		edgeSize = mult,
		insets = { left = -mult, right = -mult, top = -mult, bottom = -mult }
	},
	
	fadebg = {
		bgFile = db.blank, -- no we keep this as blank or it looks terrible
		edgeFile = db.blank,
		tile = false,
		tileSize = 0,
		edgeSize = mult,
		insets = { left = -mult, right = -mult, top = -mult, bottom = -mult }
	},

	shadowbg = {
		edgeFile = db.glowTex, 
		edgeSize = 3,
		insets = { left = mult, right = mult, top = mult, bottom = mult }
	},
	
	border = {
		edgeFile = db.blank, 
		edgeSize = mult, 
		insets = { left = mult, right = mult, top = mult, bottom = mult }
	},
	
	overlay = g_tex,		
}


----- [[     Create Panel Styles     ]] -----

function TukuiDB.CreateShadow(f)
	if f.shadow then return end
	f.shadow = CreateFrame("Frame",  "_shadow", f)
	f.shadow:SetFrameLevel(0)
	f.shadow:SetFrameStrata(f:GetFrameStrata())
	f.shadow:SetPoint("TOPLEFT", scale(-3), scale(3))
	f.shadow:SetPoint("BOTTOMRIGHT", scale(3), scale(-3))
	f.shadow:SetBackdrop(textures.shadowbg)
	f.shadow:SetBackdropColor(0, 0, 0, 0)
	f.shadow:SetBackdropBorderColor(0, 0, 0, .75)
end

function TukuiDB.CreateOverlay(f)
	if f.bg then return end
	f.bg = f:CreateTexture(f:GetName() and f:GetName().."_overlay" or nil, "BORDER", f)
	f.bg:ClearAllPoints()
	f.bg:SetPoint("TOPLEFT", mult, -mult)
	f.bg:SetPoint("BOTTOMRIGHT", -mult, mult)
	f.bg:SetTexture(textures.overlay)
	f.bg:SetVertexColor(.05, .05, .05, 1)
end

function TukuiDB.CreateInnerBorder(f)
	if f.iborder then return end
	f.iborder = CreateFrame("Frame", "_iborder", f)
	f.iborder:SetPoint("TOPLEFT", mult, -mult)
	f.iborder:SetPoint("BOTTOMRIGHT", -mult, mult)
	f.iborder:SetBackdrop(textures.border)
	f.iborder:SetBackdropBorderColor(unpack(db.backdropcolor))
end

function TukuiDB.CreateOuterBorder(f)
	if f.oborder then return end
	f.oborder = CreateFrame("Frame", "_oborder", f)
	f.oborder:SetPoint("TOPLEFT", -mult, mult)
	f.oborder:SetPoint("BOTTOMRIGHT", mult, -mult)
	f.oborder:SetBackdrop(textures.border)
	f.oborder:SetBackdropBorderColor(unpack(db.backdropcolor))
end


----- [[     Create Panel Skins     ]] -----

function TukuiDB.SkinPanel(f)
	f:SetBackdrop(textures.normbg)
	f:SetBackdropColor(unpack(db.backdropcolor))
	f:SetBackdropBorderColor(unpack(db.bordercolor))
	
	TukuiDB.CreateOverlay(f)
	TukuiDB.CreateShadow(f)
end

function TukuiDB.SkinFadedPanel(f)
	f:SetBackdrop(textures.fadebg)
	f:SetBackdropColor(unpack(db.fadedbackdropcolor))
	f:SetBackdropBorderColor(unpack(db.bordercolor))

	TukuiDB.CreateInnerBorder(f)
	TukuiDB.CreateOuterBorder(f)
	TukuiDB.CreateShadow(f)
end


----- [[     Create Panels     ]] -----

function TukuiDB.CreatePanel(f, w, h, a1, p, a2, x, y)
	sh = scale(h)
	sw = scale(w)	
	f:SetFrameLevel(1)
	f:SetHeight(sh)
	f:SetWidth(sw)
	f:SetFrameStrata("BACKGROUND")
	f:SetPoint(a1, p, a2, x, y)
	
	TukuiDB.SkinPanel(f)
end

function TukuiDB.CreateFadedPanel(f, w, h, a1, p, a2, x, y)
	sh = scale(h)
	sw = scale(w)	
	f:SetFrameLevel(1)
	f:SetHeight(sh)
	f:SetWidth(sw)
	f:SetFrameStrata("BACKGROUND")
	f:SetPoint(a1, p, a2, x, y)
	
	TukuiDB.SkinFadedPanel(f)
end

function TukuiDB.SetTemplate(f)
	f:SetBackdrop({
		bgFile = db.blank, 
		edgeFile = db.blank, 
		tile = false, tileSize = 0, edgeSize = mult, 
		insets = { left = -mult, right = -mult, top = -mult, bottom = -mult}
	})
	f:SetBackdropColor(unpack(db.backdropcolor))
	f:SetBackdropBorderColor(unpack(db.bordercolor))
end


----- [[     Fade In / Out Functions     ]] -----

function TukuiDB.FadeIn(f)
	UIFrameFadeIn(f, .4, f:GetAlpha(), 1)
end
	
function TukuiDB.FadeOut(f)
	UIFrameFadeOut(f, .8, f:GetAlpha(), 0)
end
