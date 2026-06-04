-- Rayfield UI Version - ThanhDuy V10.4 Hub | TSB
-- Load Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Tạo Window
local Window = Rayfield:CreateWindow({
    Name = "ThanhDuy",
    LoadingTitle = "ThanhDuy Hub",
    LoadingSubtitle = "by ThanhDuy",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "ThanhDuyHub",
        FileName = "Config"
    },
    Discord = {
        Enabled = false,
        Invite = "noinvitelink",
        RememberJoins = true
    },
    KeySystem = false,
    KeySettings = {
        Title = "Key System",
        Subtitle = "Enter Key",
        Note = "Join Discord for key",
        FileName = "Key",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"tthanhhub on top"}
    }
})

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local VirtualInputManager = game:GetService("VirtualInputManager")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local Debris = game:GetService("Debris")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local SoundService = game:GetService("SoundService")

-- ===== GLOBAL STATE =====
local MasterEnabled = false
local CombatEnabled = false
local CamlockEnabled = false
local CurrentTarget = nil
local CamlockTarget = nil
local LOCK_DISTANCE = 80
local CamLOCK_DISTANCE = 120
local CamPREDICTION = 0.12
local CamSMOOTHNESS = 0.18

-- FPS Counter
local FPS = 0
local lastUpdate = tick()
local frameCount = 0

RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    local now = tick()
    
    if now - lastUpdate >= 1 then
        FPS = math.floor(frameCount / (now - lastUpdate))
        frameCount = 0
        lastUpdate = now
    end
end)

-- Ping Counter
task.spawn(function()
    while true do
        local Stats = game:GetService("Stats")
        local pingValue = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
        task.wait(2)
    end
end)

-- ===== FUNCTIONS =====
function GetNearestPlayer()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end

    local root = char.HumanoidRootPart
    local nearest, dist = nil, LOCK_DISTANCE

    for _,plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            local hum = plr.Character:FindFirstChild("Humanoid")
            if hrp and hum and hum.Health > 0 then
                local d = (hrp.Position - root.Position).Magnitude
                if d < dist then
                    dist = d
                    nearest = plr
                end
            end
        end
    end
    return nearest
end

function CamFindTarget()
    local myChar = LocalPlayer.Character
    if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return nil end

    local root = myChar.HumanoidRootPart
    local nearest, bestDist = nil, CamLOCK_DISTANCE

    for _,plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local hum = plr.Character:FindFirstChildOfClass("Humanoid")
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            if hum and hrp and hum.Health > 0 then
                local d = (hrp.Position - root.Position).Magnitude
                if d < bestDist then
                    bestDist = d
                    nearest = plr
                end
            end
        end
    end
    return nearest
end

-- Main loop
RunService.RenderStepped:Connect(function()
    if MasterEnabled and CombatEnabled then
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end

        if not CurrentTarget or not CurrentTarget.Character or not CurrentTarget.Character:FindFirstChild("Humanoid") or CurrentTarget.Character.Humanoid.Health <= 0 then
            CurrentTarget = GetNearestPlayer()
            return
        end

        local targetHRP = CurrentTarget.Character:FindFirstChild("HumanoidRootPart")
        if not targetHRP then return end

        char.HumanoidRootPart.CFrame = CFrame.new(
            char.HumanoidRootPart.Position,
            Vector3.new(targetHRP.Position.X, char.HumanoidRootPart.Position.Y, targetHRP.Position.Z)
        )
    end

    if CamlockEnabled then
        if not CamlockTarget or not CamlockTarget.Character or not CamlockTarget.Character:FindFirstChild("HumanoidRootPart") then
            CamlockTarget = CamFindTarget()
            return
        end

        local hrp = CamlockTarget.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        local predicted = hrp.Position + (hrp.AssemblyLinearVelocity * CamPREDICTION)
        local currentCF = Camera.CFrame
        local targetCF = CFrame.new(currentCF.Position, predicted)
        Camera.CFrame = currentCF:Lerp(targetCF, CamSMOOTHNESS)
    end
end)

-- ===== MAIN TAB =====
local MainTab = Window:CreateTab("Main", 4483362458)
local MainSection = MainTab:CreateSection("Main Features")

-- Silent Aim
local SilentAimToggle = MainTab:CreateToggle({
    Name = "Silent Aim",
    CurrentValue = false,
    Flag = "SilentAim",
    Callback = function(Value)
        MasterEnabled = Value
        if not Value then
            CombatEnabled = false
            CurrentTarget = nil
        end
    end,
})

-- Cam Lock
local CamLockToggle = MainTab:CreateToggle({
    Name = "Cam Lock",
    CurrentValue = false,
    Flag = "CamLock",
    Callback = function(Value)
        CamlockEnabled = Value
        if not Value then
            CamlockTarget = nil
        end
    end,
})

