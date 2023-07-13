from flask import Flask, jsonify
from flask_restful import Api, Resource
from functions import *
# from routes.weather import *
# from routes.predict import *
# from routes.campaigns import *
from routes.auth import *
from models.shared import db
from models.user import userModel
app = Flask(__name__)

app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root:root@localhost/vriksha'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

api = Api(app)
db.app = app
db.init_app(app)

# db.create_all()

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
api.add_resource(Login,'/api/login/')
# api.add_resource(OAuth,'/oauth')
# api.add_resource(getPollution,'/pollution/<float:lat>/<float:lng>')
# api.add_resource(treeDensity,'/tree/<float:lat>/<float:lng>')
# api.add_resource(analyseLatLong,'/analyseLatLong/<float:lat>/<float:lng>')
# api.add_resource(createCampaign, '/createCampaign')

if __name__=='__main__':
	app.run(debug=True, host="0.0.0.0")