import json
import boto3

dynamodb = boto3.resource('dynamodb')

table_name = 'MyDataTable'
table = dynamodb.Table(table_name)

def lambda_handler(event, context):
    try:
        item_id = event['pathParameters']['id']
        
        # Fetch the item from the DynamoDB table using the provided ID
        response = table.get_item(Key={'id': item_id})
        
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
            
    except Exception as e:
        response = {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }
    
    return response

