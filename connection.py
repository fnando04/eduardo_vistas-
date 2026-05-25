import pymysql
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

conexion = credentials.Certificate("../octavo-c-iti-firebase-adminsdk-fbsvc-0b782d0d42.json")

firebase_admin.initialize_app(conexion)

baseDatos = firestore.client()

connection = pymysql.connect(
    host = "zephyr.proxy.rlwy.net",
    user = "root",
    password = "cKQDfWcxcyPCNyZKywdZfjjLDrBLWLpP",
    database = "railway",
    port = 48122
)

cursor = connection.cursor()

cursor.execute("SELECT * FROM EXP_Asesor;")

results = cursor.fetchall()

print(results)