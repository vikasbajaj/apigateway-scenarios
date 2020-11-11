import json
import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('Transactions')

def lambda_handler(event, context):
    #print("This is Transaction Save Lambda handler 121 ------>")
    print(json.dumps(event))
    for record in event['Records']:
        message=json.loads(record['body'])
        print('ssssssssssssssssss')
        print("---------------------------->>>>>")
        transactiongroup=message['message']['transactiongroup']
        transactionidentifier=message['message']['transactionidentifier']
        transactiontype=message['message']['transactiontype']
        print("transactiongroup is {}".format(transactiongroup))
        print("transactionidentifier is {}".format(transactionidentifier))
        print("transactiontype is {}".format(transactiontype))
        print("---------------------------->>>>>>>")
        table.put_item(
           Item={
                'pk': transactiongroup,
                'sk': transactionidentifier,
                'transactiontype': transactiontype
            }
        )
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
