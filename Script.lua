pcall(function()
    local CoreGui = game:GetService("CoreGui")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer

    local spyKeywords = {
        "Block remote", 
        "Clear logs", 
        "Copy code", 
        "Get result", 
        "Ignore remote", 
        "Unblock all remotes",
        "Remote Spy"
    }

    local function ScanUI(obj)
        local detected = false
        for _, v in pairs(obj:GetDescendants()) do
            if v:IsA("TextButton") or v:IsA("TextLabel") then
                for _, keyword in pairs(spyKeywords) do
                    if string.find(string.lower(v.Text), string.lower(keyword)) then 
                        detected = true
                        break
                    end
                end
            end
            if detected then break end
        end

        if detected then
            pcall(function() 
                task.wait(0.5)
                obj:Destroy()
            end)
            LocalPlayer:Kick("anti skid 🖕🖕🖕🖕")
        end
    end

    for _, child in pairs(CoreGui:GetChildren()) do
        ScanUI(child)
    end

    CoreGui.ChildAdded:Connect(function(child)
        ScanUI(child)
    end)

    task.spawn(function()
        while true do
            for _, child in pairs(CoreGui:GetChildren()) do
                ScanUI(child)
            end
            task.wait()
        end
    end)
end)

local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/aljamantugay456-del/Pakyou/refs/heads/main/Fluent.lua"))()

local SaveManager = Fluent.SaveManager
local InterfaceManager = Fluent.InterfaceManager
local FloatingButtonManager = Fluent.FloatingButtonManager

local Window = Fluent:CreateWindow({
    Title = "Venatrix",
    SubTitle = "Diesel n steel",
    TabWidth = 160,
    Size = UDim2.fromOffset(480, 460),
    Acrylic = false,
    Theme = "RGB",
    MinimizeKey = Enum.KeyCode.LeftControl,
    UserInfoTop = true,
    UserInfoTitle = game:GetService("Players").LocalPlayer.DisplayName,
    UserInfoSubtitle = "Venatrix User",
    UserInfoColor = Color3.fromRGB(0, 150, 255),
    Search = true,
})

local HomeTab = Window:AddTab({ Title = "Home", Icon = "home" })
local ShopTab = Window:AddTab({ Title = "Shop", Icon = "shopping-cart" })
local MiscTab = Window:AddTab({ Title = "Misc", Icon = "tool" })
local RolesTab = Window:AddTab({ Title = "Roles", Icon = "users" })
local MusicTab = Window:AddTab({ Title = "Music", Icon = "music" })
local BoostTab = Window:AddTab({ Title = "Boost", Icon = "zap" })
local TeleportTab = Window:AddTab({ Title = "Teleport", Icon = "map-pin" })
local TrollTab = Window:AddTab({ Title = "Troll", Icon = "alert-triangle" })

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local catNet = ReplicatedStorage:WaitForChild("CatNet", 9e9):WaitForChild("Cat", 9e9)
local remotes = ReplicatedStorage:WaitForChild("Remotes", 9e9)

local function setupCharacter(char)
    local head = char:WaitForChild("Head")
    local function block(inst)
        if not inst then return end
        pcall(function()
            if inst:IsA("Sound") then
                inst.Volume = 0
                inst.Playing = false
            end
            if inst.Name == "ChatBubble" then
                for _, v in ipairs(inst:GetDescendants()) do
                    if v:IsA("GuiObject") then
                        v.Visible = false
                    end
                    if v:IsA("BillboardGui") or v:IsA("SurfaceGui") then
                        v.Enabled = false
                    end
                end
                inst.DescendantAdded:Connect(function(v)
                    if v:IsA("GuiObject") then
                        v.Visible = false
                    end
                    if v:IsA("BillboardGui") or v:IsA("SurfaceGui") then
                        v.Enabled = false
                    end
                end)
            end
        end)
    end
    block(head:FindFirstChild("Voice"))
    block(head:FindFirstChild("ChatBubble"))
    head.ChildAdded:Connect(function(child)
        if child.Name == "Voice" or child.Name == "ChatBubble" then
            task.wait()
            block(child)
        end
    end)
    
    local billboardChat = game:GetService("ReplicatedStorage"):FindFirstChild("BillboardGuis")
    if billboardChat then
        local chatBubble = billboardChat:FindFirstChild("ChatBubble")
        if chatBubble then
            for _, v in ipairs(chatBubble:GetDescendants()) do
                if v:IsA("GuiObject") then
                    v.Visible = false
                end
                if v:IsA("BillboardGui") or v:IsA("SurfaceGui") then
                    v.Enabled = false
                end
            end
            chatBubble.DescendantAdded:Connect(function(v)
                if v:IsA("GuiObject") then
                    v.Visible = false
                end
                if v:IsA("BillboardGui") or v:IsA("SurfaceGui") then
                    v.Enabled = false
                end
            end)
        end
    end
end

if LocalPlayer.Character then
    setupCharacter(LocalPlayer.Character)
end
LocalPlayer.CharacterAdded:Connect(setupCharacter)

local blue_gradient = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 100, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 150, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 100, 255))
})

local function ApplyGradientToUI()
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    local function ApplyGradient(v)
        if v:IsA("UIStroke") then
            v.Enabled = true
            v.Color = Color3.fromRGB(0, 150, 255)
            local grad = v:FindFirstChild("PerryGrad") or Instance.new("UIGradient")
            grad.Name = "PerryGrad"
            grad.Color = blue_gradient
            grad.Rotation = 90
            grad.Parent = v
            if v.Parent and (v.Parent:IsA("TextLabel") or v.Parent:IsA("TextButton") or v.Parent:IsA("TextBox")) then
                v.Thickness = 0.8
                v.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
            else
                v.Thickness = 1.0
                v.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            end
            if v.Parent and v.Parent:IsA("GuiObject") then
                v.Parent.BorderSizePixel = 0
            end
        end
    end
    for _, v in pairs(PlayerGui:GetDescendants()) do
        ApplyGradient(v)
    end
    PlayerGui.DescendantAdded:Connect(function(v)
        ApplyGradient(v)
    end)
end

local function SendLog()
    local target = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Screen"):WaitForChild("Labels"):WaitForChild("HungerLabels")
    for _, child in pairs(target:GetChildren()) do
        if child:IsA("GuiObject") or child:IsA("UIComponent") then
            child:Destroy()
        end
    end
    target.BackgroundTransparency = 1
    local f = Instance.new("Frame")
    f.Name = "PerryHub"
    f.Parent = target
    f.Size = UDim2.new(0, 160, 0, 34)
    f.Position = UDim2.new(0, -2, 0, -5)
    f.BackgroundColor3 = Color3.fromRGB(5, 5, 20)
    f.BackgroundTransparency = 0.3
    f.BorderSizePixel = 0
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = f
    local s = Instance.new("UIStroke")
    s.Thickness = 2
    s.Color = Color3.fromRGB(0, 150, 255)
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = f
    local grad = Instance.new("UIGradient")
    grad.Color = blue_gradient
    grad.Rotation = 90
    grad.Parent = s
    local icon = Instance.new("ImageLabel")
    icon.Parent = f
    icon.Size = UDim2.new(0, 45, 0, 18)
    icon.Position = UDim2.new(0, 10, 0.5, -9)
    icon.BackgroundTransparency = 1
    icon.Image = "rbxassetid://102446662507634"
    icon.ScaleType = Enum.ScaleType.Fit
    local title = Instance.new("TextLabel")
    title.Parent = f
    title.Size = UDim2.new(1, -65, 0, 16)
    title.Position = UDim2.new(0, 60, 0, 1)
    title.Text = "Venatrix"
    title.TextColor3 = Color3.fromRGB(0, 150, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 12
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.BackgroundTransparency = 1
    local sub = Instance.new("TextLabel")
    sub.Parent = f
    sub.Size = UDim2.new(1, -65, 0, 16)
    sub.Position = UDim2.new(0, 60, 0, 15)
    sub.Text = "Diesel n steel"
    sub.TextColor3 = Color3.fromRGB(150, 150, 255)
    sub.Font = Enum.Font.GothamBold
    sub.TextSize = 12
    sub.TextXAlignment = Enum.TextXAlignment.Left
    sub.BackgroundTransparency = 1
end

task.spawn(function()
    repeat task.wait(0.5) until LocalPlayer:FindFirstChild("PlayerGui")
    ApplyGradientToUI()
    SendLog()
end)

local autoExpEnabled = false
local autoExpLoop = nil
local massivePassengerEnabled = false
local massivePassengerLoop = nil
local autoKmEnabled = false
local autoKmLoop = nil
local autoCashEnabled = false
local autoCashLoop = nil
local autoCoinEnabled = false
local autoCoinPassengerLoop = nil
local autoCoinRecieveLoop = nil
local autoCoinBarkLoop = nil
local sendCashEnabled = false
local sendCashThreads = {}
local sendAmount = 50000
local selectedTargetPlayer = nil
local dupeEnabled = false
local dupeThreads = {}
local velocityEnabled = false
local fastBreakEnabled = false
local velocityMult = 0.01572
local maxSpeed = 140
local currentSeat = nil
local gasHeld = false
local brakeHeld = false
local wHeld = false
local sHeld = false
local selectedFlingTarget = nil
local selectedHoodJeep = nil
local selectedUnlockJeep = "XLT AUV 12 Seater"
local unlockJeepIndex = "_#1"
local selectedCategory = ""
local selectedOperatorUnit = ""

local jeepModels = {"Sarao Custombuilt Model 2", "DF Devera Long Model", "Morales 10 Seater", "Milwaukee Motor Sport 11 Seater", "XLT AUV 12 Seater"}
local routeList = {"Balagtas - Bulakan", "Guiguinto - Bulakan", "Malolos - Bulakan"}
local barkMessages = {"BULAKAN", "BALAGTAS", "MALOLOS", "GUIGUINTO", "MARAMI PA", "ISA PA", "Kinsehan", "Waluhan", "Magkabilaan po yan", "Pakiusad nalang po sa Kaliwa", "Pakiusad nalang po sa kanan"}
local toolList = {"Hammer", "Engine Oil Can", "Coolant Can", "Metal pipe", "Baseball bat", "Wrench", "Rope", "Diesel can"}
local foodList = {"Betamax", "Calamares", "Isaw", "Water", "Quek Quek", "Hotdog"}

local dupeArgs = { [1] = { [1] = "3", [2] = "RecieveCash", [3] = { ["Value"] = 100, ["Main"] = true, ["Password"] = 649686508 } } }

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PerryDupeGUI"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Enabled = false

local DupeMainFrame = Instance.new("Frame")
DupeMainFrame.Name = "MainFrame"
DupeMainFrame.Parent = ScreenGui
DupeMainFrame.BackgroundTransparency = 0.15
DupeMainFrame.BackgroundColor3 = Color3.fromRGB(0, 50, 100)
DupeMainFrame.Position = UDim2.new(0.5, -120, 0.5, -65)
DupeMainFrame.Size = UDim2.new(0, 240, 0, 130)
DupeMainFrame.BorderSizePixel = 0

local DupeMainCorner = Instance.new("UICorner")
DupeMainCorner.CornerRadius = UDim.new(0, 15)
DupeMainCorner.Parent = DupeMainFrame

local DupeMainGradient = Instance.new("UIGradient")
DupeMainGradient.Color = ColorSequence.new{ ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 80, 160)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 40, 100)) }
DupeMainGradient.Rotation = 45
DupeMainGradient.Parent = DupeMainFrame

