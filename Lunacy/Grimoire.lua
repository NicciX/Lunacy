local _, Lunacy = ...

local function getloco(key)
	return Lunacy.GetLoco(key)
end

local function digroot(root)
	return Lunacy.digRoot(root)
end


local flashit = {}
--Marl
flashit.Marl = {}
flashit.Marl.gyretex = "LunacyE"
flashit.Marl.gyreclr = "SpaceCadet"
flashit.Marl.troll = 26375 -- DiDi RocketWrench
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

--Bone
--26375



--Spring
flashit.Spring = {}
flashit.Spring.gyretex = "LunacyE"
flashit.Spring.gyreclr = "Spring"
flashit.Spring.troll = 68967 --Lunara -- 26375 DiDi the Wrench
flashit.Spring.flashtime = 9
flashit.Spring.active = 0.81
flashit.Spring.lineclr = "Spring"
flashit.Spring.claps = 3
flashit.Spring.card = {}
flashit.Spring.card.house = "verdant"
flashit.Spring.card.affinity = 345
flashit.Spring.card.avatar = 68967 --Lunara
flashit.Spring.card.suit = "Verdant"
flashit.Spring.locoTest = function()
	return true
end
flashit.Spring.loco = {}
flashit.Spring.loco.drY = {}
flashit.Spring.loco.drY.a = -9
flashit.Spring.loco.drY.b = 9
flashit.Spring.loco.drY.y = 9
flashit.Spring.loco.drY.pong = 1
flashit.Spring.loco.drY.relax = 0.00023
flashit.Spring.loco.drY.decay = 23
flashit.Spring.loco.lsRadAdjY = 0.77
flashit.Spring.lucky = 0.77
flashit.Spring.sigil = math.random(777)
flashit.Spring.cast = {"~*~ Ahhh, the great outdoors! ~*~", "~*~ Spring showers, bring lovely flowers ~*~"}

--Cobalt
flashit.Cobalt = {}
flashit.Cobalt.gyretex = "LunacyE"
flashit.Cobalt.gyreclr = "Cobalt"
flashit.Cobalt.troll = 115505
flashit.Cobalt.flashtime = 7
flashit.Cobalt.active = 1.44
flashit.Cobalt.lineclr = "Cobalt"
flashit.Cobalt.claps = 3
flashit.Cobalt.connect = false
flashit.Cobalt.card = {}
flashit.Cobalt.card.house = "Azure"
flashit.Cobalt.lsSpinOver = 17
flashit.Cobalt.card.affinity = 321
flashit.Cobalt.card.avatar = 115505
flashit.Cobalt.card.suit = "Azure"
flashit.Cobalt.locoTest = function()
	if getloco(drX) then
		return
	end
	return true
end
flashit.Cobalt.loco = {}
flashit.Cobalt.loco.drX = {}
flashit.Cobalt.loco.drX.a = -9
flashit.Cobalt.loco.drX.b = 9
flashit.Cobalt.loco.drX.x = 9
flashit.Cobalt.loco.drX.pong = 1
flashit.Cobalt.loco.drX.relax = 0.00027
flashit.Cobalt.loco.drX.decay = 27
flashit.Cobalt.loco.lsRadAdjX = 0.77
flashit.Cobalt.lucky = 1.77
flashit.Cobalt.sigil = math.random(777)
flashit.Cobalt.cast = {
	").`B´.) You'll find me wherever the action is 7^~",
	").`B´.) Loads of forgotten knowledge is within our grasp! 7^~",
	").`B´.) Enquiring minds!, just got to know.",
}
 
--Palatinate - The Alchemist
flashit.Palatinate = {}
flashit.Palatinate.gyretex = "LunacyE"
flashit.Palatinate.gyreclr = "Palatinate"
--flashit.Gold.troll = 26375
flashit.Palatinate.flashtime = 7.11
flashit.Palatinate.lsSpinOver = 71
flashit.Palatinate.overTime = 7.11
flashit.Palatinate.active = 1.77
flashit.Palatinate.lineclr = "Palatinate"
flashit.Palatinate.claps = 7
flashit.Palatinate.card = {}
flashit.Palatinate.card.house = "Palatinate"
flashit.Palatinate.card.affinity = 1777
flashit.Palatinate.card.flip = function()
	return 0.69 + tonumber(getloco("active")) * 0.0037
end --tonumber(getloco("balance")) * 0.00001
flashit.Palatinate.card.avatar = 30881
flashit.Palatinate.card.suit = "Palatinate"
flashit.Palatinate.card.loco = {}
flashit.Palatinate.card.loco.balance = 0
--flashit.Gold.loco = {}
flashit.Palatinate.lucky = 7.77
flashit.Palatinate.cast = "~*~ Good News Everyone! ~*~"

--Napoli - The Scribe
flashit.Napoli = {}
flashit.Napoli.gyretex = "LunacyE"
flashit.Napoli.gyreclr = "Napoli"
--flashit.Gold.troll = 26375
flashit.Napoli.flashtime = 5.11
flashit.Napoli.lsSpinOver = 51
flashit.Napoli.overTime = 7.11
flashit.Napoli.active = 1.77
flashit.Napoli.lineclr = "MayaBlue"
flashit.Napoli.claps = 7
flashit.Napoli.card = {}
flashit.Napoli.card.house = "Napoli"
flashit.Napoli.card.affinity = 1551
flashit.Napoli.card.flip = function()
	return 1.23 + tonumber(getloco("lucky")) * 0.001
end --tonumber(getloco("balance")) * 0.00001
flashit.Napoli.card.avatar = 54841
flashit.Napoli.card.suit = "Napoli"
flashit.Napoli.card.loco = {}
flashit.Napoli.card.loco.balance = 0
--flashit.Gold.loco = {}
flashit.Napoli.lucky = 7.77
flashit.Napoli.cast = "~*~ Fortune favors the Bold! ~*~"

--Flax - The Weaver
flashit.Flax = {}
flashit.Flax.gyretex = "LunacyE"
flashit.Flax.gyreclr = "Flax"
--flashit.Gold.troll = 26375
flashit.Flax.flashtime = 5.11
flashit.Flax.lsSpinOver = 51
flashit.Flax.overTime = 7.11
flashit.Flax.active = 1.77
flashit.Flax.lineclr = "MayaBlue"
flashit.Flax.claps = 7
flashit.Flax.card = {}
flashit.Flax.card.house = "Flax"
flashit.Flax.card.affinity = 2121
flashit.Flax.card.flip = function()
	return 1.42 + tonumber(getloco("lucky")) * 0.00021
end --tonumber(getloco("balance")) * 0.00001
flashit.Flax.card.avatar = 54841
flashit.Flax.card.suit = "Flax"
flashit.Flax.card.loco = {}
flashit.Flax.card.loco.balance = 0
--flashit.Gold.loco = {}
flashit.Flax.lucky = 7.77
flashit.Flax.cast = "~*~ The Threads of Fate ~*~"

--PrussianBlue - The Enchantress
flashit.PrussianBlue = {}
flashit.PrussianBlue.gyretex = "LunacyE"
flashit.PrussianBlue.gyreclr = "PrussianBlue"
--flashit.Gold.troll = 26375
flashit.PrussianBlue.flashtime = 3.69
flashit.PrussianBlue.lsSpinOver = 69
flashit.PrussianBlue.overTime = 6.9
flashit.PrussianBlue.active = 1.69
flashit.PrussianBlue.lineclr = "Butter"
flashit.PrussianBlue.claps = 6
flashit.PrussianBlue.card = {}
flashit.PrussianBlue.card.house = "PrussianBlue"
flashit.PrussianBlue.card.affinity = 1691
flashit.PrussianBlue.card.flip = function()
	return 1.69 + tonumber(getloco("degInc")) * 0.021
end --tonumber(getloco("balance")) * 0.00001
flashit.PrussianBlue.card.avatar = 54841
flashit.PrussianBlue.card.suit = "PrussianBlue"
flashit.PrussianBlue.card.loco = {}
flashit.PrussianBlue.card.loco.balance = 0
--flashit.Gold.loco = {}
flashit.PrussianBlue.lucky = 6.9
flashit.PrussianBlue.diSTurbed = -0.69
flashit.PrussianBlue.cast = "~*~ How Enchanting! ~*~"

--Chocolate - The Chef
flashit.Chocolate = {}
flashit.Chocolate.gyretex = "LunacyE"
flashit.Chocolate.gyreclr = "Chocolate"
--flashit.Gold.troll = 26375
flashit.Chocolate.flashtime = 3.69
flashit.Chocolate.lsSpinOver = 69
flashit.Chocolate.overTime = 6.9
flashit.Chocolate.active = 1.69
flashit.Chocolate.lineclr = "Butter"
flashit.Chocolate.claps = 6
flashit.Chocolate.card = {}
flashit.Chocolate.card.house = "chocolate"
flashit.Chocolate.card.affinity = 1441
flashit.Chocolate.card.flip = function()
	local l = tonumber(getloco("lucky"))
	if getloco("wellfed") then
		return 0.84 + l * 0.000084
	else
		return 0.48 + l * 0.000048
	end
end --tonumber(getloco("balance")) * 0.00001
flashit.Chocolate.card.avatar = 54841
flashit.Chocolate.card.suit = "Chocolate"
flashit.Chocolate.card.loco = {}
flashit.Chocolate.card.loco.balance = 0
--flashit.Gold.loco = {}
flashit.Chocolate.lucky = 1.9
flashit.Chocolate.diSTurbed = -0.29
flashit.Chocolate.cast = "~*~ How Enchanting! ~*~"

--FluorescentBlue - Patience - The Angler
flashit.FluorescentBlue = {}
flashit.FluorescentBlue.gyretex = "LunacyE"
flashit.FluorescentBlue.gyreclr = "FluorescentBlue"
--flashit.Gold.troll = 26375
flashit.FluorescentBlue.flashtime = 3.77
flashit.FluorescentBlue.lsSpinOver = 77
flashit.FluorescentBlue.overTime = 7.7
flashit.FluorescentBlue.active = 1.77
flashit.FluorescentBlue.lineclr = "Eggshell"
flashit.FluorescentBlue.claps = 7
flashit.FluorescentBlue.card = {}
flashit.FluorescentBlue.card.house = "fluorescentblue"
flashit.FluorescentBlue.card.affinity = 1111
flashit.FluorescentBlue.card.flip = function()
	local l = tonumber(getloco("lucky"))
	if getloco("wellfed") then
		return 0.77 + l * 0.000077
	else
		return 0.37 + l * 0.000037
	end
end --tonumber(getloco("balance")) * 0.00001
flashit.FluorescentBlue.card.avatar = 13099
flashit.FluorescentBlue.card.suit = "FluorescentBlue"
flashit.FluorescentBlue.card.loco = {}
flashit.FluorescentBlue.card.loco.balance = 0
--flashit.Gold.loco = {}
flashit.FluorescentBlue.lucky = 7.77
flashit.FluorescentBlue.diSTurbed = -6.66
flashit.FluorescentBlue.cast = "~*~ How Enchanting! ~*~"

--The Engineer
flashit.Bronze = {}
flashit.Bronze.gyretex = "LunacyE"
flashit.Bronze.gyreclr = "Bronze"
--flashit.Gold.troll = 26375
flashit.Bronze.flashtime = 1.23
flashit.Bronze.lsSpinOver = 23
flashit.Bronze.overTime = 2.3
flashit.Bronze.active = 1.23
flashit.Bronze.lineclr = "Bronze"
flashit.Bronze.claps = 6
flashit.Bronze.card = {}
flashit.Bronze.card.house = "bronze"
flashit.Bronze.card.affinity = 1234
flashit.Bronze.card.flip = function()
	local l = tonumber(getloco("lucky"))
	if getloco("wellfed") then
		return 1.23 + l * 0.000123
	else
		return 0.23 + l * 0.000023
	end
