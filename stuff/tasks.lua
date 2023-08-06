local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGUI"))
local MainFrame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner")
local UIGridLayout = Instance.new("UIGridLayout")
local UICorner_2 = Instance.new("UICorner")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0, 0, 0.189873412, 0)
MainFrame.Size = UDim2.new(0, 100, 0, 405)

TextLabel.Parent = MainFrame
TextLabel.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(0, 0, 0.0444444455, 0)
TextLabel.Size = UDim2.new(0, 100, 0, 52)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "Tasks:"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true

UICorner.CornerRadius = UDim.new(0, 2)
UICorner.Parent = TextLabel

UIGridLayout.Parent = MainFrame
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout.CellPadding = UDim2.new(0, 5, 0, 10)
UIGridLayout.CellSize = UDim2.new(0, 100, 0, 30)

UICorner_2.CornerRadius = UDim.new(0, 5)
UICorner_2.Parent = MainFrame


local main = {}
local objects = {}

function main:new(text)
	local textlabel = Instance.new("TextLabel", MainFrame)
	table.insert(objects, textlabel)
	
	textlabel.TextScaled = true
	textlabel.TextColor3 = Color3.new(255,255,255)
	textlabel.BackgroundTransparency = 1
	textlabel.Text = text
end

function main:remove(index)
	objects[index]:Destroy()
end

function main:removeall()
	for i,v in pairs(objects) do
		v:Destroy()
	end
end

return main
