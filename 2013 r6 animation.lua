-- Fixed Custom Animate (Walk now works + Jump/Sit still work)
local Players = game:GetService("Players")
local plr = Players.LocalPlayer

local function RunCustomAnimation(Char)
	local Humanoid = Char:WaitForChild("Humanoid")
	local Animator = Humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", Humanoid)

	-- Disable default Animate
	local oldAnimate = Char:FindFirstChild("Animate")
	if oldAnimate then
		oldAnimate.Disabled = true
	end

	-- Stop everything currently playing
	for _, track in pairs(Animator:GetPlayingAnimationTracks()) do
		track:Stop(0)
	end

	-- ======================
	-- YOUR ANIMATION IDs
	-- ======================
	local animNames = {
		idle = {
			{ id = "rbxassetid://161100084", weight = 9 },
			{ id = "rbxassetid://125750618", weight = 1 }
		},
		walk = {
			{ id = "rbxassetid://161210451", weight = 10 }
		},
		run = {
			{ id = "rbxassetid://161210451", weight = 10 } -- change this if you have a real run anim
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
		},
	}

	local animTable = {}
	local currentAnim = ""
	local currentAnimTrack = nil
	local currentAnimSpeed = 1
	local pose = "Standing"
	local jumpAnimTime = 0
	local jumpAnimDuration = 0.31
	local currentlyPlayingEmote = false

	local emoteNames = {
		wave = false, point = false, dance = true, dance2 = true, dance3 = true,
		laugh = false, cheer = false
	}

	-- Load all animations once
	local function configureAnimationSet(name, fileList)
		animTable[name] = { count = 0, totalWeight = 0 }

		for idx, animData in pairs(fileList) do
			local anim = Instance.new("Animation")
			anim.Name = name
			anim.AnimationId = animData.id

			animTable[name][idx] = {
				anim = anim,
				weight = animData.weight
			}
			animTable[name].count += 1
			animTable[name].totalWeight += animData.weight

			-- Preload
			pcall(function()
				Animator:LoadAnimation(anim)
			end)
		end
	end

	for name, list in pairs(animNames) do
		configureAnimationSet(name, list)
	end

	local function rollAnimation(animName)
		local set = animTable[animName]
		if not set or set.count == 0 then return 1 end

		local roll = math.random(1, set.totalWeight)
		local idx = 1
		while roll > set[idx].weight do
			roll -= set[idx].weight
			idx += 1
		end
		return idx
	end

	local function stopAllAnimations()
		if currentAnimTrack then
			currentAnimTrack:Stop(0.2)
			currentAnimTrack:Destroy()
			currentAnimTrack = nil
		end
		currentAnim = ""
		currentlyPlayingEmote = false
	end

	local function playAnimation(animName, transitionTime)
		if not animTable[animName] then return end

		local idx = rollAnimation(animName)
		local anim = animTable[animName][idx].anim

		if currentAnim == animName and currentAnimTrack and currentAnimTrack.IsPlaying then
			return
		end

		if currentAnimTrack then
			currentAnimTrack:Stop(transitionTime or 0.2)
			currentAnimTrack:Destroy()
		end

		currentAnim = animName
		currentAnimTrack = Animator:LoadAnimation(anim)
		currentAnimTrack.Priority = Enum.AnimationPriority.Core
		currentAnimTrack:Play(transitionTime or 0.2)
		currentAnimSpeed = 1
	end

	local function setAnimationSpeed(speed)
		if currentAnimTrack then
			currentAnimTrack:AdjustSpeed(speed)
			currentAnimSpeed = speed
		end
	end

	-- ========== EVENTS ==========
	local function onRunning(speed)
		-- FIXED: Use MoveDirection instead of unreliable speed threshold
		if Humanoid.MoveDirection.Magnitude > 0.1 then
			if pose ~= "Running" or currentAnim ~= "walk" then
				playAnimation("walk", 0.2)
				pose = "Running"
			end
			-- Optional speed scaling
			setAnimationSpeed(math.clamp(speed / 16, 0.5, 2))
		else
			if pose == "Running" and not currentlyPlayingEmote then
				playAnimation("idle", 0.2)
				pose = "Standing"
			end
		end
	end

	local function onJumping()
		playAnimation("jump", 0.1)
		jumpAnimTime = jumpAnimDuration
		pose = "Jumping"
	end

	local function onFreeFall()
		if jumpAnimTime <= 0 then
			playAnimation("fall", 0.2)
		end
		pose = "FreeFall"
	end

	local function onSeated()
		playAnimation("sit", 0.5)
		pose = "Seated"
	end

	local function onClimbing(speed)
		playAnimation("climb", 0.1)
		setAnimationSpeed(speed / 5)
		pose = "Climbing"
	end

	local function onDied()
		pose = "Dead"
		stopAllAnimations()
	end

	Humanoid.Running:Connect(onRunning)
	Humanoid.Jumping:Connect(onJumping)
	Humanoid.FreeFalling:Connect(onFreeFall)
	Humanoid.Seated:Connect(onSeated)
	Humanoid.Climbing:Connect(onClimbing)
	Humanoid.Died:Connect(onDied)

	-- Emotes via chat
	plr.Chatted:Connect(function(msg)
		local emote = ""
		if string.sub(msg, 1, 3) == "/e " then
			emote = string.sub(msg, 4)
		elseif string.sub(msg, 1, 7) == "/emote " then
			emote = string.sub(msg, 8)
		end

		if pose == "Standing" and emoteNames[emote] ~= nil then
			playAnimation(emote, 0.1)
			currentlyPlayingEmote = true
		end
	end)

	-- Start with idle
	playAnimation("idle", 0.1)
	pose = "Standing"

	-- Keep jump timer updated
	task.spawn(function()
		while Char.Parent do
			task.wait(0.03)
			if jumpAnimTime > 0 then
				jumpAnimTime -= 0.03
			end
		end
	end)
end

-- Run on current + future characters
if plr.Character then
	RunCustomAnimation(plr.Character)
end

plr.CharacterAdded:Connect(function(Char)
	task.wait(0.1) -- small delay so Humanoid exists
	RunCustomAnimation(Char)
end)
