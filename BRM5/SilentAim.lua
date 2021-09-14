local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local PlayerService = game:GetService("Players")
local LocalPlayer = PlayerService.LocalPlayer

local NPCFolder = Workspace.Custom:FindFirstChild("-1") or Workspace.Custom:FindFirstChild("1")

if not getgenv().Config then
getgenv().Config = {
	-- Circle
	CircleVisible = true,
	CircleTransparency = 1,
	CircleColor = Color3.fromRGB(255,128,64),
	CircleThickness = 1,
	CircleNumSides = 30,
	CircleFilled = false,

	-- ESP
	OutlineVisible = true,
    TextVisible = false,
    BoxVisible = false,
    Color = Color3.fromRGB(255,128,64),

	NPCOutlineVisible = true,
    NPCTextVisible = true,
    NPCBoxVisible = true,
    NPCColor = Color3.fromRGB(255,128,64),

	-- Aimbot
	SilentAim = true,
	Aimbot = false,
	Wallcheck = false,
	TeamCheck = false,

	-- Aimbot Settings
	Sensitivity = 0.5,
	FieldOfView = 100,
	TargetMode = "NPC",
	AimHitbox = "Head",

	NoRecoil = false,
	EnableSpeed = false,
	Speed = 100
}
end

local UIConfig = {
    WindowName = "Blackhawk Rescue Mission 5",
	Color = Color3.fromRGB(255,128,64),
	Keybind = Enum.KeyCode.RightShift
}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/BracketV3.lua"))()
local Window = Library:CreateWindow(UIConfig, game:GetService("CoreGui"))

local MainTab = Window:CreateTab("Main")
local UITab = Window:CreateTab("UI Settings")

local AimbotSection = MainTab:CreateSection("Aimbot")
local CircleSection = MainTab:CreateSection("Circle")
local NPCESPSection = MainTab:CreateSection("NPC ESP")
local ESPSection = MainTab:CreateSection("Player ESP")
local OtherSection = MainTab:CreateSection("Other")
local MenuSection = UITab:CreateSection("Menu")
local BackgroundSection = UITab:CreateSection("Background")

local SilentAimToggle = AimbotSection:CreateToggle("Silent Aim", nil, function(State)
	Config.SilentAim = State
end)
SilentAimToggle:SetState(Config.SilentAim)

local AimbotToggle = AimbotSection:CreateToggle("Aimbot", nil, function(State)
	Config.Aimbot = State
end)
AimbotToggle:SetState(Config.Aimbot)

local TeamCheckToggle = AimbotSection:CreateToggle("Team Check", nil, function(State)
	Config.TeamCheck = State
end)
TeamCheckToggle:SetState(Config.TeamCheck)

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

local NPCBoxToggle = NPCESPSection:CreateToggle("Box Visible", nil, function(State)
	Config.NPCBoxVisible = State
end)
NPCBoxToggle:SetState(Config.NPCBoxVisible)

local NPCTextToggle = NPCESPSection:CreateToggle("Text Visible", nil, function(State)
	Config.NPCTextVisible = State
end)
NPCTextToggle:SetState(Config.NPCTextVisible)

local NPCOutlineToggle = NPCESPSection:CreateToggle("Outline Visible", nil, function(State)
	Config.NPCOutlineVisible = State
end)
NPCOutlineToggle:SetState(Config.NPCOutlineVisible)

local NPCColorpicker = NPCESPSection:CreateColorpicker("ESP Color", function(Color)
	Config.NPCColor = Color
end)
NPCColorpicker:UpdateColor(Config.NPCColor)

local BoxToggle = ESPSection:CreateToggle("Box Visible", nil, function(State)
	Config.BoxVisible = State
end)
BoxToggle:SetState(Config.BoxVisible)

local TextToggle = ESPSection:CreateToggle("Text Visible", nil, function(State)
	Config.TextVisible = State
end)
TextToggle:SetState(Config.TextVisible)

local OutlineToggle = ESPSection:CreateToggle("Outline Visible", nil, function(State)
	Config.OutlineVisible = State
end)
OutlineToggle:SetState(Config.OutlineVisible)

local Colorpicker = ESPSection:CreateColorpicker("ESP Color", function(Color)
	Config.Color = Color
end)
Colorpicker:UpdateColor(Config.Color)

