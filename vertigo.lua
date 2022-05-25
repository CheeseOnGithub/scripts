local lib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local RunService = game:GetService("RunService")
local character = game:GetService("Players").LocalPlayer.Character
local player = game:GetService("Players").LocalPlayer
local window = lib:MakeWindow({Name = "goofy ahh script", HidePremium = false, SaveConfig = true, ConfigFolder = "vertigo private script lol"})
local mainTab = window:MakeTab({Name="main", Icon = "rbxassetid://7072721039", PremiumOnly = false})
local weaponsTab = window:MakeTab({Name="weapons", Icon = "rbxassetid://7072723685", PremiumOnly = false})
local playerTab = window:MakeTab({Name="player", Icon="rbxassetid://7072724538", PremiumOnly = false})
local walkspeed = 16
local jumppower = 50
local antiFallEnabled
local ADEnabled
local antifireEnabled


mainTab:AddToggle({
	Name = "anti fall damage",
	Default = false,
	Callback = function(v)
		antiFallEnabled = v
	end
})

mainTab:AddToggle({
	Name = "infinite armour durability",
	Default = false,
	Callback = function(v)
		ADEnabled = v
	end
})

mainTab:AddToggle({
	Name = "auto extinguish player",
	Default = false,
	Callback = function(v)
		antifireEnabled = v
	end
})

mainTab:AddButton({
    Name = "no jump cooldown",
    Callback = function()
        -- how is this working this shit took me 30 minutes
        -- i think i am retarded
        for i,v in pairs(getgc()) do
            if type(v) == "function" and getfenv(v).script == character.JumpDelay then
                if table.find(getconstants(v), 0.5) then
                    setconstant(v, 3, 0)
                end
            end
        end
    end
})

mainTab:AddButton({
    Name = "explode self (i was bored and made this)",
    Callback = function()
        for i,v in pairs(character:GetDescendants()) do
            if tostring(v) == "ExplodePlayer" then
                v:FireServer()
            end
        end
    end
})

weaponsTab:AddButton({
    Name = "get eyelander",
    Callback = function()
        if game:GetService("Workspace").EyelanderStand.FakeWeapon.Transparency == 0 then
            antiFallEnabled = true
            tweenService, tweenInfo = game:GetService("TweenService"), TweenInfo.new(0.5, Enum.EasingStyle.Linear)
            tweenService:Create(game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart, tweenInfo, {CFrame = CFrame.new(1.0669541358947754, 70.7398681640625, 281.60247802734375)}):Play()
            antiFallEnabled = false
        else
            lib:MakeNotification({
                Name = "weapon hasnt spawned in yet",
                Content = "wait a sec lol",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        end
    end
})

weaponsTab:AddButton({
    Name = "get katana",
    Callback = function()
        if game:GetService("Workspace").KatanaStand.FakeWeapon.Transparency == 0 then
            antiFallEnabled = true
            tweenService, tweenInfo = game:GetService("TweenService"), TweenInfo.new(0.5, Enum.EasingStyle.Linear)
            tweenService:Create(game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart, tweenInfo, {CFrame = CFrame.new(146.04632568359375, 98.87576293945312, -104.07154846191406)}):Play()
            antiFallEnabled = false
        else
            lib:MakeNotification({
                Name = "weapon hasnt spawned in yet",
                Content = "wait a sec lol",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        end
    end
})

weaponsTab:AddButton({
    Name = "get shield",
    Callback = function()
        if game:GetService("Workspace").ShieldStand.FakeWeapon.Transparency == 0 then
            antiFallEnabled = true
            tweenService, tweenInfo = game:GetService("TweenService"), TweenInfo.new(0.5, Enum.EasingStyle.Linear)
            tweenService:Create(game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart, tweenInfo, {CFrame = CFrame.new(-213.41326904296875, 65.80203247070312, 25.38184356689453)}):Play()
            
            antiFallEnabled = false
        else
            lib:MakeNotification({
                Name = "weapon hasnt spawned in yet",
                Content = "wait a sec lol",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        end
    end
})

weaponsTab:AddButton({
    Name = "get energy sword",
    Callback = function()
        if game:GetService("Workspace").ShieldStand.FakeWeapon.Transparency == 0 then
            antiFallEnabled = true
            tweenService, tweenInfo = game:GetService("TweenService"), TweenInfo.new(0.5, Enum.EasingStyle.Linear)
            tweenService:Create(game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart, tweenInfo, {CFrame = CFrame.new(419.536926, 77.6752167, 170.104935)}):Play()
            
            antiFallEnabled = false
        else
            lib:MakeNotification({
                Name = "weapon hasnt spawned in yet",
                Content = "wait a sec lol",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        end
    end
})

playerTab:AddSlider({
	Name = "jumppower",
	Min = 50,
	Max = 200,
	Default = 50,
	Color = Color3.fromRGB(100, 17, 196),
	Increment = 1,
	ValueName = "vroom",
	Callback = function(v)
        character:WaitForChild("Humanoid").JumpPower = v
        jumppower = v
	end    
})

playerTab:AddSlider({
	Name = "walkspeed",
	Min = 16,
	Max = 100,
	Default = 16,
	Color = Color3.fromRGB(100, 17, 196),
	Increment = 1,
	ValueName = "vroom",
	Callback = function(v)
        character:WaitForChild("Humanoid").WalkSpeed = v
        walkspeed = v
	end    
})


-- remote hook
local oldnamecall = nil
oldnamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local args = {...}
    local method = getnamecallmethod()

    if antiFallEnabled then
        if method == "FireServer" and tostring(self) == "HURT" then
            return 0
        end
    end
    
    return oldnamecall(self, ...)
end)


RunService.Heartbeat:Connect(function()
    if ADEnabled and character:FindFirstChild("ARMOR_Torso") ~= nil then
        character["ARMOR_Torso"].ArmorBlockScript.Durability.Value = 125
    end

    if antifireEnabled then
        for i,v in pairs(character:GetDescendants()) do
            if tostring(v) == "ExtinguishPlayer" then
                v:FireServer()
            end
        end
    end

    wait(0.1)
end)


player.CharacterAdded:Connect(function(char)
    char:WaitForChild("Humanoid").WalkSpeed = walkspeed
    char:WaitForChild("Humanoid").JumpPower = jumppower
end)

lib:Init()