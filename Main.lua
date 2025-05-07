-- Message.lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService   = game:GetService("UserInputService")

-- Variável de controle de visibilidade
local guiVisible = true

-- Cria o ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MessageScript"
screenGui.Parent = game.CoreGui

-- Frame principal
local frame = Instance.new("Frame", screenGui)
frame.Name = "MainFrame"
frame.Size = UDim2.new(0.3, 0, 0.25, 0)
frame.Position = UDim2.new(0.35, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

-- Título
local title = Instance.new("TextLabel", frame)
title.Name = "Title"
title.Size = UDim2.new(1,0,0.2,0)
title.Position = UDim2.new(0,0,0,0)
title.BackgroundTransparency = 1
title.Text = "Script do Adry - Msg"
title.Font = Enum.Font.SourceSansBold
title.TextScaled = true
title.TextColor3 = Color3.new(1,1,1)

-- Caixa de texto
local box = Instance.new("TextBox", frame)
box.Name = "MsgBox"
box.Size = UDim2.new(0.9,0,0.4,0)
box.Position = UDim2.new(0.05,0,0.25,0)
box.PlaceholderText = "Digite a mensagem aqui"
box.ClearTextOnFocus = false
box.TextScaled = true
box.Font = Enum.Font.SourceSans
box.TextColor3 = Color3.new(1,1,1)
box.BackgroundColor3 = Color3.fromRGB(40,40,40)
box.BorderSizePixel = 0

-- Botão de enviar
local btn = Instance.new("TextButton", frame)
btn.Name = "SendButton"
btn.Size = UDim2.new(0.9,0,0.25,0)
btn.Position = UDim2.new(0.05,0,0.7,0)
btn.Text = "ENVIAR MENSAGEM"
btn.Font = Enum.Font.SourceSansBold
btn.TextScaled = true
btn.TextColor3 = Color3.new(1,1,1)
btn.BackgroundColor3 = Color3.fromRGB(0,120,215)
btn.BorderSizePixel = 0

-- Alterna visibilidade com ALT
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.LeftAlt then
        guiVisible = not guiVisible
        frame.Visible = guiVisible
    end
end)

-- Função de envio
local function sendMsg(msg)
    local chatEvents = ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents")
    local evt = chatEvents:WaitForChild("SayMessageRequest")
    evt:FireServer(msg, "All")
end

-- Clique no botão
btn.MouseButton1Click:Connect(function()
    local text = box.Text
    if text and text:match("%S") then
        sendMsg(text)
        box.Text = ""
    end
end)
