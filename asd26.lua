function getpot()
    for _,v in pairs(workspace.Plots:GetChildren()) do
        if string.find(v.PlotSign.SurfaceGui.Frame.TextLabel.Text, game.Players.LocalPlayer.Name) then
            return v
        end
    end
end
function send_webhook(url,name,price,rarity,img)
local HttpService = game:GetService("HttpService")
local player = game.Players.LocalPlayer

-- Thông tin pet cần gửi
local petName = name
local petPrice = price
local petRarity = rarity
local petImageURL = img -- ← Thay ảnh thật ở đây

-- Webhook URL
local webhookURL = url

-- Dữ liệu gửi đi
local data = {
    ["username"] = player.Name, -- Tên hiển thị là tên người chơi
    ["embeds"] = {
        {
            ["title"] = "🐾 Brainrot 🐾",
            ["color"] = 16753920, -- Vàng cam (có thể đổi mã màu)
            ["fields"] = {
                {
                    ["name"] = "[🐶 Pet Name]",
                    ["value"] = petName,
                    ["inline"] = true
                },
                {
                    ["name"] = "[💰 Price]",
                    ["value"] = petPrice,
                    ["inline"] = true
                },
                {
                    ["name"] = "[🎖️ Rarity]",
                    ["value"] = petRarity,
                    ["inline"] = true
                }
            },
            ["thumbnail"] = {
                ["url"] = petImageURL
            },
            ["footer"] = {
                ["text"] = "Sent from ThanhTuoi Dev"
            },
            ["timestamp"] = DateTime.now():ToIsoDate()
        }
    }
}

-- Headers
local headers = {
    ["Content-Type"] = "application/json"
}

-- Encode JSON
local body = HttpService:JSONEncode(data)

-- Gửi webhook
local http_request = http_request or request or (syn and syn.request) or (http and http.request)
http_request({
    Url = webhookURL,
    Method = "POST",
    Headers = headers,
    Body = body
})
end
function spin()
    game:GetService("ReplicatedStorage"):FindFirstChild("Packages"):FindFirstChild("Net"):FindFirstChild("RE/RainbowSpinWheelService/Spin"):FireServer()
end
function check_brain(tuoi)
    for _, v in pairs(tuoi.AnimalPodiums:GetChildren()) do
        local spawn = v:FindFirstChild("Base") and v.Base:FindFirstChild("Spawn")
        local attachment = spawn and spawn:FindFirstChild("Attachment")
        if not attachment then
            return false
        end
    end
    return true
end
function parse_price(text)
    local numberPart = text:match("[0-9%.]+") -- bắt số & dấu chấm đầu tiên
    local suffix = text:match("[KMB]") -- kiểm tra có hậu tố K/M/B không

    local multiplier = 1
    if suffix == "K" then
        multiplier = 1_000
    elseif suffix == "M" then
        multiplier = 1_000_000
    elseif suffix == "B" then
        multiplier = 1_000_000_000
    end

    local number = tonumber(numberPart)
    if number then
        return number * multiplier
    end

    return nil
end
function get_lowest_price_brain(tuoi)
    local lowestPrice = math.huge
    local weakestBrain = nil

    for _, v in pairs(tuoi.AnimalPodiums:GetChildren()) do
        local spawn = v:FindFirstChild("Base") and v.Base:FindFirstChild("Spawn")
        local attachment = spawn and spawn:FindFirstChild("Attachment")
        local overhead = attachment and attachment:FindFirstChild("AnimalOverhead")
        local price = overhead and overhead:FindFirstChild("Price")
        local rarity = overhead and overhead:FindFirstChild("Rarity")

        if price and price.Text and rarity.Text:lower() ~= "secret" then
            local value = parse_price(price.Text)

            if value and value < lowestPrice then
                lowestPrice = value
                weakestBrain = v
            end
        end
    end

    return weakestBrain, lowestPrice
end




function get_highest_price_brain(tuoi)
    local highestPrice = 0
    local bestBrain = nil

    for name, v in pairs(tuoi.AnimalPodiums:GetChildren()) do
        local spawn = v:FindFirstChild("Base") and v.Base:FindFirstChild("Spawn")
        local attachment = spawn and spawn:FindFirstChild("Attachment")
        local overhead = attachment and attachment:FindFirstChild("AnimalOverhead")
        local price = overhead and overhead:FindFirstChild("Price")

        if price and price.Text then
            local value = parse_price(price.Text)
            if value and value > highestPrice then
                highestPrice = value
            end
        end
    end

    return highestPrice
end