-- ===== MOVESETS TAB =====
local MovesetsTab = Window:CreateTab("Movesets", 4483362458)

-- Saitama Section
local SaitamaSection = MovesetsTab:CreateSection("Saitama")

MovesetsTab:CreateButton({
    Name = "Sukuna",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/damir512/whendoesbrickdie/main/tspno.txt",true))()
    end,
})

MovesetsTab:CreateButton({
    Name = "Gojo",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/KJ-The-Strongest-Battlegrounds-battleground-gojo-script-saitama-to-gojo-26980"))()
    end,
})

MovesetsTab:CreateButton({
    Name = "Kars",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/OfficialAposty/RBLX-Scripts/refs/heads/main/UltimateLifeForm.lua"))()
    end,
})

MovesetsTab:CreateButton({
    Name = "Wally West",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Nova2ezz/west/refs/heads/main/Protected_4638864115822087.lua.txt"))()
    end,
})

MovesetsTab:CreateButton({
    Name = "MAFIOSO",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Lovelymoonlight/Lovelymoonlight/refs/heads/main/Baldy%20to%20mafioso'))()
    end,
})

MovesetsTab:CreateButton({
    Name = "Beerus",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/sparksnaps/Beerus-The-Destroyer/refs/heads/main/Lua"))()
    end,
})

MovesetsTab:CreateButton({
    Name = "Madara",
    Callback = function()
        getgenv().Cutscene = False
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LolnotaKid/SCRIPTSBYVEUX/refs/heads/main/BoombasticLol.lua.txt"))()
    end,
})

MovesetsTab:CreateButton({
    Name = "Golden Head",
    Callback = function()
        getgenv().stand = false
        getgenv().ken = false
        getgenv().Spawn = true
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Kenjihin69/Kenjihin69/refs/heads/main/Saitama%20to%20golden%20sigma'))()
    end,
})

MovesetsTab:CreateButton({
    Name = "Jun",
    Callback = function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/GoldenHeads2/f66279000c58a020e894a6db44914838/raw/62e53e1acacec0b38b43cd0f594292c32e09c39b/gistfile1.txt"))()
    end,
})

MovesetsTab:CreateButton({
    Name = "Mahito",
    Callback = function()
        getgenv().Swordm1 = true
        getgenv().night = false
        getgenv().plushie = false
        getgenv().blackflash = true
        getgenv().chat = false
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Kenjihin69/Kenjihin69/refs/heads/main/Mahito%20v2%20sigma%20tp%20exploit'))()
    end,
})

MovesetsTab:CreateButton({
    Name = "Naruto",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LolnotaKid/NarutoBeatUpSasukeAss/refs/heads/main/NarutoCums"))()
    end,
})

-- Garou Section
local GarouSection = MovesetsTab:CreateSection("Garou")

MovesetsTab:CreateButton({
    Name = "Gabriel",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/damir512/youinsinificants/main/insignificantFuck.txt",true))()
    end,
})

MovesetsTab:CreateButton({
    Name = "Void Garou",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/yes1nt/yes/refs/heads/main/Void%20Reaper%20Obfuscated.txt"))()
    end,
})

MovesetsTab:CreateButton({
    Name = "Mastery Deku",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/xKextYP5"))()
    end,
})

MovesetsTab:CreateButton({
    Name = "SONIC.EXE",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/4zLt8a2P/raw"))()
    end,
})

-- ===== TECH TAB =====
local TechTab = Window:CreateTab("Tech", 4483362458)
local TechSection = TechTab:CreateSection("Tech")

