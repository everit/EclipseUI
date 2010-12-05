-- just some random skin, not everything is skinned atm.

local function SkinButton(f)
	f:SetNormalTexture("")
	f:SetHighlightTexture("")
	f:SetPushedTexture("")
	f:SetDisabledTexture("")
	TukuiDB.SetTemplate(f)
	TukuiDB.CreateOverlay(f)
	f:HookScript("OnEnter", TukuiDB.SetModifiedBackdrop)
	f:HookScript("OnLeave", TukuiDB.SetOriginalBackdrop)
end

local TukuiSkin = CreateFrame("Frame")
TukuiSkin:RegisterEvent("ADDON_LOADED")
TukuiSkin:SetScript("OnEvent", function(self, event, addon)
	if IsAddOnLoaded("Skinner") or IsAddOnLoaded("Aurora") then return end
	
	-- stuff not in Blizzard load-on-demand
	if addon == "Tukui" then
		-- Blizzard frame we want to reskin
		local bgskins = { -- for fully skinned backgrounds
			"StaticPopup1",
			"StaticPopup2",
			"StaticPopup3",
			"GameMenuFrame",
			"InterfaceOptionsFrame",
			"VideoOptionsFrame",
			"AudioOptionsFrame",
			"ReadyCheckFrame",
		}
		
		local insetskins = { -- for faded skinned backgrounds		
			"LFDDungeonReadyStatus",
			"BNToastFrame",
			"TicketStatusFrameButton",
			"DropDownList1MenuBackdrop",
			"DropDownList2MenuBackdrop",
			"DropDownList1Backdrop",
			"DropDownList2Backdrop",
			"LFDSearchStatus",
			"AutoCompleteBox",
			"ColorPickerFrame",
		}

		local nonshadowskins = { -- why are we doing this? because overlay is far superior than SetTemplate
			"InterfaceOptionsFramePanelContainer",
			"InterfaceOptionsFrameCategories",
			
			"VideoOptionsFrameCategoryFrame",
			"VideoOptionsFramePanelContainer",

			"AudioOptionsFrameCategoryFrame",
			"AudioOptionsSoundPanel",
			"AudioOptionsVoicePanel",
			"AudioOptionsVoicePanelTalking",
			"AudioOptionsVoicePanelBinding",
			"AudioOptionsVoicePanelListening",
		}
		TukuiDB.Kill(_G["AudioOptionsSoundPanelPlayback"]) -- maybe, unsure on this
		TukuiDB.Kill(_G["AudioOptionsSoundPanelHardware"])
		TukuiDB.Kill(_G["AudioOptionsSoundPanelVolume"])
		
		TukuiDB.Kill(_G["GhostFrame"]) -- fuck you

		-- reskin popup buttons
		for i = 1, 3 do
			for j = 1, 3 do
				SkinButton(_G["StaticPopup"..i.."Button"..j])
			end
		end
		
		for i = 1, getn(bgskins) do
			_G[bgskins[i]]:SetBackdrop({
				bgFile = TukuiCF["media"].blank,
				edgeFile = TukuiCF["media"].blank,
				tile = false,
				tileSize = 0,
				edgeSize = TukuiDB.mult,
				insets = { left = -TukuiDB.mult, right = -TukuiDB.mult, top = -TukuiDB.mult, bottom = -TukuiDB.mult }
			})
			_G[bgskins[i]]:SetBackdropColor(unpack(TukuiCF["media"].fadedbackdropcolor))
			_G[bgskins[i]]:SetBackdropBorderColor(unpack(TukuiCF["media"].bordercolor))
			TukuiDB.CreateShadow(_G[bgskins[i]])
			TukuiDB.CreateBorder(_G[bgskins[i]], true, true)
		end
		
		for i = 1, getn(insetskins) do
			TukuiDB.SetTemplate(_G[insetskins[i]])
			TukuiDB.CreateShadow(_G[insetskins[i]])
			TukuiDB.CreateOverlay(_G[insetskins[i]])
		end
		
		for i = 1, getn(nonshadowskins) do
			TukuiDB.SetTemplate(_G[nonshadowskins[i]])
			TukuiDB.CreateOverlay(_G[nonshadowskins[i]])
		end
		
		local ChatMenus = {
			"ChatMenu",
			"EmoteMenu",
			"LanguageMenu",
			"VoiceMacroMenu",
		}
 
		for i = 1, getn(ChatMenus) do
			if _G[ChatMenus[i]] == _G["ChatMenu"] then
				_G[ChatMenus[i]]:HookScript("OnShow", function(self) TukuiDB.SetTemplate(self) self:ClearAllPoints() self:SetPoint("BOTTOMLEFT", ChatFrame1, "TOPLEFT", 0, TukuiDB.Scale(30)) end)
			else
				_G[ChatMenus[i]]:HookScript("OnShow", function(self) TukuiDB.SetTemplate(self) end)
			end
		end
		
		-- reskin all esc/menu buttons
		local BlizzardMenuButtons = {
			"Options", 
			"SoundOptions", 
			"UIOptions", 
			"Keybindings", 
			"Macros",
			"Ratings",
			"AddOns", 
			"Logout", 
			"Quit", 
			"Continue", 
			"MacOptions"
		}
		
		for i = 1, getn(BlizzardMenuButtons) do
			local TukuiMenuButtons = _G["GameMenuButton"..BlizzardMenuButtons[i]]
			if TukuiMenuButtons then
				SkinButton(TukuiMenuButtons)
				_G["GameMenuButton"..BlizzardMenuButtons[i].."Left"]:SetAlpha(0)
				_G["GameMenuButton"..BlizzardMenuButtons[i].."Middle"]:SetAlpha(0)
				_G["GameMenuButton"..BlizzardMenuButtons[i].."Right"]:SetAlpha(0)
			end
		end
		
		-- hide header textures and move text/buttons.
		local BlizzardHeader = {
			"GameMenuFrame", 
			"InterfaceOptionsFrame", 
			"AudioOptionsFrame", 
			"VideoOptionsFrame"
		}
		
		for i = 1, getn(BlizzardHeader) do
			local title = _G[BlizzardHeader[i].."Header"]			
			if title then
				title:SetTexture("")
				title:ClearAllPoints()
				if title == _G["GameMenuFrameHeader"] then
					title:SetPoint("TOP", GameMenuFrame, 0, 7)
				else
					title:SetPoint("TOP", BlizzardHeader[i], 0, 0)
				end
			end
		end
		
		-- here we reskin all "normal" buttons
		local BlizzardButtons = {
			"VideoOptionsFrameOkay", 
			"VideoOptionsFrameCancel", 
			"VideoOptionsFrameDefaults", 
			"VideoOptionsFrameApply", 
			"AudioOptionsFrameOkay", 
			"AudioOptionsFrameCancel", 
			"AudioOptionsFrameDefaults", 
			"InterfaceOptionsFrameDefaults", 
			"InterfaceOptionsFrameOkay", 
			"InterfaceOptionsFrameCancel",
			"ReadyCheckFrameYesButton",
			"ReadyCheckFrameNoButton",
		}
		
		for i = 1, getn(BlizzardButtons) do
		local TukuiButtons = _G[BlizzardButtons[i]]
			if TukuiButtons then
				SkinButton(TukuiButtons)
			end
		end
		
		-- if a button position or text is not really where we want, we move it here
		_G["VideoOptionsFrameCancel"]:ClearAllPoints()
		_G["VideoOptionsFrameCancel"]:SetPoint("RIGHT",_G["VideoOptionsFrameApply"],"LEFT",-4,0)		 
		_G["VideoOptionsFrameOkay"]:ClearAllPoints()
		_G["VideoOptionsFrameOkay"]:SetPoint("RIGHT",_G["VideoOptionsFrameCancel"],"LEFT",-4,0)	
		_G["AudioOptionsFrameOkay"]:ClearAllPoints()
		_G["AudioOptionsFrameOkay"]:SetPoint("RIGHT",_G["AudioOptionsFrameCancel"],"LEFT",-4,0)
		_G["InterfaceOptionsFrameOkay"]:ClearAllPoints()
		_G["InterfaceOptionsFrameOkay"]:SetPoint("RIGHT",_G["InterfaceOptionsFrameCancel"],"LEFT", -4,0)
		_G["ReadyCheckFrameYesButton"]:SetParent(_G["ReadyCheckFrame"])
		_G["ReadyCheckFrameNoButton"]:SetParent(_G["ReadyCheckFrame"]) 
		_G["ReadyCheckFrameYesButton"]:SetPoint("RIGHT", _G["ReadyCheckFrame"], "CENTER", -1, 0)
		_G["ReadyCheckFrameNoButton"]:SetPoint("LEFT", _G["ReadyCheckFrameYesButton"], "RIGHT", 3, 0)
		_G["ReadyCheckFrameText"]:SetParent(_G["ReadyCheckFrame"])	
		_G["ReadyCheckFrameText"]:ClearAllPoints()
		_G["ReadyCheckFrameText"]:SetPoint("TOP", 0, -12)
		
		-- others
		_G["ReadyCheckListenerFrame"]:SetAlpha(0)
		_G["ReadyCheckFrame"]:HookScript("OnShow", function(self) if UnitIsUnit("player", self.initiator) then self:Hide() end end) -- bug fix, don't show it if initiator
	end
	
	-- mac menu/option panel, made by affli.
	if IsMacClient() then
		-- Skin main frame and reposition the header
		TukuiDB.SetTemplate(MacOptionsFrame)
		MacOptionsFrameHeader:SetTexture("")
		MacOptionsFrameHeader:ClearAllPoints()
		MacOptionsFrameHeader:SetPoint("TOP", MacOptionsFrame, 0, 0)
 
		--Skin internal frames
		TukuiDB.SetTemplate(MacOptionsFrameMovieRecording)
		TukuiDB.SetTemplate(MacOptionsITunesRemote)
 
		--Skin buttons
		SkinButton(_G["MacOptionsFrameCancel"])
		SkinButton(_G["MacOptionsFrameOkay"])
		SkinButton(_G["MacOptionsButtonKeybindings"])
		SkinButton(_G["MacOptionsFrameDefaults"])
		SkinButton(_G["MacOptionsButtonCompress"])
 
		--Reposition and resize buttons
		local tPoint, tRTo, tRP, tX, tY =  _G["MacOptionsButtonCompress"]:GetPoint()
		_G["MacOptionsButtonCompress"]:SetWidth(136)
		_G["MacOptionsButtonCompress"]:ClearAllPoints()
		_G["MacOptionsButtonCompress"]:SetPoint(tPoint, tRTo, tRP, TukuiDB.Scale(4), tY)
 
		_G["MacOptionsFrameCancel"]:SetWidth(96)
		_G["MacOptionsFrameCancel"]:SetHeight(22)
		tPoint, tRTo, tRP, tX, tY =  _G["MacOptionsFrameCancel"]:GetPoint()
		_G["MacOptionsFrameCancel"]:ClearAllPoints()
		_G["MacOptionsFrameCancel"]:SetPoint(tPoint, tRTo, tRP, TukuiDB.Scale(-14), tY)
 
		_G["MacOptionsFrameOkay"]:ClearAllPoints()
		_G["MacOptionsFrameOkay"]:SetWidth(96)
		_G["MacOptionsFrameOkay"]:SetHeight(22)
		_G["MacOptionsFrameOkay"]:SetPoint("LEFT",_G["MacOptionsFrameCancel"],TukuiDB.Scale(-99),0)
 
		_G["MacOptionsButtonKeybindings"]:ClearAllPoints()
		_G["MacOptionsButtonKeybindings"]:SetWidth(96)
		_G["MacOptionsButtonKeybindings"]:SetHeight(22)
		_G["MacOptionsButtonKeybindings"]:SetPoint("LEFT",_G["MacOptionsFrameOkay"],TukuiDB.Scale(-99),0)
 
		_G["MacOptionsFrameDefaults"]:SetWidth(96)
		_G["MacOptionsFrameDefaults"]:SetHeight(22)
		
		-- why these buttons is using game menu template? oO
		_G["MacOptionsButtonCompressLeft"]:SetAlpha(0)
		_G["MacOptionsButtonCompressMiddle"]:SetAlpha(0)
		_G["MacOptionsButtonCompressRight"]:SetAlpha(0)
		_G["MacOptionsButtonKeybindingsLeft"]:SetAlpha(0)
		_G["MacOptionsButtonKeybindingsMiddle"]:SetAlpha(0)
		_G["MacOptionsButtonKeybindingsRight"]:SetAlpha(0)
	end
end)