end --tonumber(getloco("balance")) * 0.00001
flashit.Bronze.card.avatar = 54841
flashit.Bronze.card.suit = "Bronze"
flashit.Bronze.card.loco = {}
flashit.Bronze.card.loco.balance = 0
--flashit.Gold.loco = {}
flashit.Bronze.lucky = -0.1234
flashit.Bronze.diSTurbed = -1.234
flashit.Bronze.cast = "~*~ ~~~~~~ ~*~"

--Shamrock
flashit.Shamrock = {}
flashit.Shamrock.gyretex = "LunacyE"
flashit.Shamrock.gyreclr = "Shamrock"
--flashit.Gold.troll = 26375
flashit.Shamrock.flashtime = 7.11
flashit.Shamrock.lsSpinOver = 71
flashit.Shamrock.overTime = 7.11
flashit.Shamrock.active = 0.66
flashit.Shamrock.lineclr = "Shamrock"
flashit.Shamrock.claps = 7
flashit.Shamrock.card = {}
flashit.Shamrock.card.house = "shamrock"
flashit.Shamrock.card.affinity = 7777
flashit.Shamrock.card.flip = function()
	return 0.77 + tonumber(getloco("lucky")) * 0.001
end --tonumber(getloco("balance")) * 0.00001
flashit.Shamrock.card.avatar = 54841
flashit.Shamrock.card.suit = "Shamrock"
flashit.Shamrock.card.loco = {}
flashit.Shamrock.card.loco.balance = 0
--flashit.Gold.loco = {}
flashit.Shamrock.lucky = 7.77
flashit.Shamrock.cast = "~*~ Fortune favors the Bold! ~*~"

--Death/The Underworld
flashit.Obsidian = {}
flashit.Obsidian.gyretex = "LunacyE"
flashit.Obsidian.gyreclr = "Obsidian"
--flashit.Gold.troll = 26375
flashit.Obsidian.flashtime = 1.69
flashit.Obsidian.lsSpinOver = 69
flashit.Obsidian.overTime = 3.6
flashit.Obsidian.active = 1.66
flashit.Obsidian.lineclr = "Obsidian"
flashit.Obsidian.claps = 6
flashit.Obsidian.card = {}
flashit.Obsidian.card.house = "obsidian"
flashit.Obsidian.card.affinity = 777
flashit.Obsidian.card.flip = function()
	local l = tonumber(getloco("diSTurbed"))
	if getloco("dead") then
		return 6.66 + l * 0.0666
	else
		return 0.33 + l * 0.00111
	end
end --tonumber(getloco("balance")) * 0.00001
flashit.Obsidian.card.avatar = 54841
flashit.Obsidian.card.suit = "Obsidian"
flashit.Obsidian.card.loco = {}
flashit.Obsidian.card.loco.balance = 0
--flashit.Gold.loco = {}
flashit.Obsidian.lucky = -6.66
flashit.Obsidian.diSTurbed = 6.66
flashit.Obsidian.cast = "~*~ ~~~~~~ ~*~"

--Arcana
flashit.Feldgrau = {}
flashit.Feldgrau.gyretex = "LunacyE"
flashit.Feldgrau.gyreclr = "Feldgrau"
--flashit.Gold.troll = 26375
flashit.Feldgrau.flashtime = 1.69
flashit.Feldgrau.lsSpinOver = 69
flashit.Feldgrau.overTime = 3.6
flashit.Feldgrau.active = 1.66
flashit.Feldgrau.lineclr = "Feldgrau"
flashit.Feldgrau.claps = 3
flashit.Feldgrau.card = {}
flashit.Feldgrau.card.house = "feldgrau"
flashit.Feldgrau.card.affinity = 1331
flashit.Feldgrau.card.flip = function()
	local l = tonumber(getloco("lucky"))
	if getloco("wellfed") then
		return 0.66 + l * 0.000333
	else
		return 0.33 + l * 0.000111
	end
end --tonumber(getloco("balance")) * 0.00001
flashit.Feldgrau.card.avatar = 54841
flashit.Feldgrau.card.suit = "Feldgrau"
flashit.Feldgrau.card.loco = {}
flashit.Feldgrau.card.loco.balance = 0
--flashit.Gold.loco = {}
flashit.Feldgrau.lucky = 3.33
flashit.Feldgrau.diSTurbed = 1.11
flashit.Feldgrau.cast = "~*~ How Enchanting! ~*~"

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
flashit.Gold.card.affinity = 343
flashit.Gold.card.flip = function()
	return 0.77 + tonumber(getloco("balance")) * 0.00000001
end --tonumber(getloco("balance")) * 0.00001
flashit.Gold.card.avatar = 54841
flashit.Gold.card.suit = "Gold"
flashit.Gold.card.loco = {}
flashit.Gold.card.loco.balance = 0
--flashit.Gold.loco = {}
--flashit.Gold.lucky = 0.77
flashit.Gold.lucky = function(lUCk) return lUCk * (1 + math.random() * 0.003777) end
flashit.Gold.diSTurbed = function(dUCk) return dUCk * (1 + math.random() * 0.003666) end
flashit.Gold.cast = "~*~ Time is money friend! ~*~"

--Maroon - Luxury - The Prince
flashit.Maroon = {}
flashit.Maroon.gyretex = "LunacyE"
flashit.Maroon.gyreclr = "Maroon"
--flashit.Gold.troll = 26375
flashit.Maroon.flashtime = 1.11
flashit.Maroon.lsSpinOver = 31
flashit.Maroon.overTime = 1.11
flashit.Maroon.active = 1.77
flashit.Maroon.lineclr = "Chartreuse"
flashit.Maroon.claps = 7
flashit.Maroon.card = {}
flashit.Maroon.card.house = "Maroon"
flashit.Maroon.card.affinity = 777
flashit.Maroon.card.flip = function()
	return 0.47 + tonumber(getloco("luxury")) * 0.0047
end --tonumber(getloco("balance")) * 0.00001
flashit.Maroon.card.avatar = 30881
flashit.Maroon.card.suit = "Maroon"
flashit.Maroon.card.loco = {}
flashit.Maroon.card.loco.balance = 0
--flashit.Gold.loco = {}
flashit.Maroon.lucky = -0.077
flashit.Maroon.cast = "~*~ A body doesn't get into this shape by accident! ~*~"

--Parchement - Duty/Obligation
flashit.Parchment = {}
flashit.Parchment.gyretex = "LunacyE"
flashit.Parchment.gyreclr = "Parchment"
--flashit.Gold.troll = 26375
flashit.Parchment.flashtime = 7.11
flashit.Parchment.lsSpinOver = 71
flashit.Parchment.overTime = 7.11
flashit.Parchment.active = 0.66
flashit.Parchment.lineclr = "Parchment"
flashit.Parchment.claps = 3
flashit.Parchment.card = {}
flashit.Parchment.card.house = "Parchment"
flashit.Parchment.card.affinity = 343
flashit.Parchment.card.flip = function()
	return 0.67 + tonumber(getloco("diSTurbed")) * 0.00000067
end --tonumber(getloco("balance")) * 0.00001
flashit.Parchment.card.avatar = 36758
flashit.Parchment.card.suit = "Parchment"
flashit.Parchment.card.loco = {}
flashit.Parchment.card.loco.balance = 0
--flashit.Gold.loco = {}
--flashit.Gold.lucky = 0.77
flashit.Parchment.lucky = function(lUCk) return lUCk * (1 + math.random() * 0.003777) end
flashit.Parchment.diSTurbed = function(dUCk) return dUCk * (1 + math.random() * 0.003666) end
flashit.Parchment.cast = "~*~ Time is money friend! ~*~"

--Bachus
flashit.NeonGreen = {}
flashit.NeonGreen.gyretex = "LunacyE"
flashit.NeonGreen.gyreclr = "NeonGreen"
flashit.NeonGreen.lsSpinOver = 71
flashit.NeonGreen.overTime = 7.11
flashit.NeonGreen.active = 0.0169
flashit.NeonGreen.lineclr = "NeonGreen"
flashit.NeonGreen.claps = 3
flashit.NeonGreen.card = {}
flashit.NeonGreen.card.house = "NeonGreen"
flashit.NeonGreen.card.affinity = 16996
flashit.NeonGreen.card.flip = function()
	return getloco("digroot")
	--return (0.0369 + tonumber(getloco("diSTurbed")) / 1669)
end
flashit.NeonGreen.card.avatar = 128099
flashit.NeonGreen.card.suit = "NeonGreen"
flashit.NeonGreen.card.loco = {}
flashit.NeonGreen.card.loco.balance = 0
flashit.NeonGreen.locoTest = function()
	return (getloco("spell") ~= "NeonGreen")
end
flashit.NeonGreen.loco = {}
flashit.NeonGreen.loco.dippX = 0.72
flashit.NeonGreen.loco.dippY = 0.72
flashit.NeonGreen.loco.drX = nil
flashit.NeonGreen.loco.drY = nil
flashit.NeonGreen.loco.pulse = {}
flashit.NeonGreen.loco.pulse.cnt = 1
flashit.NeonGreen.loco.pulse.amt = 0.03
flashit.NeonGreen.loco.pulse.tgt = 0.42
flashit.NeonGreen.loco.flashTime = 3
flashit.NeonGreen.diSTurbed = function(dBd) return dBd * (1 + math.random() * 0.00234) end
flashit.NeonGreen.lucky = function(lUCk) return lUCk * (1 + math.random() * 0.00432) end
flashit.NeonGreen.sigil = math.random(777)
flashit.NeonGreen.cast = "~^ Party Time! ^~"

--Scarlet
flashit.Scarlet = {}
flashit.Scarlet.gyretex = "LunacyE"
flashit.Scarlet.gyreclr = "Scarlet"
--flashit.Gold.troll = 26375
--flashit.Scarlet.flashtime = 3
flashit.Scarlet.lsSpinOver = 71
flashit.Scarlet.overTime = 7.11
flashit.Scarlet.active = 0.0169
flashit.Scarlet.lineclr = "Scarlet"
flashit.Scarlet.claps = 3
flashit.Scarlet.card = {}
flashit.Scarlet.card.house = "scarlet"
flashit.Scarlet.card.affinity = 16996
flashit.Scarlet.card.flip = function()
	return (0.01691 + getloco("diSTurbed") / 16969)
	--return (0.0369 + tonumber(getloco("diSTurbed")) / 1669)
end
flashit.Scarlet.card.avatar = 68967
flashit.Scarlet.card.suit = "Scarlet"
flashit.Scarlet.card.loco = {}
flashit.Scarlet.card.loco.balance = 0
flashit.Scarlet.locoTest = function()
	--local sp = getloco("spell")
	--sp = sp ~= "Scarlet"
	return (getloco("spell") ~= "Scarlet")
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
flashit.Scarlet.loco.flashTime = 3
--flashit.Gold.lucky = 0.77
--flashit.Scarlet.diSTurbed = function(dBd) return dBd * (1 - math.random() * 0.00313) end
flashit.Scarlet.lucky = function(lUCk) return lUCk * (1 + math.random() * 0.00131) end
flashit.Scarlet.sigil = math.random(777)
flashit.Scarlet.cast = "~^ Say Please ^~"

Lunacy.DrawCard = function(card)
	if flashit[card] then
		return flashit[card]
	end
end

