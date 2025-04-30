local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")
local TweenService = game:GetService("TweenService")
local rootTween
local bodyPosition
local farm = false
local fallprevention = false
local murder
local speed = 22

local autoFarm = false
local autoFarmRareEggs = false
local autoReset = false
local endRound = false

-- UI Setup
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "Teamers-HubUI"
screenGui.ResetOnSpawn = false

-- Main UI Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 500, 0, 300)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner", mainFrame)
corner.CornerRadius = UDim.new(0, 12)

-- Drag
local dragging, dragInput, dragStart, startPos
mainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

mainFrame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- SideBar
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 100, 1, 0)
sidebar.Position = UDim2.new(0, 0, 0, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
sidebar.BorderSizePixel = 0
sidebar.Parent = mainFrame

Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 10)

-- Tabs
local tabs = {"Home", "AutoFarm", "Visuals"}
local pages = {}

local function createTabButton(name, index)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, 0, 0, 40)
	button.Position = UDim2.new(0, 0, 0, 10 + (index - 1) * 45)
	button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.TextSize = 14
	button.Text = name
	button.BorderSizePixel = 0
	button.Parent = sidebar

	Instance.new("UICorner", button).CornerRadius = UDim.new(0, 6)

	return button
end

-- Pages container
local pageFrame = Instance.new("Frame")
pageFrame.Size = UDim2.new(1, -110, 1, -20)
pageFrame.Position = UDim2.new(0, 110, 0, 10)
pageFrame.BackgroundTransparency = 1
pageFrame.Parent = mainFrame

-- Create pages & tabs

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

-- Liste des joueurs dangereux à éviter
local dangerousPlayers = {
	"Jr_myR4",
	"vrvkriovjesnzqdbfbfb",
	"AngelFruit78",
	"Vellrox_YT",
	"Blox_1568"
}

