-- KY💀 V21 FINAL FIX - PENCET LANGSUNG BUKA + BISA DIGESER PINDAH + KAKASHI BG BERSIH
pcall(function() game.Players.LocalPlayer.PlayerGui:FindFirstChild("KY_HUB"):Destroy() end)
pcall(function() if gethui then gethui():FindFirstChild("KY_HUB"):Destroy() end end)

local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local parentGui = player:WaitForChild("PlayerGui")
pcall(function() if gethui then parentGui = gethui() end end)

local activeEquips = {}
local toolConnections = {}

local function getBg()
    local paths = {"ky_bg.png","Delta/Workspace/ky_bg.png","/storage/emulated/0/Delta/Workspace/ky_bg.png"}
    for _, p in ipairs(paths) do
        if isfile and isfile(p) and getcustomasset then
            local ok, asset = pcall(getcustomasset, p)
            if ok and asset then return asset end
        end
    end
    return nil
end
local bgAsset = getBg()

local screen = Instance.new("ScreenGui") 
screen.Name = "KY_HUB" 
screen.ResetOnSpawn = false 
screen.DisplayOrder = 999
screen.Parent = parentGui

-- TOMBOL KY💀 - BISA DIGESER PINDAH, TAPI PENCET LANGSUNG BUKA
local kyBtn = Instance.new("TextButton", screen)
kyBtn.Name = "KY"
kyBtn.Size = UDim2.new(0,110,0,36)
kyBtn.Position = UDim2.new(0.5,-55,0,85)
kyBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)
kyBtn.Text = "KY💀"
kyBtn.Font = Enum.Font.GothamBlack
kyBtn.TextSize = 16
kyBtn.TextColor3 = Color3.fromRGB(255,255,255)
kyBtn.Active = true
kyBtn.Draggable = true -- BISA DIGESER PINDAH POSISI
kyBtn.ZIndex = 1000
Instance.new("UICorner", kyBtn).CornerRadius = UDim.new(1,0)
local kyStroke = Instance.new("UIStroke", kyBtn) kyStroke.Color = Color3.fromRGB(100,255,255) kyStroke.Thickness = 2

-- MAIN UI
local main = Instance.new("Frame", screen) 
main.Size = UDim2.new(0,430,0,550) 
main.Position = UDim2.new(0.5,-215,0.5,-275) 
main.BackgroundColor3 = Color3.fromRGB(5,5,15) 
main.Active = true 
main.Draggable = true 
main.Visible = false 
main.ClipsDescendants = true
main.ZIndex = 900
Instance.new("UICorner", main).CornerRadius = UDim.new(0,20) 
Instance.new("UIStroke", main).Color = Color3.fromRGB(100,255,255)

if bgAsset then
    local bgImg = Instance.new("ImageLabel", main)
    bgImg.Size = UDim2.new(1,0,1,0)
    bgImg.BackgroundTransparency = 1
    bgImg.Image = bgAsset
    bgImg.ScaleType = Enum.ScaleType.Crop
    bgImg.ImageTransparency = 0.12
    bgImg.ZIndex = 901
end

