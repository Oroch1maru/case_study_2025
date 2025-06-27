## Integrácia dát

Tento Python projekt extrahuje údaje o mestských knižniciach z [Golemio API](https://api.golemio.cz) a exportuje vybrané polia do CSV súboru.

## Funkcionalita

- Pripojenie k verejnému Golemio API
- Extrakcia a transformácia údajov o mestských knižniciach v Prahe
- Export údajov do CSV súboru s bodkočiarkovým oddeľovačom
- Automatické spustenie každý deň o 7:00 (pražského času) pomocou GitHub Actions

## Extrahované polia

Výstupný CSV súbor obsahuje nasledujúce parametre:

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

## Požiadavky

- Python 3.11+
- Súbor `.env` s vaším API kľúčom::

```env
GOLEMIO_API_KEY=your_api_key_here
```

## Lokálne spustenie

```bash
git clone https://github.com/Oroch1maru/case_study_2025.git
cd case_study_2025/task_2
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python main.py
```

## Automatizácia cez GitHub Actions

Tento projekt používa GitHub Actions na denné spustenie o **07:00 (pražského času, 05:00 UTC)** a nahráva aktuálny CSV súbor ako artefakt.
Proces je možné spustiť aj manuálne v záložke GitHub Actions.

## Výstup

CSV súbor sa uloží do priečinka `output/` a je taktiež dostupný na stiahnutie ako GitHub artefakt.

