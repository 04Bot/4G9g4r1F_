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

local autoFarm = createGui("Auto Farm")
local autoFarmEclipse = createGui("Auto Farm Eclipse")
local autoReset = createGui("Auto Reset")
local esp = createGui("ESP")
local autoHideAll = createGui("Auto Hide")
local autoHideMurderer = createGui("Auto Hide (Murderer)")
local autoHideSheriff = createGui("Auto Hide (Sheriff)")
local altFarm = createGui("Alt Farm")
local getRandomCoin = createGui("Random Coin")
local beADebris = createGui("Be A Debris")


local active_AutoFarm = false
local active_AutoFarmEclipse = false
local active_AutoReset = false
local active_Esp = false
local active_AutoHideAll = false
local active_AutoHideMurderer = false
local active_AutoHideSheriff = false
local active_AltFarm = false
local active_RandomCoin = false
local active_BeADebris = false


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
<b>[/] Fix Auto Farm Eclipse : TP dans certaine map</b>
<b>[/] Fix ESP : Hero ESP</b>
<b>[BUG] Auto Farm Eclipse ne marche pas sur mobile.</b>
<b></b>
<b>V 0.0.2</b>
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
local beDebris
local altFarming = false
local isFarming = false
local altClosest
local farm = true
local fallprevention = false
local fallprevention1

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
			if distance > 300 then
				if rootTween then
					rootTween:Cancel()
				end
				rootPart.CFrame = CFrame.new(coin.Position.X, coin.Position.Y + 1.5, coin.Position.Z)
				coinRemovedConnection:Disconnect()
				isFarming = false
				moveToCoin()
			else
				workspace.Gravity = 0

				local duration = distance / speed
				local rootTweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
				local rootTweenGoal = CFrame.new(coin.Position.X, coin.Position.Y + 0.5, coin.Position.Z)

				rootTween = TweenService:Create(rootPart, rootTweenInfo, {CFrame = rootTweenGoal})
				rootTween:Play()

				rootTween.Completed:Connect(function()
					coinRemovedConnection:Disconnect()
					workspace.Gravity = 196.2
					wait(0.1)
					isFarming = false
					moveToCoin()
				end)
			end
		else
			wait(1)
			isFarming = false
			moveToCoin()
		end
	else
		wait(1)
		moveToCoin()
	end
end

-- À la fin du farming, nettoyez fallprevention
local function cleanupFallPrevention()
	if fallprevention1 then
		fallprevention1:Destroy()
		fallprevention1 = nil
	end
	fallprevention = false
	humanoid.PlatformStand = false
end

local function moveToCoinEclipse()
	if not active_AutoFarmEclipse or isFarming or not character:FindFirstChild("HumanoidRootPart") then return end

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
					moveToCoinEclipse()  -- Relancer la recherche de pièce
				end
			end)

			if not fallprevention then
				fallprevention = true
				fallprevention1 = Instance.new("BodyPosition")
				fallprevention1.P = 0
				fallprevention1.D = 0
				fallprevention1.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
				fallprevention1.Parent = character.HumanoidRootPart

				humanoid.PlatformStand = true
			end
			
			if distance <= 4 then
				-- Téléporter la pièce sur le joueur
				coin.CFrame = character.HumanoidRootPart.CFrame

				-- Déconnecter le suivi et finir le farming
				coinRemovedConnection:Disconnect()
				wait(0.1)
				cleanupFallPrevention()  -- Nettoyer le système anti-chute
				isFarming = false
				moveToCoinEclipse()
			elseif distance > 300 then
				if rootTween then
					rootTween:Cancel()
				end

				-- Calculer la position juste sous la pièce
				local targetPosition = CFrame.new(coin.Position.X, coin.Position.Y + 2, coin.Position.Z)  -- Décalage de 2 studs sous la pièce
				local targetRotation = CFrame.Angles(math.rad(90), 0, 0)
				local finalCFrame = targetPosition * targetRotation

				character.Humanoid.UseJumpPower = false
				character.Humanoid.PlatformStand = true
				rootPart.CFrame = finalCFrame
				coinRemovedConnection:Disconnect()
				cleanupFallPrevention()  -- Nettoyer après avoir atteint la pièce
				isFarming = false
				moveToCoinEclipse()
			else
				-- Déplacer normalement vers la pièce
				workspace.Gravity = 0
				local duration = distance / speed
				local rootTweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
				local rootTweenGoal = CFrame.new(coin.Position.X, coin.Position.Y - 3, coin.Position.Z) * CFrame.Angles(math.rad(90), 0, 0)

				rootTween = TweenService:Create(rootPart, rootTweenInfo, {CFrame = rootTweenGoal})
				rootTween:Play()

				rootTween.Completed:Connect(function()
					coinRemovedConnection:Disconnect()
					wait(0.1)
					cleanupFallPrevention()  -- Nettoyer après avoir terminé le tween
					isFarming = false
					moveToCoinEclipse()
				end)
			end
		else
			wait(1)
			workspace.Gravity = 196.2
			isFarming = false
			moveToCoinEclipse()
		end
	else
		wait(1)
		workspace.Gravity = 196.2
		moveToCoinEclipse()
	end
