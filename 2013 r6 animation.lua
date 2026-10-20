-- Fixed Custom Animate
-- Place this in a LocalScript inside StarterPlayerScripts.

local Players = game:GetService("Players")

local plr = Players.LocalPlayer
local activeCleanup

local function RunCustomAnimation(Char)
	if activeCleanup then
		activeCleanup()
	end

	local alive = true
	local connections = {}
	local loadedTracks = {}
	local animationObjects = {}
	local watchedTools = {}

	local Humanoid
	local Animator

	local animTable = {}
	local currentAnim = ""
	local currentTrack = nil
	local currentAnimSpeed = 1
	local movementSpeed = 0
	local pose = "Standing"

	local currentlyPlayingEmote = false
	local toolEquipped = false
	local currentTool = nil

	local jumpStartedAt = 0
	local stateGeneration = 0

	local cleanup

	cleanup = function()
		if not alive then
			return
		end

		alive = false

		for _, connection in ipairs(connections) do
			pcall(function()
				connection:Disconnect()
			end)
		end

		table.clear(connections)

		for _, track in ipairs(loadedTracks) do
			pcall(function()
				track:Stop(0)
			end)

			pcall(function()
				track:Destroy()
			end)
		end

		for _, animation in ipairs(animationObjects) do
			pcall(function()
				animation:Destroy()
			end)
		end

		if activeCleanup == cleanup then
			activeCleanup = nil
		end
	end

	activeCleanup = cleanup

	Humanoid = Char:WaitForChild("Humanoid")

	if not alive or not Char.Parent then
		return
	end

	--==================================================
	-- CONNECTION HELPER
	--==================================================

	local function connect(signal, callback)
		local connection = signal:Connect(callback)
		table.insert(connections, connection)
		return connection
	end

	--==================================================
	-- DISABLE DEFAULT ANIMATE
	--==================================================

	local function disableDefaultAnimate(child)
		if child == script then
			return
		end

		if child.Name == "Animate"
			and (child:IsA("LocalScript") or child:IsA("Script")) then

			child.Disabled = true
		end
	end

	for _, child in ipairs(Char:GetChildren()) do
		disableDefaultAnimate(child)
	end

	connect(Char.ChildAdded, disableDefaultAnimate)

	--==================================================
	-- ANIMATOR
	--==================================================

	Animator = Humanoid:FindFirstChildOfClass("Animator")

	if not Animator then
		Animator = Instance.new("Animator")
		Animator.Parent = Humanoid
	end

	-- Stop animations left over from the default Animate script.
	for _, track in ipairs(Animator:GetPlayingAnimationTracks()) do
		pcall(function()
			track:Stop(0)
		end)
	end

	--==================================================
	-- ANIMATION IDS
	--==================================================

	local animNames = {
		idle = {
			{ id = "rbxassetid://161100084", weight = 9 },
			{ id = "rbxassetid://125750618", weight = 1 }
		},

		walk = {
			{ id = "rbxassetid://161210451", weight = 10 }
		},

		run = {
			{ id = "rbxassetid://161210451", weight = 10 }
		},

		jump = {
			{ id = "rbxassetid://165167557", weight = 10 }
		},

		fall = {
			{ id = "rbxassetid://165167632", weight = 10 }
		},

		climb = {
			{ id = "rbxassetid://161235826", weight = 10 }
		},

		sit = {
			{ id = "rbxassetid://178130996", weight = 10 }
		},

		toolnone = {
			{ id = "rbxassetid://125750867", weight = 10 }
		},

		toolslash = {
			{ id = "rbxassetid://129967390", weight = 10 }
		},

		toollunge = {
			{ id = "rbxassetid://129967478", weight = 10 }
		},

		wave = {
			{ id = "rbxassetid://128777973", weight = 10 }
		},

		point = {
			{ id = "rbxassetid://128853357", weight = 10 }
		},

		dance = {
			{ id = "rbxassetid://161099825", weight = 10 },
			{ id = "rbxassetid://161099825", weight = 10 },
			{ id = "rbxassetid://161099825", weight = 10 }
		},

		dance2 = {
			{ id = "rbxassetid://161099825", weight = 10 }
		},

		dance3 = {
			{ id = "rbxassetid://161099825", weight = 10 }
		},

		laugh = {
			{ id = "rbxassetid://129423131", weight = 10 }
		},

		cheer = {
			{ id = "rbxassetid://129423030", weight = 10 }
		}
	}

	-- These animations should repeat continuously.
	local loopedAnimations = {
		idle = true,
		walk = true,
		run = true,
		fall = true,
		climb = true,
		sit = true,
		toolnone = true,
		dance = true,
		dance2 = true,
		dance3 = true
	}

	local emoteNames = {
		wave = false,
		point = false,
		dance = true,
		dance2 = true,
		dance3 = true,
		laugh = false,
		cheer = false
	}

	--==================================================
	-- LOAD ANIMATIONS ONCE
	--==================================================

	local function configureAnimationSet(name, fileList)
		local set = {
			items = {},
			totalWeight = 0
		}

		animTable[name] = set

		for _, animData in ipairs(fileList) do
			local animation = Instance.new("Animation")
			animation.Name = name
			animation.AnimationId = animData.id

			table.insert(animationObjects, animation)

			local success, track = pcall(function()
				return Animator:LoadAnimation(animation)
			end)

			if success and track then
				-- IMPORTANT: Set looping explicitly.
				track.Looped = loopedAnimations[name] == true

				-- Tool attacks should have higher priority.
				if name == "toolslash" or name == "toollunge" then
					track.Priority = Enum.AnimationPriority.Action
				else
					track.Priority = Enum.AnimationPriority.Core
				end

				local entry = {
					track = track,
					weight = animData.weight
				}

				table.insert(set.items, entry)
				set.totalWeight = set.totalWeight + animData.weight

				table.insert(loadedTracks, track)
			else
				warn("Could not load animation:", name, animData.id)
			end
		end
	end

	for name, list in pairs(animNames) do
		configureAnimationSet(name, list)
	end

	--==================================================
	-- RANDOM WEIGHTED ANIMATION
	--==================================================

	local function rollAnimation(animName)
		local set = animTable[animName]

		if not set or #set.items == 0 then
			return nil
		end

		local roll = math.random() * set.totalWeight

		for _, entry in ipairs(set.items) do
			if roll < entry.weight then
				return entry
			end

			roll = roll - entry.weight
		end

		return set.items[#set.items]
	end

	--==================================================
	-- STOP CURRENT ANIMATION
	--==================================================

	local function stopCurrentAnimation(fadeTime)
		local oldTrack = currentTrack

		-- Clear the reference before stopping the track.
		currentTrack = nil
		currentAnim = ""
		currentAnimSpeed = 1

		if oldTrack and oldTrack.IsPlaying then
			oldTrack:Stop(fadeTime or 0.15)
		end
	end

	--==================================================
	-- PLAY ANIMATION
	--==================================================

	local function playAnimation(animName, fadeTime)
		if not alive or not animTable[animName] then
			return false
		end

		-- Do not restart a currently playing animation every frame.
		if currentAnim == animName
			and currentTrack
			and currentTrack.IsPlaying then

			return true
		end

		local entry = rollAnimation(animName)

		if not entry then
			return false
		end

		local track = entry.track
		local oldTrack = currentTrack
		local fade = fadeTime or 0.15

		-- If this track was still fading out from an earlier play,
		-- stop it before reusing it.
		if track.IsPlaying and track ~= oldTrack then
			currentTrack = nil
			currentAnim = ""
			track:Stop(0)
		end

		currentTrack = track
		currentAnim = animName
		currentAnimSpeed = 1

		if oldTrack and oldTrack ~= track and oldTrack.IsPlaying then
			oldTrack:Stop(fade)
		end

		pcall(function()
			track.TimePosition = 0
		end)

		local success = pcall(function()
			track:Play(fade)
		end)

		if not success then
			if currentTrack == track then
				currentTrack = nil
				currentAnim = ""
			end

			return false
		end

		return true
	end

	local function setAnimationSpeed(speed)
		if currentTrack and currentTrack.IsPlaying then
			speed = math.clamp(speed, 0.1, 2.5)

			currentTrack:AdjustSpeed(speed)
			currentAnimSpeed = speed
		end
	end

	--==================================================
	-- HUMANOID STATES
	--==================================================

	local function isGroundedState(state)
		return state == Enum.HumanoidStateType.Running
			or state == Enum.HumanoidStateType.RunningNoPhysics
			or state == Enum.HumanoidStateType.Landed
			or state == Enum.HumanoidStateType.GettingUp
			or state == Enum.HumanoidStateType.Standing
	end

	--==================================================
	-- MOVEMENT / IDLE
	--==================================================

	local function updateLocomotion()
		if not alive or Humanoid.Health <= 0 then
			return
		end

		local state = Humanoid:GetState()

		if not isGroundedState(state) then
			return
		end

		local moving =
			Humanoid.MoveDirection.Magnitude > 0.05
			or movementSpeed > 0.5

		-- Allow an attack animation to finish while standing still.
		if not moving
			and (currentAnim == "toolslash" or currentAnim == "toollunge") then

			return
		end

		if currentlyPlayingEmote then
			if moving then
				currentlyPlayingEmote = false
			else
				pose = "Standing"
				return
			end
		end

		if moving then
			pose = "Running"

			local animName = "walk"

			if movementSpeed > 18 then
				animName = "run"
			end

			if not animTable[animName]
				or #animTable[animName].items == 0 then

				animName = "walk"
			end

			playAnimation(animName, 0.15)

			local speed = math.max(movementSpeed, 8) / 16
			setAnimationSpeed(speed)
		else
			pose = "Standing"

			if toolEquipped then
				if not playAnimation("toolnone", 0.15) then
					playAnimation("idle", 0.15)
				end
			else
				playAnimation("idle", 0.15)
			end
		end
	end

	--==================================================
	-- NON-LOOPING ANIMATION FINISHED
	--==================================================

	local function handleTrackEnded(animName, track)
		-- Ignore animations that were stopped because another
		-- animation replaced them.
		if not alive or currentTrack ~= track then
			return
		end

		if currentAnim ~= animName then
			return
		end

		currentTrack = nil
		currentAnim = ""

		if emoteNames[animName] ~= nil and currentlyPlayingEmote then
			currentlyPlayingEmote = false
			updateLocomotion()

		elseif animName == "toolslash" or animName == "toollunge" then
			updateLocomotion()

		elseif animName == "jump" then
			-- Freefall has its own timer, so don't prematurely
			-- override the jump animation.
			if isGroundedState(Humanoid:GetState()) then
				updateLocomotion()
			end
		end
	end

	-- Track.Stopped also lets non-looping emotes return to idle.
	for name, set in pairs(animTable) do
		for _, entry in ipairs(set.items) do
			local track = entry.track

			connect(track.Stopped, function()
				handleTrackEnded(name, track)
			end)
		end
	end

	--==================================================
	-- RUNNING
	--==================================================

	connect(Humanoid.Running, function(speed)
		movementSpeed = speed

		if isGroundedState(Humanoid:GetState()) then
			updateLocomotion()
		elseif Humanoid:GetState() == Enum.HumanoidStateType.Climbing then
			setAnimationSpeed(math.abs(speed) / 5)
		end
	end)

	--==================================================
	-- CLIMBING
	--==================================================

	connect(Humanoid.Climbing, function(speed)
		if not alive then
			return
		end

		if Humanoid:GetState() == Enum.HumanoidStateType.Climbing then
			if currentAnim ~= "climb" then
				playAnimation("climb", 0.1)
			end

			setAnimationSpeed(math.abs(speed) / 12)
		end
	end)

	--==================================================
	-- STATE CHANGES: JUMP, FALL, SIT, ETC.
	--==================================================

	connect(Humanoid.StateChanged, function(_, newState)
		if not alive then
			return
		end

		stateGeneration = stateGeneration + 1
		local thisGeneration = stateGeneration

		if newState == Enum.HumanoidStateType.Jumping then
			pose = "Jumping"
			currentlyPlayingEmote = false
			jumpStartedAt = os.clock()

			playAnimation("jump", 0.1)

		elseif newState == Enum.HumanoidStateType.Freefall then
			pose = "FreeFall"
			currentlyPlayingEmote = false

			local elapsed = 0

			if jumpStartedAt > 0 then
				elapsed = os.clock() - jumpStartedAt
			end

			local remaining = math.max(0, 0.31 - elapsed)

			-- Preserve the jump animation briefly, then switch to fall.
			task.delay(remaining, function()
				if not alive or not Char.Parent then
					return
				end

				if stateGeneration ~= thisGeneration then
					return
				end

				if Humanoid.Health > 0
					and Humanoid:GetState() == Enum.HumanoidStateType.Freefall
					and pose == "FreeFall" then

					playAnimation("fall", 0.15)
				end
			end)

		elseif newState == Enum.HumanoidStateType.Climbing then
			pose = "Climbing"
			currentlyPlayingEmote = false
			playAnimation("climb", 0.1)

		elseif newState == Enum.HumanoidStateType.Seated then
			pose = "Seated"
			currentlyPlayingEmote = false
			playAnimation("sit", 0.25)

		elseif newState == Enum.HumanoidStateType.Landed
			or newState == Enum.HumanoidStateType.Running
			or newState == Enum.HumanoidStateType.RunningNoPhysics
			or newState == Enum.HumanoidStateType.GettingUp
			or newState == Enum.HumanoidStateType.Standing then

			pose = "Standing"
			jumpStartedAt = 0

			task.defer(function()
				if alive then
					updateLocomotion()
				end
			end)

		elseif newState == Enum.HumanoidStateType.Swimming then
			pose = "Swimming"
			currentlyPlayingEmote = false
			stopCurrentAnimation(0.1)

		elseif newState == Enum.HumanoidStateType.Dead
			or newState == Enum.HumanoidStateType.PlatformStanding
			or newState == Enum.HumanoidStateType.FallingDown
			or newState == Enum.HumanoidStateType.Ragdoll
			or newState == Enum.HumanoidStateType.Physics then

			pose = "Dead"
			currentlyPlayingEmote = false
			stopCurrentAnimation(0.1)
		end
	end)

	connect(Humanoid.Died, function()
		pose = "Dead"
		currentlyPlayingEmote = false
		stopCurrentAnimation(0)
	end)

	--==================================================
	-- TOOL ANIMATIONS
	--==================================================

	local function watchTool(tool)
		if watchedTools[tool] then
			return
		end

		if not tool:IsA("Tool") then
			return
		end

		watchedTools[tool] = true

		if tool.Parent == Char then
			currentTool = tool
			toolEquipped = true
		end

		connect(tool.Equipped, function()
			if not alive or tool.Parent ~= Char then
				return
			end

			currentTool = tool
			toolEquipped = true
			updateLocomotion()
		end)

		connect(tool.Unequipped, function()
			if currentTool == tool then
				currentTool = nil
				toolEquipped = false
				updateLocomotion()
			end
		end)

		connect(tool.Activated, function()
			if not alive or tool.Parent ~= Char then
				return
			end

			if not isGroundedState(Humanoid:GetState()) then
				return
			end

			local animName = "toolslash"
			local marker = tool:FindFirstChild("toolanim")

			if marker
				and marker:IsA("StringValue")
				and string.lower(marker.Value) == "lunge" then

				animName = "toollunge"
			end

			playAnimation(animName, 0.05)
		end)
	end

	for _, child in ipairs(Char:GetChildren()) do
		watchTool(child)
	end

	connect(Char.ChildAdded, function(child)
		watchTool(child)
	end)

	connect(Char.ChildRemoved, function(child)
		if child == currentTool then
			currentTool = nil
			toolEquipped = false

			task.defer(function()
				if alive then
					updateLocomotion()
				end
			end)
		end
	end)

	--==================================================
	-- EMOTES THROUGH CHAT
	--==================================================

	connect(plr.Chatted, function(message)
		if not alive or Humanoid.Health <= 0 then
			return
		end

		message = string.lower(message)

		local emote = message:match("^/e%s+(.+)$")
			or message:match("^/emote%s+(.+)$")

		if not emote then
			return
		end

		emote = emote:gsub("%s+$", "")

		if emoteNames[emote] == nil then
			return
		end

		if pose ~= "Standing" then
			return
		end

		if Humanoid.MoveDirection.Magnitude > 0.05
			or movementSpeed > 0.5 then

			return
		end

		currentlyPlayingEmote = true

		if not playAnimation(emote, 0.1) then
			currentlyPlayingEmote = false
		end
	end)

	--==================================================
	-- INITIAL ANIMATION
	--==================================================

	local initialState = Humanoid:GetState()

	if initialState == Enum.HumanoidStateType.Jumping then
		pose = "Jumping"
		jumpStartedAt = os.clock()
		playAnimation("jump", 0.1)

	elseif initialState == Enum.HumanoidStateType.Freefall then
		pose = "FreeFall"
		playAnimation("fall", 0.1)

	elseif initialState == Enum.HumanoidStateType.Seated then
		pose = "Seated"
		playAnimation("sit", 0.1)

	elseif initialState == Enum.HumanoidStateType.Climbing then
		pose = "Climbing"
		playAnimation("climb", 0.1)

	elseif isGroundedState(initialState) then
		updateLocomotion()

	else
		playAnimation("idle", 0.1)
	end
end

--==================================================
-- CURRENT CHARACTER / RESPAWNS
--==================================================

plr.CharacterAdded:Connect(function(Char)
	RunCustomAnimation(Char)
end)

if plr.Character then
	task.spawn(function()
		RunCustomAnimation(plr.Character)
	end)
end