function sell(tuoi)
    local player = game.Players.LocalPlayer
    local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
    for _, v in pairs(tuoi.AnimalPodiums:GetChildren()) do
        local spawn = v:FindFirstChild("Base") and v.Base:FindFirstChild("Spawn")
        local attachment = spawn and spawn:FindFirstChild("Attachment")
        if attachment then
            local hitbox = v:FindFirstChild("Claim") and v.Claim:FindFirstChild("Hitbox")
            humanoid:MoveTo(hitbox.Position)
            humanoid.MoveToFinished:Wait() 
        end
    end
    humanoid:MoveTo(tuoi.Spawn.Position)
    humanoid.MoveToFinished:Wait()
end
function chase_and_catch(humanoid, rootPart)
    local FIRE_DISTANCE = 7
    local MAX_ATTEMPTS = 150

    for i = 1, MAX_ATTEMPTS do
        local hrp = humanoid.Parent:FindFirstChild("HumanoidRootPart")
        if not hrp or not rootPart then return false end

        local dist = (hrp.Position - rootPart.Position).Magnitude
        if dist > FIRE_DISTANCE then
            humanoid:MoveTo(rootPart.Position)
        else
            local prompt = rootPart:FindFirstChild("PromptAttachment")
            if prompt and prompt:FindFirstChild("ProximityPrompt") then
                fireproximityprompt(prompt.ProximityPrompt)
                print("✅ Đã bắt SECRET sau khi bám:", i, "lần")
                return true
            end
        end

        task.wait(0.1)
    end

    print("❌ Không bắt được (di chuyển quá nhanh?)")
    return false
end
function auto_buy_or_farm()
    
    local FIRE_DISTANCE = 7
    
    local tuoi = getpot()
    local function getDistance(pos1, pos2)
            return (pos1 - pos2).Magnitude
    end
    local done = {} -- để tránh bắt 2 lần
    while task.wait(1) do
        local player = game.Players.LocalPlayer
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:FindFirstChild("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local found = false
        local hcekh = check_brain(tuoi)
        print(hcekh)
        if hcekh == false then
            local highestOwnedPrice = get_highest_price_brain(tuoi)
            for _, v in pairs(workspace.MovingAnimals:GetChildren()) do
                local rootPart = v:FindFirstChild("HumanoidRootPart")
                if rootPart and rootPart:FindFirstChild("Info") then
                    local overhead = rootPart.Info:FindFirstChild("AnimalOverhead")
                    local price = overhead and overhead:FindFirstChild("Price")
                    local value = tonumber(parse_price(price.Text))
                    local currentCash = player:FindFirstChild("leaderstats"):FindFirstChild("Cash").Value
                    local nho, sdf = get_lowest_price_brain(tuoi)
                    if value >= tonumber(highestOwnedPrice) and not done[v] then
                            if currentCash >= value then
                                found = true
                                    
                                while task.wait() do
                                    local rootPart = v:FindFirstChild("HumanoidRootPart")
                                    if rootPart then
                                        if getDistance(hrp.Position, rootPart.Position) > FIRE_DISTANCE then
                                            humanoid:MoveTo(rootPart.Position)
                                        else
                                            local prompt = rootPart:FindFirstChild("PromptAttachment")
                                            if prompt and prompt:FindFirstChild("ProximityPrompt") then
                                                fireproximityprompt(prompt.ProximityPrompt)
                                                done[v] = true
                                            end
                                        end
                                    else
                                        break
                                    end
                                end
                                break
                            end
                    else
                        if value >= tonumber(sdf) and not done[v] then
                            if currentCash >= value then
                                found = true
                                    
                                while task.wait() do
                                    local rootPart = v:FindFirstChild("HumanoidRootPart")
                                    if rootPart then
                                        if getDistance(hrp.Position, rootPart.Position) > FIRE_DISTANCE then
                                            humanoid:MoveTo(rootPart.Position)
                                        else
                                            local prompt = rootPart:FindFirstChild("PromptAttachment")
                                            if prompt and prompt:FindFirstChild("ProximityPrompt") then
                                                fireproximityprompt(prompt.ProximityPrompt)
                                                done[v] = true
                                            end
                                        end
                                    else
                                        break
                                    end
                                end
                                break
                            end
                        end
                    end
                end
            end
        else
            humanoid:MoveTo(tuoi.Spawn.Position)
            humanoid.MoveToFinished:Wait()
            local s,a = get_lowest_price_brain(tuoi)
            for i = 1, 3 do
            if getDistance(hrp.Position, s.Claim.Hitbox.Position) > FIRE_DISTANCE then
                humanoid:MoveTo(s.Claim.Hitbox.Position)
                humanoid.MoveToFinished:Wait() 
            else
                fireproximityprompt(s.Base.Spawn.PromptAttachment.ProximityPrompt)
                break
            end
            end
            
        end
        if not found then
            humanoid:MoveTo(tuoi.Spawn.Position)
            humanoid.MoveToFinished:Wait()
            sell(tuoi)
        else
            humanoid:MoveTo(tuoi.Spawn.Position)
            humanoid.MoveToFinished:Wait()
        end
    end
end
local VirtualUser = game:service "VirtualUser"
game:service("Players").LocalPlayer.Idled:connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)
spawn(function()
    while task.wait(30) do
            spin()
    end
end)
spawn(function()
    auto_buy_or_farm()
end)
spawn(function()
    local VIM = game:GetService("VirtualInputManager")

    while true do
        VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
        wait(0.05)
        VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
        wait(10) -- mỗi 5 giây
    end
end)
-- Làm mờ nền game
-- Làm mờ nền game
local blur = Instance.new("BlurEffect")
blur.Name = "GameBlur"
blur.Size = 24
blur.Parent = game:GetService("Lighting")

