local repo = "https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/"

local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local Window = Library:CreateWindow({
	Title = "Fireteam [v0.2.0e]",
	Center = true,
	AutoShow = true,
})

local Tabs = {
	Main = Window:AddTab("Main"),
	Settings = Window:AddTab("Settings"),
}

local LeftGroup = Tabs.Main:AddLeftGroupbox("Select Role")
local RightGroup = Tabs.Main:AddRightGroupbox("Spawn Ammo Bag")
local Settings = Tabs.Settings:AddLeftGroupbox("Window")

LeftGroup:AddDropdown("Dropdown1", {
	Values = {
		"Fireteam Leader",
		"Cell Leader",
		"Corpsman",
		"Medic",
		"Automatic Rifleman",
		"Machine Gunner",
		"Light Anti Tank",
		"Rocketeer",
		"Grenadier",
		"Grenadier // AKM",
		"Grenadier // AK-74N",
	},
	Multi = false,
	Text = "Roles",
	Tooltip = "Join a Fireteam first then select Role.",
})

RightGroup:AddSlider("Slider1", {
	Text = "Spawn Increment",
	Default = 2,
	Min = 1,
	Max = 10,
	Rounding = 0,
	Compact = true,
})

Library:OnUnload(function()
	Library.Unloaded = true
end)

Settings:AddButton("Unload UI", function()
		Library:Unload()
	end):AddTooltip("This button destroys the Script that is Excecuted.")

-- LeftGroup --

local MarjawiButton = LeftGroup:AddButton("Spawn in Marjawi", function()
	local Arguments = {
		[1] = CFrame.new(
			564.243225,
			54.2584457,
			1753.72925,
			0.0165456533,
			0.309840292,
			-0.95064503,
			0.162902847,
			0.937235653,
			0.308305234,
			0.98650372,
			-0.159963802,
			-0.0349666178
		),
	}
	game:GetService("ReplicatedStorage").Events.SpawnPlayer:FireServer(unpack(Arguments))
end)

-- More Spawn Waypoints? maybe soon or just lazy.....

-- RightGroup --
local Incremented
function amb1()
	for i = 1, Incremented do
		local Arguments = {
			[1] = 1,
			[2] = "AmmoSource",
			[3] = game:GetService("ReplicatedStorage").Assets.Buildable.Team2.AmmoBag,
			[4] = game.Players.LocalPlayer.Character.Torso.CFrame,
			[5] = 2,
		}
		game:GetService("ReplicatedStorage").Events.BuildObject:FireServer(unpack(Arguments))
	end
    Library:Notify("Spawned " .. Incremented .. " Ammo Bag's")
end

function amb2()
	for i = 1, Incremented do
		local Arguments = {
			[1] = 2,
			[2] = "AmmoSource",
			[3] = game:GetService("ReplicatedStorage").Assets.Buildable.Team2.AmmoBag,
			[4] = game.Players.LocalPlayer.Character.Torso.CFrame,
			[5] = 2,
		}
		game:GetService("ReplicatedStorage").Events.BuildObject:FireServer(unpack(Arguments))
	end
    Library:Notify("Spawned " .. Incremented .. " Ammo Bag's")
end

-- United States
local USMCButton = RightGroup:AddButton("USMC", function()
		amb1()
	end):AddTooltip("Spawns a United States Team Ammo Bag")

-- Canada
local CAFButton = RightGroup:AddButton("CAF", function()
		amb1()
	end):AddTooltip("Spawns a Canada Team Ammo Bag")

-- Russia
local RGFButton = RightGroup:AddButton("RGF", function()
		amb2()
	end):AddTooltip("Spawns a Russia Team Ammo Bag")

-- Insurgents
local INSButton = RightGroup:AddButton("INS", function()
		amb2()
	end):AddTooltip("Spawns a Insurgents Team Ammo Bag")

Options.Dropdown1:OnChanged(function()
	Library:Notify("Changed to " .. Options.Dropdown1.Value, 1)
	local Args = {
		[1] = game:GetService("Players").LocalPlayer.PlayerData.FireteamID.Value,
		[2] = "Infantry",
		[3] = tostring(Options.Dropdown1.Value),
	}
	game:GetService("Players").Events.SelectRole:FireServer(unpack(Args))
end)

Options.Slider1:OnChanged(function()
	Incremented = Options.Slider1.Value
end)