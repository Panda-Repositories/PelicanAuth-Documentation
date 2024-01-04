#include <Windows.h>
#include <shellapi.h>
#include <iostream>
#include <string>
#include <cpr/cpr.h>
#include "../Tools.h"

#include <thread> // Include the thread header

#define DebugValidation false //Set this Enable to Show the Validation Debug, Usually to make sur the Hardwar ID are matched & the status

std::string ServiceDomain = "https://auth.pandadevelopment.net/failsafeValidation";

std::string GetSHAHashed(std::string exploitName, std::string rawData) {
    std::string HashedData = std::string(Tools.DownloadURL(ServiceDomain + "/serviceapi?service=" + exploitName + "&command=hashed&param=" + rawData));
    return HashedData;
}

Json::Value JSON;

void ConsoleWrite(std::string Text) {
    if (DebugValidation) {
       std::cout << Text << std::endl;
    }
}
// Function to sleep for a specified duration in milliseconds (Optional)
void sleepMilliseconds(int milliseconds) {
    std::this_thread::sleep_for(std::chrono::milliseconds(milliseconds));
}

// Define GetSHAHashed and Tools.DownloadURL functions if not already defined

bool validateKey(std::string exploitName, std::string hwid, std::string key) {
    std::string DataNet = ServiceDomain + "?service=" + exploitName + "&hwid=" + hwid + "&key=" + key;
    std::string EncryptedKeys = std::string(Tools.DownloadURL(DataNet));
    sleepMilliseconds(500);
    // JsonCpp variables
    Json::Value root;
    JSONCPP_STRING err;

    // Parse the JSON
    Json::CharReaderBuilder builder;
    const std::unique_ptr<Json::CharReader> reader(builder.newCharReader());
    if (!reader->parse(EncryptedKeys.c_str(), EncryptedKeys.c_str() + EncryptedKeys.length(), &root, &err)) {
        ConsoleWrite( "JSON Parser Error: " + err );
        return false;
    }

    // Extract values
    std::string devId = root.get("dev_id", "").asString();
    std::string status = root.get("status", "").asString();
    std::string Current_DeviceID = Tools.ConverToLower(GetSHAHashed(exploitName, Tools.getHardwareID()));
    // Output values for testing

    ConsoleWrite( "dev_id: " + devId);
    ConsoleWrite( "dev_id: " + Current_DeviceID);
    ConsoleWrite( "------------------------------------");
    ConsoleWrite("status: " + status);

    // Compare and return result
    if (!devId.empty() && !status.empty())
    {
        if (devId != Current_DeviceID) {
            ConsoleWrite( "Mismatched Hardware ID");
            return false;
        }
        else if (status == "success")        
            return true;        
        ConsoleWrite("Invalid");
        return false;
    }
    else {
        ConsoleWrite("Blank JSON");
        return false;
    }
}



std::string generateKey(std::string exploitName, std::string hwid) {
    return std::format("{}/getkey?service={}&hwid={}", ServiceDomain, exploitName, hwid);
}

int main() {
    std::string exploitName = "pandadevkit"; //replace this with your sevice id
    std::string exploitHwid = Tools.getHardwareID(); // do ur hwid stuff here
    std::string answer;
    std::string key;

    std::cout << "Do you want to get a key? (y or n)" << std::endl;
    std::getline(std::cin, answer);
    
    if (answer == "y") {
        ShellExecute(0, 0, generateKey(exploitName, exploitHwid).c_str(), 0, 0, SW_SHOW);
    }

getKey:
    std::cout << "Enter Key: ";
    std::getline(std::cin, key);

    if (validateKey(exploitName, exploitHwid, key) == false) {
        std::cout << "Invalid Key!" << std::endl;
        key.clear();
        goto getKey;
    }


    std::cout << "Key valid!" << std::endl;
    std::system("pause");
    return 0;
}
