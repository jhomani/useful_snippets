-- show blocked transacctionsi-- 
SELECT
  funcion_interfazusuario.idinterfazusuario
FROM (
  SELECT
    rol_funcion.idfuncion
  FROM (
    SELECT
      user_rol.idrol
  	FROM (
      SELECT
        idusuario
      FROM
        usuario
      WHERE
        usuario.nombreusuario = 'adan' AND
        usuario.contrasena = MD5('adanllanos')
    ) uno, user_rol
    WHERE
      user_rol.idusuario = uno.idusuario
  ) dos, rol_funcion
  WHERE
    rol_funcion.idrol = dos.idrol
) tres, funcion_interfazusuario
WHERE
  funcion_interfazusuario.idfuncion=tres.idfuncion;
