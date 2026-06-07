-- ts file was generated at discord.gg/25ms

local Players = game:GetService('Players')
local TweenService = game:GetService('TweenService')
local RunService = game:GetService('RunService')

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild('Humanoid')
local HumanoidRootPart = Character:WaitForChild('HumanoidRootPart')

local HeavyAttackAnims = {
    ['10503381238'] = true,
    ['13379003796'] = true,
}

local SpecialAttackAnims = {
    ['10479335397'] = true,
    ['13380255751'] = true,
}

local AlignPosition = nil
local AlignOrientation = nil
local RenderConnection = nil
local FollowPart = nil
local IsActive = false
local FollowRange = 10
local IsCooldown = false

-- GUI
local ScreenGui = Instance.new('ScreenGui', LocalPlayer:WaitForChild('PlayerGui'))
ScreenGui.Name = 'AutoFollowToggle'
ScreenGui.ResetOnSpawn = false

local ToggleButton = Instance.new('TextButton')
ToggleButton.Size = UDim2.new(0, 100, 0, 20)
ToggleButton.Position = UDim2.new(0, 100, 0, 50)
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleButton.Text = 'Kiba Tech V3: OFF'
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextScaled = true
ToggleButton.Active = true
ToggleButton.Draggable = true
ToggleButton.Parent = ScreenGui
Instance.new('UICorner', ToggleButton).CornerRadius = UDim.new(0, 12)

local UIGradient = Instance.new('UIGradient', ToggleButton)
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0,   Color3.fromRGB(255, 0,   0)),
    ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 127, 0)),
    ColorSequenceKeypoint.new(0.4, Color3.fromRGB(0,   255, 0)),
    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0,   0,   255)),
    ColorSequenceKeypoint.new(0.8, Color3.fromRGB(148, 0,   211)),
    ColorSequenceKeypoint.new(1,   Color3.fromRGB(255, 0,   0)),
})
UIGradient.Rotation = 10

local UIStroke = Instance.new('UIStroke', ToggleButton)
UIStroke.Thickness = 1

-- Rainbow stroke animation
task.spawn(function()
    local hue = 0
    while task.wait(0.15) do
        hue = (hue + 1) % 360
        UIStroke.Color = Color3.fromHSV(hue / 360, 1, 1)
    end
end)

-- Loading bar + effects when skill activates
local function PlayActivationEffect(duration)
    IsCooldown = true

    local BarContainer = Instance.new('Frame')
    BarContainer.Size = UDim2.new(0, 180, 0, 18)
    BarContainer.Position = UDim2.new(0.5, -90, 0.4, 80)
    BarContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    BarContainer.Transparency = 1
    BarContainer.BorderSizePixel = 0
    BarContainer.Parent = ScreenGui
    Instance.new('UICorner', BarContainer).CornerRadius = UDim.new(0, 10)

    local BarFill = Instance.new('Frame')
    BarFill.Size = UDim2.new(0, 0, 1, 0)
    BarFill.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    BarFill.BorderSizePixel = 0
    BarFill.Parent = BarContainer
    Instance.new('UICorner', BarFill).CornerRadius = UDim.new(0, 10)

    local BarLabel = Instance.new('TextLabel')
    BarLabel.Size = UDim2.new(1, 0, 1, 0)
    BarLabel.BackgroundTransparency = 1
    BarLabel.Text = 'Kiba Tech V3...'
    BarLabel.TextColor3 = Color3.new(1, 1, 1)
    BarLabel.Font = Enum.Font.GothamBold
    BarLabel.TextScaled = true
    BarLabel.Parent = BarContainer

    local Highlight = Instance.new('Highlight')
    Highlight.Parent = Character
    Highlight.FillTransparency = 0.3
    Highlight.OutlineTransparency = 0.1

    local RainbowColors = {
        Color3.fromRGB(255, 0,   0),
        Color3.fromRGB(255, 127, 0),
        Color3.fromRGB(255, 255, 0),
        Color3.fromRGB(0,   255, 0),
        Color3.fromRGB(0,   0,   255),
        Color3.fromRGB(75,  0,   130),
        Color3.fromRGB(148, 0,   211),
    }
    local HighlightRunning = true

    task.spawn(function()
        local colorIndex = 1
        while HighlightRunning and Highlight.Parent do
            Highlight.FillColor    = RainbowColors[colorIndex]
            Highlight.OutlineColor = RainbowColors[colorIndex % #RainbowColors + 1]
            colorIndex = colorIndex % #RainbowColors + 1
            task.wait(0.2)
        end
    end)

    local ParticleEmitter = Instance.new('ParticleEmitter')
    ParticleEmitter.Texture  = 'rbxassetid://243660364'
    ParticleEmitter.Rate     = 6
    ParticleEmitter.Lifetime = NumberRange.new(1.2, 1.6)
    ParticleEmitter.Speed    = NumberRange.new(0, 0)
    ParticleEmitter.Rotation = NumberRange.new(0, 360)
    ParticleEmitter.Size = NumberSequence.new({
        NumberSequenceKeypoint.new(0,   2),
        NumberSequenceKeypoint.new(0.5, 6),
        NumberSequenceKeypoint.new(1,   10),
    })
    ParticleEmitter.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.3),
        NumberSequenceKeypoint.new(1, 1),
    })
    ParticleEmitter.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0,   255, 255)),
    })
    ParticleEmitter.LightEmission = 0.6
    ParticleEmitter.Parent = HumanoidRootPart

    TweenService:Create(BarFill, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
        Size = UDim2.new(1, 0, 1, 0),
    }):Play()

    task.delay(duration, function()
        IsCooldown = false
        BarContainer:Destroy()
        HighlightRunning = false
        if Highlight    then Highlight:Destroy()       end
        if ParticleEmitter then ParticleEmitter:Destroy() end
    end)
