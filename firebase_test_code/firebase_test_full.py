import firebase_admin
import json
import time
from firebase_admin import credentials
from firebase_admin import db
from bluepy import btle
import binascii

#Configuration of 3 ESP32's
print("Connecting to ESP32_1...")
dev = btle.Peripheral("98:F4:AB:6D:2C:86")
dev.waitForNotifications(5)
print("Connecting to ESP32_2...")
dev2 = btle.Peripheral("FC:F5:C4:0E:53:4A")
dev2.waitForNotifications(5)
print("Connecting to ESP32_3...")
dev3 = btle.Peripheral("98:F4:AB:6E:61:42")
dev3.waitForNotifications(5)

#Service UUID used by all ESP32's
ESP32 = btle.UUID("6E400001-B5A3-F393-E0A9-E50E24DCCA9E")
print("service 1")
ESP32Service = dev.getServiceByUUID(ESP32)
time.sleep(1)
print("servcice 2")
ESP32Service2 = dev2.getServiceByUUID(ESP32)
time.sleep(1)
print("service 3")
ESP32Service3 = dev3.getServiceByUUID(ESP32)
time.sleep(1)

#Write configuration for all ESP32's
uuidConfig = btle.UUID("6E400002-B5A3-F393-E0A9-E50E24DCCA9E")

ESP32Config = ESP32Service.getCharacteristics(uuidConfig)[0]
ESP32Config2 = ESP32Service2.getCharacteristics(uuidConfig)[0]
ESP32Config3 = ESP32Service3.getCharacteristics(uuidConfig)[0]

#Read configuration for all ESP32's
uuidValue  = btle.UUID("6E400003-B5A3-F393-E0A9-E50E24DCCA9E")

ESP32Value = ESP32Service.getCharacteristics(uuidValue)[0]
ESP32Value2 = ESP32Service2.getCharacteristics(uuidValue)[0]
ESP32Value3 = ESP32Service3.getCharacteristics(uuidValue)[0]

#val = binascii.hexlify(ESP32Value.read())
#print("ESP 32 value: ", val.decode('utf-8'))
#val2 = binascii.hexlify(ESP32Value2.read())
#print("ESP 32 value: ", val2.decode('utf-8'))
#val3 = binascii.hexlify(ESP32Value3.read())
#print("ESP 32 value3: ", val3.decode('utf-8'))

#switch = "ON"
#ESP32Config.write(bytes(switch, encoding='utf-8'))
#val = binascii.hexlify(ESP32Value.read())
#print("ESP 32 value: ", val.decode('utf-8'))



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
        self.check_switch_status()

    def push_Switch_status(self):
        ref = db.reference('/')
        info = ref.child('Switches').child(self.name)
        if(info.get()['Switch_status'] == 'ON'):
            info.update({"Switch_status":"OFF"})
            print(self.name + " switched OFF")
            return
        if(info.get()['Switch_status'] == 'OFF'):
            info.update({"Switch_status":"ON"})
            print(self.name + " switched ON")
            return

    def push_ML_status(self):
        ref = db.reference('/')
        info = ref.child('Switches').child(self.name)
        if info.get()['ML_status'] == 'ENABLED':
            info.update({"ML_status":"DISABLED"})
            print(self.name + " DISABLED")
            return
        if info.get()['ML_status'] == 'DISABLED':
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
            if (self.name == "Switch_1"):
                ESP32Config.write(bytes(info.get()['Switch_status'], encoding='utf-8'))
            if (self.name == "Switch_2"):
                ESP32Config2.write(bytes(info.get()['Switch_status'], encoding='utf-8'))
            if (self.name == "Switch_3"):
                ESP32Config3.write(bytes(info.get()['Switch_status'], encoding='utf-8'))
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

while 1:
    Switch_1.check_switch_status()
    Switch_2.check_switch_status()
    Switch_3.check_switch_status()
    time.sleep(0.3)                                                                                                                                                                                                                  
                                                                                                                                                                                                 135,19        Bot

                                                                                                                                                                                                 77,33         63%

                                                                                                                                                                                                 50,1          Top
                                                                                                                  
