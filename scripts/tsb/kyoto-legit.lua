-- ts file was generated at discord.gg/25ms

local _LocalPlayer3 = game.Players.LocalPlayer

game:GetService('RunService')

local _call7 = Instance.new('ScreenGui')

_call7.Name = 'LazarusGui'
_call7.Parent = game.CoreGui
_call7.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

task.spawn(function(...)
    setclipboard('https://discord.gg/F8z2V82WNZ')

    local _call16 = Instance.new('TextLabel')
    local _call18 = Instance.new('UICorner')
    local _call20 = Instance.new('UIStroke')

    _call16.Parent = _call7
    _call16.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    _call16.BackgroundTransparency = 0.2
    _call16.Position = UDim2.new(0.5, -150, 0.45, 0)
    _call16.Size = UDim2.new(0, 300, 0, 45)
    _call16.Font = Enum.Font.GothamBold
    _call16.Text = 'we changed the lazarus to saturn enjoy'
    _call16.TextColor3 = Color3.fromRGB(240, 240, 240)
    _call16.TextSize = 13
    _call18.CornerRadius = UDim.new(0, 10)
    _call18.Parent = _call16
    _call20.Color = Color3.fromRGB(46, 204, 113)
    _call20.Thickness = 1
    _call20.Parent = _call16

    task.delay(5, function(...)
        local _call39 = game:GetService('TweenService')
        local _call43 = _call39:Create(_call16, TweenInfo.new(1), {
            BackgroundTransparency = 1,
            TextTransparency = 1,
        })
        local _call47 = _call39:Create(_call20, TweenInfo.new(1), {Transparency = 1})

        _call43:Play()
        _call47:Play()
        _call43.Completed:Connect(function(...)
            _call16:Destroy()
        end)
    end)
end)

local _call59 = Instance.new('TextButton')
local _call61 = Instance.new('UICorner')
local _call63 = Instance.new('UIStroke')

_call59.Parent = _call7
_call59.BackgroundColor3 = Color3.fromRGB(20, 40, 25)
_call59.Position = UDim2.new(0.6826, 0, 0.1626, 0)
_call59.Size = UDim2.new(0.08, 0, 0.05, 0)
_call59.Font = Enum.Font.GothamBold
_call59.Text = 'Auto Kyoto: OFF'
_call59.TextColor3 = Color3.fromRGB(255, 255, 255)
_call59.TextSize = 14
_call59.Draggable = true
_call59.AutoButtonColor = true
_call61.CornerRadius = UDim.new(0, 10)
_call61.Parent = _call59
_call63.Color = Color3.fromRGB(46, 204, 113)
_call63.Thickness = 1.5
_call63.Parent = _call59

local _call79 = Instance.new('TextLabel')
local _call81 = Instance.new('UICorner')

_call79.Name = 'Watermark'
_call79.Parent = _call7
_call79.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
_call79.BackgroundTransparency = 0.3
_call79.Position = UDim2.new(0.01, 0, 0.94, 0)
_call79.Size = UDim2.new(0, 160, 0, 25)
_call79.Font = Enum.Font.Code
_call79.Text = 'made by | SATURN HUB team'
_call79.TextColor3 = Color3.fromRGB(200, 200, 200)
_call79.TextSize = 12
_call81.CornerRadius = UDim.new(0, 6)
_call81.Parent = _call79

_call59.MouseButton1Click:Connect(function(...)
    _call59.Text = 'Auto Kyoto: ON'
    _call59.BackgroundColor3 = Color3.fromRGB(30, 80, 40)

    _LocalPlayer3.Character:WaitForChild('Humanoid').AnimationPlayed:Connect(function(...)
        local _106_vararg1 = ...
        local _ = _106_vararg1.Animation.AnimationId
    end)
end)
_LocalPlayer3.CharacterAdded:Connect(function(...)
    _call59.Text = 'Auto Kyoto: OFF'
    _call59.BackgroundColor3 = Color3.fromRGB(20, 40, 25)

    _call105:Disconnect()
end)
