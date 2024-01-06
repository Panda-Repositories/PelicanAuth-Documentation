local oldscript = script -- This is important please dont delete it

-- SETTINGS --
local ServiceName = "pandadevkit"
local HubName = "Pandadevkit"
local KeyFile = "panda.txt"
local Icon = "rbxassetid://14692801693"
local Description = "Click 'Get Key' button to get your key!";
local SaveKey = true
local Draggable = true -- Make Ui Draggable

-- PANDA AUTH --
local PandaAuth = loadstring(game:HttpGet('https://pandadevelopment.net/service_api/PandaAuthBeta2.lua'))()
local Notify = loadstring(game:HttpGet("https://raw.githubusercontent.com/x9PSwiftz/Panda/main/Notification.lua"))()

-- SCRIPT --
local function Script()
    -- Put your script here
    -- PandaAuth:LoadScript Example
    local User = {"Encrypted","SkieHacker OwO","9PASA"} -- Fake
    local Fake = {"example","Minecraft","BloxFruit"} -- Fake Script Github Name
    -- PandaAuth:LoadScript(<table> FakeUserTable, <string> FakeScriptName, <table> FakeGithubName, <string> script url link) 
    PandaAuth:LoadScript(User,"Panda",Fake,"https://raw.githubusercontent.com/x9PSwiftz/Panda/main/Example")
end

-- IMPORTANT -----------------------
if islclosure(getgenv().setfenv) then while true do end end -- ANTI SETFENV TAMPERING
if islclosure(getgenv().tostring) then while true do end end -- ANTI TOSTRING TAMPERING
if PandaAuth.GetLink and PandaAuth.LoadScript and PandaAuth.ValidateKey and PandaAuth.SaveKey and PandaAuth.LoadKey then
else -- ANTI Tampering
    while true do end
end
------------------------------------

local function RandomString(length)
    local randomString = ""
    for i = 1, length do
        local randomNumber = math.random(97, 122)
        randomString = randomString .. string.char(randomNumber)
    end
    return tostring(randomString)
end

-- CHECK FOR KEY SYSTEM --
function RemoveKeyUI()
    do
        local keyui = game.CoreGui:FindFirstChild("Panda Key System")
        if keyui then
            keyui:Destroy()
        end
    end
end
RemoveKeyUI()

-- TWEEN GUI --
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
 
local function MakeDraggable(topbarobject, object)
    local Dragging = nil
    local DragInput = nil
    local DragStart = nil
    local StartPosition = nil
 
    local function Update(input)
        local Delta = input.Position - DragStart
        local pos =
            UDim2.new(
                StartPosition.X.Scale,
                StartPosition.X.Offset + Delta.X,
                StartPosition.Y.Scale,
                StartPosition.Y.Offset + Delta.Y
            )
        local Tween = TweenService:Create(object, TweenInfo.new(0.2), {Position = pos})
        Tween:Play()
    end
 
    topbarobject.InputBegan:Connect(
        function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                Dragging = true
                DragStart = input.Position
                StartPosition = object.Position
 
                input.Changed:Connect(
                    function()
                        if input.UserInputState == Enum.UserInputState.End then
                            Dragging = false
                        end
                    end
                )
            end
        end
    )
 
    topbarobject.InputChanged:Connect(
        function(input)
            if
                input.UserInputType == Enum.UserInputType.MouseMovement or
                input.UserInputType == Enum.UserInputType.Touch
            then
                DragInput = input
            end
        end
    )
 
    UserInputService.InputChanged:Connect(
        function(input)
            if input == DragInput and Dragging then
                 Update(input)
            end
        end
    )
end

-- MAIN GUI --
local instance = {obj = {}}
function instance.new(class, properties)
    local inst = Instance.new(class)
    for property, value in next, properties do
        inst[property] = value
    end
    table.insert(instance.obj, inst)
    return inst
end

local object = instance.obj

object.PandaKeySystem = instance.new("ScreenGui", {
    Name = "Panda Key System";
    Parent = game.CoreGui;
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
})

