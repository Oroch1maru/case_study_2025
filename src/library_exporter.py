import os
from dotenv import load_dotenv

from library_record import LibraryRecord
from csv_exporter import CsvExporter
from golemio_client import GolemioClient


class LibraryExtractor:
    def __init__(self):
        load_dotenv("../.env")
        api_key = os.getenv("GOLEMIO_API_KEY")
        self.client = GolemioClient(api_key)
        self.exporter = CsvExporter("../output/libraries.csv")

    def run(self):
        raw_data = self.client.fetch_libraries()
        records = [LibraryRecord(lib).to_dict() for lib in raw_data]
        self.exporter.save(records)
