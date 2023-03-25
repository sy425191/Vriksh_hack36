from flask import Flask, jsonify
from flask_restful import Api, Resource
from functions import *
from routes.weather import *
from routes.predict import *
from routes.campaigns import *

app = Flask(__name__)

api = Api(app)

class User(Resource):
    def get(self,id):
        val = "abcd"
        data={"data":"Hello "+val}
        return data

class OAuth(Resource):
    def get(self):
        data={"data":"Hello"}
        return data    
       

api.add_resource(User,'/user/<string:id>')
api.add_resource(OAuth,'/oauth')
api.add_resource(getPollution,'/pollution/<float:lat>/<float:lng>')
api.add_resource(treeDensity,'/tree/<float:lat>/<float:lng>')
api.add_resource(createCampaign, '/createCampaign')


if __name__=='__main__':
	app.run(debug=True)
