local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local PlayerService = game:GetService("Players")
local LocalPlayer = PlayerService.LocalPlayer

local NPCFolder = Workspace.Custom:FindFirstChild("-1") or Workspace.Custom:FindFirstChild("1")
local Network = loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/BRM5/Network.lua"))()
local ESPLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/BRM5/ESPLibrary.lua"))()
local ConfigSystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/BRM5/ConfigSystem.lua"))()

local function SaveConfig()
    if isfile("Alex's Scripts/BRM5_SilentAim.json") then
        writefile("Alex's Scripts/BRM5_SilentAim.json", ConfigSystem.WriteJSON(Config))
    else
        makefolder("Alex's Scripts")
        writefile("Alex's Scripts/BRM5_SilentAim.json", ConfigSystem.WriteJSON(Config))
    end
end
local function LoadConfig()
    if isfile("Alex's Scripts/BRM5_SilentAim.json") then
        getgenv().Config = ConfigSystem.ReadJSON(readfile("Alex's Scripts/BRM5_SilentAim.json"),Config)
    else
        makefolder("Alex's Scripts")
        writefile("Alex's Scripts/BRM5_SilentAim.json", ConfigSystem.WriteJSON(Config))
    end
end
local function JoinDiscordServer(Server)
    local HttpService = game:GetService("HttpService")
    local response = syn.request({
        ["Url"] = "http://localhost:6463/rpc?v=1",
        ["Method"] = "POST",
        ["Headers"] = {
            ["Content-Type"] = "application/json",
            ["Origin"] = "https://discord.com"
        },
        ["Body"] = HttpService:JSONEncode({
            ["cmd"] = "INVITE_BROWSER",
            ["nonce"] = string.lower(HttpService:GenerateGUID(false)),
            ["args"] = {
                ["code"] = tostring(Server)
            }
        })
    })
end

getgenv().Config = {
    -- Circle
    CircleVisible = true,
    CircleTransparency = 1,
    CircleColor = Color3.fromRGB(255,128,64),
    CircleThickness = 1,
    CircleNumSides = 30,
    CircleFilled = false,

    -- ESP
    AllyColor = Color3.fromRGB(0,255,0),
    EnemyColor = Color3.fromRGB(255,0,0),
    UseTeamColor = true,
    BoxVisible = true,
    HealthbarVisible = false,
    InfoVisible = false,
    OutlineVisible = true,

    -- Aimbot
    SilentAim = true,
    Aimbot = false,
    Wallcheck = false,

    -- Aimbot Settings
    Sensitivity = 0.5,
    FieldOfView = 100,
    TargetMode = "NPC",
    AimHitbox = "Head",

    -- Other
    Fullbright = false,
    NoRecoil = false,
    Speedhack = false,
    SpeedhackValue = 100,
    RapidFire = false,
    RapidFireValue = 1000,
}
LoadConfig()

local UIConfig = {
    WindowName = "Blackhawk Rescue Mission 5",
    Color = Color3.fromRGB(255,128,64),
    Keybind = Enum.KeyCode.RightShift
}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/BracketV3.lua"))()
local Window = Library:CreateWindow(UIConfig, game:GetService("CoreGui"))

local MainTab = Window:CreateTab("Main")
local OtherTab = Window:CreateTab("Other")

local AimbotSection = MainTab:CreateSection("Aimbot")
local CircleSection = MainTab:CreateSection("Circle")
local ESPSection = MainTab:CreateSection("ESP")
local OtherSection = MainTab:CreateSection("Other")
local MenuSection = OtherTab:CreateSection("Menu")
local BackgroundSection = OtherTab:CreateSection("Background")

local SilentAimToggle = AimbotSection:CreateToggle("Silent Aim", nil, function(State)
    Config.SilentAim = State
end)
SilentAimToggle:SetState(Config.SilentAim)

local AimbotToggle = AimbotSection:CreateToggle("Aimbot", nil, function(State)
    Config.Aimbot = State
end)
AimbotToggle:SetState(Config.Aimbot)

local WallcheckToggle = AimbotSection:CreateToggle("Wallcheck", nil, function(State)
    Config.Wallcheck = State
end)
WallcheckToggle:SetState(Config.Wallcheck)

local SensitivitySlider = AimbotSection:CreateSlider("Sensitivity", 0,1,nil,false, function(Value)
    Config.Sensitivity = Value
end)
SensitivitySlider:SetValue(Config.Sensitivity)

local FOVSlider = AimbotSection:CreateSlider("Field Of View", 0,1000,nil,true, function(Value)
    Config.FieldOfView = Value
end)
FOVSlider:SetValue(Config.FieldOfView)

