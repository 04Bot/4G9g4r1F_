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

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.BackgroundTransparency = 1
scrollFrame.Position = UDim2.new(0.067, 0, 0.121, 0)
scrollFrame.Size = UDim2.new(0, 296, 0, 182)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.Parent = mainBackground

local scrollFrameList = Instance.new("UIListLayout")
scrollFrameList.Padding = UDim.new(0, 4) 
scrollFrameList.Parent = scrollFrame

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
	background.Parent = scrollFrame

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
	textLabel.TextSize = 15
	textLabel.Size = UDim2.new(0, 113, 0, 34)
	textLabel.TextColor3 = Color3.new(1, 1, 1)
	textLabel.Font = Enum.Font.SourceSans
	textLabel.Parent = background

	return button
end

local autoFarm = createGui("Auto Farm")
local antiAutoFarm = createGui("Anti Auto Farm")
local getRandomCoin = createGui("Random Coin")
local farthestCoinFromPlayers = createGui("Farthest Coin From Players")
local beADebris = createGui("Be A Debris")


local active_AutoFarm = false
local active_AntiAutoFarm = false
local active_RandomCoin = false
local active_BeADebris = false
local active_FarthestCoinFromPlayers = false


local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")
local TweenService = game:GetService("TweenService")
local rootTween
local bodyPosition
local coinText
local beDebris

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
				if coin:IsA("MeshPart") then
					-- Vérifie si le parent du coin contient un objet "TouchInterest"
					if not coin.Parent:FindFirstChild("TouchInterest") then
						-- Si pas de "TouchInterest", passer au prochain coin
						continue
					end

					local distance = (coin.Position - rootPart.Position).Magnitude
					if distance < closestDistance then
						closestDistance = distance
						closestCoin = coin
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
	local char2 = game.Workspace:FindFirstChild(player2)

	if char1 and char2 then
		local pos1 = char1:WaitForChild("HumanoidRootPart").Position
		local pos2 = char2:WaitForChild("HumanoidRootPart").Position
		return (pos1 - pos2).Magnitude
	end
	return math.huge -- Si les personnages n'existent pas, renvoie une valeur très grande
end

local isFarming = false

