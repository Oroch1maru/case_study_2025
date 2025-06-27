## 5. Otázky na hodnotenie osvedčených postupov

1. Používanie hardcoded hodnôt v ETL procesoch pre biznis pravidlá.

 - Nesprávny prístup - je lepšie používať konfiguračné súbory, pretože hodnoty sa môžu meniť a nie je vhodné vstupovať do kódu.

2.  Neindexovanie stĺpcov, ktoré sú často dotazované vo veľkých tabuľkách.

 - Nesprávny prístup - bez použitia indexov budú dotazy skenovať celú tabuľku, čo spôsobí spomalenie.

3. Ukladanie logov a záloh na rovnaký server ako produkčná databáza.

 - Nesprávny prístup - ukladanie logov a záloh tam, kde sa nachádza databáza, môže viesť k tomu, že sa miesto rýchlo vyčerpá, a ak spadne disk, na ktorom sa nachádza databáza, nebude možné obnoviť údaje, pretože sa stratila aj záloha.

4. Používanie zdieľaných servisných účtov na pripojenie k databázam v ETL nástrojoch.

 - Nesprávny prístup - ak všetci používajú rovnaké prihlasovacie údaje do databázy, môže to viesť k tomu, že ak niekto niečo pokazí, bude ťažké zistiť, kto to urobil. Lepšie je používať samostatné prihlasovacie údaje na zaznamenávanie akcií.

5. Budovanie dátových kanálov bez implementácie mechanizmov na opakovanie alebo zotavenie pri zlyhaní.

 - Nesprávny prístup - hrozí strata údajov. V situácii, keď údaje neboli doručené cez kanál, je lepšie pokúsiť sa ich po určitom čase odoslať znova a robiť to dovtedy, kým sa údaje nedoručia.

6. Povoľovanie priameho prístupu ku zdrojovým dátam všetkým členom tímu bez kontroly prístupu.

 - Nesprávny prístup - znižuje riziko získania údajov od neoprávnených osôb. Lepším prístupom by bolo zaviesť prístup podľa práv, napr. administrátor, bežný robotník. Použite napríklad matice prístupnosti.

7. Vynechanie validácie schémy pri načítavaní externých dát.

 - Nesprávny prístup - existuje riziko získania údajov, ktoré nie sú rovnakého typu, prázdnych hodnôt alebo škodlivých údajov. Vždy je lepšie skontrolovať údaje na vstupe.

8. Používanie zastaraných ETL procesov bez pravidelných revízií optimalizácie.

 - Nesprávny prístup - tieto funkcie nemusia byť podporované a môžu spôsobiť spomalenie programu. Je lepšie neustále aktualizovať systém na bezpečné verzie.

9. Nepremazanie alebo neodstránenie zastaraných tabuliek a pohľadov z dátového skladu.

 - Nesprávny prístup - môže viesť k nesprávnemu vnímaniu alebo retardácii. Nepoužívané údaje je lepšie vymazať alebo archivovať.

10. Nenastavenie upozornení na zlyhané úlohy alebo oneskorenia kanálov.

 - Nesprávny prístup - môže viesť k tomu, že v prípade chyby si používateľ ani neuvedomí, čo sa stalo. Je lepšie použiť nejaký druh upozornenia na chyby, napríklad poslať kód chyby na mail alebo použiť vyskakovacie okno.

11. Ukladanie citlivých údajov bez šifrovania pri ukladaní alebo prenose.

 - Nesprávny prístup - môže viesť k prečítaniu údajov narušiteľom. Citlivé údaje je vždy lepšie zašifrovať, napr. pomocou symetrického kľúča.  - Na ukladanie hesiel je lepšie používať hashovacie funkcie, preto je bežnou praxou používať soľ na hashovanie hesiel, aj keď je v databáze niekoľko rovnakých hesiel.

12. Ignorovanie obmedzení dátových typov pri vytváraní schém v dátovom sklade.

 - Nesprávny prístup - môže viesť k možným chybám alebo problémom s kvalitou údajov. Je lepšie používať správne typy pre všetky polia.

13. Povoľovanie kruhových závislostí medzi ETL úlohami.

 - Nesprávny prístup - môže viesť k situácii zacyklenia, čo povedie k tomu, že systém bude musieť byť reštartovaný. Môžete použiť obmedzenia vnorenia úloh alebo použiť smerovaný acyklický graf (DAG).

14. Vykonávanie transformácií priamo na produkčných databázach namiesto staging vrstiev.

 - Nesprávny prístup - môže viesť k spomaleniu systému, konfliktu so skutočnými údajmi alebo dokonca k strate údajov. Lepšie je použiť transforáciu údajov v staging layer, alebo zhruba povedané v návrhu údajov.

15. Výber dátového modelu (napr. hviezdica vs. snehová vločka) bez zohľadnenia použitia.

 - Nesprávny prístup - môže byť neúčinný. Lepšie je prispôsobiť model vašim potrebám.

16. Používanie VARCHAR(MAX) ako predvoleného dátového typu pre textové polia.

 - Nesprávny prístup - môže viesť k zabrzdeniu databáz alebo zberu odpadu. Je lepšie používať primerané limity, napr. pre mená s dĺžkou 255 znakov.

17. Pridávanie všetkých stĺpcov zo zdrojového systému do dátového skladu bez ohľadu na ich relevantnosť.

 - Nesprávny prístup - môže viesť k spomaleniu databázy. Je lepšie používať len potrebné polia v danom časovom intervale.

18. Vynechanie partitioningu alebo clusteringu pre veľké faktové tabuľky.

 - Nesprávny prístup - môže viesť k spomaleniu databázy. Je lepšie použiť clustering alebo partitioning

19. Vývoj a nasadenie zmien v pipeline bez verzovania alebo testovania.

 - Nesprávny prístup - môže viesť k rozpadu celého systému. Je lepšie testovať alebo používať na správu verzií systém git.