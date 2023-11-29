import requests   #Get the Content of the Page, similar to HTTPGET (Lua) / WebClient (CSharp)
import platform   #Responsible for Hardware ID
import uuid       #Responsible for Hardware ID too
import pyperclip  #For Setclipboard / Copy the Key
import json       #To Deserialize the Authentication
import hashlib    #Hashing Algorithm
from colorama import Fore, Style, init

# Initialize colorama
init(autoreset=True)

service_name = "pandadevkit" #Replace this with your own Service Name

def copy_to_clipboard(text):
    pyperclip.copy(text)

def sha256_hash(input_string):
    sha256_hash_object = hashlib.sha256()
    sha256_hash_object.update(input_string.encode('utf-8'))
    hashed_string = sha256_hash_object.hexdigest()
    return hashed_string

def get_hardware_id():
    try:
        # Get the MAC address of the machine's network interface
        mac_address = ':'.join(['{:02x}'.format((uuid.getnode() >> elements) & 0xff) for elements in range(5, -1, -1)])
        processor_info = platform.processor()
        hardware_id = f"{mac_address}-{processor_info}"
        return sha256_hash(hardware_id)
    except Exception as e:
        print(f"Error: {e}")
        return None

def get_webpage_content(url):
    try:
        response = requests.get(url)
        if response.status_code == 200:
            return response.text
        else:
            print(f"Error: Unable to fetch webpage. Status code: {response.status_code}")
            return None
    except Exception as e:
        print(f"Error: {e}")
        return None

# ------------------------------------------------------------------------------
# Pelican Authentication Lib ( Validations )
# ------------------------------------------------------------------------------


def ValidateKey(input_key, hardwareid, service_name):
    url = f"https://pandadevelopment.net/validate?key={input_key}&hwid={hardwareid}&service={service_name}"
    webpage_content = get_webpage_content(url)

    if not webpage_content:
        print("Error: Unable to fetch webpage content.")
        return False

    decryption_service_url = f"https://pandadevelopment.net/serviceapi?service={service_name}&command=decrypt&param={webpage_content}"
    decryption_service_content = get_webpage_content(decryption_service_url)

    try:
        data = json.loads(decryption_service_content)
        # Assuming data is a dictionary with the expected keys
        hardwarematching = data.get("DEV_ID", "")
        keystatus = data.get("STATUS", "")
        keypremium = data.get("ISPREMIUM", "")
    except json.JSONDecodeError as e:
        print(f"Error decoding JSON: {e}")
        print(f"Decryption service content: {decryption_service_content}")
        return False

    client_hardwareID = sha256_hash(hardwareid)
    client_marked = sha256_hash("authenticated")

    if hardwarematching != client_hardwareID.upper() or keystatus != client_marked.upper():
        return False
    else:
        return True


def GetKey(hardwareid):
    generatedlink = "https://auth.pandadevelopment.net/getkey?service=" + service_name + "&hwid=" + hardwareid
    copy_to_clipboard(generatedlink)
    print("______________________________________________________________________")
    print("URL: " + generatedlink)
    print("______________________________________________________________________")

def main():
    while True:
        user_input = input('Please enter your key. If you don\'t have a key, type "key": ')
        if user_input.lower() == 'key':
            GetKey(get_hardware_id())
        else:
            hardware_id = get_hardware_id()
            result = ValidateKey(user_input, hardware_id, service_name)
            if result:
                print(Fore.GREEN + '[ The Key is Valid ]' + Style.RESET_ALL)
                # Execute your favorite code (Python code here)
                break
            else:
                print(Fore.RED +'[ The Key is Invalid ]' + Style.RESET_ALL)

if __name__ == "__main__":
    main()