-- Fonction pour trouver une pièce random
local function findRandomCoin()
	local coins = {}

	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj.Name == "CoinContainer" then
			for _, coin in ipairs(obj:GetDescendants()) do
				if coin:IsA("BasePart") and coin.Transparency == 0 then
					table.insert(coins, coin)
				end
			end
		end
	end

	if #coins > 0 then
		local randomCoin = coins[math.random(1, #coins)]
		local distance = (randomCoin.Position - rootPart.Position).Magnitude
		return randomCoin, distance
	else
		return nil, math.huge
	end
end

-- Fonction pour vérifier si un joueur dangereux est proche
local function isDangerousPlayerNearby(radius)
	for _, playerName in ipairs(dangerousPlayers) do
		local player = game.Players:FindFirstChild(playerName)
		if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and playerName ~= game.Players.LocalPlayer.Name then
			local playerPos = player.Character.HumanoidRootPart.Position
			if (playerPos - rootPart.Position).Magnitude <= radius then
				return true
			end
		end
	end
	return false
end

local ascendTween

-- Fonction principale pour bouger vers une pièce
local function moveToCoin()
	if not autoFarm or not character:FindFirstChild("HumanoidRootPart") then return end

	if farm then
		local coin, distance

		-- Si un joueur dangereux est proche, prendre une pièce random, sinon nearest
		if isDangerousPlayerNearby(5) then
			coin, distance = findRandomCoin()
		else
			coin, distance = findNearestCoin()
		end

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
					moveToCoin()
				end
			end)

			if not fallprevention then
				fallprevention = true
				humanoid.PlatformStand = true
			end

			local duration = distance / speed

			if distance <= 4 then
				if coin.Parent.Parent:IsA("BasePart") then
					coin.Parent.Parent.CFrame = rootPart.CFrame
				else
					coin.Parent.CFrame = rootPart.CFrame
				end
				cleanConnections()
				wait(0.1)
				cleanupFallPrevention()
				moveToCoin()
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
				cleanupFallPrevention()
				moveToCoin()
			else
				workspace.Gravity = 0
				local rootTweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
				local rootTweenGoal = CFrame.new(coin.Position.X, coin.Position.Y - 4, coin.Position.Z) * CFrame.Angles(math.rad(90), 0, 0)

				rootTween = TweenService:Create(rootPart, rootTweenInfo, {CFrame = rootTweenGoal})
				rootTween:Play()

				tweenConnection = rootTween.Completed:Connect(function()
					cleanConnections()

					-- Nouvelle étape : légère montée
					local ascendTweenInfo = TweenInfo.new(0.05, Enum.EasingStyle.Linear)
					local ascendGoal = {CFrame = rootPart.CFrame * CFrame.new(0, 0, -0.5)} -- monte de 3 studs

					ascendTween = TweenService:Create(rootPart, ascendTweenInfo, ascendGoal)
					ascendTween:Play()

					ascendTween.Completed:Connect(function()
						wait(0.1)
						cleanupFallPrevention()
						moveToCoin()
					end)
				end)
			end
		else
			wait(1)
			workspace.Gravity = 196.2
			cleanupFallPrevention()
			moveToCoin()
		end
	else
		wait(1)
		workspace.Gravity = 196.2
		cleanupFallPrevention()
		moveToCoin()
	end
end

local RunService = game:GetService("RunService")
local murderDied = false

local function fling()
	while not murderDied and murder do
		local p = game.Players.LocalPlayer
		local c = p.Character
		local h = c:WaitForChild("HumanoidRootPart")

		-- Get the target part to fling
		local Target = game.Workspace:FindFirstChild(murder):WaitForChild("HumanoidRootPart")

		local pos_UU = h.CFrame

		local Thrust = Instance.new('BodyThrust', p.Character.HumanoidRootPart)
		Thrust.Force = Vector3.new(9999,9999,9999)
		Thrust.Name = "YeetForce"

		for i = 1, 200 do
			p.Character.HumanoidRootPart.CFrame = Target.CFrame
			Thrust.Location = Target.Position
			game:FindService("RunService").Heartbeat:wait()
		end

		Thrust:Destroy()
		c.Humanoid.PlatformStand = false
		h.CFrame = pos_UU
		wait(2)
	end
end

local rareEggsSpawn
local processing = false

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
		if rootTween then
			rootTween:Cancel()
		end
		if ascendTween then
			ascendTween:Cancel()
		end
		if murder == "juju59lulu1" or murder == "Vellrox_YT" or murder == "coeursn" then
			rootPart.CFrame = game.Workspace:FindFirstChild(murder).HumanoidRootPart.CFrame
		elseif autoFarmRareEggs then
			for _, spawnPoint in pairs(game.Workspace:GetDescendants()) do
				if spawnPoint:IsA("BasePart") and (spawnPoint.Name == "Spawn" or spawnPoint.Name == "PlayerSpawn") then
					local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
					if hrp then
						hrp.CFrame = spawnPoint.CFrame * CFrame.new(0, 20, 0)
						break
					end
				end
			end

			for _, obj in ipairs(game.Workspace:GetDescendants()) do
				if obj.Name == "CoinContainer" then
					rareEggsSpawn = obj.ChildAdded:Connect(function(part)
						if processing then return end
						processing = true

						wait()

						for _, p in part:GetDescendants() do
							if p:IsA("BasePart") and p.Transparency == 0 then
								local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
								if hrp then
									wait(0.5)				
									hrp.CFrame = part.CFrame * CFrame.new(0, 5, 0)
									wait(1)
									for _, s in pairs(game.Workspace:GetDescendants()) do
										if s:IsA("BasePart") and (s.Name == "Spawn" or s.Name == "PlayerSpawn") then
											hrp.CFrame = s.CFrame * CFrame.new(0, 20, 0)
											break
										end
									end
								end
							end
						end

						processing = false
					end)
				end
			end
		elseif autoReset then
			for _, spawnPoint in pairs(game.Workspace:GetDescendants()) do
				if spawnPoint:IsA("BasePart") and (spawnPoint.Name == "Spawn" or spawnPoint.Name == "PlayerSpawn") and not (spawnPoint.Parent.Parent.Name == "Lobby") then
					local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
					if hrp then
						hrp.CFrame = spawnPoint.CFrame * CFrame.new(0, 5, 0)
						break
					end
				end
			end
			wait(0.5)
			character.Humanoid.Health = 0
		else
			for _, spawnPoint in pairs(game.Workspace:GetDescendants()) do
				if spawnPoint:IsA("BasePart") and (spawnPoint.Name == "Spawn" or spawnPoint.Name == "PlayerSpawn") and not (spawnPoint.Parent.Parent.Name == "Lobby") then
					local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
					if hrp then
						hrp.CFrame = spawnPoint.CFrame * CFrame.new(0, 5, 0)
						break
					end
				end
			end
			if endRound then
				fling()
			end
		end
	end)
