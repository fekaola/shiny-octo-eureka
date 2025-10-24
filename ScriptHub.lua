local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local autoFarmEnabled = false
local antiAFKEnabled = true
local autoResetEnabled = false
local tweenSpeed = 25
local candyCount = 0
local resetCount = 0
local startTime = os.time()

local shotMurdererEnabled = false
local autoGrabGunEnabled = false
local espEnabled = false
local espMurdererEnabled = false
local espSheriffEnabled = false

local menuOpen = true

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "XHub"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 450, 0, 300)
MainFrame.Position = UDim2.new(0, 20, 0, 50)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local ResizeButton = Instance.new("TextButton")
ResizeButton.Name = "ResizeButton"
ResizeButton.Size = UDim2.new(0, 15, 0, 15)
ResizeButton.Position = UDim2.new(1, -15, 1, -15)
ResizeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
ResizeButton.BorderSizePixel = 0
ResizeButton.Text = ""
ResizeButton.ZIndex = 2

local ResizeCorner = Instance.new("UICorner")
ResizeCorner.CornerRadius = UDim.new(0, 4)
ResizeCorner.Parent = ResizeButton

local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0, 60, 0, 25)
ToggleButton.Position = UDim2.new(1, -70, 0, 10)
ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
ToggleButton.BorderSizePixel = 0
ToggleButton.Text = "Скрыть"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 12
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.AutoButtonColor = false

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 4)
ToggleCorner.Parent = ToggleButton

local MiniToggleButton = Instance.new("TextButton")
MiniToggleButton.Name = "MiniToggleButton"
MiniToggleButton.Size = UDim2.new(0, 100, 0, 35)
MiniToggleButton.Position = UDim2.new(0.5, -50, 0.08, -17)
MiniToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
MiniToggleButton.BorderSizePixel = 0
MiniToggleButton.Text = "XHub ▼"
MiniToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MiniToggleButton.TextSize = 14
MiniToggleButton.Font = Enum.Font.GothamBold
MiniToggleButton.AutoButtonColor = false
MiniToggleButton.Visible = false

local MiniToggleCorner = Instance.new("UICorner")
MiniToggleCorner.CornerRadius = UDim.new(0, 8)
MiniToggleCorner.Parent = MiniToggleButton

local TabsFrame = Instance.new("Frame")
TabsFrame.Name = "TabsFrame"
TabsFrame.Size = UDim2.new(0, 100, 1, 0)
TabsFrame.Position = UDim2.new(0, 0, 0, 0)
TabsFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
TabsFrame.BorderSizePixel = 0

local TabsCorner = Instance.new("UICorner")
TabsCorner.CornerRadius = UDim.new(0, 8)
TabsCorner.Parent = TabsFrame

local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -100, 1, 0)
ContentFrame.Position = UDim2.new(0, 100, 0, 0)
ContentFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
ContentFrame.BorderSizePixel = 0

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 8)
ContentCorner.Parent = ContentFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(1, 0, 0, 40)
TitleLabel.Position = UDim2.new(0, 0, 0, 0)
TitleLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
TitleLabel.BorderSizePixel = 0
TitleLabel.Text = "XHub"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 18
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextYAlignment = Enum.TextYAlignment.Center
TitleLabel.TextXAlignment = Enum.TextXAlignment.Center

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = TitleLabel

local function CreateTab(name, yPosition)
    local tab = Instance.new("TextButton")
    tab.Name = name .. "Tab"
    tab.Size = UDim2.new(1, -10, 0, 35)
    tab.Position = UDim2.new(0, 5, 0, yPosition)
    tab.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    tab.BorderSizePixel = 0
    tab.Text = name
    tab.TextColor3 = Color3.fromRGB(200, 200, 220)
    tab.TextSize = 12
    tab.Font = Enum.Font.Gotham
    tab.AutoButtonColor = false

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = tab
    
    return tab
end

local ESPTab = CreateTab("ESP", 50)
local AimbotTab = CreateTab("AIMBOT", 90)
local AutofarmTab = CreateTab("AUTOFARM", 130)
AutofarmTab.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
AutofarmTab.TextColor3 = Color3.fromRGB(255, 255, 255)

