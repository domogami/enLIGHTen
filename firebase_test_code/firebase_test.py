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
    def __init__(self, name):
        self.name = name
        self.ML_status = "UNINITIALIZED"
        self.Switch_status = "UNINITIALIZED"
        self.check_switch_status() #initialize the local switches with the correct states

    def push_Switch_status(self):
        ref = db.reference('/')
        info = ref.child('Switches').child(self.name)
        if(info.get()['Switch_status'] == 'ON'):
            info.update({"Switch_status":"OFF"})
            self.Switch_status = "OFF"
            print(self.name + " switched OFF")
            return
        if(info.get()['Switch_status'] == 'OFF'):
            info.update({"Switch_status":"ON"})
            self.Switch_status = "ON"
            print(self.name + " switched ON")
            return

    def push_ML_status(self):
        ref = db.reference('/')
        info = ref.child('Switches').child(self.name)
        if info.get()['ML_status'] == 'ENABLED':
            info.update({"ML_status":"DISABLED"})
            self.ML_status = "DISABLED"
            print(self.name + " DISABLED")
            return
        if info.get()['ML_status'] == 'DISABLED':
            self.ML_status = "ENABLED"
            info.update({"ML_status":"ENABLED"})
            print(self.name + " ENABLED")
            return

    def check_switch_status(self): #This will check the firebase for an update
        ref = db.reference('/')
        info = ref.child('Switches').child(self.name)
        if self.ML_status != info.get()['ML_status']:
            self.ML_status = info.get()['ML_status']
            print("ADD CODE HERE TO ENABLE OR DISABLE MACHINE LEARNING")
        if self.Switch_status != info.get()['Switch_status']:
            self.Switch_status = info.get()['Switch_status']
            print("TELL THE ESP32 to change states")

    def return_local_info(self):
        list = []
        list.append(self.Switch_status)
        list.append(self.ML_status)
        return list
    

# As an admin, the app has access to read and write all data, regradless of Security Rules
ref = db.reference('/') #This will edit the root folder, you can do more subfolders and etc
Switch_1 = Switch("Switch_1")
Switch_2 = Switch("Switch_2")
Switch_3 = Switch("Switch_3")
Switch_1.push_Switch_status()
Switch_2.push_Switch_status()

while 1:
    Switch_1.check_switch_status()
    Switch_2.check_switch_status()
    Switch_3.check_switch_status()
    time.sleep(0.3)

