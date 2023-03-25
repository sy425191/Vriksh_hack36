from flask_restful import Resource
from flask import jsonify, request


class createCampaign(Resource):
    def post(self):
        data = { 'title' : request.json['title'], 'city' : request.json['city'], 'notes' : request.json['notes'], 'date' : request.json['date'], 'joincount' : 0, 'lat' : request.json['lat'], 'long' : request.json['long']}
        return jsonify({'data': data})
    
class joinCampaign(Resource):
    def post(self):
        data = {'userid' : request.json['userid'], 'campaignid' : request.json['campaignid']}
        # check if user has already joined the campaign
        #update database

class deleteCampaign(Resource):
    def post(self):
        data = {'campaignid' : request.json['campaignid']}

class yourCampaign(Resource):
    def post(self):
        data = {'userid' : request.json['userid']}

class nearbyCampaign(Resource):
    def post(self):
        data = {'lat' : request.json['lat'], 'lat' : request.json['lat']}
        
class campaignDetail(Resource):
    def get(self):
        data = {'campaignid' : request.json['campaignid']}