local function moveToCoin()
	if not active_AutoFarm or isFarming then return end

	isFarming = true  -- Définir le drapeau pour empêcher la réexécution
	local coin, distance

	if active_RandomCoin then
		coin, distance = randomCoin()
	elseif active_FarthestCoinFromPlayers then
		-- Vérifier si un autre joueur est proche de nous (distance <= 100)
		local closestPlayerDistance = math.huge
		local closestPlayer = nil
		local p = {"Blox_3955", "Vellrox_YT", "Jr_myR4"}

		for _, otherPlayer in pairs(p) do
			if otherPlayer ~= player then  -- Ignorer le joueur lui-même
				local distance = getDistanceBetweenPlayers(player, otherPlayer)
				if distance <= 10 and distance < closestPlayerDistance then
					closestPlayerDistance = distance
					closestPlayer = otherPlayer
				end
			end
		end
		
		if closestPlayer then
			print(closestPlayer)
			coin, distance = findFarthestCoinFromPlayer(closestPlayer)
		else
			coin, distance = findNearestCoin()
		end
	else
		coin, distance = findNearestCoin()
	end

	if coin then

		local coinRemovedConnection
		coinRemovedConnection = coin.AncestryChanged:Connect(function()
			if not coin:IsDescendantOf(workspace) then
				coinRemovedConnection:Disconnect()
				wait(0.1)
				isFarming = false  -- Réinitialiser le drapeau
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
			local rootTweenGoal = CFrame.new(coin.Position.X, coin.Position.Y + 0.5, coin.Position.Z)

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
		print("Aucune pièce trouvée.")
		isFarming = false
		moveToCoin()
	end
end

local function reset()
	local coinText
	if player.PlayerGui.MainGUI.Game:FindFirstChild("CoinBags") then
		coinText = player.PlayerGui.MainGUI.Game.CoinBags.Container.Candy.Full
	elseif player.PlayerGui.MainGUI:FindFirstChild("Lobby") then
		coinText = player.PlayerGui.MainGUI.Lobby.Dock.CoinBags.Container.Candy.Full
	end

	coinText:GetPropertyChangedSignal("Visible"):Connect(function()
		if coinText.Visible == true and active_AutoFarm == true then
			player.Character.Humanoid.Health = 0
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

-- Fonction de vérification avec délai de 5 secondes
local function checkText(initialText)
	wait(5)

	-- Vérifie si le texte n'a pas changé et n'est ni "0" ni "40"
	if coinText.Text == initialText and coinText.Text ~= "0" and coinText.Text ~= "40" then
		print("Le texte n'a pas changé après " .. tostring(5) .. " secondes, déplacement vers une autre pièce.")
		if active_RandomCoin then
			moveToCoin()
		else
			active_RandomCoin = true
			moveToCoin()
			active_RandomCoin = false
		end
	end
end

local function antiAuto()
	if player.PlayerGui.MainGUI.Game:FindFirstChild("CoinBags") then
		coinText = player.PlayerGui.MainGUI.Game.CoinBags.Container.Candy.CurrencyFrame.Icon.Coins
	elseif player.PlayerGui.MainGUI:FindFirstChild("Lobby") then
		coinText = player.PlayerGui.MainGUI.Lobby.Dock.CoinBags.Container.Candy.CurrencyFrame.Icon.Coins
	end

	coinText:GetPropertyChangedSignal("Text"):Connect(function()
		-- Si le texte change et n'est ni "0" ni "40", relance la vérification
		if coinText.Text ~= "0" and coinText.Text ~= "40" then
			coroutine.wrap(function() checkText(coinText.Text) end)()
		end
	end)
end

antiAutoFarm.MouseButton1Click:Connect(function()
	local outerFrame = antiAutoFarm
	local innerFrame = outerFrame:FindFirstChild("Frame")

	if active_AntiAutoFarm then
		active_AntiAutoFarm = false
		-- Si déjà actif, désactiver et arrêter la chasse aux pièces
		outerFrame.BackgroundTransparency = 1
		innerFrame.BackgroundColor3 = Color3.new(0.52549, 0.52549, 0.52549)
		moveFrame(innerFrame, UDim2.new(0.05, 0, 0.089, 0))  -- Position initiale
	else
		active_AntiAutoFarm = true
		-- Si désactivé, l'activer et commencer la chasse aux pièces
		outerFrame.BackgroundTransparency = 0
		innerFrame.BackgroundColor3 = Color3.new(0, 0, 0)
		moveFrame(innerFrame, UDim2.new(0.5, 0, 0.089, 0))  -- Nouvelle position
		antiAuto()
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

farthestCoinFromPlayers.MouseButton1Click:Connect(function()
	local outerFrame = farthestCoinFromPlayers
	local innerFrame = outerFrame:FindFirstChild("Frame")

	if active_FarthestCoinFromPlayers then
		active_FarthestCoinFromPlayers = false
		-- Si déjà actif, désactiver et arrêter la chasse aux pièces
		outerFrame.BackgroundTransparency = 1
		innerFrame.BackgroundColor3 = Color3.new(0.52549, 0.52549, 0.52549)
		moveFrame(innerFrame, UDim2.new(0.05, 0, 0.089, 0))  -- Position initiale
	else
		active_FarthestCoinFromPlayers = true
		-- Si désactivé, l'activer et commencer la chasse aux pièces
		outerFrame.BackgroundTransparency = 0
		innerFrame.BackgroundColor3 = Color3.new(0, 0, 0)
		moveFrame(innerFrame, UDim2.new(0.5, 0, 0.089, 0))  -- Nouvelle position
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
	if active_AntiAutoFarm then
		antiAuto()
	end
	if active_BeADebris then
		debris()
	end
end

-- Initialisation
player.CharacterAdded:Connect(onCharacterAdded)
