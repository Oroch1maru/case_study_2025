## 4. Výkonnostný problém v SQL transformácii

Na základe grafu je vidieť, že doba spracovania transformácie sa postupne predlžovala. Toto môže byť spôsobené viacerými dôvodmi:

#### Možné príčiny:

- Transformácia bola pôvodne navrhnutá pre malý objem dát, ktorý časom výrazne narástol.

- Nedostatok alebo neefektívne indexy v tabuľkách.

- Dotazy bez `WHERE` alebo `LIMIT`, resp. použitie `SELECT *`, čo spôsobuje úplný prechod cez tabuľky.

- Spracovanie sa vykonáva nad všetkými dátami, vrátane tých, ktoré už boli predtým spracované alebo sa nezmenili.

#### Praktické riešenia:

- Pridať indexy na stĺpce často používané v `WHERE`, `JOIN`, `GROUP BY`.

- Zaviesť filtre (napr. podľa dátumu), aby sa obmedzil objem spracovaných dát.

- Zjednodušiť transformáciu pomocou inkrementálneho prístupu – spracovávať len nové alebo zmenené dáta namiesto celej tabuľky.