-- Tech buttons
local TechButtons = {
    {"Surfing Tech", "https://raw.githubusercontent.com/Cyborg883/GarouSurfingTech/refs/heads/main/Protected_2674673126232747.lua"},
    {"LoopDash v2 Tech", "https://api.getpolsec.com/scripts/hosted/84e2bd29cccc0f5302267e4dc952cff6816db4af36416cbd477daaa26d60863d.lua"},
    {"Lethal Kiba Tech", "https://raw.githubusercontent.com/MinhNhatHUB/MinhNhat/refs/heads/main/Lethal%20Kiba.lua"},
    {"Auto Tech", "https://raw.githubusercontent.com/Cyborg883/NewAutoTech/refs/heads/main/Protected_6389347658054908.lua"},
    {"Instant Twisted", "https://raw.githubusercontent.com/Cyborg883/InstantTwistedRevamp/refs/heads/main/Protected_7455521176683315.lua"},
    {"Instant Lethal", "https://raw.githubusercontent.com/Cyborg883/InstantLethal/refs/heads/main/Protected_5983112998592296.lua"},
    {"Combat Gui", "https://raw.githubusercontent.com/Cyborg883/CombatGUI/refs/heads/main/TSBCombatGUI"},
    {"Kai Tech", "https://raw.githubusercontent.com/YQANTGV2/YQANTGV2/refs/heads/main/Kai"},
    {"Auto Downslam", "https://raw.githubusercontent.com/kaimm2/TSB/refs/heads/main/atds"},
    {"Idk Tech", "https://raw.githubusercontent.com/Reapvitalized/TSB/refs/heads/main/SIONELTNAMATLASIA.lua"},
    {"Gojo Tech Old", "https://raw.githubusercontent.com/ngoclinh02042011-stack/Gojo-Tech/refs/heads/main/DuydepzaiGojoTech.lua"},
    {"Gojo Tech New", "https://gojotech.tsbscripts.workers.dev/"},
    {"Supa v2 Tech Fix", "https://api.getpolsec.com/scripts/hosted/2753546c83053761e44664d36ffe5035d6e20fc8aee1d19f0eb7b933974ae537.lua"},
    {"Side Dash V1", "https://api.getpolsec.com/scripts/hosted/94a29c6b88bfe8c49ea221eaa9225398790c1b7436b0f08caf7517c3002e8782.lua"},
    {"Side Dash V2", "https://api.getpolsec.com/scripts/hosted/52b3b7317bd590bfe678009b3359e74316d9c731ec1395f3e800718d520501f1.lua"},
    {"Lix Tech", "https://raw.githubusercontent.com/MerebennieOfficial/ExoticJn/refs/heads/main/Protected_83737738.txt"},
    {"Sikibidi Twister", "https://raw.githubusercontent.com/Duytsb1609/082/refs/heads/main/i8gr8zim.txt"},
    {"Sikibidi Tech V3", "https://raw.githubusercontent.com/Duytsb1609/Also-olsjdjf/refs/heads/main/ph9CvJte.txt"},
    {"Sikibidi Tech V2", "https://raw.githubusercontent.com/Duytsb1609/Hslsbc/refs/heads/main/ypWkRage.txt"},
    {"TwetiQ Tech", "https://pastefy.app/bduzr7pS/raw"},
    {"Lethal Revamp", "https://raw.githubusercontent.com/Cyborg883/InstantLethalRevamp/refs/heads/main/Protected_6977817281150270.lua"},
    {"Reflex Tech", "https://raw.githubusercontent.com/Cyborg883/ReflexTech/refs/heads/main/Protected_7459802026542834.lua"},
    {"Oreo Tech", "https://raw.githubusercontent.com/Cyborg883/OreoTech/refs/heads/main/Protected_6856895483929371.lua"},
    {"Lethal Dash", "https://raw.githubusercontent.com/Cyborg883/InstantLethal/refs/heads/main/Protected_5983112998592296.lua"},
    {"SUPA v3", "https://api.getpolsec.com/scripts/hosted/ea0b7cbd8c395e01ec38271794b2559808d26501bd6e6e30c48660759a7db7b3.lua"},
    {"Kiba", "https://raw.githubusercontent.com/kietsonphongthanhnghia-a11y/Uhyeah/refs/heads/main/Protected_1425045629292384.lua.txt"},
    {"Instant Twisted New", "https://raw.githubusercontent.com/Duytsb1609/Instant-Twisted-Sigma/refs/heads/main/instant_Twisted%20(1).lua"},
    {"3 in 1 Tech", "https://pastefy.app/NJfMV5ze/raw"},
    {"Merck V2 Tech", "https://arch-http.vercel.app/files/Merck V2.lua"},
    {"Lix Tech", "https://arch-http.vercel.app/files/Lix Tech.lua"},
    {"Nigger Tech", "https://arch-http.vercel.app/files/Nigger Tech.lua"},
    {"Kitty Tech", "https://raw.githubusercontent.com/Nhat473/Kitty-Tech/refs/heads/main/TSB"},
    {"Reflex Tech", "https://raw.githubusercontent.com/Cyborg883/ReflexTech/refs/heads/main/Protected_7459802026542834.lua"},
    {"KibaZ Tech", "https://raw.githubusercontent.com/gamerscripter90/Kibaz/main/kibaztech.lua.txt"},
    {"Lethal Dash V2", "https://raw.githubusercontent.com/MerebennieOfficial/ExoticJn/refs/heads/main/Protected_9140705456986362.lua.txt"},
    {"Kiba Tech V2", "https://raw.githubusercontent.com/MinhNhatHUB/MinhNhat/refs/heads/MinhNhatDZ/Kiba%20Tech%20V2.lua"},
    {"Auto Kyoto", "https://raw.githubusercontent.com/Cyborg883/KyotoTechRework/refs/heads/main/Protected_9378660372508532.lua"},
    {"Frezze Tech", "https://arch-http.vercel.app/files/Frezze Tech.lua"},
    {"Auto Uppercut", "https://arch-http.vercel.app/files/Auto Uppercut.lua"},
    {"The Fish X ( Dash )", "https://raw.githubusercontent.com/minhnhatdepzai8-cloud/TheFishX/refs/heads/main/obfuscated_script-1757331576860.lua.txt"},
    {"Auto Kyoto ( By Mark )", "https://raw.githubusercontent.com/Mark22028/Auto-Kyoto-Combo/refs/heads/main/Skibidi%20Sigma%20Combo.txt"},
    {"Auto Kyoto Combo", "https://raw.githubusercontent.com/gamerscripter90/Thestrongesthgg-/main/Kyoto.lua.txt"},
    {"KibaZ V1", "https://raw.githubusercontent.com/gamerscripter90/KIBAZ-TECH-/main/Kibaztechv1.lua.txt"},
    {"Abik Tech", "https://pastefy.app/Emr1fT6C/raw"},
}

