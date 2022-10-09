local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/Singularity5490/rbimgui-2/main/rbimgui-2.lua"))()
local window = ui.new({text="booga booga :flushed:"})
local mainTab = window.new({text="main"})
local combatTab = window.new({text="combat"})
local autofarmTab = window.new({text="autofarm"})
local killauraToggle = combatTab.new("Switch", {text="kill aura"})
local autohealToggle = combatTab.new("Switch", {text="auto heal"})
local autohealSlider = combatTab.new("Slider", {text="auto heal health", min=1, max=99, value=30})
local breakauraToggle = mainTab.new("Switch", {text="mine aura"})
local pickupToggle = mainTab.new("Switch", {text="auto pickup"})
local autofarmToggle = autofarmTab.new("Switch", {text="everything autofarm"})
local mouse = Players.LocalPlayer:GetMouse()

-- took this from devforums
local function getClosest()
    local hrp = Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position
    local closest_distance = math.huge
    local closestperson

    for i,v in pairs(game.Players:GetPlayers()) do
        if v.Character ~= nil and v ~= Players.LocalPlayer and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v.Character:FindFirstChild("Humanoid").Health > 0 then
            local plr_pos = v.Character.HumanoidRootPart.Position
            local plr_distance = (hrp - plr_pos).Magnitude
    
            if plr_distance < closest_distance then
                closest_distance = plr_distance
                closestperson = v
            end
        end
    end

    return closestperson
end

local function getClosestObject(folder)
    local distance, part = math.huge, nil
    local mainPart
    local Character = Players.LocalPlayer.Character
    for i,v in pairs(folder:GetChildren()) do
        if Character:FindFirstChild("HumanoidRootPart") then
            local HRPPosition = Character:FindFirstChild("HumanoidRootPart").Position

            for i2,v2 in pairs(v:GetChildren()) do
                if v2:IsA("BasePart") then
                    mainPart = v2
                    break
                end
            end
    
            if mainPart and not mainPart.Parent:FindFirstChild("Humanoid") and mainPart.Parent:FindFirstChild("Health") then
                local realDistance = math.abs((HRPPosition - mainPart.Position).Magnitude)
    
                if realDistance < distance then
                    distance = realDistance
                    part = mainPart
                end
            end
        end
    end
    return part
end

local function getClosestPickups(folder)
    local Character = Players.LocalPlayer.Character
    local pickups = {}
    for i,v in pairs(folder:GetChildren()) do
        if v:FindFirstChild("Pickup") and v:IsA("BasePart") and table.find(pickups,v) == nil and Character:FindFirstChild("HumanoidRootPart") then
            if (Character.HumanoidRootPart.Position - v.Position).Magnitude <= 30 then
                table.insert(pickups, v)
            end
        end
    end
    return pickups
end

while wait(0.1) do
    local Character = Players.LocalPlayer.Character
    if killauraToggle.on then
        local closest = getClosest()
        local hrp = Character:FindFirstChild("HumanoidRootPart").Position

        -- guessing the distance tbh
        if (hrp - closest.Character.HumanoidRootPart.Position).Magnitude <= 10 then
            ReplicatedStorage.Events.SwingTool:FireServer(ReplicatedStorage.RelativeTime.Value, {
                [1] = closest.Character.HumanoidRootPart
            })
        end
    end

    if autohealToggle.on then
        if Character:FindFirstChild("Humanoid").Health <= autohealSlider.value then
            game:GetService("ReplicatedStorage").Events.UseBagltem:FireServer("Bloodfruit")
        end
    end

    if breakauraToggle.on then
        if Character:FindFirstChild("HumanoidRootPart") then
            local closestPart = getClosestObject(workspace)
            local hrp = Character:FindFirstChild("HumanoidRootPart").Position
            
            if (hrp - closestPart.Position).Magnitude <= 40 then
                ReplicatedStorage.Events.SwingTool:FireServer(ReplicatedStorage.RelativeTime.Value, {
                    [1] = closestPart
                })
            end
        end
    end

    if pickupToggle.on then
        for i,v in pairs(getClosestPickups(workspace)) do
            game:GetService("ReplicatedStorage").Events.Pickup:FireServer(v)
        end
    end
    if autofarmToggle.on then
        local part = getClosestObject(workspace)
        local HRPPosition = Players.LocalPlayer.Character.HumanoidRootPart.Position
        local realDistance = math.round(math.abs((HRPPosition - part.Position).Magnitude))
    
        ReplicatedStorage.Events.SwingTool:FireServer(ReplicatedStorage.RelativeTime.Value, {
            [1] = part
        })
        for i,v in pairs(getClosestPickups(workspace)) do
            game:GetService("ReplicatedStorage").Events.Pickup:FireServer(v)
        end
        wait(0.1)
        if part.Position.Y <= 30 then
            TweenService:Create(Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(realDistance/10, Enum.EasingStyle.Linear), {CFrame=part.CFrame+Vector3.new(0,part.Size.Y,0)}):Play()
            task.wait(realDistance/10)
        end
    end
end
