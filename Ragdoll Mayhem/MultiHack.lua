local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local PlayerService = game:GetService("Players")
local LocalPlayer = PlayerService.LocalPlayer

if not Workspace:FindFirstChild("Drops") or not Workspace:FindFirstChild("Projectiles") then
    warn("cant find required folders")
    return
end

if not getgenv().Config then
getgenv().Config = {

    -- FoV Circle
    CircleVisible = true,
    CircleTransparency = 1,
    CircleColor = Color3.fromRGB(255,128,64),
    CircleThickness = 1,
    CircleNumSides = 30,
    CircleFilled = false,
    CircleRainbow = false,

    -- ESP
    OutlineVisible = true,
    TextVisible = true,
    HealthbarVisible = false,
    BoxVisible = true,
    Color = Color3.fromRGB(255,128,64),
    Rainbow = false,

    -- Aimbot and Silent Aim
    SilentAim = false,
    Aimbot = true,
    Sensitivity = 0.1,
    FieldOfView = 100,
    AimHitbox = "Head"
}
end

local UIConfig = {
    WindowName = "RAGDOLL UNIVERSE",
    Color = Color3.fromRGB(255,128,64),
    Keybind = Enum.KeyCode.RightShift
}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/BracketV3.lua"))()
local Window = Library:CreateWindow(UIConfig, game:GetService("CoreGui"))

local Tab1 = Window:CreateTab("Main")
local Tab2 = Window:CreateTab("UI Settings")

local Section1 = Tab1:CreateSection("Aimbot")
local Section2 = Tab1:CreateSection("FOV Circle")
local Section3 = Tab1:CreateSection("ESP")

local Section4 = Tab2:CreateSection("Menu")
local Section5 = Tab2:CreateSection("Background")

local SilentAimToggle = Section1:CreateToggle("Silent Aim", nil, function(State)
    Config.SilentAim = State
end)
SilentAimToggle:SetState(Config.SilentAim)

local AimbotToggle = Section1:CreateToggle("Aimbot", nil, function(State)
    Config.Aimbot = State
end)
AimbotToggle:SetState(Config.Aimbot)

local SensitivitySlider = Section1:CreateSlider("Aimbot Sensitivity", 0,1,nil,false, function(Value)
    Config.Sensitivity = Value
end)
SensitivitySlider:SetValue(Config.Sensitivity)

local FOVSlider = Section1:CreateSlider("Field Of View", 0,500,nil,true, function(Value)
    Config.FieldOfView = Value
end)
FOVSlider:SetValue(Config.FieldOfView)

local AimHitboxDropdown = Section1:CreateDropdown("Aim Hitbox", {"Head","Torso"}, function(String)
    if String == "Head" then
        Config.AimHitbox = "Head"
    elseif String == "Torso" then
        Config.AimHitbox = "Torso"
    end
end, Config.AimHitbox)

local CircleToggle = Section2:CreateToggle("Circle Enabled", nil, function(State)
    Config.CircleVisible = State
end)
CircleToggle:SetState(Config.CircleVisible)

local CircleTranspSlider = Section2:CreateSlider("Circle Transparency", 0,1,nil,false, function(Value)
    Config.CircleTransparency = Value
end)
CircleTranspSlider:SetValue(Config.CircleTransparency)

local CircleColorpicker = Section2:CreateColorpicker("Circle Color", function(Color)
    Config.CircleColor = Color
end)
CircleColorpicker:UpdateColor(Config.CircleColor)

local CircleThicknessSlider = Section2:CreateSlider("Circle Thickness", 1,5,nil,true, function(Value)
    Config.CircleThickness = Value
end)
CircleThicknessSlider:SetValue(Config.CircleThickness)

local CircleSidesSlider = Section2:CreateSlider("Circle NumSides", 0,100,nil,true, function(Value)
    Config.CircleNumSides = Value
end)
CircleSidesSlider:SetValue(Config.CircleNumSides)

local CircleFilledToggle = Section2:CreateToggle("Circle Filled", nil, function(State)
    Config.CircleFilled = State
end)
CircleFilledToggle:SetState(Config.CircleFilled)

local CircleRainbowToggle = Section2:CreateToggle("Circle Rainbow", nil, function(State)
    Config.CircleRainbow = State
end)
CircleRainbowToggle:SetState(Config.CircleRainbow)

