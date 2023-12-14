# Pelican Authentication ( CSharp Client )


[![Panda_Build_Status](https://ci.appveyor.com/api/projects/status/2vvwieg2ou7pkhst?svg=true)]()
## Add Pelican to your Header

```csharp
using Panda_Pelican_Libraries___CSharp_Version__;
```

## [ Get Key ] - Open Chrome Browser / MS-Edge in Incognito Mode

```csharp
string hardwareID = HardwareID(); //Your own Hardware ID Function
string ServiceID = "your_identifier"
new PelicanAuthLib().LaunchSecureBrowser(ServiceID, hardwareID);
```
## [ Validate ] - Regular Key & Premium Key
Upon the Validation of the Client's Key, their is a two ways, Regular Key & Premium Key ( Which is generated from Dashboard or upon generated from the Owner's Respective Command.
```csharp
string hardwareID = HardwareID(); //Your own Hardware ID Function
string ServiceID = "your_identifier"
if (new PelicanAuthLib().VerifyKey("pandadevkit", a, "testcsharp"))
{
        Console.WriteLine("Key Accepted!");
}
else
{
        Console.WriteLine("Key Invalid. Please try again");
}
```
For Premium Key Validation, Here is the parameter 
```csharp
string hardwareID = HardwareID(); //Your own Hardware ID Function
string ServiceID = "your_identifier"
if (new PelicanAuthLib().VerifyPremiumKey("pandadevkit", a, "testcsharp"))
{
  Console.WriteLine("Key is Premium Generated");
}
else
{
  Console.WriteLine("Key is not Premium Generated");
}
```
