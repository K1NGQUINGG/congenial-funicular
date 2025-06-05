-- Fetch and load the Informant.wtf UI library from GitHub
local success, Informant = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/weakhoes/Roblox-UI-Libs/refs/heads/main/2%20Informant.wtf%20Lib%20(FIXED)/informant.wtf%20Lib%20Source.lua"))()
end)

-- Check if library loaded successfully
if not success or not Informant then
    warn("Failed to load Informant.wtf library: " .. tostring(Informant))
    return
end

-- Create a new tab named "AIMBOT"
local AimbotTab = Informant:CreateTab("AIMBOT")

-- Services
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Variables
local aimbotEnabled = false

-- Function to execute the shoot event
local function executeShoot()
    local args = {
        [1] = "Start",
        [2] = true
    }
    local success, err = pcall(function()
        ReplicatedStorage.Events.PlayerEvents.Shoot:FireServer(unpack(args))
    end)
    if not success then
        warn("Failed to fire Shoot event: " .. tostring(err))
    end
end

-- Add toggle button for Aimbot (Autogreen)
AimbotTab:AddToggle({
    Name = "Aimbot (Autogreen)",
    Default = false,
    Callback = function(state)
        aimbotEnabled = state
        if state then
            print("Aimbot enabled")
        else
            print("Aimbot disabled")
        end
    end
})

-- Input detection for Q key and left mouse click
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if aimbotEnabled and not gameProcessedEvent then
        if input.KeyCode == Enum.KeyCode.Q or input.UserInputType == Enum.UserInputType.MouseButton1 then
            executeShoot()
        end
    end
end)
