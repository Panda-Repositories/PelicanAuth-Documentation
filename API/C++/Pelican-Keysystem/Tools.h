#include <windows.h>
#include <string>
#include <algorithm>
#include <iostream>
#include <TlHelp32.h>
#include <WinInet.h>
#include "JSON/dist/json/json.h"


#include "cURL/include/curl/curl.h"

#pragma comment(lib, "wininet.lib")

struct Tools {
    std::string getHardwareID();
    std::string ConverToUpper(const std::string& input);
    std::string DownloadURL(std::string Source);
    std::string ConverToLower(const std::string& input);
} Tools;

std::string Tools::ConverToUpper(const std::string& input) {
    std::string result = input;
    for (char& c : result) {
        c = std::toupper(c);
    }
    return result;
}

std::string Tools::ConverToLower(const std::string& input) {
    std::string result;
    for (char c : input) {
        result += std::tolower(c);
    }
    return result;
}

std::string getMotherboardID() {
    std::string motherboardID;

    // Use Windows API or other platform-specific code to get motherboard ID
    // This example uses GetVolumeInformation to get the volume serial number of the C: drive
    char volume[MAX_PATH + 1];
    char fileSystem[MAX_PATH + 1];
    DWORD serialNumber;
    DWORD maxComponentLength;
    DWORD fileSystemFlags;

    if (GetVolumeInformation(
        "C:\\",  // You can change the drive letter if needed
        volume,
        sizeof(volume),
        &serialNumber,
        &maxComponentLength,
        &fileSystemFlags,
        fileSystem,
        sizeof(fileSystem)
    )) {
        motherboardID = std::to_string(serialNumber);
    }

    return motherboardID;
}

std::string Tools::getHardwareID() {
    int cpuinfo[4] = { 0, 0, 0, 0 };
    __cpuid(cpuinfo, 0);
    char id[13];
    memcpy(id, &cpuinfo[1], 4);
    memcpy(id + 4, &cpuinfo[3], 4);
    memcpy(id + 8, &cpuinfo[2], 4);
    id[12] = '\0';
    return getMotherboardID() + std::string(id);
}

static size_t my_write(void* buffer, size_t size, size_t nmemb, void* param)
{
    std::string& text = *static_cast<std::string*>(param);
    size_t totalsize = size * nmemb;
    text.append(static_cast<char*>(buffer), totalsize);
    return totalsize;
}

std::string Tools::DownloadURL(std::string Source) {
    std::string Result;
    CURL* Curl;
    CURLcode ReturnCode;
    curl_global_init(CURL_GLOBAL_DEFAULT);
    Curl = curl_easy_init();
    if (Curl) {
        curl_easy_setopt(Curl, CURLOPT_URL, Source);
        curl_easy_setopt(Curl, CURLOPT_WRITEFUNCTION, my_write);
        curl_easy_setopt(Curl, CURLOPT_WRITEDATA, &Result);
        // Disable debug output
        curl_easy_setopt(Curl, CURLOPT_VERBOSE, 0);
        ReturnCode = curl_easy_perform(Curl);
        curl_easy_cleanup(Curl);
        if (ReturnCode != CURLE_OK) {
            std::cerr << "CURL error: " << ReturnCode << '\n';
        }
    }
    curl_global_cleanup();
    return Result;
}