local function CreateToggle(name, defaultValue, yPosition, parentFrame)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Name = name .. "Toggle"
    ToggleFrame.Size = UDim2.new(1, -20, 0, 30)
    ToggleFrame.Position = UDim2.new(0, 10, 0, yPosition)
    ToggleFrame.BackgroundTransparency = 1
    
    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Name = "Label"
    ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    ToggleLabel.Position = UDim2.new(0, 0, 0, 0)
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Text = name
    ToggleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    ToggleLabel.TextSize = 13
    ToggleLabel.Font = Enum.Font.Gotham
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Name = "Toggle"
    ToggleButton.Size = UDim2.new(0, 50, 0, 24)
    ToggleButton.Position = UDim2.new(1, -50, 0.5, -12)
    ToggleButton.BackgroundColor3 = defaultValue and Color3.fromRGB(0, 160, 0) or Color3.fromRGB(80, 80, 90)
    ToggleButton.Text = ""
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.TextSize = 10
    ToggleButton.Font = Enum.Font.GothamBold
    ToggleButton.AutoButtonColor = false

    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 12)
    ToggleCorner.Parent = ToggleButton

    local ToggleIndicator = Instance.new("Frame")
    ToggleIndicator.Name = "Indicator"
    ToggleIndicator.Size = UDim2.new(0, 20, 0, 20)
    ToggleIndicator.Position = defaultValue and UDim2.new(0.6, 0, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
    ToggleIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ToggleIndicator.BorderSizePixel = 0

    local IndicatorCorner = Instance.new("UICorner")
    IndicatorCorner.CornerRadius = UDim.new(0.5, 0)
    IndicatorCorner.Parent = ToggleIndicator
    
    ToggleButton.MouseButton1Click:Connect(function()
        local newValue = not defaultValue
        defaultValue = newValue
        
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        
        if newValue then
            TweenService:Create(ToggleButton, tweenInfo, {
                BackgroundColor3 = Color3.fromRGB(0, 160, 0)
            }):Play()
            TweenService:Create(ToggleIndicator, tweenInfo, {
                Position = UDim2.new(0.6, 0, 0.5, -10)
            }):Play()
        else
            TweenService:Create(ToggleButton, tweenInfo, {
                BackgroundColor3 = Color3.fromRGB(80, 80, 90)
            }):Play()
            TweenService:Create(ToggleIndicator, tweenInfo, {
                Position = UDim2.new(0, 2, 0.5, -10)
            }):Play()
        end
        
        if name == "Auto Farm" then
            autoFarmEnabled = newValue
        elseif name == "Anti-AFK" then
            antiAFKEnabled = newValue
        elseif name == "Auto Reset" then
            autoResetEnabled = newValue
        elseif name == "Shot Murderer" then
            shotMurdererEnabled = newValue
            if newValue then
                CreateShotMurdererButton()
            else
                RemoveShotMurdererButton()
            end
        elseif name == "Auto Grab Gun" then
            autoGrabGunEnabled = newValue
        elseif name == "ESP All" then
            espEnabled = newValue
            if newValue then
                enablePlayerESP()
            else
                disablePlayerESP()
            end
        elseif name == "ESP Murderer" then
            espMurdererEnabled = newValue
            if newValue then
                enableMurdererESP()
            else
                disableMurdererESP()
            end
        elseif name == "ESP Sheriff" then
            espSheriffEnabled = newValue
            if newValue then
                enableSheriffESP()
            else
                disableSheriffESP()
            end
        end
    end)
    
    ToggleLabel.Parent = ToggleFrame
    ToggleButton.Parent = ToggleFrame
    ToggleIndicator.Parent = ToggleButton
    ToggleFrame.Parent = parentFrame
    
    return ToggleFrame, defaultValue
end

local function CreateDisplay(name, value, yPosition, parentFrame)
    local DisplayFrame = Instance.new("Frame")
    DisplayFrame.Name = name .. "Display"
    DisplayFrame.Size = UDim2.new(1, -20, 0, 25)
    DisplayFrame.Position = UDim2.new(0, 10, 0, yPosition)
    DisplayFrame.BackgroundTransparency = 1
    
    local DisplayLabel = Instance.new("TextLabel")
    DisplayLabel.Name = "Label"
    DisplayLabel.Size = UDim2.new(0.6, 0, 1, 0)
    DisplayLabel.Position = UDim2.new(0, 0, 0, 0)
    DisplayLabel.BackgroundTransparency = 1
    DisplayLabel.Text = name
    DisplayLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    DisplayLabel.TextSize = 13
    DisplayLabel.Font = Enum.Font.Gotham
    DisplayLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local DisplayValue = Instance.new("TextLabel")
    DisplayValue.Name = "Value"
    DisplayValue.Size = UDim2.new(0.4, 0, 1, 0)
    DisplayValue.Position = UDim2.new(0.6, 0, 0, 0)
    DisplayValue.BackgroundTransparency = 1
    DisplayValue.Text = tostring(value)
    DisplayValue.TextColor3 = Color3.fromRGB(255, 215, 0)
    DisplayValue.TextSize = 13
    DisplayValue.Font = Enum.Font.GothamBold
    DisplayValue.TextXAlignment = Enum.TextXAlignment.Right
    
    DisplayLabel.Parent = DisplayFrame
    DisplayValue.Parent = DisplayFrame
    DisplayFrame.Parent = parentFrame
    
    return DisplayFrame, DisplayValue
end

local currentY = 50
local AutoFarmToggle, AutoFarmState = CreateToggle("Auto Farm", false, currentY, ContentFrame)
currentY = currentY + 35

local AntiAFKToggle, AntiAFKState = CreateToggle("Anti-AFK", true, currentY, ContentFrame)
currentY = currentY + 35

local AutoResetToggle, AutoResetState = CreateToggle("Auto Reset", false, currentY, ContentFrame)
currentY = currentY + 35

local CandyDisplay, CandyValue = CreateDisplay("Candy Collected", candyCount, currentY, ContentFrame)
currentY = currentY + 30

local TimeDisplay, TimeValue = CreateDisplay("Time Active", "0s", currentY, ContentFrame)
currentY = currentY + 30

local ResetDisplay, ResetValue = CreateDisplay("Reset Counter", resetCount, currentY, ContentFrame)
currentY = currentY + 30

local ResetButton = Instance.new("TextButton")
ResetButton.Name = "ResetButton"
ResetButton.Size = UDim2.new(1, -20, 0, 30)
ResetButton.Position = UDim2.new(0, 10, 0, currentY)
ResetButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
ResetButton.BorderSizePixel = 0
ResetButton.Text = "RESET COUNTER"
ResetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ResetButton.TextSize = 12
ResetButton.Font = Enum.Font.GothamBold
ResetButton.AutoButtonColor = false

local ResetCorner = Instance.new("UICorner")
ResetCorner.CornerRadius = UDim.new(0, 6)
ResetCorner.Parent = ResetButton

ResetButton.MouseButton1Click:Connect(function()
    resetCount = 0
    ResetValue.Text = tostring(resetCount)
    TweenService:Create(ResetButton, TweenInfo.new(0.1), {
        BackgroundColor3 = Color3.fromRGB(80, 80, 100)
    }):Play()
    wait(0.1)
    TweenService:Create(ResetButton, TweenInfo.new(0.1), {
        BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    }):Play()
end)

ResetButton.Parent = ContentFrame

local ESPContent = Instance.new("Frame")
ESPContent.Name = "ESPContent"
ESPContent.Size = UDim2.new(1, 0, 1, 0)
ESPContent.Position = UDim2.new(0, 0, 0, 0)
ESPContent.BackgroundTransparency = 1
ESPContent.Visible = false

local espCurrentY = 50
local ESPAllToggle, ESPAllState = CreateToggle("ESP All", false, espCurrentY, ESPContent)
espCurrentY = espCurrentY + 35

local ESPMurdererToggle, ESPMurdererState = CreateToggle("ESP Murderer", false, espCurrentY, ESPContent)
espCurrentY = espCurrentY + 35

local ESPSheriffToggle, ESPSheriffState = CreateToggle("ESP Sheriff", false, espCurrentY, ESPContent)
espCurrentY = espCurrentY + 35

local AimbotContent = Instance.new("Frame")
AimbotContent.Name = "AimbotContent"
AimbotContent.Size = UDim2.new(1, 0, 1, 0)
AimbotContent.Position = UDim2.new(0, 0, 0, 0)
AimbotContent.BackgroundTransparency = 1
AimbotContent.Visible = false

local aimbotCurrentY = 50
local ShotMurdererToggle, ShotMurdererState = CreateToggle("Shot Murderer", false, aimbotCurrentY, AimbotContent)
aimbotCurrentY = aimbotCurrentY + 35

local AutoGrabGunToggle, AutoGrabGunState = CreateToggle("Auto Grab Gun", false, aimbotCurrentY, AimbotContent)
aimbotCurrentY = aimbotCurrentY + 35

local function SwitchTab(selectedTab)
    ESPTab.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    AimbotTab.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    AutofarmTab.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    ESPTab.TextColor3 = Color3.fromRGB(200, 200, 220)
    AimbotTab.TextColor3 = Color3.fromRGB(200, 200, 220)
    AutofarmTab.TextColor3 = Color3.fromRGB(200, 200, 220)
    
    ContentFrame.Visible = false
    ESPContent.Visible = false
    AimbotContent.Visible = false
    
    selectedTab.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    selectedTab.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    if selectedTab == AutofarmTab then
        ContentFrame.Visible = true
    elseif selectedTab == ESPTab then
        ESPContent.Visible = true
    elseif selectedTab == AimbotTab then
        AimbotContent.Visible = true
    end
end

ESPTab.MouseButton1Click:Connect(function() SwitchTab(ESPTab) end)
AimbotTab.MouseButton1Click:Connect(function() SwitchTab(AimbotTab) end)
AutofarmTab.MouseButton1Click:Connect(function() SwitchTab(AutofarmTab) end)

local function ToggleMenu()
    menuOpen = not menuOpen
    if menuOpen then
        MiniToggleButton.Visible = false
        MainFrame.Visible = true
        ToggleButton.Text = "Скрыть"
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 450, 0, 300)
        }):Play()
    else
        ToggleButton.Text = "Показать"
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0)
        }):Play()
        wait(0.3)
        MainFrame.Visible = false
        MiniToggleButton.Visible = true
    end
