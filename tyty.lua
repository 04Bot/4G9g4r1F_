local screen = Instance.new("ScreenGui")
screen.ResetOnSpawn = false
screen.AutoLocalize = false
screen.Parent = game.CoreGui
screen.Enabled = false

local close_openGUI = Instance.new("TextButton")
close_openGUI.BackgroundTransparency = 0.5
close_openGUI.BackgroundColor3 = Color3.new(0, 0, 0)
close_openGUI.TextColor3 = Color3.new(1, 1, 1)
close_openGUI.RichText = true
close_openGUI.Text = "<b>Close GUI</b>"
close_openGUI.Position = UDim2.new(0.093, 0, 0.402, 0)
close_openGUI.Size = UDim2.new(0, 60, 0, 60)
close_openGUI.Parent = screen

local close_openGUICorner = Instance.new("UICorner")
close_openGUICorner.CornerRadius = UDim.new(0, 16)
close_openGUICorner.Parent = close_openGUI

local mainBackground = Instance.new("Frame")
mainBackground.BackgroundTransparency = 0.5
mainBackground.BackgroundColor3 = Color3.new(0, 0, 0)
mainBackground.Position = UDim2.new(0.475, 0, 0.157, 0)
mainBackground.Size = UDim2.new(0, 342, 0, 207)
mainBackground.Parent = screen

local mainBackgroundCorner = Instance.new("UICorner")
mainBackgroundCorner.CornerRadius = UDim.new(0, 16)
mainBackgroundCorner.Parent = mainBackground

local scrollingFrame = Instance.new("ScrollingFrame")
scrollingFrame.Size = UDim2.new(1, 0, 1, -10)
scrollingFrame.Position = UDim2.new(0, 0, 0, 5)
scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0) -- Dynamically adjusted
scrollingFrame.ScrollBarThickness = 8
scrollingFrame.BackgroundTransparency = 1
scrollingFrame.Parent = mainBackground

--// Add a UIListLayout for automatic button arrangement
local uiListLayout = Instance.new("UIListLayout")
uiListLayout.Padding = UDim.new(0, 5) -- Spacing between buttons
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout.Parent = scrollingFrame

local titleBackground = Instance.new("Frame")
titleBackground.Position = UDim2.new(0.475, 0, 0.156, 0)
titleBackground.Size = UDim2.new(0, 342, 0, 19)
titleBackground.BackgroundColor3 = Color3.new(0, 0, 0)
titleBackground.Parent = screen

local titleBackgroundCorner = Instance.new("UICorner")
titleBackgroundCorner.CornerRadius = UDim.new(0, 16)
titleBackgroundCorner.Parent = titleBackground

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(0, 342, 0, 19)
titleText.RichText = true
titleText.Text = "<b>Teamers Hub</b>"
titleText.TextSize = 20
titleText.TextColor3 = Color3.new(1, 1, 1)
titleText.BackgroundTransparency = 1
titleText.Font = Enum.Font.SourceSans
titleText.Parent = titleBackground

local function createGui(text)
	local background = Instance.new("Frame")
	background.BackgroundTransparency = 0.7
	background.BackgroundColor3 = Color3.new(0, 0, 0)
	background.Size = UDim2.new(0, 296, 0, 34)
	background.Parent = scrollingFrame

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = background

	local button = Instance.new("TextButton")
	button.BackgroundTransparency = 1
	button.Text = ""
	button.BackgroundColor3 = Color3.new(0, 0.576471, 0.866667)
	button.Position = UDim2.new(0.833, 0, 0.221, 0)
	button.Size = UDim2.new(0, 34, 0, 19)
	button.Parent = background

	local cornerButton = Instance.new("UICorner")
	cornerButton.CornerRadius = UDim.new(0, 19)
	cornerButton.Parent = button

	local strokeButton = Instance.new("UIStroke")
	strokeButton.Color = Color3.new(0.52549, 0.52549, 0.52549)
	strokeButton.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	strokeButton.Thickness = 1.5
	strokeButton.Parent = button

	local frame = Instance.new("Frame")
	frame.BackgroundColor3 = Color3.new(0.52549, 0.52549, 0.52549)
	frame.Position = UDim2.new(0.05, 0, 0.097, 0)
	frame.Size = UDim2.new(0, 15, 0, 15)
	frame.Parent = button

	local cornerButtonFrame = Instance.new("UICorner")
	cornerButtonFrame.CornerRadius = UDim.new(0, 50)
	cornerButtonFrame.Parent = frame  -- Fix this line

	local textLabel = Instance.new("TextLabel")
	textLabel.RichText = true
	textLabel.Text = "<b>" .. tostring(text) .. "</b>"
	textLabel.BackgroundTransparency = 1
	textLabel.TextSize = 14
	textLabel.Size = UDim2.new(0, 113, 0, 34)
	textLabel.TextColor3 = Color3.new(1, 1, 1)
	textLabel.Font = Enum.Font.SourceSans
	textLabel.Parent = background

	return button
