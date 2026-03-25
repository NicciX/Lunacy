local HBD = LibStub("HereBeDragons-2.0")

local Find = {
	["Portal"] = {
		["Stormwind City"] = {
			["Uldum"] = {},
		},
		["Silvermoon City"] = {
			["Stormwind City"] = {
				["mapID"] = 2393,
				["x"] = 52.77,
				["y"] = 64.77,
			},
			["Harandar"] = {
				["mapID"] = 2393,
				["x"] = 36.66,
				["y"] = 68.76,
			},
			["Voidstorm"] = {
				["mapID"] = 2393,
				["x"] = 35.15,
				["y"] = 65.67,
			},
		},
		["The Den"] = { -- Harandar
			["Silvermoon City"] = {
				["mapID"] = 2576,
				["x"] = 63.82,
				["y"] = 70.36,
				["opt"] = "Portal is inside cave.",
			},
		},
		["Harandar"] = { -- Harandar
			["Silvermoon City"] = {
				["mapID"] = 2576,
				["x"] = 63.82,
				["y"] = 70.36,
				["opt"] = "Portal is inside cave.",
			},
		},
	},
	["Mailbox"] = {
		["Silvermoon City"] = {
			["Dawning Lane"] = {
				["mapID"] = 2393,
				["x"] = 28.66,
				["y"] = 66.91,
			},
			["Falconwing Square"] = {
				["mapID"] = 2393,
				["x"] = 34.32,
				["y"] = 80.23,
			},
			["The Bazaar SE"] = {
				["mapID"] = 2393,
				["x"] = 49.49,
				["y"] = 75.53,
			},
			["The Bazaar N"] = {
				["mapID"] = 2393,
				["x"] = 45.09,
				["y"] = 56.58,
			},
			["The Bazaar NE"] = {
				["mapID"] = 2393,
				["x"] = 49.46,
				["y"] = 65.93,
			},
		},
		["Eversong Woods"] = {
			["Sunstrider Isle"] = {
				["mapID"] = 2395,
				["x"] = 42.81,
				["y"] = 14.55,
			},
			["Fairbreeze Village"] = {
				["mapID"] = 2395,
				["x"] = 46.64,
				["y"] = 45.81,
			},
		},
	},
	["Bank"] = {
		["Silvermoon City"] = {
			["The Bazaar NE"] = {
				["mapID"] = 2393,
				["x"] = 50.35,
				["y"] = 65.89,
			},
		},
	},
	["Anvil"] = {
		["Silvermoon City"] = {
			["The Bazaar N"] = {
				["mapID"] = 2393,
				["x"] = 43.78,
				["y"] = 51.87,
			},
		},
	},
	["Alchemy Trainer"] = {
		["Silvermoon City"] = {
			["The Bazaar N"] = {
				["mapID"] = 2393,
				["x"] = 46.93,
				["y"] = 51.88,
			},
		},
	},
	["Auction House"] = {
		["Silvermoon City"] = {
			["The Bazaar SE"] = {
				["mapID"] = 2393,
				["x"] = 50.44,
				["y"] = 75.15,
			},
		},
	},
}

local matchSticks = {
	["portal"] = "Portal",
	["port"] = "Portal",
	["mailbox"] = "Mailbox",
	["mail"] = "Mailbox",
	["box"] = "Mailbox",
	["bank"] = "Bank",
	["anvil"] = "Anvil",
	["repair"] = "Anvil",
	["bs"] = "Blacksmith",
	["loom"] = "Loom",
	["tailor"] = "Tailor",
	["fire"] = "Fire",
	["forge"] = "Forge",
	["delve"] = "Delve",
	["vendor"] = "Vendor",
	["cook"] = "Cooking Trainer",
	["chef"] = "Cooking Trainer",
	["cooking"] = "Cooking Trainer",
	["auction house"] = "Auction House",
	["auctionhouse"] = "Auction House",
	["auction"] = "Auction House",
	["ah"] = "Auction House",
	["auctionhouse"] = "Auction House",
	["trainer"] = "Trainer",
	["qm"] = "Quartermaster",
	["quartermaster"] = "Quartermaster",
	["alchemy"] = "Alchemy Trainer",
	["alchy"] = "Alchemy Trainer",
	["cauldron"] = "Cauldron",
	["alchemy trainer"] = "Alchemy Trainer",
	["scribe"] = "Inscription Trainer",
	["inscription"] = "Inscription Trainer",
	["herbalist"] = "Herbalist",
	["herbalism"] = "Herbalist",
	["ore"] = "Metal & Stone",
	["herb"] = "Herb",
}

