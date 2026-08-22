--[[
    Title: c00lkidd GUI v4 (Revamped & Persistent)
    Theme: Team C00LKIDD!
    Features: Combat, Chaos, UI Window Controls, Anti-Respawn Destruction
]]
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
-- UI Constants (Hacker Theme: Dark with Neon Green)
local BACKGROUND_COLOR = Color3.fromRGB(5, 5, 5)
local BORDER_COLOR = Color3.fromRGB(0, 255, 0)
local TEXT_COLOR = Color3.fromRGB(0, 255, 0)
local ACCENT_COLOR = Color3.fromRGB(0, 100, 0)
local GLOW_TRANSPARENCY = 0.5
local HOVER_COLOR = Color3.fromRGB(0, 150, 0)
-- Create the GUI
local gui = Instance.new("ScreenGui")
gui.Name = "C00lkiddGUI_Persistent"
gui.ResetOnSpawn = false -- CRITICAL: Keeps UI active after death
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
-- Main Frame
local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 380, 0, 500) -- Slightly larger for better layout
frame.Position = UDim2.new(0.5, -190, 0.5, -250)
frame.BackgroundColor3 = BACKGROUND_COLOR
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.Visible = false
frame.Active = true -- For dragging
frame.Parent = gui
local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 12)
frameCorner.Parent = frame
local frameStroke = Instance.new("UIStroke")
frameStroke.Color = BORDER_COLOR
frameStroke.Transparency = GLOW_TRANSPARENCY
frameStroke.Thickness = 1.5
frameStroke.Parent = frame
-- Header / Drag Bar with Gradient
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 45)
header.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
header.BorderSizePixel = 0
header.Parent = frame
local headerGradient = Instance.new("UIGradient")
headerGradient.Color = ColorSequence.new(BACKGROUND_COLOR, ACCENT_COLOR)
headerGradient.Rotation = 90
headerGradient.Parent = header
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -120, 1, 0)
titleLabel.Position = UDim2.new(0, 15, 0, 0)
titleLabel.Text = "c00lkidd GUI v4 // TEAM C00LKIDD"
titleLabel.TextColor3 = TEXT_COLOR
titleLabel.Font = Enum.Font.Code
titleLabel.TextSize = 18 -- Larger for cool factor
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.BackgroundTransparency = 1
titleLabel.Parent = header
-- Window Controls Container
local controls = Instance.new("Frame")
controls.Size = UDim2.new(0, 100, 1, 0)
controls.Position = UDim2.new(1, -105, 0, 0)
controls.BackgroundTransparency = 1
controls.Parent = header
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "Close"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0.5, -15)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0) -- Darker red
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.Code
closeBtn.Parent = controls
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)
local closeStroke = Instance.new("UIStroke")
closeStroke.Color = Color3.fromRGB(255, 0, 0)
closeStroke.Transparency = GLOW_TRANSPARENCY
closeStroke.Parent = closeBtn
local collapseBtn = Instance.new("TextButton")
collapseBtn.Name = "Collapse"
collapseBtn.Size = UDim2.new(0, 30, 0, 30)
collapseBtn.Position = UDim2.new(1, -70, 0.5, -15)
collapseBtn.Text = "-"
collapseBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
collapseBtn.TextColor3 = TEXT_COLOR
collapseBtn.Font = Enum.Font.Code
collapseBtn.Parent = controls
Instance.new("UICorner", collapseBtn).CornerRadius = UDim.new(0, 6)
local collapseStroke = Instance.new("UIStroke")
collapseStroke.Color = BORDER_COLOR
collapseStroke.Transparency = GLOW_TRANSPARENCY
collapseStroke.Parent = collapseBtn
-- Navigation Bar with Gradient
local nav = Instance.new("Frame")
nav.Size = UDim2.new(1, 0, 0, 35)
nav.Position = UDim2.new(0, 0, 0, 45)
nav.BackgroundColor3 = ACCENT_COLOR
nav.BorderSizePixel = 0
nav.Parent = frame
local navGradient = Instance.new("UIGradient")
navGradient.Color = ColorSequence.new(ACCENT_COLOR, BACKGROUND_COLOR)
navGradient.Rotation = 180
navGradient.Parent = nav
local pageDisplay = Instance.new("TextLabel")
pageDisplay.Size = UDim2.new(1, 0, 1, 0)
pageDisplay.Text = "PAGE: Scripts" -- Fixed initial text
pageDisplay.TextColor3 = TEXT_COLOR
pageDisplay.Font = Enum.Font.Code
pageDisplay.TextSize = 14
pageDisplay.BackgroundTransparency = 1
pageDisplay.Parent = nav
local nextBtn = Instance.new("TextButton")
nextBtn.Size = UDim2.new(0, 40, 1, 0)
nextBtn.Position = UDim2.new(1, -40, 0, 0)
nextBtn.Text = ">"
nextBtn.TextColor3 = TEXT_COLOR
nextBtn.BackgroundTransparency = 1
nextBtn.Font = Enum.Font.Code
nextBtn.TextSize = 20
nextBtn.Parent = nav
local prevBtn = Instance.new("TextButton")
prevBtn.Size = UDim2.new(0, 40, 1, 0)
prevBtn.Position = UDim2.new(0, 0, 0, 0)
prevBtn.Text = "<"
prevBtn.TextColor3 = TEXT_COLOR
prevBtn.BackgroundTransparency = 1
prevBtn.Font = Enum.Font.Code
prevBtn.TextSize = 20
prevBtn.Parent = nav
-- Content Area
local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1, -20, 1, -160)
content.Position = UDim2.new(0, 10, 0, 90)
content.BackgroundTransparency = 1
content.BorderSizePixel = 0
content.ScrollBarThickness = 4
content.ScrollBarImageColor3 = BORDER_COLOR
content.Parent = frame
local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 10) -- More spacing for cool look
listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
listLayout.Parent = content
-- Message Log (with Gradient Background)
local logFrame = Instance.new("ScrollingFrame")
logFrame.Size = UDim2.new(1, -20, 0, 80) -- Taller for more logs
logFrame.Position = UDim2.new(0, 10, 1, -90)
logFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
logFrame.BorderSizePixel = 0
logFrame.ScrollBarThickness = 2
logFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
logFrame.Parent = frame
local logGradient = Instance.new("UIGradient")
logGradient.Color = ColorSequence.new(BACKGROUND_COLOR, Color3.fromRGB(0, 50, 0))
logGradient.Rotation = 90
logGradient.Parent = logFrame
local logStroke = Instance.new("UIStroke")
logStroke.Color = BORDER_COLOR
logStroke.Transparency = GLOW_TRANSPARENCY
logStroke.Parent = logFrame
local logLayout = Instance.new("UIListLayout")
logLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
logLayout.Parent = logFrame
-- Open Toggle Button (with Glow)
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0, 140, 0, 45) -- Wider
openBtn.Position = UDim2.new(0, 20, 1, -60)
openBtn.BackgroundColor3 = BACKGROUND_COLOR
openBtn.BorderSizePixel = 0
openBtn.Text = "JOIN C00LKIDD"
openBtn.TextColor3 = TEXT_COLOR
openBtn.Font = Enum.Font.Code
openBtn.TextSize = 16
openBtn.Parent = gui
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(0, 8)
local openStroke = Instance.new("UIStroke")
openStroke.Color = BORDER_COLOR
openStroke.Transparency = GLOW_TRANSPARENCY
openStroke.Parent = openBtn
-- Sound
local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://9118823106"
sound.Looped = true
sound.Volume = 0.5
sound.Parent = gui
-- wait for the main frame
local frame = gui:WaitForChild("MainFrame")

-- Binary Rain Container
local rainContainer = Instance.new("Frame")
rainContainer.Size = UDim2.new(1, 0, 1, 0)
rainContainer.BackgroundTransparency = 1
rainContainer.ClipsDescendants = true
rainContainer.ZIndex = 11
rainContainer.Parent = frame

-- Function to generate a vertical binary string (stacked 0s and 1s)
local function createBinaryStack()
    local stackContainer = Instance.new("Frame")
    stackContainer.BackgroundTransparency = 1
    stackContainer.Size = UDim2.new(0, 20, 0, 150) -- Vertical space for the stack
    stackContainer.Parent = rainContainer
    
    local stackLength = math.random(4, 7)
    local labels = {}
    
    -- Create the vertical stack
    for i = 1, stackLength do
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 0, 18)
        label.Position = UDim2.new(0, 0, 0, (i-1) * 16)
        label.BackgroundTransparency = 1
        label.Font = Enum.Font.Code
        label.TextSize = 18
        label.ZIndex = 12
        
        -- Gradient Logic: Bottom (newest) is brightest, Top (tail) is faded
        local opacity = (i / stackLength) * 0.8
        label.TextColor3 = Color3.fromRGB(0, 255 * opacity, 0)
        label.TextTransparency = 1 - opacity
        
        label.Parent = stackContainer
        table.insert(labels, label)
    end
    
    return stackContainer, labels
end

local function runRainSystem()
    task.spawn(function()
        -- Wait for frame visibility (button state check)
        while true do
            if not frame or not frame.Parent then return end
            if frame.Visible then break end
            task.wait(0.5)
        end

        while true do
            if not frame or not frame.Parent then break end
            
            if frame.Visible then
                local stack, labels = createBinaryStack()
                local startPos = UDim2.new(math.random(), 0, -0.2, 0)
                local endPos = UDim2.new(startPos.X.Scale, 0, 1.1, 0)
                
                stack.Position = startPos
                
                -- Dynamic Transformation Loop (Jumbling numbers)
                task.spawn(function()
                    while stack and stack.Parent do
                        for _, label in ipairs(labels) do
                            label.Text = tostring(math.random(0, 1))
                        end
                        task.wait(0.1)
                    end
                end)
                
                -- Falling Motion
                local fallTime = math.random(2, 5)
                local fallTween = TweenService:Create(stack, TweenInfo.new(fallTime, Enum.EasingStyle.Linear), {
                    Position = endPos
                })
                
                -- Fade out when nearing the bottom
                task.delay(fallTime * 0.7, function()
                    if stack and stack.Parent then
                        for _, label in ipairs(labels) do
                            TweenService:Create(label, TweenInfo.new(fallTime * 0.3), {TextTransparency = 1}):Play()
                        end
                    end
                end)
                
                fallTween:Play()
                fallTween.Completed:Connect(function() stack:Destroy() end)
                
                task.wait(math.random(15, 30) / 100) -- Variation in spawn frequency
            else
                task.wait(0.5)
            end
        end
    end)
end

-- CRT Scanline Overlay
local scanline = Instance.new("Frame")
scanline.Size = UDim2.new(1, 0, 0, 2)
scanline.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
scanline.BackgroundTransparency = 0.7
scanline.ZIndex = 13
scanline.Parent = frame

task.spawn(function()
    while true do
        if not frame or not frame.Parent then return end
        if frame.Visible then break end
        task.wait(0.5)
    end

    while true do
        if not frame or not frame.Parent then break end
        if frame.Visible then
            scanline.Position = UDim2.new(0, 0, 0, 0)
            local t = TweenService:Create(scanline, TweenInfo.new(3, Enum.EasingStyle.Linear), {
                Position = UDim2.new(0, 0, 1, 0)
            })
            t:Play()
            t.Completed:Wait()
        else
            task.wait(0.5)
        end
    end
end)

runRainSystem()
-------------------------------------------------------
                     -- Logic & State
-------------------------------------------------------
local pages = {"FE_Scripts", "f3x_Chaos", "FE_2"}
local currentPageIndex = 1
local isCollapsed = false
local activeButtons = {}
-- Universal log system (unchanged, already cool)
local function addLog(text, style)
    local logLabel = Instance.new("TextLabel")
    logLabel.Size = UDim2.new(1, -5, 0, 18)
    logLabel.BackgroundTransparency = 1
    logLabel.Font = Enum.Font.Code
    logLabel.TextSize = 14
    logLabel.TextXAlignment = Enum.TextXAlignment.Left
    logLabel.RichText = true
    logLabel.Parent = logFrame
    if style == "cursed" then
        local originalText = text
        task.spawn(function()
            local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*"
            while logLabel.Parent do
                local glitch = ""
                for i = 1, #originalText do
                    local r = math.random(1, #chars)
                    glitch = glitch .. chars:sub(r, r)
                end
                logLabel.Text = ">> <font color='#00FF00'>§k</font>" .. glitch
                task.wait(0.05)
            end
        end)
    elseif style == "rainbow" then
        task.spawn(function()
            while logLabel.Parent do
                local hue = tick() % 3 / 3
                logLabel.TextColor3 = Color3.fromHSV(hue, 0.8, 1)
                logLabel.Text = ">> [CHROMA] " .. text
                task.wait(0.01)
            end
        end)
    elseif style == "typewriter" then
        logLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
        task.spawn(function()
            for i = 1, #text do
                logLabel.Text = ">> " .. text:sub(1, i) .. "_"
                task.wait(0.03)
            end
            logLabel.Text = ">> " .. text
        end)
    elseif style == "critical" then
        logLabel.Text = ">> [!] CRITICAL: " .. text:upper()
        task.spawn(function()
            while logLabel.Parent do
                local pulse = (math.sin(tick() * 5) + 1) / 2
                logLabel.TextColor3 = Color3.new(1, 0, 0):Lerp(Color3.new(0.4, 0, 0), pulse)
                task.wait(0.01)
            end
        end)
    elseif style == "hacker" then
        logLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
        logLabel.Text = "==[ " .. text .. " ]=="
    elseif style == "glitch" then
        task.spawn(function()
            while logLabel.Parent do
                logLabel.Position = UDim2.new(0, math.random(-2, 2), 0, 0)
                logLabel.TextColor3 = math.random() > 0.8 and Color3.new(1, 1, 1) or Color3.fromRGB(0, 255, 100)
                logLabel.Text = "ERR_ " .. text .. " [0x" .. string.format("%X", math.random(100, 999)) .. "]"
                task.wait(0.05)
            end
        end)
    elseif style == "rune" then
        local runes = {"ᛖ", "ᚠ", "ᚢ", "ᚦ", "ᚨ", "ᚱ", "ᚲ", "ᚷ", "ᚹ", "ᚺ", "ᚻ"}
        logLabel.TextColor3 = Color3.fromRGB(180, 100, 255)
        logLabel.Text = runes[math.random(1, #runes)] .. " " .. text .. " " .. runes[math.random(1, #runes)]
        logLabel.TextStrokeTransparency = 0.6
        logLabel.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
    elseif style == "cold" then
        logLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
        logLabel.Text = "❄ [FROST_OS] " .. text
        logLabel.TextTransparency = 0.3
    elseif style == "cyber" then
        logLabel.Text = "<font color='#FF00FF'>[CYBER]</font> <font color='#00FFFF'>" .. text .. "</font>"
        logLabel.TextColor3 = Color3.new(1, 1, 1)
    elseif style == "binary" then
        logLabel.TextColor3 = Color3.fromRGB(0, 150, 0)
        task.spawn(function()
            while logLabel.Parent do
                local b = ""
                for i = 1, 4 do b = b .. math.random(0, 1) end
                logLabel.Text = "{" .. b .. "} " .. text
                task.wait(0.1)
            end
        end)
    elseif style == "ghost" then
        logLabel.TextColor3 = Color3.new(0.8, 0.8, 0.8)
        logLabel.Text = ">> (GHOST) " .. text
        task.spawn(function()
            task.wait(2)
            for i = 0, 1, 0.1 do
                logLabel.TextTransparency = i
                task.wait(0.1)
            end
            logLabel:Destroy()
        end)
    else
        logLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
        logLabel.Text = ">> " .. text
    end
    if logLayout then
        logFrame.CanvasSize = UDim2.new(0, 0, 0, logLayout.AbsoluteContentSize.Y)
        logFrame.CanvasPosition = Vector2.new(0, logFrame.CanvasSize.Y.Offset)
    end
end


-- Button Creation with Hover Effects
local function createScriptButton(name, callback)
    if not content then return end
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 40) -- Taller buttons
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    btn.Text = name
    btn.TextColor3 = TEXT_COLOR
    btn.Font = Enum.Font.Code
    btn.TextSize = 16
    btn.Parent = content
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    local btnStroke = Instance.new("UIStroke")
    btnStroke.Color = BORDER_COLOR
    btnStroke.Transparency = GLOW_TRANSPARENCY
    btnStroke.Parent = btn
    -- Hover Effect
    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, tweenInfo, {BackgroundColor3 = HOVER_COLOR}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, tweenInfo, {BackgroundColor3 = Color3.fromRGB(20, 20, 20)}):Play()
    end)
    table.insert(activeButtons, btn)
    btn.MouseButton1Click:Connect(function()
        addLog("Executing: " .. name, "binary")
        local success, errorMessage = pcall(callback)
        if not success then
            addLog("Error executing " .. name .. ": " .. tostring(errorMessage), "critical")
        else
            addLog("Success: " .. name, "hacker")
        end
    end)
end
local function clearContent()
    for _, btn in pairs(activeButtons) do
        if typeof(btn) == "Instance" then
            btn:Destroy()
        end
    end
    activeButtons = {}
end
local scriptData = {
    FE_Scripts = {
        {"NDS Hub By Katers", function()
loadstring(game:HttpGet("https://rawscripts.net/raw/Natural-Disaster-Survival-Katers-NDS-Hub-19533"))()
        end},
        {"Invisible", function()
loadstring(game:HttpGet('https://pastebin.com/raw/3Rnd9rHf'))()
        end},
        {"Tool Reach Customizer", function()
-- Tool Reach Customizer Script (Persistent with UI Controls)
-- Place this in a LocalScript inside StarterGui or execute via executor.

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- UI Constants
local MAIN_COLOR = Color3.fromRGB(45, 45, 45)
local ACCENT_COLOR = Color3.fromRGB(0, 128, 255)
local TEXT_COLOR = Color3.fromRGB(255, 255, 255)

-- Create the GUI
local gui = Instance.new("ScreenGui")
gui.Name = "ToolCustomizerGui"
gui.ResetOnSpawn = false -- CRITICAL: Makes GUI persist after death
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Main Frame
local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 300, 0, 450)
frame.Position = UDim2.new(0.5, -150, 0.5, -225)
frame.BackgroundColor3 = MAIN_COLOR
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.Parent = gui

-- Rounded corners
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

-- Header / Drag Bar
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
header.BorderSizePixel = 0
header.Parent = frame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 8)
headerCorner.Parent = header

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -110, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.Text = "Tool Reach Pro"
title.TextColor3 = TEXT_COLOR
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.BackgroundTransparency = 1
title.Parent = header

-- Close Button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.TextColor3 = TEXT_COLOR
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = header
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 5)

-- Collapse Button
local collapseBtn = Instance.new("TextButton")
collapseBtn.Size = UDim2.new(0, 30, 0, 30)
collapseBtn.Position = UDim2.new(1, -70, 0, 5)
collapseBtn.Text = "-"
collapseBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
collapseBtn.TextColor3 = TEXT_COLOR
collapseBtn.Font = Enum.Font.GothamBold
collapseBtn.Parent = header
Instance.new("UICorner", collapseBtn).CornerRadius = UDim.new(0, 5)

-- "Open" Button (Hidden initially, shown when closed)
local openBtn = Instance.new("TextButton")
openBtn.Name = "OpenButton"
openBtn.Size = UDim2.new(0, 100, 0, 40)
openBtn.Position = UDim2.new(0, 10, 1, -80)
openBtn.Text = "Open Tool UI"
openBtn.BackgroundColor3 = ACCENT_COLOR
openBtn.TextColor3 = TEXT_COLOR
openBtn.Visible = false
openBtn.Parent = gui
Instance.new("UICorner", openBtn)

-- Content Container (For collapsing)
local content = Instance.new("Frame")
content.Name = "Content"
content.Size = UDim2.new(1, 0, 1, -40)
content.Position = UDim2.new(0, 0, 0, 40)
content.BackgroundTransparency = 1
content.Parent = frame

-- UI Variables & State
local isCollapsed = false
local baseHeight, baseLength, baseWidth = 4, 4, 1
local effectiveHeight, effectiveLength, effectiveWidth = 4, 4, 1
local currentIsMassless = false
local currentEquip = 1
local equipOptions = {"None", "Blade (+10% L)", "Hammer (+20% W)", "Drill (+15% H)", "Extender (+5% All)"}
local currentTool = nil
local toolOriginalSizes = {}
local toolBaseSizes = {}

-- Draggable Logic
local dragging, dragInput, dragStart, startPos
header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true; dragStart = input.Position; startPos = frame.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- UI Components Construction
local function createLabel(text, pos, parent)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -20, 0, 20)
    l.Position = pos
    l.Text = text
    l.TextColor3 = Color3.fromRGB(180, 180, 180)
    l.Font = Enum.Font.Gotham
    l.TextSize = 12
    l.BackgroundTransparency = 1
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = parent
    return l
end

local function createBox(text, pos, parent)
    local b = Instance.new("TextBox")
    b.Size = UDim2.new(1, -20, 0, 30)
    b.Position = pos
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    b.TextColor3 = TEXT_COLOR
    b.Font = Enum.Font.Gotham
    b.Parent = parent
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
    return b
end

local function createBtn(text, pos, color, parent)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -20, 0, 35)
    b.Position = pos
    b.Text = text
    b.BackgroundColor3 = color
    b.TextColor3 = TEXT_COLOR
    b.Font = Enum.Font.GothamBold
    b.Parent = parent
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
    return b
end

-- Layout
local equipLabel = createLabel("Equipped Item: None", UDim2.new(0, 10, 0, 10), content)
local equipBtn = createBtn("Cycle Add-on", UDim2.new(0, 10, 0, 35), Color3.fromRGB(70, 70, 70), content)
local massBtn = createBtn("Massless: OFF", UDim2.new(0, 10, 0, 75), Color3.fromRGB(70, 70, 70), content)

createLabel("Base Height (Y):", UDim2.new(0, 10, 0, 120), content)
local heightBox = createBox("4.00", UDim2.new(0, 10, 0, 140), content)

createLabel("Base Length (Z):", UDim2.new(0, 10, 0, 180), content)
local lengthBox = createBox("4.00", UDim2.new(0, 10, 0, 200), content)

createLabel("Base Width (X):", UDim2.new(0, 10, 0, 240), content)
local widthBox = createBox("1.00", UDim2.new(0, 10, 0, 260), content)

local expandBtn = createBtn("Expand All (+10%)", UDim2.new(0, 10, 0, 305), ACCENT_COLOR, content)

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -20, 0, 60)
statusLabel.Position = UDim2.new(0, 10, 0, 350)
statusLabel.Text = "No Tool Detected"
statusLabel.TextColor3 = ACCENT_COLOR
statusLabel.BackgroundTransparency = 1
statusLabel.Font = Enum.Font.GothamSemibold
statusLabel.TextSize = 14
statusLabel.TextWrapped = true
statusLabel.Parent = content

-- Logic Functions
local function updateUI()
    heightBox.Text = string.format("%.2f", baseHeight)
    lengthBox.Text = string.format("%.2f", baseLength)
    widthBox.Text = string.format("%.2f", baseWidth)
    statusLabel.Text = string.format("Effective Reach:\nH:%.2f L:%.2f W:%.2f", effectiveHeight, effectiveLength, effectiveWidth)
end

local function applyToTool()
    if currentTool then
        local handle = currentTool:FindFirstChild("Handle")
        if handle then
            handle.Size = Vector3.new(effectiveWidth, effectiveHeight, effectiveLength)
            handle.Massless = currentIsMassless
        end
    end
end

local function updateEffective()
    effectiveHeight, effectiveLength, effectiveWidth = baseHeight, baseLength, baseWidth
    local mod = equipOptions[currentEquip]:lower()
    if mod:find("blade") then effectiveLength *= 1.1 
    elseif mod:find("hammer") then effectiveWidth *= 1.2
    elseif mod:find("drill") then effectiveHeight *= 1.15
    elseif mod:find("extender") then 
        effectiveHeight *= 1.05; effectiveLength *= 1.05; effectiveWidth *= 1.05
    end
    updateUI()
    applyToTool()
end

local function onToolEquipped(tool)
    currentTool = tool
    local handle = tool:FindFirstChild("Handle")
    if handle then
        if not toolOriginalSizes[tool] then toolOriginalSizes[tool] = handle.Size end
        if not toolBaseSizes[tool] then
            toolBaseSizes[tool] = {h = handle.Size.Y, l = handle.Size.Z, w = handle.Size.X}
        end
        baseHeight, baseLength, baseWidth = toolBaseSizes[tool].h, toolBaseSizes[tool].l, toolBaseSizes[tool].w
        updateEffective()
    end
end

-- Input Listeners
heightBox.FocusLost:Connect(function() baseHeight = tonumber(heightBox.Text) or 4; updateEffective() end)
lengthBox.FocusLost:Connect(function() baseLength = tonumber(lengthBox.Text) or 4; updateEffective() end)
widthBox.FocusLost:Connect(function() baseWidth = tonumber(widthBox.Text) or 1; updateEffective() end)

equipBtn.MouseButton1Click:Connect(function()
    currentEquip = currentEquip % #equipOptions + 1
    equipLabel.Text = "Equipped Item: " .. equipOptions[currentEquip]
    updateEffective()
end)

massBtn.MouseButton1Click:Connect(function()
    currentIsMassless = not currentIsMassless
    massBtn.Text = "Massless: " .. (currentIsMassless and "ON" or "OFF")
    massBtn.BackgroundColor3 = currentIsMassless and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(70, 70, 70)
    updateEffective()
end)

expandBtn.MouseButton1Click:Connect(function()
    baseHeight *= 1.1; baseLength *= 1.1; baseWidth *= 1.1
    if currentTool and toolBaseSizes[currentTool] then
        toolBaseSizes[currentTool] = {h = baseHeight, l = baseLength, w = baseWidth}
    end
    updateEffective()
end)

-- Window Control Listeners
collapseBtn.MouseButton1Click:Connect(function()
    isCollapsed = not isCollapsed
    if isCollapsed then
        frame:TweenSize(UDim2.new(0, 300, 0, 40), "Out", "Quad", 0.3, true)
        collapseBtn.Text = "+"
        content.Visible = false
    else
        frame:TweenSize(UDim2.new(0, 300, 0, 450), "Out", "Quad", 0.3, true)
        collapseBtn.Text = "-"
        content.Visible = true
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    frame.Visible = false
    openBtn.Visible = true
end)

openBtn.MouseButton1Click:Connect(function()
    frame.Visible = true
    openBtn.Visible = false
end)

-- Tool Detection Logic
local function scan(char)
    char.ChildAdded:Connect(function(c) if c:IsA("Tool") then onToolEquipped(c) end end)
    for _, t in ipairs(char:GetChildren()) do if t:IsA("Tool") then onToolEquipped(t) end end
end

LocalPlayer.CharacterAdded:Connect(scan)
if LocalPlayer.Character then scan(LocalPlayer.Character) end

updateUI()
        end},
        {"BLIND SHOT ESP", function()
        local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera


local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "BlindShotFinal"
ScreenGui.ResetOnSpawn = false


local ToggleButton = Instance.new("ImageButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 60, 0, 60)
ToggleButton.Position = UDim2.new(0, 15, 0.5, -30)
ToggleButton.BackgroundColor3 = Color3.fromRGB(130, 210, 255)
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(1, 0)


local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 500, 0, 320)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 150)
MainFrame.BorderSizePixel = 0
local Gradient = Instance.new("UIGradient", MainFrame)
Gradient.Color = ColorSequence.new(Color3.fromRGB(0, 0, 255), Color3.fromRGB(0, 0, 10))
Gradient.Rotation = 90


local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "BLIND SHOT"; Title.Font = Enum.Font.PermanentMarker; Title.TextSize = 35; Title.TextColor3 = Color3.new(1,1,1); Title.Position = UDim2.new(0.05, 0, 0, 10); Title.Size = UDim2.new(0, 200, 0, 50); Title.BackgroundTransparency = 1

local DestroyBtn = Instance.new("TextButton", MainFrame)
DestroyBtn.Text = "X"; DestroyBtn.TextColor3 = Color3.fromRGB(255, 0, 0); DestroyBtn.TextSize = 40; DestroyBtn.BackgroundTransparency = 1; DestroyBtn.Position = UDim2.new(1, -50, 0, 5); DestroyBtn.Size = UDim2.new(0, 40, 0, 40)

local MinimizeBtn = Instance.new("TextButton", MainFrame)
MinimizeBtn.Text = "-"; MinimizeBtn.TextColor3 = Color3.fromRGB(180, 180, 180); MinimizeBtn.TextSize = 50; MinimizeBtn.BackgroundTransparency = 1; MinimizeBtn.Position = UDim2.new(1, -95, 0, 0); MinimizeBtn.Size = UDim2.new(0, 40, 0, 40)


local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(0, 300, 1, -70); ContentArea.Position = UDim2.new(0, 170, 0, 70); ContentArea.BackgroundTransparency = 1


local States = {ESP = false}
local espConnections = {}
local torsoLines = {}

local function HealthBarLerp(ratio)
    return Color3.fromRGB(math.floor(255 * (1 - ratio)), math.floor(255 * ratio), 0)
end

local function createESP(player)
    -- ESP Drawings (2D)
    local Box = Drawing.new("Square"); Box.Visible = false; Box.Color = Color3.fromRGB(138, 43, 226); Box.Thickness = 1
    local NameText = Drawing.new("Text"); NameText.Visible = false; NameText.Size = 16; NameText.Center = true; NameText.Outline = true; NameText.Color = Color3.new(1,1,1)
    local HealthBar = Drawing.new("Square"); HealthBar.Visible = false; HealthBar.Filled = true


    local linePart = Instance.new("Part")
    linePart.Name = "PermanentGreenLine"
    linePart.Size = Vector3.new(0.15, 0.15, 150) -- Made even longer (150)
    linePart.Transparency = 0.3
    linePart.Material = Enum.Material.Neon
    linePart.Color = Color3.fromRGB(0, 255, 0)
    linePart.CanCollide = false
    linePart.Parent = workspace

    local weld = Instance.new("Weld")
    weld.Part0 = player.Character:WaitForChild("HumanoidRootPart")
    weld.Part1 = linePart
    weld.C0 = CFrame.new(0, 0, -75) -- Centered for 150 length
    weld.Parent = linePart
    
    torsoLines[player] = linePart

    local connection = RunService.RenderStepped:Connect(function()
        -- If ESP is toggled off or player dies, hide everything
        if not States.ESP or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
            Box.Visible = false; NameText.Visible = false; HealthBar.Visible = false
            if torsoLines[player] then torsoLines[player].Transparency = 1 end
            return
        end
        
        local hrp = player.Character.HumanoidRootPart
        local hum = player.Character:FindFirstChild("Humanoid")
        local screenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
        
        -- Always keep the Green Line visible while ESP is ON
        if torsoLines[player] then torsoLines[player].Transparency = 0.3 end

        -- 2D Elements only show when player is on screen
        if onScreen and hum then
            local headPos = Camera:WorldToViewportPoint(hrp.Position + Vector3.new(0, 3, 0))
            local height = math.abs(headPos.Y - screenPos.Y) * 2.2
            local width = height / 1.8

            Box.Size = Vector2.new(width, height); Box.Position = Vector2.new(screenPos.X - width/2, screenPos.Y - height/2); Box.Visible = true
            NameText.Text = player.Name; NameText.Position = Vector2.new(screenPos.X, screenPos.Y - height/2 - 15); NameText.Visible = true
            HealthBar.Size = Vector2.new(2, height * (hum.Health / hum.MaxHealth)); HealthBar.Position = Vector2.new(screenPos.X - width/2 - 5, screenPos.Y - height/2 + (height * (1 - hum.Health/hum.MaxHealth))); HealthBar.Color = HealthBarLerp(hum.Health/hum.MaxHealth); HealthBar.Visible = true
        else
            Box.Visible = false; NameText.Visible = false; HealthBar.Visible = false
        end
    end)
    
    return {Connection = connection, Drawings = {Box, NameText, HealthBar}}
end

local function CleanupESP()
    for player, data in pairs(espConnections) do
        data.Connection:Disconnect()
        for _, draw in pairs(data.Drawings) do draw:Remove() end
    end
    for _, line in pairs(torsoLines) do line:Destroy() end
    espConnections = {}
    torsoLines = {}
end


local ESPToggle = Instance.new("TextButton", ContentArea)
ESPToggle.Size = UDim2.new(1, 0, 0, 50); ESPToggle.Text = "BLIND SHOT ESP: OFF"; ESPToggle.BackgroundColor3 = Color3.fromRGB(0, 0, 40); ESPToggle.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", ESPToggle).CornerRadius = UDim.new(0.5, 0)

ESPToggle.MouseButton1Click:Connect(function()
    States.ESP = not States.ESP
    ESPToggle.Text = "BLIND SHOT ESP: " .. (States.ESP and "ON" or "OFF")
    ESPToggle.BackgroundColor3 = States.ESP and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(0, 0, 40)
    if States.ESP then
        for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then espConnections[p] = createESP(p) end end
    else
        CleanupESP()
    end
end)


local dragging, dragStart, startPos
MainFrame.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true; dragStart = i.Position; startPos = MainFrame.Position end end)
UserInputService.InputChanged:Connect(function(i) if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
    local delta = i.Position - dragStart; MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end end)
UserInputService.InputEnded:Connect(function() dragging = false end)

DestroyBtn.MouseButton1Click:Connect(function() CleanupESP(); ScreenGui:Destroy() end)
MinimizeBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)
ToggleButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

        end},
        {"Aimbot universal and more", function()
loadstring(game:HttpGet("https://pastebin.com/raw/AiFegBPa"))()
        end},
        {"Sorin Hub V3", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/DontTrlp/chatgpt/refs/heads/main/Xenure"))()
        end},
        {"Backdoor.exe", function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/iK4oS/backdoor.exe/master/source.lua'))()
        end},
        {"c00lgui ogVer", function()
loadstring(game:HttpGet("https://pastebin.com/raw/pqBe2ezu", true))()
        end},
        {"fe zerox hub (Tps u to the baseplate game)", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/ilikeices/script/refs/heads/main/zerox.luau"))()
        end},
        {"Tidal Serverside Executor {Loader}", function()
loadstring(game:HttpGetAsync("https://pastebin.com/raw/nzPxaeTn"))()
        end},
        {"Project Bluu V2 BackDoor Scanner", function()
loadstring(game:HttpGet('https://pastebin.com/raw/rNLsVrYA'))() -- Scanner!
        end},
        {"starlight backdoor scanner", function()
loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-starlight-archive-46524"))()
        end},
        {"CurseDew Executor Backdoor", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/UrexampleGD/Cursing/refs/heads/main/BetaLecha.lua"))()
        end},
        {"Hitbox Expander", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/example-prog/Hitbox-Expander/refs/heads/main/RScripter"))()
        end},
        {"c00lgui v3 FE", function()
loadstring(game:HttpGet("https://pastebin.com/5i37wELU", true))()
        end},
        {"FE R15 Animation Player", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Boxten-Keyes/music/refs/heads/main/music%23%5Bscripts%5D/music%23%5Bmiscellaneous%5D/music%23%5Bfe%20r15%20animation%20player%5D.lua"))()
        end},
        {"Equip all tool", function()
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()

local backpack = plr:WaitForChild("Backpack")
for _, tool in ipairs(backpack:GetChildren()) do
	if tool:IsA("Tool") then
		tool.Parent = char
		print("Equipped:", tool.Name)
	end
end

print("Humanoid.CurrentTool:", char.Humanoid:FindFirstChildOfClass("Tool"))
        end},
        {"NA", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/kigredns/testUIDK/refs/heads/main/panel.lua"))()
        end},
        {"R6 2007 Anim", function()
-- 2007 anim
game.Players.LocalPlayer.Character:BreakJoints()
   game.Players.LocalPlayer.Character=nil
   Connection = game.Workspace.DescendantAdded:Connect(function(c)
       if c.Name == "Animate" then
           c.Disabled=true        
       end
   end)
   repeat wait() until game.Players.LocalPlayer.Character
   Char = game.Players.LocalPlayer.Character
   Died = game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Died:Connect(function()
       Connection:Disconnect()
       Died:Disconnect()
   end)
   wait(.1)
   function waitForChild(parent, childName)
local child = parent:findFirstChild(childName)
if child then return child end
while true do
 child = parent.ChildAdded:wait()
 if child.Name==childName then return child end
end
end

-- ANIMATION
wait(0.1)
game.StarterGui:SetCore("SendNotification", {
Title = "youtube.com/@publicized";
Text = "2007 animations loaded!";
Duration = 5;
})
-- declarations

local Figure = game.Players.LocalPlayer.Character
local Torso = waitForChild(Figure, "Torso")
local RightShoulder = waitForChild(Torso, "Right Shoulder")
local LeftShoulder = waitForChild(Torso, "Left Shoulder")
local RightHip = waitForChild(Torso, "Right Hip")
local LeftHip = waitForChild(Torso, "Left Hip")
local Neck = waitForChild(Torso, "Neck")
local Humanoid = waitForChild(Figure, "Humanoid")
local pose = "Standing"

local toolAnim = "None"
local toolAnimTime = 0

local jumpMaxLimbVelocity = 0.75

-- functions

function onRunning(speed)
if speed>0 then
 pose = "Running"
else
 pose = "Standing"
end
end

function onDied()
pose = "Dead"
end

function onJumping()
pose = "Jumping"
end

function onClimbing()
pose = "Climbing"
end

function onGettingUp()
pose = "GettingUp"
end

function onFreeFall()
pose = "FreeFall"
end

function onFallingDown()
pose = "FallingDown"
end

function onSeated()
pose = "Seated"
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

function moveJump()
RightShoulder.MaxVelocity = jumpMaxLimbVelocity
LeftShoulder.MaxVelocity = jumpMaxLimbVelocity
 RightShoulder:SetDesiredAngle(3.14)
LeftShoulder:SetDesiredAngle(-3.14)
RightHip:SetDesiredAngle(0)
LeftHip:SetDesiredAngle(0)
end


-- same as jump for now

function moveFreeFall()
RightShoulder.MaxVelocity = jumpMaxLimbVelocity
LeftShoulder.MaxVelocity = jumpMaxLimbVelocity
RightShoulder:SetDesiredAngle(3.14)
LeftShoulder:SetDesiredAngle(-3.14)
RightHip:SetDesiredAngle(0)
LeftHip:SetDesiredAngle(0)
end

function moveSit()
RightShoulder.MaxVelocity = 0.15
LeftShoulder.MaxVelocity = 0.15
RightShoulder:SetDesiredAngle(3.14 /2)
LeftShoulder:SetDesiredAngle(-3.14 /2)
RightHip:SetDesiredAngle(3.14 /2)
LeftHip:SetDesiredAngle(-3.14 /2)
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
 RightShoulder:SetDesiredAngle(1.57)
 return
end

if (toolAnim == "Slash") then
 RightShoulder.MaxVelocity = 0.5
 RightShoulder:SetDesiredAngle(0)
 return
end

if (toolAnim == "Lunge") then
 RightShoulder.MaxVelocity = 0.5
 LeftShoulder.MaxVelocity = 0.5
 RightHip.MaxVelocity = 0.5
 LeftHip.MaxVelocity = 0.5
 RightShoulder:SetDesiredAngle(1.57)
 LeftShoulder:SetDesiredAngle(1.0)
 RightHip:SetDesiredAngle(1.57)
 LeftHip:SetDesiredAngle(1.0)
 return
end
end

function move(time)
local amplitude
local frequency
 
if (pose == "Jumping") then
 moveJump()
 return
end

if (pose == "FreeFall") then
 moveFreeFall()
 return
end

if (pose == "Seated") then
 moveSit()
 return
end

local climbFudge = 0

if (pose == "Running") then
   if (RightShoulder.CurrentAngle > 1.5 or RightShoulder.CurrentAngle < -1.5) then
  RightShoulder.MaxVelocity = jumpMaxLimbVelocity
 else  
  RightShoulder.MaxVelocity = 0.15
 end
 if (LeftShoulder.CurrentAngle > 1.5 or LeftShoulder.CurrentAngle < -1.5) then
  LeftShoulder.MaxVelocity = jumpMaxLimbVelocity
 else  
  LeftShoulder.MaxVelocity = 0.15
 end
 amplitude = 1
 frequency = 9
elseif (pose == "Climbing") then
 RightShoulder.MaxVelocity = 0.5
 LeftShoulder.MaxVelocity = 0.5
 amplitude = 1
 frequency = 9
 climbFudge = 3.14
else
 amplitude = 0.1
 frequency = 1
end

desiredAngle = amplitude * math.sin(time*frequency)

RightShoulder:SetDesiredAngle(desiredAngle + climbFudge)
LeftShoulder:SetDesiredAngle(desiredAngle - climbFudge)
RightHip:SetDesiredAngle(-desiredAngle)
LeftHip:SetDesiredAngle(-desiredAngle)


local tool = getTool()

if tool then

 animStringValueObject = getToolAnim(tool)

 if animStringValueObject then
  toolAnim = animStringValueObject.Value
  -- message recieved, delete StringValue
  animStringValueObject.Parent = nil
  toolAnimTime = time + .3
 end

 if time > toolAnimTime then
  toolAnimTime = 0
  toolAnim = "None"
 end

 animateTool()

 
else
 toolAnim = "None"
 toolAnimTime = 0
end
end


-- connect events

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
-- main program

local runService = game:service("RunService");

while Figure.Parent~=nil do
local _, time = wait(0.1)
move(time)
end
        end},
        {"R15 To R6 Anim converter", function()
local plr = game:GetService("Players").LocalPlayer

function RunCustomAnimation(Char)
	if Char:WaitForChild("Humanoid").RigType == Enum.HumanoidRigType.R6 then
		return
	end
	
	if Char:WaitForChild("Animate") ~= nil then
		Char.Animate.Disabled = true
	end

	for i,v in next, Char.Humanoid:GetPlayingAnimationTracks() do
		v:Stop()
	end

	--fake script
	local script = Char.Animate

	local Character = Char
	local Humanoid = Character:WaitForChild("Humanoid")
	local pose = "Standing"

	local UserGameSettings = UserSettings():GetService("UserGameSettings")

	local userNoUpdateOnLoopSuccess, userNoUpdateOnLoopValue = pcall(function() return UserSettings():IsUserFeatureEnabled("UserNoUpdateOnLoop") end)
	local userNoUpdateOnLoop = userNoUpdateOnLoopSuccess and userNoUpdateOnLoopValue

	local AnimationSpeedDampeningObject = script:FindFirstChild("ScaleDampeningPercent")
	local HumanoidHipHeight = 2

	local humanoidSpeed = 0 -- speed most recently sent to us from onRunning()
	local cachedRunningSpeed = 0 -- The most recent speed used to compute blends.  Tiny variations from cachedRunningSpeed will not cause animation updates.
	local cachedLocalDirection = {x=0.0, y=0.0} -- unit 2D object space direction of motion
	local smallButNotZero = 0.0001 -- We want weights to be small but not so small the animation stops
	local runBlendtime = 0.2
	local lastLookVector = Vector3.new(0.0, 0.0, 0.0) -- used to track whether rootPart orientation is changing.
	local lastBlendTime = 0 -- The last time we blended velocities
	local WALK_SPEED = 6.4
	local RUN_SPEED = 12.8

	local EMOTE_TRANSITION_TIME = 0.1

	local currentAnim = ""
	local currentAnimInstance = nil
	local currentAnimTrack = nil
	local currentAnimKeyframeHandler = nil
	local currentAnimSpeed = 1.0

	local PreloadedAnims = {}

	local animTable = {}
	local animNames = { 
		idle = 	{
			{ id = "http://www.roblox.com/asset/?id=12521158637", weight = 9 },
			{ id = "http://www.roblox.com/asset/?id=12521162526", weight = 1 },
		},
		walk = 	{
			{ id = "http://www.roblox.com/asset/?id=12518152696", weight = 10 }
		},
		run = 	{
			{ id = "http://www.roblox.com/asset/?id=12518152696", weight = 10 } 
		},
		jump = 	{
			{ id = "http://www.roblox.com/asset/?id=12520880485", weight = 10 }
		},
		fall = 	{
			{ id = "http://www.roblox.com/asset/?id=12520972571", weight = 10 }
		},
		climb = {
			{ id = "http://www.roblox.com/asset/?id=12520982150", weight = 10 }
		},
		sit = 	{
			{ id = "http://www.roblox.com/asset/?id=12520993168", weight = 10 }
		},
		toolnone = {
			{ id = "http://www.roblox.com/asset/?id=12520996634", weight = 10 }
		},
		toolslash = {
			{ id = "http://www.roblox.com/asset/?id=12520999032", weight = 10 }
		},
		toollunge = {
			{ id = "http://www.roblox.com/asset/?id=12521002003", weight = 10 }
		},
		wave = {
			{ id = "http://www.roblox.com/asset/?id=12521004586", weight = 10 }
		},
		point = {
			{ id = "http://www.roblox.com/asset/?id=12521007694", weight = 10 }
		},
		dance = {
			{ id = "http://www.roblox.com/asset/?id=12521009666", weight = 10 },
			{ id = "http://www.roblox.com/asset/?id=12521151637", weight = 10 },
			{ id = "http://www.roblox.com/asset/?id=12521015053", weight = 10 }
		},
		dance2 = {
			{ id = "http://www.roblox.com/asset/?id=12521169800", weight = 10 },
			{ id = "http://www.roblox.com/asset/?id=12521173533", weight = 10 },
			{ id = "http://www.roblox.com/asset/?id=12521027874", weight = 10 }
		},
		dance3 = {
			{ id = "http://www.roblox.com/asset/?id=12521178362", weight = 10 },
			{ id = "http://www.roblox.com/asset/?id=12521181508", weight = 10 },
			{ id = "http://www.roblox.com/asset/?id=12521184133", weight = 10 }
		},
		laugh = {
			{ id = "http://www.roblox.com/asset/?id=12521018724", weight = 10 }
		},
		cheer = {
			{ id = "http://www.roblox.com/asset/?id=12521021991", weight = 10 }
		},
	}


	local strafingLocomotionMap = {}
	local fallbackLocomotionMap = {}
	local locomotionMap = strafingLocomotionMap
	-- Existance in this list signifies that it is an emote, the value indicates if it is a looping emote
	local emoteNames = { wave = false, point = false, dance = true, dance2 = true, dance3 = true, laugh = false, cheer = false}

	math.randomseed(tick())

	function findExistingAnimationInSet(set, anim)
		if set == nil or anim == nil then
			return 0
		end

		for idx = 1, set.count, 1 do
			if set[idx].anim.AnimationId == anim.AnimationId then
				return idx
			end
		end

		return 0
	end

	function configureAnimationSet(name, fileList)
		if (animTable[name] ~= nil) then
			for _, connection in pairs(animTable[name].connections) do
				connection:disconnect()
			end
		end
		animTable[name] = {}
		animTable[name].count = 0
		animTable[name].totalWeight = 0
		animTable[name].connections = {}

		-- uncomment this section to allow players to load with their
		-- own (non-classic) animations
        --[[
        local config = script:FindFirstChild(name)
        if (config ~= nil) then
            table.insert(animTable[name].connections, config.ChildAdded:connect(function(child) configureAnimationSet(name, fileList) end))
            table.insert(animTable[name].connections, config.ChildRemoved:connect(function(child) configureAnimationSet(name, fileList) end))

            local idx = 0

            for _, childPart in pairs(config:GetChildren()) do
                if (childPart:IsA("Animation")) then
                    local newWeight = 1
                    local weightObject = childPart:FindFirstChild("Weight")
                    if (weightObject ~= nil) then
                        newWeight = weightObject.Value
                    end
                    animTable[name].count = animTable[name].count + 1
                    idx = animTable[name].count
                    animTable[name][idx] = {}
                    animTable[name][idx].anim = childPart
                    animTable[name][idx].weight = newWeight
                    animTable[name].totalWeight = animTable[name].totalWeight + animTable[name][idx].weight
                    table.insert(animTable[name].connections, childPart.Changed:connect(function(property) configureAnimationSet(name, fileList) end))
                    table.insert(animTable[name].connections, childPart.ChildAdded:connect(function(property) configureAnimationSet(name, fileList) end))
                    table.insert(animTable[name].connections, childPart.ChildRemoved:connect(function(property) configureAnimationSet(name, fileList) end))
                    local lv = childPart:GetAttribute("LinearVelocity")
                    if lv then
                        strafingLocomotionMap[name] = {lv=lv, speed = lv.Magnitude}
                    end
                    if name == "run" or name == "walk" then

                        if lv then
                            fallbackLocomotionMap[name] = strafingLocomotionMap[name]
                        else
                            local speed = name == "run" and RUN_SPEED or WALK_SPEED
                            fallbackLocomotionMap[name] = {lv=Vector2.new(0.0, speed), speed = speed}
                            locomotionMap = fallbackLocomotionMap
                            -- If you don't have a linear velocity with your run or walk, you can't blend/strafe
                            --warn("Strafe blending disabled. No linear velocity information for "..'"'.."walk"..'"'.." and "..'"'.."run"..'"'..".")
                        end

                    end
                end
            end
        end
        ]]

		-- if you uncomment the above section, comment out this "if"-block
		if name == "run" or name == "walk" then
			local speed = name == "run" and RUN_SPEED or WALK_SPEED
			fallbackLocomotionMap[name] = {lv=Vector2.new(0.0, speed), speed = speed}
			locomotionMap = fallbackLocomotionMap
			-- If you don't have a linear velocity with your run or walk, you can't blend/strafe
			--warn("Strafe blending disabled. No linear velocity information for "..'"'.."walk"..'"'.." and "..'"'.."run"..'"'..".")
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

		-- preload anims
		for i, animType in pairs(animTable) do
			for idx = 1, animType.count, 1 do
				if PreloadedAnims[animType[idx].anim.AnimationId] == nil then
					Humanoid:LoadAnimation(animType[idx].anim)
					PreloadedAnims[animType[idx].anim.AnimationId] = true
				end
			end
		end
	end

	-- Setup animation objects
	function scriptChildModified(child)
		local fileList = animNames[child.Name]
		if (fileList ~= nil) then
			configureAnimationSet(child.Name, fileList)
		else
			if child:isA("StringValue") then
				animNames[child.Name] = {}
				configureAnimationSet(child.Name, animNames[child.Name])
			end
		end	
	end

	script.ChildAdded:connect(scriptChildModified)
	script.ChildRemoved:connect(scriptChildModified)

	-- Clear any existing animation tracks
	-- Fixes issue with characters that are moved in and out of the Workspace accumulating tracks
	local animator = if Humanoid then Humanoid:FindFirstChildOfClass("Animator") else nil
	if animator then
		local animTracks = animator:GetPlayingAnimationTracks()
		for i,track in ipairs(animTracks) do
			track:Stop(0)
			track:Destroy()
		end
	end

	for name, fileList in pairs(animNames) do
		configureAnimationSet(name, fileList)
	end
	for _,child in script:GetChildren() do
		if child:isA("StringValue") and not animNames[child.name] then
			animNames[child.Name] = {}
			configureAnimationSet(child.Name, animNames[child.Name])
		end
	end

	-- ANIMATION

	-- declarations
	local toolAnim = "None"
	local toolAnimTime = 0

	local jumpAnimTime = 0
	local jumpAnimDuration = 0.31

	local toolTransitionTime = 0.1
	local fallTransitionTime = 0.2

	local currentlyPlayingEmote = false

	-- functions

	function stopAllAnimations()
		local oldAnim = currentAnim

		-- return to idle if finishing an emote
		if (emoteNames[oldAnim] ~= nil and emoteNames[oldAnim] == false) then
			oldAnim = "idle"
		end

		if currentlyPlayingEmote then
			oldAnim = "idle"
			currentlyPlayingEmote = false
		end

		currentAnim = ""
		currentAnimInstance = nil
		if (currentAnimKeyframeHandler ~= nil) then
			currentAnimKeyframeHandler:disconnect()
		end

		if (currentAnimTrack ~= nil) then
			currentAnimTrack:Stop()
			currentAnimTrack:Destroy()
			currentAnimTrack = nil
		end

		for _,v in pairs(locomotionMap) do
			if v.track then
				v.track:Stop()
				v.track:Destroy()
				v.track = nil
			end
		end

		return oldAnim
	end

	function getHeightScale()
		if Humanoid then
			if not Humanoid.AutomaticScalingEnabled then
				return 1
			end

			local scale = Humanoid.HipHeight / HumanoidHipHeight
			if AnimationSpeedDampeningObject == nil then
				AnimationSpeedDampeningObject = script:FindFirstChild("ScaleDampeningPercent")
			end
			if AnimationSpeedDampeningObject ~= nil then
				scale = 1 + (Humanoid.HipHeight - HumanoidHipHeight) * AnimationSpeedDampeningObject.Value / HumanoidHipHeight
			end
			return scale
		end
		return 1
	end


	local function signedAngle(a, b)
		return -math.atan2(a.x * b.y - a.y * b.x, a.x * b.x + a.y * b.y)
	end

	local angleWeight = 2.0
	local function get2DWeight(px, p1, p2, sx, s1, s2)
		local avgLength = 0.5 * (s1 + s2)

		local p_1 = {x = (sx - s1)/avgLength, y = (angleWeight * signedAngle(p1, px))}
		local p12 = {x = (s2 - s1)/avgLength, y = (angleWeight * signedAngle(p1, p2))}	
		local denom = smallButNotZero + (p12.x*p12.x + p12.y*p12.y)
		local numer = p_1.x * p12.x + p_1.y * p12.y
		local r = math.clamp(1.0 - numer/denom, 0.0, 1.0)
		return r
	end

	local function blend2D(targetVelo, targetSpeed)
		local h = {}
		local sum = 0.0
		for n,v1 in pairs(locomotionMap) do
			if targetVelo.x * v1.lv.x < 0.0 or targetVelo.y * v1.lv.y < 0 then
				-- Require same quadrant as target
				h[n] = 0.0
				continue
			end
			h[n] = math.huge
			for j,v2 in pairs(locomotionMap) do
				if targetVelo.x * v2.lv.x < 0.0 or targetVelo.y * v2.lv.y < 0 then
					-- Require same quadrant as target
					continue
				end
				h[n] = math.min(h[n], get2DWeight(targetVelo, v1.lv, v2.lv, targetSpeed, v1.speed, v2.speed))
			end
			sum += h[n]
		end

		--truncates below 10% contribution
		local sum2 = 0.0
		local weightedVeloX = 0
		local weightedVeloY = 0
		for n,v in pairs(locomotionMap) do

			if (h[n] / sum > 0.1) then
				sum2 += h[n]
				weightedVeloX += h[n] * v.lv.x
				weightedVeloY += h[n] * v.lv.y
			else
				h[n] = 0.0
			end
		end
		local animSpeed
		local weightedSpeedSquared = weightedVeloX * weightedVeloX + weightedVeloY * weightedVeloY
		if weightedSpeedSquared > smallButNotZero then
			animSpeed = math.sqrt(targetSpeed * targetSpeed / weightedSpeedSquared)
		else
			animSpeed = 0
		end

		animSpeed = animSpeed / getHeightScale()
		local groupTimePosition = 0
		for n,v in pairs(locomotionMap) do
			if v.track.IsPlaying then
				groupTimePosition = v.track.TimePosition
				break
			end
		end
		for n,v in pairs(locomotionMap) do
			-- if not loco
			if h[n] > 0.0 then
				if not v.track.IsPlaying then 
					v.track:Play(runBlendtime)
					v.track.TimePosition = groupTimePosition
				end

				local weight = math.max(smallButNotZero, h[n] / sum2)
				v.track:AdjustWeight(weight, runBlendtime)
				v.track:AdjustSpeed(animSpeed)
			else
				v.track:Stop(runBlendtime)
			end
		end

	end

	local function getWalkDirection()
		local walkToPoint = Humanoid.WalkToPoint
		local walkToPart = Humanoid.WalkToPart
		if Humanoid.MoveDirection ~= Vector3.zero then
			return Humanoid.MoveDirection
		elseif walkToPart or walkToPoint ~= Vector3.zero then
			local destination
			if walkToPart then
				destination = walkToPart.CFrame:PointToWorldSpace(walkToPoint)
			else
				destination = walkToPoint
			end
			local moveVector = Vector3.zero
			if Humanoid.RootPart then
				moveVector = destination - Humanoid.RootPart.CFrame.Position
				moveVector = Vector3.new(moveVector.x, 0.0, moveVector.z)
				local mag = moveVector.Magnitude
				if mag > 0.01 then
					moveVector /= mag
				end
			end
			return moveVector
		else
			return Humanoid.MoveDirection
		end
	end

	local function updateVelocity(currentTime)

		local tempDir

		if locomotionMap == strafingLocomotionMap then

			local moveDirection = getWalkDirection()

			if not Humanoid.RootPart then
				return
			end

			local cframe = Humanoid.RootPart.CFrame
			if math.abs(cframe.UpVector.Y) < smallButNotZero or pose ~= "Running" or humanoidSpeed < 0.001 then
				-- We are horizontal!  Do something  (turn off locomotion)
				for n,v in pairs(locomotionMap) do
					if v.track then
						v.track:AdjustWeight(smallButNotZero, runBlendtime)
					end
				end
				return
			end
			local lookat = cframe.LookVector
			local direction = Vector3.new(lookat.X, 0.0, lookat.Z)
			direction = direction / direction.Magnitude --sensible upVector means this is non-zero.
			local ly = moveDirection:Dot(direction)
			if ly <= 0.0 and ly > -0.05 then
				ly = smallButNotZero -- break quadrant ties in favor of forward-friendly strafes
			end
			local lx = direction.X*moveDirection.Z - direction.Z*moveDirection.X
			local tempDir = Vector2.new(lx, ly) -- root space moveDirection
			local delta = Vector2.new(tempDir.x-cachedLocalDirection.x, tempDir.y-cachedLocalDirection.y)
			-- Time check serves the purpose of the old keyframeReached sync check, as it syncs anim timePosition
			if delta:Dot(delta) > 0.001 or math.abs(humanoidSpeed - cachedRunningSpeed) > 0.01 or currentTime - lastBlendTime > 1 then
				cachedLocalDirection = tempDir
				cachedRunningSpeed = humanoidSpeed
				lastBlendTime = currentTime
				blend2D(cachedLocalDirection, cachedRunningSpeed)
			end 
		else
			if math.abs(humanoidSpeed - cachedRunningSpeed) > 0.01 or currentTime - lastBlendTime > 1 then
				cachedRunningSpeed = humanoidSpeed
				lastBlendTime = currentTime
				blend2D(Vector2.yAxis, cachedRunningSpeed)
			end
		end
	end

	function setAnimationSpeed(speed)
		if currentAnim ~= "walk" then
			if speed ~= currentAnimSpeed then
				currentAnimSpeed = speed
				currentAnimTrack:AdjustSpeed(currentAnimSpeed)
			end
		end
	end

	function keyFrameReachedFunc(frameName)
		if (frameName == "End") then
			local repeatAnim = currentAnim
			-- return to idle if finishing an emote
			if (emoteNames[repeatAnim] ~= nil and emoteNames[repeatAnim] == false) then
				repeatAnim = "idle"
			end

			if currentlyPlayingEmote then
				if currentAnimTrack.Looped then
					-- Allow the emote to loop
					return
				end

				repeatAnim = "idle"
				currentlyPlayingEmote = false
			end

			local animSpeed = currentAnimSpeed
			playAnimation(repeatAnim, 0.15, Humanoid)
			setAnimationSpeed(animSpeed)
		end
	end

	function rollAnimation(animName)
		local roll = math.random(1, animTable[animName].totalWeight)
		local origRoll = roll
		local idx = 1
		while (roll > animTable[animName][idx].weight) do
			roll = roll - animTable[animName][idx].weight
			idx = idx + 1
		end
		return idx
	end

	local maxVeloX, minVeloX, maxVeloY, minVeloY

	local function destroyRunAnimations()
		for _,v in pairs(strafingLocomotionMap) do
			if v.track then
				v.track:Stop()
				v.track:Destroy()
				v.track = nil
			end
		end
		for _,v in pairs(fallbackLocomotionMap) do
			if v.track then
				v.track:Stop()
				v.track:Destroy()
				v.track = nil
			end
		end
		cachedRunningSpeed = 0
	end

	local function resetVelocityBounds(velo)
		minVeloX = 0
		maxVeloX = 0
		minVeloY = 0
		maxVeloY = 0
	end

	local function updateVelocityBounds(velo)
		if velo then 
			if velo.x > maxVeloX then maxVeloX = velo.x end
			if velo.y > maxVeloY then maxVeloY = velo.y end
			if velo.x < minVeloX then minVeloX = velo.x end
			if velo.y < minVeloY then minVeloY = velo.y end
		end
	end

	local function checkVelocityBounds(velo)
		if maxVeloX == 0 or minVeloX == 0 or maxVeloY == 0 or minVeloY == 0 then
			if locomotionMap == strafingLocomotionMap then
				warn("Strafe blending disabled.  Not all quadrants of motion represented.")
			end
			locomotionMap = fallbackLocomotionMap
		else
			locomotionMap = strafingLocomotionMap
		end
	end

	local function setupWalkAnimation(anim, animName, transitionTime, humanoid)
		resetVelocityBounds()
		-- check to see if we need to blend a walk/run animation
		for n,v in pairs(locomotionMap) do
			v.track = humanoid:LoadAnimation(animTable[n][1].anim)
			v.track.Priority = Enum.AnimationPriority.Core
			updateVelocityBounds(v.lv)
		end
		checkVelocityBounds()
	end

	local function switchToAnim(anim, animName, transitionTime, humanoid)
		-- switch animation		
		if (anim ~= currentAnimInstance) then

			if (currentAnimTrack ~= nil) then
				currentAnimTrack:Stop(transitionTime)
				currentAnimTrack:Destroy()
			end
			if (currentAnimKeyframeHandler ~= nil) then
				currentAnimKeyframeHandler:disconnect()
			end


			currentAnimSpeed = 1.0

			currentAnim = animName
			currentAnimInstance = anim	-- nil in the case of locomotion

			if animName == "walk" then
				setupWalkAnimation(anim, animName, transitionTime, humanoid)
			else
				destroyRunAnimations()
				-- load it to the humanoid; get AnimationTrack
				currentAnimTrack = humanoid:LoadAnimation(anim)
				currentAnimTrack.Priority = Enum.AnimationPriority.Core

				currentAnimTrack:Play(transitionTime)	

				-- set up keyframe name triggers
				currentAnimKeyframeHandler = currentAnimTrack.KeyframeReached:connect(keyFrameReachedFunc)
			end
		end
	end

	function playAnimation(animName, transitionTime, humanoid)
		local idx = rollAnimation(animName)
		local anim = animTable[animName][idx].anim

		switchToAnim(anim, animName, transitionTime, humanoid)
		currentlyPlayingEmote = false
	end

	function playEmote(emoteAnim, transitionTime, humanoid)
		switchToAnim(emoteAnim, emoteAnim.Name, transitionTime, humanoid)
		currentlyPlayingEmote = true
	end

	-------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------

	local toolAnimName = ""
	local toolAnimTrack = nil
	local toolAnimInstance = nil
	local currentToolAnimKeyframeHandler = nil

	function toolKeyFrameReachedFunc(frameName)
		if (frameName == "End") then
			playToolAnimation(toolAnimName, 0.0, Humanoid)
		end
	end


	function playToolAnimation(animName, transitionTime, humanoid, priority)
		local idx = rollAnimation(animName)
		local anim = animTable[animName][idx].anim

		if (toolAnimInstance ~= anim) then

			if (toolAnimTrack ~= nil) then
				toolAnimTrack:Stop()
				toolAnimTrack:Destroy()
				transitionTime = 0
			end

			-- load it to the humanoid; get AnimationTrack
			toolAnimTrack = humanoid:LoadAnimation(anim)
			if priority then
				toolAnimTrack.Priority = priority
			end

			-- play the animation
			toolAnimTrack:Play(transitionTime)
			toolAnimName = animName
			toolAnimInstance = anim

			currentToolAnimKeyframeHandler = toolAnimTrack.KeyframeReached:connect(toolKeyFrameReachedFunc)
		end
	end

	function stopToolAnimations()
		local oldAnim = toolAnimName

		if (currentToolAnimKeyframeHandler ~= nil) then
			currentToolAnimKeyframeHandler:disconnect()
		end

		toolAnimName = ""
		toolAnimInstance = nil
		if (toolAnimTrack ~= nil) then
			toolAnimTrack:Stop()
			toolAnimTrack:Destroy()
			toolAnimTrack = nil
		end

		return oldAnim
	end

	-------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------
	-- STATE CHANGE HANDLERS

	function onRunning(speed)
		local movedDuringEmote = currentlyPlayingEmote and Humanoid.MoveDirection == Vector3.new(0, 0, 0)
		local speedThreshold = movedDuringEmote and Humanoid.WalkSpeed or 0.75
		humanoidSpeed = speed
		if speed > speedThreshold then
			playAnimation("walk", 0.2, Humanoid)
			if pose ~= "Running" then
				pose = "Running"
				updateVelocity(0) -- Force velocity update in response to state change
			end
		else
			if emoteNames[currentAnim] == nil and not currentlyPlayingEmote then
				playAnimation("idle", 0.2, Humanoid)
				pose = "Standing"
			end
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
		local scale = 5.0
		playAnimation("climb", 0.1, Humanoid)
		setAnimationSpeed(speed / scale)
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
	end

	function onPlatformStanding()
		pose = "PlatformStanding"
	end

	-------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------

	function onSwimming(speed)
		if speed > 0 then
			pose = "Running"
		else
			pose = "Standing"
		end
	end

	function animateTool()
		if (toolAnim == "None") then
			playToolAnimation("toolnone", toolTransitionTime, Humanoid, Enum.AnimationPriority.Idle)
			return
		end

		if (toolAnim == "Slash") then
			playToolAnimation("toolslash", 0, Humanoid, Enum.AnimationPriority.Action)
			return
		end

		if (toolAnim == "Lunge") then
			playToolAnimation("toollunge", 0, Humanoid, Enum.AnimationPriority.Action)
			return
		end
	end

	function getToolAnim(tool)
		for _, c in ipairs(tool:GetChildren()) do
			if c.Name == "toolanim" and c.className == "StringValue" then
				return c
			end
		end
		return nil
	end

	local lastTick = 0

	function stepAnimate(currentTime)
		local amplitude = 1
		local frequency = 1
		local deltaTime = currentTime - lastTick
		lastTick = currentTime

		local climbFudge = 0
		local setAngles = false

		if (jumpAnimTime > 0) then
			jumpAnimTime = jumpAnimTime - deltaTime
		end

		if (pose == "FreeFall" and jumpAnimTime <= 0) then
			playAnimation("fall", fallTransitionTime, Humanoid)
		elseif (pose == "Seated") then
			playAnimation("sit", 0.5, Humanoid)
			return
		elseif (pose == "Running") then
			playAnimation("walk", 0.2, Humanoid)
			updateVelocity(currentTime)
		elseif (pose == "Dead" or pose == "GettingUp" or pose == "FallingDown" or pose == "Seated" or pose == "PlatformStanding") then
			stopAllAnimations()
			amplitude = 0.1
			frequency = 1
			setAngles = true
		end

		-- Tool Animation handling
		local tool = Character:FindFirstChildOfClass("Tool")
		if tool and tool:FindFirstChild("Handle") then
			local animStringValueObject = getToolAnim(tool)

			if animStringValueObject then
				toolAnim = animStringValueObject.Value
				-- message recieved, delete StringValue
				animStringValueObject.Parent = nil
				toolAnimTime = currentTime + .3
			end

			if currentTime > toolAnimTime then
				toolAnimTime = 0
				toolAnim = "None"
			end

			animateTool()
		else
			stopToolAnimations()
			toolAnim = "None"
			toolAnimInstance = nil
			toolAnimTime = 0
		end
	end


	-- connect events
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

	-- setup emote chat hook
	game:GetService("Players").LocalPlayer.Chatted:connect(function(msg)
		local emote = ""
		if (string.sub(msg, 1, 3) == "/e ") then
			emote = string.sub(msg, 4)
		elseif (string.sub(msg, 1, 7) == "/emote ") then
			emote = string.sub(msg, 8)
		end

		if (pose == "Standing" and emoteNames[emote] ~= nil) then
			playAnimation(emote, EMOTE_TRANSITION_TIME, Humanoid)
		end
	end)

	-- emote bindable hook
	script:WaitForChild("PlayEmote").OnInvoke = function(emote)
		-- Only play emotes when idling
		if pose ~= "Standing" then
			return
		end

		if emoteNames[emote] ~= nil then
			-- Default emotes
			playAnimation(emote, EMOTE_TRANSITION_TIME, Humanoid)

			return true, currentAnimTrack
		elseif typeof(emote) == "Instance" and emote:IsA("Animation") then
			-- Non-default emotes
			playEmote(emote, EMOTE_TRANSITION_TIME, Humanoid)

			return true, currentAnimTrack
		end

		-- Return false to indicate that the emote could not be played
		return false
	end

	if Character.Parent ~= nil then
		-- initialize to idle
		playAnimation("idle", 0.1, Humanoid)
		pose = "Standing"
	end

	-- loop to handle timed state transitions and tool animations
	task.spawn(function()
		while Character.Parent ~= nil do
			local _, currentGameTime = wait(0.1)
			stepAnimate(currentGameTime)
		end
	end)
end

RunCustomAnimation(plr.Character)

plr.CharacterAdded:Connect(function(Char)
	RunCustomAnimation(Char)
end)
        end},
    },
    f3x_Chaos = {
        {"Dyson sphere", function()
--[[
    F3X Power Sphere GUI
    Fixed + Modes: Idle, Click, Orbit, Spikes, Blackhole, etc.
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Cleanup
pcall(function()
    if CoreGui:FindFirstChild("F3XPowerGUI") then
        CoreGui.F3XPowerGUI:Destroy()
    end
end)

-- Settings
local Config = {
    Enabled = false,
    Mode = "Idle Pulse", -- Idle Pulse, Click Burst, Orbit, Spikes, Blackhole, Wave
    Radius = 22,
    PartCount = 36,
    SpinSpeed = 0.6,
    PulseSpeed = 2.2,
    PartSize = Vector3.new(3.5, 3.5, 3.5)
}

local ringParts = {}
local timePassed = 0
local Connections = {}

local function getRemote()
    local char = LocalPlayer.Character
    if not char then return nil end
    local tool = char:FindFirstChild("Building Tools") or LocalPlayer.Backpack:FindFirstChild("Building Tools")
    if not tool then return nil end
    local sync = tool:FindFirstChild("SyncAPI")
    return sync and sync:FindFirstChild("ServerEndpoint")
end

local function clearParts()
    local remote = getRemote()
    if remote then
        for _, data in ipairs(ringParts) do
            pcall(function()
                if data.part and data.part.Parent then
                    remote:InvokeServer("RemovePart", data.part)
                end
            end)
        end
    end
    table.clear(ringParts)
end

local function buildSphere()
    clearParts()
    local remote = getRemote()
    if not remote then
        warn("Building Tools not found / not equipped")
        return
    end

    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local phi = math.pi * (3 - math.sqrt(5))

    for i = 1, Config.PartCount do
        local y = 1 - (i / (Config.PartCount - 1)) * 2
        local r = math.sqrt(math.max(0, 1 - y * y))
        local theta = phi * i
        local vec = Vector3.new(math.cos(theta) * r, y, math.sin(theta) * r)

        local success, part = pcall(function()
            return remote:InvokeServer("CreatePart1", "Normal", CFrame.new(root.Position + vec * Config.Radius), workspace)
        end)

        if success and part then
            pcall(function()
                remote:InvokeServer("SyncResize1", {{Part = part, CFrame = part.CFrame, Size = Config.PartSize}})
                remote:InvokeServer("CreateDecorations", {{Part = part, DecorationType = "Fire"}})
            end)
            table.insert(ringParts, {part = part, vec = vec, base = vec})
        end

        if i % 6 == 0 then task.wait() end
    end
end

-- ================= GUI =================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "F3XPowerGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 270, 0, 360)
Main.Position = UDim2.new(0.5, -135, 0.5, -180)
Main.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 38)
Title.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
Title.Text = "  F3X Power Sphere"
Title.TextColor3 = Color3.fromRGB(0, 200, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 15
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Main
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 10)

local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0, 30, 0, 30)
Close.Position = UDim2.new(1, -34, 0, 4)
Close.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
Close.Text = "×"
Close.TextColor3 = Color3.fromRGB(255, 80, 80)
Close.Font = Enum.Font.GothamBold
Close.TextSize = 16
Close.Parent = Main
Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 6)

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -16, 1, -50)
Content.Position = UDim2.new(0, 8, 0, 44)
Content.BackgroundTransparency = 1
Content.Parent = Main

local List = Instance.new("UIListLayout")
List.Padding = UDim.new(0, 8)
List.Parent = Content

local function CreateButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 34)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(230, 230, 230)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 13
    btn.Parent = Content
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 7)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, 0, 0, 28)
Status.BackgroundTransparency = 1
Status.Text = "Status: Idle"
Status.TextColor3 = Color3.fromRGB(160, 160, 160)
Status.Font = Enum.Font.Gotham
Status.TextSize = 13
Status.Parent = Content

CreateButton("Build Sphere", function()
    Status.Text = "Status: Building..."
    task.spawn(function()
        buildSphere()
        Status.Text = "Status: Built (" .. #ringParts .. " parts)"
    end)
end)

CreateButton("Clear All", function()
    clearParts()
    Config.Enabled = false
    Status.Text = "Status: Cleared"
end)

local Modes = {"Idle Pulse", "Orbit", "Spikes", "Blackhole", "Wave", "Click Burst"}
local modeIndex = 1

CreateButton("Mode: " .. Config.Mode, function(btn)
    modeIndex = modeIndex % #Modes + 1
    Config.Mode = Modes[modeIndex]
    btn.Text = "Mode: " .. Config.Mode
end)

CreateButton("Toggle Power (ON/OFF)", function()
    Config.Enabled = not Config.Enabled
    Status.Text = Config.Enabled and "Status: Active - " .. Config.Mode or "Status: Stopped"
end)

-- Drag
local dragging, dragStart, startPos
Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)
Title.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

Close.MouseButton1Click:Connect(function()
    clearParts()
    for _, c in pairs(Connections) do pcall(function() c:Disconnect() end) end
    ScreenGui:Destroy()
end)

-- ================= POWER LOOP =================
table.insert(Connections, RunService.Heartbeat:Connect(function(dt)
    if not Config.Enabled or #ringParts == 0 then return end

    local remote = getRemote()
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not remote or not root then return end

    timePassed = timePassed + dt
    local wave = (math.sin(timePassed * Config.PulseSpeed) + 1) / 2

    local moveData = {}
    local colorData = {}
    local fireData = {}

    local rotation = CFrame.Angles(0, timePassed * Config.SpinSpeed, timePassed * (Config.SpinSpeed * 0.5))

    for i, data in ipairs(ringParts) do
        local p = data.part
        if p and p.Parent then
            local vec = data.vec
            local finalPos

            if Config.Mode == "Idle Pulse" then
                finalPos = root.Position + (rotation * vec * Config.Radius)
            elseif Config.Mode == "Orbit" then
                finalPos = root.Position + (rotation * vec * (Config.Radius + wave * 6))
            elseif Config.Mode == "Spikes" then
                local spike = 1 + math.abs(math.sin(timePassed * 3 + i)) * 1.8
                finalPos = root.Position + (rotation * vec * Config.Radius * spike)
            elseif Config.Mode == "Blackhole" then
                local pull = 1 - (wave * 0.7)
                finalPos = root.Position + (rotation * vec * Config.Radius * pull)
            elseif Config.Mode == "Wave" then
                local extra = math.sin(timePassed * 4 + i * 0.3) * 8
                finalPos = root.Position + (rotation * vec * Config.Radius) + Vector3.new(0, extra, 0)
            else -- Click Burst default
                finalPos = root.Position + (rotation * vec * Config.Radius)
            end

            table.insert(moveData, {Part = p, CFrame = CFrame.new(finalPos, root.Position)})
            table.insert(colorData, {Part = p, Color = Color3.new(0, wave * 0.6, wave), UnionColoring = true})
            table.insert(fireData, {Part = p, DecsheetsType = "Fire", Size = 4 + wave * 16, Color = Color3.new(0, 0.6, 1)})
        end
    end

    if #moveData > 0 then
        pcall(function()
            remote:InvokeServer("SyncMove1", moveData)
            remote:InvokeServer("SyncColor1", colorData)
            remote:InvokeServer("SyncDecorate", fireData)
        end)
    end
end))

-- Click Burst
Mouse.Button1Down:Connect(function()
    if Config.Mode == "Click Burst" and Config.Enabled and #ringParts > 0 then
        local remote = getRemote()
        local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not remote or not root then return end

        local moveData = {}
        for _, data in ipairs(ringParts) do
            if data.part and data.part.Parent then
                local burst = root.Position + (data.vec * (Config.Radius * 2.2))
                table.insert(moveData, {Part = data.part, CFrame = CFrame.new(burst)})
            end
        end
        pcall(function() remote:InvokeServer("SyncMove1", moveData) end)
        task.wait(0.15)
    end
end)

print("F3X Power Sphere GUI loaded")
        end},
        {"RC7 Cloud (F3X)", function()
--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
--// Script: RC7 Cloud F3X \\ --
--// Creator: ItsKittyyyGD \\ --
-- CODE/SOURCE (OPEN):

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local tool

for _, v in player:GetDescendants() do
    if v.Name == "SyncAPI" then
        tool = v.Parent
    end
end

for _, v in game.ReplicatedStorage:GetDescendants() do
    if v.Name == "SyncAPI" then
        tool = v.Parent
    end
end

local remote = tool.SyncAPI.ServerEndpoint

function _(args)
    remote:InvokeServer(unpack(args))
end

function SetCollision(part, boolean)
    local args = {"SyncCollision", {{Part = part, CanCollide = boolean}}}
    _(args)
end

function SetAnchor(boolean, part)
    local args = {"SyncAnchor", {{Part = part, Anchored = boolean}}}
    _(args)
end

function CreatePart(cf, parent)
    local args = {"CreatePart", "Normal", cf, parent}
    _(args)
end

function AddMesh(part)
    local args = {"CreateMeshes", {{Part = part}}}
    _(args)
end

function SetMesh(part, meshid)
    local args = {"SyncMesh", {{Part = part, MeshId = "rbxassetid://" .. meshid}}}
    _(args)
end

function MeshResize(part, size)
    local args = {"SyncMesh", {{Part = part, Scale = size}}}
    _(args)
end

function SetColor(part, color)
    local args = {"SyncColor", {{Part = part, Color = color, UnionColoring = false}}}
    _(args)
end

function MovePart(part, cf)
    local args = {"SyncMove", {{Part = part, CFrame = cf}}}
    _(args)
end

function CreateCloud()
    local head = char:WaitForChild("Head")
    local cf = head.CFrame + Vector3.new(0, 6, 0)
    CreatePart(cf, workspace)
    task.spawn(function()
        repeat task.wait() until (function()
            for _, v in workspace:GetDescendants() do
                if v:IsA("BasePart") and (v.Position - cf.Position).Magnitude < 0.5 then
                    SetAnchor(true, v)
                    SetCollision(v, false)
                    SetColor(v, BrickColor.new(333).Color)
                    AddMesh(v)
                    SetMesh(v, "111820358")
                    MeshResize(v, Vector3.new(8, 8, 8))
                    task.spawn(function()
                        game:GetService("RunService").RenderStepped:Connect(function()
                            if char and char:FindFirstChild("Head") then
                                MovePart(v, char.Head.CFrame + Vector3.new(0, 6, 0))
                            end
                        end)
                    end)
                    return true
                end
            end
        end)()
    end)
end

CreateCloud()

-- i can quit because theres more scripters f3x better than me. This can be my last script but,¿who knows?
        end},
        {"NA", function()

        end},
        {"pickle gui v2 f3x", function()
loadstring(game:HttpGet('https://api.junkie-development.de/api/v1/luascripts/public/c8a1b6cdfa92d7391fe2e9a583466299cdb59f4891d226920493ee63059d1915/download'))()
        end},

        {"k00pkidd F3x Gui", function()
        loadstring(game:HttpGet("https://pastebin.com/PNyR27xY", true))()
        end},

        {"F3Xsploit 2.0", function()
--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
--[=[
 d888b  db    db d888888b      .d888b.      db      db    db  .d8b.  
88' Y8b 88    88   `88'        VP  `8D      88      88    88 d8' `8b 
88      88    88    88            odD'      88      88    88 88ooo88 
88  ooo 88    88    88          .88'        88      88    88 88~~~88 
88. ~8~ 88b  d88   .88.        j88.         88booo. 88b  d88 88   88    @uniquadev
 Y888P  ~Y8888P' Y888888P      888888D      Y88888P ~Y8888P' YP   YP  CONVERTER 
]=]

-- Instances: 170 | Scripts: 28 | Modules: 0 | Tags: 0
local G2L = {};

-- StarterGui.FU
G2L["1"] = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"));
G2L["1"]["Name"] = [[FU]];
G2L["1"]["ResetOnSpawn"] = false;


-- StarterGui.FU.reagon
G2L["2"] = Instance.new("Frame", G2L["1"]);
G2L["2"]["Visible"] = false;
G2L["2"]["BorderSizePixel"] = 0;
G2L["2"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["2"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["2"]["Size"] = UDim2.new(0.57339, 0, 0.55305, 0);
G2L["2"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["2"]["Name"] = [[reagon]];
G2L["2"]["BackgroundTransparency"] = 0.9;


-- StarterGui.FU.reagon.UICorner
G2L["3"] = Instance.new("UICorner", G2L["2"]);



-- StarterGui.FU.reagon.UIStroke
G2L["4"] = Instance.new("UIStroke", G2L["2"]);
G2L["4"]["Transparency"] = 0.4;
G2L["4"]["Thickness"] = 1.5;
G2L["4"]["Color"] = Color3.fromRGB(255, 255, 255);


-- StarterGui.FU.reagon.UIAspectRatioConstraint
G2L["5"] = Instance.new("UIAspectRatioConstraint", G2L["2"]);
G2L["5"]["AspectRatio"] = 1.6988;


-- StarterGui.FU.reagon.TextLabel
G2L["6"] = Instance.new("TextLabel", G2L["2"]);
G2L["6"]["TextWrapped"] = true;
G2L["6"]["BorderSizePixel"] = 0;
G2L["6"]["TextSize"] = 14;
G2L["6"]["TextScaled"] = true;
G2L["6"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["6"]["FontFace"] = Font.new([[rbxassetid://12187365364]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["6"]["TextColor3"] = Color3.fromRGB(255, 150, 0);
G2L["6"]["BackgroundTransparency"] = 1;
G2L["6"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["6"]["Size"] = UDim2.new(0.14365, 0, 0.16545, 0);
G2L["6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["6"]["Text"] = [[F3X]];
G2L["6"]["Position"] = UDim2.new(0.09511, 0, 0.1101, 0);


-- StarterGui.FU.reagon.TextLabel
G2L["7"] = Instance.new("TextLabel", G2L["2"]);
G2L["7"]["TextWrapped"] = true;
G2L["7"]["BorderSizePixel"] = 0;
G2L["7"]["TextSize"] = 14;
G2L["7"]["TextScaled"] = true;
G2L["7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["7"]["FontFace"] = Font.new([[rbxassetid://12187365364]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["7"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["7"]["BackgroundTransparency"] = 1;
G2L["7"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["7"]["Size"] = UDim2.new(0.14365, 0, 0.16545, 0);
G2L["7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["7"]["Text"] = [[SER]];
G2L["7"]["Position"] = UDim2.new(0.22762, 0, 0.1101, 0);


-- StarterGui.FU.reagon.Destruction
G2L["8"] = Instance.new("Frame", G2L["2"]);
G2L["8"]["BorderSizePixel"] = 0;
G2L["8"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["8"]["Size"] = UDim2.new(0.94256, 0, 0.59964, 0);
G2L["8"]["Position"] = UDim2.new(0.02328, 0, 0.25883, 0);
G2L["8"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["8"]["Name"] = [[Destruction]];
G2L["8"]["BackgroundTransparency"] = 0.9;


-- StarterGui.FU.reagon.Destruction.UIStroke
G2L["9"] = Instance.new("UIStroke", G2L["8"]);
G2L["9"]["Transparency"] = 0.8;
G2L["9"]["Thickness"] = 1.5;
G2L["9"]["Color"] = Color3.fromRGB(255, 255, 255);


-- StarterGui.FU.reagon.Destruction.UICorner
G2L["a"] = Instance.new("UICorner", G2L["8"]);



-- StarterGui.FU.reagon.Destruction.TextLabel
G2L["b"] = Instance.new("TextLabel", G2L["8"]);
G2L["b"]["TextWrapped"] = true;
G2L["b"]["BorderSizePixel"] = 0;
G2L["b"]["TextSize"] = 14;
G2L["b"]["TextScaled"] = true;
G2L["b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["b"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["b"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["b"]["BackgroundTransparency"] = 1;
G2L["b"]["Size"] = UDim2.new(0.33512, 0, 0.09868, 0);
G2L["b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["b"]["Text"] = [[DESTRUCTION]];
G2L["b"]["Position"] = UDim2.new(0.33101, 0, -0.09868, 0);


-- StarterGui.FU.reagon.Destruction.sky
G2L["c"] = Instance.new("TextButton", G2L["8"]);
G2L["c"]["TextWrapped"] = true;
G2L["c"]["BorderSizePixel"] = 0;
G2L["c"]["TextSize"] = 14;
G2L["c"]["TextScaled"] = true;
G2L["c"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["c"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["c"]["BackgroundTransparency"] = 0.9;
G2L["c"]["Size"] = UDim2.new(0.08011, 0, 0.12917, 0);
G2L["c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["c"]["Text"] = [[Sky]];
G2L["c"]["Name"] = [[sky]];
G2L["c"]["Position"] = UDim2.new(0.017, 0, 0.121, 0);


-- StarterGui.FU.reagon.Destruction.sky.UICorner
G2L["d"] = Instance.new("UICorner", G2L["c"]);



-- StarterGui.FU.reagon.Destruction.sky.UIStroke
G2L["e"] = Instance.new("UIStroke", G2L["c"]);
G2L["e"]["Transparency"] = 0.8;
G2L["e"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["e"]["Thickness"] = 1.5;
G2L["e"]["Color"] = Color3.fromRGB(255, 255, 255);


-- StarterGui.FU.reagon.Destruction.sky.TextBox
G2L["f"] = Instance.new("TextBox", G2L["c"]);
G2L["f"]["BorderSizePixel"] = 0;
G2L["f"]["TextWrapped"] = true;
G2L["f"]["TextSize"] = 14;
G2L["f"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["f"]["TextScaled"] = true;
G2L["f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["f"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["f"]["PlaceholderText"] = [[ID]];
G2L["f"]["Size"] = UDim2.new(1.97826, 0, 1, 0);
G2L["f"]["Position"] = UDim2.new(1.25094, 0, 0, 0);
G2L["f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["f"]["Text"] = [[]];
G2L["f"]["BackgroundTransparency"] = 0.9;


-- StarterGui.FU.reagon.Destruction.sky.TextBox.UIStroke
G2L["10"] = Instance.new("UIStroke", G2L["f"]);
G2L["10"]["Transparency"] = 0.8;
G2L["10"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["10"]["Thickness"] = 1.5;
G2L["10"]["Color"] = Color3.fromRGB(255, 255, 255);


-- StarterGui.FU.reagon.Destruction.sky.TextBox.UICorner
G2L["11"] = Instance.new("UICorner", G2L["f"]);



-- StarterGui.FU.reagon.Destruction.sky.LocalScript
G2L["12"] = Instance.new("LocalScript", G2L["c"]);



-- StarterGui.FU.reagon.Destruction.decal
G2L["13"] = Instance.new("TextButton", G2L["8"]);
G2L["13"]["TextWrapped"] = true;
G2L["13"]["BorderSizePixel"] = 0;
G2L["13"]["TextSize"] = 14;
G2L["13"]["TextScaled"] = true;
G2L["13"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["13"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["13"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["13"]["BackgroundTransparency"] = 0.9;
G2L["13"]["Size"] = UDim2.new(0.08011, 0, 0.13588, 0);
G2L["13"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["13"]["Text"] = [[Decal]];
G2L["13"]["Name"] = [[decal]];
G2L["13"]["Position"] = UDim2.new(0.017, 0, 0.29658, 0);


-- StarterGui.FU.reagon.Destruction.decal.UICorner
G2L["14"] = Instance.new("UICorner", G2L["13"]);



-- StarterGui.FU.reagon.Destruction.decal.UIStroke
G2L["15"] = Instance.new("UIStroke", G2L["13"]);
G2L["15"]["Transparency"] = 0.8;
G2L["15"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["15"]["Thickness"] = 1.5;
G2L["15"]["Color"] = Color3.fromRGB(255, 255, 255);


-- StarterGui.FU.reagon.Destruction.decal.TextBox
G2L["16"] = Instance.new("TextBox", G2L["13"]);
G2L["16"]["BorderSizePixel"] = 0;
G2L["16"]["TextWrapped"] = true;
G2L["16"]["TextSize"] = 14;
G2L["16"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["16"]["TextScaled"] = true;
G2L["16"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["16"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["16"]["PlaceholderText"] = [[ID]];
G2L["16"]["Size"] = UDim2.new(1.97826, 0, 1, 0);
G2L["16"]["Position"] = UDim2.new(1.25094, 0, 0, 0);
G2L["16"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["16"]["Text"] = [[]];
G2L["16"]["BackgroundTransparency"] = 0.9;


-- StarterGui.FU.reagon.Destruction.decal.TextBox.UIStroke
G2L["17"] = Instance.new("UIStroke", G2L["16"]);
G2L["17"]["Transparency"] = 0.8;
G2L["17"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["17"]["Thickness"] = 1.5;
G2L["17"]["Color"] = Color3.fromRGB(255, 255, 255);


-- StarterGui.FU.reagon.Destruction.decal.TextBox.UICorner
G2L["18"] = Instance.new("UICorner", G2L["16"]);



-- StarterGui.FU.reagon.Destruction.decal.LocalScript
G2L["19"] = Instance.new("LocalScript", G2L["13"]);



-- StarterGui.FU.reagon.Destruction.666
G2L["1a"] = Instance.new("TextButton", G2L["8"]);
G2L["1a"]["TextWrapped"] = true;
G2L["1a"]["BorderSizePixel"] = 0;
G2L["1a"]["TextSize"] = 14;
G2L["1a"]["TextScaled"] = true;
G2L["1a"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1a"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["1a"]["BackgroundTransparency"] = 0.9;
G2L["1a"]["Size"] = UDim2.new(0.10376, 0, 0.15242, 0);
G2L["1a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1a"]["Text"] = [[666]];
G2L["1a"]["Name"] = [[666]];
G2L["1a"]["Position"] = UDim2.new(0.31921, 0, 0.121, 0);


-- StarterGui.FU.reagon.Destruction.666.UICorner
G2L["1b"] = Instance.new("UICorner", G2L["1a"]);



-- StarterGui.FU.reagon.Destruction.666.UIStroke
G2L["1c"] = Instance.new("UIStroke", G2L["1a"]);
G2L["1c"]["Transparency"] = 0.8;
G2L["1c"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["1c"]["Thickness"] = 1.5;
G2L["1c"]["Color"] = Color3.fromRGB(255, 255, 255);


-- StarterGui.FU.reagon.Destruction.666.LocalScript
G2L["1d"] = Instance.new("LocalScript", G2L["1a"]);



-- StarterGui.FU.reagon.Destruction.color
G2L["1e"] = Instance.new("TextButton", G2L["8"]);
G2L["1e"]["TextWrapped"] = true;
G2L["1e"]["BorderSizePixel"] = 0;
G2L["1e"]["TextSize"] = 14;
G2L["1e"]["TextScaled"] = true;
G2L["1e"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1e"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["1e"]["BackgroundTransparency"] = 0.9;
G2L["1e"]["Size"] = UDim2.new(0.10376, 0, 0.15242, 0);
G2L["1e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1e"]["Text"] = [[Color]];
G2L["1e"]["Name"] = [[color]];
G2L["1e"]["Position"] = UDim2.new(0.31921, 0, 0.32422, 0);


-- StarterGui.FU.reagon.Destruction.color.UICorner
G2L["1f"] = Instance.new("UICorner", G2L["1e"]);



-- StarterGui.FU.reagon.Destruction.color.UIStroke
G2L["20"] = Instance.new("UIStroke", G2L["1e"]);
G2L["20"]["Transparency"] = 0.8;
G2L["20"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["20"]["Thickness"] = 1.5;
G2L["20"]["Color"] = Color3.fromRGB(255, 255, 255);


-- StarterGui.FU.reagon.Destruction.color.LocalScript
G2L["21"] = Instance.new("LocalScript", G2L["1e"]);



-- StarterGui.FU.reagon.Destruction.Unanchor
G2L["22"] = Instance.new("TextButton", G2L["8"]);
G2L["22"]["TextWrapped"] = true;
G2L["22"]["BorderSizePixel"] = 0;
G2L["22"]["TextSize"] = 14;
G2L["22"]["TextScaled"] = true;
G2L["22"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["22"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["22"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["22"]["BackgroundTransparency"] = 0.9;
G2L["22"]["Size"] = UDim2.new(0.10376, 0, 0.15242, 0);
G2L["22"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["22"]["Text"] = [[Unanchor]];
G2L["22"]["Name"] = [[Unanchor]];
G2L["22"]["Position"] = UDim2.new(0.43876, 0, 0.121, 0);


-- StarterGui.FU.reagon.Destruction.Unanchor.UICorner
G2L["23"] = Instance.new("UICorner", G2L["22"]);



-- StarterGui.FU.reagon.Destruction.Unanchor.UIStroke
G2L["24"] = Instance.new("UIStroke", G2L["22"]);
G2L["24"]["Transparency"] = 0.8;
G2L["24"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["24"]["Thickness"] = 1.5;
G2L["24"]["Color"] = Color3.fromRGB(255, 255, 255);


-- StarterGui.FU.reagon.Destruction.Unanchor.LocalScript
G2L["25"] = Instance.new("LocalScript", G2L["22"]);



-- StarterGui.FU.reagon.Destruction.Delete
G2L["26"] = Instance.new("TextButton", G2L["8"]);
G2L["26"]["TextWrapped"] = true;
G2L["26"]["BorderSizePixel"] = 0;
G2L["26"]["TextSize"] = 14;
G2L["26"]["TextScaled"] = true;
G2L["26"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["26"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["26"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["26"]["BackgroundTransparency"] = 0.9;
G2L["26"]["Size"] = UDim2.new(0.10376, 0, 0.15242, 0);
G2L["26"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["26"]["Text"] = [[Delete]];
G2L["26"]["Name"] = [[Delete]];
G2L["26"]["Position"] = UDim2.new(0.43876, 0, 0.32422, 0);


-- StarterGui.FU.reagon.Destruction.Delete.UICorner
G2L["27"] = Instance.new("UICorner", G2L["26"]);



-- StarterGui.FU.reagon.Destruction.Delete.UIStroke
G2L["28"] = Instance.new("UIStroke", G2L["26"]);
G2L["28"]["Transparency"] = 0.8;
G2L["28"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["28"]["Thickness"] = 1.5;
G2L["28"]["Color"] = Color3.fromRGB(255, 255, 255);


-- StarterGui.FU.reagon.Destruction.Delete.LocalScript
G2L["29"] = Instance.new("LocalScript", G2L["26"]);



-- StarterGui.FU.reagon.Destruction.Frame
G2L["2a"] = Instance.new("Frame", G2L["8"]);
G2L["2a"]["BorderSizePixel"] = 0;
G2L["2a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["2a"]["Size"] = UDim2.new(0.01095, 0, 0.93458, 0);
G2L["2a"]["Position"] = UDim2.new(0.293, 0, 0.02804, 0);
G2L["2a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["2a"]["BackgroundTransparency"] = 0.8;


-- StarterGui.FU.reagon.Destruction.KillAll
G2L["2b"] = Instance.new("TextButton", G2L["8"]);
G2L["2b"]["TextWrapped"] = true;
G2L["2b"]["BorderSizePixel"] = 0;
G2L["2b"]["TextSize"] = 14;
G2L["2b"]["TextScaled"] = true;
G2L["2b"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["2b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["2b"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["2b"]["BackgroundTransparency"] = 0.9;
G2L["2b"]["Size"] = UDim2.new(0.10376, 0, 0.15242, 0);
G2L["2b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["2b"]["Text"] = [[Kill]];
G2L["2b"]["Name"] = [[KillAll]];
G2L["2b"]["Position"] = UDim2.new(0.56056, 0, 0.121, 0);


-- StarterGui.FU.reagon.Destruction.KillAll.UICorner
G2L["2c"] = Instance.new("UICorner", G2L["2b"]);



-- StarterGui.FU.reagon.Destruction.KillAll.UIStroke
G2L["2d"] = Instance.new("UIStroke", G2L["2b"]);
G2L["2d"]["Transparency"] = 0.8;
G2L["2d"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["2d"]["Thickness"] = 1.5;
G2L["2d"]["Color"] = Color3.fromRGB(255, 255, 255);


-- StarterGui.FU.reagon.Destruction.KillAll.LocalScript
G2L["2e"] = Instance.new("LocalScript", G2L["2b"]);



-- StarterGui.FU.reagon.Destruction.sparklez
G2L["2f"] = Instance.new("TextButton", G2L["8"]);
G2L["2f"]["TextWrapped"] = true;
G2L["2f"]["BorderSizePixel"] = 0;
G2L["2f"]["TextSize"] = 14;
G2L["2f"]["TextScaled"] = true;
G2L["2f"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["2f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["2f"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["2f"]["BackgroundTransparency"] = 0.9;
G2L["2f"]["Size"] = UDim2.new(0.10376, 0, 0.15242, 0);
G2L["2f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["2f"]["Text"] = [[Sparkles]];
G2L["2f"]["Name"] = [[sparklez]];
G2L["2f"]["Position"] = UDim2.new(0.56056, 0, 0.32422, 0);


-- StarterGui.FU.reagon.Destruction.sparklez.UICorner
G2L["30"] = Instance.new("UICorner", G2L["2f"]);



-- StarterGui.FU.reagon.Destruction.sparklez.UIStroke
G2L["31"] = Instance.new("UIStroke", G2L["2f"]);
G2L["31"]["Transparency"] = 0.8;
G2L["31"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["31"]["Thickness"] = 1.5;
G2L["31"]["Color"] = Color3.fromRGB(255, 255, 255);


-- StarterGui.FU.reagon.Destruction.sparklez.LocalScript
G2L["32"] = Instance.new("LocalScript", G2L["2f"]);



-- StarterGui.FU.reagon.Destruction.base
G2L["33"] = Instance.new("TextButton", G2L["8"]);
G2L["33"]["TextWrapped"] = true;
G2L["33"]["BorderSizePixel"] = 0;
G2L["33"]["TextSize"] = 14;
G2L["33"]["TextScaled"] = true;
G2L["33"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["33"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["33"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["33"]["BackgroundTransparency"] = 0.9;
G2L["33"]["Size"] = UDim2.new(0.10348, 0, 0.15222, 0);
G2L["33"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["33"]["Text"] = [[Baseplate]];
G2L["33"]["Name"] = [[base]];
G2L["33"]["Position"] = UDim2.new(0.68247, 0, 0.12099, 0);


-- StarterGui.FU.reagon.Destruction.base.UICorner
G2L["34"] = Instance.new("UICorner", G2L["33"]);



-- StarterGui.FU.reagon.Destruction.base.UIStroke
G2L["35"] = Instance.new("UIStroke", G2L["33"]);
G2L["35"]["Transparency"] = 0.8;
G2L["35"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["35"]["Thickness"] = 1.5;
G2L["35"]["Color"] = Color3.fromRGB(255, 255, 255);


-- StarterGui.FU.reagon.Destruction.base.LocalScript
G2L["36"] = Instance.new("LocalScript", G2L["33"]);



-- StarterGui.FU.reagon.Destruction.part
G2L["37"] = Instance.new("TextButton", G2L["8"]);
G2L["37"]["TextWrapped"] = true;
G2L["37"]["BorderSizePixel"] = 0;
G2L["37"]["TextSize"] = 14;
G2L["37"]["TextScaled"] = true;
G2L["37"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["37"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["37"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["37"]["BackgroundTransparency"] = 0.9;
G2L["37"]["Size"] = UDim2.new(0.10348, 0, 0.15222, 0);
G2L["37"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["37"]["Text"] = [[Spawn Parts]];
G2L["37"]["Name"] = [[part]];
G2L["37"]["Position"] = UDim2.new(0.68151, 0, 0.32422, 0);


-- StarterGui.FU.reagon.Destruction.part.UICorner
G2L["38"] = Instance.new("UICorner", G2L["37"]);



-- StarterGui.FU.reagon.Destruction.part.UIStroke
G2L["39"] = Instance.new("UIStroke", G2L["37"]);
G2L["39"]["Transparency"] = 0.8;
G2L["39"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["39"]["Thickness"] = 1.5;
G2L["39"]["Color"] = Color3.fromRGB(255, 255, 255);


-- StarterGui.FU.reagon.Destruction.part.LocalScript
G2L["3a"] = Instance.new("LocalScript", G2L["37"]);



-- StarterGui.FU.reagon.Destruction.rain
G2L["3b"] = Instance.new("TextButton", G2L["8"]);
G2L["3b"]["TextWrapped"] = true;
G2L["3b"]["BorderSizePixel"] = 0;
G2L["3b"]["TextSize"] = 14;
G2L["3b"]["TextScaled"] = true;
G2L["3b"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["3b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["3b"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["3b"]["BackgroundTransparency"] = 0.9;
G2L["3b"]["Size"] = UDim2.new(0.08011, 0, 0.13588, 0);
G2L["3b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["3b"]["Text"] = [[Rain]];
G2L["3b"]["Name"] = [[rain]];
G2L["3b"]["Position"] = UDim2.new(0.017, 0, 0.47442, 0);


-- StarterGui.FU.reagon.Destruction.rain.UICorner
G2L["3c"] = Instance.new("UICorner", G2L["3b"]);



-- StarterGui.FU.reagon.Destruction.rain.UIStroke
G2L["3d"] = Instance.new("UIStroke", G2L["3b"]);
G2L["3d"]["Transparency"] = 0.8;
G2L["3d"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["3d"]["Thickness"] = 1.5;
G2L["3d"]["Color"] = Color3.fromRGB(255, 255, 255);


-- StarterGui.FU.reagon.Destruction.rain.mesh
G2L["3e"] = Instance.new("TextBox", G2L["3b"]);
G2L["3e"]["Name"] = [[mesh]];
G2L["3e"]["BorderSizePixel"] = 0;
G2L["3e"]["TextWrapped"] = true;
G2L["3e"]["TextSize"] = 14;
G2L["3e"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["3e"]["TextScaled"] = true;
G2L["3e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["3e"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["3e"]["PlaceholderText"] = [[Mesh]];
G2L["3e"]["Size"] = UDim2.new(0.89955, 0, 1, 0);
G2L["3e"]["Position"] = UDim2.new(1.25094, 0, 0, 0);
G2L["3e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["3e"]["Text"] = [[]];
G2L["3e"]["BackgroundTransparency"] = 0.9;


-- StarterGui.FU.reagon.Destruction.rain.mesh.UIStroke
G2L["3f"] = Instance.new("UIStroke", G2L["3e"]);
G2L["3f"]["Transparency"] = 0.8;
G2L["3f"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["3f"]["Thickness"] = 1.5;
G2L["3f"]["Color"] = Color3.fromRGB(255, 255, 255);


-- StarterGui.FU.reagon.Destruction.rain.mesh.UICorner
G2L["40"] = Instance.new("UICorner", G2L["3e"]);



-- StarterGui.FU.reagon.Destruction.rain.LocalScript
G2L["41"] = Instance.new("LocalScript", G2L["3b"]);



-- StarterGui.FU.reagon.Destruction.rain.texture
G2L["42"] = Instance.new("TextBox", G2L["3b"]);
G2L["42"]["Name"] = [[texture]];
G2L["42"]["BorderSizePixel"] = 0;
G2L["42"]["TextWrapped"] = true;
G2L["42"]["TextSize"] = 14;
G2L["42"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["42"]["TextScaled"] = true;
G2L["42"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["42"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["42"]["PlaceholderText"] = [[Texture]];
G2L["42"]["Size"] = UDim2.new(0.89955, 0, 1, 0);
G2L["42"]["Position"] = UDim2.new(2.32965, 0, 0, 0);
G2L["42"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["42"]["Text"] = [[]];
G2L["42"]["BackgroundTransparency"] = 0.9;


-- StarterGui.FU.reagon.Destruction.rain.texture.UIStroke
G2L["43"] = Instance.new("UIStroke", G2L["42"]);
G2L["43"]["Transparency"] = 0.8;
G2L["43"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["43"]["Thickness"] = 1.5;
G2L["43"]["Color"] = Color3.fromRGB(255, 255, 255);


-- StarterGui.FU.reagon.Destruction.rain.texture.UICorner
G2L["44"] = Instance.new("UICorner", G2L["42"]);



-- StarterGui.FU.reagon.Destruction.rain.size
G2L["45"] = Instance.new("TextBox", G2L["3b"]);
G2L["45"]["Name"] = [[size]];
G2L["45"]["BorderSizePixel"] = 0;
G2L["45"]["TextWrapped"] = true;
G2L["45"]["TextSize"] = 14;
G2L["45"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["45"]["TextScaled"] = true;
G2L["45"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["45"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["45"]["PlaceholderText"] = [[Size]];
G2L["45"]["Size"] = UDim2.new(1.97826, 0, 0.82714, 0);
G2L["45"]["Position"] = UDim2.new(1.25094, 0, 1.16063, 0);
G2L["45"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["45"]["Text"] = [[]];
G2L["45"]["BackgroundTransparency"] = 0.9;


-- StarterGui.FU.reagon.Destruction.rain.size.UIStroke
G2L["46"] = Instance.new("UIStroke", G2L["45"]);
G2L["46"]["Transparency"] = 0.8;
G2L["46"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["46"]["Thickness"] = 1.5;
G2L["46"]["Color"] = Color3.fromRGB(255, 255, 255);


-- StarterGui.FU.reagon.Destruction.rain.size.UICorner
G2L["47"] = Instance.new("UICorner", G2L["45"]);



-- StarterGui.FU.reagon.Destruction.Realm
G2L["48"] = Instance.new("TextButton", G2L["8"]);
G2L["48"]["TextWrapped"] = true;
G2L["48"]["BorderSizePixel"] = 0;
G2L["48"]["TextSize"] = 14;
G2L["48"]["TextScaled"] = true;
G2L["48"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["48"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["48"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["48"]["BackgroundTransparency"] = 0.9;
G2L["48"]["Size"] = UDim2.new(0.10376, 0, 0.15242, 0);
G2L["48"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["48"]["Text"] = [[Realm]];
G2L["48"]["Name"] = [[Realm]];
G2L["48"]["Position"] = UDim2.new(0.80014, 0, 0.121, 0);


-- StarterGui.FU.reagon.Destruction.Realm.UICorner
G2L["49"] = Instance.new("UICorner", G2L["48"]);



-- StarterGui.FU.reagon.Destruction.Realm.UIStroke
G2L["4a"] = Instance.new("UIStroke", G2L["48"]);
G2L["4a"]["Transparency"] = 0.8;
G2L["4a"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["4a"]["Thickness"] = 1.5;
G2L["4a"]["Color"] = Color3.fromRGB(255, 255, 255);


-- StarterGui.FU.reagon.Destruction.Realm.LocalScript
G2L["4b"] = Instance.new("LocalScript", G2L["48"]);



-- StarterGui.FU.reagon.Destruction.Spawns
G2L["4c"] = Instance.new("TextButton", G2L["8"]);
G2L["4c"]["TextWrapped"] = true;
G2L["4c"]["BorderSizePixel"] = 0;
G2L["4c"]["TextSize"] = 14;
G2L["4c"]["TextScaled"] = true;
G2L["4c"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["4c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["4c"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["4c"]["BackgroundTransparency"] = 0.9;
G2L["4c"]["Size"] = UDim2.new(0.10376, 0, 0.15242, 0);
G2L["4c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["4c"]["Text"] = [[Remove all Spawns]];
G2L["4c"]["Name"] = [[Spawns]];
G2L["4c"]["Position"] = UDim2.new(0.7994, 0, 0.32358, 0);


-- StarterGui.FU.reagon.Destruction.Spawns.UICorner
G2L["4d"] = Instance.new("UICorner", G2L["4c"]);



-- StarterGui.FU.reagon.Destruction.Spawns.UIStroke
G2L["4e"] = Instance.new("UIStroke", G2L["4c"]);
G2L["4e"]["Transparency"] = 0.8;
G2L["4e"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["4e"]["Thickness"] = 1.5;
G2L["4e"]["Color"] = Color3.fromRGB(255, 255, 255);


-- StarterGui.FU.reagon.Destruction.Spawns.LocalScript
G2L["4f"] = Instance.new("LocalScript", G2L["4c"]);



-- StarterGui.FU.reagon.Destruction.mesh
G2L["50"] = Instance.new("TextButton", G2L["8"]);
G2L["50"]["TextWrapped"] = true;
G2L["50"]["BorderSizePixel"] = 0;
G2L["50"]["TextSize"] = 14;
G2L["50"]["TextScaled"] = true;
G2L["50"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["50"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["50"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["50"]["BackgroundTransparency"] = 0.9;
G2L["50"]["Size"] = UDim2.new(0.10376, 0, 0.15242, 0);
G2L["50"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["50"]["Text"] = [[Mesh all]];
G2L["50"]["Name"] = [[mesh]];
G2L["50"]["Position"] = UDim2.new(0.31921, 0, 0.52306, 0);


-- StarterGui.FU.reagon.Destruction.mesh.UICorner
G2L["51"] = Instance.new("UICorner", G2L["50"]);



-- StarterGui.FU.reagon.Destruction.mesh.UIStroke
G2L["52"] = Instance.new("UIStroke", G2L["50"]);
G2L["52"]["Transparency"] = 0.8;
G2L["52"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["52"]["Thickness"] = 1.5;
G2L["52"]["Color"] = Color3.fromRGB(255, 255, 255);


-- StarterGui.FU.reagon.Destruction.mesh.LocalScript
G2L["53"] = Instance.new("LocalScript", G2L["50"]);



-- StarterGui.FU.reagon.Destruction.bw
G2L["54"] = Instance.new("TextButton", G2L["8"]);
G2L["54"]["TextWrapped"] = true;
G2L["54"]["BorderSizePixel"] = 0;
G2L["54"]["TextSize"] = 14;
G2L["54"]["TextScaled"] = true;
G2L["54"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["54"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["54"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["54"]["BackgroundTransparency"] = 0.9;
G2L["54"]["Size"] = UDim2.new(0.10376, 0, 0.15242, 0);
G2L["54"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["54"]["Text"] = [[Black and white]];
G2L["54"]["Name"] = [[bw]];
G2L["54"]["Position"] = UDim2.new(0.43762, 0, 0.52088, 0);


-- StarterGui.FU.reagon.Destruction.bw.UICorner
G2L["55"] = Instance.new("UICorner", G2L["54"]);



-- StarterGui.FU.reagon.Destruction.bw.UIStroke
G2L["56"] = Instance.new("UIStroke", G2L["54"]);
G2L["56"]["Transparency"] = 0.8;
G2L["56"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["56"]["Thickness"] = 1.5;
G2L["56"]["Color"] = Color3.fromRGB(255, 255, 255);


-- StarterGui.FU.reagon.Destruction.bw.LocalScript
G2L["57"] = Instance.new("LocalScript", G2L["54"]);



-- StarterGui.FU.reagon.Destruction.grass
G2L["58"] = Instance.new("TextButton", G2L["8"]);
G2L["58"]["TextWrapped"] = true;
G2L["58"]["BorderSizePixel"] = 0;
G2L["58"]["TextSize"] = 14;
G2L["58"]["TextScaled"] = true;
G2L["58"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["58"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["58"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["58"]["BackgroundTransparency"] = 0.9;
G2L["58"]["Size"] = UDim2.new(0.10376, 0, 0.15242, 0);
G2L["58"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["58"]["Text"] = [[Grass block all]];
G2L["58"]["Name"] = [[grass]];
G2L["58"]["Position"] = UDim2.new(0.56036, 0, 0.52088, 0);


-- StarterGui.FU.reagon.Destruction.grass.UICorner
G2L["59"] = Instance.new("UICorner", G2L["58"]);



-- StarterGui.FU.reagon.Destruction.grass.UIStroke
G2L["5a"] = Instance.new("UIStroke", G2L["58"]);
G2L["5a"]["Transparency"] = 0.8;
G2L["5a"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["5a"]["Thickness"] = 1.5;
G2L["5a"]["Color"] = Color3.fromRGB(255, 255, 255);


-- StarterGui.FU.reagon.Destruction.grass.LocalScript
G2L["5b"] = Instance.new("LocalScript", G2L["58"]);



-- StarterGui.FU.reagon.Destruction.material
G2L["5c"] = Instance.new("TextButton", G2L["8"]);
G2L["5c"]["TextWrapped"] = true;
G2L["5c"]["BorderSizePixel"] = 0;
G2L["5c"]["TextSize"] = 14;
G2L["5c"]["TextScaled"] = true;
G2L["5c"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["5c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["5c"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["5c"]["BackgroundTransparency"] = 0.9;
G2L["5c"]["Size"] = UDim2.new(0.08011, 0, 0.12917, 0);
G2L["5c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["5c"]["Text"] = [[Material]];
G2L["5c"]["Name"] = [[material]];
G2L["5c"]["Position"] = UDim2.new(0.017, 0, 0.80352, 0);


-- StarterGui.FU.reagon.Destruction.material.UICorner
G2L["5d"] = Instance.new("UICorner", G2L["5c"]);



-- StarterGui.FU.reagon.Destruction.material.UIStroke
G2L["5e"] = Instance.new("UIStroke", G2L["5c"]);
G2L["5e"]["Transparency"] = 0.8;
G2L["5e"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["5e"]["Thickness"] = 1.5;
G2L["5e"]["Color"] = Color3.fromRGB(255, 255, 255);


-- StarterGui.FU.reagon.Destruction.material.TextBox
G2L["5f"] = Instance.new("TextBox", G2L["5c"]);
G2L["5f"]["BorderSizePixel"] = 0;
G2L["5f"]["TextWrapped"] = true;
G2L["5f"]["TextSize"] = 14;
G2L["5f"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["5f"]["TextScaled"] = true;
G2L["5f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["5f"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["5f"]["PlaceholderText"] = [[String]];
G2L["5f"]["Size"] = UDim2.new(1.97826, 0, 1, 0);
G2L["5f"]["Position"] = UDim2.new(1.25094, 0, 0, 0);
G2L["5f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["5f"]["Text"] = [[]];
G2L["5f"]["BackgroundTransparency"] = 0.9;


-- StarterGui.FU.reagon.Destruction.material.TextBox.UIStroke
G2L["60"] = Instance.new("UIStroke", G2L["5f"]);
G2L["60"]["Transparency"] = 0.8;
G2L["60"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["60"]["Thickness"] = 1.5;
G2L["60"]["Color"] = Color3.fromRGB(255, 255, 255);


-- StarterGui.FU.reagon.Destruction.material.TextBox.UICorner
G2L["61"] = Instance.new("UICorner", G2L["5f"]);



-- StarterGui.FU.reagon.Destruction.material.LocalScript
G2L["62"] = Instance.new("LocalScript", G2L["5c"]);



-- StarterGui.FU.reagon.Assets
G2L["63"] = Instance.new("Folder", G2L["2"]);
G2L["63"]["Name"] = [[Assets]];


-- StarterGui.FU.reagon.Assets.666
G2L["64"] = Instance.new("Decal", G2L["63"]);
-- [ERROR] cannot convert TextureContent, please report to "https://github.com/uniquadev/GuiToLuaConverter/issues"
G2L["64"]["Name"] = [[666]];
G2L["64"]["Texture"] = [[http://www.roblox.com/asset/?id=18308643059]];


-- StarterGui.FU.reagon.Assets.White Background
G2L["65"] = Instance.new("Decal", G2L["63"]);
-- [ERROR] cannot convert TextureContent, please report to "https://github.com/uniquadev/GuiToLuaConverter/issues"
G2L["65"]["Name"] = [[White Background]];
G2L["65"]["Texture"] = [[http://www.roblox.com/asset/?id=10995799876]];


-- StarterGui.FU.reagon.tab
G2L["66"] = Instance.new("Frame", G2L["2"]);
G2L["66"]["BorderSizePixel"] = 0;
G2L["66"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["66"]["Size"] = UDim2.new(0.943, 0, 0.09693, 0);
G2L["66"]["Position"] = UDim2.new(0.02177, 0, 0.88212, 0);
G2L["66"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["66"]["Name"] = [[tab]];
G2L["66"]["BackgroundTransparency"] = 0.95;


-- StarterGui.FU.reagon.tab.UIStroke
G2L["67"] = Instance.new("UIStroke", G2L["66"]);
G2L["67"]["Transparency"] = 0.8;
G2L["67"]["Thickness"] = 1.5;
G2L["67"]["Color"] = Color3.fromRGB(255, 255, 255);


-- StarterGui.FU.reagon.tab.UICorner
G2L["68"] = Instance.new("UICorner", G2L["66"]);



-- StarterGui.FU.reagon.tab.UIListLayout
G2L["69"] = Instance.new("UIListLayout", G2L["66"]);
G2L["69"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
G2L["69"]["VerticalFlex"] = Enum.UIFlexAlignment.SpaceEvenly;
G2L["69"]["Padding"] = UDim.new(0, 25);
G2L["69"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
G2L["69"]["FillDirection"] = Enum.FillDirection.Horizontal;


-- StarterGui.FU.reagon.tab.d
G2L["6a"] = Instance.new("TextButton", G2L["66"]);
G2L["6a"]["TextWrapped"] = true;
G2L["6a"]["BorderSizePixel"] = 0;
G2L["6a"]["TextSize"] = 14;
G2L["6a"]["TextScaled"] = true;
G2L["6a"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["6a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["6a"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["6a"]["BackgroundTransparency"] = 0.9;
G2L["6a"]["Size"] = UDim2.new(0.05908, 0, 0.77596, 0);
G2L["6a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["6a"]["Text"] = [[D]];
G2L["6a"]["Name"] = [[d]];
G2L["6a"]["Position"] = UDim2.new(0.46898, 0, 0.11202, 0);


-- StarterGui.FU.reagon.tab.d.UIStroke
G2L["6b"] = Instance.new("UIStroke", G2L["6a"]);
G2L["6b"]["Transparency"] = 0.8;
G2L["6b"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["6b"]["Thickness"] = 1.5;
G2L["6b"]["Color"] = Color3.fromRGB(255, 255, 255);


-- StarterGui.FU.reagon.tab.d.UICorner
G2L["6c"] = Instance.new("UICorner", G2L["6a"]);



-- StarterGui.FU.reagon.tab.d.LocalScript
G2L["6d"] = Instance.new("LocalScript", G2L["6a"]);



-- StarterGui.FU.reagon.tab.lp
G2L["6e"] = Instance.new("TextButton", G2L["66"]);
G2L["6e"]["TextWrapped"] = true;
G2L["6e"]["BorderSizePixel"] = 0;
G2L["6e"]["TextSize"] = 14;
G2L["6e"]["TextScaled"] = true;
G2L["6e"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["6e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["6e"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["6e"]["BackgroundTransparency"] = 0.9;
G2L["6e"]["Size"] = UDim2.new(0.05908, 0, 0.77596, 0);
G2L["6e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["6e"]["Text"] = [[LP]];
G2L["6e"]["Name"] = [[lp]];
G2L["6e"]["Position"] = UDim2.new(0.46898, 0, 0.11202, 0);


-- StarterGui.FU.reagon.tab.lp.UIStroke
G2L["6f"] = Instance.new("UIStroke", G2L["6e"]);
G2L["6f"]["Transparency"] = 0.8;
G2L["6f"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["6f"]["Thickness"] = 1.5;
G2L["6f"]["Color"] = Color3.fromRGB(255, 255, 255);


-- StarterGui.FU.reagon.tab.lp.UICorner
G2L["70"] = Instance.new("UICorner", G2L["6e"]);



-- StarterGui.FU.reagon.tab.lp.LocalScript
G2L["71"] = Instance.new("LocalScript", G2L["6e"]);



-- StarterGui.FU.reagon.LocalPlayer
G2L["72"] = Instance.new("Frame", G2L["2"]);
G2L["72"]["Visible"] = false;
G2L["72"]["BorderSizePixel"] = 0;
G2L["72"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["72"]["Size"] = UDim2.new(0.94256, 0, 0.59964, 0);
G2L["72"]["Position"] = UDim2.new(0.02328, 0, 0.25883, 0);
G2L["72"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["72"]["Name"] = [[LocalPlayer]];
G2L["72"]["BackgroundTransparency"] = 0.9;


-- StarterGui.FU.reagon.LocalPlayer.UIStroke
G2L["73"] = Instance.new("UIStroke", G2L["72"]);
G2L["73"]["Transparency"] = 0.8;
G2L["73"]["Thickness"] = 1.5;
G2L["73"]["Color"] = Color3.fromRGB(255, 255, 255);


-- StarterGui.FU.reagon.LocalPlayer.UICorner
G2L["74"] = Instance.new("UICorner", G2L["72"]);



-- StarterGui.FU.reagon.LocalPlayer.TextLabel
G2L["75"] = Instance.new("TextLabel", G2L["72"]);
G2L["75"]["TextWrapped"] = true;
G2L["75"]["BorderSizePixel"] = 0;
G2L["75"]["TextSize"] = 14;
G2L["75"]["TextScaled"] = true;
G2L["75"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["75"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["75"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["75"]["BackgroundTransparency"] = 1;
G2L["75"]["Size"] = UDim2.new(0.33512, 0, 0.09868, 0);
G2L["75"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["75"]["Text"] = [[LOCAL PLAYER]];
G2L["75"]["Position"] = UDim2.new(0.33101, 0, -0.09868, 0);


-- StarterGui.FU.reagon.LocalPlayer.eraser
G2L["76"] = Instance.new("TextButton", G2L["72"]);
G2L["76"]["TextWrapped"] = true;
G2L["76"]["BorderSizePixel"] = 0;
G2L["76"]["TextSize"] = 14;
G2L["76"]["TextScaled"] = true;
G2L["76"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["76"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["76"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["76"]["BackgroundTransparency"] = 0.9;
G2L["76"]["Size"] = UDim2.new(0.10376, 0, 0.15242, 0);
G2L["76"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["76"]["Text"] = [[Eraser of death]];
G2L["76"]["Name"] = [[eraser]];
G2L["76"]["Position"] = UDim2.new(0.02298, 0, 0.19219, 0);


-- StarterGui.FU.reagon.LocalPlayer.eraser.UICorner
G2L["77"] = Instance.new("UICorner", G2L["76"]);



-- StarterGui.FU.reagon.LocalPlayer.eraser.UIStroke
G2L["78"] = Instance.new("UIStroke", G2L["76"]);
G2L["78"]["Transparency"] = 0.8;
G2L["78"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["78"]["Thickness"] = 1.5;
G2L["78"]["Color"] = Color3.fromRGB(255, 255, 255);


-- StarterGui.FU.reagon.LocalPlayer.eraser.LocalScript
G2L["79"] = Instance.new("LocalScript", G2L["76"]);



-- StarterGui.FU.reagon.LocalPlayer.Frame
G2L["7a"] = Instance.new("Frame", G2L["72"]);
G2L["7a"]["BorderSizePixel"] = 0;
G2L["7a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["7a"]["Size"] = UDim2.new(0.00915, 0, 0.94131, 0);
G2L["7a"]["Position"] = UDim2.new(0.293, 0, 0.03164, 0);
G2L["7a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["7a"]["BackgroundTransparency"] = 0.8;


-- StarterGui.FU.reagon.LocalPlayer.tools
G2L["7b"] = Instance.new("TextLabel", G2L["72"]);
G2L["7b"]["TextWrapped"] = true;
G2L["7b"]["BorderSizePixel"] = 0;
G2L["7b"]["TextSize"] = 14;
G2L["7b"]["TextScaled"] = true;
G2L["7b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["7b"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["7b"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["7b"]["BackgroundTransparency"] = 1;
G2L["7b"]["Size"] = UDim2.new(0.30177, 0, 0.09888, 0);
G2L["7b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["7b"]["Text"] = [[Tools]];
G2L["7b"]["Name"] = [[tools]];
G2L["7b"]["Position"] = UDim2.new(0, 0, 0.03164, 0);


-- StarterGui.FU.reagon.LocalPlayer.draw
G2L["7c"] = Instance.new("TextButton", G2L["72"]);
G2L["7c"]["TextWrapped"] = true;
G2L["7c"]["BorderSizePixel"] = 0;
G2L["7c"]["TextSize"] = 14;
G2L["7c"]["TextScaled"] = true;
G2L["7c"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["7c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["7c"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["7c"]["BackgroundTransparency"] = 0.9;
G2L["7c"]["Size"] = UDim2.new(0.10376, 0, 0.15242, 0);
G2L["7c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["7c"]["Text"] = [[Draw]];
G2L["7c"]["Name"] = [[draw]];
G2L["7c"]["Position"] = UDim2.new(0.16369, 0, 0.19219, 0);


-- StarterGui.FU.reagon.LocalPlayer.draw.UICorner
G2L["7d"] = Instance.new("UICorner", G2L["7c"]);



-- StarterGui.FU.reagon.LocalPlayer.draw.UIStroke
G2L["7e"] = Instance.new("UIStroke", G2L["7c"]);
G2L["7e"]["Transparency"] = 0.8;
G2L["7e"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["7e"]["Thickness"] = 1.5;
G2L["7e"]["Color"] = Color3.fromRGB(255, 255, 255);


-- StarterGui.FU.reagon.LocalPlayer.draw.LocalScript
G2L["7f"] = Instance.new("LocalScript", G2L["7c"]);



-- StarterGui.FU.reagon.LocalPlayer.Stoneify
G2L["80"] = Instance.new("TextButton", G2L["72"]);
G2L["80"]["TextWrapped"] = true;
G2L["80"]["BorderSizePixel"] = 0;
G2L["80"]["TextSize"] = 14;
G2L["80"]["TextScaled"] = true;
G2L["80"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["80"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["80"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["80"]["BackgroundTransparency"] = 0.9;
G2L["80"]["Size"] = UDim2.new(0.10376, 0, 0.15242, 0);
G2L["80"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["80"]["Text"] = [[Stoneify]];
G2L["80"]["Name"] = [[Stoneify]];
G2L["80"]["Position"] = UDim2.new(0.02179, 0, 0.42104, 0);


-- StarterGui.FU.reagon.LocalPlayer.Stoneify.UICorner
G2L["81"] = Instance.new("UICorner", G2L["80"]);



-- StarterGui.FU.reagon.LocalPlayer.Stoneify.UIStroke
G2L["82"] = Instance.new("UIStroke", G2L["80"]);
G2L["82"]["Transparency"] = 0.8;
G2L["82"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["82"]["Thickness"] = 1.5;
G2L["82"]["Color"] = Color3.fromRGB(255, 255, 255);


-- StarterGui.FU.reagon.LocalPlayer.Stoneify.LocalScript
G2L["83"] = Instance.new("LocalScript", G2L["80"]);



-- StarterGui.FU.reagon.LocalPlayer.char
G2L["84"] = Instance.new("TextLabel", G2L["72"]);
G2L["84"]["TextWrapped"] = true;
G2L["84"]["BorderSizePixel"] = 0;
G2L["84"]["TextSize"] = 14;
G2L["84"]["TextScaled"] = true;
G2L["84"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["84"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["84"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["84"]["BackgroundTransparency"] = 1;
G2L["84"]["Size"] = UDim2.new(0.66143, 0, 0.09888, 0);
G2L["84"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["84"]["Text"] = [[Character]];
G2L["84"]["Name"] = [[char]];
G2L["84"]["Position"] = UDim2.new(0.32032, 0, 0.03164, 0);


-- StarterGui.FU.reagon.LocalPlayer.jondotrill
G2L["85"] = Instance.new("TextButton", G2L["72"]);
G2L["85"]["TextWrapped"] = true;
G2L["85"]["BorderSizePixel"] = 0;
G2L["85"]["TextSize"] = 14;
G2L["85"]["TextScaled"] = true;
G2L["85"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["85"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["85"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["85"]["BackgroundTransparency"] = 0.9;
G2L["85"]["Size"] = UDim2.new(0.10376, 0, 0.15242, 0);
G2L["85"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["85"]["Text"] = [[John doe trail]];
G2L["85"]["Name"] = [[jondotrill]];
G2L["85"]["Position"] = UDim2.new(0.33066, 0, 0.19219, 0);


-- StarterGui.FU.reagon.LocalPlayer.jondotrill.UICorner
G2L["86"] = Instance.new("UICorner", G2L["85"]);



-- StarterGui.FU.reagon.LocalPlayer.jondotrill.UIStroke
G2L["87"] = Instance.new("UIStroke", G2L["85"]);
G2L["87"]["Transparency"] = 0.8;
G2L["87"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["87"]["Thickness"] = 1.5;
G2L["87"]["Color"] = Color3.fromRGB(255, 255, 255);


-- StarterGui.FU.reagon.LocalPlayer.jondotrill.LocalScript
G2L["88"] = Instance.new("LocalScript", G2L["85"]);



-- StarterGui.FU.reagon.LocalPlayer.bag
G2L["89"] = Instance.new("TextButton", G2L["72"]);
G2L["89"]["TextWrapped"] = true;
G2L["89"]["BorderSizePixel"] = 0;
G2L["89"]["TextSize"] = 14;
G2L["89"]["TextScaled"] = true;
G2L["89"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["89"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["89"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["89"]["BackgroundTransparency"] = 0.9;
G2L["89"]["Size"] = UDim2.new(0.10376, 0, 0.15242, 0);
G2L["89"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["89"]["Text"] = [[Money bag]];
G2L["89"]["Name"] = [[bag]];
G2L["89"]["Position"] = UDim2.new(0.16369, 0, 0.42104, 0);


-- StarterGui.FU.reagon.LocalPlayer.bag.UICorner
G2L["8a"] = Instance.new("UICorner", G2L["89"]);



-- StarterGui.FU.reagon.LocalPlayer.bag.UIStroke
G2L["8b"] = Instance.new("UIStroke", G2L["89"]);
G2L["8b"]["Transparency"] = 0.8;
G2L["8b"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["8b"]["Thickness"] = 1.5;
G2L["8b"]["Color"] = Color3.fromRGB(255, 255, 255);


-- StarterGui.FU.reagon.LocalPlayer.bag.LocalScript
G2L["8c"] = Instance.new("LocalScript", G2L["89"]);



-- StarterGui.FU.reagon.LocalPlayer.train
G2L["8d"] = Instance.new("TextButton", G2L["72"]);
G2L["8d"]["TextWrapped"] = true;
G2L["8d"]["BorderSizePixel"] = 0;
G2L["8d"]["TextSize"] = 14;
G2L["8d"]["TextScaled"] = true;
G2L["8d"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["8d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["8d"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["8d"]["BackgroundTransparency"] = 0.9;
G2L["8d"]["Size"] = UDim2.new(0.10376, 0, 0.15242, 0);
G2L["8d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["8d"]["Text"] = [[Thomas Engine]];
G2L["8d"]["Name"] = [[train]];
G2L["8d"]["Position"] = UDim2.new(0.45341, 0, 0.19219, 0);


-- StarterGui.FU.reagon.LocalPlayer.train.UICorner
G2L["8e"] = Instance.new("UICorner", G2L["8d"]);



-- StarterGui.FU.reagon.LocalPlayer.train.UIStroke
G2L["8f"] = Instance.new("UIStroke", G2L["8d"]);
G2L["8f"]["Transparency"] = 0.8;
G2L["8f"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["8f"]["Thickness"] = 1.5;
G2L["8f"]["Color"] = Color3.fromRGB(255, 255, 255);


-- StarterGui.FU.reagon.LocalPlayer.train.LocalScript
G2L["90"] = Instance.new("LocalScript", G2L["8d"]);



-- StarterGui.FU.SpectateGui
G2L["91"] = Instance.new("ScreenGui", G2L["1"]);
G2L["91"]["Name"] = [[SpectateGui]];
G2L["91"]["ResetOnSpawn"] = false;


-- StarterGui.FU.SpectateGui.Bar
G2L["92"] = Instance.new("Frame", G2L["91"]);
G2L["92"]["BorderSizePixel"] = 5;
G2L["92"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["92"]["Size"] = UDim2.new(0.15186, 0, 0.06219, 0);
G2L["92"]["Position"] = UDim2.new(-1.07593, 0, 0.81781, 0);
G2L["92"]["BorderColor3"] = Color3.fromRGB(28, 43, 54);
G2L["92"]["Name"] = [[Bar]];
G2L["92"]["BackgroundTransparency"] = 0.2;


-- StarterGui.FU.SpectateGui.Bar.Previous
G2L["93"] = Instance.new("TextButton", G2L["92"]);
G2L["93"]["BorderSizePixel"] = 0;
G2L["93"]["TextSize"] = 48;
G2L["93"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["93"]["BackgroundColor3"] = Color3.fromRGB(135, 135, 135);
G2L["93"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["93"]["Size"] = UDim2.new(0.25, 0, 1, 0);
G2L["93"]["BorderColor3"] = Color3.fromRGB(131, 204, 255);
G2L["93"]["Text"] = [[<]];
G2L["93"]["Name"] = [[Previous]];


-- StarterGui.FU.SpectateGui.Bar.Next
G2L["94"] = Instance.new("TextButton", G2L["92"]);
G2L["94"]["BorderSizePixel"] = 0;
G2L["94"]["TextSize"] = 48;
G2L["94"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["94"]["BackgroundColor3"] = Color3.fromRGB(135, 135, 135);
G2L["94"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["94"]["Size"] = UDim2.new(-0.25, 0, 1, 0);
G2L["94"]["BorderColor3"] = Color3.fromRGB(131, 204, 255);
G2L["94"]["Text"] = [[>]];
G2L["94"]["Name"] = [[Next]];
G2L["94"]["Position"] = UDim2.new(1, 0, 0, 0);


-- StarterGui.FU.SpectateGui.Bar.Title
G2L["95"] = Instance.new("TextLabel", G2L["92"]);
G2L["95"]["TextWrapped"] = true;
G2L["95"]["TextSize"] = 14;
G2L["95"]["TextScaled"] = true;
G2L["95"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["95"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["95"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["95"]["BackgroundTransparency"] = 1;
G2L["95"]["Size"] = UDim2.new(0.45, 0, 1, 0);
G2L["95"]["BorderColor3"] = Color3.fromRGB(28, 43, 54);
G2L["95"]["Text"] = [[]];
G2L["95"]["Name"] = [[Title]];
G2L["95"]["Position"] = UDim2.new(0.275, 0, 0, 0);


-- StarterGui.FU.SpectateGui.Button
G2L["96"] = Instance.new("ImageButton", G2L["91"]);
G2L["96"]["BorderSizePixel"] = 5;
G2L["96"]["BackgroundTransparency"] = 0.3;
-- [ERROR] cannot convert ImageContent, please report to "https://github.com/uniquadev/GuiToLuaConverter/issues"
G2L["96"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["96"]["Image"] = [[http://www.roblox.com/asset/?id=176106970]];
G2L["96"]["Size"] = UDim2.new(0.03797, 0, 0.06219, 0);
G2L["96"]["BorderColor3"] = Color3.fromRGB(28, 43, 54);
G2L["96"]["Name"] = [[Button]];
G2L["96"]["Position"] = UDim2.new(0.00607, 0, 0.44403, 0);


-- StarterGui.FU.SpectateGui.LocalScript
G2L["97"] = Instance.new("LocalScript", G2L["91"]);



-- StarterGui.FU.f3x
G2L["98"] = Instance.new("TextButton", G2L["1"]);
G2L["98"]["TextWrapped"] = true;
G2L["98"]["BorderSizePixel"] = 0;
G2L["98"]["TextSize"] = 14;
G2L["98"]["TextScaled"] = true;
G2L["98"]["TextColor3"] = Color3.fromRGB(255, 150, 0);
G2L["98"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["98"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["98"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["98"]["BackgroundTransparency"] = 0.9;
G2L["98"]["Size"] = UDim2.new(0.03791, 0, 0.06219, 0);
G2L["98"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["98"]["Text"] = [[F3X]];
G2L["98"]["Name"] = [[f3x]];
G2L["98"]["Position"] = UDim2.new(0.02578, 0, 0.95398, 0);


-- StarterGui.FU.f3x.UIStroke
G2L["99"] = Instance.new("UIStroke", G2L["98"]);
G2L["99"]["Transparency"] = 0.4;
G2L["99"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["99"]["Thickness"] = 1.5;
G2L["99"]["Color"] = Color3.fromRGB(255, 255, 255);


-- StarterGui.FU.f3x.UICorner
G2L["9a"] = Instance.new("UICorner", G2L["98"]);



-- StarterGui.FU.f3x.UIAspectRatioConstraint
G2L["9b"] = Instance.new("UIAspectRatioConstraint", G2L["98"]);
G2L["9b"]["AspectRatio"] = 1;


-- StarterGui.FU.f3x.LocalScript
G2L["9c"] = Instance.new("LocalScript", G2L["98"]);



-- StarterGui.FU.notification
G2L["9d"] = Instance.new("Frame", G2L["1"]);
G2L["9d"]["BorderSizePixel"] = 0;
G2L["9d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["9d"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["9d"]["Size"] = UDim2.new(0.14632, 0, 0.22182, 0);
G2L["9d"]["Position"] = UDim2.new(0.12661, 0, 0.87487, 0);
G2L["9d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["9d"]["Name"] = [[notification]];
G2L["9d"]["BackgroundTransparency"] = 0.9;


-- StarterGui.FU.notification.Frame
G2L["9e"] = Instance.new("Frame", G2L["9d"]);
G2L["9e"]["BorderSizePixel"] = 0;
G2L["9e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["9e"]["Size"] = UDim2.new(1, 0, 0.25503, 0);
G2L["9e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["9e"]["BackgroundTransparency"] = 0.8;


-- StarterGui.FU.notification.Frame.TextLabel
G2L["9f"] = Instance.new("TextLabel", G2L["9e"]);
G2L["9f"]["TextWrapped"] = true;
G2L["9f"]["BorderSizePixel"] = 0;
G2L["9f"]["TextSize"] = 14;
G2L["9f"]["TextScaled"] = true;
G2L["9f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["9f"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["9f"]["TextColor3"] = Color3.fromRGB(255, 150, 0);
G2L["9f"]["BackgroundTransparency"] = 1;
G2L["9f"]["Size"] = UDim2.new(0.34043, 0, 1, 0);
G2L["9f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["9f"]["Text"] = [[F3X]];
G2L["9f"]["Position"] = UDim2.new(0, 0, 0, 0);


-- StarterGui.FU.notification.Frame.TextLabel
G2L["a0"] = Instance.new("TextLabel", G2L["9e"]);
G2L["a0"]["TextWrapped"] = true;
G2L["a0"]["BorderSizePixel"] = 0;
G2L["a0"]["TextSize"] = 14;
G2L["a0"]["TextScaled"] = true;
G2L["a0"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["a0"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["a0"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["a0"]["BackgroundTransparency"] = 1;
G2L["a0"]["Size"] = UDim2.new(0.35396, 0, 1, 0);
G2L["a0"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["a0"]["Text"] = [[NOTIFICATION]];
G2L["a0"]["Position"] = UDim2.new(0.34043, 0, 0, 0);


-- StarterGui.FU.notification.Frame.x
G2L["a1"] = Instance.new("TextButton", G2L["9e"]);
G2L["a1"]["TextWrapped"] = true;
G2L["a1"]["BorderSizePixel"] = 0;
G2L["a1"]["TextSize"] = 14;
G2L["a1"]["TextScaled"] = true;
G2L["a1"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["a1"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["a1"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["a1"]["BackgroundTransparency"] = 0.9;
G2L["a1"]["Size"] = UDim2.new(0.16791, 0, 0.71141, 0);
G2L["a1"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["a1"]["Text"] = [[X]];
G2L["a1"]["Name"] = [[x]];
G2L["a1"]["Position"] = UDim2.new(0.80676, 0, 0.13004, 0);


-- StarterGui.FU.notification.Frame.x.UIStroke
G2L["a2"] = Instance.new("UIStroke", G2L["a1"]);
G2L["a2"]["Transparency"] = 0.4;
G2L["a2"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["a2"]["Thickness"] = 1.5;
G2L["a2"]["Color"] = Color3.fromRGB(255, 255, 255);


-- StarterGui.FU.notification.Frame.x.UICorner
G2L["a3"] = Instance.new("UICorner", G2L["a1"]);



-- StarterGui.FU.notification.Frame.x.UIAspectRatioConstraint
G2L["a4"] = Instance.new("UIAspectRatioConstraint", G2L["a1"]);



-- StarterGui.FU.notification.Frame.x.LocalScript
G2L["a5"] = Instance.new("LocalScript", G2L["a1"]);



-- StarterGui.FU.notification.Frame.UIAspectRatioConstraint
G2L["a6"] = Instance.new("UIAspectRatioConstraint", G2L["9e"]);
G2L["a6"]["AspectRatio"] = 4.23684;


-- StarterGui.FU.notification.UIStroke
G2L["a7"] = Instance.new("UIStroke", G2L["9d"]);
G2L["a7"]["Transparency"] = 0.4;
G2L["a7"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["a7"]["Thickness"] = 1.5;
G2L["a7"]["Color"] = Color3.fromRGB(255, 255, 255);


-- StarterGui.FU.notification.TextLabel
G2L["a8"] = Instance.new("TextLabel", G2L["9d"]);
G2L["a8"]["TextWrapped"] = true;
G2L["a8"]["BorderSizePixel"] = 0;
G2L["a8"]["TextSize"] = 14;
G2L["a8"]["TextScaled"] = true;
G2L["a8"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["a8"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["a8"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["a8"]["BackgroundTransparency"] = 1;
G2L["a8"]["Size"] = UDim2.new(0.90683, 0, 0.74497, 0);
G2L["a8"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["a8"]["Text"] = [[Hi there, thanks for using my F3X gui that i made. This is the final version of the ui so it will only have bug fixes.]];
G2L["a8"]["Position"] = UDim2.new(0.04348, 0, 0.25503, 0);


-- StarterGui.FU.notification.UIAspectRatioConstraint
G2L["a9"] = Instance.new("UIAspectRatioConstraint", G2L["9d"]);
G2L["a9"]["AspectRatio"] = 1.08054;


-- StarterGui.FU.notification.UICorner
G2L["aa"] = Instance.new("UICorner", G2L["9d"]);



-- StarterGui.FU.reagon.Destruction.sky.LocalScript
local function C_12()
local script = G2L["12"];
	script.Parent.Activated:Connect(function()
		local player = game.Players.LocalPlayer
		local char = player.Character
		local backpack = player.Backpack
	
		local function getf3x()
			for _, v in ipairs(backpack:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
			for _, v in ipairs(char:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
	
			return nil
		end
	
		-- get all info
	
		local f3x = getf3x()
		if not f3x then
			warn("you dont have f3x skid")
		end
		local syncapi = f3x.SyncAPI
		local serverendpoint = syncapi.ServerEndpoint
	
		-- name func
	
		local function name(part, stringa)
			local args = {
				[1] = "SetName",
				[2] = {
					[1] = part
				},
				[3] = stringa
			}
			serverendpoint:InvokeServer(unpack(args))
		end
		
		local function setcollision(part, booleana)
			local args = {
				[1] = "SyncCollision",
				[2] = {
					[1] = {
						["Part"] = part,
						["CanCollide"] = booleana
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
	
		local function lock(part, boolean)
			local args = {
				[1] = "SetLocked",
				[2] = {
					[1] = part
				},
				[3] = boolean
			}
			serverendpoint:InvokeServer(unpack(args))
		end
	
		-- sky func
	
		local function sky()
			spawn(function()
				local position = char.Head.Position
				local part = serverendpoint:InvokeServer("CreatePart", "Normal", CFrame.new(position + Vector3.new(0, 2, 0)), workspace)
				local args = {
					[1] = "CreateMeshes",
					[2] = {
						[1] = {
							["Part"] = part
						}
					}
				}
				serverendpoint:InvokeServer(unpack(args))
				local args = {
					[1] = "SyncMesh",
					[2] = {
						[1] = {
							["Part"] = part,
							["MeshId"] = "rbxassetid://8006679977"
						}
					}
				}
				serverendpoint:InvokeServer(unpack(args))
				local args = {
					[1] = "SyncMesh",
					[2] = {
						[1] = {
							["Part"] = part,
							["Scale"] = Vector3.new(90, 90, 90)
						}
					}
				}
				serverendpoint:InvokeServer(unpack(args))
				local args = {
					[1] = "SyncMesh",
					[2] = {
						[1] = {
							["Part"] = part,
							["TextureId"] =	"rbxassetid://"..script.Parent.TextBox.Text
						}
					}
				}
				serverendpoint:InvokeServer(unpack(args))
	
				name(part, "Sky")
				lock(part, true)
				setcollision(part, false)
			end)
		end
	
		sky()
	end)
end;
task.spawn(C_12);
-- StarterGui.FU.reagon.Destruction.decal.LocalScript
local function C_19()
local script = G2L["19"];
	script.Parent.Activated:Connect(function()
		local player = game.Players.LocalPlayer
		local char = player.Character
		local backpack = player.Backpack
	
		local function getf3x()
			for _, v in ipairs(backpack:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
			for _, v in ipairs(char:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
	
			return nil
		end
	
		-- get all info
	
		local f3x = getf3x()
		if not f3x then
			warn("you dont have f3x skid")
		end
		local syncapi = f3x.SyncAPI
		local serverendpoint = syncapi.ServerEndpoint
	
		local function createdecal(part, side)
			local args = {
				[1] = "CreateTextures",
				[2] = {
					[1] = {
						["Part"] = part,
						["Face"] = side,
						["TextureType"] = "Decal"
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
		local function setdecal(part, asset, side)
			local args = {
				[1] = "SyncTexture",
				[2] = {
					[1] = {
						["Part"] = part,
						["Face"] = side,
						["TextureType"] = "Decal",
						["Texture"] = "rbxassetid://".. asset
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
	
		local function decalspam()
			local decalid = script.Parent.TextBox.Text
			for _, v in ipairs(workspace:GetDescendants()) do
				if v:IsA("BasePart") or v:IsA("UnionOperation") then
					spawn(function()
						createdecal(v, Enum.NormalId.Front)
						createdecal(v, Enum.NormalId.Back)
						createdecal(v, Enum.NormalId.Left)
						createdecal(v, Enum.NormalId.Right)
						createdecal(v, Enum.NormalId.Bottom)
						createdecal(v, Enum.NormalId.Top)
	
						setdecal(v, decalid, Enum.NormalId.Front)
						setdecal(v, decalid, Enum.NormalId.Back)
						setdecal(v, decalid, Enum.NormalId.Left)
						setdecal(v, decalid, Enum.NormalId.Right)
						setdecal(v, decalid, Enum.NormalId.Bottom)
						setdecal(v, decalid, Enum.NormalId.Top)
					end)
				end
			end
		end
	
		decalspam()
	end)
end;
task.spawn(C_19);
-- StarterGui.FU.reagon.Destruction.666.LocalScript
local function C_1d()
local script = G2L["1d"];
	script.Parent.Activated:Connect(function()
		local player = game.Players.LocalPlayer
		local char = player.Character
		local backpack = player.Backpack
	
		local function getf3x()
			for _, v in ipairs(backpack:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
			for _, v in ipairs(char:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
	
			return nil
		end
	
		local f3x = getf3x()
		if not f3x then
			warn("you dont have f3x skid")
		end
		local syncapi = f3x.SyncAPI
		local serverendpoint = syncapi.ServerEndpoint
	
		local function name(part, stringa)
			local args = {
				[1] = "SetName",
				[2] = {
					[1] = part
				},
				[3] = stringa
			}
			serverendpoint:InvokeServer(unpack(args))
		end
	
		local function lock(part, boolean)
			local args = {
				[1] = "SetLocked",
				[2] = {
					[1] = part
				},
				[3] = boolean
			}
			serverendpoint:InvokeServer(unpack(args))
		end
	
		-- main func
	
		local function createdecal(part, side)
			local args = {
				[1] = "CreateTextures",
				[2] = {
					[1] = {
						["Part"] = part,
						["Face"] = side,
						["TextureType"] = "Decal"
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
		local function setdecal(part, asset, side)
			local args = {
				[1] = "SyncTexture",
				[2] = {
					[1] = {
						["Part"] = part,
						["Face"] = side,
						["TextureType"] = "Decal",
						["Texture"] = "rbxassetid://".. asset
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
	
		local function color(part, color)
			local args = {
				[1] = "SyncColor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Color"] = color --[[Color3]],
						["UnionColoring"] = false
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
	
		local function addfire(part)
			local args = {
				[1] = "CreateDecorations",
				[2] = {
					[1] = {
						["Part"] = part,
						["DecorationType"] = "Fire"
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
		
		local function syncfire(part, size, heat)
			local args = {
				[1] = "SyncDecorate",
				[2] = {
					[1] = {
						["Part"] = part,
						["DecorationType"] = "Fire",
						["Size"] = 30,
						["Heat"] = 35
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
		
		local function addlight(part, brightness)
			local args = {
				[1] = "CreateLights",
				[2] = {
					[1] = {
						["Part"] = part,
						["LightType"] = "PointLight"
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
		
		local function synclight(part, brightness)
			local args = {
				[1] = "SyncLighting",
				[2] = {
					[1] = {
						["Part"] = part,
						["LightType"] = "PointLight",
						["Brightness"] = brightness,
						["Color"] = Color3.new(1, 0, 0)
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
		
		local function setcollision(part, booleana)
			local args = {
				[1] = "SyncCollision",
				[2] = {
					[1] = {
						["Part"] = part,
						["CanCollide"] = booleana
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
	
		local function decalspam()
			local decalid = "96757457442198"
			for _, v in ipairs(workspace:GetDescendants()) do
				if v.Name == "Sky" then
					print("no")
				elseif v:IsA("BasePart") or v:IsA("UnionOperation") then
					spawn(function()
						createdecal(v, Enum.NormalId.Front)
						createdecal(v, Enum.NormalId.Back)
						createdecal(v, Enum.NormalId.Left)
						createdecal(v, Enum.NormalId.Right)
						createdecal(v, Enum.NormalId.Bottom)
						createdecal(v, Enum.NormalId.Top)
	
						setdecal(v, decalid, Enum.NormalId.Front)
						setdecal(v, decalid, Enum.NormalId.Back)
						setdecal(v, decalid, Enum.NormalId.Left)
						setdecal(v, decalid, Enum.NormalId.Right)
						setdecal(v, decalid, Enum.NormalId.Bottom)
						setdecal(v, decalid, Enum.NormalId.Top)
					end)
				end
			end
		end
		
		local function lightall()
			for _, v in ipairs(workspace:GetDescendants()) do
				if v:IsA("BasePart") or v:IsA("UnionOperation") then
					spawn(function()
						addlight(v)
						synclight(v, 15)
					end)
				end
			end
		end
	
		local function colorall()
			for _, v in ipairs(workspace:GetDescendants()) do
				if v:IsA("BasePart") or v:IsA("UnionOperation") then
					spawn(function()
						color(v, Color3.new(0.0666667, 0.0666667, 0.0666667))
					end)
				end
			end
		end
	
		local function sky666()
			spawn(function()
				local position = char.Head.Position
				local part = serverendpoint:InvokeServer("CreatePart", "Normal", CFrame.new(position + Vector3.new(0, 2, 0)), workspace)
				local args = {
					[1] = "CreateMeshes",
					[2] = {
						[1] = {
							["Part"] = part
						}
					}
				}
				serverendpoint:InvokeServer(unpack(args))
				local args = {
					[1] = "SyncMesh",
					[2] = {
						[1] = {
							["Part"] = part,
							["MeshId"] = "rbxassetid://8006679977"
						}
					}
				}
				serverendpoint:InvokeServer(unpack(args))
				local args = {
					[1] = "SyncMesh",
					[2] = {
						[1] = {
							["Part"] = part,
							["Scale"] = Vector3.new(90, 90, 90)
						}
					}
				}
				serverendpoint:InvokeServer(unpack(args))
				local args = {
					[1] = "SyncMesh",
					[2] = {
						[1] = {
							["Part"] = part,
							["TextureId"] =	"rbxassetid://15849970412"
						}
					}
				}
				serverendpoint:InvokeServer(unpack(args))
	
				name(part, "Sky")
				lock(part, true)
				setcollision(part, false)
			end)
		end
	
		local function fireall()
			for _, v in ipairs(workspace:GetDescendants()) do
				if v:IsA("BasePart") or v:IsA("UnionOperation") then
					spawn(function()
						addfire(v)
						syncfire(v)
					end)
				end
			end
		end
	
		local function sixsixsix()
			fireall()
			sky666()
			decalspam()
			colorall()
			lightall()
		end
	
		sixsixsix()
	end)
end;
task.spawn(C_1d);
-- StarterGui.FU.reagon.Destruction.color.LocalScript
local function C_21()
local script = G2L["21"];
	script.Parent.Activated:Connect(function()
		local player = game.Players.LocalPlayer
		local char = player.Character
		local backpack = player.Backpack
	
		local function getf3x()
			for _, v in ipairs(backpack:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
			for _, v in ipairs(char:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
	
			return nil
		end
	
		-- get all info
	
		local f3x = getf3x()
		if not f3x then
			warn("you dont have f3x skid")
		end
		local syncapi = f3x.SyncAPI
		local serverendpoint = syncapi.ServerEndpoint
	
		local function color(part, color)
			local args = {
				[1] = "SyncColor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Color"] = color --[[Color3]],
						["UnionColoring"] = false
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
	
	
		local function colorall()
			for _, v in ipairs(workspace:GetDescendants()) do
				if v:IsA("BasePart") or v:IsA("UnionOperation") then
					spawn(function()
						color(v,Color3.new(math.random(0,255),math.random(0,255),math.random(0,255)))
					end)
				end
			end
		end
		colorall()
	end)
end;
task.spawn(C_21);
-- StarterGui.FU.reagon.Destruction.Unanchor.LocalScript
local function C_25()
local script = G2L["25"];
	script.Parent.Activated:Connect(function()
		local player = game.Players.LocalPlayer
		local char = player.Character
		local backpack = player.Backpack
	
		local function getf3x()
			for _, v in ipairs(backpack:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
			for _, v in ipairs(char:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
	
			return nil
		end
	
		-- get all info
	
		local f3x = getf3x()
		if not f3x then
			warn("you dont have f3x skid")
		end
		local syncapi = f3x.SyncAPI
		local serverendpoint = syncapi.ServerEndpoint
	
		local function setanchor(part, boolean)
			local args = {
				[1] = "SyncAnchor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Anchored"] = boolean
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
	
		local function unanchorall()
			for _, v in ipairs(workspace:GetDescendants()) do
					if v:IsA("BasePart") or v:IsA("UnionOperation") then
					spawn(function()
						setanchor(v, false)
					end)
					end
			end
		end
	
		unanchorall()
	end)
end;
task.spawn(C_25);
-- StarterGui.FU.reagon.Destruction.Delete.LocalScript
local function C_29()
local script = G2L["29"];
	script.Parent.Activated:Connect(function()
		local player = game.Players.LocalPlayer
		local char = player.Character
		local backpack = player.Backpack
	
		local function getf3x()
			for _, v in ipairs(backpack:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
			for _, v in ipairs(char:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
	
			return nil
		end
	
		-- get all info
	
		local f3x = getf3x()
		if not f3x then
			warn("you dont have f3x skid")
		end
		local syncapi = f3x.SyncAPI
		local serverendpoint = syncapi.ServerEndpoint
	
		local function delete(part)
			local args = {
				[1] = "Remove",
				[2] = {
					[1] = part
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
	
		local function deleteall()
			for _, v in ipairs(workspace:GetDescendants()) do
				if v:IsA("BasePart") or v:IsA("UnionOperation") then
					spawn(function()
						delete(v)
					end)
				end
			end
		end
	
		deleteall()
	end)
end;
task.spawn(C_29);
-- StarterGui.FU.reagon.Destruction.KillAll.LocalScript
local function C_2e()
local script = G2L["2e"];
	script.Parent.Activated:Connect(function()
		local player = game.Players.LocalPlayer
		local char = player.Character
		local backpack = player.Backpack
	
		local function getf3x()
			for _, v in ipairs(backpack:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
			for _, v in ipairs(char:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
	
			return nil
		end
	
		-- get all info
	
		local f3x = getf3x()
		if not f3x then
			warn("you dont have f3x skid")
		end
		local syncapi = f3x.SyncAPI
		local serverendpoint = syncapi.ServerEndpoint
	
		local function delete(part)
			local args = {
				[1] = "Remove",
				[2] = {
					[1] = part
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
	
		local function killall()
			for _, v in ipairs(workspace:GetDescendants()) do
				if v.Parent:FindFirstChildOfClass("Humanoid") then
					spawn(function()
						delete(v.Parent.Head)
					end)
				end
			end
		end
	
		killall()
	end)
end;
task.spawn(C_2e);
-- StarterGui.FU.reagon.Destruction.sparklez.LocalScript
local function C_32()
local script = G2L["32"];
	script.Parent.Activated:Connect(function()
		local player = game.Players.LocalPlayer
		local char = player.Character
		local backpack = player.Backpack
	
		local function getf3x()
			for _, v in ipairs(backpack:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
			for _, v in ipairs(char:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
	
			return nil
		end
	
		-- get all info
	
		local f3x = getf3x()
		if not f3x then
			warn("you dont have f3x skid")
		end
		local syncapi = f3x.SyncAPI
		local serverendpoint = syncapi.ServerEndpoint
	
		local function addsparkles(part)
			local args = {
				[1] = "CreateDecorations",
				[2] = {
					[1] = {
						["Part"] = part,
						["DecorationType"] = "Sparkles"
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
	
		local function sparklesall()
			for _, v in ipairs(workspace:GetDescendants()) do
				if v:IsA("BasePart") or v:IsA("UnionOperation") then
					spawn(function()
						addsparkles(v)
					end)
				end
			end
		end
	
		sparklesall()
	end)
end;
task.spawn(C_32);
-- StarterGui.FU.reagon.Destruction.base.LocalScript
local function C_36()
local script = G2L["36"];
	script.Parent.Activated:Connect(function()
		local player = game.Players.LocalPlayer
		local char = player.Character
		local backpack = player.Backpack
	
		local function getf3x()
			for _, v in ipairs(backpack:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
			for _, v in ipairs(char:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
	
			return nil
		end
	
		-- get all info
	
		local f3x = getf3x()
		if not f3x then
			warn("you dont have f3x skid")
		end
		local syncapi = f3x.SyncAPI
		local serverendpoint = syncapi.ServerEndpoint
	
		local function resize(part,size,cf)
			local args = {
				[1] = "SyncResize",
				[2] = {
					[1] = {
						["Part"] = part,
						["CFrame"] = cf,
						["Size"] = size
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
	
		local function syncmaterial(part,mate)
			local args = {
				[1] = "SyncMaterial",
				[2] = {
					[1] = {
						["Part"] = part,
						["Material"] = mate
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
	
		local function color(part, color)
			local args = {
				[1] = "SyncColor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Color"] = color --[[Color3]],
						["UnionColoring"] = false
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
	
	
		local function makebaseplate()
			local position = char.Head.Position + Vector3.new(0, -20, 0)
			spawn(function()
				local base = serverendpoint:InvokeServer("CreatePart", "Normal", CFrame.new(position), workspace)
				resize(base, Vector3.new(512, 16, 512), CFrame.new(position))
				syncmaterial(base, Enum.Material.Grass)
				color(base, Color3.new(0.45098, 0.647059, 0.0823529))
			end)
		end
	
		makebaseplate()
	end)
end;
task.spawn(C_36);
-- StarterGui.FU.reagon.Destruction.part.LocalScript
local function C_3a()
local script = G2L["3a"];
	script.Parent.Activated:Connect(function()
		local player = game.Players.LocalPlayer
		local char = player.Character
		local backpack = player.Backpack
	
		local function getf3x()
			for _, v in ipairs(backpack:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
			for _, v in ipairs(char:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
	
			return nil
		end
	
		-- get all info
	
		local f3x = getf3x()
		if not f3x then
			warn("you dont have f3x skid")
		end
		local syncapi = f3x.SyncAPI
		local serverendpoint = syncapi.ServerEndpoint
	
		local function makepart(cf, typea, parent)
			local args = {
				[1] = "CreatePart",
				[2] = typea,
				[3] = cf,
				[4] = parent
			}
			return serverendpoint:InvokeServer(unpack(args))
		end
	
		local function setanchor(part, boolean)
			local args = {
				[1] = "SyncAnchor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Anchored"] = boolean
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
	
		local function spamparts()
			for i = 1, 50 do
				spawn(function()
					local part = makepart(char.Head.CFrame * CFrame.new(0, 50, 0), "Normal", workspace)
					setanchor(part, false)
				end)
			end
		end
	
		spamparts()
	end)
end;
task.spawn(C_3a);
-- StarterGui.FU.reagon.Destruction.rain.LocalScript
local function C_41()
local script = G2L["41"];
	script.Parent.Activated:Connect(function()
		local player = game.Players.LocalPlayer
		local char = player.Character
		local backpack = player.Backpack
	
		local function getf3x()
			for _, v in ipairs(backpack:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
			for _, v in ipairs(char:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
	
			return nil
		end
	
		-- get all info
	
		local f3x = getf3x()
		if not f3x then
			warn("you dont have f3x skid")
		end
		local syncapi = f3x.SyncAPI
		local serverendpoint = syncapi.ServerEndpoint
	
		local function makemesh(part)
			local args = {
				[1] = "CreateMeshes",
				[2] = {
					[1] = {
						["Part"] = part
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
		
		local function setanchor(part, boolean)
			local args = {
				[1] = "SyncAnchor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Anchored"] = boolean
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
		
		local function syncmeshid(part, id)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["MeshId"] = "rbxassetid://"..id
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
		
		local function syncmeshtexture(part, id)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["TextureId"] =	"rbxassetid://"..id
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
		
		local function syncmeshsize(part, vectora)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["Scale"] = vectora
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
		
		local function name(part, stringa)
			local args = {
				[1] = "SetName",
				[2] = {
					[1] = part
				},
				[3] = stringa
			}
			serverendpoint:InvokeServer(unpack(args))
		end
		
		local function lock(part, boolean)
			local args = {
				[1] = "SetLocked",
				[2] = {
					[1] = part
				},
				[3] = boolean
			}
			serverendpoint:InvokeServer(unpack(args))
		end
		
		local function setcollision(part, booleana)
			local args = {
				[1] = "SyncCollision",
				[2] = {
					[1] = {
						["Part"] = part,
						["CanCollide"] = booleana
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
		
		local function rain()
			local hrpcf = char.HumanoidRootPart.CFrame
			while task.wait(0.1) do
				local x = hrpcf.x
				local z = hrpcf.z
				local randint = math.random(-300,300)
				local randint2 = math.random(-300,300)
				local xloc = randint + x
				local zloc = randint2 + z
				local raincf = player.Character.HumanoidRootPart.CFrame.y + 400
				spawn(function()
					local rainpart = serverendpoint:InvokeServer("CreatePart", "Normal", CFrame.new(math.floor(xloc), math.random(raincf,raincf+400), math.floor(zloc)), workspace)
					name(rainpart, "the sigma")
					lock(rainpart, true)
					makemesh(rainpart)
					syncmeshid(rainpart, script.Parent.mesh.Text)
					syncmeshtexture(rainpart, script.Parent.texture.Text)
					setanchor(rainpart, false)
					if script.Parent.size.Text ~= "" then
						syncmeshsize(rainpart, Vector3.new(script.Parent.size.Text, script.Parent.size.Text, script.Parent.size.Text))
					end
				end)
			end
		end
		rain()
	end)
end;
task.spawn(C_41);
-- StarterGui.FU.reagon.Destruction.Realm.LocalScript
local function C_4b()
local script = G2L["4b"];
	script.Parent.Activated:Connect(function()
		local player = game.Players.LocalPlayer
		local char = player.Character
		local backpack = player.Backpack
	
		local function getf3x()
			for _, v in ipairs(backpack:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
			for _, v in ipairs(char:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
	
			return nil
		end
	
		-- get all info
	
		local f3x = getf3x()
		if not f3x then
			warn("you dont have f3x skid")
		end
		local syncapi = f3x.SyncAPI
		local serverendpoint = syncapi.ServerEndpoint
		
		local function resize(part,size,cf)
			local args = {
				[1] = "SyncResize",
				[2] = {
					[1] = {
						["Part"] = part,
						["CFrame"] = cf,
						["Size"] = size
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
	
		local function syncmaterial(part,mate)
			local args = {
				[1] = "SyncMaterial",
				[2] = {
					[1] = {
						["Part"] = part,
						["Material"] = mate
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
	
		local function color(part, color)
			local args = {
				[1] = "SyncColor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Color"] = color --[[Color3]],
						["UnionColoring"] = false
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
		
		local function syncmeshid(part, id)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["MeshId"] = "rbxassetid://"..id
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
		
		local function makemesh(part)
			local args = {
				[1] = "CreateMeshes",
				[2] = {
					[1] = {
						["Part"] = part
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
		
		local function syncmeshsize(part, vectora)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["Scale"] = vectora
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
		
		local function syncmeshtexture(part, id)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["TextureId"] =	"rbxassetid://"..id
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
	
		local function name(part, stringa)
			local args = {
				[1] = "SetName",
				[2] = {
					[1] = part
				},
				[3] = stringa
			}
			serverendpoint:InvokeServer(unpack(args))
		end
	
		local function lock(part, boolean)
			local args = {
				[1] = "SetLocked",
				[2] = {
					[1] = part
				},
				[3] = boolean
			}
			serverendpoint:InvokeServer(unpack(args))
		end
		
		local function setcollision(part, booleana)
			local args = {
				[1] = "SyncCollision",
				[2] = {
					[1] = {
						["Part"] = part,
						["CanCollide"] = booleana
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
		
		local function setanchor(part, boolean)
			local args = {
				[1] = "SyncAnchor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Anchored"] = boolean
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
		
		local function createdecal(part, side)
			local args = {
				[1] = "CreateTextures",
				[2] = {
					[1] = {
						["Part"] = part,
						["Face"] = side,
						["TextureType"] = "Decal"
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
		local function setdecal(part, asset, side)
			local args = {
				[1] = "SyncTexture",
				[2] = {
					[1] = {
						["Part"] = part,
						["Face"] = side,
						["TextureType"] = "Decal",
						["Texture"] = "rbxassetid://".. asset
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
		
		local function makerealmbase()
			local position = CFrame.new(0, 5000000, 0)
			local base = serverendpoint:InvokeServer("CreatePart", "Normal", position, workspace)
			resize(base, Vector3.new(512, 16, 512), position)
			syncmaterial(base, Enum.Material.Grass)
			color(base, Color3.new(0.45098, 0.647059, 0.0823529))
			name(base, "sigma base")
			lock(base, true)
			
			local spawnpos = CFrame.new(0, 5000005, 0)
			local spawna = serverendpoint:InvokeServer("CreatePart", "Spawn", spawnpos, workspace)
			resize(spawna, Vector3.new(10, 5, 10), spawnpos)
			name(spawna, "sigma spawn")
			lock(spawna, true)
			
			createdecal(spawna, Enum.NormalId.Top)
			setdecal(spawna, "rbxassetid://1135882259", Enum.NormalId.Top)
			
			local shrinepos = CFrame.new(0, 5000040, 0)
			local shrine = serverendpoint:InvokeServer("CreatePart", "Normal", shrinepos, workspace)
			
			makemesh(shrine)
			syncmeshsize(shrine, Vector3.new(15, 15, 15))
			syncmeshid(shrine, "14860633751")
			syncmeshtexture(shrine, "16005991600")
			lock(shrine, true)
			name(shrine, "adsgdjhwdghsaydtavtwydsafooooooooooooooooo")
			setcollision(shrine, false)
			
		end
		
		local function sky()
			local position = CFrame.new(0, 5000000, 0)
			local sky = serverendpoint:InvokeServer("CreatePart", "Normal", position, workspace)
			
			makemesh(sky)
			syncmeshid(sky, "8006679977")
			syncmeshtexture(sky, "77285008779144")
			syncmeshsize(sky, Vector3.new(500, 500, 500))
			lock(sky, true)
			name(sky, "SECRET SURPRISE!!!")
			setcollision(sky, false)
		end
		
		local function unanchorall()
			for _, v in ipairs(workspace:GetDescendants()) do
					if v:IsA("BasePart") or v:IsA("UnionOperation") then
					spawn(function()
						setanchor(v, false)
					end)
					end
			end
		end
		
		local function realm()
			unanchorall()
			task.wait(3)
			sky()
			makerealmbase()
		end
		
		realm()
	end)
end;
task.spawn(C_4b);
-- StarterGui.FU.reagon.Destruction.Spawns.LocalScript
local function C_4f()
local script = G2L["4f"];
	script.Parent.Activated:Connect(function()
		local player = game.Players.LocalPlayer
		local char = player.Character
		local backpack = player.Backpack
	
		local function getf3x()
			for _, v in ipairs(backpack:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
			for _, v in ipairs(char:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
	
			return nil
		end
	
		-- get all info
	
		local f3x = getf3x()
		if not f3x then
			warn("you dont have f3x skid")
		end
		local syncapi = f3x.SyncAPI
		local serverendpoint = syncapi.ServerEndpoint
	
		local function delete(part)
			local args = {
				[1] = "Remove",
				[2] = {
					[1] = part
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
	
		local function removeallspawns()
			for _, v in ipairs(workspace:GetDescendants()) do
				if v:IsA("SpawnLocation") then
					spawn(function()
						delete(v)
					end)
				end
			end
		end
	
		removeallspawns()
	end)
end;
task.spawn(C_4f);
-- StarterGui.FU.reagon.Destruction.mesh.LocalScript
local function C_53()
local script = G2L["53"];
	script.Parent.Activated:Connect(function()
		local player = game.Players.LocalPlayer
		local char = player.Character
		local backpack = player.Backpack
	
		local function getf3x()
			for _, v in ipairs(backpack:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
			for _, v in ipairs(char:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
	
			return nil
		end
	
		-- get all info
	
		local f3x = getf3x()
		if not f3x then
			warn("you dont have f3x skid")
		end
		local syncapi = f3x.SyncAPI
		local serverendpoint = syncapi.ServerEndpoint
	
		local meshTypes = {
			Enum.MeshType.Brick,
			Enum.MeshType.Cylinder,
			Enum.MeshType.FileMesh,
			Enum.MeshType.Head,
			Enum.MeshType.Sphere,
			Enum.MeshType.Wedge
		}
		
		local function makemesh(part)
			local args = {
				[1] = "CreateMeshes",
				[2] = {
					[1] = {
						["Part"] = part
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
	
		local function syncmeshtype(part, type1)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["MeshType"] = type1,
						["Part"] = part
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
		
		local randomMeshType = meshTypes[math.random(1, #meshTypes)]
		
		local function applymesh()
			for _, v in ipairs(workspace:GetDescendants()) do
				spawn(function()
					makemesh(v)
					syncmeshtype(v, randomMeshType)
				end)
			end
		end
		
		applymesh()
	end)
end;
task.spawn(C_53);
-- StarterGui.FU.reagon.Destruction.bw.LocalScript
local function C_57()
local script = G2L["57"];
	script.Parent.Activated:Connect(function()
		local player = game.Players.LocalPlayer
		local char = player.Character
		local backpack = player.Backpack
	
		local function getf3x()
			for _, v in ipairs(backpack:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
			for _, v in ipairs(char:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
	
			return nil
		end
	
		-- get all info
	
		local f3x = getf3x()
		if not f3x then
			warn("you dont have f3x skid")
		end
		local syncapi = f3x.SyncAPI
		local serverendpoint = syncapi.ServerEndpoint
	
		local function color(part, color)
			local args = {
				[1] = "SyncColor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Color"] = color --[[Color3]],
						["UnionColoring"] = false
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
		
		local function name(part, stringa)
			local args = {
				[1] = "SetName",
				[2] = {
					[1] = part
				},
				[3] = stringa
			}
			serverendpoint:InvokeServer(unpack(args))
		end
	
		local function setcollision(part, booleana)
			local args = {
				[1] = "SyncCollision",
				[2] = {
					[1] = {
						["Part"] = part,
						["CanCollide"] = booleana
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
	
		local function lock(part, boolean)
			local args = {
				[1] = "SetLocked",
				[2] = {
					[1] = part
				},
				[3] = boolean
			}
			serverendpoint:InvokeServer(unpack(args))
		end
		
		
		local function sky()
			spawn(function()
				local position = char.Head.Position
				local part = serverendpoint:InvokeServer("CreatePart", "Normal", CFrame.new(position + Vector3.new(0, 2, 0)), workspace)
				local args = {
					[1] = "CreateMeshes",
					[2] = {
						[1] = {
							["Part"] = part
						}
					}
				}
				serverendpoint:InvokeServer(unpack(args))
				local args = {
					[1] = "SyncMesh",
					[2] = {
						[1] = {
							["Part"] = part,
							["MeshId"] = "rbxassetid://8006679977"
						}
					}
				}
				serverendpoint:InvokeServer(unpack(args))
				local args = {
					[1] = "SyncMesh",
					[2] = {
						[1] = {
							["Part"] = part,
							["Scale"] = Vector3.new(90, 90, 90)
						}
					}
				}
				serverendpoint:InvokeServer(unpack(args))
				local args = {
					[1] = "SyncMesh",
					[2] = {
						[1] = {
							["Part"] = part,
							["TextureId"] =	"rbxassetid://10995799876"
						}
					}
				}
				serverendpoint:InvokeServer(unpack(args))
	
				name(part, "Sky")
				lock(part, true)
				setcollision(part, false)
			end)
		end
	
		local function colorall()
			for _, v in ipairs(workspace:GetDescendants()) do
				if v:IsA("BasePart") or v:IsA("UnionOperation") then
					spawn(function()
						color(v, Color3.new(0.196078, 0.196078, 0.196078))
					end)
				end
			end
		end
		colorall()
		sky()
	end)
end;
task.spawn(C_57);
-- StarterGui.FU.reagon.Destruction.grass.LocalScript
local function C_5b()
local script = G2L["5b"];
	script.Parent.Activated:Connect(function()
		local player = game.Players.LocalPlayer
		local char = player.Character
		local backpack = player.Backpack
	
		local function getf3x()
			for _, v in ipairs(backpack:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
			for _, v in ipairs(char:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
	
			return nil
		end
	
		-- get all info
	
		local f3x = getf3x()
		if not f3x then
			warn("you dont have f3x skid")
		end
		local syncapi = f3x.SyncAPI
		local serverendpoint = syncapi.ServerEndpoint
	
		local function createdecal(part, side)
			local args = {
				[1] = "CreateTextures",
				[2] = {
					[1] = {
						["Part"] = part,
						["Face"] = side,
						["TextureType"] = "Decal"
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
		local function setdecal(part, asset, side)
			local args = {
				[1] = "SyncTexture",
				[2] = {
					[1] = {
						["Part"] = part,
						["Face"] = side,
						["TextureType"] = "Decal",
						["Texture"] = "rbxassetid://".. asset
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
		
		local function grassblock()
			for _, v in ipairs(workspace:GetDescendants()) do
				if v:IsA("BasePart") or v:IsA("UnionOperation") then
					spawn(function()
						local decalidtop = "3027402982"
						local decalidother = "3027402330"
						local decalidbottom = "3027464199"
						
						createdecal(v, Enum.NormalId.Front)
						createdecal(v, Enum.NormalId.Back)
						createdecal(v, Enum.NormalId.Left)
						createdecal(v, Enum.NormalId.Right)
						createdecal(v, Enum.NormalId.Bottom)
						createdecal(v, Enum.NormalId.Top)
	
						setdecal(v, decalidother, Enum.NormalId.Front)
						setdecal(v, decalidother, Enum.NormalId.Back)
						setdecal(v, decalidother, Enum.NormalId.Left)
						setdecal(v, decalidother, Enum.NormalId.Right)
						setdecal(v, decalidbottom, Enum.NormalId.Bottom)
						setdecal(v, decalidtop, Enum.NormalId.Top)
						
					end)
				end
			end
		end
		
		grassblock()
	end)
end;
task.spawn(C_5b);
-- StarterGui.FU.reagon.Destruction.material.LocalScript
local function C_62()
local script = G2L["62"];
	script.Parent.Activated:Connect(function()
		local player = game.Players.LocalPlayer
		local char = player.Character
		local backpack = player.Backpack
	
		local function getf3x()
			for _, v in ipairs(backpack:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
			for _, v in ipairs(char:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
	
			return nil
		end
	
		-- get all info
	
		local f3x = getf3x()
		if not f3x then
			warn("you dont have f3x skid")
		end
		local syncapi = f3x.SyncAPI
		local serverendpoint = syncapi.ServerEndpoint
	
		local function syncmaterial(part,mate)
			local args = {
				[1] = "SyncMaterial",
				[2] = {
					[1] = {
						["Part"] = part,
						["Material"] = mate
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
		
		local function materialall()
			for _, v in ipairs(workspace:GetDescendants()) do
				if v:IsA("BasePart") or v:IsA("UnionOperation") then
					spawn(function()
						syncmaterial(v, script.Parent.TextBox.Text)
					end)
				end
			end
		end
		
		materialall()
	end)
end;
task.spawn(C_62);
-- StarterGui.FU.reagon.tab.d.LocalScript
local function C_6d()
local script = G2L["6d"];
	local b = script.Parent
	local desctructionframe = b.Parent.Parent.Destruction
	local localplayerframe = b.Parent.Parent.LocalPlayer
	
	b.Activated:Connect(function()
		desctructionframe.Visible = true
		localplayerframe.Visible = false
	end)
end;
task.spawn(C_6d);
-- StarterGui.FU.reagon.tab.lp.LocalScript
local function C_71()
local script = G2L["71"];
	local b = script.Parent
	local desctructionframe = b.Parent.Parent.Destruction
	local localplayerframe = b.Parent.Parent.LocalPlayer
	
	b.Activated:Connect(function()
		desctructionframe.Visible = false
		localplayerframe.Visible = true
	end)
end;
task.spawn(C_71);
-- StarterGui.FU.reagon.LocalPlayer.eraser.LocalScript
local function C_79()
local script = G2L["79"];
	script.Parent.Activated:Connect(function()
		local player = game.Players.LocalPlayer
		local char = player.Character
		local backpack = player.Backpack
		
		local UserInputService = game:GetService("UserInputService")
		local RunService = game:GetService("RunService")
	
		local holding = false
	
		local function getf3x()
			for _, v in ipairs(backpack:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
			for _, v in ipairs(char:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
	
			return nil
		end
	
		local f3x = getf3x()
		if not f3x then
			warn("you dont have f3x skid")
		end
		local syncapi = f3x.SyncAPI
		local serverendpoint = syncapi.ServerEndpoint
	
		local function delete(part)
			local args = {
				[1] = "Remove",
				[2] = {
					[1] = part
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
		
		local function resize(part,size,cf)
			local args = {
				[1] = "SyncResize",
				[2] = {
					[1] = {
						["Part"] = part,
						["CFrame"] = cf,
						["Size"] = size
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
		
		local function syncmaterial(part,mate)
			local args = {
				[1] = "SyncMaterial",
				[2] = {
					[1] = {
						["Part"] = part,
						["Material"] = mate
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
		
		local function synctrans(part,int)
			local args = {
				[1] = "SyncMaterial",
				[2] = {
					[1] = {
						["Part"] = part,
						["Transparency"] = int
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
		
		local function color(part, color)
			local args = {
				[1] = "SyncColor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Color"] = color --[[Color3]],
						["UnionColoring"] = false
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
		
		local tool = Instance.new("Tool")
		tool.Parent = player.Backpack
		tool.Name = "Eraser of death"
		tool.RequiresHandle = false
		
		tool.Equipped:Connect(function()
			local mouse = player:GetMouse()
			holding = false
	
			local renderConnection
	
			mouse.Button1Down:Connect(function()
				holding = true
			end)
	
			mouse.Button1Up:Connect(function()
				holding = false
			end)
	
			renderConnection = RunService.RenderStepped:Connect(function()
				if holding then
					local target = mouse.Target
					if target and target:IsA("BasePart") then
						local maxSize = Vector3.new(100, 100, 100)
						local size = target.Size
						if size.X <= maxSize.X and size.Y <= maxSize.Y and size.Z <= maxSize.Z then
							delete(target)
	
							local remainspos = target.CFrame
							local remains = serverendpoint:InvokeServer("CreatePart", "Normal", remainspos, workspace)
	
							resize(remains, target.Size, target.CFrame)
							syncmaterial(remains, Enum.Material.Neon)
							synctrans(remains, 0.4)
							color(remains, Color3.new(1, 0, 0))
	
							task.wait(1)
							delete(remains)
						end
					end
				end
			end)
			tool.Unequipped:Connect(function()
				if renderConnection then
					renderConnection:Disconnect()
					renderConnection = nil
				end
				holding = false
			end)
		end)
	end)
end;
task.spawn(C_79);
-- StarterGui.FU.reagon.LocalPlayer.draw.LocalScript
local function C_7f()
local script = G2L["7f"];
	script.Parent.Activated:Connect(function()
		local player = game.Players.LocalPlayer
		local char = player.Character
		local backpack = player.Backpack
		
		local UserInputService = game:GetService("UserInputService")
		local RunService = game:GetService("RunService")
	
		local holding = false
	
		local function getf3x()
			for _, v in ipairs(backpack:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
			for _, v in ipairs(char:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end

			return nil
		end

		local f3x = getf3x()
		if not f3x then
			warn("you dont have f3x skid")
		end
		local syncapi = f3x.SyncAPI
		local serverendpoint = syncapi.ServerEndpoint

		local function resize(part,size,cf)
			local args = {
				[1] = "SyncResize",
				[2] = {
					[1] = {
						["Part"] = part,
						["CFrame"] = cf,
						["Size"] = size
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end

		local function color(part, color)
			local args = {
				[1] = "SyncColor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Color"] = color --[[Color3]],
						["UnionColoring"] = false
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end

		local function setcollision(part, booleana)
			local args = {
				[1] = "SyncCollision",
				[2] = {
					[1] = {
						["Part"] = part,
						["CanCollide"] = booleana
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end

		local function name(part, stringa)
			local args = {
				[1] = "SetName",
				[2] = {
					[1] = part
				},
				[3] = stringa
			}
			serverendpoint:InvokeServer(unpack(args))
		end

		local function lock(part, boolean)
			local args = {
				[1] = "SetLocked",
				[2] = {
					[1] = part
				},
				[3] = boolean
			}
			serverendpoint:InvokeServer(unpack(args))
		end

		local function syncmaterial(part,mate)
			local args = {
				[1] = "SyncMaterial",
				[2] = {
					[1] = {
						["Part"] = part,
						["Material"] = mate
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end

		local tool = Instance.new("Tool")
		tool.Parent = player.Backpack
		tool.Name = "Draw tool"
		tool.RequiresHandle = false

		tool.Equipped:Connect(function()
			local mouse = player:GetMouse()
			holding = false

			local renderConnection

			mouse.Button1Down:Connect(function()
				holding = true
			end)

			mouse.Button1Up:Connect(function()
				holding = false
			end)
			renderConnection = RunService.RenderStepped:Connect(function()
				if holding then
					local target = mouse.Target

					if target:IsA("BasePart") then
						spawn(function()
							local hitPosition = mouse.Hit.Position
							local cf = CFrame.new(hitPosition)
							local drawball = serverendpoint:InvokeServer("CreatePart", "Ball", cf, workspace)

							color(drawball, Color3.new(0, 0, 0))
							resize(drawball, Vector3.new(0.5, 0.5, 0.5), cf)
							setcollision(drawball, false)
							name(drawball, "ligmaligmaboy")
							lock(drawball, true)
						end)
					else
						warn("aim at a part")
					end
				end
			end)
			tool.Unequipped:Connect(function()
				if renderConnection then
					renderConnection:Disconnect()
					renderConnection = nil
				end
				holding = false
			end)
		end)
	end)
end;
task.spawn(C_7f);
-- StarterGui.FU.reagon.LocalPlayer.Stoneify.LocalScript
local function C_83()
	local script = G2L["83"];
	script.Parent.Activated:Connect(function()
		local player = game.Players.LocalPlayer
		local char = player.Character
		local backpack = player.Backpack

		local UserInputService = game:GetService("UserInputService")
		local RunService = game:GetService("RunService")

		local holding = false

		local function getf3x()
			for _, v in ipairs(backpack:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
			for _, v in ipairs(char:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end

			return nil
		end

		local f3x = getf3x()
		if not f3x then
			warn("you dont have f3x skid")
		end
		local syncapi = f3x.SyncAPI
		local serverendpoint = syncapi.ServerEndpoint

		local function color(part, color)
			local args = {
				[1] = "SyncColor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Color"] = color --[[Color3]],
						["UnionColoring"] = false
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end

		local function setanchor(part, boolean)
			local args = {
				[1] = "SyncAnchor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Anchored"] = boolean
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end

		local function setcollision(part, booleana)
			local args = {
				[1] = "SyncCollision",
				[2] = {
					[1] = {
						["Part"] = part,
						["CanCollide"] = booleana
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end

		local function lock(part, boolean)
			local args = {
				[1] = "SetLocked",
				[2] = {
					[1] = part
				},
				[3] = boolean
			}
			serverendpoint:InvokeServer(unpack(args))
		end

		local function syncmaterial(part,mate)
			local args = {
				[1] = "SyncMaterial",
				[2] = {
					[1] = {
						["Part"] = part,
						["Material"] = mate
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end

		local tool = Instance.new("Tool")
		tool.Parent = player.Backpack
		tool.Name = "Stoneify"
		tool.RequiresHandle = false

		tool.Equipped:Connect(function()
			local mouse = player:GetMouse()
			holding = false

			local renderConnection

			mouse.Button1Down:Connect(function()
				holding = true
			end)

			mouse.Button1Up:Connect(function()
				holding = false
			end)
			renderConnection = RunService.RenderStepped:Connect(function()
				if holding then
					local target = mouse.Target

					if target:IsA("BasePart") then
						spawn(function()
							setanchor(target, true)
							syncmaterial(target, Enum.Material.Slate)
							color(target, Color3.new(0.207843, 0.207843, 0.207843))
							lock(target, true)
							setcollision(target, true)
						end)
					else
						warn("aim at a part")
					end
					if target.Parent:FindFirstChildOfClass("Humanoid") then
						for _, v in ipairs(target.Parent:GetDescendants()) do
							if v:IsA("BasePart") or v:IsA("UnionOperation") then
								spawn(function()
									setanchor(v, true)
									syncmaterial(v, Enum.Material.Slate)
									color(v, Color3.new(0.207843, 0.207843, 0.207843))
									lock(v, true)
									setcollision(v, true)
								end)
							end
						end
					end
				end
			end)
			tool.Unequipped:Connect(function()
				if renderConnection then
					renderConnection:Disconnect()
					renderConnection = nil
				end
				holding = false
			end)
		end)
	end)
end;
task.spawn(C_83);
-- StarterGui.FU.reagon.LocalPlayer.jondotrill.LocalScript
local function C_88()
	local script = G2L["88"];
	script.Parent.Activated:Connect(function()
		local player = game.Players.LocalPlayer
		local char = player.Character
		local backpack = player.Backpack

		local UserInputService = game:GetService("UserInputService")
		local RunService = game:GetService("RunService")

		local holding = false

		local function getf3x()
			for _, v in ipairs(backpack:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
			for _, v in ipairs(char:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end

			return nil
		end

		local f3x = getf3x()
		if not f3x then
			warn("you dont have f3x skid")
		end
		local syncapi = f3x.SyncAPI
		local serverendpoint = syncapi.ServerEndpoint

		local function delete(part)
			local args = {
				[1] = "Remove",
				[2] = {
					[1] = part
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end

		local function resize(part,size,cf)
			local args = {
				[1] = "SyncResize",
				[2] = {
					[1] = {
						["Part"] = part,
						["CFrame"] = cf,
						["Size"] = size
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end

		local function syncmaterial(part,mate)
			local args = {
				[1] = "SyncMaterial",
				[2] = {
					[1] = {
						["Part"] = part,
						["Material"] = mate
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end

		local function synctrans(part,int)
			local args = {
				[1] = "SyncMaterial",
				[2] = {
					[1] = {
						["Part"] = part,
						["Transparency"] = int
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end

		local function color(part, color)
			local args = {
				[1] = "SyncColor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Color"] = color --[[Color3]],
						["UnionColoring"] = false
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end

		local function setcollision(part, booleana)
			local args = {
				[1] = "SyncCollision",
				[2] = {
					[1] = {
						["Part"] = part,
						["CanCollide"] = booleana
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end

		while task.wait(0.1) do
			spawn(function()
				local hrp = char.HumanoidRootPart
				local pos = hrp.CFrame * CFrame.new(0, -3.2, 0)
				local trail = serverendpoint:InvokeServer("CreatePart", "Normal", pos, char)

				setcollision(trail, false)
				syncmaterial(trail, Enum.Material.Granite)
				color(trail, Color3.new(0, 0, 0))
				resize(trail, Vector3.new(10, 0.5, 10), trail.CFrame)


				task.wait(1)
				delete(trail)
			end)
		end
	end)
end;
task.spawn(C_88);
-- StarterGui.FU.reagon.LocalPlayer.bag.LocalScript
local function C_8c()
	local script = G2L["8c"];
	script.Parent.Activated:Connect(function()
		local player = game.Players.LocalPlayer
		local char = player.Character
		local backpack = player.Backpack

		local UserInputService = game:GetService("UserInputService")
		local RunService = game:GetService("RunService")

		local holding = false

		local function getf3x()
			for _, v in ipairs(backpack:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
			for _, v in ipairs(char:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end

			return nil
		end

		local f3x = getf3x()
		if not f3x then
			warn("you dont have f3x skid")
		end
		local syncapi = f3x.SyncAPI
		local serverendpoint = syncapi.ServerEndpoint

		local function resize(part,size,cf)
			local args = {
				[1] = "SyncResize",
				[2] = {
					[1] = {
						["Part"] = part,
						["CFrame"] = cf,
						["Size"] = size
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end

		local function delete(part)
			local args = {
				[1] = "Remove",
				[2] = {
					[1] = part
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end

		local function color(part, color)
			local args = {
				[1] = "SyncColor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Color"] = color --[[Color3]],
						["UnionColoring"] = false
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end

		local function name(part, stringa)
			local args = {
				[1] = "SetName",
				[2] = {
					[1] = part
				},
				[3] = stringa
			}
			serverendpoint:InvokeServer(unpack(args))
		end

		local function lock(part, boolean)
			local args = {
				[1] = "SetLocked",
				[2] = {
					[1] = part
				},
				[3] = boolean
			}
			serverendpoint:InvokeServer(unpack(args))
		end

		local function createdecal(part, side)
			local args = {
				[1] = "CreateTextures",
				[2] = {
					[1] = {
						["Part"] = part,
						["Face"] = side,
						["TextureType"] = "Decal"
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
		local function setdecal(part, asset, side)
			local args = {
				[1] = "SyncTexture",
				[2] = {
					[1] = {
						["Part"] = part,
						["Face"] = side,
						["TextureType"] = "Decal",
						["Texture"] = "rbxassetid://".. asset
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end

		local function setanchor(part, boolean)
			local args = {
				[1] = "SyncAnchor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Anchored"] = boolean
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end

		local tool = Instance.new("Tool")
		tool.Parent = player.Backpack
		tool.Name = "Money Bag"
		tool.RequiresHandle = false
		tool.TextureId = "http://www.roblox.com/asset/?id=16659163"

		local debounce = false

		tool.Activated:Connect(function()
			if debounce == false then
				debounce = true
				for i = 1, 5 do
					spawn(function()
						local offset = Vector3.new(math.random() - 0.5, math.random() - 0.5, math.random() - 0.5).Unit
						local pos = char.HumanoidRootPart.CFrame * CFrame.new(offset) * CFrame.new(0, 4, 0)
						local buck = serverendpoint:InvokeServer("CreatePart", "Normal", pos, workspace)
						name(buck, "MONEY")
						lock(buck, true)
						resize(buck, Vector3.new(2, 0.4, 1), pos)
						color(buck, Color3.new(0.156863, 0.498039, 0.278431))
						setanchor(buck, false)

						createdecal(buck, Enum.NormalId.Top)
						setdecal(buck, "16658163", Enum.NormalId.Top)

						task.wait(10)
						delete(buck)
					end)
				end
				task.wait(1)
				debounce = false
			end
		end)
	end)
end;
task.spawn(C_8c);
-- StarterGui.FU.reagon.LocalPlayer.train.LocalScript
local function C_90()
	local script = G2L["90"];
	script.Parent.Activated:Connect(function()
		local player = game.Players.LocalPlayer
		local char = player.Character
		local backpack = player.Backpack

		local UserInputService = game:GetService("UserInputService")
		local RunService = game:GetService("RunService")

		local holding = false

		local function getf3x()
			for _, v in ipairs(backpack:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
			for _, v in ipairs(char:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end

			return nil
		end

		local f3x = getf3x()
		if not f3x then
			warn("you dont have f3x skid")
		end
		local syncapi = f3x.SyncAPI
		local serverendpoint = syncapi.ServerEndpoint

		local function makemesh(part)
			local args = {
				[1] = "CreateMeshes",
				[2] = {
					[1] = {
						["Part"] = part
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end

		local function syncmeshtexture(part, id)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["TextureId"] =	"rbxassetid://"..id
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end

		local function synctrans(part,int)
			local args = {
				[1] = "SyncMaterial",
				[2] = {
					[1] = {
						["Part"] = part,
						["Transparency"] = int
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end

		local function syncmeshsize(part, vectora)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["Scale"] = vectora
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end

		local function setcollision(part, booleana)
			local args = {
				[1] = "SyncCollision",
				[2] = {
					[1] = {
						["Part"] = part,
						["CanCollide"] = booleana
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end

		local function syncmeshid(part, id)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["MeshId"] = "rbxassetid://"..id
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end

		local function weld(p1, p2, lead)
			local args = {
				[1] = "CreateWelds",
				[2] = {
					[1] = p1,
					[2] = p2
				},
				[3] = lead
			}
			serverendpoint:InvokeServer(unpack(args))
		end

		local function name(part, stringa)
			local args = {
				[1] = "SetName",
				[2] = {
					[1] = part
				},
				[3] = stringa
			}
			serverendpoint:InvokeServer(unpack(args))
		end

		local function setanchor(part, boolean)
			local args = {
				[1] = "SyncAnchor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Anchored"] = boolean
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end

		local function resize(part,size,cf)
			local args = {
				[1] = "SyncResize",
				[2] = {
					[1] = {
						["Part"] = part,
						["CFrame"] = cf,
						["Size"] = size
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end

		local function delete(part)
			local args = {
				[1] = "Remove",
				[2] = {
					[1] = part
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end

		-- train

		for _, v in ipairs(char:GetChildren()) do
			if v:IsA("BasePart") or v:IsA("MeshPart") then
				spawn(function()
					synctrans(v, 1)
				end)
			end
		end

		task.wait(1)

		spawn(function()
			local hrp = char.HumanoidRootPart
			local trainpart = serverendpoint:InvokeServer("CreatePart", "Normal", hrp.CFrame, char)
			setanchor(hrp, true)

			name(trainpart, "sigmatrain")
			setcollision(trainpart, false)
			resize(trainpart, Vector3.new(5,5,10), hrp.CFrame)
			weld(trainpart, hrp, trainpart)
			makemesh(trainpart)
			syncmeshsize(trainpart, Vector3.new(2,2,1.5))
			syncmeshid(trainpart, "2231280549")
			syncmeshtexture(trainpart, "2231280614")
			task.wait(1)
			setanchor(trainpart, false)
			setanchor(hrp, false)
			char.Humanoid.WalkSpeed = 60

			trainpart.Touched:Connect(function(p)
				if p.Parent then
					if p.Parent:FindFirstChildOfClass("Humanoid") then
						if p.Parent ~= char then
							delete(p.Parent.Head)
						end
					end
				end
			end)
		end)
	end)
end;
task.spawn(C_90);
-- StarterGui.FU.SpectateGui.LocalScript
local function C_97()
	local script = G2L["97"];
	-- By super10099

	cam = game.Workspace.CurrentCamera

	local bar = script.Parent.Bar
	local title = bar.Title
	local prev = bar.Previous
	local nex = bar.Next
	local button = script.Parent.Button

	function get()
		for _,v in pairs(game.Players:GetPlayers())do
			if v.Name == title.Text then
				return(_)
			end
		end
	end


	local debounce = false
	button.MouseButton1Click:connect(function()
		if debounce == false then debounce = true
			bar:TweenPosition(UDim2.new(.5,-100,0.88,-50),"In","Linear",1,true)
			pcall(function()
				title.Text = game.Players:GetPlayerFromCharacter(cam.CameraSubject.Parent).Name
			end)
		elseif debounce == true then debounce = false
			pcall(function() cam.CameraSubject = game.Players.LocalPlayer.Character.Humanoid end)
			bar:TweenPosition(UDim2.new(-1,-100,0.88,-50),"In","Linear",1,true)
		end
	end)

	prev.MouseButton1Click:connect(function()
		wait(.1)
		local players = game.Players:GetPlayers()
		local num = get()
		if not pcall(function() 
				cam.CameraSubject = players[num-1].Character.Humanoid
			end) then
			cam.CameraSubject = players[#players].Character.Humanoid
		end
		pcall(function()
			title.Text = game.Players:GetPlayerFromCharacter(cam.CameraSubject.Parent).Name
		end)
	end)

	nex.MouseButton1Click:connect(function()
		wait(.1)
		local players = game.Players:GetPlayers()
		local num = get()
		if not pcall(function() 
				cam.CameraSubject = players[num+1].Character.Humanoid
			end) then
			cam.CameraSubject = players[1].Character.Humanoid
		end
		pcall(function()
			title.Text = game.Players:GetPlayerFromCharacter(cam.CameraSubject.Parent).Name
		end)
	end)


end;
task.spawn(C_97);
-- StarterGui.FU.f3x.LocalScript
local function C_9c()
	local script = G2L["9c"];
	script.Parent.Activated:Connect(function()
		script.Parent.Parent.reagon.Visible = not script.Parent.Parent.reagon.Visible
	end)
end;
task.spawn(C_9c);
-- StarterGui.FU.notification.Frame.x.LocalScript
local function C_a5()
	local script = G2L["a5"];
	script.Parent.Activated:Connect(function()
		script.Parent.Parent.Parent:Destroy()
	end)
end;
task.spawn(C_a5);

return G2L["1"], require;
        end},

        {"F3XSploit V2", function()
--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
--[=[
 d888b  db    db d888888b      .d888b.      db      db    db  .d8b.  
88' Y8b 88    88   `88'        VP  `8D      88      88    88 d8' `8b 
88      88    88    88            odD'      88      88    88 88ooo88 
88  ooo 88    88    88          .88'        88      88    88 88~~~88 
88. ~8~ 88b  d88   .88.        j88.         88booo. 88b  d88 88   88    @uniquadev
 Y888P  ~Y8888P' Y888888P      888888D      Y88888P ~Y8888P' YP   YP  CONVERTER 
]=]

-- Instances: 193 | Scripts: 31 | Modules: 0 | Tags: 0
local G2L = {};

-- StarterGui.f3xmain2
G2L["1"] = Instance.new("ScreenGui", game:GetService("CoreGui"));
G2L["1"]["IgnoreGuiInset"] = true;
G2L["1"]["ScreenInsets"] = Enum.ScreenInsets.DeviceSafeInsets;
G2L["1"]["Name"] = [[f3xmain2]];
G2L["1"]["ResetOnSpawn"] = false;


-- StarterGui.f3xmain2.Frame
G2L["2"] = Instance.new("Frame", G2L["1"]);
G2L["2"]["Active"] = true;
G2L["2"]["BorderSizePixel"] = 0;
G2L["2"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["2"]["Size"] = UDim2.new(0.34288, 0, 0.4602, 0);
G2L["2"]["Position"] = UDim2.new(0.03416, 0, 0.35075, 0);
G2L["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);


-- StarterGui.f3xmain2.Frame.top
G2L["3"] = Instance.new("Frame", G2L["2"]);
G2L["3"]["BorderSizePixel"] = 0;
G2L["3"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["3"]["Size"] = UDim2.new(1.05216, 0, 0.12209, 0);
G2L["3"]["Position"] = UDim2.new(-0.02687, 0, 0, 0);
G2L["3"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["3"]["Name"] = [[top]];


-- StarterGui.f3xmain2.Frame.top.UIStroke
G2L["4"] = Instance.new("UIStroke", G2L["3"]);
G2L["4"]["Thickness"] = 7;
G2L["4"]["Color"] = Color3.fromRGB(255, 0, 0);


-- StarterGui.f3xmain2.Frame.top.TextLabel
G2L["5"] = Instance.new("TextLabel", G2L["3"]);
G2L["5"]["TextWrapped"] = true;
G2L["5"]["BorderSizePixel"] = 0;
G2L["5"]["TextSize"] = 14;
G2L["5"]["TextScaled"] = true;
G2L["5"]["BackgroundColor3"] = Color3.fromRGB(59, 59, 59);
G2L["5"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["5"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["5"]["Size"] = UDim2.new(0.48923, 0, -1, 0);
G2L["5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["5"]["Text"] = [[script made by: bedman or NDLgen]];
G2L["5"]["Position"] = UDim2.new(0, 0, 0.98307, 0);


-- StarterGui.f3xmain2.Frame.top.TextLabel.UITextSizeConstraint
G2L["6"] = Instance.new("UITextSizeConstraint", G2L["5"]);
G2L["6"]["MaxTextSize"] = 21;


-- StarterGui.f3xmain2.Frame.top.TextLabel
G2L["7"] = Instance.new("TextLabel", G2L["3"]);
G2L["7"]["TextWrapped"] = true;
G2L["7"]["BorderSizePixel"] = 0;
G2L["7"]["TextSize"] = 14;
G2L["7"]["TextScaled"] = true;
G2L["7"]["BackgroundColor3"] = Color3.fromRGB(59, 59, 59);
G2L["7"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["7"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["7"]["Size"] = UDim2.new(0.47774, 0, -1, 0);
G2L["7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["7"]["Text"] = [[use this to destroy f3x games]];
G2L["7"]["Position"] = UDim2.new(0.522, 0, 0.98307, 0);


-- StarterGui.f3xmain2.Frame.top.TextLabel.UITextSizeConstraint
G2L["8"] = Instance.new("UITextSizeConstraint", G2L["7"]);
G2L["8"]["MaxTextSize"] = 21;


-- StarterGui.f3xmain2.Frame.UIStroke
G2L["9"] = Instance.new("UIStroke", G2L["2"]);
G2L["9"]["Thickness"] = 4;
G2L["9"]["Color"] = Color3.fromRGB(121, 0, 0);


-- StarterGui.f3xmain2.Frame.bottom
G2L["a"] = Instance.new("Frame", G2L["2"]);
G2L["a"]["BorderSizePixel"] = 0;
G2L["a"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["a"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["a"]["Size"] = UDim2.new(1.03848, 0, 0.12209, 0);
G2L["a"]["Position"] = UDim2.new(0.49869, 0, 1.04605, 0);
G2L["a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["a"]["Name"] = [[bottom]];


-- StarterGui.f3xmain2.Frame.bottom.UIStroke
G2L["b"] = Instance.new("UIStroke", G2L["a"]);
G2L["b"]["Thickness"] = 7;
G2L["b"]["Color"] = Color3.fromRGB(255, 0, 0);


-- StarterGui.f3xmain2.Frame.bottom.TextButton
G2L["c"] = Instance.new("TextButton", G2L["a"]);
G2L["c"]["TextWrapped"] = true;
G2L["c"]["BorderSizePixel"] = 0;
G2L["c"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
G2L["c"]["TextSize"] = 14;
G2L["c"]["TextScaled"] = true;
G2L["c"]["BackgroundColor3"] = Color3.fromRGB(59, 59, 59);
G2L["c"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["c"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["c"]["Size"] = UDim2.new(-1, 0, -1, 0);
G2L["c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["c"]["Text"] = [[Give f3x (only if your admin rank in hd admin games )]];
G2L["c"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.f3xmain2.Frame.bottom.TextButton.LocalScript
G2L["d"] = Instance.new("LocalScript", G2L["c"]);



-- StarterGui.f3xmain2.Frame.bottom.TextButton.UITextSizeConstraint
G2L["e"] = Instance.new("UITextSizeConstraint", G2L["c"]);
G2L["e"]["MaxTextSize"] = 38;


-- StarterGui.f3xmain2.Frame.DragScript
G2L["f"] = Instance.new("LocalScript", G2L["2"]);
G2L["f"]["Name"] = [[DragScript]];


-- StarterGui.f3xmain2.Frame.main
G2L["10"] = Instance.new("Frame", G2L["2"]);
G2L["10"]["BorderSizePixel"] = 0;
G2L["10"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["10"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["10"]["Size"] = UDim2.new(0.96275, 0, 0.77035, 0);
G2L["10"]["Position"] = UDim2.new(0.49862, 0, 0.55087, 0);
G2L["10"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["10"]["Name"] = [[main]];
G2L["10"]["BackgroundTransparency"] = 0.3;


-- StarterGui.f3xmain2.Frame.main.UIStroke
G2L["11"] = Instance.new("UIStroke", G2L["10"]);
G2L["11"]["Thickness"] = 2;
G2L["11"]["Color"] = Color3.fromRGB(151, 0, 0);


-- StarterGui.f3xmain2.Frame.main.destruction
G2L["12"] = Instance.new("Frame", G2L["10"]);
G2L["12"]["BorderSizePixel"] = 0;
G2L["12"]["BackgroundColor3"] = Color3.fromRGB(28, 28, 28);
G2L["12"]["Size"] = UDim2.new(0.46206, 0, 0.89573, 0);
G2L["12"]["Position"] = UDim2.new(0.02679, 0, 0.04151, 0);
G2L["12"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["12"]["Name"] = [[destruction]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2
G2L["13"] = Instance.new("TextButton", G2L["12"]);
G2L["13"]["TextWrapped"] = true;
G2L["13"]["BorderSizePixel"] = 0;
G2L["13"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
G2L["13"]["TextSize"] = 14;
G2L["13"]["TextScaled"] = true;
G2L["13"]["BackgroundColor3"] = Color3.fromRGB(59, 59, 59);
G2L["13"]["FontFace"] = Font.new([[rbxasset://fonts/families/ComicNeueAngular.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["13"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["13"]["Size"] = UDim2.new(0.28274, 0, -0.17614, 0);
G2L["13"]["Name"] = [[sky2]];
G2L["13"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["13"]["Text"] = [[Sky2]];
G2L["13"]["Position"] = UDim2.new(0.17708, 0, 0.38201, 0);


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.LocalScript
G2L["14"] = Instance.new("LocalScript", G2L["13"]);



-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames
G2L["15"] = Instance.new("Folder", G2L["13"]);
G2L["15"]["Name"] = [[gif_frames]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.1
G2L["16"] = Instance.new("Decal", G2L["15"]);
G2L["16"]["Name"] = [[1]];
G2L["16"]["Texture"] = [[http://www.roblox.com/asset/?id=9282115523]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.2
G2L["17"] = Instance.new("Decal", G2L["15"]);
G2L["17"]["Name"] = [[2]];
G2L["17"]["Texture"] = [[http://www.roblox.com/asset/?id=9282120015]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.3
G2L["18"] = Instance.new("Decal", G2L["15"]);
G2L["18"]["Name"] = [[3]];
G2L["18"]["Texture"] = [[http://www.roblox.com/asset/?id=9282120346]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.42
G2L["19"] = Instance.new("Decal", G2L["15"]);
G2L["19"]["Name"] = [[42]];
G2L["19"]["Texture"] = [[http://www.roblox.com/asset/?id=9282140103]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.5
G2L["1a"] = Instance.new("Decal", G2L["15"]);
G2L["1a"]["Name"] = [[5]];
G2L["1a"]["Texture"] = [[http://www.roblox.com/asset/?id=9282121507]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.6
G2L["1b"] = Instance.new("Decal", G2L["15"]);
G2L["1b"]["Name"] = [[6]];
G2L["1b"]["Texture"] = [[http://www.roblox.com/asset/?id=9282122029]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.7
G2L["1c"] = Instance.new("Decal", G2L["15"]);
G2L["1c"]["Name"] = [[7]];
G2L["1c"]["Texture"] = [[http://www.roblox.com/asset/?id=9282122427]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.4
G2L["1d"] = Instance.new("Decal", G2L["15"]);
G2L["1d"]["Name"] = [[4]];
G2L["1d"]["Texture"] = [[http://www.roblox.com/asset/?id=9282120720]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.8
G2L["1e"] = Instance.new("Decal", G2L["15"]);
G2L["1e"]["Name"] = [[8]];
G2L["1e"]["Texture"] = [[http://www.roblox.com/asset/?id=9282123195]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.9
G2L["1f"] = Instance.new("Decal", G2L["15"]);
G2L["1f"]["Name"] = [[9]];
G2L["1f"]["Texture"] = [[http://www.roblox.com/asset/?id=9282123789]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.10
G2L["20"] = Instance.new("Decal", G2L["15"]);
G2L["20"]["Name"] = [[10]];
G2L["20"]["Texture"] = [[http://www.roblox.com/asset/?id=9282124179]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.11
G2L["21"] = Instance.new("Decal", G2L["15"]);
G2L["21"]["Name"] = [[11]];
G2L["21"]["Texture"] = [[http://www.roblox.com/asset/?id=9282125162]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.12
G2L["22"] = Instance.new("Decal", G2L["15"]);
G2L["22"]["Name"] = [[12]];
G2L["22"]["Texture"] = [[http://www.roblox.com/asset/?id=9282125645]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.13
G2L["23"] = Instance.new("Decal", G2L["15"]);
G2L["23"]["Name"] = [[13]];
G2L["23"]["Texture"] = [[http://www.roblox.com/asset/?id=9282126074]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.14
G2L["24"] = Instance.new("Decal", G2L["15"]);
G2L["24"]["Name"] = [[14]];
G2L["24"]["Texture"] = [[http://www.roblox.com/asset/?id=9282126474]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.15
G2L["25"] = Instance.new("Decal", G2L["15"]);
G2L["25"]["Name"] = [[15]];
G2L["25"]["Texture"] = [[http://www.roblox.com/asset/?id=9282126991]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.16
G2L["26"] = Instance.new("Decal", G2L["15"]);
G2L["26"]["Name"] = [[16]];
G2L["26"]["Texture"] = [[http://www.roblox.com/asset/?id=9282127390]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.17
G2L["27"] = Instance.new("Decal", G2L["15"]);
G2L["27"]["Name"] = [[17]];
G2L["27"]["Texture"] = [[http://www.roblox.com/asset/?id=9282127772]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.18
G2L["28"] = Instance.new("Decal", G2L["15"]);
G2L["28"]["Name"] = [[18]];
G2L["28"]["Texture"] = [[http://www.roblox.com/asset/?id=9282128101]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.19
G2L["29"] = Instance.new("Decal", G2L["15"]);
G2L["29"]["Name"] = [[19]];
G2L["29"]["Texture"] = [[http://www.roblox.com/asset/?id=9282128472]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.20
G2L["2a"] = Instance.new("Decal", G2L["15"]);
G2L["2a"]["Name"] = [[20]];
G2L["2a"]["Texture"] = [[http://www.roblox.com/asset/?id=9282129029]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.21
G2L["2b"] = Instance.new("Decal", G2L["15"]);
G2L["2b"]["Name"] = [[21]];
G2L["2b"]["Texture"] = [[http://www.roblox.com/asset/?id=9282129378]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.22
G2L["2c"] = Instance.new("Decal", G2L["15"]);
G2L["2c"]["Name"] = [[22]];
G2L["2c"]["Texture"] = [[http://www.roblox.com/asset/?id=9282130080]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.23
G2L["2d"] = Instance.new("Decal", G2L["15"]);
G2L["2d"]["Name"] = [[23]];
G2L["2d"]["Texture"] = [[http://www.roblox.com/asset/?id=9282130496]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.24
G2L["2e"] = Instance.new("Decal", G2L["15"]);
G2L["2e"]["Name"] = [[24]];
G2L["2e"]["Texture"] = [[http://www.roblox.com/asset/?id=9282130919]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.25
G2L["2f"] = Instance.new("Decal", G2L["15"]);
G2L["2f"]["Name"] = [[25]];
G2L["2f"]["Texture"] = [[http://www.roblox.com/asset/?id=9282131320]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.26
G2L["30"] = Instance.new("Decal", G2L["15"]);
G2L["30"]["Name"] = [[26]];
G2L["30"]["Texture"] = [[http://www.roblox.com/asset/?id=9282132188]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.27
G2L["31"] = Instance.new("Decal", G2L["15"]);
G2L["31"]["Name"] = [[27]];
G2L["31"]["Texture"] = [[http://www.roblox.com/asset/?id=9282132983]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.28
G2L["32"] = Instance.new("Decal", G2L["15"]);
G2L["32"]["Name"] = [[28]];
G2L["32"]["Texture"] = [[http://www.roblox.com/asset/?id=9282134027]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.29
G2L["33"] = Instance.new("Decal", G2L["15"]);
G2L["33"]["Name"] = [[29]];
G2L["33"]["Texture"] = [[http://www.roblox.com/asset/?id=9282134596]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.30
G2L["34"] = Instance.new("Decal", G2L["15"]);
G2L["34"]["Name"] = [[30]];
G2L["34"]["Texture"] = [[http://www.roblox.com/asset/?id=9282135188]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.31
G2L["35"] = Instance.new("Decal", G2L["15"]);
G2L["35"]["Name"] = [[31]];
G2L["35"]["Texture"] = [[http://www.roblox.com/asset/?id=9282135611]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.32
G2L["36"] = Instance.new("Decal", G2L["15"]);
G2L["36"]["Name"] = [[32]];
G2L["36"]["Texture"] = [[http://www.roblox.com/asset/?id=9282135996]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.33
G2L["37"] = Instance.new("Decal", G2L["15"]);
G2L["37"]["Name"] = [[33]];
G2L["37"]["Texture"] = [[http://www.roblox.com/asset/?id=9282136340]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.34
G2L["38"] = Instance.new("Decal", G2L["15"]);
G2L["38"]["Name"] = [[34]];
G2L["38"]["Texture"] = [[http://www.roblox.com/asset/?id=9282136848]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.35
G2L["39"] = Instance.new("Decal", G2L["15"]);
G2L["39"]["Name"] = [[35]];
G2L["39"]["Texture"] = [[http://www.roblox.com/asset/?id=9282137385]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.36
G2L["3a"] = Instance.new("Decal", G2L["15"]);
G2L["3a"]["Name"] = [[36]];
G2L["3a"]["Texture"] = [[http://www.roblox.com/asset/?id=9282137881]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.37
G2L["3b"] = Instance.new("Decal", G2L["15"]);
G2L["3b"]["Name"] = [[37]];
G2L["3b"]["Texture"] = [[http://www.roblox.com/asset/?id=9282138246]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.38
G2L["3c"] = Instance.new("Decal", G2L["15"]);
G2L["3c"]["Name"] = [[38]];
G2L["3c"]["Texture"] = [[http://www.roblox.com/asset/?id=9282138675]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.39
G2L["3d"] = Instance.new("Decal", G2L["15"]);
G2L["3d"]["Name"] = [[39]];
G2L["3d"]["Texture"] = [[http://www.roblox.com/asset/?id=9282138998]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.40
G2L["3e"] = Instance.new("Decal", G2L["15"]);
G2L["3e"]["Name"] = [[40]];
G2L["3e"]["Texture"] = [[http://www.roblox.com/asset/?id=9282139388]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.gif_frames.41
G2L["3f"] = Instance.new("Decal", G2L["15"]);
G2L["3f"]["Name"] = [[41]];
G2L["3f"]["Texture"] = [[http://www.roblox.com/asset/?id=9282139730]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky2.UITextSizeConstraint
G2L["40"] = Instance.new("UITextSizeConstraint", G2L["13"]);
G2L["40"]["MaxTextSize"] = 22;


-- StarterGui.f3xmain2.Frame.main.destruction.sky
G2L["41"] = Instance.new("TextButton", G2L["12"]);
G2L["41"]["TextWrapped"] = true;
G2L["41"]["BorderSizePixel"] = 0;
G2L["41"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
G2L["41"]["TextSize"] = 14;
G2L["41"]["TextScaled"] = true;
G2L["41"]["BackgroundColor3"] = Color3.fromRGB(59, 59, 59);
G2L["41"]["FontFace"] = Font.new([[rbxasset://fonts/families/ComicNeueAngular.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["41"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["41"]["Size"] = UDim2.new(0.28274, 0, 0.19035, 0);
G2L["41"]["Name"] = [[sky]];
G2L["41"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["41"]["Text"] = [[Sky]];
G2L["41"]["Position"] = UDim2.new(0.17708, 0, 0.1379, 0);


-- StarterGui.f3xmain2.Frame.main.destruction.sky.LocalScript
G2L["42"] = Instance.new("LocalScript", G2L["41"]);



-- StarterGui.f3xmain2.Frame.main.destruction.sky.TextBox
G2L["43"] = Instance.new("TextBox", G2L["41"]);
G2L["43"]["CursorPosition"] = -1;
G2L["43"]["PlaceholderColor3"] = Color3.fromRGB(207, 0, 0);
G2L["43"]["BorderSizePixel"] = 0;
G2L["43"]["TextWrapped"] = true;
G2L["43"]["TextSize"] = 94;
G2L["43"]["TextColor3"] = Color3.fromRGB(81, 87, 145);
G2L["43"]["TextScaled"] = true;
G2L["43"]["BackgroundColor3"] = Color3.fromRGB(77, 77, 77);
G2L["43"]["FontFace"] = Font.new([[rbxasset://fonts/families/AccanthisADFStd.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["43"]["PlaceholderText"] = [[sky 1 image id...]];
G2L["43"]["Size"] = UDim2.new(1.93347, 0, 0.99859, 0);
G2L["43"]["Position"] = UDim2.new(1.25501, 0, 0, 0);
G2L["43"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["43"]["Text"] = [[]];


-- StarterGui.f3xmain2.Frame.main.destruction.sky.TextBox.UITextSizeConstraint
G2L["44"] = Instance.new("UITextSizeConstraint", G2L["43"]);
G2L["44"]["MaxTextSize"] = 42;


-- StarterGui.f3xmain2.Frame.main.destruction.sky.UITextSizeConstraint
G2L["45"] = Instance.new("UITextSizeConstraint", G2L["41"]);
G2L["45"]["MaxTextSize"] = 29;


-- StarterGui.f3xmain2.Frame.main.destruction.UIStroke
G2L["46"] = Instance.new("UIStroke", G2L["12"]);
G2L["46"]["Thickness"] = 2;
G2L["46"]["Color"] = Color3.fromRGB(255, 0, 0);


-- StarterGui.f3xmain2.Frame.main.destruction.TextLabel
G2L["47"] = Instance.new("TextLabel", G2L["12"]);
G2L["47"]["TextWrapped"] = true;
G2L["47"]["BorderSizePixel"] = 0;
G2L["47"]["TextSize"] = 14;
G2L["47"]["TextScaled"] = true;
G2L["47"]["BackgroundColor3"] = Color3.fromRGB(7, 9, 19);
G2L["47"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["47"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
G2L["47"]["Size"] = UDim2.new(1, 0, 0.13223, 0);
G2L["47"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["47"]["Text"] = [[Destruction]];
G2L["47"]["Position"] = UDim2.new(0, 0, 0.86777, 0);


-- StarterGui.f3xmain2.Frame.main.destruction.TextLabel.UIStroke
G2L["48"] = Instance.new("UIStroke", G2L["47"]);
G2L["48"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["48"]["Thickness"] = 2;
G2L["48"]["Color"] = Color3.fromRGB(255, 0, 0);


-- StarterGui.f3xmain2.Frame.main.destruction.TextLabel.UITextSizeConstraint
G2L["49"] = Instance.new("UITextSizeConstraint", G2L["47"]);
G2L["49"]["MaxTextSize"] = 28;


-- StarterGui.f3xmain2.Frame.main.destruction.fire
G2L["4a"] = Instance.new("TextButton", G2L["12"]);
G2L["4a"]["TextWrapped"] = true;
G2L["4a"]["BorderSizePixel"] = 0;
G2L["4a"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
G2L["4a"]["TextSize"] = 14;
G2L["4a"]["TextScaled"] = true;
G2L["4a"]["BackgroundColor3"] = Color3.fromRGB(59, 59, 59);
G2L["4a"]["FontFace"] = Font.new([[rbxasset://fonts/families/ComicNeueAngular.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["4a"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["4a"]["Size"] = UDim2.new(0.29518, 0, -0.17596, 0);
G2L["4a"]["Name"] = [[fire]];
G2L["4a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["4a"]["Text"] = [[Fire all]];
G2L["4a"]["Position"] = UDim2.new(0.56672, 0, 0.38192, 0);


-- StarterGui.f3xmain2.Frame.main.destruction.fire.LocalScript
G2L["4b"] = Instance.new("LocalScript", G2L["4a"]);



-- StarterGui.f3xmain2.Frame.main.destruction.fire.UITextSizeConstraint
G2L["4c"] = Instance.new("UITextSizeConstraint", G2L["4a"]);
G2L["4c"]["MaxTextSize"] = 42;


-- StarterGui.f3xmain2.Frame.main.destruction.unanchor
G2L["4d"] = Instance.new("TextButton", G2L["12"]);
G2L["4d"]["TextWrapped"] = true;
G2L["4d"]["BorderSizePixel"] = 0;
G2L["4d"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
G2L["4d"]["TextSize"] = 14;
G2L["4d"]["TextScaled"] = true;
G2L["4d"]["BackgroundColor3"] = Color3.fromRGB(59, 59, 59);
G2L["4d"]["RichText"] = true;
G2L["4d"]["FontFace"] = Font.new([[rbxasset://fonts/families/ComicNeueAngular.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["4d"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["4d"]["Size"] = UDim2.new(0.28378, 0, -0.16862, 0);
G2L["4d"]["Name"] = [[unanchor]];
G2L["4d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["4d"]["Text"] = [[Unanchor all]];
G2L["4d"]["Position"] = UDim2.new(0.17656, 0, 0.62464, 0);


-- StarterGui.f3xmain2.Frame.main.destruction.unanchor.LocalScript
G2L["4e"] = Instance.new("LocalScript", G2L["4d"]);



-- StarterGui.f3xmain2.Frame.main.destruction.unanchor.UITextSizeConstraint
G2L["4f"] = Instance.new("UITextSizeConstraint", G2L["4d"]);
G2L["4f"]["MaxTextSize"] = 32;


-- StarterGui.f3xmain2.Frame.main.destruction.delete
G2L["50"] = Instance.new("TextButton", G2L["12"]);
G2L["50"]["TextWrapped"] = true;
G2L["50"]["BorderSizePixel"] = 0;
G2L["50"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
G2L["50"]["TextSize"] = 14;
G2L["50"]["TextScaled"] = true;
G2L["50"]["BackgroundColor3"] = Color3.fromRGB(59, 59, 59);
G2L["50"]["FontFace"] = Font.new([[rbxasset://fonts/families/ComicNeueAngular.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["50"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["50"]["Size"] = UDim2.new(0.29758, 0, -0.16936, 0);
G2L["50"]["Name"] = [[delete]];
G2L["50"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["50"]["Text"] = [[Delete all]];
G2L["50"]["Position"] = UDim2.new(0.56552, 0, 0.62427, 0);


-- StarterGui.f3xmain2.Frame.main.destruction.delete.LocalScript
G2L["51"] = Instance.new("LocalScript", G2L["50"]);



-- StarterGui.f3xmain2.Frame.main.destruction.delete.UITextSizeConstraint
G2L["52"] = Instance.new("UITextSizeConstraint", G2L["50"]);
G2L["52"]["MaxTextSize"] = 34;


-- StarterGui.f3xmain2.Frame.main.destruction.neon
G2L["53"] = Instance.new("TextButton", G2L["12"]);
G2L["53"]["TextWrapped"] = true;
G2L["53"]["BorderSizePixel"] = 0;
G2L["53"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
G2L["53"]["TextSize"] = 14;
G2L["53"]["TextScaled"] = true;
G2L["53"]["BackgroundColor3"] = Color3.fromRGB(59, 59, 59);
G2L["53"]["FontFace"] = Font.new([[rbxasset://fonts/families/ComicNeueAngular.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["53"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["53"]["Size"] = UDim2.new(0.14851, 0, -0.17718, 0);
G2L["53"]["Name"] = [[neon]];
G2L["53"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["53"]["Text"] = [[Neon all]];
G2L["53"]["Position"] = UDim2.new(0.86116, 0, 0.38149, 0);


-- StarterGui.f3xmain2.Frame.main.destruction.neon.LocalScript
G2L["54"] = Instance.new("LocalScript", G2L["53"]);



-- StarterGui.f3xmain2.Frame.main.destruction.neon.UITextSizeConstraint
G2L["55"] = Instance.new("UITextSizeConstraint", G2L["53"]);
G2L["55"]["MaxTextSize"] = 20;


-- StarterGui.f3xmain2.Frame.main.destruction.color
G2L["56"] = Instance.new("TextButton", G2L["12"]);
G2L["56"]["TextWrapped"] = true;
G2L["56"]["BorderSizePixel"] = 0;
G2L["56"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
G2L["56"]["TextSize"] = 14;
G2L["56"]["TextScaled"] = true;
G2L["56"]["BackgroundColor3"] = Color3.fromRGB(59, 59, 59);
G2L["56"]["FontFace"] = Font.new([[rbxasset://fonts/families/ComicNeueAngular.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["56"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["56"]["Size"] = UDim2.new(0.15032, 0, -0.17068, 0);
G2L["56"]["Name"] = [[color]];
G2L["56"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["56"]["Text"] = [[Color all]];
G2L["56"]["Position"] = UDim2.new(0.86206, 0, 0.62361, 0);


-- StarterGui.f3xmain2.Frame.main.destruction.color.LocalScript
G2L["57"] = Instance.new("LocalScript", G2L["56"]);



-- StarterGui.f3xmain2.Frame.main.destruction.color.UITextSizeConstraint
G2L["58"] = Instance.new("UITextSizeConstraint", G2L["56"]);
G2L["58"]["MaxTextSize"] = 20;


-- StarterGui.f3xmain2.Frame.main.destruction.decal
G2L["59"] = Instance.new("TextButton", G2L["12"]);
G2L["59"]["TextWrapped"] = true;
G2L["59"]["BorderSizePixel"] = 0;
G2L["59"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
G2L["59"]["TextSize"] = 14;
G2L["59"]["TextScaled"] = true;
G2L["59"]["BackgroundColor3"] = Color3.fromRGB(59, 59, 59);
G2L["59"]["FontFace"] = Font.new([[rbxasset://fonts/families/ComicNeueAngular.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["59"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["59"]["Size"] = UDim2.new(0.53072, 0, 0.06676, 0);
G2L["59"]["Name"] = [[decal]];
G2L["59"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["59"]["Text"] = [[Decal spam]];
G2L["59"]["Position"] = UDim2.new(0.30108, 0, 0.7795, 0);


-- StarterGui.f3xmain2.Frame.main.destruction.decal.LocalScript
G2L["5a"] = Instance.new("LocalScript", G2L["59"]);



-- StarterGui.f3xmain2.Frame.main.destruction.decal.UITextSizeConstraint
G2L["5b"] = Instance.new("UITextSizeConstraint", G2L["59"]);
G2L["5b"]["MaxTextSize"] = 16;


-- StarterGui.f3xmain2.Frame.main.destruction.decal.decal
G2L["5c"] = Instance.new("TextBox", G2L["59"]);
G2L["5c"]["CursorPosition"] = -1;
G2L["5c"]["Name"] = [[decal]];
G2L["5c"]["PlaceholderColor3"] = Color3.fromRGB(207, 0, 0);
G2L["5c"]["BorderSizePixel"] = 0;
G2L["5c"]["TextWrapped"] = true;
G2L["5c"]["TextSize"] = 14;
G2L["5c"]["TextColor3"] = Color3.fromRGB(81, 87, 145);
G2L["5c"]["TextScaled"] = true;
G2L["5c"]["BackgroundColor3"] = Color3.fromRGB(77, 77, 77);
G2L["5c"]["FontFace"] = Font.new([[rbxasset://fonts/families/AccanthisADFStd.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["5c"]["PlaceholderText"] = [[decal id...]];
G2L["5c"]["Size"] = UDim2.new(0.60967, 0, 0.94872, 0);
G2L["5c"]["Position"] = UDim2.new(1.07801, 0, 0.00823, 0);
G2L["5c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["5c"]["Text"] = [[]];


-- StarterGui.f3xmain2.Frame.main.destruction.decal.decal.UITextSizeConstraint
G2L["5d"] = Instance.new("UITextSizeConstraint", G2L["5c"]);
G2L["5d"]["MaxTextSize"] = 42;


-- StarterGui.f3xmain2.Frame.main.misc
G2L["5e"] = Instance.new("Frame", G2L["10"]);
G2L["5e"]["BorderSizePixel"] = 0;
G2L["5e"]["BackgroundColor3"] = Color3.fromRGB(28, 28, 28);
G2L["5e"]["Size"] = UDim2.new(0.44983, 0, 0.89573, 0);
G2L["5e"]["Position"] = UDim2.new(0.52466, 0, 0.04151, 0);
G2L["5e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["5e"]["Name"] = [[misc]];


-- StarterGui.f3xmain2.Frame.main.misc.UIStroke
G2L["5f"] = Instance.new("UIStroke", G2L["5e"]);
G2L["5f"]["Thickness"] = 2;
G2L["5f"]["Color"] = Color3.fromRGB(255, 0, 0);


-- StarterGui.f3xmain2.Frame.main.misc.TextLabel
G2L["60"] = Instance.new("TextLabel", G2L["5e"]);
G2L["60"]["TextWrapped"] = true;
G2L["60"]["BorderSizePixel"] = 0;
G2L["60"]["TextSize"] = 14;
G2L["60"]["TextScaled"] = true;
G2L["60"]["BackgroundColor3"] = Color3.fromRGB(7, 9, 19);
G2L["60"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["60"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
G2L["60"]["Size"] = UDim2.new(1, 0, 0.13223, 0);
G2L["60"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["60"]["Text"] = [[Misc]];
G2L["60"]["Position"] = UDim2.new(0, 0, 0.86777, 0);


-- StarterGui.f3xmain2.Frame.main.misc.TextLabel.UIStroke
G2L["61"] = Instance.new("UIStroke", G2L["60"]);
G2L["61"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["61"]["Thickness"] = 2;
G2L["61"]["Color"] = Color3.fromRGB(255, 0, 0);


-- StarterGui.f3xmain2.Frame.main.misc.TextLabel.UITextSizeConstraint
G2L["62"] = Instance.new("UITextSizeConstraint", G2L["60"]);
G2L["62"]["MaxTextSize"] = 31;


-- StarterGui.f3xmain2.Frame.main.misc.base
G2L["63"] = Instance.new("TextButton", G2L["5e"]);
G2L["63"]["TextWrapped"] = true;
G2L["63"]["BorderSizePixel"] = 0;
G2L["63"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
G2L["63"]["TextSize"] = 14;
G2L["63"]["TextScaled"] = true;
G2L["63"]["BackgroundColor3"] = Color3.fromRGB(59, 59, 59);
G2L["63"]["FontFace"] = Font.new([[rbxasset://fonts/families/ComicNeueAngular.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["63"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["63"]["Size"] = UDim2.new(0.80548, 0, -0.14734, 0);
G2L["63"]["Name"] = [[base]];
G2L["63"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["63"]["Text"] = [[Create baseplate]];
G2L["63"]["Position"] = UDim2.new(0.51169, 0, 0.11407, 0);


-- StarterGui.f3xmain2.Frame.main.misc.base.LocalScript
G2L["64"] = Instance.new("LocalScript", G2L["63"]);



-- StarterGui.f3xmain2.Frame.main.misc.base.UITextSizeConstraint
G2L["65"] = Instance.new("UITextSizeConstraint", G2L["63"]);
G2L["65"]["MaxTextSize"] = 17;


-- StarterGui.f3xmain2.Frame.main.misc.hd
G2L["66"] = Instance.new("TextButton", G2L["5e"]);
G2L["66"]["TextWrapped"] = true;
G2L["66"]["BorderSizePixel"] = 0;
G2L["66"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
G2L["66"]["TextSize"] = 14;
G2L["66"]["TextScaled"] = true;
G2L["66"]["BackgroundColor3"] = Color3.fromRGB(59, 59, 59);
G2L["66"]["RichText"] = true;
G2L["66"]["FontFace"] = Font.new([[rbxasset://fonts/families/ComicNeueAngular.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["66"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["66"]["Size"] = UDim2.new(0.80548, 0, -0.14651, 0);
G2L["66"]["Name"] = [[hd]];
G2L["66"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["66"]["Text"] = [[HDAdminWorkspaceFolder ( ONLY IN HD ADMIN GAMES )]];
G2L["66"]["Position"] = UDim2.new(0.51169, 0, 0.30464, 0);


-- StarterGui.f3xmain2.Frame.main.misc.hd.LocalScript
G2L["67"] = Instance.new("LocalScript", G2L["66"]);



-- StarterGui.f3xmain2.Frame.main.misc.hd.UITextSizeConstraint
G2L["68"] = Instance.new("UITextSizeConstraint", G2L["66"]);
G2L["68"]["MaxTextSize"] = 33;


-- StarterGui.f3xmain2.Frame.main.misc.kill
G2L["69"] = Instance.new("TextButton", G2L["5e"]);
G2L["69"]["TextWrapped"] = true;
G2L["69"]["BorderSizePixel"] = 0;
G2L["69"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
G2L["69"]["TextSize"] = 14;
G2L["69"]["TextScaled"] = true;
G2L["69"]["BackgroundColor3"] = Color3.fromRGB(59, 59, 59);
G2L["69"]["FontFace"] = Font.new([[rbxasset://fonts/families/ComicNeueAngular.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["69"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["69"]["Size"] = UDim2.new(0.80548, 0, -0.13504, 0);
G2L["69"]["Name"] = [[kill]];
G2L["69"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["69"]["Text"] = [[Kill all]];
G2L["69"]["Position"] = UDim2.new(0.51169, 0, 0.47074, 0);


-- StarterGui.f3xmain2.Frame.main.misc.kill.LocalScript
G2L["6a"] = Instance.new("LocalScript", G2L["69"]);



-- StarterGui.f3xmain2.Frame.main.misc.kill.UITextSizeConstraint
G2L["6b"] = Instance.new("UITextSizeConstraint", G2L["69"]);
G2L["6b"]["MaxTextSize"] = 32;


-- StarterGui.f3xmain2.Frame.main.misc.rotate
G2L["6c"] = Instance.new("TextButton", G2L["5e"]);
G2L["6c"]["TextWrapped"] = true;
G2L["6c"]["BorderSizePixel"] = 0;
G2L["6c"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
G2L["6c"]["TextSize"] = 14;
G2L["6c"]["TextScaled"] = true;
G2L["6c"]["BackgroundColor3"] = Color3.fromRGB(59, 59, 59);
G2L["6c"]["FontFace"] = Font.new([[rbxasset://fonts/families/ComicNeueAngular.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["6c"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["6c"]["Size"] = UDim2.new(0.80697, 0, -0.13046, 0);
G2L["6c"]["Name"] = [[rotate]];
G2L["6c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["6c"]["Text"] = [[Rotate all]];
G2L["6c"]["Position"] = UDim2.new(0.51094, 0, 0.64372, 0);


-- StarterGui.f3xmain2.Frame.main.misc.rotate.LocalScript
G2L["6d"] = Instance.new("LocalScript", G2L["6c"]);



-- StarterGui.f3xmain2.Frame.main.misc.rotate.UITextSizeConstraint
G2L["6e"] = Instance.new("UITextSizeConstraint", G2L["6c"]);
G2L["6e"]["MaxTextSize"] = 31;


-- StarterGui.f3xmain2.Frame.main.misc.mesh
G2L["6f"] = Instance.new("TextButton", G2L["5e"]);
G2L["6f"]["TextWrapped"] = true;
G2L["6f"]["BorderSizePixel"] = 0;
G2L["6f"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
G2L["6f"]["TextSize"] = 14;
G2L["6f"]["TextScaled"] = true;
G2L["6f"]["BackgroundColor3"] = Color3.fromRGB(59, 59, 59);
G2L["6f"]["FontFace"] = Font.new([[rbxasset://fonts/families/ComicNeueAngular.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["6f"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["6f"]["Size"] = UDim2.new(0.81103, 0, -0.06676, 0);
G2L["6f"]["Name"] = [[mesh]];
G2L["6f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["6f"]["Text"] = [[Random Mesh all]];
G2L["6f"]["Position"] = UDim2.new(0.50891, 0, 0.7795, 0);


-- StarterGui.f3xmain2.Frame.main.misc.mesh.LocalScript
G2L["70"] = Instance.new("LocalScript", G2L["6f"]);



-- StarterGui.f3xmain2.Frame.main.misc.mesh.UITextSizeConstraint
G2L["71"] = Instance.new("UITextSizeConstraint", G2L["6f"]);
G2L["71"]["MaxTextSize"] = 16;


-- StarterGui.f3xmain2.Frame.main2
G2L["72"] = Instance.new("Frame", G2L["2"]);
G2L["72"]["Visible"] = false;
G2L["72"]["BorderSizePixel"] = 0;
G2L["72"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["72"]["Size"] = UDim2.new(0.96552, 0, 0.77035, 0);
G2L["72"]["Position"] = UDim2.new(0.02002, 0, 0.1657, 0);
G2L["72"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["72"]["Name"] = [[main2]];


-- StarterGui.f3xmain2.Frame.main2.UIStroke
G2L["73"] = Instance.new("UIStroke", G2L["72"]);
G2L["73"]["Thickness"] = 2;
G2L["73"]["Color"] = Color3.fromRGB(251, 0, 0);


-- StarterGui.f3xmain2.Frame.main2.localplayer
G2L["74"] = Instance.new("Frame", G2L["72"]);
G2L["74"]["BorderSizePixel"] = 0;
G2L["74"]["BackgroundColor3"] = Color3.fromRGB(28, 28, 28);
G2L["74"]["Size"] = UDim2.new(0.44643, 0, 0.91321, 0);
G2L["74"]["Position"] = UDim2.new(0.02679, 0, 0.04151, 0);
G2L["74"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["74"]["Name"] = [[localplayer]];


-- StarterGui.f3xmain2.Frame.main2.localplayer.UIStroke
G2L["75"] = Instance.new("UIStroke", G2L["74"]);
G2L["75"]["Thickness"] = 2;
G2L["75"]["Color"] = Color3.fromRGB(251, 0, 0);


-- StarterGui.f3xmain2.Frame.main2.localplayer.TextLabel
G2L["76"] = Instance.new("TextLabel", G2L["74"]);
G2L["76"]["TextWrapped"] = true;
G2L["76"]["BorderSizePixel"] = 0;
G2L["76"]["TextSize"] = 14;
G2L["76"]["TextScaled"] = true;
G2L["76"]["BackgroundColor3"] = Color3.fromRGB(7, 9, 19);
G2L["76"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["76"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
G2L["76"]["Size"] = UDim2.new(1, 0, 0.13223, 0);
G2L["76"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["76"]["Text"] = [[Local Player]];
G2L["76"]["Position"] = UDim2.new(0, 0, 0.86777, 0);


-- StarterGui.f3xmain2.Frame.main2.localplayer.TextLabel.UIStroke
G2L["77"] = Instance.new("UIStroke", G2L["76"]);
G2L["77"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["77"]["Thickness"] = 2;
G2L["77"]["Color"] = Color3.fromRGB(251, 0, 0);


-- StarterGui.f3xmain2.Frame.main2.localplayer.TextLabel.UITextSizeConstraint
G2L["78"] = Instance.new("UITextSizeConstraint", G2L["76"]);
G2L["78"]["MaxTextSize"] = 28;


-- StarterGui.f3xmain2.Frame.main2.localplayer.trail
G2L["79"] = Instance.new("TextButton", G2L["74"]);
G2L["79"]["TextWrapped"] = true;
G2L["79"]["BorderSizePixel"] = 0;
G2L["79"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
G2L["79"]["TextSize"] = 14;
G2L["79"]["TextScaled"] = true;
G2L["79"]["BackgroundColor3"] = Color3.fromRGB(59, 59, 59);
G2L["79"]["FontFace"] = Font.new([[rbxasset://fonts/families/ComicNeueAngular.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["79"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["79"]["Size"] = UDim2.new(0.36851, 0, -0.1961, 0);
G2L["79"]["Name"] = [[trail]];
G2L["79"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["79"]["Text"] = [[Trail]];
G2L["79"]["Position"] = UDim2.new(0.28103, 0, 0.12937, 0);


-- StarterGui.f3xmain2.Frame.main2.localplayer.trail.LocalScript
G2L["7a"] = Instance.new("LocalScript", G2L["79"]);



-- StarterGui.f3xmain2.Frame.main2.localplayer.trail.UITextSizeConstraint
G2L["7b"] = Instance.new("UITextSizeConstraint", G2L["79"]);
G2L["7b"]["MaxTextSize"] = 33;


-- StarterGui.f3xmain2.Frame.main2.localplayer.laserknife
G2L["7c"] = Instance.new("TextButton", G2L["74"]);
G2L["7c"]["TextWrapped"] = true;
G2L["7c"]["BorderSizePixel"] = 0;
G2L["7c"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
G2L["7c"]["TextSize"] = 14;
G2L["7c"]["TextScaled"] = true;
G2L["7c"]["BackgroundColor3"] = Color3.fromRGB(59, 59, 59);
G2L["7c"]["RichText"] = true;
G2L["7c"]["FontFace"] = Font.new([[rbxasset://fonts/families/ComicNeueAngular.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["7c"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["7c"]["Size"] = UDim2.new(0.36851, 0, -0.1961, 0);
G2L["7c"]["Name"] = [[laserknife]];
G2L["7c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["7c"]["Text"] = [[laserknife (not mine, credits to sauga77kjk)]];
G2L["7c"]["Position"] = UDim2.new(0.72103, 0, 0.12937, 0);


-- StarterGui.f3xmain2.Frame.main2.localplayer.laserknife.LocalScript
G2L["7d"] = Instance.new("LocalScript", G2L["7c"]);



-- StarterGui.f3xmain2.Frame.main2.localplayer.laserknife.UITextSizeConstraint
G2L["7e"] = Instance.new("UITextSizeConstraint", G2L["7c"]);
G2L["7e"]["MaxTextSize"] = 44;


-- StarterGui.f3xmain2.Frame.main2.localplayer.walkspeed
G2L["7f"] = Instance.new("TextButton", G2L["74"]);
G2L["7f"]["TextWrapped"] = true;
G2L["7f"]["BorderSizePixel"] = 0;
G2L["7f"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
G2L["7f"]["Modal"] = true;
G2L["7f"]["TextSize"] = 14;
G2L["7f"]["TextScaled"] = true;
G2L["7f"]["BackgroundColor3"] = Color3.fromRGB(59, 59, 59);
G2L["7f"]["FontFace"] = Font.new([[rbxasset://fonts/families/ComicNeueAngular.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["7f"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["7f"]["Size"] = UDim2.new(0.36851, 0, -0.1961, 0);
G2L["7f"]["Name"] = [[walkspeed]];
G2L["7f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["7f"]["Text"] = [[Walkspeed]];
G2L["7f"]["Position"] = UDim2.new(0.28103, 0, 0.38144, 0);


-- StarterGui.f3xmain2.Frame.main2.localplayer.walkspeed.LocalScript
G2L["80"] = Instance.new("LocalScript", G2L["7f"]);



-- StarterGui.f3xmain2.Frame.main2.localplayer.walkspeed.UITextSizeConstraint
G2L["81"] = Instance.new("UITextSizeConstraint", G2L["7f"]);
G2L["81"]["MaxTextSize"] = 12;


-- StarterGui.f3xmain2.Frame.main2.localplayer.jump
G2L["82"] = Instance.new("TextButton", G2L["74"]);
G2L["82"]["TextWrapped"] = true;
G2L["82"]["BorderSizePixel"] = 0;
G2L["82"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
G2L["82"]["Modal"] = true;
G2L["82"]["TextSize"] = 14;
G2L["82"]["TextScaled"] = true;
G2L["82"]["BackgroundColor3"] = Color3.fromRGB(59, 59, 59);
G2L["82"]["FontFace"] = Font.new([[rbxasset://fonts/families/ComicNeueAngular.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["82"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["82"]["Size"] = UDim2.new(0.36851, 0, -0.1961, 0);
G2L["82"]["Name"] = [[jump]];
G2L["82"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["82"]["Text"] = [[Jump Power]];
G2L["82"]["Position"] = UDim2.new(0.28103, 0, 0.62111, 0);


-- StarterGui.f3xmain2.Frame.main2.localplayer.jump.LocalScript
G2L["83"] = Instance.new("LocalScript", G2L["82"]);



-- StarterGui.f3xmain2.Frame.main2.localplayer.jump.UITextSizeConstraint
G2L["84"] = Instance.new("UITextSizeConstraint", G2L["82"]);
G2L["84"]["MaxTextSize"] = 44;


-- StarterGui.f3xmain2.Frame.main2.localplayer.speed
G2L["85"] = Instance.new("TextBox", G2L["74"]);
G2L["85"]["Name"] = [[speed]];
G2L["85"]["PlaceholderColor3"] = Color3.fromRGB(255, 0, 0);
G2L["85"]["BorderSizePixel"] = 0;
G2L["85"]["TextWrapped"] = true;
G2L["85"]["TextSize"] = 14;
G2L["85"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["85"]["TextScaled"] = true;
G2L["85"]["BackgroundColor3"] = Color3.fromRGB(77, 77, 77);
G2L["85"]["RichText"] = true;
G2L["85"]["FontFace"] = Font.new([[rbxasset://fonts/families/JosefinSans.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["85"]["PlaceholderText"] = [[walkspeed]];
G2L["85"]["Size"] = UDim2.new(0.36667, 0, 0.20661, 0);
G2L["85"]["Position"] = UDim2.new(0.53333, 0, 0.27686, 0);
G2L["85"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["85"]["Text"] = [[]];


-- StarterGui.f3xmain2.Frame.main2.localplayer.speed.UITextSizeConstraint
G2L["86"] = Instance.new("UITextSizeConstraint", G2L["85"]);
G2L["86"]["MaxTextSize"] = 10;


-- StarterGui.f3xmain2.Frame.main2.localplayer.jump
G2L["87"] = Instance.new("TextBox", G2L["74"]);
G2L["87"]["Name"] = [[jump]];
G2L["87"]["PlaceholderColor3"] = Color3.fromRGB(255, 0, 0);
G2L["87"]["BorderSizePixel"] = 0;
G2L["87"]["TextWrapped"] = true;
G2L["87"]["TextSize"] = 14;
G2L["87"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["87"]["TextScaled"] = true;
G2L["87"]["BackgroundColor3"] = Color3.fromRGB(77, 77, 77);
G2L["87"]["RichText"] = true;
G2L["87"]["FontFace"] = Font.new([[rbxasset://fonts/families/JosefinSans.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["87"]["PlaceholderText"] = [[jumppower]];
G2L["87"]["Size"] = UDim2.new(0.36667, 0, 0.20661, 0);
G2L["87"]["Position"] = UDim2.new(0.53333, 0, 0.5124, 0);
G2L["87"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["87"]["Text"] = [[]];


-- StarterGui.f3xmain2.Frame.main2.localplayer.jump.UITextSizeConstraint
G2L["88"] = Instance.new("UITextSizeConstraint", G2L["87"]);
G2L["88"]["MaxTextSize"] = 9;


-- StarterGui.f3xmain2.Frame.main2.hd
G2L["89"] = Instance.new("Frame", G2L["72"]);
G2L["89"]["BorderSizePixel"] = 0;
G2L["89"]["BackgroundColor3"] = Color3.fromRGB(28, 28, 28);
G2L["89"]["Size"] = UDim2.new(0.44643, 0, 0.49155, 0);
G2L["89"]["Position"] = UDim2.new(0.52095, 0, 0.04151, 0);
G2L["89"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["89"]["Name"] = [[hd]];


-- StarterGui.f3xmain2.Frame.main2.hd.UIStroke
G2L["8a"] = Instance.new("UIStroke", G2L["89"]);
G2L["8a"]["Thickness"] = 2;
G2L["8a"]["Color"] = Color3.fromRGB(251, 0, 0);


-- StarterGui.f3xmain2.Frame.main2.hd.TextLabel
G2L["8b"] = Instance.new("TextLabel", G2L["89"]);
G2L["8b"]["TextWrapped"] = true;
G2L["8b"]["BorderSizePixel"] = 0;
G2L["8b"]["TextSize"] = 14;
G2L["8b"]["TextScaled"] = true;
G2L["8b"]["BackgroundColor3"] = Color3.fromRGB(59, 59, 59);
G2L["8b"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["8b"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
G2L["8b"]["Size"] = UDim2.new(1, 0, 0.13223, 0);
G2L["8b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["8b"]["Text"] = [[HD Admin Scripts]];
G2L["8b"]["Position"] = UDim2.new(0, 0, 0.86777, 0);


-- StarterGui.f3xmain2.Frame.main2.hd.TextLabel.UIStroke
G2L["8c"] = Instance.new("UIStroke", G2L["8b"]);
G2L["8c"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["8c"]["Thickness"] = 2;
G2L["8c"]["Color"] = Color3.fromRGB(251, 0, 0);


-- StarterGui.f3xmain2.Frame.main2.hd.TextLabel.UITextSizeConstraint
G2L["8d"] = Instance.new("UITextSizeConstraint", G2L["8b"]);
G2L["8d"]["MaxTextSize"] = 28;


-- StarterGui.f3xmain2.Frame.main2.hd.MML
G2L["8e"] = Instance.new("TextButton", G2L["89"]);
G2L["8e"]["TextWrapped"] = true;
G2L["8e"]["BorderSizePixel"] = 0;
G2L["8e"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
G2L["8e"]["Modal"] = true;
G2L["8e"]["TextSize"] = 14;
G2L["8e"]["TextScaled"] = true;
G2L["8e"]["BackgroundColor3"] = Color3.fromRGB(59, 59, 59);
G2L["8e"]["FontFace"] = Font.new([[rbxasset://fonts/families/ComicNeueAngular.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["8e"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["8e"]["Size"] = UDim2.new(0.81523, 0, -0.1961, 0);
G2L["8e"]["Name"] = [[MML]];
G2L["8e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["8e"]["Text"] = [[MML Admin]];
G2L["8e"]["Position"] = UDim2.new(0.51006, 0, 0.15046, 0);


-- StarterGui.f3xmain2.Frame.main2.hd.MML.LocalScript
G2L["8f"] = Instance.new("LocalScript", G2L["8e"]);



-- StarterGui.f3xmain2.Frame.main2.hd.MML.UITextSizeConstraint
G2L["90"] = Instance.new("UITextSizeConstraint", G2L["8e"]);
G2L["90"]["MaxTextSize"] = 44;


-- StarterGui.f3xmain2.Frame.main2.hd.gghub
G2L["91"] = Instance.new("TextButton", G2L["89"]);
G2L["91"]["TextWrapped"] = true;
G2L["91"]["BorderSizePixel"] = 0;
G2L["91"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
G2L["91"]["Modal"] = true;
G2L["91"]["TextSize"] = 14;
G2L["91"]["TextScaled"] = true;
G2L["91"]["BackgroundColor3"] = Color3.fromRGB(59, 59, 59);
G2L["91"]["FontFace"] = Font.new([[rbxasset://fonts/families/ComicNeueAngular.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["91"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["91"]["Size"] = UDim2.new(0.81523, 0, -0.1961, 0);
G2L["91"]["Name"] = [[gghub]];
G2L["91"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["91"]["Text"] = [[GG Hub Remastered]];
G2L["91"]["Position"] = UDim2.new(0.51006, 0, 0.49691, 0);


-- StarterGui.f3xmain2.Frame.main2.hd.gghub.LocalScript
G2L["92"] = Instance.new("LocalScript", G2L["91"]);



-- StarterGui.f3xmain2.Frame.main2.hd.gghub.UITextSizeConstraint
G2L["93"] = Instance.new("UITextSizeConstraint", G2L["91"]);
G2L["93"]["MaxTextSize"] = 44;


-- StarterGui.f3xmain2.Frame.main2.universal
G2L["94"] = Instance.new("Frame", G2L["72"]);
G2L["94"]["BorderSizePixel"] = 0;
G2L["94"]["BackgroundColor3"] = Color3.fromRGB(28, 28, 28);
G2L["94"]["Size"] = UDim2.new(0.44643, 0, 0.36466, 0);
G2L["94"]["Position"] = UDim2.new(0.52095, 0, 0.58932, 0);
G2L["94"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["94"]["Name"] = [[universal]];


-- StarterGui.f3xmain2.Frame.main2.universal.UIStroke
G2L["95"] = Instance.new("UIStroke", G2L["94"]);
G2L["95"]["Thickness"] = 2;
G2L["95"]["Color"] = Color3.fromRGB(251, 0, 0);


-- StarterGui.f3xmain2.Frame.main2.universal.TextLabel
G2L["96"] = Instance.new("TextLabel", G2L["94"]);
G2L["96"]["TextWrapped"] = true;
G2L["96"]["BorderSizePixel"] = 0;
G2L["96"]["TextSize"] = 14;
G2L["96"]["TextScaled"] = true;
G2L["96"]["BackgroundColor3"] = Color3.fromRGB(59, 59, 59);
G2L["96"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["96"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
G2L["96"]["Size"] = UDim2.new(1, 0, 0.27717, 0);
G2L["96"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["96"]["Text"] = [[Universal]];
G2L["96"]["Position"] = UDim2.new(0, 0, 0.72283, 0);


-- StarterGui.f3xmain2.Frame.main2.universal.TextLabel.UIStroke
G2L["97"] = Instance.new("UIStroke", G2L["96"]);
G2L["97"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["97"]["Thickness"] = 2;
G2L["97"]["Color"] = Color3.fromRGB(251, 0, 0);


-- StarterGui.f3xmain2.Frame.main2.universal.TextLabel.UITextSizeConstraint
G2L["98"] = Instance.new("UITextSizeConstraint", G2L["96"]);
G2L["98"]["MaxTextSize"] = 28;


-- StarterGui.f3xmain2.Frame.main2.universal.rc7
G2L["99"] = Instance.new("TextButton", G2L["94"]);
G2L["99"]["TextWrapped"] = true;
G2L["99"]["BorderSizePixel"] = 0;
G2L["99"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
G2L["99"]["Modal"] = true;
G2L["99"]["TextSize"] = 14;
G2L["99"]["TextScaled"] = true;
G2L["99"]["BackgroundColor3"] = Color3.fromRGB(59, 59, 59);
G2L["99"]["FontFace"] = Font.new([[rbxasset://fonts/families/ComicNeueAngular.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["99"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["99"]["Size"] = UDim2.new(0.81523, 0, -0.1961, 0);
G2L["99"]["Name"] = [[rc7]];
G2L["99"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["99"]["Text"] = [[RC7]];
G2L["99"]["Position"] = UDim2.new(0.51006, 0, 0.15046, 0);


-- StarterGui.f3xmain2.Frame.main2.universal.rc7.LocalScript
G2L["9a"] = Instance.new("LocalScript", G2L["99"]);



-- StarterGui.f3xmain2.Frame.main2.universal.rc7.UITextSizeConstraint
G2L["9b"] = Instance.new("UITextSizeConstraint", G2L["99"]);
G2L["9b"]["MaxTextSize"] = 44;


-- StarterGui.f3xmain2.Frame.main2.universal.sirius
G2L["9c"] = Instance.new("TextButton", G2L["94"]);
G2L["9c"]["TextWrapped"] = true;
G2L["9c"]["BorderSizePixel"] = 0;
G2L["9c"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
G2L["9c"]["Modal"] = true;
G2L["9c"]["TextSize"] = 14;
G2L["9c"]["TextScaled"] = true;
G2L["9c"]["BackgroundColor3"] = Color3.fromRGB(59, 59, 59);
G2L["9c"]["RichText"] = true;
G2L["9c"]["FontFace"] = Font.new([[rbxasset://fonts/families/ComicNeueAngular.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["9c"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["9c"]["Size"] = UDim2.new(0.81523, 0, -0.1961, 0);
G2L["9c"]["Name"] = [[sirius]];
G2L["9c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["9c"]["Text"] = [[Sirius (credits to the owners)]];
G2L["9c"]["Position"] = UDim2.new(0.51006, 0, 0.49691, 0);


-- StarterGui.f3xmain2.Frame.main2.universal.sirius.LocalScript
G2L["9d"] = Instance.new("LocalScript", G2L["9c"]);



-- StarterGui.f3xmain2.Frame.main2.universal.sirius.UITextSizeConstraint
G2L["9e"] = Instance.new("UITextSizeConstraint", G2L["9c"]);
G2L["9e"]["MaxTextSize"] = 44;


-- StarterGui.f3xmain2.Frame.switch
G2L["9f"] = Instance.new("TextButton", G2L["2"]);
G2L["9f"]["TextWrapped"] = true;
G2L["9f"]["BorderSizePixel"] = 0;
G2L["9f"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
G2L["9f"]["TextSize"] = 14;
G2L["9f"]["TextScaled"] = true;
G2L["9f"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["9f"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["9f"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["9f"]["Size"] = UDim2.new(0.10588, 0, 0.79651, 0);
G2L["9f"]["Name"] = [[switch]];
G2L["9f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["9f"]["Text"] = [[Page 1]];
G2L["9f"]["Position"] = UDim2.new(1.07667, 0, 0.56189, 0);


-- StarterGui.f3xmain2.Frame.switch.UIStroke
G2L["a0"] = Instance.new("UIStroke", G2L["9f"]);
G2L["a0"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["a0"]["Thickness"] = 2;
G2L["a0"]["Color"] = Color3.fromRGB(251, 0, 0);


-- StarterGui.f3xmain2.Frame.switch.LocalScript
G2L["a1"] = Instance.new("LocalScript", G2L["9f"]);



-- StarterGui.f3xmain2.Frame.switch.UITextSizeConstraint
G2L["a2"] = Instance.new("UITextSizeConstraint", G2L["9f"]);
G2L["a2"]["MaxTextSize"] = 48;


-- StarterGui.f3xmain2.Frame.main3
G2L["a3"] = Instance.new("Frame", G2L["2"]);
G2L["a3"]["Visible"] = false;
G2L["a3"]["BorderSizePixel"] = 0;
G2L["a3"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["a3"]["Size"] = UDim2.new(0.96552, 0, 0.77035, 0);
G2L["a3"]["Position"] = UDim2.new(0.02002, 0, 0.1657, 0);
G2L["a3"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["a3"]["Name"] = [[main3]];


-- StarterGui.f3xmain2.Frame.main3.UIStroke
G2L["a4"] = Instance.new("UIStroke", G2L["a3"]);
G2L["a4"]["Thickness"] = 2;
G2L["a4"]["Color"] = Color3.fromRGB(251, 0, 0);


-- StarterGui.f3xmain2.Frame.main3.skies
G2L["a5"] = Instance.new("Frame", G2L["a3"]);
G2L["a5"]["BorderSizePixel"] = 0;
G2L["a5"]["BackgroundColor3"] = Color3.fromRGB(28, 28, 28);
G2L["a5"]["Size"] = UDim2.new(0.94204, 0, 0.91321, 0);
G2L["a5"]["Position"] = UDim2.new(0.02679, 0, 0.04151, 0);
G2L["a5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["a5"]["Name"] = [[skies]];


-- StarterGui.f3xmain2.Frame.main3.skies.UIStroke
G2L["a6"] = Instance.new("UIStroke", G2L["a5"]);
G2L["a6"]["Thickness"] = 2;
G2L["a6"]["Color"] = Color3.fromRGB(251, 0, 0);


-- StarterGui.f3xmain2.Frame.main3.skies.TextLabel
G2L["a7"] = Instance.new("TextLabel", G2L["a5"]);
G2L["a7"]["TextWrapped"] = true;
G2L["a7"]["BorderSizePixel"] = 0;
G2L["a7"]["TextSize"] = 14;
G2L["a7"]["TextScaled"] = true;
G2L["a7"]["BackgroundColor3"] = Color3.fromRGB(59, 59, 59);
G2L["a7"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["a7"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
G2L["a7"]["Size"] = UDim2.new(1, 0, 0.13223, 0);
G2L["a7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["a7"]["Text"] = [[SKIES]];
G2L["a7"]["Position"] = UDim2.new(0, 0, 0.86777, 0);


-- StarterGui.f3xmain2.Frame.main3.skies.TextLabel.UIStroke
G2L["a8"] = Instance.new("UIStroke", G2L["a7"]);
G2L["a8"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["a8"]["Thickness"] = 2;
G2L["a8"]["Color"] = Color3.fromRGB(251, 0, 0);


-- StarterGui.f3xmain2.Frame.main3.skies.TextLabel.UITextSizeConstraint
G2L["a9"] = Instance.new("UITextSizeConstraint", G2L["a7"]);
G2L["a9"]["MaxTextSize"] = 28;


-- StarterGui.f3xmain2.Frame.main3.skies.chip
G2L["aa"] = Instance.new("TextButton", G2L["a5"]);
G2L["aa"]["TextWrapped"] = true;
G2L["aa"]["BorderSizePixel"] = 0;
G2L["aa"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
G2L["aa"]["TextSize"] = 14;
G2L["aa"]["TextScaled"] = true;
G2L["aa"]["BackgroundColor3"] = Color3.fromRGB(59, 59, 59);
G2L["aa"]["FontFace"] = Font.new([[rbxasset://fonts/families/ComicNeueAngular.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["aa"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["aa"]["Size"] = UDim2.new(0.36851, 0, -0.1961, 0);
G2L["aa"]["Name"] = [[chip]];
G2L["aa"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["aa"]["Text"] = [[chip]];
G2L["aa"]["Position"] = UDim2.new(0.70875, 0, 0.13993, 0);


-- StarterGui.f3xmain2.Frame.main3.skies.chip.UITextSizeConstraint
G2L["ab"] = Instance.new("UITextSizeConstraint", G2L["aa"]);
G2L["ab"]["MaxTextSize"] = 33;


-- StarterGui.f3xmain2.Frame.main3.skies.chip.LocalScript
G2L["ac"] = Instance.new("LocalScript", G2L["aa"]);



-- StarterGui.f3xmain2.Frame.main3.skies.skeleton
G2L["ad"] = Instance.new("TextButton", G2L["a5"]);
G2L["ad"]["TextWrapped"] = true;
G2L["ad"]["BorderSizePixel"] = 0;
G2L["ad"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
G2L["ad"]["Modal"] = true;
G2L["ad"]["TextSize"] = 14;
G2L["ad"]["TextScaled"] = true;
G2L["ad"]["BackgroundColor3"] = Color3.fromRGB(59, 59, 59);
G2L["ad"]["FontFace"] = Font.new([[rbxasset://fonts/families/ComicNeueAngular.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["ad"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["ad"]["Size"] = UDim2.new(0.36851, 0, -0.1961, 0);
G2L["ad"]["Name"] = [[skeleton]];
G2L["ad"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["ad"]["Text"] = [[Skeleton]];
G2L["ad"]["Position"] = UDim2.new(0.28641, 0, 0.13907, 0);


-- StarterGui.f3xmain2.Frame.main3.skies.skeleton.LocalScript
G2L["ae"] = Instance.new("LocalScript", G2L["ad"]);



-- StarterGui.f3xmain2.Frame.main3.skies.skeleton.UITextSizeConstraint
G2L["af"] = Instance.new("UITextSizeConstraint", G2L["ad"]);
G2L["af"]["MaxTextSize"] = 44;


-- StarterGui.f3xmain2.Frame.main3.skies.geometry
G2L["b0"] = Instance.new("TextButton", G2L["a5"]);
G2L["b0"]["TextWrapped"] = true;
G2L["b0"]["BorderSizePixel"] = 0;
G2L["b0"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
G2L["b0"]["TextSize"] = 14;
G2L["b0"]["TextScaled"] = true;
G2L["b0"]["BackgroundColor3"] = Color3.fromRGB(59, 59, 59);
G2L["b0"]["FontFace"] = Font.new([[rbxasset://fonts/families/ComicNeueAngular.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["b0"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["b0"]["Size"] = UDim2.new(0.36851, 0, -0.1961, 0);
G2L["b0"]["Name"] = [[geometry]];
G2L["b0"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["b0"]["Text"] = [[geometry]];
G2L["b0"]["Position"] = UDim2.new(0.28372, 0, 0.42845, 0);


-- StarterGui.f3xmain2.Frame.main3.skies.geometry.UITextSizeConstraint
G2L["b1"] = Instance.new("UITextSizeConstraint", G2L["b0"]);
G2L["b1"]["MaxTextSize"] = 33;


-- StarterGui.f3xmain2.Frame.main3.skies.geometry.LocalScript
G2L["b2"] = Instance.new("LocalScript", G2L["b0"]);



-- StarterGui.f3xmain2.Frame.main3.skies.cow
G2L["b3"] = Instance.new("TextButton", G2L["a5"]);
G2L["b3"]["TextWrapped"] = true;
G2L["b3"]["BorderSizePixel"] = 0;
G2L["b3"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
G2L["b3"]["Modal"] = true;
G2L["b3"]["TextSize"] = 14;
G2L["b3"]["TextScaled"] = true;
G2L["b3"]["BackgroundColor3"] = Color3.fromRGB(59, 59, 59);
G2L["b3"]["FontFace"] = Font.new([[rbxasset://fonts/families/ComicNeueAngular.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["b3"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["b3"]["Size"] = UDim2.new(0.36851, 0, -0.1961, 0);
G2L["b3"]["Name"] = [[cow]];
G2L["b3"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["b3"]["Text"] = [[polish cow]];
G2L["b3"]["Position"] = UDim2.new(0.70875, 0, 0.42845, 0);


-- StarterGui.f3xmain2.Frame.main3.skies.cow.UITextSizeConstraint
G2L["b4"] = Instance.new("UITextSizeConstraint", G2L["b3"]);
G2L["b4"]["MaxTextSize"] = 33;


-- StarterGui.f3xmain2.Frame.main3.skies.cow.LocalScript
G2L["b5"] = Instance.new("LocalScript", G2L["b3"]);



-- StarterGui.f3xmain2.Frame.main3.skies.banana
G2L["b6"] = Instance.new("TextButton", G2L["a5"]);
G2L["b6"]["TextWrapped"] = true;
G2L["b6"]["BorderSizePixel"] = 0;
G2L["b6"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
G2L["b6"]["TextSize"] = 14;
G2L["b6"]["TextScaled"] = true;
G2L["b6"]["BackgroundColor3"] = Color3.fromRGB(59, 59, 59);
G2L["b6"]["FontFace"] = Font.new([[rbxasset://fonts/families/ComicNeueAngular.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["b6"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["b6"]["Size"] = UDim2.new(0.36851, 0, -0.1961, 0);
G2L["b6"]["Name"] = [[banana]];
G2L["b6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["b6"]["Text"] = [[banana]];
G2L["b6"]["Position"] = UDim2.new(0.70875, 0, 0.67475, 0);


-- StarterGui.f3xmain2.Frame.main3.skies.banana.UITextSizeConstraint
G2L["b7"] = Instance.new("UITextSizeConstraint", G2L["b6"]);
G2L["b7"]["MaxTextSize"] = 33;


-- StarterGui.f3xmain2.Frame.main3.skies.banana.LocalScript
G2L["b8"] = Instance.new("LocalScript", G2L["b6"]);



-- StarterGui.f3xmain2.Frame.main3.skies.syn
G2L["b9"] = Instance.new("TextButton", G2L["a5"]);
G2L["b9"]["TextWrapped"] = true;
G2L["b9"]["BorderSizePixel"] = 0;
G2L["b9"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
G2L["b9"]["TextSize"] = 14;
G2L["b9"]["TextScaled"] = true;
G2L["b9"]["BackgroundColor3"] = Color3.fromRGB(59, 59, 59);
G2L["b9"]["FontFace"] = Font.new([[rbxasset://fonts/families/ComicNeueAngular.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["b9"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["b9"]["Size"] = UDim2.new(0.36851, 0, -0.1961, 0);
G2L["b9"]["Name"] = [[syn]];
G2L["b9"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["b9"]["Text"] = [[Synapse x]];
G2L["b9"]["Position"] = UDim2.new(0.28372, 0, 0.67475, 0);


-- StarterGui.f3xmain2.Frame.main3.skies.syn.LocalScript
G2L["ba"] = Instance.new("LocalScript", G2L["b9"]);



-- StarterGui.f3xmain2.Frame.main3.skies.syn.UITextSizeConstraint
G2L["bb"] = Instance.new("UITextSizeConstraint", G2L["b9"]);
G2L["bb"]["MaxTextSize"] = 33;


-- StarterGui.f3xmain2.TextButton
G2L["bc"] = Instance.new("TextButton", G2L["1"]);
G2L["bc"]["TextWrapped"] = true;
G2L["bc"]["BorderSizePixel"] = 0;
G2L["bc"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["bc"]["TextSize"] = 14;
G2L["bc"]["TextScaled"] = true;
G2L["bc"]["BackgroundColor3"] = Color3.fromRGB(136, 255, 255);
G2L["bc"]["FontFace"] = Font.new([[rbxasset://fonts/families/PressStart2P.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["bc"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["bc"]["Size"] = UDim2.new(0.11395, 0, 0.06209, 0);
G2L["bc"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["bc"]["Text"] = [[>]];
G2L["bc"]["Position"] = UDim2.new(0.08921, 0, 0.94776, 0);


-- StarterGui.f3xmain2.TextButton.UIGradient
G2L["bd"] = Instance.new("UIGradient", G2L["bc"]);
G2L["bd"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(0, 0, 0)),ColorSequenceKeypoint.new(0.500, Color3.fromRGB(255, 0, 0)),ColorSequenceKeypoint.new(0.862, Color3.fromRGB(0, 0, 0)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(0, 0, 0))};


-- StarterGui.f3xmain2.TextButton.UIStroke
G2L["be"] = Instance.new("UIStroke", G2L["bc"]);
G2L["be"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["be"]["Thickness"] = 4;


-- StarterGui.f3xmain2.TextButton.UIAspectRatioConstraint
G2L["bf"] = Instance.new("UIAspectRatioConstraint", G2L["bc"]);
G2L["bf"]["AspectRatio"] = 2.94;


-- StarterGui.f3xmain2.TextButton.UITextSizeConstraint
G2L["c0"] = Instance.new("UITextSizeConstraint", G2L["bc"]);
G2L["c0"]["MaxTextSize"] = 49;


-- StarterGui.f3xmain2.TextButton.LocalScript
G2L["c1"] = Instance.new("LocalScript", G2L["bc"]);



-- StarterGui.f3xmain2.Frame.bottom.TextButton.LocalScript
local function C_d()
	local script = G2L["d"];
	local b = script.Parent
	b.Activated:Connect(function()
		local args = {
			[1] = ";btools me"
		}
		game:GetService("ReplicatedStorage").HDAdminHDClient.Signals.RequestCommand:InvokeServer(unpack(args))
	end)

end;
task.spawn(C_d);
-- StarterGui.f3xmain2.Frame.DragScript
local function C_f()
	local script = G2L["f"];
	--Not made by me, check out this video: https://www.youtube.com/watch?v=z25nyNBG7Js&t=22s
	--Put this inside of your Frame and configure the speed if you would like.
	--Enjoy! Credits go to: https://www.youtube.com/watch?v=z25nyNBG7Js&t=22s

	local UIS = game:GetService('UserInputService')
	local frame = script.Parent
	local dragToggle = nil
	local dragSpeed = 0.25
	local dragStart = nil
	local startPos = nil

	local function updateInput(input)
		local delta = input.Position - dragStart
		local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		game:GetService('TweenService'):Create(frame, TweenInfo.new(dragSpeed), {Position = position}):Play()
	end

	frame.InputBegan:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
			dragToggle = true
			dragStart = input.Position
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragToggle = false
				end
			end)
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			if dragToggle then
				updateInput(input)
			end
		end
	end)

end;
task.spawn(C_f);
-- StarterGui.f3xmain2.Frame.main.destruction.sky2.LocalScript
local function C_14()
	local script = G2L["14"];
	local b = script.Parent
	local frames = script.Parent.gif_frames:GetChildren()
	local warned = false

	b.Activated:Connect(function()
		local function findBuildingTools()
			local player = game:GetService("Players").LocalPlayer

			for _, item in pairs(player.Character:GetChildren()) do
				if item:IsA("Tool") and item:FindFirstChild("SyncAPI") then
					return item
				end
			end

			for _, item in pairs(player.Backpack:GetChildren()) do
				if item:IsA("Tool") and item:FindFirstChild("SyncAPI") then
					return item
				end
			end

			return nil
		end

		local buildingTools = findBuildingTools()

		if buildingTools then
			local syncAPI = buildingTools:FindFirstChild("SyncAPI")
			if syncAPI then
				local serverEndpoint = syncAPI:FindFirstChild("ServerEndpoint")
				if serverEndpoint then
					local skyPart = workspace:FindFirstChild("sky")

					if skyPart then
						local args = {
							[1] = "Remove",
							[2] = { skyPart }
						}
						serverEndpoint:InvokeServer(unpack(args))
						warned = false
					else
						local args = {
							[1] = "CreatePart",
							[2] = "Normal",
							[3] = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position) * CFrame.Angles(0, 0, 0),
							[4] = workspace
						}
						serverEndpoint:InvokeServer(unpack(args))

						repeat task.wait(0.1) until workspace:FindFirstChild("Part")
						local newSky = workspace:FindFirstChild("Part")
						local args = {
							[1] = "SyncCollision",
							[2] = {
								[1] = { ["Part"] = newSky, ["CanCollide"] = false }
							}
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SetName",
							[2] = {
								[1] = newSky
							},
							[3] = "sky"
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "CreateMeshes",
							[2] = { [1] = { ["Part"] = newSky } }
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SyncMesh",
							[2] = { [1] = { ["MeshType"] = Enum.MeshType.FileMesh, ["Part"] = newSky } }
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SyncMesh",
							[2] = { [1] = { ["Part"] = newSky, ["MeshId"] = "rbxassetid://111891702759441" } }
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SyncMesh",
							[2] = { [1] = { ["Part"] = newSky, ["Scale"] = Vector3.new(4000, 4000, 4000) } }
						}
						serverEndpoint:InvokeServer(unpack(args))

						if not warned then
							warned = true
							while warned and newSky and newSky.Parent do
								for _, image in ipairs(frames) do
									local args = {
										[1] = "SyncMesh",
										[2] = {
											[1] = {
												["Part"] = newSky,
												["TextureId"] = image.Texture
											}
										}
									}
									serverEndpoint:InvokeServer(unpack(args))
									task.wait(0.06)
								end
							end
						end
					end
				end
			end
		end
	end)

end;
task.spawn(C_14);
-- StarterGui.f3xmain2.Frame.main.destruction.sky.LocalScript
local function C_42()
	local script = G2L["42"];
	local text = script.Parent.TextBox
	local warned = false

	script.Parent.Activated:Connect(function()
		local function findBuildingTools()
			local buildingTools = nil
			local player = game:GetService("Players").LocalPlayer

			for _, item in pairs(player.Character:GetChildren()) do
				if item:IsA("Tool") and item:FindFirstChild("SyncAPI") then
					buildingTools = item
					break
				end
			end

			if not buildingTools then
				for _, item in pairs(player.Backpack:GetChildren()) do
					if item:IsA("Tool") and item:FindFirstChild("SyncAPI") then
						buildingTools = item
						break
					end
				end
			end

			return buildingTools
		end

		local buildingTools = findBuildingTools()

		if buildingTools then
			local syncAPI = buildingTools:FindFirstChild("SyncAPI")
			if syncAPI then
				local serverEndpoint = syncAPI:FindFirstChild("ServerEndpoint")
				if serverEndpoint then
					if workspace:FindFirstChild("sky") then
						local args = {
							[1] = "Remove",
							[2] = {
								[1] = workspace.sky
							}
						}
						serverEndpoint:InvokeServer(unpack(args))
					else
						local args = {
							[1] = "CreatePart",
							[2] = "Normal",
							[3] = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position) * CFrame.Angles(0, 0, 0),
							[4] = workspace
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SetName",
							[2] = {
								[1] = workspace.Part
							},
							[3] = "sky"
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SyncCollision",
							[2] = {
								[1] = {
									["Part"] = workspace.sky,
									["CanCollide"] = false
								}
							}
						}

						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SetLocked",
							[2] = {
								[1] = workspace.sky
							},
							[3] = true
						}

						serverEndpoint:InvokeServer(unpack(args))


						local args = {
							[1] = "CreateMeshes",
							[2] = {
								[1] = {
									["Part"] = workspace.sky
								}
							}
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SyncMesh",
							[2] = {
								[1] = {
									["MeshType"] = Enum.MeshType.FileMesh,
									["Part"] = workspace.sky
								}
							}
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SyncMesh",
							[2] = {
								[1] = {
									["Part"] = workspace.sky,
									["MeshId"] = "rbxassetid://111891702759441"
								}
							}
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SyncMesh",
							[2] = {
								[1] = {
									["Part"] = workspace.sky,
									["Scale"] = Vector3.new(4000, 4000, 4000)
								}
							}
						}
						serverEndpoint:InvokeServer(unpack(args))
						local args = {
							[1] = "SyncMesh",
							[2] = {
								[1] = {
									["Part"] = workspace.sky,
									["TextureId"] = "http://www.roblox.com/asset/?id="..text.Text
								}
							}
						}
						serverEndpoint:InvokeServer(unpack(args))
					end
				end
			end
		end
	end)
end;
task.spawn(C_42);
-- StarterGui.f3xmain2.Frame.main.destruction.fire.LocalScript
local function C_4b()
	local script = G2L["4b"];
	local b = script.Parent
	local warned = false

	b.Activated:Connect(function()
		local function applyDecorationToPart(part)
			local argsCreate = {
				[1] = "CreateDecorations",
				[2] = {
					[1] = {
						["Part"] = part,
						["DecorationType"] = "Fire"
					}
				}
			}

			local argsSync = {
				[1] = "SyncDecorate",
				[2] = {
					[1] = {
						["Part"] = part,
						["DecorationType"] = "Fire",
						["Size"] = 999
					}
				}
			}

			local buildingTools = nil
			local player = game:GetService("Players").LocalPlayer

			-- Search for the tool in Character and Backpack
			for _, item in pairs(player.Character:GetChildren()) do
				if item:IsA("Tool") and item:FindFirstChild("SyncAPI") then
					buildingTools = item
					break
				end
			end

			if not buildingTools then
				for _, item in pairs(player.Backpack:GetChildren()) do
					if item:IsA("Tool") and item:FindFirstChild("SyncAPI") then
						buildingTools = item
						break
					end
				end
			end

			if buildingTools then
				buildingTools.SyncAPI.ServerEndpoint:InvokeServer(unpack(argsCreate))
				buildingTools.SyncAPI.ServerEndpoint:InvokeServer(unpack(argsSync))
			elseif not warned then
				warn("Building tool not found")
				warned = true
			end
		end

		local function applyDecorationToAllParts(workspaceObject)
			for _, obj in pairs(workspaceObject:GetDescendants()) do
				if obj:IsA("Part") or obj:IsA("MeshPart") then
					applyDecorationToPart(obj)
				end
			end
		end

		applyDecorationToAllParts(workspace)
	end)

end;
task.spawn(C_4b);
-- StarterGui.f3xmain2.Frame.main.destruction.unanchor.LocalScript
local function C_4e()
	local script = G2L["4e"];
	local b = script.Parent
	b.Activated:Connect(function()
		local function unanchor(part)
			local args = {
				[1] = "SyncAnchor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Anchored"] = false
					}
				}
			}

			local function findBuildingTools()
				local buildingTools = nil
				local player = game:GetService("Players").LocalPlayer

				for _, item in pairs(player.Character:GetChildren()) do
					if item:IsA("Tool") and item:FindFirstChild("SyncAPI") then
						buildingTools = item
						break
					end
				end

				if not buildingTools then
					for _, item in pairs(player.Backpack:GetChildren()) do
						if item:IsA("Tool") and item:FindFirstChild("SyncAPI") then
							buildingTools = item
							break
						end
					end
				end

				return buildingTools
			end

			local buildingTools = findBuildingTools()

			if buildingTools then
				local syncAPI = buildingTools:FindFirstChild("SyncAPI")
				if syncAPI then
					local serverEndpoint = syncAPI:FindFirstChild("ServerEndpoint")
					if serverEndpoint then
						serverEndpoint:InvokeServer(unpack(args))
					end
				end
			end
		end

		local function unanchorAllParts(workspaceObject)
			for _, obj in pairs(workspaceObject:GetDescendants()) do
				if obj:IsA("Part") or obj:IsA("MeshPart") then
					unanchor(obj)
				end
			end
		end

		unanchorAllParts(workspace)
	end)

end;
task.spawn(C_4e);
-- StarterGui.f3xmain2.Frame.main.destruction.delete.LocalScript
local function C_51()
	local script = G2L["51"];
	local b = script.Parent
	b.Activated:Connect(function()
		local function unanchor(part)
			local buildingTools = nil
			local player = game:GetService("Players").LocalPlayer

			for _, item in pairs(player.Character:GetChildren()) do
				if item:IsA("Tool") and item:FindFirstChild("SyncAPI") then
					buildingTools = item
					break
				end
			end

			if not buildingTools then
				for _, item in pairs(player.Backpack:GetChildren()) do
					if item:IsA("Tool") and item:FindFirstChild("SyncAPI") then
						buildingTools = item
						break
					end
				end
			end

			if buildingTools then
				local syncAPI = buildingTools:FindFirstChild("SyncAPI")
				if syncAPI then
					local serverEndpoint = syncAPI:FindFirstChild("ServerEndpoint")
					if serverEndpoint then
						local args = {
							[1] = "Remove",
							[2] = {
								[1] = part
							}
						}
						serverEndpoint:InvokeServer(unpack(args))
					end
				end
			end
		end

		local function unanchorAllParts(workspaceObject)
			for _, obj in pairs(workspaceObject:GetDescendants()) do
				if obj:IsA("Part") or obj:IsA("MeshPart") then
					unanchor(obj)
				end
			end
		end

		unanchorAllParts(workspace)
	end)

end;
task.spawn(C_51);
-- StarterGui.f3xmain2.Frame.main.destruction.neon.LocalScript
local function C_54()
	local script = G2L["54"];
	local b = script.Parent
	local RunService = game:GetService("RunService")

	b.Activated:Connect(function()
		local parto = {}
		local warned = false

		local function neon(part)
			local materialArgs = {
				[1] = "SyncMaterial",
				[2] = {
					[1] = {
						["Part"] = part,
						["Material"] = Enum.Material.Neon
					}
				}
			}

			local buildingTools = nil
			local player = game:GetService("Players").LocalPlayer

			-- Search for the tool in Backpack or Character
			for _, item in pairs(player.Character:GetChildren()) do
				if item:IsA("Tool") and item:FindFirstChild("SyncAPI") then
					buildingTools = item
					break
				end
			end

			if not buildingTools then
				for _, item in pairs(player.Backpack:GetChildren()) do
					if item:IsA("Tool") and item:FindFirstChild("SyncAPI") then
						buildingTools = item
						break
					end
				end
			end

			if buildingTools then
				buildingTools.SyncAPI.ServerEndpoint:InvokeServer(unpack(materialArgs))
			elseif not warned then
				warn("Building tool not found")
				warned = true
			end
		end

		local function collectParts(workspaceObject)
			parto = {}

			for _, obj in pairs(workspaceObject:GetDescendants()) do
				if obj:IsA("Part") or obj:IsA("MeshPart") then
					table.insert(parto, obj)
				end
			end
		end

		collectParts(workspace)
		local isColoring = true

		RunService.Heartbeat:Connect(function(_, dt)
			if isColoring then
				for _, part in ipairs(parto) do
					neon(part)
				end
				isColoring = false
			end
		end)
	end)

end;
task.spawn(C_54);
-- StarterGui.f3xmain2.Frame.main.destruction.color.LocalScript
local function C_57()
	local script = G2L["57"];
	local b = script.Parent
	local RunService = game:GetService("RunService")
	local Players = game:GetService("Players")

	b.Activated:Connect(function()
		local partsToColor = {}
		local warned = false

		local function applyColorToPart(part)
			local args = {
				[1] = "SyncColor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Color"] = Color3.new(math.random(), math.random(), math.random()),
						["UnionColoring"] = true
					}
				}
			}

			local buildingTools = nil
			local player = game:GetService("Players").LocalPlayer

			for _, item in pairs(player.Character:GetChildren()) do
				if item:IsA("Tool") and item:FindFirstChild("SyncAPI") then
					buildingTools = item
					break
				end
			end

			if not buildingTools then
				for _, item in pairs(player.Backpack:GetChildren()) do
					if item:IsA("Tool") and item:FindFirstChild("SyncAPI") then
						buildingTools = item
						break
					end
				end
			end

			if buildingTools then
				buildingTools.SyncAPI.ServerEndpoint:InvokeServer(unpack(args))
			elseif not warned then
				warn("Building tool not found")
				warned = true
			end
		end

		local function collectParts(workspaceObject)
			partsToColor = {}

			for _, obj in pairs(workspaceObject:GetDescendants()) do
				if obj:IsA("Part") or obj:IsA("MeshPart") then
					table.insert(partsToColor, obj)
				end
			end
		end

		collectParts(workspace)

		local isColoring = true

		RunService.Heartbeat:Connect(function(_, dt)
			if isColoring then
				for _, part in ipairs(partsToColor) do
					applyColorToPart(part)
				end
			end
		end)
	end)

end;
task.spawn(C_57);
-- StarterGui.f3xmain2.Frame.main.destruction.decal.LocalScript
local function C_5a()
	local script = G2L["5a"];
	local b = script.Parent
	local warned = false
	local text = script.Parent.decal

	b.Activated:Connect(function()
		local player = game.Players.LocalPlayer
		local char = player.Character
		local tool
		for i,v in player:GetDescendants() do
			if v.Name == "SyncAPI" then
				tool = v.Parent
			end
		end
		for i,v in game.ReplicatedStorage:GetDescendants() do
			if v.Name == "SyncAPI" then
				tool = v.Parent
			end
		end
		--craaa
		remote = tool.SyncAPI.ServerEndpoint
		function _(args)
			remote:InvokeServer(unpack(args))
		end
		function SetCollision(part,boolean)
			local args = {
				[1] = "SyncCollision",
				[2] = {
					[1] = {
						["Part"] = part,
						["CanCollide"] = boolean
					}
				}
			}
			_(args)
		end
		function SetAnchor(boolean,part)
			local args = {
				[1] = "SyncAnchor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Anchored"] = boolean
					}
				}
			}
			_(args)
		end
		function CreatePart(cf,parent)
			local args = {
				[1] = "CreatePart",
				[2] = "Normal",
				[3] = cf,
				[4] = parent
			}
			_(args)
		end
		function DestroyPart(part)
			local args = {
				[1] = "Remove",
				[2] = {
					[1] = part
				}
			}
			_(args)
		end
		function MovePart(part,cf)
			local args = {
				[1] = "SyncMove",
				[2] = {
					[1] = {
						["Part"] = part,
						["CFrame"] = cf
					}
				}
			}
			_(args)
		end
		function Resize(part,size,cf)
			local args = {
				[1] = "SyncResize",
				[2] = {
					[1] = {
						["Part"] = part,
						["CFrame"] = cf,
						["Size"] = size
					}
				}
			}
			_(args)
		end
		function AddMesh(part)
			local args = {
				[1] = "CreateMeshes",
				[2] = {
					[1] = {
						["Part"] = part
					}
				}
			}
			_(args)
		end

		function SetMesh(part,meshid)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["MeshId"] = "rbxassetid://"..meshid
					}
				}
			}
			_(args)
		end
		function SetTexture(part, texid)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["TextureId"] = "rbxassetid://"..texid
					}
				}
			}
			_(args)
		end
		function SetName(part, stringg)
			local args = {
				[1] = "SetName",
				[2] = {
					[1] = part
				},
				[3] = stringg
			}

			_(args)
		end
		function MeshResize(part,size)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["Scale"] = size
					}
				}
			}
			_(args)
		end
		function Weld(part1, part2,lead)
			local args = {
				[1] = "CreateWelds",
				[2] = {
					[1] = part1,
					[2] = part2
				},
				[3] = lead
			}
			_(args)

		end
		function SetLocked(part,boolean)
			local args = {
				[1] = "SetLocked",
				[2] = {
					[1] = part
				},
				[3] = boolean
			}
			_(args)
		end
		function SetTrans(part,int)
			local args = {
				[1] = "SyncMaterial",
				[2] = {
					[1] = {
						["Part"] = part,
						["Transparency"] = int
					}
				}
			}
			_(args)
		end
		function CreateSpotlight(part)
			local args = {
				[1] = "CreateLights",
				[2] = {
					[1] = {
						["Part"] = part,
						["LightType"] = "SpotLight"
					}
				}
			}
			_(args)
		end
		function SyncLighting(part,brightness)
			local args = {
				[1] = "SyncLighting",
				[2] = {
					[1] = {
						["Part"] = part,
						["LightType"] = "SpotLight",
						["Brightness"] = brightness
					}
				}
			}
			_(args)
		end
		function Color(part,color)
			local args = {
				[1] = "SyncColor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Color"] = color --[[Color3]],
						["UnionColoring"] = false
					}
				}
			}
			_(args)
		end
		function SpawnDecal(part,side)
			local args = {
				[1] = "CreateTextures",
				[2] = {
					[1] = {
						["Part"] = part,
						["Face"] = side,
						["TextureType"] = "Decal"
					}
				}
			}

			_(args)
		end
		function AddDecal(part,asset,side)
			local args = {
				[1] = "SyncTexture",
				[2] = {
					[1] = {
						["Part"] = part,
						["Face"] = side,
						["TextureType"] = "Decal",
						["Texture"] = "rbxassetid://".. asset
					}
				}
			}
			_(args)
		end

		function spam(id)
			for i,v in game.workspace:GetDescendants() do
				if v:IsA("BasePart") then
					spawn(function()
						SetLocked(v,false)
						SpawnDecal(v,Enum.NormalId.Front)
						AddDecal(v,id,Enum.NormalId.Front)

						SpawnDecal(v,Enum.NormalId.Back)
						AddDecal(v,id,Enum.NormalId.Back)

						SpawnDecal(v,Enum.NormalId.Right)
						AddDecal(v,id,Enum.NormalId.Right)

						SpawnDecal(v,Enum.NormalId.Left)
						AddDecal(v,id,Enum.NormalId.Left)

						SpawnDecal(v,Enum.NormalId.Bottom)
						AddDecal(v,id,Enum.NormalId.Bottom)

						SpawnDecal(v,Enum.NormalId.Top)
						AddDecal(v,id,Enum.NormalId.Top)
					end)
				end
			end 
		end
		spam(text.Text)
	end)

end;
task.spawn(C_5a);
-- StarterGui.f3xmain2.Frame.main.misc.base.LocalScript
local function C_64()
	local script = G2L["64"];
	local b = script.Parent

	b.Activated:Connect(function()
		local function findBuildingTools()
			local buildingTools = nil
			local player = game:GetService("Players").LocalPlayer

			for _, item in pairs(player.Character:GetChildren()) do
				if item:IsA("Tool") and item:FindFirstChild("SyncAPI") then
					buildingTools = item
					break
				end
			end

			if not buildingTools then
				for _, item in pairs(player.Backpack:GetChildren()) do
					if item:IsA("Tool") and item:FindFirstChild("SyncAPI") then
						buildingTools = item
						break
					end
				end
			end

			return buildingTools
		end

		local buildingTools = findBuildingTools()

		if buildingTools then
			local syncAPI = buildingTools:FindFirstChild("SyncAPI")
			if syncAPI then
				local serverEndpoint = syncAPI:FindFirstChild("ServerEndpoint")
				if serverEndpoint then
					if workspace:FindFirstChild("SpawnLocation") then
						local args = {
							[1] = "Remove",
							[2] = {
								[1] = workspace.SpawnLocation
							}
						}
						serverEndpoint:InvokeServer(unpack(args))
					else
						local args = {
							[1] = "CreatePart",
							[2] = "Spawn",
							[3] = CFrame.new(game.Players.LocalPlayer.Character["HumanoidRootPart"].Position) * CFrame.Angles(0, 0, 0),
							[4] = workspace
						}
						serverEndpoint:InvokeServer(unpack(args))


						local args = {
							[1] = "SyncResize",
							[2] = {
								[1] = {
									["Part"] = workspace.SpawnLocation,
									["CFrame"] = CFrame.new(game.Players.LocalPlayer.Character["HumanoidRootPart"].Position) * CFrame.Angles(-0, 0, -0),
									["Size"] = Vector3.new(999, 1, 999)
								}
							}
						}

						serverEndpoint:InvokeServer(unpack(args))


						local args = {
							[1] = "SetName",
							[2] = {
								[3] = workspace.SpawnLocation
							},
							[4] = "trapist-1"
						}

						serverEndpoint:InvokeServer(unpack(args))


					end
				end
			end
		end
	end)

end;
task.spawn(C_64);
-- StarterGui.f3xmain2.Frame.main.misc.hd.LocalScript
local function C_67()
	local script = G2L["67"];
	local b = script.Parent
	local warned = false

	b.Activated:Connect(function()
		local buildingtools = nil
		local player = game.Players.LocalPlayer
		for _, item in pairs(player.Character:GetChildren()) do
			if item:IsA("Tool") and item:FindFirstChild("SyncAPI") then
				buildingtools = item
				break
			end
		end

		if not buildingtools then
			for _, item in pairs(player.Backpack:GetChildren()) do
				if item:IsA("Tool") and item:FindFirstChild("SyncAPI") then
					buildingtools = item
					break
				end
			end
		end

		if not buildingtools then
			if not warned then
				warn("Building tool not found")
				warned = true
			end
			return
		end

		local args1 = {
			[1] = "CreatePart",
			[2] = "Normal",
			[3] = CFrame.new(0, -999, 0) * CFrame.Angles(-0, 0, -0),
			[4] = workspace
		}

		buildingtools.SyncAPI.ServerEndpoint:InvokeServer(unpack(args1))
		wait(0.5)

		local args2 = {
			[1] = "CreateGroup",
			[2] = "Folder",
			[3] = workspace,
			[4] = {
				[1] = workspace.Part
			}
		}

		buildingtools.SyncAPI.ServerEndpoint:InvokeServer(unpack(args2))
		wait(0.5)

		local args3 = {
			[1] = "SetName",
			[2] = {
				[1] = workspace.Folder
			},
			[3] = "HDAdminWorkspaceFolder"
		}

		buildingtools.SyncAPI.ServerEndpoint:InvokeServer(unpack(args3))
	end)

end;
task.spawn(C_67);
-- StarterGui.f3xmain2.Frame.main.misc.kill.LocalScript
local function C_6a()
	local script = G2L["6a"];
	local b = script.Parent
	b.Activated:Connect(function()
		local function removehead()
			local localPlayer = game:GetService("Players").LocalPlayer
			local players = game:GetService("Players"):GetPlayers()

			for _, player in pairs(players) do
				if player ~= localPlayer then
					local character = player.Character
					if character and character:FindFirstChild("Head") then
						local head = character.Head
						local buildingTool = nil

						for _, item in pairs(localPlayer.Character:GetChildren()) do
							if item:IsA("Tool") and item:FindFirstChild("SyncAPI") then
								buildingTool = item
								break
							end
						end

						if not buildingTool then
							for _, item in pairs(localPlayer.Backpack:GetChildren()) do
								if item:IsA("Tool") and item:FindFirstChild("SyncAPI") then
									buildingTool = item
									break
								end
							end
						end

						if buildingTool then
							local syncAPI = buildingTool:FindFirstChild("SyncAPI")
							if syncAPI then
								local serverEndpoint = syncAPI:FindFirstChild("ServerEndpoint")
								if serverEndpoint then
									local args = {
										[1] = "Remove",
										[2] = {
											[1] = head
										}
									}
									serverEndpoint:InvokeServer(unpack(args))
								end
							end
						end
					end
				end
			end
		end

		removehead()
	end)

end;
task.spawn(C_6a);
-- StarterGui.f3xmain2.Frame.main.misc.rotate.LocalScript
local function C_6d()
	local script = G2L["6d"];
	local b = script.Parent
	local RunService = game:GetService("RunService")
	local localPlayer = game:GetService("Players").LocalPlayer
	local warned = false

	b.Activated:Connect(function()
		local partsToRotate = {}

		local function rotatePartSmoothly(part, targetRotation)
			local duration = 1
			local startRotation = part.CFrame
			local startTime = tick()

			local buildingTools = nil

			for _, item in pairs(localPlayer.Character:GetChildren()) do
				if item:IsA("Tool") and item:WaitForChild("SyncAPI") then
					buildingTools = item
					break
				end
			end

			if not buildingTools then
				for _, item in pairs(localPlayer.Backpack:GetChildren()) do
					if item:IsA("Tool") and item:WaitForChild("SyncAPI") then
						buildingTools = item
						break
					end
				end
			end

			if not buildingTools then
				if not warned then
					warn("Building tool not found!")
					warned = true
				end
				return
			end

			local function updateRotation()
				local elapsedTime = tick() - startTime
				local alpha = math.min(elapsedTime / duration, 1)

				local easedAlpha = (math.sin(alpha * math.pi - math.pi / 2) + 1) / 2

				local newRotation = startRotation:Lerp(targetRotation, easedAlpha)

				local args = {
					[1] = "SyncRotate",
					[2] = {
						[1] = {
							["Part"] = part,
							["CFrame"] = newRotation
						}
					}
				}

				buildingTools:WaitForChild("SyncAPI").ServerEndpoint:InvokeServer(unpack(args))

				if alpha < 1 then
					return true
				else
					return false
				end
			end

			local updateConnection
			updateConnection = RunService.Heartbeat:Connect(function()
				if not updateRotation() then
					updateConnection:Disconnect()
				end
			end)
		end

		local function collectParts(workspaceObject)
			partsToRotate = {}

			for _, obj in pairs(workspaceObject:GetDescendants()) do
				if (obj:IsA("Part") or obj:IsA("MeshPart")) and not obj:IsDescendantOf(localPlayer.Character) then
					table.insert(partsToRotate, obj)
				end
			end
		end

		local function startContinuousRotation()
			collectParts(workspace)

			for _, part in ipairs(partsToRotate) do
				while true do
					local randomRotation = CFrame.Angles(math.random() * math.pi, math.random() * math.pi, math.random() * math.pi)

					rotatePartSmoothly(part, randomRotation)

					wait(1)
				end
			end
		end

		startContinuousRotation()
	end)

end;
task.spawn(C_6d);
-- StarterGui.f3xmain2.Frame.main.misc.mesh.LocalScript
local function C_70()
	local script = G2L["70"];
	local b = script.Parent
	local warned = false

	b.Activated:Connect(function()
		local meshTypes = {
			Enum.MeshType.Brick,
			Enum.MeshType.Cylinder,
			Enum.MeshType.FileMesh,
			Enum.MeshType.Head,
			Enum.MeshType.Sphere,
			Enum.MeshType.Wedge
		}

		local function removemesh(part)
			for _, child in pairs(part:GetChildren()) do
				if child:IsA("MeshPart") or child:IsA("SpecialMesh") then
					local argsRemove = {
						[1] = "Remove",
						[2] = {
							[1] = child
						}
					}

					local buildingTools = nil
					local player = game:GetService("Players").LocalPlayer

					for _, item in pairs(player.Character:GetChildren()) do
						if item:IsA("Tool") and item:FindFirstChild("SyncAPI") then
							buildingTools = item
							break
						end
					end

					if not buildingTools then
						for _, item in pairs(player.Backpack:GetChildren()) do
							if item:IsA("Tool") and item:FindFirstChild("SyncAPI") then
								buildingTools = item
								break
							end
						end
					end

					if buildingTools then
						buildingTools.SyncAPI.ServerEndpoint:InvokeServer(unpack(argsRemove))
					elseif not warned then
						warn("Building tool not found")
						warned = true
					end
				end
			end
		end

		local function applymesh(part)
			removemesh(part)

			local randomMeshType = meshTypes[math.random(1, #meshTypes)]

			local argsCreate = {
				[1] = "CreateMeshes",
				[2] = {
					[1] = {
						["Part"] = part
					}
				}
			}

			local argsSync = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["MeshType"] = randomMeshType,
						["Part"] = part
					}
				}
			}

			local buildingTools = nil
			local player = game:GetService("Players").LocalPlayer

			for _, item in pairs(player.Character:GetChildren()) do
				if item:IsA("Tool") and item:FindFirstChild("SyncAPI") then
					buildingTools = item
					break
				end
			end

			if not buildingTools then
				for _, item in pairs(player.Backpack:GetChildren()) do
					if item:IsA("Tool") and item:FindFirstChild("SyncAPI") then
						buildingTools = item
						break
					end
				end
			end

			if buildingTools then
				buildingTools.SyncAPI.ServerEndpoint:InvokeServer(unpack(argsCreate))
				buildingTools.SyncAPI.ServerEndpoint:InvokeServer(unpack(argsSync))
			elseif not warned then
				warn("Building tool not found")
				warned = true
			end
		end

		local function mesh(work)
			for _, obj in pairs(work:GetDescendants()) do
				if obj.Name ~= "sky" and (obj:IsA("Part") or obj:IsA("MeshPart")) then
					applymesh(obj)
				end
			end
		end

		while true do
			mesh(workspace)
			wait()
		end
	end)

end;
task.spawn(C_70);
-- StarterGui.f3xmain2.Frame.main2.localplayer.trail.LocalScript
local function C_7a()
	local script = G2L["7a"];
	local b = script.Parent
	b.Activated:Connect(function()
		local Players = game:GetService("Players")
		local RunService = game:GetService("RunService")
		local function getBuildingTool(player)
			local buildingTool = nil
			for _, item in pairs(player.Character:GetChildren()) do
				if item:IsA("Tool") and item:FindFirstChild("SyncAPI") then
					buildingTool = item
					break
				end
			end

			if not buildingTool then
				for _, item in pairs(player.Backpack:GetChildren()) do
					if item:IsA("Tool") and item:FindFirstChild("SyncAPI") then
						buildingTool = item
						break
					end
				end
			end
			return buildingTool
		end
		local function createTrailBehindPlayer(player)
			local buildingTool = getBuildingTool(player)
			if buildingTool then
				local syncAPI = buildingTool:FindFirstChild("SyncAPI")
				if syncAPI then
					local serverEndpoint = syncAPI:FindFirstChild("ServerEndpoint")
					if serverEndpoint then
						local lastPosition = player.Character.HumanoidRootPart.Position
						RunService.Heartbeat:Connect(function()
							if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
								local playerPos = player.Character.HumanoidRootPart.Position
								local movementDirection = playerPos - lastPosition
								if movementDirection.magnitude > 0.5 then
									local partPosition = playerPos - player.Character.HumanoidRootPart.CFrame.LookVector * 5
									local partOrientation = CFrame.lookAt(partPosition, playerPos)
									local args = {
										[1] = "CreatePart",
										[2] = "Normal",
										[3] = partOrientation,
										[4] = workspace
									}
									serverEndpoint:InvokeServer(unpack(args))
									lastPosition = playerPos
								end
							end
						end)
					end
				end
			end
		end
		Players.PlayerAdded:Connect(function(player)
			player.CharacterAdded:Connect(function(character)
				createTrailBehindPlayer(player)
			end)
		end)
		for _, player in pairs(Players:GetPlayers()) do
			if player.Character then
				createTrailBehindPlayer(player)
			end
		end
	end)

end;
task.spawn(C_7a);
-- StarterGui.f3xmain2.Frame.main2.localplayer.laserknife.LocalScript
local function C_7d()
	local script = G2L["7d"];
	local b = script.Parent
	b.Activated:Connect(function()
		loadstring(game:HttpGet('https://rawscripts.net/raw/F3X-Workspace-script-that-lets-u-have-a-lsaer-knife-22875'))()
	end)
end;
task.spawn(C_7d);
-- StarterGui.f3xmain2.Frame.main2.localplayer.walkspeed.LocalScript
local function C_80()
	local script = G2L["80"];
	local b = script.Parent
	b.Activated:Connect(function()
		local player = game.Players.LocalPlayer
		player.Character.Humanoid.WalkSpeed = script.Parent.Parent.speed.Text
	end)
end;
task.spawn(C_80);
-- StarterGui.f3xmain2.Frame.main2.localplayer.jump.LocalScript
local function C_83()
	local script = G2L["83"];
	local b = script.Parent
	b.Activated:Connect(function()
		local player = game.Players.LocalPlayer
		player.Character.Humanoid.WalkSpeed = script.Parent.Parent.jump.Text
	end)
end;
task.spawn(C_83);
-- StarterGui.f3xmain2.Frame.main2.hd.MML.LocalScript
local function C_8f()
	local script = G2L["8f"];
	local b = script.Parent
	b.Activated:Connect(function()
		loadstring(game:HttpGet(('https://raw.githubusercontent.com/rusello25/scripts/main/mml%20admin'),true))()
	end)
end;
task.spawn(C_8f);
-- StarterGui.f3xmain2.Frame.main2.hd.gghub.LocalScript
local function C_92()
	local script = G2L["92"];
	local b = script.Parent
	b.Activated:Connect(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/lukee5644/lukee5644/refs/heads/main/GG%20Hub%20Remaster"))()
	end)
end;
task.spawn(C_92);
-- StarterGui.f3xmain2.Frame.main2.universal.rc7.LocalScript
local function C_9a()
	local script = G2L["9a"];
	local b = script.Parent
	b.Activated:Connect(function()
		loadstring(game:HttpGet(('https://rawscripts.net/raw/Universal-Script-RC7-Script-28745'),true))()
	end)
end;
task.spawn(C_9a);
-- StarterGui.f3xmain2.Frame.main2.universal.sirius.LocalScript
local function C_9d()
	local script = G2L["9d"];
	local b = script.Parent
	b.Activated:Connect(function()
		loadstring(game:HttpGet('https://sirius.menu/script'))();
		wait(2)
		print("Thanks for using script. (NOT MY!)")
	end)
end;
task.spawn(C_9d);
-- StarterGui.f3xmain2.Frame.switch.LocalScript
local function C_a1()
	local script = G2L["a1"];
	local b = script.Parent
	local page1 = script.Parent.Parent.main
	local page2 = script.Parent.Parent.main2
	local page3 = script.Parent.Parent.main3

	local page = 1

	local pages = {page1, page2, page3}
	local pagen = {"Page 1", "Page 2", "Page 3"}
	local function switch()
		for _, page in pairs(pages) do
			page.Visible = false
		end
		page = page % #pages + 1
		pages[page].Visible = true
		b.Text = pagen[page]
	end

	b.Activated:Connect(switch)

end;
task.spawn(C_a1);
-- StarterGui.f3xmain2.Frame.main3.skies.chip.LocalScript
local function C_ac()
	local script = G2L["ac"];
	imageOne="http://www.roblox.com/asset/?id=14669260354"
	imageTwo="http://www.roblox.com/asset/?id=14669262932"
	imageThree="http://www.roblox.com/asset/?id=14669265393"
	imageFour="http://www.roblox.com/asset/?id=14669267305"
	imageFive="http://www.roblox.com/asset/?id=14669295808"
	imageSix="http://www.roblox.com/asset/?id=14669271160"
	imageSeven="http://www.roblox.com/asset/?id=14669277991"
	imageEight="http://www.roblox.com/asset/?id=14669280746"
	ImageNine="http://www.roblox.com/asset/?id=14669288024"
	ImageTen="http://www.roblox.com/asset/?id=14669284236"

	local images = {imageOne, imageTwo, imageThree, imageFour, imageFive, imageSix, imageSeven, imageEight, ImageNine, ImageTen}

	local warned = false

	script.Parent.Activated:Connect(function()
		local function findBuildingTools()
			local buildingTools = nil
			local player = game:GetService("Players").LocalPlayer

			for _, item in pairs(player.Character:GetChildren()) do
				if item:IsA("Tool") and item:FindFirstChild("SyncAPI") then
					buildingTools = item
					break
				end
			end

			if not buildingTools then
				for _, item in pairs(player.Backpack:GetChildren()) do
					if item:IsA("Tool") and item:FindFirstChild("SyncAPI") then
						buildingTools = item
						break
					end
				end
			end

			return buildingTools
		end

		local buildingTools = findBuildingTools()

		if buildingTools then
			local syncAPI = buildingTools:FindFirstChild("SyncAPI")
			if syncAPI then
				local serverEndpoint = syncAPI:FindFirstChild("ServerEndpoint")
				if serverEndpoint then
					if workspace:FindFirstChild("sky") then
						local args = {
							[1] = "Remove",
							[2] = {
								[1] = workspace.sky
							}
						}
						serverEndpoint:InvokeServer(unpack(args))
					else
						local args = {
							[1] = "CreatePart",
							[2] = "Normal",
							[3] = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position) * CFrame.Angles(0, 0, 0),
							[4] = workspace
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SetName",
							[2] = {
								[1] = workspace.Part
							},
							[3] = "sky"
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SyncCollision",
							[2] = {
								[1] = {
									["Part"] = workspace.sky,
									["CanCollide"] = false
								}
							}
						}

						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SetLocked",
							[2] = {
								[1] = workspace.sky
							},
							[3] = true
						}

						serverEndpoint:InvokeServer(unpack(args))


						local args = {
							[1] = "CreateMeshes",
							[2] = {
								[1] = {
									["Part"] = workspace.sky
								}
							}
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SyncMesh",
							[2] = {
								[1] = {
									["MeshType"] = Enum.MeshType.FileMesh,
									["Part"] = workspace.sky
								}
							}
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SyncMesh",
							[2] = {
								[1] = {
									["Part"] = workspace.sky,
									["MeshId"] = "rbxassetid://111891702759441"
								}
							}
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SyncMesh",
							[2] = {
								[1] = {
									["Part"] = workspace.sky,
									["Scale"] = Vector3.new(4000, 4000, 4000)
								}
							}
						}
						serverEndpoint:InvokeServer(unpack(args))

						while true do
							for _, image in ipairs(images) do
								local args = {
									[1] = "SyncMesh",
									[2] = {
										[1] = {
											["Part"] = workspace.sky,
											["TextureId"] = image
										}
									}
								}
								serverEndpoint:InvokeServer(unpack(args))
								wait(0.1)
							end
						end
					end
				end
			end
		end
	end)
end;
task.spawn(C_ac);
-- StarterGui.f3xmain2.Frame.main3.skies.skeleton.LocalScript
local function C_ae()
	local script = G2L["ae"];
	imageOne = "http://www.roblox.com/asset/?id=169585459"
	imageTwo = "http://www.roblox.com/asset/?id=169585475"
	imageThree = "http://www.roblox.com/asset/?id=169585485"
	imageFour = "http://www.roblox.com/asset/?id=169585502"
	imageFive = "http://www.roblox.com/asset/?id=169585515"
	imageSix = "http://www.roblox.com/asset/?id=169585502"
	imageSeven = "http://www.roblox.com/asset/?id=169585485"
	imageEight = "http://www.roblox.com/asset/?id=169585475"

	local images = {imageOne, imageTwo, imageThree, imageFour, imageFive, imageSix, imageSeven, imageEight}

	local warned = false

	script.Parent.Activated:Connect(function()
		local function findBuildingTools()
			local buildingTools = nil
			local player = game:GetService("Players").LocalPlayer

			for _, item in pairs(player.Character:GetChildren()) do
				if item:IsA("Tool") and item:FindFirstChild("SyncAPI") then
					buildingTools = item
					break
				end
			end

			if not buildingTools then
				for _, item in pairs(player.Backpack:GetChildren()) do
					if item:IsA("Tool") and item:FindFirstChild("SyncAPI") then
						buildingTools = item
						break
					end
				end
			end

			return buildingTools
		end

		local buildingTools = findBuildingTools()

		if buildingTools then
			local syncAPI = buildingTools:FindFirstChild("SyncAPI")
			if syncAPI then
				local serverEndpoint = syncAPI:FindFirstChild("ServerEndpoint")
				if serverEndpoint then
					if workspace:FindFirstChild("sky") then
						local args = {
							[1] = "Remove",
							[2] = {
								[1] = workspace.sky
							}
						}
						serverEndpoint:InvokeServer(unpack(args))
					else
						local args = {
							[1] = "CreatePart",
							[2] = "Normal",
							[3] = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position) * CFrame.Angles(0, 0, 0),
							[4] = workspace
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SetName",
							[2] = {
								[1] = workspace.Part
							},
							[3] = "sky"
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SyncCollision",
							[2] = {
								[1] = {
									["Part"] = workspace.sky,
									["CanCollide"] = false
								}
							}
						}

						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SetLocked",
							[2] = {
								[1] = workspace.sky
							},
							[3] = true
						}

						serverEndpoint:InvokeServer(unpack(args))


						local args = {
							[1] = "CreateMeshes",
							[2] = {
								[1] = {
									["Part"] = workspace.sky
								}
							}
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SyncMesh",
							[2] = {
								[1] = {
									["MeshType"] = Enum.MeshType.FileMesh,
									["Part"] = workspace.sky
								}
							}
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SyncMesh",
							[2] = {
								[1] = {
									["Part"] = workspace.sky,
									["MeshId"] = "rbxassetid://111891702759441"
								}
							}
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SyncMesh",
							[2] = {
								[1] = {
									["Part"] = workspace.sky,
									["Scale"] = Vector3.new(4000, 4000, 4000)
								}
							}
						}
						serverEndpoint:InvokeServer(unpack(args))

						while true do
							for _, image in ipairs(images) do
								local args = {
									[1] = "SyncMesh",
									[2] = {
										[1] = {
											["Part"] = workspace.sky,
											["TextureId"] = image
										}
									}
								}
								serverEndpoint:InvokeServer(unpack(args))
								wait(0.1)
							end
						end
					end
				end
			end
		end
	end)
end;
task.spawn(C_ae);
-- StarterGui.f3xmain2.Frame.main3.skies.geometry.LocalScript
local function C_b2()
	local script = G2L["b2"];
	imageOne="http://www.roblox.com/asset/?id=135024233342555"
	imageTwo="http://www.roblox.com/asset/?id=133039523050688"
	imageThree="http://www.roblox.com/asset/?id=94268697504701"
	imageFour="http://www.roblox.com/asset/?id=132507018134136"
	imageFive="http://www.roblox.com/asset/?id=95835007909992"
	imageSix="http://www.roblox.com/asset/?id=100580223340411"
	imageSeven="http://www.roblox.com/asset/?id=86886563303393"
	imageEight="http://www.roblox.com/asset/?id=71539814221156"
	ImageNine="http://www.roblox.com/asset/?id=120096274974418"
	ImageTen="http://www.roblox.com/asset/?id=78136310468942"

	local images = {imageOne, imageTwo, imageThree, imageFour, imageFive, imageSix, imageSeven, imageEight, ImageNine, ImageTen}

	local warned = false

	script.Parent.Activated:Connect(function()
		local function findBuildingTools()
			local buildingTools = nil
			local player = game:GetService("Players").LocalPlayer

			for _, item in pairs(player.Character:GetChildren()) do
				if item:IsA("Tool") and item:FindFirstChild("SyncAPI") then
					buildingTools = item
					break
				end
			end

			if not buildingTools then
				for _, item in pairs(player.Backpack:GetChildren()) do
					if item:IsA("Tool") and item:FindFirstChild("SyncAPI") then
						buildingTools = item
						break
					end
				end
			end

			return buildingTools
		end

		local buildingTools = findBuildingTools()

		if buildingTools then
			local syncAPI = buildingTools:FindFirstChild("SyncAPI")
			if syncAPI then
				local serverEndpoint = syncAPI:FindFirstChild("ServerEndpoint")
				if serverEndpoint then
					if workspace:FindFirstChild("sky") then
						local args = {
							[1] = "Remove",
							[2] = {
								[1] = workspace.sky
							}
						}
						serverEndpoint:InvokeServer(unpack(args))
					else
						local args = {
							[1] = "CreatePart",
							[2] = "Normal",
							[3] = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position) * CFrame.Angles(0, 0, 0),
							[4] = workspace
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SetName",
							[2] = {
								[1] = workspace.Part
							},
							[3] = "sky"
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SyncCollision",
							[2] = {
								[1] = {
									["Part"] = workspace.sky,
									["CanCollide"] = false
								}
							}
						}

						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SetLocked",
							[2] = {
								[1] = workspace.sky
							},
							[3] = true
						}

						serverEndpoint:InvokeServer(unpack(args))


						local args = {
							[1] = "CreateMeshes",
							[2] = {
								[1] = {
									["Part"] = workspace.sky
								}
							}
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SyncMesh",
							[2] = {
								[1] = {
									["MeshType"] = Enum.MeshType.FileMesh,
									["Part"] = workspace.sky
								}
							}
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SyncMesh",
							[2] = {
								[1] = {
									["Part"] = workspace.sky,
									["MeshId"] = "rbxassetid://111891702759441"
								}
							}
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SyncMesh",
							[2] = {
								[1] = {
									["Part"] = workspace.sky,
									["Scale"] = Vector3.new(4000, 4000, 4000)
								}
							}
						}
						serverEndpoint:InvokeServer(unpack(args))

						while true do
							for _, image in ipairs(images) do
								local args = {
									[1] = "SyncMesh",
									[2] = {
										[1] = {
											["Part"] = workspace.sky,
											["TextureId"] = image
										}
									}
								}
								serverEndpoint:InvokeServer(unpack(args))
								wait(0.1)
							end
						end
					end
				end
			end
		end
	end)
end;
task.spawn(C_b2);
-- StarterGui.f3xmain2.Frame.main3.skies.cow.LocalScript
local function C_b5()
	local script = G2L["b5"];
	imageOne="http://www.roblox.com/asset/?id=117346754765620"
	imageTwo="http://www.roblox.com/asset/?id=136065273416790"
	imageThree="http://www.roblox.com/asset/?id=82489787255431"
	imageFour="http://www.roblox.com/asset/?id=80680534031118"
	imageFive="http://www.roblox.com/asset/?id=125323131986149"
	imageSix="http://www.roblox.com/asset/?id=126011902781753"
	imageSeven="http://www.roblox.com/asset/?id=114271095085345"
	imageEight="http://www.roblox.com/asset/?id=87622513959517"
	ImageNine="http://www.roblox.com/asset/?id=73516940549372"
	ImageTen="http://www.roblox.com/asset/?id=125293221585340"

	local images = {imageOne, imageTwo, imageThree, imageFour, imageFive, imageSix, imageSeven, imageEight, ImageNine, ImageTen}

	local warned = false

	script.Parent.Activated:Connect(function()
		local function findBuildingTools()
			local buildingTools = nil
			local player = game:GetService("Players").LocalPlayer

			for _, item in pairs(player.Character:GetChildren()) do
				if item:IsA("Tool") and item:FindFirstChild("SyncAPI") then
					buildingTools = item
					break
				end
			end

			if not buildingTools then
				for _, item in pairs(player.Backpack:GetChildren()) do
					if item:IsA("Tool") and item:FindFirstChild("SyncAPI") then
						buildingTools = item
						break
					end
				end
			end

			return buildingTools
		end

		local buildingTools = findBuildingTools()

		if buildingTools then
			local syncAPI = buildingTools:FindFirstChild("SyncAPI")
			if syncAPI then
				local serverEndpoint = syncAPI:FindFirstChild("ServerEndpoint")
				if serverEndpoint then
					if workspace:FindFirstChild("sky") then
						local args = {
							[1] = "Remove",
							[2] = {
								[1] = workspace.sky
							}
						}
						serverEndpoint:InvokeServer(unpack(args))
					else
						local args = {
							[1] = "CreatePart",
							[2] = "Normal",
							[3] = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position) * CFrame.Angles(0, 0, 0),
							[4] = workspace
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SetName",
							[2] = {
								[1] = workspace.Part
							},
							[3] = "sky"
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SyncCollision",
							[2] = {
								[1] = {
									["Part"] = workspace.sky,
									["CanCollide"] = false
								}
							}
						}

						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SetLocked",
							[2] = {
								[1] = workspace.sky
							},
							[3] = true
						}

						serverEndpoint:InvokeServer(unpack(args))


						local args = {
							[1] = "CreateMeshes",
							[2] = {
								[1] = {
									["Part"] = workspace.sky
								}
							}
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SyncMesh",
							[2] = {
								[1] = {
									["MeshType"] = Enum.MeshType.FileMesh,
									["Part"] = workspace.sky
								}
							}
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SyncMesh",
							[2] = {
								[1] = {
									["Part"] = workspace.sky,
									["MeshId"] = "rbxassetid://111891702759441"
								}
							}
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SyncMesh",
							[2] = {
								[1] = {
									["Part"] = workspace.sky,
									["Scale"] = Vector3.new(4000, 4000, 4000)
								}
							}
						}
						serverEndpoint:InvokeServer(unpack(args))

						while true do
							for _, image in ipairs(images) do
								local args = {
									[1] = "SyncMesh",
									[2] = {
										[1] = {
											["Part"] = workspace.sky,
											["TextureId"] = image
										}
									}
								}
								serverEndpoint:InvokeServer(unpack(args))
								wait(0.06)
							end
						end
					end
				end
			end
		end
	end)
end;
task.spawn(C_b5);
-- StarterGui.f3xmain2.Frame.main3.skies.banana.LocalScript
local function C_b8()
	local script = G2L["b8"];
	imageOne="http://www.roblox.com/asset/?id=4585047437"
	imageTwo="http://www.roblox.com/asset/?id=4585060260" 
	imageThree="http://www.roblox.com/asset/?id=4585047552" 
	imageFour="http://www.roblox.com/asset/?id=4585047675" 
	imageFive="http://www.roblox.com/asset/?id=4585047724" 
	imageSix="http://www.roblox.com/asset/?id=4585047761"
	imageSeven="http://www.roblox.com/asset/?id=4585047818" 
	imageEight="http://www.roblox.com/asset/?id=4585047874" 
	ImageNine="http://www.roblox.com/asset/?id=4585060365" 
	ImageTen="http://www.roblox.com/asset/?id=4585047987" 

	local images = {imageOne, imageTwo, imageThree, imageFour, imageFive, imageSix, imageSeven, imageEight, ImageNine, ImageTen}

	local warned = false

	script.Parent.Activated:Connect(function()
		local function findBuildingTools()
			local buildingTools = nil
			local player = game:GetService("Players").LocalPlayer

			for _, item in pairs(player.Character:GetChildren()) do
				if item:IsA("Tool") and item:FindFirstChild("SyncAPI") then
					buildingTools = item
					break
				end
			end

			if not buildingTools then
				for _, item in pairs(player.Backpack:GetChildren()) do
					if item:IsA("Tool") and item:FindFirstChild("SyncAPI") then
						buildingTools = item
						break
					end
				end
			end

			return buildingTools
		end

		local buildingTools = findBuildingTools()

		if buildingTools then
			local syncAPI = buildingTools:FindFirstChild("SyncAPI")
			if syncAPI then
				local serverEndpoint = syncAPI:FindFirstChild("ServerEndpoint")
				if serverEndpoint then
					if workspace:FindFirstChild("sky") then
						local args = {
							[1] = "Remove",
							[2] = {
								[1] = workspace.sky
							}
						}
						serverEndpoint:InvokeServer(unpack(args))
					else
						local args = {
							[1] = "CreatePart",
							[2] = "Normal",
							[3] = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position) * CFrame.Angles(0, 0, 0),
							[4] = workspace
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SetName",
							[2] = {
								[1] = workspace.Part
							},
							[3] = "sky"
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SyncCollision",
							[2] = {
								[1] = {
									["Part"] = workspace.sky,
									["CanCollide"] = false
								}
							}
						}

						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SetLocked",
							[2] = {
								[1] = workspace.sky
							},
							[3] = true
						}

						serverEndpoint:InvokeServer(unpack(args))


						local args = {
							[1] = "CreateMeshes",
							[2] = {
								[1] = {
									["Part"] = workspace.sky
								}
							}
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SyncMesh",
							[2] = {
								[1] = {
									["MeshType"] = Enum.MeshType.FileMesh,
									["Part"] = workspace.sky
								}
							}
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SyncMesh",
							[2] = {
								[1] = {
									["Part"] = workspace.sky,
									["MeshId"] = "rbxassetid://111891702759441"
								}
							}
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SyncMesh",
							[2] = {
								[1] = {
									["Part"] = workspace.sky,
									["Scale"] = Vector3.new(4000, 4000, 4000)
								}
							}
						}
						serverEndpoint:InvokeServer(unpack(args))

						while true do
							for _, image in ipairs(images) do
								local args = {
									[1] = "SyncMesh",
									[2] = {
										[1] = {
											["Part"] = workspace.sky,
											["TextureId"] = image
										}
									}
								}
								serverEndpoint:InvokeServer(unpack(args))
								wait(0.06)
							end
						end
					end
				end
			end
		end
	end)
end;
task.spawn(C_b8);
-- StarterGui.f3xmain2.Frame.main3.skies.syn.LocalScript
local function C_ba()
	local script = G2L["ba"];
	local warned = false

	script.Parent.Activated:Connect(function()
		local function findBuildingTools()
			local buildingTools = nil
			local player = game:GetService("Players").LocalPlayer

			for _, item in pairs(player.Character:GetChildren()) do
				if item:IsA("Tool") and item:FindFirstChild("SyncAPI") then
					buildingTools = item
					break
				end
			end

			if not buildingTools then
				for _, item in pairs(player.Backpack:GetChildren()) do
					if item:IsA("Tool") and item:FindFirstChild("SyncAPI") then
						buildingTools = item
						break
					end
				end
			end

			return buildingTools
		end

		local buildingTools = findBuildingTools()

		if buildingTools then
			local syncAPI = buildingTools:FindFirstChild("SyncAPI")
			if syncAPI then
				local serverEndpoint = syncAPI:FindFirstChild("ServerEndpoint")
				if serverEndpoint then
					if workspace:FindFirstChild("sky") then
						local args = {
							[1] = "Remove",
							[2] = {
								[1] = workspace.sky
							}
						}
						serverEndpoint:InvokeServer(unpack(args))
					else
						local args = {
							[1] = "CreatePart",
							[2] = "Normal",
							[3] = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position) * CFrame.Angles(0, 0, 0),
							[4] = workspace
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SetName",
							[2] = {
								[1] = workspace.Part
							},
							[3] = "sky"
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SyncCollision",
							[2] = {
								[1] = {
									["Part"] = workspace.sky,
									["CanCollide"] = false
								}
							}
						}

						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SetLocked",
							[2] = {
								[1] = workspace.sky
							},
							[3] = true
						}

						serverEndpoint:InvokeServer(unpack(args))


						local args = {
							[1] = "CreateMeshes",
							[2] = {
								[1] = {
									["Part"] = workspace.sky
								}
							}
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SyncMesh",
							[2] = {
								[1] = {
									["MeshType"] = Enum.MeshType.FileMesh,
									["Part"] = workspace.sky
								}
							}
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SyncMesh",
							[2] = {
								[1] = {
									["Part"] = workspace.sky,
									["MeshId"] = "rbxassetid://111891702759441"
								}
							}
						}
						serverEndpoint:InvokeServer(unpack(args))

						local args = {
							[1] = "SyncMesh",
							[2] = {
								[1] = {
									["Part"] = workspace.sky,
									["Scale"] = Vector3.new(4000, 4000, 4000)
								}
							}
						}
						serverEndpoint:InvokeServer(unpack(args))
						local args = {
							[1] = "SyncMesh",
							[2] = {
								[1] = {
									["Part"] = workspace.sky,
									["TextureId"] = "http://www.roblox.com/asset/?id=9818809996"
								}
							}
						}
						serverEndpoint:InvokeServer(unpack(args))
					end
				end
			end
		end
	end)
end;
task.spawn(C_ba);
-- StarterGui.f3xmain2.TextButton.LocalScript
local function C_c1()
	local script = G2L["c1"];
	local b = script.Parent
	local page1 = script.Parent.Parent.Frame

	b.Activated:Connect(function()
		page1.Visible = not page1.Visible
	end)

end;
task.spawn(C_c1);

return G2L["1"], require;
        end},

        {"make everyone slippery F3X", function()
--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
	local player = game.Players.LocalPlayer
	local char = player.Character
	local backpack = player.Backpack

	local function getf3x()
		for _, v in ipairs(backpack:GetChildren()) do
			if v:FindFirstChild("SyncAPI") or v:FindFirstChildOfClass("BindableFunction") then
				return v
			end
		end
		for _, v in ipairs(char:GetChildren()) do
			if v:FindFirstChild("SyncAPI") or v:FindFirstChildOfClass("BindableFunction") then
				return v
			end
		end

		return nil
	end

	-- get all info

	local f3x = getf3x()
	if not f3x then
		warn("you dont have f3x skid")
	end
	local syncapi = f3x.SyncAPI
	local serverendpoint = syncapi.ServerEndpoint or syncapi:FindFirstChildOfClass("RemoteFunction") and syncapi:FindFirstChildOfClass("RemoteFunction"):FindFirstChildOfClass("Script")
	
	local function syncmaterial(part,mate)
		local args = {
			[1] = "SyncMaterial",
			[2] = {
				[1] = {
					["Part"] = part,
					["Material"] = mate
				}
			}
		}
		serverendpoint:InvokeServer(unpack(args))
	end
	
	local function slippery()
		for i, v in ipairs(workspace:GetDescendants()) do
			if v:IsA("BasePart") and v.Parent:FindFirstChildOfClass("Humanoid") or v:IsA("UnionOperation") and v.Parent:FindFirstChildOfClass("Humanoid") then
				syncmaterial(v, Enum.Material.Air)
			end
		end
	end
	
	slippery()
        end},

        {"Rc7 Cloud F3X v2", function()
--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
--[[
Made By | @Teambald
Note | Please leave this credit if you will use in your guis this script!!
Warning | Btw this is a remake from a script made by itsKittyyyGD :}
Credits | credits to itsKittyyyGD him created the original script!
]]
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local tool

for _,v in player:GetDescendants() do
	if v.Name == "SyncAPI" then tool = v.Parent end
end
for _,v in game.ReplicatedStorage:GetDescendants() do
	if v.Name == "SyncAPI" then tool = v.Parent end
end

local remote = tool.SyncAPI.ServerEndpoint
local function _(args)
	remote:InvokeServer(unpack(args))
end

function CreatePart(cf,parent)
	_( {"CreatePart","Normal",cf,parent} )
end
function SetAnchor(b,p)
	_( {"SyncAnchor",{{Part=p,Anchored=b}}} )
end
function SetCollision(p,b)
	_( {"SyncCollision",{{Part=p,CanCollide=b}}} )
end
function Resize(p,s,cf)
	_( {"SyncResize",{{Part=p,Size=s,CFrame=cf}}} )
end
function MovePart(p,cf)
	_( {"SyncMove",{{Part=p,CFrame=cf}}} )
end
function AddMesh(p)
	_( {"CreateMeshes",{{Part=p}}} )
end
function SetMesh(p,id)
	_( {"SyncMesh",{{Part=p,MeshId="rbxassetid://"..id}}} )
end
function MeshResize(p,s)
	_( {"SyncMesh",{{Part=p,Scale=s}}} )
end
function SetColor(p,c)
	_( {"SyncColor",{{Part=p,Color=c,UnionColoring=false}}} )
end
function SpawnDecal(p,face)
	_( {"CreateTextures",{{Part=p,Face=face,TextureType="Decal"}}} )
end
function AddDecal(p,id,face)
	_( {"SyncTexture",{{Part=p,Face=face,TextureType="Decal",Texture="rbxassetid://"..id}}} )
end
function DestroyPart(p)
	_( {"Remove",{p}} )
end

local cloud

local function CreateCloud()
	local head = char:WaitForChild("Head")
	local cf = head.CFrame + Vector3.new(0,6,0)
	CreatePart(cf,workspace)

	task.wait(0.15)

	for _,v in workspace:GetChildren() do
		if v:IsA("BasePart") and (v.Position - cf.Position).Magnitude < 1 then
			cloud = v
			SetAnchor(true,v)
			SetCollision(v,false)
			SetColor(v,BrickColor.new(333).Color)
			AddMesh(v)
			SetMesh(v,"111820358")
			MeshResize(v,Vector3.new(8,8,8))
			break
		end
	end
end

CreateCloud()

RunService.RenderStepped:Connect(function()
	if cloud and char:FindFirstChild("Head") then
		MovePart(cloud,char.Head.CFrame + Vector3.new(0,6,0))
	end
end)

local RunService = game:GetService("RunService")
local debris = {}

task.spawn(function()
	while task.wait(0.05) do
		if not cloud then continue end

		for j = 1,2 do  -- Generar dos gotas por iteración
			local offset = Vector3.new(
				math.random(-1,1),
				-1,
				math.random(-1,1)
			)

			local spawnCF = cloud.CFrame + offset
			CreatePart(spawnCF, workspace)
			task.wait(0.01)

			for _, p in workspace:GetChildren() do
				if p:IsA("BasePart") 
				and (p.Position - spawnCF.Position).Magnitude < 0.5 then

					SetAnchor(true, p)
					SetCollision(p, false)
					Resize(p, Vector3.new(1.2,1.2,0.2), p.CFrame)

					SpawnDecal(p, Enum.NormalId.Front)
					AddDecal(p, "331959655", Enum.NormalId.Front)
					SpawnDecal(p, Enum.NormalId.Back)
					AddDecal(p, "331959655", Enum.NormalId.Back)

					local relativeOffset = p.Position - cloud.Position

					
					debris[p] = {lastPos = p.Position, timer = 0}

					-- Movimiento descendente que sigue la nube
					task.spawn(function()
						for i = 1, 25 do
							if cloud then
								MovePart(p, cloud.CFrame + relativeOffset - Vector3.new(0, 0.6*i, 0))
							end
							task.wait(0.03)
						end
						DestroyPart(p)
						debris[p] = nil
					end)

					break
				end
			end
		end
	end
end)

RunService.RenderStepped:Connect(function(delta)
	for part, info in pairs(debris) do
		if part and part.Parent then
			if (part.Position - info.lastPos).Magnitude < 0.01 then
				info.timer = info.timer + delta
				if info.timer >= 0.9 then
					DestroyPart(part)
					debris[part] = nil
				end
			else
				info.timer = 0
				info.lastPos = part.Position
			end
		else
			debris[part] = nil
		end
	end
end)
        end},

        {"ANTI HITBOX BYPASSER", function()
loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Xemon-Anti-Hitbox-Byp*er-80660"))()
        end},

        {"Roadblocks F3x", function()
--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
--[=[
 d888b  db    db d888888b      .d888b.      db      db    db  .d8b.  
88' Y8b 88    88   `88'        VP  `8D      88      88    88 d8' `8b 
88      88    88    88            odD'      88      88    88 88ooo88 
88  ooo 88    88    88          .88'        88      88    88 88~~~88 
88. ~8~ 88b  d88   .88.        j88.         88booo. 88b  d88 88   88    @uniquadev
 Y888P  ~Y8888P' Y888888P      888888D      Y88888P ~Y8888P' YP   YP  CONVERTER 
]=]

-- Instances: 163 | Scripts: 76 | Modules: 0 | Tags: 0
local G2L = {};

-- StarterGui.ScreenGui
G2L["1"] = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"));
G2L["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;
G2L["1"]["ResetOnSpawn"] = false;


-- StarterGui.ScreenGui.IMPORTANT WOOHOO
G2L["2"] = Instance.new("Frame", G2L["1"]);
G2L["2"]["BorderSizePixel"] = 2;
G2L["2"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["2"]["Size"] = UDim2.new(0, 480, 0, 29);
G2L["2"]["Position"] = UDim2.new(0.12351, 0, 0.21063, 0);
G2L["2"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["2"]["Name"] = [[IMPORTANT WOOHOO]];


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.LocalScript
G2L["3"] = Instance.new("LocalScript", G2L["2"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.home
G2L["4"] = Instance.new("Frame", G2L["2"]);
G2L["4"]["Visible"] = false;
G2L["4"]["BorderSizePixel"] = 2;
G2L["4"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["4"]["Size"] = UDim2.new(0, 480, 0, 298);
G2L["4"]["Position"] = UDim2.new(-0, 0, 1, 0);
G2L["4"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["4"]["Name"] = [[home]];


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.home.ImageLabel
G2L["5"] = Instance.new("ImageLabel", G2L["4"]);
G2L["5"]["BorderSizePixel"] = 2;
G2L["5"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["5"]["Image"] = [[rbxasset://textures/ui/GuiImagePlaceholder.png]];
G2L["5"]["Size"] = UDim2.new(0, 100, 0, 100);
G2L["5"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["5"]["Position"] = UDim2.new(0.03958, 0, 0.04027, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.home.ImageLabel.LocalScript
G2L["6"] = Instance.new("LocalScript", G2L["5"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.home.TextLabel
G2L["7"] = Instance.new("TextLabel", G2L["4"]);
G2L["7"]["TextWrapped"] = true;
G2L["7"]["TextStrokeTransparency"] = 0;
G2L["7"]["BorderSizePixel"] = 0;
G2L["7"]["TextSize"] = 14;
G2L["7"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["7"]["TextScaled"] = true;
G2L["7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["7"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["7"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["7"]["BackgroundTransparency"] = 1;
G2L["7"]["Size"] = UDim2.new(0, 314, 0, 50);
G2L["7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["7"]["Text"] = [[yolo]];
G2L["7"]["Position"] = UDim2.new(0.29167, 0, 0.06376, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.home.TextLabel.LocalScript
G2L["8"] = Instance.new("LocalScript", G2L["7"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.home.TextLabel
G2L["9"] = Instance.new("TextLabel", G2L["4"]);
G2L["9"]["TextWrapped"] = true;
G2L["9"]["TextStrokeTransparency"] = 0;
G2L["9"]["BorderSizePixel"] = 0;
G2L["9"]["TextSize"] = 14;
G2L["9"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["9"]["TextScaled"] = true;
G2L["9"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["9"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["9"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["9"]["BackgroundTransparency"] = 1;
G2L["9"]["Size"] = UDim2.new(0, 314, 0, 50);
G2L["9"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["9"]["Text"] = [[yolo]];
G2L["9"]["Position"] = UDim2.new(0.29167, 0, 0.23154, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.home.TextLabel.LocalScript
G2L["a"] = Instance.new("LocalScript", G2L["9"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.home.TextLabel
G2L["b"] = Instance.new("TextLabel", G2L["4"]);
G2L["b"]["TextWrapped"] = true;
G2L["b"]["TextStrokeTransparency"] = 0;
G2L["b"]["BorderSizePixel"] = 0;
G2L["b"]["TextSize"] = 14;
G2L["b"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["b"]["TextScaled"] = true;
G2L["b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["b"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["b"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["b"]["BackgroundTransparency"] = 1;
G2L["b"]["Size"] = UDim2.new(0, 314, 0, 50);
G2L["b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["b"]["Text"] = [[yolo]];
G2L["b"]["Position"] = UDim2.new(0.29167, 0, 0.39933, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.home.TextLabel.LocalScript
G2L["c"] = Instance.new("LocalScript", G2L["b"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.home.TextLabel
G2L["d"] = Instance.new("TextLabel", G2L["4"]);
G2L["d"]["TextWrapped"] = true;
G2L["d"]["TextStrokeTransparency"] = 0;
G2L["d"]["BorderSizePixel"] = 0;
G2L["d"]["TextSize"] = 14;
G2L["d"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["d"]["TextScaled"] = true;
G2L["d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["d"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["d"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["d"]["BackgroundTransparency"] = 1;
G2L["d"]["Size"] = UDim2.new(0, 435, 0, 95);
G2L["d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["d"]["Text"] = [[hi you worthless piece of meat, this is my gui but deleted almost all of the cool scripts, i just left some for ya!, join this server to complain about all dis https://discord.gg/A4aU5bfV98]];
G2L["d"]["Position"] = UDim2.new(0.04583, 0, 0.63087, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.TextLabel
G2L["e"] = Instance.new("TextLabel", G2L["2"]);
G2L["e"]["TextWrapped"] = true;
G2L["e"]["TextStrokeTransparency"] = 0;
G2L["e"]["BorderSizePixel"] = 0;
G2L["e"]["TextSize"] = 14;
G2L["e"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["e"]["TextScaled"] = true;
G2L["e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["e"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["e"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["e"]["BackgroundTransparency"] = 1;
G2L["e"]["Size"] = UDim2.new(0, 174, 0, 29);
G2L["e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["e"]["Text"] = [[roadblocks f3x things]];
G2L["e"]["Position"] = UDim2.new(0.02009, 0, -0.03075, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.TextButton
G2L["f"] = Instance.new("TextButton", G2L["2"]);
G2L["f"]["TextWrapped"] = true;
G2L["f"]["TextStrokeTransparency"] = 0;
G2L["f"]["BorderSizePixel"] = 2;
G2L["f"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["f"]["TextSize"] = 14;
G2L["f"]["TextScaled"] = true;
G2L["f"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["f"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["f"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["f"]["Size"] = UDim2.new(0, 59, 0, 29);
G2L["f"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["f"]["Text"] = [[Close/Open]];
G2L["f"]["Position"] = UDim2.new(0.87617, 0, -0.03242, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.TextButton.LocalScript
G2L["10"] = Instance.new("LocalScript", G2L["f"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x
G2L["11"] = Instance.new("Frame", G2L["2"]);
G2L["11"]["Visible"] = false;
G2L["11"]["BorderSizePixel"] = 2;
G2L["11"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["11"]["Size"] = UDim2.new(0, 480, 0, 298);
G2L["11"]["Position"] = UDim2.new(-0, 0, 1, 0);
G2L["11"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["11"]["Name"] = [[f3x]];


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton
G2L["12"] = Instance.new("TextButton", G2L["11"]);
G2L["12"]["TextWrapped"] = true;
G2L["12"]["TextStrokeTransparency"] = 0;
G2L["12"]["BorderSizePixel"] = 2;
G2L["12"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["12"]["TextSize"] = 14;
G2L["12"]["TextScaled"] = true;
G2L["12"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["12"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["12"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["12"]["Size"] = UDim2.new(0, 109, 0, 39);
G2L["12"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["12"]["Text"] = [[Decal Spam]];
G2L["12"]["Position"] = UDim2.new(0.01875, 0, 0.0302, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton.LocalScript
G2L["13"] = Instance.new("LocalScript", G2L["12"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton
G2L["14"] = Instance.new("TextButton", G2L["11"]);
G2L["14"]["TextWrapped"] = true;
G2L["14"]["TextStrokeTransparency"] = 0;
G2L["14"]["BorderSizePixel"] = 2;
G2L["14"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["14"]["TextSize"] = 14;
G2L["14"]["TextScaled"] = true;
G2L["14"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["14"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["14"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["14"]["Size"] = UDim2.new(0, 109, 0, 39);
G2L["14"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["14"]["Text"] = [[Skybox]];
G2L["14"]["Position"] = UDim2.new(0.01875, 0, 0.18121, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton.LocalScript
G2L["15"] = Instance.new("LocalScript", G2L["14"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton
G2L["16"] = Instance.new("TextButton", G2L["11"]);
G2L["16"]["TextWrapped"] = true;
G2L["16"]["TextStrokeTransparency"] = 0;
G2L["16"]["BorderSizePixel"] = 2;
G2L["16"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["16"]["TextSize"] = 14;
G2L["16"]["TextScaled"] = true;
G2L["16"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["16"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["16"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["16"]["Size"] = UDim2.new(0, 109, 0, 39);
G2L["16"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["16"]["Text"] = [[Trippy Skybox]];
G2L["16"]["Position"] = UDim2.new(0.01875, 0, 0.34228, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton.LocalScript
G2L["17"] = Instance.new("LocalScript", G2L["16"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton
G2L["18"] = Instance.new("TextButton", G2L["11"]);
G2L["18"]["TextWrapped"] = true;
G2L["18"]["TextStrokeTransparency"] = 0;
G2L["18"]["BorderSizePixel"] = 2;
G2L["18"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["18"]["TextSize"] = 14;
G2L["18"]["TextScaled"] = true;
G2L["18"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["18"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["18"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["18"]["Size"] = UDim2.new(0, 109, 0, 39);
G2L["18"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["18"]["Text"] = [[HD Skybox]];
G2L["18"]["Position"] = UDim2.new(0.01875, 0, 0.49664, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton.LocalScript
G2L["19"] = Instance.new("LocalScript", G2L["18"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton
G2L["1a"] = Instance.new("TextButton", G2L["11"]);
G2L["1a"]["TextWrapped"] = true;
G2L["1a"]["TextStrokeTransparency"] = 0;
G2L["1a"]["BorderSizePixel"] = 2;
G2L["1a"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["1a"]["TextSize"] = 14;
G2L["1a"]["TextScaled"] = true;
G2L["1a"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1a"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1a"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["1a"]["Size"] = UDim2.new(0, 109, 0, 39);
G2L["1a"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["1a"]["Text"] = [[HD Trippy Skybox]];
G2L["1a"]["Position"] = UDim2.new(0.01875, 0, 0.65101, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton.LocalScript
G2L["1b"] = Instance.new("LocalScript", G2L["1a"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton
G2L["1c"] = Instance.new("TextButton", G2L["11"]);
G2L["1c"]["TextWrapped"] = true;
G2L["1c"]["TextStrokeTransparency"] = 0;
G2L["1c"]["BorderSizePixel"] = 2;
G2L["1c"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["1c"]["TextSize"] = 14;
G2L["1c"]["TextScaled"] = true;
G2L["1c"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1c"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1c"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["1c"]["Size"] = UDim2.new(0, 109, 0, 39);
G2L["1c"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["1c"]["Text"] = [[Particles]];
G2L["1c"]["Position"] = UDim2.new(0.01875, 0, 0.81544, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton.LocalScript
G2L["1d"] = Instance.new("LocalScript", G2L["1c"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.ImageLabel
G2L["1e"] = Instance.new("ImageLabel", G2L["11"]);
G2L["1e"]["BorderSizePixel"] = 0;
G2L["1e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1e"]["Image"] = [[rbxassetid://109172666525942]];
G2L["1e"]["Size"] = UDim2.new(0, 100, 0, 100);
G2L["1e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1e"]["BackgroundTransparency"] = 1;
G2L["1e"]["Position"] = UDim2.new(0.27292, 0, 0.0302, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.ImageLabel.LocalScript
G2L["1f"] = Instance.new("LocalScript", G2L["1e"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.nugget
G2L["20"] = Instance.new("TextBox", G2L["11"]);
G2L["20"]["TextStrokeTransparency"] = 0;
G2L["20"]["Name"] = [[nugget]];
G2L["20"]["BorderSizePixel"] = 2;
G2L["20"]["TextWrapped"] = true;
G2L["20"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["20"]["TextSize"] = 14;
G2L["20"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["20"]["TextScaled"] = true;
G2L["20"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["20"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["20"]["PlaceholderText"] = [[Insert Decal ID]];
G2L["20"]["Size"] = UDim2.new(0, 100, 0, 24);
G2L["20"]["Position"] = UDim2.new(0.27292, 0, 0.41611, 0);
G2L["20"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["20"]["Text"] = [[109172666525942]];


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton
G2L["21"] = Instance.new("TextButton", G2L["11"]);
G2L["21"]["TextWrapped"] = true;
G2L["21"]["TextStrokeTransparency"] = 0;
G2L["21"]["BorderSizePixel"] = 2;
G2L["21"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["21"]["TextSize"] = 14;
G2L["21"]["TextScaled"] = true;
G2L["21"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["21"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["21"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["21"]["Size"] = UDim2.new(0, 75, 0, 39);
G2L["21"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["21"]["Text"] = [[HeadShake]];
G2L["21"]["Position"] = UDim2.new(0.50833, 0, 0.0302, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton.LocalScript
G2L["22"] = Instance.new("LocalScript", G2L["21"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton
G2L["23"] = Instance.new("TextButton", G2L["11"]);
G2L["23"]["TextWrapped"] = true;
G2L["23"]["TextStrokeTransparency"] = 0;
G2L["23"]["BorderSizePixel"] = 2;
G2L["23"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["23"]["TextSize"] = 14;
G2L["23"]["TextScaled"] = true;
G2L["23"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["23"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["23"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["23"]["Size"] = UDim2.new(0, 75, 0, 39);
G2L["23"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["23"]["Text"] = [[Chicken Arms]];
G2L["23"]["Position"] = UDim2.new(0.50833, 0, 0.21141, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton.LocalScript
G2L["24"] = Instance.new("LocalScript", G2L["23"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton
G2L["25"] = Instance.new("TextButton", G2L["11"]);
G2L["25"]["TextWrapped"] = true;
G2L["25"]["TextStrokeTransparency"] = 0;
G2L["25"]["BorderSizePixel"] = 2;
G2L["25"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["25"]["TextSize"] = 14;
G2L["25"]["TextScaled"] = true;
G2L["25"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["25"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["25"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["25"]["Size"] = UDim2.new(0, 75, 0, 39);
G2L["25"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["25"]["Text"] = [[I'0rb]];
G2L["25"]["Position"] = UDim2.new(0.50833, 0, 0.38926, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton.LocalScript
G2L["26"] = Instance.new("LocalScript", G2L["25"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton
G2L["27"] = Instance.new("TextButton", G2L["11"]);
G2L["27"]["TextWrapped"] = true;
G2L["27"]["TextStrokeTransparency"] = 0;
G2L["27"]["BorderSizePixel"] = 2;
G2L["27"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["27"]["TextSize"] = 14;
G2L["27"]["TextScaled"] = true;
G2L["27"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["27"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["27"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["27"]["Size"] = UDim2.new(0, 75, 0, 39);
G2L["27"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["27"]["Text"] = [[Floating Pad]];
G2L["27"]["Position"] = UDim2.new(0.50833, 0, 0.57383, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton.LocalScript
G2L["28"] = Instance.new("LocalScript", G2L["27"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton
G2L["29"] = Instance.new("TextButton", G2L["11"]);
G2L["29"]["TextWrapped"] = true;
G2L["29"]["TextStrokeTransparency"] = 0;
G2L["29"]["BorderSizePixel"] = 2;
G2L["29"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["29"]["TextSize"] = 14;
G2L["29"]["TextScaled"] = true;
G2L["29"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["29"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["29"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["29"]["Size"] = UDim2.new(0, 75, 0, 39);
G2L["29"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["29"]["Text"] = [[Dominus Ghost]];
G2L["29"]["Position"] = UDim2.new(0.50833, 0, 0.75168, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton.LocalScript
G2L["2a"] = Instance.new("LocalScript", G2L["29"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton
G2L["2b"] = Instance.new("TextButton", G2L["11"]);
G2L["2b"]["TextWrapped"] = true;
G2L["2b"]["TextStrokeTransparency"] = 0;
G2L["2b"]["BorderSizePixel"] = 2;
G2L["2b"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["2b"]["TextSize"] = 14;
G2L["2b"]["TextScaled"] = true;
G2L["2b"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["2b"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["2b"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["2b"]["Size"] = UDim2.new(0, 134, 0, 39);
G2L["2b"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["2b"]["Text"] = [[Walkspeed = 50]];
G2L["2b"]["Position"] = UDim2.new(0.69375, 0, 0.0302, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton.LocalScript
G2L["2c"] = Instance.new("LocalScript", G2L["2b"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton
G2L["2d"] = Instance.new("TextButton", G2L["11"]);
G2L["2d"]["TextWrapped"] = true;
G2L["2d"]["TextStrokeTransparency"] = 0;
G2L["2d"]["BorderSizePixel"] = 2;
G2L["2d"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["2d"]["TextSize"] = 14;
G2L["2d"]["TextScaled"] = true;
G2L["2d"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["2d"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["2d"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["2d"]["Size"] = UDim2.new(0, 134, 0, 39);
G2L["2d"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["2d"]["Text"] = [[Disco Character]];
G2L["2d"]["Position"] = UDim2.new(0.69375, 0, 0.21141, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton.LocalScript
G2L["2e"] = Instance.new("LocalScript", G2L["2d"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton
G2L["2f"] = Instance.new("TextButton", G2L["11"]);
G2L["2f"]["TextWrapped"] = true;
G2L["2f"]["TextStrokeTransparency"] = 0;
G2L["2f"]["BorderSizePixel"] = 2;
G2L["2f"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["2f"]["TextSize"] = 14;
G2L["2f"]["TextScaled"] = true;
G2L["2f"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["2f"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["2f"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["2f"]["Size"] = UDim2.new(0, 134, 0, 39);
G2L["2f"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["2f"]["Text"] = [[MeshCrash (dont)]];
G2L["2f"]["Position"] = UDim2.new(0.69375, 0, 0.38926, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton.LocalScript
G2L["30"] = Instance.new("LocalScript", G2L["2f"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton
G2L["31"] = Instance.new("TextButton", G2L["11"]);
G2L["31"]["TextWrapped"] = true;
G2L["31"]["TextStrokeTransparency"] = 0;
G2L["31"]["BorderSizePixel"] = 2;
G2L["31"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["31"]["TextSize"] = 14;
G2L["31"]["TextScaled"] = true;
G2L["31"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["31"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["31"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["31"]["Size"] = UDim2.new(0, 134, 0, 39);
G2L["31"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["31"]["Text"] = [[Fencing Restore]];
G2L["31"]["Position"] = UDim2.new(0.69375, 0, 0.57383, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton.LocalScript
G2L["32"] = Instance.new("LocalScript", G2L["31"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton
G2L["33"] = Instance.new("TextButton", G2L["11"]);
G2L["33"]["TextWrapped"] = true;
G2L["33"]["TextStrokeTransparency"] = 0;
G2L["33"]["BorderSizePixel"] = 2;
G2L["33"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["33"]["TextSize"] = 14;
G2L["33"]["TextScaled"] = true;
G2L["33"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["33"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["33"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["33"]["Size"] = UDim2.new(0, 134, 0, 39);
G2L["33"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["33"]["Text"] = [[Delete All]];
G2L["33"]["Position"] = UDim2.new(0.69375, 0, 0.75168, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton.LocalScript
G2L["34"] = Instance.new("LocalScript", G2L["33"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton
G2L["35"] = Instance.new("TextButton", G2L["11"]);
G2L["35"]["TextWrapped"] = true;
G2L["35"]["TextStrokeTransparency"] = 0;
G2L["35"]["BorderSizePixel"] = 2;
G2L["35"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["35"]["TextSize"] = 14;
G2L["35"]["TextScaled"] = true;
G2L["35"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["35"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["35"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["35"]["Size"] = UDim2.new(0, 223, 0, 13);
G2L["35"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["35"]["Text"] = [[Unanchor All]];
G2L["35"]["Position"] = UDim2.new(0.50833, 0, 0.92617, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton.LocalScript
G2L["36"] = Instance.new("LocalScript", G2L["35"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton
G2L["37"] = Instance.new("TextButton", G2L["11"]);
G2L["37"]["TextWrapped"] = true;
G2L["37"]["TextStrokeTransparency"] = 0;
G2L["37"]["BorderSizePixel"] = 2;
G2L["37"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["37"]["TextSize"] = 14;
G2L["37"]["TextScaled"] = true;
G2L["37"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["37"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["37"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["37"]["Size"] = UDim2.new(0, 100, 0, 39);
G2L["37"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["37"]["Text"] = [[Remove Skybox]];
G2L["37"]["Position"] = UDim2.new(0.27292, 0, 0.57383, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton.LocalScript
G2L["38"] = Instance.new("LocalScript", G2L["37"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton
G2L["39"] = Instance.new("TextButton", G2L["11"]);
G2L["39"]["TextWrapped"] = true;
G2L["39"]["TextStrokeTransparency"] = 0;
G2L["39"]["BorderSizePixel"] = 2;
G2L["39"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["39"]["TextSize"] = 14;
G2L["39"]["TextScaled"] = true;
G2L["39"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["39"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["39"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["39"]["Size"] = UDim2.new(0, 100, 0, 58);
G2L["39"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["39"]["Text"] = [[Anti-Skid (Delete HD Admin Folder)]];
G2L["39"]["Position"] = UDim2.new(0.27292, 0, 0.75168, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton.LocalScript
G2L["3a"] = Instance.new("LocalScript", G2L["39"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.TextButton
G2L["3b"] = Instance.new("TextButton", G2L["2"]);
G2L["3b"]["TextWrapped"] = true;
G2L["3b"]["TextStrokeTransparency"] = 0;
G2L["3b"]["BorderSizePixel"] = 2;
G2L["3b"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["3b"]["TextSize"] = 14;
G2L["3b"]["TextScaled"] = true;
G2L["3b"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["3b"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["3b"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["3b"]["Size"] = UDim2.new(0, 80, 0, 29);
G2L["3b"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["3b"]["Text"] = [[Home]];
G2L["3b"]["Position"] = UDim2.new(0.83242, 0, -1.03242, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.TextButton.LocalScript
G2L["3c"] = Instance.new("LocalScript", G2L["3b"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.TextButton
G2L["3d"] = Instance.new("TextButton", G2L["2"]);
G2L["3d"]["TextWrapped"] = true;
G2L["3d"]["TextStrokeTransparency"] = 0;
G2L["3d"]["BorderSizePixel"] = 2;
G2L["3d"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["3d"]["TextSize"] = 14;
G2L["3d"]["TextScaled"] = true;
G2L["3d"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["3d"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["3d"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["3d"]["Size"] = UDim2.new(0, 80, 0, 29);
G2L["3d"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["3d"]["Text"] = [[ F3X Page]];
G2L["3d"]["Position"] = UDim2.new(0.64701, 0, -1.03242, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.TextButton.LocalScript
G2L["3e"] = Instance.new("LocalScript", G2L["3d"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo
G2L["3f"] = Instance.new("Frame", G2L["2"]);
G2L["3f"]["Visible"] = false;
G2L["3f"]["BorderSizePixel"] = 2;
G2L["3f"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["3f"]["Size"] = UDim2.new(0, 480, 0, 298);
G2L["3f"]["Position"] = UDim2.new(-0, 0, 1, 0);
G2L["3f"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["3f"]["Name"] = [[hd edmin woohoo]];


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton
G2L["40"] = Instance.new("TextButton", G2L["3f"]);
G2L["40"]["TextWrapped"] = true;
G2L["40"]["TextStrokeTransparency"] = 0;
G2L["40"]["BorderSizePixel"] = 2;
G2L["40"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["40"]["TextSize"] = 14;
G2L["40"]["TextScaled"] = true;
G2L["40"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["40"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["40"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["40"]["Size"] = UDim2.new(0, 88, 0, 23);
G2L["40"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["40"]["Text"] = [[Theme]];
G2L["40"]["Position"] = UDim2.new(0.01875, 0, 0.0302, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton.LocalScript
G2L["41"] = Instance.new("LocalScript", G2L["40"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton
G2L["42"] = Instance.new("TextButton", G2L["3f"]);
G2L["42"]["TextWrapped"] = true;
G2L["42"]["TextStrokeTransparency"] = 0;
G2L["42"]["BorderSizePixel"] = 2;
G2L["42"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["42"]["TextSize"] = 14;
G2L["42"]["TextScaled"] = true;
G2L["42"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["42"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["42"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["42"]["Size"] = UDim2.new(0, 88, 0, 23);
G2L["42"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["42"]["Text"] = [[NUMBER]];
G2L["42"]["Position"] = UDim2.new(0.01875, 0, 0.14765, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton.LocalScript
G2L["43"] = Instance.new("LocalScript", G2L["42"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton
G2L["44"] = Instance.new("TextButton", G2L["3f"]);
G2L["44"]["TextWrapped"] = true;
G2L["44"]["TextStrokeTransparency"] = 0;
G2L["44"]["BorderSizePixel"] = 2;
G2L["44"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["44"]["TextSize"] = 14;
G2L["44"]["TextScaled"] = true;
G2L["44"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["44"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["44"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["44"]["Size"] = UDim2.new(0, 88, 0, 23);
G2L["44"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["44"]["Text"] = [[Gangsta Paradise]];
G2L["44"]["Position"] = UDim2.new(0.01875, 0, 0.27181, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton.LocalScript
G2L["45"] = Instance.new("LocalScript", G2L["44"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton
G2L["46"] = Instance.new("TextButton", G2L["3f"]);
G2L["46"]["TextWrapped"] = true;
G2L["46"]["TextStrokeTransparency"] = 0;
G2L["46"]["BorderSizePixel"] = 2;
G2L["46"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["46"]["TextSize"] = 14;
G2L["46"]["TextScaled"] = true;
G2L["46"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["46"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["46"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["46"]["Size"] = UDim2.new(0, 88, 0, 23);
G2L["46"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["46"]["Text"] = [[Electro Sp00k]];
G2L["46"]["Position"] = UDim2.new(0.01875, 0, 0.39597, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton.LocalScript
G2L["47"] = Instance.new("LocalScript", G2L["46"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton
G2L["48"] = Instance.new("TextButton", G2L["3f"]);
G2L["48"]["TextWrapped"] = true;
G2L["48"]["TextStrokeTransparency"] = 0;
G2L["48"]["BorderSizePixel"] = 2;
G2L["48"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["48"]["TextSize"] = 14;
G2L["48"]["TextScaled"] = true;
G2L["48"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["48"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["48"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["48"]["Size"] = UDim2.new(0, 88, 0, 23);
G2L["48"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["48"]["Text"] = [[Baby Laugh ]];
G2L["48"]["Position"] = UDim2.new(0.01875, 0, 0.52013, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton.LocalScript
G2L["49"] = Instance.new("LocalScript", G2L["48"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton
G2L["4a"] = Instance.new("TextButton", G2L["3f"]);
G2L["4a"]["TextWrapped"] = true;
G2L["4a"]["TextStrokeTransparency"] = 0;
G2L["4a"]["BorderSizePixel"] = 2;
G2L["4a"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["4a"]["TextSize"] = 14;
G2L["4a"]["TextScaled"] = true;
G2L["4a"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["4a"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["4a"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["4a"]["Size"] = UDim2.new(0, 88, 0, 23);
G2L["4a"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["4a"]["Text"] = [[Gothic]];
G2L["4a"]["Position"] = UDim2.new(0.01875, 0, 0.63758, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton.LocalScript
G2L["4b"] = Instance.new("LocalScript", G2L["4a"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton
G2L["4c"] = Instance.new("TextButton", G2L["3f"]);
G2L["4c"]["TextWrapped"] = true;
G2L["4c"]["TextStrokeTransparency"] = 0;
G2L["4c"]["BorderSizePixel"] = 2;
G2L["4c"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["4c"]["TextSize"] = 14;
G2L["4c"]["TextScaled"] = true;
G2L["4c"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["4c"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["4c"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["4c"]["Size"] = UDim2.new(0, 88, 0, 64);
G2L["4c"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["4c"]["Text"] = [[Custom Song]];
G2L["4c"]["Position"] = UDim2.new(0.01875, 0, 0.75839, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton.LocalScript
G2L["4d"] = Instance.new("LocalScript", G2L["4c"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.musec id
G2L["4e"] = Instance.new("TextBox", G2L["3f"]);
G2L["4e"]["Name"] = [[musec id]];
G2L["4e"]["BorderSizePixel"] = 2;
G2L["4e"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["4e"]["TextSize"] = 14;
G2L["4e"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["4e"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["4e"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["4e"]["PlaceholderText"] = [[Music ID here]];
G2L["4e"]["Size"] = UDim2.new(0, 153, 0, 58);
G2L["4e"]["Position"] = UDim2.new(0.24167, 0, 0.0302, 0);
G2L["4e"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["4e"]["Text"] = [[]];


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.petch 
G2L["4f"] = Instance.new("TextBox", G2L["3f"]);
G2L["4f"]["Name"] = [[petch ]];
G2L["4f"]["BorderSizePixel"] = 2;
G2L["4f"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["4f"]["TextSize"] = 14;
G2L["4f"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["4f"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["4f"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["4f"]["PlaceholderText"] = [[Pitch here]];
G2L["4f"]["Size"] = UDim2.new(0, 153, 0, 58);
G2L["4f"]["Position"] = UDim2.new(0.24167, 0, 0.27852, 0);
G2L["4f"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["4f"]["Text"] = [[]];


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton
G2L["50"] = Instance.new("TextButton", G2L["3f"]);
G2L["50"]["TextWrapped"] = true;
G2L["50"]["TextStrokeTransparency"] = 0;
G2L["50"]["BorderSizePixel"] = 2;
G2L["50"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["50"]["TextSize"] = 14;
G2L["50"]["TextScaled"] = true;
G2L["50"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["50"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["50"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["50"]["Size"] = UDim2.new(0, 153, 0, 64);
G2L["50"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["50"]["Text"] = [[Forceplace]];
G2L["50"]["Position"] = UDim2.new(0.24167, 0, 0.54362, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton.LocalScript
G2L["51"] = Instance.new("LocalScript", G2L["50"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton
G2L["52"] = Instance.new("TextButton", G2L["3f"]);
G2L["52"]["TextWrapped"] = true;
G2L["52"]["TextStrokeTransparency"] = 0;
G2L["52"]["BorderSizePixel"] = 2;
G2L["52"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["52"]["TextSize"] = 14;
G2L["52"]["TextScaled"] = true;
G2L["52"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["52"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["52"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["52"]["Size"] = UDim2.new(0, 182, 0, 64);
G2L["52"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["52"]["Text"] = [[F3X]];
G2L["52"]["Position"] = UDim2.new(0.59583, 0, 0.02013, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton.LocalScript
G2L["53"] = Instance.new("LocalScript", G2L["52"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton
G2L["54"] = Instance.new("TextButton", G2L["3f"]);
G2L["54"]["TextWrapped"] = true;
G2L["54"]["TextStrokeTransparency"] = 0;
G2L["54"]["BorderSizePixel"] = 2;
G2L["54"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["54"]["TextSize"] = 14;
G2L["54"]["TextScaled"] = true;
G2L["54"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["54"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["54"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["54"]["Size"] = UDim2.new(0, 182, 0, 24);
G2L["54"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["54"]["Text"] = [[R6]];
G2L["54"]["Position"] = UDim2.new(0.59583, 0, 0.26846, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton.LocalScript
G2L["55"] = Instance.new("LocalScript", G2L["54"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton
G2L["56"] = Instance.new("TextButton", G2L["3f"]);
G2L["56"]["TextWrapped"] = true;
G2L["56"]["TextStrokeTransparency"] = 0;
G2L["56"]["BorderSizePixel"] = 2;
G2L["56"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["56"]["TextSize"] = 14;
G2L["56"]["TextScaled"] = true;
G2L["56"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["56"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["56"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["56"]["Size"] = UDim2.new(0, 182, 0, 24);
G2L["56"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["56"]["Text"] = [[System-Message Spam]];
G2L["56"]["Position"] = UDim2.new(0.59583, 0, 0.39262, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton.LocalScript
G2L["57"] = Instance.new("LocalScript", G2L["56"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton
G2L["58"] = Instance.new("TextButton", G2L["3f"]);
G2L["58"]["TextWrapped"] = true;
G2L["58"]["TextStrokeTransparency"] = 0;
G2L["58"]["BorderSizePixel"] = 2;
G2L["58"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["58"]["TextSize"] = 14;
G2L["58"]["TextScaled"] = true;
G2L["58"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["58"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["58"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["58"]["Size"] = UDim2.new(0, 182, 0, 24);
G2L["58"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["58"]["Text"] = [[Anti-Skid]];
G2L["58"]["Position"] = UDim2.new(0.59583, 0, 0.54362, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton.LocalScript
G2L["59"] = Instance.new("LocalScript", G2L["58"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton
G2L["5a"] = Instance.new("TextButton", G2L["3f"]);
G2L["5a"]["TextWrapped"] = true;
G2L["5a"]["TextStrokeTransparency"] = 0;
G2L["5a"]["BorderSizePixel"] = 2;
G2L["5a"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["5a"]["TextSize"] = 14;
G2L["5a"]["TextScaled"] = true;
G2L["5a"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["5a"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["5a"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["5a"]["Size"] = UDim2.new(0, 182, 0, 24);
G2L["5a"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["5a"]["Text"] = [[ServerMessage]];
G2L["5a"]["Position"] = UDim2.new(0.59583, 0, 0.67785, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton.LocalScript
G2L["5b"] = Instance.new("LocalScript", G2L["5a"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton
G2L["5c"] = Instance.new("TextButton", G2L["3f"]);
G2L["5c"]["TextWrapped"] = true;
G2L["5c"]["TextStrokeTransparency"] = 0;
G2L["5c"]["BorderSizePixel"] = 2;
G2L["5c"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["5c"]["TextSize"] = 14;
G2L["5c"]["TextScaled"] = true;
G2L["5c"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["5c"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["5c"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["5c"]["Size"] = UDim2.new(0, 182, 0, 44);
G2L["5c"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["5c"]["Text"] = [[Hint]];
G2L["5c"]["Position"] = UDim2.new(0.59583, 0, 0.8255, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton.LocalScript
G2L["5d"] = Instance.new("LocalScript", G2L["5c"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton
G2L["5e"] = Instance.new("TextButton", G2L["3f"]);
G2L["5e"]["TextWrapped"] = true;
G2L["5e"]["TextStrokeTransparency"] = 0;
G2L["5e"]["BorderSizePixel"] = 2;
G2L["5e"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["5e"]["TextSize"] = 14;
G2L["5e"]["TextScaled"] = true;
G2L["5e"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["5e"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["5e"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["5e"]["Size"] = UDim2.new(0, 67, 0, 44);
G2L["5e"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["5e"]["Text"] = [[Shutdown]];
G2L["5e"]["Position"] = UDim2.new(0.24167, 0, 0.8255, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton.LocalScript
G2L["5f"] = Instance.new("LocalScript", G2L["5e"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton
G2L["60"] = Instance.new("TextButton", G2L["3f"]);
G2L["60"]["TextWrapped"] = true;
G2L["60"]["TextStrokeTransparency"] = 0;
G2L["60"]["BorderSizePixel"] = 2;
G2L["60"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["60"]["TextSize"] = 14;
G2L["60"]["TextScaled"] = true;
G2L["60"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["60"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["60"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["60"]["Size"] = UDim2.new(0, 67, 0, 44);
G2L["60"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["60"]["Text"] = [[Billboard]];
G2L["60"]["Position"] = UDim2.new(0.42083, 0, 0.8255, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton.LocalScript
G2L["61"] = Instance.new("LocalScript", G2L["60"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.TextButton
G2L["62"] = Instance.new("TextButton", G2L["2"]);
G2L["62"]["TextWrapped"] = true;
G2L["62"]["TextStrokeTransparency"] = 0;
G2L["62"]["BorderSizePixel"] = 2;
G2L["62"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["62"]["TextSize"] = 14;
G2L["62"]["TextScaled"] = true;
G2L["62"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["62"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["62"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["62"]["Size"] = UDim2.new(0, 80, 0, 29);
G2L["62"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["62"]["Text"] = [[HD Admin Page]];
G2L["62"]["Position"] = UDim2.new(0.46367, 0, -1.03242, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.TextButton.LocalScript
G2L["63"] = Instance.new("LocalScript", G2L["62"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.scrept heb
G2L["64"] = Instance.new("Frame", G2L["2"]);
G2L["64"]["Visible"] = false;
G2L["64"]["BorderSizePixel"] = 2;
G2L["64"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["64"]["Size"] = UDim2.new(0, 480, 0, 298);
G2L["64"]["Position"] = UDim2.new(-0, 0, 1, 0);
G2L["64"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["64"]["Name"] = [[scrept heb]];


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.scrept heb.TextButton
G2L["65"] = Instance.new("TextButton", G2L["64"]);
G2L["65"]["TextWrapped"] = true;
G2L["65"]["TextStrokeTransparency"] = 0;
G2L["65"]["BorderSizePixel"] = 2;
G2L["65"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["65"]["TextSize"] = 14;
G2L["65"]["TextScaled"] = true;
G2L["65"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["65"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["65"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["65"]["Size"] = UDim2.new(0, 88, 0, 23);
G2L["65"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["65"]["Text"] = [[Grab Knife]];
G2L["65"]["Position"] = UDim2.new(0.01875, 0, 0.0302, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.scrept heb.TextButton.LocalScript
G2L["66"] = Instance.new("LocalScript", G2L["65"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.scrept heb.TextButton
G2L["67"] = Instance.new("TextButton", G2L["64"]);
G2L["67"]["TextWrapped"] = true;
G2L["67"]["TextStrokeTransparency"] = 0;
G2L["67"]["BorderSizePixel"] = 2;
G2L["67"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["67"]["TextSize"] = 14;
G2L["67"]["TextScaled"] = true;
G2L["67"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["67"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["67"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["67"]["Size"] = UDim2.new(0, 88, 0, 23);
G2L["67"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["67"]["Text"] = [[Gun]];
G2L["67"]["Position"] = UDim2.new(0.27083, 0, 0.0302, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.scrept heb.TextButton.LocalScript
G2L["68"] = Instance.new("LocalScript", G2L["67"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.scrept heb.TextButton
G2L["69"] = Instance.new("TextButton", G2L["64"]);
G2L["69"]["TextWrapped"] = true;
G2L["69"]["TextStrokeTransparency"] = 0;
G2L["69"]["BorderSizePixel"] = 2;
G2L["69"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["69"]["TextSize"] = 14;
G2L["69"]["TextScaled"] = true;
G2L["69"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["69"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["69"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["69"]["Size"] = UDim2.new(0, 88, 0, 23);
G2L["69"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["69"]["Text"] = [[John Doe]];
G2L["69"]["Position"] = UDim2.new(0.52708, 0, 0.0302, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.scrept heb.TextButton.LocalScript
G2L["6a"] = Instance.new("LocalScript", G2L["69"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.scrept heb.TextButton
G2L["6b"] = Instance.new("TextButton", G2L["64"]);
G2L["6b"]["TextWrapped"] = true;
G2L["6b"]["TextStrokeTransparency"] = 0;
G2L["6b"]["BorderSizePixel"] = 2;
G2L["6b"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["6b"]["TextSize"] = 14;
G2L["6b"]["TextScaled"] = true;
G2L["6b"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["6b"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["6b"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["6b"]["Size"] = UDim2.new(0, 88, 0, 23);
G2L["6b"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["6b"]["Text"] = [[Shedletsky ]];
G2L["6b"]["Position"] = UDim2.new(0.7875, 0, 0.0302, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.scrept heb.TextButton.LocalScript
G2L["6c"] = Instance.new("LocalScript", G2L["6b"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.scrept heb.TextButton
G2L["6d"] = Instance.new("TextButton", G2L["64"]);
G2L["6d"]["TextWrapped"] = true;
G2L["6d"]["TextStrokeTransparency"] = 0;
G2L["6d"]["BorderSizePixel"] = 2;
G2L["6d"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["6d"]["TextSize"] = 14;
G2L["6d"]["TextScaled"] = true;
G2L["6d"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["6d"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["6d"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["6d"]["Size"] = UDim2.new(0, 88, 0, 23);
G2L["6d"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["6d"]["Text"] = [[Roadblocks Spinning]];
G2L["6d"]["Position"] = UDim2.new(0.7875, 0, 0.15772, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.scrept heb.TextButton.LocalScript
G2L["6e"] = Instance.new("LocalScript", G2L["6d"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.scrept heb.TextButton
G2L["6f"] = Instance.new("TextButton", G2L["64"]);
G2L["6f"]["TextWrapped"] = true;
G2L["6f"]["TextStrokeTransparency"] = 0;
G2L["6f"]["BorderSizePixel"] = 2;
G2L["6f"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["6f"]["TextSize"] = 14;
G2L["6f"]["TextScaled"] = true;
G2L["6f"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["6f"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["6f"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["6f"]["Size"] = UDim2.new(0, 88, 0, 23);
G2L["6f"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["6f"]["Text"] = [[Obunga]];
G2L["6f"]["Position"] = UDim2.new(0.52708, 0, 0.15772, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.scrept heb.TextButton.LocalScript
G2L["70"] = Instance.new("LocalScript", G2L["6f"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.scrept heb.TextButton
G2L["71"] = Instance.new("TextButton", G2L["64"]);
G2L["71"]["TextWrapped"] = true;
G2L["71"]["TextStrokeTransparency"] = 0;
G2L["71"]["BorderSizePixel"] = 2;
G2L["71"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["71"]["TextSize"] = 14;
G2L["71"]["TextScaled"] = true;
G2L["71"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["71"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["71"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["71"]["Size"] = UDim2.new(0, 88, 0, 23);
G2L["71"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["71"]["Text"] = [[Toadroast]];
G2L["71"]["Position"] = UDim2.new(0.27083, 0, 0.15772, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.scrept heb.TextButton.LocalScript
G2L["72"] = Instance.new("LocalScript", G2L["71"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.scrept heb.TextButton
G2L["73"] = Instance.new("TextButton", G2L["64"]);
G2L["73"]["TextWrapped"] = true;
G2L["73"]["TextStrokeTransparency"] = 0;
G2L["73"]["BorderSizePixel"] = 2;
G2L["73"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["73"]["TextSize"] = 14;
G2L["73"]["TextScaled"] = true;
G2L["73"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["73"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["73"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["73"]["Size"] = UDim2.new(0, 88, 0, 23);
G2L["73"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["73"]["Text"] = [[Spookeh Skeleton]];
G2L["73"]["Position"] = UDim2.new(0.01875, 0, 0.15772, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.scrept heb.TextButton.LocalScript
G2L["74"] = Instance.new("LocalScript", G2L["73"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.scrept heb.TextButton
G2L["75"] = Instance.new("TextButton", G2L["64"]);
G2L["75"]["TextWrapped"] = true;
G2L["75"]["TextStrokeTransparency"] = 0;
G2L["75"]["BorderSizePixel"] = 2;
G2L["75"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["75"]["TextSize"] = 14;
G2L["75"]["TextScaled"] = true;
G2L["75"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["75"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["75"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["75"]["Size"] = UDim2.new(0, 209, 0, 132);
G2L["75"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["75"]["Text"] = [[Realm]];
G2L["75"]["Position"] = UDim2.new(0.01875, 0, 0.27517, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.scrept heb.TextButton.LocalScript
G2L["76"] = Instance.new("LocalScript", G2L["75"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.scrept heb.TextButton
G2L["77"] = Instance.new("TextButton", G2L["64"]);
G2L["77"]["TextWrapped"] = true;
G2L["77"]["TextStrokeTransparency"] = 0;
G2L["77"]["BorderSizePixel"] = 2;
G2L["77"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["77"]["TextSize"] = 14;
G2L["77"]["TextScaled"] = true;
G2L["77"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["77"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["77"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["77"]["Size"] = UDim2.new(0, 209, 0, 132);
G2L["77"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["77"]["Text"] = [[Retroslopers Fav Map]];
G2L["77"]["Position"] = UDim2.new(0.53542, 0, 0.27852, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.scrept heb.TextButton.LocalScript
G2L["78"] = Instance.new("LocalScript", G2L["77"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.TextButton
G2L["79"] = Instance.new("TextButton", G2L["2"]);
G2L["79"]["TextWrapped"] = true;
G2L["79"]["TextStrokeTransparency"] = 0;
G2L["79"]["BorderSizePixel"] = 2;
G2L["79"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["79"]["TextSize"] = 14;
G2L["79"]["TextScaled"] = true;
G2L["79"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["79"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["79"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["79"]["Size"] = UDim2.new(0, 80, 0, 29);
G2L["79"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["79"]["Text"] = [[Script Hub]];
G2L["79"]["Position"] = UDim2.new(0.27617, 0, -1.03242, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.TextButton.LocalScript
G2L["7a"] = Instance.new("LocalScript", G2L["79"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.TextButton
G2L["7b"] = Instance.new("TextButton", G2L["2"]);
G2L["7b"]["TextWrapped"] = true;
G2L["7b"]["TextStrokeTransparency"] = 0;
G2L["7b"]["BorderSizePixel"] = 2;
G2L["7b"]["TextStrokeColor3"] = Color3.fromRGB(103, 103, 103);
G2L["7b"]["TextSize"] = 14;
G2L["7b"]["TextScaled"] = true;
G2L["7b"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["7b"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["7b"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["7b"]["Size"] = UDim2.new(0, 80, 0, 29);
G2L["7b"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["7b"]["Text"] = [[Decals Tab]];
G2L["7b"]["Position"] = UDim2.new(0.09492, 0, -1.03242, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.TextButton.LocalScript
G2L["7c"] = Instance.new("LocalScript", G2L["7b"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab
G2L["7d"] = Instance.new("Frame", G2L["2"]);
G2L["7d"]["BorderSizePixel"] = 2;
G2L["7d"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["7d"]["Size"] = UDim2.new(0, 480, 0, 298);
G2L["7d"]["Position"] = UDim2.new(-0, 0, 1, 0);
G2L["7d"]["BorderColor3"] = Color3.fromRGB(86, 171, 255);
G2L["7d"]["Name"] = [[decal tab]];


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton
G2L["7e"] = Instance.new("ImageButton", G2L["7d"]);
G2L["7e"]["BorderSizePixel"] = 0;
G2L["7e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["7e"]["Image"] = [[rbxassetid://138177692150198]];
G2L["7e"]["Size"] = UDim2.new(0, 60, 0, 60);
G2L["7e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["7e"]["Position"] = UDim2.new(0.03542, 0, 0.02349, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton.LocalScript
G2L["7f"] = Instance.new("LocalScript", G2L["7e"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton
G2L["80"] = Instance.new("ImageButton", G2L["7d"]);
G2L["80"]["BorderSizePixel"] = 0;
G2L["80"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["80"]["Image"] = [[rbxassetid://125940566001256]];
G2L["80"]["Size"] = UDim2.new(0, 60, 0, 60);
G2L["80"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["80"]["Position"] = UDim2.new(0.18542, 0, 0.02349, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton.LocalScript
G2L["81"] = Instance.new("LocalScript", G2L["80"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton
G2L["82"] = Instance.new("ImageButton", G2L["7d"]);
G2L["82"]["BorderSizePixel"] = 0;
G2L["82"]["BackgroundTransparency"] = 1;
G2L["82"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["82"]["Image"] = [[rbxassetid://158118263]];
G2L["82"]["Size"] = UDim2.new(0, 60, 0, 60);
G2L["82"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["82"]["Position"] = UDim2.new(0.33125, 0, 0.02349, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton.LocalScript
G2L["83"] = Instance.new("LocalScript", G2L["82"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton
G2L["84"] = Instance.new("ImageButton", G2L["7d"]);
G2L["84"]["BorderSizePixel"] = 0;
G2L["84"]["BackgroundTransparency"] = 1;
G2L["84"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["84"]["Image"] = [[rbxassetid://109172666525942]];
G2L["84"]["Size"] = UDim2.new(0, 60, 0, 60);
G2L["84"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["84"]["Position"] = UDim2.new(0.48125, 0, 0.02349, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton.LocalScript
G2L["85"] = Instance.new("LocalScript", G2L["84"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton
G2L["86"] = Instance.new("ImageButton", G2L["7d"]);
G2L["86"]["BorderSizePixel"] = 0;
G2L["86"]["BackgroundTransparency"] = 1;
G2L["86"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["86"]["Image"] = [[rbxassetid://96464893839346]];
G2L["86"]["Size"] = UDim2.new(0, 60, 0, 60);
G2L["86"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["86"]["Position"] = UDim2.new(0.66458, 0, 0.02349, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton.LocalScript
G2L["87"] = Instance.new("LocalScript", G2L["86"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton
G2L["88"] = Instance.new("ImageButton", G2L["7d"]);
G2L["88"]["BorderSizePixel"] = 0;
G2L["88"]["BackgroundTransparency"] = 1;
G2L["88"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["88"]["Image"] = [[rbxassetid://108026156503677]];
G2L["88"]["Size"] = UDim2.new(0, 60, 0, 60);
G2L["88"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["88"]["Position"] = UDim2.new(0.83125, 0, 0.02349, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton.LocalScript
G2L["89"] = Instance.new("LocalScript", G2L["88"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton
G2L["8a"] = Instance.new("ImageButton", G2L["7d"]);
G2L["8a"]["BorderSizePixel"] = 0;
G2L["8a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["8a"]["Image"] = [[rbxassetid://103019090820445]];
G2L["8a"]["Size"] = UDim2.new(0, 60, 0, 60);
G2L["8a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["8a"]["Position"] = UDim2.new(0.03958, 0, 0.25503, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton.LocalScript
G2L["8b"] = Instance.new("LocalScript", G2L["8a"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton
G2L["8c"] = Instance.new("ImageButton", G2L["7d"]);
G2L["8c"]["BorderSizePixel"] = 0;
G2L["8c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["8c"]["Image"] = [[rbxassetid://138193061357271]];
G2L["8c"]["Size"] = UDim2.new(0, 60, 0, 60);
G2L["8c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["8c"]["Position"] = UDim2.new(0.18958, 0, 0.25503, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton.LocalScript
G2L["8d"] = Instance.new("LocalScript", G2L["8c"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton
G2L["8e"] = Instance.new("ImageButton", G2L["7d"]);
G2L["8e"]["BorderSizePixel"] = 0;
G2L["8e"]["BackgroundTransparency"] = 1;
G2L["8e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["8e"]["Image"] = [[rbxassetid://127419442544941]];
G2L["8e"]["Size"] = UDim2.new(0, 60, 0, 60);
G2L["8e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["8e"]["Position"] = UDim2.new(0.33542, 0, 0.25503, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton.LocalScript
G2L["8f"] = Instance.new("LocalScript", G2L["8e"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton
G2L["90"] = Instance.new("ImageButton", G2L["7d"]);
G2L["90"]["BorderSizePixel"] = 0;
G2L["90"]["BackgroundTransparency"] = 1;
G2L["90"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["90"]["Image"] = [[rbxassetid://110240864101518]];
G2L["90"]["Size"] = UDim2.new(0, 60, 0, 60);
G2L["90"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["90"]["Position"] = UDim2.new(0.48542, 0, 0.25503, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton.LocalScript
G2L["91"] = Instance.new("LocalScript", G2L["90"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton
G2L["92"] = Instance.new("ImageButton", G2L["7d"]);
G2L["92"]["BorderSizePixel"] = 0;
G2L["92"]["BackgroundTransparency"] = 1;
G2L["92"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["92"]["Image"] = [[rbxassetid://12851404448]];
G2L["92"]["Size"] = UDim2.new(0, 60, 0, 60);
G2L["92"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["92"]["Position"] = UDim2.new(0.66875, 0, 0.25503, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton.LocalScript
G2L["93"] = Instance.new("LocalScript", G2L["92"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton
G2L["94"] = Instance.new("ImageButton", G2L["7d"]);
G2L["94"]["BorderSizePixel"] = 0;
G2L["94"]["BackgroundTransparency"] = 1;
G2L["94"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["94"]["Image"] = [[rbxassetid://358313209]];
G2L["94"]["Size"] = UDim2.new(0, 60, 0, 60);
G2L["94"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["94"]["Position"] = UDim2.new(0.83542, 0, 0.25503, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton.LocalScript
G2L["95"] = Instance.new("LocalScript", G2L["94"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton
G2L["96"] = Instance.new("ImageButton", G2L["7d"]);
G2L["96"]["BorderSizePixel"] = 0;
G2L["96"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["96"]["Image"] = [[rbxassetid://382332426]];
G2L["96"]["Size"] = UDim2.new(0, 60, 0, 60);
G2L["96"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["96"]["Position"] = UDim2.new(0.03958, 0, 0.5, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton.LocalScript
G2L["97"] = Instance.new("LocalScript", G2L["96"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton
G2L["98"] = Instance.new("ImageButton", G2L["7d"]);
G2L["98"]["BorderSizePixel"] = 0;
G2L["98"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["98"]["Image"] = [[rbxassetid://7108680822]];
G2L["98"]["Size"] = UDim2.new(0, 60, 0, 60);
G2L["98"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["98"]["Position"] = UDim2.new(0.18958, 0, 0.5, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton.LocalScript
G2L["99"] = Instance.new("LocalScript", G2L["98"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton
G2L["9a"] = Instance.new("ImageButton", G2L["7d"]);
G2L["9a"]["BorderSizePixel"] = 0;
G2L["9a"]["BackgroundTransparency"] = 1;
G2L["9a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["9a"]["Image"] = [[rbxassetid://172423468]];
G2L["9a"]["Size"] = UDim2.new(0, 60, 0, 60);
G2L["9a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["9a"]["Position"] = UDim2.new(0.33542, 0, 0.5, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton.LocalScript
G2L["9b"] = Instance.new("LocalScript", G2L["9a"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton
G2L["9c"] = Instance.new("ImageButton", G2L["7d"]);
G2L["9c"]["BorderSizePixel"] = 0;
G2L["9c"]["BackgroundTransparency"] = 1;
G2L["9c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["9c"]["Image"] = [[rbxassetid://12025340162]];
G2L["9c"]["Size"] = UDim2.new(0, 60, 0, 60);
G2L["9c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["9c"]["Position"] = UDim2.new(0.48542, 0, 0.5, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton.LocalScript
G2L["9d"] = Instance.new("LocalScript", G2L["9c"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton
G2L["9e"] = Instance.new("ImageButton", G2L["7d"]);
G2L["9e"]["BorderSizePixel"] = 0;
G2L["9e"]["BackgroundTransparency"] = 1;
G2L["9e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["9e"]["Image"] = [[rbxassetid://157755295]];
G2L["9e"]["Size"] = UDim2.new(0, 60, 0, 60);
G2L["9e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["9e"]["Position"] = UDim2.new(0.66875, 0, 0.5, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton.LocalScript
G2L["9f"] = Instance.new("LocalScript", G2L["9e"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton
G2L["a0"] = Instance.new("ImageButton", G2L["7d"]);
G2L["a0"]["BorderSizePixel"] = 0;
G2L["a0"]["BackgroundTransparency"] = 1;
G2L["a0"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["a0"]["Image"] = [[rbxassetid://132408240384029]];
G2L["a0"]["Size"] = UDim2.new(0, 60, 0, 60);
G2L["a0"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["a0"]["Position"] = UDim2.new(0.83542, 0, 0.5, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton.LocalScript
G2L["a1"] = Instance.new("LocalScript", G2L["a0"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton
G2L["a2"] = Instance.new("ImageButton", G2L["7d"]);
G2L["a2"]["BorderSizePixel"] = 0;
G2L["a2"]["BackgroundTransparency"] = 1;
G2L["a2"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["a2"]["Image"] = [[rbxassetid://160456772]];
G2L["a2"]["Size"] = UDim2.new(0, 60, 0, 60);
G2L["a2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["a2"]["Position"] = UDim2.new(0.03958, 0, 0.74832, 0);


-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton.LocalScript
G2L["a3"] = Instance.new("LocalScript", G2L["a2"]);



-- StarterGui.ScreenGui.IMPORTANT WOOHOO.LocalScript
local function C_3()
local script = G2L["3"];
	local UserInputService = game:GetService("UserInputService")
	local RunService = game:GetService("RunService")
	
	local gui = script.Parent
	local DRAG_SPEED = 8
	
	local dragging = false
	local startPos
	local lastMousePos
	local lastGoalPos
	
	local function Lerp(a, b, m)
		return a + (b - a) * m
	end
	
	local function Update(dt)
		if not startPos then return end
	
		if not dragging and lastGoalPos then
			gui.Position = UDim2.new(
				startPos.X.Scale,
				Lerp(gui.Position.X.Offset, lastGoalPos.X.Offset, dt * DRAG_SPEED),
				startPos.Y.Scale,
				Lerp(gui.Position.Y.Offset, lastGoalPos.Y.Offset, dt * DRAG_SPEED)
			)
			return
		end
	
		if dragging then
			local delta = lastMousePos - UserInputService:GetMouseLocation()
			local xGoal = startPos.X.Offset - delta.X
			local yGoal = startPos.Y.Offset - delta.Y
	
			lastGoalPos = UDim2.new(startPos.X.Scale, xGoal, startPos.Y.Scale, yGoal)
	
			gui.Position = UDim2.new(
				startPos.X.Scale,
				Lerp(gui.Position.X.Offset, xGoal, dt * DRAG_SPEED),
				startPos.Y.Scale,
				Lerp(gui.Position.Y.Offset, yGoal, dt * DRAG_SPEED)
			)
		end
	end
	
	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 
			or input.UserInputType == Enum.UserInputType.Touch then
	
			dragging = true
			startPos = gui.Position
			lastMousePos = UserInputService:GetMouseLocation()
	
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	RunService.Heartbeat:Connect(Update)
	
end;
task.spawn(C_3);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.home.ImageLabel.LocalScript
local function C_6()
local script = G2L["6"];
	local Players = game:GetService("Players")
	local player = Players.LocalPlayer
	local imageLabel = script.Parent
	
	local function setProfileImage()
		local userId = player.UserId
		local thumbType = Enum.ThumbnailType.HeadShot
		local thumbSize = Enum.ThumbnailSize.Size420x420
	
		local content, isReady = Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)
		imageLabel.Image = content
	end
	
	setProfileImage()
	
end;
task.spawn(C_6);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.home.TextLabel.LocalScript
local function C_8()
local script = G2L["8"];
	local Players = game:GetService("Players")
	local player = Players.LocalPlayer
	local textLabel = script.Parent
	
	textLabel.Text = "Welcome " .. player.Name .. " to roadblocks F3X hub, have fun with the scripts i guess"
	
end;
task.spawn(C_8);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.home.TextLabel.LocalScript
local function C_a()
local script = G2L["a"];
	local textLabel = script.Parent
	local workspace = game:GetService("Workspace")
	
	local function updateText()
		local folder = workspace:FindFirstChild("HDAdminWorkspaceFolder")
	
		if folder and folder:IsA("Folder") then
			textLabel.Text = "HD ADMIN = yuh uh"
		else
			textLabel.Text = "HD ADMIN = nuh uh"
		end
	end
	
	updateText()
	
	workspace.ChildAdded:Connect(updateText)
	
	workspace.ChildRemoved:Connect(updateText)
	
end;
task.spawn(C_a);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.home.TextLabel.LocalScript
local function C_c()
local script = G2L["c"];
	local textLabel = script.Parent
	local Players = game:GetService("Players")
	local player = Players.LocalPlayer
	
	local function hasF3X()
		local backpack = player:FindFirstChild("Backpack")
		local character = player.Character
	
		if backpack and (backpack:FindFirstChild("Building Tools") or backpack:FindFirstChild("F3X")) then
			return true
		end
	
		if character and (character:FindFirstChild("Building Tools") or character:FindFirstChild("F3X")) then
			return true
		end
	
		return false
	end
	
	local function updateText()
		if hasF3X() then
			textLabel.Text = "F3X = yuh uh"
		else
			textLabel.Text = "F3X = nuh uh"
		end
	end
	
	while true do
		updateText()
		task.wait(0.1)
	end
	
end;
task.spawn(C_c);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.TextButton.LocalScript
local function C_10()
local script = G2L["10"];
	local button = script.Parent
	local main = button.Parent
	
	local savedState = {}
	local toggled = false
	
	button.MouseButton1Click:Connect(function()
	
		if not toggled then
			
			savedState = {}
	
			for _, obj in ipairs(main:GetDescendants()) do
				if obj:IsA("Frame") and obj.Name ~= "IMPORTANT WOOHOO" then
					savedState[obj] = obj.Visible
					obj.Visible = false
				end
			end
	
			toggled = true
	
		else
			
			for frame, wasVisible in pairs(savedState) do
				if frame then
					frame.Visible = wasVisible
				end
			end
	
			toggled = false
		end
	
	end)
	
end;
task.spawn(C_10);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton.LocalScript
local function C_13()
local script = G2L["13"];
	local button = script.Parent
	local textbox = script.Parent.Parent:WaitForChild("nugget")
	
	button.MouseButton1Click:Connect(function()
	
		local assetId = textbox.Text
		if assetId == "" then return end
	
		local Players = game:GetService("Players")
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local player = Players.LocalPlayer
	
		local tool
	
		local function findSyncAPITool()
			for _, v in pairs(player:GetDescendants()) do
				if v.Name == "SyncAPI" then
					return v.Parent
				end
			end
			for _, v in pairs(ReplicatedStorage:GetDescendants()) do
				if v.Name == "SyncAPI" then
					return v.Parent
				end
			end
		end
	
		tool = findSyncAPITool()
		if not tool then return end
	
		local remote = tool.SyncAPI.ServerEndpoint
		local function invoke(args)
			remote:InvokeServer(unpack(args))
		end
	
		local function SetLocked(part, boolean)
			invoke({ "SetLocked", { part }, boolean })
		end
	
		local function SpawnDecal(part, face)
			invoke({ "CreateTextures", { { Part = part, Face = face, TextureType = "Decal" } } })
		end
	
		local function AddDecal(part, assetId, face)
			invoke({ "SyncTexture", { { Part = part, Face = face, TextureType = "Decal", Texture = "rbxassetid://" .. assetId } } })
		end
	
		local function hasBlockedMesh(part)
			for _, child in ipairs(part:GetChildren()) do
				if child:IsA("SpecialMesh") or child:IsA("Mesh") then
					if tostring(child.MeshId):find("111891702759441") then
						return true
					end
				end
			end
			return false
		end
	
		local function SpamDecal(assetId)
			for _, v in pairs(workspace:GetDescendants()) do
				if v:IsA("BasePart") and not hasBlockedMesh(v) then
					task.spawn(function()
						SetLocked(v, false)
						for _, face in pairs(Enum.NormalId:GetEnumItems()) do
							SpawnDecal(v, face)
							AddDecal(v, assetId, face)
						end
					end)
				end
			end
		end
	
		SpamDecal(assetId)
	
	end)
	
end;
task.spawn(C_13);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton.LocalScript
local function C_15()
local script = G2L["15"];
	local button = script.Parent
	local textbox = script.Parent.Parent:WaitForChild("nugget")
	
	button.MouseButton1Click:Connect(function()
	
		local assetId = textbox.Text
		if assetId == "" then return end
	
		local player = game.Players.LocalPlayer
		local char = player.Character or player.CharacterAdded:Wait()
		local tool
	
		for i,v in player:GetDescendants() do
			if v.Name == "SyncAPI" then
				tool = v.Parent
			end
		end
	
		for i,v in game.ReplicatedStorage:GetDescendants() do
			if v.Name == "SyncAPI" then
				tool = v.Parent
			end
		end
	
		if not tool then return end
	
		local remote = tool.SyncAPI.ServerEndpoint
	
		function _(args)
			remote:InvokeServer(unpack(args))
		end
	
		function CreatePart(cf,parent)
			local args = {
				[1] = "CreatePart",
				[2] = "Normal",
				[3] = cf,
				[4] = parent
			}
			_(args)
		end
	
		function SetName(part, stringg)
			local args = {
				[1] = "SetName",
				[2] = { part },
				[3] = stringg
			}
			_(args)
		end
	
		function AddMesh(part)
			local args = {
				[1] = "CreateMeshes",
				[2] = {
					{
						Part = part
					}
				}
			}
			_(args)
		end
	
		function SetMesh(part,meshid)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					{
						Part = part,
						MeshId = "rbxassetid://"..meshid
					}
				}
			}
			_(args)
		end
	
		function SetTexture(part, texid)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					{
						Part = part,
						TextureId = "rbxassetid://"..texid
					}
				}
			}
			_(args)
		end
	
		function MeshResize(part,size)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					{
						Part = part,
						Scale = size
					}
				}
			}
			_(args)
		end
	
		function SetLocked(part,boolean)
			local args = {
				[1] = "SetLocked",
				[2] = { part },
				[3] = boolean
			}
			_(args)
		end
	
		function Sky(id)
			local e = char.HumanoidRootPart.CFrame.x
			local f = char.HumanoidRootPart.CFrame.y
			local g = char.HumanoidRootPart.CFrame.z
	
			CreatePart(
				CFrame.new(math.floor(e),math.floor(f),math.floor(g)) + Vector3.new(0,6,0),
				workspace
			)
	
			for i,v in game.Workspace:GetDescendants() do
				if v:IsA("BasePart") and v.CFrame.x == math.floor(e) and v.CFrame.z == math.floor(g) then
	
					SetName(v,"Sky")
					AddMesh(v)
	
					SetMesh(v,"111891702759441")
					SetTexture(v,assetId)
	
					MeshResize(v,Vector3.new(9000,9000,9000))
	
					SetLocked(v,true)
				end
			end
		end
	
		Sky(assetId)
	
	end)
	
end;
task.spawn(C_15);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton.LocalScript
local function C_17()
local script = G2L["17"];
	local button = script.Parent
	local textbox = script.Parent.Parent:WaitForChild("nugget")
	
	button.MouseButton1Click:Connect(function()
	
		local decalId = textbox.Text
		if decalId == "" then return end
	
		local Players = game:GetService("Players")
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RunService = game:GetService("RunService")
	
		local player = Players.LocalPlayer
		local tool
	
		for _, obj in ipairs(player:GetDescendants()) do
			if obj.Name == "SyncAPI" then
				tool = obj.Parent
				break
			end
		end
	
		if not tool then
			for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
				if obj.Name == "SyncAPI" then
					tool = obj.Parent
					break
				end
			end
		end
	
		if not tool then return end
		local SyncAPI = tool:WaitForChild("SyncAPI")
	
		local part
		local baseCF
		local rotX, rotY, rotZ = 0, 0, 0
		local connection
	
		local function call(args)
			SyncAPI:Invoke(unpack(args))
		end
	
		local function CreatePart(cf, parent)
			call({ "CreatePart", "Normal", cf, parent })
		end
	
		local function SetAnchor(p, anchored)
			call({ "SyncAnchor", {{ Part = p, Anchored = anchored }} })
		end
	
		local function AddMesh(p)
			call({ "CreateMeshes", {{ Part = p }} })
		end
	
		local function SetMesh(p, meshId, textureId)
			call({
				"SyncMesh",
				{{
					Part = p,
					MeshId = "rbxassetid://" .. meshId,
					TextureId = "rbxassetid://" .. textureId
				}}
			})
		end
	
		local function ResizeMesh(p, size)
			call({ "SyncMesh", {{ Part = p, Scale = size }} })
		end
	
		local function SetTransparency(p, value)
			call({ "SyncTransparency", {{ Part = p, Transparency = value }} })
		end
	
		local function SyncRotate(cf)
			if not part or not part.Parent then return end
			call({ "SyncRotate", {{ Part = part, CFrame = cf }} })
		end
	
		local function Sky()
			local startCF = CFrame.new(0, 100, 0)
			CreatePart(startCF, workspace)
	
			task.wait()
	
			for _, obj in ipairs(workspace:GetDescendants()) do
				if obj:IsA("BasePart") and (obj.Position - startCF.Position).Magnitude < 0.1 then
					part = obj
					baseCF = part.CFrame
	
					SetAnchor(part, true)
					AddMesh(part)
					SetMesh(part, "111891702759441", decalId)
					ResizeMesh(part, Vector3.new(9000, 9000, 9000))
					SetTransparency(part, 0)
	
					local speedX = math.rad(50)
					local speedY = math.rad(50)
					local speedZ = math.rad(50)
	
					connection = RunService.Heartbeat:Connect(function(dt)
						if not part or not part.Parent then
							if connection then
								connection:Disconnect()
								connection = nil
							end
							return
						end
	
						rotX = (rotX + speedX * dt) % (math.pi * 2)
						rotY = (rotY + speedY * dt) % (math.pi * 2)
						rotZ = (rotZ + speedZ * dt) % (math.pi * 2)
	
						local cf = baseCF * CFrame.Angles(rotX, rotY, rotZ)
						SyncRotate(cf)
						part.CFrame = cf
					end)
	
					break
				end
			end
		end
	
		Sky()
	
	end)
	
end;
task.spawn(C_17);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton.LocalScript
local function C_19()
local script = G2L["19"];
	local button = script.Parent
	local textbox = script.Parent.Parent:WaitForChild("nugget")
	
	button.MouseButton1Click:Connect(function()
	
		local texId = textbox.Text
		if texId == "" then return end
	
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
		RequestCommand:InvokeServer(";fogcolor black ;unfog ;time")
	
		task.wait(0.2)
	
		local player = game.Players.LocalPlayer
		local char = player.Character or player.CharacterAdded:Wait()
		local tool
	
		for _,v in ipairs(player:GetDescendants()) do
			if v.Name == "SyncAPI" then
				tool = v.Parent
				break
			end
		end
	
		if not tool then
			for _,v in ipairs(game.ReplicatedStorage:GetDescendants()) do
				if v.Name == "SyncAPI" then
					tool = v.Parent
					break
				end
			end
		end
	
		if not tool then return end
	
		local remote = tool.SyncAPI.ServerEndpoint
	
		local function _(args)
			remote:InvokeServer(unpack(args))
		end
	
		local function CreatePart(cf,parent)
			_({"CreatePart","Normal",cf,parent})
		end
	
		local function SetName(part,name)
			_({"SetName",{part},name})
		end
	
		local function AddMesh(part)
			_({"CreateMeshes",{{Part=part}}})
		end
	
		local function SetMesh(part,id)
			_({"SyncMesh",{{Part=part,MeshId="rbxassetid://"..id}}})
		end
	
		local function SetTexture(part,id)
			_({"SyncMesh",{{Part=part,TextureId="rbxassetid://"..id}}})
		end
	
		local function MeshResize(part,size)
			_({"SyncMesh",{{Part=part,Scale=size}}})
		end
	
		local function SetVertexColor(part,vec)
			_({"SyncMesh",{{Part=part,VertexColor=vec}}})
		end
	
		local function SetLocked(part,bool)
			_({"SetLocked",{part},bool})
		end
	
		local function SetMaterial(part,mat)
			_({"SyncMaterial",{{Part=part,Material=mat}}})
		end
	
		local function SetCollision(part,bool)
			_({"SyncCollision",{{Part=part,CanCollide=bool}}})
		end
	
		local function CreatePointLight(part)
			_({"CreateLights",{{Part=part,LightType="PointLight"}}})
		end
	
		local function SyncPointLight(part,brightness,range)
			_({"SyncLighting",{{Part=part,LightType="PointLight",Brightness=brightness,Range=range}}})
		end
	
		local function Sky(texId)
			local pos = Vector3.new(0,100,0)
	
			CreatePart(CFrame.new(pos),workspace)
	
			for _,v in ipairs(workspace:GetDescendants()) do
				if v:IsA("BasePart")
					and not v:IsDescendantOf(char)
					and math.floor(v.Position.X) == 0
					and math.floor(v.Position.Y) == 100
					and math.floor(v.Position.Z) == 0 then
	
					SetName(v,"Sky")
					AddMesh(v)
					SetMesh(v,"111891702759441")
					SetTexture(v,texId)
					MeshResize(v,Vector3.new(99999,99999,99999))
					SetVertexColor(v,Vector3.new(4,4,4))
					SetMaterial(v,"Neon")
					SetCollision(v,false)
					CreatePointLight(v)
					SyncPointLight(v,5,8)
					SetLocked(v,true)
				end
			end
		end
	
		Sky(texId)
	
	end)
	
end;
task.spawn(C_19);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton.LocalScript
local function C_1b()
local script = G2L["1b"];
	local button = script.Parent
	local textbox = script.Parent.Parent:WaitForChild("nugget")
	
	button.MouseButton1Click:Connect(function()
	
		local textureId = textbox.Text
		if textureId == "" then return end
	
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
		RequestCommand:InvokeServer(";fogcolor black ;unfog ;time")
	
		task.wait(0.2)
	
		local Players = game:GetService("Players")
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RunService = game:GetService("RunService")
	
		local player = Players.LocalPlayer
		local tool
	
		for _, obj in ipairs(player:GetDescendants()) do
			if obj.Name == "SyncAPI" then
				tool = obj.Parent
				break
			end
		end
	
		if not tool then
			for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
				if obj.Name == "SyncAPI" then
					tool = obj.Parent
					break
				end
			end
		end
	
		if not tool then return end
		local SyncAPI = tool:WaitForChild("SyncAPI")
	
		local part
		local baseCF
		local rotX, rotY, rotZ = 0, 0, 0
		local connection
	
		local function call(args)
			SyncAPI:Invoke(unpack(args))
		end
	
		local function CreatePart(cf, parent)
			call({ "CreatePart", "Normal", cf, parent })
		end
	
		local function SetAnchor(p, anchored)
			call({ "SyncAnchor", {{ Part = p, Anchored = anchored }} })
		end
	
		local function AddMesh(p)
			call({ "CreateMeshes", {{ Part = p }} })
		end
	
		local function SetMesh(p, meshId, textureId)
			call({
				"SyncMesh",
				{{
					Part = p,
					MeshId = "rbxassetid://" .. meshId,
					TextureId = "rbxassetid://" .. textureId
				}}
			})
		end
	
		local function ResizeMesh(p, size)
			call({ "SyncMesh", {{ Part = p, Scale = size }} })
		end
	
		local function SetTransparency(p, value)
			call({ "SyncTransparency", {{ Part = p, Transparency = value }} })
		end
	
		local function SetMaterial(p, mat)
			call({ "SyncMaterial", {{ Part = p, Material = mat }} })
		end
	
		local function SetVertexColor(p, vec)
			call({ "SyncMesh", {{ Part = p, VertexColor = vec }} })
		end
	
		local function CreatePointLight(p)
			call({ "CreateLights", {{ Part = p, LightType = "PointLight" }} })
		end
	
		local function SyncPointLight(p, brightness, range)
			call({
				"SyncLighting",
				{{
					Part = p,
					LightType = "PointLight",
					Brightness = brightness,
					Range = range
				}}
			})
		end
	
		local function SyncRotate(cf)
			if not part or not part.Parent then return end
			call({ "SyncRotate", {{ Part = part, CFrame = cf }} })
		end
	
		local function Sky()
			local startCF = CFrame.new(0, 100, 0)
			CreatePart(startCF, workspace)
	
			task.wait()
	
			for _, obj in ipairs(workspace:GetDescendants()) do
				if obj:IsA("BasePart") and (obj.Position - startCF.Position).Magnitude < 0.1 then
					part = obj
					baseCF = part.CFrame
	
					SetAnchor(part, true)
					AddMesh(part)
					SetMesh(part, "111891702759441", textureId)
					ResizeMesh(part, Vector3.new(99999, 99999, 99999))
					SetVertexColor(part, Vector3.new(4, 4, 4))
					SetMaterial(part, "Neon")
					SetTransparency(part, 0)
	
					CreatePointLight(part)
					SyncPointLight(part, 5, 8)
	
					local speedX = math.rad(50)
					local speedY = math.rad(50)
					local speedZ = math.rad(50)
	
					connection = RunService.Heartbeat:Connect(function(dt)
						if not part or not part.Parent then
							if connection then
								connection:Disconnect()
								connection = nil
							end
							return
						end
	
						rotX = (rotX + speedX * dt) % (math.pi * 2)
						rotY = (rotY + speedY * dt) % (math.pi * 2)
						rotZ = (rotZ + speedZ * dt) % (math.pi * 2)
	
						local cf = baseCF * CFrame.Angles(rotX, rotY, rotZ)
						SyncRotate(cf)
						part.CFrame = cf
					end)
	
					break
				end
			end
		end
	
		Sky()
	
	end)
	
end;
task.spawn(C_1b);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton.LocalScript
local function C_1d()
local script = G2L["1d"];
	local button = script.Parent
	local textbox = script.Parent.Parent:WaitForChild("nugget")
	
	button.MouseButton1Click:Connect(function()
	
		local decalId = textbox.Text
		if decalId == "" then return end
	
		local player = game.Players.LocalPlayer
		local char = player.Character or player.CharacterAdded:Wait()
		local tool
	
		for i,v in player:GetDescendants() do
			if v.Name == "SyncAPI" then
				tool = v.Parent
			end
		end
	
		for i,v in game.ReplicatedStorage:GetDescendants() do
			if v.Name == "SyncAPI" then
				tool = v.Parent
			end
		end
	
		if not tool then return end
	
		local remote = tool.SyncAPI.ServerEndpoint
	
		function _(args)
			remote:InvokeServer(unpack(args))
		end
	
		function CreatePart(cf,parent)
			_({"CreatePart","Normal",cf,parent})
		end
	
		function SetName(part,name)
			_({"SetName",{part},name})
		end
	
		function Resize(part,size,cf)
			_({"SyncResize",{{Part=part,CFrame=cf,Size=size}}})
		end
	
		function MovePart(part,cf)
			_({"SyncMove",{{Part=part,CFrame=cf}}})
		end
	
		function SetLocked(part,boolean)
			_({"SetLocked",{part},boolean})
		end
	
		function SetTrans(part,int)
			_({"SyncMaterial",{{Part=part,Transparency=int}}})
		end
	
		function SpawnDecal(part,side)
			_({"CreateTextures",{{Part=part,Face=side,TextureType="Decal"}}})
		end
	
		function AddDecal(part,asset,side)
			_({"SyncTexture",{{Part=part,Face=side,TextureType="Decal",Texture="rbxassetid://"..asset}}})
		end
	
		while wait(0.1) do
			spawn(function()
	
				local e = char.HumanoidRootPart.CFrame.x + math.random(-100, 100)
				local f = char.HumanoidRootPart.CFrame.y
				local g = char.HumanoidRootPart.CFrame.z + math.random(-100, 100)
	
				CreatePart(CFrame.new(math.floor(e), math.floor(f), math.floor(g)) + Vector3.new(0,6,0), workspace)
	
				for i,v in game.Workspace:GetDescendants() do
					if v:IsA("BasePart") and v.CFrame.x == math.floor(e) and v.CFrame.z == math.floor(g) then
	
						SetName(v,"particle")
	
						SpawnDecal(v,Enum.NormalId.Front)
						AddDecal(v,decalId,Enum.NormalId.Front)
	
						SpawnDecal(v,Enum.NormalId.Back)
						AddDecal(v,decalId,Enum.NormalId.Back)
	
						SetTrans(v,1)
						Resize(v,Vector3.new(7,7,0.1),v.CFrame)
						SetLocked(v,true)
	
						while wait(0.01) do
							MovePart(v,CFrame.new(v.CFrame.x,v.CFrame.y + 3,v.CFrame.z))
						end
	
					end
				end
	
			end)
		end
	
	end)
	
end;
task.spawn(C_1d);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.ImageLabel.LocalScript
local function C_1f()
local script = G2L["1f"];
	local imageLabel = script.Parent
	local textbox = imageLabel.Parent:WaitForChild("nugget")
	
	local function updateImage()
		local id = textbox.Text
	
		if id ~= "" then
	
			if not string.find(id, "rbxassetid://") then
				id = "rbxassetid://" .. id
			end
	
			imageLabel.Image = id
		end
	end
	
	
	textbox:GetPropertyChangedSignal("Text"):Connect(updateImage)
	
	
	updateImage()
	
end;
task.spawn(C_1f);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton.LocalScript
local function C_22()
local script = G2L["22"];
	--made by myself, NO ONE ELSE!!!!
	
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
	
		local Players = game:GetService("Players")
		local RunService = game:GetService("RunService")
	
		local player = Players.LocalPlayer
		local char = player.Character or player.CharacterAdded:Wait()
	
		local tool
		for _, v in ipairs(player:GetDescendants()) do
			if v.Name == "SyncAPI" then
				tool = v.Parent
				break
			end
		end
	
		if not tool then
			for _, v in ipairs(game.ReplicatedStorage:GetDescendants()) do
				if v.Name == "SyncAPI" then
					tool = v.Parent
					break
				end
			end
		end
	
		if not tool then return end
	
		local remote = tool.SyncAPI.ServerEndpoint
	
		local head = char:WaitForChild("Head")
		local headMesh = head:FindFirstChildWhichIsA("SpecialMesh")
		if not headMesh then return end
	
		local hats = {}
		for _, acc in ipairs(char:GetChildren()) do
			if acc:IsA("Accessory") and acc:FindFirstChild("Handle") then
				local mesh = acc.Handle:FindFirstChildWhichIsA("SpecialMesh")
				if mesh then
					table.insert(hats, {Part = acc.Handle, MeshId = mesh.MeshId})
				end
			end
		end
	
		local t = 0
	
		RunService.RenderStepped:Connect(function(dt)
			t += dt * 6
			local offset = math.sin(t) * 0.7
	
			local partsToSync = {
				{Part = head, MeshId = headMesh.MeshId, Offset = Vector3.new(offset, 0, 0)}
			}
	
			for _, h in ipairs(hats) do
				table.insert(partsToSync, {Part = h.Part, MeshId = h.MeshId, Offset = Vector3.new(offset, 0, 0)})
			end
	
			remote:InvokeServer("SyncMesh", partsToSync)
		end)
	
	end)
	
end;
task.spawn(C_22);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton.LocalScript
local function C_24()
local script = G2L["24"];
	--elv4r0x did this, credits to him!!
	
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	
	local button = script.Parent
	local player = Players.LocalPlayer
	
	button.MouseButton1Click:Connect(function()
	
		local char = player.Character or player.CharacterAdded:Wait()
		local hum = char:WaitForChild("Humanoid")
	
		local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
		if not torso then return end
	
		local larm = char:FindFirstChild("Left Arm") or char:FindFirstChild("LeftUpperArm")
		local rarm = char:FindFirstChild("Right Arm") or char:FindFirstChild("RightUpperArm")
		if not larm or not rarm then return end
	
		local tool = char:FindFirstChildOfClass("Tool")
		if not tool then
			for _, v in ipairs(player.Backpack:GetChildren()) do
				if v:IsA("Tool") then
					tool = v
					break
				end
			end
		end
	
		if tool then
			hum:EquipTool(tool)
			task.wait()
			hum:UnequipTools()
		end
	
		local server = tool
			and tool:FindFirstChild("SyncAPI")
			and tool.SyncAPI:FindFirstChild("ServerEndpoint")
	
		local idleAngles = Vector3.new(0,0,math.rad(-90))
		local flapAmplitude = Vector3.new(0, 0, math.rad(40))
		local flapSpeed = 14
	
		RunService.RenderStepped:Connect(function()
	
			local time = tick()
			local flapX = math.sin(time * flapSpeed) * flapAmplitude.X
			local flapY = math.sin(time * flapSpeed * 0.8) * flapAmplitude.Y
			local flapZ = math.sin(time * flapSpeed * 0.6) * flapAmplitude.Z
	
			local targetL
			local targetR
	
			if hum.MoveDirection.Magnitude == 0 then  
				targetL = torso.CFrame * CFrame.new(-1.9,0.5,0) * CFrame.Angles(idleAngles.X, idleAngles.Y, idleAngles.Z)  
				targetR = torso.CFrame * CFrame.new(1.9,0.5,0) * CFrame.Angles(-idleAngles.X, -idleAngles.Y, -idleAngles.Z)  
			else  
				targetL = torso.CFrame * CFrame.new(-1.9,0.5,0) * CFrame.Angles(flapX, flapY, idleAngles.Z + flapZ)  
				targetR = torso.CFrame * CFrame.new(1.9,0.5,0) * CFrame.Angles(-flapX, -flapY, -idleAngles.Z - flapZ)  
			end  
	
			larm.CFrame = targetL
			rarm.CFrame = targetR
	
			if server then
				server:InvokeServer("SyncMove", {{Part = larm, CFrame = larm.CFrame}})
				server:InvokeServer("SyncMove", {{Part = rarm, CFrame = rarm.CFrame}})
			end
	
		end)
	
	end)
	
end;
task.spawn(C_24);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton.LocalScript
local function C_26()
local script = G2L["26"];
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
	
		local Players = game:GetService("Players")
		local RunService = game:GetService("RunService")
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
	
		local player = Players.LocalPlayer
	
		local function getChar()
			local char = player.Character or player.CharacterAdded:Wait()
			return char, char:WaitForChild("HumanoidRootPart")
		end
	
		local tool
		for _,v in ipairs(player:GetDescendants()) do
			if v.Name == "SyncAPI" then
				tool = v.Parent
				break
			end
		end
	
		if not tool then
			for _,v in ipairs(ReplicatedStorage:GetDescendants()) do
				if v.Name == "SyncAPI" then
					tool = v.Parent
					break
				end
			end
		end
	
		if not tool then return end
	
		local remote = tool.SyncAPI.ServerEndpoint
	
		local function invoke(args)
			remote:InvokeServer(unpack(args))
		end
	
		local function CreatePart(cf,parent)
			invoke({"CreatePart","Ball",cf,parent})
		end
	
		local function MovePart(part,cf)
			invoke({"SyncMove",{{Part=part,CFrame=cf}}})
		end
	
		local function Resize(part,size,cf)
			invoke({"SyncResize",{{Part=part,Size=size,CFrame=cf}}})
		end
	
		local function SetAnchor(bool,part)
			invoke({"SyncAnchor",{{Part=part,Anchored=bool}}})
		end
	
		local function SetCollision(part,bool)
			invoke({"SyncCollision",{{Part=part,CanCollide=bool}}})
		end
	
		local function SetName(part,name)
			invoke({"SetName",{part},name})
		end
	
		local function Color(part,color)
			invoke({"SyncColor",{{Part=part,Color=color,UnionColoring=false}}})
		end
	
		local function AddFire(part,size,color,color2,heat)
			invoke({
				"CreateDecorations",
				{
					{
						Part = part,
						DecorationType = "Fire"
					}
				}
			})
	
			invoke({
				"SyncDecorate",
				{
					{
						Part = part,
						DecorationType = "Fire",
						Size = size,
						Heat = heat,
						Color = color,
						SecondaryColor = color2
					}
				}
			})
		end
	
		local orbitConnection
	
		local function createOrbitBall()
	
			local char, hrp = getChar()
	
			local radius = 5
			local verticalAmplitude = 3
			local speed = math.rad(100)
			local angle = 0
	
			local initialCF = hrp.CFrame * CFrame.new(radius, -0.1, 0)
	
			CreatePart(initialCF, workspace)
	
			local ball
	
			repeat task.wait()
				for _,v in ipairs(workspace:GetDescendants()) do
					if v:IsA("BasePart") and (v.Position - initialCF.Position).Magnitude < 0.1 then
						ball = v
						break
					end
				end
			until ball
	
			SetName(ball,"Hello everyone my name is welcome")
			Resize(ball,Vector3.new(0.9,0.9,0.9),initialCF)
			Color(ball,Color3.new(0,0,0))
			SetAnchor(true,ball)
			SetCollision(ball,false)
	
			AddFire(ball,0.5,Color3.new(0,0,0),Color3.new(0,0,0),15)
	
			if orbitConnection then
				orbitConnection:Disconnect()
			end
	
			orbitConnection = RunService.Heartbeat:Connect(function(dt)
	
				if not hrp.Parent then return end
	
				angle += dt * speed
	
				local x = math.cos(angle) * radius
				local z = math.sin(angle) * radius
				local y = 2 + math.sin(angle*2) * verticalAmplitude
	
				local pos = hrp.Position + Vector3.new(x,y,z)
	
				local lookDir = Vector3.new(
					-math.sin(angle),
					math.cos(angle*2)*0.1,
					math.cos(angle)
				)
	
				local newCF = CFrame.new(pos,pos + lookDir)
	
				MovePart(ball,newCF)
	
			end)
	
		end
	
		createOrbitBall()
	
		player.CharacterAdded:Connect(function()
			task.wait(1)
			createOrbitBall()
		end)
	
	end)
	
end;
task.spawn(C_26);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton.LocalScript
local function C_28()
local script = G2L["28"];
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
	
		local player = game.Players.LocalPlayer
		local char = player.Character or player.CharacterAdded:Wait()
	
		local tool
	
		for _, v in ipairs(player:GetDescendants()) do
			if v.Name == "SyncAPI" then
				tool = v.Parent
				break
			end
		end
	
		if not tool then
			for _, v in ipairs(game.ReplicatedStorage:GetDescendants()) do
				if v.Name == "SyncAPI" then
					tool = v.Parent
					break
				end
			end
		end
	
		if not tool then return end
	
		local remote = tool.SyncAPI.ServerEndpoint
	
		local function invoke(args)
			remote:InvokeServer(unpack(args))
		end
	
		local function CreatePart(cf, parent, types)
			invoke({
				"CreatePart",
				types or "Normal",
				cf,
				parent
			})
		end
	
		local function Resize(part, size, cf)
			invoke({
				"SyncResize",
				{
					{
						Part = part,
						CFrame = cf,
						Size = size
					}
				}
			})
		end
	
		local function MovePart(part, cf)
			invoke({
				"SyncMove",
				{
					{
						Part = part,
						CFrame = cf
					}
				}
			})
		end
	
		local function Color(part, color)
			invoke({
				"SyncColor",
				{
					{
						Part = part,
						Color = color,
						UnionColoring = false
					}
				}
			})
		end
	
		local function SetCollision(part, boolean)
			invoke({
				"SyncCollision",
				{
					{
						Part = part,
						CanCollide = boolean
					}
				}
			})
		end
	
		local function SetLocked(part, boolean)
			invoke({
				"SetLocked",
				{part},
				boolean
			})
		end
	
		local hrp = char:WaitForChild("HumanoidRootPart")
	
		local padPos = hrp.CFrame * CFrame.new(0, -3.5, 0)
		CreatePart(padPos, workspace, "Cylinder")
	
		task.wait(0.2)
	
		local floatingPad
	
		for _, v in ipairs(workspace:GetDescendants()) do
			if v:IsA("BasePart")
				and (v.Position - padPos.Position).Magnitude < 3 then
	
				floatingPad = v
	
				Resize(floatingPad, Vector3.new(0.5, 8, 8), padPos * CFrame.Angles(0, 0, math.rad(90)))
				Color(floatingPad, Color3.fromRGB(107, 50, 124))
				SetCollision(floatingPad, true)
				SetLocked(floatingPad, true)
	
				break
			end
		end
	
		if floatingPad then
	
			local RunService = game:GetService("RunService")
	
			RunService.Heartbeat:Connect(function()
	
				if not hrp.Parent then return end
	
				local targetPos = hrp.CFrame * CFrame.new(0, -3.5, 0)
	
				MovePart(
					floatingPad,
					targetPos * CFrame.Angles(0, 0, math.rad(90))
				)
	
			end)
	
		end
	
	end)
	
end;
task.spawn(C_28);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton.LocalScript
local function C_2a()
local script = G2L["2a"];
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
	
		function nob(who,tra,hat)
			c=who.Character
			pcall(function()u=c["Body Colors"]
				u.HeadColor=BrickColor.new("Black")
				u.LeftLegColor=BrickColor.new("Black")
				u.RightLegolor=BrickColor.new("Black")
				u.LeftArmColor=BrickColor.new("Black")
				u.TorsoColor=BrickColor.new("Black")
				u.RightArmColor=BrickColor.new("Black")
			end)
			pcall(function()c.Shirt:Destroy() c.Pants:Destroy() end)
			for i,v in pairs(c:GetChildren()) do
				if v:IsA("BasePart") then
					v.Transparency=tra
					if v.Name=="HumanoidRootPart" or v.Name=="Head" then
						v.Transparency=1
					end
					wait()
					v.BrickColor=BrickColor.new("Black")
				elseif v:IsA("Hat") then
					v:Destroy()
				end
			end
			xx=game:service("InsertService"):LoadAsset(hat)
			xy=game:service("InsertService"):LoadAsset(47433)["LinkedSword"]
			xy.Parent=who.Backpack
			for a,hat in pairs(xx:children()) do
				hat.Parent=c
			end
			xx:Destroy()
			h=who.Character.Humanoid
			h.MaxHealth=50000
			wait(1.5)
			h.Health=50000
			h.WalkSpeed=32
		end
		nob(game.Players.LocalPlayer,0.6,21070012)
	
	end)
	
end;
task.spawn(C_2a);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton.LocalScript
local function C_2c()
local script = G2L["2c"];
	local button = script.Parent
	local player = game.Players.LocalPlayer
	
	button.MouseButton1Click:Connect(function()
		local char = player.Character or player.CharacterAdded:Wait()
		local humanoid = char:WaitForChild("Humanoid")
	
		humanoid.WalkSpeed = 50
	end)
	
end;
task.spawn(C_2c);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton.LocalScript
local function C_2e()
local script = G2L["2e"];
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
	
		local Players = game:GetService("Players")
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
	
		local player = Players.LocalPlayer
		local char = player.Character or player.CharacterAdded:Wait()
	
		local tool
		for _, v in ipairs(player:GetDescendants()) do
			if v.Name == "SyncAPI" then
				tool = v.Parent
				break
			end
		end
	
		if not tool then
			for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
				if v.Name == "SyncAPI" then
					tool = v.Parent
					break
				end
			end
		end
	
		if not tool then return end
	
		local remote = tool.SyncAPI.ServerEndpoint
	
		local function invoke(args)
			remote:InvokeServer(unpack(args))
		end
	
		local presets = {
			"Bright red",
			"Bright yellow",
			"Bright orange",
			"Bright violet",
			"Bright blue",
			"Bright bluish green",
			"Bright green"
		}
	
		local running = true
	
		task.spawn(function()
			while running and player.Parent do
				task.wait(0.5)
	
				char = player.Character
				if not char then continue end
	
				local function randomColor()
					return BrickColor.new(presets[math.random(1,#presets)]).Color
				end
	
				invoke({
					"SyncColor",
					{
						{Color=randomColor(), Part=char:FindFirstChild("Head"), UnionColoring=true},
						{Color=randomColor(), Part=char:FindFirstChild("HumanoidRootPart"), UnionColoring=true},
						{Color=randomColor(), Part=char:FindFirstChild("Left Arm") or char:FindFirstChild("LeftUpperArm"), UnionColoring=true},
						{Color=randomColor(), Part=char:FindFirstChild("Right Leg") or char:FindFirstChild("RightUpperLeg"), UnionColoring=true},
						{Color=randomColor(), Part=char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso"), UnionColoring=true},
						{Color=randomColor(), Part=char:FindFirstChild("Right Arm") or char:FindFirstChild("RightUpperArm"), UnionColoring=true},
						{Color=randomColor(), Part=char:FindFirstChild("Left Leg") or char:FindFirstChild("LeftUpperLeg"), UnionColoring=true}
					}
				})
	
			end
		end)
	
	end)
	
end;
task.spawn(C_2e);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton.LocalScript
local function C_30()
local script = G2L["30"];
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		print("a")
	end)
end;
task.spawn(C_30);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton.LocalScript
local function C_32()
local script = G2L["32"];
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
	
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommandSilent = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommandSilent:InvokeServer(";time 14")
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
		local player = game.Players.LocalPlayer
		local char = player.Character
		local backpack = player.Backpack
	
		local Players = game:GetService("Players")
		local player = Players.LocalPlayer
	
		local character = player.Character or player.CharacterAdded:Wait()
	
		local storedCharacter = character
		local originalParent = storedCharacter.Parent
	
		storedCharacter.Parent = nil
	
		local player = game.Players.LocalPlayer
		local char = player.Character
		local backpack = player.Backpack
	
		local function getf3x()
			for _, v in ipairs(backpack:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
			for _, v in ipairs(char:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
	
			return nil
		end
	
		-- get all info
	
		local f3x = getf3x()
		if not f3x then
			warn("you dont have f3x skid")
		end
		local syncapi = f3x.SyncAPI
		local serverendpoint = syncapi.ServerEndpoint
	
		local function delete(part)
			local args = {
				[1] = "Remove",
				[2] = {
					[1] = part
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
	
		local function deleteall()
			for _, v in ipairs(workspace:GetDescendants()) do
				if v:IsA("BasePart") or v:IsA("UnionOperation") then
					spawn(function()
						delete(v)
					end)
				end
			end
		end
	
		deleteall()
	
		local function getf3x()
			for _, v in ipairs(backpack:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
			for _, v in ipairs(char:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
			return nil
		end
	
		local f3x = getf3x()
		if not f3x then
			warn("you dont have f3x skid")
		end
		local syncapi = f3x.SyncAPI
		local serverendpoint = syncapi.ServerEndpoint
	
		function _(args)
			serverendpoint:InvokeServer(unpack(args))
		end
	
		local function addlight(part, brightness)
			local args = {
				[1] = "CreateLights",
				[2] = {
					[1] = {
						["Part"] = part,
						["LightType"] = "PointLight"
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
	
		local function synclight(part, brightness)
			local args = {
				[1] = "SyncLighting",
				[2] = {
					[1] = {
						["Part"] = part,
						["LightType"] = "PointLight",
						["Range"] = 60,
						["Color"] = Color3.new(1, 0, 0)
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
	
		local function fire(part) 
	
			local argsCreate = {
				[1] = "CreateDecorations",
				[2] = {
					[1] = {
						["Part"] = part,
						["DecorationType"] = "Fire"
					}
				}
			}
	
	
			local argsSync = {
				[1] = "SyncDecorate",
				[2] = {
					[1] = {
						["Part"] = part,
						["DecorationType"] = "Fire",
						["Size"] = 30,
						["Heat"] = 9,
						["Color"] = Color3.fromRGB(255, 0, 0), 
						["SecondaryColor"] = Color3.fromRGB(255, 0, 0) 
					} 
				} 
			}
	
	
			_(argsCreate)
			_(argsSync)
		end
		function MovePart(part, cf)
			local args = {
				"SyncMove",
				{
					{
						Part = part,
						CFrame = cf
					}
				}
			}
			_(args)
		end
	
		local function resize(part, size, cf)
			local args = {
				"SyncResize",
				{
					{
						Part = part,
						CFrame = cf,
						Size = size
					}
				}
			}
			_(args)
		end
	
		function SetTrans(part,int)
			local args = {
				[1] = "SyncMaterial",
				[2] = {
					[1] = {
						["Part"] = part,
						["Transparency"] = int
					}
				}
			}
			_(args)
		end
	
		local function mat(part, mate)
			local args = {
				"SyncMaterial",
				{
					{
						Part = part,
						Material = mate
					}
				}
			}
			_(args)
		end
	
		local function transparency(part, trans)
			local args = {
				"SyncMaterial",
				{
					{
						Part = part,
						Transparency = trans
					}
				}
			}
			_(args)
		end
	
		local function color(part, color)
			local args = {
				"SyncColor",
				{
					{
						Part = part,
						Color = color,
						UnionColoring = false
					}
				}
			}
			_(args)
		end
	
		local function syncmeshid(part, id)
			local args = {
				"SyncMesh",
				{
					{
						Part = part,
						MeshId = "rbxassetid://" .. id
					}
				}
			}
			_(args)
		end
	
		local function makemesh(part)
			local args = {
				"CreateMeshes",
				{
					{
						Part = part
					}
				}
			}
			_(args)
		end
	
		local function syncmeshsize(part, vectora)
			local args = {
				"SyncMesh",
				{
					{
						Part = part,
						Scale = vectora
					}
				}
			}
			_(args)
		end
	
		local function syncmeshtexture(part, id)
			local args = {
				"SyncMesh",
				{
					{
						Part = part,
						TextureId = "rbxassetid://" .. id
					}
				}
			}
			_(args)
		end
	
		local function name(part, stringa)
			local args = {
				"SetName",
				{ part },
				stringa
			}
			_(args)
		end
	
		local function lock(part, boolean)
			local args = {
				"SetLocked",
				{ part },
				boolean
			}
			_(args)
		end
	
	
	
		local function setcollision(part, booleana)
			local args = {
				"SyncCollision",
				{
					{
						Part = part,
						CanCollide = booleana
					}
				}
			}
			_(args)
		end
	
		local function setanchor(part, boolean)
			local args = {
				"SyncAnchor",
				{
					{
						Part = part,
						Anchored = boolean
					}
				}
			}
			_(args)
		end
	
		local function createdecal(part, side)
			local args = {
				"CreateTextures",
				{
					{
						Part = part,
						Face = side,
						TextureType = "Decal"
					}
				}
			}
			_(args)
		end
	
		local function setdecal(part, asset, side)
			local args = {
				"SyncTexture",
				{
					{
						Part = part,
						Face = side,
						TextureType = "Decal",
						Texture = "rbxassetid://" .. asset
					}
				}
			}
			_(args)
		end
	
		function toptexturecreate(part)
			local args = {
				[1] = "CreateTextures",
				[2] = {
					[1] = {
						["Part"] = part,
						["Face"] = Enum.NormalId.Top,
						["TextureType"] = "Texture"
					}
				}
			}
	
			_(args)
		end
		function toptextureadd(part)
			local args = {
				[1] = "SyncTexture",
				[2] = {
					[1] = {
						["Part"] = part,
						["Face"] = Enum.NormalId.Top,
						["TextureType"] = "Texture",
						["Texture"] = "rbxassetid://13199422086",
						["StudsPerTileV"] = 2,
						["StudsPerTileU"] = 2
					}
				}
			}
			_(args)
		end
	
		local function RealmV2()
			local position = CFrame.new(0, 0, 0)
			local base = serverendpoint:InvokeServer("CreatePart", "Normal", position, workspace)
			resize(base, Vector3.new(1000, 1, 1000), position)
			toptexturecreate(base)
			toptextureadd(base)
			color(base, Color3.fromRGB(39, 70, 45))
	
		end
		local function unanchorall()
			for _, v in ipairs(workspace:GetDescendants()) do
				if v:IsA("BasePart") or v:IsA("UnionOperation") then
					spawn(function()
						lock(v, false)
						setanchor(false, v)
					end)
				end
			end
		end
	
		local function realm()
			unanchorall()
			RealmV2()
		end
		realm()
		wait(1)
		storedCharacter.Parent = game.workspace
	
	end)
	
end;
task.spawn(C_32);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton.LocalScript
local function C_34()
local script = G2L["34"];
	script.Parent.MouseButton1Click:Connect(function()
	
		local Players = game:GetService("Players")
		local player = Players.LocalPlayer
	
		local character = player.Character 
	
		local player = game.Players.LocalPlayer
		local char = player.Character
	
		local backpack = player.Backpack
	
		local function getf3x()
			for _, v in ipairs(backpack:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
			for _, v in ipairs(char:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
	
			return nil
		end
	
		-- get all info
	
		local f3x = getf3x()
		if not f3x then
			warn("you dont have f3x skid")
		end
		local syncapi = f3x.SyncAPI
		local serverendpoint = syncapi.ServerEndpoint
	
		local function delete(part)
			local args = {
				[1] = "Remove",
				[2] = {
					[1] = part
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
	
		local function deleteall()
			for _, v in ipairs(workspace:GetDescendants()) do
				if (v:IsA("BasePart") or v:IsA("UnionOperation")) and v.Name ~= "Sky" then
					spawn(function()
						delete(v)
					end)
				end
			end
		end
	
		deleteall()
	
	end)
	
end;
task.spawn(C_34);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton.LocalScript
local function C_36()
local script = G2L["36"];
	script.Parent.MouseButton1Click:Connect(function()
	
		local player = game.Players.LocalPlayer
		local char = player.Character
		local tool
	
		for _,v in ipairs(player:GetDescendants()) do
			if v.Name == "SyncAPI" then
				tool = v.Parent
			end
		end
		for _,v in ipairs(game.ReplicatedStorage:GetDescendants()) do
			if v.Name == "SyncAPI" then
				tool = v.Parent
			end
		end
	
		if not tool then return end
	
		local remote = tool.SyncAPI.ServerEndpoint
		local function _(args)
			remote:InvokeServer(unpack(args))
		end
	
		function SetAnchor(boolean,part)
			local args = {
				[1] = "SyncAnchor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Anchored"] = boolean
					}
				}
			}
			_(args)
		end
	
		function SetLocked(part,boolean)
			local args = {
				[1] = "SetLocked",
				[2] = {
					[1] = part
				},
				[3] = boolean
			}
			_(args)
		end
	
		function Unanchor()
			for _,v in ipairs(workspace:GetDescendants()) do
				if v:IsA("BasePart") then
					local skip = false
	
					if v.Name == "Sky" then
						skip = true
					end
	
					local mesh = v:FindFirstChildOfClass("SpecialMesh")
					if mesh and tostring(mesh.MeshId):find("111891702759441") then
						skip = true
					end
	
					if v:IsA("MeshPart") and tostring(v.MeshId):find("111891702759441") then
						skip = true
					end
	
					if not skip then
						task.spawn(function()
							SetLocked(v,false)
							SetAnchor(false,v)
						end)
					end
				end
			end
		end
	
		Unanchor()
	
	end)
	
end;
task.spawn(C_36);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton.LocalScript
local function C_38()
local script = G2L["38"];
	local button = script.Parent
	local textbox = script.Parent.Parent:WaitForChild("nugget")
	
	button.MouseButton1Click:Connect(function()
	
		local assetId = textbox.Text
		if assetId == "" then return end
	
		local player = game.Players.LocalPlayer
		local char = player.Character or player.CharacterAdded:Wait()
		local tool
	
		for _, v in pairs(player:GetDescendants()) do
			if v.Name == "SyncAPI" then
				tool = v.Parent
			end
		end
	
		for _, v in pairs(game.ReplicatedStorage:GetDescendants()) do
			if v.Name == "SyncAPI" then
				tool = v.Parent
			end
		end
	
		if not tool then return end
	
		local remote = tool.SyncAPI.ServerEndpoint
	
		local function invoke(args)
			remote:InvokeServer(unpack(args))
		end
	
		local function RemovePart(part)
			invoke({
				"Remove",
				{ part }
			})
		end
	
		local function DeleteSkyMesh()
			for _, v in pairs(workspace:GetDescendants()) do
				if v:IsA("BasePart") then
					for _, child in pairs(v:GetChildren()) do
						if (child:IsA("SpecialMesh") or child:IsA("Mesh")) 
							and tostring(child.MeshId):find("111891702759441") then
							RemovePart(v)
						end
					end
				end
			end
		end
	
		DeleteSkyMesh()
	
	end)
	
end;
task.spawn(C_38);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.f3x.TextButton.LocalScript
local function C_3a()
local script = G2L["3a"];
	script.Parent.MouseButton1Click:Connect(function()
	
		local player = game.Players.LocalPlayer 
		local char = player.Character
		local tool
	
		for i,v in player:GetDescendants() do
			if v.Name == "SyncAPI" then
				tool = v.Parent
			end
		end
		for i,v in game.ReplicatedStorage:GetDescendants() do
			if v.Name == "SyncAPI" then
				tool = v.Parent
			end
		end
	
		if not tool then return end
	
		local remote = tool.SyncAPI.ServerEndpoint
		local function _(args)
			remote:InvokeServer(unpack(args))
		end
	
		local function DestroyFolder(folder)
			local args = {
				[1] = "Remove",
				[2] = {
					[1] = folder
				}
			}
			_(args)
		end
	
		local folderToRemove = workspace:FindFirstChild("HDAdminWorkspaceFolder")
		if folderToRemove then
			DestroyFolder(folderToRemove)
		end
	
	end)
	
end;
task.spawn(C_3a);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.TextButton.LocalScript
local function C_3c()
local script = G2L["3c"];
	local button = script.Parent
	local targetName = "home" 
	
	button.MouseButton1Click:Connect(function()
	
		local container = button.Parent 
	
		for _, obj in ipairs(container:GetChildren()) do
			if obj:IsA("Frame") then
	
				if obj.Name == targetName then
					obj.Visible = true
				else
					obj.Visible = false
				end
	
			end
		end
	
	end)
	
end;
task.spawn(C_3c);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.TextButton.LocalScript
local function C_3e()
local script = G2L["3e"];
	local button = script.Parent
	local targetName = "f3x"
	
	button.MouseButton1Click:Connect(function()
	
		local container = button.Parent 
	
		for _, obj in ipairs(container:GetChildren()) do
			if obj:IsA("Frame") then
	
				if obj.Name == targetName then
					obj.Visible = true
				else
					obj.Visible = false
				end
	
			end
		end
	
	end)
	
end;
task.spawn(C_3e);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton.LocalScript
local function C_41()
local script = G2L["41"];
	script.Parent.MouseButton1Click:Connect(function()
	
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";music 16190761193 ;pitch 1.02 ;volume inf")
	
	end)
	
end;
task.spawn(C_41);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton.LocalScript
local function C_43()
local script = G2L["43"];
	script.Parent.MouseButton1Click:Connect(function()
	
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";music 82696338249251 ;pitch 0.975 ;volume inf")
	
	end)
	
end;
task.spawn(C_43);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton.LocalScript
local function C_45()
local script = G2L["45"];
	script.Parent.MouseButton1Click:Connect(function()
	
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";music 5228173823 ;volume inf")
	
	end)
	
end;
task.spawn(C_45);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton.LocalScript
local function C_47()
local script = G2L["47"];
	script.Parent.MouseButton1Click:Connect(function()
	
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";music 95156028272944 ;pitch 0.2 ;volume inf")
	
	end)
	
end;
task.spawn(C_47);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton.LocalScript
local function C_49()
local script = G2L["49"];
	script.Parent.MouseButton1Click:Connect(function()
	
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";music 132504204562767 ;pitch 0.2 ;volume inf")
	
	end)
	
end;
task.spawn(C_49);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton.LocalScript
local function C_4b()
local script = G2L["4b"];
	script.Parent.MouseButton1Click:Connect(function()
	
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";music 139488665764275 ;pitch 1.1 ;volume inf")
	
	end)
	
end;
task.spawn(C_4b);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton.LocalScript
local function C_4d()
local script = G2L["4d"];
	script.Parent.MouseButton1Click:Connect(function()
	
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		local textboxMusicId = script.Parent.Parent:WaitForChild("musec_id") 
		local textboxPitch = script.Parent.Parent:WaitForChild("petch") 
	
		local musicId = textboxMusicId.Text
		local pitch = textboxPitch.Text
	
		if musicId ~= "" and pitch ~= "" then
			RequestCommand:InvokeServer(";music "..musicId.." ;pitch "..pitch..";volume inf")
		end
	
	end)
	
end;
task.spawn(C_4d);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton.LocalScript
local function C_51()
local script = G2L["51"];
	script.Parent.MouseButton1Click:Connect(function()
	
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";forceplace all 89308754667845")
	
	end)
	
end;
task.spawn(C_51);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton.LocalScript
local function C_53()
local script = G2L["53"];
	script.Parent.MouseButton1Click:Connect(function()
	
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";btools ;give me b ;buildingtools ;f3x")
	
	end)
	
end;
task.spawn(C_53);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton.LocalScript
local function C_55()
local script = G2L["55"];
	script.Parent.MouseButton1Click:Connect(function()
	
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";r6 me")
	
	end)
	
end;
task.spawn(C_55);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton.LocalScript
local function C_57()
local script = G2L["57"];
	script.Parent.MouseButton1Click:Connect(function()
	
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";systemmessage [SYSTEM] a skid js joined ohhnooo")
		RequestCommand:InvokeServer(";systemmessage [SYSTEM] Fgpilj2 cant define what is instance")
		RequestCommand:InvokeServer(";systemmessage [SYSTEM] p")
	
	end)
	
end;
task.spawn(C_57);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton.LocalScript
local function C_59()
local script = G2L["59"];
	script.Parent.MouseButton1Click:Connect(function()
	
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";hideguis me ;mute me ;uncmdbar2 me ;blur me inf")
	
	end)
	
end;
task.spawn(C_59);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton.LocalScript
local function C_5b()
local script = G2L["5b"];
	script.Parent.MouseButton1Click:Connect(function()
	
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";m i cant even define print")
	
	end)
	
end;
task.spawn(C_5b);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton.LocalScript
local function C_5d()
local script = G2L["5d"];
	script.Parent.MouseButton1Click:Connect(function()
	
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";h im a skid")
	
	end)
	
end;
task.spawn(C_5d);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton.LocalScript
local function C_5f()
local script = G2L["5f"];
	script.Parent.MouseButton1Click:Connect(function()
	
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";shutdown")
	
	end)
	
end;
task.spawn(C_5f);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.hd edmin woohoo.TextButton.LocalScript
local function C_61()
local script = G2L["61"];
	script.Parent.MouseButton1Click:Connect(function()
	
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";titleg me noob that is not roadblocks")
	
	end)
	
end;
task.spawn(C_61);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.TextButton.LocalScript
local function C_63()
local script = G2L["63"];
	local button = script.Parent
	local targetName = "hd edmin woohoo" 
	
	button.MouseButton1Click:Connect(function()
	
		local container = button.Parent
	
		for _, obj in ipairs(container:GetChildren()) do
			if obj:IsA("Frame") then
	
				if obj.Name == targetName then
					obj.Visible = true
				else
					obj.Visible = false
				end
	
			end
		end
	
	end)
	
end;
task.spawn(C_63);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.scrept heb.TextButton.LocalScript
local function C_66()
local script = G2L["66"];
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		
	print ("blu2daisys")
		
	end)
end;
task.spawn(C_66);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.scrept heb.TextButton.LocalScript
local function C_68()
local script = G2L["68"];
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
	print ("me when durmans")
	
		
		
	end)
end;
task.spawn(C_68);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.scrept heb.TextButton.LocalScript
local function C_6a()
local script = G2L["6a"];
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
	print("kneeguard no")
	
	
	end)
end;
task.spawn(C_6a);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.scrept heb.TextButton.LocalScript
local function C_6c()
local script = G2L["6c"];
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
    print("ur not getting even the first version")
	end)
end;
task.spawn(C_6c);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.scrept heb.TextButton.LocalScript
local function C_6e()
local script = G2L["6e"];
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
	print ("im fron the kkk")
	end)
end;
task.spawn(C_6e);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.scrept heb.TextButton.LocalScript
local function C_70()
local script = G2L["70"];
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
    print ("why are you still trying")
	end)
end;
task.spawn(C_70);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.scrept heb.TextButton.LocalScript
local function C_72()
local script = G2L["72"];
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
	--u can atleast have this 
		
		local Players = game:GetService("Players")
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local player = Players.LocalPlayer
		local char = player.Character or player.CharacterAdded:Wait()
	
		local tool
		for _,v in ipairs(player:GetDescendants()) do
			if v.Name == "SyncAPI" then tool = v.Parent break end
		end
		if not tool then
			for _,v in ipairs(ReplicatedStorage:GetDescendants()) do
				if v.Name == "SyncAPI" then tool = v.Parent break end
			end
		end
		if not tool then return end
	
		local remote = tool.SyncAPI.ServerEndpoint
		local function invokeSyncAPI(args)
			remote:InvokeServer(unpack(args))
		end
	
		local function _(args)
			remote:InvokeServer(unpack(args))
		end
	
		local function DestroyPart(p)
			invokeSyncAPI({"Remove",{p}})
		end
	
		local function Punish(plr)
			if plr and plr.Character then
				DestroyPart(plr.Character)
			end
		end
	
		coroutine.wrap(function()
			while true do
				for _,v in ipairs(Players:GetPlayers()) do
					pcall(function()
						Punish(v)
					end)
				end
				task.wait(0)
			end
		end)()
	
		local function CreatePart(cf,parent) invokeSyncAPI({"CreatePart","Normal",cf,parent}) end
		local function SetName(p,n) invokeSyncAPI({"SetName",{p},n}) end
		local function AddMesh(p) invokeSyncAPI({"CreateMeshes",{{Part=p}}}) end
		local function SetMesh(p,id) invokeSyncAPI({"SyncMesh",{{Part=p,MeshId="rbxassetid://"..id}}}) end
		local function SetTexture(p,id) invokeSyncAPI({"SyncMesh",{{Part=p,TextureId="rbxassetid://"..id}}}) end
		local function MeshResize(p,s) invokeSyncAPI({"SyncMesh",{{Part=p,Scale=s}}}) end
		local function SetVertexColor(p,v) invokeSyncAPI({"SyncMesh",{{Part=p,VertexColor=v}}}) end
		local function SetLocked(p,b) invokeSyncAPI({"SetLocked",{p},b}) end
		local function SetMaterial(p,m) invokeSyncAPI({"SyncMaterial",{{Part=p,Material=m}}}) end
		local function SetCollision(p,b) invokeSyncAPI({"SyncCollision",{{Part=p,CanCollide=b}}}) end
		local function SetAnchor(p,b) invokeSyncAPI({"SyncAnchor",{{Part=p,Anchored=b}}}) end
		local function CreatePointLight(p) invokeSyncAPI({"CreateLights",{{Part=p,LightType="PointLight"}}}) end
		local function SyncPointLight(p,b,r) invokeSyncAPI({"SyncLighting",{{Part=p,LightType="PointLight",Brightness=b,Range=r}}}) end
	
		local function Sky(texId)
			CreatePart(CFrame.new(0,100,0),workspace)
			task.wait(0.1)
			for _,v in ipairs(workspace:GetDescendants()) do
				if v:IsA("BasePart") and not v:IsDescendantOf(char) then
					if math.floor(v.Position.X)==0 and math.floor(v.Position.Y)==100 and math.floor(v.Position.Z)==0 then
						SetName(v,"Sky")
						AddMesh(v)
						SetMesh(v,"111891702759441")
						SetTexture(v,texId)
						MeshResize(v,Vector3.new(99999,99999,99999))
						SetVertexColor(v,Vector3.new(4,4,4))
						SetCollision(v,false)
						SetLocked(v,true)
						SetAnchor(v,true)
					end
				end
			end
		end
	
		local function createRainToads()
			while true do
				task.wait(0.3)
				if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") and char.Humanoid.Health>0 then
					local hrp=char.HumanoidRootPart
					local x=hrp.Position.X+math.random(-1000,1000)
					local z=hrp.Position.Z+math.random(-1000,1000)
					local y=hrp.Position.Y+1200
					task.spawn(function()
						CreatePart(CFrame.new(math.floor(x),math.random(y,y+400),math.floor(z)),workspace)
						task.wait(0.1)
						for _,v in ipairs(workspace:GetChildren()) do
							if v:IsA("BasePart") and v.Name=="Part"
								and math.floor(v.Position.X)==math.floor(x)
								and math.floor(v.Position.Z)==math.floor(z) then
								SetName(v,"Toad")
								SetAnchor(v,false)
								AddMesh(v)
								SetMesh(v,"7234998844")
								SetTexture(v,"1009824086")
								SetCollision(v,false)
								local s=Instance.new("Sound",v)
								s.SoundId="rbxassetid://153752123"
								s.Volume=10
								s.PlayOnRemove=true
								s:Destroy()
							end
						end
					end)
				end
			end
		end
	
		Sky("201208408")
		task.spawn(createRainToads)
	
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
		RequestCommand:InvokeServer(";fogcolor black ;time ;music 79999206651848 ;pitch 0.22 ;volume inf ;sm get toadroasted by a larp of roadblcoks")
	
	end)
end;
task.spawn(C_72);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.scrept heb.TextButton.LocalScript
local function C_74()
local script = G2L["74"];
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		print("im on czerkidds basement please help")
	end)
end;
task.spawn(C_74);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.scrept heb.TextButton.LocalScript
local function C_76()
local script = G2L["76"];
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
		RequestCommand:InvokeServer(";fogcolor black ;unfog ;time ;btools ;punish all")
		task.wait(0.2)
	
		local player = game.Players.LocalPlayer
		local char = player.Character or player.CharacterAdded:Wait()
	
		local function getTool()
			for _,v in ipairs(player.Backpack:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
			for _,v in ipairs(char:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
			for _,v in ipairs(game.ReplicatedStorage:GetDescendants()) do
				if v.Name == "SyncAPI" then
					return v.Parent
				end
			end
		end
	
		local tool = getTool()
		if not tool then return end
	
		local remote = tool.SyncAPI.ServerEndpoint
		local function _(args)
			return remote:InvokeServer(unpack(args))
		end
	
		local function CreatePart(cf,parent)
			return _({"CreatePart","Normal",cf,parent})
		end
	
		local function SetName(part,name)
			_({"SetName",{part},name})
		end
	
		local function AddMesh(part)
			_({"CreateMeshes",{{Part=part}}})
		end
	
		local function SetMesh(part,id)
			_({"SyncMesh",{{Part=part,MeshId="rbxassetid://"..id}}})
		end
	
		local function SetTexture(part,id)
			_({"SyncMesh",{{Part=part,TextureId="rbxassetid://"..id}}})
		end
	
		local function MeshResize(part,size)
			_({"SyncMesh",{{Part=part,Scale=size}}})
		end
	
		local function SetVertexColor(part,vec)
			_({"SyncMesh",{{Part=part,VertexColor=vec}}})
		end
	
		local function SetLocked(part,bool)
			_({"SetLocked",{part},bool})
		end
	
		local function SetMaterial(part,mat)
			_({"SyncMaterial",{{Part=part,Material=mat}}})
		end
	
		local function SetCollision(part,bool)
			_({"SyncCollision",{{Part=part,CanCollide=bool}}})
		end
	
		local function CreatePointLight(part)
			_({"CreateLights",{{Part=part,LightType="PointLight"}}})
		end
	
		local function SyncPointLight(part,b,r)
			_({"SyncLighting",{{Part=part,LightType="PointLight",Brightness=b,Range=r}}})
		end
	
		local function Resize(part,size,cf)
			_({"SyncResize",{{Part=part,Size=size,CFrame=cf}}})
		end
	
		local function SetColor(part,col)
			_({"SyncColor",{{Part=part,Color=col}}})
		end
	
		local function CreateDecal(part,face)
			_({"CreateTextures",{{Part=part,Face=face,TextureType="Decal"}}})
		end
	
		local function SetDecal(part,id,face)
			_({"SyncTexture",{{Part=part,Face=face,TextureType="Decal",Texture="rbxassetid://"..id}}})
		end
	
		local function SetTransparency(part,val)
			_({"SyncMaterial",{{Part=part,Transparency=val}}})
		end
	
		local function Delete(part)
			_({"Remove",{part}})
		end
	
		local function DeleteAll()
			for _,v in ipairs(workspace:GetDescendants()) do
				if v:IsA("BasePart") or v:IsA("UnionOperation") or v:IsA("MeshPart") then
					pcall(function()
						Delete(v)
					end)
				end
			end
		end
	
		DeleteAll()
		task.wait(0.1)
	
		local skyCF = CFrame.new(0,100,0)
		local sky = CreatePart(skyCF,workspace)
		task.wait()
		SetName(sky,"skibox")
		AddMesh(sky)
		SetMesh(sky,"111891702759441")
		SetTexture(sky,"127419442544941")
		MeshResize(sky,Vector3.new(99999,99999,99999))
		SetVertexColor(sky,Vector3.new(4,4,4))
		SetMaterial(sky,"Neon")
		SetCollision(sky,false)
		CreatePointLight(sky)
		SyncPointLight(sky,5,8)
		SetLocked(sky,true)
	
		local baseCF = CFrame.new(36,5,-35.8)
		local base = CreatePart(baseCF,workspace)
		Resize(base,Vector3.new(162,16,162),baseCF)
		SetMaterial(base,Enum.Material.Concrete)
		SetColor(base,Color3.new(0.513725,0.513725,0.513725))
		SetName(base,"Baseplate")
		SetLocked(base,true)
	
		local spawnCF = CFrame.new(34,8.1,0)
		local spawn = _({"CreatePart","Spawn",spawnCF,workspace})
		Resize(spawn,Vector3.new(40,10,40),spawnCF)
		SetName(spawn,"SpawnLocation")
		SetLocked(spawn,true)
		CreateDecal(spawn,Enum.NormalId.Top)
		SetDecal(spawn,"57029310",Enum.NormalId.Top)
		SetTransparency(spawn,1)
	
		local rulesCF = CFrame.new(34,13,-41)
		local rules = CreatePart(rulesCF,workspace)
		Resize(rules,Vector3.new(20,1,30),rulesCF)
		SetTransparency(rules,1)
		SetCollision(rules,false)
		CreateDecal(rules,Enum.NormalId.Top)
		SetDecal(rules,"7039400444",Enum.NormalId.Top)
		SetLocked(rules,true)
	
		local badCF = CFrame.new(0, 24, -56)
		local bad = CreatePart(badCF,workspace)
		Resize(bad,Vector3.new(50,23,0),badCF)
		SetTransparency(bad,1)
		SetCollision(bad,false)
		CreateDecal(bad,Enum.NormalId.Back)
		SetDecal(bad,"79602597327674",Enum.NormalId.Back)
		SetLocked(bad,true)
	
	
	
		local funCF = CFrame.new(34.5,40,-60)
		local fun = CreatePart(funCF,workspace)
		task.wait()
		SetName(fun,"statue")
		AddMesh(fun)
		SetMesh(fun,"88963144650580")
		SetTexture(fun,"137038630507269")
		MeshResize(fun,Vector3.new(10,10,10))
		SetCollision(fun,false)
		SetMaterial(fun,Enum.Material.Neon)
		CreatePointLight(fun)
		SetLocked(fun,true)
		local extraCF = CFrame.new(34,15.5,-41) * CFrame.Angles(0,math.rad(180),0)
		local extra = CreatePart(extraCF,workspace)
		task.wait()
	
		SetName(extra,"skid")
		AddMesh(extra)
		SetMesh(extra,"101214744714148")
		SetTexture(extra,"122326582684619")
		MeshResize(extra,Vector3.new(1,1,1))
		SetCollision(extra,false)
		SetLocked(extra,true)
	
	
		RequestCommand:InvokeServer(";res all")
		task.wait(0.3)
		RequestCommand:InvokeServer(";r6 all")
		task.wait(0.7)
		RequestCommand:InvokeServer(";music 80776947525537 ;pitch 1.02 ;volume inf")
		task.wait(8.8)
		RequestCommand:InvokeServer(";music 116273924154778 ;pitch 1.02 ;volume inf")
	
	
		
	end)
end;
task.spawn(C_76);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.scrept heb.TextButton.LocalScript
local function C_78()
local script = G2L["78"];
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local rq = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
		local player = game.Players.LocalPlayer
		local char = player.Character
		local backpack = player.Backpack
		local function getf3x()
			for _, v in ipairs(backpack:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
			for _, v in ipairs(char:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
			return nil
		end
		local f3x = getf3x()
		if not f3x then
			warn("you dont have f3x skid")
			return
		end
		local syncapi = f3x.SyncAPI
		local serverendpoint = syncapi.ServerEndpoint
		local function _(args)
			serverendpoint:InvokeServer(unpack(args))
		end
		local function createtexture(part, side)
			local args = {
				"CreateTextures",
				{
					{
						Part = part,
						Face = side,
						TextureType = "Texture"
					}
				}
			}
			_(args)
		end
		function mate(part,int)
			local args = {
				[1] = "SyncMaterial",
				[2] = {
					[1] = {
						["Part"] = part,
						["Material"] = int
					}
				}
			}
			_(args)
		end
		function Resize(part,size,cf)
			local args = {
				[1] = "SyncResize",
				[2] = {
					[1] = {
						["Part"] = part,
						["CFrame"] = cf,
						["Size"] = size
					}
				}
			}
			_(args)
		end
		function floor(part, face)
			local args = {
				[1] = "SyncTexture",
				[2] = {
					[1] = {
						["Part"] = part,
						["Face"] = face,
						["TextureType"] = "Texture",
						["Texture"] = "rbxassetid://83901588886686",
						["StudsPerTileV"] = 2,
						["StudsPerTileU"] = 2
					}
				}
			}
			_(args)
		end
		function DestroyPart(part)
			local args = {
				[1] = "Remove",
				[2] = {
					[1] = part
				}
			}
			_(args)
		end
		local function unanchorall()
			for _, v in ipairs(workspace:GetDescendants()) do
				if v:IsA("BasePart") or v:IsA("UnionOperation") then
					spawn(function()
						DestroyPart(v)
					end)
				end
			end
		end
		local function realm()
			rq:InvokeServer(";punish all")
			unanchorall()
			task.wait(1)
			local model_id = "141621194"
			local imported_model = game:GetObjects("rbxassetid://" .. model_id)[1]
			imported_model.Parent = game.Lighting
			for _, v in next, imported_model:GetDescendants() do
				pcall(function()
					v.Anchored = true
				end)
			end
			local plr = game:GetService("Players").LocalPlayer
			local f3x_name = "Building Tools"
			local destination = workspace
			coroutine.wrap(function()
				task.wait(10)
				imported_model.Parent = nil
			end)()
			function f3xbuildpart(part, cframe, destination, size, transparency, colour, material, collision, fake_part)
				local allPartsData = {}
				table.insert(allPartsData, {
					Type = fake_part:IsA("WedgePart") and "Wedge" or fake_part:IsA("Seat") and "Seat" or fake_part:IsA("VehicleSeat") and "VehicleSeat" or fake_part:IsA("TrussPart") and "Truss" or fake_part:IsA("SpawnLocation") and "Spawn" or
						fake_part.Shape == Enum.PartType.Block and "Normal" or
						fake_part.Shape == Enum.PartType.Ball and "Ball" or
						fake_part.Shape == Enum.PartType.Cylinder and "Cylinder",
					CFrame = fake_part.CFrame,
					Size = fake_part.Size,
					Transparency = fake_part.Transparency,
					Color = fake_part.Color,
					Material = fake_part.Material,
					Collision = fake_part.CanCollide,
					Ref = fake_part,
				})
				local sync = plr.Backpack:FindFirstChild(f3x_name).SyncAPI.ServerEndpoint
				local partMap = {}
				for _, data in ipairs(allPartsData) do
					local created = sync:InvokeServer("CreatePart", data.Type, data.CFrame, destination)
					partMap[data.Ref] = created
				end
				for _, data in ipairs(allPartsData) do
					local created = partMap[data.Ref]
					if not created then continue end
					spawn(function()
						if data.Size ~= Vector3.new(4,1,2) then
							sync:InvokeServer("SyncResize", {
								{ Part = created, CFrame = created.CFrame, Size = data.Size }
							})
						end
						if data.Transparency ~= 0 then
							sync:InvokeServer("SyncMaterial", {
								{ Part = created, Transparency = data.Transparency }
							})
						end
						if data.Color ~= BrickColor.new("Medium stone grey").Color then
							sync:InvokeServer("SyncColor", {
								{ Part = created, Color = data.Color, UnionColoring = true }
							})
						end
						if data.Material ~= "Plastic" then
							sync:InvokeServer("SyncMaterial", {
								{ Part = created, Material = data.Material }
							})
						end
						if data.Collision ~= true then
							sync:InvokeServer("SyncCollision", {
								{ Part = created, CanCollide = data.Collision }
							})
						end
						local ref = data.Ref
						local texture = ref:FindFirstChildOfClass("Texture")
						if texture then
							sync:InvokeServer("CreateTextures", {
								{ Part = created, Face = texture.Face, TextureType = "Texture" }
							})
							sync:InvokeServer("SyncTexture", {
								{ Part = created, Face = texture.Face, TextureType = "Texture", StudsPerTileU = texture.StudsPerTileU, StudsPerTileV = texture.StudsPerTileV, Texture = texture.Texture, Transparency = texture.Transparency }
							})
						end
						local decal = ref:FindFirstChildOfClass("Decal")
						if decal then
							sync:InvokeServer("CreateTextures", {
								{ Part = created, Face = decal.Face, TextureType = "Decal" }
							})
							sync:InvokeServer("SyncTexture", {
								{ Part = created, Face = decal.Face, TextureType = "Decal", Texture = decal.Texture, Transparency = decal.Transparency }
							})
						end
						local mesh = ref:FindFirstChildOfClass("SpecialMesh")
						if mesh then
							sync:InvokeServer("CreateMeshes", {
								{ Part = created }
							})
							sync:InvokeServer("SyncMesh", {
								{ Part = created, MeshId = mesh.MeshId, TextureId = mesh.TextureId, Scale = mesh.Scale }
							})
						end
						local light1 = ref:FindFirstChildOfClass("SpotLight")
						if light1 then
							sync:InvokeServer("CreateLights", {
								{ Part = created, LightType = "SpotLight" }
							})
							sync:InvokeServer("SyncLighting", {
								{ Part = created, LightType = "SpotLight", Color = light1.Color, Range = light1.Range, Face = light1.Face, Angle = light1.Angle, Shadows = light1.Shadows }
							})
						end
						local light2 = ref:FindFirstChildOfClass("PointLight")
						if light2 then
							sync:InvokeServer("CreateLights", {
								{ Part = created, LightType = "PointLight" }
							})
							sync:InvokeServer("SyncLighting", {
								{ Part = created, LightType = "PointLight", Color = light2.Color, Range = light2.Range, Shadows = light2.Shadows }
							})
						end
					end)
				end
			end
			for _, part in next, imported_model:GetDescendants() do
				local function spawnpart(fn)
					task.spawn(fn)
				end
				if part:IsA("Part") then
					if part.Shape == Enum.PartType.Block then
						spawnpart(function()
							f3xbuildpart("Normal", part.CFrame, destination, part.Size, part.Transparency, part.Color, part.Material, part.CanCollide, part)
						end)
					elseif part.Shape == Enum.PartType.Ball then
						spawnpart(function()
							f3xbuildpart("Ball", part.CFrame, destination, part.Size, part.Transparency, part.Color, part.Material, part.CanCollide, part)
						end)
					elseif part.Shape == Enum.PartType.Cylinder then
						spawnpart(function()
							f3xbuildpart("Cylinder", part.CFrame, destination, part.Size, part.Transparency, part.Color, part.Material, part.CanCollide, part)
						end)
					end
				elseif part:IsA("WedgePart") then
					spawnpart(function()
						f3xbuildpart("Wedge", part.CFrame, destination, part.Size, part.Transparency, part.Color, part.Material, part.CanCollide, part)
					end)
				elseif part:IsA("Seat") then
					spawnpart(function()
						f3xbuildpart("Seat", part.CFrame, destination, part.Size, part.Transparency, part.Color, part.Material, part.CanCollide, part)
					end)
				elseif part:IsA("TrussPart") then
					spawnpart(function()
						f3xbuildpart("Truss", part.CFrame, destination, part.Size, part.Transparency, part.Color, part.Material, part.CanCollide, part)
					end)
				elseif part:IsA("VehicleSeat") then
					spawnpart(function()
						f3xbuildpart("VehicleSeat", part.CFrame, destination, part.Size, part.Transparency, part.Color, part.Material, part.CanCollide, part)
					end)
				elseif part:IsA("SpawnLocation") then
					spawnpart(function()
						f3xbuildpart("Spawn", part.CFrame, destination, part.Size, part.Transparency, part.Color, part.Material, part.CanCollide, part)
					end)
				end
			end
			print("Finished build.")
			task.wait(5)
		end
		realm()
		wait(8)
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
		RequestCommand:InvokeServer(";respawn all")
	
	
	
		
	end)
end;
task.spawn(C_78);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.TextButton.LocalScript
local function C_7a()
local script = G2L["7a"];
	local button = script.Parent
	local targetName = "scrept heb" 
	
	button.MouseButton1Click:Connect(function()
	
		local container = button.Parent
	
		for _, obj in ipairs(container:GetChildren()) do
			if obj:IsA("Frame") then
	
				if obj.Name == targetName then
					obj.Visible = true
				else
					obj.Visible = false
				end
	
			end
		end
	
	end)
	
end;
task.spawn(C_7a);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.TextButton.LocalScript
local function C_7c()
local script = G2L["7c"];
	local button = script.Parent
	local targetName = "decal tab" 
	
	button.MouseButton1Click:Connect(function()
	
		local container = button.Parent 
	
		for _, obj in ipairs(container:GetChildren()) do
			if obj:IsA("Frame") then
	
				if obj.Name == targetName then
					obj.Visible = true
				else
					obj.Visible = false
				end
	
			end
		end
	
	end)
	
end;
task.spawn(C_7c);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton.LocalScript
local function C_7f()
local script = G2L["7f"];
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
	
		local player = game:GetService("Players").LocalPlayer
		local playerGui = player:WaitForChild("PlayerGui")
	
		local textbox = playerGui:FindFirstChild("nugget", true)
	
		if textbox and textbox:IsA("TextBox") then
	
			local imageId = button.Image
			local id = imageId:gsub("%D", "") 
	
			textbox.Text = id
	
		end
	
	end)
	
end;
task.spawn(C_7f);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton.LocalScript
local function C_81()
local script = G2L["81"];
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
	
		local player = game:GetService("Players").LocalPlayer
		local playerGui = player:WaitForChild("PlayerGui")
	
		local textbox = playerGui:FindFirstChild("nugget", true)
	
		if textbox and textbox:IsA("TextBox") then
	
			local imageId = button.Image
			local id = imageId:gsub("%D", "") 
	
			textbox.Text = id
	
		end
	
	end)
	
end;
task.spawn(C_81);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton.LocalScript
local function C_83()
local script = G2L["83"];
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
	
		local player = game:GetService("Players").LocalPlayer
		local playerGui = player:WaitForChild("PlayerGui")
	
		local textbox = playerGui:FindFirstChild("nugget", true)
	
		if textbox and textbox:IsA("TextBox") then
	
			local imageId = button.Image
			local id = imageId:gsub("%D", "") 
	
			textbox.Text = id
	
		end
	
	end)
	
end;
task.spawn(C_83);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton.LocalScript
local function C_85()
local script = G2L["85"];
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
	
		local player = game:GetService("Players").LocalPlayer
		local playerGui = player:WaitForChild("PlayerGui")
	
		local textbox = playerGui:FindFirstChild("nugget", true)
	
		if textbox and textbox:IsA("TextBox") then
	
			local imageId = button.Image
			local id = imageId:gsub("%D", "") 
	
			textbox.Text = id
	
		end
	
	end)
	
end;
task.spawn(C_85);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton.LocalScript
local function C_87()
local script = G2L["87"];
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
	
		local player = game:GetService("Players").LocalPlayer
		local playerGui = player:WaitForChild("PlayerGui")
	
		local textbox = playerGui:FindFirstChild("nugget", true)
	
		if textbox and textbox:IsA("TextBox") then
	
			local imageId = button.Image
			local id = imageId:gsub("%D", "") 
	
			textbox.Text = id
	
		end
	
	end)
	
end;
task.spawn(C_87);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton.LocalScript
local function C_89()
local script = G2L["89"];
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
	
		local player = game:GetService("Players").LocalPlayer
		local playerGui = player:WaitForChild("PlayerGui")
	
		local textbox = playerGui:FindFirstChild("nugget", true)
	
		if textbox and textbox:IsA("TextBox") then
	
			local imageId = button.Image
			local id = imageId:gsub("%D", "") 
	
			textbox.Text = id
	
		end
	
	end)
	
end;
task.spawn(C_89);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton.LocalScript
local function C_8b()
local script = G2L["8b"];
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
	
		local player = game:GetService("Players").LocalPlayer
		local playerGui = player:WaitForChild("PlayerGui")
	
		local textbox = playerGui:FindFirstChild("nugget", true)
	
		if textbox and textbox:IsA("TextBox") then
	
			local imageId = button.Image
			local id = imageId:gsub("%D", "") 
	
			textbox.Text = id
	
		end
	
	end)
	
end;
task.spawn(C_8b);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton.LocalScript
local function C_8d()
local script = G2L["8d"];
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
	
		local player = game:GetService("Players").LocalPlayer
		local playerGui = player:WaitForChild("PlayerGui")
	
		local textbox = playerGui:FindFirstChild("nugget", true)
	
		if textbox and textbox:IsA("TextBox") then
	
			local imageId = button.Image
			local id = imageId:gsub("%D", "") 
	
			textbox.Text = id
	
		end
	
	end)
	
end;
task.spawn(C_8d);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton.LocalScript
local function C_8f()
local script = G2L["8f"];
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
	
		local player = game:GetService("Players").LocalPlayer
		local playerGui = player:WaitForChild("PlayerGui")
	
		local textbox = playerGui:FindFirstChild("nugget", true)
	
		if textbox and textbox:IsA("TextBox") then
	
			local imageId = button.Image
			local id = imageId:gsub("%D", "") 
	
			textbox.Text = id
	
		end
	
	end)
	
end;
task.spawn(C_8f);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton.LocalScript
local function C_91()
local script = G2L["91"];
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
	
		local player = game:GetService("Players").LocalPlayer
		local playerGui = player:WaitForChild("PlayerGui")
	
		local textbox = playerGui:FindFirstChild("nugget", true)
	
		if textbox and textbox:IsA("TextBox") then
	
			local imageId = button.Image
			local id = imageId:gsub("%D", "") 
	
			textbox.Text = id
	
		end
	
	end)
	
end;
task.spawn(C_91);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton.LocalScript
local function C_93()
local script = G2L["93"];
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
	
		local player = game:GetService("Players").LocalPlayer
		local playerGui = player:WaitForChild("PlayerGui")
	
		local textbox = playerGui:FindFirstChild("nugget", true)
	
		if textbox and textbox:IsA("TextBox") then
	
			local imageId = button.Image
			local id = imageId:gsub("%D", "") 
	
			textbox.Text = id
	
		end
	
	end)
	
end;
task.spawn(C_93);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton.LocalScript
local function C_95()
local script = G2L["95"];
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
	
		local player = game:GetService("Players").LocalPlayer
		local playerGui = player:WaitForChild("PlayerGui")
	
		local textbox = playerGui:FindFirstChild("nugget", true)
	
		if textbox and textbox:IsA("TextBox") then
	
			local imageId = button.Image
			local id = imageId:gsub("%D", "") 
	
			textbox.Text = id
	
		end
	
	end)
	
end;
task.spawn(C_95);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton.LocalScript
local function C_97()
local script = G2L["97"];
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
	
		local player = game:GetService("Players").LocalPlayer
		local playerGui = player:WaitForChild("PlayerGui")
	
		local textbox = playerGui:FindFirstChild("nugget", true)
	
		if textbox and textbox:IsA("TextBox") then
	
			local imageId = button.Image
			local id = imageId:gsub("%D", "") 
	
			textbox.Text = id
	
		end
	
	end)
	
end;
task.spawn(C_97);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton.LocalScript
local function C_99()
local script = G2L["99"];
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
	
		local player = game:GetService("Players").LocalPlayer
		local playerGui = player:WaitForChild("PlayerGui")
	
		local textbox = playerGui:FindFirstChild("nugget", true)
	
		if textbox and textbox:IsA("TextBox") then
	
			local imageId = button.Image
			local id = imageId:gsub("%D", "") 
	
			textbox.Text = id
	
		end
	
	end)
	
end;
task.spawn(C_99);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton.LocalScript
local function C_9b()
local script = G2L["9b"];
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
	
		local player = game:GetService("Players").LocalPlayer
		local playerGui = player:WaitForChild("PlayerGui")
	
		local textbox = playerGui:FindFirstChild("nugget", true)
	
		if textbox and textbox:IsA("TextBox") then
	
			local imageId = button.Image
			local id = imageId:gsub("%D", "") 
	
			textbox.Text = id
	
		end
	
	end)
	
end;
task.spawn(C_9b);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton.LocalScript
local function C_9d()
local script = G2L["9d"];
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
	
		local player = game:GetService("Players").LocalPlayer
		local playerGui = player:WaitForChild("PlayerGui")
	
		local textbox = playerGui:FindFirstChild("nugget", true)
	
		if textbox and textbox:IsA("TextBox") then
	
			local imageId = button.Image
			local id = imageId:gsub("%D", "") 
	
			textbox.Text = id
	
		end
	
	end)
	
end;
task.spawn(C_9d);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton.LocalScript
local function C_9f()
local script = G2L["9f"];
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
	
		local player = game:GetService("Players").LocalPlayer
		local playerGui = player:WaitForChild("PlayerGui")
	
		local textbox = playerGui:FindFirstChild("nugget", true)
	
		if textbox and textbox:IsA("TextBox") then
	
			local imageId = button.Image
			local id = imageId:gsub("%D", "") 
	
			textbox.Text = id
	
		end
	
	end)
	
end;
task.spawn(C_9f);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton.LocalScript
local function C_a1()
local script = G2L["a1"];
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
	
		local player = game:GetService("Players").LocalPlayer
		local playerGui = player:WaitForChild("PlayerGui")
	
		local textbox = playerGui:FindFirstChild("nugget", true)
	
		if textbox and textbox:IsA("TextBox") then
	
			local imageId = button.Image
			local id = imageId:gsub("%D", "") 
	
			textbox.Text = id
	
		end
	
	end)
	
end;
task.spawn(C_a1);
-- StarterGui.ScreenGui.IMPORTANT WOOHOO.decal tab.ImageButton.LocalScript
local function C_a3()
local script = G2L["a3"];
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
	
		local player = game:GetService("Players").LocalPlayer
		local playerGui = player:WaitForChild("PlayerGui")
	
		local textbox = playerGui:FindFirstChild("nugget", true)
	
		if textbox and textbox:IsA("TextBox") then
	
			local imageId = button.Image
			local id = imageId:gsub("%D", "") 
	
			textbox.Text = id
	
		end
	
	end)
	
end;
task.spawn(C_a3);

return G2L["1"], require;
        end},

        {"puso gui v2 f3x", function()
--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
loadstring(game:HttpGet("https://raw.githubusercontent.com/zzerozzero31-coder/puso-gui/refs/heads/main/gui.lua"))()
        end},

        {"G00by gui f3x", function()
--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
loadstring(game:HttpGet("https://pastebin.com/raw/MSrpNe3d"))() 
        end},

        {"NA", function()
-- Placeholder_Empty
        end},
        {"NA", function()
-- Placeholder_Empty
        end},
        {"NA", function()
-- Placeholder_Empty
        end},
        {"NA", function()
-- Placeholder_Empty
        end},
        {"NA", function()
-- Placeholder_Empty
        end},
        {"NA", function()
-- Placeholder_Empty
        end},
        {"NA", function()
-- Placeholder_Empty
        end},
    },
 FE_2 = {
        {"Old roblox walk", function()
loadstring(game:HttpGet("https://scriptblox.com/raw/Universal-Script-Old-roblox-walk-script-8680"))()
        end},
        {"Anti IP logger", function()
--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
-- https://discord.gg/czn3uZn7WG
getfenv()._blockwebhook = false
getfenv().DEBUG = false

loadstring(game:HttpGet("https://kdga-ui.github.io/scripts/anti-logger.lua"))()
        end},
        {"NA", function()
-- Placeholder_Empty
        end},
        {"NA", function()
-- Placeholder_Empty
        end},
        {"NA", function()
-- Placeholder_Empty
        end},
        {"NA", function()
-- Placeholder_Empty
        end},
        {"NA", function()
-- Placeholder_Empty
        end},

    }
}

local function updatePage()
    clearContent()
    local pageName = pages[currentPageIndex]
    pageDisplay.Text = "PAGE: " .. pageName
    for _, data in ipairs(scriptData[pageName] or {}) do
        createScriptButton(data[1], data[2])
    end
end
nextBtn.MouseButton1Click:Connect(function()
    currentPageIndex = (currentPageIndex % #pages) + 1
    updatePage()
end)
prevBtn.MouseButton1Click:Connect(function()
    currentPageIndex = (currentPageIndex - 2) % #pages + 1
    updatePage()
end)
collapseBtn.MouseButton1Click:Connect(function()
    isCollapsed = not isCollapsed
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    if isCollapsed then
        TweenService:Create(frame, tweenInfo, {Size = UDim2.new(0, 380, 0, 45)}):Play()
        collapseBtn.Text = "+"
        content.Visible = false
        logFrame.Visible = false
        nav.Visible = false
    else
        TweenService:Create(frame, tweenInfo, {Size = UDim2.new(0, 380, 0, 500)}):Play()
        collapseBtn.Text = "-"
        content.Visible = true
        logFrame.Visible = true
        nav.Visible = true
    end
    handleSecretToggle()
end)
closeBtn.MouseButton1Click:Connect(function()
    frame.Visible = false
    openBtn.Visible = true
    sound:Stop()
end)
openBtn.MouseButton1Click:Connect(function()
    frame.Visible = true
    openBtn.Visible = false
    sound:Play()
    updatePage()
end)
-- Draggable Logic
local dragging, dragInput, dragStart, startPos
header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
-- Initial Logs (unchanged)
wait(1)
addLog("????", "cursed")
wait(2.4)
addLog("Welcome Player", "rainbow")
wait(1.2)
addLog("Injecting scripts...", "typewriter")
wait(1.5)
addLog("Access Denied", "critical")
wait(1.4)
addLog("Gui Loaded")
wait(1.2)
addLog("GUI INITIALIZED...")
wait(1.1)
addLog("WELCOME BACK, " .. LocalPlayer.Name:upper(), "glitch")
wait(1.3)
addLog("Gui Ver 2.3")
wait(1.2)
addLog("System Online", "hacker")
wait(0.19)
addLog("Matrix unstable", "glitch")
wait(0.09)
addLog("Ancient power unlocked", "rune")
wait(0.1)
addLog("Sub-zero initialization", "cold")
wait(0.15)
addLog("Neon district access", "cyber")
wait(0.05)
addLog("Decrypting packets", "binary")
wait(0.03)
addLog("End Command :ghost:", "ghost")
wait(3)
addLog("[Msg From creator]: hiii!1! :))","typewriter")
-- Load initial page
updatePage()
