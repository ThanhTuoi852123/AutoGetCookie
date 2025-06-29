function getpot()
    for _,v in pairs(workspace.Plots:GetChildren()) do
        if string.find(v.PlotSign.SurfaceGui.Frame.TextLabel.Text, game.Players.LocalPlayer.Name) then
            return v
        end
    end
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
                    if value > tonumber(highestOwnedPrice) and not done[v] then
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
                                                break
                                            end
                                        end
                                    else
                                        break
                                    end
                                end
                            end
                    else
                        if value > tonumber(sdf) and not done[v] then
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
                            end
                        end
                    end
                end
            end
        else
            humanoid:MoveTo(tuoi.Spawn.Position)
            humanoid.MoveToFinished:Wait()
            sell()
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
        end
    end
end
local VirtualUser = game:service "VirtualUser"
game:service("Players").LocalPlayer.Idled:connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

spawn(function()
    while task.wait(10) do
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



