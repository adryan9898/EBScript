local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

-- Função para converter números em palavras
local function numberToWords(n)
    local words = {"ZERO", "UM", "DOIS", "TRÊS", "QUATRO", "CINCO", "SEIS", "SETE", "OITO", "NOVE", "DEZ"}
    if n <= 10 then return words[n + 1] .. " !" end
    return tostring(n) .. " !" 
end

-- Variável para controlar visibilidade
local guiVisible = true

-- Criação da Interface
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "EBNumberMenu"

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0.3, 0, 0.4, 0)
frame.Position = UDim2.new(0.35, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Draggable = true
frame.Active = true

local title = Instance.new("TextLabel", frame)
title.Text = "Script do Adry"
title.Size = UDim2.new(1, 0, 0.15, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextScaled = true

local configButton = Instance.new("TextButton", frame)
configButton.Text = "⚙️"
configButton.Size = UDim2.new(0.1, 0, 0.15, 0)
configButton.Position = UDim2.new(0.9, 0, 0, 0)
configButton.BackgroundTransparency = 1
configButton.TextScaled = true

local startBox = Instance.new("TextBox", frame)
startBox.PlaceholderText = "Número Inicial"
startBox.Size = UDim2.new(0.8, 0, 0.2, 0)
startBox.Position = UDim2.new(0.1, 0, 0.3, 0)
startBox.Text = ""
startBox.Font = Enum.Font.SourceSans
startBox.TextScaled = true

local endBox = Instance.new("TextBox", frame)
endBox.PlaceholderText = "Número Final"
endBox.Size = UDim2.new(0.8, 0, 0.2, 0)
endBox.Position = UDim2.new(0.1, 0, 0.55, 0)
endBox.Text = ""
endBox.Font = Enum.Font.SourceSans
endBox.TextScaled = true

local playButton = Instance.new("TextButton", frame)
playButton.Text = "COMEÇAR"
playButton.Size = UDim2.new(0.8, 0, 0.15, 0)
playButton.Position = UDim2.new(0.1, 0, 0.8, 0)
playButton.Font = Enum.Font.SourceSansBold
playButton.TextScaled = true
playButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
playButton.TextColor3 = Color3.fromRGB(255, 255, 255)
playButton.BorderSizePixel = 0

local function toggleVisibility()
    guiVisible = not guiVisible
    screenGui.Enabled = guiVisible
end

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.LeftAlt then
        toggleVisibility()
    end
end)

playButton.MouseButton1Click:Connect(function()
    local startNum = tonumber(startBox.Text) or 0
    local endNum = tonumber(endBox.Text) or 10
    for i = startNum, endNum do
        ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents")
        :WaitForChild("SayMessageRequest")
        :FireServer(numberToWords(i), "All")
        task.wait(1.5)
    end
end)

-- Menu de Configuração
local configFrame = Instance.new("Frame", frame)
configFrame.Size = UDim2.new(1, 0, 0.3, 0)
configFrame.Position = UDim2.new(0, 0, 1, 0)
configFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
configFrame.Visible = false

local configLabel = Instance.new("TextLabel", configFrame)
configLabel.Text = "Configurações"
configLabel.Size = UDim2.new(1, 0, 0.3, 0)
configLabel.BackgroundTransparency = 1
configLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
configLabel.Font = Enum.Font.SourceSansBold
configLabel.TextScaled = true

configButton.MouseButton1Click:Connect(function()
    configFrame.Visible = not configFrame.Visible
end)
