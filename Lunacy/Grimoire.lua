function getloco(key)
	return GetLoco(key)
end

local flashit = {}
--Marl
flashit.Marl = {}
flashit.Marl.gyretex = "LunacyE"
flashit.Marl.gyreclr = "SpaceCadet"
flashit.Marl.troll = 26375
flashit.Marl.flashtime = 4
flashit.Marl.active = 0.333
flashit.Marl.lineclr = "SpaceCadet"
flashit.Marl.claps = 2

--[[
flashit.Marl.card = {}
flashit.Marl.card.house = "whimsy"
flashit.Marl.card.affinity = 123
flashit.Marl.card.avatar = nil
flashit.Marl.card.suit = "LemonLime"
]]--

--Spring
flashit.Spring = {}
flashit.Spring.gyretex = "LunacyE"
flashit.Spring.gyreclr = "Spring"
flashit.Spring.troll = 26375
flashit.Spring.flashtime = 9
flashit.Spring.active = 0.81
flashit.Spring.lineclr = "Spring"
flashit.Spring.claps = 3
flashit.Spring.card = {}
flashit.Spring.card.house = "verdant"
flashit.Spring.card.affinity = 444
flashit.Spring.card.avatar = 37154
flashit.Spring.card.suit = "Verdant"
flashit.Spring.loco = {}
flashit.Spring.loco.drY = {}
flashit.Spring.loco.drY.a = -9
flashit.Spring.loco.drY.b = 9
flashit.Spring.loco.drY.y = 9
flashit.Spring.loco.drY.pong = 1
flashit.Spring.loco.drY.relax = 0.00023
flashit.Spring.loco.drY.decay = GetTimePreciseSec() + 23
flashit.Spring.loco.lsRadAdj = 0.77
flashit.Spring.lucky = 0.77
flashit.Spring.cast = "~*~ Spring showers, bring lovely flowers ~*~"

--Gold
flashit.Gold = {}
flashit.Gold.gyretex = "LunacyE"
flashit.Gold.gyreclr = "Gold"
--flashit.Gold.troll = 26375
flashit.Gold.flashtime = 7.11
flashit.Gold.lsSpinOver = 71
flashit.Gold.overTime = 7.11
flashit.Gold.active = 0.66
flashit.Gold.lineclr = "Gold"
flashit.Gold.claps = 3
flashit.Gold.card = {}
flashit.Gold.card.house = "gold"
flashit.Gold.card.affinity = 777
flashit.Gold.card.flip = function()
	return tonumber(getloco("balance")) * 0.000001
end --tonumber(getloco("balance")) * 0.00001
flashit.Gold.card.avatar = 54841
flashit.Gold.card.suit = "Gold"
flashit.Gold.card.loco = {}
flashit.Gold.card.loco.balance = 0
--flashit.Gold.loco = {}
--flashit.Gold.lucky = 0.77
flashit.Gold.cast = "~*~ Time is money friend! ~*~"

--Gold
flashit.Scarlet = {}
flashit.Scarlet.gyretex = "LunacyE"
flashit.Scarlet.gyreclr = "Scarlet"
--flashit.Gold.troll = 26375
--flashit.Scarlet.flashtime = 7.11
flashit.Scarlet.lsSpinOver = 71
flashit.Scarlet.overTime = 7.11
flashit.Scarlet.active = 0.0169
flashit.Scarlet.lineclr = "Scarlet"
flashit.Scarlet.claps = 3
flashit.Scarlet.card = {}
flashit.Scarlet.card.house = "scarlet"
flashit.Scarlet.card.affinity = 3696
flashit.Scarlet.card.flip = function()
	return (0.0369 + tonumber(getloco("diSTurbed")) / 1669)
end
flashit.Scarlet.card.avatar = 68967
flashit.Scarlet.card.suit = "Scarlet"
flashit.Scarlet.card.loco = {}
flashit.Scarlet.card.loco.balance = 0
flashit.Scarlet.locoTest = function()
	return not tonumber(getloco("diSTurbed"))
