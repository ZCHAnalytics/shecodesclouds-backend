import azure.functions as func
from azure.data.tables import TableServiceClient, UpdateMode
import os
import logging
import json
import traceback  # For better error details

app = func.FunctionApp()

# Set logging level
logging.basicConfig(level=logging.INFO)

@app.route(route="VisitorCounter", auth_level=func.AuthLevel.ANONYMOUS)
def VisitorCounter(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('===VISITOR COUNTER FUNCTION CALLED ===')
    
    # Debug: Check environment variables
    cosmos_endpoint = os.environ.get("COSMOS_ENDPOINT")
    cosmos_key      = os.environ.get("COSMOS_KEY")
    table_name      = "VisitorCounter"
    
    logging.info(f"Cosmos endpoint: {cosmos_endpoint}")
    logging.info(f"Table name: {table_name}")
    
    try:
        # Extract account name from endpoint
        # From: https://zchresume-cosmos.documents.azure.com:443/
        # Extract: zchresume-cosmos
        account_name = cosmos_endpoint.split('.')[0].replace('https://', '').replace('http://', '')

        # Build  Table API endoint  
        table_endpoint = f"https://{account_name}.table.cosmos.azure.com:443/"

        # Build connection string for Table API
        conn_str = f"DefaultEndpointsProtocol=https;AccountName={account_name};AccountKey={cosmos_key};TableEndpoint={table_endpoint}"
        
        logging.info(f"Account name: {account_name}")
        logging.info(f"Table endpoint: {table_endpoint}")

        logging.info("Creating table service client...")
        table_service = TableServiceClient.from_connection_string(conn_str)
        
        logging.info("Getting table client...")
        table_client = table_service.get_table_client(table_name=table_name)
        
        # Counter entity details
        partition_key = "counter"
        row_key = "visits"
        
        try:
            entity = table_client.get_entity(partition_key=partition_key, row_key=row_key)
            current_count = entity.get("count", 0) + 1
            logging.info(f"Found existing entity with count: {current_count - 1}")
        except Exception as read_error:
            logging.info(f"No existing entity, creating new one: {str(read_error)}")
            current_count = 1
        
        # Update entity
        entity = {
            "PartitionKey": partition_key,
            "RowKey": row_key,
            "count": current_count
        }
        
        logging.info("Updating entity...")
        table_client.upsert_entity(entity=entity, mode=UpdateMode.REPLACE)
        
        return func.HttpResponse(
            json.dumps({"count": current_count}),
            status_code=200,
            headers={
                "Content-Type": "application/json",
                "Access-Control-Allow-Origin": "*"
            }
        )
        
    except Exception as e:
        # Get detailed error information
        error_details = {
            "error": str(e),
            "type": type(e).__name__,
            "traceback": traceback.format_exc()
        }
        logging.error(f"Detailed error: {json.dumps(error_details)}")
        
        return func.HttpResponse(
            json.dumps(error_details),
            status_code=500,
            headers={"Content-Type": "application/json"}
        )
