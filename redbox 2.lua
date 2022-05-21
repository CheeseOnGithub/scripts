repeat wait() until game:IsLoaded()

local players = game:GetService("Players")
local ESP = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()
local ValidTargetParts = {"Head", "Torso"}
local Cam = workspace.CurrentCamera
local WorldToScreen = Cam.WorldToScreenPoint
local WorldToViewportPoint = Cam.WorldToViewportPoint
local GetPartsObscuringTarget = Cam.GetPartsObscuringTarget
local Mouse = players.LocalPlayer:GetMouse()
local silentAimEnabled = false
local fovEnabled = false
local arrestAuraEnabled = false
local antiArrestEnabled = false
local walkspeedValue = 16
local jumppowerValue = 50
ESP.Boxes = true
local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
local fovcircle = Drawing.new("Circle")

fovcircle.Thickness = 1
fovcircle.Filled = false
fovcircle.Color = Color3.new(0.462745, 0, 0.772549)
fovcircle.Radius = 150

game:GetService("ReplicatedStorage").Assets.Modules:WaitForChild("AntiExploitModule"):Destroy()


local RequiredArgs = {
    ArgCountRequired = 3,
    Args = {
    "Instance", "Vector3", "Vector3", "RaycastParams"
    }
}


local function GetPositionOnScreen(Vector)
    local Vec3, OnScreen = WorldToScreen(Cam, Vector)
    return Vector2.new(Vec3.X, Vec3.Y), OnScreen
end

local function ValidateArguments(Args, RayMethod)
    local Matches = 0

    if #Args < RayMethod.ArgCountRequired then
        return false
    end

    for Pos, Argument in next, Args do
        if typeof(Argument) == RayMethod.Args[Pos] then
            Matches = Matches + 1
        end
    end

    return Matches >= RayMethod.ArgCountRequired
end

local function GetDirection(Origin, Position)
    return (Position - Origin).Unit * 1000
end

local function GetMousePosition()
    return Vector2.new(Mouse.X, Mouse.Y)
end

