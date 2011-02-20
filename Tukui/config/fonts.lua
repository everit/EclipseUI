local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

-- font template used for fallback values if incorrect or no values are entered
-- don't change this, unless you know what you're doing
local fontTemplate = {
	family = C["media"].font,
	size = 12,
	style = "NONE", -- "THINOUTLINE" / "OUTLINE" / "MONOCHROMEOUTLINE"
	point = "CENTER",
	xOff = 0,
	yOff = 0
}

-- fallback font function
local function Font(family, size, style, point, xOff, yOff)
	local result = {
		setfont = {
			family or fontTemplate.family,
			size or fontTemplate.size,
			style or fontTemplate.style
		},
		setoffsets = {
			point or fontTemplate.point,
			xOff or fontTemplate.xOff,
			yOff or fontTemplate.yOff
		}
	}
	return result;
end


T.Fonts = {
	--[[ how to use:
		 
		 1. you only need to change the values you need to change, other values can be left as "nil"
		 for example if you only needed to change the font size and style on the aHotkey table;
		 
		 aHotkey = Font(nil, 14, "THINOUTLINE", nil, nil, nil)
		 
		 that's how you would write it; because you are using default values from the fallback table
	]]--
	
	-- actionbars
	aHotkey = Font(C["media"].pixel_font, nil, "MONOCHROMEOUTLINE", "TOPRIGHT", nil, -1), -- hotkey
	aCount = Font(C["media"].pixel_font, nil, "MONOCHROMEOUTLINE", "BOTTOMRIGHT", -1, 1), -- count
	
	-- bags
	baCount = Font(C["media"].pixel_font, nil, "MONOCHROMEOUTLINE", "BOTTOMRIGHT", -1, 1), -- count
	baGeneral = Font(C["media"].pixel_font, nil, "MONOCHROMEOUTLINE", nil, nil, nil),
	
	-- mirror bar
	miGeneral = Font(C["media"].pixel_font, nil, "MONOCHROMEOUTLINE", nil, nil, nil),
	
	-- buffs
	bDuration = Font(C["media"].pixel_font, nil, "MONOCHROMEOUTLINE", "BOTTOM", 1, -14), -- duration
	bCount = Font(C["media"].pixel_font, nil, "MONOCHROMEOUTLINE", "TOPLEFT", 3, 1), -- count
	
	-- chat
	cTab = Font(C["media"].pixel_font, nil, "MONOCHROMEOUTLINE", nil, nil, nil), -- chat tab
	cGeneral = Font(C["media"].caith, 11, nil, nil, nil, nil), -- chat window
	
	-- datatext
	dFont = Font(C["media"].pixel_font, nil, "MONOCHROMEOUTLINE", nil, nil, nil),
	
	-- loot
	lGeneral = Font(C["media"].caith, 11, "OUTLINE", nil, nil, nil),
	
	-- map
	mTitle = Font(C["media"].caith, 22, "OUTLINE", nil, nil, nil), -- region name
	mGeneral = Font(C["media"].caith, 22, "OUTLINE", nil, nil, nil), -- show quest/digsite
	mArea = Font(C["media"].caith, 22*3, "OUTLINE", nil, nil, nil), -- hover over
	
	-- nameplates
	nGeneral = Font(C["media"].pixel_font, 12, "MONOCHROMEOUTLINE", nil, nil, nil),
	
	-- tooltip
	tGeneral = Font(C["media"].caith, 11, "OUTLINE", nil, nil, nil),
	
	-- unitframes - don't try and anchor these yet
	uHealth = Font(C["media"].pixel_font, nil, "MONOCHROMEOUTLINE", nil, nil, nil), -- unit health
	uPower = Font(C["media"].pixel_font, nil, "MONOCHROMEOUTLINE", nil, nil, nil), -- unit power
	uName = Font(C["media"].pixel_font, nil, "MONOCHROMEOUTLINE", nil, nil, nil), -- unit name
	
	uGeneral = Font(C["media"].pixel_font, nil, "MONOCHROMEOUTLINE", nil, nil, nil), -- castbar, pvp, etc
	uCombat = Font(C["media"].caith, 14, nil, nil, nil, nil), -- combat feedback

	-- miscellaneous
	altPowerBar = Font(C["media"].pixel_font, nil, "MONOCHROMEOUTLINE", nil, 0, 1),
	lootRollFrame = Font(C["media"].pixel_font, nil, "MONOCHROMEOUTLINE", nil, nil, nil),
}