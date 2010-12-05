-- move durability frame.

hooksecurefunc(DurabilityFrame,"SetPoint",function(self,_,parent)
    if (parent == "MinimapCluster") or (parent == _G["MinimapCluster"]) then
        self:ClearAllPoints()
		self:SetPoint("TOP", UIParent, "TOP", 0, TukuiDB.Scale(-60))
    end
end)