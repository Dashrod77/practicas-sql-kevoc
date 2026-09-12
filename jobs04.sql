DELIMITER $$
CREATE EVENT job04
ON SCHEDULE EVERY 1 DAY AT 23:59:59
DO
BEGIN
SELECT fecha_generacion FROM resumen_diario WHERE fecha = CURDATE();
INSERT INTO resumen_diario (fecha, prestamo_activo,prestamo_vencido,equipos_disponibles,equipos_en_mantenimiento,multas_pendientes ) VALUES (CURDATE() ,(SELECT COUNT(*) FROM Prestamo WHERE estado = 'activo'),(SELECT COUNT(*) FROM prestamo WHERE estado = 'vencido'),(SELECT COUNT(*) FROM equipo WHERE estado = 'disponible'),(SELECT COUNT(*) FROM equipo WHERE estado = 'mantenimiento'),(SELECT COUNT(*) FROM multa WHERE estado = 'pendiente')) ON DUPLICATE KEY UPDATE prestamo_activo = (SELECT COUNT(*) FROM prestamo WHERE estado = 'activo' AND fecha_devolucion_programada >= NOW()), prestamo_vencido = (SELECT COUNT(*) FROM prestamo WHERE estado = 'vencido' AND fecha_devolucion_programada < NOW()), equipos_disponibles = (SELECT COUNT(*) FROM equipo WHERE estado = 'disponible'), equipos_en_mantenimiento = (SELECT COUNT(*) FROM equipo WHERE estado = 'mantenimiento'), multas_pendientes = (SELECT COUNT(*) FROM multa WHERE estado = 'pendiente');
END $$
DELIMITER ;