end

ToggleButton.MouseButton1Click:Connect(ToggleMenu)
MiniToggleButton.MouseButton1Click:Connect(ToggleMenu)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightControl then
        ToggleMenu()
    end
end)

local resizing = false
ResizeButton.MouseButton1Down:Connect(function()
    resizing = true
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        resizing = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if resizing and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mousePos = UserInputService:GetMouseLocation()
        local newSize = UDim2.new(0, math.max(350, mousePos.X - MainFrame.AbsolutePosition.X), 0, math.max(250, mousePos.Y - MainFrame.AbsolutePosition.Y))
        MainFrame.Size = newSize
    end
end)

TitleLabel.Parent = TabsFrame
ESPTab.Parent = TabsFrame
AimbotTab.Parent = TabsFrame
AutofarmTab.Parent = TabsFrame
TabsFrame.Parent = MainFrame
ContentFrame.Parent = MainFrame
ESPContent.Parent = MainFrame
AimbotContent.Parent = MainFrame
ResizeButton.Parent = MainFrame
ToggleButton.Parent = MainFrame
MainFrame.Parent = ScreenGui
MiniToggleButton.Parent = ScreenGui
ScreenGui.Parent = PlayerGui

local shotMurdererButton = nil

local function CreateShotMurdererButton()
    if shotMurdererButton then return end
    
    shotMurdererButton = Instance.new("TextButton")
    shotMurdererButton.Name = "ShotMurdererButton"
    shotMurdererButton.Size = UDim2.new(0, 120, 0, 40)
    shotMurdererButton.Position = UDim2.new(0.5, -60, 0.8, 0)
    shotMurdererButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    shotMurdererButton.BorderSizePixel = 0
    shotMurdererButton.Text = "SHOT MURDERER"
    shotMurdererButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    shotMurdererButton.TextSize = 12
    shotMurdererButton.Font = Enum.Font.GothamBold
    shotMurdererButton.AutoButtonColor = false
    shotMurdererButton.ZIndex = 10
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = shotMurdererButton
    
    shotMurdererButton.MouseButton1Click:Connect(function()
        shootMurderer()
    end)
    
    shotMurdererButton.Parent = ScreenGui
