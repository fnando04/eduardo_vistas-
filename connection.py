import pymysql
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

conexion = credentials.Certificate("../octavo-c-iti-firebase-adminsdk-fbsvc-0b782d0d42.json")

firebase_admin.initialize_app(conexion)

baseDatos = firestore.client()

connection = pymysql.connect(
    host = "127.0.0.1",
    user = "root",
    password = "",
    database = "DB_EXPERT"
)

cursor = connection.cursor()

cursor.execute("SELECT ASO_Usuario FROM EXP_Asesor LIMIT 1;")

results = cursor.fetchall()[0][0]

statusResult = baseDatos.collection("estados").document(results).get()

print(results, statusResult.to_dict()["estado"])