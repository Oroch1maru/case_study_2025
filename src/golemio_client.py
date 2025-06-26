import requests

class GolemioClient:
    def __init__(self, api_key:str):
        self.api_key = api_key
        self.url = "https://api.golemio.cz/v2/municipallibraries"

    def fetch_libraries(self) -> list[dict]:
        headers = {
            "accept": "application/json; charset=utf-8",
            "X-Access-Token": self.api_key
        }
        response = requests.get(self.url, headers=headers)
        if response.status_code == 200:
            return response.json().get("features", [])
        else:
            raise Exception(f"Failed to fetch data: {response.status_code}")