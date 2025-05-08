--// Contador de Números - Script do Adry
local ui_open = true
local dragging = false
local offset = Vector2.new()
local running = false
local count = 0
local max_count = 0

--// Criando a interface
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ProgressLabel = Instance.new("TextLabel")
local StartInput = Instance.new("TextBox")
local EndInput = Instance.new("TextBox")
local DelayInput = Instance.new("TextBox")
local StartButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local Subtitle = Instance.new("TextLabel")

ScreenGui.Name = "AdryCounterUI"
ScreenGui.Parent = game:GetService("CoreGui")

Frame.Name = "MainFrame"
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.BorderSizePixel = 0
Frame.Size = UDim2.new(0, 300, 0, 400)
Frame.Position = UDim2.new(0.5, -150, 0.5, -200)
Frame.Active = true
Frame.Draggable = false
Frame.BackgroundTransparency = 0.05

Title.Name = "Title"
Title.Parent = Frame
Title.Text = "Contador de Números"
Title.Size = UDim2.new(1, 0, 0.15, 0)
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.TextColor3 = Color3.fromRGB(0, 0, 0)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 24
Title.BorderSizePixel = 0

Subtitle.Name = "Subtitle"
Subtitle.Parent = Frame
Subtitle.Text = "Insira os números e pressione Começar"
Subtitle.Size = UDim2.new(1, 0, 0.1, 0)
Subtitle.Position = UDim2.new(0, 0, 0.15, 0)
Subtitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Subtitle.TextColor3 = Color3.fromRGB(100, 100, 100)
Subtitle.Font = Enum.Font.SourceSans
Subtitle.TextSize = 18
Subtitle.BorderSizePixel = 0

ProgressLabel.Name = "ProgressLabel"
ProgressLabel.Parent = Frame
ProgressLabel.Text = ""
ProgressLabel.Size = UDim2.new(1, 0, 0.15, 0)
ProgressLabel.Position = UDim2.new(0, 0, 0.25, 0)
ProgressLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ProgressLabel.TextColor3 = Color3.fromRGB(0, 170, 0)
ProgressLabel.Font = Enum.Font.SourceSansBold
ProgressLabel.TextSize = 22
ProgressLabel.BorderSizePixel = 0

StartInput.Name = "StartInput"
StartInput.Parent = Frame
StartInput.PlaceholderText = "Número inicial"
StartInput.Text = "1"
StartInput.Size = UDim2.new(0.8, 0, 0.15, 0)
StartInput.Position = UDim2.new(0.1, 0, 0.4, 0)
StartInput.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
StartInput.TextColor3 = Color3.fromRGB(0, 0, 0)
StartInput.Font = Enum.Font.SourceSans
StartInput.TextSize = 18
StartInput.BorderSizePixel = 0

EndInput.Name = "EndInput"
EndInput.Parent = Frame
EndInput.PlaceholderText = "Número final"
EndInput.Text = "50"
EndInput.Size = UDim2.new(0.8, 0, 0.15, 0)
EndInput.Position = UDim2.new(0.1, 0, 0.55, 0)
EndInput.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
EndInput.TextColor3 = Color3.fromRGB(0, 0, 0)
EndInput.Font = Enum.Font.SourceSans
EndInput.TextSize = 18
EndInput.BorderSizePixel = 0

DelayInput.Name = "DelayInput"
DelayInput.Parent = Frame
DelayInput.PlaceholderText = "Tempo entre números (s)"
DelayInput.Text = "1"
DelayInput.Size = UDim2.new(0.8, 0, 0.15, 0)
DelayInput.Position = UDim2.new(0.1, 0, 0.7, 0)
DelayInput.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
DelayInput.TextColor3 = Color3.fromRGB(0, 0, 0)
DelayInput.Font = Enum.Font.SourceSans
DelayInput.TextSize = 18
DelayInput.BorderSizePixel = 0

StartButton.Name = "StartButton"
StartButton.Parent = Frame
StartButton.Text = "Começar"
StartButton.Size = UDim2.new(0.8, 0, 0.15, 0)
StartButton.Position = UDim2.new(0.1, 0, 0.85, 0)
StartButton.BackgroundColor3 = Color3.fromRGB(0, 122, 255)
StartButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StartButton.Font = Enum.Font.SourceSansBold
StartButton.TextSize = 20
StartButton.BorderSizePixel = 0
StartButton.AutoButtonColor = true

CloseButton.Name = "CloseButton"
CloseButton.Parent = Frame
CloseButton.Text = "✖"
CloseButton.Size = UDim2.new(0.1, 0, 0.15, 0)
CloseButton.Position = UDim2.new(0.9, -10, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextSize = 20
CloseButton.BorderSizePixel = 0

--// Funções do botão fechar
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
