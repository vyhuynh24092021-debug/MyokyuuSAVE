local WindUI = loadstring(gameHttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

WindUIAddTheme({
    Name = My Theme,
    Accent = Color3.fromHex(#FFFFFF),
    Background = Color3.fromHex(#000000),
    Outline = Color3.fromHex(#FFFFFF),
    Text = Color3.fromHex(#FFFFFF),
    Placeholder = Color3.fromHex(#555555),
    Button = Color3.fromHex(#1a1a1a),
    Icon = Color3.fromHex(#FFFFFF),
})

local Window = WindUICreateWindow({
    Title = AT Tech GUI,
    Icon = rbxassetid108649453985291,
    Author = by ThanhDuy,
    Folder = yanaaaaw,
    Background = rbxassetid122086311889987,
    Size = UDim2.fromOffset(580, 460),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),
    Transparent = true,
    Theme = My Theme,
    Resizable = true,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.65,
    HideSearchBar = true,
    ScrollBarEnabled = false,
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
            print(clicked)
        end,
    },
})

WindowEditOpenButton({
    Title = Open AT Tech GUI,
    Icon = rbxassetid108649453985291,
    CornerRadius = UDim.new(0, 16),
    StrokeThickness = 2,
    Color = ColorSequence.new(Color3.fromHex(#FFFFFF), Color3.fromHex(#1a1a1a)),
    OnlyMobile = false,
    Enabled = true,
    Draggable = true,
})

local SoundService = gameGetService(SoundService)
local sound = Instance.new(Sound)
sound.SoundId = rbxassetid4503761646
sound.Volume = 2
sound.Looped = false
sound.Parent = SoundService
soundPlay()

--==================================================
-- CREDIT TAB
--==================================================

local CreditTab = WindowTab({
    Title = Credit,
    Icon = info,
    Locked = false,
})

CreditTabParagraph({
    Title = Dev,
    Text = Tthanh
})

--==================================================
-- AUTO TECH TAB
--==================================================

local AutoTechTab = WindowTab({
    Title = Tech,
    Icon = zap,
    Locked = false,
})

local toggles = {
    AutoKyoto = false,
    HexedTech = false,
    LixTech = false,
    ReflexTech = false,
    OreoTech = false,
    LoopDash = false,
    KibaV5 = false,
    InstantLethal = false,
    SupaTech = false
}

-- Hexed Tech
AutoTechTabToggle({
    Title = Hexed Tech,
    Desc = ,
    Locked = false,
    Default = false,
    Callback = function(state)
        toggles.HexedTech = state
        if state then
            task.spawn(function()
                local vu1 = {rbxassetid10503381238, rbxassetid13379003796}
                local vu2 = 0.32
                local vu3 = 0.25
                local vu4 = 0.35
                local vu10 = gameGetService(Players)
                local vu11 = gameGetService(RunService)
                local vu12 = vu10.LocalPlayer
                local vu9 = nil
                
                local function vu23()
                    local v13 = vu12.Character
                    if not (v13 and v13FindFirstChild(HumanoidRootPart)) then return nil end
                    local v14 = v13.HumanoidRootPart.Position
                    local v15 = nil
                    local v16 = nil
                    local v17 = workspaceFindFirstChild(Live)
                    if v17 then
                        for _, v21 in ipairs(v17GetChildren()) do
                            if v21IsA(Model) and v21FindFirstChild(HumanoidRootPart) and (v21.Name == Weakest Dummy or (vu10GetPlayerFromCharacter(v21) and v21 ~= vu12.Character)) then
                                local v22 = (v21.HumanoidRootPart.Position - v14).Magnitude
                                if not v16 or v22  v16 then
                                    v16 = v22
                                    v15 = v21
                                end
                            end
                        end
                    end
                    return v15
                end
                
                local function vu34(p24)
                    local vu25 = p24GetDescendants()
                    for _, v29 in ipairs(vu25) do
                        if v29IsA(BasePart) then v29.CanCollide = false end
                    end
                    task.delay(1.2, function()
                        for _, v33 in ipairs(vu25) do
                            if v33IsA(BasePart) then v33.CanCollide = true end
                        end
                    end)
                end
                
                local function vu49()
                    if vu9 then vu9Disconnect() end
                    local vu35 = vu12.Character or vu12.CharacterAddedWait()
                    vu9 = vu35WaitForChild(Humanoid).AnimationPlayedConnect(function(p37)
                        local v38 = p37.Animation
                        if v38 and table.find(vu1, v38.AnimationId) then
                            vu34(vu35)
                            task.wait(vu2)
                            local v39 = {{Dash = Enum.KeyCode.W, Key = Enum.KeyCode.Q, Goal = KeyPress}}
                            local v40 = vu35FindFirstChild(Communicate)
                            if v40 then v40FireServer(unpack(v39)) end
                            task.wait(vu3)
                            local vu41 = vu35FindFirstChild(HumanoidRootPart)
                            if vu41 then
                                local vu42 = Instance.new(Attachment)
                                vu42.Name = Lix_Att
                                vu42.Parent = vu41
                                local vu43 = Instance.new(AlignOrientation)
                                vu43.Mode = Enum.OrientationAlignmentMode.OneAttachment
                                vu43.Attachment0 = vu42
                                vu43.MaxTorque = math.huge
                                vu43.Responsiveness = 1000
                                vu43.RigidityEnabled = false
                                vu43.Parent = vu41
                                local vu44 = tick()
                                local vu45 = nil
                                vu45 = vu11.HeartbeatConnect(function()
                                    if vu4 = tick() - vu44 then
                                        local v46 = vu23()
                                        if v46 and v46FindFirstChild(HumanoidRootPart) then
                                            local v47 = v46.HumanoidRootPart.Position
                                            local v48 = CFrame.lookAt(vu41.Position, Vector3.new(v47.X, vu41.Position.Y, v47.Z))  CFrame.Angles(math.rad(30), 100, -100)
                                            vu41.CFrame = v48
                                            vu43.CFrame = v48
                                        end
                                    else
                                        vu45Disconnect()
                                        vu43Destroy()
                                        vu42Destroy()
                                    end
                                end)
                            end
                        end
                    end)
                end
                vu49()
                while toggles.HexedTech do task.wait(1) end
                if vu9 then vu9Disconnect() end
            end)
        end
    end
})

-- Lix Tech
AutoTechTabToggle({
    Title = Lix Tech,
    Desc = ,
    Locked = false,
    Default = false,
    Callback = function(state)
        toggles.LixTech = state
        if state then
            task.spawn(function()
                local v1 = gameGetService(Players).LocalPlayer
                local vu5 = 0.3
                local vu6 = 0.05
                local vu7 = 0.05
                local vu8 = 2
                local vu9 = false
                local vu10 = false
                local vu11 = rbxassetid1127797184
                local vu13 = false
                
                local function vu19(p16, p17, p18)
                    if p16  p17 then return p17 elseif p18  p16 then return p18 else return p16 end
                end
                
                local function vu118(p112, p113)
                    if not getnilinstances then return nil end
                    for _, v117 in pairs(getnilinstances()) do
                        if v117 and v117.ClassName == p113 and v117.Name == p112 then return v117 end
                    end
                    return nil
                end
                
                local vu119 = v1.Character or v1.CharacterAddedWait()
                local vu120 = vu119FindFirstChildOfClass(Humanoid)
                local vu121 = vu119FindFirstChild(HumanoidRootPart)
                
                local function vu123(p122)
                    return p122 and {WalkSpeed = p122.WalkSpeed, JumpPower = p122.JumpPower, PlatformStand = p122.PlatformStand, AutoRotate = p122.AutoRotate}
                        or {WalkSpeed = 16, JumpPower = 50, PlatformStand = false, AutoRotate = true}
                end
                local vu124 = vu123(vu120)
                
                local function vu134(pu125)
                    if vu9 and not vu10 then
                        if pu125 and pu125.Animation then
                            local v128 = tonumber(pu125.Animation.AnimationIdmatch(%d+))
                            if v128 == 13379003796 or v128 == 10503381238 then
                                vu10 = true
                                vu120 = vu119 and vu119FindFirstChildOfClass(Humanoid) or vu120
                                vu121 = vu119 and vu119FindFirstChild(HumanoidRootPart) or vu121
                                local vu129 = vu123(vu120)
                                task.wait(vu5)
                                local vu130 = {{Dash = Enum.KeyCode.W, Key = Enum.KeyCode.Q, Goal = KeyPress}}
                                if vu119 and vu119FindFirstChild(Communicate) then
                                    pcall(function() vu119.CommunicateFireServer(table.unpack(vu130)) end)
                                end
                                local vu131 = vu118(moveme, BodyVelocity)
                                local vu132
                                if vu131 then vu132 = vu131.Parent pcall(function() vu131.Parent = nil end) end
                                local vu133 = {{Goal = delete bv, BV = vu131}}
                                if vu119 and vu119FindFirstChild(Communicate) then
                                    pcall(function() vu119.CommunicateFireServer(table.unpack(vu133)) end)
                                end
                                task.wait(0.3)
                                if vu121 then pcall(function() vu121.CFrame = vu121.CFrame  CFrame.Angles(0, math.rad(180), 0) end) end
                                if vu131 and vu132 then pcall(function() vu131.Parent = vu132 end) end
                                if vu120 then pcall(function() vu120.WalkSpeed = vu129.WalkSpeed or 16 vu120.JumpPower = vu129.JumpPower or 50 vu120.PlatformStand = vu129.PlatformStand or false vu120.AutoRotate = vu129.AutoRotate or true end) end
                                task.wait(0.4)
                                vu121 = vu119 and vu119FindFirstChild(HumanoidRootPart) or vu121
                                if vu121 then pcall(function() vu121.CFrame = vu121.CFrame  CFrame.Angles(0, math.rad(180), 0) end) end
                                task.wait(0.15)
                                vu10 = false
                            end
                        end
                    end
                end
                
                local function vu136(p135)
                    vu119 = p135
                    vu120 = vu119FindFirstChildOfClass(Humanoid)
                    vu121 = vu119FindFirstChild(HumanoidRootPart)
                    vu124 = vu123(vu120)
                    if vu120 then vu120.AnimationPlayedConnect(vu134) end
                end
                
                if v1.Character then vu136(v1.Character) end
                v1.CharacterAddedConnect(vu136)
                vu9 = true
                while toggles.LixTech do task.wait(1) end
                vu9 = false
            end)
        end
    end
})

-- Oreo Tech
AutoTechTabToggle({
    Title = Oreo Tech,
    Desc = ,
    Locked = false,
    Default = false,
    Callback = function(state)
        toggles.OreoTech = state
        if state then
            task.spawn(function()
                local vu4 = gameGetService(Players).LocalPlayer
                local vu5 = workspace.CurrentCamera
                local vu6 = {rbxassetid10503381238, rbxassetid13379003796}
                local vu7 = false
                local vu8 = true
                local vu9 = 5
                local vu10 = nil
                local vu11 = (vu4.Character or vu4.CharacterAddedWait())WaitForChild(HumanoidRootPart)
                
                local function vu16()
                    local v12 = vu4.Character or vu4.CharacterAddedWait()
                    local v13 = v12WaitForChild(HumanoidRootPart)
                    v12WaitForChild(Humanoid).AutoRotate = false
                    local v14 = v13.CFrame  CFrame.Angles(0, math.rad(180), 0)
                    v13.CFrame = v14
                    local v15 = (vu5.CFrame.Position - v14.Position).Magnitude
                    vu5.CFrame = CFrame.new(v14.Position - v14.LookVector  v15 + Vector3.new(0, 2), v14.Position)
                end
                
                local function vu17()
                    (vu4.Character or vu4.CharacterAddedWait())WaitForChild(HumanoidRootPart).AssemblyLinearVelocity = Vector3.new(0, 57, 0)
                end
                
                vu7 = true
                vu10 = (vu4.Character or vu4.CharacterAddedWait())WaitForChild(Humanoid).AnimationPlayedConnect(function(p19)
                    if not vu8 then return end
                    for _, v23 in ipairs(vu6) do
                        if p19.Animation.AnimationId == v23 then
                            vu8 = false
                            task.spawn(function()
                                task.wait(0.421)
                                vu17()
                                task.wait(0.13)
                                local v24 = {{Dash = Enum.KeyCode.W, Key = Enum.KeyCode.Q, Goal = KeyPress}}
                                local v25 = vu4.CharacterFindFirstChild(Communicate)
                                if v25 then v25FireServer(unpack(v24)) end
                                vu16()
                                task.wait(0.16)
                                vu16()
                                local v26 = vu11.CFrame.LookVector.Unit
                                vu11.CFrame = vu11.CFrame + v26  3.5
                            end)
                            task.delay(vu9, function() vu8 = true end)
                            break
                        end
                    end
                end)
                while toggles.OreoTech do task.wait(1) end
                if vu10 then vu10Disconnect() end
                vu7 = false
            end)
        end
    end
})

-- LoopDash
AutoTechTabToggle({
    Title = LoopDash,
    Desc = ,
    Locked = false,
    Default = false,
    Callback = function(state)
        toggles.LoopDash = state
        if state then
            task.spawn(function()
                local v_u_1_ = gameGetService(Players)
                local v_u_2_ = v_u_1_.LocalPlayer
                local v_u_3_ = gameGetService(RunService)
                local v_u_5_ = gameGetService(Workspace)
                local v_u_9_ = {loopReworkAnimDetectId = 10503381238, loopReworkBlockAnimId = 10471478869}
                local v_u_11_ = {loopRework = true, loopReworkDebounce = false, loopReworkWaitDetect = 3, loopReworkWaitJump = 0, loopReworkWaitRemote = 1, loopReworkLockDuration = 15, loopReworkTargetRadius = 50, loopReworkCooldown = 10, loopReworkResponsiveness = 483, ForceJumpUpwardVelocity = 62}
                local v_u_50_ = {}
                local v_u_51_ = nil
                
                local function v_u_59_()
                    local v56_ = v_u_2_.Character
                    if v56_ then
                        local v57_ = v56_FindFirstChildOfClass(Humanoid)
                        local v58_ = v56_FindFirstChild(HumanoidRootPart)
                        if v57_ and v58_ then return v56_, v57_, v58_ end
                    end
                    return nil
                end
                
                function loopReworkFireDashQW()
                    local v60_ = v_u_2_.Character
                    if v60_ then
                        local v_u_61_ = v60_FindFirstChild(Communicate)
                        if v_u_61_ then
                            pcall(function() v_u_61_FireServer(unpack({{Dash = Enum.KeyCode.W, Key = Enum.KeyCode.Q, Goal = KeyPress}})) end)
                        end
                    end
                end
                
                function loopReworkFindBestTarget(p63_)
                    local v64_ = p63_ or v_u_11_.loopReworkTargetRadius
                    local v65_ = v_u_5_FindFirstChild(Live)
                    if not v65_ then return nil end
                    local _, _, v66_ = v_u_59_()
                    if not v66_ then return nil end
                    local v70_ = nil
                    for _, v71_ in ipairs(v65_GetChildren()) do
                        if v71_ and v71_IsA(Model) and v71_ ~= v_u_2_.Character then
                            local v72_ = v71_FindFirstChild(HumanoidRootPart)
                            local v73_ = v71_FindFirstChildOfClass(Humanoid)
                            if v72_ and v73_ and v73_.Health  0 then
                                local v74_ = (v72_.Position - v66_.Position).Magnitude
                                if v74_ = v64_ then v70_ = v72_ v64_ = v74_ end
                            end
                        end
                    end
                    return v70_
                end
                
                function StartHorizontalLockLerp(p_u_93_, p_u_94_, p95_)
                    if not (p_u_93_ and p_u_93_.Parent) then return nil end
                    local _, v96_, v_u_97_ = v_u_59_()
                    if not (v_u_97_ and v96_) then return nil end
                    local v_u_100_ = tick()
                    local v_u_101_ = v_u_3_.RenderSteppedConnect(function(p102_)
                        if p_u_93_ and p_u_93_.Parent and v_u_97_ and v_u_97_.Parent then
                            local v103_ = v_u_97_.Position
                            local v104_ = Vector3.new(p_u_93_.Position.X, v103_.Y, p_u_93_.Position.Z)
                            if (v104_ - v103_).Magnitude = 0.001 then
                                local v_u_105_ = CFrame.new(v103_, v104_)
                                local alpha = math.clamp(1 - math.exp(-0.02  483  p102_), 0, 1)
                                local v108_ = v_u_97_.CFrameLerp(v_u_105_, alpha)
                                v_u_97_.CFrame = CFrame.new(v103_)  CFrame.fromMatrix(Vector3.new(), v108_.RightVector, v108_.UpVector)
                            end
                            if tick() - v_u_100_ = p_u_94_ then v_u_101_Disconnect() end
                        else v_u_101_Disconnect() end
                    end)
                    return function() if v_u_101_ then pcall(function() v_u_101_Disconnect() end) end end
                end
                
                function loopReworkRunSequence()
                    if v_u_11_.loopReworkDebounce or not v_u_11_.loopRework then return end
                    v_u_11_.loopReworkDebounce = true
                    task.wait(v_u_11_.loopReworkWaitDetect  10)
                    local _, v_u_130_, v_u_131_ = v_u_59_()
                    if v_u_130_ and v_u_131_ then
                        v_u_130_.AutoRotate = false
                        v_u_131_.Velocity = Vector3.new(v_u_131_.Velocity.X, v_u_11_.ForceJumpUpwardVelocity, v_u_131_.Velocity.Z)
                        task.wait(v_u_11_.loopReworkWaitJump  10)
                        loopReworkFireDashQW()
                        task.wait(v_u_11_.loopReworkWaitRemote  10)
                        local target = loopReworkFindBestTarget()
                        if target then v_u_51_ = StartHorizontalLockLerp(target, v_u_11_.loopReworkLockDuration  10, v_u_11_.loopReworkResponsiveness) end
                        local endTime = tick() + (v_u_11_.loopReworkLockDuration  10)
                        task.spawn(function()
                            while tick()  endTime and v_u_11_.loopRework do v_u_130_.AutoRotate = false v_u_3_.HeartbeatWait() end
                            v_u_130_.AutoRotate = true
                        end)
                    end
                    task.wait(v_u_11_.loopReworkCooldown  10)
                    v_u_11_.loopReworkDebounce = false
                end
                
                function loopReworkOnAnimationPlayed(p160_)
                    if v_u_11_.loopRework and not v_u_11_.loopReworkDebounce then
                        local animId = tostring(p160_.Animation.AnimationId)
                        if animIdfind(v_u_9_.loopReworkAnimDetectId) then task.spawn(loopReworkRunSequence) end
                    end
                end
                
                local function ConnectCharacter()
                    local char = v_u_2_.Character or v_u_2_.CharacterAddedWait()
                    local hum = charWaitForChild(Humanoid)
                    if v_u_50_.anim then v_u_50_.animDisconnect() end
                    v_u_50_.anim = hum.AnimationPlayedConnect(loopReworkOnAnimationPlayed)
                end
                
                ConnectCharacter()
                v_u_50_.charAdded = v_u_2_.CharacterAddedConnect(ConnectCharacter)
                while toggles.LoopDash do task.wait(1) end
                if v_u_50_.anim then v_u_50_.animDisconnect() end
                if v_u_50_.charAdded then v_u_50_.charAddedDisconnect() end
                local _, hum = v_u_59_()
                if hum then hum.AutoRotate = true end
                if v_u_51_ then v_u_51_() end
            end)
        end
    end
})

-- Supa Tech
AutoTechTabToggle({
    Title = Supa Tech,
    Desc = ,
    Locked = false,
    Default = false,
    Callback = function(state)
        toggles.SupaTech = state
        if state then
            task.spawn(function()
                local Players = gameGetService(Players)
                local RunService = gameGetService(RunService)
                local LocalPlayer = Players.LocalPlayer
                local currentCharacter = nil
                local currentHumanoid = nil
                local currentRootPart = nil
                local toggleEnabled = true
                local inCooldown = false
                local LEGIT_CONFIG = {DASH_DURATION = 0.15, FOLLOW_OFFSET = 2.5, ANGLE_TILT = math.rad(55), STICK_RANGE = 18, ANIMATION_IDS = {10503381238, 13379003796}}
                
                local function findClosestModelWithRootPart()
                    if not currentRootPart then return nil end
                    local closestModel = nil
                    local smallestDistance = LEGIT_CONFIG.STICK_RANGE
                    for _, descendant in pairs(workspaceGetDescendants()) do
                        if descendantIsA(Model) and descendantFindFirstChild(HumanoidRootPart) and descendant ~= currentCharacter then
                            local distance = (currentRootPart.Position - descendant.HumanoidRootPart.Position).Magnitude
                            if distance  smallestDistance then
                                closestModel = descendant
                                smallestDistance = distance
                            end
                        end
                    end
                    return closestModel
                end
                
                local function performStickDash()
                    if not currentCharacter or not currentHumanoid or not currentRootPart then return end
                    local targetModel = findClosestModelWithRootPart()
                    if not targetModel then return end
                    local targetRoot = targetModelFindFirstChild(HumanoidRootPart)
                    if not targetRoot then return end
                    local saved = {WalkSpeed = currentHumanoid.WalkSpeed, JumpPower = currentHumanoid.JumpPower, PlatformStand = currentHumanoid.PlatformStand, AutoRotate = currentHumanoid.AutoRotate}
                    local hbc = RunService.HeartbeatConnect(function() if currentRootPart then currentRootPart.Velocity = Vector3.zero end if currentHumanoid then currentHumanoid.WalkSpeed = 0 end end)
                    pcall(function() if currentCharacter and currentCharacterFindFirstChild(Communicate) then currentCharacter.CommunicateFireServer(unpack({{Dash = Enum.KeyCode.W, Key = Enum.KeyCode.Q, Goal = KeyPress}})) end end)
                    task.wait(0.2)
                    pcall(function() currentHumanoidChangeState(Enum.HumanoidStateType.Physics) end)
                    currentRootPart.CFrame = currentRootPart.CFrame  CFrame.Angles(LEGIT_CONFIG.ANGLE_TILT, 0, 0)
                    local start = tick()
                    local flw = RunService.HeartbeatConnect(function()
                        if LEGIT_CONFIG.DASH_DURATION  tick() - start then
                            local dir = (targetRoot.Position - currentRootPart.Position).Unit
                            currentRootPart.CFrame = CFrame.new(targetRoot.Position - dir  LEGIT_CONFIG.FOLLOW_OFFSET)  CFrame.Angles(LEGIT_CONFIG.ANGLE_TILT, 0, 0)
                        end
                    end)
                    task.wait(LEGIT_CONFIG.DASH_DURATION)
                    hbcDisconnect()
                    flwDisconnect()
                    pcall(function() currentHumanoidChangeState(Enum.HumanoidStateType.GettingUp) currentHumanoid.WalkSpeed = saved.WalkSpeed currentHumanoid.JumpPower = saved.JumpPower currentHumanoid.AutoRotate = saved.AutoRotate end)
                end
                
                local function handleAnimationPlayed(track)
                    local anim = track.Animation
                    if anim then
                        local id = tostring(anim.AnimationId)
                        for _, val in ipairs(LEGIT_CONFIG.ANIMATION_IDS) do
                            if string.find(id, val) then
                                task.delay(0.3, function()
                                    if toggleEnabled and not inCooldown then
                                        inCooldown = true
                                        task.spawn(performStickDash)
                                        task.wait(4)
                                        inCooldown = false
                                    end
                                end)
                                break
                            end
                        end
                    end
                end
                
                local function onChar(char)
                    currentCharacter = char
                    currentHumanoid = charWaitForChild(Humanoid)
                    currentRootPart = charWaitForChild(HumanoidRootPart)
                    currentHumanoid.AnimationPlayedConnect(handleAnimationPlayed)
                end
                
                LocalPlayer.CharacterAddedConnect(onChar)
                if LocalPlayer.Character then onChar(LocalPlayer.Character) end
                while toggles.SupaLegitV2 do task.wait(1) end
                toggleEnabled = false
            end)
        end
    end
})

--==================================================
-- SAITAMA TAB
--==================================================

local SaitamaTab = WindowTab({
    Title = Auto Tech Saitama,
    Icon = rbxassetid15114667107,
    Locked = false,
})

-- Reflex Tech
SaitamaTabToggle({
    Title = Reflex Tech,
    Desc = ,
    Locked = false,
    Default = false,
    Callback = function(state)
        toggles.ReflexTech = state
        if state then
            task.spawn(function()
                local v1 = game.Players.LocalPlayer
                local vu5 = workspaceWaitForChild(Live)WaitForChild(v1.Name)
                local vu6 = false
                local vu7 = {}
                local vu8 = rbxassetid10471336737
                local vu9 = gameGetService(Players)
                local vu10 = gameGetService(RunService)
                local vu11 = vu9.LocalPlayer
                
                local function vu22()
                    local v12 = vu11.Character
                    if not (v12 and v12FindFirstChild(HumanoidRootPart)) then return nil end
                    local v13 = v12.HumanoidRootPart
                    local v14 = math.huge
                    local v19 = nil
                    for _, v20 in ipairs(vu9GetPlayers()) do
                        if v20 ~= vu11 and v20.Character and v20.CharacterFindFirstChild(HumanoidRootPart) then
                            local v21 = (v13.Position - v20.Character.HumanoidRootPart.Position).Magnitude
                            if v21  v14 then v19 = v20 v14 = v21 end
                        end
                    end
                    return v19
                end
                
                local function vu32()
                    local v23 = vu11.Character or vu11.CharacterAddedWait()
                    local vu24 = v23WaitForChild(Humanoid)
                    local vu25 = v23WaitForChild(HumanoidRootPart)
                    vu24.AutoRotate = false
                    local vu27 = vu24GetPropertyChangedSignal(AutoRotate)Connect(function() if vu24.AutoRotate == true then vu24.AutoRotate = false end end)
                    local vu28 = vu22()
                    if vu28 then
                        local vu29 = tick()
                        local vu30 = nil
                        vu30 = vu10.RenderSteppedConnect(function()
                            if tick() - vu29 = 3 then
                                if vu28.Character and vu28.CharacterFindFirstChild(HumanoidRootPart) then
                                    local v31 = vu28.Character.HumanoidRootPart.Position
                                    vu25.CFrame = CFrame.lookAt(vu25.Position, Vector3.new(v31.X, vu25.Position.Y, v31.Z))
                                end
                            else
                                vu30Disconnect()
                                vu27Disconnect()
                                vu24.AutoRotate = true
                            end
                        end)
                    end
                end
                
                local function vu38()
                    local vu33 = gameGetService(VirtualInputManager)
                    vu33SendKeyEvent(true, Enum.KeyCode.Space, false, game)
                    task.delay(1, function() vu33SendKeyEvent(false, Enum.KeyCode.Space, false, game) end)
                    task.wait(0.29)
                    local v35 = {{Mobile = true, Goal = LeftClick}}
                    game.Players.LocalPlayer.Character.CommunicateFireServer(unpack(v35))
                    task.wait(0.1)
                    task.wait(0.5)
                    local v36 = {{Goal = LeftClickRelease, Mobile = true}}
                    game.Players.LocalPlayer.Character.CommunicateFireServer(unpack(v36))
                    vu32()
                    local v37 = {{Dash = Enum.KeyCode.W, Key = Enum.KeyCode.Q, Goal = KeyPress}}
                    game.Players.LocalPlayer.Character.CommunicateFireServer(unpack(v37))
                end
                
                local function vu50()
                    local v49 = vu5GetAttributeChangedSignal(Combo)Connect(function()
                        if vu5GetAttribute(Combo) == 4 then
                            local vu39 = vu11.Character or vu11.CharacterAddedWait()
                            local v43 = vu39WaitForChild(Humanoid).AnimationPlayedConnect(function(p42)
                                if p42.Animation and p42.Animation.AnimationId == vu8 then vu38(vu39) end
                            end)
                            table.insert(vu7, v43)
                            for _, v48 in ipairs(vu39WaitForChild(Humanoid)GetPlayingAnimationTracks()) do
                                if v48.Animation and v48.Animation.AnimationId == vu8 then vu38(vu39) break end
                            end
                        end
                    end)
                    table.insert(vu7, v49)
                end
                
                vu50()
                while toggles.ReflexTech do task.wait(1) end
                for _, v54 in ipairs(vu7) do v54Disconnect() end
            end)
        end
    end
})

--==================================================
-- GAROU TAB
--==================================================

local GarouTab = WindowTab({
    Title = Auto Tech Garou,
    Icon = rbxassetid15124465439,
    Locked = false,
})

-- Instant Lethal
GarouTabToggle({
    Title = Instant Lethal,
    Desc = ,
    Locked = false,
    Default = false,
    Callback = function(state)
        toggles.InstantLethal = state
        if state then
            task.spawn(function()
                local vu4 = gameGetService(Players).LocalPlayer
                local vu5 = workspace.CurrentCamera
                local vu6 = rbxassetid12296113986
                local vu7 = true
                local vu8 = nil
                local Smoothness = 0.22
                
                local function DoFlick()
                    local char = vu4.Character
                    local root = char and charFindFirstChild(HumanoidRootPart)
                    local hum = char and charFindFirstChild(Humanoid)
                    if root and hum then
                        root.CFrame = root.CFrame  CFrame.Angles(0, math.pi, 0)
                        local x, y, z = vu5.CFrameToEulerAnglesYXZ()
                        vu5.CFrame = CFrame.new(vu5.CFrame.Position)  CFrame.fromEulerAnglesYXZ(x, y + math.pi, z)
                        hum.AutoRotate = false
                        task.delay(0.4, function() if hum then hum.AutoRotate = true end end)
                    end
                end
                
                local function DoJump()
                    local char = vu4.Character
                    local root = char and charFindFirstChild(HumanoidRootPart)
                    if root then root.AssemblyLinearVelocity = Vector3.new(0, 64, 0) end
                end
                
                local function ConnectLogic()
                    if vu8 then vu8Disconnect() end
                    local char = vu4.Character or vu4.CharacterAddedWait()
                    local hum = charWaitForChild(Humanoid)
                    vu8 = hum.AnimationPlayedConnect(function(anim)
                        if vu7 and anim.Animation.AnimationId == vu6 then
                            task.wait(1.72)
                            DoJump()
                            DoFlick()
                            local dashData = {{Dash = Enum.KeyCode.W, Key = Enum.KeyCode.Q, Goal = KeyPress}}
                            if charFindFirstChild(Communicate) then char.CommunicateFireServer(unpack(dashData)) end
                            task.wait(Smoothness)
                            DoFlick()
                        end
                    end)
                end
                
                ConnectLogic()
                while toggles.InstantLethal do task.wait(1) end
                if vu8 then vu8Disconnect() end
            end)
        end
    end
})

-- Auto Kyoto (Garou)
GarouTabToggle({
    Title = Auto Kyoto,
    Desc = ,
    Locked = false,
    Default = false,
    Callback = function(state)
        toggles.GarouAutoKyoto = state
        if state then
            task.spawn(function()
                local v_u_1 = 22.5
                local v_u_4 = 0.6
                local v5 = gameGetService(Players)
                local v_u_6 = gameGetService(VirtualInputManager)
                local v_u_8 = v5.LocalPlayer
                local v_u_9 = 0
                local v_u_11 = true
                
                local function v_u_13() return os.clock() end
                local function v_u_15()
                    local v14 = v_u_8.Character
                    if v14 then return v14FindFirstChild(HumanoidRootPart) else return nil end
                end
                local function v_u_17()
                    if v_u_13() - v_u_9 = v_u_4 then
                        v_u_9 = v_u_13()
                        local v16 = v_u_15()
                        if v16 then
                            v16.CFrame = v16.CFrame + v16.CFrame.LookVector  v_u_1
                            pcall(function()
                                v_u_6SendKeyEvent(true, Enum.KeyCode.Two, false, game)
                                task.wait(0.05)
                                v_u_6SendKeyEvent(false, Enum.KeyCode.Two, false, game)
                            end)
                        end
                    end
                end
                local animId = rbxassetid12273188754
                local delayTime = 1.5
                local connection = nil
                local function setupChar(char)
                    if connection then connectionDisconnect() end
                    local hum = charFindFirstChild(Humanoid)
                    if hum then
                        connection = hum.AnimationPlayedConnect(function(animTrack)
                            if v_u_11 and animTrack.Animation and animTrack.Animation.AnimationId == animId then
                                task.delay(delayTime, function()
                                    if v_u_11 then v_u_17() end
                                end)
                            end
                        end)
                    end
                end
                v_u_8.CharacterAddedConnect(setupChar)
                if v_u_8.Character then setupChar(v_u_8.Character) end
                while toggles.GarouAutoKyoto do task.wait(1) end
                if connection then connectionDisconnect() end
            end)
        end
    end
})