for _, tech in ipairs(TechButtons) do
    TechTab:CreateButton({
        Name = tech[1],
        Callback = function()
            loadstring(game:HttpGet(tech[2]))()
        end,
    })
end

-- ===== PLAYER TAB =====
local PlayerTab = Window:CreateTab("Player", 4483362458)

-- Boombox Section
local BoomboxSection = PlayerTab:CreateSection("Boombox")

local MusicList = {
    ["Mercy - Living Stone"] = "112545816639972",
    ["My ordinary life - Living Stone"] = "131387015642491",
    ["Discord - Living Stone"] = "77595469047336",
    ["Young Girl A"] = "117044716417145",
    ["The World Revolving"] = "126101283149087",
    ["Finale - Undertale"] = "117064854285259",
    ["Last Breath"] = "97889274347145",
    ["Stronger Than You (Chara Ver)"] = "74109325185963",
    ["Stronger Than You (Frisk Ver)"] = "92969307461807",
    ["Number Hardtekk (Slowed)"] = "82696338249251",
}

local musicNames = {}
for name, _ in pairs(MusicList) do
    table.insert(musicNames, name)
end

local SelectedMusic = "Mercy - Living Stone"
local CurrentVolume = 0.5
local IsLooped = false
local Sound = nil

local function CreateSound()
    if Sound then
        pcall(function()
            Sound:Stop()
            Sound:Destroy()
        end)
    end

    Sound = Instance.new("Sound")
    Sound.Name = "BoomboxSound"
    Sound.Parent = workspace.CurrentCamera
    Sound.Volume = CurrentVolume
    Sound.Looped = IsLooped
    Sound.SoundId = "rbxassetid://" .. MusicList[SelectedMusic]
    Sound:Stop()
end

CreateSound()

workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
    if Sound then
        Sound.Parent = workspace.CurrentCamera
    end
end)

PlayerTab:CreateDropdown({
    Name = "Select Music",
    Options = musicNames,
    CurrentOption = "Mercy - Living Stone",
    Flag = "MusicDropdown",
    Callback = function(selected)
        SelectedMusic = selected
        if Sound then
            Sound.SoundId = "rbxassetid://" .. MusicList[selected]
            Sound:Stop()
            Sound.TimePosition = 0
        end
    end,
})

PlayerTab:CreateButton({
    Name = "Play",
    Callback = function()
        if not Sound then return end
        Sound:Stop()
        Sound.TimePosition = 0
        Sound:Play()
    end,
})

PlayerTab:CreateButton({
    Name = "Stop",
    Callback = function()
        if Sound then
            Sound:Stop()
        end
    end,
})

PlayerTab:CreateToggle({
    Name = "Loop",
    CurrentValue = false,
    Flag = "LoopMusic",
    Callback = function(Value)
        IsLooped = Value
        if Sound then
            Sound.Looped = Value
        end
    end,
})

PlayerTab:CreateSlider({
    Name = "Volume",
    Range = {0, 100},
    Increment = 10,
    CurrentValue = 50,
    Flag = "VolumeSlider",
    Callback = function(Value)
        CurrentVolume = Value / 100
        if Sound then
            Sound.Volume = CurrentVolume
        end
    end,
})

-- Visual Section
local VisualSection = PlayerTab:CreateSection("Visual")

