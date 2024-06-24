import json
import boto3

dynamodb = boto3.resource('dynamodb')

table_name = 'MyDataTable'
table = dynamodb.Table(table_name)

# Lambda function to retrieve data from DynamoDB
def lambda_handler(event, context):
    try:
        # Extract the item ID from the path parameters of the incoming request
        item_id = event['pathParameters']['id']
        
        # Fetch the item from the DynamoDB table using the provided ID
        response = table.get_item(Key={'id': item_id})
        
        # Retrieve the item from the response
        item = response.get('Item')
        
        if item:
            # Return a response with a status code of 200 and the item in the body
            response = {
                'statusCode': 200,
                'body': json.dumps(item)
            }
        else:
            # Return a response with a status code of 404 if the item was not found
            response = {
                'statusCode': 404,
                'body': json.dumps({'error': 'Item not found'})
            }
    # Return a response with an error status code and message if an exception occurs
    except Exception as e:
        response = {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }
    
    return response

