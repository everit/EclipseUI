------------------------------------------------------------------------
--	GM ticket position
------------------------------------------------------------------------

TicketStatusFrame:ClearAllPoints()
TicketStatusFrame:SetPoint("TOPLEFT", TukuiMinimap, "TOPRIGHT", TukuiDB.Scale(1), TukuiDB.Scale(-TukuiCF["panels"].tinfoheight - 3))

------------------------------------------------------------------------
--	GM toggle command
------------------------------------------------------------------------

SLASH_GM1 = "/gm"
SlashCmdList["GM"] = function() ToggleHelpFrame() end