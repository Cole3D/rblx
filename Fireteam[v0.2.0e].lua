local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()

local UI = Material.Load({
	Title = "Fireteam [v0.2.0e]",
	Style = 2,
	SizeX = 350,
	SizeY = 350,
	Theme = "Dark",
	ColorOverrides = {
		MainFrame = Color3.fromRGB(54, 54, 54),
	},
})

local Page = UI.New({
	Title = "Main",
})

Page.Dropdown({
	Text = "Force Role",
	Callback = function(val)
		local Arguments = {
			[1] = game:GetService("Players").LocalPlayer.PlayerData.FireteamID.Value,
			[2] = "Infantry",
			[3] = tostring(val),
		}
		game:GetService("Players").Events.SelectRole:FireServer(unpack(Arguments))
	end,
	Options = {
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
})

local function AmmoBox1()
	local Arguments = {
		[1] = 1,
		[2] = "AmmoSource",
		[3] = game:GetService("ReplicatedStorage").Assets.Buildable.Team2.AmmoBag,
		[4] = game.Players.LocalPlayer.Character.Torso.CFrame,
		[5] = 2,
	}
	game:GetService("ReplicatedStorage").Events.BuildObject:FireServer(unpack(Arguments))
end

local function AmmoBox2()
	local Arguments = {
		[1] = 2,
		[2] = "AmmoSource",
		[3] = game:GetService("ReplicatedStorage").Assets.Buildable.Team2.AmmoBag,
		[4] = game.Players.LocalPlayer.Character.Torso.CFrame,
		[5] = 2,
	}
	game:GetService("ReplicatedStorage").Events.BuildObject:FireServer(unpack(Arguments))
end

Page.Dropdown({
	Text = "Spawn Stuff",
	Callback = function(val)
		if val == "AmmoBox(USA & Canada)" then
			AmmoBox1()
		elseif val == "AmmoBox(Insurgent & Russia)" then
			AmmoBox2()
		end
	end,
	Options = {
		"AmmoBox(USA & Canada)", -- Part1
		"AmmoBox(Insurgent & Russia)", -- Part2
	},
})

Page.Button({
	Text = "Spawn in Marjawi",
	Callback = function()
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
	end,
})

