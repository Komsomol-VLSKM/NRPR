local RemoteCalls = {}

------------
-- BASICS --
------------

function RemoteCalls.spawnTroop(province, position, unitType)
	--local args = {
	--	workspace:WaitForChild("Map"):WaitForChild("Province"),
	--	vector.create(-21.56826400756836, -58.49993896484375, 86.84256744384766),
	--	"Troop"
	--}
	game:GetService("ReplicatedStorage"):WaitForChild("SpawnTroop"):FireServer(
		province,
		position,
		unitType
	)
end

function RemoteCalls.moveTroop(troop, position)
	--local args = {
	--	workspace:WaitForChild("Countries"):WaitForChild("a"):WaitForChild("Units"):WaitForChild("Troop"),
	--	vector.create(-23.651321411132812, -58.500099182128906, 86.5311050415039),
	--	"lJWWH5Vj\232\131y\231F\238$"
	--}
	game:GetService("ReplicatedStorage"):WaitForChild("MoveTroop"):FireServer(troop, position)
end

function RemoteCalls.disbandTroop(troop)
	--local args = {
	--	Instance.new("Model", nil)
	--}
	game:GetService("ReplicatedStorage"):WaitForChild("DisbandTroop"):FireServer(troop)
end

function RemoteCalls.train(troop, toggle)
	--local args = {
	--	workspace:WaitForChild("Countries"):WaitForChild("a"):WaitForChild("Units"):WaitForChild("Troop"),
	--	true
	--}
	game:GetService("ReplicatedStorage"):WaitForChild("TrainTroop"):FireServer(troop, toggle)

end

function RemoteCalls.garrison(unit, troop)
	--local args = {
	--	workspace:WaitForChild("Countries"):WaitForChild("russia"):WaitForChild("Units"):WaitForChild("Transport Truck"),
	--	Instance.new("Model", nil)
	--}
	--local args = {
	--	workspace:WaitForChild("Countries"):WaitForChild("russia"):WaitForChild("Units"):WaitForChild("Transport Truck"),
	--	false
	--}
	game:GetService("ReplicatedStorage"):WaitForChild("Garrison"):FireServer(unit, troop)
end

---------------------
-- COUNTRY RELATED --
---------------------

function RemoteCalls.countryLeader(action, value)
	--local args = {
	--	"name",
	--	"Nation"
	--}
	
	--local args = {
	--	"color",
	--	BrickColor.new(1026)
	--}
	
	--local args = {
	--	"def_addtroops",
	--	false
	--}
	
	--local args = {
	--	"def_movetroops",
	--	false
	--}
	
	--local args = {
	--	"def_disbandtroops",
	--	false
	--}
	
	--local args = {
	--	"def_traintroops",
	--	false
	--}
	
	--local args = {
	--	"def_disableanti",
	--	false
	--}	
	
	--local args = {
	--	"breakally",
	--	workspace:WaitForChild("Countries"):WaitForChild("Vost Dor")
	--}
	
	--local args = {
	--	"subjugate",
	--	Instance.new("Folder", nil)
	--}
	--local args = {
	--	"money",
	--	Instance.new("Folder", nil),
	--	1000
	--}
	--local args = {
	--	"loan",
	--	Instance.new("Folder", nil),
	--	1000,
	--	10,
	--	10
	--}
	--local args = {
	--	"formally",
	--	workspace:WaitForChild("Countries"):WaitForChild("China")
	--}
	--local args = { -- trade tool
	--	"province",
	--	workspace:WaitForChild("Countries"):WaitForChild("russia"),
	--	workspace:WaitForChild("Map"):WaitForChild("Province")
	--}
	--local args = {
	--	"acceptally",
	--	workspace:WaitForChild("Countries"):WaitForChild("Republic of Ireland ")
	--}
	game:GetService("ReplicatedStorage"):WaitForChild("CountryLeader"):FireServer(action, value)
end

function RemoteCalls.leaveCountry()
	game:GetService("ReplicatedStorage"):WaitForChild("LeaveCountry"):FireServer()
end

function RemoteCalls.createCountry(name, color)
	--local args = {
	--	"h",
	--	BrickColor.new(125)
	--}
	
	game:GetService("ReplicatedStorage"):WaitForChild("CreateCountry"):FireServer(name, color)
end

function RemoteCalls.joinCountry(country)
	--local args = {
	--	workspace:WaitForChild("Countries"):WaitForChild("WPWA")
	--}
	game:GetService("ReplicatedStorage"):WaitForChild("JoinCountry"):FireServer(country)
end

----------
-- MISC --
----------

function RemoteCalls.nameFilter(text)
	--local args = {
	--	"h"
	--}
	
	game:GetService("ReplicatedStorage"):WaitForChild("NameFilter"):InvokeServer(text)
end

function RemoteCalls.voteEraReset(bool)
	--local args = {
	--	true
	--}
	game:GetService("ReplicatedStorage"):WaitForChild("voteresetmap"):FireServer(bool)
end

function RemoteCalls.voteMap(mapName)
	--local args = {
	--	"Modern"
	--}
	--local args = {
	--	"ColdWar"
	--}
	--local args = {
	--	"WW2"
	--}
	--local args = {
	--	"WW1"
	--}
	game:GetService("ReplicatedStorage"):WaitForChild("votemap"):FireServer(mapName)
