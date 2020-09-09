### This is basic template for APIGateway to Lambda integration

This is basic stack that creates 
- VPC with attached Internet Gateway
- 2 public subnets
- 2 private subnets
- 1 public Route Table (associated 2 public Subnets)
- 2 private Route Tables (associated 2 private Subnets)
- 2 NAT Gateways in respective private subnets
- Bastion Host
- Lambda Caller EC2 host in Private subnet
- Lambda function associated with VPC ****

#### Invoke Lambda from Lambda Caller EC2 Host using boto3
- Login into Bastion Host using the Keypair used in the CF stack
- ssh into Lambda Caller EC2 host in private subnet using the same Keypair
- copy lambda-client.py from this folder into Lambda Caller EC2 host
- Install Python 3 and Boto3 on Lambda caller host
        ```sudo yum install python3 -y```
        ```sudo pip3 install boto3```
- Run Lambda client from Lambda caller EC2 host
    ```python3 private_lambda.py```
     
