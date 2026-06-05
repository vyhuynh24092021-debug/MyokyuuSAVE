local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local cloneref = cloneref or function(f) return f end
local LocalPlayer = Players.LocalPlayer

local Library = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local Window = Library:CreateWindow({
    Name = "Zenith Hub",
    LoadingTitle = "Zenith Hub",
    LoadingSubtitle = "by @cakisbetter",
    ConfigurationSaving = { Enabled = true, FolderName = "Zenith Hub", FileName = "Config" },
    Discord = { Enabled = true, Invite = "Zenith", RememberJoins = true },
    KeySystem = false,
})

local MainTab = Window:CreateTab("Main", 4483362458)
local PlayerTab = Window:CreateTab("Player", 4483345998)
local MiscTab = Window:CreateTab("Misc", 4483362458)
local SettingTab = Window:CreateTab("UI Settings", 4483373537)

local IsCourtsGame = workspace:WaitForChild("Game"):FindFirstChild("Courts") ~= nil
local VisualGui = LocalPlayer.PlayerGui:WaitForChild("Visual")
local ShootingGui = VisualGui:WaitForChild("Shooting")
local ShootRemote = ReplicatedStorage.Packages.Knit.Services.ControlService.RE.Shoot

local AutoShootEnabled = false
local AutoGuardEnabled = false
local AutoReboundSteal = false
local FollowBallCarrierEnabled = false
local StealReachEnabled = false
local SpeedBoostEnabled = false
local BallMagnetEnabled = false
local AnimationSpoofEnabled = false

local SpeedAmount = 16
local PredictionTime = 3
local GuardDistance = 10
local ShotTimingValue = 0.8
local ReachMultiplier = 2
local MagnetDistance = 30
local TargetDistanceLimit = 10

local GuardConnection = nil
local PostAimbotConnection = nil
local SpeedBoostConnection = nil
local FollowConnection = nil
local AutoStealConnection = nil

local PositionHistory = {}
local TargetOffset = -10
local OriginalRightSize, OriginalLeftSize
local LastPostTrack = 0

local function GetPlayerFromCharacter(char)
    for _, ply in ipairs(Players:GetPlayers()) do
        if ply.Character == char then return ply end
    end
    return nil
end

local function IsEnemy(char)
    local targetPly = GetPlayerFromCharacter(char)
    if not targetPly then return false end
    if not LocalPlayer.Team or not targetPly.Team then
        return targetPly ~= LocalPlayer
    end
    return LocalPlayer.Team ~= targetPly.Team
end

local function GetBallCarrier()
    for _, model in ipairs(workspace:GetChildren()) do
        if model:IsA("Model") and model ~= LocalPlayer.Character then
            local hrp = model:FindFirstChild("HumanoidRootPart")
            local ball = model:FindFirstChild("Basketball")
            if hrp and ball and ball:IsA("Tool") and IsEnemy(model) then
                return model, hrp
            end
        end
    end

    local looseBall = workspace:FindFirstChild("Basketball")
    if looseBall and looseBall:IsA("BasePart") then
        local closestEnemy, closestHrp = nil, nil
        local shortestDist = 15
        for _, model in ipairs(workspace:GetChildren()) do
            if model:IsA("Model") and model ~= LocalPlayer.Character and IsEnemy(model) then
                local hrp = model:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local dist = (hrp.Position - looseBall.Position).Magnitude
                    if dist < shortestDist then
                        shortestDist = dist
                        closestEnemy = model
                        closestHrp = hrp
                    end
                end
            end
        end
        return closestEnemy, closestHrp
    end
    return nil, nil
end

local function GetClosestEnemy()
    local char = LocalPlayer.Character
    if not char then return nil end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end

    local closestHrp = nil
    local shortestDist = TargetDistanceLimit

    for _, ply in ipairs(Players:GetPlayers()) do
        if ply ~= LocalPlayer and ply.Character then
            local targetHrp = ply.Character:FindFirstChild("HumanoidRootPart")
            if targetHrp and IsEnemy(ply.Character) then
                local dist = (hrp.Position - targetHrp.Position).Magnitude
                if dist < shortestDist then
                    shortestDist = dist
                    closestHrp = targetHrp
                end
            end
        end
    end
    return closestHrp