local grimoire = {}

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
grimoire.Verdant.lsRadAdjX = 1.23
grimoire.Verdant.lsRadAdjY = 1.23
grimoire.Verdant.gyreVert = "Verdant"
grimoire.Verdant.gyreTex = "LunacyM"
grimoire.Verdant.trOll = 68967 --37154 -- Singing Sunflower
grimoire.Verdant.snarks = {547788,547796,547785,547790}

--Earth
grimoire.Azure = {
    ["num"] = 36,
    ["spin"] = 23,
    ["degInc"] = 17,
    ["rd"] = 21,
    ["rdInc"] = nil,
    ["colorSet"] = "Azure",
    ["lineClr"] = "Smoke",
    ["funcX"] = function(d,rd,rm)
		local mp = math.pi / 180
		d = d - rm
		--local mp = 1
		local x1 = math.sin(d * mp)
		local x2 = math.sin((d + rm) * 6 * mp)
		local pt = (rd * x1) + (rd / 2 * x2)
		return pt
	end,
    ["funcY"] = function(d,rd,rm)
		local mp = math.pi / 180
		d = d - rm
		--local mp = 1
		local y1 = math.cos(d * mp)
		local y2 = math.cos((d + rm) * 6 * mp)
		local pt = (rd * y1) + (rd / 2 * y2)
		return pt
	end,
    ["connect"] = nil,
    ["smooth"] = true,
    ["drX"] = nil,
    ["drY"] = nil,
    ["pulse"] = nil,
    ["dippX"] = 1.0,
    ["dippY"] = 1.0,
    ["lsSkew"] = 0,
    ["rube"] = nil,
	["gizmo"] = 0,
    ["lsRadAdjX"] = 1.13,
    ["lsRadAdjY"] = 1.13,
    ["gyreVert"] = "Azure",
    ["gyreTex"] = "LunacyE",
    ["trOll"] = 115505,
    ["doMMy"] = "Buff",
    ["snarks"] = {545429,545476,545489,545491},
}

--The Alchemist
grimoire.Palatinate = {}
grimoire.Palatinate.num = 33
grimoire.Palatinate.spin = 6
grimoire.Palatinate.degInc = 9
grimoire.Palatinate.rd = 21
grimoire.Palatinate.rdInc = nil
grimoire.Palatinate.colorSet = "Palatinate"
grimoire.Palatinate.lineClr = "Silver"
grimoire.Palatinate.funcX = function(d,rd,rm)
	local mp = math.pi / 180
	d = d - rm
	--local mp = 1
	local x1 = math.sin(d * mp)
	local x2 = math.sin((d + rm) * 7 * mp)
	local pt = (rd * x1) + (rd / 2 * x2)
	return pt
end
grimoire.Palatinate.funcY = function(d,rd,rm)
	local mp = math.pi / 180
	d = d - rm
	--local mp = 1
	local y1 = math.cos(d * mp)
	local y2 = math.cos((d + rm) * 7 * mp)
	local pt = (rd * y1) + (rd / 2 * y2)
	return pt
end
grimoire.Palatinate.connect = nil
grimoire.Palatinate.smooth = nil
grimoire.Palatinate.drX = nil
grimoire.Palatinate.drY = nil
--grimoire.Palatinate.trOck = {}
--grimoire.Palatinate.trOck.anim = 69 --69
--grimoire.Palatinate.trOck.rot = 0
--grimoire.Palatinate.trOck.camdis = 1.0
--grimoire.Palatinate.trOck.offX = 14
--grimoire.Palatinate.trOck.offY = -10
grimoire.Palatinate.pulse = {}
grimoire.Palatinate.pulse.cnt = 0.77
grimoire.Palatinate.pulse.amt = 0.00077
grimoire.Palatinate.pulse.tgt = 0.07
grimoire.Palatinate.dippX = 1.0
grimoire.Palatinate.dippY = 1.0
grimoire.Palatinate.lsSkew = 7
grimoire.Palatinate.rube = nil
grimoire.Palatinate.lsRadAdjX = 1.11
grimoire.Palatinate.lsRadAdjY = 1.11
grimoire.Palatinate.gyreVert = "Palatinate"
grimoire.Palatinate.gyreTex = "LunacyE"
grimoire.Palatinate.trOll = 30881 -- Professor Putricide
grimoire.Palatinate.snarks = {558452,558418,558404,558387}

--The Scribe
grimoire.Napoli = {}
grimoire.Napoli.num = 33
grimoire.Napoli.spin = 6
grimoire.Napoli.degInc = 4.5
grimoire.Napoli.rd = 21
grimoire.Napoli.rdInc = nil
grimoire.Napoli.colorSet = "Napoli"
grimoire.Napoli.lineClr = "MayaBlue"
grimoire.Napoli.funcX = function(d,rd,rm)
	local mp = math.pi / 180
	d = d - rm
	--local mp = 1
	local x1 = math.sin(d * mp)
	local x2 = math.sin((d + rm) * 7 * mp)
	local pt = (rd * x1) + (rd / 2 * x2)
	return pt
end
grimoire.Napoli.funcY = function(d,rd,rm)
	local mp = math.pi / 180
	d = d - rm
	--local mp = 1
	local y1 = math.cos(d * mp)
	local y2 = math.cos((d + rm) * 7 * mp)
	local pt = (rd * y1) + (rd / 2 * y2)
	return pt
end
grimoire.Napoli.connect = nil
grimoire.Napoli.smooth = nil
grimoire.Napoli.drX = nil
grimoire.Napoli.drY = nil
grimoire.Napoli.pulse = {}
grimoire.Napoli.pulse.cnt = 0.77
grimoire.Napoli.pulse.amt = 0.00077
grimoire.Napoli.pulse.tgt = 0.07
grimoire.Napoli.dippX = 1.0
grimoire.Napoli.dippY = 1.0
grimoire.Napoli.lsSkew = 7
grimoire.Napoli.rube = nil
grimoire.Napoli.lsRadAdjX = 1.11
grimoire.Napoli.lsRadAdjY = 1.11
grimoire.Napoli.gyreVert = "Napoli"
grimoire.Napoli.gyreTex = "LunacyE"
grimoire.Napoli.trOll = 14855 -- Silas Darkmoon
grimoire.Napoli.snarks = {550478,550466,550472,550473}

--The Weaver
grimoire.Flax = {}
grimoire.Flax.num = 33
grimoire.Flax.spin = 6
grimoire.Flax.degInc = 4.5
grimoire.Flax.rd = 21
grimoire.Flax.rdInc = nil
grimoire.Flax.colorSet = "Flax"
grimoire.Flax.lineClr = "MayaBlue"
grimoire.Flax.funcX = function(d,rd,rm)
	local mp = math.pi / 180
	d = d - rm
	--local mp = 1
	local x1 = math.sin(d * mp)
	local x2 = math.sin((d + rm) * 7 * mp)
	local pt = (rd * x1) + (rd / 2 * x2)
	return pt
end
grimoire.Flax.funcY = function(d,rd,rm)
	local mp = math.pi / 180
	d = d - rm
	--local mp = 1
	local y1 = math.cos(d * mp)
	local y2 = math.cos((d + rm) * 7 * mp)
	local pt = (rd * y1) + (rd / 2 * y2)
	return pt
end
grimoire.Flax.connect = nil
grimoire.Flax.smooth = nil
grimoire.Flax.drX = nil
grimoire.Flax.drY = nil
grimoire.Flax.pulse = {}
grimoire.Flax.pulse.cnt = 0.77
grimoire.Flax.pulse.amt = 0.00077
grimoire.Flax.pulse.tgt = 0.07
grimoire.Flax.dippX = 1.0
grimoire.Flax.dippY = 1.0
grimoire.Flax.lsSkew = 7
grimoire.Flax.rube = nil
grimoire.Flax.lsRadAdjX = 1.11
grimoire.Flax.lsRadAdjY = 1.11
grimoire.Flax.gyreVert = "Flax"
grimoire.Flax.gyreTex = "LunacyE"
grimoire.Flax.trOll = 24877 -- Chromie
grimoire.Flax.snarks = {3049652,3049653,3049655,3049658}

--The Enchantress
grimoire.PrussianBlue = {}
grimoire.PrussianBlue.num = 17
grimoire.PrussianBlue.spin = 27
grimoire.PrussianBlue.degInc = 113
grimoire.PrussianBlue.rd = 23
grimoire.PrussianBlue.rdInc = nil
grimoire.PrussianBlue.colorSet = "PrussianBlue"
grimoire.PrussianBlue.lineClr = "Vixen"
grimoire.PrussianBlue.funcX = function(d,rd,rm)
	local mp = math.pi / 180
	d = d - rm
	--local mp = 1
	local x1 = math.sin(d * mp)
	local x2 = math.sin((d + rm) * 1 * mp)
	local pt = (rd * x1) + (rd / 2 * x2)
	return pt
end
grimoire.PrussianBlue.funcY = function(d,rd,rm)
	local mp = math.pi / 180
	d = d - rm
	--local mp = 1
	local y1 = math.cos(d * mp)
	local y2 = math.cos((d + rm) * 1 * mp)
	local pt = (rd * y1) + (rd / 2 * y2)
	return pt
end
grimoire.PrussianBlue.connect = true
grimoire.PrussianBlue.smooth = nil
grimoire.PrussianBlue.drX = nil
grimoire.PrussianBlue.drY = nil
grimoire.PrussianBlue.pulse = {}
grimoire.PrussianBlue.pulse.cnt = 1.0
grimoire.PrussianBlue.pulse.amt = 0.00169
grimoire.PrussianBlue.pulse.tgt = 0.169
grimoire.PrussianBlue.dippX = 1.0
grimoire.PrussianBlue.dippY = 0.91
grimoire.PrussianBlue.lsSkew = 18
grimoire.PrussianBlue.rube = nil
grimoire.PrussianBlue.lsRadAdjX = 1.13
grimoire.PrussianBlue.lsRadAdjY = 1.13
grimoire.PrussianBlue.gyreVert = "PrussianBlue"
grimoire.PrussianBlue.gyreTex = "LunacyE"
grimoire.PrussianBlue.trOll = 14855 -- Silas Darkmoon
grimoire.PrussianBlue.snarks = {550478,550466,550472,550473}

--The Chef
grimoire.Chocolate = {}
grimoire.Chocolate.num = 18
grimoire.Chocolate.spin = 27
grimoire.Chocolate.degInc = 169
grimoire.Chocolate.rd = 18
grimoire.Chocolate.rdInc = 0
grimoire.Chocolate.colorSet = "Chocolate"
grimoire.Chocolate.lineClr = "Butter"
grimoire.Chocolate.funcX = function(d,rd,rm)
	local mp = math.pi / 180
	d = d - rm
	local j = mod(math.abs(d),360)
	rd = rd - math.floor(j / 120) * 0.18
	local x1 = math.sin(d * mp)
	local x2 = math.sin((d + rm) * 1 * mp)
	local pt = (rd * x1) + (rd / 2 * x2)
	return pt
end
grimoire.Chocolate.funcY = function(d,rd,rm)
	local mp = math.pi / 180
	d = d - rm
	local j = mod(math.abs(d),360)
	rd = rd - math.floor(j / 120) * 0.18
	local y1 = math.cos(d * mp)
	local y2 = math.cos((d + rm) * 1 * mp)
	local pt = (rd * y1) + (rd / 2 * y2)
	return pt
