-- === CONSULTA 1: Resumen ejecutivo mensual ===
SELECT
    MONTH(fecha_venta)                          AS mes,
    SUM(cantidad * precio_unitario)             AS total_facturado,
    COUNT(*)                                    AS cantidad_pedidos,
    ROUND(AVG(cantidad * precio_unitario), 2)   AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

-- === CONSULTA 2: Ranking de productos (Top 5 por facturación) ===
SELECT TOP 5
    id_producto,
    SUM(cantidad)                         AS unidades_vendidas,
    SUM(cantidad * precio_unitario)       AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;

-- === CONSULTA 3: Clientes recurrentes (más de un pedido) ===
SELECT
    id_cliente,
    COUNT(*)                          AS cantidad_pedidos,
    SUM(cantidad * precio_unitario)   AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC;

-- === CONSULTA 4: Meses por encima / por debajo del promedio ===
-- Nota: todas las ventas cargadas son de marzo de 2024, por lo que hay un
-- solo mes y su total coincide con el promedio mensual ('En el promedio').
-- Con más meses cargados, cada fila quedaría 'Por encima' o 'Por debajo'.
SELECT
    MONTH(fecha_venta)                  AS mes,
    SUM(cantidad * precio_unitario)     AS total_facturado,
    CASE
        WHEN SUM(cantidad * precio_unitario) >
             (SELECT SUM(cantidad * precio_unitario) / COUNT(DISTINCT MONTH(fecha_venta)) FROM ventas)
            THEN 'Por encima'
        WHEN SUM(cantidad * precio_unitario) <
             (SELECT SUM(cantidad * precio_unitario) / COUNT(DISTINCT MONTH(fecha_venta)) FROM ventas)
            THEN 'Por debajo'
        ELSE 'En el promedio'
    END AS comparacion_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

-- === BLOQUE DE CIERRE: HALLAZGOS ===
-- 1) El producto 1 concentra el 55,9% de la facturación de marzo
--    (3.600 de 6.444) con solo 3 de las 29 unidades vendidas.
-- 2) El producto 2 es el más vendido en volumen (13 de 29 unidades,
--    44,8%) pero aporta apenas el 5,6% de lo facturado (364 de 6.444).
-- 3) Los 5 clientes son recurrentes (2 pedidos cada uno), pero el gasto
--    está concentrado: el cliente 1 explica el 41,0% del total (2.640)
--    y, junto con el cliente 5, el 73,6% (4.740 de 6.444).
