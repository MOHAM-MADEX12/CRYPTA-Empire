-- REDZ HUB | CRYPTA v5.8 CANDY EGG FIXED | MOHAM-MADEX12 | Delta Ready
local Players,RunService,UserInputService,TeleportService,ReplicatedStorage,Workspace,Camera=game:GetService("Players"),game:GetService("RunService"),game:GetService("UserInputService"),game:GetService("TeleportService"),game:GetService("ReplicatedStorage"),game:GetService("Workspace"),workspace.CurrentCamera
local LocalPlayer=Players.LocalPlayer
getgenv().CRYPTA_LOADED=true

local function httpGet(u)return game:HttpGet(u:gsub("https://","http://"))end

local Library=loadstring(httpGet("http://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window=Library.CreateLib("REDZ HUB | CRYPTA v5.8","BloodTheme")
local Watermark=Library:CreateWatermark("REDZ HUB | CRYPTA v5.8 CANDY EGG | MOHAM-MADEX12")

local SeaTPs={"Sea1","Sea2","Sea3","Sea1_1","Sea1_2","Sea2_1","Sea2_2","Sea2_3","Sea3_1","Sea3_2","Sea3_3","Sea3_4","Sea3_5","Sea3_6","Sea3_7","Sea3_8","Sea3_9","Sea3_10","Sea3_11","Sea3_12","Sea3_13","Sea3_14","Sea3_15","Sea3_16","Sea3_17","Sea3_18"}

local Main=Window:NewTab("Main")
local stat="Melee"
Main:NewDropdown("Stat",nil,{"Melee","Defense","Sword","Gun","Demon Fruit","Bloom","Observation"},function(s)stat=s end)
Main:NewToggle("Max Stats",nil,function(a)getgenv().MaxStats=a;if a then task.spawn(function()while getgenv().MaxStats do pcall(function()for i=1,5 do ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint",stat,1000)task.wait(0.15)end end)task.wait(1)end end)end end)
Main:NewButton("Rejoin",nil,function()TeleportService:Teleport(game.PlaceId)end)
Main:NewButton("Server Hop",nil,function()loadstring(httpGet("http://raw.githubusercontent.com/EdgeIY/infiniteyield/master/serverhop.lua"))()end)

local Farm=Window:NewTab("Farm")
Farm:NewToggle("Auto Farm",nil,function(a)getgenv().AutoFarm=a end)
Farm:NewSlider("Distance","500",500,50,function(s)getgenv().FarmDistance=s end)

local Combat=Window:NewTab("Combat")
Combat:NewToggle("ESP",nil,function()loadstring(httpGet("http://raw.githubusercontent.com/skatbr/A_simple_esp.lua/main/A_simple_esp.lua"))()end)
Combat:NewToggle("Inf Stamina",nil,function(a)getgenv().InfStamina=a end)
Combat:NewSlider("Walkspeed","16",16,200,function(s)getgenv().Walkspeed=s end)

local flyEnabled,flySpeed,bv,bav=false,100
Combat:NewToggle("Mobile Fly",nil,function(a)
    flyEnabled=a
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")then
        local h=LocalPlayer.Character.HumanoidRootPart
        if a then
            bv=Instance.new("BodyVelocity",h)bv.MaxForce=Vector3.new(4000,4000,4000)
            bav=Instance.new("BodyAngularVelocity",h)bav.MaxTorque=Vector3.new(4000,4000,4000)
            RunService.Heartbeat:Connect(function()
                if flyEnabled then
                    local v=Camera.CFrame.LookVector*flySpeed
                    bv.Velocity=Vector3.new(v.X,UserInputService:IsKeyDown(Enum.KeyCode.Space)and flySpeed or UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)and-flySpeed or 0,v.Z)
                end
            end)
        else if bv then bv:Destroy()end if bav then bav:Destroy()end end
    end
end)
Combat:NewSlider("Fly Speed","100",100,1,function(s)flySpeed=s end)

local Misc=Window:NewTab("Misc")
Misc:NewDropdown("Sea TP",nil,SeaTPs,function(s)pcall(function()ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSea",s)end)end)
Misc:NewButton("Destroy GUI",nil,function()Library:Destroy()end)

RunService.Heartbeat:Connect(function()
    pcall(function()
        local c=LocalPlayer.Character
        if c and c:FindFirstChild("HumanoidRootPart")and c:FindFirstChild("Humanoid")then
            local h=c.HumanoidRootPart
            local hu=c.Humanoid
            if getgenv().AutoFarm then
                local n,d=nil,getgenv().FarmDistance or 500
                for _,v in pairs(Workspace.Enemies:GetChildren())do
                    if v:FindFirstChild("HumanoidRootPart")then
                        local dist=(h.Position-v.HumanoidRootPart.Position).Magnitude
                        if dist<d then d=dist n=v end
                    end
                end
                if n then
                    h.CFrame=n.HumanoidRootPart.CFrame*CFrame.new(0,5,0)
                    task.wait(0.1)
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest",n.Name,1)
                end
            end
            if getgenv().InfStamina then hu:ChangeState(11)end
            if getgenv().Walkspeed then hu.WalkSpeed=getgenv().Walkspeed end
        end
    end)
end)

print("REDZ HUB | CRYPTA v5.8 CANDY EGG FIXED LOADED!")
