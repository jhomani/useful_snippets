-- 1.
DECLARE
  saldo_act FLOAT
  mont FLOAT := 3000
  cuenta_id INTEGER := 12
BEGIN TRANSACTION;
SELECT INTO saldo_act saldo FROM cuenta WHERE cuentaID=cuenta_id;

UPDATE cuenta SET saldo=saldo-mont WHERE cuentaID=cuenta_id;
IF saldo_act > mont THEN
  COMMIT TRANSACTION;
ELSE
  ROLLBACK TRANSACTION;
END IF;
-- 2.
-- igual que el 1. solo cambiar valirables

-- 3.
-- nro,ci,tipo,saldo
-- 12, 5, a, 2000
-- 13, 7, c, 5000

-- 4.
-- nro,ci,tipo,saldo
-- 12, 5, a, 2000
-- 13, 7, c, 5000