end
grimoire.Chocolate.connect = nil
grimoire.Chocolate.smooth = nil
grimoire.Chocolate.drX = nil
grimoire.Chocolate.drY = nil
grimoire.Chocolate.pulse = {}
grimoire.Chocolate.pulse.cnt = 1.0
grimoire.Chocolate.pulse.amt = 0.00169
grimoire.Chocolate.pulse.tgt = 0.169
grimoire.Chocolate.dippX = 1.0
grimoire.Chocolate.dippY = 0.91
grimoire.Chocolate.lsSkew = 18
grimoire.Chocolate.rube = nil
grimoire.Chocolate.lsRadAdjX = 1.13
grimoire.Chocolate.lsRadAdjY = 1.13
grimoire.Chocolate.orbit = 0
grimoire.Chocolate.orbinc = 13
grimoire.Chocolate.orbrad = 3
grimoire.Chocolate.gyreVert = "Chocolate"
grimoire.Chocolate.gyreTex = "LunacyE"
grimoire.Chocolate.doMMy = "Chocolate"
grimoire.Chocolate.trOll = 42360 --Jian Ironpaw --1305 -- Capt Cookie
grimoire.Chocolate.snarks = {632512,632514,632506}

--Patience - Fishing
grimoire.FluorescentBlue = {}
grimoire.FluorescentBlue.num = 29
grimoire.FluorescentBlue.spin = 14.4
grimoire.FluorescentBlue.degInc = 4.32
grimoire.FluorescentBlue.rd = 21
grimoire.FluorescentBlue.rdInc = nil
grimoire.FluorescentBlue.colorSet = "FluorescentBlue"
grimoire.FluorescentBlue.lineClr = "Eggshell"
grimoire.FluorescentBlue.funcX = function(d,rd,rm)
	local mp = math.pi / 180
	d = d - rm
	local j = math.floor(mod(math.abs(d),360)/3)*2
	rd = rd - math.floor(j / 144) * 0.18
	local x1 = math.sin(d * mp)
	local x2 = math.sin((d + rm) * 1 * mp)
	local pt = (rd * x1) + (rd / 4.2 * x2)
	return pt
end
grimoire.FluorescentBlue.funcY = function(d,rd,rm)
	local mp = math.pi / 180
	d = d - rm
	local j = math.floor(mod(math.abs(d),360)/3)*2
	rd = rd - math.floor(j / 144) * 0.18
	local y1 = math.cos(d * mp)
	local y2 = math.cos((d + rm) * 1 * mp)
	local pt = (rd * y1) + (rd / 4.2 * y2)
	return pt
end
grimoire.FluorescentBlue.connect = nil
grimoire.FluorescentBlue.smooth = nil
grimoire.FluorescentBlue.drX = nil
grimoire.FluorescentBlue.drY = nil
grimoire.FluorescentBlue.pulse = {}
grimoire.FluorescentBlue.pulse.cnt = 1.0
grimoire.FluorescentBlue.pulse.amt = 0.00144
grimoire.FluorescentBlue.pulse.tgt = 0.432
grimoire.FluorescentBlue.dippX = 1.0
grimoire.FluorescentBlue.dippY = 0.91
grimoire.FluorescentBlue.lsSkew = 18
grimoire.FluorescentBlue.rube = nil
grimoire.FluorescentBlue.lsRadAdjX = 1.13
grimoire.FluorescentBlue.lsRadAdjY = 1.13
grimoire.FluorescentBlue.orbit = 0
grimoire.FluorescentBlue.orbinc = -17
grimoire.FluorescentBlue.orbrad = 4
grimoire.FluorescentBlue.gyreVert = "FluorescentBlue"
grimoire.FluorescentBlue.gyreTex = "LunacyE"
grimoire.FluorescentBlue.doMMy = "FluorescentBlue"
grimoire.FluorescentBlue.trOll = 13099 --Nat Pagle
grimoire.FluorescentBlue.snarks = {552196,552200,552210}

--Arcana
grimoire.Feldgrau = {}
grimoire.Feldgrau.num = 77
grimoire.Feldgrau.spin = 4
grimoire.Feldgrau.degInc = 7.7
grimoire.Feldgrau.rd = 21
grimoire.Feldgrau.rdInc = nil
grimoire.Feldgrau.colorSet = "Silver"
grimoire.Feldgrau.lineClr = "Feldgrau"
grimoire.Feldgrau.funcX = function(d,rd,rm)
	local mp = math.pi / 180
	d = d - rm
	--local mp = 1
	local x1 = math.sin(d * mp)
	local x2 = math.sin((d + rm) * 6 * mp)
	local pt = (rd * x1) + (rd / 2 * x2)
	return pt
end
grimoire.Feldgrau.funcY = function(d,rd,rm)
	local mp = math.pi / 180
	d = d - rm
	--local mp = 1
	local y1 = math.cos(d * mp)
	local y2 = math.cos((d + rm) * 6 * mp)
	local pt = (rd * y1) + (rd / 2 * y2)
	return pt
end
grimoire.Feldgrau.connect = nil
grimoire.Feldgrau.smooth = nil
grimoire.Feldgrau.drX = nil
grimoire.Feldgrau.drY = nil
grimoire.Feldgrau.sticky = 21
grimoire.Feldgrau.pulse = {}
grimoire.Feldgrau.pulse.cnt = 0.77
grimoire.Feldgrau.pulse.amt = 0.00077
grimoire.Feldgrau.pulse.tgt = 0.07
grimoire.Feldgrau.dippX = 1.0
grimoire.Feldgrau.dippY = 1.0
grimoire.Feldgrau.lsSkew = 7
grimoire.Feldgrau.rube = nil
grimoire.Feldgrau.lsRadAdjX = 1.11
grimoire.Feldgrau.lsRadAdjY = 1.11
grimoire.Feldgrau.gyreVert = "Silver"
grimoire.Feldgrau.gyreTex = "LunacyE"
grimoire.Feldgrau.doMMy = "Feldgrau"
grimoire.Feldgrau.trOll = 14855 -- Silas Darkmoon
grimoire.Feldgrau.snarks = {550478,550466,550472,550473}

--The Engineer
grimoire.Bronze = {}
grimoire.Bronze.num = 37
grimoire.Bronze.spin = 19
grimoire.Bronze.degInc = 19
grimoire.Bronze.rd = 19
grimoire.Bronze.rdInc = nil
grimoire.Bronze.colorSet = "Bronze"
grimoire.Bronze.lineClr = "Indigo"
grimoire.Bronze.ring = "Silver"
grimoire.Bronze.funcX = function(d,rd,rm)
	local mp = math.pi / 180
	d = d - rm
	local j = mod(math.abs(d),360)
	rd = rd - math.floor(j / 120) * 0.19
	local x1 = math.sin(d * mp)
	local x2 = math.sin((d + rm) * 3.7 * mp)
	local pt = (rd * x1) + (rd / 1 * x2)
	return pt
end
grimoire.Bronze.funcY = function(d,rd,rm)
	local mp = math.pi / 180
	d = d - rm
	local j = mod(math.abs(d),360)
	rd = rd - math.floor(j / 120) * 0.19
	local y1 = math.cos(d * mp)
	local y2 = math.cos((d + rm) * 3.7 * mp)
	local pt = (rd * y1) + (rd / 1 * y2)
	return pt
end
grimoire.Bronze.connect = nil
grimoire.Bronze.smooth = nil
grimoire.Bronze.drX = nil
grimoire.Bronze.drY = nil
grimoire.Bronze.pulse = nil
--rimoire.Azure.pulse.cnt = 1
--grimoire.Azure.pulse.amt = 0.03
--grimoire.Azure.pulse.tgt = 0.44
grimoire.Bronze.orbit = 0
grimoire.Bronze.orbinc = 19
grimoire.Bronze.orbrad = 3.7
grimoire.Bronze.sticky = 19
grimoire.Bronze.dippX = 1.0
grimoire.Bronze.dippY = 1.0
grimoire.Bronze.lsSkew = 19
grimoire.Bronze.rube = nil
grimoire.Bronze.lsRadAdjX = 1.0
grimoire.Bronze.lsRadAdjY = 1.0
grimoire.Bronze.gyreVert = "Bronze"
grimoire.Bronze.gyreTex = "LunacyE"
grimoire.Bronze.trOll = 30076 --< Jeeves
grimoire.Bronze.doMMy = "Bronze"
grimoire.Bronze.snarks = {546274,546277,546285}

--Fortune
grimoire.Shamrock = {}
grimoire.Shamrock.num = 77
grimoire.Shamrock.spin = 4
grimoire.Shamrock.degInc = 7.7
grimoire.Shamrock.rd = 21
grimoire.Shamrock.rdInc = nil
grimoire.Shamrock.colorSet = "Silver"
grimoire.Shamrock.lineClr = "Shamrock"
grimoire.Shamrock.funcX = function(d,rd,rm)
	local mp = math.pi / 180
	d = d - rm
	--local mp = 1
	local x1 = math.sin(d * mp)
	local x2 = math.sin((d + rm) * 6 * mp)
	local pt = (rd * x1) + (rd / 2 * x2)
	return pt
end
grimoire.Shamrock.funcY = function(d,rd,rm)
	local mp = math.pi / 180
	d = d - rm
	--local mp = 1
	local y1 = math.cos(d * mp)
	local y2 = math.cos((d + rm) * 6 * mp)
	local pt = (rd * y1) + (rd / 2 * y2)
	return pt
end
grimoire.Shamrock.connect = nil
grimoire.Shamrock.smooth = nil
grimoire.Shamrock.drX = nil
grimoire.Shamrock.drY = nil
grimoire.Shamrock.sticky = 21
grimoire.Shamrock.pulse = {}
grimoire.Shamrock.pulse.cnt = 0.77
grimoire.Shamrock.pulse.amt = 0.00077
grimoire.Shamrock.pulse.tgt = 0.07
grimoire.Shamrock.dippX = 1.0
grimoire.Shamrock.dippY = 1.0
grimoire.Shamrock.lsSkew = 7
grimoire.Shamrock.rube = nil
grimoire.Shamrock.lsRadAdjX = 1.11
grimoire.Shamrock.lsRadAdjY = 1.11
grimoire.Shamrock.gyreVert = "Silver"
grimoire.Shamrock.gyreTex = "LunacyE"
grimoire.Shamrock.trOll = 14855 -- Silas Darkmoon
grimoire.Shamrock.snarks = {550478,550466,550472,550473}

--Bachus
grimoire.NeonGreen = {}
grimoire.NeonGreen.num = 27
grimoire.NeonGreen.spin = 27
grimoire.NeonGreen.degInc = 72
grimoire.NeonGreen.rd = 21
grimoire.NeonGreen.rdInc = nil
grimoire.NeonGreen.colorSet = "NeonGreen"
grimoire.NeonGreen.lineClr = "Violet"
grimoire.NeonGreen.funcX = function(d,rd,rm)
	local mp = math.pi / 180
	d = d - rm
	--local mp = 1
	local x1 = math.sin(d * mp)
	local x2 = math.sin((d + rm) * 6 * mp)
	local pt = (rd * x1) + (rd / 2 * x2)
	return pt
	--return rd * math.sin(d * mp)^3
end
grimoire.NeonGreen.funcY = function(d,rd,rm)
	local mp = math.pi / 180
	d = d - rm
	--local mp = 1
	local y1 = math.cos(d * mp)
	local y2 = math.cos((d + rm) * 6 * mp)
	local pt = (rd * y1) + (rd / 2 * y2)
	return pt
	--return rd * math.cos(d * mp) - ((rd/3) * math.cos(2 * d * mp)) - ((rd/6) * math.cos(3 * d * mp)) - ((rd/4) * math.cos(4 * d * mp))