end
flashit.Scarlet.loco = {}
flashit.Scarlet.loco.dippX = 0.77
flashit.Scarlet.loco.dippY = 0.77
flashit.Scarlet.loco.drX = nil
flashit.Scarlet.loco.drY = nil
flashit.Scarlet.loco.pulse = {}
flashit.Scarlet.loco.pulse.cnt = 1
flashit.Scarlet.loco.pulse.amt = 0.03
flashit.Scarlet.loco.pulse.tgt = 0.44
flashit.Scarlet.loco.flashTime = GetTimePreciseSec() + 1
--flashit.Gold.lucky = 0.77
flashit.Scarlet.diSTurbed = function(dBd) return dBd * (1 - math.random() * 0.00313) end
flashit.Scarlet.lucky = function(lUCk) return lUCk * (1 + math.random() * 0.00131) end
flashit.Scarlet.sigil = math.random(777)
flashit.Scarlet.cast = "~*~ Time is money friend! ~*~"


function DrawCard(card)
	if flashit[card] then
		return flashit[card]
	end
end

grimoire = {}
--initLineSet(27,18,234,27,nil,"CandyApple")

--Fire/Passion
grimoire.Vixen = {}
grimoire.Vixen.num = 27
grimoire.Vixen.spin = 18
grimoire.Vixen.degInc = 234
grimoire.Vixen.rd = 27
grimoire.Vixen.rdInc = nil
grimoire.Vixen.colorSet = "Burgandy"
grimoire.Vixen.lineClr = "Mulberry"
grimoire.Vixen.connect = nil
grimoire.Vixen.smooth = nil
grimoire.Vixen.drX = nil
grimoire.Vixen.drY = nil
grimoire.Vixen.pulse = nil
grimoire.Vixen.dippX = 1.0
grimoire.Vixen.dippY = 1.0
grimoire.Vixen.rube = nil
grimoire.Vixen.lsRadAdjX = 1.37
grimoire.Vixen.lsRadAdjY = 1.11
grimoire.Vixen.gyreVert = "White"
grimoire.Vixen.gyreTex = "LunacyA"
grimoire.Vixen.trOll = 21723


--Nature
grimoire.Verdant = {}
grimoire.Verdant.num = 72
grimoire.Verdant.spin = 11
grimoire.Verdant.degInc = 5
grimoire.Verdant.rd = 24
grimoire.Verdant.rdInc = nil
grimoire.Verdant.colorSet = "Verdant"
grimoire.Verdant.lineClr = "Sunflower"
grimoire.Verdant.funcX = function(d,rd,rm)
	local mp = math.pi / 180
	d = d - rm
	--local mp = 1
	return (rd * math.sin((d*7+rm)*mp)) * math.sin(d*mp)
end
grimoire.Verdant.funcY = function(d,rd,rm)
	local mp = math.pi / 180
	d = d - rm
	--local mp = 1
	return (rd * math.sin((d*7+rm)*mp)) * math.cos(d*mp)
end
grimoire.Verdant.connect = true
grimoire.Verdant.smooth = nil
grimoire.Verdant.drX = nil
grimoire.Verdant.drY = nil
grimoire.Verdant.pulse = {}
grimoire.Verdant.pulse.cnt = 1
grimoire.Verdant.pulse.amt = 0.03
grimoire.Verdant.pulse.tgt = 0.44
grimoire.Verdant.dippX = 1.0
grimoire.Verdant.dippY = 1.0
grimoire.Verdant.lsSkew = 0
grimoire.Verdant.rube = nil
grimoire.Verdant.lsRadAdjX = 1.13
grimoire.Verdant.lsRadAdjY = 1.13
grimoire.Verdant.gyreVert = "Verdant"
grimoire.Verdant.gyreTex = "LunacyM"
grimoire.Verdant.trOll = 37154
grimoire.Verdant.snarks = {547788,547796,547785,547790}