local titleBar = Instance.new("Frame", main) titleBar.Size = UDim2.new(1,0,0,55) titleBar.BackgroundColor3 = Color3.fromRGB(15,15,25) titleBar.BackgroundTransparency = 0.2 titleBar.ZIndex = 902 Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0,20)
local titleLabel = Instance.new("TextLabel", titleBar) titleLabel.Size = UDim2.new(1,-60,1,0) titleLabel.Position = UDim2.new(0,20,0,0) titleLabel.BackgroundTransparency = 1 titleLabel.Text = bgAsset and "KY💀 GEAR HUB ✓" or "KY💀 GEAR HUB" titleLabel.Font = Enum.Font.GothamBlack titleLabel.TextSize = 14 titleLabel.TextColor3 = Color3.fromRGB(255,255,255) titleLabel.TextXAlignment = Enum.TextXAlignment.Left titleLabel.ZIndex = 903
local closeBtn = Instance.new("TextButton", titleBar) closeBtn.Size = UDim2.new(0,36,0,36) closeBtn.Position = UDim2.new(1,-46,0.5,-18) closeBtn.BackgroundColor3 = Color3.fromRGB(90,90,90) closeBtn.Text = "×" closeBtn.Font = Enum.Font.GothamBold closeBtn.TextSize = 20 closeBtn.TextColor3 = Color3.fromRGB(255,255,255) closeBtn.ZIndex = 903 Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0,10)
local scroll = Instance.new("ScrollingFrame", main) scroll.Size = UDim2.new(1,-20,1,-70) scroll.Position = UDim2.new(0,10,0,65) scroll.BackgroundTransparency = 1 scroll.BorderSizePixel = 0 scroll.ScrollBarThickness = 4 scroll.ZIndex = 902 scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
local listLayout = Instance.new("UIListLayout", scroll) listLayout.SortOrder = Enum.SortOrder.Name listLayout.Padding = UDim.new(0,8)
local equipHolder = Instance.new("Folder", screen) equipHolder.Name = "EquipHolder"

-- LOGIC: PENCET LANGSUNG BUKA (ANTI GESER KEPENCET)
local uiOpen = false
local dragStart = nil
local hasDragged = false

local function openUI()
    uiOpen = true
    main.Visible = true
    kyStroke.Color = Color3.fromRGB(0,255,100)
    kyBtn.Text = "CLOSE"
end

local function closeUI()
    uiOpen = false
    main.Visible = false
    kyStroke.Color = Color3.fromRGB(100,255,255)
    kyBtn.Text = "KY💀"
end

-- BISA DIGESER TAPI KALO CUMA DI PENCET (GAK GESER JAUH) LANGSUNG BUKA
kyBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragStart = input.Position
        hasDragged = false
    end
end)

kyBtn.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        if not hasDragged and dragStart then
            -- INI PENCET, BUKAN GESER, LANGSUNG BUKA/TUTUP
            if uiOpen then closeUI() else openUI() end
        end
        dragStart = nil
        hasDragged = false
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragStart and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        if (input.Position - dragStart).Magnitude > 15 then
            hasDragged = true -- KALO GESER JAUH, ANGGAP LAGI GESER PINDAH, JANGAN BUKA UI
        end
    end
end)

closeBtn.MouseButton1Click:Connect(closeUI)
closeBtn.TouchTap:Connect(closeUI)

-- GEAR LOGIC SAMA
local function equipTool(toolName)
    task.spawn(function()
        local char = player.Character or player.CharacterAdded:Wait()
        local backpack = player:WaitForChild("Backpack")
        local targetTool for i=1,15 do targetTool = backpack:FindFirstChild(toolName) or char:FindFirstChild(toolName) if targetTool then break end task.wait(0.1) end
        if not targetTool or targetTool.Parent == char then return end
        for _, t in pairs(char:GetChildren()) do if t:IsA("Tool") and t.Name ~= toolName then t.Parent = backpack end end
        task.wait(0.05) pcall(function() char:WaitForChild("Humanoid"):UnequipTools() end) task.wait(0.08)
        targetTool.Parent = char
    end)
end

