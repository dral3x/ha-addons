#!/bin/bash

echo "Starting"
aws --version

KEY=`jq -r .aws_key_id /data/options.json`
SECRET=`jq -r .aws_key_secret /data/options.json`
BUCKET=`jq -r .bucket_name /data/options.json`
FOLDER=`jq -r .bucket_folder /data/options.json`
STORAGE_CLASS=`jq -r .storage_class /data/options.json`

aws configure set aws_access_key_id $KEY
aws configure set aws_secret_access_key $SECRET

aws s3 sync /backup/ s3://$BUCKET/$FOLDER --delete --storage-class $STORAGE_CLASS

echo "Done"