CREATE PROCEDURE get_estudiantes()
LANGUAGE SQL
BEGIN ATOMIC

  SELECT ci, nombre FROM Estudiante WHERE ci IN (
    SELECT ci FROM Nota GROUP BY ci HAVING AVG(nota) > 90
  );

END;

CREATE PROCEDURE get_estudiantes(greatThen FLOAT)
LANGUAGE SQL
BEGIN ATOMIC

  SELECT ci, nombre FROM Estudiante WHERE ci IN (
    SELECT ci FROM Nota GROUP BY ci HAVING AVG(nota) > greatThen
  );

END;

CREATE PROCEDURE get_estudiantes(ci INTEGER, prom OUT FLOAT)
LANGUAGE SQL
BEGIN ATOMIC

  SELECT ci, prom := AVG(nota) FROM Nota WHERE ci=ci GROUP BY ci;

END;
