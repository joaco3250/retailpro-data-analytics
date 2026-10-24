-- === CONSULTA 1: Vista base del proyecto (INNER JOIN) ===
SELECT
    v.fecha_venta,
    v.id_cliente,
    c.nombre                         AS nombre_cliente,
    c.ciudad,
    p.nombre_producto,
    cat.nombre_categoria,
    v.cantidad,
    v.precio_unitario,
    v.cantidad * v.precio_unitario   AS total_venta
FROM ventas AS v
INNER JOIN clientes   AS c   ON v.id_cliente   = c.id_cliente
INNER JOIN productos  AS p   ON v.id_producto  = p.id_producto
INNER JOIN categorias AS cat ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta, v.id_venta;

-- === DATOS DE PRUEBA (M5) ===
-- Motivo: con los 25 registros originales del Módulo 3, todos los clientes
-- compraron al menos una vez y todos los productos tienen ventas. Por eso las
-- Consultas 2 y 3 (LEFT JOIN ... IS NULL) devolverían 0 filas y no se podría
-- comprobar que la lógica funciona.
-- Qué se agrega: 1 cliente sin compras (id 6) y 1 producto sin ventas (id 7).
-- Impacto: no se modifica ninguna venta, así que los totales facturados no
-- cambian. Solo aumenta la cantidad de clientes (6) y de productos (7).
-- El IF NOT EXISTS evita el error de clave duplicada si el bloque se ejecuta
-- más de una vez.
IF NOT EXISTS (SELECT 1 FROM clientes WHERE id_cliente = 6)
    INSERT INTO clientes (id_cliente, nombre, email, ciudad, fecha_registro)
    VALUES (6, 'Sofía Díaz', 'sofia@mail.com', 'La Plata', '2024-03-18');

IF NOT EXISTS (SELECT 1 FROM productos WHERE id_producto = 7)
    INSERT INTO productos (id_producto, nombre_producto, id_categoria, precio, stock, activo)
    VALUES (7, 'Webcam Full HD', 2, 60.00, 25, 1);

    -- === CONSULTA 2: Clientes sin ventas (LEFT JOIN) ===
SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes AS c
LEFT JOIN ventas AS v ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;

-- === CONSULTA 3: Productos sin ventas ===
SELECT
    p.nombre_producto,
    cat.nombre_categoria,
    p.precio
FROM productos AS p
INNER JOIN categorias AS cat ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas AS v        ON p.id_producto  = v.id_producto
WHERE v.id_venta IS NULL;

-- === CONSULTA 4: Consolidado por canal ===
SELECT canal, SUM(total) AS total_canal
FROM (
    SELECT fecha_venta, cantidad * precio_unitario AS total, 'Hasta el 10 de marzo' AS canal
    FROM ventas
    WHERE fecha_venta <= '2024-03-10'
    UNION ALL
    SELECT fecha_venta, cantidad * precio_unitario AS total, 'Desde el 11 de marzo' AS canal
    FROM ventas
    WHERE fecha_venta > '2024-03-10'
) AS consolidado
GROUP BY canal
ORDER BY total_canal DESC;

-- Hallazgo: el tramo hasta el 10 de marzo facturó 3.620 (56,2%) y el posterior 2.824 (43,8%),
-- con 5 ventas en cada uno. La diferencia la explica la venta 1 (2 Laptop Pro 15 por 2.400).