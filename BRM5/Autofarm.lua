local Network = loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/BRM5/Network.lua"))() -- by Averias https://v3rmillion.net/showthread.php?tid=1096231 <3
local Notification = loadstring(game:HttpGet("https://api.irisapp.ca/Scripts/IrisBetterNotifications.lua"))() -- thanks to iris for better notifications

local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local PlayerService = game:GetService("Players")
local LocalPlayer = PlayerService.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui

local Workspace = game:GetService("Workspace")
local NPCFolder = Workspace.Custom:FindFirstChild("-1")
local PropFolder = Workspace.Custom["0"].Airbase.Props

-- do not touch 
local globalTable = nil

-- parachute bypass
local Float = Instance.new("Part")
Float.Name = "Autofarm AntiParachute"
Float.Parent = Workspace
Float.Transparency = 1
Float.Anchored = true
Float.Size = Vector3.new(10,1,10)

getgenv().AutofarmConfig = {
    Enabled = false,
    Align = CFrame.new(0,-6,0) -- aling your character to npc
}

local function notify(message, color)
    for _,Instance in pairs(getnilinstances()) do
        if Instance.Name == "InterfaceHandler" then
            require(Instance).ScreenMessage(nil, message, color)
            break
        end
    end
end

local function isAlive() -- resets character when you down
    if LocalPlayer.Character then
        if LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health <= 10 then
            Network:FireServer("resetCharacter")
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

local function getAmmo() -- get ammo function, self-explanatory
    for _, Prop in pairs(PropFolder:GetDescendants()) do
        if Prop:IsA("StringValue") then
            if Prop.Value == '[["refillAmmo","Refill Ammo",[]]]' then -- find ammo box
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then -- check for player character
                    Prop.Parent.CFrame = CFrame.new(-3500, 50, 975) -- tp ammo box under grass
                    LocalPlayer.Character.HumanoidRootPart.CFrame = Prop.Parent.CFrame * CFrame.new(0,2,0) -- tp player char on ammo box
                end
            end
        end
    end
    Network:FireServer("interactObject", 1) -- use ammo box
end

local function checkGun(auto) -- gun check and equip gun mechanism
    local Ammo = PlayerGui.Screen["#main"]["#hud"].right["#ammo"]
    if Ammo.Visible then -- its not visible when you dont have gun
        return true
    else
        if auto then
            Network:InvokeServer("equipTool", 0) -- unequip already hold on gun
            Network:InvokeServer("equipTool", 1) -- equip your main gun if its not
        end
        return false
    end
end

-- get npc and tp
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

metatable = hookfunction(getgenv().setmetatable, function(...)
    local args = {...}
    if args[1]._ammo then
        globalTable = args[1]
    end
    return metatable(...)
end)

-- main render function
RunService.RenderStepped:Connect(function()
    if AutofarmConfig.Enabled then
        if checkGun(false) then
            if globalTable and globalTable._ammo ~= 0 then -- ammo check
                local target = getTarget()
                if target then
                    local GUID = HttpService:GenerateGUID(false)
                    Network:FireServer("activateTool", "discharge", GUID, 0, {{target.Position.X,target.Position.Y,target.Position.Z}})
                    Network:FireServer("activateTool", "land", GUID .. "1", target:GetFullName(), {0,0,0})
                    globalTable._ammo = globalTable._ammo - 1
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
end)

-- delay for some functions (dont ask me why i am not using while true do loop or any other shit)
local Wait = 0
local WaitMax = 1
RunService.Heartbeat:Connect(function(Delta)
    Wait += Delta
    if Wait >= WaitMax then
        if AutofarmConfig.Enabled then
            checkMenu()
            checkGun(true)
            isAlive()
        end
        Wait = 0
    end
end)

-- simple keybind with notify
UserInputService.InputBegan:Connect(function(Input)
    if Input.KeyCode == Enum.KeyCode.F6 then
        AutofarmConfig.Enabled = not AutofarmConfig.Enabled
        notify("Autofarm " .. (AutofarmConfig.Enabled and "enabled" or "disabled"),Color3.fromRGB(255,255,255))
    end
end)

notify("Autofarm by AlexR32#0157\nPress F6 to start farming",Color3.fromRGB(255,255,255)) -- send message when script is executed
