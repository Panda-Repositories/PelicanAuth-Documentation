#pragma once
#include "JSON/dist/json/json.h"

namespace JSONParser {
	void Initialize();
}
Json::Value JSON;


void Fetch() {
	std::unique_ptr<std::string> httpData(new std::string(Tools.DownloadURL("https://pastebin.com/raw/BPiy3bW9")));
	const auto rawJsonLength = static_cast<int>((*httpData).length());
	JSONCPP_STRING err;

	Json::CharReaderBuilder builder;
	const std::unique_ptr<Json::CharReader> reader(builder.newCharReader());
	if (!reader->parse((*httpData).c_str(), (*httpData).c_str() + rawJsonLength, &JSON, &err)) {
		std::cout << "JSON Parser Error: " << err << std::endl;
		Sleep(100);
		Fetch();
	}
}

void JSONParser::Initialize() {
	Fetch(); /* Fetch the json */

	/* Data Types */
}