PlayerTab:CreateButton({
    Name = "Golden Shoulder",
    Callback = function()
        local function Accs(AccsName, char, Mesh, Texture, Scale, CF, Welded, Angle)
            local acc = Instance.new("Accessory")
            acc.Name = AccsName
            acc.Parent = char

            local handle = Instance.new("Part")
            handle.Name = "Handle"
            handle.Size = Vector3.new(1,1,1)
            handle.Anchored = false
            handle.Massless = true
            handle.CanCollide = false
            handle.Parent = acc

            local mesh = Instance.new("SpecialMesh")
            mesh.MeshId = Mesh
            mesh.TextureId = Texture
            mesh.Scale = Scale
            mesh.Parent = handle

            local weld = Instance.new("Weld")
            weld.Part0 = handle
            weld.Part1 = char:WaitForChild(Welded)
            weld.C0 = CF * Angle
            weld.Parent = handle
        end

        local lp = game.Players.LocalPlayer
        local char = lp.Character or lp.CharacterAdded:Wait()

        if char:FindFirstChild("GoldenShoulder") then
            char.GoldenShoulder:Destroy()
        end

        Accs(
            "GoldenShoulder",
            char,
            "rbxassetid://4307568890",
            "rbxassetid://4307568951",
            Vector3.new(1,1,1),
            CFrame.new(-0.6, -1.3, 0),
            "Right Arm",
            CFrame.Angles(0, 0, 0)
        )
    end,
})

PlayerTab:CreateInput({
    Name = "Kill Sound ID",
    PlaceholderText = "Enter Sound ID",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        text = tostring(text):gsub("%s+", "")
        if text == "" then return end
        if tonumber(text) then
            local soundId = "rbxassetid://" .. text
            local sound = Instance.new("Sound")
            sound.SoundId = soundId
            sound.Volume = 1
            sound.Parent = SoundService
            
            local leaderstats = LocalPlayer:WaitForChild("leaderstats", 10)
            if leaderstats then
                local kills = leaderstats:FindFirstChild("Kills")
                if kills then
                    kills:GetPropertyChangedSignal("Value"):Connect(function()
                        sound:Play()
                    end)
                end
            end
        end
    end,
})

PlayerTab:CreateButton({
    Name = "Fix Lag MAX (Boost)",
    Callback = function()
        -- Lighting
        for _, v in ipairs(Lighting:GetChildren()) do
            if v:IsA("PostEffect") then
                v.Enabled = false
            end
        end
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 1e9
        Lighting.Brightness = 1

        -- Remove VFX
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") or obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Explosion") or obj:IsA("Highlight") then
                pcall(function()
                    obj.Enabled = false
                    obj:Destroy()
                end)
            end
            if obj:IsA("BasePart") then
                obj.CastShadow = false
                obj.Material = Enum.Material.Plastic
                obj.Reflectance = 0
            elseif obj:IsA("Decal") or obj:IsA("Texture") then
                obj.Transparency = 1
            end
        end

        -- Remove Trees
        local map = workspace:FindFirstChild("Map")
        if map then
            local treesFolder = map:FindFirstChild("Trees")
            if treesFolder then
                for _, tree in ipairs(treesFolder:GetChildren()) do
                    if tree:IsA("Model") and tree.Name == "Tree" then
                        tree:Destroy()
                    end
                end
            end
        end

        Rayfield:Notify({
            Title = "Fix Lag",
            Content = "MAX Boost Enabled",
            Duration = 3,
            Image = 4483362458,
        })
    end,
})

-- ===== EMOTE TAB =====
local EmoteTab = Window:CreateTab("Emote Limited", 4483362458)
local EmoteSection = EmoteTab:CreateSection("Limited Emotes")

-- Final Stand
EmoteTab:CreateButton({
    Name = "Final Stand",
    Callback = function()
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")

        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://113876851900426"
        humanoid:LoadAnimation(anim):Play()

        task.delay(0.1, function()
            local acc = Instance.new("Accessory")
            acc.Name = "#EmoteHolder_" .. math.random(1, 100000)
            acc.Parent = character
            acc:SetAttribute("EmoteProperty", true)

            require(ReplicatedStorage.Emotes.VFX):MainFunction({
                Character = character,
                vfxName = "Final Stand",
                SpecificModule = ReplicatedStorage.Emotes.VFX,
                AnimSent = 113876851900426,
                RealBind = acc,
            })
        end)
    end
})

-- Inner Rage
EmoteTab:CreateButton({
    Name = "Inner Rage",
    Callback = function()
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")

        local v67 = Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255))

        local v69 = Instance.new("Animation")
        v69.AnimationId = "rbxassetid://96993907314948"
        local v70 = humanoid:LoadAnimation(v69)
        v70:Play()

        v70.Stopped:Connect(function()
            local v71 = Instance.new("Animation")
            v71.AnimationId = "rbxassetid://127234845846317"
            humanoid:LoadAnimation(v71):Play()
        end)

        local vu72 = Instance.new("Accessory")
        vu72.Name = "#EmoteHolder_" .. math.random(1,100000)
        vu72.Parent = character

        require(ReplicatedStorage.Emotes.VFX):MainFunction({
            Character = character,
            vfxName = "Energy Explosion",
            AnimSent = 96993907314948,
            RealBind = vu72,
            NoInsertion = true,
            Colour = v67,
        })
    end
})

