CREATE TABLE IF NOT EXISTS "category" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR (150) NOT NULL,
  -- ...
  "father_id" INT NOT NULL,

  FOREIGN KEY ("father_id") REFERENCES "category"("id")
)


CREATE TABLE IF NOT EXISTS "comment" (
  "id" SERIAL PRIMARY KEY,
  "content" VARCHAR (550) NOT NULL,
  "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  -- ...
  "comment_id" INT NOT NULL,

  FOREIGN KEY ("comment_id") REFERENCES "comment"("id")
);