local function createEquipButton(toolName)
    if activeEquips[toolName] then return activeEquips[toolName] end
    local realTool = player:WaitForChild("Backpack"):FindFirstChild(toolName) or (player.Character and player.Character:FindFirstChild(toolName))
    local count = 0 for _ in pairs(activeEquips) do count+=1 end
    local btn = Instance.new("ImageButton", equipHolder) btn.Name = toolName btn.Size = UDim2.new(0,70,0,70) btn.Position = UDim2.new(1, -90 - (count%4)*80, 0, 0.15 + math.floor(count/4)*0.22, 0) btn.BackgroundColor3 = Color3.fromRGB(35,35,35) btn.Image = (realTool and realTool.TextureId ~= "" and realTool.TextureId) or "rbxassetid://6031075931" btn.ScaleType = Enum.ScaleType.Fit btn.ZIndex = 1000 Instance.new("UICorner", btn).CornerRadius = UDim.new(0,14) Instance.new("UIStroke", btn).Color = Color3.fromRGB(70,70,70)
    local cdLabel = Instance.new("TextLabel", btn) cdLabel.Size = UDim2.new(1,0,1,0) cdLabel.BackgroundTransparency = 1 cdLabel.Text = "" cdLabel.Font = Enum.Font.GothamBlack cdLabel.TextSize = 24 cdLabel.TextColor3 = Color3.fromRGB(255,255,255) cdLabel.TextStrokeTransparency = 0 cdLabel.ZIndex = 1001 cdLabel.Visible = false
    local overlay = Instance.new("Frame", btn) overlay.Size = UDim2.new(1,0,1,0) overlay.BackgroundColor3 = Color3.fromRGB(0,0,0) overlay.BackgroundTransparency = 0.35 overlay.Visible = false overlay.ZIndex = 1000 Instance.new("UICorner", overlay).CornerRadius = UDim.new(0,14)
    local data = {btn=btn, cdLabel=cdLabel, overlay=overlay, locked=false, size=70, dragging=false, dragStart=nil, startPos=nil, inCooldown=false}
    local function startCD()
        if data.inCooldown then return end
        data.inCooldown = true cdLabel.Visible = true overlay.Visible = true
        task.spawn(function()
            local startTime = tick() local lastVal = nil
            while data.inCooldown and btn.Parent do
                local char = player.Character local tool = char and char:FindFirstChild(toolName) or player.Backpack and player.Backpack:FindFirstChild(toolName)
                local realCD = tool and (tool:GetAttribute("Cooldown") or tool:GetAttribute("CD") or tool:GetAttribute("CooldownRemaining"))
                if realCD and realCD > 0 then lastVal = realCD cdLabel.Text = string.format("%.1f", realCD) startTime = tick() task.wait(0.05)
                else if lastVal then lastVal -= 0.1 if lastVal <= 0 then break end cdLabel.Text = string.format("%.1f", lastVal) task.wait(0.1) else task.wait(0.2) if tick() - startTime > 2 then break end end end
            end
            cdLabel.Visible = false overlay.Visible = false cdLabel.Text = "" data.inCooldown = false
        end)
    end
    data.startCD = startCD
    btn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if data.locked then equipTool(toolName) return end
            data.dragging = false data.dragStart = input.Position data.startPos = btn.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then if not data.dragging then equipTool(toolName) end data.dragStart = nil task.wait(0.05) data.dragging = false end end)
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if not data.dragStart or data.locked then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            local delta = input.Position - data.dragStart if delta.Magnitude > 10 then data.dragging = true end
            if data.dragging then btn.Position = UDim2.new(data.startPos.X.Scale, data.startPos.X.Offset + delta.X, data.startPos.Y.Scale, data.startPos.Y.Offset + delta.Y) end
        end
    end)
    activeEquips[toolName] = data return data
end

local function hookTool(tool)
    if not tool:IsA("Tool") then return end
    if toolConnections[tool] then return end
    toolConnections[tool] = tool.Activated:Connect(function()
        task.wait(0.1)
        local data = activeEquips[tool.Name]
        if data and data.startCD then data.startCD() end
    end)
end

