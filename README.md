# PRS
This pipeline is designed to generate Polygenic Risk Scores (PRS) using different algorithms such as Support Vector Machines (SVM), Random Forest (RF), and Deep Learning (DL).

Contents
Data Preparation

Place your input data files in the corresponding directories (e.g., w1.csv, i1_rf.csv, etc.).
Run the provided R scripts to preprocess the data.
PRS Generation

Use the provided shell script prs_generation.sh to generate PRS using PLINK.
The generated PRS files will be named prs1, prs2, ..., prsn.
PRS Transformation

Use the R script log_trans.r to perform a logarithmic transformation on the third column of PRS files.
Transformed PRS files will be overwritten in place.
Model Training and Feature Extraction

Use the Python script train_model_and_extract_features.py to train SVM and RF models and extract feature weights.
Results will be saved in w1.csv, w2.csv, ..., wn.csv and i_rf1.csv, i_rf2.csv, ..., i_rfn.csv.
PRS-SVM-RF-DL Integration

Run the R script prs_svm_rf_dl.r to combine PRS with SVM, RF, and DL results.
Resulting files will be named prs_svm1, prs_svm2, ..., prs_svmn, prs_rf1, prs_rf2, ..., prs_rfn, prs_dl1, prs_dl2, ..., prs_dln.
PRS Scoring

Use PLINK to score PRS on the simulation datasets (sim1, sim2, ..., simn).
Weights and Importance Extraction

Execute the provided shell script weights_importance_extraction.sh to extract feature weights (w1.csv, w2.csv, ..., wn.csv) and importance (i_rf1.csv, i_rf2.csv, ..., i_rfn.csv) from the simulation datasets.
Combining PRS, SVM, RF, DL

Run the R script combine_prs.r to combine PRS, SVM, RF, and DL results into a single CSV file prs_5K.csv.
Nextflow Workflow

A Nextflow workflow is provided to automate the execution of these steps. Create a Nextflow script (e.g., my_workflow.nf) and paste the provided code.
Usage
Ensure you have the required dependencies installed (PLINK, R, Python, Nextflow).
Follow the instructions in each section to perform the respective tasks.
Modify the scripts and parameters to suit your specific data and requirements.