end

local autoFarmEclipse = createGui("Auto Farm Eclipse")


local active_AutoFarmEclipse = false

local screenLog = Instance.new("ScreenGui")
screenLog.ResetOnSpawn = false
screenLog.AutoLocalize = false
screenLog.Parent = game.CoreGui

-- Frame principale pour le changelog
local logBackground = Instance.new("Frame")
logBackground.BackgroundTransparency = 0.5
logBackground.BackgroundColor3 = Color3.new(0, 0, 0)
logBackground.Position = UDim2.new(0.475, 0, 0.157, 0)
logBackground.Size = UDim2.new(0, 342, 0, 207)
logBackground.Parent = screenLog

local logBackgroundCorner = Instance.new("UICorner")
logBackgroundCorner.CornerRadius = UDim.new(0, 16)
logBackgroundCorner.Parent = logBackground

local logTitleBackground = Instance.new("Frame")
logTitleBackground.Position = UDim2.new(0.475, 0, 0.156, 0)
logTitleBackground.Size = UDim2.new(0, 342, 0, 19)
logTitleBackground.BackgroundColor3 = Color3.new(0, 0, 0)
logTitleBackground.Parent = screenLog

local logTitleBackgroundCorner = Instance.new("UICorner")
logTitleBackgroundCorner.CornerRadius = UDim.new(0, 16)
logTitleBackgroundCorner.Parent = logTitleBackground

local logTitleText = Instance.new("TextLabel")
logTitleText.Size = UDim2.new(0, 342, 0, 19)
logTitleText.RichText = true
logTitleText.Text = "<b>Change Log</b>"
logTitleText.TextSize = 20
logTitleText.TextColor3 = Color3.new(1, 1, 1)
logTitleText.BackgroundTransparency = 1
logTitleText.Font = Enum.Font.SourceSans
logTitleText.Parent = logTitleBackground

-- Texte pour afficher les logs
local logText = Instance.new("TextLabel")
logText.Size = UDim2.new(1, 0, 0, 150) -- Taille ajustée pour le texte
logText.Position = UDim2.new(0, 0, 0, 25)
logText.RichText = true
logText.Text = [[
<b>[ADDED] Now farming RARE EGGS</b>
<b></b>
<b>V 0.1.2</b>
]]  -- Ajoute ici tes logs de changement
logText.TextSize = 16
logText.TextColor3 = Color3.new(1, 1, 1)
logText.BackgroundTransparency = 1
logText.TextWrapped = true  -- Pour que le texte se défile si trop long
logText.TextYAlignment = Enum.TextYAlignment.Top
logText.Font = Enum.Font.SourceSans
logText.Parent = logBackground

-- Bouton OK pour fermer le changelog
local okButton = Instance.new("TextButton")
okButton.BackgroundTransparency = 0.5
okButton.BackgroundColor3 = Color3.new(0, 1, 0)
okButton.TextColor3 = Color3.new(1, 1, 1)
okButton.RichText = true
okButton.Font = Enum.Font.SourceSans
okButton.TextSize = 20
okButton.Text = "<b>OK</b>"
okButton.Size = UDim2.new(0, 80, 0, 40)
okButton.Position = UDim2.new(0.5, -40, 1, -50)  -- Positionner en bas au centre
okButton.Parent = logBackground

