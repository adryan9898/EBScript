local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function numberToWords(n)
    local words = {"ZERO", "UM", "DOIS", "TRÊS", "QUATRO", "CINCO", "SEIS", "SETE", "OITO", "NOVE", "DEZ"}
    if n <= 10 then return words[n + 1] .. " !" end
    return tostring(n) .. " !" -- Fallback para números acima de 10
end

local function createUI()
    local screenGui = Instance.new("ScreenGui", game.CoreGui)
    screenGui.Name = "EBNumberMenu"

    local frame = Instance.new("Frame", screenGui)
    frame.Size = UDim2.new(0.3, 0, 0.4, 0)
    frame.Position = UDim2.new(0.35, 0, 0.3, 0)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0

    local title = Instance.new("TextLabel", frame)
    title.Text = "JOGO DE EB"
    title.Size = UDim2.new(1, 0, 0.2, 0)
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
    playButton.Size = UDim2.new(0.8, 0, 0.15, 0)
    playButton.Position = UDim2.new(0.1, 0, 0.8, 0)
    playButton.Font = Enum.Font.SourceSansBold
    playButton.TextScaled = true
    playButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
    playButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    playButton.BorderSizePixel = 0

    playButton.MouseButton1Click:Connect(function()
        local startNum = tonumber(startBox.Text) or 0
        local endNum = tonumber(endBox.Text) or 10
        for i = startNum, endNum do
            ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents")
            :WaitForChild("SayMessageRequest")
            :FireServer(numberToWords(i), "All")
            task.wait(1.5)
        end
        screenGui:Destroy()
    end)
end

createUI()
  
