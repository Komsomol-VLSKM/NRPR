-- Values --

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

local Country = loadstring(game:HttpGet("https://raw.githubusercontent.com/Komsomol-VLSKM/NRPR/refs/heads/main/src/class/Country.lua"))()

local CountryService = {
	countries = {}
}

-- Functions --

function CountryService.init(self: CountryService)
	if RunService:IsStudio() then
		return
	end
	
	local countriesFolder: Folder = workspace.Countries
	countriesFolder.ChildAdded:Connect(function(countryFolder)
		local country = Country.new(countryFolder)
		self.countries[country.id] = country
	end)
	
	countriesFolder.ChildRemoved:Connect(function(countryFolder)
		self.countries[self:getCountryFromCountryFolder(countryFolder).id] = nil
	end)
end

function CountryService.getCountryFromCountryFolder(self: CountryService, countryFolder: Folder): Country
	for id, country in self.countries do
		if countryFolder == country.folder then
			return country
		end
	end
end

function CountryService.getCountryFromPlayer(self: CountryService, player)
	return self:getCountryFromCountryFolder(player.Country.Value)
end

-- Script --

type CountryService = typeof(CountryService)

return CountryService :: CountryService
