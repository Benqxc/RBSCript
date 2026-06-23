local Library = loadstring(game:HttpGet("https://pastefy.app/IEsfnVtX/raw"))()

local Window = Library:CreateWindow("by benqxc")
local Tab1 = Window:AddTab("Spin")
local Tab2 = Window:AddTab("Game")

local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- WaitForChild без таймаута никогда не вернёт nil, поэтому конструкция
-- "a:WaitForChild(...) or b:WaitForChild(...)" не работала как fallback,
-- а обращение ReplicatedStorage.Remotes падало, если папки Remotes нет.
local function waitForRemote(name, timeout)
    timeout = timeout or 5
    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
    local found = remotes and remotes:WaitForChild(name, timeout)
    if not found then
        found = ReplicatedStorage:WaitForChild(name, timeout)
    end
    if not found then
        warn(("[Dig to Earth's CORE!] RemoteEvent '%s' не найден"):format(name))
    end
    return found
end

local SpinPrizeEvent = waitForRemote("SpinPrizeEvent")
local DigEvent = waitForRemote("DigEvent")

-- Таблица для хранения активных циклов
local activeLoops = {}

-- Функция для создания зацикленных призов
local function createPrizeToggle(tab, text, prizeId)
    tab:AddToggle({
        Text = text,
        Default = false,
        Callback = function(value)
            if value then
                if not SpinPrizeEvent then
                    warn("[Dig to Earth's CORE!] SpinPrizeEvent не найден — переключатель не работает")
                    return
                end
                -- не запускаем второй цикл, если он уже активен
                if activeLoops[prizeId] then return end
                activeLoops[prizeId] = true
                task.spawn(function()
                    while activeLoops[prizeId] do
                        SpinPrizeEvent:FireServer(prizeId)
                        task.wait(0.1)
                    end
                end)
            else
                activeLoops[prizeId] = false
            end
        end
    })
end

-- Создаем призы с автоматической зацикленной работой
createPrizeToggle(Tab1, "Collect 75 Gems", 9)
createPrizeToggle(Tab1, "Collect x10 Cash", 8)
createPrizeToggle(Tab1, "Collect 3 Spin", 7)
createPrizeToggle(Tab1, "Collect 1K Cash", 6)
createPrizeToggle(Tab1, "Collect 250 Gems", 5)
createPrizeToggle(Tab1, "Collect Dominus(Dupe Lol)", 4)
createPrizeToggle(Tab1, "Collect Spin", 3)
createPrizeToggle(Tab1, "Collect 2.5K Cash", 2)
createPrizeToggle(Tab1, "Collect 100 Gems", 1)

-- Улучшенная функция для поиска RemoteEvent
local function findRemoteEvent(possibleNames)
    -- FindFirstChild вместо прямого обращения: папки Remotes может не быть
    local locations = { ReplicatedStorage }
    local remotesFolder = ReplicatedStorage:FindFirstChild("Remotes")
    if remotesFolder then
        table.insert(locations, remotesFolder)
    end
    table.insert(locations, game:GetService("Workspace"))
    table.insert(locations, game:GetService("Players").LocalPlayer)
    
    for _, location in ipairs(locations) do
        for _, name in ipairs(possibleNames) do
            local found = location:FindFirstChild(name)
            if found and found:IsA("RemoteEvent") then
                return found
            end
        end
    end
    
    return nil
end

-- Функция для получения всех питомцев
local function getAllPets()
    -- Пытаемся найти правильный RemoteEvent для питомцев
    local petEvent = findRemoteEvent({
        "ClaimPetEvent", "GetPetEvent", "UnlockPetEvent",
        "PetRewardEvent", "AddPetEvent", "GainPetEvent"
    })
    
    if petEvent then
        return petEvent
    end
    
    -- Если не нашли, попробуем получить все возможные награды
    local rewardEvent = findRemoteEvent({
        "ClaimRewardEvent", "GetRewardEvent", "UnlockRewardEvent",
        "SpinRewardEvent", "AddRewardEvent", "GainRewardEvent"
    })
    
    return rewardEvent
end

Tab2:AddToggle({
    Text = "Get All Pets",
    Default = false,
    Callback = function(value)
        if value then
            if activeLoops.pets then return end
            -- Пытаемся найти событие для получения питомцев
            local PetEvent = getAllPets()
            
            if PetEvent then
                activeLoops.pets = true
                task.spawn(function()
                    while activeLoops.pets do
                        -- Отправляем запрос на получение питомца
                        PetEvent:FireServer()
                        
                        -- Также пытаемся получить питомцев через другие возможные методы
                        if SpinPrizeEvent then
                            SpinPrizeEvent:FireServer(4) -- Dominus (часто дает питомцев)
                            SpinPrizeEvent:FireServer(5) -- 250 Gems (может использоваться для покупки питомцев)
                        end
                        
                        task.wait(0.2)
                    end
                end)
            else
                -- Notify/GetToggles есть не во всех версиях библиотеки — защищаемся pcall
                pcall(function()
                    Library:Notify("Ошибка", "Не найден RemoteEvent для питомцев!", 5)
                end)
                warn("[Dig to Earth's CORE!] Не найден RemoteEvent для питомцев")
            end
        else
            activeLoops.pets = false
        end
    end
})

-- Авто-фарм денег
Tab2:AddToggle({
    Text = "Auto Money(inf)",
    Default = false,
    Callback = function(value)
        if value then
            if not DigEvent then
                warn("[Dig to Earth's CORE!] DigEvent не найден — переключатель не работает")
                return
            end
            if activeLoops.money then return end
            activeLoops.money = true
            task.spawn(function()
                while activeLoops.money do
                    DigEvent:FireServer("hello")
                    task.wait(0.1)
                end
            end)
        else
            activeLoops.money = false
        end
    end
})

-- Дополнительная функция для быстрого получения ресурсов
Tab2:AddToggle({
    Text = "Fast Resources",
    Default = false,
    Callback = function(value)
        if value then
            if not SpinPrizeEvent then
                warn("[Dig to Earth's CORE!] SpinPrizeEvent не найден — переключатель не работает")
                return
            end
            if activeLoops.resources then return end
            activeLoops.resources = true
            task.spawn(function()
                while activeLoops.resources do
                    -- Быстрое получение различных ресурсов
                    SpinPrizeEvent:FireServer(9) -- 75 Gems
                    SpinPrizeEvent:FireServer(8) -- x10 Cash
                    SpinPrizeEvent:FireServer(6) -- 1K Cash
                    SpinPrizeEvent:FireServer(5) -- 250 Gems
                    SpinPrizeEvent:FireServer(2) -- 2.5K Cash
                    SpinPrizeEvent:FireServer(1) -- 100 Gems
                    
                    task.wait(0.3)
                end
            end)
        else
            activeLoops.resources = false
        end
    end
})
