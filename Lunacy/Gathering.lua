function LunacyAddNode(whoGathered, item, amt, x, y, pMapID)
	if not x then
		x, y, pMapID = HBD:GetPlayerZonePosition(true)
	end
	if not pMapID then
		lootTrig = true
		return
	end
	if not gatherRegistered then return; end
	local nodeType = gatherRegistered

	LunacyGather[nodeType][pMapID] = LunacyGather[nodeType][pMapID] or {}
	local k = floor(x*1000) * 1000 + floor(y*1000)
	local ti = GetServerTime()
	local san = item
	lastGather = item
	
	if nodeType == "ore" then
		san = gsub(san, " deposit", "")
		san = gsub(san, " vein", "")
		san = gsub(san, " seam", "")
	elseif nodeType == "jelly" then
		san = gsub(san, " deposit", "")
	end
	
	local dt = date("%m/%d/%y %H:%M:%S", ti)

	if not LunacyGather[nodeType][pMapID][k] then
		LunacyGather[nodeType][pMapID][k] = {res = san, X = x, Y = y, lT = dt, who = whoGathered, visited = 0, tot = 0}
		if whoGathered == Lunacy.playerKey then
			print("|cffffa500Stored gather of "..san.." in database.")
		else
			print("|cffffa500Received a gather of "..san.." from "..whoGathered..".")
		end
	else
		if whoGathered == Lunacy.playerKey then
			print("|cffffa500Updated database for "..san.." ("..tostring(LunacyGather[nodeType][pMapID][k].tot + amt).." gathered).")
		else
			print("|cffffa500Received a gather of "..san.." from "..whoGathered..".")
		end
	end
	if whoGathered == Lunacy.playerKey then
		LunacyGather[nodeType][pMapID][k].lT = dt
		LunacyGather[nodeType][pMapID][k].who = whoGathered
		LunacyGather[nodeType][pMapID][k].tot = LunacyGather[nodeType][pMapID][k].tot + amt
		LunacyGather[nodeType][pMapID][k].visited = LunacyGather[nodeType][pMapID][k].visited + 1
		local msg = san..","..nodeType..","..tostring(x)..","..tostring(y)..","..tostring(pMapID)
		C_ChatInfo.SendAddonMessage("LunaGather", msg, "GUILD")
	end
	
	lootTrig = true
end

local LunacyRegisterGather(gatherType)
	if gatherRegistered then return; end
	gatherRegistered = gatherType
end