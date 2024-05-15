from robot.api.deco import keyword
from pymongo import MongoClient
import bcrypt

client = MongoClient('mongodb+srv://qa:xperience@cluster0.h6wugwz.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0')

db = client['markdb']

@keyword('Clean User From Database')
def clean_user(email):
    users = db['users']
    tasks = db['tasks']

    user = users.find_one({'email': email})
    if user:
        tasks.delete_many({'user': user['_id']})
        users.delete_many({'email': email})

@keyword('Remove User From Database')
def remove_user(email):
    users = db['users']
    users.delete_many({'email': email})
    print('removing user by ' + email)

@keyword('Insert User Into Database')
def insert_user(user):
    hash_pass = bcrypt.hashpw(user['password'].encode('utf-8'), bcrypt.gensalt(8))
    doc = {
        'name': user['name'],
        'email': user['email'],
        'password': hash_pass,
    }
    users = db['users']
    users.insert_one(doc)
    print('inserting user')
    print(user)