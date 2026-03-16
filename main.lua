local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- Начало библиотеки локальных функций/моделей/переменных

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local codes = {"ITSTHEBILLION!","1MIL80K","FLYING1M80K"}

 -- UI + секции, кнопки, кнопки

local Window = WindUI:CreateWindow({
    Title = "Fistashka-Hub",
    Icon = "brain-circuit", -- lucide icon
    Author = "Made by Kelios",
    Folder = "BrainCellHigh",

    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
            print("clicked")
        end,
    },
    
    --       remove this all, 
    -- !  ↓  if you DON'T need the key system
    KeySystem = { 
        -- ↓ Optional. You can remove it.
        Key = game:HttpGet("https://raw.githubusercontent.com/candyblossomn559-bit/Nothin/refs/heads/main/ntm.lua"),
        
        Note = "Script in pre-alpha, and got only auto-spin now(",
        
        -- ↓ Optional. You can remove it.
        URL = game:HttpGet("https://raw.githubusercontent.com/CobaltVQQQ0/Fruit-Battlegrounds-auto-spin/refs/heads/main/link.lua"),
        
        -- ↓ Optional. You can remove it.
        SaveKey = false, -- automatically save and load the key.
        
    },
})

local Tab = Window:Tab({
    Title = "Main",
    Icon = "lightbulb", -- optional
    Locked = false,
})

Tab:Select()

local Button = Tab:Button({
    Title = "Redeem active codes",
    Desc = "",
    Locked = false,
    Callback = function()
        for i,v in pairs(codes) do
        local string_1 = "Codes";
        local string_2 = "Redeem";
        local table_1 = {
        ["Code"] = v
        };
        game:GetService("ReplicatedStorage").Replicator:InvokeServer(string_1, string_2, table_1);
        end
    end
})

local Dropdown = Tab:Dropdown({
    Title = "Rarity priority",
    Desc = "Choose rarity for auto-spin",
    Values = {
        {
            Title = "Legendary+",
            Icon = "apple"
        },
        {
            Title = "Mythic",
            Icon = "apple"
        },
    },
    Value = "Unselected",
    Callback = function(option)
        globalCloud = option.Title
    end
})

local Toggle = Tab:Toggle({
    Title = "Auto-Spin",
    Desc = "Choose rarity priority before start",
    Icon = "check",
    Type = "Toggle",
    Value = false,
    Callback = function(state)
        _G.AutoSpin = state
        
        if state then
            task.spawn(function()
                local player = game.Players.LocalPlayer
                local mainData = player:WaitForChild("MAIN_DATA")
                local target = game:GetService("ReplicatedStorage"):WaitForChild("Replicator")
                
                local wantedfruits = {}
                if globalCloud == "Mythic" then
                    wantedfruits = {"Lightning","Nika","DragonV2","Soul","DarkXQuake","Okuchi","DoughV2","LeopardV2","Impact","OpeV2"}
                else
                    wantedfruits = {"Quake","Gravity","Phoenix","TSRubber","Dragon","Dough","Magnet","Leopard","Ope","Venom","MagmaV2","IceV2","LightV2","FlameV2","Lightning","Nika","DragonV2","Soul","DarkXQuake","Okuchi","DoughV2","LeopardV2","Impact","OpeV2"}
                end

                while _G.AutoSpin do                    local currslot = mainData.Slot.Value
                    local currfruit = mainData.Slots[currslot].Value

                    if table.find(wantedfruits, currfruit) then
                        print("Target fruit found: " .. currfruit)
                        break
                    end

                    target:InvokeServer("FruitsHandler", "Spin", {})
                    task.wait(5.1)
                end
                print("END")
            end)
        end
    end
})
