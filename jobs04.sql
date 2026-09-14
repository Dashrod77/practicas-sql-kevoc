DELIMITER $$
CREATE EVENT job04
ON SCHEDULE EVERY 1 DAY STARTS CURRENT_DATE + INTERVAL 23 HOUR
DO
BEGIN
SELECT fecha_generacion FROM resumen_diario WHERE fecha = CURDATE();
INSERT INTO resumen_diario (fecha, prestamos_activos,prestamos_vencidos,equipos_disponibles,equipos_mantenimiento,multas_pendientes ) VALUES (CURDATE() ,(SELECT COUNT(*) FROM Prestamo WHERE estado = 'activo'),(SELECT COUNT(*) FROM prestamo WHERE estado = 'vencido'),(SELECT COUNT(*) FROM equipo WHERE estado = 'disponible'),(SELECT COUNT(*) FROM equipo WHERE estado = 'mantenimiento'),(SELECT COUNT(*) FROM multa WHERE estado = 'pendiente')) ON DUPLICATE KEY UPDATE prestamos_activos = (SELECT COUNT(*) FROM prestamo WHERE estado = 'activo' AND fecha_devolucion_programada >= NOW()), prestamos_vencidos = (SELECT COUNT(*) FROM prestamo WHERE estado = 'vencido' AND fecha_devolucion_programada < NOW()), equipos_disponibles = (SELECT COUNT(*) FROM equipo WHERE estado = 'disponible'), equipos_mantenimiento = (SELECT COUNT(*) FROM equipo WHERE estado = 'mantenimiento'), multas_pendientes = (SELECT COUNT(*) FROM multa WHERE estado = 'pendiente');
END $$
DELIMITER ;