end
grimoire.NeonGreen.connect = nil
grimoire.NeonGreen.smooth = true
grimoire.NeonGreen.drX = nil
grimoire.NeonGreen.drY = nil
grimoire.NeonGreen.pulse = {}
grimoire.NeonGreen.pulse.cnt = 1
grimoire.NeonGreen.pulse.amt = 0.0432
grimoire.NeonGreen.pulse.tgt = 0.432
grimoire.NeonGreen.doMMy = "NeonGreen"
grimoire.NeonGreen.dippX = 1.0
grimoire.NeonGreen.dippY = 1.0
grimoire.NeonGreen.lsSkew = 42
grimoire.NeonGreen.rube = nil
grimoire.NeonGreen.lsRadAdjX = 1.0
grimoire.NeonGreen.lsRadAdjY = 1.0
grimoire.NeonGreen.gyreVert = "NeonGreen"
grimoire.NeonGreen.gyreTex = "LunacyE"
grimoire.NeonGreen.trOll = 128099
grimoire.NeonGreen.snarks = {7236685,7236714,7236744,7236626}

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
--grimoire.Scarlet.trOck = {}
--grimoire.Scarlet.trOck.anim = 69 --69
--grimoire.Scarlet.trOck.rot = 169
--grimoire.Scarlet.trOck.camdis = 0.88
--grimoire.Scarlet.trOck.offX = 15
--grimoire.Scarlet.trOck.offY = -21
--rimoire.Azure.pulse.cnt = 1
--grimoire.Azure.pulse.amt = 0.03
--grimoire.Azure.pulse.tgt = 0.44
grimoire.Scarlet.doMMy = "Scarlet"
grimoire.Scarlet.dippX = 1.0
grimoire.Scarlet.dippY = 1.0
grimoire.Scarlet.lsSkew = 77
grimoire.Scarlet.rube = nil
grimoire.Scarlet.lsRadAdjX = 1.13
grimoire.Scarlet.lsRadAdjY = 1.13
grimoire.Scarlet.gyreVert = "Scarlet"
grimoire.Scarlet.gyreTex = "LunacyE"
grimoire.Scarlet.trOll = 2043
grimoire.Scarlet.snarks = {1466150,561156,561158,561160,561165,633949}

--Death/The Underworld
grimoire.Obsidian = {}
grimoire.Obsidian.num = 37
grimoire.Obsidian.spin = 19
grimoire.Obsidian.degInc = 19
grimoire.Obsidian.rd = 19
grimoire.Obsidian.rdInc = nil
grimoire.Obsidian.colorSet = "Obsidian"
grimoire.Obsidian.lineClr = "Indigo"
grimoire.Obsidian.ring = "Indigo"
grimoire.Obsidian.funcX = function(d,rd,rm)
	local mp = math.pi / 180
	d = d - rm
	local j = mod(math.abs(d),360)
	rd = rd - math.floor(j / 120) * 0.19
	local x1 = math.sin(d * mp)
	local x2 = math.sin((d + rm) * 3.7 * mp)
	local pt = (rd * x1) + (rd / 1 * x2)
	return pt
end
grimoire.Obsidian.funcY = function(d,rd,rm)
	local mp = math.pi / 180
	d = d - rm
	local j = mod(math.abs(d),360)
	rd = rd - math.floor(j / 120) * 0.19
	local y1 = math.cos(d * mp)
	local y2 = math.cos((d + rm) * 3.7 * mp)
	local pt = (rd * y1) + (rd / 1 * y2)
	return pt
end
grimoire.Obsidian.connect = nil
grimoire.Obsidian.smooth = nil
grimoire.Obsidian.drX = nil
grimoire.Obsidian.drY = nil
grimoire.Obsidian.pulse = nil
--rimoire.Azure.pulse.cnt = 1
--grimoire.Azure.pulse.amt = 0.03
--grimoire.Azure.pulse.tgt = 0.44
grimoire.Obsidian.orbit = 0
grimoire.Obsidian.orbinc = 19
grimoire.Obsidian.orbrad = 3.7
grimoire.Obsidian.sticky = 19
grimoire.Obsidian.dippX = 1.0
grimoire.Obsidian.dippY = 1.0
grimoire.Obsidian.lsSkew = 19
grimoire.Obsidian.rube = nil
grimoire.Obsidian.lsRadAdjX = 1.0
grimoire.Obsidian.lsRadAdjY = 1.0
grimoire.Obsidian.gyreVert = "Obsidian"
grimoire.Obsidian.gyreTex = "LunacyE"
grimoire.Obsidian.trOll = 5233 --< Spirit Healer >--28213 Sylvanas
grimoire.Obsidian.doMMy = "Obsidian"
--grimoire.Obsidian.trOck = {}
--grimoire.Obsidian.trOck.anim = 0 --69
--grimoire.Obsidian.trOck.rot = 0
--grimoire.Obsidian.trOck.camdis = 0.91
--grimoire.Obsidian.trOck.offX = 15
--grimoire.Obsidian.trOck.offY = -18
grimoire.Obsidian.snarks = {561297,561327,561346,561301}

--Luxury
grimoire.Maroon = {
	["num"] = 36,
	["spin"] = 23,
	["degInc"] = 17,
	["rd"] = 21,
	["rdInc"] = nil,
	["colorSet"] = "Maroon",
	["lineClr"] = "Chartreuse",
	["funcX"] = function(d,rd,rm)
		local mp = math.pi / 180
		d = d - rm
		--local mp = 1
		local x1 = math.sin(d * mp)
		local x2 = math.sin((d + rm) * 6 * mp)
		local pt = (rd * x1) + (rd / 2 * x2)
		return pt
		--return rd * math.sin(d * mp)^3
	end,
	["funcY"] = function(d,rd,rm)
		local mp = math.pi / 180
		d = d - rm
		--local mp = 1
		local y1 = math.cos(d * mp)
		local y2 = math.cos((d + rm) * 6 * mp)
		local pt = (rd * y1) + (rd / 2 * y2)
		return pt
		--return rd * math.cos(d * mp) - ((rd/3) * math.cos(2 * d * mp)) - ((rd/6) * math.cos(3 * d * mp)) - ((rd/4) * math.cos(4 * d * mp))
	end,
	["connect"] = nil,
	["smooth"] = true,
	["drX"] = nil,
	["drY"] = nil,
	["pulse"] = nil,
	--rimoire.Azure.pulse.cnt = 1
	--grimoire.Azure.pulse.amt = 0.03
	--grimoire.Azure.pulse.tgt = 0.44
	["dippX"] = 1.0,
	["dippY"] = 1.0,
	["lsSkew"] = 0,
	["rube"] = nil,
	["lsRadAdjX"] = 1.13,
	["lsRadAdjY"] = 1.13,
	["gyreVert"] = "Maroon",
	["gyreTex"] = "LunacyE",
	["doMMy"] = "Maroon",
	["trOll"] = 75730,
	["snarks"] = {1860609,1860610,1860611,1860612,1860624},
}

--Duty
grimoire.Parchment = {
    ["num"] = 36,
    ["spin"] = 24,
    ["degInc"] = 24,
    ["rd"] = 24,
    ["rdInc"] = nil,
    ["colorSet"] = "Parchment",
    ["lineClr"] = "Obsidian",
    ["funcX"] = function(d,rd,rm,i)
		local mp = math.pi / 180
		d = d - rm
		--local mp = 1
		local x1 = math.sin(21 * (i+1) * mp)
		local x2 = math.sin((d + rm) * 6 * mp)
		local pt = (rd * x1) + (rd / 2 * x2)
		return pt
		--return rd * math.sin(d * mp)^3
	end,
    ["funcY"] = function(d,rd,rm,i)
		local mp = math.pi / 180
		d = d - rm
		--local mp = 1
		local y1 = math.cos(21 * (i+1) * mp)
		local y2 = math.cos((d + rm) * 6 * mp)
		local pt = (rd * y1) + (rd / 2 * y2)
		return pt
		--return rd * math.cos(d * mp) - ((rd/3) * math.cos(2 * d * mp)) - ((rd/6) * math.cos(3 * d * mp)) - ((rd/4) * math.cos(4 * d * mp))
	end,
    ["connect"] = nil,
    ["smooth"] = nil,
    ["drX"] = nil,
    ["drY"] = nil,
	["pulse"] = {
		["cnt"] = 1, -- current
		["amt"] = 0.0007, -- speed
		["tgt"] = 0.21, -- lower range
	},
    ["dippX"] = 1.0,
    ["dippY"] = 1.0,
    ["lsSkew"] = 11,
    ["rube"] = nil,
    ["lsRadAdjX"] = 1.13,
    ["lsRadAdjY"] = 1.13,
	["doMMy"] = "Parchment",
	["ring"] = "Parchment",
    ["gyreVert"] = "Parchment",
    ["gyreTex"] = "LunacyE",
    ["trOll"] = 43460, -- `Jancy´ https://www.wowhead.com/npc=59184/jandice-barov
    ["snarks"] = {552156,552157,552164,552165},
}

--Wealth
grimoire.Gold = {
    ["num"] = 37,
    ["spin"] = 21,
    ["degInc"] = 21,
    ["rd"] = 21,
    ["rdInc"] = nil,
    ["colorSet"] = "Gold",
    ["lineClr"] = "FluorescentYellow",
    ["funcX"] = function(d,rd,rm,i)
		local mp = math.pi / 180
		d = d - rm
		--local mp = 1
		local x1 = math.sin(21 * (i+1) * mp)
		local x2 = math.sin((d + rm) * 6 * mp)
		local pt = (rd * x1) + (rd / 2 * x2)
		return pt
		--return rd * math.sin(d * mp)^3
	end,
    ["funcY"] = function(d,rd,rm,i)
		local mp = math.pi / 180
		d = d - rm
		--local mp = 1
		local y1 = math.cos(21 * (i+1) * mp)
		local y2 = math.cos((d + rm) * 6 * mp)
		local pt = (rd * y1) + (rd / 2 * y2)
		return pt
		--return rd * math.cos(d * mp) - ((rd/3) * math.cos(2 * d * mp)) - ((rd/6) * math.cos(3 * d * mp)) - ((rd/4) * math.cos(4 * d * mp))
	end,
    ["connect"] = nil,
    ["smooth"] = nil,
    ["drX"] = nil,
    ["drY"] = nil,
	["pulse"] = {
		["cnt"] = 1, -- current
		["amt"] = 0.0007, -- speed
		["tgt"] = 0.21, -- lower range
	},
    ["dippX"] = 1.0,
    ["dippY"] = 1.0,
    ["lsSkew"] = 11,
    ["rube"] = nil,
    ["lsRadAdjX"] = 1.13,
    ["lsRadAdjY"] = 1.13,
	["doMMy"] = "Gold",
	["ring"] = "Gold",
    ["gyreVert"] = "Gold",
    ["gyreTex"] = "LunacyE",
    ["trOll"] = 34157, -- `Goblin.•.Broker´
    ["snarks"] = {3089702,550846,550869,550848,550835,550858,550832,550845,550851},
}