local function GetClosestPlayer()
    local Closest
    local DistanceToMouse

    for _, v in next, game.GetChildren(players) do
        if v == players.LocalPlayer then continue end

        local Character = v.Character
        if not Character then continue end
        

        local HumanoidRootPart = game.FindFirstChild(Character, "HumanoidRootPart")
        local Humanoid = game.FindFirstChild(Character, "Humanoid")

        if not HumanoidRootPart or not Humanoid or Humanoid and Humanoid.Health <= 0 then continue end

        local ScreenPosition, OnScreen = GetPositionOnScreen(HumanoidRootPart.Position)

        if not OnScreen then continue end

        local Distance = (GetMousePosition() - ScreenPosition).Magnitude
        if Distance <= (DistanceToMouse or (fovEnabled and fovcircle.Radius) or 150) then
            Closest = (Character[ValidTargetParts[math.random(1, #ValidTargetParts)]] or Character["Head"])
            DistanceToMouse = Distance
        end
    end
    return Closest
end

-- i am lazy
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(...)
    local Method = getnamecallmethod()
    local args = {...}
    local self = args[1]

    if silentAimEnabled and self == workspace and not checkcaller() then
        if ValidateArguments(args, RequiredArgs) then
            local origin = args[2]
            local hit = GetClosestPlayer()

            if hit then
                args[3] = GetDirection(origin, hit.Position)

                return oldNamecall(unpack(args))
            end
        end
    end

    return oldNamecall(...)
end)

game:GetService("RunService").RenderStepped:Connect(function()
    fovcircle.Position = GetMousePosition() + Vector2.new(0, 38)

    if arrestAuraEnabled then
        for _,v in pairs(game:GetService("Players"):GetPlayers()) do
            if v ~= players.LocalPlayer and v.Character ~= nil and v.Character.Humanoid.Health > 0 and (v.Character.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30 then
                if v.Character:WaitForChild("Arrested").Value == false then	
                    game:GetService("ReplicatedStorage").Assets.Remotes.cuffsArrest:FireServer(v.Character)
                    wait(0.1)
                end
            end
        end
        wait()
    end

    players.LocalPlayer.Character.Humanoid.WalkSpeed = walkspeedValue
    players.LocalPlayer.Character.Humanoid.JumpPower = jumppowerValue
end)

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/matas3535/PoopLibrary/main/Library.lua"))()
local window = library:New({Name = "redbox 2 script", Accent = Color3.fromRGB(141, 8, 250)})
local main = window:Page({Name="main"})
local mainLeft = main:Section({Name = "da good stuff", Side = "Left"})
local playerTab = window:Page({Name="player"})
local playerMain = playerTab:Section({Name="character", Side="Left"})
local visuals = window:Page({Name="visuals"})
local visualsMain = visuals:Section({Name="visuals", Side="Left"})
local settings = window:Page({Name="settings"})
local settingsMain = settings:Section({Name="settings",Side="Left"})

visualsMain:Toggle({Name = "Enabled", Default = false, Callback = function(v)
    ESP:Toggle(v)
end})

mainLeft:Button({Name = "get all guns", Callback = function()
    -- SHIT CODE BELOW DONT LOOK

    local args = {
        [1] = game:GetService("Players").LocalPlayer.Character,
        [2] = game:GetService("ReplicatedStorage").Assets.Loadout.Secondary:FindFirstChild("Beretta M9")
    }
    
    game:GetService("ReplicatedStorage").AddTool:FireServer(unpack(args))
    
    
    local args = {
        [1] = game:GetService("Players").LocalPlayer.Character,
        [2] = game:GetService("ReplicatedStorage").Assets.Loadout.Primary["Pump Shotgun"]
    }
    
    game:GetService("ReplicatedStorage").AddTool:FireServer(unpack(args))
    
    local args = {
        [1] = game:GetService("Players").LocalPlayer.Character,
        [2] = game:GetService("ReplicatedStorage").Assets.Loadout.Primary.M4A1
    }
    
    game:GetService("ReplicatedStorage").AddTool:FireServer(unpack(args))
    
    local args = {
        [1] = game:GetService("Players").LocalPlayer.Character,
        [2] = game:GetService("ReplicatedStorage").Assets.Loadout.Primary["Remington 700"]
    }
    
    game:GetService("ReplicatedStorage").AddTool:FireServer(unpack(args))
    
    local args = {
        [1] = game:GetService("Players").LocalPlayer.Character,
        [2] = game:GetService("ReplicatedStorage").Assets.Loadout.Primary["Riot Shield"]
    }
    
    game:GetService("ReplicatedStorage").AddTool:FireServer(unpack(args))
    
    local args = {
        [1] = game:GetService("Players").LocalPlayer.Character,
        [2] = game:GetService("ReplicatedStorage").Assets.Loadout.Misc.Cuffs
    }
    
    
    game:GetService("ReplicatedStorage").AddTool:FireServer(unpack(args))
    
    local args = {
        [1] = game:GetService("Players").LocalPlayer.Character,
        [2] = game:GetService("ReplicatedStorage").Assets.Loadout.Misc["Incendiary Grenade"]
    }
    
    game:GetService("ReplicatedStorage").AddTool:FireServer(unpack(args))
    
    local args = {
        [1] = game:GetService("Players").LocalPlayer.Character,
        [2] = game:GetService("ReplicatedStorage").Assets.Loadout.Misc["Frag Grenade"]
    }
    
    
    
    game:GetService("ReplicatedStorage").AddTool:FireServer(unpack(args))
    
    local args = {
        [1] = game:GetService("Players").LocalPlayer.Character,
        [2] = game:GetService("ReplicatedStorage").Assets.Loadout.Primary.M4A1
    }
    
    game:GetService("ReplicatedStorage").AddTool:FireServer(unpack(args))
    
    
    local args = {
        [1] = game:GetService("Players").LocalPlayer.Character,
        [2] = game:GetService("ReplicatedStorage").Assets.Loadout.Primary.AK47
    }
    
    game:GetService("ReplicatedStorage").AddTool:FireServer(unpack(args))
end})

mainLeft:Toggle({Name="arrest aura", Default=false, Callback = function(v)
    arrestAuraEnabled = v
end})

mainLeft:Toggle({Name="silent aim", Default=false, Callback=function(v)
    silentAimEnabled = v
end})

mainLeft:Label({Name = "silent aim fov", Middle = true})

mainLeft:Toggle({Name="fov circle", Default=false, Callback=function(v)
    fovcircle.Visible = v
    fovEnabled = v
end})

mainLeft:Slider({Name="fov radius", Minimum = 100, Maximum = 500, Default=150, Callback=function(v)
    fovcircle.Radius = v
end})

playerMain:Slider({Name="walkspeed", Minimum = 16, Maximum = 500, Default=16, Callback=function(v)
    players.LocalPlayer.Character.Humanoid.WalkSpeed = v
    walkspeedValue = v
end})

playerMain:Slider({Name="jumppower", Minimum = 50, Maximum = 500, Default=50, Callback=function(v)
    players.LocalPlayer.Character.Humanoid.JumpPower = v
    jumppowerValue = v
end})

for i,v in getgc(true) do
    if typeof(v) == "table" then
        rconsoleprint(v)
    end
end



window:Initialize()