--Earth
grimoire.Azure = {}
grimoire.Azure.num = 36
grimoire.Azure.spin = 23
grimoire.Azure.degInc = 17
grimoire.Azure.rd = 21
grimoire.Azure.rdInc = nil
grimoire.Azure.colorSet = "Azure"
grimoire.Azure.lineClr = "Smoke"
grimoire.Azure.funcX = function(d,rd,rm)
	local mp = math.pi / 180
	d = d - rm
	--local mp = 1
	local x1 = math.sin(d * mp)
	local x2 = math.sin((d + rm) * 6 * mp)
	local pt = (rd * x1) + (rd / 2 * x2)
	return pt
	--return rd * math.sin(d * mp)^3
end
grimoire.Azure.funcY = function(d,rd,rm)
	local mp = math.pi / 180
	d = d - rm
	--local mp = 1
	local y1 = math.cos(d * mp)
	local y2 = math.cos((d + rm) * 6 * mp)
	local pt = (rd * y1) + (rd / 2 * y2)
	return pt
	--return rd * math.cos(d * mp) - ((rd/3) * math.cos(2 * d * mp)) - ((rd/6) * math.cos(3 * d * mp)) - ((rd/4) * math.cos(4 * d * mp))
end
grimoire.Azure.connect = nil
grimoire.Azure.smooth = true
grimoire.Azure.drX = nil
grimoire.Azure.drY = nil
grimoire.Azure.pulse = nil
--rimoire.Azure.pulse.cnt = 1
--grimoire.Azure.pulse.amt = 0.03
--grimoire.Azure.pulse.tgt = 0.44
grimoire.Azure.dippX = 1.0
grimoire.Azure.dippY = 1.0
grimoire.Azure.lsSkew = 0
grimoire.Azure.rube = nil
grimoire.Azure.lsRadAdjX = 1.13
grimoire.Azure.lsRadAdjY = 1.13
grimoire.Azure.gyreVert = "Azure"
grimoire.Azure.gyreTex = "LunacyE"
grimoire.Azure.trOll = 115505
grimoire.Azure.doMMy = "Buff"
grimoire.Azure.snarks = {545429,545476,545489,545491}

--War/Combat
grimoire.Scarlet = {}
grimoire.Scarlet.num = 36
grimoire.Scarlet.spin = 23
grimoire.Scarlet.degInc = 17
grimoire.Scarlet.rd = 21
grimoire.Scarlet.rdInc = nil
grimoire.Scarlet.colorSet = "Scarlet"
grimoire.Scarlet.lineClr = "Black"
grimoire.Scarlet.funcX = function(d,rd,rm)
	local mp = math.pi / 180
	d = d - rm
	--local mp = 1
	local x1 = math.sin(d * mp)
	local x2 = math.sin((d + rm) * 6 * mp)
	local pt = (rd * x1) + (rd / 2 * x2)
	return pt
	--return rd * math.sin(d * mp)^3
end
grimoire.Scarlet.funcY = function(d,rd,rm)
	local mp = math.pi / 180
	d = d - rm
	--local mp = 1
	local y1 = math.cos(d * mp)
	local y2 = math.cos((d + rm) * 6 * mp)
	local pt = (rd * y1) + (rd / 2 * y2)
	return pt
	--return rd * math.cos(d * mp) - ((rd/3) * math.cos(2 * d * mp)) - ((rd/6) * math.cos(3 * d * mp)) - ((rd/4) * math.cos(4 * d * mp))
