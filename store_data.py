import json
import boto3
import uuid

# Initialize a DynamoDB resource using Boto3
dynamodb = boto3.resource('dynamodb')

# Specify the DynamoDB table
table = dynamodb.Table('MyDataTable')

# Lambda function handler
def lambda_handler(event, context):
    # Parse the JSON body of the incoming request
    data = json.loads(event['body'])
    
    # Generate a unique ID using UUID
    id = str(uuid.uuid4())
    print(f"Generated ID: {id}")  # Print the generated ID
    
    # Create a new item with the generated ID and the provided data
    item = {
        'id': id,                   # Use the generated ID
        'data': data['data']        # Extract 'data' field from the parsed JSON
    }
    
    # Put the item into the DynamoDB table
    table.put_item(Item=item)
    
    # Return a response with a status code of 200 and the created item in the body
    return {
        'statusCode': 200,          # HTTP status code 200 indicates success
        'body': json.dumps(item)    # Convert the item dictionary to a JSON string
    }
