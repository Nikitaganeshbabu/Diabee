import sys
import pandas as pd
from sklearn.preprocessing import LabelEncoder, MinMaxScaler
import joblib

def predict_diabetes(test_values):
    # Load the dataset
    df = pd.read_csv('diabetes_data_upload.csv')

    # Encoding the target variable
    label_encoder = LabelEncoder()
    df['class'] = label_encoder.fit_transform(df['class'])

    # Extracting features and target variable
    X = df.drop(['class'], axis=1)
    y = df['class']

    # One-hot encoding categorical features
    X = pd.get_dummies(X, drop_first=True)

    # Scaling numerical features
    minmax = MinMaxScaler()
    X_scaled = minmax.fit_transform(X)

    # Load the trained logistic regression model
    logistic_regression_model = joblib.load('logistic_regression_model.joblib')

    # Preprocess the testing values
    test_df = pd.DataFrame([test_values], columns=X.columns)
    test_df_scaled = minmax.transform(test_df)

    # Make predictions
    prediction = logistic_regression_model.predict(test_df_scaled)

    # Interpret the prediction
    result = label_encoder.inverse_transform(prediction)[0]
    return result

if __name__ == '__main__':
    # Extract test values from command-line arguments
    test_values = list(map(float, sys.argv[1:]))
    
    # Predict diabetes
    prediction = predict_diabetes(test_values)
    print("The prediction for the testing example is:", prediction)
