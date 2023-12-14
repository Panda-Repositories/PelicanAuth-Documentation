game.StarterGui:SetCore("SendNotification", {
    Title = "Panda ADB-Sideload (Beta)"; -- the title (ofc)
    Text = "Successfully Executed"; -- what the text says (ofc)
    Icon = "rbxassetid://11354741327"; -- the image if u want. 
    Duration = 3; -- how long the notification should in secounds
    })

warn('Panda ADB-Development ( Windows ADB Sideloaded) for Delta')
local key = "Ready"
local scriptFilePath = "executed_script.lua"

function ExecuteScriptCore(script)
    local identifiershit = identifyexecutor();
    if identifiershit == "Delta Android" then
        runcode(script)
    else
        loadstring(script)() -- Universal bruhh
    end
end

while true do
    wait(0.5) -- Wait for 1 second before checking again
    local content = readfile(scriptFilePath)
    if not content or content ~= key then
        if content then
            -- loadstring(content)() -- Execute the script if content is not null and not equal to the key
            ExecuteScriptCore(content)
        end
        wait(1) -- Wait for 1 second before checking again
        writefile(scriptFilePath, tostring(key)) -- Update the file with the key
    end
end