--Avarice
grimoire.Chartreuse = {
    ["num"] = 37,
    ["spin"] = 21,
    ["degInc"] = 21,
    ["rd"] = 21,
    ["rdInc"] = nil,
    ["colorSet"] = "Chartreuse",
    ["lineClr"] = "Indigo",
    ["funcX"] = function(d,rd,rm,i)
		local mp = math.pi / 180
		d = d - rm
		--local mp = 1
		local x1 = math.sin(21 * (i+1) * mp)
		local x2 = math.sin((d + rm) * 6 * mp)
		local pt = (rd * x1) + (rd / 2 * x2)
		return pt
		--return rd * math.sin(d * mp)^3
	end,
    ["funcY"] = function(d,rd,rm,i)
		local mp = math.pi / 180
		d = d - rm
		--local mp = 1
		local y1 = math.cos(21 * (i+1) * mp)
		local y2 = math.cos((d + rm) * 6 * mp)
		local pt = (rd * y1) + (rd / 2 * y2)
		return pt
		--return rd * math.cos(d * mp) - ((rd/3) * math.cos(2 * d * mp)) - ((rd/6) * math.cos(3 * d * mp)) - ((rd/4) * math.cos(4 * d * mp))
	end,
    ["connect"] = true,
    ["smooth"] = nil,
    ["drX"] = nil,
    ["drY"] = nil,
    ["pulse"] = {},
    ["pulse.cnt"] = 1, -- current
    ["pulse.amt"] = 0.0007, -- speed
    ["pulse.tgt"] = 0.21, -- lower range
    ["dippX"] = 1.0,
    ["dippY"] = 1.0,
    ["lsSkew"] = 11,
    ["rube"] = nil,
    ["lsRadAdjX"] = 1.13,
    ["lsRadAdjY"] = 1.13,
    ["gyreVert"] = "Chartreuse",
    ["gyreTex"] = "LunacyE",
    ["trOll"] = 75730,
    ["snarks"] = {550805,550813,550806,550809},
}

Lunacy.grimoire = grimoire

