from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return "Congratulations! You have done your first complete demo."

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
