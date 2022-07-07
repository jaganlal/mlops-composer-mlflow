#!/bin/bash
export MLFLOW_GCS_ROOT_URI=gs://mlops-july-07-3pm-artifacts
export MLFLOW_SQL_CONNECTION_STR=mysql+pymysql://root:mlflow_db_secret@127.0.0.1:3306/mlflow
export MLFLOW_SQL_CONNECTION_NAME=mlops-poc-337511:us-east1:mlops-july-07-3pm-sql
export MLFLOW_EXPERIMENTS_URI=gs://mlops-july-07-3pm-artifacts/experiments
export MLFLOW_TRACKING_URI=http://127.0.0.1:80
export MLFLOW_TRACKING_EXTERNAL_URI=https://cc8fb569cd450d0-dot-us-east1.pipelines.googleusercontent.com
export MLOPS_COMPOSER_NAME=mlops-july-07-3pm-af
export MLOPS_REGION=us-east1
export ML_IMAGE_URI=gcr.io/mlops-poc-337511/mlops-july-07-3pm-mlimage:latest

/usr/local/bin/cloud_sql_proxy -dir=/var/run/cloud-sql-proxy -instances=mlops-poc-337511:us-east1:mlops-july-07-3pm-sql=tcp:3306 -credential_file=/usr/local/bin/sql-access.json &
sleep 45s
mlflow server --host=127.0.0.1 --port=80 --backend-store-uri=mysql+pymysql://root:mlflow_db_secret@127.0.0.1:3306/mlflow --default-artifact-root=gs://mlops-july-07-3pm-artifacts/experiments &
