function TukuiDB.UIScale()
	if TukuiCF["general"].autoscale == true then
		TukuiCF["general"].uiscale = min(2, max(.64, 768/string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)")))
	end
end
TukuiDB.UIScale()

local mult = 768/string.match(GetCVar("gxResolution"), "%d+x(%d+)")/TukuiCF["general"].uiscale

function TukuiDB.Scale(x)
    return mult*math.floor(x/mult+.5)
end

TukuiDB.mult = mult