-- Shadow Eruption
EmoteTab:CreateButton({
    Name = "Shadow Eruption",
    Callback = function()
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")

        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://121032789756540"
        humanoid:LoadAnimation(anim):Play()

        task.delay(0.1, function()
            local acc = Instance.new("Accessory")
            acc.Name = "#EmoteHolder_" .. math.random(1, 100000)
            acc.Parent = character

            require(ReplicatedStorage.Emotes.VFX):MainFunction({
                Character = character,
                vfxName = "Shadow Eruption",
                SpecificModule = ReplicatedStorage.Emotes.VFX,
                AnimSent = 121032789756540,
                RealBind = acc,
            })
        end)
    end
})

-- Divine Form
EmoteTab:CreateButton({
    Name = "Divine Form",
    Callback = function()
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")

        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://116187503451999"
        humanoid:LoadAnimation(anim):Play()

        local acc = Instance.new("Accessory")
        acc.Name = "#EmoteHolder_" .. math.random(1, 100000)
        acc.Parent = character
        acc:SetAttribute("EmoteProperty", true)

        require(ReplicatedStorage.Emotes.VFX):MainFunction({
            Character = character,
            vfxName = "Divine Form",
            SpecificModule = ReplicatedStorage.Emotes.VFX,
            AnimSent = 116187503451999,
            RealBind = acc,
        })
    end
})

-- The Strongest
EmoteTab:CreateButton({
    Name = "The Strongest",
    Callback = function()
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")

        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://86505219150915"
        humanoid:LoadAnimation(anim):Play()

        task.delay(0.1, function()
            local bind = Instance.new("Folder")
            bind.Name = "PrideBind"
            bind.Parent = character
            bind:SetAttribute("EmoteProperty", true)

            require(ReplicatedStorage.Emotes.VFX):MainFunction({
                Character = character,
                vfxName = "Boss Raid",
                SpecificModule = ReplicatedStorage.Emotes.VFX,
                AnimSent = 86505219150915,
                RealBind = bind,
            })
        end)
    end
})

-- Boundless Rage
EmoteTab:CreateButton({
    Name = "Boundless Rage",
    Callback = function()
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")

        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://107649573628906"
        humanoid:LoadAnimation(anim):Play()

        task.delay(0.1, function()
            local emoteAcc = Instance.new("Accessory")
            emoteAcc.Name = "#EmoteHolder_" .. math.random(1, 100000)
            emoteAcc.Parent = character
            emoteAcc:SetAttribute("EmoteProperty", true)

            require(ReplicatedStorage.Emotes.VFX):MainFunction({
                Character = character,
                vfxName = "Boundless Rage",
                SpecificModule = ReplicatedStorage.Emotes.VFX,
                AnimSent = 107649573628906,
                RealBind = emoteAcc,
            })
        end)
    end
})

-- The Fallen
EmoteTab:CreateButton({
    Name = "The Fallen",
    Callback = function()
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")

        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://133818134745501"
        humanoid:LoadAnimation(anim):Play()

        task.delay(0.1, function()
            local old = character:FindFirstChild("DismantleEffect")
            if old then
                old:Destroy()
            end

            local acc = Instance.new("Accessory")
            acc.Name = "DismantleEffect"
            acc.Parent = character
            acc:SetAttribute("EmoteEffect", true)

            require(ReplicatedStorage.Emotes.VFX):MainFunction({
                Character = character,
                vfxName = "Pride",
                SpecificModule = ReplicatedStorage.Emotes.VFX,
                AnimSent = 133818134745501,
                RealBind = acc,
                CanRotate = true,
            })
        end)
    end
})

-- True Aura
EmoteTab:CreateButton({
    Name = "True Aura",
    Callback = function()
        local character = LocalPlayer.Character
        if not character then return end
        local humanoid = character:FindFirstChild("Humanoid")
        if not humanoid then return end

        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://103668868712897"
        humanoid:LoadAnimation(anim):Play()

        task.delay(0.1, function()
            if not character or not character.Parent then return end

            local acc = Instance.new("Accessory")
            acc.Name = "#EmoteHolder_" .. math.random(1, 100000)
            acc.Parent = character

            require(ReplicatedStorage.Emotes.VFX):MainFunction({
                Character = character,
                vfxName = "True Aura",
                SpecificModule = ReplicatedStorage.Emotes.VFX,
                AnimSent = 103668868712897,
                RealBind = acc,
            })
        end)
    end
})

