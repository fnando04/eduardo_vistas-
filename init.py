""" LIBRERÍAS """
import pymysql

from flask import Flask
from flask import render_template

from markupsafe import escape

""" VARIABLES GLOBALES """
app = Flask(__name__)

# Datos del usuario
id = 0
name = ""
role = ""

""" BASE DE DATOS """
connection = pymysql.connect(
    host = "127.0.0.1",
    user = "root",
    password = "",
    database = "DB_EXPERT",
    port = 3306
)

cursor = connection.cursor()

""" MÉTODOS """

""" FUNCIONES DE FLASK """
# Función inicial, primera en ejecutarse al iniciar el programa
@app.route("/")
def index():
    if(id != 0):
        return render_template('index.html', person = name)
    else:
        return render_template('login.html', alert = "")

# Se ejecuta al pulsar "iniciar sesión" en el Login
@app.route("/login/<string:user>/<string:password>")
def login(user, password):
    cursor.callproc("tspIniciarSesion", [user, password])
    query = cursor.fetchall()[0]

    # El procedimiento almacenado devuelve un select de toda la fila del usuario.
    # ID -> query[0]
    # User -> [4]
    # Role -> query[7]

    # Verificamos si se encontró algo
    if(query[0] != 0):
        # Asignamos lo obtenido del procedimiento a las variables globales
        global id
        global name
        global role
        
        id = query[0]
        name = query[4]
        role = query[7]

        return render_template('index.html', person = name)
    else:
        return render_template('login.html', alert = query[1])

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