local DupeUIStroke = Instance.new("UIStroke")
DupeUIStroke.Parent = DupeMainFrame
DupeUIStroke.Thickness = 1.5
DupeUIStroke.Transparency = 0
DupeUIStroke.Color = Color3.fromRGB(0, 150, 255)

local DupeBorderGradient = Instance.new("UIGradient")
DupeBorderGradient.Color = ColorSequence.new{ ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 100, 200)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 150, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 100, 200)) }
DupeBorderGradient.Parent = DupeUIStroke

task.spawn(function()
    while DupeMainFrame.Parent do
        DupeBorderGradient.Rotation = DupeBorderGradient.Rotation + 1
        task.wait(0.02)
    end
end)

local DupeTitle = Instance.new("TextLabel")
DupeTitle.Name = "Title"
DupeTitle.Parent = DupeMainFrame
DupeTitle.BackgroundTransparency = 1
DupeTitle.Position = UDim2.new(0, 0, 0.05, 0)
DupeTitle.Size = UDim2.new(1, 0, 0.25, 0)
DupeTitle.Font = Enum.Font.FredokaOne
DupeTitle.Text = "Venatrix Dupe Cash"
DupeTitle.TextColor3 = Color3.fromRGB(0, 200, 255)
DupeTitle.TextSize = 20
DupeTitle.ZIndex = 2

local DupeTitleStroke = Instance.new("UIStroke")
DupeTitleStroke.Parent = DupeTitle
DupeTitleStroke.Thickness = 2
DupeTitleStroke.Color = Color3.fromRGB(0, 150, 255)

local DupeToggleButton = Instance.new("TextButton")
DupeToggleButton.Name = "ToggleButton"
DupeToggleButton.Parent = DupeMainFrame
DupeToggleButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
DupeToggleButton.Position = UDim2.new(0.075, 0, 0.45, 0)
DupeToggleButton.Size = UDim2.new(0.85, 0, 0.45, 0)
DupeToggleButton.AutoButtonColor = false
DupeToggleButton.Text = ""

local DupeButtonCorner = Instance.new("UICorner")
DupeButtonCorner.CornerRadius = UDim.new(0, 12)
DupeButtonCorner.Parent = DupeToggleButton

local DupeButtonMainGradient = Instance.new("UIGradient")
DupeButtonMainGradient.Name = "ButtonMainGradient"
DupeButtonMainGradient.Color = ColorSequence.new{ ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 80, 160)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 50, 120)) }
DupeButtonMainGradient.Rotation = 90
DupeButtonMainGradient.Parent = DupeToggleButton

local DupeButtonStroke = Instance.new("UIStroke")
DupeButtonStroke.Parent = DupeToggleButton
DupeButtonStroke.Color = Color3.fromRGB(0, 200, 255)
DupeButtonStroke.Thickness = 1.5
DupeButtonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local DupeButtonBorderGradient = Instance.new("UIGradient")
DupeButtonBorderGradient.Color = ColorSequence.new{ ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 100, 200)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 200, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 100, 200)) }
DupeButtonBorderGradient.Parent = DupeButtonStroke

task.spawn(function()
    while DupeToggleButton.Parent do
        DupeButtonBorderGradient.Rotation = DupeButtonBorderGradient.Rotation - 1
        task.wait(0.02)
    end
end)

local DupeButtonLabel = Instance.new("TextLabel")
DupeButtonLabel.Name = "ButtonLabel"
DupeButtonLabel.Parent = DupeToggleButton
DupeButtonLabel.BackgroundTransparency = 1
DupeButtonLabel.Size = UDim2.new(1, 0, 1, 0)
DupeButtonLabel.Font = Enum.Font.FredokaOne
DupeButtonLabel.Text = "OFF"
DupeButtonLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
DupeButtonLabel.TextSize = 24
DupeButtonLabel.ZIndex = 2

local DupeLabelStroke = Instance.new("UIStroke")
DupeLabelStroke.Parent = DupeButtonLabel
DupeLabelStroke.Thickness = 2
DupeLabelStroke.Color = Color3.fromRGB(0, 150, 255)

local DupeLabelGradient = Instance.new("UIGradient")
DupeLabelGradient.Color = ColorSequence.new{ ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 100, 200)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 200, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 100, 200)) }
DupeLabelGradient.Parent = DupeButtonLabel

task.spawn(function()
    local t = 0
    while DupeButtonLabel.Parent do
        t = t + 0.02
        if t > 1 then t = -1 end
        DupeLabelGradient.Offset = Vector2.new(t, 0)
        task.wait(0.03)
    end
end)

local function startDupe()
    dupeEnabled = true
    for i = 1, 950 do
        local thread = task.spawn(function()
            while dupeEnabled do
                catNet:FireServer(dupeArgs)
                task.wait(0.25)
            end
        end)
        table.insert(dupeThreads, thread)
    end
end

local function stopDupe()
    dupeEnabled = false
    for _, thread in ipairs(dupeThreads) do
        task.cancel(thread)
    end
    dupeThreads = {}
end

local dupeToggled = false
local dupeDb = false

DupeToggleButton.MouseButton1Click:Connect(function()
    if dupeDb then return end
    dupeDb = true
    dupeToggled = not dupeToggled
    if dupeToggled then
        DupeButtonLabel.Text = "ON"
        DupeButtonMainGradient.Color = ColorSequence.new{ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 150, 100)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 100, 50)) }
        startDupe()
        Fluent:Notify({Title = "Dupe Cash", Content = "ENABLED", Duration = 3})
    else
        DupeButtonLabel.Text = "OFF"
        DupeButtonMainGradient.Color = ColorSequence.new{ ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 80, 160)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 50, 120)) }
        stopDupe()
        Fluent:Notify({Title = "Dupe Cash", Content = "DISABLED", Duration = 2})
    end
    task.wait(0.2)
    dupeDb = false
end)

local dupeDragging = false
local dupeDragInput = nil
local dupeDragStart = nil
local dupeStartPos = nil

local function dupeUpdate(input)
    if not dupeDragStart then return end
    local delta = input.Position - dupeDragStart
    local targetPos = UDim2.new(dupeStartPos.X.Scale, dupeStartPos.X.Offset + delta.X, dupeStartPos.Y.Scale, dupeStartPos.Y.Offset + delta.Y)
    TweenService:Create(DupeMainFrame, TweenInfo.new(0.1), {Position = targetPos}):Play()
end

DupeMainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dupeDragging = true
        dupeDragStart = input.Position
        dupeStartPos = DupeMainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dupeDragging = false
                dupeDragStart = nil
            end
        end)
    end
end)

DupeMainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dupeDragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dupeDragInput and dupeDragging then dupeUpdate(input) end
end)

local function getOnlinePlayers()
    local list = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            table.insert(list, player.Name)
        end
    end
    if #list == 0 then table.insert(list, "No Players") end
    return list
end

local function getJeepList()
    local list = {}
    local jeepnies = ReplicatedStorage:FindFirstChild("Jeepnies")
    if jeepnies then
        for _, jeep in pairs(jeepnies:GetChildren()) do
            table.insert(list, jeep.Name)
        end
    end
    if #list == 0 then table.insert(list, "No Jeeps Found") end
    return list
end

local function getOperatorUnits()
    local list = {}
    local operatorJeepneys = workspace:WaitForChild("Map", 9e9):WaitForChild("Misc", 9e9):WaitForChild("OperatorJeepneys", 9e9)
    local mangJuan = operatorJeepneys:FindFirstChild("Mang Juan")
    if mangJuan then
        for _, unit in pairs(mangJuan:GetChildren()) do
            table.insert(list, unit.Name)
        end
    end
    if #list == 0 then table.insert(list, "No units found") end
    return list
end

local function getAttachmentCategories(jeepName)
    local categories = {}
    local attachmentsPath = ReplicatedStorage:FindFirstChild("Jeepnies"):FindFirstChild(jeepName)
    if attachmentsPath then
        attachmentsPath = attachmentsPath:FindFirstChild("Body"):FindFirstChild("Structure"):FindFirstChild("Customizables"):FindFirstChild("Attachments")
        if attachmentsPath then
            for _, folder in pairs(attachmentsPath:GetChildren()) do
                table.insert(categories, folder.Name)
            end
        end
    end
    if #categories == 0 then categories = {"No Categories Found"} end
    return categories
end

local function spawnRole(roleName)
    catNet:FireServer({ [1] = { [1] = "3", [2] = "SpawnCharacter", [3] = { ["Password"] = 157913333, ["Role"] = roleName } } })
    Fluent:Notify({Title = roleName, Content = "Spawned as " .. roleName, Duration = 2})
end

local function teleportTo(position, name)
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local targetCFrame = CFrame.new(position)
    if humanoid and humanoid.SeatPart then
        local jeepFolder = workspace:FindFirstChild("Jeepnies")
        local jeep = jeepFolder and jeepFolder:FindFirstChild(LocalPlayer.Name)
        if jeep then
            local root = jeep.PrimaryPart or jeep:FindFirstChildWhichIsA("BasePart")
            if root then
                jeep:SetPrimaryPartCFrame(targetCFrame)
                Fluent:Notify({Title = "Teleported", Content = "Teleported to " .. name, Duration = 2})
                return
            end
        end
    end
    char:PivotTo(targetCFrame)
    Fluent:Notify({Title = "Teleported", Content = "Teleported to " .. name, Duration = 2})
end

local HomeSection = HomeTab:AddSection("Passenger Features")

HomeSection:AddToggle("AutoExp", {
    Title = "Auto Exp",
    Default = false,
    Callback = function(v)
        autoExpEnabled = v
        if v then
            autoExpLoop = task.spawn(function()
                while autoExpEnabled do
                    catNet:FireServer({ [1] = { [1] = "3", [2] = "Bark", [3] = { ["Password"] = 622233069, ["Route"] = "Balagtas - Bulakan", ["VoiceOver"] = "BALAGTAS", ["GiveExp"] = true, ["MunicipalityOrCity"] = "ToBalagtasTerminalLoadPoint" } } })
                    task.wait()
                end
            end)
            Fluent:Notify({Title = "Auto Exp", Content = "ENABLED", Duration = 2})
        else
            if autoExpLoop then task.cancel(autoExpLoop) end
            Fluent:Notify({Title = "Auto Exp", Content = "DISABLED", Duration = 2})
        end
    end
})

HomeSection:AddToggle("MassivePassenger", {
    Title = "Massive Passenger",
    Default = false,
    Callback = function(v)
        massivePassengerEnabled = v
        if v then
            massivePassengerLoop = task.spawn(function()
                while massivePassengerEnabled do
                    catNet:FireServer({ [1] = { [1] = "3", [2] = "Bark", [3] = { ["Password"] = 622233069, ["Route"] = "Balagtas - Bulakan", ["VoiceOver"] = "BALAGTAS", ["GiveExp"] = false, ["MunicipalityOrCity"] = "ToBalagtasTerminalLoadPoint" } } })
                    task.wait()
                end
            end)
            Fluent:Notify({Title = "Massive Passenger", Content = "ENABLED", Duration = 2})
        else
            if massivePassengerLoop then task.cancel(massivePassengerLoop) end
            Fluent:Notify({Title = "Massive Passenger", Content = "DISABLED", Duration = 2})
        end
    end
})