object.Main = instance.new("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5);
    BackgroundColor3 = Color3.fromRGB(17, 24, 39);
    BorderColor3 = Color3.fromRGB(0, 0, 0);
    BorderSizePixel = 0;
    Name = "Main";
    Parent = object.PandaKeySystem;
    Position = UDim2.new(0.492770165, 0, 0.5, 0);
    Size = UDim2.new(0, 380, 0, 200);
})

object.UICorner = instance.new("UICorner", {
    CornerRadius = UDim.new(0, 5);
    Parent = object.Main;
})

object.GetKey = instance.new("TextButton", {
    BackgroundColor3 = Color3.fromRGB(31, 41, 55);
    BorderColor3 = Color3.fromRGB(0, 0, 0);
    BorderSizePixel = 0;
    Font = Enum.Font.Gotham;
    Name = "GetKey";
    Parent = object.Main;
    Position = UDim2.new(0.51810205, 0, 0.742947996, 0);
    Size = UDim2.new(0, 173, 0, 39);
    Text = "Get Key";
    TextColor3 = Color3.fromRGB(225, 225, 225);
    TextSize = 14.000;
})

object.GetKey.MouseButton1Click:Connect(function()
object.TextBox.Text = PandaAuth:GetLink(ServiceName)
setclipboard(PandaAuth:GetLink(ServiceName))
print("[ "..HubName.." ]".." Succesfully copied get key link to clipboard!")
Notify.New("Succesfully copied link!", 2)
end)

object.UICorner = instance.new("UICorner", {
    CornerRadius = UDim.new(0, 5);
    Parent = object.GetKey;
})

object.UIStroke = instance.new("UIStroke", {
    ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    Color = Color3.fromRGB(51, 61, 77);
    LineJoinMode = Enum.LineJoinMode.Round;
    Parent = object.GetKey;
})

object.TextBox = instance.new("TextBox", {
    BackgroundColor3 = Color3.fromRGB(21, 31, 45);
    BorderColor3 = Color3.fromRGB(0, 0, 0);
    BorderSizePixel = 0;
    Font = Enum.Font.SourceSans;
    Parent = object.Main;
    PlaceholderColor3 = Color3.fromRGB(178, 178, 178);
    PlaceholderText = "Enter your key here..";
    Position = UDim2.new(0.0331600793, 0, 0.414063871, 0);
    Size = UDim2.new(0, 357, 0, 50);
    Text = "";
    TextColor3 = Color3.fromRGB(255, 255, 255);
    TextSize = 14.000;
    TextTruncate = Enum.TextTruncate.AtEnd;
    ClearTextOnFocus = false;
})

if SaveKey and isfile(KeyFile) then
    object.TextBox.Text = readfile(KeyFile)
    Notify.New("Succesfully loaded key!", 5)
end

object.UIPadding = instance.new("UIPadding", {
    PaddingLeft = UDim.new(0, 15);
    Parent = object.TextBox;
})

object.UICorner = instance.new("UICorner", {
    Parent = object.TextBox;
})

object.UIStroke = instance.new("UIStroke", {
ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
Color = Color3.fromRGB(51, 61, 77);
LineJoinMode = Enum.LineJoinMode.Round;
Parent = object.TextBox;
})

object.TopBar = instance.new("Frame", {
    BackgroundColor3 = Color3.fromRGB(31, 41, 55);
    BorderColor3 = Color3.fromRGB(0, 0, 0);
    BorderSizePixel = 0;
    Name = "TopBar";
    Parent = object.Main;
    Size = UDim2.new(0, 380, 0, 30);
})

object.UICorner = instance.new("UICorner", {
    CornerRadius = UDim.new(0, 5);
    Parent = object.TopBar;
})

object.Frame = instance.new("Frame", {
    BackgroundColor3 = Color3.fromRGB(51, 61, 77);
    BorderColor3 = Color3.fromRGB(0, 0, 0);
    BorderSizePixel = 0;
    Parent = object.TopBar;
    Position = UDim2.new(0, 0, 1, 0);
    Size = UDim2.new(0, 380, 0, 1);
})

