import firebase_admin
import json
import time
from firebase_admin import credentials
from firebase_admin import db

# Fetch the service account key JSON file contents
# Get the path to the authentication JSON 
cred = credentials.Certificate('enlightenment-31974-firebase-adminsdk-l47x5-0bd15aff79.json')

# Initialize the app with a service account, granting admin privileges
firebase_admin.initialize_app(cred, {
    #This is the url at the top of the database, the realtime one not the firestone one
    'databaseURL': 'https://enlightenment-31974.firebaseio.com/'
})

class Switch:
    def __init__(self, name, ML_status, Switch_status):
        self.name = name
        self.ML_status = ML_status
        self.Switch_status = Switch_status

    def push_switch_status(self):
        info = ref.child(self.name)
        if(info.get()['Switch_status'] == 'ON'):
            info.update({"Switch_status":"OFF"})
            print(self.name + " switched OFF")
        else:
            info.update({"Switch_status":"ON"})
            print(self.name + " switched ON")

    def get_switch_status(self):
        info = ref.child(self.name)
        
    def return_info(self):
        return ref.get()[self.name]
    

# As an admin, the app has access to read and write all data, regradless of Security Rules
ref = db.reference('/') #This will edit the root folder, you can do more subfolders and etc
Switch_1 = Switch("Switch_1", "Enabled", "On")
Switch_2 = Switch("Switch_2", "Enabled", "On")
Switch_3 = Switch("Switch_3", "Enabled", "On")
Switch_4 = Switch("Switch_4", "Enabled", "On")

Switch_2.push_switch_status()

