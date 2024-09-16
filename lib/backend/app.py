from flask import Flask, request
import subprocess
import json

app = Flask(__name__)

@app.route('/predict', methods=['POST'])
def predict():
    try:
        data = request.json
        
        # Convert received JSON data into a list of values
        test_values = [
            data.get('age', 0),
            1 if data.get('gender', '') == 'Male' else 0,
            1 if data.get('polyuria', '') == 'Yes' else 0,
            1 if data.get('polydipsia', '') == 'Yes' else 0,
            1 if data.get('sudden_weight_loss', '') == 'Yes' else 0,
            1 if data.get('weakness', '') == 'Yes' else 0,
            1 if data.get('polyphagia', '') == 'Yes' else 0,
            1 if data.get('genital_thrush', '') == 'Yes' else 0,
            1 if data.get('visual_blurring', '') == 'Yes' else 0,
            1 if data.get('itching', '') == 'Yes' else 0,
            1 if data.get('irritability', '') == 'Yes' else 0,
            1 if data.get('delayed_healing', '') == 'Yes' else 0,
            1 if data.get('partial_paresis', '') == 'Yes' else 0,
            1 if data.get('muscle_stiffness', '') == 'Yes' else 0,
            1 if data.get('alopecia', '') == 'Yes' else 0,
            1 if data.get('obesity', '') == 'Yes' else 0,
        ]
        
        # Run the Python script with the received data
        result = subprocess.check_output(['python', 'train_model.py', *map(str, test_values)])
        return result.decode('utf-8')
    except Exception as e:
        return str(e)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)