end

local function LocalPlayerHasBall()
    local char = LocalPlayer.Character
    return char and char:FindFirstChild("Basketball") and char.Basketball:IsA("Tool")
end

local function GetBallSide()
    local char = LocalPlayer.Character
    if not char then return "right" end
    local ball = char:FindFirstChild("Basketball")
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if ball and ball:IsA("Tool") and hrp then
        local handle = ball:FindFirstChild("Handle")
        if handle then
            return hrp.CFrame:ToObjectSpace(handle.CFrame).X > 0 and "right" or "left"
        end
    end
    return "right"
end

local function ProcessPostAimbot()
    if tick() - LastPostTrack < 0.033 then return end
    LastPostTrack = tick()

    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local targetHrp = GetClosestEnemy()
    if targetHrp then
        local lookCF = CFrame.new(hrp.Position, Vector3.new(targetHrp.Position.X, hrp.Position.Y, targetHrp.Position.Z))
        hrp.CFrame = lookCF * CFrame.Angles(0, math.rad(GetBallSide() == "left" and 90 or -90), 0)
    end
end

local function ProcessAutoGuard()
    local char = LocalPlayer.Character
    if not char or LocalPlayerHasBall() then
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
        return
    end

    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end

    local carrierChar, carrierHrp = GetBallCarrier()
    if carrierChar and carrierHrp then
        local currentPos = carrierHrp.Position
        local vel = PositionHistory[carrierChar] and (currentPos - PositionHistory[carrierChar]) / 0.033 or Vector3.new()
        PositionHistory[carrierChar] = currentPos

        local predictedPos = currentPos + (vel * (PredictionTime * 0.1))
        local dist = (hrp.Position - currentPos).Magnitude

        if dist <= GuardDistance then
            local destination = predictedPos - (predictedPos - hrp.Position).Unit * 5
            hum:MoveTo(Vector3.new(destination.X, hrp.Position.Y, destination.Z))
            VirtualInputManager:SendKeyEvent(dist <= 10, Enum.KeyCode.F, false, game)
        else
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
        end
    else
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
    end
end

local function ToggleFollowCarrier(state)
    if state then
        if FollowConnection then return end
        FollowConnection = RunService.Heartbeat:Connect(function()
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local _, carrierHrp = GetBallCarrier()
            if hrp and carrierHrp then
                hrp.CFrame = carrierHrp.CFrame * CFrame.new(0, 0, TargetOffset)
            end
        end)
    else
        if FollowConnection then FollowConnection:Disconnect(); FollowConnection = nil end
    end
end

local function ToggleSpeedBoost(state)
    if state then
        if SpeedBoostConnection then SpeedBoostConnection:Disconnect() end
        SpeedBoostConnection = RunService.RenderStepped:Connect(function(dt)
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hrp and hum and hum.MoveDirection.Magnitude > 0 then
                local extraSpeed = math.max(SpeedAmount - hum.WalkSpeed, 0)
                hrp.CFrame = hrp.CFrame + (hum.MoveDirection.Unit * extraSpeed * dt)
            end
        end)
    else
        if SpeedBoostConnection then SpeedBoostConnection:Disconnect(); SpeedBoostConnection = nil end
    end
end

