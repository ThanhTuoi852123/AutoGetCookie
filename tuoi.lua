print(1)
local PathfindingService = game:GetService("PathfindingService")
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")

local done = {}
local FIRE_DISTANCE = 7

local function getDistance(pos1, pos2)
    return (pos1 - pos2).Magnitude
end

local function goTo(targetPos)
    local path = PathfindingService:CreatePath({
        AgentRadius = 2,
        AgentHeight = 5,
        AgentCanJump = true,
        AgentCanClimb = true
    })
    path:ComputeAsync(hrp.Position, targetPos)

    if path.Status == Enum.PathStatus.Complete then
        for _, waypoint in pairs(path:GetWaypoints()) do
            humanoid:MoveTo(waypoint.Position)
            humanoid.MoveToFinished:Wait()
        end
    else
        warn("❌ Không tìm được đường đến mục tiêu")
    end
end

while task.wait(0.5) do
    for _, v in pairs(workspace.MovingAnimals:GetChildren()) do
        local rootPart = v:FindFirstChild("HumanoidRootPart")
        if rootPart and rootPart:FindFirstChild("Info") then
            local overhead = rootPart.Info:FindFirstChild("AnimalOverhead")
            if overhead and overhead:FindFirstChild("Rarity") and overhead.Rarity.Text:lower() == "epic" then
                
                if not done[v] then
                    if getDistance(hrp.Position, rootPart.Position) > FIRE_DISTANCE then
                        goTo(rootPart.Position) -- ✅ Sử dụng pathfinding để né vật cản
                    else
                        local prompt = rootPart:FindFirstChild("PromptAttachment")
                        if prompt and prompt:FindFirstChild("ProximityPrompt") then
                            fireproximityprompt(prompt.ProximityPrompt)
                            done[v] = true

                            -- Gửi Discord webhook
                            local url = "https://discord.com/api/webhooks/1192054950629494814/iE350ER0cwGpPc1E-Oi_rarmvlcby4uUR0fOr0bh_Vr2T38pVK3Bn5KeseqoiiQ9vniH"
                            local data = {
                                ["username"] = "Tuoidz",
                                ["embeds"] = {{
                                    ["title"] = game.Players.LocalPlayer.Name,
                                    ["description"] = "Secret: " .. overhead.DisplayName.Text,
                                    ["color"] = 16711680
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