object.TextLabel = instance.new("TextLabel", {
    BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    BackgroundTransparency = 1;
    BorderColor3 = Color3.fromRGB(0, 0, 0);
    BorderSizePixel = 0;
    Font = Enum.Font.GothamMedium;
    Parent = object.TopBar;
    Position = UDim2.new(0, 0, 0, 0);
    Size = UDim2.new(1, 0, 1, 0);
    Text = HubName.." Key System";
    TextColor3 = Color3.fromRGB(186, 186, 186);
    TextSize = 14.000;
})

object.ImageLabel = instance.new("ImageLabel", {
    BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    BackgroundTransparency = 1.000;
    BorderColor3 = Color3.fromRGB(0, 0, 0);
    BorderSizePixel = 0;
    Image = Icon or "rbxassetid://14692801693";
    Parent = object.Main;
    Position = UDim2.new(0.002, 0, 0, 0);
    Size = UDim2.new(0, 35, 0, 35);
})

object.CheckKey = instance.new("TextButton", {
    BackgroundColor3 = Color3.fromRGB(31, 41, 55);
    BorderColor3 = Color3.fromRGB(0, 0, 0);
    BorderSizePixel = 0;
    Font = Enum.Font.Gotham;
    Name = "Check Key";
    Parent = object.Main;
    Position = UDim2.new(0.0305285007, 0, 0.742947996, 0);
    Size = UDim2.new(0, 173, 0, 39);
    Text = "Check Key";
    TextColor3 = Color3.fromRGB(225, 225, 225);
    TextSize = 14.000;
})

object.CheckKey.MouseButton1Click:Connect(function()
    Check_Key()
end)

object.UICorner = instance.new("UICorner", {
    CornerRadius = UDim.new(0, 5);
    Parent = object.CheckKey;
})

object.UIStroke = instance.new("UIStroke", {
    ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    Color = Color3.fromRGB(51, 61, 77);
    LineJoinMode = Enum.LineJoinMode.Round;
    Parent = object.CheckKey;
})

object.Desc = instance.new("TextLabel", {
    BackgroundColor3 = Color3.fromRGB(225, 225, 225);
    BackgroundTransparency = 1.000;
    BorderColor3 = Color3.fromRGB(0, 0, 0);
    BorderSizePixel = 0;
    Font = Enum.Font.Gotham;
    Name = "Desc";
    Parent = object.Main;
    Position = UDim2.new(0.17368421, 0, 0.165000007, 0);
    Size = UDim2.new(0, 247, 0, 50);
    Text = Description or "Click 'Get Key' button to get your key!";
    TextColor3 = Color3.fromRGB(61, 71, 85);
    TextSize = 14.000;
})
if Draggable then
    MakeDraggable(object.TopBar, object.Main)
end

oldstring = RandomString(10)
function Check_Key()
    pcall(function()
        print("[ "..HubName.." ]".." Checking key..")
        Notify.New("Checking key..", 2)
        -- Anti Tampering
        if RandomString(10) == oldstring then return Notify.New("Haha kid want to bypass PandaKeySystem v2", 2) end;oldstring = RandomString(10)
        if PandaAuth:GetLink(ServiceName) == nil or PandaAuth:ValidateKey(ServiceName, object.TextBox.Text..RandomString(10)) then
            return Notify.New("Haha kid want to bypass PandaKeySystem v2", 2)
        elseif PandaAuth:ValidateKey(ServiceName, object.TextBox.Text) then
            print("[ "..HubName.." ]".." Key is correct: "..object.TextBox.Text)
            Notify.New("Key is correct: "..object.TextBox.Text, 3)
            PandaAuth:SaveKey(KeyFile, object.TextBox.Text)
            RemoveKeyUI()
            Script()
        else
            print("[ "..HubName.." ]".." Key is invalid!")
            Notify.New("Key is invalid!", 3)
        end
    end)
end

-- AUTO CHECK --
if SaveKey and isfile(KeyFile) then
    Check_Key()
end

-- This is important please dont delete it {
setfenv(1,{})
script = oldscript
-- }
------------------------------------