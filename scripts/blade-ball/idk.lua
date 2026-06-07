-- ts file was generated at discord.gg/25ms

setfpscap(165)

local v1 = loadstring(game:HttpGet('https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua'))()
local _ = v1.Options
local v2 = v1:CreateWindow({
    Title = 'DungKee',
    SubTitle = 'Blade Ball | By pulawat6680',
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = 'Dark',
    MinimizeKey = Enum.KeyCode.LeftControl,
})
local v3 = {
    Main = v2:AddTab({
        Title = 'Main',
        Icon = '',
    }),
}
local _Stats = game:GetService('Stats')
local _Players = game:GetService('Players')
local _RunService = game:GetService('RunService')
local _ReplicatedStorage = game:GetService('ReplicatedStorage')
local _LocalPlayer = _Players.LocalPlayer
local _CurrentCamera = workspace.CurrentCamera
local u10 = nil
local u11 = nil

function GetParryRemote()
    local _RemoteEvent = game:GetService('AdService'):FindFirstChildOfClass('RemoteEvent')
    local _RemoteEvent2 = game:GetService('SocialService'):FindFirstChildOfClass('RemoteEvent')

    if _RemoteEvent then
        if _RemoteEvent.Name:find('\n') then
            u11 = _RemoteEvent
        end
    elseif _RemoteEvent2 and _RemoteEvent2.Name:find('\n') then
        u11 = _RemoteEvent2
    end
end
function GetBall()
    local v14, v15, v16 = pairs(workspace:WaitForChild('Balls'):GetChildren())

    while true do
        local v17

        v16, v17 = v14(v15, v16)

        if v16 == nil then
            break
        end
        if v17:IsA('BasePart') and v17:GetAttribute('realBall') then
            return v17
        end
    end
end
function IsAlive(p18)
    local v19 = p18.Character and workspace.Alive:FindFirstChild(p18.Name)

    if v19 then
        v19 = workspace.Alive:FindFirstChild(p18.Name).Humanoid.Health > 0
    end

    return v19
end
function GetClosestObject(p20)
    task.spawn(function()
        local _huge = math.huge
        local v22, v23, v24 = pairs(workspace.Alive:GetChildren())

        while true do
            local v25

            v24, v25 = v22(v23, v24)

            if v24 == nil then
                break
            end
            if v25.Name ~= _Players.LocalPlayer.Name then
                local _Magnitude = (p20.Position - v25.HumanoidRootPart.Position).Magnitude

                if _Magnitude < _huge then
                    u10 = v25
                    _huge = _Magnitude
                end
            end
        end

        return u10
    end)
end

local u27 = {
    AutoParryEnabled = false,
    ParryStateInfo = {
        canParry = true,
        is_Spamming = false,
        parry_Range = 0,
        spam_Range = 0,
        hit_Count = 0,
        hit_Time = tick(),
        ball_Warping = tick(),
        is_ball_Warping = false,
    },
}
local _ParryStateInfo = u27.ParryStateInfo

