CREATE TABLE IF NOT EXISTS "product" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR (150) NOT NULL
  -- ...
);

CREATE TABLE IF NOT EXISTS "quote" (
  "product_id" INT NOT NULL PRIMARY KEY,
  "month" DATE NOT NULL,

  FOREIGN KEY ("product_id") REFERENCES "product"("id")
);

CREATE TABLE IF NOT EXISTS "book" (
  "product_id" INT NOT NULL PRIMARY KEY,
  "file_link" VARCHAR (150) NOT NULL,
  "total_pages" INT NOT NULL,

  FOREIGN KEY ("product_id") REFERENCES "product"("id")
);

CREATE TABLE IF NOT EXISTS "course" (
  "product_id" INT NOT NULL PRIMARY KEY,
  "start_at" TIMESTAMP NOT NULL,
  "teacher_id" INT NOT NULL,

  FOREIGN KEY ("product_id") REFERENCES "product"("id"),
  FOREIGN KEY ("teacher_id") REFERENCES "user"("id")
);

CREATE TABLE IF NOT EXISTS "mortuary" (
  "product_id" INT NOT NULL PRIMARY KEY,
  "deaceased_id" VARCHAR (150) NOT NULL,
  "dead_at" DATE NOT NULL,

  FOREIGN KEY ("product_id") REFERENCES "product"("id"),
  FOREIGN KEY ("deaceased_id") REFERENCES "user"("id")
);
