-- Loader.lua
local gui = Instance.new("ScreenGui", game.CoreGui)
local txt = Instance.new("TextLabel", gui)
txt.Size = UDim2.new(1,0,1,0)
txt.BackgroundTransparency = 1
txt.Text = "Loading..."
txt.TextColor3 = Color3.new(1,1,1)
txt.Font = Enum.Font.SourceSansBold
txt.TextSize = 40

task.wait(2)
txt.Text = "Almost Ready..."

task.wait(1)
gui:Destroy()

-- Gọi Main.lua từ GitHub
loadstring(game:HttpGet("https://raw.githubusercontent.com/trieuvancoi/Kill-hub/main/Main.lua"))()