local okButtonCorner = Instance.new("UICorner")
okButtonCorner.CornerRadius = UDim.new(0, 16)
okButtonCorner.Parent = okButton

-- Fonction pour fermer le GUI quand le bouton OK est cliqué
okButton.MouseButton1Click:Connect(function()
	screenLog:Destroy()  -- Cacher l'UI
	screen.Enabled = true
end)


local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")
local TweenService = game:GetService("TweenService")
local rootTween
local bodyPosition
local farm = false
local fallprevention = false
local murder

local function updateCanvasSize()
	local totalHeight = uiListLayout.AbsoluteContentSize.Y
	scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
end

uiListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvasSize)

-- Fonction pour créer et jouer un tween pour déplacer le Frame interne
local function moveFrame(innerFrame, targetPosition)
	local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)  -- Durée de 0.1 seconde avec un easing smooth
	local tween = TweenService:Create(innerFrame, tweenInfo, {Position = targetPosition})  -- Crée le tween pour changer la position
	tween:Play()  -- Joue l'animation
end

local speed = 25  -- Vitesse en unités par seconde

-- Fonction pour trouver la pièce la plus proche dans chaque "CoinContainer"
local function findFarthestCoinFromPlayer(targetPlayer)
	local farthestCoin = nil
	local farthestDistance = 0

	-- Chercher dans tous les containers de pièces
	for _, obj in ipairs(game.Workspace:GetDescendants()) do
		if obj.Name == "CoinContainer" then
			for _, coin in ipairs(obj:GetDescendants()) do
				if coin:IsA("BasePart") then
                    if coin.Transparency == 0 then
                        local distance = (coin.Position - game.Workspace:FindFirstChild(targetPlayer):FindFirstChild("HumanoidRootPart").Position).Magnitude
                        if distance > farthestDistance then
                            farthestDistance = distance
                            farthestCoin = coin
                        end
                    end
				end
			end
		end
	end

	return farthestCoin, farthestDistance
end

-- Fonction pour trouver la pièce la plus proche dans chaque "CoinContainer"
local function findNearestCoin()
	local closestCoin = nil
	local closestDistance = math.huge

	for _, obj in ipairs(game.Workspace:GetDescendants()) do
		if obj.Name == "CoinContainer" then
			for _, coin in ipairs(obj:GetDescendants()) do
				if coin:IsA("BasePart") then
					if coin.Transparency == 0 then
						-- Calcule la distance jusqu'à la pièce
						local distance = (coin.Position - rootPart.Position).Magnitude
						if distance < closestDistance then
							closestDistance = distance
							closestCoin = coin
						end
					end
				end
			end
		end
	end

	return closestCoin, closestDistance
end

-- À la fin du farming, nettoyez fallprevention
local function cleanupFallPrevention()
	fallprevention = false
	humanoid.PlatformStand = false
end

