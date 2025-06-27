## E-commerce Data Model

### 1. Navrhnite dátový model vo forme ER diagramu (Entity-Relationship diagram), ktorý pokryje nasledovné požiadavky:

![ER-diagram](images/diagram.png)  
*Diagram znázorňuje relačný model databázy pre e-commerce aplikáciu.*

---

### 2. Definujte dimenzie a faktové tabuľky pre analytické potreby:

![Snowflake scheme](images/snowflake_scheme.png)  
*Analytický model vo forme snowflake schémy s dimenziami a faktovou tabuľkou.*

---

### 3. Identifikujte:

#### 3.1. Primárne a cudzie kľúče:

- **Products**: `id` (PK), `category_id` (FK)
- **Categories**: `id` (PK), `parent_category_id` (FK)
- **Customers**: `id` (PK)
- **Orders**: `id` (PK), `customer_id` (FK)
- **OrderItems**: `id` (PK), `order_id` (FK), `product_id` (FK)
- **Transactions**: `id` (PK), `order_id` (FK)

#### 3.2. Možné normalizačné kroky a úrovne normalizácie:

Dátový model pre OLTP časť bol navrhnutý podľa zásad 3. normálnej formy (3NF):

- **1NF (Prvá normálna forma):**
  - Každý stĺpec obsahuje len atómové (nedeliteľné) hodnoty.
  - V tabuľkách nie sú opakujúce sa skupiny ani zoznamy.

- **2NF (Druhá normálna forma):**
  - Všetky ne-kľúčové atribúty sú plne závislé od celého primárneho kľúča.

- **3NF (Tretia normálna forma):**
  - Neexistujú tranzitívne závislosti medzi ne-kľúčovými atribútmi.

Takto navrhnutý model zabezpečuje minimálnu redundanciu, konzistenciu údajov a jednoduchú údržbu dát.

#### 3.3. Miesta, kde by denormalizácia mohla zvýšiť výkonnosť analytických dotazov:

- **Zlúčenie `ProductDim` a `CategoryDim`:**
  - Umožní analyzovať predaje podľa kategórie bez ďalšieho JOIN-u.

- **Zlúčenie `CustomerDim` a `RegionDim`:**
  - Umožní rýchlejšie agregácie podľa regiónu.

- **Pridanie opisných polí do faktovej tabuľky:**
  - Napr. `product_name`, `customer_region`, ak sa často používajú vo filtroch.

---

### 4. SQL schéma na vytvorenie tabuliek:

```sql
CREATE TABLE "products" (
    "id" integer PRIMARY KEY,
    "name" varchar(255),
    "price" float,
    "description" varchar(255),
    "availability" bool,
    "category_id" integer NOT NULL
);

CREATE TABLE "categories" (
  "id" integer PRIMARY KEY,
  "name_category" varchar(255),
  "parent_category_id" integer NULL
);

CREATE TABLE "customers" (
 "id" integer PRIMARY KEY,
 "name" varchar(255),
 "email" varchar(255),
 "address" varchar(255),
 "region" varchar(255),
 "registration_date" timestamp
);

CREATE TABLE "orders" (
  "id" integer PRIMARY KEY,
  "customer_id" integer NOT NULL,
  "order_date" timestamp,
  "status" varchar(100)
);

CREATE TABLE "orderItems" (
  "id" integer PRIMARY KEY,
  "order_id" integer NOT NULL,
  "product_id" integer NOT NULL,
  "quantity" integer,
  "unit_price" float
);

CREATE TABLE "transactions" (
    "id" integer PRIMARY KEY,
    "order_id" integer NOT NULL,
    "date" timestamp,
    "payment_method" varchar(100),
    "amount" float
);

ALTER TABLE "products" ADD FOREIGN KEY ("category_id") REFERENCES "categories" ("id");
ALTER TABLE "orders" ADD FOREIGN KEY ("customer_id") REFERENCES "customers" ("id");
ALTER TABLE "orderItems" ADD FOREIGN KEY ("order_id") REFERENCES "orders" ("id");
ALTER TABLE "orderItems" ADD FOREIGN KEY ("product_id") REFERENCES "products" ("id");
ALTER TABLE "transactions" ADD FOREIGN KEY ("order_id") REFERENCES "orders" ("id");
ALTER TABLE "categories" ADD FOREIGN KEY ("parent_category_id") REFERENCES "categories" ("id");
```

---

### 5. Diskusia

#### Aké kompromisy by ste spravili medzi normalizáciou a výkonnosťou?

V závislosti od cieľov systému by som urobil kompromis medzi normalizáciou a výkonom. 
Napríklad:

  - ponechal normalizáciu tam, kde sú časté zápisy a aktualizácie (pre zachovanie integrity),
  
  - no v častiach, kde sa často vykonávajú analytické dotazy, by som niektoré tabuľky denormalizoval (napr. zlúčil tabuľky alebo duplikoval vybrané údaje), aby sa zvýšila rýchlosť čítania.

#### Ako by ste riešili historické zmeny (napr. zmena ceny produktu, adresa zákazníka)?

Skúmal by som historické zmeny, aby som mohol analyzovať údaje v čase. Znamená to, že by som ukladal nielen aktuálny stav, ale aj predchádzajúce hodnoty.

Napríklad:

  - pri cene produktu by som sledoval, ako sa menila v priebehu roka a ako tieto zmeny ovplyvňovali správanie zákazníkov a tržby;

  - pri adresách zákazníkov by som si vedel spätne zistiť, z akého regiónu zákazník objednával v danom čase — napríklad kvôli logistike alebo segmentácii.

#### Aké indexy by ste pridali na zlepšenie výkonnosti dotazov?

Na zlepšenie výkonnosti dotazov by som pridal indexy na stĺpce, ktoré sa často používajú vo filtrovaní , triedeníalebo spojeniach. Konkrétne:

Indexy v transakčnej databáze:
  - orders(customer_id) – zrýchľuje dotazy typu „objednávky zákazníka“.

  - orderItems(order_id) – efektívne pre zobrazenie položiek v objednávke.

  - orderItems(product_id) – ak potrebujeme zistiť, koľkokrát sa produkt predal.

  - transactions(order_id) – pre rýchly prístup k transakciám objednávky.

  - customers(email) – ak vyhľadávame zákazníka podľa emailu (napr. pri login/CRM).

  - products(category_id) – filtrovanie produktov podľa kategórie.
