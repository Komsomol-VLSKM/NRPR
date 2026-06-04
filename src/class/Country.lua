-- Values --

local ReplicatedStorage = game:GetService("ReplicatedStorage")

--local Types = require(ReplicatedStorage.Types)

local Country = {}
Country.__index = Country

local countryId = 0

-- Functions --

function Country.new(countryFolder: Folder): Types.Country
	local ColorValue: BrickColorValue = countryFolder.COLOR
	local LeaderValue: ObjectValue = countryFolder.Leader
	local IncomeValue: NumberValue = countryFolder.Income
	local BalanceValue: NumberValue = countryFolder.Balance
	local SpawnCooldownValue: NumberValue = countryFolder.SpawnCooldown
	
	local self: Types.Country = setmetatable({
		name = countryFolder.Name,
		color = ColorValue.Value,
		leader = LeaderValue.Value,
		id = countryId,
		folder = countryFolder,
		unitsFolder = countryFolder.Units,
	}, Country)
	
	countryId += 1
	
	countryFolder.Changed:Connect(function(property)
		if property == "Name" then
			self.name = countryFolder.Name
		end
	end)
	
	ColorValue.Changed:Connect(function()
		self.color = ColorValue.Value
	end)
	
	LeaderValue.Changed:Connect(function()
		self.leader = LeaderValue.Value
	end)
	
	IncomeValue.Changed:Connect(function()
		self.income = IncomeValue.Value
	end)
	
	BalanceValue.Changed:Connect(function()
		self.balance = BalanceValue.Value
	end)
	
	SpawnCooldownValue.Changed:Connect(function()
		self.spawnCooldown = SpawnCooldownValue.Value
	end)
	
	return self
end

-- Script --

return Country
