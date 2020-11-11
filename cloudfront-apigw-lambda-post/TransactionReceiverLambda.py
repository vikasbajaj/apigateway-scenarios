import json
import boto3

sqs = boto3.client('sqs')
queue_url = 'https://sqs.ap-southeast-2.amazonaws.com/xxxxxxxxxxxx/transaction-queue.fifo'

def lambda_handler(event, context):
    print("This is private lambda handler------>")
    print(json.dumps(event))
    #print(event['body'])
    messages = json.loads(event['body'])
    for message in messages['messages']:
        transactiongroup=message['message']['transactiongroup']
        transactionidentifier=message['message']['transactionidentifier']
        transactiontype=message['message']['transactiontype']
        print('transaction group is {}'.format(transactiongroup))
        print('transaction identifier is {}'.format(transactionidentifier))
        print('transaction type is {}'.format(transactiontype))
        #message=event['body']
        response = sqs.send_message(
            QueueUrl=queue_url,
            MessageBody=(
                json.dumps(message)
            ),
            MessageDeduplicationId=transactionidentifier+transactiongroup,
            MessageGroupId=transactiongroup
        )
        print(response['MessageId'])
    
    return {
            "statusCode": 200,
            "body": json.dumps({
                "message": 'tested'
            }),
            "headers":{ 'Access-Control-Allow-Origin' : '*' }
        }