local TargetDropdown = AimbotSection:CreateDropdown("Target", {"NPC","Player"}, function(String)
    if String == "NPC" then
        Config.TargetMode = "NPC"
    elseif String == "Player" then
        Config.TargetMode = "Player"
    end
end, Config.TargetMode)

local AimHitboxDropdown = AimbotSection:CreateDropdown("Aim Hitbox", {"Head","Torso"}, function(String)
    if String == "Head" then
        Config.AimHitbox = "Head"
    elseif String == "Torso" then
        Config.AimHitbox = "Torso"
    end
end, Config.AimHitbox)

local CircleVisibleToggle = CircleSection:CreateToggle("Enable Circle", nil, function(State)
    Config.CircleVisible = State
end)
CircleVisibleToggle:SetState(Config.CircleVisible)

local CircleTransparencySlider = CircleSection:CreateSlider("Circle Transparency", 0,1,nil,false, function(Value)
    Config.CircleTransparency = Value
end)
CircleTransparencySlider:SetValue(Config.CircleTransparency)

local CircleColorpicker = CircleSection:CreateColorpicker("Circle Color", function(Color)
    Config.CircleColor = Color
end)
CircleColorpicker:UpdateColor(Config.CircleColor)

local CircleThicknessSlider = CircleSection:CreateSlider("Circle Thickness", 1,5,nil,true, function(Value)
    Config.CircleThickness = Value
end)
CircleThicknessSlider:SetValue(Config.CircleThickness)

local CircleNumSidesSlider = CircleSection:CreateSlider("Circle NumSides", 3,100,nil,true, function(Value)
    Config.CircleNumSides = Value
end)
CircleNumSidesSlider:SetValue(Config.CircleNumSides)

local CircleFilledToggle = CircleSection:CreateToggle("Circle Filled", nil, function(State)
    Config.CircleFilled = State
end)
CircleFilledToggle:SetState(Config.CircleFilled)

local AllyColorpicker = ESPSection:CreateColorpicker("Ally Color", function(Color)
    Config.AllyColor = Color
end)
AllyColorpicker:UpdateColor(Config.AllyColor)

local EnemyColorpicker = ESPSection:CreateColorpicker("Enemy Color", function(Color)
    Config.EnemyColor = Color
end)
EnemyColorpicker:UpdateColor(Config.EnemyColor)

local UseTeamToggle = ESPSection:CreateToggle("Use Team Color", nil, function(State)
    Config.UseTeamColor = State
end)
UseTeamToggle:SetState(Config.UseTeamColor)

local BoxToggle = ESPSection:CreateToggle("Box Visible", nil, function(State)
    Config.BoxVisible = State
end)
BoxToggle:SetState(Config.BoxVisible)

local HealthbarToggle = ESPSection:CreateToggle("Healthbar Visible", nil, function(State)
    Config.HealthbarVisible = State
end)
HealthbarToggle:SetState(Config.HealthbarVisible)

local InfoToggle = ESPSection:CreateToggle("Info Visible", nil, function(State)
    Config.InfoVisible = State
end)
InfoToggle:SetState(Config.InfoVisible)

local OutlineToggle = ESPSection:CreateToggle("Outline Visible", nil, function(State)
    Config.OutlineVisible = State
end)
OutlineToggle:SetState(Config.OutlineVisible)

local FullbrightToggle = OtherSection:CreateToggle("Enable Fullbright", nil, function(State)
    Config.Fullbright = State
end)
FullbrightToggle:SetState(Config.Fullbright)

local NoRecoilToggle = OtherSection:CreateToggle("Enable No Recoil", nil, function(State)
    Config.NoRecoil = State
end)
NoRecoilToggle:SetState(Config.NoRecoil)

local SpeedhackToggle = OtherSection:CreateToggle("Enable Speedhack", nil, function(State)
    Config.Speedhack = State
end)
SpeedhackToggle:SetState(Config.Speedhack)

local SpeedhackSlider = OtherSection:CreateSlider("Speedhack Value", 0,1000,nil,true, function(Value)
    Config.SpeedhackValue = Value
end)
SpeedhackSlider:SetValue(Config.SpeedhackValue)

local RapidFireToggle = OtherSection:CreateToggle("Enable RapidFire", nil, function(State)
    Config.RapidFire = State
end)
RapidFireToggle:SetState(Config.RapidFire)

local RapidFireSlider = OtherSection:CreateSlider("RapidFire Value", 0,5000,nil,true, function(Value)
    Config.RapidFireValue = Value
end)
RapidFireSlider:SetValue(Config.RapidFireValue)


local UIToggle = MenuSection:CreateToggle("UI Toggle", nil, function(State)
    Window:Toggle(State)
end)
UIToggle:CreateKeybind(tostring(UIConfig.Keybind):gsub("Enum.KeyCode.", ""), function(Key)
    UIConfig.Keybind = Enum.KeyCode[Key]
end)
UIToggle:SetState(false)

