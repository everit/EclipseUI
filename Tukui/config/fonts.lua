local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

local font, caith, pixel = C["media"].font, C["media"].caith, C["media"].pixel_font

-- font template used for fallback values if incorrect or no values are entered
-- don't change this, unless you know what you're doing
local fontTemplate = {
	family = font,
	size = 12,
	outline = "NONE", -- "THINOUTLINE" / "OUTLINE" / "MONOCHROMEOUTLINE"
	point = "CENTER",
	xOff = 0,
	yOff = 0
}

-- fallback font function
local function Font(family, size, outline, point, xOff, yOff)
	local result = {
		setfont = {
			family or fontTemplate.family,
			size or fontTemplate.size,
			outline or fontTemplate.outline
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
		 
		1. You only need to change the values you want to change, other values can be left as "nil".
		Font function syntax:
		
		Font(font, size, outline, anchorpoint, x-offset, y-offset)
		
		
		For example if you only needed to change the font size and outline on the aHotkey table...
		 
		aHotkey = Font(nil, 14, "THINOUTLINE", nil, nil, nil)
		 
		...that's how you would write it; because you are using default values from the fallback table.
		 
		Included font alternatives:
		- font
		- pixel
		- caith
	]]--
	
	-- actionbars
	aHotkey = Font(pixel, nil, "MONOCHROMEOUTLINE", "TOPRIGHT", nil, -1), -- hotkey
	aCount = Font(pixel, nil, "MONOCHROMEOUTLINE", "BOTTOMRIGHT", -1, 1), -- count
	
	-- bags
	baCount = Font(pixel, nil, "MONOCHROMEOUTLINE", "BOTTOMRIGHT", -1, 1), -- count
	baGeneral = Font(pixel, nil, "MONOCHROMEOUTLINE", nil, nil, nil),
	
	-- mirror bar
	miGeneral = Font(pixel, nil, "MONOCHROMEOUTLINE", nil, nil, nil),
	
	-- buffs
	bDuration = Font(pixel, nil, "MONOCHROMEOUTLINE", "BOTTOM", 1, -14), -- duration
	bCount = Font(pixel, nil, "MONOCHROMEOUTLINE", "TOPLEFT", 3, 1), -- count
	
	-- chat
	cTab = Font(pixel, nil, "MONOCHROMEOUTLINE", nil, nil, nil), -- chat tab
	cGeneral = Font(caith, 11, nil, nil, nil, nil), -- chat window
	
	-- datatext
	dFont = Font(pixel, nil, "MONOCHROMEOUTLINE", nil, nil, nil),
	
	-- loot
	lGeneral = Font(caith, 11, "OUTLINE", nil, nil, nil),
	
	-- map
	mTitle = Font(caith, 22, "OUTLINE", nil, nil, nil), -- region name
	mGeneral = Font(caith, 22, "OUTLINE", nil, nil, nil), -- show quest/digsite
	mArea = Font(caith, 22*3, "OUTLINE", nil, nil, nil), -- hover over
	
	-- nameplates
	nGeneral = Font(pixel, 12, "MONOCHROMEOUTLINE", nil, nil, nil),
	
	-- tooltip
	tGeneral = Font(caith, 11, "OUTLINE", nil, nil, nil),
	
	-- unitframes - don't try and anchor these yet
	uHealth = Font(pixel, nil, "MONOCHROMEOUTLINE", nil, nil, nil), -- unit health
	uPower = Font(pixel, nil, "MONOCHROMEOUTLINE", nil, nil, nil), -- unit power
	uName = Font(pixel, nil, "MONOCHROMEOUTLINE", nil, nil, nil), -- unit name
	
	uGeneral = Font(pixel, nil, "MONOCHROMEOUTLINE", nil, nil, nil), -- castbar, pvp, etc
	uCombat = Font(caith, 14, nil, nil, nil, nil), -- combat feedback
	uAuras = Font(pixel, nil, "MONOCHROMEOUTLINE", nil, nil, nil),
	
	-- miscellaneous
	altPowerBar = Font(pixel, nil, "MONOCHROMEOUTLINE", nil, 0, 1),
	lootRollFrame = Font(pixel, nil, "MONOCHROMEOUTLINE", nil, nil, nil),
	cooldown = Font(pixel, nil, "MONOCHROMEOUTLINE", nil, nil, nil), -- actionbar / bag / etc.
	movers = Font(pixel, nil, "MONOCHROMEOUTLINE", nil, nil, nil), -- /moveui text + vehicle
}