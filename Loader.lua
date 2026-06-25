if getgenv().ngaaa then
    warn("already executed [Zilu]")
    return
end
function loading()
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local black = Instance.new("Frame")
black.Size = UDim2.fromScale(1, 1)
black.BackgroundColor3 = Color3.new(0, 0, 0)
black.BackgroundTransparency = 1
black.BorderSizePixel = 0
black.Parent = gui

local container = Instance.new("Frame")
container.AnchorPoint = Vector2.new(0.5, 0.5)
container.Position = UDim2.fromScale(0.5, 0.5)
container.BackgroundTransparency = 1
container.Parent = black

TweenService:Create(
	black,
	TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
	{BackgroundTransparency = 0.4}
):Play()

task.wait(0.5)

local text = "Zilu Hub"

local letterWidth = 48
local spacing = 0

local startColor = Color3.fromRGB(255,255,255)
local endColor = Color3.fromRGB(134,134,2)

local totalWidth = (#text * letterWidth) + ((#text - 1) * spacing)
local startX = -totalWidth / 2

for i = 1, #text do
	local char = text:sub(i, i)

	local alpha = (#text <= 1) and 0 or ((i - 1) / (#text - 1))
	local color = startColor:Lerp(endColor, alpha)

	local letter = Instance.new("TextLabel")
	letter.BackgroundTransparency = 1
	letter.Size = UDim2.fromOffset(letterWidth, 80)
	letter.AnchorPoint = Vector2.new(0.5, 0.5)
	letter.Text = char
	letter.Font = Enum.Font.GothamBold
	letter.TextScaled = true
	letter.TextColor3 = color
	letter.TextTransparency = 1
	letter.Parent = container

	local targetX = startX + (i - 0.5) * (letterWidth + spacing)

	letter.Position = UDim2.fromScale(0.5, 0.5) + UDim2.fromOffset(targetX - 30, 0)

	TweenService:Create(
		letter,
		TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
		{
			Position = UDim2.fromScale(0.5, 0.5) + UDim2.fromOffset(targetX, 0),
			TextTransparency = 0
		}
	):Play()

	task.wait(0.05)
end

task.wait(1)

local fadeBlack = TweenService:Create(
	black,
	TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
	{BackgroundTransparency = 1}
)

for _, v in ipairs(container:GetChildren()) do
	if v:IsA("TextLabel") then
		TweenService:Create(
			v,
			TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{TextTransparency = 1}
		):Play()
	end
end

fadeBlack:Play()
fadeBlack.Completed:Wait()
gui:Destroy()
end

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
loading()
wait(3)
notify({
	Title = "Game Found!",
	Desc = "Loading Grow a Garden 2...",
	Time = 2,
})
--topbar
loadstring(game:HttpGet("https://raw.githubusercontent.com/HiddenSpurces/Woahhzeelu/refs/heads/main/assets/topbar.lua"))()
--anti scam msg
loadstring(game:HttpGet("https://raw.githubusercontent.com/HiddenSpurces/Woahhzeelu/refs/heads/main/assets/warningmsg.lua"))()
---auto updater
loadstring(game:HttpGet("https://raw.githubusercontent.com/HiddenSpurces/Woahhzeelu/refs/heads/main/assets/autoupdater.lua"))()
-----
loadstring(game:HttpGet("https://raw.githubusercontent.com/HiddenSpurces/Woahhzeelu/refs/heads/main/games/Backup.lua"))()
wait(30)
loadstring(game:HttpGet("https://raw.githubusercontent.com/HiddenSpurces/Woahhzeelu/refs/heads/main/assets/discordjoiner.lua"))()

else
notify({
	Title = "Game not Supported",
	Desc = "Script game is not supported.",
	Time = 6,
})
end
