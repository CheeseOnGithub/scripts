local lib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local RunService = game:GetService("RunService")
local character = game:GetService("Players").LocalPlayer.Character
local window = lib:MakeWindow({Name = "goofy ahh script", HidePremium = false, SaveConfig = true, ConfigFolder = "vertigo private script lol"})
local mainTab = window:MakeTab({Name="main", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local antiFallEnabled = false
local ADEnabled
local HBEVal = 1


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

mainTab:AddButton({
    Name = "no jump cooldown",
    Callback = function(v)
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
    Name = "get eyelander",
    Callback = function()
        local oldPos = game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart.Position
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

-- main loop or some shti
while wait() do
    -- inf armour durability
    if ADEnabled then
        character["ARMOR_Torso"].ArmorBlockScript.Durability.Value = 130
    end
end