_ReplicatedStorage.Remotes.ParrySuccessAll.OnClientEvent:Connect(function()
    _ParryStateInfo.hit_Count = _ParryStateInfo.hit_Count + 1

    task.delay(0.15, function()
        _ParryStateInfo.hit_Count = _ParryStateInfo.hit_Count - 1
    end)
end)
workspace:WaitForChild('Balls').ChildRemoved:Connect(function(_)
    _ParryStateInfo.hit_Count = 0
    _ParryStateInfo.is_ball_Warping = false
    _ParryStateInfo.is_Spamming = false
end)
v3.Main:AddToggle('AutoParryEnabled', {
    Title = 'AutoParry Enabled',
    Description = 'Auto Blocked a Ball',
    Default = u27.AutoParryEnabled,
}):OnChanged(function(p29)
    GetParryRemote()

    u27.AutoParryEnabled = p29
end)
task.spawn(function()
    _RunService.PreRender:Connect(function()
        if u27.AutoParryEnabled then
            if u10 and (workspace.Alive:FindFirstChild(u10.Name) and (workspace.Alive:FindFirstChild(u10.Name).Humanoid.Health > 0 and _ParryStateInfo.is_Spamming and _LocalPlayer:DistanceFromCharacter(u10.HumanoidRootPart.Position) <= _ParryStateInfo.spam_Range)) then
                u11:FireServer(0.5, CFrame.new(_CurrentCamera.CFrame.Position, Vector3.zero), {
                    [u10.Name] = u10.HumanoidRootPart.Position,
                }, {
                    u10.HumanoidRootPart.Position.X,
                    u10.HumanoidRootPart.Position.Y,
                }, false)
            end
        end
    end)
    _RunService.Heartbeat:Connect(function()
        if u27.AutoParryEnabled then
            local v30 = _Stats.Network.ServerStatsItem['Data Ping']:GetValue() / 10
            local v31 = GetBall()

            if v31 then
                v31:GetAttributeChangedSignal('target'):Once(function()
                    _ParryStateInfo.canParry = true
                end)

                if v31:GetAttribute('target') == _LocalPlayer.Name and _ParryStateInfo.canParry then
                    GetClosestObject(_LocalPlayer.Character.PrimaryPart)

                    local _ = _LocalPlayer.Character.PrimaryPart.Position
                    local _Position = v31.Position
                    local _AssemblyLinearVelocity = v31.AssemblyLinearVelocity

                    if v31:FindFirstChild('zoomies') then
                        _AssemblyLinearVelocity = v31.zoomies.VectorVelocity
                    end

                    local _Unit = (_LocalPlayer.Character.PrimaryPart.Position - _Position).Unit
                    local u35 = _LocalPlayer:DistanceFromCharacter(_Position)
                    local v36 = _Unit:Dot(_AssemblyLinearVelocity.Unit)
                    local _Magnitude2 = _AssemblyLinearVelocity.Magnitude
                    local u38 = math.min(_Magnitude2 / 1000, 0.1)
                    local _ = u35 - v30 / 15.5 - _Magnitude2 / 3.5
                    local _Position2 = u10.HumanoidRootPart.Position
                    local v40 = _LocalPlayer:DistanceFromCharacter(_Position2)
                    local u41 = math.min(v40 / 10000, 0.1)
                    local _Unit2 = (_LocalPlayer.Character.PrimaryPart.Position - u10.HumanoidRootPart.Position).Unit
                    local _AssemblyLinearVelocity2 = u10.HumanoidRootPart.AssemblyLinearVelocity

                    if _AssemblyLinearVelocity2.Magnitude > 0 then
                        math.max(_Unit2:Dot(_AssemblyLinearVelocity2.Unit), 0)
                    end

                    _ParryStateInfo.spam_Range = math.max(v30 / 10, 15) + _Magnitude2 / 7
                    _ParryStateInfo.parry_Range = math.max(math.max(v30, 4) + _Magnitude2 / 3.5, 9.5)
                    _ParryStateInfo.is_Spamming = _ParryStateInfo.hit_Count > 1 or u35 < 13.5

                    if v36 < -0.2 then
                        _ParryStateInfo.ball_Warping = tick()
                    end

                    task.spawn(function()
                        if tick() - _ParryStateInfo.ball_Warping >= 0.15 + u41 - u38 or u35 <= 10 then
                            _ParryStateInfo.is_ball_Warping = false
                        else
                            _ParryStateInfo.is_ball_Warping = true
                        end
                    end)

                    if u35 <= _ParryStateInfo.parry_Range and not (_ParryStateInfo.is_Spamming or _ParryStateInfo.is_ball_Warping) then
                        u11:FireServer(0.5, CFrame.new(_CurrentCamera.CFrame.Position, Vector3.new(math.random(0, 100), math.random(0, 1000), math.random(100, 1000))), {
                            [u10.Name] = _Position2,
                        }, {
                            _Position2.X,
                            _Position2.Y,
                        }, false)

                        _ParryStateInfo.canParry = false
                        _ParryStateInfo.hit_Time = tick()
                        _ParryStateInfo.hit_Count = _ParryStateInfo.hit_Count + 1

                        task.delay(0.15, function()
                            _ParryStateInfo.hit_Count = _ParryStateInfo.hit_Count - 1
                        end)
                    end

                    task.spawn(function()
                        repeat
                            _RunService.Heartbeat:Wait()
                        until tick() - _ParryStateInfo.hit_Time >= 1

                        _ParryStateInfo.canParry = true
                    end)
                end
            else
                return
            end
        else
            return
        end
    end)
end)
v2:SelectTab(1)
v1:Notify({
    Title = 'Loaded',
    Content = 'The script has been loaded.',
    Duration = 2,
})