HomeSection:AddToggle("AutoKm", {
    Title = "Auto Km",
    Default = false,
    Callback = function(v)
        autoKmEnabled = v
        if v then
            autoKmLoop = task.spawn(function()
                while autoKmEnabled do
                    local char = LocalPlayer.Character
                    if char then
                        local hum = char:FindFirstChild("Humanoid")
                        if hum and hum.SeatPart then
                            local car = hum.SeatPart.Parent
                            if car and car:FindFirstChild("Body") then
                                local body = car.Body
                                if body:FindFirstChild("#Weight") then
                                    body.PrimaryPart = body["#Weight"]
                                end
                                local carPrimaryPart = car.PrimaryPart or (body and body["#Weight"])
                                if carPrimaryPart then
                                    local location1 = Vector3.new(-589929299282829, 74, -2940)
                                    local location2 = Vector3.new(-2827827282682, 74, 3171)
                                    while autoKmEnabled do
                                        repeat
                                            if not autoKmEnabled then break end
                                            task.wait()
                                            carPrimaryPart.Velocity = carPrimaryPart.CFrame.LookVector * 5000
                                            car:PivotTo(CFrame.new(carPrimaryPart.Position, location1))
                                        until (char.PrimaryPart.Position - location1).Magnitude < 50 or not autoKmEnabled
                                        if not autoKmEnabled then break end
                                        carPrimaryPart.Velocity = Vector3.new(0,0,0)
                                        task.wait(1)
                                        repeat
                                            if not autoKmEnabled then break end
                                            task.wait()
                                            carPrimaryPart.Velocity = carPrimaryPart.CFrame.LookVector * 5000
                                            car:PivotTo(CFrame.new(carPrimaryPart.Position, location2))
                                        until (char.PrimaryPart.Position - location2).Magnitude < 50 or not autoKmEnabled
                                        if not autoKmEnabled then break end
                                        carPrimaryPart.Velocity = Vector3.new(0,0,0)
                                        task.wait(1)
                                    end
                                end
                            end
                        end
                    end
                    task.wait()
                end
            end)
            Fluent:Notify({Title = "Auto Km", Content = "ENABLED", Duration = 2})
        else
            if autoKmLoop then task.cancel(autoKmLoop) end
            Fluent:Notify({Title = "Auto Km", Content = "DISABLED", Duration = 2})
        end
    end
})

HomeSection:AddToggle("AutoCash", {
    Title = "Auto Cash",
    Default = false,
    Callback = function(v)
        autoCashEnabled = v
        if v then
            autoCashLoop = task.spawn(function()
                local function autoCash()
                    while autoCashEnabled do
                        catNet:FireServer({ [1] = { [1] = "3", [2] = "BuyJeepney", [3] = { ["Password"] = 768886465, ["JeepneyName"] = "Sarao Custombuilt Model 2" } } })
                        remotes:WaitForChild("GetDataStore"):InvokeServer()
                        remotes:WaitForChild("CloseCustomize"):FireServer({ ["Password"] = 590460131, ["NewOwnedParts"] = { ["BA - 05"] = 100, ["BA - 01"] = 100, ["BA - 03"] = 100, ["4-Speed Manual"] = 100, ["6-Speed Manual"] = 100, ["5-Speed Manual"] = 100, ["CL - 02"] = 100, ["TO - 01"] = 100, ["4HK1 Twin Turbo"] = 100, ["4JJ1"] = 100, ["4HK1 Single Turbo"] = 100, ["4BC2"] = 100, ["4HE1 Single Turbo"] = 100, ["4-Speed Manual (High Ratio)"] = 100, ["T - 01 (F)"] = 100, ["EO - 01"] = 100, ["T - 05 (R)"] = 100, ["T - 03 (R)"] = 100, ["TO - 03"] = 100, ["EO - 03"] = 100, ["TO - 05"] = 100, ["EO - 05"] = 100, ["4HF1 Twin Turbo"] = 100, ["TO - 02"] = 100, ["C - 04"] = 100, ["BA - 02"] = 100, ["EO - 04"] = 100, ["T - 04 (R)"] = 100, ["C - 02"] = 100, ["BA - 04"] = 100, ["T - 02 (F)"] = 100, ["EO - 02"] = 100, ["B - 05"] = 100, ["R - 01"] = 100, ["BF - 02"] = 100, ["C - 03"] = 100, ["B - 03"] = 100, ["BF - 01"] = 100, ["T - 05 (F)"] = 100, ["4-Speed Manual"] = 100, ["B - 04"] = 100, ["TO - 04"] = 100, ["4JK1"] = 100, ["CL - 01"] = 100, ["T - 01 (R)"] = 100, ["R - 02"] = 100, ["B - 02"] = 100, ["4BE1"] = 100, ["T - 04 (F)"] = 100, ["B - 01"] = 100, ["T - 03 (F)"] = 100, ["D - 01"] = 100, ["C - 01"] = 100 }, ["NewPartsStatus"] = { ["FrontTiresHealth"] = 100, ["DifferentialHealth"] = 100, ["ClutchHealth"] = 100, ["TransmissionHealth"] = 100, ["TransmissionOil"] = 100, ["CoolantLevel"] = 100, ["BrakeHealth"] = 100, ["BrakeFluid"] = 100, ["RearTiresHealth"] = 100, ["BatteryHealth"] = 100, ["RadiatorHealth"] = 100, ["EngineOil"] = 100, ["EngineHealth"] = 100 }, ["JeepneyName"] = "Sarao Custombuilt Model 2_#1", ["NewEquippedParts"] = { ["Clutch"] = "CL - 01", ["Brake"] = "B - 01", ["Differential"] = "D - 01", ["Battery"] = "BA - 01", ["Transmission"] = "4-Speed Manual", ["Coolant"] = "C - 01", ["TransmissionOil"] = "TO - 01", ["RearTires"] = "T - 01 (R)", ["Radiator"] = "R - 01", ["BrakeFluid"] = "BF - 01", ["FrontTires"] = "T - 01 (F)", ["EngineOil"] = "EO - 01", ["Engine"] = "4BC2" } })
                        catNet:FireServer({ [1] = { [1] = "3", [2] = "SpawnJeepney", [3] = { ["Password"] = 596586371, ["Garage"] = workspace.Map.Misc.Garages.Bulakan, ["Route"] = "Balagtas - Bulakan", ["JeepneyName"] = "Sarao Custombuilt Model 2_#1" } } })
                        catNet:FireServer({ [1] = { [1] = "3", [2] = "SellJeepney", [3] = { ["Index"] = "Sarao Custombuilt Model 2_#1" } } })
                        task.wait()
                    end
                end
                autoCash()
                task.wait(1)
                autoCash()
                task.wait(1)
                autoCash()
            end)
            Fluent:Notify({Title = "Auto Cash", Content = "ENABLED", Duration = 2})
        else
            if autoCashLoop then task.cancel(autoCashLoop) end
            Fluent:Notify({Title = "Auto Cash", Content = "DISABLED", Duration = 2})
        end
    end
})

