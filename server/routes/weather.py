from flask_restful import Resource
from functions import *
from flask import jsonify

class getPollution(Resource):
    def get(self, lat, lng):
        # get the pollution data
        pollution_data = get_weather_data(lat, lng).decode('ASCII')
        print(pollution_data)
        return (pollution_data)