local destinations = {
	["stormwind"] = "Stormwind City",
	["sw"] = "Stormwind City",
	["uldum"] = "Uldum",
	["harandar"] = "Harandar",
	["haradar"] = "Harandar",
	["harandir"] = "Harandar",
	["haran"] = "Harandar",
	["hara"] = "Harandar",
	["smc"] = "Silvermoon City",
	
}

function gATHEr(txt)
	txt = string.lower(txt)
	Ramble(colorMe("Under Construnction", "Sunflower"))
	local pMap = C_Map.GetBestMapForUnit("player")
	local pX,pY,pMap = GetPlayerPosition()
	local info = C_Map.GetMapInfo(pMap)
	local name = info.name
	local zoneName = GetZoneText()
	if Gathers[zoneName] then
		local dressing = ChattyChop(txt)
		local crOUTon, salt, pepper
		if dressing and dressing[1] then
			crOUTon = matchSticks[dressing[1]]
			print(crOUTon)
			txt = string.gsub(txt, dressing[1].." ", "")
			if crOUTon and Gathers[zoneName][crOUTon] then
				salt = {}
				salt.x = pX
				salt.y = pY
				salt.map = pMap
				salt.what = txt
				salt.pork = crOUTon
				salt.zone = zoneName
				pepper = {}
				for kOOl,vOOl in pairs(Gathers[zoneName][crOUTon]) do
					if string.find(string.lower(kOOl), txt) then
						for cool, spool in pairs(vOOl) do
							pepper[cool] = kOOl
						end
						--shEErThEShEEp(vOOl,salt, kOOl)
						--salt = nil
					end
				end
				shEErThEShEEp(pepper,salt)
			end
			--if type(dressing) == "table" then
				--print(tostring(dressing[1]))
			--end
		end
	end
end

function rECORd(txt)
	local sZone = string.gsub(GetSubZoneText(), " ", "")
	
	local mtCStk = string.match(txt, "(%w+)")
	if mtCStk == "target" then
		
	end
	local key = matchSticks[mtCStk]
	if key then
		txt = string.gsub(txt, mtCStk, "")
		local pMap = C_Map.GetBestMapForUnit("player")
		local pX,pY,pMap = GetPlayerPosition()
		local info = C_Map.GetMapInfo(pMap)
		local name = info.name
		if pMap and pX and name then
			pX = floor(pX*10000)/100
			pY = floor(pY*10000)/100
			local sX,sY = tostring(pX), tostring(pY)
			local spot = sZone.."-"..sX..":"..sY
			local ramble = colorMe(key, "FluorescentBlue")..colorMe(" recorded ", "Scarlet")..colorMe(" @ ", "ElectricBlue")
			ramble = ramble..colorMe(" x: ", "Red")..sX..colorMe(" y: ", "Yellow")..sY
			Ramble(ramble, colorMe("\|•rECORd•\| ", "Scarlet"))
			Ramble(colorMe("key :> ", "Shamrock")..colorMe(spot, "Yellow"), colorMe("\|•rECORd•\| ", "Yellow"))
			Luna.Find = Luna.Find or {}
			Luna.Find[key] = Luna.Find[key] or {}
			Luna.Find[key][name] = Luna.Find[key][name] or {}
			Luna.Find[key][name][spot] = {}
			Luna.Find[key][name][spot].mapID = pMap
			Luna.Find[key][name][spot].x = pX
			Luna.Find[key][name][spot].y = pY
			Luna.Find[key][name][spot].opt = txt
		end
	end

end

local function GetDis(pX,pY,dX,dY,tMap)
	dX, dY = HBD:GetWorldCoordinatesFromZone(dX/100, dY/100, tMap)
	return math.abs(HBD:GetWorldDistance(tMap, pX, pY, dX, dY))
end

