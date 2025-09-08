-- Redz Kill Aura | Configurable
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- ⚙️ Config chỉnh ở đây:
local auraRange = 25    -- Tầm đánh (bao xa)
local maxTargets = 3    -- Số quái đánh cùng lúc
local damage = 15       -- Sát thương mỗi hit

RunService.Heartbeat:Connect(function()
    if character and character:FindFirstChild("HumanoidRootPart") then
        local root = character.HumanoidRootPart
        local count = 0
        for _, mob in pairs(workspace:GetDescendants()) do
            if mob:IsA("Model") and mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") then
                if mob ~= character and mob.Humanoid.Health > 0 then
                    local dist = (mob.HumanoidRootPart.Position - root.Position).Magnitude
                    if dist <= auraRange then
                        pcall(function()
                            mob.Humanoid:TakeDamage(damage)
                        end)
                        count = count + 1
                        if count >= maxTargets then break end
                    end
                end
            end
        end
    end
end)
