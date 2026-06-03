-- Values --

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

--local Types = require(ReplicatedStorage.Types)

local RemoteCalls = loadstring(game:HttpGet("https://raw.githubusercontent.com/Komsomol-VLSKM/NRPR/refs/heads/main/src/RemoteCalls.lua"))()

local Unit = {}
Unit.__index = Unit

-- Functions --

function Unit.new(unitType, position, province): Types.Unit
	local self: Types.Unit = setmetatable({
		unitType = unitType,
		position = position,
	}, Unit)
	
	if not RunService:IsStudio() then
		RemoteCalls.spawnTroop(province, position, unitType)
	else
		local part = Instance.new("Part")
		self.model = part
		part.Anchored = true
		part.CanCollide = false
		part.CanQuery = false
		part.CanTouch = false
		part.Shape = Enum.PartType.Ball
		part.Size = Vector3.new(0.5, 0.5, 0.5)
		part.Color = Color3.fromRGB(255, 255, 255)
		part.Material = Enum.Material.Neon
		part.Position = position
		part.Parent = workspace
	end
	
	return self
end

function Unit.move(self: Types.Unit, position)
	if RunService:IsStudio() then
		local distance = (self.model.Position - position).Magnitude
		local speed = distance / 0.2
		TweenService:Create(self.model, TweenInfo.new(speed, Enum.EasingStyle.Linear), {Position = position}):Play()
	else
		RemoteCalls.moveTroop(self.model, position)
	end
end

function Unit.disband(self: Types.Unit)
	if RunService:IsStudio() then
		self.model:Destroy()
	end
end

function Unit.train(self: Types.Unit, bool)
	if not RunService:IsStudio() then
		RemoteCalls.train(self.model, bool)
	else
		self.model.Color = if bool then Color3.fromRGB(255, 255, 255) else Color3.fromRGB(0, 0, 0)
	end
end

function Unit.garrison(self: Types.Unit, unit: Types.Unit)
	if not RunService:IsStudio() then
		RemoteCalls.garrison(self.model, unit.model)
	else
		self.model.Parent = unit.model
	end
end

-- Script --

return Unit
