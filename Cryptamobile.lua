-- 🔥 CRYPTA EMPIRE v5.6 BULLETPROOF | REDZ HUB GUI CLONE | MOHAM-MADEX12 | Delta Ready
-- Loadstring: loadstring(game:HttpGet("https://raw.githubusercontent.com/MOHAM-MADEX12/CRYPTA-Empire/main/CryptaMobile.lua"))()
getgenv().CRYPTA_LOADED = true
getgenv().HackerAI_Authorized = true

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Safe HttpGet
local function sHttpGet(url)
    local success, result = pcall(function()
        return game:HttpGet(url)
    end)
    return success and result or ""
end

-- Load Kavo UI
local Kavo = loadstring(sHttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

-- Watermark (RedZ Style)
Kavo:InitWatermark("🔴 REDZ HUB | CRYPTA v5.6 ULTRA | MOHAM-MADEX12 | Delta Ready")

-- Main Window (RedZ Dark Theme)
local Window = Kavo:CreateLib("🔴 CRYPTA EMPIRE v5.6 | REDZ HUB", "DarkTheme")

-- TABS (RedZ Style)
local MainTab = Window:NewTab("🏠 Main")
local FarmTab = Window:NewTab("🌾 Farm")
local CombatTab = Window:NewTab("⚔️ Combat")
local MiscTab = Window:NewTab("⚙️ Misc")

-- 🌾 FARM TAB
local FarmSection = FarmTab:NewSection("Auto Farm")
local FarmToggle = FarmTab:NewToggle("AutoFarm", "Auto farm nearest enemy <500 studs", function(state)
    getgenv().AutoFarm = state
end)

-- Teleports Section
local TPSection = FarmTab:NewSection("25+ Sea Teleports")
local TPDropdown = FarmTab:NewDropdown("Teleport", "Select location", {"Starter Sea (-323,73,5641)", "Jungle (-1320,16,377)", "Pirate (-300,73,5500)", "Marine (5432,28,800)", "Sky (-7890,5540,0)", "Fountain (5282,22,448)", "Green Zone (11185,141,13871)", "Haunted Castle (9231,157,60856)", "Temple of Time (2990,20,8000)", "Redz Secret (0,1000,0)", "Frozen Village (-1245,15,10595)", "Snow Mountain (1385,88,1110)", "Hot and Cold (5676,29,523)", "Cursed Ship (916,182,1193)", "Hydra Island (5467,650,642)", "Floating Turtle (2749,64,2899)", "Castle on the Sea (6344,325,292)", "Port Town (301,23,1425)", "Rough Waters (23,73,306)", "Mansion ( -377,25,325)", "Prehistoric (61180,17,-5522)", "Diamond's Teeth (-1380,15,37)", "Great Tree (2719,102,2656)", "Snow Lair (-6050,330,-3750)", "Sea 2 (2681,17,-38)"}, function(selected)
    local TPs = {
        ["Starter Sea (-323,73,5641)"] = CFrame.new(-323,73,5641),
        ["Jungle (-1320,16,377)"] = CFrame.new(-1320,16,377),
        ["Pirate (-300,73,5500)"] = CFrame.new(-300,73,5500),
        ["Marine (5432,28,800)"] = CFrame.new(5432,28,800),
        ["Sky (-7890,5540,0)"] = CFrame.new(-7890,5540,0),
        ["Fountain (5282,22,448)"] = CFrame.new(5282,22,448),
        ["Green Zone (11185,141,13871)"] = CFrame.new(11185,141,13871),
        ["Haunted Castle (9231,157,60856)"] = CFrame.new(9231,157,60856),
        ["Temple of Time (2990,20,8000)"] = CFrame.new(2990,20,8000),
        ["Redz Secret (0,1000,0)"] = CFrame.new(0,1000,0),
        ["Frozen Village (-1245,15,10595)"] = CFrame.new(-1245,15,10595),
        ["Snow Mountain (1385,88,1110)"] = CFrame.new(1385,88,1110),
        ["Hot and Cold (5676,29,523)"] = CFrame.new(5676,29,523),
        ["Cursed Ship (916,182,1193)"] = CFrame.new(916,182,1193),
        ["Hydra Island (5467,650,642)"] = CFrame.new(5467,650,642),
        ["Floating Turtle (2749,64,2899)"] = CFrame.new(2749,64,2899),
        ["Castle on the Sea (6344,325,292)"] = CFrame.new(6344,325,292),
        ["Port Town (301,23,1425)"] = CFrame.new(301,23,1425),
        ["Rough Waters (23,73,306)"] = CFrame.new(23,73,306),
        ["Mansion ( -377,25,325)"] = CFrame.new(-377,25,325),
        ["Prehistoric (61180,17,-5522)"] = CFrame.new(61180,17,-5522),
        ["Diamond's Teeth (-1380,15,37)"] = CFrame.new(-1380,15,37),
        ["Great Tree (2719,102,2656)"] = CFrame.new(2719,102,2656),
        ["Snow Lair (-6050,330,-3750)"] = CFrame.new(-6050,330,-3750),
        ["Sea 2 (2681,17,-38)"] = CFrame.new(2681,17,-38)
    }
    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        Player.Character.HumanoidRootPart.CFrame = TPs[selected]
    end
end)

-- 🏠 MAIN TAB
local FlySection = MainTab:NewSection("Mobile Fly (BV Method)")
local FlyToggle = MainTab:NewToggle("Fly", "Toggle fly (WASD/Space/Shift)", function(state)
    getgenv().FlyEnabled = state
    if not Player.Character then return end
    FlyLogic()
end)
local FlySlider = MainTab:NewSlider("FlySpeed", "Fly speed", 50, 1, 200, function(s)
    getgenv().FlySpeed = s
end)

-- ⚔️ COMBAT TAB
local StatsSection = CombatTab:NewSection("Max Stats")
local StatsDropdown = CombatTab:NewDropdown("StatType", "Select stat", {"Melee", "Defense", "Sword", "Gun", "Demon Fruit", "Bloom", "Observation"}, function(selected)
    getgenv().SelectedStat = selected:gsub(" ", ""):lower()
end)
local MaxStatsBtn = CombatTab:NewButton("Max Stats (x5)", "Max selected stat", function()
    task.spawn(function()
        for i = 1, 5 do
            pcall(function()
                RS.Remotes.CommF_:InvokeServer("AddPoint", getgenv().SelectedStat or "Melee", 1000)
            end)
            task.wait(0.15)
        end
        Kavo:Notify("Max Stats Complete!", 3)
    end)
end)

-- ⚙️ MISC TAB
local MiscSection = MiscTab:NewSection("ESP & Utilities")
local ESPBtn = MiscTab:NewButton("Load ESP", "Load skatbr ESP", function()
    loadstring(sHttpGet("https://raw.githubusercontent.com/skatbr/Roblox-Releases/main/A_simple_esp.lua"))()
    Kavo:Notify("ESP Loaded!", 3)
end)

local StaminaBtn = MiscTab:NewButton("Infinite Stamina", "Toggle inf stamina", function()
    getgenv().InfStamina = not getgenv().InfStamina
    Kavo:Notify("Inf Stamina: " .. (getgenv().InfStamina and "ON" or "OFF"), 3)
end)

local SpeedSection = MiscTab:NewSection("Walk Speed")
local SpeedSlider = MiscTab:NewSlider("WalkSpeed", "Walk speed", 16, 16, 200, function(s)
    getgenv().WalkSpeed = s
    if Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid.WalkSpeed = s
    end
end)

local HopSection = MiscTab:NewSection("Server")
local RejoinBtn = MiscTab:NewButton("Rejoin", "Rejoin server", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, Player)
end)
local HopBtn = MiscTab:NewButton("Server Hop", "Hop to new server", function()
    loadstring(sHttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/serverhop.lua"))()
end)

-- FLY LOGIC (Mobile BV Heartbeat - RedZ Style)
local flyBV, vel = nil, nil
local keys = {w=0, s=0, a=0, d=0, sp=0, sh=0}
function FlyLogic()
    if getgenv().FlyEnabled and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        if flyBV then flyBV:Destroy() end
        flyBV = Instance.new("BodyVelocity")
        flyBV.MaxForce = Vector3.new(4000,4000,4000)
        flyBV.Parent = Player.Character.HumanoidRootPart
        
        RunService.Heartbeat:Connect(function()
            if not getgenv().FlyEnabled or not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") or not flyBV or not flyBV.Parent then
                if flyBV then flyBV:Destroy() end
                return
            end
            
            vel = Vector3.new(0,0,0)
            local camLook = Camera.CFrame.LookVector * getgenv().FlySpeed
            local camRight = Camera.CFrame.RightVector * getgenv().FlySpeed
            
            if keys.w == 1 then vel = vel + camLook end
            if keys.s == 1 then vel = vel - camLook end
            if keys.a == 1 then vel = vel - camRight end
            if keys.d == 1 then vel = vel + camRight end
            if keys.sp == 1 then vel = vel + Vector3.new(0, getgenv().FlySpeed, 0) end
            if keys.sh == 1 then vel = vel - Vector3.new(0, getgenv().FlySpeed, 0) end
            
            flyBV.Velocity = vel
        end)
        
        -- Mobile Controls (RedZ Style)
        UserInputService.InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.W then keys.w = 1 end
            if input.KeyCode == Enum.KeyCode.S then keys.s = 1 end
            if input.KeyCode == Enum.KeyCode.A then keys.a = 1 end
            if input.KeyCode == Enum.KeyCode.D then keys.d = 1 end
            if input.KeyCode == Enum.KeyCode.Space then keys.sp = 1 end
            if input.KeyCode == Enum.KeyCode.LeftShift then keys.sh = 1 end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.W then keys.w = 0 end
            if input.KeyCode == Enum.KeyCode.S then keys.s = 0 end
            if input.KeyCode == Enum.KeyCode.A then keys.a = 0 end
            if input.KeyCode == Enum.KeyCode.D then keys.d = 0 end
            if input.KeyCode == Enum.KeyCode.Space then keys.sp = 0 end
            if input.KeyCode == Enum.KeyCode.LeftShift then keys.sh = 0 end
        end)
    else
        if flyBV then flyBV:Destroy() end
    end
