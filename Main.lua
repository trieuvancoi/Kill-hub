-- Main.lua
-- GUI Hack với Fly + Kill Aura

-- Tạo ScreenGui
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 120)
Frame.Position = UDim2.new(0.05, 0, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(40,40,40)
Frame.Active = true
Frame.Draggable = true

-- Nút Fly
local flyBtn = Instance.new("TextButton", Frame)
flyBtn.Size = UDim2.new(1, -20, 0, 40)
flyBtn.Position = UDim2.new(0, 10, 0, 10)
flyBtn.Text = "Fly: OFF"
flyBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
flyBtn.TextColor3 = Color3.new(1,1,1)

-- Nút Kill Aura
local auraBtn = Instance.new("TextButton", Frame)
auraBtn.Size = UDim2.new(1, -20, 0, 40)
auraBtn.Position = UDim2.new(0, 10, 0, 60)
auraBtn.Text = "Aura: OFF"
auraBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
auraBtn.TextColor3 = Color3.new(1,1,1)

-- Fly function
local flying = false
local plr = game.Players.LocalPlayer
local hum = plr.Character:WaitForChild("HumanoidRootPart")

flyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    flyBtn.Text = flying and "Fly: ON" or "Fly: OFF"

    if flying then
        spawn(function()
            while flying do
                task.wait()
                hum.Velocity = Vector3.new(0,50,0) -- bay lên
            end
        end)
    end
end)

-- Kill Aura function
local auraOn = false

auraBtn.MouseButton1Click:Connect(function()
    auraOn = not auraOn
    auraBtn.Text = auraOn and "Aura: ON" or "Aura: OFF"

    if auraOn then
        spawn(function()
            while auraOn do
                task.wait(0.5)
                for _,v in pairs(workspace:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v.Name ~= plr.Name then
                        v.Humanoid.Health = 0 -- tiêu diệt
                    end
                end
            end
        end)
    end
end)
