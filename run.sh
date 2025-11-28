#!/bin/bash
# Automation script for CloudFormation templates. 
#
# Parameters
#   $1: Execution mode. Valid values: deploy, delete, preview.
#   $2: Region
#   $3: Stack name
#   $4: Template file
#   $5: Parameters file
#
# Usage examples:
#   ./run.sh deploy us-east-1 my-stack-name udagram.yml udagram-parameters.json
#   ./run.sh preview us-east-1 my-stack-name udagram.yml udagram-parameters.json
#   ./run.sh delete us-east-1 my-stack-name
#

# Validate parameters
if [[ $1 != "deploy" && $1 != "delete" && $1 != "preview" ]]; then
    echo "ERROR: Incorrect execution mode. Valid values: deploy, delete, preview." >&2
    exit 1
fi

# Execute CloudFormation CLI
if [ $1 == "deploy" ]
then
    aws cloudformation deploy \
        --stack-name $3 \
        --template-file $4 \
        --parameter-overrides file://$5 \
        --region $2 \
        --capabilities CAPABILITY_NAMED_IAM
fi
if [ $1 == "delete" ]
then
    aws cloudformation delete-stack \
        --stack-name $3 \
        --region $2
fi
if [ $1 == "preview" ]
then
    aws cloudformation deploy \
        --stack-name $3 \
        --template-file $4 \
        --parameter-overrides file://$5 \
        --no-execute-changeset \
        --region $2 \
        --capabilities CAPABILITY_NAMED_IAM
fi