end
local gameStarted = true

local function reset()
	local coinText
	if player.PlayerGui.MainGUI.Game:FindFirstChild("CoinBags") then
		coinText = player.PlayerGui.MainGUI.Game.CoinBags.Container.SnowToken.Full
	elseif player.PlayerGui.MainGUI:FindFirstChild("Lobby") then
		coinText = player.PlayerGui.MainGUI.Lobby.Dock.CoinBags.Container.SnowToken.Full
	end

	coinText:GetPropertyChangedSignal("Visible"):Connect(function()
		farm = false
		if active_AutoFarmEclipse then
			for _, i in pairs(game:GetService("Workspace"):GetDescendants()) do
                if i:IsA("BasePart") and (i.Name == "Spawn" or i.Name == "PlayerSpawn") then
                    local player = game.Players.LocalPlayer
                    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        player.Character.HumanoidRootPart.CFrame = i.CFrame
                        break -- Sortie après avoir téléporté le joueur à un spawn
                    end
                end
            end
		end
		if coinText.Visible == true and active_AutoFarm == true and active_AutoReset == true then
			player.Character.Humanoid.Health = 0
		end
		if coinText.Visible == true and active_AutoFarmEclipse == true and active_AutoReset == true then
			player.Character.Humanoid.Health = 0
		end
	end)

	if gameStarted then
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
		gameStarted = false
	end
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
	if rootTween then
		rootTween:Cancel()
	end
	for _, part in ipairs(character:GetDescendants()) do
		if part:IsA("BasePart") or part:IsA("MeshPart") then
			part.CanCollide = true -- Active/désactive la collision
		end
	end
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
	            player.Character.HumanoidRootPart.CFrame = i.CFrame
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

local function debris()
	beDebris = Instance.new("BodyPosition")
	beDebris.P = 0
	beDebris.D = 0
	beDebris.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	beDebris.Parent = character.HumanoidRootPart

	humanoid.PlatformStand = true
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local roleDataTable = {} -- Table pour stocker les données des rôles, incluant les morts

-- Fonction pour ajouter un Highlight à un personnage
local function addESPHighlight(player, role, isRespawn, isDead)
	if not player or player == Players.LocalPlayer then 
		return 
	end -- Ignorer le joueur local ou invalide

	local character = player.Character or player.CharacterAdded:Wait() -- Attendre que le personnage soit chargé
	local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 10) 
	if not humanoidRootPart then 
		return 
	end -- Vérifier si un ESP existe déjà et le supprimer

	local existingHighlight = character:FindFirstChild("ESPHighlight") 
	if existingHighlight then 
		existingHighlight:Destroy() 
	end 

	-- Créer un Highlight
	local highlight = Instance.new("Highlight")
	highlight.Name = "ESPHighlight"
	highlight.Parent = character
	highlight.FillTransparency = 0.8 -- Rendre l'intérieur partiellement transparent (visible)
	highlight.OutlineTransparency = 0 -- Opacité du contour
	highlight.Enabled = true -- Si c'est un respawn, appliquer un ESP blanc

	if isRespawn then
		highlight.OutlineColor = Color3.fromRGB(255, 255, 255) -- Blanc
		highlight.FillColor = Color3.fromRGB(255, 255, 255) -- Blanc
	elseif isDead then
		-- Si le joueur est mort, appliquer un ESP gris
		highlight.OutlineColor = Color3.fromRGB(169, 169, 169) -- Gris
		highlight.FillColor = Color3.fromRGB(169, 169, 169) -- Gris
	else
		-- Définir la couleur selon le rôle
		local roleColors = {
			Murderer = {
				OutlineColor = Color3.fromRGB(255, 0, 0),
				FillColor = Color3.fromRGB(255, 0, 0)
			},
			Sheriff = {
				OutlineColor = Color3.fromRGB(0, 0, 255),
				FillColor = Color3.fromRGB(0, 0, 255)
			},
			Innocent = {
				OutlineColor = Color3.fromRGB(0, 255, 0),
				FillColor = Color3.fromRGB(0, 255, 0)
			},
			Hero = {
				OutlineColor = Color3.fromRGB(255, 255, 0),
				FillColor = Color3.fromRGB(255, 255, 0)
			}
		}

		local color = roleColors[role]
		if color then
			highlight.OutlineColor = color.OutlineColor
			highlight.FillColor = color.FillColor
		end
	end
end

-- Fonction pour gérer l'activation de l'ESP
local function handleESPActivation()
	if esp then
		-- Si ESP est activé, appliquer les highlights des joueurs stockés dans roleDataTable
		for playerName, data in pairs(roleDataTable) do
			local player = Players:FindFirstChild(playerName)
			if player and type(data) == "table" and data.Role then
				-- Vérifier si le joueur est mort
				local isDead = data.IsDead or false
				addESPHighlight(player, data.Role, false, isDead)
			end
		end
	end
