from flask import Flask
from flask import render_template

from markupsafe import escape

app = Flask(__name__)

@app.route("/")

def index():
    #return render_template('index.html', advice = "Hello World!")
    return render_template('login.html')