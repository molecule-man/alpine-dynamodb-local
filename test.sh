#!/bin/bash

set -e

ENDPOINT=http://localhost:8000
aws dynamodb create-table \
    --endpoint-url $ENDPOINT \
    --table-name local \
    --attribute-definitions AttributeName=Id,AttributeType=S \
    --key-schema AttributeName=Id,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=1000,WriteCapacityUnits=1000

aws dynamodb put-item \
    --endpoint-url $ENDPOINT \
    --table-name local \
    --item '{ "Id": {"S": "foo"}, "Bar": {"S": "buz"}}'

aws dynamodb get-item \
    --endpoint-url $ENDPOINT \
    --table-name local \
    --key '{ "Id": {"S": "foo"}}'
