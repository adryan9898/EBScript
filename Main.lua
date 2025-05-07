-- Message.lua v2
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui        = game:GetService("StarterGui")
local UserInputService  = game:GetService("UserInputService")

-- Tela e frame
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "MessageScript"

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

-- Visibilidade
local visible = true
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.LeftAlt then
        visible = not visible
        frame.Visible = visible
    end
end)

-- Tenta encontrar o RemoteEvent de chat
local chatEvents = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
local sayReq
if chatEvents then
    sayReq = chatEvents:FindFirstChild("SayMessageRequest")
end

local function sendMsg(msg)
    if sayReq then
        sayReq:FireServer(msg, "All")
        warn("[Message.lua] Usando SayMessageRequest =>", msg)
    else
        StarterGui:SetCore("ChatMakeSystemMessage",{ Text = msg, Color = Color3.new(1,1,1) })
        warn("[Message.lua] Fallback SetCore ChatMakeSystemMessage =>", msg)
    end
end

-- Clique
btn.MouseButton1Click:Connect(function()
    local txt = box.Text
    if txt:match("%S") then
        sendMsg(txt)
        box.Text = ""
    end
end)