local function UpdateReach()
    local char = LocalPlayer.Character
    if not char then return end
    local rArm = char:FindFirstChild("Right Arm") or char:FindFirstChild("RightHand") or char:FindFirstChild("RightLowerArm")
    local lArm = char:FindFirstChild("Left Arm") or char:FindFirstChild("LeftHand") or char:FindFirstChild("LeftLowerArm")
    if not rArm or not lArm then return end

    if not OriginalRightSize then OriginalRightSize = rArm.Size end
    if not OriginalLeftSize then OriginalLeftSize = lArm.Size end

    if StealReachEnabled then
        rArm.Size = OriginalRightSize * ReachMultiplier
        lArm.Size = OriginalLeftSize * ReachMultiplier
        rArm.Transparency, lArm.Transparency = 1, 1
        rArm.CanCollide, lArm.CanCollide = false, false
        rArm.Massless, lArm.Massless = true, true
    else
        rArm.Size, lArm.Size = OriginalRightSize, OriginalLeftSize
        rArm.Transparency, lArm.Transparency = 0, 0
        rArm.CanCollide, lArm.CanCollide = false, false
        rArm.Massless, lArm.Massless = false, false
    end
end

local function SetBodyGyroState(state)
    for _, model in ipairs(workspace:GetChildren()) do
        if model:IsA("Model") and model:FindFirstChild("HumanoidRootPart") then
            local hrp = model.HumanoidRootPart
            for _, item in ipairs(hrp:GetDescendants()) do
                if item.Name == "BG" and item:IsA("BodyGyro") then
                    item.Parent = state and hrp or nil
                    if state then
                        item.MaxTorque = Vector3.new(9e10, 9e10, 9e10)
                        item.P, item.D, item.CFrame = 90000, 500, hrp.CFrame
                    end
                end
            end
        end
    end
end

local AnimFolder = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Animations_R15")
local SelectedDunk = "Default"
local SelectedEmote = "Dance_Casual"
local AnimConnections = {}
local ValidEmotes = {}

for name in pairs({
    Default = "Dance_Casual", Dance_Sturdy = "Dance_Sturdy", Dance_Taunt = "Dance_Taunt",
    Dance_TakeFlight = "Dance_TakeFlight", Dance_Flex = "Dance_Flex", Dance_Bat = "Dance_Bat",
    Dance_Twist = "Dance_Twist", Dance_Griddy = "Dance_Griddy", Dance_Dab = "Dance_Dab",
    Dance_Drake = "Dance_Drake", Dance_Fresh = "Dance_Fresh", Dance_Hype = "Dance_Hype",
    Dance_Spongebob = "Dance_Spongebob", Dance_Backflip = "Dance_Backflip", Dance_L = "Dance_L",
    Dance_Facepalm = "Dance_Facepalm", Dance_Bow = "Dance_Bow"
}) do table.insert(ValidEmotes, name) end
table.sort(ValidEmotes)

local function HookAnimator(humanoid)
    local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)
    local conn = animator.AnimationPlayed:Connect(function(track)
        if not AnimationSpoofEnabled then return end
        if track.Animation.Name == "Dunk_Default" and SelectedDunk ~= "Default" then
            track:Stop()
            local asset = AnimFolder:FindFirstChild("Dunk_" .. SelectedDunk)
            if asset then humanoid:LoadAnimation(asset):Play() end
        elseif track.Animation.Name == "Dance_Casual" and SelectedEmote ~= "Dance_Casual" then
            track:Stop()
            local asset = AnimFolder:FindFirstChild(SelectedEmote)
            if asset then humanoid:LoadAnimation(asset):Play() end
        end
    end)
    table.insert(AnimConnections, conn)
end

local function ToggleAnimationSpoof(state)
    for _, c in ipairs(AnimConnections) do c:Disconnect() end
    AnimConnections = {}
    if not state then return end

    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        HookAnimator(LocalPlayer.Character:FindFirstChildOfClass("Humanoid"))
    end
    table.insert(AnimConnections, LocalPlayer.CharacterAdded:Connect(function(char)
        HookAnimator(char:WaitForChild("Humanoid"))
    end))
end

RunService.RenderStepped:Connect(function()
    if StealReachEnabled then UpdateReach() end
    if not BallMagnetEnabled then return end

    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    for _, obj in ipairs(workspace:GetChildren()) do
        if obj.Name == "Basketball" then
            local part = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
            if part and (hrp.Position - part.Position).Magnitude <= MagnetDistance then
                hrp.CFrame = CFrame.new(part.Position + part.CFrame.LookVector * 3)
                break
            end
        end
    end
end)

