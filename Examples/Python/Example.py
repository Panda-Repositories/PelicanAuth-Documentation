import importlib.util
import urllib.request
import sys

#Rename this Service name to your own
service_name = "pandadevkit"
# --------------------------------------------------------------------------------------------
# ( Important Module ) Include this to your project
# --------------------------------------------------------------------------------------------
def load_module_from_url(url, module_name):
    try:
        headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'}
        request = urllib.request.Request(url, headers=headers)
        response = urllib.request.urlopen(request)
        code = response.read().decode('utf-8')
        module_spec = importlib.util.spec_from_loader(module_name, loader=None)
        module = importlib.util.module_from_spec(module_spec)
        exec(code, module.__dict__)
        module.__file__ = url
        sys.modules[module_name] = module
        return module

    except Exception as e:
        print(f"Error loading module from URL: {e}")
        return None
# --------------------------------------------------------------------------------------------
# Load PandaAuthPYLib from the URL ( DO NOT RENAME THESE OR THE LIBRARY WON'T LOAD)
# --------------------------------------------------------------------------------------------
url = 'https://auth.pandadevelopment.net/library/PythonLib/PandaAuthPYLib.py'
module_name = 'PandaAuthPYLib'
panda_auth_lib = load_module_from_url(url, module_name)

# Check if the library was successfully loaded
if panda_auth_lib:
    #The Fun Begin
    def main():
        while True:
            client_hardware_id = panda_auth_lib.get_hardware_id()
            user_input = input('Please enter your key. If you don\'t have a key, type "key": ')
            if user_input.lower() == 'key':
                panda_auth_lib.get_key(service_name, client_hardware_id)
            else:
                result = panda_auth_lib.validate_key(user_input, client_hardware_id, service_name)
                if result:
                    print('[ The Key is Valid ]')
                    # Execute your favorite code (Python code here)
                    break
                else:
                    print('[ The Key is Invalid ]')

    if __name__ == "__main__":
        main()
else:
    print("Unable to load the PandaAuthPYLib from the URL.")
