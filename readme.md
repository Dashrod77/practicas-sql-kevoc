JOB01 — Detectar préstamos vencidos

Qué debe hacer y entregar: Cada día el sistema debe encontrar préstamos con estado='ACTIVO' cuya fecha_devolucion_programada ya pasó y marcarlos VENCIDO. La regla debe ser idempotente (ejecutarlo dos veces no produce cambios adicionales). Un EVENT diario con schedule diario y condición que solo afecta a ACTIVO. Si decides auditar, registra en auditoria.
Probar:
-- Forzar un activo vencible UPDATE prestamo SET fecha_devolucion_programada = CURDATE() - INTERVAL 1 DAY WHERE prestamo_id=13; -- Ejecutar manualmente la lógica del evento (o esperar) -- Verificar SELECT prestamo_id, estado, fecha_devolucion_programada FROM prestamo WHERE prestamo_id=13;
Entregable: evento ev_prestamos_vencidos creado, SHOW EVENTS y SELECT antes/después.
-- check

JOB02 — Detectar mantenimientos próximos (7 días)

Qué debe hacer y entregar: Un EVENT diario que detecte equipos con fecha_proximo_mantenimiento dentro de los próximos 7 días. No actualiza el estado del equipo; solo demuestra detección. Cuida el rango de fechas y el filtro activo. Opcionalmente, deja evidencia (fila en auditoria — usuario_id es nullable — u otra que documentes).
Nota: auditoria tiene usuario_id nullable, así que puede insertar sin usuario.
Probar:
SELECT codigo_inventario, fecha_proximo_mantenimiento FROM equipo WHERE fecha_proximo_mantenimiento BETWEEN CURDATE() AND CURDATE()+INTERVAL 7 DAY; SELECT * FROM auditoria WHERE tabla_afectada='equipo' ORDER BY auditoria_id DESC LIMIT 5;
-- check

JOB03 — Expirar reservas

Qué debe hacer y entregar: Un EVENT periódico (frecuencia a justificar; sugerencia: horaria) que pase a EXPIRADA toda reserva con estado='APROBADA' cuya fecha_fin ya está en el pasado. Cuida el estado de origen y la comparación temporal (NOW() vs CURDATE() según tu tipo).
Probar:
-- Crear reserva APROBADA ya vencida INSERT INTO reserva (usuario_id, equipo_id, fecha_inicio, fecha_fin, motivo, estado) VALUES (1, 1, NOW()-INTERVAL 2 DAY, NOW()-INTERVAL 1 DAY, 'Prueba expiración', 'APROBADA'); SELECT reserva_id, estado, fecha_fin FROM reserva WHERE motivo='Prueba expiración'; -- Ejecutar UPDATE del evento y verificar → EXPIRADA

JOB04 — Generar resumen diario

Qué debe hacer y entregar: Cada noche, un EVENT diario que deje en resumen_diario el corte del día: una fila por fecha con 5 métricas, sin duplicar clave si el día ya tiene fila. Métricas: préstamos ACTIVO, préstamos VENCIDO, equipos DISPONIBLE (solo activos), equipos en MANTENIMIENTO, multas PENDIENTE. Revisa resumen_diario y su UNIQUE(fecha) para resolver el upsert.
Probar:
SELECT * FROM resumen_diario ORDER BY fecha DESC LIMIT 3; -- Forzar ejecución manual del SELECT y verificar que inserta/actualiza
