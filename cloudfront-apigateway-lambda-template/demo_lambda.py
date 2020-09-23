import json

def lambda_handler(event, context):
    print("This is private lambda handler------>")
    return {
            "statusCode": 200,
            "body": json.dumps({
                "message": 'tested'
            }),
            "headers":{ 'Access-Control-Allow-Origin' : '*' }
        }