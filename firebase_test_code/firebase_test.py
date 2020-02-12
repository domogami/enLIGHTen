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

# As an admin, the app has access to read and write all data, regradless of Security Rules
ref = db.reference('/') #This will edit the root folder, you can do more subfolders and etc
i = 0
for i in range(10):
    time.sleep(1)
    item = ref.get()
    try:
        print("Switch1" + item['Switch1'])
    except:
        print("doesn't exist")
    ref.update({"Switch1": i})