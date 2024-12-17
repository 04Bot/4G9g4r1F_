local screen = Instance.new("ScreenGui")
screen.ResetOnSpawn = false
screen.AutoLocalize = false
screen.Parent = game.CoreGui

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

local autoFarm = createGui("Auto Farm")
local autoReset = createGui("Auto Reset")
local autoHideAll = createGui("Auto Hide")
local autoHideMurderer = createGui("Auto Hide (Murderer)")
local autoHideSheriff = createGui("Auto Hide (Sheriff)")
local autoHide = createGui("Auto Hide")
local altFarm = createGui("Alt Farm")
local getRandomCoin = createGui("Random Coin")
local beADebris = createGui("Be A Debris")


local active_AutoFarm = false
local active_AutoReset = false
local active_AutoHideAll = false
local active_AutoHideMurderer = false
local active_AutoHideSheriff = false
local active_AltFarm = false
local active_RandomCoin = false
local active_BeADebris = false


local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")
local TweenService = game:GetService("TweenService")
local rootTween
local bodyPosition
local beDebris
local altFarming = false
local isFarming = false
local altClosest
local farm = true

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

local function randomCoin()
	local coins = {}

	-- Remplir le tableau avec les pièces trouvées dans les conteneurs CoinContainer du Workspace
	for _, container in ipairs(game.Workspace:GetDescendants()) do
		if container.Name == "CoinContainer" then
			for _, coin in ipairs(container:GetDescendants()) do
				if coin:IsA("MeshPart") then
					if not coin.Parent:FindFirstChild("TouchInterest") then
						-- Si pas de "TouchInterest", passer au prochain coin
						continue
					end

					table.insert(coins, coin)
				end
			end
		end
	end

	-- Retourne une pièce aléatoire si elle existe, sinon nil
	if #coins == 0 then
		return nil
	end

	local randomCoin = coins[math.random(1, #coins)]
	return randomCoin, (character.HumanoidRootPart.Position - randomCoin.Position).Magnitude
end

local function findFarthestCoinFromPlayer(targetPlayer)
	local farthestCoin = nil
	local farthestDistance = 0

	-- Chercher dans tous les containers de pièces
	for _, obj in ipairs(game.Workspace:GetDescendants()) do
		if obj.Name == "CoinContainer" then
			for _, coin in ipairs(obj:GetDescendants()) do
				if coin:IsA("MeshPart") then
					-- Vérifier si le coin a un "TouchInterest"
					if not coin.Parent:FindFirstChild("TouchInterest") then
						continue
					end
						
					local distance = (coin.Position - game.Workspace:FindFirstChild(targetPlayer):FindFirstChild("HumanoidRootPart").Position).Magnitude
					if distance > farthestDistance then
						farthestDistance = distance
						farthestCoin = coin
                    end
				end
			end
		end
	end

	return farthestCoin, farthestDistance
end

local function getDistanceBetweenPlayers(player1, player2)
	local char1 = player1.Character
	local char2 = player2.Character

	if char1 and char2 then
		local hrp1 = char1:FindFirstChild("HumanoidRootPart")
		local hrp2 = char2:FindFirstChild("HumanoidRootPart")

		if hrp1 and hrp2 then
			return (hrp1.Position - hrp2.Position).Magnitude
		end
	end
	
	-- Si un des personnages ou HumanoidRootParts est inexistant, renvoyer une valeur très grande
	return math.huge
end

local function moveToCoin()
	if not active_AutoFarm or isFarming then return end

	if farm then
		isFarming = true
		local coin, distance

		if active_RandomCoin then
			coin, distance = randomCoin()
		elseif active_AltFarm then
			-- Vérifier si un autre joueur est proche de nous (distance <= 100)
			local closestPlayerDistance = math.huge
			local closestPlayer = nil
			local p = {"Blox_3955", "Vellrox_YT", "Jr_myR4", "qMinette", "Blox_1568", "pppcww", "p4ppc", "iiirpp", "pppcll", "iiihpp"}

			for _, otherPlayer in pairs(p) do
				if otherPlayer ~= player.Name and game.Players:FindFirstChild(otherPlayer) then  -- Ignorer le joueur lui-même
					local distance = getDistanceBetweenPlayers(player, game.Players:FindFirstChild(otherPlayer))
					if distance <= 10 and distance < closestPlayerDistance then
						closestPlayerDistance = distance
						closestPlayer = otherPlayer
					end
				end
			end

			--if not altFarming then
				if closestPlayer then
					if rootTween then
						rootTween:Cancel()
					end
					altFarming = true
					coin, distance = randomCoin()
					altClosest = closestPlayer
				else
					coin, distance = findNearestCoin()
				end
			--[[elseif altFarming then
				if altClosest then
					if rootTween then
						rootTween:Cancel()
					end
					altFarming = false
					altClosest = nil
					coin, distance = findFarthestCoinFromPlayer(altClosest)
				else
					coin, distance = findNearestCoin()
				end
			end]]--
		else
			coin, distance = findNearestCoin()
		end

		if coin then

			local coinRemovedConnection
			coinRemovedConnection = coin.AncestryChanged:Connect(function()
				if not coin:IsDescendantOf(workspace) then
					coinRemovedConnection:Disconnect()
					wait(0.1)
					isFarming = false
					moveToCoin()  -- Relancer la recherche de pièce
				end
			end)

			if distance <= 1 then
				coinRemovedConnection:Disconnect()
				wait(0.1)
				isFarming = false
				moveToCoin()
			elseif distance > 300 then
				if rootTween then
					rootTween:Cancel()
				end
				rootPart.CFrame = CFrame.new(coin.Position.X, coin.Position.Y + 0.5, coin.Position.Z)
				coinRemovedConnection:Disconnect()
				isFarming = false
				moveToCoin()
			else
				if not bodyPosition then
					bodyPosition = Instance.new("BodyPosition")
					bodyPosition.P = 0
					bodyPosition.D = 0
					bodyPosition.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
					bodyPosition.Parent = character.HumanoidRootPart
				end

				local duration = distance / speed
				local rootTweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
				local rootTweenGoal = CFrame.new(coin.Position.X, coin.Position.Y, coin.Position.Z)

				rootTween = TweenService:Create(rootPart, rootTweenInfo, {CFrame = rootTweenGoal})
				rootTween:Play()

				rootTween.Completed:Connect(function()
					coinRemovedConnection:Disconnect()
					wait(0.1)
					isFarming = false
					moveToCoin()
				end)
			end
		else
			wait(1)
			if bodyPosition then
				bodyPosition:Destroy()
			end
			--print("Aucune pièce trouvée.")
			isFarming = false
			moveToCoin()
		end
	end
end

local function reset()
	local coinText
	if player.PlayerGui.MainGUI.Game:FindFirstChild("CoinBags") then
		coinText = player.PlayerGui.MainGUI.Game.CoinBags.Container.Coin.Full
	elseif player.PlayerGui.MainGUI:FindFirstChild("Lobby") then
		coinText = player.PlayerGui.MainGUI.Lobby.Dock.CoinBags.Container.Coin.Full
	end

	coinText:GetPropertyChangedSignal("Visible"):Connect(function()
		farm = false
		if coinText.Visible == true and active_AutoFarm == true and active_AutoReset == true then
			player.Character.Humanoid.Health = 0
		end
	end)

	local role = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("RoleSelect")

	role.OnClientEvent:Connect(function(message)
		farm = true
		if active_AutoHideAll == true then
	            -- Ne pas reset si le rôle est Murderer ou Sheriff et qu'ils ne sont pas activés pour le reset
	            if (message == "Sheriff" and not active_AutoHideSheriff) or (message == "Murderer" and not active_AutoHideMurderer) then
	                return -- On quitte la fonction sans réinitialiser
	            end
	            -- Sinon, on réinitialise
	            player.Character.Humanoid.Health = 0
	        else
	            -- Vérifie uniquement les conditions spécifiques pour Sheriff ou Murderer
	            if active_AutoHideSheriff == true and message == "Sheriff" then
	                player.Character.Humanoid.Health = 0
	            elseif active_AutoHideMurderer == true and message == "Murderer" then
	                player.Character.Humanoid.Health = 0
	            end
	        end
	end)
end

-- Fonction pour démarrer l'auto-farm
local function startAutoFarm()
	active_AutoFarm = true
	reset()
	moveToCoin()  -- Lancer la chasse à la première pièce
	while active_AutoFarm do
		wait()
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") or part:IsA("MeshPart") then
				part.CanCollide = false  -- Active/désactive la collision
			end
		end
	end
end

-- Fonction pour arrêter l'auto-farm
local function stopAutoFarm()
	active_AutoFarm = false
	rootTween:Cancel()
	if bodyPosition then
		bodyPosition:Destroy()
	end
	for _, part in ipairs(character:GetDescendants()) do
		if part:IsA("BasePart") or part:IsA("MeshPart") then
			part.CanCollide = true -- Active/désactive la collision
		end
	end
end

local function debris()
	beDebris = Instance.new("BodyPosition")
	beDebris.P = 0
	beDebris.D = 0
	beDebris.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	beDebris.Parent = character.HumanoidRootPart

	humanoid.PlatformStand = true
end

autoFarm.MouseButton1Click:Connect(function()
	local outerFrame = autoFarm
	local innerFrame = outerFrame:FindFirstChild("Frame")

	if active_AutoFarm then
		-- Si déjà actif, désactiver et arrêter la chasse aux pièces
		outerFrame.BackgroundTransparency = 1
		innerFrame.BackgroundColor3 = Color3.new(0.52549, 0.52549, 0.52549)
		moveFrame(innerFrame, UDim2.new(0.05, 0, 0.089, 0))  -- Position initiale
		stopAutoFarm()
	else
		-- Si désactivé, l'activer et commencer la chasse aux pièces
		outerFrame.BackgroundTransparency = 0
		innerFrame.BackgroundColor3 = Color3.new(0, 0, 0)
		moveFrame(innerFrame, UDim2.new(0.5, 0, 0.089, 0))  -- Nouvelle position
		startAutoFarm()
	end
end)

autoReset.MouseButton1Click:Connect(function()
	local outerFrame = autoReset
	local innerFrame = outerFrame:FindFirstChild("Frame")

	if active_AutoReset then
		active_AutoReset = false
		-- Si déjà actif, désactiver et arrêter la chasse aux pièces
		outerFrame.BackgroundTransparency = 1
		innerFrame.BackgroundColor3 = Color3.new(0.52549, 0.52549, 0.52549)
		moveFrame(innerFrame, UDim2.new(0.05, 0, 0.089, 0))  -- Position initiale
	else
		active_AutoReset = true
		-- Si désactivé, l'activer et commencer la chasse aux pièces
		outerFrame.BackgroundTransparency = 0
		innerFrame.BackgroundColor3 = Color3.new(0, 0, 0)
		moveFrame(innerFrame, UDim2.new(0.5, 0, 0.089, 0))  -- Nouvelle position
	end
end)

autoHideAll.MouseButton1Click:Connect(function()
	local outerFrame = autoHideAll
	local innerFrame = outerFrame:FindFirstChild("Frame")

	if active_AutoHideAll then
		active_AutoHideAll = false
		-- Si déjà actif, désactiver et arrêter la chasse aux pièces
		outerFrame.BackgroundTransparency = 1
		innerFrame.BackgroundColor3 = Color3.new(0.52549, 0.52549, 0.52549)
		moveFrame(innerFrame, UDim2.new(0.05, 0, 0.089, 0))  -- Position initiale
	else
		active_AutoHideAll = true
		-- Si désactivé, l'activer et commencer la chasse aux pièces
		outerFrame.BackgroundTransparency = 0
		innerFrame.BackgroundColor3 = Color3.new(0, 0, 0)
		moveFrame(innerFrame, UDim2.new(0.5, 0, 0.089, 0))  -- Nouvelle position
	end
end)

autoHideMurderer.MouseButton1Click:Connect(function()
	local outerFrame = autoHideMurderer
	local innerFrame = outerFrame:FindFirstChild("Frame")

	if active_AutoHideMurderer then
		active_AutoHideMurderer = false
		-- Si déjà actif, désactiver et arrêter la chasse aux pièces
		outerFrame.BackgroundTransparency = 1
		innerFrame.BackgroundColor3 = Color3.new(0.52549, 0.52549, 0.52549)
		moveFrame(innerFrame, UDim2.new(0.05, 0, 0.089, 0))  -- Position initiale
	else
		active_AutoHideMurderer = true
		-- Si désactivé, l'activer et commencer la chasse aux pièces
		outerFrame.BackgroundTransparency = 0
		innerFrame.BackgroundColor3 = Color3.new(0, 0, 0)
		moveFrame(innerFrame, UDim2.new(0.5, 0, 0.089, 0))  -- Nouvelle position
	end
end)

autoHideSheriff.MouseButton1Click:Connect(function()
	local outerFrame = autoHideSheriff
	local innerFrame = outerFrame:FindFirstChild("Frame")

	if active_AutoHideSheriff then
		active_AutoHideSheriff = false
		-- Si déjà actif, désactiver et arrêter la chasse aux pièces
		outerFrame.BackgroundTransparency = 1
		innerFrame.BackgroundColor3 = Color3.new(0.52549, 0.52549, 0.52549)
		moveFrame(innerFrame, UDim2.new(0.05, 0, 0.089, 0))  -- Position initiale
	else
		active_AutoHideSheriff = true
		-- Si désactivé, l'activer et commencer la chasse aux pièces
		outerFrame.BackgroundTransparency = 0
		innerFrame.BackgroundColor3 = Color3.new(0, 0, 0)
		moveFrame(innerFrame, UDim2.new(0.5, 0, 0.089, 0))  -- Nouvelle position
	end
end)

altFarm.MouseButton1Click:Connect(function()
	local outerFrame = altFarm
	local innerFrame = outerFrame:FindFirstChild("Frame")

	if active_AltFarm then
		active_AltFarm = false
		-- Si déjà actif, désactiver et arrêter la chasse aux pièces
		outerFrame.BackgroundTransparency = 1
		innerFrame.BackgroundColor3 = Color3.new(0.52549, 0.52549, 0.52549)
		moveFrame(innerFrame, UDim2.new(0.05, 0, 0.089, 0))  -- Position initiale
	else
		active_AltFarm = true
		-- Si désactivé, l'activer et commencer la chasse aux pièces
		outerFrame.BackgroundTransparency = 0
		innerFrame.BackgroundColor3 = Color3.new(0, 0, 0)
		moveFrame(innerFrame, UDim2.new(0.5, 0, 0.089, 0))  -- Nouvelle position
	end
end)

getRandomCoin.MouseButton1Click:Connect(function()
	local outerFrame = getRandomCoin
	local innerFrame = outerFrame:FindFirstChild("Frame")

	if active_RandomCoin then
		active_RandomCoin = false
		-- Si déjà actif, désactiver et arrêter la chasse aux pièces
		outerFrame.BackgroundTransparency = 1
		innerFrame.BackgroundColor3 = Color3.new(0.52549, 0.52549, 0.52549)
		moveFrame(innerFrame, UDim2.new(0.05, 0, 0.089, 0))  -- Position initiale
	else
		active_RandomCoin = true
		-- Si désactivé, l'activer et commencer la chasse aux pièces
		outerFrame.BackgroundTransparency = 0
		innerFrame.BackgroundColor3 = Color3.new(0, 0, 0)
		moveFrame(innerFrame, UDim2.new(0.5, 0, 0.089, 0))  -- Nouvelle position
	end
end)

beADebris.MouseButton1Click:Connect(function()
	local outerFrame = beADebris
	local innerFrame = outerFrame:FindFirstChild("Frame")

	if active_BeADebris then
		active_BeADebris = false
		-- Si déjà actif, désactiver et arrêter la chasse aux pièces
		outerFrame.BackgroundTransparency = 1
		innerFrame.BackgroundColor3 = Color3.new(0.52549, 0.52549, 0.52549)
		moveFrame(innerFrame, UDim2.new(0.05, 0, 0.089, 0))  -- Position initiale

		if beDebris then
			beDebris:Destroy()
		end
		if humanoid.PlatformStand == true then
			humanoid.PlatformStand = false
		end
	else
		active_BeADebris = true
		-- Si désactivé, l'activer et commencer la chasse aux pièces
		outerFrame.BackgroundTransparency = 0
		innerFrame.BackgroundColor3 = Color3.new(0, 0, 0)
		moveFrame(innerFrame, UDim2.new(0.5, 0, 0.089, 0))  -- Nouvelle position
		debris()
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

	if active_AutoFarm then
		stopAutoFarm()
		wait(2)
		startAutoFarm()
		reset()
	end
	if active_BeADebris then
		debris()
	end
end

-- Initialisation
player.CharacterAdded:Connect(onCharacterAdded)
