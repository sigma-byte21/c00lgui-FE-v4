function waitForChild(parent, childName)
	local child = parent:findFirstChild(childName)
	if child then return child end
	while true do
		child = parent.ChildAdded:wait()
		if child.Name==childName then return child end
	end
end

local Figure = script.Parent
local Humanoid = waitForChild(Figure, "Humanoid")
local isR15 = Humanoid.RigType == Enum.HumanoidRigType.R15

-- Only look for R6 joints if the character is actually R6
local Torso, RightShoulder, LeftShoulder, RightHip, LeftHip, Neck
if not isR15 then
	Torso = waitForChild(Figure, "Torso")
	RightShoulder = waitForChild(Torso, "Right Shoulder")
	LeftShoulder = waitForChild(Torso, "Left Shoulder")
	RightHip = waitForChild(Torso, "Right Hip")
	LeftHip = waitForChild(Torso, "Left Hip")
	Neck = waitForChild(Torso, "Neck")
end

local pose = "Standing"

local currentAnim = ""
local currentAnimTrack = nil
local currentAnimKeyframeHandler = nil
local currentAnimSpeed = 1.0
local oldAnimTrack = nil
local animTable = {}

-- Dual Animation Tables based on RigType
local animNames = {}

if isR15 then
	-- Use R15 "Old School" Animation IDs to mimic the stiff R6 look
	animNames = { 
		idle = 	{	
					{ id = "rbxassetid://507766388", weight = 9 },
					{ id = "rbxassetid://507766951", weight = 1 }
				},
		walk = 	{ 	
					{ id = "rbxassetid://507777826", weight = 10 } 
				}, 
		run = 	{
					{ id = "rbxassetid://507767714", weight = 10 } 
				}, 
		jump = 	{
					{ id = "rbxassetid://507765000", weight = 10 } 
				}, 
		fall = 	{
					{ id = "rbxassetid://507767968", weight = 10 } 
				}, 
		climb = {
					{ id = "rbxassetid://507765644", weight = 10 } 
				}, 
		sit = { -- Added for R15 Seating
					{ id = "rbxassetid://2506281703", weight = 10 } 
				},
		toolnone = {
					{ id = "rbxassetid://507768375", weight = 10 } 
				},
		toolslash = {
					{ id = "rbxassetid://522635514", weight = 10 } 
				},
		toollunge = {
					{ id = "rbxassetid://522638767", weight = 10 } 
				},
		wave = {
					{ id = "rbxassetid://507770239", weight = 10 } 
				},
		point = {
					{ id = "rbxassetid://507770453", weight = 10 } 
				},
		dance = {
					{ id = "rbxassetid://507771019", weight = 10 }, 
					{ id = "rbxassetid://507771019", weight = 10 }, 
					{ id = "rbxassetid://507771019", weight = 10 } 
				},
		laugh = {
					{ id = "rbxassetid://507770818", weight = 10 } 
				},
		cheer = {
					{ id = "rbxassetid://507770677", weight = 10 } 
				}
	}
