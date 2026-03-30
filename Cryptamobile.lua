-- 🔴 REDZ HUB | CRYPTA v5.6 ULTRA | MOHAM-MADEX12 | Delta Ready
-- CRYPTA EMPIRE MOBILE - Blox Fruits v5.6 BULLETPROOF (HTTP DELTA FIXED)
-- Single-file loadstring for Mobile/Delta/Codex - Kavo UI DarkTheme Clone

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

getgenv().CRYPTA_LOADED = true
getgenv().HackerAI_Authorized = true

-- HTTP Load Function (Delta/Codex Compatible)
local function httpGet(url)
    return game:HttpGet(url:gsub("https://", "http://"))
end

-- Anti-Detection
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local args = {...}
    local method = getnamecallmethod()
    if method == "FireServer" and self.Name == "CommF_" then
        return
    end
    return oldNamecall(self, ...)
end)

-- Kavo UI Library (HTTP Fixed for Delta)
local KavoSuccess, KavoLib = pcall(function()
    return httpGet("http://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua")
end)

local Library = loadstring(KavoLib or game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("🔴 REDZ HUB | CRYPTA v5.6 ULTRA", "DarkTheme")
local Watermark = Library:CreateWatermark("🔴 REDZ HUB | CRYPTA v5.6 ULTRA | MOHAM-MADEX12 | Delta Ready")

-- SEA TELEPORTS (25+)
local SeaTPs = {
    "Sea1","Sea2","Sea3","Sea1_1","Sea1_2","Sea2_1","Sea2_2","Sea2_3",
    "Sea3_1","Sea3_2","Sea3_3","Sea3_4","Sea3_5","Sea3_6","Sea3_7",
    "Sea3_8","Sea3_9","Sea3_10","Sea3_11","Sea3_12","Sea3_13","Sea3_14",
    "Sea3_15","Sea3_16","Sea3_17","Sea3_18"
}

-- 🏠 MAIN TAB
local MainTab = Window:NewTab("🏠 Main")
local MainSection = MainTab:NewSection("Core")

local SelectedStat = "Melee"
MainTab:NewDropdown("Stat", "Max this stat", {"Melee","Defense","Sword","Gun","Demon Fruit","Bloom","Observation"}, function(stat)
    SelectedStat = stat
end)

MainTab:NewToggle("Max Stats", "1000pts x5 loop", function(state)
    getgenv().MaxStats = state
    if state then task.spawn(function()
        while getgenv().MaxStats do
            pcall(function()
                for i=1,5 do
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint",SelectedStat,1000)
                    task.wait(0.15)
                end
            end) task.wait(1)
        end
    end) end
end)

MainTab:NewButton("🌀 Rejoin", "Rejoin server", function()
    TeleportService:Teleport(game.PlaceId,LocalPlayer)
end)

MainTab:NewButton("🔄 Server Hop", "New server", function()
    loadstring(httpGet("http://raw.githubusercontent.com/EdgeIY/infiniteyield/master/serverhop.lua") or game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/serverhop.lua"))()
end)

-- 🌾 FARM TAB
local FarmTab = Window:NewTab("🌾 Farm")
FarmTab:NewToggle("Auto Farm", "Nearest <500 studs", function(state)
    getgenv().AutoFarm = state
end)
FarmTab:NewSlider("Distance", "Max farm distance", 500, 50, function(s)
    getgenv().FarmDistance = s
end)

-- ⚔️ COMBAT TAB
local CombatTab = Window:NewTab("⚔️ Combat")
CombatTab:NewToggle("ESP", "Enemy ESP", function(state)
    loadstring(httpGet("http://raw.githubusercontent.com/skatbr/A_simple_esp.lua/main/A_simple_esp.lua") or game:HttpGet("https://raw.githubusercontent.com/skatbr/A_simple_esp.lua/main/A_simple_esp.lua"))()
end)

CombatTab:NewToggle("Inf Stamina", "No stamina drain", function(state)
    getgenv().InfStamina = state
end)

CombatTab:NewSlider("Walkspeed", "16-200", 16, 200, function(s)
    getgenv().Walkspeed = s
end)

-- Mobile Fly (BV 4000 Heartbeat)
local FlyEnabled, FlySpeed, BV, BAV = false, 100
CombatTab:NewToggle("Mobile Fly", "BV Heartbeat fly", function(state)
    FlyEnabled = state
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local HRP = LocalPlayer.Character.HumanoidRootPart
        if state then
            BV = Instance.new("BodyVelocity",HRP) BV.MaxForce = Vector3.new(4000,4000,4000)
            BAV = Instance.new("BodyAngularVelocity",HRP) BAV.MaxTorque = Vector3.new(4000,4000,4000)
            RunService.Heartbeat:Connect(function()
                if FlyEnabled then
                    local camVec = Camera.CFrame.LookVector*FlySpeed
                    BV.Velocity = Vector3.new(camVec.X, (UserInputService:IsKeyDown(Enum.KeyCode.Space) and FlySpeed or UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and -FlySpeed or 0), camVec.Z)
                end
            end)
        else
            if BV then BV:Destroy() end
            if BAV then BAV:Destroy() end
        end
    end
end)

CombatTab:NewSlider("Fly Speed", "1-200", 100, 1, 200, function(s) FlySpeed = s end)

-- ⚙️ MISC TAB
local MiscTab = Window:NewTab("⚙️ Misc")
MiscTab:NewDropdown("Sea TP", "Teleport sea", SeaTPs, function(sea)
    pcall(function() ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSea",sea) end)
end)

MiscTab:NewButton("🗑️ Destroy", "Close GUI", function() Library:Destroy() end)

-- MAIN HEARTBEAT LOOP
RunService.Heartbeat:Connect(function()
    pcall(function()
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        local HRP = char.HumanoidRootPart
        local hum = char:FindFirstChild("Humanoid")
        
        -- Auto Farm
        if getgenv().AutoFarm then
            local nearest, dist = nil, getgenv().FarmDistance or 500
            for _,v in pairs(Workspace.Enemies:GetChildren()) do
                if v:FindFirstChild("HumanoidRootPart") then
                    local d = (HRP.Position-v.HumanoidRootPart.Position).Magnitude
                    if d<dist then dist=d nearest=v end
                end
            end
            if nearest then
                HRP.CFrame = nearest.HumanoidRootPart.CFrame*CFrame.new(0,5,0)
                task.wait(0.1)
                ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest",nearest.Name,1)
            end
        end
        
        -- Inf Stamina + Walkspeed
        if getgenv().InfStamina then hum:ChangeState(11) end
        if getgenv().Walkspeed then hum.WalkSpeed = getgenv().Walkspeed end
    end)
end)

-- Defaults
getgenv().FarmDistance = 500
getgenv().Walkspeed = 16

print("🔴 CRYPTA v5.6 DELTA FIXED LOADED! HTTP://raw.githubusercontent.com")