end

-- Cleanup align constraints and snap marker
local function CleanupFollow()
    if AlignPosition  then AlignPosition:Destroy()   end
    if AlignOrientation then AlignOrientation:Destroy() end
    if RenderConnection then RenderConnection:Disconnect() end
    if FollowPart     then FollowPart:Destroy()      end

    for _, child in ipairs(HumanoidRootPart:GetChildren()) do
        if child:IsA('Attachment') or child.Name == 'HasSnapped' then
            child:Destroy()
        end
    end
end

-- Set up AlignPosition + AlignOrientation to follow a target
local function StartFollow(TargetRoot)
    CleanupFollow()

    FollowPart = Instance.new('Part')
    FollowPart.Size        = Vector3.new(0.5, 0.5, 0.5)
    FollowPart.Transparency = 1
    FollowPart.Anchored    = true
    FollowPart.CanCollide  = false
    FollowPart.Name        = 'FollowPart'
    FollowPart.Parent      = workspace

    local Attach0 = Instance.new('Attachment', HumanoidRootPart)
    local Attach1 = Instance.new('Attachment', FollowPart)
    local Attach2 = Instance.new('Attachment', HumanoidRootPart)
    local Attach3 = Instance.new('Attachment', FollowPart)

    AlignPosition = Instance.new('AlignPosition')
    AlignPosition.Attachment0     = Attach0
    AlignPosition.Attachment1     = Attach1
    AlignPosition.RigidityEnabled = true
    AlignPosition.Responsiveness  = 200
    AlignPosition.MaxForce        = math.huge
    AlignPosition.Parent          = HumanoidRootPart

    AlignOrientation = Instance.new('AlignOrientation')
    AlignOrientation.Attachment0     = Attach2
    AlignOrientation.Attachment1     = Attach3
    AlignOrientation.RigidityEnabled = true
    AlignOrientation.Responsiveness  = 100
    AlignOrientation.MaxTorque       = math.huge
    AlignOrientation.Parent          = HumanoidRootPart

    RenderConnection = RunService.RenderStepped:Connect(function()
        if TargetRoot and TargetRoot.Parent then
            local TargetCFrame = TargetRoot.CFrame * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(55), 0, 0)
            FollowPart.CFrame = TargetCFrame

            if not HumanoidRootPart:FindFirstChild('HasSnapped') then
                HumanoidRootPart.CFrame = TargetCFrame

                local SnapMarker = Instance.new('BoolValue')
                SnapMarker.Name   = 'HasSnapped'
                SnapMarker.Parent = HumanoidRootPart
            end
        end
    end)
end

-- Find nearest valid target in workspace.Live
local function FindNearestTarget()
    local closestDist = FollowRange
    local closestRoot = nil

    for _, model in pairs(workspace.Live:GetChildren()) do
        if model:IsA('Model') and model ~= Character then
            local targetRoot = model:FindFirstChild('HumanoidRootPart')
            local targetHumanoid = model:FindFirstChildOfClass('Humanoid')

            if targetRoot and targetHumanoid and targetHumanoid.Health > 0 then
                local dist = (targetRoot.Position - HumanoidRootPart.Position).Magnitude

                if dist <= closestDist then
                    if model.Name == 'Weakest Dummy' then
                        closestRoot = targetRoot
                        closestDist = dist
                    elseif Players:GetPlayerFromCharacter(model) then
                        closestRoot = targetRoot
                        closestDist = dist
                    end
                end
            end
        end
    end

    return closestRoot
end

-- Handle animation events
local function OnAnimationPlayed(animTrack)
    if IsActive and not IsCooldown then
        local animId = string.match(animTrack.Animation.AnimationId, '%d+')

        if SpecialAttackAnims[animId] then
            IsCooldown = true
            task.delay(0.8, function()
                PlayActivationEffect(4.6)
            end)

        elseif HeavyAttackAnims[animId] then
            IsCooldown = true

            task.delay(0.32, function()
                local inputPayload = {
                    {
                        Dash = Enum.KeyCode.W,
                        Key  = Enum.KeyCode.Q,
                        Goal = 'KeyPress',
                    },
                }

                pcall(function()
                    LocalPlayer.Character:WaitForChild('Communicate'):FireServer(unpack(inputPayload))
                end)

                local nearestRoot = FindNearestTarget()
                if nearestRoot then
                    StartFollow(nearestRoot)
                    task.delay(0.5, CleanupFollow)
                end
            end)

            task.delay(0.8, function()
                PlayActivationEffect(4.6)
            end)
        end
    end
end

-- Re-grab references after respawn
local function SetupCharacter()
    Character       = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    Humanoid        = Character:WaitForChild('Humanoid')
    HumanoidRootPart = Character:WaitForChild('HumanoidRootPart')

    Humanoid.AnimationPlayed:Connect(OnAnimationPlayed)
end

-- Init
SetupCharacter()

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.1)
    SetupCharacter()
end)

ToggleButton.MouseButton1Click:Connect(function()
    IsActive = not IsActive
    ToggleButton.Text = IsActive and 'Kiba Tech V3: ON' or 'Kiba Tech V3: OFF'
end)