AutoStealConnection = RunService.Heartbeat:Connect(function()
    if not AutoReboundSteal then return end
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    for _, desc in ipairs(workspace:GetDescendants()) do
        if desc:IsA("BasePart") and desc.Name == "Basketball" then
            if (hrp.Position - desc.Position).Magnitude <= 30 then
                firetouchinterest(hrp, desc, 0)
                firetouchinterest(hrp, desc, 1)
            end
        end
    end
end)

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.G and AutoGuardEnabled then
        if not GuardConnection then GuardConnection = RunService.Heartbeat:Connect(ProcessAutoGuard) end
    elseif input.KeyCode == Enum.KeyCode.P and PostAimbotConnection == nil then
        PostAimbotConnection = RunService.Heartbeat:Connect(ProcessPostAimbot)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.G then
        if GuardConnection then GuardConnection:Disconnect(); GuardConnection = nil end
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
    elseif input.KeyCode == Enum.KeyCode.P then
        if PostAimbotConnection then PostAimbotConnection:Disconnect(); PostAimbotConnection = nil end
    end
end)

MainTab:CreateSection("Auto Shooting")
MainTab:CreateToggle({
    Name = "Auto Time",
    CurrentValue = false,
    Flag = "AutoShoot",
    Callback = function(v)
        AutoShootEnabled = v
        if v then
            ShootingGui:GetPropertyChangedSignal("Visible"):Connect(function()
                if AutoShootEnabled and ShootingGui.Visible then
                    task.wait(0.25)
                    ShootRemote:FireServer(ShotTimingValue)
                end
            end)
        end
    end,
})

MainTab:CreateSlider({
    Name = "Shot Timing", Range = {50, 100}, Increment = 1, CurrentValue = 80, Flag = "ShootTiming",
    Callback = function(v) ShotTimingValue = v / 100 end,
})
MainTab:CreateLabel("Shot Timing: 80=Mediocre | 90=Good | 95=Great | 100=Perfect")

MainTab:CreateSection("Auto Guard")
MainTab:CreateToggle({
    Name = "Auto Guard", CurrentValue = false, Flag = "AutoGuard",
    Callback = function(v)
        AutoGuardEnabled = v
        if not v and GuardConnection then GuardConnection:Disconnect(); GuardConnection = nil end
    end,
})
MainTab:CreateLabel("Hold G to activate (toggle must be enabled)")

MainTab:CreateSlider({
    Name = "Guard Distance", Range = {5, 20}, Increment = 1, CurrentValue = 10, Flag = "GuardDistance",
    Callback = function(v) GuardDistance = v end,
})
MainTab:CreateSlider({
    Name = "Prediction Time", Range = {1, 8}, Increment = 1, CurrentValue = 3, Flag = "PredictionTime",
    Callback = function(v) PredictionTime = v end,
})

MainTab:CreateSection("Auto Rebound & Steal")
MainTab:CreateToggle({
    Name = "Auto Rebound & Steal", CurrentValue = false, Flag = "ReboundAutoSteal",
    Callback = function(v) AutoReboundSteal = v end,
})

MainTab:CreateSection("Follow Ball Carrier")
MainTab:CreateToggle({
    Name = "Follow Ball Carrier", CurrentValue = false, Flag = "FollowBallCarrier",
    Callback = function(v) FollowBallCarrierEnabled = v; ToggleFollowCarrier(v) end,
})
MainTab:CreateSlider({
    Name = "Follow Offset", Range = {-10, 10}, Increment = 1, CurrentValue = -10, Flag = "FollowOffset",
    Callback = function(v) TargetOffset = v end,
})

MainTab:CreateSection("Reach")
MainTab:CreateToggle({
    Name = "Steal Reach", CurrentValue = false, Flag = "StealReach",
    Callback = function(v) StealReachEnabled = v; UpdateReach() end,
})
MainTab:CreateSlider({
    Name = "Steal Reach Multiplier", Range = {1, 20}, Increment = 1, CurrentValue = 2, Flag = "StealReachMultiplier",
    Callback = function(v) ReachMultiplier = v; if StealReachEnabled then UpdateReach() end end,
})

