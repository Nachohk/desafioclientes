CREATE DATABASE pruebaclientes;
---1 restauracion bd-
psql -U postgres pruebaclientes < C:\Users\ignac\Desktop\Apoyoprueba\unidad2.sql
\set AUTOCOMMIT OFF

--2.1--
SELECT cl.nombre, cl.email, c.fecha, d.cantidad, p.descripcion, p.stock, p.precio
FROM cliente cl
LEFT JOIN compra c ON cl.id = c.cliente_id
LEFT JOIN detalle_compra d ON c.id = d.compra_id
LEFT JOIN producto p ON d.producto_id = p.id 
WHERE cl.nombre = 'usuario01'
AND p.descripcion = 'producto9'
AND d.cantidad = 5;
AND c.fecha = CURRENT_DATE;

--2.3--
\set AUTOCOMMIT OFF
\echo :AUTOCOMMIT 
----

--2.4--
SELECT id, descripcion, stock, precio FROM producto WHERE descripcion='producto9';
----

--2.5--
BEGIN;
INSERT INTO compra (cliente_id, fecha)
SELECT id, CURRENT_DATE FROM cliente WHERE nombre = 'usuario01';

INSERT INTO detalle_compra (producto_id, compra_id, cantidad )
SELECT id, CURRVAL('compra_id_seq'), 5
FROM producto WHERE descripcion = 'producto9';

UPDATE producto
SET stock = stock - 5
WHERE id = (SELECT id FROM producto WHERE descripcion ='producto9');
COMMIT;

--2.6--
SELECT cl.nombre, cl.email, c.fecha, d.cantidad, p.descripcion, p.stock, p.precio
FROM cliente cl
LEFT JOIN compra c ON cl.id = c.cliente_id
LEFT JOIN detalle_compra d ON c.id = d.compra_id
LEFT JOIN producto p ON d.producto_id = p.id 
WHERE cl.nombre = 'usuario01'
AND p.descripcion = 'producto9'
AND d.cantidad = 5;
AND c.fecha = CURRENT_DATE;
----

--3--
SELECT cl.nombre, cl.email, c.fecha, d.cantidad, p.descripcion, p.stock, p.precio
FROM cliente cl
LEFT JOIN compra c ON cl.id = c.cliente_id
LEFT JOIN detalle_compra d ON c.id = d.compra_id
LEFT JOIN producto p ON d.producto_id = p.id 
WHERE cl.nombre = 'usuario02'
AND p.descripcion IN ('producto9', 'producto2', 'producto8')
AND d.cantidad = 3;
AND c.fecha = CURRENT_DATE;
----

--3.2--
SELECT id, descripcion, stock, precio FROM producto 
WHERE descripcion IN ('producto9', 'producto2', 'producto8');
--
BEGIN
--P1--
INSERT INTO compra (cliente_id, fecha)
SELECT id, CURRENT_DATE FROM cliente WHERE nombre = 'usuario02';

INSERT INTO detalle_compra (producto_id, compra_id, cantidad)
SELECT id, CURRVAL('compra_id_seq'), 3
FROM producto WHERE descripcion = 'producto1';

UPDATE producto
SET stock = stock - 3
WHERE id = (SELECT id FROM producto WHERE descripcion = 'producto1');
SAVEPOINT producto1; 

--P2--
INSERT INTO compra (cliente_id, fecha)
SELECT id, CURRENT_DATE FROM cliente WHERE nombre = 'usuario02';

INSERT INTO detalle_compra (producto_id, compra_id, cantidad)
SELECT id, CURRVAL('compra_id_seq'), 3
FROM producto WHERE descripcion = 'producto2';

UPDATE producto
SET stock = stock - 3
WHERE id = (SELECT id FROM producto WHERE descripcion = 'producto2');
SAVEPOINT producto2; 
----

--P3--
INSERT INTO compra (cliente_id, fecha)
SELECT id, CURRENT_DATE FROM cliente WHERE nombre = 'usuario02';

INSERT INTO detalle_compra (producto_id, compra_id, cantidad)
SELECT id, CURRVAL('compra_id_seq'), 3
FROM producto WHERE descripcion = 'producto3';

UPDATE producto
SET stock = stock - 3
WHERE id = (SELECT id FROM producto WHERE descripcion = 'producto3'); 
----
COMMIT;
----

--3.4--
SELECT id, descripcion, stock, precio FROM producto
WHERE descripcion IN ('producto9', 'producto2', 'producto8');
-----
--3.5--
SELECT cl.nombre, cl.email, c.fecha, d.cantidad, p.descripcion, p.stock, p.precio
FROM cliente cl
LEFT JOIN compra c ON cl.id = c.cliente_id
LEFT JOIN detalle_compra d ON c.id = d.compra_id
LEFT JOIN producto p ON d.producto_id = p.id 
WHERE cl.nombre = 'usuario02'
AND p.descripcion IN ('producto9', 'producto2', 'producto8')
AND d.cantidad = 3;
AND c.fecha = CURRENT_DATE;
-----
--4--
\echo :AUTOCOMMIT
----
--4.1--
INSERT INTO cliente (nombre, email)
VALUES ('NUEVO USUARIO', 'ignacio@gmail.com');
----
--4.2--
SELECT id, nombre, email FROM cliente
WHERE nombre LIKE 'ignacio%';
----
--4.3--
ROLLBACK;
----
--4.4--
SELECT id, nombre, email FROM cliente
WHERE nombre LIKE 'ignacio%';
----
--4.5--
\set AUTOCOMMIT ON
\echo :AUTOCOMMIT
----
