# Roblox

## Blackhawk Rescue Mission 5
```lua
getgenv().Config = {
    CircleEnabled = false,
    CircleTransparency = 0.25,
    CircleColor = Color3.fromRGB(255,255,255),

    CircleThickness = 1.5,
    CircleNumSides = 30,
    CircleFilled = false,

    TracerEnabled = false,
    TracerTransparency = 0.25,
    TracerColor = Color3.fromRGB(255,0,0),
    TracerThickness = 2,

    InfoEnabled = false,
    InfoDistance = false,
    InfoPosition = Vector2.new(0,25),
    InfoTransparency = 0.25,
    InfoSize = 20,
    InfoOutline = false,
    InfoFont = 1,

    SilentAim = false,
    VisibiltyCheck = false,
    FOV = 100,
    Distance = 1000,
    TargetMode = "NPC",
    HitPart = "Head",
    FOVMode = "Cursor"
}
-- github.com/AlexR32/Roblox
loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/BlackhawkRescueMission5.lua"))()
```
### Changelog
```css
[*] Attemt to fix ESP fps drop (maybe)
[*] Edited Config
```
## BRM5 ESP Cut
```lua
getgenv().Config = {
    TracerEnabled = false,
    TracerTransparency = 0.5,
    TracerColor = Color3.fromRGB(255,75,75),
    TracerThickness = 1,

    InfoEnabled = false,
    InfoDistance = false,
    InfoPosition = Vector2.new(0,50),
    InfoTransparency = 1,
    InfoSize = 20,
    InfoOutline = false,
    InfoFont = 1,
}
-- No UI, no silent aim, only esp
-- github.com/AlexR32/Roblox
loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/BRM5ESPCut.lua"))()
```
## CoastingUI V2
```lua
local CoreGui = game:GetService("CoreGui")
local Config = {
    Theme = {
        BackgroundColor = Color3.fromRGB(35,35,35),
        MainColor = Color3.fromRGB(75,75,255),
        TextFont = Enum.Font.SourceSansBold,
        EasingStyle = Enum.EasingStyle.Quart
    },
    CheatName = nil,
    Discord = nil,
    UIKeybind = Enum.KeyCode.RightShift,
    Cursor = true
}

local CoastingCore = loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/CoastingUIV2.lua"))()
local Coasting = CoastingCore:Init(Config, CoreGui)

local Main = Coasting:CreateTab("Main")
local Credits = Coasting:CreateTab("Credits")
local Settings = Coasting:CreateTab("Settings")

local MainSection = Main:CreateSection("Section")
local CoastingUISec = Credits:CreateSection("Developers")
local SettingsSection = Settings:CreateSection("...")

MainSection:CreateLabel("", "Label")

MainSection:CreateButton("Button", function()
    print("Button")
end)

MainSection:CreateToggle("Toggle", true, function(Boolean)
    print(Boolean)
end)

MainSection:CreateSlider("Slider", 0, 100, 50, false, function(Number)
    print(Number)
end)

MainSection:CreateColorPicker("ColorPicker",Color3.new(1,1,1),function(Color)
	print(Color)
end)

MainSection:CreateDropdown("Dropdown", {"Text1","Text2"}, 2, function(String)
    print(String)
end)

CoastingUISec:CreateLabel("Main Dev", "coasts @v3rmillion.net coasts#7386 @discord.com (Original Version Dev)")
CoastingUISec:CreateLabel("V2 Dev", "Alex332Rus @v3rmillion.net AlexR32#3232 @discord.com (V2 Dev)")

SettingsSection:CreateKeybind("UI Toggle", Config.UIKeybind, true, false, function(Key)
    Config.UIKeybind = Enum.KeyCode[Key]
end)
```
### Changelog
```css
[*] Fixed Section Titles
[*] Fixed Slider TextBox not working
[*] Fixed CornerUI not replicating in keybinds
```
## TPR:R Hax
```lua
_G.Config = {
    PrimaryColor = Color3.fromRGB(27, 38, 59),
    SecondaryColor = Color3.fromRGB(13, 27, 42),
    AccentColor = Color3.fromRGB(41, 115, 115),
    TextColor =  Color3.new(1,1,1),
    Font = Enum.Font.Gotham,
    TextSize = 15,
    HeaderWidth = 250,
    HeaderHeight = 30,
    EntryMargin = 1,
    AnimationDuration = 0.5,
    AnimationEasingStyle = Enum.EasingStyle.Linear,
    DefaultEntryHeight = 35
}

loadstring(game:HttpGet(("https://raw.githubusercontent.com/AlexR32/Roblox/main/TPRRHax.lua"), true))()
```
