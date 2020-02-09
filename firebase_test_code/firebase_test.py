import firebase_admin
import json
import time
from firebase_admin import credentials
from firebase_admin import db

# Fetch the service account key JSON file contents
cred = credentials.Certificate('enlightenment-31974-firebase-adminsdk-l47x5-0bd15aff79.json')

# Initialize the app with a service account, granting admin privileges
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://enlightenment-31974.firebaseio.com/'
})

# As an admin, the app has access to read and write all data, regradless of Security Rules
ref = db.reference('/')
i = 0
for i in range(10):
    time.sleep(1)
    item = ref.get()
    try:
        print(item['Switch1'])
    except:
        print("doesn't exist")
    ref.update({"Switch1": i})