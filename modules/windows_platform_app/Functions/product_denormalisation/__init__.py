import logging
import json
import azure.functions as func

def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info("ProductDenormalisation function triggered.")

    try:
        req_body = req.get_json()
    except ValueError:
        return func.HttpResponse(
            json.dumps({"error": "Invalid JSON"}),
            status_code=400,
            mimetype="application/json"
        )

    # Simulated denormalization logic
    denormalized_data = {
        "product_id": req_body.get("productId"),
        "name": req_body.get("name"),
        "category": req_body.get("category", "Unknown"),
    }

    return func.HttpResponse(
        json.dumps({"message": "Product denormalisation completed", "data": denormalized_data}),
        status_code=200,
        mimetype="application/json"
    )