-- Tạo GUI
local gui = Instance.new("ScreenGui")
gui.Name = "GameInfoOverlay"
gui.ResetOnSpawn = false
gui.Parent = game:GetService("CoreGui")

-- Frame chính
local mainFrame = Instance.new("Frame")
mainFrame.BackgroundTransparency = 1
mainFrame.Size = UDim2.new(1, 0, 1, 0)
mainFrame.Parent = gui

-- Hàm tạo label
local function createLabel(text, size, color, bold)
    local label = Instance.new("TextLabel")
    label.Text = text
    label.Size = UDim2.new(0, 400, 0, size)
    label.BackgroundTransparency = 1
    label.TextColor3 = color or Color3.new(1, 1, 1)
    label.Font = bold and Enum.Font.GothamBold or Enum.Font.Gotham
    label.TextSize = size
    label.TextStrokeTransparency = 0
    label.TextStrokeColor3 = Color3.new(0, 0, 0)
    label.TextWrapped = true
    label.TextXAlignment = Enum.TextXAlignment.Center
    return label
end

-- Layout
local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 5)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Center
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = mainFrame

-- Dòng tiêu đề và thời gian
local title = createLabel("ThanhTuoi Dev", 40, Color3.fromRGB(0, 255, 255), true)
title.Parent = mainFrame

local timeLabel = createLabel("Time: 0h0m0s", 24)
timeLabel.Parent = mainFrame

-- Bắt đầu đếm thời gian
task.spawn(function()
    local seconds = 0
    while true do
        seconds += 1
        local h = math.floor(seconds / 3600)
        local m = math.floor((seconds % 3600) / 60)
        local s = seconds % 60
        timeLabel.Text = string.format("Time : %02dh%02dm%02ds", h, m, s)
        task.wait(1)
    end
end)

-- Hàm tìm plot của người chơi
function getpot()
    for _,v in pairs(workspace.Plots:GetChildren()) do
        if string.find(v.PlotSign.SurfaceGui.Frame.TextLabel.Text, game.Players.LocalPlayer.Name) then
            return v
        end
    end
end

-- Hàm cập nhật info
function getinfo(tuoi)
    local infoList = {}
    for _, v in pairs(tuoi.AnimalPodiums:GetChildren()) do
        local spawn = v:FindFirstChild("Base") and v.Base:FindFirstChild("Spawn")
        local attachment = spawn and spawn:FindFirstChild("Attachment")
        local overhead = attachment and attachment:FindFirstChild("AnimalOverhead")
        local price = overhead and overhead:FindFirstChild("Price")
        local rarity = overhead and overhead:FindFirstChild("Rarity")
        local display = overhead and overhead:FindFirstChild("DisplayName")
        if rarity and price and display then
            table.insert(infoList, {
                Rarity = rarity.Text,
                Name = display.Text,
                Price = price.Text
            })
        end
    end
    return infoList
end

-- Lấy plot
local tuoi = getpot()

-- Tạo bảng lưu label động
local animalLabels = {}

-- Vòng lặp cập nhật mỗi giây
task.spawn(function()
    while true do
        -- Xóa các label cũ
        for _, lbl in pairs(animalLabels) do
            lbl:Destroy()
        end
        animalLabels = {}

        -- Lấy danh sách mới
        local animals = getinfo(tuoi)
        for _, animal in pairs(animals) do
            local line = string.format("Rarity: %s | Name: %s | Price: %s", animal.Rarity, animal.Name, animal.Price)
            local newLabel = createLabel(line, 22)
            newLabel.Parent = mainFrame
            table.insert(animalLabels, newLabel)
        end

        task.wait(1)
    end
end)