end

local function RemoveShotMurdererButton()
    if shotMurdererButton then
        shotMurdererButton:Destroy()
        shotMurdererButton = nil
    end
end

local function shootMurderer()
    local murderer = findMurderer()
    if murderer and murderer.Character then
        local humanoid = murderer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            print("Shot murderer: " .. murderer.Name)
        end
    end
end

local function findMurderer()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            if checkIfMurderer(player) then
                return player
            end
        end
    end
    return nil
end

local autoGrabLoop = nil

local function autoGrabGun()
    local character = LocalPlayer.Character
    if not character then return end
    
    for _, obj in pairs(workspace:GetChildren()) do
        if obj.Name == "Gun" or obj:FindFirstChild("Handle") then
            local distance = (character.HumanoidRootPart.Position - obj.Position).Magnitude
            if distance < 10 then
                fireclickdetector(obj.ClickDetector)
            end
        end
    end
end

local highlights = {}

local function enablePlayerESP()
    local players = Players:GetPlayers()
    
    for _, player in ipairs(players) do
        if player ~= LocalPlayer and player.Character then
            local character = player.Character
            
            if not highlights[player] then
                local highlight = Instance.new("Highlight")
                highlight.Name = "PlayerHighlight"
                highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                highlight.Adornee = character
                highlight.FillColor = Color3.fromRGB(0, 255, 0)
                highlight.OutlineColor = Color3.fromRGB(0, 200, 0)
                highlight.Parent = workspace
                
                highlights[player] = highlight
            end
        end
    end
