- configure SQS FIFO queue
- Configure Lambda Trigger to invoke TransactionProcessorLambda.py

#### Flow
- APIGW + TransactionReceiverLambda.py publish individual messages from the message payload (apipost-message.json)
- SQS FIFO has lambda trigger configured to invoke TransactionProcessorLambda.py
