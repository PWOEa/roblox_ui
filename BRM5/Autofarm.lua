local Network = loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/BRM5/Network.lua"))() -- by Averias https://v3rmillion.net/showthread.php?tid=1096231 <3
local Notification = loadstring(game:HttpGet("https://api.irisapp.ca/Scripts/IrisBetterNotifications.lua"))() -- thanks to iris for better notifications

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")

local PlayerService = game:GetService("Players")
local LocalPlayer = PlayerService.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui

local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera
local CameraPosition = Camera.CFrame.Position

local NPCFolder = Workspace.Custom:FindFirstChild("-1")
local PropFolder = Workspace.Custom["0"].Airbase.Props

-- dont touch 
local MenuOpened = false
local BagDelivering = false
local target = nil

-- support for krnl
local iswindowactive = iswindowactive or isrbxactive

-- nice parachute bypass
local Float = Instance.new("Part")
Float.Name = "autofarm antiparachute (DONT TOUCH)"
Float.Parent = Workspace
Float.Transparency = 1
Float.Anchored = true
Float.Size = Vector3.new(10,1,10)

getgenv().AutofarmConfig = {
    Enabled = false,
    BagsFarm = false, -- work in progress (DONT USE IT for now)
    Align = CFrame.new(0,0,0) -- aling your character to npc (pretty useless but i let it be just in case)
}

local function alert(Message, Duration)
    Notification.Notify("autofarm by AlexR32#3232", Message, "", {
        Duration = Duration,
        TitleSettings = {
            BackgroundColor3 = Color3.fromRGB(255, 255 ,255),
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextScaled = false,
            TextWrapped = false,
            TextSize = 14,
            Font = Enum.Font.Code,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Bottom
        },
        DescriptionSettings = {
            BackgroundColor3 = Color3.fromRGB(255, 255 ,255),
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextScaled = true,
            TextWrapped = true,
            TextSize = 18,
            Font = Enum.Font.Code,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
        },
        IconSettings = {
            BackgroundTransparency = 1,
            BackgroundColor3 = Color3.fromRGB(255,255,255),
        },
        GradientSettings = {
            GradientEnabled = false,
            SolidColorEnabled = true,
            SolidColor = Color3.fromRGB(120,120,120),
            Retract = false,
            Extend = true,
        },
        Main = {
            BorderColor3 = Color3.fromRGB(0,0,0),
            BackgroundColor3 = Color3.fromRGB(30,30,30),
            BackgroundTransparency = 0.5,
            Rounding = false,
            BorderSizePixel = 1
        }
    })
end

local function isAlive()
    if LocalPlayer.Character then
        if LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health <= 10 then
            Network:FireServer("resetCharacter") -- reset character when you down
            --LocalPlayer.Character.Humanoid.Health = 0
        --elseif LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health <= 50 then
            --Network:FireServer("useMedical", 1)
        else
            return true
        end
    end
end

local function checkMenu() -- basic menu check and deploy button fire
    local Menu = PlayerGui.Screen["#menu"]
    if Menu.Visible then
        local Deploy = Menu["#screens"].template["#tab"]["#deploy"]
        getconnections(Deploy.MouseButton1Click)[1]:Fire()
    end
end

local function checkAmmo() -- simple check ammo based on player's gui
    local Clip = PlayerGui.Screen["#main"]["#hud"].right["#ammo"]["#clip"]
    if Clip.Text == "0" then
        return false
    else
        return true
    end
end

local function getAmmo() -- hacky method how to get ammo fast
    for _, Prop in pairs(PropFolder:GetDescendants()) do
        if Prop:IsA("StringValue") then
            if Prop.Value == '[["refillAmmo","Refill Ammo",[]]]' then -- find ammo box
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then -- check for player character
                    Prop.Parent.CFrame = CFrame.new(-3500, 50, 975) -- tp ammo box under grass
                    LocalPlayer.Character.HumanoidRootPart.CFrame = Prop.Parent.CFrame * CFrame.new(0,2,0) -- tp player on ammo box
                end
            end
        end
    end
    Network:FireServer("interactObject", 1) -- use ammo box
    --keypress(0x46)
    --keyrelease(0x46)
    --mouse1click()
