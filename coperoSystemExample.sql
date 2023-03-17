use coperosystem;

INSERT INTO copo_productos (descripcion) VALUES ('Copo simple sin leche');

SELECT * FROM copo_productos;

INSERT INTO copo_productos (descripcion) VALUES ('Copo de una leches');
INSERT INTO copo_productos (descripcion) VALUES ('Copo de dos leches');
INSERT INTO copo_productos (descripcion) VALUES ('Copo de tres leches');
INSERT INTO copo_productos (productid, descripcion) VALUES (2, '');

UPDATE copo_productos SET descripcion = 'Fresa colada' WHERE productoid = 10;