local function moveToCoinEclipse()
	if not active_AutoFarmEclipse or not character:FindFirstChild("HumanoidRootPart") then return end

	if farm then
        local coin, distance = findNearestCoin()

		if coin then
			local coinConnection
			local tweenConnection

			local function cleanConnections()
				if coinConnection then
					coinConnection:Disconnect()
					coinConnection = nil
				end
				if tweenConnection then
					tweenConnection:Disconnect()
					tweenConnection = nil
				end
			end

			coinConnection = coin:GetPropertyChangedSignal("Transparency"):Connect(function()
				if coin.Transparency ~= 0 or not coin:IsDescendantOf(workspace) then
					cleanConnections()
					wait(0.1)
					moveToCoinEclipse()
				end
			end)

			if not fallprevention then
				fallprevention = true
				humanoid.PlatformStand = true
			end

            local duration = distance / speed
			
			if distance <= 2 then
                coin:Destroy()
				cleanConnections()
				wait(0.1)
				cleanupFallPrevention()
				moveToCoinEclipse()
			elseif distance > 300 then
                workspace.Gravity = 0
				if rootTween then
					rootTween:Cancel()
				end

				local targetPosition = CFrame.new(coin.Position.X, coin.Position.Y - 10, coin.Position.Z)
				local targetRotation = CFrame.Angles(math.rad(90), 0, 0)
				local finalCFrame = targetPosition * targetRotation

				character.Humanoid.UseJumpPower = false
				character.Humanoid.PlatformStand = true
				rootPart.CFrame = finalCFrame

				cleanConnections()
                wait(math.random(3,6))
				cleanupFallPrevention()
				moveToCoinEclipse()
			else
				workspace.Gravity = 0
				local rootTweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
				local rootTweenGoal = CFrame.new(coin.Position.X, coin.Position.Y - 1.5, coin.Position.Z) * CFrame.Angles(math.rad(90), 0, 0)

				rootTween = TweenService:Create(rootPart, rootTweenInfo, {CFrame = rootTweenGoal})
				rootTween:Play()

				tweenConnection = rootTween.Completed:Connect(function()
					cleanConnections()
					wait(0.1)
					cleanupFallPrevention()
					moveToCoinEclipse()
				end)
			end
		else
			wait(1)
			workspace.Gravity = 196.2
            cleanupFallPrevention()
			moveToCoinEclipse()
		end
	else
		wait(1)
		workspace.Gravity = 196.2
        cleanupFallPrevention()
		moveToCoinEclipse()
	end
end

local rareEggsSpawn

local function reset()
	local player = game.Players.LocalPlayer
	local coinText
	
	local gui = player:FindFirstChild("PlayerGui")
	if gui and gui:FindFirstChild("MainGUI") then
		local mainGUI = gui.MainGUI
		if mainGUI:FindFirstChild("Game") and mainGUI.Game:FindFirstChild("CoinBags") then
			coinText = mainGUI.Game.CoinBags.Container.Coin.Full
		elseif mainGUI:FindFirstChild("Lobby") then
			coinText = mainGUI.Lobby.Dock.CoinBags.Container.Coin.Full
		end
	end

	if not coinText then return end

	coinText:GetPropertyChangedSignal("Visible"):Connect(function()
		farm = false
		if murder == "juju59lulu1" or murder == "Vellrox_YT" or murder == "coeursn" then
			rootPart.CFrame = game.Workspace:FindFirstChild(murder).HumanoidRootPart.CFrame
		else
			for _, spawnPoint in pairs(game.Workspace:GetDescendants()) do
				if spawnPoint:IsA("BasePart") and (spawnPoint.Name == "Spawn" or spawnPoint.Name == "PlayerSpawn") then
					local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
					if hrp then
						hrp.CFrame = spawnPoint.CFrame
						break
					end
				end
			end

			for _, obj in ipairs(game.Workspace:GetDescendants()) do
				if obj.Name == "CoinContainer" then
					rareEggsSpawn = obj.ChildAdded:Connect(function(part)
						wait()
                        for _, p in part:GetDescendants() do
                            if p:IsA("BasePart") and p.Transparency == 0 then
                                local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                                if hrp then
                                    hrp.CFrame = part.CFrame
                                    wait(1)
                                    -- Teleport back to spawn
                                    for _, s in pairs(game.Workspace:GetDescendants()) do
                                        if s:IsA("BasePart") and (s.Name == "Spawn" or s.Name == "PlayerSpawn") then
                                            hrp.CFrame = s.CFrame
                                            break
                                        end
                                    end
                                end
                            end
                        end
					end)
				end
			end
		end
	end)
end

-- Fonction pour démarrer l'auto-farm
local function startAutoFarmEclipse()
	active_AutoFarmEclipse = true
	reset()
	moveToCoinEclipse()  -- Lancer la chasse à la première pièce
	while active_AutoFarmEclipse do
		wait()
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") or part:IsA("MeshPart") then
				part.CanCollide = false  -- Active/désactive la collision
			end
		end
	end
