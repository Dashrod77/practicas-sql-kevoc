DELIMITER $$
  CREATE EVENT job02
  ON SCHEDULE EVERY 1 DAY
DO
  BEGIN
  SELECT codigo_inventario , fecha_proximo_mantenimiento FROM equipo WHERE fecha_proximo_mantenimiento BETWEEN CURDATE() AND CURDATE() + INTERVAL 7 DAY;
  END $$
  DELIMITER ;
