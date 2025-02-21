# UNIT TESTING 

import pytest
import azure.functions as func
from .. import main

def test_product_denormalisation():
    # Mock HTTP request
    req = func.HttpRequest(
        method='POST',
        url='/api/productDenormalisation',
        body=b'{"productId": 1, "name": "ProductA", "category": "CategoryA"}',
        headers={}
    )

    # Call the main function
    resp = main(req)

    # Assert the response
    assert resp.status_code == 200
    assert resp.get_body() == b'{"message": "Product denormalisation completed", "data": {"product_id": 1, "name": "ProductA", "category": "CategoryA"}}'
