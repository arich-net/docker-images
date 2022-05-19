#!/usr/bin/env python3
# Web Server to run web server in python using Flask

import os
import socket
import re
from flask import Flask, request, session
from flask_session import Session
import string
import random

def id_generator(size=6, chars=string.ascii_lowercase + string.digits):
   return ''.join(random.choice(chars) for _ in range(size))

app = Flask(__name__)
# Check Configuration section for more details
SESSION_COOKIE_NAME = 'hello-1'
SESSION_TYPE = 'filesystem'
app.config.from_object(__name__)
Session(app)

@app.route("/")
def hello():
    return "<h1>Hello World!</h1>"

@app.route("/login")
def login():
    session['id'] = id_generator(size=10)
    result = "Got session"
    return result

@app.route("/headers")
def headers():
    result = ""
    if re.match(r'^curl', request.headers.get('User-Agent')):
        result = "Request Details:\n"
        result = result + "----------------\n"
        result = result + "Full Path --> " + request.full_path + "\n"
        result = result + "Method -----> " + request.method + "\n"
        for header in request.headers.items():
            result = result + "Header -----> " + header[0] + ": " + header[1] + "\n"
        
        result = result + "Pod --------> " + socket.gethostname() + "\n"
        if 'id' in session:
            result = result + "Session id -> " + session['id'] + "\n"
    else:
        result = result + "<h1>Request Details</h1>"
        result = result + "<table>"
        result = result + "<tr><td><strong>Full Path:</strong></td><td>" + request.full_path + "</td></tr>"
        result = result + "<tr><td><strong>Method:</strong></td><td>" + request.method + "</td></tr>"
        for header in request.headers.items():
            result = result + "<tr><td><strong>Header:</strong></td><td>" + header[0] + ": " + header[1] + "</td></tr>"
        
        result = result + "<tr><td><strong>Pod:</strong></td><td>" + socket.gethostname() + "</td></tr>"
        if 'id' in session:
            result = result + "<tr><td><strong>Session id:</strong></td><td>" + session['id'] + "</td></tr>"

        result = result + "</table>"

    return result

if __name__ == '__main__':
    if os.getenv('HTTP_PORT'):
        http_port = os.getenv('HTTP_PORT')
    else:
        http_port = '8080' 
    
    app.run(debug=True, 
            host='0.0.0.0', 
            port=int(http_port))