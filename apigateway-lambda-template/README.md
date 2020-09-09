### This is basic template for APIGateway to Lambda integration

This is basic stack that creates 
- VPC with attached Internet Gateway
- 2 public subnets
- 2 private subnets
- 1 public Route Table (associated 1 public Subnet)
- 2 private Route Tables (associated 2 private Subnets)
- Bastion Host
- Lambda Caller EC2 host in Private subnet (this is not being used in this exercise, just leave it as is)
- Lambda function (Not in VPC)
- Rest API APIGW (Regional) that talks to the Lambda (AWS_PROXY)
