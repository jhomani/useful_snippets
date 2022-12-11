CREATE TABLE IF NOT EXISTS "language" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR (50) NOT NULL,
);

CREATE TABLE IF NOT EXISTS "post_dictionary" (
  "post_id" INT NOT NULL PRIMARY KEY,
  "language_id" INT NOT NULL PRIMARY KEY,
  "title" VARCHAR (200) NOT NULL,
  "content" TEXT NOT NULL,

  FOREIGN KEY ("language_id") REFERENCES "language"("id")
);


CREATE TABLE IF NOT EXISTS "provider" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR (200) NOT NULL,
  -- ...
  "country_id" INT NOT NULL PRIMARY KEY,

  FOREIGN KEY ("country_id") REFERENCES "country"("id")
);

CREATE TABLE IF NOT EXISTS "country" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR (50) NOT NULL,
);
