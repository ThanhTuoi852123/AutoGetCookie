local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local done = {}
local FIRE_DISTANCE = 7

local function getDistance(pos1, pos2)
    return (pos1 - pos2).Magnitude
end

local function tweenTo(pos)
    local distance = (hrp.Position - pos).Magnitude
    local time = distance / 20 -- 20 studs/giây
    local tween = TweenService:Create(hrp, TweenInfo.new(time, Enum.EasingStyle.Linear), {
        CFrame = CFrame.new(pos)
    })
    tween:Play()
    tween.Completed:Wait()
end

while task.wait(0.2) do
    for _, v in pairs(workspace.MovingAnimals:GetChildren()) do
        local rootPart = v:FindFirstChild("HumanoidRootPart")
        if rootPart and rootPart:FindFirstChild("Info") then
            local overhead = rootPart.Info:FindFirstChild("AnimalOverhead")
            if overhead and overhead:FindFirstChild("Rarity") and overhead.Rarity.Text:lower() == "secret" then
                
                if not done[v] then
                    if getDistance(hrp.Position, rootPart.Position) > FIRE_DISTANCE then
                        tweenTo(rootPart.Position + Vector3.new(0, 2, 0)) -- bay mượt đến gần
                    end

                    if getDistance(hrp.Position, rootPart.Position) <= FIRE_DISTANCE then
                        local prompt = rootPart:FindFirstChild("PromptAttachment")
                        if prompt and prompt:FindFirstChild("ProximityPrompt") then
                            fireproximityprompt(prompt.ProximityPrompt)
                            done[v] = true

                            -- Gửi Discord webhook
                            local url = "https://discord.com/api/webhooks/1192054950629494814/iE350ER0cwGpPc1E-Oi_rarmvlcby4uUR0fOr0bh_Vr2T38pVK3Bn5KeseqoiiQ9vniH"
                            local data = {
                                ["username"] = "Tuoidz",
                                ["embeds"] = {{
                                    ["title"] = player.Name,
                                    ["description"] = "Secret: " .. overhead.DisplayName.Text,
                                    ["color"] = 16711680
                                }}
                            }

                            local encoded = HttpService:JSONEncode(data)

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