HomeSection:AddToggle("AutoCoin", {
    Title = "Auto Coin",
    Default = false,
    Callback = function(v)
        autoCoinEnabled = v
        if v then
            autoCoinPassengerLoop = task.spawn(function()
                while autoCoinEnabled do
                    local Jeepney = workspace:WaitForChild("Jeepnies", 9e9):WaitForChild(LocalPlayer.Name, 9e9)
                    local Passengers = workspace:WaitForChild("Passengers", 9e9)
                    
                    local function getPassengersInsideJeep()
                        local insidePassengers = {}
                        local jeepRoot = Jeepney.PrimaryPart or Jeepney:FindFirstChildWhichIsA("BasePart")
                        
                        if not jeepRoot then
                            return insidePassengers
                        end
                        
                        local jeepPos = jeepRoot.Position
                        
                        for _, passenger in pairs(Passengers:GetChildren()) do
                            local passengerRoot = passenger:FindFirstChild("HumanoidRootPart") or passenger:FindFirstChild("Head")
                            if passengerRoot then
                                local distance = (passengerRoot.Position - jeepPos).Magnitude
                                if distance < 20 then
                                    table.insert(insidePassengers, passenger)
                                end
                            end
                        end
                        return insidePassengers
                    end
                    
                    local passengersInside = getPassengersInsideJeep()
                    
                    if #passengersInside > 0 then
                        local passenger = passengersInside[math.random(1, #passengersInside)]
                        catNet:FireServer({ [1] = { [1] = "3", [2] = "PassengerChatted", [3] = { ["Password"] = 410501933, ["Character"] = passenger, ["Text"] = "Manong sobra ho sukli." } } })
                    end
                    
                    task.wait()
                end
            end)
            
            autoCoinRecieveLoop = task.spawn(function()
                while autoCoinEnabled do
                    local Jeepney = workspace:WaitForChild("Jeepnies", 9e9):WaitForChild(LocalPlayer.Name, 9e9)
                    local Passengers = workspace:WaitForChild("Passengers", 9e9)
                    
                    local function getPassengersInsideJeep()
                        local insidePassengers = {}
                        local jeepRoot = Jeepney.PrimaryPart or Jeepney:FindFirstChildWhichIsA("BasePart")
                        
                        if not jeepRoot then
                            return insidePassengers
                        end
                        
                        local jeepPos = jeepRoot.Position
                        
                        for _, passenger in pairs(Passengers:GetChildren()) do
                            local passengerRoot = passenger:FindFirstChild("HumanoidRootPart") or passenger:FindFirstChild("Head")
                            if passengerRoot then
                                local distance = (passengerRoot.Position - jeepPos).Magnitude
                                if distance < 20 then
                                    table.insert(insidePassengers, passenger)
                                end
                            end
                        end
                        return insidePassengers
                    end
                    
                    local passengersInside = getPassengersInsideJeep()
                    
                    if #passengersInside > 0 then
                        catNet:FireServer({ [1] = { [1] = "3", [2] = "RecieveCoin", [3] = { ["Value"] = 300, ["PassengerValues"] = Jeepney:WaitForChild("PassengerValues", 9e9), ["Password"] = 410501933 } } })
                    end
                    
                    task.wait()
                end
            end)
            
            autoCoinBarkLoop = task.spawn(function()
                while autoCoinEnabled do
                    catNet:FireServer({ [1] = { [1] = "3", [2] = "Bark", [3] = { ["Password"] = 622233069, ["Route"] = "Balagtas - Bulakan", ["VoiceOver"] = "BALAGTAS", ["GiveExp"] = false, ["MunicipalityOrCity"] = "ToBalagtasTerminalLoadPoint" } } })
                    task.wait(0.5)
                end
            end)
            
            Fluent:Notify({Title = "Auto Coin", Content = "ENABLED", Duration = 2})
        else
            if autoCoinPassengerLoop then task.cancel(autoCoinPassengerLoop) end
            if autoCoinRecieveLoop then task.cancel(autoCoinRecieveLoop) end
            if autoCoinBarkLoop then task.cancel(autoCoinBarkLoop) end
            Fluent:Notify({Title = "Auto Coin", Content = "DISABLED", Duration = 2})
        end
    end
})

HomeSection:AddButton({
    Title = "Unload All",
    Callback = function()
        local Passengers = workspace:WaitForChild("Passengers", 9e9)
        local fixedDestination = workspace.Map.Misc.PassengerSpawnPoints["Malolos - Bulakan"].BulakanTerminalDropPoint
        
        local function getJeepney()
            local jeepFolder = workspace:FindFirstChild("Jeepnies")
            if jeepFolder then
                return jeepFolder:FindFirstChild(LocalPlayer.Name)
            end
            return nil
        end
        
        local function getSeat(jeep)
            if jeep and jeep:FindFirstChild("Body") then
                local functionalStuff = jeep.Body:FindFirstChild("FunctionalStuff")
                if functionalStuff and functionalStuff:FindFirstChild("Seats") then
                    local seats = functionalStuff.Seats:GetChildren()
                    return seats[14]
                end
            end
            return nil
        end
        
        local function getPassengersInsideJeep(jeep)
            local insidePassengers = {}
            local jeepRoot = jeep.PrimaryPart or jeep:FindFirstChildWhichIsA("BasePart")
            
            if not jeepRoot then
                return insidePassengers
            end
            
            local jeepPos = jeepRoot.Position
            
            for _, passenger in pairs(Passengers:GetChildren()) do
                local passengerRoot = passenger:FindFirstChild("HumanoidRootPart") or passenger:FindFirstChild("Head")
                if passengerRoot then
                    local distance = (passengerRoot.Position - jeepPos).Magnitude
                    if distance < 20 then
                        table.insert(insidePassengers, passenger)
                    end
                end
            end
            return insidePassengers
        end
        
        local currentJeepney = getJeepney()
        local currentSeat = getSeat(currentJeepney)
        
        if currentJeepney and currentSeat then
            local passengersInside = getPassengersInsideJeep(currentJeepney)
            local payload = {}
            
            for _, passenger in pairs(passengersInside) do
                table.insert(payload, {
                    [1] = "3",
                    [2] = "UnloadPassenger",
                    [3] = {
                        ["Seat"] = currentSeat,
                        ["Passenger"] = passenger,
                        ["Password"] = 349161876,
                        ["Jeepney"] = currentJeepney,
                        ["Destination"] = fixedDestination,
                    },
                })
            end
            
            if #payload > 0 then
                catNet:FireServer(payload)
                Fluent:Notify({Title = "Unload All", Content = "Unloaded " .. #payload .. " passengers", Duration = 3})
            else
                Fluent:Notify({Title = "Unload All", Content = "No passengers found inside jeep", Duration = 3})
            end
            
            task.wait(10)
            
            game:GetService("ReplicatedStorage").Remotes.DespawnJeepney:FireServer({
                ["NotOPTR"] = true,
                ["Jeepney"] = currentJeepney,
            })
            
            task.wait()
            
            local selectedPlayerJeep = "DF Devera Long Model"
            local selectedPlayerRoute = "Malolos - Bulakan"
            local selectedPlayerIndex = "_#1"
            local jeepFullName = selectedPlayerJeep .. selectedPlayerIndex
            
            remotes:WaitForChild("SpawnOperatorJeepney", 9e9):FireServer({
                ["JeepneyStore"] = {
                    ["ChassisNumber"] = "DNS.-5430487",
                    ["Fuel"] = 5,
                    ["Tune"] = { ["FrontDampening"] = 0.9676249027252197, ["RearDampening"] = 0.41008758544921875, ["RearHeight"] = 0.09258568286895752, ["RearStiffness"] = 0.811918318271637, ["FrontHeight"] = 0.03237512707710266, ["FrontStiffness"] = 0.6782255172729492 },
                    ["EquippedAttachments"] = { "Rim - 01 (FL)", "Metal Dashboard", "Rim - 01 (FR)", "Primary Horn - 01", "Default Side Mirror", "Default Dashboard", "Rim - 02 (RL)", "Default Visor", "Default Rearview Mirror", "Default Car Seat", "Default Hood", "Basic Rear Lights Pack", "Basic Front Blinkers", "Bench Type", "Default Placard Holder", "Basic Roof Support", "Default Interior Light", "Shifter - 01", "Round Headlight", "Steering Wheel - 01", "Rim - 02 (RR)", "5 Divider Lamigo Muffler" },
                    ["BeingOperated"] = true,
                    ["EquippedParts"] = { ["Clutch"] = "CL - 02", ["Brake"] = "B - 05", ["Differential"] = "D - 01", ["Battery"] = "BA - 03", ["Transmission"] = "4-Speed Manual (High Ratio)", ["Coolant"] = "C - 04", ["Radiator"] = "R - 02", ["BrakeFluid"] = "BF - 02", ["TransmissionOil"] = "TO - 05", ["RearTires"] = "T - 03 (R)", ["FrontTires"] = "T - 03 (F)", ["EngineOil"] = "EO - 05", ["Engine"] = "4HK1 Twin Turbo" },
                    ["PlateNumber"] = "CWX 137",
                    ["Guiguinto"] = "rbxassetid://114600621685336",
                    ["DriverName"] = LocalPlayer.Name,
                    ["Decals"] = {},
                    ["OwnedAttachments"] = {},
                    ["PartsStatus"] = { ["FrontTiresHealth"] = 100, ["DifferentialHealth"] = 100, ["TransmissionOil"] = 100, ["TransmissionHealth"] = 100, ["RadiatorHealth"] = 100, ["CoolantLevel"] = 100, ["BrakeHealth"] = 100, ["EngineHealth"] = 100, ["BatteryHealth"] = 100, ["RearTiresHealth"] = 100, ["BrakeFluid"] = 100, ["EngineOil"] = 100, ["ClutchHealth"] = 100 },
                    ["UnitName"] = "My Custom Jeep",
                    ["Route"] = selectedPlayerRoute,
                    ["ModelName"] = jeepFullName,
                    ["Mileage"] = 4,
                    ["Bulakan"] = "rbxassetid://94850207143039",
                    ["Colors"] = {},
                    ["OperatorUserId"] = 10223003929,
                    ["Rehistro"] = false,
                    ["Balagtas"] = "rbxassetid://105606854418605",
                    ["OwnedParts"] = {},
                    ["Malolos"] = "rbxassetid://78090237780822",
                },
                ["JeepneyName"] = selectedPlayerJeep,
            })
            
            Fluent:Notify({Title = "Reset", Content = "DF Devera Long Model spawned", Duration = 2})
            
            task.wait(10)
            
            teleportTo(Vector3.new(-1267, 13, -3035), "Reset Location")
            
            task.wait(1)
            
            local newJeep = workspace:FindFirstChild("Jeepnies"):FindFirstChild(LocalPlayer.Name)
            
            if newJeep then
                game:GetService("ReplicatedStorage").CatNet.Cat:FireServer({
                    [1] = {
                        [1] = "3",
                        [2] = "JoinQueue",
                        [3] = {
                            ["Password"] = 907312169,
                            ["Join"] = true,
                            ["BoundBox"] = workspace.Map.Misc.QueueBoundBoxes["Malolos - Bulakan"].Bulakan,
                            ["Jeepney"] = newJeep,
                        },
                    },
                })
                Fluent:Notify({Title = "Queue", Content = "Joined queue!", Duration = 2})
            end
            
            Fluent:Notify({Title = "Complete", Content = "Teleported to location and joined queue!", Duration = 3})
        else
            Fluent:Notify({Title = "Unload All", Content = "Jeep or seat not found", Duration = 3})
        end
    end
})

HomeSection:AddToggle("FixSpawnBug", {
    Title = "Fix Spawn Bug",
    Default = false,
    Callback = function(v)
        if v then
            local char = LocalPlayer.Character
            if not char then return end
            
            local humanoid = char:FindFirstChild("Humanoid")
            local rootPart = char:FindFirstChild("HumanoidRootPart")
            
            if humanoid and rootPart then
                humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
                task.wait(0.1)
                humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                
                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
                bodyVelocity.Parent = rootPart
                
                local bodyGyro = Instance.new("BodyGyro")
                bodyGyro.MaxTorque = Vector3.new(4000, 4000, 4000)
                bodyGyro.Parent = rootPart
                
                humanoid.AutoRotate = false
                
                local flySpeed = 1
                local flying = true
                
                local function onKeyPress(input, processed)
                    if processed then return end
                    if not flying then return end
                    
                    local moveDirection = Vector3.new(0, 0, 0)
                    
                    if input.KeyCode == Enum.KeyCode.W then
                        moveDirection = moveDirection + rootPart.CFrame.LookVector
                    elseif input.KeyCode == Enum.KeyCode.S then
                        moveDirection = moveDirection - rootPart.CFrame.LookVector
                    elseif input.KeyCode == Enum.KeyCode.A then
                        moveDirection = moveDirection - rootPart.CFrame.RightVector
                    elseif input.KeyCode == Enum.KeyCode.D then
                        moveDirection = moveDirection + rootPart.CFrame.RightVector
                    elseif input.KeyCode == Enum.KeyCode.Space then
                        moveDirection = moveDirection + Vector3.new(0, 1, 0)
                    elseif input.KeyCode == Enum.KeyCode.LeftControl then
                        moveDirection = moveDirection + Vector3.new(0, -1, 0)
                    end
                    
                    if moveDirection ~= Vector3.new(0, 0, 0) then
                        bodyVelocity.Velocity = moveDirection * flySpeed
                    else
                        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                    end
                end
                
                local connection = UserInputService.InputBegan:Connect(onKeyPress)
                
                LocalPlayer.CharacterAdded:Connect(function()
                    flying = false
                    pcall(function()
                        bodyVelocity:Destroy()
                        bodyGyro:Destroy()
                    end)
                    if humanoid then
                        humanoid.AutoRotate = true
                    end
                    connection:Disconnect()
                end)
            end
            
            Fluent:Notify({Title = "Fix Spawn Bug", Content = "ENABLED - Fly Mode (Speed 1)", Duration = 3})
        else
            local char = LocalPlayer.Character
            if char then
                local rootPart = char:FindFirstChild("HumanoidRootPart")
                local humanoid = char:FindFirstChild("Humanoid")
                
                if rootPart then
                    local vel = rootPart:FindFirstChild("BodyVelocity")
                    if vel then vel:Destroy() end
                    local gyro = rootPart:FindFirstChild("BodyGyro")
                    if gyro then gyro:Destroy() end
                end
                
                if humanoid then
                    humanoid.AutoRotate = true
                end
            end
            
            Fluent:Notify({Title = "Fix Spawn Bug", Content = "DISABLED", Duration = 2})
        end
    end
})

HomeSection:AddToggle("DupeCashToggle", {
    Title = "Dupe Cash GUI",
    Default = false,
    Callback = function(v)
        ScreenGui.Enabled = v
        Fluent:Notify({Title = "Dupe GUI", Content = v and "Opened" or "Closed", Duration = 2})
    end
})

local SendSection = HomeTab:AddSection("Send to Players")

HomeSection:AddInput("SendAmount", {
    Title = "Amount to Send",
    Placeholder = "50000",
    Numeric = true,
    Callback = function(v)
        local num = tonumber(v)
        if num and num > 0 then sendAmount = num end
    end
})

local targetPlayerDrop = HomeSection:AddDropdown("TargetPlayer", {
    Title = "Target Player",
    Values = getOnlinePlayers(),
    Callback = function(v)
        if v and v ~= "No Players" then selectedTargetPlayer = v end
    end
})

HomeSection:AddButton({
    Title = "Refresh Players",
    Callback = function()
        targetPlayerDrop:SetValues(getOnlinePlayers())
        Fluent:Notify({Title = "Refreshed", Content = "Player list updated", Duration = 2})
    end
})

HomeSection:AddToggle("SendCash", {
    Title = "Send Cash",
    Default = false,
    Callback = function(v)
        sendCashEnabled = v
        if v then
            if not selectedTargetPlayer or selectedTargetPlayer == "No Players" then
                Fluent:Notify({Title = "Error", Content = "Select a player first!", Duration = 3})
                return
            end
            for i = 1, 600 do
                local thread = task.spawn(function()
                    while sendCashEnabled do
                        local targetPlayer = Players:FindFirstChild(selectedTargetPlayer)
                        if targetPlayer then
                            catNet:FireServer({ [1] = { [1] = "3", [2] = "SendCash", [3] = { ["Value"] = sendAmount, ["OtherPlayer"] = targetPlayer, ["Password"] = 988167864 } } })
                        end
                        task.wait()
                    end
                end)
                table.insert(sendCashThreads, thread)
            end
            Fluent:Notify({Title = "Send Cash", Content = "Sending cash to " .. selectedTargetPlayer, Duration = 3})
        else
            for _, thread in ipairs(sendCashThreads) do task.cancel(thread) end
            sendCashThreads = {}
            Fluent:Notify({Title = "Send Cash", Content = "Stopped", Duration = 2})
        end
    end
})

local HomeOperatorSection = HomeTab:AddSection("Operator Jeepney Spawner")

local unitDrop = HomeOperatorSection:AddDropdown("SelectUnit", {
    Title = "Select Unit",
    Values = getOperatorUnits(),
    Callback = function(v)
        selectedOperatorUnit = v
    end
})

HomeOperatorSection:AddButton({
    Title = "Refresh Units",
    Callback = function()
        unitDrop:SetValues(getOperatorUnits())
        Fluent:Notify({Title = "Refreshed", Content = "Unit list updated", Duration = 2})
    end
})

HomeOperatorSection:AddButton({
    Title = "Spawn Operator Jeepney",
    Callback = function()
        if selectedOperatorUnit and selectedOperatorUnit ~= "No units found" and selectedOperatorUnit ~= "" then
            local operatorJeepneys = workspace:WaitForChild("Map", 9e9):WaitForChild("Misc", 9e9):WaitForChild("OperatorJeepneys", 9e9)
            local mangJuan = operatorJeepneys:FindFirstChild("Mang Juan")
            remotes:WaitForChild("SpawnOperatorNPCJeepney", 9e9):FireServer({
                ["OperatorNpc"] = mangJuan,
                ["JeepneyName"] = "Sarao Custombuilt Model 2",
                ["UnitName"] = selectedOperatorUnit,
            })
            Fluent:Notify({Title = "Spawned!", Content = "Spawned unit: " .. selectedOperatorUnit, Duration = 2})
        end
    end
})

local HomeJeepSection = HomeTab:AddSection("Jeep Player Spawner")

local selectedPlayerJeep = ""
local selectedPlayerRoute = routeList[1]
local selectedPlayerIndex = "_#1"

local jeepDrop = HomeJeepSection:AddDropdown("SelectJeep", {
    Title = "Select Jeep",
    Values = getJeepList(),
    Callback = function(v)
        if v and v ~= "No Jeeps Found" then selectedPlayerJeep = v end
    end
})

HomeJeepSection:AddInput("JeepIndex", {
    Title = "Jeep Index",
    Placeholder = "_#1, _#2, etc.",
    Default = "_#1",
    Callback = function(v)
        selectedPlayerIndex = v
    end
})

local routeDrop = HomeJeepSection:AddDropdown("SelectRoute", {
    Title = "Select Route",
    Values = routeList,
    Callback = function(v)
        selectedPlayerRoute = v
    end
})

HomeJeepSection:AddButton({
    Title = "Refresh Jeep List",
    Callback = function()
        jeepDrop:SetValues(getJeepList())
        Fluent:Notify({Title = "Refreshed", Content = "Jeep list updated", Duration = 2})
    end
})

HomeJeepSection:AddButton({
    Title = "Spawn Jeep",
    Callback = function()
        if not selectedPlayerJeep or selectedPlayerJeep == "" or selectedPlayerJeep == "No Jeeps Found" then
            Fluent:Notify({Title = "Error", Content = "Select a jeep first!", Duration = 2})
            return
        end
        local jeepFullName = selectedPlayerJeep .. selectedPlayerIndex
        remotes:WaitForChild("SpawnOperatorJeepney", 9e9):FireServer({
            ["JeepneyStore"] = {
                ["ChassisNumber"] = "DNS.-5430487",
                ["Fuel"] = 5,
                ["Tune"] = { ["FrontDampening"] = 0.9676249027252197, ["RearDampening"] = 0.41008758544921875, ["RearHeight"] = 0.09258568286895752, ["RearStiffness"] = 0.811918318271637, ["FrontHeight"] = 0.03237512707710266, ["FrontStiffness"] = 0.6782255172729492 },
                ["EquippedAttachments"] = { "Rim - 01 (FL)", "Metal Dashboard", "Rim - 01 (FR)", "Primary Horn - 01", "Default Side Mirror", "Default Dashboard", "Rim - 02 (RL)", "Default Visor", "Default Rearview Mirror", "Default Car Seat", "Default Hood", "Basic Rear Lights Pack", "Basic Front Blinkers", "Bench Type", "Default Placard Holder", "Basic Roof Support", "Default Interior Light", "Shifter - 01", "Round Headlight", "Steering Wheel - 01", "Rim - 02 (RR)", "5 Divider Lamigo Muffler" },
                ["BeingOperated"] = true,
                ["EquippedParts"] = { ["Clutch"] = "CL - 02", ["Brake"] = "B - 05", ["Differential"] = "D - 01", ["Battery"] = "BA - 03", ["Transmission"] = "4-Speed Manual (High Ratio)", ["Coolant"] = "C - 04", ["Radiator"] = "R - 02", ["BrakeFluid"] = "BF - 02", ["TransmissionOil"] = "TO - 05", ["RearTires"] = "T - 03 (R)", ["FrontTires"] = "T - 03 (F)", ["EngineOil"] = "EO - 05", ["Engine"] = "4HK1 Twin Turbo" },
                ["PlateNumber"] = "CWX 137",
                ["Guiguinto"] = "rbxassetid://114600621685336",
                ["DriverName"] = LocalPlayer.Name,
                ["Decals"] = {},
                ["OwnedAttachments"] = {},
                ["PartsStatus"] = { ["FrontTiresHealth"] = 100, ["DifferentialHealth"] = 100, ["TransmissionOil"] = 100, ["TransmissionHealth"] = 100, ["RadiatorHealth"] = 100, ["CoolantLevel"] = 100, ["BrakeHealth"] = 100, ["EngineHealth"] = 100, ["BatteryHealth"] = 100, ["RearTiresHealth"] = 100, ["BrakeFluid"] = 100, ["EngineOil"] = 100, ["ClutchHealth"] = 100 },
                ["UnitName"] = "My Custom Jeep",
                ["Route"] = selectedPlayerRoute,
                ["ModelName"] = jeepFullName,
                ["Mileage"] = 4,
                ["Bulakan"] = "rbxassetid://94850207143039",
                ["Colors"] = {},
                ["OperatorUserId"] = 10223003929,
                ["Rehistro"] = false,
                ["Balagtas"] = "rbxassetid://105606854418605",
                ["OwnedParts"] = {},
                ["Malolos"] = "rbxassetid://78090237780822",
            },
            ["JeepneyName"] = selectedPlayerJeep,
        })
        Fluent:Notify({Title = "Jeep Spawned", Content = "Spawned " .. selectedPlayerJeep .. " on route " .. selectedPlayerRoute, Duration = 3})
    end
})

local CPCSection = HomeTab:AddSection("CPC Application")

local cpcJeepList = {"Sarao Custombuilt Model 2", "DF Devera Long Model", "Morales 10 Seater", "Milwaukee Motor Sport 11 Seater", "XLT AUV 12 Seater"}
local selectedCPCJeep = cpcJeepList[1]
local selectedCPCRoute = routeList[1]
local selectedCPCIndex = "_#1"

CPCSection:AddDropdown("SelectCPCJeep", {
    Title = "Select Jeep for CPC",
    Values = cpcJeepList,
    Callback = function(v) selectedCPCJeep = v end
})

CPCSection:AddInput("CPCJeepIndex", {
    Title = "Jeep Index",
    Placeholder = "_#1, _#2, etc.",
    Default = "_#1",
    Callback = function(v) selectedCPCIndex = v end
})

CPCSection:AddDropdown("SelectCPCRoute", {
    Title = "Select Route for CPC",
    Values = routeList,
    Callback = function(v) selectedCPCRoute = v end
})

CPCSection:AddButton({
    Title = "Apply CPC",
    Callback = function()
        local jeepFullName = selectedCPCJeep .. selectedCPCIndex
        remotes:WaitForChild("ApplyForCPC", 9e9):FireServer({ ["Yes_Or_No"] = true, ["JeepneyName"] = jeepFullName, ["Route"] = selectedCPCRoute })
        Fluent:Notify({Title = "CPC Applied", Content = "Applied CPC for " .. jeepFullName, Duration = 3})
    end
})

CPCSection:AddButton({
    Title = "Remove CPC Badge",
    Callback = function()
        local jeepFullName = selectedCPCJeep .. selectedCPCIndex
        remotes:WaitForChild("ApplyForCPC", 9e9):FireServer({ ["Yes_Or_No"] = false, ["JeepneyName"] = jeepFullName })
        Fluent:Notify({Title = "CPC Removed", Content = "Removed CPC badge for " .. jeepFullName, Duration = 3})
    end
})

local ShopSection = ShopTab:AddSection("Jeepney Shop")

for _, jeep in ipairs(jeepModels) do
    ShopSection:AddButton({
        Title = jeep,
        Callback = function()
            catNet:FireServer({ [1] = { [1] = "3", [2] = "BuyJeepney", [3] = { ["JeepneyName"] = jeep, ["Password"] = 800584595 } } })
            task.wait(0.5)
            remotes:WaitForChild("GetDataStore"):InvokeServer()
            task.wait(0.3)
            remotes:WaitForChild("CloseCustomize", 9e9):FireServer({ ["Password"] = 332271450, ["NewOwnedParts"] = { ["BA - 05"] = 100, ["BA - 01"] = 100, ["BA - 03"] = 100, ["4-Speed Manual"] = 100, ["6-Speed Manual"] = 100, ["5-Speed Manual"] = 100, ["C - 04"] = 100, ["B - 04"] = 100, ["EO - 03"] = 100, ["4JJ1"] = 100, ["4HK1 Single Turbo"] = 100, ["4JK1"] = 100, ["4HE1 Single Turbo"] = 100, ["4-Speed Manual (High Ratio)"] = 100, ["T - 01 (F)"] = 100, ["EO - 01"] = 100, ["T - 05 (R)"] = 100, ["T - 03 (R)"] = 100, ["EO - 05"] = 100, ["T - 04 (R)"] = 100, ["T - 02 (R)"] = 100, ["R - 02"] = 100, ["TO - 05"] = 100, ["TO - 04"] = 100, ["TO - 03"] = 100, ["BA - 02"] = 100, ["EO - 04"] = 100, ["B - 02"] = 100, ["C - 02"] = 100, ["BA - 04"] = 100, ["T - 02 (F)"] = 100, ["EO - 02"] = 100, ["T - 04 (F)"] = 100, ["R - 01"] = 100, ["TO - 02"] = 100, ["T - 03 (F)"] = 100, ["B - 03"] = 100, ["BF - 01"] = 100, ["T - 05 (F)"] = 100, ["TO - 01"] = 100, ["B - 05"] = 100, ["CL - 01"] = 100, ["4BC2"] = 100, ["CL - 02"] = 100, ["T - 01 (R)"] = 100, ["BF - 02"] = 100, ["C - 03"] = 100, ["4BE1"] = 100, ["4HK1 Twin Turbo"] = 100, ["B - 01"] = 100, ["4HF1 Twin Turbo"] = 100, ["D - 01"] = 100, ["C - 01"] = 100 }, ["NewPartsStatus"] = { ["FrontTiresHealth"] = 100, ["DifferentialHealth"] = 100, ["ClutchHealth"] = 100, ["TransmissionHealth"] = 100, ["RadiatorHealth"] = 100, ["CoolantLevel"] = 100, ["BrakeHealth"] = 100, ["EngineHealth"] = 100, ["RearTiresHealth"] = 100, ["BrakeFluid"] = 100, ["TransmissionOil"] = 100, ["EngineOil"] = 100, ["BatteryHealth"] = 100 }, ["JeepneyName"] = jeep .. "_#1", ["NewEquippedParts"] = { ["Clutch"] = "CL - 01", ["Brake"] = "B - 01", ["Differential"] = "D - 01", ["Engine"] = "4HK1 Twin Turbo", ["Transmission"] = "4-Speed Manual (High Ratio)", ["Coolant"] = "C - 01", ["BrakeFluid"] = "BF - 01", ["RearTires"] = "T - 01 (R)", ["TransmissionOil"] = "TO - 01", ["Battery"] = "BA - 01", ["Radiator"] = "R - 01", ["EngineOil"] = "EO - 01", ["FrontTires"] = "T - 01 (F)" } })
            Fluent:Notify({Title = "Bought!", Content = "Bought and upgraded " .. jeep, Duration = 3})
        end
    })
end

local ToolSection = ShopTab:AddSection("Tools Shop")

local selectedTool = "Hammer"

ToolSection:AddDropdown("SelectTool", {
    Title = "Select Tool",
    Values = toolList,
    Callback = function(v) selectedTool = v end
})

ToolSection:AddButton({
    Title = "Buy Selected Tool",
    Callback = function()
        remotes:WaitForChild("BuyTool", 9e9):InvokeServer({ ["Password"] = 517660391, ["ToolName"] = selectedTool })
        Fluent:Notify({Title = "Bought!", Content = "Bought " .. selectedTool, Duration = 2})
    end
})

local FoodSection = ShopTab:AddSection("Food Shop")

local selectedFood = "Isaw"

FoodSection:AddDropdown("SelectFood", {
    Title = "Select Food",
    Values = foodList,
    Callback = function(v) selectedFood = v end
})

FoodSection:AddButton({
    Title = "Buy Selected Food",
    Callback = function()
        remotes:WaitForChild("BuyFood", 9e9):InvokeServer({ ["Password"] = 598785065, ["FoodName"] = selectedFood })
        Fluent:Notify({Title = "Bought!", Content = "Bought " .. selectedFood, Duration = 2})
    end
})

local MiscSection = MiscTab:AddSection("Utilities")

MiscSection:AddButton({ Title = "Get Licence", Callback = function()
    catNet:FireServer({ [1] = { [1] = "3", [2] = "PassedTheExam", [3] = { ["Password"] = 157913333 } } })
    Fluent:Notify({Title = "Licence", Content = "You got your licence!", Duration = 2})
end })

MiscSection:AddButton({ Title = "Complete Tutorial", Callback = function()
    catNet:FireServer({ [1] = { [1] = "3", [2] = "CompletedTutorial", [3] = { ["Password"] = 157913333 } } })
    Fluent:Notify({Title = "Tutorial", Content = "Tutorial completed!", Duration = 2})
end })

MiscSection:AddButton({ Title = "Register Jeep", Callback = function()
    remotes:WaitForChild("RegisterJeepney", 9e9):FireServer({})
    Fluent:Notify({Title = "Registered", Content = "Jeepney registered!", Duration = 2})
end })

MiscSection:AddButton({ Title = "Max Fuel", Callback = function()
    catNet:FireServer({ [1] = { [1] = "3", [2] = "RecieveFuel", [3] = { ["Amount"] = 100, ["JeepneyValues"] = workspace:WaitForChild("Jeepnies", 9e9):WaitForChild(LocalPlayer.Name, 9e9):WaitForChild("JeepneyValues", 9e9), ["Password"] = 157913333 } } })
    Fluent:Notify({Title = "Max Fuel", Content = "Fuel set to maximum", Duration = 2})
end })

MiscSection:AddButton({ Title = "Repair Engine", Callback = function()
    remotes:WaitForChild("WrenchRepair", 9e9):FireServer({ [1] = { ["Character"] = workspace:WaitForChild(LocalPlayer.Name, 9e9), ["Jeepney"] = workspace:WaitForChild("Jeepnies", 9e9):WaitForChild(LocalPlayer.Name, 9e9) } })
    Fluent:Notify({Title = "Repaired", Content = "Engine repaired!", Duration = 2})
end })

MiscSection:AddButton({ Title = "Remove Existing Jeep", Callback = function()
    local jeepnies = workspace:FindFirstChild("Jeepnies")
    local count = 0
    if jeepnies then
        for _, v in pairs(jeepnies:GetChildren()) do
            if v.Name ~= LocalPlayer.Name then
                v:Destroy()
                count = count + 1
            end
        end
    end
    Fluent:Notify({Title = "Removed", Content = "Removed " .. count .. " jeepnies", Duration = 2})
end })

MiscSection:AddButton({ Title = "Remove AI Vehicles", Callback = function()
    local aiVehicles = workspace:FindFirstChild("AiVehicles")
    local count = 0
    if aiVehicles then
        for _, v in pairs(aiVehicles:GetChildren()) do
            v:Destroy()
            count = count + 1
        end
    end
    Fluent:Notify({Title = "Removed", Content = "Removed " .. count .. " AI vehicles", Duration = 2})
end })

MiscSection:AddButton({ Title = "Return Jeepnies", Callback = function()
    local jeepFolder = workspace:FindFirstChild("Jeepnies")
    if not jeepFolder then Fluent:Notify({Title = "Error", Content = "Jeepnies folder not found!", Duration = 2}) return end
    local playerJeep = jeepFolder:FindFirstChild(LocalPlayer.Name)
    if not playerJeep then Fluent:Notify({Title = "Error", Content = "No jeep found for you!", Duration = 2}) return end
    local root = playerJeep.PrimaryPart or playerJeep:FindFirstChildWhichIsA("BasePart")
    if not root then Fluent:Notify({Title = "Error", Content = "Jeep has no primary part!", Duration = 2}) return end
    local char = LocalPlayer.Character
    if not char then Fluent:Notify({Title = "Error", Content = "Character not found!", Duration = 2}) return end
    local humanoidRoot = char:FindFirstChild("HumanoidRootPart")
    if not humanoidRoot then Fluent:Notify({Title = "Error", Content = "HumanoidRootPart not found!", Duration = 2}) return end
    local playerPos = humanoidRoot.Position
    playerJeep:SetPrimaryPartCFrame(CFrame.new(playerPos))
    Fluent:Notify({Title = "Returned", Content = "Your jeep has been teleported to you!", Duration = 2})
end })

local DeductSection = MiscTab:AddSection("Deductions")

local removeCashAmount = 1000

MiscSection:AddInput("RemoveCash", {
    Title = "Cash Amount to Remove",
    Placeholder = "1000",
    Numeric = true,
    Callback = function(v)
        local num = tonumber(v)
        if num and num > 0 then removeCashAmount = num end
    end
})

MiscSection:AddButton({ Title = "Remove Cash", Callback = function()
    catNet:FireServer({ [1] = { [1] = "3", [2] = "DeductCash", [3] = { ["Value"] = removeCashAmount, ["Password"] = 157913333 } } })
    Fluent:Notify({Title = "Cash Removed", Content = "Removed " .. removeCashAmount .. " cash", Duration = 2})
end })

local removeExpAmount = 1000

MiscSection:AddInput("RemoveExp", {
    Title = "EXP Amount to Remove",
    Placeholder = "1000",
    Numeric = true,
    Callback = function(v)
        local num = tonumber(v)
        if num and num > 0 then removeExpAmount = num end
    end
})

MiscSection:AddButton({ Title = "Remove Exp", Callback = function()
    catNet:FireServer({ [1] = { [1] = "3", [2] = "DeductExp", [3] = { ["Value"] = removeExpAmount, ["Password"] = 157913333 } } })
    Fluent:Notify({Title = "Exp Removed", Content = "Removed " .. removeExpAmount .. " experience", Duration = 2})
end })

local BarkSection = MiscTab:AddSection("Bark")

local selectedBarkMessage = "Pakiusad nalang po sa kanan"

BarkSection:AddDropdown("BarkMessage", {
    Title = "Select Message",
    Values = barkMessages,
    Callback = function(v) selectedBarkMessage = v end
})

BarkSection:AddButton({ Title = "Bark", Callback = function()
    remotes:WaitForChild("Bark", 9e9):FireServer({ [1] = { ["Password"] = 412543273, ["VoiceOver"] = selectedBarkMessage } })
    Fluent:Notify({Title = "Bark", Content = "Sent: " .. selectedBarkMessage, Duration = 2})
end })

local ServerSection = MiscTab:AddSection("Server")

ServerSection:AddButton({ Title = "Server Hop", Callback = function()
    local placeId = game.PlaceId
    local jobId = game.JobId
    local servers = {}
    local response = HttpService:JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?limit=100"))
    for _, v in pairs(response.data or {}) do
        if v.playing and v.id ~= jobId then
            table.insert(servers, v.id)
        end
    end
    if #servers > 0 then
        TeleportService:TeleportToPlaceInstance(placeId, servers[math.random(1, #servers)], LocalPlayer)
    end
end })

ServerSection:AddButton({ Title = "Rejoin", Callback = function()
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
end })

local AttachSection = MiscTab:AddSection("Unlock Attachments")

local unlockJeepDrop = AttachSection:AddDropdown("SelectUnlockJeep", {
    Title = "Select Jeep",
    Values = getJeepList(),
    Callback = function(v)
        if v and v ~= "No Jeeps Found" then selectedUnlockJeep = v end
    end
})

AttachSection:AddInput("UnlockJeepIndex", {
    Title = "Jeep Index",
    Placeholder = "_#1, _#2, etc.",
    Default = "_#1",
    Callback = function(v) unlockJeepIndex = v end
})

AttachSection:AddButton({
    Title = "Refresh Jeep List",
    Callback = function()
        unlockJeepDrop:SetValues(getJeepList())
        Fluent:Notify({Title = "Refreshed", Content = "Jeep list updated", Duration = 2})
    end
})

local unlockCategoryDrop = AttachSection:AddDropdown("SelectCategory", {
    Title = "Select Category",
    Values = {"Select a jeep first"},
    Callback = function(v)
        if v and v ~= "Select a jeep first" and v ~= "No Categories Found" then selectedCategory = v end
    end
})

AttachSection:AddButton({
    Title = "Refresh Categories",
    Callback = function()
        if selectedUnlockJeep and selectedUnlockJeep ~= "No Jeeps Found" then
            local newList = getAttachmentCategories(selectedUnlockJeep)
            unlockCategoryDrop:SetValues(newList)
            Fluent:Notify({Title = "Refreshed", Content = "Categories updated", Duration = 2})
        else
            Fluent:Notify({Title = "Error", Content = "Select a jeep first!", Duration = 2})
        end
    end
})

AttachSection:AddButton({
    Title = "Unlock Selected Category",
    Callback = function()
        if not selectedUnlockJeep or selectedUnlockJeep == "No Jeeps Found" then
            Fluent:Notify({Title = "Error", Content = "Select a jeep first!", Duration = 2})
            return
        end
        if not selectedCategory or selectedCategory == "" or selectedCategory == "Select a jeep first" or selectedCategory == "No Categories Found" then
            Fluent:Notify({Title = "Error", Content = "Select a category first!", Duration = 2})
            return
        end
        local jeepFullName = selectedUnlockJeep .. unlockJeepIndex
        local attachmentsPath = ReplicatedStorage:FindFirstChild("Jeepnies"):FindFirstChild(selectedUnlockJeep)
        if not attachmentsPath then
            Fluent:Notify({Title = "Error", Content = "Jeep not found!", Duration = 2})
            return
        end
        attachmentsPath = attachmentsPath:FindFirstChild("Body"):FindFirstChild("Structure"):FindFirstChild("Customizables"):FindFirstChild("Attachments")
        if not attachmentsPath then
            Fluent:Notify({Title = "Error", Content = "Attachments folder not found!", Duration = 2})
            return
        end
        local categoryFolder = attachmentsPath:FindFirstChild(selectedCategory)
        if not categoryFolder then
            Fluent:Notify({Title = "Error", Content = "Category not found!", Duration = 2})
            return
        end
        local totalUnlocked = 0
        for _, item in pairs(categoryFolder:GetChildren()) do
            remotes:WaitForChild("GetDataStore"):InvokeServer()
            task.wait(0.1)
            remotes:WaitForChild("UpdateCustomizable", 9e9):FireServer({ ["Password"] = 238551201, ["Index"] = item.Name, ["Insert"] = true, ["Value"] = { ["B"] = "165.00000536441803", ["Material"] = "Stainless", ["G"] = "162.00000554323196", ["R"] = "163.00000548362732" }, ["JeepneyName"] = jeepFullName, ["Container"] = "OwnedAttachments" })
            task.wait(0.1)
            totalUnlocked = totalUnlocked + 1
        end
        Fluent:Notify({Title = "Attachments", Content = "Unlocked " .. totalUnlocked .. " items from " .. selectedCategory, Duration = 3})
    end
})

AttachSection:AddButton({
    Title = "Unlock ALL Attachments",
    Callback = function()
        if not selectedUnlockJeep or selectedUnlockJeep == "No Jeeps Found" then
            Fluent:Notify({Title = "Error", Content = "Select a jeep first!", Duration = 2})
            return
        end
        local jeepFullName = selectedUnlockJeep .. unlockJeepIndex
        local attachmentsPath = ReplicatedStorage:FindFirstChild("Jeepnies"):FindFirstChild(selectedUnlockJeep)
        if not attachmentsPath then
            Fluent:Notify({Title = "Error", Content = "Jeep not found!", Duration = 2})
            return
        end
        attachmentsPath = attachmentsPath:FindFirstChild("Body"):FindFirstChild("Structure"):FindFirstChild("Customizables"):FindFirstChild("Attachments")
        if not attachmentsPath then
            Fluent:Notify({Title = "Error", Content = "Attachments folder not found!", Duration = 2})
            return
        end
        local totalUnlocked = 0
        for _, folder in pairs(attachmentsPath:GetChildren()) do
            for _, item in pairs(folder:GetChildren()) do
                remotes:WaitForChild("GetDataStore"):InvokeServer()
                task.wait(0.1)
                remotes:WaitForChild("UpdateCustomizable", 9e9):FireServer({ ["Password"] = 238551201, ["Index"] = item.Name, ["Insert"] = true, ["Value"] = { ["B"] = "165.00000536441803", ["Material"] = "Stainless", ["G"] = "162.00000554323196", ["R"] = "163.00000548362732" }, ["JeepneyName"] = jeepFullName, ["Container"] = "OwnedAttachments" })
                task.wait(0.1)
                totalUnlocked = totalUnlocked + 1
            end
        end
        Fluent:Notify({Title = "Attachments", Content = "Unlocked " .. totalUnlocked .. " attachments for " .. jeepFullName, Duration = 5})
    end
})

local PartsSection = MiscTab:AddSection("Unlock ALL Parts")

PartsSection:AddButton({
    Title = "Unlock ALL Parts",
    Callback = function()
        remotes:WaitForChild("GetDataStore"):InvokeServer()
        task.wait(0.3)
        remotes:WaitForChild("CloseCustomize", 9e9):FireServer({ ["Password"] = 332271450, ["NewOwnedParts"] = { ["BA - 05"] = 100, ["BA - 01"] = 100, ["BA - 03"] = 100, ["4-Speed Manual"] = 100, ["6-Speed Manual"] = 100, ["5-Speed Manual"] = 100, ["C - 04"] = 100, ["B - 04"] = 100, ["EO - 03"] = 100, ["4JJ1"] = 100, ["4HK1 Single Turbo"] = 100, ["4JK1"] = 100, ["4HE1 Single Turbo"] = 100, ["4-Speed Manual (High Ratio)"] = 100, ["T - 01 (F)"] = 100, ["EO - 01"] = 100, ["T - 05 (R)"] = 100, ["T - 03 (R)"] = 100, ["EO - 05"] = 100, ["T - 04 (R)"] = 100, ["T - 02 (R)"] = 100, ["R - 02"] = 100, ["TO - 05"] = 100, ["TO - 04"] = 100, ["TO - 03"] = 100, ["BA - 02"] = 100, ["EO - 04"] = 100, ["B - 02"] = 100, ["C - 02"] = 100, ["BA - 04"] = 100, ["T - 02 (F)"] = 100, ["EO - 02"] = 100, ["T - 04 (F)"] = 100, ["R - 01"] = 100, ["TO - 02"] = 100, ["T - 03 (F)"] = 100, ["B - 03"] = 100, ["BF - 01"] = 100, ["T - 05 (F)"] = 100, ["TO - 01"] = 100, ["B - 05"] = 100, ["CL - 01"] = 100, ["4BC2"] = 100, ["CL - 02"] = 100, ["T - 01 (R)"] = 100, ["BF - 02"] = 100, ["C - 03"] = 100, ["4BE1"] = 100, ["4HK1 Twin Turbo"] = 100, ["B - 01"] = 100, ["4HF1 Twin Turbo"] = 100, ["D - 01"] = 100, ["C - 01"] = 100 }, ["NewPartsStatus"] = { ["FrontTiresHealth"] = 100, ["DifferentialHealth"] = 100, ["ClutchHealth"] = 100, ["TransmissionHealth"] = 100, ["RadiatorHealth"] = 100, ["CoolantLevel"] = 100, ["BrakeHealth"] = 100, ["EngineHealth"] = 100, ["RearTiresHealth"] = 100, ["BrakeFluid"] = 100, ["TransmissionOil"] = 100, ["EngineOil"] = 100, ["BatteryHealth"] = 100 }, ["JeepneyName"] = selectedUnlockJeep .. unlockJeepIndex, ["NewEquippedParts"] = { ["Clutch"] = "CL - 01", ["Brake"] = "B - 01", ["Differential"] = "D - 01", ["Engine"] = "4HK1 Twin Turbo", ["Transmission"] = "4-Speed Manual (High Ratio)", ["Coolant"] = "C - 01", ["BrakeFluid"] = "BF - 01", ["RearTires"] = "T - 01 (R)", ["TransmissionOil"] = "TO - 01", ["Battery"] = "BA - 01", ["Radiator"] = "R - 01", ["EngineOil"] = "EO - 01", ["FrontTires"] = "T - 01 (F)" } })
        Fluent:Notify({Title = "Unlocked", Content = "All parts unlocked", Duration = 3})
    end
})

local RolesSection = RolesTab:AddSection("Spawn Roles")

local roles = {"Police", "Fire Enforcement", "Driver", "Conductor", "Barker", "Operator", "Owner", "Co Owner", "Manager", "Player", "Civilian", "Passenger", "VIP"}

for _, role in ipairs(roles) do
    RolesSection:AddButton({
        Title = role,
        Callback = function() spawnRole(role) end
    })
end

local MusicSection = MusicTab:AddSection("Player")

local MusicController = { currentSound = nil, volume = 100 }

function MusicController:Play(assetId)
    if self.currentSound then self.currentSound:Stop() self.currentSound:Destroy() end
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://" .. assetId
    sound.Volume = self.volume / 100
    sound.Parent = game:GetService("SoundService")
    sound:Play()
    self.currentSound = sound
    Fluent:Notify({Title = "Music", Content = "Now playing...", Duration = 2})
end

function MusicController:Stop()
    if self.currentSound then
        self.currentSound:Stop()
        self.currentSound:Destroy()
        self.currentSound = nil
        Fluent:Notify({Title = "Music", Content = "Music stopped", Duration = 2})
    end
end

MusicSection:AddSlider("Volume", {
    Title = "Volume",
    Min = 0,
    Max = 100,
    Default = 100,
    Rounding = 0,
    Callback = function(v)
        MusicController.volume = v
        if MusicController.currentSound then MusicController.currentSound.Volume = v / 100 end
    end
})

local songs = {
    {Id = 101998287760411, Name = "Pahintulot"}, {Id = 113228606989893, Name = "Palaisipan"},
    {Id = 91093214600377, Name = "Pamangulo"}, {Id = 103186131289010, Name = "Party 4 U"},
    {Id = 115245691174726, Name = "Pasko Sa Pinas"}, {Id = 72274749745781, Name = "Pagsamo"},
    {Id = 86793099693274, Name = "Puff Me Up"}, {Id = 99019663546064, Name = "Rebound"},
    {Id = 77165853903435, Name = "Sakin Ka Pa Rin Hahalin"}, {Id = 78487275982635, Name = "Salamin Salamin"},
    {Id = 106174792478284, Name = "Love Attack"}, {Id = 120200330391730, Name = "Thank You for the Love"},
    {Id = 133257180884988, Name = "Torete"}, {Id = 138013123641752, Name = "Tingin"},
    {Id = 105897803731104, Name = "Wala Na Pag-ibig"},
}
local songNames = {}
for _, song in ipairs(songs) do table.insert(songNames, song.Name) end
local selectedSongId = songs[1].Id

MusicSection:AddDropdown("SelectSong", {
    Title = "Select Song",
    Values = songNames,
    Callback = function(v)
        for _, song in ipairs(songs) do if song.Name == v then selectedSongId = song.Id break end end
    end
})

MusicSection:AddButton({ Title = "Play", Callback = function() MusicController:Play(selectedSongId) end })
MusicSection:AddButton({ Title = "Stop", Callback = function() MusicController:Stop() end })

local BoostSection = BoostTab:AddSection("Speed Settings")

BoostSection:AddSlider("TypeSpeed", {
    Title = "Type Speed",
    Min = 0,
    Max = 1,
    Default = 0.01572,
    Rounding = 5,
    Callback = function(v) velocityMult = v end
})

BoostSection:AddSlider("MaxSpeed", {
    Title = "Max Speed",
    Min = 0,
    Max = 500,
    Default = 140,
    Rounding = 0,
    Callback = function(v) maxSpeed = v end
})

BoostSection:AddToggle("SpeedBoost", {
    Title = "Jeep Speed Boost",
    Default = false,
    Callback = function(v)
        velocityEnabled = v
        Fluent:Notify({Title = "Speed Boost", Content = v and "ENABLED" or "DISABLED", Duration = 2})
    end
})

BoostSection:AddToggle("FastBreak", {
    Title = "Fast Break",
    Default = false,
    Callback = function(v)
        fastBreakEnabled = v
        Fluent:Notify({Title = "Fast Break", Content = v and "ENABLED" or "DISABLED", Duration = 2})
    end
})

local TeleportSection = TeleportTab:AddSection("Teleport Locations")

local teleports = {
    {"Bulakan Terminal", Vector3.new(-626, 16, -3202)}, {"Balagtas Terminal", Vector3.new(-3922, 17, 3156)},
    {"Malolos Terminal", Vector3.new(17606, 16, -1195)}, {"Guiguinto Terminal", Vector3.new(1060, 16, 3167)},
    {"Bulakan - Guiguinto Drop", Vector3.new(1049.858, 14.004, 3246.740)}, {"Guiguinto - Bulakan Drop", Vector3.new(-1545, 13, -3470)},
    {"Bulakan - Malolos Drop", Vector3.new(17793, 13, -1080)}, {"Bulakan - Balagtas Drop", Vector3.new(-3802, 13, 3357)},
    {"Balagtas - Bulakan Drop", Vector3.new(-1512, 13, -3471)}, {"Talyer", Vector3.new(-430.981, 12.701, 620.724)},
    {"Police Station", Vector3.new(1240.597, 12.863, 3211.784)}, {"Junk Shop", Vector3.new(-467, 13, 772)},
    {"Malolos", Vector3.new(17796, 13, -1104)}, {"Balagtas", Vector3.new(-3879, 14, 3482)},
    {"Guiguinto", Vector3.new(822, 13, 3290)}, {"Bulakan", Vector3.new(-1455, 13, -3438)}
}

for _, tp in ipairs(teleports) do
    TeleportSection:AddButton({
        Title = tp[1],
        Callback = function() teleportTo(tp[2], tp[1]) end
    })
end

local TrollSection = TrollTab:AddSection("Jeep Flinger")

local function flingPlayer(targetPlayer)
    local jeepFolder = workspace:FindFirstChild("Jeepnies")
    if not jeepFolder then return end
    local playerJeep = jeepFolder:FindFirstChild(LocalPlayer.Name)
    if not playerJeep then return end
    local seat = playerJeep:FindFirstChild("DriveSeat")
    if not seat or not seat:IsA("BasePart") then return end
    local model = seat:FindFirstAncestorOfClass("Model")
    if not model then return end
    if not model.PrimaryPart then model.PrimaryPart = seat end
    local originalPosition = model.PrimaryPart.CFrame
    if not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    local flingForce = Instance.new("BodyThrust")
    flingForce.Force = Vector3.new(9999, 9999, 9999)
    flingForce.Location = model.PrimaryPart.Position
    flingForce.Name = "JeepFling"
    flingForce.Parent = model.PrimaryPart
    local flingTime = 2
    local start = tick()
    while tick() - start < flingTime do
        if targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            model:SetPrimaryPartCFrame(CFrame.new(targetPlayer.Character.HumanoidRootPart.Position))
            flingForce.Location = targetPlayer.Character.HumanoidRootPart.Position
        else break end
        RunService.Heartbeat:Wait()
    end
    flingForce:Destroy()
    model:SetPrimaryPartCFrame(originalPosition)
end

local flingPlayerDrop = TrollSection:AddDropdown("FlingTarget", {
    Title = "Target Player",
    Values = getOnlinePlayers(),
    Callback = function(v)
        if v and v ~= "No Players" then selectedFlingTarget = v end
    end
})

TrollSection:AddButton({
    Title = "Refresh Players",
    Callback = function()
        flingPlayerDrop:SetValues(getOnlinePlayers())
        Fluent:Notify({Title = "Refreshed", Content = "Player list updated", Duration = 2})
    end
})

TrollSection:AddButton({ Title = "Fling Target", Callback = function()
    if not selectedFlingTarget or selectedFlingTarget == "No Players" then
        Fluent:Notify({Title = "Error", Content = "Select a player first!", Duration = 3})
        return
    end
    local target = Players:FindFirstChild(selectedFlingTarget)
    if target then
        flingPlayer(target)
        Fluent:Notify({Title = "Flinged!", Content = "Flinged " .. selectedFlingTarget, Duration = 2})
    end
end })

TrollSection:AddButton({ Title = "Fling All", Callback = function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then flingPlayer(p) end
    end
    Fluent:Notify({Title = "Fling All!", Content = "All players flinged!", Duration = 3})
end })

local HoodSection = TrollTab:AddSection("Troll Hood")

local hoodJeepDrop = HoodSection:AddDropdown("SelectJeep", {
    Title = "Select Jeep",
    Values = {"No Jeeps"},
    Callback = function(v)
        if v and v ~= "No Jeeps" then selectedHoodJeep = v end
    end
})

local function updateJeepList()
    local list = {}
    local jeepFolder = workspace:FindFirstChild("Jeepnies")
    if jeepFolder then
        for _, jeep in pairs(jeepFolder:GetChildren()) do
            table.insert(list, jeep.Name)
        end
    end
    if #list == 0 then list = {"No Jeeps"} end
    hoodJeepDrop:SetValues(list)
end

HoodSection:AddButton({
    Title = "Refresh Jeeps",
    Callback = function()
        updateJeepList()
        Fluent:Notify({Title = "Refreshed", Content = "Jeep list updated", Duration = 2})
    end
})

HoodSection:AddButton({ Title = "Open Hood", Callback = function()
    if not selectedHoodJeep or selectedHoodJeep == "No Jeeps" then
        Fluent:Notify({Title = "Error", Content = "Select a jeep first!", Duration = 3})
        return
    end
    local hoodMotor = workspace:WaitForChild("Jeepnies", 9e9):WaitForChild(selectedHoodJeep, 9e9):WaitForChild("Misc", 9e9):WaitForChild("Hood", 9e9):WaitForChild("HingeDriveSeat", 9e9):WaitForChild("Motor", 9e9)
    catNet:FireServer({ [1] = { [1] = "3", [2] = "OpenDoor", [3] = { ["Password"] = 161091573, ["Angle"] = 1, ["Motor"] = hoodMotor } } })
    Fluent:Notify({Title = "Hood Opened!", Content = "Opened hood of " .. selectedHoodJeep, Duration = 2})
end })

local function setupSeat()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    humanoid:GetPropertyChangedSignal("SeatPart"):Connect(function()
        local seat = humanoid.SeatPart
        if seat and seat:IsA("BasePart") then
            currentSeat = seat
        else currentSeat = nil end
    end)
    local seat = humanoid.SeatPart
    if seat and seat:IsA("BasePart") then currentSeat = seat end
end

setupSeat()
LocalPlayer.CharacterAdded:Connect(setupSeat)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.W then wHeld = true end
    if input.KeyCode == Enum.KeyCode.S then sHeld = true end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.W then wHeld = false end
    if input.KeyCode == Enum.KeyCode.S then sHeld = false end
end)

task.spawn(function()
    repeat task.wait(0.5) until LocalPlayer:FindFirstChild("PlayerGui")
    local playerGui = LocalPlayer.PlayerGui
    local success, buttonsFolder = pcall(function()
        return playerGui:WaitForChild("A-Chassis Interface"):WaitForChild("Buttons")
    end)
    if success and buttonsFolder then
        local gasButton = buttonsFolder:FindFirstChild("Gas")
        local brakeButton = buttonsFolder:FindFirstChild("Brake")
        if gasButton then
            gasButton.MouseButton1Down:Connect(function() gasHeld = true end)
            gasButton.MouseButton1Up:Connect(function() gasHeld = false end)
            gasButton.TouchStarted:Connect(function() gasHeld = true end)
            gasButton.TouchEnded:Connect(function() gasHeld = false end)
        end
        if brakeButton then
            brakeButton.MouseButton1Down:Connect(function() brakeHeld = true end)
            brakeButton.MouseButton1Up:Connect(function() brakeHeld = false end)
            brakeButton.TouchStarted:Connect(function() brakeHeld = true end)
            brakeButton.TouchEnded:Connect(function() brakeHeld = false end)
        end
    end
end)

RunService.Heartbeat:Connect(function(dt)
    if not velocityEnabled or not currentSeat then return end
    local accelerate = gasHeld or wHeld
    local braking = brakeHeld or sHeld
    if accelerate and not braking then
        local vel = currentSeat.AssemblyLinearVelocity
        local speed = vel.Magnitude
        if speed < maxSpeed then
            local mult = 1 + (velocityMult * (dt * 60))
            local newVel = Vector3.new(vel.X * mult, vel.Y, vel.Z * mult)
            if newVel.Magnitude > maxSpeed then newVel = newVel.Unit * maxSpeed end
            currentSeat.AssemblyLinearVelocity = newVel
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if not fastBreakEnabled then return end
    local braking = brakeHeld or sHeld
    if braking then
        local character = LocalPlayer.Character
        if character then
            local hum = character:FindFirstChild("Humanoid")
            if hum and hum.SeatPart then
                local car = hum.SeatPart.Parent
                if car and car:FindFirstChild("Body") then
                    local body = car.Body
                    if body:FindFirstChild("#Weight") then
                        local carPrimaryPart = body["#Weight"]
                        carPrimaryPart.Velocity = Vector3.new(0, carPrimaryPart.Velocity.Y, 0)
                        carPrimaryPart.RotVelocity = Vector3.new(0, 0, 0)
                    end
                end
                if currentSeat then
                    currentSeat.Velocity = Vector3.new(0, currentSeat.Velocity.Y, 0)
                    currentSeat.RotVelocity = Vector3.new(0, 0, 0)
                end
            end
        end
    end
end)

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
FloatingButtonManager:SetLibrary(Fluent)

InterfaceManager:SetFolder("PerryMusslurn")
SaveManager:SetFolder("PerryMusslurn/Config")
FloatingButtonManager:SetFolder("PerryMusslurn/Floating")

local OpenGui = Instance.new("ScreenGui")
OpenGui.Name = "OpenUI"
OpenGui.ResetOnSpawn = false
OpenGui.Parent = game:GetService("CoreGui")

local OpenBtn = Instance.new("ImageButton")
OpenBtn.Size = UDim2.fromOffset(55, 55)
OpenBtn.Position = UDim2.new(0.02, 0, 0.85, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
OpenBtn.BackgroundTransparency = 0
OpenBtn.Image = "rbxassetid://102446662507634"
OpenBtn.Parent = OpenGui
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0.2, 0)

FloatingButtonManager:AddButton("OpenBtn", OpenBtn, false, false)

local _dragActive, _dragStart, _startPos
OpenBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        _dragActive = true
        _dragStart = input.Position
        _startPos = OpenBtn.Position
    end
end)

OpenBtn.InputChanged:Connect(function(input)
    if _dragActive and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - _dragStart
        OpenBtn.Position = UDim2.new(
            _startPos.X.Scale, _startPos.X.Offset + delta.X,
            _startPos.Y.Scale, _startPos.Y.Offset + delta.Y
        )
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        _dragActive = false
    end
end)

OpenBtn.MouseButton1Click:Connect(function()
    if Window and Window.Minimize then
        Window:Minimize()
    end
end)

Fluent:Notify({
    Title = "Venatrix",
    Content = "Diesel n steel script fully Loaded! Press LCtrl to toggle",
    Duration = 5
})

Window:SelectTab(1)
