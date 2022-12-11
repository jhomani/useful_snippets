
CREATE TABLE IF NOT EXISTS "user" (
  "id" SERIAL PRIMARY KEY,
  "avatar" VARCHAR (150),
  "name" VARCHAR (150) NOT NULL,
  "email" VARCHAR (20) UNIQUE NOT NULL,
  "signed_up_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS "role" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS "action" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS "user_interface" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(50) NOT NULL,
);

CREATE TABLE IF NOT EXISTS "can_do" (
  "action_id" INT NOT NULL PRIMARY KEY,
  "role_id" INT NOT NULL PRIMARY KEY,
  "active" BOOLEAN DEFAULT TRUE,

  FOREIGN KEY ("action_id") REFERENCES "action"("id"),
  FOREIGN KEY ("role_id") REFERENCES "role"("id")
);

CREATE TABLE IF NOT EXISTS "assign_role" (
  "user_id" INT NOT NULL PRIMARY KEY,
  "role_id" INT NOT NULL PRIMARY KEY,
  "created" DATETIME NOT NULL,
  "until" DATETIME NOT NULL,

  FOREIGN KEY ("user_id") REFERENCES "user"("id"),
  FOREIGN KEY ("role_id") REFERENCES "role"("id")
);

CREATE TABLE IF NOT EXISTS "assign_ui" (
  "ui_id" INT NOT NULL PRIMARY KEY,
  "action_id" INT NOT NULL PRIMARY KEY,
  "active" BOOLEAN DEFAULT TRUE,

  FOREIGN KEY ("ui_id") REFERENCES "ui"("id"),
  FOREIGN KEY ("action_id") REFERENCES "action"("id")
);
