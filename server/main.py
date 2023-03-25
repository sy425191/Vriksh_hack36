from flask import Flask, jsonify
from flask_restful import Api, Resource
from functions import *
from routes.weather import *
from routes.predict import *
from routes.campaigns import *
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)

api = Api(app)
db  = SQLAlchemy(app)

db_cred = {
    'user': 'subfousu_hack36',         # DATABASE USER
    'pass': 'o59R0r{lFp_d',     # DATABASE PASSWORD
    'host': '162.214.81.26',    # DATABASE HOSTNAME
    'name': 'subfousu_hack36'   # DATABASE NAME
}

# db.engine.execute("USE subfousu_hack36")

app.config['SQLALCHEMY_DATABASE_URI'] = f"mysql+pymysql://\
{db_cred['user']}:{db_cred['pass']}@{db_cred['host']}/\
{db_cred['name']}"
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

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
api.add_resource(analyseLatLong,'/analyseLatLong/<float:lat>/<float:lng>')
api.add_resource(createCampaign, '/createCampaign')


if __name__=='__main__':
	app.run(debug=True, host="192.168.0.106")
