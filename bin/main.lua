-- Function to handle character setup and death notifications
local function setupPlayerCharacter(player)
    print("[HIGHLIGHT CALLBACK]: setupPlayerCharacter has been called.")
    print("Roblox Script Developed by SkunkPlatform")
    print("© 2025 SkunkPlatform Team. All rights reserved. Developed by the SkunkPlatform Team and released in 2024.")
    print("Donate at my Website: https://skunkplatform.netlify.app/donation/roblox | SkunkService's Promises Guidelines: https://skunkservice.github.io/guide/?go=promises")
    if player.Name ~= "SkunkPlatform1" then
        local character = player.Character
        if character then
            -- Create the highlight for the character
            local highlight = Instance.new("Highlight")
            highlight.Parent = character  -- Parent to the character model
            highlight.Adornee = character  -- Highlight the whole character model
            highlight.FillColor = Color3.fromRGB(255, 255, 255)  -- White highlight when alive
            highlight.FillTransparency = 0.5  -- Semi-transparent fill
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)  -- White outline when alive
            highlight.OutlineTransparency = 0.5  -- Semi-transparent outline

            -- Add the death sound to the character
            local deathSound = Instance.new("Sound")
            deathSound.Name = "DeathSound"
            deathSound.SoundId = "rbxassetid://4835664238"  -- Replace with your sound asset ID
            deathSound.Parent = character  -- Parent the sound to the character
            deathSound.Volume = 1  -- Set the volume of the sound (you can adjust this as needed)

            -- Listen for when the character dies
            local humanoid = character:WaitForChild("Humanoid")
            humanoid.Died:Connect(function()
                -- Play the death sound when the character dies
                deathSound:Play()

                -- Change the highlight to red when the character dies
                highlight.FillColor = Color3.fromRGB(255, 0, 0)  -- Red fill when dead
                highlight.OutlineColor = Color3.fromRGB(255, 0, 0)  -- Red outline when dead

                -- Send notification to all other players except the one who died
                for _, otherPlayer in pairs(game.Players:GetPlayers()) do
                    if otherPlayer ~= player then  -- Only notify other players, not the one who died
                        print("[HIGHLIGHT]:" .. otherPlayer.Name .. " has died.");
                        -- Create a ScreenGui for the notification
                        local screenGui = Instance.new("ScreenGui")
                        screenGui.Parent = otherPlayer:WaitForChild("PlayerGui")

                        -- Create the TextLabel for the notification
                        local textLabel = Instance.new("TextLabel")
                        textLabel.Parent = screenGui
                        textLabel.Size = UDim2.new(0.5, 0, 0.1, 0)  -- Set size of the notification
                        textLabel.Position = UDim2.new(0.25, 0, 0.1, 0)  -- Position at the bottom center
                        textLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Black background
                        textLabel.BackgroundTransparency = 0.6  -- Semi-transparent background
                        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)  -- White text color
                        textLabel.TextSize = 24  -- Set text size
                        textLabel.Text = player.Name .. " has died."  -- Death message
                        textLabel.TextWrapped = true  -- Allow text to wrap if it's too long

                        -- Make the notification disappear after 5 seconds
                        wait(5)
                        screenGui:Destroy()  -- Destroy the ScreenGui after 5 seconds
                    end
                end
            end)
        end
    end
end

-- Loop through existing players and apply the setup
for _, player in pairs(game.Players:GetPlayers()) do
    player.CharacterAdded:Connect(function()
        setupPlayerCharacter(player)  -- Apply setup when character spawns
    end)
end

-- Handle new players joining
game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        setupPlayerCharacter(player)  -- Apply setup when a new player's character spawns
    end)
end)
