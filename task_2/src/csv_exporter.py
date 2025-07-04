import pandas as pd



class CsvExporter:
    def __init__(self, output_path:str):
        self.output_path = output_path

    def save(self, records:list[dict]):
        df = pd.DataFrame(records)
        df.to_csv(self.output_path, index=False, encoding="utf-8", sep=";")
        print(f"CSV saved: {self.output_path}")