end

-- AUTO FARM LOOP
task.spawn(function()
    while true do
        if getgenv().AutoFarm and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            local nearestEnemy = nil
            local shortestDist = 500
            
            for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                if enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                    local dist = (Player.Character.HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude
                    if dist < shortestDist then
                        shortestDist = dist
                        nearestEnemy = enemy
                    end
                end
            end
            
            if nearestEnemy and shortestDist < 500 then
                Player.Character.HumanoidRootPart.CFrame = nearestEnemy.HumanoidRootPart.CFrame * CFrame.new(0,5,0)
                task.wait(0.2)
                pcall(function()
                    RS.Remotes.CommF_:InvokeServer("StartQuest", nearestEnemy.Name.."Quest", 1)
                end)
            end
        end
        task.wait(0.5)
    end
end)

-- INF STAMINA + WALK SPEED HEARTBEAT (Optimized)
RunService.Heartbeat:Connect(function()
    if Player.Character and Player.Character:FindFirstChild("Humanoid") then
        -- Walk Speed
        if getgenv().WalkSpeed then
            Player.Character.Humanoid.WalkSpeed = getgenv().WalkSpeed
        end
        
        -- Inf Stamina
        if getgenv().InfStamina then
            local humanoid = Player.Character.Humanoid
            humanoid:ChangeState(Enum.HumanoidStateType.Physics)
        end
    end
end)

-- CharAdded Persistence
Player.CharacterAdded:Connect(function()
    task.wait(5)
    if getgenv().FlyEnabled then FlyLogic() end
end)

-- CLEAR DELTA CACHE (Optional)
pcall(function()
    game:GetService("CoreGui"):ClearAllChildren()
end)

print("🔴 CRYPTA EMPIRE v5.6 LOADED | REDZ HUB GUI CLONE | MOHAM-MADEX12")
Kavo:Notify("YOUR DREAM IS ALIVE! 🔥 CRYPTA v5.6 BULLETPROOF LOADED", 5)
