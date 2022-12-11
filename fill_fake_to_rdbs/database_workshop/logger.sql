CREATE TABLE IF NOT EXISTS "sale" (
  "id" SERIAL PRIMARY KEY,
  "detail" VARCHAR (150) NOT NULL,
  "price" DECIMAL(7, 2) NOT NULL,
  "user_id" INT NOT NULL,

  FOREIGN KEY ("user_id") REFERENCES "user"("id")
);

CREATE TABLE IF NOT EXISTS "user" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR (150) NOT NULL,
  "email" VARCHAR (20) UNIQUE NOT NULL,
  "signed_up_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "session"(
  "id" SERIAL PRIMARY KEY,
  "process_id" INET NOT NULL,
  "ip_address" INET NOT NULL,
  "user_id" INT NOT NULL,

  FOREIGN KEY ("user_id") REFERENCES "user"("id")
);

CREATE TYPE VALID_ACTION AS ENUM ('delete', 'update', 'create');

CREATE TABLE IF NOT EXISTS log_record (
  id SERIAL,
  table_name VARCHAR(255),
  action_type VALID_ACTION,
  data_old JSON,
  data_new JSON,
  user JSON NOT NULL,
  happened_on TIMESTAMPTZ DEFAULT NOW()
);

---- 

CREATE OR REPLACE FUNCTION fn_log_after_insert()
RETURNS TRIGGER
AS $$
DECLARE new_record JSON;
DECLARE made_by JSON;
BEGIN
  new_record := row_to_json(NEW.*);

  SELECT
    made_by := row_to_json(u.*)
  FROM
    "user" u, "session" s
  WHERE 
    u.id = s.user_id AND 
    s.process_id = pg_backend_pid();

  INSERT INTO log_record
  VALUES ('sale', 'create', activity, NULL, new_record, made_by);

RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';

DROP TRIGGER IF EXISTS log_after_insert ON sale;

CREATE TRIGGER log_after_insert
AFTER INSERT ON sale FOR EACH ROW
EXECUTE PROCEDURE fn_log_after_insert();

------ 

CREATE OR REPLACE FUNCTION fn_log_after_delete()
RETURNS TRIGGER
AS $$
DECLARE new_record JSON;
DECLARE old_record JSON;
DECLARE made_by JSON;
BEGIN
  new_record :=  row_to_json(NEW.*);
  old_record :=  row_to_json(OLD.*);

  SELECT
    made_by := row_to_json(u.*)
  FROM
    "user" u, "session" s
  WHERE 
    u.id = s.user_id AND 
    s.process_id = pg_backend_pid();

  INSERT INTO log_record
  VALUES ('sale', 'delete', activity, old_record, new_record, made_by);
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';

DROP TRIGGER IF EXISTS log_after_delete ON sale;

CREATE TRIGGER log_after_delete
AFTER UPDATE ON sale FOR EACH ROW
EXECUTE PROCEDURE fn_log_after_delete();