end

-- Fonction pour arrêter l'auto-farm
local function stopAutoFarmEclipse()
	active_AutoFarmEclipse = false
	workspace.Gravity = 196.2
	for _, i in pairs(game:GetService("Workspace"):GetDescendants()) do
	    if i:IsA("BasePart") and (i.Name == "Spawn" or i.Name == "PlayerSpawn") then
	        local player = game.Players.LocalPlayer
	        if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
	            player.Character.HumanoidRootPart.CFrame = i.CFrame * CFrame.new(0, 20, 0)
	            break -- Sortie après avoir téléporté le joueur à un spawn
	        end
	    end
	end
	character.Humanoid.UseJumpPower = true
	character.Humanoid.PlatformStand = false
	if rootTween then
		rootTween:Cancel()
	end
	for _, part in ipairs(character:GetDescendants()) do
		if part:IsA("BasePart") or part:IsA("MeshPart") then
			part.CanCollide = true -- Active/désactive la collision
		end
	end
	cleanupFallPrevention()
end

local role = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("RoleSelect")
role.OnClientEvent:Connect(function()
	farm = true	
    wait(1)
    for _, i in pairs(game:GetService("Workspace"):GetDescendants()) do
	    if i:IsA("BasePart") and (i.Name == "Spawn" or i.Name == "PlayerSpawn") then
	        local player = game.Players.LocalPlayer
	        if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
	            player.Character.HumanoidRootPart.CFrame = i.CFrame * CFrame.new(0, 20, 0)
	            break -- Sortie après avoir téléporté le joueur à un spawn
	        end
	    end
	end
end)

local espEvent = game.ReplicatedStorage.Remotes.Gameplay.Fade
espEvent.OnClientEvent:Connect(function(message)
	-- Sinon, stocker les données des rôles dans la table
	for playerName, data in pairs(message) do
		local player = game.Players:FindFirstChild(playerName)
		if player and type(data) == "table" and data.Role == "Murderer" then
			murder = tostring(player)
		end
	end
end)

autoFarmEclipse.MouseButton1Click:Connect(function()
	local outerFrame = autoFarmEclipse
	local innerFrame = outerFrame:FindFirstChild("Frame")

	if active_AutoFarmEclipse then
		-- Si déjà actif, désactiver et arrêter la chasse aux pièces
		outerFrame.BackgroundTransparency = 1
		innerFrame.BackgroundColor3 = Color3.new(0.52549, 0.52549, 0.52549)
		moveFrame(innerFrame, UDim2.new(0.05, 0, 0.089, 0))  -- Position initiale
		stopAutoFarmEclipse()
	else
		-- Si désactivé, l'activer et commencer la chasse aux pièces
		outerFrame.BackgroundTransparency = 0
		innerFrame.BackgroundColor3 = Color3.new(0, 0, 0)
		moveFrame(innerFrame, UDim2.new(0.5, 0, 0.089, 0))  -- Nouvelle position
		startAutoFarmEclipse()
	end
end)

close_openGUI.MouseButton1Click:Connect(function()
	if close_openGUI.Text == "<b>Close GUI</b>" then
		mainBackground.Visible = false
		titleBackground.Visible = false
		close_openGUI.Text = "<b>Open GUI</b>"
	else
		mainBackground.Visible = true
		titleBackground.Visible = true
		close_openGUI.Text = "<b>Close GUI</b>"
	end
end)

-- Gestion des personnages
local function onCharacterAdded(newCharacter)
	character = newCharacter
	rootPart = character:WaitForChild("HumanoidRootPart")
	humanoid = character:WaitForChild("Humanoid")

	wait(4)
    farm = false
    if rareEggsSpawn then
        rareEggsSpawn:Disconnect()
        rareEggsSpawn = nil
    end
	if active_AutoFarmEclipse then
		stopAutoFarmEclipse()
		wait(2)
		startAutoFarmEclipse()
	end
end

-- Initialisation
player.CharacterAdded:Connect(onCharacterAdded)
