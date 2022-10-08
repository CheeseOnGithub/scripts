local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/Singularity5490/rbimgui-2/main/rbimgui-2.lua"))()
local window = ui.new({text="booga booga :flushed:"})
local mainTab = window.new({text="main"})
local combatTab = window.new({text="combat"})
local killauraToggle = combatTab.new("Switch", {text="kill aura"})
local autohealToggle = combatTab.new("Switch", {text="auto heal"})
local autohealSlider = combatTab.new("Slider", {text="auto heal health", min=1, max=99, value=30})
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

while wait() do
    local suc, err = pcall(function()
        local Character = Players.LocalPlayer.Character or Players.LocalPlayer.CharacterAdded:Wait()
        if killauraToggle.on then
            local closest = getClosest()
            local hrp = Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position
    
            -- guessing the distance tbh
            if (hrp - closest.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                ReplicatedStorage.Events.SwingTool:FireServer(ReplicatedStorage.RelativeTime.Value, {
                    [1] = closest.Character.HumanoidRootPart
                })
            end
        end

        if autohealToggle.on then
            if Character:WaitForChild("Humanoid").Health <= autohealSlider.value then
                game:GetService("ReplicatedStorage").Events.UseBagltem:FireServer("Bloodfruit")
            end
        end
    end)

    if err then
        print(err)
    end
end
