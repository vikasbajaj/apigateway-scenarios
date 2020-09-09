import json

def lambda_handler(event, context):
    print("This is private lambda handler------>")
    for x in range(1000000000):
        print("------Number is {}".format(x))