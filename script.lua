-- Dinas Hub ULTRA OP - Standalone Version
-- Не требует внешних библиотек, работает в любом исполнителе

local function CreateDinasHub()
    -- Основные сервисы
    local Players = game:GetService("Players")
    local Player = Players.LocalPlayer
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local CoreGui = game:GetService("CoreGui")
    
    -- Удаляем старый интерфейс, если есть
    if CoreGui:FindFirstChild("DinasHub") then
        CoreGui.DinasHub:Destroy()
    end
    
    -- Создаем основной UI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "DinasHub"
    ScreenGui.Parent = CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Главное окно
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 400, 0, 450)
    MainFrame.Position = UDim2.new(0.5, -200, 0.5, -225)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 30)
    TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = MainFrame
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "TitleLabel"
    TitleLabel.Size = UDim2.new(1, 0, 1, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "Dinas Hub ULTRA OP v5.0"
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 14
    TitleLabel.Parent = TitleBar
    
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -30, 0, 0)
    CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    CloseButton.BorderSizePixel = 0
    CloseButton.Text = "X"
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.TextSize = 14
    CloseButton.TextColor3 = Color3.white
    CloseButton.Parent = TitleBar
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    -- Создаем вкладки
    local TabButtons = {}
    local TabFrames = {}
    local Tabs = {"Spin", "Game", "Dupe", "Teleport", "Player", "Info"}
    
    local TabButtonContainer = Instance.new("Frame")
    TabButtonContainer.Name = "TabButtonContainer"
    TabButtonContainer.Size = UDim2.new(1, 0, 0, 40)
    TabButtonContainer.Position = UDim2.new(0, 0, 0, 30)
    TabButtonContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    TabButtonContainer.BorderSizePixel = 0
    TabButtonContainer.Parent = MainFrame
    
    local TabContentFrame = Instance.new("Frame")
    TabContentFrame.Name = "TabContentFrame"
    TabContentFrame.Size = UDim2.new(1, 0, 1, -70)
    TabContentFrame.Position = UDim2.new(0, 0, 0, 70)
    TabContentFrame.BackgroundTransparency = 1
    TabContentFrame.Parent = MainFrame
    
    for i, tabName in ipairs(Tabs) do
        -- Кнопки вкладок
        local TabButton = Instance.new("TextButton")
        TabButton.Name = tabName.."Button"
        TabButton.Size = UDim2.new(0, 60, 0, 30)
        TabButton.Position = UDim2.new(0, (i-1)*65, 0, 5)
        TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        TabButton.BorderSizePixel = 0
        TabButton.Text = tabName
        TabButton.Font = Enum.Font.Gotham
        TabButton.TextSize = 12
        TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        TabButton.Parent = TabButtonContainer
        
        -- Фреймы контента
        local TabFrame = Instance.new("ScrollingFrame")
        TabFrame.Name = tabName.."Frame"
        TabFrame.Size = UDim2.new(1, 0, 1, 0)
        TabFrame.Position = UDim2.new(0, 0, 0, 0)
        TabFrame.BackgroundTransparency = 1
        TabFrame.Visible = (i == 1)
        TabFrame.CanvasSize = UDim2.new(0, 0, 0, 1000)
        TabFrame.ScrollBarThickness = 5
        TabFrame.Parent = TabContentFrame
        
        TabButtons[tabName] = TabButton
        TabFrames[tabName] = TabFrame
        
        TabButton.MouseButton1Click:Connect(function()
            for _, frame in pairs(TabFrames) do
                frame.Visible = false
            end
            TabFrame.Visible = true
        end)
    end
    
    -- Функция для добавления элементов
    local function AddElement(tabName, elementType, config)
        local TabFrame = TabFrames[tabName]
        if not TabFrame then return end
        
        local elementHeight = 30
        local yPos = #TabFrame:GetChildren() * 35
        
        if elementType == "Toggle" then
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Name = config.Name
            ToggleFrame.Size = UDim2.new(1, -20, 0, elementHeight)
            ToggleFrame.Position = UDim2.new(0, 10, 0, yPos)
            ToggleFrame.BackgroundTransparency = 1
            ToggleFrame.Parent = TabFrame
            
            local ToggleButton = Instance.new("TextButton")
            ToggleButton.Name = "ToggleButton"
            ToggleButton.Size = UDim2.new(0, 20, 0, 20)
            ToggleButton.Position = UDim2.new(0, 0, 0.5, -10)
            ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
            ToggleButton.BorderSizePixel = 0
            ToggleButton.Text = ""
            ToggleButton.Parent = ToggleFrame
            
            local ToggleLabel = Instance.new("TextLabel")
            ToggleLabel.Name = "ToggleLabel"
            ToggleLabel.Size = UDim2.new(1, -30, 1, 0)
            ToggleLabel.Position = UDim2.new(0, 25, 0, 0)
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.Text = config.Text
            ToggleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
            ToggleLabel.Font = Enum.Font.Gotham
            ToggleLabel.TextSize = 12
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            ToggleLabel.Parent = ToggleFrame
            
            local state = config.Default or false
            local function UpdateState()
                if state then
                    ToggleButton.BackgroundColor3 = Color3.fromRGB(80, 180, 80)
                else
                    ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
                end
                config.Callback(state)
            end
            
            ToggleButton.MouseButton1Click:Connect(function()
                state = not state
                UpdateState()
            end)
            
            UpdateState()
            
        elseif elementType == "Button" then
            local Button = Instance.new("TextButton")
            Button.Name = config.Name
            Button.Size = UDim2.new(1, -20, 0, elementHeight)
            Button.Position = UDim2.new(0, 10, 0, yPos)
            Button.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
            Button.BorderSizePixel = 0
            Button.Text = config.Text
            Button.Font = Enum.Font.Gotham
            Button.TextSize = 12
            Button.TextColor3 = Color3.fromRGB(220, 220, 220)
            Button.Parent = TabFrame
            
            Button.MouseButton1Click:Connect(config.Callback)
            
        elseif elementType == "Label" then
            local Label = Instance.new("TextLabel")
            Label.Name = config.Name
            Label.Size = UDim2.new(1, -20, 0, elementHeight)
            Label.Position = UDim2.new(0, 10, 0, yPos)
            Label.BackgroundTransparency = 1
            Label.Text = config.Text
            Label.TextColor3 = Color3.fromRGB(200, 200, 220)
            Label.Font = Enum.Font.Gotham
            Label.TextSize = 12
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = TabFrame
        end
        
        -- Обновляем размер контента
        TabFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + elementHeight + 10)
    end

    -- Безопасное получение событий
    local function GetRemoteEvent(name)
        return ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild(name)
            or ReplicatedStorage:FindFirstChild(name)
    end

    local SpinPrizeEvent = GetRemoteEvent("SpinPrizeEvent")
    local DigEvent = GetRemoteEvent("DigEvent")
    local DupeEvent = GetRemoteEvent("DupeCosmic") or GetRemoteEvent("DuplicatePet")

    -- Конфигурация призов
    local spinPrizes = {
        {name = "75 Gems", id = 9, active = false},
        {name = "x10 Cash", id = 8, active = false},
        {name = "3 Spins", id = 7, active = false},
        {name = "1K Cash", id = 6, active = false},
        {name = "250 Gems", id = 5, active = false},
        {name = "Dominus", id = 4, active = false},
        {name = "1 Spin", id = 3, active = false},
        {name = "2.5K Cash", id = 2, active = false},
        {name = "100 Gems", id = 1, active = false}
    }

    -- Состояния функций
    local farmToggles = {
        money = {running = false, delay = 0.1},
        cosmic = {running = false, delay = 1},
        allPrizes = false
    }

    -- Функция для безопасного вызова событий
    local function SafeFireServer(event, ...)
        if event then
            pcall(function()
                event:FireServer(...)
            end)
        end
    end

    -- Авто-сбор призов
    for _, prize in ipairs(spinPrizes) do
        AddElement("Spin", "Toggle", {
            Name = "AutoCollect"..prize.name,
            Text = "AUTO Collect "..prize.name,
            Default = false,
            Callback = function(value)
                prize.active = value
                if value then
                    coroutine.wrap(function()
                        while prize.active do
                            SafeFireServer(SpinPrizeEvent, prize.id)
                            wait(0.3)
                        end
                    end)()
                end
            end
        })
    end

    -- Кнопка для сбора всех призов
    AddElement("Spin", "Toggle", {
        Name = "CollectAllPrizes",
        Text = "🔥 AUTO COLLECT ALL PRIZES",
        Default = false,
        Callback = function(value)
            farmToggles.allPrizes = value
            if value then
                coroutine.wrap(function()
                    while farmToggles.allPrizes do
                        for _, prize in ipairs(spinPrizes) do
                            SafeFireServer(SpinPrizeEvent, prize.id)
                        end
                        wait(0.5)
                    end
                end)()
            end
        end
    })

    -- Авто-фарм денег
    if DigEvent then
        AddElement("Game", "Toggle", {
            Name = "AutoMoney",
            Text = "💰 Auto Money (INFINITE)",
            Default = false,
            Callback = function(value)
                farmToggles.money.running = value
                if value then
                    coroutine.wrap(function()
                        while farmToggles.money.running do
                            SafeFireServer(DigEvent, "hello")
                            wait(farmToggles.money.delay)
                        end
                    end)()
                end
            end
        })
    else
        AddElement("Game", "Label", {
            Name = "DigEventWarning",
            Text = "DigEvent not found!"
        })
    end

    -- Дупликация питомцев
    if DupeEvent then
        AddElement("Dupe", "Toggle", {
            Name = "DupeCosmic",
            Text = "🌀 DUPE COSMIC PET",
            Default = false,
            Callback = function(value)
                farmToggles.cosmic.running = value
                if value then
                    coroutine.wrap(function()
                        while farmToggles.cosmic.running do
                            SafeFireServer(DupeEvent, "Cosmic")
                            SafeFireServer(DupeEvent, "Ultra Cosmic")
                            SafeFireServer(DupeEvent, "Rainbow Cosmic")
                            wait(farmToggles.cosmic.delay)
                        end
                    end)()
                end
            end
        })
        
        AddElement("Dupe", "Button", {
            Name = "InstantDupe",
            Text = "⚡ INSTANT DUPE 100x",
            Callback = function()
                for i = 1, 100 do
                    SafeFireServer(DupeEvent, "Cosmic")
                    task.wait(0.05)
                end
            end
        })
    else
        AddElement("Dupe", "Label", {
            Name = "DupeEventWarning",
            Text = "DupeEvent not found!"
        })
    end

    -- Телепортация к игрокам
    local function UpdatePlayerList()
        -- Очищаем старые кнопки
        for _, child in ipairs(TabFrames["Teleport"]:GetChildren()) do
            if child.Name ~= "RefreshButton" then
                child:Destroy()
            end
        end
        
        -- Добавляем новых игроков
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= Player then
                AddElement("Teleport", "Button", {
                    Name = "TP_"..player.Name,
                    Text = "TP to "..player.Name,
                    Callback = function()
                        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and
                           player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            Player.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
                        end
                    end
                })
            end
        end
    end

    -- Кнопка обновления списка
    AddElement("Teleport", "Button", {
        Name = "RefreshButton",
        Text = "🔄 Refresh Player List",
        Callback = UpdatePlayerList
    })

    -- Функции игрока
    AddElement("Player", "Button", {
        Name = "ResetCharacter",
        Text = "Reset Character",
        Callback = function()
            if Player.Character then
                Player.Character:BreakJoints()
            end
        end
    })

    -- Информация
    AddElement("Info", "Label", {
        Name = "PlayerName",
        Text = "Player: "..Player.Name
    })
    
    AddElement("Info", "Label", {
        Name = "Version",
        Text = "Dinas Hub ULTRA OP v5.0"
    })
    
    AddElement("Info", "Label", {
        Name = "Status",
        Text = "Status: ACTIVE"
    })

    -- Экстренная остановка
    AddElement("Info", "Button", {
        Name = "EmergencyStop",
        Text = "🛑 EMERGENCY STOP ALL",
        Callback = function()
            farmToggles.money.running = false
            farmToggles.cosmic.running = false
            farmToggles.allPrizes = false
            
            for _, prize in ipairs(spinPrizes) do
                prize.active = false
            end
        end
    })

    -- Инициализация
    UpdatePlayerList()
    
    -- Перетаскивание окна
    local dragging
    local dragInput
    local dragStart
    local startPos

    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    TitleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    return ScreenGui
end

-- Запускаем хаб
CreateDinasHub()

-- Уведомление
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Dinas Hub LOADED!",
    Text = "v5.0 Activated",
    Duration = 5
})