MainTab:CreateSection("Ball Magnet")
MainTab:CreateToggle({
    Name = "Ball Magnet", CurrentValue = false, Flag = "BallMagnet",
    Callback = function(v) BallMagnetEnabled = v end,
})
MainTab:CreateSlider({
    Name = "Magnet Distance", Range = {10, 85}, Increment = 1, CurrentValue = 30, Flag = "BallMagnetDistance",
    Callback = function(v) MagnetDistance = v end,
})

PlayerTab:CreateSection("Speed Boost")
PlayerTab:CreateToggle({
    Name = "Speed Boost", CurrentValue = false, Flag = "SpeedBoost",
    Callback = function(v) SpeedBoostEnabled = v; ToggleSpeedBoost(v) end,
})
PlayerTab:CreateSlider({
    Name = "Speed Amount", Range = {16, 45}, Increment = 1, CurrentValue = 16, Flag = "SpeedAmount",
    Callback = function(v) SpeedAmount = v; if SpeedBoostEnabled then ToggleSpeedBoost(true) end end,
})

MiscTab:CreateSection("Visuals")
MiscTab:CreateToggle({
    Name = "Show BodyGyro", CurrentValue = false, Flag = "ShowBG",
    Callback = function(v) SetBodyGyroState(v) end,
})

MiscTab:CreateSection("Animation Changer")
MiscTab:CreateToggle({
    Name = "Animation Changer", CurrentValue = false, Flag = "AnimationSpoof",
    Callback = function(v) AnimationSpoofEnabled = v; ToggleAnimationSpoof(v) end,
})
MiscTab:CreateDropdown({
    Name = "Dunk Animation", Options = {"Default", "Testing", "Testing2", "Reverse", "360", "Tomahawk", "Windmill"},
    CurrentOption = {"Default"}, Flag = "DunkSpoof", Callback = function(v) SelectedDunk = v[1] end,
})
MiscTab:CreateDropdown({
    Name = "Emote Animation", Options = ValidEmotes, CurrentOption = {"Default"}, Flag = "EmoteSpoof",
    Callback = function(v) SelectedEmote = v[1] end,
})

MiscTab:CreateSection("Server Teleporters")
MiscTab:CreateButton({
    Name = "Rejoin Current Server",
    Callback = function() TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer) end,
})
MiscTab:CreateButton({
    Name = "Server Hop",
    Callback = function()
        local serverList = {}
        local res = pcall(function()
            local raw = game:HttpGet("https://games.roblox.com/v1/games/" .. tostring(game.PlaceId) .. "/servers/Public?sortOrder=Asc&limit=100")
            local data = HttpService:JSONDecode(raw)
            for _, s in pairs(data.data) do
                if s.playing < s.maxPlayers and s.id ~= game.JobId then table.insert(serverList, s) end
            end
        end)
        if res and #serverList > 0 then
            table.sort(serverList, function(a, b) return a.playing < b.playing end)
            TeleportService:TeleportToPlaceInstance(game.PlaceId, serverList[1].id, LocalPlayer)
        else
            Library:Notify({ Title = "Failed", Content = "No other available servers found.", Duration = 3 })
        end
    end,
})

SettingTab:CreateSection("Menu configuration")
SettingTab:CreateButton({
    Name = "Unload Hub",
    Callback = function()
        if GuardConnection then GuardConnection:Disconnect() end
        if PostAimbotConnection then PostAimbotConnection:Disconnect() end
        if SpeedBoostConnection then SpeedBoostConnection:Disconnect() end
        if FollowConnection then FollowConnection:Disconnect() end
        if AutoStealConnection then AutoStealConnection:Disconnect() end
        ToggleAnimationSpoof(false)
        Library:Destroy()
    end,
})