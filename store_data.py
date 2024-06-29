import json
import boto3
import uuid

dynamodb = boto3.resource('dynamodb')

table = dynamodb.Table('MyDataTable')

def lambda_handler(event, context):
    data = json.loads(event['body'])
    
    # Generate a unique ID using UUID
    id = str(uuid.uuid4())
    print(f"Generated ID: {id}")  # Print the generated ID
    
    # Create a new item with the generated ID and the provided data
    item = {
        'id': id,                   
        'data': data['data']       
    }
    
    table.put_item(Item=item)
    
    # Return a response with a status code of 200 and the created item in the body
    return {
        'statusCode': 200,         
        'body': json.dumps(item)    
    }
