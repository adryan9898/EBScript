local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local guiVisible = true

-- Criando a interface principal
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "MessageScriptMenu"

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0.35, 0, 0.3, 0)
mainFrame.Position = UDim2.new(0.325, 0, 0.35, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Draggable = true
mainFrame.Active = true

local titleLabel = Instance.new("TextLabel", mainFrame)
titleLabel.Text = "Script do Adry - Mensagens"
titleLabel.Size = UDim2.new(1, 0, 0.2, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextScaled = true

-- Caixa de texto para mensagens personalizadas
local messageBox = Instance.new("TextBox", mainFrame)
messageBox.PlaceholderText = "Escreva a mensagem"
messageBox.Size = UDim2.new(0.8, 0, 0.3, 0)
messageBox.Position = UDim2.new(0.1, 0, 0.3, 0)
messageBox.Text = ""
messageBox.Font = Enum.Font.SourceSans
messageBox.TextScaled = true

-- Botão para enviar mensagens personalizadas
local sendMessageButton = Instance.new("TextButton", mainFrame)
sendMessageButton.Text = "ENVIAR MENSAGEM"
sendMessageButton.Size = UDim2.new(0.8, 0, 0.3, 0)
sendMessageButton.Position = UDim2.new(0.1, 0, 0.65, 0)
sendMessageButton.Font = Enum.Font.SourceSansBold
sendMessageButton.TextScaled = true
sendMessageButton.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
sendMessageButton.TextColor3 = Color3.fromRGB(255, 255, 255)
sendMessageButton.BorderSizePixel = 0

-- Função para alternar visibilidade
local function toggleVisibility()
    guiVisible = not guiVisible
    mainFrame.Visible = guiVisible
end

-- Conectar a tecla Alt para alternar o menu
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.LeftAlt then
        toggleVisibility()
    end
end)

-- Função para enviar mensagens para o chat
local function sendMessage(message)
    local ChatService = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents")
    local event = ChatService:WaitForChild("SayMessageRequest")
    event:FireServer(message, "All")
end

-- Conectar o botão de enviar mensagem
sendMessageButton.MouseButton1Click:Connect(function()
    local message = messageBox.Text
    if message ~= "" then
        sendMessage(message)
        messageBox.Text = ""  -- Limpa a caixa de texto após o envio
    end
end)
