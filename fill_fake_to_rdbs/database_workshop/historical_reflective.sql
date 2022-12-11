CREATE TABLE IF NOT EXISTS "project" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR (150) NOT NULL
  -- ...
);

CREATE TABLE IF NOT EXISTS "employee" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR (150) NOT NULL,
  "salary" NUMERIC(5,2) NOT NULL,
  -- ...
);

CREATE TABLE IF NOT EXISTS "project_team" (
  "team_lead_id" INT NOT NULL PRIMARY KEY,
  "developer_id" INT NOT NULL PRIMARY KEY,
  "project_id" INT NOT NULL PRIMARY KEY,
  "date" DATE NOT NULL PRIMARY KEY,

  FOREIGN KEY ("team_lead_id") REFERENCES "employee"("id"),
  FOREIGN KEY ("developer_id") REFERENCES "employee"("id"),
  FOREIGN KEY ("project_id") REFERENCES "project"("id"),
);