end

local function disablePlayerESP()
    for player, highlight in pairs(highlights) do
        if highlight then
            highlight:Destroy()
        end
    end
    highlights = {}
end

local function enableMurdererESP()
    local players = Players:GetPlayers()
    
    for _, player in ipairs(players) do
        if player.Character and checkIfMurderer(player) then
            local character = player.Character
            
            if not highlights[player] then
                local highlight = Instance.new("Highlight")
                highlight.Name = "MurdererHighlight"
                highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                highlight.Adornee = character
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                highlight.OutlineColor = Color3.fromRGB(200, 0, 0)
                highlight.Parent = workspace
                
                highlights[player] = highlight
            end
        end
    end
end

local function disableMurdererESP()
    for player, highlight in pairs(highlights) do
        if highlight and highlight.Name == "MurdererHighlight" then
            highlight:Destroy()
            highlights[player] = nil
        end
    end
end

local function enableSheriffESP()
    local players = Players:GetPlayers()
    
    for _, player in ipairs(players) do
        if player.Character and checkIfSheriff(player) then
            local character = player.Character
            
            if not highlights[player] then
                local highlight = Instance.new("Highlight")
                highlight.Name = "SheriffHighlight"
                highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                highlight.Adornee = character
                highlight.FillColor = Color3.fromRGB(0, 0, 255)
                highlight.OutlineColor = Color3.fromRGB(0, 0, 200)
                highlight.Parent = workspace
                
                highlights[player] = highlight
            end
        end
    end
end

local function disableSheriffESP()
    for player, highlight in pairs(highlights) do
        if highlight and highlight.Name == "SheriffHighlight" then
            highlight:Destroy()
            highlights[player] = nil
        end
    end
end

local function checkIfMurderer(player)
    if player.Character then
        for _, tool in ipairs(player.Character:GetChildren()) do
            if tool:IsA("Tool") and (string.lower(tool.Name) == "knife" or string.lower(tool.Name) == "murderer") then
                return true
            end
        end
    end
    return false
