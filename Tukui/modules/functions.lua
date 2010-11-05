function TukuiDB.UIScale()
	-- the tukui high reso whitelist
	if not (TukuiDB.getscreenresolution == "1680x945"
		or TukuiDB.getscreenresolution == "2560x1440" 
		or TukuiDB.getscreenresolution == "1680x1050" 
		or TukuiDB.getscreenresolution == "1920x1080" 
		or TukuiDB.getscreenresolution == "1920x1200" 
		or TukuiDB.getscreenresolution == "1600x900" 
		or TukuiDB.getscreenresolution == "2048x1152" 
		or TukuiDB.getscreenresolution == "1776x1000" 
		or TukuiDB.getscreenresolution == "2560x1600" 
		or TukuiDB.getscreenresolution == "1600x1200") then
			if TukuiCF["general"].overridelowtohigh == true then
				TukuiCF["general"].autoscale = false
				TukuiDB.lowversion = false
			else
				TukuiDB.lowversion = true
			end			
	end

	if TukuiCF["general"].autoscale == true then
		-- i'm putting a autoscale feature mainly for an easy auto install process
		-- we all know that it's not very effective to play via 1024x768 on an 0.64 uiscale :P
		-- with this feature on, it should auto choose a very good value for your current reso!
		TukuiCF["general"].uiscale = min(2, max(.64, 768/string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)")))
	end
end
TukuiDB.UIScale()

-- pixel perfect script of custom ui scale.
local mult = 768/string.match(GetCVar("gxResolution"), "%d+x(%d+)")/TukuiCF["general"].uiscale
local function scale(x)
    return mult*math.floor(x/mult+.5)
end

function TukuiDB.Scale(x) return scale(x) end
TukuiDB.mult = mult


----- [[     Textures     ]] -----

local media = TukuiCF["media"]

local textures = {
	normbg = {
		bgFile = TukuiCF["general"].game_texture,
		edgeFile = media.blank,
		tile = false,
		tileSize = 0,
		edgeSize = mult,
		insets = { left = -mult, right = -mult, top = -mult, bottom = -mult }
	},
	
	fadebg = {
		bgFile = media.blank, -- no we keep this as blank or it looks terrible
		edgeFile = media.blank,
		tile = false,
		tileSize = 0,
		edgeSize = mult,
		insets = { left = -mult, right = -mult, top = -mult, bottom = -mult }
	},

	shadowbg = {
		edgeFile = media.glowTex, 
		edgeSize = 3,
		insets = { left = mult, right = mult, top = mult, bottom = mult }
	},
	
	border = {
		edgeFile = media.blank, 
		edgeSize = mult, 
		insets = { left = mult, right = mult, top = mult, bottom = mult }
	},
	
	overlay = TukuiCF["general"].game_texture,		
}


----- [[     Create Panel Styles     ]] -----

function TukuiDB.CreateShadow(f)
	if f.shadow then return end
	f.shadow = CreateFrame("Frame", nil, f)
	f.shadow:SetFrameLevel(0)
	f.shadow:SetFrameStrata(f:GetFrameStrata())
	f.shadow:SetPoint("TOPLEFT", -3, 3)
	f.shadow:SetPoint("BOTTOMRIGHT", 3, -3)
	f.shadow:SetBackdrop(textures.shadowbg)
	f.shadow:SetBackdropColor(0, 0, 0, 0)
	f.shadow:SetBackdropBorderColor(0, 0, 0, .75)
	return f.shadow
end

function TukuiDB.CreateOverlay(f)
	if f.bg then return end
	f.bg = f:CreateTexture(f:GetName() and f:GetName().."_overlay" or nil, "BORDER", f)
	f.bg:ClearAllPoints()
	f.bg:SetPoint("TOPLEFT", mult, -mult)
	f.bg:SetPoint("BOTTOMRIGHT", -mult, mult)
	f.bg:SetTexture(textures.overlay)
	f.bg:SetVertexColor(0.075, 0.075, 0.075)
	return f.bg
end

function TukuiDB.CreateInnerBorder(f)
	if f.iborder then return end
	f.iborder = CreateFrame("Frame", nil, f)
	f.iborder:SetPoint("TOPLEFT", mult, -mult)
	f.iborder:SetPoint("BOTTOMRIGHT", -mult, mult)
	f.iborder:SetBackdrop(textures.border)
	f.iborder:SetBackdropBorderColor(unpack(media.backdropcolor))
	return f.iborder
end

function TukuiDB.CreateOuterBorder(f)
	if f.oborder then return end
	f.oborder = CreateFrame("Frame", nil, f)
	f.oborder:SetPoint("TOPLEFT", -mult, mult)
	f.oborder:SetPoint("BOTTOMRIGHT", mult, -mult)
	f.oborder:SetBackdrop(textures.border)
	f.oborder:SetBackdropBorderColor(unpack(media.backdropcolor))
	return f.oborder
end


----- [[     Create Panel Skins     ]] -----

function TukuiDB.SkinPanel(f)
	f:SetBackdrop(textures.normbg)
	f:SetBackdropColor(unpack(media.backdropcolor))
	f:SetBackdropBorderColor(unpack(media.bordercolor))
	
	TukuiDB.CreateOverlay(f)
	TukuiDB.CreateShadow(f)
end

function TukuiDB.SkinFadedPanel(f)
	f:SetBackdrop(textures.fadebg)
	f:SetBackdropColor(unpack(media.fadedbackdropcolor))
	f:SetBackdropBorderColor(unpack(media.bordercolor))

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
	  bgFile = media.blank, 
	  edgeFile = media.blank, 
	  tile = false, tileSize = 0, edgeSize = mult, 
	  insets = { left = -mult, right = -mult, top = -mult, bottom = -mult}
	})
	f:SetBackdropColor(unpack(media.backdropcolor))
	f:SetBackdropBorderColor(unpack(media.bordercolor))
end

----- [[     Kill Function     ]] -----

function TukuiDB.Kill(object)
	if object.UnregisterAllEvents then
		object:UnregisterAllEvents()
	end
	object.Show = TukuiDB.dummy
	object:Hide()
end