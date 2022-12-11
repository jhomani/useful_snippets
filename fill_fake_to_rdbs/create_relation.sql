SET timezone = 'America/La_Paz';
SET statement_timeout = 0;

CREATE TABLE IF NOT EXISTS "Alumno" (
  "ci" serial PRIMARY KEY,
  "nom" VARCHAR (100) NOT NULL,
  "sexo" VARCHAR (10) NOT NULL,
  "direc" VARCHAR (200) NOT NULL,
  "fec_nac" TIMESTAMP,
  "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS "Carrera" (
  "sigla" serial PRIMARY KEY,
  "nom" VARCHAR (100) NOT NULL,
  "descrip" VARCHAR (100) NOT NULL,
  "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS "Materia" (
  "sigla" serial PRIMARY KEY,
  "nom" VARCHAR (100) NOT NULL,
  "descrip" VARCHAR (100) NOT NULL,
  "nivel" INTEGER NOT NULL,
  "creditos" VARCHAR (200) NOT NULL,
  "area" VARCHAR (50) NOT NULL,
  "sigla_car" INTEGER NOT NULL,
  "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  FOREIGN KEY ("sigla_car") REFERENCES "Carrera" ("sigla")
);


DROP TABLE "Nota";
CREATE TABLE IF NOT EXISTS "Nota" (
  "ci" INTEGER NOT NULL,
  "sigla" INTEGER NOT NULL,
  "gestion" VARCHAR (20) NOT NULL,
  "calif" INTEGER NOT NULL CHECK("calif" >= 0),

  FOREIGN KEY ("ci") REFERENCES "Alumno" ("ci"),
  FOREIGN KEY ("sigla") REFERENCES "Materia" ("sigla")
);

SELECT * FROM "Nota";
UPDATE "Alumno" SET sexo='male' WHERE ci IN (1, 3 );
UPDATE "Alumno" SET sexo='female' WHERE ci = 2;

-- INSERT INTO "Alumno"("nom", "sexo", "direc", "fec_nac") VALUES
--   ('Jose Carlos', 'm', 'Calle Gral. Pando', '2004-12-10'),
--   ('Veronica', 'm', 'Calle Ramon Rivero', '2001-10-10 13:41:08');

-- INSERT INTO "Carrera"("nom", "descrip") VALUES
--   ('Sistemas', 'Esta es la description'),
--   ('Matematicas', 'Esta es la description'),
--   ('Fisica', 'Esta es la description'),
--   ('Contaduria Publica', 'Esta es la description'),
--   ('Informatica', 'Esta es la description'),
--   ('Electronica', 'Esta es la description');

-- INSERT INTO "Materia"("nom", "descrip", "nivel", "creditos", "area", "sigla_car") VALUES
INSERT INTO "Nota"("ci", "sigla", "gestion", "calif") VALUES

-- INSERT INTO "money"("amount", "quantity", "imageuri", "atmid") VALUES(20, 10, 'http://localhost:9000/images/20.png', 1);

SELECT * FROM "Nota" WHERE ci = 41;


CREATE PROCEDURE takan_assings(num_mat INT)
LANGUAGE SQL
BEGIN ATOMIC

  SELECT N.ci, nom, avg(calif) FROM "Alumno" A, "Nota" N
    WHERE
      A.ci = N.ci AND
      A.ci IN (
        SELECT ci FROM "Nota" 
          GROUP BY ci 
          HAVING count(DISTINCT sigla) > num_mat
      )
    GROUP BY N.ci, nom;

END;

