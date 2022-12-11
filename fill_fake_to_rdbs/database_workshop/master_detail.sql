CREATE TABLE IF NOT EXISTS "product" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR (50) NOT NULL,
  "price" NUMERIC(4, 2) NOT NULL
);

CREATE TABLE IF NOT EXISTS "image" (
  "id" SERIAL PRIMARY KEY,
  "url" VARCHAR (250) NOT NULL,
  "product_id" INT NOT NULL,

  FOREIGN KEY ("product_id") REFERENCES "product"("id")
);

CREATE TABLE IF NOT EXISTS "client" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR (50) NOT NULL,
  -- ...
  "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS "bank_card" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR (250) NOT NULL,
  --...
  "client_id" INT NOT NULL,

  FOREIGN KEY ("client_id") REFERENCES "client"("id")
);
