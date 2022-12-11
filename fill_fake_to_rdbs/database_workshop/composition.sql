CREATE TABLE IF NOT EXISTS "student" (
  "id" SERIAL PRIMARY KEY,
  "ci" VARCHAR (20) UNIQUE NOT NULL,
  "name" VARCHAR (150) NOT NULL
  -- ...
);

CREATE TABLE IF NOT EXISTS "subject" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR (150) NOT NULL
  -- ...
);


CREATE TABLE IF NOT EXISTS "bank_card" (
  "student_id" INT NOT NULL PRIMARY KEY,
  "subject_id" INT NOT NULL PRIMARY KEY,
  "season" DATE NOT NULL PRIMARY KEY,
  "grade" INT NOT NULL,

  FOREIGN KEY ("student_id") REFERENCES "student"("id"),
  FOREIGN KEY ("subject_id") REFERENCES "subject"("id")
);

-----------


CREATE TABLE IF NOT EXISTS "client" (
  "id" SERIAL PRIMARY KEY,
  "code" VARCHAR (20) UNIQUE NOT NULL,
  "name" VARCHAR (150) NOT NULL
  -- ...
);

CREATE TABLE IF NOT EXISTS "offer" (
  "id" SERIAL PRIMARY KEY,
  "discount" NUMERIC(4, 2) NOT NULL
  -- ...
);

CREATE TABLE IF NOT EXISTS "product" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR (150) NOT NULL
  -- ..
);

CREATE TABLE IF NOT EXISTS "branch_office" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR (150) NOT NULL
  -- ...
);

CREATE TABLE IF NOT EXISTS "sell" (
  "client_id" INT NOT NULL PRIMARY KEY,
  "offer_id" INT NOT NULL PRIMARY KEY,
  "product_id" INT NOT NULL PRIMARY KEY,
  "branch_office_id" INT NOT NULL PRIMARY KEY,
  "date" TIMESTAMP  NOT NULL PRIMARY KEY,

  FOREIGN KEY ("client_id") REFERENCES "client"("id"),
  FOREIGN KEY ("product_id") REFERENCES "product"("id"),
  FOREIGN KEY ("branch_office_id") REFERENCES "branch_office"("id"),
  FOREIGN KEY ("offer_id") REFERENCES "offer"("id")
);
