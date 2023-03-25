from flask_restful import Resource, reqparse
from flask import jsonify

parser = reqparse.RequestParser()
parser.add_argument('title','address','notes','date')

class createCampaign(Resource):
    def post(self):
        args = parser.parse_args()
        title = args['title']
        address = args['address']
        notes = args['notes']
        date = args['date']
        