from flask_restful import Resource
from functions import *
# from utils.ml import *
from flask import jsonify

class treeDensity(Resource):
    def get(self, lat, lng):
        # get image 
        image = "test"
        return (image)
