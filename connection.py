import pymysql

connection = pymysql.connect(
    host = "127.0.0.1",
    user = "root",
    password = "",
    database = "DB_EXPERT"
)

cursor = connection.cursor()

cursor.execute("SELECT * FROM EXP_Asesorado;")

results = cursor.fetchall()

for i in results:
    print(i, "\n")

#! Al ejecutar funciones que modifiquen los datos, es importante ejecutar:
# cursor.commit()