-- Eternal Seal (Bugged)
EmoteTab:CreateButton({
    Name = "Eternal Seal (Bugged)",
    Callback = function()
        Rayfield:Notify({
            Title = "Eternal Seal",
            Content = "This emote is currently bugged",
            Duration = 3,
            Image = 4483362458,
        })
    end
})

-- World Cutting Slash (Soon)
EmoteTab:CreateButton({
    Name = "World Cutting Slash (Soon)",
    Callback = function()
        Rayfield:Notify({
            Title = "World Cutting Slash",
            Content = "Coming soon...",
            Duration = 2,
            Image = 4483362458,
        })
    end
})

-- ===== INFO TAB =====
local InfoTab = Window:CreateTab("Info", 4483362458)
local InfoSection = InfoTab:CreateSection("Information")

InfoTab:CreateButton({
    Name = "Copy Discord Link",
    Callback = function()
        setclipboard("https://discord.gg/pz5UhsVH")
        Rayfield:Notify({
            Title = "Copied!",
            Content = "Discord link copied to clipboard",
            Duration = 3,
            Image = 4483362458,
        })
    end,
})

InfoTab:CreateParagraph({
    Title = "UPDATE SCRIPT:",
    Content = "[+] Fixed CamLock\n[+] Added Fling Player\n[+] Added Number Hardtekk(music)\n[+] Remove Sleeping City Funk(music)",
})

-- ===== MISC TAB =====
local MiscTab = Window:CreateTab("Misc", 4483362458)
local MiscSection = MiscTab:CreateSection("Server Tools")

-- Server Info
local function formatTime(sec)
    local h = math.floor(sec / 3600)
    local m = math.floor((sec % 3600) / 60)
    local s = math.floor(sec % 60)
    return string.format("%02dh %02dm %02ds", h, m, s)
end

MiscTab:CreateParagraph({
    Title = "Server Info",
    Content = "Loading...",
})

-- Update server info
task.spawn(function()
    while true do
        local currentPlayers = #Players:GetPlayers()
        local maxPlayers = Players.MaxPlayers
        local placeId = game.PlaceId
        local jobId = game.JobId
        local uptime = workspace.DistributedGameTime
        
        for _, element in pairs(MiscTab:GetChildren()) do
            if element:IsA("Paragraph") and element.Title == "Server Info" then
                element.Content = "👥 Players: " .. currentPlayers .. "/" .. maxPlayers ..
                    "\n👀 PlaceId: " .. placeId ..
                    "\n⌚ Session Time: " .. formatTime(uptime) ..
                    "\n🧩 JobId: " .. jobId
                break
            end
        end
        task.wait(1)
    end
end)

MiscTab:CreateButton({
    Name = "Copy JobId",
    Callback = function()
        if setclipboard then
            setclipboard(game.JobId)
            Rayfield:Notify({
                Title = "Copied!",
                Content = "JobId copied to clipboard",
                Duration = 2,
                Image = 4483362458,
            })
        end
    end,
})

MiscTab:CreateButton({
    Name = "Rejoin Server",
    Callback = function()
        pcall(function()
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
        end)
    end,
})

MiscTab:CreateButton({
    Name = "Hop Server (Random)",
    Callback = function()
        local function getServers(maxPages)
            local servers = {}
            local cursor = ""
            local pages = 0

            repeat
                pages += 1
                local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100" .. (cursor ~= "" and "&cursor=" .. cursor or "")
                local success, res = pcall(function()
                    return HttpService:JSONDecode(game:HttpGet(url))
                end)

                if not success or not res or not res.data then break end

                for _, srv in ipairs(res.data) do
                    if srv.playing < srv.maxPlayers and srv.id ~= game.JobId then
                        table.insert(servers, srv)
                    end
                end

                cursor = res.nextPageCursor
            until not cursor or pages >= (maxPages or 5)

            return servers
        end

        local servers = getServers(6)
        if #servers > 0 then
            local pick = servers[math.random(1, #servers)]
            task.wait(0.2)
            TeleportService:TeleportToPlaceInstance(game.PlaceId, pick.id, LocalPlayer)
        end
    end,
})

MiscTab:CreateButton({
    Name = "Hop Lowest Player Server",
    Callback = function()
        local servers = {}
        local cursor = ""

        repeat
            local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100" .. (cursor ~= "" and "&cursor=" .. cursor or "")
            local success, res = pcall(function()
                return HttpService:JSONDecode(game:HttpGet(url))
            end)

            if success and res and res.data then
                for _, srv in ipairs(res.data) do
                    if srv.playing and srv.playing >= 1 and srv.playing < srv.maxPlayers and srv.id ~= game.JobId then
                        table.insert(servers, srv)
                    end
                end
                cursor = res.nextPageCursor
            else
                break
            end
        until not cursor or #servers >= 200

        table.sort(servers, function(a, b) return a.playing < b.playing end)

        if servers[1] then
            pcall(function()
                TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[1].id, LocalPlayer)
            end)
        end
    end,
})

MiscTab:CreateInput({
    Name = "Join by JobID",
    PlaceholderText = "Paste JobId...",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        if text and text ~= "" then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, text, LocalPlayer)
        end
    end,
})