end

local function checkIfSheriff(player)
    if player.Character then
        for _, tool in ipairs(player.Character:GetChildren()) do
            if tool:IsA("Tool") and (string.lower(tool.Name) == "gun" or string.lower(tool.Name) == "sheriff") then
                return true
            end
        end
    end
    return false
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        if espEnabled then
            enablePlayerESP()
        end
        if espMurdererEnabled and checkIfMurderer(player) then
            enableMurdererESP()
        end
        if espSheriffEnabled and checkIfSheriff(player) then
            enableSheriffESP()
        end
    end)
end)

local function SetupAutoFarm()
    local CoinCollected = ReplicatedStorage.Remotes.Gameplay.CoinCollected
    local RoundStart = ReplicatedStorage.Remotes.Gameplay.RoundStart
    local RoundEnd = ReplicatedStorage.Remotes.Gameplay.RoundEndFade

    local farming = false
    local bag_full = false
    local resetting = false
    local start_position = nil

    local function getCharacter() 
        return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait() 
    end
    
    local function getHRP() 
        return getCharacter():WaitForChild("HumanoidRootPart") 
    end

    CoinCollected.OnClientEvent:Connect(function(_, current, max)
        candyCount = current
        CandyValue.Text = tostring(candyCount)
        
        if current == max and not resetting and autoResetEnabled then
            resetting = true
            bag_full = true
            resetCount = resetCount + 1
            ResetValue.Text = tostring(resetCount)
            
            local hrp = getHRP()
            if start_position then
                local tween = TweenService:Create(hrp, TweenInfo.new(2, Enum.EasingStyle.Linear), {CFrame = start_position})
                tween:Play()
                tween.Completed:Wait()
            end
            task.wait(0.5)
            LocalPlayer.Character.Humanoid.Health = 0
            LocalPlayer.CharacterAdded:Wait()
            task.wait(1.5)
            resetting = false
            bag_full = false
        end
    end)

    RoundStart.OnClientEvent:Connect(function()
        farming = true
        start_position = getHRP().CFrame
    end)

    RoundEnd.OnClientEvent:Connect(function()
        farming = false
    end)

    local function get_nearest_coin()
        local hrp = getHRP()
        local closest, dist = nil, math.huge
        for _, m in pairs(workspace:GetChildren()) do
            if m:FindFirstChild("CoinContainer") then
                for _, coin in pairs(m.CoinContainer:GetChildren()) do
                    if coin:IsA("BasePart") and coin:FindFirstChild("TouchInterest") then
                        local d = (hrp.Position - coin.Position).Magnitude
                        if d < dist then 
                            closest, dist = coin, d 
                        end
                    end
                end
            end
        end
        return closest, dist
    end

    task.spawn(function()
        while true do
            if autoFarmEnabled and farming and not bag_full then
                local coin, dist = get_nearest_coin()
                if coin then
                    local hrp = getHRP()
                    if dist > 150 then
                        hrp.CFrame = coin.CFrame
                    else
                        local tween = TweenService:Create(hrp, TweenInfo.new(dist / tweenSpeed, Enum.EasingStyle.Linear), {CFrame = coin.CFrame})
                        tween:Play()
                        repeat 
                            task.wait() 
                        until not coin:FindFirstChild("TouchInterest") or not farming or not autoFarmEnabled
                        tween:Cancel()
                    end
                end
            end
            task.wait(0.2)
        end
    end)
end

local function SetupAntiAFK()
    LocalPlayer.Idled:Connect(function()
        if antiAFKEnabled then
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end
    end)
end

task.spawn(function()
    while true do
        if autoGrabGunEnabled then
            autoGrabGun()
        end
        task.wait(0.5)
    end
end)

task.spawn(function()
    while true do
        local currentTime = os.time() - startTime
        local minutes = math.floor(currentTime / 60)
        local seconds = currentTime % 60
        TimeValue.Text = string.format("%dm %ds", minutes, seconds)
        task.wait(1)
    end
end)

SetupAutoFarm()
SetupAntiAFK()
