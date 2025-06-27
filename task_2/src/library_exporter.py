import os
from dotenv import load_dotenv

from src.library_record import LibraryRecord
from src.csv_exporter import CsvExporter
from src.golemio_client import GolemioClient


class LibraryExtractor:
    def __init__(self):
        load_dotenv(".env")
        api_key = os.getenv("GOLEMIO_API_KEY")
        self.client = GolemioClient(api_key)
        output_path = os.path.join(os.path.dirname(__file__), "..", "output", "libraries.csv")
        self.exporter = CsvExporter(os.path.abspath(output_path))

    def run(self):
        raw_data = self.client.fetch_libraries()
        records = [LibraryRecord(lib).to_dict() for lib in raw_data]
        self.exporter.save(records)
