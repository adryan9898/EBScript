local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Interface Settings
local menuOpen = false
local isClimbing = false
local isRunning = false
local climbSpeed = 0.15

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TowerClimbMenu"
screenGui.Parent = game.CoreGui

-- Create Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 200, 0, 350)
mainFrame.Position = UDim2.new(0.5, -100, 0.5, -175)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Parent = screenGui

-- Add Draggable Functionality
local dragging = false
local dragStart = nil
local startPos = nil

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

mainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Add Title Label
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 50)
titleLabel.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 20
titleLabel.Text = "Script do Adry"
titleLabel.Parent = mainFrame

-- Add Tower Climb Button
local climbButton = Instance.new("TextButton")
climbButton.Size = UDim2.new(0.8, 0, 0, 40)
climbButton.Position = UDim2.new(0.1, 0, 0, 60)
climbButton.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
climbButton.TextColor3 = Color3.fromRGB(255, 255, 255)
climbButton.Font = Enum.Font.SourceSansBold
climbButton.TextSize = 18
climbButton.Text = "1: Função Subir Torre (Ativar)"
climbButton.Parent = mainFrame

climbButton.MouseButton1Click:Connect(function()
    isClimbing = not isClimbing
    if isClimbing then
        climbButton.Text = "1: Função Subir Torre (Parar)"
    else
        climbButton.Text = "1: Função Subir Torre (Ativar)"
    end
end)

-- Add Infinite Run Button
local runButton = Instance.new("TextButton")
runButton.Size = UDim2.new(0.8, 0, 0, 40)
runButton.Position = UDim2.new(0.1, 0, 0, 120)
runButton.BackgroundColor3 = Color3.fromRGB(34, 139, 34)
runButton.TextColor3 = Color3.fromRGB(255, 255, 255)
runButton.Font = Enum.Font.SourceSansBold
runButton.TextSize = 18
runButton.Text = "2: Função Correr Infinito (Ativar)"
runButton.Parent = mainFrame

runButton.MouseButton1Click:Connect(function()
    isRunning = not isRunning
    if isRunning then
        runButton.Text = "2: Função Correr Infinito (Parar)"
    else
        runButton.Text = "2: Função Correr Infinito (Ativar)"
    end
end)

-- Climb Function
RunService.Heartbeat:Connect(function()
    if isClimbing then
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:Move(Vector3.new(1, 0, 0))
            task.wait(climbSpeed)
            humanoid:Move(Vector3.new(-1, 0, 0))
        end
    end
end)

-- Infinite Run Function
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.LeftShift and isRunning then
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 50
        end
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.LeftShift and isRunning then
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 16
        end
    end
end)

-- Toggle Menu Visibility with Alt
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.LeftAlt or input.KeyCode == Enum.KeyCode.RightAlt then
        menuOpen = not menuOpen
        mainFrame.Visible = menuOpen
    end
end)