else
	-- Your original R6 Animation IDs
	animNames = { 
		idle = 	{	
					{ id = "rbxassetid://161100084", weight = 9 },
					{ id = "rbxassetid://125750618", weight = 1 }
				},
		walk = 	{ 	
					{ id = "rbxassetid://161210451", weight = 10 } 
				}, 
		run = 	{
					{ id = "run.xml", weight = 10 } 
				}, 
		jump = 	{
					{ id = "rbxassetid://165167557", weight = 10 } 
				}, 
		fall = 	{
					{ id = "rbxassetid://165167632", weight = 10 } 
				}, 
		climb = {
					{ id = "rbxassetid://161235826", weight = 10 } 
				}, 
		toolnone = {
					{ id = "rbxassetid://125750867", weight = 10 } 
				},
		toolslash = {
					{ id = "rbxassetid://129967390", weight = 10 } 
	--				{ id = "slash.xml", weight = 10 } 
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
		laugh = {
					{ id = "rbxassetid://129423131", weight = 10 } 
				},
		cheer = {
					{ id = "rbxassetid://=129423030", weight = 10 } 
				}
	}
end

-- Existance in this list signifies that it is an emote, the value indicates if it is a looping emote
local emoteNames = { wave = false, point = false, dance = true, laugh = false, cheer = false}

math.randomseed(tick())

-- Setup animation objects
for name, fileList in pairs(animNames) do 
	animTable[name] = {}
	animTable[name].count = 0
	animTable[name].totalWeight = 0

	-- check for config values
	local config = script:FindFirstChild(name)
	if (config ~= nil) then
		local idx = 1
		for _, childPart in pairs(config:GetChildren()) do
			animTable[name][idx] = {}
			animTable[name][idx].anim = childPart
			local weightObject = childPart:FindFirstChild("Weight")
			if (weightObject == nil) then
				animTable[name][idx].weight = 1
			else
				animTable[name][idx].weight = weightObject.Value
			end
			animTable[name].count = animTable[name].count + 1
			animTable[name].totalWeight = animTable[name].totalWeight + animTable[name][idx].weight
			idx = idx + 1
		end
	end

	-- fallback to defaults
	if (animTable[name].count <= 0) then
		for idx, anim in pairs(fileList) do
			animTable[name][idx] = {}
			animTable[name][idx].anim = Instance.new("Animation")
			animTable[name][idx].anim.Name = name
			animTable[name][idx].anim.AnimationId = anim.id
			animTable[name][idx].weight = anim.weight
			animTable[name].count = animTable[name].count + 1
			animTable[name].totalWeight = animTable[name].totalWeight + anim.weight
		end
	end
end

-- ANIMATION
local toolAnim = "None"
local toolAnimTime = 0

local jumpAnimTime = 0
local jumpAnimDuration = 0.175

local toolTransitionTime = 0.1
local fallTransitionTime = 0.2
local jumpMaxLimbVelocity = 0.75

function stopAllAnimations()
	local oldAnim = currentAnim
	if (emoteNames[oldAnim] ~= nil and emoteNames[oldAnim] == false) then
		oldAnim = "idle"
	end

	currentAnim = ""
	if (currentAnimKeyframeHandler ~= nil) then
		currentAnimKeyframeHandler:disconnect()
	end

	if (oldAnimTrack ~= nil) then
		oldAnimTrack:Stop()
		oldAnimTrack:Destroy()
		oldAnimTrack = nil
	end
	if (currentAnimTrack ~= nil) then
		currentAnimTrack:Stop()
		currentAnimTrack:Destroy()
		currentAnimTrack = nil
	end
	return oldAnim
end

function setAnimationSpeed(speed)
	if speed ~= currentAnimSpeed then
		currentAnimSpeed = speed
		if currentAnimTrack then
			currentAnimTrack:AdjustSpeed(currentAnimSpeed)
		end
	end
end

function keyFrameReachedFunc(frameName)
	if (frameName == "End") then
		local repeatAnim = stopAllAnimations()
		local animSpeed = currentAnimSpeed
		playAnimation(repeatAnim, 0.0, Humanoid)
		setAnimationSpeed(animSpeed)
	end
end

function playAnimation(animName, transitionTime, humanoid)
	if (animName ~= currentAnim) then		 
		
		if (oldAnimTrack ~= nil) then
			oldAnimTrack:Stop()
			oldAnimTrack:Destroy()
		end

		currentAnimSpeed = 1.0
		local roll = math.random(1, animTable[animName].totalWeight) 
		local origRoll = roll
		local idx = 1
		while (roll > animTable[animName][idx].weight) do
			roll = roll - animTable[animName][idx].weight
			idx = idx + 1
		end

		local anim = animTable[animName][idx].anim

		oldAnimTrack = currentAnimTrack
		currentAnimTrack = humanoid:LoadAnimation(anim)
		 
		currentAnimTrack:Play(transitionTime)
		currentAnim = animName

		if (currentAnimKeyframeHandler ~= nil) then
			currentAnimKeyframeHandler:disconnect()
		end
		currentAnimKeyframeHandler = currentAnimTrack.KeyframeReached:connect(keyFrameReachedFunc)
	end
end

local toolAnimName = ""
local toolOldAnimTrack = nil
local toolAnimTrack = nil
local currentToolAnimKeyframeHandler = nil

function toolKeyFrameReachedFunc(frameName)
	if (frameName == "End") then
		local repeatAnim = stopToolAnimations()
		playToolAnimation(repeatAnim, 0.0, Humanoid)
	end
end


function playToolAnimation(animName, transitionTime, humanoid)
	if (animName ~= toolAnimName) then		 
		
		if (toolAnimTrack ~= nil) then
			toolAnimTrack:Stop()
			toolAnimTrack:Destroy()
			transitionTime = 0
		end

		local roll = math.random(1, animTable[animName].totalWeight) 
		local origRoll = roll
		local idx = 1
		while (roll > animTable[animName][idx].weight) do
			roll = roll - animTable[animName][idx].weight
			idx = idx + 1
		end

		local anim = animTable[animName][idx].anim

		toolOldAnimTrack = toolAnimTrack
		toolAnimTrack = humanoid:LoadAnimation(anim)
		 
		toolAnimTrack:Play(transitionTime)
		toolAnimName = animName

		currentToolAnimKeyframeHandler = toolAnimTrack.KeyframeReached:connect(toolKeyFrameReachedFunc)
	end
end

function stopToolAnimations()
	local oldAnim = toolAnimName

	if (currentToolAnimKeyframeHandler ~= nil) then
		currentToolAnimKeyframeHandler:disconnect()
	end

	toolAnimName = ""
	if (toolAnimTrack ~= nil) then
		toolAnimTrack:Stop()
		toolAnimTrack:Destroy()
		toolAnimTrack = nil
	end

	return oldAnim
end

function onRunning(speed)
	if speed>0 then
		playAnimation("walk", 0.1, Humanoid)
		pose = "Running"
	else
		playAnimation("idle", 0.1, Humanoid)
		pose = "Standing"
	end
end

function onDied()
	pose = "Dead"
end

function onJumping()
	playAnimation("jump", 0.1, Humanoid)
	jumpAnimTime = jumpAnimDuration
	pose = "Jumping"
end

function onClimbing(speed)
	playAnimation("climb", 0.1, Humanoid)
	setAnimationSpeed(speed / 12.0)
	pose = "Climbing"
end

function onGettingUp()
	pose = "GettingUp"
end

function onFreeFall()
	if (jumpAnimTime <= 0) then
		playAnimation("fall", fallTransitionTime, Humanoid)
	end
	pose = "FreeFall"
end

function onFallingDown()
	pose = "FallingDown"
end

function onSeated()
	pose = "Seated"
	if isR15 then
		-- R15 uses a proper track for seating, no joint math needed
		playAnimation("sit", 0.1, Humanoid)
	end
end

function onPlatformStanding()
	pose = "PlatformStanding"
end

function onSwimming(speed)
	if speed>0 then
		pose = "Running"
	else
		pose = "Standing"
	end
end

function getTool()	
	for _, kid in ipairs(Figure:GetChildren()) do
		if kid.className == "Tool" then return kid end
	end
	return nil
end

function getToolAnim(tool)
	for _, c in ipairs(tool:GetChildren()) do
		if c.Name == "toolanim" and c.className == "StringValue" then
			return c
		end
	end
	return nil
end

function animateTool()
	if (toolAnim == "None") then
		playToolAnimation("toolnone", toolTransitionTime, Humanoid)
		return
	end

	if (toolAnim == "Slash") then
		playToolAnimation("toolslash", 0, Humanoid)
		return
	end

	if (toolAnim == "Lunge") then
		playToolAnimation("toollunge", 0, Humanoid)
		return
	end
end

function moveSit()
	if isR15 then return end -- Failsafe
	RightShoulder.MaxVelocity = 0.15
	LeftShoulder.MaxVelocity = 0.15
	RightShoulder:SetDesiredAngle(3.14 /2)
	LeftShoulder:SetDesiredAngle(-3.14 /2)
	RightHip:SetDesiredAngle(3.14 /2)
	LeftHip:SetDesiredAngle(-3.14 /2)
end

local lastTick = 0

function move(time)
	local amplitude = 1
	local frequency = 1
  	local deltaTime = time - lastTick
  	lastTick = time

	local climbFudge = 0
	local setAngles = false

  	if (jumpAnimTime > 0) then
  		jumpAnimTime = jumpAnimTime - deltaTime
  	end

	if (pose == "FreeFall" and jumpAnimTime <= 0) then
		playAnimation("fall", fallTransitionTime, Humanoid)
	elseif (pose == "Seated") then
		if not isR15 then
			stopAllAnimations()
			moveSit()
		end
		return
	elseif (pose == "Running") then
		playAnimation("walk", 0.1, Humanoid)
	elseif (pose == "Dead" or pose == "GettingUp" or pose == "FallingDown" or pose == "Seated" or pose == "PlatformStanding") then
		amplitude = 0.1
		frequency = 1
		setAngles = true
	end

	-- Only run the old motor angle math if it's an R6 character
	if (setAngles and not isR15) then
		desiredAngle = amplitude * math.sin(time * frequency)

		RightShoulder:SetDesiredAngle(desiredAngle + climbFudge)
		LeftShoulder:SetDesiredAngle(desiredAngle - climbFudge)
		RightHip:SetDesiredAngle(-desiredAngle)
		LeftHip:SetDesiredAngle(-desiredAngle)
	end

	-- Tool Animation handling
	local tool = getTool()
	if tool then
		local animStringValueObject = getToolAnim(tool)

		if animStringValueObject then
			toolAnim = animStringValueObject.Value
			animStringValueObject.Parent = nil
			toolAnimTime = time + .3
		end

		if time > toolAnimTime then
			toolAnimTime = 0
			toolAnim = "None"
		end

		animateTool()		
	else
		stopToolAnimations()
		toolAnim = "None"
		toolAnimTime = 0
	end
end

Humanoid.Died:connect(onDied)
Humanoid.Running:connect(onRunning)
Humanoid.Jumping:connect(onJumping)
Humanoid.Climbing:connect(onClimbing)
Humanoid.GettingUp:connect(onGettingUp)
Humanoid.FreeFalling:connect(onFreeFall)
Humanoid.FallingDown:connect(onFallingDown)
Humanoid.Seated:connect(onSeated)
Humanoid.PlatformStanding:connect(onPlatformStanding)
Humanoid.Swimming:connect(onSwimming)

Game.Players.LocalPlayer.Chatted:connect(function(msg)
	local emote = ""
	if (string.sub(msg, 1, 3) == "/e ") then
		emote = string.sub(msg, 4)
	elseif (string.sub(msg, 1, 7) == "/emote ") then
		emote = string.sub(msg, 8)
	end
	
	if (pose == "Standing" and emoteNames[emote] ~= nil) then
		playAnimation(emote, 0.1, Humanoid)
	end
end)

local runService = game:service("RunService");

playAnimation("idle", 0.1, Humanoid)
pose = "Standing"

while Figure.Parent~=nil do
	local _, time = wait(0.1)
	move(time)
end
