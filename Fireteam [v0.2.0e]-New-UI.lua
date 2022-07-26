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

Settings:AddButton("Unload UI", function()
	Library:Unload()
end):AddTooltip("This button destroys the Script that is Excecuted.")

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

LeftGroup:AddButton("Spawn Anywhere", function()
	Library:Notify("Click a teammate on the Map",5)
	
	local MapIcons = game:GetService("Players").LocalPlayer.PlayerGui.Menu.Menu.Deploy.Frame.Windows.MapFrame.MapUI.Map.Holder.Map.MapIcons
	local PlayersFolder = game:GetService("Workspace"):FindFirstChild("Players")

	for _, value in pairs(MapIcons:GetChildren()) do
		if value:IsA("Frame") then
			local GetPlayer
			game:GetService("UserInputService").InputBegan:Connect(function(key)
				if key.KeyCode == Enum.KeyCode.G and GetPlayer ~= nil then
					local PlayerPosition = PlayersFolder:FindFirstChild(tostring(GetPlayer)).HumanoidRootPart.Position
					local A = {
						[1] = CFrame.new(PlayerPosition),
					}
					game:GetService("ReplicatedStorage").Events.SpawnPlayer:FireServer(unpack(A))
					Library:Notify("Successfully spawned to " .. tostring(GetPlayer), 2)
					GetPlayer = nil		
					return
				end
			end)

			value.MouseEnter:Connect(function()
				local UICorner = Instance.new("UICorner")
				UICorner.Parent = value
				value.Transparency = 0
				value.BackgroundColor3 = Color3.new(0.933333, 0, 1)
				GetPlayer = value.Name
			end)

			value.MouseLeave:Connect(function()
				value:FindFirstChild("UICorner"):Destroy()
				value.Transparency = 1
				value.BackgroundColor3 = Color3.new(255, 255, 255)
				GetPlayer = nil
			end)
		end
	end
end)

-- RightGroup --

function amb1(arg)
	for i = 1, tonumber(arg) do
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

function amb2(arg)
	for i = 1, tonumber(arg) do
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

local USMCButton = RightGroup:AddButton("USMC", function()
		amb1(Options.Slider1.Value)
	end):AddTooltip("Spawns a United States Team Ammo Bag")

local CAFButton = RightGroup:AddButton("CAF", function()
		amb1(Options.Slider1.Value)
	end):AddTooltip("Spawns a Canada Team Ammo Bag")

local RGFButton = RightGroup:AddButton("RGF", function()
		amb2(Options.Slider1.Value)
	end):AddTooltip("Spawns a Russia Team Ammo Bag")

local INSButton = RightGroup:AddButton("INS", function()
		amb2(Options.Slider1.Value)
	end):AddTooltip("Spawns a Insurgents Team Ammo Bag")

Options.Dropdown1:OnChanged(function()
	Library:Notify("Changed to " .. tostring(Options.Dropdown1.Value), 1)
	local Args = {
		[1] = game:GetService("Players").LocalPlayer.PlayerData.FireteamID.Value,
		[2] = "Infantry",
		[3] = tostring(Options.Dropdown1.Value),
	}
	game:GetService("ReplicatedStorage").Events.SelectRole:FireServer(unpack(Args))
end)

Options.Slider1:OnChanged(function()
	Incremented = Options.Slider1.Value
end)

function UAAB()
	if not game:IsLoaded() then return end
	local MT = getrawmetatable(game)
	local Hook = MT.__namecall

	setreadonly(MT, false)
	MT.__namecall = newcclosure(function(Remote, ...)
		local Args = {...}
		local Method = getnamecallmethod()
		
		if Method == 'FireServer' and Remote.Name == 'UpdateAmmoBagSupplies' then
			Args[2] = 1e9
			return Hook(Remote, unpack(Args))
		end
		return Hook(Remote, ...)
	end)
	setreadonly(MT, true)
end

local INFAmmoButton = RightGroup:AddButton("INFAMMO", function()
	UAAB()
end):AddTooltip("Unlimited Ammo(Only on AmmoBags) ")

-- End --

Library:Notify('Script Initialized 🟢 ')
