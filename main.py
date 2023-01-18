#Installing required dependencies
import sys
import json
import subprocess
from flask import Flask,request,jsonify
import datetime as dt
import shlex
app = Flask(__name__)
# video_path="s3://testingvideocheck/akash_video.mp4"
# config["BUCKET"]=os.getenv("BUCKET")

@app.route('/')
def testing_function():
    return 'Flask API running latest date -> 18-01-2023.20:30:00'

@app.route('/training', methods=['POST'])
def start_training():
    record=request.data
    record = json.loads(request.data.decode('utf-8'))
    cmd = "python3 train.py --config train.json"
    args = shlex.split(cmd)
    training_output = subprocess.check_output(args).decode('utf-8')
    return jsonify(str(training_output))

app.debug=True

app.run(host="0.0.0.0")
