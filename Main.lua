local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

-- OpenAI API Config
local OPENAI_API_KEY = "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"
local OPENAI_ENDPOINT = "https://api.openai.com/v1/chat/completions"

-- Interface Settings
local menuOpen = false
local isClimbing = false
local isRunning = false
local climbSpeed = 0.1

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TowerClimbMenu"
screenGui.Parent = game.CoreGui

-- Create Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 500)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
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
titleLabel.Size = UDim2.new(1, 0, 0, 60)
titleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 24
titleLabel.Text = "⚙️ Script do Adry"
titleLabel.Parent = mainFrame

-- Add Tower Climb Button
local climbButton = Instance.new("TextButton")
climbButton.Size = UDim2.new(0.8, 0, 0, 50)
climbButton.Position = UDim2.new(0.1, 0, 0, 80)
climbButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
climbButton.TextColor3 = Color3.fromRGB(255, 255, 255)
climbButton.Font = Enum.Font.SourceSansBold
climbButton.TextSize = 20
climbButton.Text = "🗼 Subir Torre (Ativar)"
climbButton.Parent = mainFrame

climbButton.MouseButton1Click:Connect(function()
    isClimbing = not isClimbing
    if isClimbing then
        climbButton.Text = "🛑 Parar Torre"
    else
        climbButton.Text = "🗼 Subir Torre (Ativar)"
    end
end)

-- Add Infinite Run Button
local runButton = Instance.new("TextButton")
runButton.Size = UDim2.new(0.8, 0, 0, 50)
runButton.Position = UDim2.new(0.1, 0, 0, 150)
runButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
runButton.TextColor3 = Color3.fromRGB(255, 255, 255)
runButton.Font = Enum.Font.SourceSansBold
runButton.TextSize = 20
runButton.Text = "🏃‍♂️ Correr Infinito (Ativar)"
runButton.Parent = mainFrame

runButton.MouseButton1Click:Connect(function()
    isRunning = not isRunning
    if isRunning then
        runButton.Text = "🛑 Parar Corrida"
    else
        runButton.Text = "🏃‍♂️ Correr Infinito (Ativar)"
    end
end)

-- Add AI Chat Button
local aiButton = Instance.new("TextButton")
aiButton.Size = UDim2.new(0.8, 0, 0, 50)
aiButton.Position = UDim2.new(0.1, 0, 0, 220)
aiButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
aiButton.TextColor3 = Color3.fromRGB(255, 255, 255)
aiButton.Font = Enum.Font.SourceSansBold
aiButton.TextSize = 20
aiButton.Text = "🤖 Inteligência Artificial"
aiButton.Parent = mainFrame

local aiFrame = Instance.new("Frame")
aiFrame.Size = UDim2.new(0.9, 0, 0, 200)
aiFrame.Position = UDim2.new(0.05, 0, 0, 280)
aiFrame.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
aiFrame.BorderSizePixel = 0
aiFrame.Visible = false
aiFrame.Parent = mainFrame

local aiTextBox = Instance.new("TextBox")
aiTextBox.Size = UDim2.new(1, -10, 0, 100)
aiTextBox.Position = UDim2.new(0, 5, 0, 5)
aiTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
aiTextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
aiTextBox.Font = Enum.Font.SourceSansBold
aiTextBox.TextSize = 18
aiTextBox.Text = "Digite sua pergunta..."
aiTextBox.Parent = aiFrame

local aiResponse = Instance.new("TextLabel")
aiResponse.Size = UDim2.new(1, -10, 0, 85)
aiResponse.Position = UDim2.new(0, 5, 0, 115)
aiResponse.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
aiResponse.TextColor3 = Color3.fromRGB(0, 0, 0)
aiResponse.Font = Enum.Font.SourceSansBold
aiResponse.TextSize = 16
aiResponse.Text = "Responda aqui..."
aiResponse.TextWrapped = true
aiResponse.Parent = aiFrame

aiButton.MouseButton1Click:Connect(function()
    aiFrame.Visible = not aiFrame.Visible
end)

-- Toggle Menu Visibility with Alt
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.LeftAlt or input.KeyCode == Enum.KeyCode.RightAlt then
        menuOpen = not menuOpen
        mainFrame.Visible = menuOpen
    end
end)
