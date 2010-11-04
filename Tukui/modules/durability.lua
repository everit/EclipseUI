-- move durability frame.

hooksecurefunc(DurabilityFrame,"SetPoint",function(self,_,parent)
    if (parent == "MinimapCluster") or (parent == _G["MinimapCluster"]) then
        self:ClearAllPoints()
		self:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, TukuiDB.Scale(800));
    end
end)