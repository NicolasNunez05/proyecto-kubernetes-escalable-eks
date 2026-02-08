"""
GPU API endpoint tests
"""
import pytest
from fastapi import status


def test_get_gpus_empty(client):
    """
    Test GET /api/gpus returns empty list initially
    """
    response = client.get("/api/gpus")
    assert response.status_code == status.HTTP_200_OK
    assert isinstance(response.json(), list)


def test_create_gpu(client, sample_gpu_data):
    """
    Test POST /api/gpus creates a new GPU
    """
    response = client.post("/api/gpus", json=sample_gpu_data)
    assert response.status_code == status.HTTP_201_CREATED
    
    data = response.json()
    assert data["name"] == sample_gpu_data["name"]
    assert data["brand"] == sample_gpu_data["brand"]
    assert data["price"] == sample_gpu_data["price"]
    assert "id" in data


def test_get_gpus_after_creation(client, sample_gpu_data):
    """
    Test GET /api/gpus returns created GPU
    """
    # Create GPU
    client.post("/api/gpus", json=sample_gpu_data)
    
    # Get all GPUs
    response = client.get("/api/gpus")
    assert response.status_code == status.HTTP_200_OK
    
    gpus = response.json()
    assert len(gpus) == 1
    assert gpus[0]["name"] == sample_gpu_data["name"]


def test_get_gpu_by_id(client, sample_gpu_data):
    """
    Test GET /api/gpus/{id} returns specific GPU
    """
    # Create GPU
    create_response = client.post("/api/gpus", json=sample_gpu_data)
    gpu_id = create_response.json()["id"]
    
    # Get GPU by ID
    response = client.get(f"/api/gpus/{gpu_id}")
    assert response.status_code == status.HTTP_200_OK
    
    data = response.json()
    assert data["id"] == gpu_id
    assert data["name"] == sample_gpu_data["name"]


def test_get_gpu_not_found(client):
    """
    Test GET /api/gpus/{id} returns 404 for non-existent GPU
    """
    response = client.get("/api/gpus/99999")
    assert response.status_code == status.HTTP_404_NOT_FOUND


def test_create_gpu_invalid_data(client):
    """
    Test POST /api/gpus with invalid data returns 422
    """
    invalid_data = {
        "name": "Test GPU"
        # Missing required fields
    }
    
    response = client.post("/api/gpus", json=invalid_data)
    assert response.status_code == status.HTTP_422_UNPROCESSABLE_ENTITY
