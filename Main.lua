--// Contador de JJs - Script do Adry
local max_count = 1000
local count = 0
local ui_open = true
local dragging = false
local offset = Vector2.new()
local running = false

--// Criando a interface
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Progress = Instance.new("TextLabel")
local StartStopButton = Instance.new("TextButton")

ScreenGui.Name = "AdryJJCounter"
ScreenGui.Parent = game:GetService("CoreGui")

Frame.Name = "MainFrame"
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Size = UDim2.new(0, 300, 0, 150)
Frame.Position = UDim2.new(0.5, -150, 0.5, -75)
Frame.Active = true
Frame.Draggable = false

Title.Name = "Title"
Title.Parent = Frame
Title.Text = "Script do Adry"
Title.Size = UDim2.new(1, 0, 0.2, 0)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20
Title.BorderSizePixel = 0

Progress.Name = "Progress"
Progress.Parent = Frame
Progress.Text = "Aguardando..."
Progress.Size = UDim2.new(1, 0, 0.4, 0)
Progress.Position = UDim2.new(0, 0, 0.2, 0)
Progress.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Progress.TextColor3 = Color3.fromRGB(255, 255, 255)
Progress.Font = Enum.Font.SourceSans
Progress.TextSize = 18
Progress.BorderSizePixel = 0

StartStopButton.Name = "StartStopButton"
StartStopButton.Parent = Frame
StartStopButton.Text = "Começar"
StartStopButton.Size = UDim2.new(1, -20, 0.3, 0)
StartStopButton.Position = UDim2.new(0, 10, 0.6, 0)
StartStopButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
StartStopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StartStopButton.Font = Enum.Font.SourceSansBold
StartStopButton.TextSize = 18
StartStopButton.BorderSizePixel = 0

--// Numeros por extenso
local numeros = {"ZERO", "UM", "DOIS", "TRÊS", "QUATRO", "CINCO", "SEIS", "SETE", "OITO", "NOVE", "DEZ"}
for i = 11, max_count do
    table.insert(numeros, tostring(i))
end

--// Função para enviar mensagens
local function enviarMensagem(mensagem)
    game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents")
    :WaitForChild("SayMessageRequest")
    :FireServer(mensagem, "All")
end

--// Controle do botão
StartStopButton.MouseButton1Click:Connect(function()
    if running then
        running = false
        StartStopButton.Text = "Começar"
        Progress.Text = "Pausado em: " .. numeros[count] .. " !"
    else
        running = true
        StartStopButton.Text = "Parar"
        spawn(function()
            while running and count < max_count do
                count += 1
                local mensagem = numeros[count] .. " !"
                enviarMensagem(mensagem)
                Progress.Text = mensagem .. " - " .. count .. " de " .. max_count
                task.wait(0.5) -- Ajuste a velocidade aqui
            end
            if count >= max_count then
                running = false
                StartStopButton.Text = "Começar"
                Progress.Text = "Concluído!"
            end
        end)
    end
end)

--// Controle de movimento do menu
Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        offset = Frame.Position - UDim2.fromOffset(input.Position.X, input.Position.Y)
    end
end)

Frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        Frame.Position = UDim2.fromOffset(input.Position.X, input.Position.Y) + offset
    end
end)

--// Controle de visibilidade com Alt
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.LeftAlt then
        ui_open = not ui_open
        Frame.Visible = ui_open
    end
end)
