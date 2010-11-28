----- [[     Textures     ]] -----

local eciUI = ecUI
local mult = TukuiDB.mult
local scale = TukuiDB.Scale

local db = TukuiCF["media"]
local texture = TukuiCF["customise"].texture

----- [[     Textures     ]] -----

local textures = {
	normbg = {
		bgFile = texture,
		edgeFile = db.blank,
		tile = false,
		tileSize = 0,
		edgeSize = mult,
		insets = { left = -mult, right = -mult, top = -mult, bottom = -mult }
	},
	
	-- don't touch this texture
	template_fadebg = {
		bgFile = db.blank,
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
	
	overlay = texture,		
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

function ecUI.CreateOverlay(f)
	if f.bg then return end
	f.bg = f:CreateTexture(f:GetName() and f:GetName().."_overlay" or nil, "BORDER", f)
	f.bg:ClearAllPoints()
	f.bg:SetPoint("TOPLEFT", mult, -mult)
	f.bg:SetPoint("BOTTOMRIGHT", -mult, mult)
	f.bg:SetTexture(textures.overlay)
	f.bg:SetVertexColor(.05, .05, .05, 1)
end

function ecUI.CreateInnerBorder(f)
	if f.iborder then return end
	f.iborder = CreateFrame("Frame", "_iborder", f)
	f.iborder:SetPoint("TOPLEFT", mult, -mult)
	f.iborder:SetPoint("BOTTOMRIGHT", -mult, mult)
	f.iborder:SetBackdrop(textures.border)
	f.iborder:SetBackdropBorderColor(unpack(db.backdropcolor))
end

function ecUI.CreateOuterBorder(f)
	if f.oborder then return end
	f.oborder = CreateFrame("Frame", "_oborder", f)
	f.oborder:SetPoint("TOPLEFT", -mult, mult)
	f.oborder:SetPoint("BOTTOMRIGHT", mult, -mult)
	f.oborder:SetFrameLevel(f:GetFrameLevel() + 1)
	f.oborder:SetBackdrop(textures.border)
	f.oborder:SetBackdropBorderColor(unpack(db.backdropcolor))
end


----- [[     Create Panel Skins     ]] -----

function ecUI.SkinPanel(f)
	f:SetBackdrop(textures.normbg)
	f:SetBackdropColor(unpack(db.backdropcolor))
	f:SetBackdropBorderColor(unpack(db.bordercolor))
	
	ecUI.CreateOverlay(f)
	TukuiDB.CreateShadow(f)
end

function ecUI.SkinFadedPanel(f)
	f:SetBackdrop(textures.template_fadebg)
	f:SetBackdropColor(unpack(db.fadedbackdropcolor))
	f:SetBackdropBorderColor(unpack(db.bordercolor))

	ecUI.CreateInnerBorder(f)
	ecUI.CreateOuterBorder(f)
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
	
	ecUI.SkinPanel(f)
end

function TukuiDB.CreateFadedPanel(f, w, h, a1, p, a2, x, y)
	sh = scale(h)
	sw = scale(w)	
	f:SetFrameLevel(1)
	f:SetHeight(sh)
	f:SetWidth(sw)
	f:SetFrameStrata("BACKGROUND")
	f:SetPoint(a1, p, a2, x, y)
	
	ecUI.SkinFadedPanel(f)
end

function TukuiDB.SetTemplate(f)
	f:SetBackdrop(textures.template_fadebg)
	f:SetBackdropColor(unpack(db.backdropcolor))
	f:SetBackdropBorderColor(unpack(db.bordercolor))
end


----- [[     Fade In / Out Functions     ]] -----

function ecUI.FadeIn(f)
	UIFrameFadeIn(f, .4, f:GetAlpha(), 1)
end
	
function ecUI.FadeOut(f)
	UIFrameFadeOut(f, .8, f:GetAlpha(), 0)
end


----- [[     Setup Text Coloring     ]] -----

function ecUI.Color(f, red, green, blue)
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


----- [[     Setup Button Border Coloring     ]] -----

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
