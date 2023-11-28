
# PandaAuth
PandaAuth is a service providing a secure key system.
## Documentation
### Symbols
```lua
...: vararg
<...>: required
[...]: optional
```
### PandaAuth
```lua
local PandaAuth = loadstring(game:HttpGet('https://pandadevelopment.net/service_api/PandaBetaLib.lua'))(): table
```
Once loaded, it'll return a table.

The code below will visualize the returned value.
```lua
PandaAuth = {
	GetLink: function;
	ValidateKey: function;
	ValidateNormalKey: function;
	ValidatePremiumKey: function;
}
```
Moving onto the next step, documenting each function and arguments!
### Service Argument
The service argument must be entirely lowercase.

For example:
```lua
Correct:
	PandaAuth:GetLink("service"): string
	PandaAuth:ValidateKey("service", "Key_Example")
	
Incorrect:
	PandaAuth:GetLink("Service"): string
	PandaAuth:ValidateKey("Service", "Key_Example")
```
### GetLink
```lua
PandaAuth:GetLink(<Service>: string): string
```
GetLink will return a string or specifically an URL for the user to paste in a browser.
### ValidateKey: Normal & Premium
```lua
PandaAuth:ValidateKey(<Service>: string, <Key>: string): boolean
```
ValidateKey will return a boolean to determine whether the key is valid for that service.

(ValidateNormalKey and ValidatePremiumKey accepts the same arguments as ValidateKey and their identifier is self explanatory.)
## Example
```lua
local PandaAuth = loadstring(game:HttpGet('https://pandadevelopment.net/service_api/PandaBetaLib.lua'))()

local Service = ("Service"):lower()

if type(PandaAuth) == "table" then
	local URL = PandaAuth:GetLink(Service)
	
	local Valid = PandaAuth:ValidateKey(Service, "Key_Example")
	
	if Valid then
		warn("Key is valid")
	else
		warn("Key is invalid")
	end
end
```
Make sure to add security!
