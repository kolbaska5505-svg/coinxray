local menu = loadstring(game:HttpGet("https://pastebin.com/raw/bsgK22Zy"))()

local peach = Color3.fromRGB(255, 200, 150)
local highlighted = {}
local scanConnection = nil

local function scan()
    for _, obj in workspace:GetChildren() do
        local container = obj:FindFirstChild("CoinContainer") or (obj.Name == "CoinContainer" and obj)
        
        if container and not highlighted[container] then
            highlighted[container] = true
            
            local hl = Instance.new("Highlight")
            hl.FillColor = peach
            hl.FillTransparency = 0.3
            hl.OutlineColor = peach
            hl.OutlineTransparency = 0.1
            hl.Parent = container
        end
    end
end

local function clearHighlights()
    for obj, _ in pairs(highlighted) do
        local hl = obj:FindFirstChild("Highlight")
        if hl then
            hl:Destroy()
        end
    end
    highlighted = {}
end

local myMenu = menu({
    MenuName = "Coin X-ray",
    CheckTexts = {"Coin X-ray"},
    OnToggles = {
        function(state)
            if state then
                scan()
                scanConnection = workspace.ChildAdded:Connect(scan)
            else
                if scanConnection then
                    scanConnection:Disconnect()
                    scanConnection = nil
                end
                clearHighlights()
            end
        end
    }
})

if myMenu:GetChecked(1) then
    scan()
    scanConnection = workspace.ChildAdded:Connect(scan)
end