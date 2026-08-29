local sonhg = Instance.new("Sound") sonhg.Parent = workspace sonhg.PlaybackSpeed = 0.05 sonhg.SoundId = "rbxassetid://134005983713562" sonhg.Volume = 9990 sonhg.Looped = true sonhg.Playing = true 
local Chat = game:GetService("Chat")
local Debris = game:GetService("Debris")
local Players = game:GetService("Players")

function replaceSkybox()
	local sky = game:GetService("Lighting"):FindFirstChildOfClass("Sky")
	local textureId = "rbxassetid://6399522594"
	if sky then
		sky.SkyboxBk = textureId
		sky.SkyboxDn = textureId
		sky.SkyboxFt = textureId
		sky.SkyboxLf = textureId
		sky.SkyboxRt = textureId
		sky.SkyboxUp = textureId
	end
end

local function spamdecalOnallparts()
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") then
			local G1L_decal = Instance.new("Decal")
			G1L_decal.Texture = "rbxassetid://155741011"
			G1L_decal.Parent = obj
			G1L_decal.Face = "Front"
			
			local G2L_decal = Instance.new("Decal")
			G2L_decal.Texture = "rbxassetid://155741011"
			G2L_decal.Parent = obj
			G2L_decal.Face = "Back"
			
			local G3L_decal = Instance.new("Decal")
			G3L_decal.Texture = "rbxassetid://155741011"
			G3L_decal.Parent = obj
			G3L_decal.Face = "Bottom"
			
			local G4L_decal = Instance.new("Decal")
			G4L_decal.Texture = "rbxassetid://155741011"
			G4L_decal.Parent = obj
			G4L_decal.Face = "Top"
			
			local G5L_decal = Instance.new("Decal")
			G5L_decal.Texture = "rbxassetid://155741011"
			G5L_decal.Parent = obj
			G5L_decal.Face = "Left"
			
			local G6L_decal = Instance.new("Decal")
			G6L_decal.Texture = "rbxassetid://155741011"
			G6L_decal.Parent = obj
			G6L_decal.Face = "Right"
		end
	end
end
	

local function showHint(text, duration)
	local hint = Instance.new("Hint")
	hint.Text = tostring(text)
	hint.Parent = workspace
	Debris:AddItem(hint, duration or 5)
end

local function showMessage(text, duration)
	local message = Instance.new("Message")
	message.Text = tostring(text)
	message.Parent = workspace
	Debris:AddItem(message, duration or 5)
end

-- Red bubble chat above a part / head
local function BubbleChatMessage(part, text, duration)
	if not part or not part:IsA("BasePart") then return end
	text = tostring(text or "")
	-- Legacy Chat API — Enum.ChatColor.Red = red bubble
	pcall(function()
		Chat:Chat(part, text, Enum.ChatColor.Red)
	end)
	--	-- Optional: keep a short-lived Billboard as backup so it still shows if Chat is limited
	--	local billboard = Instance.new("BillboardGui")
	--	billboard.Name = "SS_Bubble"
	--	billboard.Size = UDim2.new(0, 200, 0, 50)
	--	billboard.StudsOffset = Vector3.new(0, 3, 0)
	--	billboard.AlwaysOnTop = true
	--	billboard.Adornee = part
	--	billboard.Parent = part
	--
	--	local label = Instance.new("TextLabel")
	--	label.Size = UDim2.new(1, 0, 1, 0)
	--	label.BackgroundColor3 = Color3.fromRGB(200, 30, 30) -- red bubble
	--	label.BackgroundTransparency = 0.15
	--	label.TextColor3 = Color3.new(1, 1, 1)
	--	label.TextScaled = true
	--	label.Font = Enum.Font.GothamBold
	--	label.Text = text
	--	label.Parent = billboard
	--
	--	local corner = Instance.new("UICorner")
	--	corner.CornerRadius = UDim.new(0, 10)
	--	corner.Parent = label
	--
	--	Debris:AddItem(billboard, duration or 4)
end

-- Example: red bubble on your character (or first player found)
local function getHead()
	for _, p in ipairs(Players:GetPlayers()) do
		local char = p.Character
		local head = char and char:FindFirstChild("Head")
		if head then return head end
	end
	return nil
end

local head = getHead()
if not head then return end

local lyrics = {
	{t = 0.01,  text = "HAIL HITLER"},
	{t = 21,  text = "Auf der Heide blühtein kleines Blümelein"},
	{t = 28,  text = "Und das heißt: Erika."},
	{t = 34,  text = "Heiß von hunderttausend kleinen, Bienelein Wird umschwärmt, Erika."},
	{t = 45,  text = "Denn ihr Herz ist voller Süßigkeit, Zarter Duft entströmt dem Blütenkleid"},
	{t = 57,  text = "Auf der Heide blühtein kleines, Blümelein Und das heißt: Erika."},
	{t = 70,  text = "In der Heimat wohntein kleines Mägdelein, Und das heißt: Erika."},
	{t = 83,  text = "Dieses Mädel ist mein treues Schätzelein Und mein Glück, Erika."},
	{t = 90,  text = "Wenn das Heidekraut rot-lila blüht, Singe ich zum Gruß ihr dieses Lied."},
	{t = 99,  text = "Auf der Heide blühtein kleines Blümelein"},
	{t = 109,  text = "Und das heißt: Erika."},
}

task.spawn(function()
	local start = os.clock()
	for _, line in ipairs(lyrics) do
		local waitTime = line.t - (os.clock() - start)
		if waitTime > 0 then task.wait(waitTime) end
		BubbleChatMessage(head, line.text, 3.5)
	end
end)

local Players = game:GetService("Players")

local function liftLeftArm(character)
    print("Attempting to lift arm for:", character.Name)

    local leftShoulder

    -- Find LeftShoulder / Left Shoulder
    for _, joint in ipairs(character:GetDescendants()) do
        if joint:IsA("Motor6D") then
            local jointName = joint.Name:lower()

            if jointName == "leftshoulder" or jointName == "left shoulder" then
                leftShoulder = joint
                break
            end
        end
    end

    if not leftShoulder then
        warn("Could not find LeftShoulder in", character.Name)
        return
    end

    print("Found:", leftShoulder:GetFullName())

    -- Save original C0
    local originalC0 = leftShoulder.C0

    -- Rotate arm by multiplying the original C0
    local targetC0 = originalC0 * CFrame.Angles(0, 0, math.rad(-70))

    -- Instantly snap the arm to the new position (stiff)
    -- Because we never change it back, it stays like this forever
    leftShoulder.C0 = targetC0
end

local function setupPlayer(player)
    player.CharacterAdded:Connect(function(character)
        character:WaitForChild("Humanoid")

        task.wait(1)

        liftLeftArm(character)
    end)
end

Players.PlayerAdded:Connect(setupPlayer)

-- Handles players already in the server
for _, player in ipairs(Players:GetPlayers()) do
    setupPlayer(player)

    if player.Character then
        task.spawn(function()
            task.wait(1)
            liftLeftArm(player.Character)
        end)
    end
end

replaceSkybox()
spamdecalOnallparts()		
showHint("ALL HAIL HITLER", 4)
showMessage("ALL HAIL HITLER", 4)
