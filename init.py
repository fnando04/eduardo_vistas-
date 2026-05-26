from flask import Flask
from flask import render_template

from markupsafe import escape

app = Flask(__name__)

# Función inicial
# Es la primera en ejecutarse al iniciar el programa
@app.route("/")
def index():
    #return render_template('index.html', advice = "Hello World!")
    return render_template('login.html')

# Se ejecuta al pulsar "iniciar sesión" en el Login
@app.route("/login")
def login():
    return render_template('index.html')

# Redirije a la ventana de selección de cuenta
@app.route("/chooseAccount")
def chooseAccount():
    return render_template('registerSelection.html')

# Redirije a la ventana de crear asesorado (estudiante)
@app.route("/createStudent")
def createStudent():
    return render_template('studentRegister.html')

# Redirije a la ventana de crear asesor (maestro)
@app.route("/createTeacher")
def createTeacher():
    return render_template('teacherRegister.html')