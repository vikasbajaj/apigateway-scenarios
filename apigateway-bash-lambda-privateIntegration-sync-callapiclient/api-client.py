import requests

url = 'https://i89eoacu30.execute-api.ap-southeast-2.amazonaws.com/demo/democall'

x = requests.post(url)

print(x.status_code)

if x.status_code == 200:
    print("processing successful")
else:
    print("issue with processing")