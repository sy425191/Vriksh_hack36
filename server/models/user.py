from models.shared import db
import datetime
from dataclasses import dataclass

@dataclass
class userModel(db.Model):
    id:int
    email:str
    fname:str
    lname:str
    __tablename__ = 'User'
    id=db.Column(db.Integer, primary_key=True)
    email=db.Column(db.String(80), unique=True, nullable=False)
    password=db.Column(db.String(40), nullable=False)
    fname = db.Column(db.String(40))
    lname = db.Column(db.String(40))
    joinedTime = db.Column(db.DateTime, default=datetime.datetime.utcnow)

    def __init__(self, email, password):
        self.email = email
        self.password = password

