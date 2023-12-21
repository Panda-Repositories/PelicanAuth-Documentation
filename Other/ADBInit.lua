game.StarterGui:SetCore("SendNotification", {
    Title = "Panda ADB-Sideload (Beta)"; -- the title (ofc)
    Text = "Successfully Executed"; -- what the text says (ofc)
    Icon = "rbxassetid://5179834418"; -- the image if u want. 
    Duration = 3; -- how long the notification should in secounds
    })

local ADB_Ready = "Ready"
local ADBShellExecution = true
local ADB_scriptFilePath = "executed_script.lua"
while true do
    wait(0.1)
    if ADBShellExecution == true then         
        local content = readfile(ADB_scriptFilePath)        
        if not content or content ~= ADB_Ready then
            if content then
                -- Attempt to execute the script in a protected call
                local success, result = pcall(function()
                    -- runcode(tostring(content))
                    loadstring(content)()
                end)
    
                -- Check if the execution was successful
                if not success then
                    -- Handle the error (replace this with your specific error-handling logic)
                    warn("[Error ADB Executing Script]: " .. result)
                end
            end    
            writefile(ADB_scriptFilePath, tostring(ADB_Ready)) -- Update the file with the key
        end
    end
end
