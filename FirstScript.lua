-- Load the Informant.wtf UI library (assuming it's already loaded or included)
local Informant = _G.Informant or loadstring(game:HttpGet("https://raw.githubusercontent.com/weakhoes/Roblox-UI-Libs/refs/heads/main/2%20Informant.wtf%20Lib%20(FIXED)/informant.wtf%20Lib%20Source.lua"))()

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
    ReplicatedStorage.Events.PlayerEvents.Shoot:FireServer(unpack(args))
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