local ESPBoxToggle = Section3:CreateToggle("Box Visible", nil, function(State)
    Config.BoxVisible = State
end)
ESPBoxToggle:SetState(Config.BoxVisible)

local ESPTextToggle = Section3:CreateToggle("Text Visible", nil, function(State)
    Config.TextVisible = State
end)
ESPTextToggle:SetState(Config.TextVisible)

local ESPHealthToggle = Section3:CreateToggle("Healthbar Visible", nil, function(State)
    Config.HealthbarVisible = State
end)
ESPHealthToggle:SetState(Config.HealthbarVisible)

local ESPOutlineToggle = Section3:CreateToggle("ESP Outline", nil, function(State)
    Config.OutlineVisible = State
end)
ESPOutlineToggle:SetState(Config.OutlineVisible)

local ESPColorpicker = Section3:CreateColorpicker("ESP Color", function(Color)
    Config.Color = Color
end)
ESPColorpicker:UpdateColor(Config.Color)

local ESPRainbowToggle = Section3:CreateToggle("ESP Rainbow", nil, function(State)
    Config.Rainbow = State
end)
ESPRainbowToggle:SetState(Config.Rainbow)

local Toggle3 = Section4:CreateToggle("UI Toggle", true, function(State)
    Window:Toggle(State)
end)
Toggle3:CreateKeybind(tostring(UIConfig.Keybind):gsub("Enum.KeyCode.", ""), function(Key)
    UIConfig.Keybind = Enum.KeyCode[Key]
end)

local Colorpicker3 = Section4:CreateColorpicker("UI Color", function(Color)
    Window:ChangeColor(Color)
end)
Colorpicker3:UpdateColor(UIConfig.Color)