local SpeedToggle = OtherSection:CreateToggle("Enabled Speedhack", nil, function(State)
	Config.EnableSpeed = State
end)
SpeedToggle:SetState(Config.EnableSpeed)

local NoRecoilToggle = OtherSection:CreateToggle("No Recoil", nil, function(State)
	Config.NoRecoil = State
end)
NoRecoilToggle:SetState(Config.NoRecoil)

local SpeedSlider = OtherSection:CreateSlider("Speedhack Value", 0,1000,nil,true, function(Value)
	Config.Speed = Value
end)
SpeedSlider:SetValue(Config.Speed)


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

local function CalculateBox(Model)
	local CFrame, Size = Model:GetBoundingBox()
	local Camera = Workspace.CurrentCamera
    
	local CornerTable = {
		Camera:WorldToViewportPoint(Vector3.new(CFrame.X - Size.X / 2, CFrame.Y + Size.Y / 2, CFrame.Z)), -- TopLeft
		Camera:WorldToViewportPoint(Vector3.new(CFrame.X + Size.X / 2, CFrame.Y + Size.Y / 2, CFrame.Z)), -- TopRight
		Camera:WorldToViewportPoint(Vector3.new(CFrame.X - Size.X / 2, CFrame.Y - Size.Y / 2, CFrame.Z)), -- BottomLeft
		Camera:WorldToViewportPoint(Vector3.new(CFrame.X + Size.X / 2, CFrame.Y - Size.Y / 2, CFrame.Z)), -- BottomRight
	}

	local WorldPosition, OnScreen = Camera:WorldToViewportPoint(CFrame.Position)
	local Size = Vector2.new((CornerTable[1] - CornerTable[2]).Magnitude, (CornerTable[1] - CornerTable[3]).Magnitude)
	local Position = Vector2.new(WorldPosition.X - Size.X / 2, WorldPosition.Y - Size.Y / 2)
    
	return Position, Size, OnScreen
end

local function GetDistanceFromClient(Position)
    return LocalPlayer:DistanceFromCharacter(Position)
end

local function TeamCheck(Target)
    if Config.TeamCheck then
        if LocalPlayer.Team ~= Target.Team then
            return true
        else
            return false
        end
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

local function CreateESPNPC(Model)
    local Text = Drawing.new("Text")
    local BoxOutline = Drawing.new("Square")
    local Box = Drawing.new("Square")

    local Render = RunService.RenderStepped:Connect(function()
        if Model and Model:FindFirstChild("HumanoidRootPart") then
            if Model:FindFirstChildOfClass("Humanoid") and Model:FindFirstChildOfClass("Humanoid").Health ~= 0 then
                Camera = Workspace.CurrentCamera
                local Position, Size, OnScreen = CalculateBox(Model)
				local Distance = GetDistanceFromClient(Model.HumanoidRootPart.Position)
				local Health = Model:FindFirstChildOfClass("Humanoid").Health
                if OnScreen then
                    Text.Visible = Config.NPCTextVisible
                    Text.Transparency = 1
                    Text.Color = Color3.fromRGB(255,255,255)
                    Text.Text = string.format("%s\n%d HP\n%d studs",string.sub(Model.Name,38),Health,Distance)
                    Text.Size = 16
                    Text.Center = true
                    Text.Outline = Config.NPCOutlineVisible
                    Text.OutlineColor = Color3.fromRGB(0,0,0)

                    Text.Position = Vector2.new(Position.X + Size.X/2, Position.Y + Size.Y)

                    BoxOutline.Visible = Config.NPCBoxVisible and Config.NPCOutlineVisible
                    BoxOutline.Transparency = 1
                    BoxOutline.Color = Color3.fromRGB(0,0,0)
                    BoxOutline.Thickness = 3
                    BoxOutline.Filled = false

                    BoxOutline.Size = Size
                    BoxOutline.Position = Position

                    Box.Visible = Config.NPCBoxVisible
                    Box.Transparency = 1
                    Box.Color = Config.NPCColor
                    Box.Thickness = 1
                    Box.Filled = false

                    Box.Size = Size
                    Box.Position = Position
                else
                    Text.Visible = false
                    BoxOutline.Visible = false
                    Box.Visible = false
                end
            else
                Text.Visible = false
                BoxOutline.Visible = false
                Box.Visible = false
            end
		else
			Text.Visible = false
			BoxOutline.Visible = false
			Box.Visible = false
        end
    end)

    Model.AncestryChanged:Connect(function(Child, Parent)
        if not Parent then
            Render:Disconnect()
            Text:Remove()
            BoxOutline:Remove()
            Box:Remove()
        end
    end)