local function FindPortal(txt)
	local map = C_Map.GetBestMapForUnit("player")
	local loCat = C_Map.GetMapInfo(map)
	loCat = loCat.name
	--print(txt)
	if loCat then
		if destinations[txt] and Find.Portal[loCat] then
			if Find.Portal[loCat][destinations[txt]] then
				if Find.Portal[loCat][destinations[txt]].mapID then
					Ramble(colorMe("Portal for ", "Champagne")..colorMe(destinations[txt], "Chartreuse")..colorMe(" set.", "Champagne"), colorMe("[WhereIs] ", "SignalYellow"))
					SetTrack(Find.Portal[loCat][destinations[txt]].mapID,
						Find.Portal[loCat][destinations[txt]].x,
						Find.Portal[loCat][destinations[txt]].y,
						colorMe("Portal to ", "Champagne")..colorMe(destinations[txt], "Chartreuse"),
						Find.Portal[loCat][destinations[txt]].opt, "Portal"
					)
				end
			end
		elseif Find.Portal[loCat] then
			local dis = 9999
			local pX,pY,pMap,pWX,pWY,mapType,pntMap = GetPlayerPosition()
			local dX, dY
			local dISS, kEY
			for k,v in pairs(Find.Portal[loCat]) do
				dISS = GetDis(pWX,pWY,v.x,v.y,v.mapID)
				if dISS < dis then
					dis = dISS
					kEY = k
				end
			end
			if kEY then
				Ramble(colorMe("Portal for ", "Champagne")..colorMe(kEY, "Chartreuse")..colorMe(" set.", "Champagne"), colorMe("[WhereIs] ", "SignalYellow"))
				SetTrack(Find.Portal[loCat][kEY].mapID,
					Find.Portal[loCat][kEY].x,
					Find.Portal[loCat][kEY].y,
					colorMe("Portal to ", "Champagne")..colorMe(kEY, "Chartreuse"),
					Find.Portal[loCat][kEY].opt, "Portal"
				)
			else
				Ramble(colorMe("~No portals located for ", "CandyApple")..colorMe(loCat, "Chartreuse")..colorMe("~", "CandyApple"),
					colorMe("[WhereIs]", "SignalYellow"))
			end
		elseif loCat and Luna.Find.Portal and Luna.Find.Portal[loCat] then
			local dis = 9999
			local pX,pY,pMap,pWX,pWY,mapType,pntMap = GetPlayerPosition()
			local dX, dY
			local dISS, kEY
			for k,v in pairs(Luna.Find.Portal[loCat]) do
				dISS = GetDis(pWX,pWY,v.x,v.y,v.mapID)
				if dISS < dis then
					dis = dISS
					kEY = k
					last = "Luna"
				end
			end
			if kEY then
				Ramble(colorMe("Portal for ", "Champagne")..colorMe(kEY, "Chartreuse")..colorMe(" set.", "Champagne"), colorMe("[WhereIs] ", "SignalYellow"))
				SetTrack(Luna.Find.Portal[loCat][kEY].mapID,
					Luna.Find.Portal[loCat][kEY].x,
					Luna.Find.Portal[loCat][kEY].y,
					colorMe("Portal to ", "Champagne")..colorMe(kEY, "Chartreuse"),
					Luna.Find.Portal[loCat][kEY].opt, "Portal"
				)
			else
				Ramble(colorMe("~No portals located for ", "CandyApple")..colorMe(loCat, "Chartreuse")..colorMe("~", "CandyApple"),
					colorMe("[WhereIs]", "SignalYellow"))
			end
		else
			Ramble(colorMe("~No valid data for [", "CandyApple")..colorMe(loCat, "Chartreuse")..colorMe("]~", "CandyApple"),
					colorMe("[WhereIs]", "SignalYellow"))
		end
	else
		Ramble(colorMe("~Unknown Location~", "CandyApple"), colorMe("[WhereIs]", "SignalYellow"))
	end
end

