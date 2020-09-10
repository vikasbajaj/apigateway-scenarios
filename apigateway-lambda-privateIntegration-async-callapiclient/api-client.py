import requests

url = 'https://vc7q02v5hg.execute-api.ap-southeast-2.amazonaws.com/demo/democall'
x = requests.post(url)

print(x.text)