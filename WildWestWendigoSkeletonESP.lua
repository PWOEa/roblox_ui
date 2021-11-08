local ESPLibrary = loadstring(Game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/ESPLibrary.lua"))()
local NPCFolder = Workspace.WORKSPACE_Entities.NPCs
local AnimalFolder = Workspace.WORKSPACE_Entities.Animals

for Index, Animal in pairs(AnimalFolder:GetChildren()) do
    if Animal.Name == "Wendigo" then
        ESPLibrary.Add(Animal.Name, Animal)
    end
end
AnimalFolder.ChildAdded:Connect(function(Animal)
    if Animal.Name == "Wendigo" then
        ESPLibrary.Add(Animal.Name, Animal)
    end
end)
AnimalFolder.ChildRemoved:Connect(function(Animal)
    if Animal.Name == "Wendigo" then
        ESPLibrary.Remove(Animal)
    end
end)

for Index, NPC in pairs(NPCFolder:GetChildren()) do
    if NPC:FindFirstChild("SkeletonTemplate") then
        ESPLibrary.Add(NPC.SkeletonTemplate.Parent.Name, NPC.SkeletonTemplate)
    end
end
NPCFolder.ChildAdded:Connect(function(NPC)
    if NPC:FindFirstChild("SkeletonTemplate") then
        ESPLibrary.Add(NPC.SkeletonTemplate.Parent.Name, NPC.SkeletonTemplate)
    end
end)
NPCFolder.ChildRemoved:Connect(function(NPC)
    if NPC:FindFirstChild("SkeletonTemplate") then
        ESPLibrary.Remove(NPC.SkeletonTemplate)
    end
end)
