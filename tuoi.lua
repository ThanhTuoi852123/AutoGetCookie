print(1)


local done = {}
local FIRE_DISTANCE = 7
local MOVE_SPEED = 25
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local function getDistance(a, b)
    return (a - b).Magnitude
end

local function followTarget(targetPart)
    while getDistance(hrp.Position, targetPart.Position) > FIRE_DISTANCE do
        local distance = getDistance(hrp.Position, targetPart.Position)
        local duration = distance / MOVE_SPEED

        local tween = TweenService:Create(hrp, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
            CFrame = CFrame.new(targetPart.Position + Vector3.new(0, 2, 0))
        })
        tween:Play()
        task.wait(0.05) 
    end
end

while task.wait(0.2) do
    local success, err = pcall(function()
    player = game.Players.LocalPlayer
    char = player.Character or player.CharacterAdded:Wait() 
    hrp = char:WaitForChild("HumanoidRootPart")
    for _, v in pairs(workspace.MovingAnimals:GetChildren()) do
        local rootPart = v:FindFirstChild("HumanoidRootPart")
        if rootPart and rootPart:FindFirstChild("Info") then
            local overhead = rootPart.Info:FindFirstChild("AnimalOverhead")
            if overhead and overhead:FindFirstChild("Rarity") and overhead.Rarity.Text:lower() == "secret" then
                
                if not done[v] then
                    followTarget(rootPart)
                    if getDistance(hrp.Position, rootPart.Position) <= FIRE_DISTANCE then
                        local prompt = rootPart:FindFirstChild("PromptAttachment")
                        if prompt and prompt:FindFirstChild("ProximityPrompt") then
                            fireproximityprompt(prompt.ProximityPrompt)
                            done[v] = true
                            local url = "https://discord.com/api/webhooks/1192054950629494814/iE350ER0cwGpPc1E-Oi_rarmvlcby4uUR0fOr0bh_Vr2T38pVK3Bn5KeseqoiiQ9vniH"
                            local data = {
                                ["username"] = "Tuoidz",
                                ["embeds"] = {{
                                    ["title"] = player.Name,
                                    ["description"] = "Secret: " .. overhead.DisplayName.Text,
                                    ["color"] = 65280
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
        end)
end
