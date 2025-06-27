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