-- The Book of T°tems
local trOlls = { 
	--dOSIERr dEMENTUs -- dr.ds > OSIER.EMENTU.REISO
	["ω♥∩"] = { -- Shy Sister Sally ✓
		["id"] = 2043,
		["pitch"] = 0.0,
		["zoff"] = 0.69,
		["camtarZ"] = 0.75,
		["camtarx"] = -0.03,
		["yaw"] = 0.06,
		["rot"] = -90,
		["gizmo"] = 0,
		["nospin"] = true,
		["yoff"] = 0.6,
		["desc"] = "Sister Sally",
		["house"] = "War",
		["dance"] = 69,
		["snarks"] = {1466150,561156,561158,561160,561165,633949},
	},
	["°)ω(°"] = { -- Y°Y°, Geordie's Sister
		["id"] = 86488,
		["desc"] = "YoYo",
		["snarks"] = {568873,568873},
	},
	["(^♥^)"] = { -- Mother Moon
		["id"] = 140475,
		["desc"] = "Mother Moon",
		["snarks"] = {549325,549326},
	},
	["(.Y.)"] = { -- Geordie, Spriggan Wendigo
		["id"] = 86488,
		["desc"] = "Geordie",
		["snarks"] = {568873,568873},
	},
	["(•)♥)"] = { -- `•Já§§ý.•´ `Goblin.•.Broker´
		["id"] = 34157,
		["gizmo"] = 0,
		["pitch"] = 0.0,
		["yaw"] = 0.0,
		["rot"] = 90,
		["zoff"] = 0.47,
		["yoff"] = 1.45,
		["camtarX"] = -0.11,
		["camtarZ"] = 0.61,
		["dance"] = 69,
		["desc"] = "`•Já§§ý.•´",
		["house"] = "Wealth",
		["clr"] = "Gold",
		["snarks"] = {3089702,550846,550869,550848,550835,550858,550832,550845,550851},
		["skits"] = {
			[1] = {
				["gizmo"] = 0,
				["pitch"] = 0.0,
				["yaw"] = 0.0,
				["rot"] = 90,
				["zoff"] = 0.47,
				["yoff"] = 1.45,
				["camtarX"] = -0.11,
				["camtarZ"] = 0.61,
				["dance"] = 69,
			},
			[2] = {
				["rot"] = -90,
				["pitch"] = 0.3,
				["yaw"] = 0,
				["xoff"] = 0,
				["yoff"] = 1.45,
				["zoff"] = 0.47,
				["camtarX"] = -0.11,
				["camtarY"] = 0,
				["camtarZ"] = 0.39,
				["dance"] = 69,
			},
			[3] = {
				["gizmo"] = 0,
				["pitch"] = 0.0,
				["yaw"] = 0.0,
				["rot"] = 90,
				["zoff"] = 0.47,
				["yoff"] = 1.45,
				["camtarX"] = -0.11,
				["camtarZ"] = 0.61,
				["dance"] = 38,
			},
		},
	},
	["°(•)"] = { -- `Goblin~Broker`
		["id"] = 34155,
		["clr"] = "NeonYellow",
		["desc"] = "`Goblin~Broker`",
		["snarks"] = {550903,550874},
	},
	["\\°/"] = { -- Kaldorei Mailbox Dancer
		["id"] = 39620,
		["desc"] = "Kaldorei Mailbox Dancer",
		["dance"] = 69,
	},
	["(•Y°)"] = { -- Deranged Alchemy Professor
		["id"] = 30881,
		["yaw"] = 0,
		["pitch"] = 0,
		["nospin"] = true,
		["rot"] = 0,
		["offX"] = 14,
		["offY"] = -10,
		["desc"] = "Deranged Alchemy Professor",
	},
	["(•Y•)"] = { -- Deranged Alchemy Professor
		["id"] = 30881,
		["clr"] = "Palatinate",
		["yaw"] = 0,
		["pitch"] = 0,
		["rot"] = 105,
		--["zoff"] = 0.5,
		["nospin"] = true,
		["desc"] = "Deranged Alchemy Professor",
		["house"] = "Alchemy",
		["snarks"] = {558452,558418,558404,558387},
		["skits"] = {
			[1] = {
				["nospin"] = true,
				["gizmo"] = 0,
				["rot"] = 105,
				["pitch"] = 0,
				["yaw"] = 0,
				["xoff"] = 0,
				["yoff"] = 1.23,
				["zoff"] = 1.19,
				["camtarX"] = -0.09,
				["camtarY"] = 0,
				["camtarZ"] = 1.17,
				["rotinc"] = 5,
				["campulse"] = 0.15,
				["camMin"] = 0.37,
				["camMax"] = 3.77,
				["dance"] = 82,
			},
			[2] = {
				["nospin"] = true,
				["needle"] = "Palatinate",
				["gizmo"] = 0,
				["rot"] = 103,
				["pitch"] = -0.03,
				["yaw"] = 0,
				["xoff"] = 0,
				["yoff"] = 0.309,
				["zoff"] = 1.19,
				["camtarX"] = -0.0693,
				["camtarY"] = 0,
				["camtarZ"] = 1.202,
				["rotinc"] = 5,
				["campulse"] = 0.15,
				["camMin"] = 0.37,
				["camMax"] = 3.77,
				["dance"] = 82,
			},
		},
	},
	["&ω\\"] = { -- Sayaad Barmaid
		["id"] = 2834,
		["desc"] = "Sayaad Barmaid",
	},
	["(•´¤`•)"] = { -- ~(•´¤`•) Hi! I'm Bouyant Meadows!~
		["id"] = 68967,
		["camdis"] = 1.49,
		["rot"] = 0,
		["nospin"] = true,
		["yoff"] = 2.5,
		["clr"] = "Spring",
		["snarks"] = {547796,547790,547788,547785,547790},
		["desc"] = "Bouyant Meadows", -- ~(•´¤`•) Hi! I'm Bouyant Meadows!~
	},
	["↓.^.↓"] = { -- Shy Turtle Tom ~ floating along ~^~
		["id"] = 17158,
		["desc"] = "Shy Turtle Tom",
	},
	[").`B´.)"] = { --).Brawndo~Man.(--
		["id"] = 115505,
		["clr"] = "Buff",
		["desc"] = "Brawndo Man",
		["pitch"] = 0.0,
		["yaw"] = 0.0,
		["nospin"] = true,
		["rot"] = 90,
		["zoff"] = 1.0,
		--["xoff"] = 0.0,
		["yoff"] = 2.7,
		["clr"] = "Cobalt",
		["dance"] = 41,
		["camtarX"] = -0.07,
		["camtarZ"] = 0.44,
		["snarks"] = {545429,545476,545489,545491},
	},
	["`†Ðõ†§†´"] = { -- Maiden of Cups ✓ `†Ðõ†§†´
		["id"] = 87892,
		["camdis"] = 0.84,
		["offX"] = 15,
		["offY"] = 0,
		["nospin"] = true,
		["desc"] = "Maiden of Cups",
		["clr"] = "AdmiralBlue",
		["dance"] = 69,
		["snarks"] = {3534100,3534100,3534100,3534100,3534100,3534100,2012997},
	},
	["×♦ÐîÐî♦×"] = { -- ×♦ÐîÐî♦× ⌂RøçkéTWréñçh⌂ ✓
		["id"] = 26375,
		["camdis"] = 0.84,
		["offX"] = 15,
		["offY"] = -14,
		["desc"] = "DiDi RockeTWrench",
		["clr"] = "Vixen",
		["dance"] = 78,
		["snarks"] = {550640,550659,550665,550654,550660,550643,550657},
	},
	["∞χΔθΔχ∞"] = { -- Oracle of Time() ✓
		["id"] = 24877,
		["camdis"] = 1.5,
		["camdisScale"] = 0.75,
		["pitch"] = 0.0,
		["yaw"] = 0.0,
		["rot"] = 90,
		["xoff"] = 0,
		["yoff"] = 1.45,
		["zoff"] = 0.47,
		["camtarX"] = -0.11,
		["camtarY"] = 0,
		["camtarZ"] = 0.61,
		["desc"] = "The Oracle of Time",
		["clr"] = "Flax",
		["dance"] = 82,
		["snarks"] = {3049652,3049653,3049655,3049658},
		["skits"] = {
			[1] = {
				["gizmo"] = 0,
				["nospin"] = true,
				["pitch"] = 0.0,
				["yaw"] = 0.0,
				["rot"] = 90,
				["xoff"] = 0,
				["yoff"] = 1.45,
				["zoff"] = 0.47,
				["camtarX"] = -0.11,
				["camtarY"] = 0,
				["camtarZ"] = 0.61,
				["dance"] = 82, -- Flex
			},
			[2] = {
				["gizmo"] = 0,
				["nospin"] = true,
				["pitch"] = 0.0,
				["yaw"] = 0.0,
				["rot"] = 90,
				["xoff"] = 0,
				["yoff"] = 1.45,
				["zoff"] = 0.47,
				["camtarX"] = -0.11,
				["camtarY"] = 0,
				["camtarZ"] = 0.61,
				["dance"] = 69, -- Dance
			},
			[3] = {
				["gizmo"] = 0,
				["nospin"] = true,
				["pitch"] = 0.0,
				["yaw"] = 0.0,
				["rot"] = 90,
				["xoff"] = 0,
				["yoff"] = 1.45,
				["zoff"] = 0.47,
				["camtarX"] = -0.11,
				["camtarY"] = 0,
				["camtarZ"] = 0.61,
				["dance"] = 78, --Chicken
			},
			[4] = {
				["gizmo"] = 0,
				["nospin"] = true,
				["pitch"] = 0.0,
				["yaw"] = 0.0,
				["rot"] = 90,
				["xoff"] = 0,
				["yoff"] = 1.45,
				["zoff"] = 0.47,
				["camtarX"] = -0.11,
				["camtarY"] = 0,
				["camtarZ"] = 0.61,
				["dance"] = 111, -- Toss
			},
			[5] = {
				["gizmo"] = 3,
				["rot"] = 90,
				["pitch"] = 10.8,
				["yaw"] = 12.075,
				["xoff"] = 0,
				["yoff"] = 1.45,
				["zoff"] = 0.47,
				["camtarX"] = -0.11,
				["camtarY"] = 0,
				["camtarZ"] = 0.61,
				["rotinc"] = 5,
				["campulse"] = 0.15,
				["camMin"] = 0.37,
				["camMax"] = 3.77,
				["dance"] = 126, -- Spin
			},
			[6] = {
				["gizmo"] = 0,
				["pitch"] = 0.0,
				["yaw"] = 0.0,
				["rot"] = 90,
				["xoff"] = 0,
				["yoff"] = 1.45,
				["zoff"] = 0.47,
				["camtarX"] = -0.11,
				["camtarY"] = 0,
				["camtarZ"] = 0.61,
				["dance"] = 69, -- Dance
			},
			[7] = {
				["gizmo"] = 0,
				["pitch"] = 0.0,
				["yaw"] = 0.0,
				["rot"] = 90,
				["xoff"] = 0,
				["yoff"] = 1.45,
				["zoff"] = 0.47,
				["camtarX"] = -0.11,
				["camtarY"] = 0,
				["camtarZ"] = 0.61,
				["dance"] = 135, --Swimming
			},
			[8] = {
				["gizmo"] = 0,
				["pitch"] = 0.0,
				["yaw"] = 0.0,
				["rot"] = 90,
				["xoff"] = 0,
				["yoff"] = 1.45,
				["zoff"] = 0.47,
				["camtarX"] = -0.11,
				["camtarY"] = 0,
				["camtarZ"] = 0.61,
				["dance"] = 143, -- Sprint
			},
			[9] = {
				["gizmo"] = 0,
				["pitch"] = 0.0,
				["yaw"] = 0.0,
				["rot"] = 90,
				["xoff"] = 0,
				["yoff"] = 1.45,
				["zoff"] = 0.47,
				["camtarX"] = -0.11,
				["camtarY"] = 0,
				["camtarZ"] = 0.61,
				["dance"] = 132, -- Dead in the Water
			},
		},
	},
	["£/ώ\\Ř"] = { -- `Jancy´ - Jandice Barov - Mistress of Illusion✓
		["id"] = 43460,
		["yaw"] = 0,
		["pitch"] = 0,
		["rot"] = -90,
		["xoff"] = 0,
		["yoff"] = 1.0,
		["zoff"] = 0.69,
		["camtarX"] = 0,
		["camtarY"] = 0,
		["camtarZ"] = 0.79,
		["desc"] = "`ώ£áώçýώ´",
		["clr"] = "Flax",
		["dance"] = 69,
		["nospin"] = true,
		["snarks"] = {552156,552157,552164,552165},
		["skits"] = {
			[1] = {
				["rot"] = 90,
				["pitch"] = 0,
				["yaw"] = 0,
				["xoff"] = 0,
				["yoff"] = 0.69,
				["zoff"] = 1,
				["camtarX"] = -0.03,
				["camtarY"] = 0,
				["camtarZ"] = 1.05,
				["dance"] = 78,
				["nospin"] = true,
			},
			[2] = {
				["rot"] = -90,
				["pitch"] = 0,
				["yaw"] = 0,
				["xoff"] = 0,
				["yoff"] = 1.0,
				["zoff"] = 0.69,
				["camtarX"] = 0,
				["camtarY"] = 0,
				["camtarZ"] = 0.79,
				["dance"] = 69,
				["nospin"] = true,
			},
			[3] = {
				["rot"] = 90,
				["pitch"] = 0,
				["yaw"] = 0,
				["xoff"] = 0,
				["yoff"] = 1.0,
				["zoff"] = 0.69,
				["camtarX"] = 0,
				["camtarY"] = 0,
				["camtarZ"] = 0.79,
				["dance"] = 69,
				["nospin"] = true,
			},
		},
	},
	["♣Δ\\°/Δ♣"] = { -- `Silas - The Wizard´ ✓
		["id"] = 14855,
		["camdis"] = 1.5,
		["camdisScale"] = 0.75,
		["pitch"] = 0,
		["yaw"] = 0.00,
		["rot"] = 90,
		["camMax"] = 7.7,
		["camMin"] = 1.69,
		["campulse"] = 0.07,
		["camyoff"] = 2.34,
		["rotinc"] = 1,
		["gizmo"] = 8,
		["zoff"] = 0.35,
		["yoff"] = 1.0,
		["camtarZ"] = 0.67,
		["offX"] = 6,
		["offY"] = 0,
		["desc"] = "♣§¡£å§♣",
		["clr"] = "Shamrock",
		["dance"] = 143,
		["snarks"] = {550478,550466,550472,550473},
	},
	["Ħ°Ħ"] = { -- `ĦM°Ģrg°gleĦ´ ✓
		["id"] = 21723,
		["pitch"] = 0,
		["yaw"] = 0.00,
		["rot"] = 90,
		["gizmo"] = 0,
		["rotinc"] = 1,
		["xoff"] = -0.77,
		["yoff"] = 3.5,
		["zoff"] = 0.5,
		["camtarX"] = -0.39,
		["camtarY"] = 0,
		["camtarZ"] = 0.67,
		["desc"] = "ĦM°Ģrg°gleĦ",
		["clr"] = "Green",
		["dance"] = 69,
		["snarks"] = {550736,550736,550736,550736},
	},
	["♦†.Y.†♦"] = { -- Luxury - Ŧħę Pŗ†ŋćę
		["id"] = 75730,
		["clr"] = "Maroon",
		["needle"] = "Chartreuse",
		["desc"] = "Ŧħę Pŗ†ŋćę",
		["house"] = "Luxury",
		["pitch"] = 0.0,
		["yaw"] = 0.0,
		["rot"] = 90,
		["zoff"] = 1.0,
		--["xoff"] = 0.0,
		["yoff"] = 2.7,
		["dance"] = 69,
		["camtarX"] = -0.07,
		["camtarZ"] = 0.44,
		["snarks"] = {1860609,1860610,1860611,1860612,1860624},
	},
	["ω(.^.)ω"] = { -- The Chef
		["id"] = 42360,
		["clr"] = "Butter",
		["needle"] = "Butter",
		["desc"] = "The Chef",
		["house"] = "Chef",
		["pitch"] = 0.09,
		["yaw"] = 0.0,
		["rot"] = -90,
		["zoff"] = 1.0,
		["xoff"] = -0.03,
		["yoff"] = 3.77,
		["dance"] = 69,
		["gizmo"] = 0,
		["camtarX"] = -0.15,
		["camtarZ"] = 0.84,
		["snarks"] = {632512,632514,632506},
	},
	["^(♠ώ♠)^"] = { -- The Dark Lady - Death
		["id"] = 5233,
		["clr"] = "Obsidian",
		["needle"] = "CarlolinaBlue",
		["desc"] = "The Dark Lady",
		["house"] = "Death",
		["pitch"] = 0.00,
		["yaw"] = 0.0,
		["nospin"] = true,
		["rot"] = 90,
		["zoff"] = 2.0,
		["xoff"] = 0,
		["yoff"] = 11,
		["dance"] = 0,
		["gizmo"] = 0,
		["camtarX"] = -0.81,
		["camtarY"] = 0,
		["camtarZ"] = 3,
		["snarks"] = {561297,561327,561346,561301},
		["skits"] = {
			[1] = {
				["gizmo"] = 0,
				["id"] = 5233,
				["rot"] = 90,
				["pitch"] = 0,
				["yaw"] = 0,
				["xoff"] = 0,
				["yoff"] = 11,
				["zoff"] = 2.2,
				["camtarX"] = -0.91,
				["camtarY"] = 0,
				["camtarZ"] = 3,
				["dance"] = 0,
			},
			[2] = {
				["gizmo"] = 0,
				["id"] = 28213,
				["rot"] = -280,
				["pitch"] = 0.9,
				["yaw"] = 0,
				["xoff"] = 0,
				["yoff"] = 3.6,
				["zoff"] = 2.2,
				["camtarX"] = -0.91,
				["camtarY"] = 0.25,
				["camtarZ"] = 2.75,
				["rotinc"] = 5,
				["campulse"] = 0.15,
				["camMin"] = 0.37,
				["camMax"] = 3.77,
				["dance"] = 0,
			},
			[3] = {
				["gizmo"] = 0,
				["id"] = 28213,
				["rot"] = -280,
				["pitch"] = 0.9,
				["yaw"] = 0,
				["xoff"] = 0,
				["yoff"] = 3.6,
				["zoff"] = 2.2,
				["camtarX"] = -0.91,
				["camtarY"] = 0.25,
				["camtarZ"] = 2.75,
				["rotinc"] = 5,
				["campulse"] = 0.15,
				["camMin"] = 0.37,
				["camMax"] = 3.77,
				["dance"] = 0,
			},
			[4] = {
				["gizmo"] = 0,
				["id"] = 5233,
				["rot"] = -280,
				["pitch"] = 0.9,
				["yaw"] = 0,
				["xoff"] = 0,
				["yoff"] = 3.6,
				["zoff"] = 2.2,
				["camtarX"] = -0.91,
				["camtarY"] = 0.25,
				["camtarZ"] = 2.75,
				["rotinc"] = 5,
				["campulse"] = 0.15,
				["camMin"] = 0.37,
				["camMax"] = 3.77,
				["dance"] = 0,
			},
			[5] = {
				["gizmo"] = 0,
				["id"] = 5233,
				["rot"] = -280,
				["pitch"] = 0.9,
				["yaw"] = 0,
				["xoff"] = 0,
				["yoff"] = 3.6,
				["zoff"] = 2.2,
				["camtarX"] = -0.91,
				["camtarY"] = 0.25,
				["camtarZ"] = 2.75,
				["rotinc"] = 5,
				["campulse"] = 0.15,
				["camMin"] = 0.37,
				["camMax"] = 3.77,
				["dance"] = 0,
			},
		},
	},
	["d(•-•)b"] = { -- The Engineer - Jeeves
		["id"] = 30076,
		--["camdis"] = 1.5,
		["pitch"] = 0.0,
		["yaw"] = 0.0,
		["rot"] = 90,
		["gizmo"] = 0,
		["nospin"] = true,
		["rotinc"] = 0,
		["zoff"] = 0.47,
		["yoff"] = 0.77,
		["camtarX"] = -0.11,
		["camtarZ"] = 0.55,
		["dance"] = 69,
		["desc"] = "Jeeves",
		["house"] = "Ingenuity",
		["clr"] = "Bronze",
		["snarks"] = {546274,546277,546285},
	},
	["♣•>ώ<•♣"] = { -- Bachus
		["id"] = 128099,
		["pitch"] = 0.0,
		["yaw"] = 0.0,
		["rot"] = 90,
		["gizmo"] = 10,
		["rotinc"] = 0,
		["zoff"] = 0.47,
		["yoff"] = 2.34,
		["camtarX"] = -0.11,
		["camtarZ"] = 0.55,
		["camMax"] = 9.87,
		["camMin"] = 2.34,
		["campulse"] = 0.19,
		--["camyoff"] = 2.34,
		["dance"] = 69,
		["needle"] = "Violet",
		["desc"] = "Bachus",
		["house"] = "Revelry",
		["clr"] = "NeonGreen",
		["snarks"] = {7236685,7236714,7236744,7236626},
	},
	
	
	--B•plug•I~-~D=
	[888] = "°)ω(°", -- YoYo
	[86488] = "°)ω(°", -- YoYo
	[68967] = "(•´¤`•)", --Bouyant Meadows
	[420] = "(.Y.)", -- Geordie
	[369] = "(^♥^)", -- Mother Moon
	[777] = "(^♥^)",
	[140475] = "(^♥^)", 
	[2043] = "ω♥∩", -- Sister Sally
	[34157] = "(•)♥)", -- `•Já§§ý.•´ `Goblin.•.Broker´
	[34155] = "°(•)", -- `Goblin~Broker`
	[39620] = "\\°/", -- Kaldorei Mailbox Dancer
	[30881] = "(•Y•)", -- Deranged Professor
	[2834] = "&ω\\", -- Sayaad Barmaid
	[17158] = "↓.^.↓", -- Shy Turtle Tom
	[115505] = ").`B´.)", -- Brawndo Man
	["7^~"] = ").`B´.)", --).Brawndo~Man.(--
	[87892] = "`†Ðõ†§†´", -- Maiden of Cups
	[26375] = "×♦ÐîÐî♦×", -- ×♦ÐîÐî♦× ⌂RøçkéTWréñçh⌂
	[24877] = "∞χΔθΔχ∞", -- Oracle of Time
	[43460] = "£/ώ\\Ř", -- `Jancy´ https://www.wowhead.com/npc=59184/jandice-barov ώ
    [14855] = "♣Δ\\°/Δ♣", -- The Leprechaun
	[21723] = "Ħ°Ħ", -- ĦM°Ģrg°gleĦ
	[75730] = "♦†.Y.†♦", -- ťĤę þŗ†ŋÇę
	[42360] = "ω(.^.)ω", -- The Chef
	[5233] = "^(♠ώ♠)^", -- The Dark Lady/Spirit Healer
	[28213] = "^(♠ώ♠)^",
	[30076] = "d(•-•)b", -- The Engineer - Jeeves
	[128099] = "♣•>ώ<•♣", -- Bachus - Lord Saltheril snarks = {7236685,7236714,7236744,7236626}
	
	-- `Snark<~s•-•s~> and (•)`Brokers´(♥)
	-- `Goblin.•.Broker´
	[550846] = "(•)♥)",
	[550869] = "(•)♥)",
	[550848] = "(•)♥)",
	[550835] = "(•)♥)",
	[550858] = "(•)♥)",
	[550832] = "(•)♥)",
	[550845] = "(•)♥)",
	[550851] = "(•)♥)",
	[3089702] = "(•)♥)",
	
	-- `Goblin~Broker`
	[550805] = "(•)°",
	
	-- Jancy - Mistress of Illusion
	[552156] = "£/ώ\\Ř",
	[552157] = "£/ώ\\Ř",
	[552164] = "£/ώ\\Ř",
	[552165] = "£/ώ\\Ř",
	
	--Bouyant Meadows
	[547796] = "(•´¤`•)",
	[547788] = "(•´¤`•)",
	[547785] = "(•´¤`•)",
	[547790] = "(•´¤`•)",
	
	-- Brawndo Man
	[545429] = ").`B´.)",
	[545476] = ").`B´.)",
	[545489] = ").`B´.)",
	[545491] = ").`B´.)",
	
	
	-- Daughter of the Sea
	[3534100] = "`†Ðõ†§†´",
	[2012997] = "`†Ðõ†§†´",
	--["`†Ðõ†§†´"] = "",
	
	-- Oracle of Time
	[3049652] = "∞χΔθΔχ∞",
	[3049653] = "∞χΔθΔχ∞",
	[3049655] = "∞χΔθΔχ∞",
	[3049658] = "∞χΔθΔχ∞",
	
	-- ×♦ÐîÐî♦× ⌂RøçkéTWréñçh⌂
	[550640] = "×♦ÐîÐî♦×",
	[550659] = "×♦ÐîÐî♦×",
	[550665] = "×♦ÐîÐî♦×",
	[550654] = "×♦ÐîÐî♦×",
	[550660] = "×♦ÐîÐî♦×",
	[550657] = "×♦ÐîÐî♦×",
	[550643] = "×♦ÐîÐî♦×",
	
	--The Chef
	[632512] = "ω(.^.)ω",
	[632514] = "ω(.^.)ω",
	[632506] = "ω(.^.)ω",
	
	-- Kaldorei Mailbox Dancer
	[541055] = "\\°/",
	
	--~°B°°gers~∩~B•ps~--•
	
	-- Sayaad Barmaid -- B°°ger
	[561158] = "&ω\\", 
	[561156] = "&ω\\",
	[561158] = "&ω\\",
	[561158] = "&ω\\",
	
	-- Shy Turtle Tom -- B•p
	[559193] = "↓.^.↓",
	
	[550736] = "Ħ°Ħ", -- Gremlin
	
	[1860609] = "♦†.Y.†♦",
	[1860610] = "♦†.Y.†♦",
	[1860611] = "♦†.Y.†♦",
	[1860612] = "♦†.Y.†♦",
	[1860624] = "♦†.Y.†♦",
	
	-- Dark Lady
	[561297] = "^(♠ώ♠)^",
	[561327] = "^(♠ώ♠)^",
	[561346] = "^(♠ώ♠)^",
	[561301] = "^(♠ώ♠)^",
	
	--The Engineer
	[546274] = "d(•-•)b",
	[546277] = "d(•-•)b",
	[546285] = "d(•-•)b",
	
	
	--↓(↑)↓
							-- Bωωber --
	["Geordie"] = "(.Y.)", -- .ωas ω herω. --
}

