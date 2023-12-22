# pip install panda-auth==0.3
from panda_auth import *
# Variables
service = "pandadevkit"

# reset hardware ID
key = "blablabla"
newhwid = "lmao"
reset_hwid(service,key,newhwid, debug=True) # Enabling debug will help you to solve the errors

# Create a premium key

params = {
'email': 'email.example@gmail.com', # Account email
    'pass': '', # Account password 
    'expire': '2050-12-24', # key expire
    'note': 'Thanks for buying!', # key note 
    'count': '1' # Number of key 
}
generate_key(params, debug=True)


# Send the get key link without providing an hwid


get_key(service, debug=True)

# Get key with an HWID

hwid="hwidhere"

get_keyHWID(service, hwid, debug=True)

