DELIMITER $$

CREATE EVENT job01
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
DECLARE prestamo_id INT;
DECLARE estado VARCHAR(20);
DECLARE cur CURSOR FOR
SELECT prestamo_id, estado FROM prestamo WHERE estado = 'activo';
UPDATE prestamo SET estado = 'vencido' WHERE estado = 'activo' AND fecha_devolucion_programada < NOW();
END $$
DELIMITER ;
