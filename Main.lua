-- Redz Kill Aura | Full GUI
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui") -- ⚡ PlayerGui thay vì CoreGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 250, 0, 200)
mainFrame.Position = UDim2.new(0.5, -125, 0.4, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Visible = true
mainFrame.Parent = ScreenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "Redz Kill Aura"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.BackgroundColor3 = Color3.fromRGB(20,20,20)
title.Parent = mainFrame

local auraBtn = Instance.new("TextButton")
auraBtn.Size = UDim2.new(1, 0, 0, 30)
auraBtn.Position = UDim2.new(0, 0, 0, 50)
auraBtn.Text = "Kill Aura: OFF"
auraBtn.BackgroundColor3 = Color3.fromRGB(120,0,0)
auraBtn.TextColor3 = Color3.new(1,1,1)
auraBtn.Parent = mainFrame

local rangeBox = Instance.new("TextBox")
rangeBox.Size = UDim2.new(1, -20, 0, 30)
rangeBox.Position = UDim2.new(0, 10, 0, 90)
rangeBox.PlaceholderText = "Range (default 15)"
rangeBox.Text = ""
rangeBox.TextColor3 = Color3.new(1,1,1)
rangeBox.BackgroundColor3 = Color3.fromRGB(60,60,60)
rangeBox.Parent = mainFrame

local maxBox = Instance.new("TextBox")
maxBox.Size = UDim2.new(1, -20, 0, 30)
maxBox.Position = UDim2.new(0, 10, 0, 130)
maxBox.PlaceholderText = "Max Targets (default 1)"
maxBox.Text = ""
maxBox.TextColor3 = Color3.new(1,1,1)
maxBox.BackgroundColor3 = Color3.fromRGB(60,60,60)
maxBox.Parent = mainFrame

local hideBtn = Instance.new("TextButton")
hideBtn.Size = UDim2.new(1, 0, 0, 30)
hideBtn.Position = UDim2.new(0, 0, 0, 170)
hideBtn.Text = "Ẩn Menu (RightShift mở lại)"
hideBtn.BackgroundColor3 = Color3.fromRGB(0,0,120)
hideBtn.TextColor3 = Color3.new(1,1,1)
hideBtn.Parent = mainFrame

-- Config
local auraEnabled = false
local auraRange = 15
local maxTargets = 1

-- Buttons
auraBtn.MouseButton1Click:Connect(function()
    auraEnabled = not auraEnabled
    if auraEnabled then
        auraBtn.Text = "Kill Aura: ON"
        auraBtn.BackgroundColor3 = Color3.fromRGB(0,120,0)
    else
        auraBtn.Text = "Kill Aura: OFF"
        auraBtn.BackgroundColor3 = Color3.fromRGB(120,0,0)
    end
end)

rangeBox.FocusLost:Connect(function()
    local val = tonumber(rangeBox.Text)
    if val and val > 0 then
        auraRange = val
    else
        auraRange = 15
    end
end)

maxBox.FocusLost:Connect(function()
    local val = tonumber(maxBox.Text)
    if val and val > 0 then
        maxTargets = val
    else
        maxTargets = 1
    end
end)

hideBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

UIS.InputBegan:Connect(function(input,gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.RightShift then
        mainFrame.Visible = not mainFrame.Visible
    end
end)

-- Kill Aura
RunService.Heartbeat:Connect(function()
    if auraEnabled and character and character:FindFirstChild("HumanoidRootPart") then
        local root = character.HumanoidRootPart
        local count = 0
        for _, mob in pairs(workspace:GetDescendants()) do
            if mob:IsA("Model") and mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") then
                if mob ~= character then
                    local dist = (mob.HumanoidRootPart.Position - root.Position).Magnitude
                    if dist <= auraRange and mob.Humanoid.Health > 0 then
                        pcall(function()
                            mob.Humanoid:TakeDamage(10)
                        end)
                        count = count + 1
                        if count >= maxTargets then break end
                    end
                end
            end
        end
    end
end)
