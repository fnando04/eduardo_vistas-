"""
Backend Flask — API de registro de asesores
Requiere:
  pip install flask flask-cors flask-mysqldb bcrypt

Ejecutar:
  python app.py
"""

from flask import Flask, request, jsonify
from flask_cors import CORS
import MySQLdb
import bcrypt
import base64
import os
import re

app = Flask(__name__)
CORS(app)  # Permite peticiones desde el frontend

# ─────────────────────────────────────────────
#  CONFIGURACIÓN DE BASE DE DATOS
#  Cambia estos valores por los de tu MySQL
# ─────────────────────────────────────────────
DB_CONFIG = {
    "host":   "localhost",
    "user":   "root",          # tu usuario de MySQL
    "passwd": "tu_contraseña", # tu contraseña de MySQL
    "db":     "empresa_db",    # nombre de tu base de datos
    "port":   3306,
    "charset": "utf8mb4"
}

# ─────────────────────────────────────────────
#  HELPER: Conexión a la BD
# ─────────────────────────────────────────────
def get_db():
    return MySQLdb.connect(**DB_CONFIG)

# ─────────────────────────────────────────────
#  SCRIPT SQL DE REFERENCIA
#  Ejecuta esto en tu MySQL antes de iniciar:
#
#  CREATE DATABASE IF NOT EXISTS empresa_db
#    CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
#
#  USE empresa_db;
#
#  CREATE TABLE IF NOT EXISTS asesores (
#    id               INT AUTO_INCREMENT PRIMARY KEY,
#    nombres          VARCHAR(100) NOT NULL,
#    apellidos        VARCHAR(100) NOT NULL,
#    usuario          VARCHAR(60)  NOT NULL UNIQUE,
#    password_hash    VARCHAR(255) NOT NULL,
#    cuota            DECIMAL(10,2) DEFAULT 0.00,
#    fecha_nacimiento DATE,
#    categoria        VARCHAR(80),
#    tema_clase       VARCHAR(150),
#    foto             LONGTEXT,        -- guarda base64 o ruta de imagen
#    tipo             VARCHAR(20) DEFAULT 'asesor',
#    fecha_registro   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
#  );
# ─────────────────────────────────────────────


# ─────────────────────────────────────────────
#  UTILIDADES
# ─────────────────────────────────────────────
def hash_password(plain: str) -> str:
    """Genera un hash seguro de la contraseña con bcrypt."""
    salt = bcrypt.gensalt()
    return bcrypt.hashpw(plain.encode("utf-8"), salt).decode("utf-8")


def is_valid_usuario(usuario: str) -> bool:
    """Solo letras, números, puntos y guiones bajos."""
    return bool(re.match(r"^[\w.]+$", usuario))


# ─────────────────────────────────────────────
#  ENDPOINT: POST /api/asesores
# ─────────────────────────────────────────────
@app.route("/api/asesores", methods=["POST"])
def crear_asesor():
    data = request.get_json(silent=True)
    if not data:
        return jsonify({"message": "Cuerpo de la petición inválido."}), 400

    # — Campos requeridos —
    campos_req = ["nombres", "apellidos", "usuario", "password",
                  "cuota", "fecha_nacimiento", "categoria", "tema_clase"]
    for campo in campos_req:
        if not data.get(campo) and data.get(campo) != 0:
            return jsonify({"message": f"El campo '{campo}' es requerido."}), 400

    nombres          = data["nombres"].strip()
    apellidos        = data["apellidos"].strip()
    usuario          = data["usuario"].strip()
    password         = data["password"]
    cuota            = float(data["cuota"])
    fecha_nacimiento = data["fecha_nacimiento"]
    categoria        = data["categoria"].strip()
    tema_clase       = data["tema_clase"].strip()
    foto             = data.get("foto")   # base64 o None
    tipo             = data.get("tipo", "asesor")

    # — Validaciones básicas del lado del servidor —
    if len(usuario) < 4:
        return jsonify({"message": "El usuario debe tener al menos 4 caracteres."}), 422

    if not is_valid_usuario(usuario):
        return jsonify({"message": "El usuario contiene caracteres no válidos."}), 422

    if len(password) < 8:
        return jsonify({"message": "La contraseña debe tener al menos 8 caracteres."}), 422

    if cuota < 0:
        return jsonify({"message": "La cuota no puede ser negativa."}), 422

    # — Hash de contraseña —
    password_hash = hash_password(password)

    # — Insertar en MySQL —
    try:
        conn   = get_db()
        cursor = conn.cursor()

        # Verificar si el usuario ya existe
        cursor.execute("SELECT id FROM asesores WHERE usuario = %s", (usuario,))
        if cursor.fetchone():
            cursor.close()
            conn.close()
            return jsonify({"message": "El nombre de usuario ya está registrado."}), 409

        # Insertar nuevo asesor
        sql = """
            INSERT INTO asesores
              (nombres, apellidos, usuario, password_hash,
               cuota, fecha_nacimiento, categoria, tema_clase, foto, tipo)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """
        cursor.execute(sql, (
            nombres, apellidos, usuario, password_hash,
            cuota, fecha_nacimiento, categoria, tema_clase, foto, tipo
        ))
        conn.commit()
        nuevo_id = cursor.lastrowid

        cursor.close()
        conn.close()

        return jsonify({
            "message": "Asesor registrado exitosamente.",
            "id": nuevo_id
        }), 201

    except MySQLdb.Error as e:
        return jsonify({"message": f"Error de base de datos: {str(e)}"}), 500


# ─────────────────────────────────────────────
#  ENDPOINT: GET /api/asesores  (listar todos)
# ─────────────────────────────────────────────
@app.route("/api/asesores", methods=["GET"])
def listar_asesores():
    try:
        conn   = get_db()
        cursor = conn.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute("""
            SELECT id, nombres, apellidos, usuario, cuota,
                   fecha_nacimiento, categoria, tema_clase, tipo, fecha_registro
            FROM asesores
            ORDER BY fecha_registro DESC
        """)
        asesores = cursor.fetchall()
        cursor.close()
        conn.close()
        return jsonify(asesores), 200
    except MySQLdb.Error as e:
        return jsonify({"message": f"Error: {str(e)}"}), 500


# ─────────────────────────────────────────────
#  INICIAR SERVIDOR
# ─────────────────────────────────────────────
if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5000)