Lunacy.trOlls = trOlls

--550736 ooga horn

local wHIspRES = {
	[550892] = "°(•)`You're just embarrasing yourself´(•)°",
	[550888] = "°(•)`I do not have time for this´(•)°",
	[550846] = "(•)♥) tsk` you're just embarrassing yourself~´",
	[550869] = "(•)♥) Will you knock it off >~´",
	[550848] = "(•)♥)",
	[550835] = "(•)♥) Got the best deals anywhere!",
	[550858] = "(•)♥)",
	[550832] = "(•)♥) What part of 'time is money', don't `you´ understand?",
	[550845] = "(•)♥)",
	[550851] = "(•)♥) hey! tickling costs extra bub!",
	[541055] = "\\°/ Elune Be Praised! \\°/", -- ✓
	[559193] = "↓.^.↓ it's turtles all the way down ↓.^.↓", -- ✓
	[568873] = "(.Y.) Squeeeeel~", -- ✓
	[546621] = "↓(↑)↓ you..are..already...dead...", -- ↓(↑)↓ C'thun aka Bobby Kotick 104732
	[546627] = "↓(↑)↓ death..is..close..",
	[546631] = "~szhezawoookata~", -- ✓
	[567134] = "~.×.×.×.×.×.×.~", -- ✓×××
	[3089702] = "(•)♥) Well, Well, Look who it is >.< (•)♥)", -- `Goblin.•.Broker´ ✓
	[3534100] = "`†Ðõ†§†´ How is your day going?", -- ✓ `-Œ†Ðõ†§´ß
	[548759] = "..ahhhooooowaahaah..", -- ✓
	[561158] = "&ω\\ Being bad never felt so good &ω\\", -- Sayaad Barmaid ✓
	[561156] = "&ω\\ Let's have some fun &ω\\", -- Sayaad Barmaid ✓
	[550805] = "(•)°Time is money friend°(•)", -- Goblin Broker ✓
	[550813] = "(•)°What's up?°(•)", -- Goblin Broker ✓
	[550806] = "How's your day going?",
	[550809] = "How's your day going?",
	[633949] = "ω♥∩ ...Mograine... ∩♥ω", -- Sister Sally ✓
	[1860609] = "♦†.Y.†♦ You better be here to make me money.",
	[1860624] = "♦†.Y.†♦ You're just jealous of my pleasure palace.",
	[1860610] = "♦†.Y.†♦ Make it snappy kid.",
	[1860611] = "How's your day going?",
	[1860612] = "How's your day going?",
	[1860613] = "How's your day going?",
	[1860614] = "How's your day going?",
	[1860615] = "How's your day going?",
	[561297] = "How's your day going?",
	[561327] = "How's your day going?",
	[561346] = "How's your day going?",
	[561301] = "How's your day going?",
	[1466150] = "&ω\\ Mmm Thwaaaack &ω\\", -- Sayaad Barmaid ✓
	[561160] = "&ω\\Now you're talking &ω\\", -- Sayaad Barmaid ✓
	[561165] = "How's your day going?",
	[550478] = "How's your day going?",
	[550466] = "How's your day going?",
	[550472] = "How's your day going?",
	[550473] = "How's your day going?",
	[558452] = "How's your day going?",
	[558418] = "`(•Y•) Great News! Everyone! (•Y•)´", -- Deranged Alchemy Professor
	[558404] = "(•Y°) That was unexpected", -- Deranged Alchemy Professor
	[558387] = "(•Y•) Taste's like cherries... oh, excuse me!",
	[545429] = "How's your day going?",
	[545476] = "How's your day going?",
	[547788] = "(•´¤`•) Ahhh! The Great Outdoors!", --Bouyant Meadows ✓
	[547796] = "(•´¤`•) Hi!", --Bouyant Meadows ✓
	[547785] = "(•´¤`•) Is there trouble?!", --Bouyant Meadows ✓
	[547790] = "(•´¤`•) What is nature's call?", --Bouyant Meadows ✓
	[550848] = "(•)♥) I got whatcha need. (•)♥)",
	[545429] = ").`B´.) The answers are here, I can feel it!",
	[545476] = ").`B´.) Loads of forgotten knowledge are within our grasp.", -- ~The Ale`Barrel Brigade~
	[545489] = ").`B´.) You'll find me, wherever the action is.", --Þ×Þ×Þ
	[545491] = ").`B´.) Enquiring minds!, just got to know.", -- 		î-Brawndo Man-î
	[2012997] = "`†Ðõ†§†´ What would you ask the Ðãüg†hér õf †hé §éã?", -- Maiden of Cups
	[550640] = "×♦ÐîÐî♦×",
	[550659] = "×♦ÐîÐî♦×",
	[550665] = "×♦ÐîÐî♦×",
	[550654] = "×♦ÐîÐî♦×",
	[550660] = "×♦ÐîÐî♦×",
	[550657] = "×♦ÐîÐî♦×",
	[550643] = "×♦ÐîÐî♦× I don't have time for this. >.<",
	[3049652] = "∞χΔθΔχ∞ It's like meeting again for the first time!∞",
	[3049653] = "∞χΔθΔχ∞ Hmmm... Haven't we done this before?∞",
	[3049655] = "∞χΔθΔχ∞ I always have time for you.",
	[3049658] = "∞χΔθΔχ∞ Time is always on my side.∞",
	[552156] = "£/ώ\\Ř Uhh.. I'm kind of busy..",
	[552157] = "£/ώ\\Ř Quit it!",
	[552164] = "£/ώ\\Ř What's you're problem?",
	[552165] = "£/ώ\\Ř You're getting on my nerves >.<", --Jancy £/ώ\\Ř
	[550736] = "Ħ°Ħ Ăáááħħħ~òóòóòó~ğàààĥĥĥ",
	[632512] = "ω(.^.)ω Is there not something more productive you could do with your hands?", -- The Chef
	[632514] = "ω(.^.)ω ",
	[632506] = "ω(.^.)ω ",
	[561297] = "^(♠ώ♠)^",
	[561327] = "^(♠ώ♠)^",
	[561346] = "^(♠ώ♠)^",
	[561301] = "^(♠ώ♠)^",
	[546274] = "d(•-•)b",
	[546277] = "d(•-•)b",
	[546285] = "d(•-•)b",
	
}

Lunacy.wHIspRES = wHIspRES

-- Params; id,xoff,yoff,zoff,camtarX,camtarY,camtarZ,pitch,yaw,gizmo,
-- 		   rotinc,dance,camdis,sandyRot,campulse,camMin,camMax,nospin

local dosier = {
	["id"] = 0,
	["xoff"] = 0,
	["yoff"] = 0,
	["zoff"] = 0,
	["camtarX"] = 0,
}

