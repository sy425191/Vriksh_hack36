from flask import Flask, jsonify
from flask_restful import Resource

class User(Resource):
    def get(self):
        return jsonify({'data': 'Hello World'})

    