end
grimoire.Scarlet.connect = nil
grimoire.Scarlet.smooth = true
grimoire.Scarlet.drX = nil
grimoire.Scarlet.drY = nil
grimoire.Scarlet.pulse = nil
--rimoire.Azure.pulse.cnt = 1
--grimoire.Azure.pulse.amt = 0.03
--grimoire.Azure.pulse.tgt = 0.44
grimoire.Scarlet.dippX = 1.0
grimoire.Scarlet.dippY = 1.0
grimoire.Scarlet.lsSkew = 77
grimoire.Scarlet.rube = nil
grimoire.Scarlet.lsRadAdjX = 1.13
grimoire.Scarlet.lsRadAdjY = 1.13
grimoire.Scarlet.gyreVert = "Scarlet"
grimoire.Scarlet.gyreTex = "LunacyE"
grimoire.Scarlet.trOll = 2043
grimoire.Scarlet.snarks = {1466150,561156,561158,561160,561165}

--Death/The Underworld
grimoire.Obsidian = {}
grimoire.Obsidian.num = 36
grimoire.Obsidian.spin = 23
grimoire.Obsidian.degInc = 17
grimoire.Obsidian.rd = 21
grimoire.Obsidian.rdInc = nil
grimoire.Obsidian.colorSet = "Obsidian"
grimoire.Obsidian.lineClr = "Smoke"
grimoire.Obsidian.funcX = function(d,rd,rm)
	local mp = math.pi / 180
	d = d - rm
	--local mp = 1
	local x1 = math.sin(d * mp)
	local x2 = math.sin((d + rm) * 6 * mp)
	local pt = (rd * x1) + (rd / 2 * x2)
	return pt
	--return rd * math.sin(d * mp)^3
end
grimoire.Obsidian.funcY = function(d,rd,rm)
	local mp = math.pi / 180
	d = d - rm
	--local mp = 1
	local y1 = math.cos(d * mp)
	local y2 = math.cos((d + rm) * 6 * mp)
	local pt = (rd * y1) + (rd / 2 * y2)
	return pt
	--return rd * math.cos(d * mp) - ((rd/3) * math.cos(2 * d * mp)) - ((rd/6) * math.cos(3 * d * mp)) - ((rd/4) * math.cos(4 * d * mp))
end
grimoire.Obsidian.connect = nil
grimoire.Obsidian.smooth = true
grimoire.Obsidian.drX = nil
grimoire.Obsidian.drY = nil
grimoire.Obsidian.pulse = nil
--rimoire.Azure.pulse.cnt = 1
--grimoire.Azure.pulse.amt = 0.03
--grimoire.Azure.pulse.tgt = 0.44
grimoire.Obsidian.dippX = 1.0
grimoire.Obsidian.dippY = 1.0
grimoire.Obsidian.lsSkew = 77
grimoire.Obsidian.rube = nil
grimoire.Obsidian.lsRadAdjX = 1.13
grimoire.Obsidian.lsRadAdjY = 1.13
grimoire.Obsidian.gyreVert = "Obsidian"
grimoire.Obsidian.gyreTex = "LunacyE"
grimoire.Obsidian.trOll = 5233 --< Spirit Healer >--28213 Sylvanas
grimoire.Obsidian.doMMy = "Obsidian"
grimoire.Obsidian.trOck = {}
grimoire.Obsidian.trOck.anim = 0 --69
grimoire.Obsidian.trOck.rot = 0
grimoire.Obsidian.trOck.camdis = 0.77
grimoire.Obsidian.trOck.offX = 15
grimoire.Obsidian.trOck.offY = -18
grimoire.Obsidian.snarks = {561297,561327,561346,561301}

--Avarice
grimoire.Maroon = {}
grimoire.Maroon.num = 36
grimoire.Maroon.spin = 23
grimoire.Maroon.degInc = 17
grimoire.Maroon.rd = 21
grimoire.Maroon.rdInc = nil
grimoire.Maroon.colorSet = "Maroon"
grimoire.Maroon.lineClr = "Bone"
grimoire.Maroon.funcX = function(d,rd,rm)
	local mp = math.pi / 180
	d = d - rm
	--local mp = 1
	local x1 = math.sin(d * mp)
	local x2 = math.sin((d + rm) * 6 * mp)
	local pt = (rd * x1) + (rd / 2 * x2)
	return pt
	--return rd * math.sin(d * mp)^3