local UIColor = MenuSection:CreateColorpicker("UI Color", function(Color)
    Window:ChangeColor(Color)
end)
UIColor:UpdateColor(UIConfig.Color)

local DiscordButton = MenuSection:CreateButton("Join Discord Server", function()
    JoinDiscordServer("JKywVqjV6m")
end)
DiscordButton:AddToolTip("Support and Changelog Server")

MenuSection:CreateButton("Unlock CBTS Achievement", function() Network:FireServer("CBTS") end)

-- credits to jan for patterns
local PatternBackground = BackgroundSection:CreateDropdown("Image", {"Default","Hearts","Abstract","Hexagon","Circles","Lace With Flowers","Floral"}, function(Name)
    if Name == "Default" then
        Window:SetBackground("2151741365")
    elseif Name == "Hearts" then
        Window:SetBackground("6073763717")
    elseif Name == "Abstract" then
        Window:SetBackground("6073743871")
    elseif Name == "Hexagon" then
        Window:SetBackground("6073628839")
    elseif Name == "Circles" then
        Window:SetBackground("6071579801")
    elseif Name == "Lace With Flowers" then
        Window:SetBackground("6071575925")
    elseif Name == "Floral" then
        Window:SetBackground("5553946656")
    end
end, "Default")

local BackgroundColorpicker = BackgroundSection:CreateColorpicker("Color", function(Color)
    Window:SetBackgroundColor(Color)
end)
BackgroundColorpicker:UpdateColor(Color3.new(1,1,1))

local BackgroundTransparencySlider = BackgroundSection:CreateSlider("Transparency",0,1,nil,false, function(Value)
    Window:SetBackgroundTransparency(Value)
end)
BackgroundTransparencySlider:SetValue(0)

local TileSizeSlider = BackgroundSection:CreateSlider("Tile Scale",0,1,nil,false, function(Value)
    Window:SetTileScale(Value)
end)
TileSizeSlider:SetValue(0.5)

local function TeamCheck(Target)
    if LocalPlayer.Team ~= Target.Team then
        return true
    else
        return false
    end
    return true
end

local function WallCheck(Part)
    if Config.Wallcheck and Part then
        local Camera = Workspace.CurrentCamera
        local CameraPosition = Camera.CFrame.Position
        local RaycastParameters = RaycastParams.new()
        RaycastParameters.FilterType = Enum.RaycastFilterType.Blacklist
        RaycastParameters.FilterDescendantsInstances = {LocalPlayer.Character,Part.Parent}
        RaycastParameters.IgnoreWater = true
        
        if Workspace:Raycast(CameraPosition, Part.Position - CameraPosition, RaycastParameters) then
            return false
        end
    end
    return true
end

function GetTarget()
    local ClosestPlayer = nil
    local FarthestDistance = math.huge
    local Camera = Workspace.CurrentCamera
    if Config.TargetMode == "NPC" then
        if NPCFolder then
            for _, NPC in pairs(NPCFolder:GetChildren()) do
                if NPC:FindFirstChildOfClass("Humanoid") and not NPC:FindFirstChildOfClass("Humanoid"):FindFirstChild("Free") and NPC:FindFirstChild(Config.AimHitbox) then
                    if NPC:FindFirstChildOfClass("Humanoid") and NPC:FindFirstChildOfClass("Humanoid").Health ~= 0 then
                        local ScreenPosition, OnScreen = Camera:WorldToViewportPoint(NPC:FindFirstChild(Config.AimHitbox).Position)
                        if OnScreen and WallCheck(NPC:FindFirstChild(Config.AimHitbox)) then
                            local MouseDistance = (Vector2.new(ScreenPosition.X, ScreenPosition.Y) - UserInputService:GetMouseLocation()).Magnitude
                            if MouseDistance < FarthestDistance and MouseDistance <= Config.FieldOfView then
                                FarthestDistance = MouseDistance
                                ClosestPlayer = NPC:FindFirstChild(Config.AimHitbox)
                            end
                        end
                    end
                end
            end
        end
    elseif Config.TargetMode == "Player" then
        for _, Player in pairs(PlayerService:GetPlayers()) do
            if Player ~= LocalPlayer and TeamCheck(Player) then
                if Player.Character and Player.Character:FindFirstChild(Config.AimHitbox) then
                    if Player.Character:FindFirstChildOfClass("Humanoid") and Player.Character:FindFirstChildOfClass("Humanoid").Health ~= 0 then
                        local ScreenPosition, OnScreen = Camera:WorldToViewportPoint(Player.Character:FindFirstChild(Config.AimHitbox).Position)
                        if OnScreen and WallCheck(Player.Character:FindFirstChild(Config.AimHitbox)) then
                            local MouseDistance = (Vector2.new(ScreenPosition.X, ScreenPosition.Y) - UserInputService:GetMouseLocation()).Magnitude
                            if MouseDistance < FarthestDistance and MouseDistance <= Config.FieldOfView then
                                FarthestDistance = MouseDistance
                                ClosestPlayer = Player.Character:FindFirstChild(Config.AimHitbox)
                            end
                        end
                    end
                end
            end
        end
    end
    return ClosestPlayer
