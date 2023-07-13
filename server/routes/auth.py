from flask import Flask, jsonify, request,make_response
from flask_restful import Resource
from models.user import userModel
from models.shared import db
import json
import jwt
import os
from dotenv import load_dotenv
load_dotenv()

class User(Resource):
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

class Login(Resource):
    def post(self):
        data = (request.get_json(force=True))
        email = data['email']
        password = data['password']

        # check if email exist in database
        alreadypresentuser = userModel.query.filter_by(email=email).all()
        if(len(alreadypresentuser) != 0):
            if(alreadypresentuser[0].password != password):
                resp = jsonify({
                    "status": "error",
                    "Message": "Wrong Password"
                }), 500
                response = make_response(resp)
                response.status_code= 401
                return response
        
        else:
            # add to model
            newuser = userModel(email, password)
            db.session.add(newuser)
            db.session().commit()

        user = userModel.query.filter_by(email=email, password=password).first()
        token = jwt.encode({
            'id': user.id,
        }, os.getenv("SECRET_KEY")).decode()


        resp = jsonify({
            "status":"success",
            "data": user,
            "token": token
        })
        response = make_response(resp)
        response.status_code= 200
        return response
        
        