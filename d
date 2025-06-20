local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local s = Instance.new("LocalScript")
s.Name = "functionBP"
s.Enabled = false
s.Source = [[
local p = game.Players.LocalPlayer
local c = p.Character or p.CharacterAdded:Wait()
local hrp = c:WaitForChild("HumanoidRootPart")
local closest, dist = nil, math.huge

for _, v in pairs(game.Players:GetPlayers()) do
    if v ~= p and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
        local d = (hrp.Position - v.Character.HumanoidRootPart.Position).Magnitude
        if d < dist then
            closest = v
            dist = d
        end
    end
end

if closest and closest.Character and closest.Character:FindFirstChild("HumanoidRootPart") then
    hrp.CFrame = closest.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
end
]]
s.Parent = character

local gui = Instance.new("ScreenGui")
gui.Name = "FunctionBPActivator"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 320, 0, 160)
frame.Position = UDim2.new(0.5, -160, 0.5, -80)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Name = "MainFrame"
frame.Parent = gui
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 0, 40)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "FunctionBP Activator"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.Text = "X"
closeBtn.Parent = frame
closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

local button = Instance.new("TextButton")
button.Size = UDim2.new(0.85, 0, 0, 45)
button.Position = UDim2.new(0.5, 0, 0.6, 0)
button.AnchorPoint = Vector2.new(0.5, 0.5)
button.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.GothamBold
button.TextSize = 20
button.Text = "FunctionBP is DISABLED ❌"
button.Parent = frame
button.BorderSizePixel = 0

button.MouseButton1Click:Connect(function()
	local bp = character:FindFirstChild("functionBP")
	if bp and bp:IsA("LocalScript") then
		bp.Enabled = not bp.Enabled
		if bp.Enabled then
			button.BackgroundColor3 = Color3.fromRGB(40, 180, 90)
			button.Text = "FunctionBP is ENABLED ✅"
		else
			button.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
			button.Text = "FunctionBP is DISABLED ❌"
		end
	end
end)