local function createItemRow(tool)
    if not tool:IsA("Tool") then return end
    if scroll:FindFirstChild(tool.Name) then return end
    local row = Instance.new("Frame", scroll) row.Name = tool.Name row.Size = UDim2.new(1,-10,0,62) row.BackgroundColor3 = Color3.fromRGB(15,15,15) row.BackgroundTransparency = 0.2 row.ZIndex = 903 Instance.new("UICorner", row).CornerRadius = UDim.new(0,13) Instance.new("UIStroke", row).Color = Color3.fromRGB(45,45,45)
    local icon = Instance.new("ImageLabel", row) icon.Size = UDim2.new(0,46,0,46) icon.Position = UDim2.new(0,8,0.5,-23) icon.BackgroundColor3 = Color3.fromRGB(30,30,30) icon.Image = (tool.TextureId ~= "" and tool.TextureId) or "rbxassetid://6031075931" icon.ScaleType = Enum.ScaleType.Fit icon.ZIndex = 904 Instance.new("UICorner", icon).CornerRadius = UDim.new(0,11)
    local nameLabel = Instance.new("TextLabel", row) nameLabel.Size = UDim2.new(1,-155,1,0) nameLabel.Position = UDim2.new(0,64,0,0) nameLabel.BackgroundTransparency = 1 nameLabel.Text = tool.Name nameLabel.Font = Enum.Font.GothamMedium nameLabel.TextSize = 13 nameLabel.TextColor3 = Color3.fromRGB(255,255,255) nameLabel.TextXAlignment = Enum.TextXAlignment.Left nameLabel.TextTruncate = Enum.TextTruncate.AtEnd nameLabel.ZIndex = 904
    local setBtn = Instance.new("TextButton", row) setBtn.Size = UDim2.new(0,32,0,32) setBtn.Position = UDim2.new(1,-106,0.5,-16) setBtn.BackgroundColor3 = Color3.fromRGB(30,30,30) setBtn.Text = "⚙" setBtn.Font = Enum.Font.GothamBold setBtn.TextSize = 16 setBtn.TextColor3 = Color3.fromRGB(140,140,140) setBtn.ZIndex = 904 Instance.new("UICorner", setBtn).CornerRadius = UDim.new(0,8)
    local toggle = Instance.new("TextButton", row) toggle.Size = UDim2.new(0,56,0,32) toggle.Position = UDim2.new(1,-68,0.5,-16) toggle.BackgroundColor3 = activeEquips[tool.Name] and Color3.fromRGB(255,255,255) or Color3.fromRGB(30,30,30) toggle.Text = activeEquips[tool.Name] and "ON" or "OFF" toggle.Font = Enum.Font.GothamBold toggle.TextSize = 12 toggle.TextColor3 = activeEquips[tool.Name] and Color3.fromRGB(5,5,5) or Color3.fromRGB(140,140,140) toggle.ZIndex = 904 Instance.new("UICorner", toggle).CornerRadius = UDim.new(0,8)
    local popup = Instance.new("Frame", row) popup.Size = UDim2.new(1,0,0,48) popup.Position = UDim2.new(0,0,1,6) popup.BackgroundColor3 = Color3.fromRGB(10,10,10) popup.Visible = false popup.ZIndex = 905 Instance.new("UICorner", popup).CornerRadius = UDim.new(0,10) Instance.new("UIStroke", popup).Color = Color3.fromRGB(255,255,255)
    local lockBtn = Instance.new("TextButton", popup) lockBtn.Size = UDim2.new(0,120,0,28) lockBtn.Position = UDim2.new(0,8,0.5,-14) lockBtn.BackgroundColor3 = Color3.fromRGB(30,30,30) lockBtn.Text = "🔓 LOCK: OFF" lockBtn.Font = Enum.Font.GothamBold lockBtn.TextSize = 11 lockBtn.TextColor3 = Color3.fromRGB(140,140,140) lockBtn.ZIndex = 906 Instance.new("UICorner", lockBtn).CornerRadius = UDim.new(0,7)
    local plusBtn = Instance.new("TextButton", popup) plusBtn.Size = UDim2.new(0,60,0,28) plusBtn.Position = UDim2.new(0,136,0.5,-14) plusBtn.BackgroundColor3 = Color3.fromRGB(30,30,30) plusBtn.Text = "SIZE +" plusBtn.Font = Enum.Font.GothamBold plusBtn.TextSize = 11 plusBtn.TextColor3 = Color3.fromRGB(255,255,255) plusBtn.ZIndex = 906 Instance.new("UICorner", plusBtn).CornerRadius = UDim.new(0,7)
    local minBtn = Instance.new("TextButton", popup) minBtn.Size = UDim2.new(0,60,0,28) minBtn.Position = UDim2.new(0,202,0.5,-14) minBtn.BackgroundColor3 = Color3.fromRGB(30,30,30) minBtn.Text = "SIZE -" minBtn.Font = Enum.Font.GothamBold plusBtn.TextSize = 11 minBtn.TextColor3 = Color3.fromRGB(255,255,255) minBtn.ZIndex = 906 Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0,7)
    local isOn = activeEquips[tool.Name] ~= nil
    local isPopupOpen = false
    setBtn.MouseButton1Click:Connect(function() isPopupOpen = not isPopupOpen popup.Visible = isPopupOpen if isPopupOpen then row.Size = UDim2.new(1,-10,0,118) else row.Size = UDim2.new(1,-10,0,62) end end)
    toggle.MouseButton1Click:Connect(function() isOn = not isOn if isOn then toggle.Text="ON" toggle.BackgroundColor3=Color3.fromRGB(255,255,255) toggle.TextColor3=Color3.fromRGB(5,5,5) createEquipButton(tool.Name) else toggle.Text="OFF" toggle.BackgroundColor3=Color3.fromRGB(30,30,30) toggle.TextColor3=Color3.fromRGB(140,140,140) if activeEquips[tool.Name] then activeEquips[tool.Name].btn:Destroy() activeEquips[tool.Name]=nil end end end)
    lockBtn.MouseButton1Click:Connect(function() local data = activeEquips[tool.Name] if not data then data = createEquipButton(tool.Name) isOn=true toggle.Text="ON" toggle.BackgroundColor3=Color3.fromRGB(255,255,255) toggle.TextColor3=Color3.fromRGB(5,5,5) end data.locked = not data.locked if data.locked then lockBtn.Text="🔒 LOCK: ON" lockBtn.BackgroundColor3=Color3.fromRGB(0,255,100) lockBtn.TextColor3=Color3.fromRGB(5,5,5) else lockBtn.Text="🔓 LOCK: OFF" lockBtn.BackgroundColor3=Color3.fromRGB(30,30,30) lockBtn.TextColor3=Color3.fromRGB(140,140,140) end end)
    plusBtn.MouseButton1Click:Connect(function() local data = activeEquips[tool.Name] if not data then data = createEquipButton(tool.Name) isOn=true toggle.Text="ON" toggle.BackgroundColor3=Color3.fromRGB(255,255,255) toggle.TextColor3=Color3.fromRGB(5,5,5) end data.size = math.clamp(data.size + 6, 32, 120) data.btn.Size = UDim2.new(0,data.size,0,data.size) end)
    minBtn.MouseButton1Click:Connect(function() local data = activeEquips[tool.Name] if not data then data = createEquipButton(tool.Name) isOn=true toggle.Text="ON" toggle.BackgroundColor3=Color3.fromRGB(255,255,255) toggle.TextColor3=Color3.fromRGB(5,5,5) end data.size = math.clamp(data.size - 6, 32, 120) data.btn.Size = UDim2.new(0,data.size,0,data.size) end)
end

local function scanInventory()
    local char = player.Character if not char then return end
    local backpack = player:FindFirstChild("Backpack") if not backpack then return end
    for _, item in ipairs(backpack:GetChildren()) do if item:IsA("Tool") then createItemRow(item) hookTool(item) end end
    for _, item in ipairs(char:GetChildren()) do if item:IsA("Tool") then createItemRow(item) hookTool(item) end end
end

scanInventory()
player:WaitForChild("Backpack").ChildAdded:Connect(function(tool) task.wait(0.3) if tool:IsA("Tool") then createItemRow(tool) hookTool(tool) end end)

print("KY💀 V21 FINAL - PENCET BUKA + GESER PINDAH + BG BERSIH LOADED")