end

-- Fonction pour démarrer l'auto-farm
local function startAutoFarm()
	autoFarm = true
	reset()
	moveToCoin()  -- Lancer la chasse à la première pièce
	while autoFarm do
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
	autoFarm = false
	workspace.Gravity = 196.2
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
			local character_ = player.Character or player:WaitForChild("Character")
			local humanoid_ = character_:WaitForChild("Humanoid")

			murder = tostring(player)
			murderDied = false
			humanoid_.Died:Connect(function()
				murderDied = true
			end)
		end
	end
end)

local transparencyTargets = {}

function enableXRay()
	transparencyTargets = {}

	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") and not obj:IsDescendantOf(game.Players.LocalPlayer.Character) then
			if obj.Transparency < 1 then
				table.insert(transparencyTargets, {part = obj, originalTransparency = obj.Transparency})
				obj.Transparency = 0.8
			end
		end
	end
end

function disableXRay()
	for _, data in pairs(transparencyTargets) do
		if data.part and data.part:IsDescendantOf(workspace) then
			data.part.Transparency = data.originalTransparency
		end
	end
	transparencyTargets = {}
end

local toggleActions = {
	["Auto Farm"] = function(enabled)
		if enabled then
			autoFarm = true
			startAutoFarm()
		else
			autoFarm = false
			for _, i in pairs(game:GetService("Workspace"):GetDescendants()) do
				if i:IsA("BasePart") and (i.Name == "Spawn" or i.Name == "PlayerSpawn") then
					local player = game.Players.LocalPlayer
					if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
						player.Character.HumanoidRootPart.CFrame = i.CFrame * CFrame.new(0, 20, 0)
						break -- Sortie après avoir téléporté le joueur à un spawn
					end
				end
			end
			stopAutoFarm()
		end
	end,

	["Auto Farm Rare Eggs"] = function(enabled)
		if enabled then
			autoFarmRareEggs = true
		else
			autoFarmRareEggs = false
		end
	end,

	["Auto Reset"] = function(enabled)
		if enabled then
			autoReset = true
		else
			autoReset = false
		end
	end,

	["⚠️ End Round"] = function(enabled)
		if enabled then
			endRound = true
		else
			endRound = false
		end
	end,

	["⚠️ X-Ray"] = function(enabled)
		if enabled then
			enableXRay()
		else
			disableXRay()
		end
	end
}

