#!/usr/bin/env bash

set -e

if [ -z $AWS_PROFILE ]; then
    echo "AWS_PROFILE environment variable is not set."
    exit 1
fi

echo "Setting AWS_PROFILE=${AWS_PROFILE}"
export AWS_PROFILE=${AWS_PROFILE}

if [ -z $PROJECT_NAME ]; then
    echo "PROJECT_NAME environment variable is not set."
    exit 1
fi

if [ -z $KEY_PAIR ]; then
    echo "KEY_PAIR environment variable is not set."
    exit 1
fi

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)"

deploy_lambda_function(){
    echo '********************** Uploading Lambda Zip file to S3 ***********************'
    mkdir ${DIR}/deployment_package
    cp ${DIR}/index.sh ${DIR}/deployment_package
    cd ${DIR}/deployment_package
    zip -r9 index.zip .
    aws s3 mb s3://${LAMBDA_FUNCTION_BUCKET}
    aws s3 cp index.zip s3://${LAMBDA_FUNCTION_BUCKET}/index.zip
    echo '******************** Lambda Zip file uploaded to S3 Completed ***************'
}
delete_lambda_function(){
    if ! aws s3api head-bucket --bucket $LAMBDA_FUNCTION_BUCKET 2>&1 | grep -q 'Not Found'; then
        echo '******************** Deleting Lambda Zip file and bucket ********************'
        aws s3 rb s3://${LAMBDA_FUNCTION_BUCKET} --force
        rm -rf ${DIR}/deployment_package
    fi
}
deploy_vpc(){
    echo "Deploying Cloud Formation stack: \"${PROJECT_NAME}-vpc\" containing vpc, public subnets, private subnets.."
    aws cloudformation deploy \
        --no-fail-on-empty-changeset \
        --stack-name "${PROJECT_NAME}-vpc" \
        --template-file "${DIR}/vpc-stack.yaml" \
        --capabilities CAPABILITY_IAM \
        --parameter-overrides "ProjectName=${PROJECT_NAME}" "KeyPair=${KEY_PAIR}" "LambdaFunctionBucket=${LAMBDA_FUNCTION_BUCKET}"
}
deploy_stacks() {
    delete_lambda_function
    deploy_lambda_function
    deploy_vpc
}
delete_cfn_stack() {
    stack_name=$1
    echo "Deleting Cloud Formation stack: \"${stack_name}\"..."
    aws cloudformation delete-stack --stack-name $stack_name
    echo 'Waiting for the stack to be deleted, this may take a few minutes...'
    aws cloudformation wait stack-delete-complete --stack-name $stack_name
    echo 'Done'
}
delete_stacks() {
    delete_lambda_function
    delete_cfn_stack "${PROJECT_NAME}-vpc"
    echo "all resources for primary account have been deleted"
}
action=${1:-"deploy"}
if [ "$action" == "delete" ]; then
    delete_stacks
    exit 0
fi

if [ "$action" == "deploy" ]; then
    deploy_stacks
    exit 0
fi