end

local function GetNilScript(Name)
    for _,Instance in pairs(getnilinstances()) do
        if Instance.Name == Name then
            return Instance
        end 
    end
end

-- hooks
local HumanoidClass = require(GetNilScript("HumanoidClass"))
local humanoidOld = HumanoidClass.LateUpdate
HumanoidClass.LateUpdate = function(...)
    if Config.Speedhack then
        local args = {...}
        args[1]._speed = Config.SpeedhackValue
        args[1].fall = false
        args[1].Falling = false
    end
    return humanoidOld(...)
end

local CharacterCamera = require(GetNilScript("CharacterCamera"))
local cameraOld = CharacterCamera.Update
CharacterCamera.Update = function(...)
    local args = {...}
    args[1]._shake = 0
    if Config.NoRecoil then
        args[1]._recoil = 0
    end
    if Config.Speedhack then
        args[1]._bob = 0
    end
    return cameraOld(...)
end

local FirearmInventory = require(GetNilScript("FirearmInventory"))
local firearmOld = FirearmInventory.Discharge
FirearmInventory.Discharge = function(...)
    local args = {...}
    if Config.RapidFire then
        args[1]._data.stats.rpm = Config.RapidFireValue
    end
    return firearmOld(...)
end

local namecall
namecall = hookmetamethod(game, "__namecall", function(self, ...)
    local args = {...}
    local namecallmethod = getnamecallmethod()
    if namecallmethod == "FindPartOnRayWithIgnoreList" then
        local Camera = Workspace.CurrentCamera
        local CameraPosition = Camera.CFrame.Position
        if target and args[1].Origin == CameraPosition then
            args[1] = Ray.new(CameraPosition, (target.Position - CameraPosition))
        end
    end
    return namecall(self, unpack(args))
end)

-- render
local Circle = Drawing.new("Circle")
RunService.Heartbeat:Connect(function()
    Circle.Visible = Config.CircleVisible
    Circle.Transparency = Config.CircleTransparency
    Circle.Color = Config.CircleColor

    Circle.Thickness = Config.CircleThickness
    Circle.NumSides = Config.CircleNumSides
    Circle.Radius = Config.FieldOfView
    Circle.Filled = Config.CircleFilled
    Circle.Position = UserInputService:GetMouseLocation()

    if Config.Fullbright then
        Lighting.ClockTime = 12
        Lighting.Brightness = 3
    end

    if Config.SilentAim then
        target = GetTarget()
    else
        target = nil
    end

    if Config.Aimbot then
        if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
            local Target = GetTarget()
            if Target then
                local Camera = Workspace.CurrentCamera
                local Mouse = UserInputService:GetMouseLocation()
                local TargetPos = Camera:WorldToViewportPoint(Target.Position)
                mousemoverel((TargetPos.X - Mouse.X) * Config.Sensitivity, (TargetPos.Y - Mouse.Y) * Config.Sensitivity)
            end
        end
    end
end)

if NPCFolder then
    for Index, NPC in pairs(NPCFolder:GetChildren()) do
        if NPC:WaitForChild("Humanoid",0.1) and not NPC.Humanoid:FindFirstChild("Free") then
            ESPLibrary.AddNPC(NPC)
        end
    end
    NPCFolder.ChildAdded:Connect(function(NPC)
        if NPC:WaitForChild("Humanoid",0.1) and not NPC.Humanoid:FindFirstChild("Free") then
            ESPLibrary.AddNPC(NPC)
        end
    end)
    NPCFolder.ChildRemoved:Connect(function(NPC)
        ESPLibrary.RemoveNPC(NPC)
    end)
end

for Index, Player in pairs(PlayerService:GetPlayers()) do
    if Player == LocalPlayer then continue end
    ESPLibrary.AddPlayer(Player)
end
PlayerService.PlayerAdded:Connect(function(Player)
    ESPLibrary.AddPlayer(Player)
end)
PlayerService.PlayerRemoving:Connect(function(Player)
    if Player == LocalPlayer then SaveConfig() end
    ESPLibrary.RemovePlayer(Player)
end)