end
grimoire.Maroon.funcY = function(d,rd,rm)
	local mp = math.pi / 180
	d = d - rm
	--local mp = 1
	local y1 = math.cos(d * mp)
	local y2 = math.cos((d + rm) * 6 * mp)
	local pt = (rd * y1) + (rd / 2 * y2)
	return pt
	--return rd * math.cos(d * mp) - ((rd/3) * math.cos(2 * d * mp)) - ((rd/6) * math.cos(3 * d * mp)) - ((rd/4) * math.cos(4 * d * mp))
end
grimoire.Maroon.connect = nil
grimoire.Maroon.smooth = true
grimoire.Maroon.drX = nil
grimoire.Maroon.drY = nil
grimoire.Maroon.pulse = nil
--rimoire.Azure.pulse.cnt = 1
--grimoire.Azure.pulse.amt = 0.03
--grimoire.Azure.pulse.tgt = 0.44
grimoire.Maroon.dippX = 1.0
grimoire.Maroon.dippY = 1.0
grimoire.Maroon.lsSkew = 0
grimoire.Maroon.rube = nil
grimoire.Maroon.lsRadAdjX = 1.13
grimoire.Maroon.lsRadAdjY = 1.13
grimoire.Maroon.gyreVert = "Maroon"
grimoire.Maroon.gyreTex = "LunacyE"
grimoire.Maroon.trOll = 75730
grimoire.Maroon.snarks = {1860609,1860610,1860611,1860612,1860613,1860614,1860615}

--Fortune
grimoire.Gold = {}
grimoire.Gold.num = 37
grimoire.Gold.spin = 21
grimoire.Gold.degInc = 21
grimoire.Gold.rd = 21
grimoire.Gold.rdInc = nil
grimoire.Gold.colorSet = "Gold"
grimoire.Gold.lineClr = "FluorescentYellow"
grimoire.Gold.funcX = function(d,rd,rm,i)
	local mp = math.pi / 180
	d = d - rm
	--local mp = 1
	local x1 = math.sin(21 * (i+1) * mp)
	local x2 = math.sin((d + rm) * 6 * mp)
	local pt = (rd * x1) + (rd / 2 * x2)
	return pt
	--return rd * math.sin(d * mp)^3
end
grimoire.Gold.funcY = function(d,rd,rm,i)
	local mp = math.pi / 180
	d = d - rm
	--local mp = 1
	local y1 = math.cos(21 * (i+1) * mp)
	local y2 = math.cos((d + rm) * 6 * mp)
	local pt = (rd * y1) + (rd / 2 * y2)
	return pt
	--return rd * math.cos(d * mp) - ((rd/3) * math.cos(2 * d * mp)) - ((rd/6) * math.cos(3 * d * mp)) - ((rd/4) * math.cos(4 * d * mp))
end
grimoire.Gold.connect = true
grimoire.Gold.smooth = nil
grimoire.Gold.drX = nil
grimoire.Gold.drY = nil
grimoire.Gold.pulse = {}
grimoire.Gold.pulse.cnt = 1 -- current
grimoire.Gold.pulse.amt = 0.0007 -- speed
grimoire.Gold.pulse.tgt = 0.21 -- lower range
grimoire.Gold.dippX = 1.0
grimoire.Gold.dippY = 1.0
grimoire.Gold.lsSkew = 11
grimoire.Gold.rube = nil
grimoire.Gold.lsRadAdjX = 1.13
grimoire.Gold.lsRadAdjY = 1.13
grimoire.Gold.gyreVert = "Gold"
grimoire.Gold.gyreTex = "LunacyE"
grimoire.Gold.trOll = 5233
grimoire.Gold.snarks = {550805,550813,550806,550809}