end

function RemoteCalls.misc(action, value)
	--local args = {
	--	"equiptitle",
	--	"cc"
	--}
	--local args = {
	--	"savesetting",
	--	{
	--		bme = true,
	--		bm = 0.2220056653022766,
	--		sfx = 1,
	--		rsm = false,
	--		cn = true,
	--		pre = true,
	--		qac = false
	--	}
	--}
	game:GetService("ReplicatedStorage"):WaitForChild("misc"):FireServer(action, value)
end

function RemoteCalls.quest(action, value)
	--local args = {
	--	"claim",
	--	Instance.new("NumberValue", nil)
	--}
	game:GetService("ReplicatedStorage"):WaitForChild("Quests"):FireServer(action, value)
end

----------------------
-- RESTRICTED TOOLS --
----------------------

function RemoteCalls.devTool(object, country, value)
	--local args = {
	--	"money",
	--	workspace:WaitForChild("Countries"):WaitForChild("a"),
	--	1000
	--}
	
	--local args = {
	--	"province",
	--	workspace:WaitForChild("Countries"):WaitForChild("a"),
	--	workspace:WaitForChild("Map"):WaitForChild("Province")
	--}
	game:GetService("ReplicatedStorage"):WaitForChild("DevTool"):FireServer(object, country, value)
end

function RemoteCalls.launchFirework(position)
	--local args = {
	--	vector.create(-47.389190673828125, -58.4999885559082, 94.58425903320312)
	--}
	game:GetService("Players").LocalPlayer:WaitForChild("Backpack"):WaitForChild("FireworkTool"):WaitForChild("RemoteEvent"):FireServer(position)
end

function RemoteCalls.launchIBGM(position)
	--local args = {
	--	vector.create(-47.389190673828125, -58.4999885559082, 94.58425903320312)
	--}
	game:GetService("Players").LocalPlayer:WaitForChild("Backpack"):WaitForChild("IGBMTool"):WaitForChild("RemoteEvent"):FireServer(position)
end

function RemoteCalls.cityBuilder(action, properties)
	--local args = {
	--	"Spawn",
	--	{
	--		Rotation = 0,
	--		Template = "City",
	--		Name = "kmkk;",
	--		Position = vector.create(-29.323850631713867, -58.50002670288086, 84.6697998046875)
	--	}
	--}
	--local args = {
	--	"Disband",
	--	{
	--		Cities = {
	--			Instance.new("Model", nil)
	--		}
	--	}
	--}
	game:GetService("ReplicatedStorage"):WaitForChild("CityBuilderRemote"):FireServer(action, properties)

end

function RemoteCalls.updateProvinceIncome(provinceIds, level, tool)
	--local args = {
	--	{
	--		"P1795"
	--	},
	--	4,
	--	game:GetService("Players").LocalPlayer:WaitForChild("Backpack"):WaitForChild("ProvinceIncome")
	--}
	game:GetService("ReplicatedStorage"):WaitForChild("UpdateProvinceIncome"):FireServer(provinceIds, level, tool)
end

function RemoteCalls.hostingTool(action, properties)
	--local args = {
	--	"pause", -- pauses wars
	--	{}
	--}
	--local args = {
	--	"timeout",
	--	{
	--		c = workspace:WaitForChild("Countries"):WaitForChild("h")
	--	}
	--}
	--local args = {
	--	"province",
	--	{
	--		c = workspace:WaitForChild("Countries"):WaitForChild("h"),
	--		pv = workspace:WaitForChild("Map"):WaitForChild("Province")
	--	}
	--}
	--local args = {
	--	"dbndtrps",
	--	{
	--		c = workspace:WaitForChild("Countries"):WaitForChild("h")
	--	}
	--}
	--local args = {
	--	"balance",
	--	{
	--		c = workspace:WaitForChild("Countries"):WaitForChild("h"),
	--		amount = 100
	--	}
	--}
	--local args = {
	--	"toggleunit",
	--	{
	--		unit = "Frigate"
	--	}
	--}
	--local args = {
	--	"setallunits",
	--	{
	--		enabled = false
	--	}
	--}
	game:GetService("ReplicatedStorage"):WaitForChild("Hosting"):FireServer(action, properties)
end

--------------
-- WORKSHOP --
--------------

function RemoteCalls.openWorkshop()
	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("OpenWorkshop"):FireServer()
end

function RemoteCalls.browseWorkshop()
	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("WorkshopBrowse"):InvokeServer()
end

function RemoteCalls.myWorkshopMaps()
	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("WorkshopMyMaps"):InvokeServer()
end

function RemoteCalls.publishWorkshopMap(flagId, title, desc)
	--local args = {
	--	{
	--		Flag = "14471275464",
	--		Title = "gggg",
	--		Desc = "ggg"
	--	}
	--}
	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("WorkshopPublish"):FireServer({
		Flag = flagId,
		Title = title,
		Desc = desc
	})
end

function RemoteCalls.deleteWorkshopMap(mapId)
	--local args = {
	--	"7a2b9d9e98b84656"
	--}
	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("WorkshopDelete"):FireServer(mapId)
end

return RemoteCalls