for i, name in ipairs(tabs) do
	local page = Instance.new("Frame")
	page.Size = UDim2.new(1, 0, 1, 0)
	page.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	page.BorderSizePixel = 0
	page.Visible = (i == 1)
	page.Parent = pageFrame

	if name == "AutoFarm" then
		local toggles = {
			{"Auto Farm", false},
			{"Auto Farm Speed", false},
			{"Auto Farm Rare Eggs", false},
			{"Auto Reset", false},
			{"⚠️ End Round", false}
		}

		for i, info in ipairs(toggles) do
			local toggleName, toggleState = info[1], info[2]

			if toggleName == "Auto Farm Speed" then
				local container = Instance.new("Frame")
				container.Size = UDim2.new(1, -20, 0, 40)
				container.Position = UDim2.new(0, 10, 0, (i - 1) * 50 + 10)
				container.BackgroundTransparency = 1
				container.Parent = page

				local label = Instance.new("TextLabel")
				label.Size = UDim2.new(0.6, 0, 1, 0)
				label.BackgroundTransparency = 1
				label.Text = toggleName
				label.TextColor3 = Color3.fromRGB(255, 255, 255)
				label.TextSize = 18
				label.Font = Enum.Font.SourceSansBold
				label.TextXAlignment = Enum.TextXAlignment.Left
				label.Parent = container

				local text = Instance.new("TextBox")
				text.Size = UDim2.new(0, 50, 0, 25)
				text.Position = UDim2.new(1, -60, 0.5, -12)
				text.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
				text.BorderSizePixel = 0
				text.PlaceholderText = "22"
				text.Text = ""
				text.Font = Enum.Font.SourceSansBold
				text.TextSize = 18
				text.TextColor3 = Color3.new(0.839216, 0.839216, 0.839216)
				text.Parent = container
				
				text.Changed:Connect(function()
					local newText = text.Text
                    local number = tonumber(newText)
                    if number then
                        speed = number
                    end
				end)

				local corner = Instance.new("UICorner", text)
				corner.CornerRadius = UDim.new(0, 8)
			else
				local container = Instance.new("Frame")
				container.Size = UDim2.new(1, -20, 0, 40)
				container.Position = UDim2.new(0, 10, 0, (i - 1) * 50 + 10)
				container.BackgroundTransparency = 1
				container.Parent = page

				local label = Instance.new("TextLabel")
				label.Size = UDim2.new(0.6, 0, 1, 0)
				label.BackgroundTransparency = 1
				label.Text = toggleName
				label.TextColor3 = Color3.fromRGB(255, 255, 255)
				label.TextSize = 18
				label.Font = Enum.Font.SourceSansBold
				label.TextXAlignment = Enum.TextXAlignment.Left
				label.Parent = container

				local toggle = Instance.new("Frame")
				toggle.Size = UDim2.new(0, 50, 0, 25)
				toggle.Position = UDim2.new(1, -60, 0.5, -12)
				toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
				toggle.BorderSizePixel = 0
				toggle.Parent = container

				local corner = Instance.new("UICorner", toggle)
				corner.CornerRadius = UDim.new(0, 12)

				local knob = Instance.new("Frame")
				knob.Size = UDim2.new(0, 21, 0, 21)
				knob.Position = UDim2.new(0, 2, 0, 2)
				knob.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
				knob.BorderSizePixel = 0
				knob.Parent = toggle

				Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

				local isOn = false

				local function updateToggle(state)
					isOn = state
					local targetPos = state and UDim2.new(1, -23, 0, 2) or UDim2.new(0, 2, 0, 2)
					local color = state and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(60, 60, 60)
					local knobColor = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)

					TweenService:Create(knob, TweenInfo.new(0.2), {Position = targetPos}):Play()
					TweenService:Create(toggle, TweenInfo.new(0.2), {BackgroundColor3 = color}):Play()
					knob.BackgroundColor3 = knobColor
				end

				toggle.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						local newState = not isOn
						updateToggle(newState)

						-- Appelle l'action liée à ce toggle
						if toggleActions[toggleName] then
							toggleActions[toggleName](newState)
						end
					end
				end)

				updateToggle(false)
			end
		end
	elseif name == "Visuals" then
		local toggles = {
			{"⚠️ X-Ray", false}
		}

		for i, info in ipairs(toggles) do
			local toggleName, toggleState = info[1], info[2]

			local container = Instance.new("Frame")
			container.Size = UDim2.new(1, -20, 0, 40)
			container.Position = UDim2.new(0, 10, 0, (i - 1) * 50 + 10)
			container.BackgroundTransparency = 1
			container.Parent = page

			local label = Instance.new("TextLabel")
			label.Size = UDim2.new(0.6, 0, 1, 0)
			label.BackgroundTransparency = 1
			label.Text = toggleName
			label.TextColor3 = Color3.fromRGB(255, 255, 255)
			label.TextSize = 18
			label.Font = Enum.Font.SourceSansBold
			label.TextXAlignment = Enum.TextXAlignment.Left
			label.Parent = container

			local toggle = Instance.new("Frame")
			toggle.Size = UDim2.new(0, 50, 0, 25)
			toggle.Position = UDim2.new(1, -60, 0.5, -12)
			toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
			toggle.BorderSizePixel = 0
			toggle.Parent = container

			local corner = Instance.new("UICorner", toggle)
			corner.CornerRadius = UDim.new(0, 12)

			local knob = Instance.new("Frame")
			knob.Size = UDim2.new(0, 21, 0, 21)
			knob.Position = UDim2.new(0, 2, 0, 2)
			knob.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
			knob.BorderSizePixel = 0
			knob.Parent = toggle

			Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

			local isOn = false

			local function updateToggle(state)
				isOn = state
				local targetPos = state and UDim2.new(1, -23, 0, 2) or UDim2.new(0, 2, 0, 2)
				local color = state and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(60, 60, 60)
				local knobColor = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)

				TweenService:Create(knob, TweenInfo.new(0.2), {Position = targetPos}):Play()
				TweenService:Create(toggle, TweenInfo.new(0.2), {BackgroundColor3 = color}):Play()
				knob.BackgroundColor3 = knobColor
			end

			toggle.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					local newState = not isOn
					updateToggle(newState)

					-- Appelle l'action liée à ce toggle
					if toggleActions[toggleName] then
						toggleActions[toggleName](newState)
					end
				end
			end)

			updateToggle(false)
		end
	else
		local label = Instance.new("TextLabel")
		label.Size = UDim2.new(1, 0, 1, 0)
		label.BackgroundTransparency = 1
		label.RichText = true
		label.TextColor3 = Color3.fromRGB(255, 255, 255)
		label.TextSize = 18
		label.Font = Enum.Font.SourceSansBold  -- Utilise la même police
		label.TextXAlignment = Enum.TextXAlignment.Left
		label.TextYAlignment = Enum.TextYAlignment.Top
		label.TextWrapped = true
		label.Text = [[
<b><font color="rgb(0,170,255)">TEAMERS-HUB</font></b><br/>
<b>Changelog – v0.22a</b>

<font color="rgb(255,255,0)">~ Amélioration :</font> Améliorations (petite)
<font color="rgb(255,100,100)">- Correction (BUG):</font> auto farm (mini bug)
<font color="rgb(0,255,0)">+ Ajout :</font> Toggle "End Round"
<font color="rgb(0,255,0)">+ Ajout :</font> TextBox "Auto Farm Speed"<br/>
⚠️ bug X-ray (fait x-ray les pièces + joueurs)
⚠️ bug End Round (Ver. Alpha (gros BUG possible))
]]

		--<font color="rgb(200,200,200)"><i>Merci d'utiliser Teamers Hub ❤️</i></font>
		--<font color="rgb(0,255,0)">+ Ajout :</font> Toggle "X-Ray"<br/>
		label.Parent = page
	end

	pages[name] = page

	local button = createTabButton(name, i)
	button.MouseButton1Click:Connect(function()
		for _, p in pairs(pages) do p.Visible = false end
		pages[name].Visible = true
	end)
end


local menuOpen = true
local UserInputService = game:GetService("UserInputService")

-- Détecter l'appui sur Tab
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	-- Vérifie si l'entrée est la touche Tab et si ce n'est pas déjà traité par le jeu
	if gameProcessed then return end
	if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.Tab then
		if menuOpen then
			screenGui.Enabled = false
			menuOpen = false
		else
			screenGui.Enabled = true
			menuOpen = true
		end
	end
end)

-- Gestion des personnages
local function onCharacterAdded(newCharacter)
	character = newCharacter
	rootPart = character:WaitForChild("HumanoidRootPart")
	humanoid = character:WaitForChild("Humanoid")

	farm = false
	wait(4)
	if rareEggsSpawn then
		rareEggsSpawn:Disconnect()
		rareEggsSpawn = nil
	end
	if endRound then
		fling()
	end
	if autoFarm then
		stopAutoFarm()
		wait(2)
		startAutoFarm()
	end
end

player.CharacterAdded:Connect(onCharacterAdded)
