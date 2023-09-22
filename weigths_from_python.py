import sklearn
import pandas as pd
import numpy as np
from sklearn.metrics import classification_report, confusion_matrix
from collections import Counter
from sklearn.datasets import make_classification
from sklearn.ensemble import RandomForestClassifier
import datatable as dt
from sklearn.svm import SVC
from sklearn.model_selection import train_test_split
import tensorflow as tf
from tensorflow import keras 

# Define a function for model training and feature extraction
def train_model_and_extract_features(input_file_prefix, output_w_file, output_i_file):
    datatable_df = dt.fread(input_file_prefix + ".raw")
    d = datatable_df.to_pandas()
    d = d.drop(['FID', 'IID',"PAT","MAT","SEX"], axis=1)
    X = d.drop('PHENOTYPE', axis=1)
    y = d['PHENOTYPE']
    del datatable_df

    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.20)
    
    # Train SVM
    svm = SVC(C=1000, kernel='linear', probability=True)
    svm.fit(X_train, y_train)
    w = pd.DataFrame(np.transpose(svm.coef_))
    w.to_csv(output_w_file, index=False)

    # Train Random Forest
    clf = RandomForestClassifier(n_estimators=1000, max_depth=30, min_samples_leaf=10, min_samples_split=10, oob_score=True, random_state=0)
    clf.fit(X, y)
    importance = clf.feature_importances_
    i = pd.DataFrame(importance)
    i.to_csv(output_i_file, index=False)

    # Additional code for training Deep Learning model can be added here

    del d, X, y, X_train, X_test, y_train, y_test, svm, w, clf, importance, i

# Iterate over datasets
for i in range(1, n):
    input_prefix = "sim" + str(i)
    output_w_file = f'w{i}.csv'
    output_i_file = f'i_rf{i}.csv'
    train_model_and_extract_features(input_prefix, output_w_file, output_i_file)