-- Auto Kill Section
local AutoKillSection = MiscTab:CreateSection("Auto Kill")

local targetPlayer = nil
local killEnabled = false
local orbitEnabled = false
local nameInput = ""

-- Auto Kill functions
local function getNearestPlayerAK()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
    local root = char.HumanoidRootPart
    local nearest, minDist = nil, math.huge

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            local hum = plr.Character:FindFirstChildOfClass("Humanoid")
            if hrp and hum and hum.Health > 0 then
                local dist = (root.Position - hrp.Position).Magnitude
                if dist < minDist then
                    minDist = dist
                    nearest = plr
                end
            end
        end
    end
    return nearest
end

local function tapKey(key, delay)
    VirtualInputManager:SendKeyEvent(true, key, false, game)
    task.wait(delay or 0.05)
    VirtualInputManager:SendKeyEvent(false, key, false, game)
end

MiscTab:CreateInput({
    Name = "Enter username to kill",
    PlaceholderText = "Empty = nearest",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        nameInput = text
    end,
})

MiscTab:CreateToggle({
    Name = "Auto Kill",
    CurrentValue = false,
    Flag = "AutoKill",
    Callback = function(Value)
        killEnabled = Value
        orbitEnabled = Value
    end,
})

-- Auto Kill loop
task.spawn(function()
    while task.wait(0.1) do
        if not killEnabled then continue end
        
        if nameInput ~= "" then
            targetPlayer = Players:FindFirstChild(nameInput)
        else
            targetPlayer = getNearestPlayerAK()
        end
        
        if not targetPlayer or not targetPlayer.Character then continue end
        
        local char = LocalPlayer.Character
        local thrp = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        local thum = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
        local comm = char and char:FindFirstChild("Communicate")
        
        if not char or not thrp or not thum or not comm then continue end
        if thum.Health <= 0 then continue end
        if (char.HumanoidRootPart.Position - thrp.Position).Magnitude > 6 then continue end
        
        comm:FireServer({ Goal = "LeftClick", Mobile = true })
        task.wait(0.15)
        
        tapKey(Enum.KeyCode.Q, 0.1)
        tapKey(Enum.KeyCode.One)
        tapKey(Enum.KeyCode.Two)
        tapKey(Enum.KeyCode.Three)
        tapKey(Enum.KeyCode.Four)
        
        task.wait(0.15)
        tapKey(Enum.KeyCode.G, 0.15)
        tapKey(({Enum.KeyCode.One,Enum.KeyCode.Two,Enum.KeyCode.Three,Enum.KeyCode.Four})[math.random(1,4)])
    end
end)

-- Orbit
local radius = 5.5
local heightMin = -1.5
local heightMax = 2
local teleportSpeed = 2

local function randomOffset()
    local dir = Vector3.new(math.random(-100,100), 0, math.random(-100,100)).Unit
    local height = math.random() * (heightMax - heightMin) + heightMin
    return dir * radius + Vector3.new(0, height, 0)
end

RunService.RenderStepped:Connect(function()
    if not orbitEnabled or not targetPlayer or not targetPlayer.Character then return end
    local root = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
    local hum = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
    if not root or not hum or hum.Health <= 0 then return end
    
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    for _ = 1, teleportSpeed do
        char.HumanoidRootPart.CFrame = CFrame.new(root.Position + randomOffset(), root.Position)
    end
end)

-- Fling Player
MiscTab:CreateButton({
    Name = "Open UI Fling Player",
    Callback = function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/ngm2807-sudo/7155874edfab6e1d774d5017ea0b3018/raw/32e909c874a9a5192fd52fd5afe4579e1c74cdb9/flingplayer.lua"))()
    end,
})

-- Trash-can man
MiscTab:CreateButton({
    Name = "Trash-can man",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/yes1nt/yes/refs/heads/main/Trashcan%20Man",true))()
    end,
})

-- Hitbox expander
MiscTab:CreateButton({
    Name = "Hitbox expander",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/The-Strongest-Battlegrounds-SION-ELTNAM-ATLASIA-61168"))()
    end,
})

-- ===== LOAD CONFIG =====
Rayfield:LoadConfiguration()

-- Thông báo hoàn tất
Rayfield:Notify({
    Title = "ThanhDuy Hub",
    Content = "Loaded successfully!",
    Duration = 3,
    Image = 4483362458,
})