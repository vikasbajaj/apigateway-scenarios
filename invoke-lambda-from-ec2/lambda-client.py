import json
import boto3

def call_lambda():
    print("This is private lambda handler------>")
    client = boto3.client('lambda')
    response = client.invoke(
                    FunctionName='private_lambda',
                    InvocationType='RequestResponse')

call_lambda()