Section4:CreateButton("Server Hop", function()
    -- credits to infinite yield for serverhop
    local x = {}
    for _, v in ipairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
        if type(v) == "table" and v.id ~= game.JobId then
            x[#x + 1] = v.id
        end
    end
    if #x > 0 then
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, x[math.random(1, #x)])
    else
        return warn("Serverhop: Couldn't find a server.")
    end
end)

-- credits to jan for patterns
local Dropdown3 = Section5:CreateDropdown("Image", {"Default","Hearts","Abstract","Hexagon","Circles","Lace With Flowers","Floral"}, function(Name)
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

local Colorpicker4 = Section5:CreateColorpicker("Color", function(Color)
    Window:SetBackgroundColor(Color)
end)
Colorpicker4:UpdateColor(Color3.new(1,1,1))

local Slider3 = Section5:CreateSlider("Transparency",0,1,0,false, function(Value)
    Window:SetBackgroundTransparency(Value)
end)

local Slider4 = Section5:CreateSlider("Tile Scale",0,1,0.5,false, function(Value)
    Window:SetTileScale(Value)
end)

local function GetCorners(Model)
    local CFrame, Size = Model:GetBoundingBox()
    local CornerTable = {
        Vector3.new(CFrame.X + Size.X / 2, CFrame.Y + Size.Y / 2, CFrame.Z), -- TopRight
        Vector3.new(CFrame.X - Size.X / 2, CFrame.Y + Size.Y / 2, CFrame.Z), -- TopLeft

        Vector3.new(CFrame.X - Size.X / 2, CFrame.Y - Size.Y / 2, CFrame.Z), -- BottomLeft
        Vector3.new(CFrame.X + Size.X / 2, CFrame.Y - Size.Y / 2, CFrame.Z), -- BottomRight
    }

    local xMin = Camera.ViewportSize.X
    local yMin = Camera.ViewportSize.Y
    local xMax = 0
    local yMax = 0
                            
    for _, Corner in next, CornerTable do
        local Position = Camera:WorldToViewportPoint(Corner)

        if Position.X > xMax then
            xMax = Position.X
        end

        if Position.X < xMin then
            xMin = Position.X
        end

        if Position.Y > yMax then
            yMax = Position.Y
        end

        if Position.Y < yMin then
            yMin = Position.Y
        end
    end

    return xMax - xMin,yMax - yMin,xMin,yMin,xMax,yMax
end

local function CreateESP(Model)
    local Text = Drawing.new("Text")
    local HealthbarOutline = Drawing.new("Square")
    local Healthbar = Drawing.new("Square")
    local BoxOutline = Drawing.new("Square")
    local Box = Drawing.new("Square")

    local Render = RunService.RenderStepped:Connect(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Torso") then
            if Model and Model:FindFirstChild("Torso") then
                if Model:FindFirstChildOfClass("Humanoid") and Model:FindFirstChildOfClass("Humanoid").Health ~= 0 then
                    Camera = Workspace.CurrentCamera
                    local Vector, OnScreen = Camera:WorldToViewportPoint(Model.Torso.Position)
                    if OnScreen then
                        local xSize,ySize,xMin,yMin,xMax,yMax = GetCorners(Model)

                        Text.Visible = Config.TextVisible
                        Text.Transparency = 1
                        Text.Color = Color3.fromRGB(255,255,255)
                        Text.Text = Model.Name .. "\n" .. math.round((LocalPlayer.Character.Torso.Position - Model.Torso.Position).Magnitude) .. " studs"
                        Text.Size = 20
                        Text.Center = true
                        Text.Outline = Config.OutlineVisible
                        Text.OutlineColor = Color3.fromRGB(0,0,0)
                        Text.Position = Vector2.new(xMax - xSize/2, yMax)

                        HealthbarOutline.Visible = Config.HealthbarVisible and Config.OutlineVisible
                        HealthbarOutline.Transparency = 1
                        HealthbarOutline.Color = Color3.fromRGB(0,0,0)
                        HealthbarOutline.Thickness = 1
                        HealthbarOutline.Filled = true

                        HealthbarOutline.Size = Vector2.new(4,-ySize-2)
                        HealthbarOutline.Position = Vector2.new(xMin-8,yMax+1)

                        Healthbar.Visible = Config.HealthbarVisible
                        Healthbar.Transparency = 1
                        Healthbar.Color = Color3.fromRGB(255,0,0):Lerp(Color3.fromRGB(0,255,0), Model.Humanoid.Health/Model.Humanoid.MaxHealth)
                        Healthbar.Thickness = 1
                        Healthbar.Filled = true

                        Healthbar.Size = Vector2.new(2,0):Lerp(Vector2.new(2,-ySize),Model.Humanoid.Health/Model.Humanoid.MaxHealth)
                        Healthbar.Position = Vector2.new(xMin-7,yMax)

                        BoxOutline.Visible = Config.BoxVisible and Config.OutlineVisible
                        BoxOutline.Transparency = 1
                        BoxOutline.Color = Color3.fromRGB(0,0,0)
                        BoxOutline.Thickness = 3
                        BoxOutline.Filled = false

                        BoxOutline.Size = Vector2.new(xSize,ySize)
                        BoxOutline.Position = Vector2.new(xMin,yMin)

                        Box.Visible = Config.BoxVisible
                        Box.Transparency = 1
                        Box.Color = Config.Color
                        Box.Thickness = 1
                        Box.Filled = false

                        Box.Size = Vector2.new(xSize, ySize)
                        Box.Position = Vector2.new(xMin, yMin)
                    else
                        Text.Visible = false
                        HealthbarOutline.Visible = false
                        Healthbar.Visible = false
                        BoxOutline.Visible = false
                        Box.Visible = false
                    end
                else
                    Text.Visible = false
                    HealthbarOutline.Visible = false
                    Healthbar.Visible = false
                    BoxOutline.Visible = false
                    Box.Visible = false
                end
            else
                Text.Visible = false
                HealthbarOutline.Visible = false
                Healthbar.Visible = false
                BoxOutline.Visible = false
                Box.Visible = false
            end
        else
            Text.Visible = false
            HealthbarOutline.Visible = false
            Healthbar.Visible = false
            BoxOutline.Visible = false
            Box.Visible = false
        end
    end)

    Model.AncestryChanged:Connect(function(Child, Parent)
        if not Parent then
            Render:Disconnect()
            Text:Remove()
            HealthbarOutline:Remove()
            Healthbar:Remove()
            BoxOutline:Remove()
            Box:Remove()
        end
    end)
end

local function TeamCheck(Player)
    if Player.Character and Player.Character:FindFirstChild("Team") then
        if Player.Character.Team.Value ~= LocalPlayer.Character.Team.Value or Player.Character.Team.Value == "None" then
            return true
        else
            return false
        end
    end
    return true
end

local function GetTarget()
    local ClosestPlayer = nil
    local FarthestDistance = math.huge
    local Camera = Workspace.CurrentCamera
    for _, Player in pairs(PlayerService:GetPlayers()) do
        if Player ~= LocalPlayer and Player.Character and Player.Character:FindFirstChild(Config.AimHitbox) and TeamCheck(Player) then
            if Player.Character:FindFirstChildOfClass("Humanoid") and Player.Character:FindFirstChildOfClass("Humanoid").Health ~= 0 then
                local ScreenPosition, OnScreen = Camera:WorldToViewportPoint(Player.Character:FindFirstChild(Config.AimHitbox).Position)
                if OnScreen then
                    local MouseDistance = (Vector2.new(ScreenPosition.X, ScreenPosition.Y) - UserInputService:GetMouseLocation()).Magnitude
                    if MouseDistance < FarthestDistance and MouseDistance <= Config.FieldOfView then
                        FarthestDistance = MouseDistance
                        ClosestPlayer = Player.Character:FindFirstChild(Config.AimHitbox)
                    end
                end
            end
        end
    end
    return ClosestPlayer
end

local function GetTargetDummyDebug()
    local Camera = Workspace.CurrentCamera
    for _, Player in pairs(Workspace.LiveDuders:GetChildren()) do
        if Player.Name ~= LocalPlayer.Name and Player:FindFirstChild(Config.AimHitbox) then
            if Player:FindFirstChildOfClass("Humanoid") and Player:FindFirstChildOfClass("Humanoid").Health ~= 0 then
                local Vector, OnScreen = Camera:WorldToViewportPoint(Player:FindFirstChild(Config.AimHitbox).Position)
                if OnScreen then
                    local VectorMagnitude = (Vector2.new(Vector.X, Vector.Y) - UserInputService:GetMouseLocation()).Magnitude
                    if VectorMagnitude <= Config.FieldOfView then
                        return Player:FindFirstChild(Config.AimHitbox)
                    end
                end
            end
        end
    end
end

local function returnHit(hit, args)
    local Camera = Workspace.CurrentCamera
    local CameraPosition = Camera.CFrame.Position
    if table.find(args[2],LocalPlayer,1) and table.find(args[2],Workspace.Drops,4) and table.find(args[2],Workspace.Projectiles,5) then
        args[1] = Ray.new(CameraPosition, hit.Position - CameraPosition)
        return
    end
end

namecall = hookmetamethod(game, "__namecall", function(self, ...)
    local namecallmethod = getnamecallmethod()
    local args = {...}
    if namecallmethod == "FindPartOnRayWithIgnoreList" then
        if hit then
            returnHit(hit, args)
        end
    end
    return namecall(self, unpack(args))
end)

local Circle = Drawing.new("Circle")
RunService.RenderStepped:Connect(function()
    Circle.Visible = Config.CircleVisible
    Circle.Transparency = Config.CircleTransparency
    Circle.Color = Config.CircleColor

    Circle.Thickness = Config.CircleThickness
    Circle.NumSides = Config.CircleNumSides
    Circle.Radius = Config.FieldOfView
    Circle.Filled = Config.CircleFilled
    Circle.Position = UserInputService:GetMouseLocation()

    if Config.SilentAim then
        hit = GetTarget()
    else
        hit = nil
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

    if Config.Rainbow then
        local Hue, Saturation, Value = Config.Color:ToHSV()
        if Hue == 1 then
            Hue = 0
        end
        Config.Color = Color3.fromHSV(Hue + 0.001, 1, 1)
    end
    if Config.CircleRainbow then
        local Hue, Saturation, Value = Config.CircleColor:ToHSV()
        if Hue == 1 then
            Hue = 0
        end
        Config.CircleColor = Color3.fromHSV(Hue + 0.001, 1, 1)
    end
end)

for Index, Player in pairs(PlayerService:GetPlayers()) do
    if Player == LocalPlayer then continue end
    CreateESP(Player.Character)
    Player.CharacterAdded:Connect(function(Character)
        CreateESP(Character)
    end)
end

PlayerService.PlayerAdded:Connect(function(Player)
    Player.CharacterAdded:Connect(function(Character)
        CreateESP(Character)
    end)
end)
