local Library = loadstring(game:HttpGet("https://pastefy.app/IEsfnVtX/raw"))()

local Window = Library:CreateWindow("by benqxc")
local Tab1 = Window:AddTab("Spin")
local Tab2 = Window:AddTab("Game")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SpinPrizeEvent = ReplicatedStorage.Remotes:WaitForChild("SpinPrizeEvent") or ReplicatedStorage:WaitForChild("SpinPrizeEvent")
local DigEvent = ReplicatedStorage.Remotes:WaitForChild("DigEvent") or ReplicatedStorage:WaitForChild("DigEvent")

-- Таблица для хранения активных циклов
local activeLoops = {}

-- Функция для создания зацикленных призов
local function createPrizeToggle(tab, text, prizeId)
    tab:AddToggle({
        Text = text,
        Default = false,
        Callback = function(value)
            if value then
                activeLoops[prizeId] = true
                coroutine.wrap(function()
                    while activeLoops[prizeId] do
                        SpinPrizeEvent:FireServer(prizeId)
                        task.wait(0.1)
                    end
                end)()
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
    local locations = {
        ReplicatedStorage,
        ReplicatedStorage.Remotes,
        game:GetService("Workspace"),
        game:GetService("Players").LocalPlayer
    }
    
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
            -- Пытаемся найти событие для получения питомцев
            local PetEvent = getAllPets()
            
            if PetEvent then
                activeLoops.pets = true
                coroutine.wrap(function()
                    while activeLoops.pets do
                        -- Отправляем запрос на получение питомца
                        PetEvent:FireServer()
                        
                        -- Также пытаемся получить питомцев через другие возможные методы
                        SpinPrizeEvent:FireServer(4) -- Dominus (часто дает питомцев)
                        SpinPrizeEvent:FireServer(5) -- 250 Gems (может использоваться для покупки питомцев)
                        
                        task.wait(0.2)
                    end
                end)()
            else
                Library:Notify("Ошибка", "Не найден RemoteEvent для питомцев!", 5)
                Tab2:GetToggles()[1]:SetValue(false) -- Отключаем переключатель
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
            activeLoops.money = true
            coroutine.wrap(function()
                while activeLoops.money do
                    DigEvent:FireServer("hello")
                    task.wait(0.1)
                end
            end)()
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
            activeLoops.resources = true
            coroutine.wrap(function()
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
            end)()
        else
            activeLoops.resources = false
        end
    end
})
