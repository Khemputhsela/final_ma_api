from flask import Flask, jsonify
from flask_cors import CORS
import sqlite3

app = Flask(__name__)
CORS(app)

conn = sqlite3.connect('database_st2_6.db', check_same_thread=False)
cursor = conn.cursor()


@app.get('/')
@app.get('/products')
def getProducts():
    result = cursor.execute('''SELECT * FROM product''')
    data = result.fetchall()
    conn.commit()

    product_list = []

    for item in data:
        product_list.append(
            {
                "id": item[0],
                "title": item[1],
                "price": float(item[5]),
                "description": item[3],
                "category": item[2],
                "image": "/static/image/" + item[4],
                "rating": {
                    "rate": 3.9,
                    "count": 120
                }
            }
        )
    return jsonify(product_list)


if __name__ == '__main__':
    app.run()