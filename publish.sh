#!/bin/sh

helm package .

helm repo index --url https://charts.zinc.dev .

cp -r index.yaml artifacts/index.yaml
cp -r *.tgz artifacts/
aws s3 sync artifacts s3://zincsearch-releases/charts/

# invalidate cludfront cache
aws cloudfront create-invalidation --distribution-id E1MZFY4I0CFJV9 --paths=/*