end

local function checkGun(auto) -- simple gun check
    local Ammo = PlayerGui.Screen["#main"]["#hud"].right["#ammo"]
    if Ammo.Visible then -- its not visible when you dont have gun
        return true
    else
        if auto then
            Network:InvokeServer("equipTool", 1) -- equip your main gun if its not
            --keypress(0x31)
            --keyrelease(0x31)
        end
        return false
    end
end

local function checkBag() -- work in progress
    for _,Bag in pairs(Workspace.Custom:GetDescendants()) do
        if Bag.Name == "Bag" then
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                BagDelivering = true
                LocalPlayer.Character.HumanoidRootPart.CFrame = Bag.CFrame
                keypress(0x46)
                keyrelease(0x46)
                mouse1click()
            end
        end
    end
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Objective") then
        return true
    else
        return false
    end
end

local function deliverBag() -- work in progress
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-3510, 63, 532)
    wait(1)
    keypress(0x46)
    keyrelease(0x46)
    mouse1click()
    wait(2)
    local Dialogue = PlayerGui.Screen["#main"]["#hud"]["#dialogue"]
    for _, Button in pairs(Dialogue:GetChildren()) do
        if Button.Name == "TextButton" then
            if Button.Text == "I've got some goods you might want." then
                getconnections(Button.MouseButton1Click)[1]:Fire()
            end
        end
    end
    BagDelivering = false
end

-- silent aim things
local function getTarget()
    for _, NPC in pairs(NPCFolder:GetChildren()) do
        if NPC:FindFirstChildOfClass("Humanoid") and not NPC:FindFirstChildOfClass("Humanoid"):FindFirstChild("Free") then
            if NPC:FindFirstChildOfClass("Humanoid") and NPC:FindFirstChildOfClass("Humanoid").Health >= 0 then
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    if NPC:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = NPC.HumanoidRootPart.CFrame * AutofarmConfig.Align
                        Float.Position = LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(0,4,0)
                        return NPC:FindFirstChild("Head")
                    end
                end
            end
        end
    end
    return nil
end

local function returnHit(target, args)
    CameraPosition = Camera.CFrame.Position
    if args[1].Origin == CameraPosition then
        args[1] = Ray.new(CameraPosition, target.Position - CameraPosition)
        return
    end
end

namecall = hookmetamethod(game, "__namecall", function(self, ...)
    local namecallmethod = getnamecallmethod()
    local args = {...}
    if namecallmethod == "FindPartOnRayWithIgnoreList" then
        if target then
            returnHit(target, args)
        end
    end
    return namecall(self, unpack(args))
end)

-- main render function
RunService.RenderStepped:Connect(function()
    if AutofarmConfig.Enabled and not MenuOpened and not BagDelivering then
        if iswindowactive() then
            if checkGun(false) then
                if checkAmmo() then
                    target = getTarget()
                    if target then
                        mouse1click()
                    else
                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1705, 800, -4532)
                            Float.Position = LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(0,4,0)
                        end
                    end
                else
                    getAmmo()
                end
            end
        end
    end
end)

-- delay for some functions (dont ask me why i am not using while true do loop or any other shit)
local Wait = 0
local WaitMax = 2
RunService.Heartbeat:Connect(function(Delta)
    Wait += Delta
    if Wait >= WaitMax then
        if AutofarmConfig.Enabled then
            checkMenu()
            checkGun(true)
            isAlive()
        end
        if AutofarmConfig.BagsFarm then
            if checkBag() then
                deliverBag()
            end
        end
        Wait = 0
    end
end)

-- simple keybind with alert
UserInputService.InputBegan:Connect(function(Input)
    if Input.KeyCode == Enum.KeyCode.F6 then
        AutofarmConfig.Enabled = not AutofarmConfig.Enabled

        alert("autofarm " .. (AutofarmConfig.Enabled and "enabled" or "disabled"),1)
    end
end)

-- check for "esc menu"
GuiService.MenuOpened:Connect(function()
    MenuOpened = true
end)

GuiService.MenuClosed:Connect(function()
    MenuOpened = false
end)

alert("press F6 to start farming",5) -- send message when script is executed
