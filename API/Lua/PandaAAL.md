# Welcome to Panda Auth AAL LuaU library official documentation !

# Installation 🔌
First you need an executor (ofc)
```lua
local PandaAuth = loadstring(game:HttpGet("https://pandadevelopment.net/servicelib?service=servicename&core=roblox&param=testing"))() : table
```
The PandaAuth loadstring will return a table.
Here are all the differents functions into PandaAuth 
```lua
PandaAuth:ValidateKey ----> Global key
PandaAuth:ValidatePremiumKey ---> Premium key check
PandaAuth:ValidateNormalKey ----> Non-premium key check
PandaAuth:ResetHWID ----> Reset associated HWID of key
PandaAuth:GetKey ----> Return get key link and set it to clipboard
```

# Setup 🏳️
To setup Panda Library, call this function
```lua
PandaAuth:Set({
    Service = "landhub", ---- your service name
    APIToken = "idiot", ---- api token on dashboard 
    Debug = false, --- true/false
    ViginereKey = "supermariobros", ---- any key will work
    TrueEndpoint = "supermario_v", ---- try make something hard to understand 
    FalseEndpoint = "supermario_f" ----- try make something hard to understand 
})
```

Explaning each args :
- Service : This is your service ID
- APIToken this is the thing you have set on your dashboard https://cdn.discordapp.com/attachments/1095687141704605696/1199026014962077726/image.png?ex=65c10afe&is=65ae95fe&hm=49cc48ec4df1394ba1f9ac4653d76be29c6764f7f01101c90428c5453b89371e&
- Debug : Will output bunch of warns if you need help
- ViginereKey : This is a key to decrypt viginere cypher, check the plan for more
- TrueEndpoint : This is the string that will be hashed if your key is validated
- FalseEndpoint : This is the string that will be hashed if your key is not validated

Plan on how PandaAuth's validation works :
```lua
[OnKeyValidate]
  |
  +-- 1. Make API Request:
       - Construct URL with service, hardware ID, and key.
       - Use GET method to send the request.
  |
  +-- 2. Handle API Response:
       - Check response status code.
       - If 200 (OK):
         - Decrypt response body using XOR and API token.
         - Parse decrypted text as JSON.
       - If not 200:
         - Check specific response codes (401, 404, 406, etc.).
  |
  +-- 3. Validate Authorization:
       - Check if the service in the response matches the internal service.
       - Check if the success message is valid.
  |
  +-- 4. Handle Validations:
       - If authorized and valid, log success and return encrypted result.
       - If unauthorized or other specific cases, log relevant debug messages and return encrypted result of the False endpoint.
  |
  +-- 5. Error Handling:
       - Handle different HTTP response codes and exceptions.
  |
  +-- 6. Return Encrypted Result:
       - If validation is successful, [PandaAuth:ValidateKey]
  |
  +-- 1. Make API Request:
       - Construct URL with service, hardware ID, and key.
       - Use GET method to send the request.
  |
  +-- 2. Handle API Response:
       - Check response status code.
       - If 200 (OK):
         - Decrypt response body using XOR and API token.
         - Parse decrypted text as JSON.
       - If not 200:
         - Check specific response codes (401, 404, 406, etc.).
  |
  +-- 3. Validate Authorization:
       - Check if the service in the response matches the internal service.
       - Check if the success message and expiration time are valid.
  |
  +-- 4. Handle Validations:
       - If authorized and valid, log success and return encrypted result.
       - If unauthorized or other specific cases, log relevant debug messages.
  |
  +-- 5. Error Handling:
       - Handle different HTTP response codes and exceptions.
  |
  +-- 6. Return Encrypted Result:
       - If validation is successful, hash the TrueEndpoint and encrypt it with Viginere Cypher.
       
       - If there's an error, hash the FalseEndpoint and encrypt it with Viginere Cypher.
```

# Validating 
Since I'm lazy to implement validate shit ill give you guys a working example
