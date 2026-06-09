-- ts file was generated at discord.gg/25ms

local _ScreenGui = Instance.new('ScreenGui')
local _TextButton = Instance.new('TextButton')
local _UICorner = Instance.new('UICorner')

_ScreenGui.Parent = game.CoreGui
_ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
_TextButton.Parent = _ScreenGui
_TextButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
_TextButton.BorderSizePixel = 0
_TextButton.Position = UDim2.new(0.6826, 0, 0.1626, 0)
_TextButton.Size = UDim2.new(0.0666, 0, 0.1169, 0)
_TextButton.Font = Enum.Font.SourceSans
_TextButton.Text = 'OFF'
_TextButton.TextColor3 = Color3.fromRGB(189, 189, 189)
_TextButton.TextSize = 30
_TextButton.TextWrapped = true
_TextButton.Draggable = true
_UICorner.Parent = _TextButton

local _LocalPlayer = game:GetService('Players').LocalPlayer
local _CurrentCamera = workspace.CurrentCamera
local u6 = 'rbxassetid://12296113986'
local u7 = false
local u8 = nil

local function u13()
    local v9 = _LocalPlayer.Character or _LocalPlayer.CharacterAdded:Wait()
    local _HumanoidRootPart = v9:WaitForChild('HumanoidRootPart')

    v9:WaitForChild('Humanoid').AutoRotate = false

    local v11 = _HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(180), 0)

    _HumanoidRootPart.CFrame = v11

    local _Magnitude = (_CurrentCamera.CFrame.Position - v11.Position).Magnitude

    _CurrentCamera.CFrame = CFrame.new(v11.Position - v11.LookVector * _Magnitude + Vector3.new(0, 2), v11.Position)
end
local function u14()
    (_LocalPlayer.Character or _LocalPlayer.CharacterAdded:Wait()):WaitForChild('HumanoidRootPart').AssemblyLinearVelocity = Vector3.new(0, 64, 0)
end
local function u15()
    u7 = false
    _TextButton.Text = 'OFF'

    if u8 then
        u8:Disconnect()

        u8 = nil
    end
end
local function v18()
    if u7 then
        u15()
    else
        u7 = true
        _TextButton.Text = 'ON'
        u8 = (_LocalPlayer.Character or _LocalPlayer.CharacterAdded:Wait()):WaitForChild('Humanoid').AnimationPlayed:Connect(function(p16)
            if p16.Animation.AnimationId == u6 then
                wait(1.7)
                u14()
                u13()

                local v17 = {
                    {
                        Dash = Enum.KeyCode.W,
                        Key = Enum.KeyCode.Q,
                        Goal = 'KeyPress',
                    },
                }

                _LocalPlayer.Character:WaitForChild('Communicate'):FireServer(unpack(v17))

                getgenv().Delay = 0.22

                task.wait(getgenv().Delay)
                u13()
            end
        end)
    end
end

_TextButton.MouseButton1Click:Connect(v18)
_LocalPlayer.CharacterAdded:Connect(function()
    u15()
end)
