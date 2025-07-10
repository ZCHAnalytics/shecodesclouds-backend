import requests
import pytest

BASE_URL = "https://zch-resume-function-app.azurewebsites.net/api"

def test_open_access():
    response = requests.get(f"{BASE_URL}/VisitorCounter")
    assert response.status_code == 200
    
@pytest.mark.skip(reason="Authentication not enabled on the function app")
def test_authenticated_access():
    token = "DUMMY_TOKEN"
    headers = {"Authorization": f"Bearer {token}"}
    response = requests.get(f"{BASE_URL}/secure-data", headers=headers)
    assert response.status_code == 200