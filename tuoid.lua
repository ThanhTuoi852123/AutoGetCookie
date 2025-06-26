
function getpot()
    for _,v in pairs(workspace.Plots:GetChildren()) do
        if string.find(v.PlotSign.SurfaceGui.Frame.TextLabel.Text, game.Players.LocalPlayer.Name) then
            return v
        end
    end
end
function spin()
    game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RE/RainbowSpinWheelService/Spin"):FireServer()
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

        if price and price.Text and rarity:lower() ~= "secret" then
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
    local humanoid = player.Character and player.Character:WaitForChild("Humanoid")
    for _, v in pairs(tuoi.AnimalPodiums:GetChildren()) do
        local hitbox = v:FindFirstChild("Claim") and v.Claim:FindFirstChild("Hitbox")
        if hitbox and hitbox:FindFirstChildWhichIsA("TouchTransmitter") then
            humanoid:MoveTo(hitbox.Position)
        end
        task.wait(0.5)
    end
end
function auto_buy_or_farm()
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")
    local hrp = char:WaitForChild("HumanoidRootPart")

    local tuoi = getpot()
    local function getDistance(pos1, pos2)
            return (pos1 - pos2).Magnitude
    end
    if check_brain(tuoi) == false then
        local highestOwnedPrice = get_highest_price_brain(tuoi)
        local done = {} -- để tránh bắt 2 lần

        local FIRE_DISTANCE = 7
        

        for _, v in pairs(workspace.MovingAnimals:GetChildren()) do
            local rootPart = v:FindFirstChild("HumanoidRootPart")
            if rootPart and rootPart:FindFirstChild("Info") then
                local overhead = rootPart.Info:FindFirstChild("AnimalOverhead")
                local price = overhead and overhead:FindFirstChild("Price")
                if price and tonumber(price.Text) then
                    local value = tonumber(price.Text)
                    local currentCash = player:WaitForChild("leaderstats"):WaitForChild("Cash").Value

                    if value > tonumber(highestOwnedPrice) and not done[v] then
                        if currentCash >= value then
                            -- đủ tiền → di chuyển và bắt
                            if getDistance(hrp.Position, rootPart.Position) > FIRE_DISTANCE then
                                humanoid:MoveTo(rootPart.Position)
                            else
                                local prompt = rootPart:FindFirstChild("PromptAttachment")
                                if prompt and prompt:FindFirstChild("ProximityPrompt") then
                                    fireproximityprompt(prompt.ProximityPrompt)
                                    done[v] = true
                                    print("Đã bắt SECRET giá trị:", value)
                                end
                            end
                        else
                            sell(tuoi)
                        end
                    end
                end
            end
        end
    else
        local s,a = get_lowest_price_brain(tuoi)
        if getDistance(hrp.Position, s.Claim.Hitbox.Position) > FIRE_DISTANCE then
            humanoid:MoveTo(rootPart.Position)
        else
            fireproximityprompt(s.Base.Spawn.PromptAttachment.ProximityPrompt)
        end
        
    end
end


auto_buy_or_farm()
