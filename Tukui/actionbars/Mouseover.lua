local db = TukuiCF["actionbar"]

if not db.enable then return end

----- [[     Split Bar Mouseover     ]] -----

local function split_bar_alpha(alpha)
	TukuiLeftSplitBarBackground:SetAlpha(alpha)
	TukuiRightSplitBarBackground:SetAlpha(alpha)
	
	if db.split_bar == true and db.split_bar_mouseover == true then
		if MultiBarLeft:IsShown() then
			for i=1, 12 do
				local pb = _G["MultiBarLeftButton"..i]
				pb:SetAlpha(alpha)
			end
			MultiBarLeft:SetAlpha(alpha)
		end
	end
end

if db.split_bar == true and db.split_bar_mouseover == true then
	TukuiLeftSplitBarBackground:SetAlpha(0)
	TukuiRightSplitBarBackground:SetAlpha(0)
	TukuiLeftSplitBarBackground:SetScript("OnEnter", function(self) split_bar_alpha(1) end)
	TukuiLeftSplitBarBackground:SetScript("OnLeave", function(self) split_bar_alpha(0) end)
	TukuiRightSplitBarBackground:SetScript("OnEnter", function(self) split_bar_alpha(1) end)
	TukuiRightSplitBarBackground:SetScript("OnLeave", function(self) split_bar_alpha(0) end)

	for i = 1, 12 do
		local pb = _G["MultiBarLeftButton"..i]
		pb:SetAlpha(0)
		pb:HookScript("OnEnter", function(self) split_bar_alpha(1) end)
		pb:HookScript("OnLeave", function(self) split_bar_alpha(0) end)
	end
end


----- [[     Pet Bar Mouseover     ]] -----

local function petbar_mouseover(alpha)
	TukuiPetActionBarBackground:SetAlpha(alpha)
	
	for i=1, NUM_PET_ACTION_SLOTS do
		local pb = _G["PetActionButton"..i]
		pb:SetAlpha(alpha)
	end
end

if db.petbar_mouseover == true then
	TukuiPetActionBarBackground:SetAlpha(0)
	TukuiPetActionBarBackground:SetScript("OnEnter", function(self) petbar_mouseover(1) end)
	TukuiPetActionBarBackground:SetScript("OnLeave", function(self) petbar_mouseover(0) end)

	for i=1, NUM_PET_ACTION_SLOTS do
		local pb = _G["PetActionButton"..i]
		pb:SetAlpha(0)
		pb:HookScript("OnEnter", function(self) petbar_mouseover(1) end)
		pb:HookScript("OnLeave", function(self) petbar_mouseover(0) end)
	end
end


----- [[     Right Bar Mouseover     ]] -----

local function rightbar_alpha(alpha)
	TukuiActionBarBackgroundRight:SetAlpha(alpha)
	
	if not db.splitbar and db.rightbars > 2 then
		if MultiBarLeft:IsShown() then
			for i=1, 12 do
				local pb = _G["MultiBarLeftButton"..i]
				pb:SetAlpha(alpha)
			end
			MultiBarLeft:SetAlpha(alpha)
		end
	end
	if db.rightbars > 1 then
		if MultiBarBottomRight:IsShown() then
			for i=1, 12 do
				local pb = _G["MultiBarBottomRightButton"..i]
				pb:SetAlpha(alpha)
			end
			MultiBarBottomRight:SetAlpha(alpha)
		end
	end
	if db.rightbars > 0 then
		if MultiBarRight:IsShown() then
			for i=1, 12 do
				local pb = _G["MultiBarRightButton"..i]
				pb:SetAlpha(alpha)
			end
			MultiBarRight:SetAlpha(alpha)
		end
	end
end

if db.rightbar_mouseover == true and db.rightbars > 0 then
	TukuiActionBarBackgroundRight:SetAlpha(0)
	TukuiActionBarBackgroundRight:SetScript("OnEnter", function(self) petbar_mouseover(1) rightbar_alpha(1) end)
	TukuiActionBarBackgroundRight:SetScript("OnLeave", function(self) petbar_mouseover(0) rightbar_alpha(0) end)

	for i=1, 12 do
		local pb = _G["MultiBarRightButton"..i]
		pb:SetAlpha(0)
		pb:HookScript("OnEnter", function(self) petbar_mouseover(1) rightbar_alpha(1) end)
		pb:HookScript("OnLeave", function(self) petbar_mouseover(0) rightbar_alpha(0) end)
		
		if not db.splitbar then
			local pb = _G["MultiBarLeftButton"..i]
			pb:SetAlpha(0)
			pb:HookScript("OnEnter", function(self) petbar_mouseover(1) rightbar_alpha(1) end)
			pb:HookScript("OnLeave", function(self) petbar_mouseover(0) rightbar_alpha(0) end)
		end
		
		local pb = _G["MultiBarBottomRightButton"..i]
		pb:SetAlpha(0)
		pb:HookScript("OnEnter", function(self) petbar_mouseover(1) rightbar_alpha(1) end)
		pb:HookScript("OnLeave", function(self) petbar_mouseover(0) rightbar_alpha(0) end)
	end
	
	TukuiPetActionBarBackground:SetAlpha(0)
	TukuiPetActionBarBackground:SetScript("OnEnter", function(self) petbar_mouseover(1) rightbar_alpha(1) end)
	TukuiPetActionBarBackground:SetScript("OnLeave", function(self) petbar_mouseover(0) rightbar_alpha(0) end)
	for i=1, NUM_PET_ACTION_SLOTS do
		local pb = _G["PetActionButton"..i]
		pb:SetAlpha(0)
		pb:HookScript("OnEnter", function(self) petbar_mouseover(1) rightbar_alpha(1) end)
		pb:HookScript("OnLeave", function(self) petbar_mouseover(0) rightbar_alpha(0) end)
	end
end