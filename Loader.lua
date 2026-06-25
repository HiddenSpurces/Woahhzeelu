--- Open Sourced
--- Only the loader is open sourced lol


if getgenv().ngaaa then
    warn("already executed [Zilu]")
    return
end
loadstring(game:HttpGet("https://raw.githubusercontent.com/HiddenSpurces/Woahhzeelu/refs/heads/main/assets/loadingscreen.lua"))()
wait(2.5)
local Gui = Instance.new("ScreenGui")
Gui.Name           = "wtfLoad"
Gui.ResetOnSpawn   = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.IgnoreGuiInset = true
Gui.DisplayOrder   = 300
Gui.Parent         = game.CoreGui
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local Notifications = {}
local MaxNotifications = 5

local Width = 250
local Height = 68
local Spacing = 8
local MarginTop = 15
local MarginRight = 15

local function UpdateStack()
	for i, Data in ipairs(Notifications) do
		TweenService:Create(
			Data.Frame,
			TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
			{
				Position = UDim2.new(
					1,
					-(Width + MarginRight),
					0,
					MarginTop + ((i - 1) * (Height + Spacing))
				)
			}
		):Play()
	end
end

local function RemoveNotification(Data)
	local Index = table.find(Notifications, Data)

	if Index then
		table.remove(Notifications, Index)
	end

	local Tween = TweenService:Create(
		Data.Frame,
		TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
		{
			Position = UDim2.new(
				1,
				20,
				0,
				Data.Frame.Position.Y.Offset
			)
		}
	)

	Tween:Play()
	Tween.Completed:Wait()

	Data.Frame:Destroy()

	UpdateStack()
end

function notify(Config)
	local Title = Config.Title or "Notification"
	local Desc = Config.Desc or ""
	local Time = Config.Time or 6

	while #Notifications >= MaxNotifications do
		RemoveNotification(Notifications[1])
	end

	local Frame = Instance.new("Frame")
	Frame.Size = UDim2.fromOffset(Width, Height)
	Frame.Position = UDim2.new(1, 20, 0, MarginTop)
	Frame.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
	Frame.BorderSizePixel = 0
	Frame.Parent = Gui

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 10)
	Corner.Parent = Frame

	local Accent = Instance.new("Frame")
	Accent.Size = UDim2.new(0, 4, 1, 0)
	Accent.BackgroundColor3 = Color3.fromRGB(134, 134, 2)
	Accent.BorderSizePixel = 0
	Accent.Parent = Frame

	local AccentCorner = Instance.new("UICorner")
	AccentCorner.CornerRadius = UDim.new(0, 10)
	AccentCorner.Parent = Accent

	local TitleLabel = Instance.new("TextLabel")
	TitleLabel.BackgroundTransparency = 1
	TitleLabel.Position = UDim2.fromOffset(18, 8)
	TitleLabel.Size = UDim2.new(1, -28, 0, 14)
	TitleLabel.Font = Enum.Font.GothamBold
	TitleLabel.Text = Title
	TitleLabel.TextSize = 13
	TitleLabel.TextColor3 = Color3.fromRGB(235, 235, 235)
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	TitleLabel.Parent = Frame

	local DescLabel = Instance.new("TextLabel")
	DescLabel.BackgroundTransparency = 1
	DescLabel.Position = UDim2.fromOffset(18, 22)
	DescLabel.Size = UDim2.new(1, -28, 0, 22)
	DescLabel.Font = Enum.Font.Gotham
	DescLabel.Text = Desc
	DescLabel.TextWrapped = true
	DescLabel.TextSize = 10
	DescLabel.TextColor3 = Color3.fromRGB(140, 140, 140)
	DescLabel.TextXAlignment = Enum.TextXAlignment.Left
	DescLabel.TextYAlignment = Enum.TextYAlignment.Top
	DescLabel.Parent = Frame

	local Dots = {}

	for i = 1, 3 do
		local Dot = Instance.new("Frame")
		Dot.Size = UDim2.fromOffset(8, 8)
		Dot.Position = UDim2.fromOffset(22 + ((i - 1) * 15), 52)
		Dot.BackgroundColor3 = Color3.fromRGB(134, 134, 2)
		Dot.BorderSizePixel = 0
		Dot.Parent = Frame

		local DotCorner = Instance.new("UICorner")
		DotCorner.CornerRadius = UDim.new(1, 0)
		DotCorner.Parent = Dot

		Dots[i] = Dot
	end

	local Data = {
		Frame = Frame
	}

	table.insert(Notifications, Data)

	UpdateStack()

	TweenService:Create(
		Frame,
		TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
		{
			Position = UDim2.new(
				1,
				-(Width + MarginRight),
				0,
				MarginTop + ((#Notifications - 1) * (Height + Spacing))
			)
		}
	):Play()

	task.spawn(function()
		local Segment = Time / 3

		for i = 1, 3 do
			task.wait(Segment)

			local Dot = Dots[i]

			TweenService:Create(
				Dot,
				TweenInfo.new(0.25),
				{
					Size = UDim2.fromOffset(0, 0),
					BackgroundTransparency = 1
				}
			):Play()
		end

		RemoveNotification(Data)
	end)
end

if game.PlaceId == 97598239454123 then
notify({
	Title = "Game Found!",
	Desc = "Loading Grow a Garden 2...",
	Time = 2,
})
loadstring(game:HttpGet("https://raw.githubusercontent.com/HiddenSpurces/Woahhzeelu/refs/heads/main/games/Backup.lua"))()
else
notify({
	Title = "Game not Supported",
	Desc = "Script game is not supported.",
	Time = 6,
})
end
