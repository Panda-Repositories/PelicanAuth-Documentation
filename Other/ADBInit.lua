game.StarterGui:SetCore("SendNotification", {
    Title = "Panda ADB-Sideload (Beta)"; -- the title (ofc)
    Text = "Successfully Executed"; -- what the text says (ofc)
    Icon = "rbxassetid://5179834418"; -- the image if u want. 
    Duration = 3; -- how long the notification should in secounds
    })

warn('Panda ADB-Development ( Windows ADB Sideloaded) for Delta')
local key = "Ready"
local scriptFilePath = "executed_script.lua"
writefile(scriptFilePath, tostring(key))

while true do
    wait(0.2) -- Wait for 1 second before checking again
    local content = readfile(scriptFilePath)
    
    if not content or content ~= key then
        if content then
            -- Attempt to execute the script in a protected call
            local success, result = pcall(function()
                local identifiershit = identifyexecutor()
                -- Check if identifiershit contains the substring "Delta"
                if identifiershit and string.find(identifiershit:lower(), "delta") then
                    runcode(script)
                else
                    loadstring(script)() -- Universal bruhh
                end
            end)

            -- Check if the execution was successful
            if not success then
                -- Handle the error (replace this with your specific error-handling logic)
                print("[Error Executing Script]: " .. result)
            else
                print("[Script Executed]")
            end
        end

        writefile(scriptFilePath, tostring(key)) -- Update the file with the key
    end
end

