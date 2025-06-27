# Golemio Municipal Libraries Extractor

This Python project extracts data about municipal libraries from the [Golemio API](https://api.golemio.cz) and exports selected fields into a CSV file.

## Features

- Connects to the public Golemio API
- Extracts and transforms data from Prague municipal libraries
- Exports data to a semicolon-separated CSV file
- Scheduled to run daily at 7:00 AM (Prague time) via GitHub Actions

## Extracted fields

The output CSV file includes the following parameters:

1. ID knižnice — Library ID  
2. Názov knižnice — Library name  
3. Ulica — Street address  
4. PSČ — Postal code  
5. Mesto — City  
6. Kraj — Region 
7. Krajina — Country  
8. Zemepisná šírka — Latitude  
9. Zemepisná dĺžka — Longitude  
10. Čas otvorenia — Opening hours  

## Requirements

- Python 3.11+
- `.env` file with your API key:

```env
GOLEMIO_API_KEY=your_api_key_here
```

## Running locally

```bash
git clone https://github.com/Oroch1maru/case_study_2025.git
cd case_study_2025/task_2
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python main.py
```

## GitHub Actions automation

This project uses GitHub Actions to run daily at **07:00 Prague time (05:00 UTC)** and upload the latest CSV file as an artifact.  
You can also trigger it manually from the GitHub Actions tab.

## Output

The CSV file is saved to the `output/` directory and is also available as a downloadable GitHub artifact.