end

local function CreateESP(Model)
    local Text = Drawing.new("Text")
    local BoxOutline = Drawing.new("Square")
    local Box = Drawing.new("Square")

    local Render = RunService.RenderStepped:Connect(function()
        if Model and Model:FindFirstChild("HumanoidRootPart") then
            if Model:FindFirstChildOfClass("Humanoid") and Model:FindFirstChildOfClass("Humanoid").Health ~= 0 then
                Camera = Workspace.CurrentCamera
                local Position, Size, OnScreen = CalculateBox(Model)
				local Distance = GetDistanceFromClient(Model.HumanoidRootPart.Position)
				local Health = Model:FindFirstChildOfClass("Humanoid").Health
                if OnScreen then
                    Text.Visible = Config.TextVisible
                    Text.Transparency = 1
                    Text.Color = Color3.fromRGB(255,255,255)
                    Text.Text = string.format("%s\n%d HP\n%d studs",Model.Name,Health,Distance)
                    Text.Size = 16
                    Text.Center = true
                    Text.Outline = Config.OutlineVisible
                    Text.OutlineColor = Color3.fromRGB(0,0,0)
                    Text.Position = Vector2.new(Position.X + Size.X/2, Position.Y + Size.Y)

                    BoxOutline.Visible = Config.BoxVisible and Config.OutlineVisible
                    BoxOutline.Transparency = 1
                    BoxOutline.Color = Color3.fromRGB(0,0,0)
                    BoxOutline.Thickness = 3
                    BoxOutline.Filled = false

                    BoxOutline.Size = Size
                    BoxOutline.Position = Position

                    Box.Visible = Config.BoxVisible
                    Box.Transparency = 1
                    Box.Color = Config.Color
                    Box.Thickness = 1
                    Box.Filled = false

                    Box.Size = Size
                    Box.Position = Position
                else
                    Text.Visible = false
                    BoxOutline.Visible = false
                    Box.Visible = false
                end
            else
                Text.Visible = false
                BoxOutline.Visible = false
                Box.Visible = false
            end
		else
			Text.Visible = false
			BoxOutline.Visible = false
			Box.Visible = false
        end
    end)

    Model.AncestryChanged:Connect(function(Child, Parent)
        if not Parent then
            Render:Disconnect()
            Text:Remove()
            BoxOutline:Remove()
            Box:Remove()
        end
    end)
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
humanoidHook = hookfunction(require(GetNilScript("HumanoidClass")).LateUpdate, function(...)
    local args = {...}
	if Config.EnableSpeed then
		args[1]._speed = Config.Speed
		args[1].fly = 0
		args[1].fall = false -- just in case
		args[1].Falling = false
	end
    return humanoidHook(unpack(args))
end)

cameraHook = hookfunction(require(GetNilScript("CharacterCamera")).Update, function(...)
    local args = {...}
	if Config.NoRecoil then
    	args[1]._recoil = 0
		args[1]._shake = 0
	end
	if Config.EnableSpeed then
		args[1]._bob = 0
		args[1]._shake = 0
	end
    return cameraHook(unpack(args))
end)

namecall = hookmetamethod(game, "__namecall", function(self, ...)
    local namecallmethod = getnamecallmethod()
    local args = {...}
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
		wait(0.1)
		if NPC:FindFirstChildOfClass("Humanoid") and not NPC.Humanoid:FindFirstChild("Free") then
			CreateESPNPC(NPC)
		end
	end

	NPCFolder.ChildAdded:Connect(function(NPC)
		wait(0.1)
		if NPC:FindFirstChildOfClass("Humanoid") and not NPC.Humanoid:FindFirstChild("Free") then
			CreateESPNPC(NPC)
		end
	end)
end

for Index, Player in pairs(PlayerService:GetPlayers()) do
    if Player == LocalPlayer then continue end
	if Player.Character then
    	CreateESP(Player.Character)
	end
    Player.CharacterAdded:Connect(function(Character)
        CreateESP(Character)
    end)
end

PlayerService.PlayerAdded:Connect(function(Player)
    Player.CharacterAdded:Connect(function(Character)
        CreateESP(Character)
    end)
end)
