
# PandaAuth
PandaAuth is a service providing a secure key system.

## Documentation
```lua
...: vararg
<...>: required
[...]: optional
```

```lua
local PandaAuth = loadstring(game:HttpGet('https://pandadevelopment.net/service_api/PandaBetaLib.lua'))(): table
```

Once loaded, it'll return a table and the code below will visualize the returned value
```lua
PandaAuth = {
	GetLink: function;
	ValidateKey: function;
	ValidateNormalKey: function;
	ValidatePremiumKey: function;
}
```
moving on documenting each function
### GetLink
```lua
PandaAuth:GetLink(<Service>): string
```
GetLink will return a string or specifically an url for the user to paste in a browser
