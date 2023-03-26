from flask import Flask, jsonify
from flask_restful import Resource

class User(Resource):
    def get(self):
        return jsonify({'data': 'Hello World'})
    
    # define post request we get email and password
    def post(self):
        data = {'email': request.json['email'], 'password': request.json['password']}
        # if email already exists in users table
        if(check_email(data['email'])):
            return jsonify({'data': 'Email already exists'})
        return jsonify({'data': data})

    def check_email(email):
        # check if email exists in users table
        return True