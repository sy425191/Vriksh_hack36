from flask_restful import Resource
from functions import *
from utils.ml import *
from flask import jsonify

class treeDensity(Resource):
    def get(self, lat, lng):
        return jsonify(predictFromModel(lat, lng))

class analyseLatLong(Resource):
    def get(self, lat, lng):
        data = {}
        data['pollution'] = get_weather_data(lat, lng)
        data['tree_cover'] = predictFromModel(lat, lng)
        # data['population_density'] = get_population_density(lat, lng)
        data['region'] = cal_region(data['tree_cover'])
        return (data)

def cal_region(tree_cover):
    print(tree_cover)
    if tree_cover <= 0.06:
        return "RED"
    elif tree_cover <= 0.18:
        return "ORANGE"
    else:
        return "GREEN"