end

-- Fonction pour stocker les données des joueurs dans la table, y compris l'état de la mort
local function storeRoleData(player, role, isDead)
	roleDataTable[player.Name] = {Role = role, IsDead = isDead}
end

-- Gérer la mort d'un joueur
local function onPlayerDeath(player)
	-- Lorsqu'un joueur meurt, stocker l'état comme "mort" et appliquer l'ESP gris
	storeRoleData(player, roleDataTable[player.Name] and roleDataTable[player.Name].Role or "Unknown", true)
	if not active_Esp then
		-- Appliquer un ESP gris si ESP est désactivé
		addESPHighlight(player, roleDataTable[player.Name] and roleDataTable[player.Name].Role or "Unknown", false, true)
	end
end

-- Écoute l'ajout d'un joueur et son respawn
Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		-- Lors du respawn, appliquer un ESP blanc
		addESPHighlight(player, nil, true, false) -- Le paramètre "nil" est passé pour le rôle, car on applique un ESP blanc
	end)

	-- Écoute la mort du joueur
	player.Character:WaitForChild("Humanoid").Died:Connect(function()
		onPlayerDeath(player)
	end)
end)

-- Gérer le retrait d'un joueur
Players.PlayerRemoving:Connect(function(player)
	roleDataTable[player.Name] = nil
end)

-- Appliquer l'ESP pour les joueurs existants
for _, player in ipairs(Players:GetPlayers()) do
	player.CharacterAdded:Connect(function(character)
		addESPHighlight(player, nil, true, false)
	end)
	player.Character:WaitForChild("Humanoid").Died:Connect(function()
		onPlayerDeath(player)
	end)
end

-- Fonction pour vérifier si un joueur possède un Gun dans son Backpack
local function checkForGunInBackpack(player)
	local backpack = player:FindFirstChild("Backpack")
	if backpack then
		for _, item in pairs(backpack:GetChildren()) do
			if item.Name == "Gun" then
				return true
			end
		end
	end
	return false
end

-- Fonction pour appliquer l'effet Hero quand le gun est pris
local function applyHeroEffect()
	for _, player in pairs(Players:GetPlayers()) do
		-- Si un joueur a un gun dans son Backpack, on applique l'effet Hero
		if checkForGunInBackpack(player) then
			if not active_Esp then
				storeRoleData(player, "Hero", false) -- Stocker l'effet Hero dans la table si esp est désactivé
			else
                print("yes2")
            	addESPHighlight(player, "Hero", false, false)
				storeRoleData(player, "Hero", false)
			end
		end
	end
end

-- Écoute l'ajout d'un GunDrop dans le Workspace
local function espHero()
	game.Workspace.DescendantRemoving:Connect(function(descendant)
        if descendant.Name == "GunDrop" then
            print("yes")
            wait(1)
            applyHeroEffect()
        end
    end)
end

-- Écoute l'événement RoundStart
local espEvent = ReplicatedStorage.Remotes.Gameplay.Fade
espEvent.OnClientEvent:Connect(function(message)
	if roleDataTable ~= nil then
		roleDataTable = {}
	end

	if active_Esp then
		-- Si ESP est activé, appliquer directement les highlights
		for playerName, data in pairs(message) do
			local player = Players:FindFirstChild(playerName)
			if player and type(data) == "table" and data.Role then
				addESPHighlight(player, data.Role, false, false)
				storeRoleData(player, data.Role, false)
			end
		end
	else
		-- Sinon, stocker les données des rôles dans la table
		for playerName, data in pairs(message) do
			local player = Players:FindFirstChild(playerName)
			if player and type(data) == "table" and data.Role then
				storeRoleData(player, data.Role, false)
			end
		end
	end
end)

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

esp.MouseButton1Click:Connect(function()
	local outerFrame = esp
	local innerFrame = outerFrame:FindFirstChild("Frame")

	if active_Esp then
		active_Esp = false
		for _, player in pairs(Players:GetPlayers()) do
			local character = player.Character
			if character then
				local existingHighlight = character:FindFirstChild("ESPHighlight")
				if existingHighlight then
					existingHighlight:Destroy()  -- Détruire l'ESP
				end
			end
		end
		-- Si déjà actif, désactiver et arrêter la chasse aux pièces
		outerFrame.BackgroundTransparency = 1
		innerFrame.BackgroundColor3 = Color3.new(0.52549, 0.52549, 0.52549)
		moveFrame(innerFrame, UDim2.new(0.05, 0, 0.089, 0))  -- Position initiale
	else
		active_Esp = true
		handleESPActivation()
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

	wait(4)

	if active_AutoFarm then
		stopAutoFarm()
		wait(2)
		startAutoFarm()
	end
	if active_BeADebris then
		debris()
	end
	if active_AutoFarmEclipse then
		stopAutoFarmEclipse()
		wait(2)
		startAutoFarmEclipse()
	end
end

espHero()

-- Initialisation
player.CharacterAdded:Connect(onCharacterAdded)
