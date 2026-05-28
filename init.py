""" LIBRERÍAS """
import pymysql

from flask import Flask, jsonify, request, render_template

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
@app.route("/login", methods = ["POST"])
def login():
    user = request.form["email"]
    password = request.form["password"]

    if(user == "" or password == ""):
        return render_template('login.html', alert = "Por favor completar los campos")

    cursor.callproc("tspIniciarSesion", [user, password])
    query = cursor.fetchall()[0]

    # El procedimiento almacenado devuelve un select de toda la fila del usuario.
    # ID -> query[0]
    # Name -> [1]
    # User -> [4]
    # Role -> query[7]

    # Verificamos si se encontró algo
    if(query[0] != 0):
        # Asignamos lo obtenido del procedimiento a las variables globales
        global id
        global name
        global role
        
        id = query[0]
        name = query[1]
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
    return render_template('teacherRegister.html', alert = "")

@app.route("/registerAccount", methods=["POST"])
def registerAccount():
    data = request.get_json()

    print(data)

    names = data["nombres"]
    lastNameP = data["apellidoP"]
    lastNameM = data["apellidoM"]
    user = data["usuario"]
    email = data["correo"]
    password = data["password"]
    fee = data["cuota"]
    temRole = data["rol"]
    
    if(temRole == "asesor"):
        cursor.callproc("tspRegistrarAsesor", [names, lastNameP, lastNameM, user, email, password, fee])
        query = cursor.fetchall()[0]

        print(query)
        print(query[0])

        if(query[0] == 'El usuario ya existe' or query[0] == 'El correo ya está registrado'):
            return jsonify({
                "success": False,
                "message": query[0]
            })
        
    connection.commit()
    
    global id
    global name
    global role
    
    id = query[0]
    name = names
    role = temRole

    return jsonify({
        "success": True,
        "message": "Usuario creado exitosamente"
    })