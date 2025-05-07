local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

-- Função para converter números em palavras (para até 100.000)
local function numberToWords(n)
    local words = {"ZERO", "UM", "DOIS", "TRÊS", "QUATRO", "CINCO", "SEIS", "SETE", "OITO", "NOVE", "DEZ", 
                   "ONZE", "DOZE", "TREZE", "QUATORZE", "QUINZE", "DEZESSEIS", "DEZESSETE", "DEZOITO", "DEZENOVE", 
                   "VINTE", "VINTE E UM", "VINTE E DOIS", "VINTE E TRÊS", "VINTE E QUATRO", "VINTE E CINCO", 
                   "VINTE E SEIS", "VINTE E SETE", "VINTE E OITO", "VINTE E NOVE", "TRINTA", "TRINTA E UM", 
                   "TRINTA E DOIS", "TRINTA E TRÊS", "TRINTA E QUATRO", "TRINTA E CINCO", "TRINTA E SEIS", 
                   "TRINTA E SETE", "TRINTA E OITO", "TRINTA E NOVE", "QUARENTA", "QUARENTA E UM", "QUARENTA E DOIS", 
                   "QUARENTA E TRÊS", "QUARENTA E QUATRO", "QUARENTA E CINCO", "QUARENTA E SEIS", "QUARENTA E SETE", 
                   "QUARENTA E OITO", "QUARENTA E Nove", "CINQUENTA", "CINQUENTA E UM", "CINQUENTA E DOIS", 
                   "CINQUENTA E TRÊS", "CINQUENTA E QUATRO", "CINQUENTA E CINCO", "CINQUENTA E SEIS", 
                   "CINQUENTA E SETE", "CINQUENTA E OITO", "CINQUENTA E NOVE", "SESSENTA", "SESSENTA E UM", 
                   "SESSENTA E DOIS", "SESSENTA E TRÊS", "SESSENTA E QUATRO", "SESSENTA E CINCO", "SESSENTA E SEIS", 
                   "SESSENTA E SETE", "SESSENTA E OITO", "SESSENTA E Nove", "SETENTA", "SETENTA E UM", 
                   "SETENTA E DOIS", "SETENTA E TRÊS", "SETENTA E QUATRO", "SETENTA E CINCO", "SETENTA E SEIS", 
                   "SETENTA E SETE", "SETENTA E OITO", "SETENTA E Nove", "OITENTA", "OITENTA E UM", 
                   "OITENTA E DOIS", "OITENTA E TRÊS", "OITENTA E QUATRO", "OITENTA E CINCO", "OITENTA E SEIS", 
                   "OITENTA E SETE", "OITENTA E OITO", "OITENTA E NOVE", "NOVENTA", "NOVENTA E UM", 
                   "NOVENTA E DOIS", "NOVENTA E TRÊS", "NOVENTA E QUATRO", "NOVENTA E CINCO", "NOVENTA E SEIS", 
                   "NOVENTA E SETE", "NOVENTA E OITO", "NOVENTA E Nove", "CEM", "CEM MIL"}

    if n <= 100000 then
        return words[n + 1] .. " !"
    else
        return tostring(n) .. " !"
    end
end

-- Variáveis para controlar visibilidade e interrupção
local guiVisible = true
local running = false
local connection
local logs = {}

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
playButton.Size = UDim2.new(0.4, 0, 0.15, 0)
playButton.Position = UDim2.new(0.1, 0, 0.8, 0)
playButton.Font = Enum.Font.SourceSansBold
playButton.TextScaled = true
playButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
playButton.TextColor3 = Color3.fromRGB(255, 255, 255)
playButton.BorderSizePixel = 0

local stopButton = Instance.new("TextButton", frame)
stopButton.Text = "PARAR"
stopButton.Size = UDim2.new(0.4, 0, 0.15, 0)
stopButton.Position = UDim2.new(0.5, 0, 0.8, 0)
stopButton.Font = Enum.Font.SourceSansBold
stopButton.TextScaled = true
stopButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
stopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
stopButton.BorderSizePixel = 0

local logFrame = Instance.new("Frame", screenGui)
logFrame.Size = UDim2.new(0.3, 0, 0
