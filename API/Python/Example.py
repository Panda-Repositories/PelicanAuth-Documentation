# Necessaries Library on Python to operate this code
import importlib.util
import urllib.request
import sys

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
panda_auth_lib = load_module_from_url('https://auth.pandadevelopment.net/library/PythonLib/PandaAuthPYLib.py', 'PandaAuthPYLib')

#Rename this Service name to your own
service_name = "pandadevkit"

# Get the Hardware ID from the current device (Don't use this if you're running on a server)
panda_auth_lib.get_hardware_id() 

# Returns True / False (boolean) Validate the Key of the User based on the hardware id and it's status.
panda_auth_lib.validate_key(user_input, client_hardware_id, service_name)

#Automatic added to your clipboard at the same time, returning as a string of URL (panda)
panda_auth_lib.get_key(service_name, client_hardware_id)


