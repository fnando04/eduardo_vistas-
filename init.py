""" LIBRERÍAS """
import pymysql

from flask import Flask, jsonify, request, render_template

""" VARIABLES GLOBALES """
app = Flask(__name__)

# Datos del usuario en sesión
id   = 0
name = ""
role = ""

""" BASE DE DATOS """
# Función de conexión reutilizable (evita cursor global que causa bugs)
def get_db_connection():
    return pymysql.connect(
        host     = "127.0.0.1",
        user     = "root",
        password = "12345",
        database = "DB_EXPERT",
        port     = 3306
    )

""" FUNCIONES DE FLASK """

# ── Inicio ────────────────────────────────────────────────────────────────────
@app.route("/")
def index():
    if id != 0:
        return render_template('index.html', person=name)
    else:
        return render_template('login.html', alert="")

# ── Login ─────────────────────────────────────────────────────────────────────
@app.route("/login", methods=["POST"])
def login():
    user     = request.form["email"]
    password = request.form["password"]

    if user == "" or password == "":
        return render_template('login.html', alert="Por favor completar los campos")

    conn   = get_db_connection()
    cursor = conn.cursor()
    cursor.callproc("tspIniciarSesion", [user, password])
    query = cursor.fetchall()[0]
    cursor.close()
    conn.close()

    # query[0] = Id, query[1] = Nombre, query[6] = TipoUsuario
    if query[0] != 0:
        global id, name, role
        id   = query[0]
        name = query[1]
        role = query[6]
        return render_template('index.html', person=name)
    else:
        return render_template('login.html', alert=query[1])

# ── Navegación de registro ────────────────────────────────────────────────────
@app.route("/chooseAccount")
def chooseAccount():
    return render_template('registerSelection.html')

@app.route("/createStudent")
def createStudent():
    return render_template('studentRegister.html')

@app.route("/createTeacher")
def createTeacher():
    return render_template('teacherRegister.html', alert="")

# ── API: Obtener temas (para los checkboxes del registro de asesor) ───────────
@app.route("/api/temas", methods=["GET"])
def get_temas():
    try:
        conn   = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        cursor.callproc("tspRevisarTemas")

        temas = cursor.fetchall()

        cursor.close()
        conn.close()
        return jsonify({"success": True, "temas": temas})

    except Exception as e:
        return jsonify({"success": False, "message": str(e)}), 500

# ── Registro de cuenta ────────────────────────────────────────────────────────
@app.route("/registerAccount", methods=["POST"])
def registerAccount():
    data = request.get_json()

    names     = data["nombres"]
    lastNameP = data["apellidoP"]
    lastNameM = data["apellidoM"]
    user      = data["usuario"]
    email     = data["correo"]
    password  = data["password"]
    fee       = data.get("cuota", None)
    temas     = data.get("temas", [])      # lista de IDs de temas (solo asesor)
    temRole   = data["rol"]

    conn   = get_db_connection()
    cursor = conn.cursor()

    try:
        # ── Registro de ASESOR ────────────────────────────────────────────────
        if temRole == "asesor":
            cursor.callproc("tspRegistrarAsesor", [
                names, lastNameP, lastNameM, user, email, password, fee
            ])
            query = cursor.fetchall()[0]

            # El SP devuelve Mensaje (string) si hay error, o Id (int) si fue exitoso
            if isinstance(query[0], str):
                conn.close()
                return jsonify({"success": False, "message": query[0]})

            nuevo_id = query[0]   # ID del asesor recién creado

            # Guardar temas de dominio seleccionados
            for id_tema in temas:
                cursor.callproc("tspAgregarTemaAsesor", [nuevo_id, id_tema])
                cursor.fetchall()  # consumir resultado del SP

        # ── Registro de ASESORADO ─────────────────────────────────────────────
        elif temRole == "asesorado":
            cursor.callproc("tspRegistrarAsesorado", [
                names, lastNameP, lastNameM, user, email, password
            ])
            query = cursor.fetchall()[0]

            if isinstance(query[0], str):
                conn.close()
                return jsonify({"success": False, "message": query[0]})

            nuevo_id = query[0]

        else:
            conn.close()
            return jsonify({"success": False, "message": "Rol no reconocido."})

        conn.commit()
        cursor.close()
        conn.close()

        # Iniciar sesión automáticamente tras el registro
        global id, name, role
        id   = nuevo_id
        name = names
        role = temRole

        return jsonify({"success": True, "message": "Usuario creado exitosamente"})

    except Exception as e:
        conn.close()
        return jsonify({"success": False, "message": str(e)}), 500

# ── Cerrar sesión ─────────────────────────────────────────────────────────────
@app.route("/closeSession")
def closeSession():
    global id, name, role
    id   = 0
    name = ""
    role = ""
    return render_template('login.html', alert="")