CREATE TABLE IF NOT EXISTS "user" (
  "id" SERIAL PRIMARY KEY,
  "avatar" VARCHAR (150),
  "name" VARCHAR (150) NOT NULL,
  "email" VARCHAR (20) UNIQUE NOT NULL,
  "signed_up_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE PROCEDURE get_estudiantes()
LANGUAGE SQL
BEGIN ATOMIC

  SELECT ci, nombre FROM "user";

END;

CREATE OR REPLACE PROCEDURE  get_estudiantes(
  a OUT INT
)
AS $$
DECLARE
  result INT;
BEGIN
  result:= 24;

  SELECT * FROM "user";

  a:=result;
END; $$
LANGUAGE plpgsql; 

DO $$
DECLARE myvar INTEGER;
BEGIN
  get_estudiantes(myvar);

  SELECT myvar;
END $$;

SELECT * FROM tmp_table;

CREATE TABLE IF NOT EXISTS "repository" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR (150) NOT NULL,
  "description" VARCHAR (500) NOT NULL,
  "is_public" BOOLEAN,
  "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS "file_type" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(50) NOT NULL,
);

CREATE TABLE IF NOT EXISTS "file" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR (100) NOT NULL,
  "size" INT NOT NULL,
  "type_id" INT NOT NULL,
  "father_id" INT,
  "repository_id" INT NOT NULL,
  "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  FOREIGN KEY ("repository_id") REFERENCES "repository"("id"),
  FOREIGN KEY ("father_id") REFERENCES "file"("id"),
  FOREIGN KEY ("type_id") REFERENCES "file_type"("id")
);

CREATE TABLE IF NOT EXISTS "raw_file" (
  "file_id" INT NOT NULL PRIMARY KEY,
  "file" BYTEA,

  FOREIGN KEY ("file_id") REFERENCES "file"("id"),
);

CREATE TABLE IF NOT EXISTS "comment" (
  "id" SERIAL PRIMARY KEY,
  "content" VARCHAR (550) NOT NULL,
  "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  "comment_id" INT NOT NULL,
  "user_id" INT NOT NULL,
  "file_id" INT NOT NULL,

  FOREIGN KEY ("file_id") REFERENCES "file"("id"),
  FOREIGN KEY ("user_id") REFERENCES "user"("id")
);

CREATE TABLE IF NOT EXISTS "member" (
  "id" SERIAL PRIMARY KEY,
  "expires" TIMESTAMP,
  "last_activity" TIMESTAMP,
  "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  "user_id" INT NOT NULL,
  "repository_id" INT NOT NULL,
  "role_id" INT NOT NULL,

  FOREIGN KEY ("role_id") REFERENCES "role"("id"),
  FOREIGN KEY ("repository_id") REFERENCES "repository"("id"),
  FOREIGN KEY ("user_id") REFERENCES "user"("id")
);

CREATE TABLE IF NOT EXISTS "role" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS "permit" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(50) NOT NULL,
);

CREATE TABLE IF NOT EXISTS "can_do" (
  "permit_id" INT NOT NULL PRIMARY KEY,
  "role_id" INT NOT NULL PRIMARY KEY,

  FOREIGN KEY ("permit_id") REFERENCES "permit"("id"),
  FOREIGN KEY ("role_id") REFERENCES "role"("id")
);

CREATE TABLE IF NOT EXISTS "history" (
  "member_id" INT NOT NULL PRIMARY KEY,
  "file_id" INT NOT NULL PRIMARY KEY,
  "permit_id" INT NOT NULL PRIMARY KEY,
  "happend_on" TIMESTAMP DEFAULT CURRENT_TIMESTAMP PRIMARY KEY,

  FOREIGN KEY ("permit_id") REFERENCES "permit"("id"),
  FOREIGN KEY ("file_id") REFERENCES "file"("id"),
  FOREIGN KEY ("member_id") REFERENCES "member"("id")
);
