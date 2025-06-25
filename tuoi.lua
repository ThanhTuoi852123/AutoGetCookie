print(1)
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")

local done = {} -- Lưu các con đã xử lý

-- Khoảng cách đủ gần để fire
local FIRE_DISTANCE = 7

-- Hàm tính khoảng cách
local function getDistance(pos1, pos2)
    return (pos1 - pos2).Magnitude
end

while task.wait(0.1) do
    for _, v in pairs(workspace.MovingAnimals:GetChildren()) do
        local rootPart = v:FindFirstChild("HumanoidRootPart")
        if rootPart and rootPart:FindFirstChild("Info") then
            local overhead = rootPart.Info:FindFirstChild("AnimalOverhead")
            if overhead and overhead:FindFirstChild("Rarity") and overhead.Rarity.Text:lower() == "secret" then
                
                if not done[v] then
                    -- Nếu chưa gần thì tiếp tục chạy theo
                    if getDistance(hrp.Position, rootPart.Position) > FIRE_DISTANCE then
                        humanoid:MoveTo(rootPart.Position)
                    else
                        -- Khi đã đủ gần thì fire và đánh dấu
                        local prompt = rootPart:FindFirstChild("PromptAttachment")
                        if prompt and prompt:FindFirstChild("ProximityPrompt") then
                            fireproximityprompt(prompt.ProximityPrompt)
                            done[v] = true
                            local url = "https://discord.com/api/webhooks/1192054950629494814/iE350ER0cwGpPc1E-Oi_rarmvlcby4uUR0fOr0bh_Vr2T38pVK3Bn5KeseqoiiQ9vniH"
                            local data = {
                                ["username"] = "Tuoidz",
                                ["embeds"] = {{
                                    ["title"] = game.Players.LocalPlayer.Name,
                                    ["description"] = "Secret: " .. overhead.DisplayName.Text,
                                    ["color"] = 16711680 -- Màu đỏ (RGB: 255, 0, 0)
                                }}
                            }

                            local encoded = game:GetService("HttpService"):JSONEncode(data)

                            http_request({
                                Url = url,
                                Method = "POST",
                                Headers = {
                                    ["Content-Type"] = "application/json"
                                },
                                Body = encoded
                            })
                        end
                    end
                end
            end
        end
    end
end