local function FindThing(thing)
	local map = C_Map.GetBestMapForUnit("player")
	local loCat = C_Map.GetMapInfo(map)
	loCat = loCat.name
	
	local dis = 9999
	local pX,pY,pMap,pWX,pWY,mapType,pntMap = GetPlayerPosition()
	local dX, dY
	local dISS, kEY, lass
	
	if loCat then
		if loCat and Luna.Find[thing] and Luna.Find[thing][loCat] then
			for k,v in pairs(Luna.Find[thing][loCat]) do
				dISS = GetDis(pWX,pWY,v.x,v.y,v.mapID)
				if dISS < dis then
					dis = dISS
					kEY = k
					last = "Luna"
				end
			end
		end
		if loCat and Find[thing] and Find[thing][loCat] then
			for k,v in pairs(Find[thing][loCat]) do
				dISS = GetDis(pWX,pWY,v.x,v.y,v.mapID)
				if dISS < dis then
					dis = dISS
					kEY = k
					last = "Find"
				end
			end
		end
	end
	
	if last and last == "Luna" then
		last = Luna.Find[thing][loCat][kEY]
	elseif last and last == "Find" then
		last = Find[thing][loCat][kEY]
	end
	if last and kEY then
		Ramble(colorMe(thing.." found at ", "Champagne")..colorMe(kEY, "Chartreuse")..colorMe(" set.", "Champagne"), colorMe("[WhereIs] ", "SignalYellow"))
		SetTrack(last.mapID,last.x,last.y,colorMe(thing.." @ ", "Champagne")..colorMe(kEY, "Chartreuse"),last.opt, thing)
	else
		Ramble(colorMe("~No "..thing.." located in ", "CandyApple")..colorMe(loCat, "Chartreuse")..colorMe("~", "CandyApple"),
			colorMe("[WhereIs]", "SignalYellow"))
	end
	
	
	--[[
	if loCat and (Find[thing] or Luna.Find[thing]) then
		if Find[thing][loCat] then
			local dis = 9999
			local pX,pY,pMap,pWX,pWY,mapType,pntMap = GetPlayerPosition()
			local dX, dY
			local dISS, kEY, lass
		
			for k,v in pairs(Find[thing][loCat]) do
				dISS = GetDis(pWX,pWY,v.x,v.y,v.mapID)
				if dISS < dis then
					dis = dISS
					kEY = k
					last = "Find"
				end
			end
			if Luna.Find[thing] and Luna.Find[thing][loCat] then
				for k,v in pairs(Luna.Find[thing][loCat]) do
					dISS = GetDis(pWX,pWY,v.x,v.y,v.mapID)
					if dISS < dis then
						dis = dISS
						kEY = k
						last = "Luna"
					end
				end
			end
			if last and last == "Luna" then
				last = Luna.Find[thing][loCat][kEY]
			elseif last and last == "Find" then
				last = Find[thing][loCat][kEY]
			end
			if last and kEY then
				Ramble(colorMe(thing.." found at ", "Champagne")..colorMe(kEY, "Chartreuse")..colorMe(" set.", "Champagne"), colorMe("[WhereIs] ", "SignalYellow"))
				SetTrack(last.mapID,last.x,last.y,colorMe(thing.." @ ", "Champagne")..colorMe(kEY, "Chartreuse"),last.opt, thing)
			else
				Ramble(colorMe("~No "..things.." located in ", "CandyApple")..colorMe(loCat, "Chartreuse")..colorMe("~", "CandyApple"),
					colorMe("[WhereIs]", "SignalYellow"))
			end
		else
			Ramble(colorMe("~No valid data for [", "CandyApple")..colorMe(loCat, "Chartreuse")..colorMe("]~", "CandyApple"),
					colorMe("[WhereIs]", "SignalYellow"))
		end
	else
		Ramble(colorMe("~Unknown Thing~", "CandyApple"), colorMe("[WhereIs]", "SignalYellow"))
	end
	]]--
	
end

function WhereIs(txt)
	if string.sub(txt, 1, 7) == "portal " or string.sub(txt, 1, 5) == "port " or txt == "port" or txt == "portal" then
		txt = string.gsub(txt, "portal ", "")
		txt = string.gsub(txt, "port ", "")
		txt = string.gsub(txt, "portal", "")
		txt = string.gsub(txt, "port", "")
		FindPortal(txt)
	elseif matchSticks[txt] then
		FindThing(matchSticks[txt])
	else
		Ramble(colorMe("~Unknown Thing~", "CandyApple"), colorMe("[WhereIs]", "SignalYellow"))
	--elseif txt == "mailbox" or txt == "mail" or txt == "box" then
		--FindThing("Mailbox")
	--elseif txt == "bank" then
		--FindThing("Bank")
	--elseif txt == "ah" or txt == "auction" or txt == "auction house" then
		--FindThing("Auction House")
	end
end