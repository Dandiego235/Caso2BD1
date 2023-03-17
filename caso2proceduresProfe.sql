-- stored procedures de productos venta y registrar venta;

-- tabla temporal la cual se usa como "parametro" dentro del stored procedure de registrarVenta
-- para agrupar productos con un guid de una sola venta.
DROP TABLE IF EXISTS productosVenta;
CREATE TEMPORARY TABLE productosVenta(
  guid VARCHAR(36),
  productId INT,
  quantity SMALLINT
);

DROP PROCEDURE IF EXISTS registrarVenta;
DELIMITER $$
CREATE PROCEDURE registrarVenta(IN pTurnoId INT, IN pTipoPago TINYINT, IN pPostDate DATETIME, IN pSolicitudId INT, IN pComputer VARCHAR(20), IN pUsername VARCHAR(20), IN pGuid VARCHAR(36))
BEGIN
  DECLARE pComisionId INT;
  DECLARE pVentaId INT;
  DECLARE pEventId INT;
  DECLARE done INT DEFAULT FALSE;
  DECLARE productoFetch INT;
  DECLARE cantidadFetch SMALLINT;
  DECLARE precioProducto DECIMAL(7,2);
  DECLARE montoVenta DECIMAL (10,2);
  DECLARE cur CURSOR FOR SELECT productId, quantity FROM productosVenta WHERE guid = pGuid;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  
  SELECT comisionId FROM comisiones WHERE enabled = 1 INTO pComisionId; 
  
  INSERT INTO copoVentas (turnoId, postDate, tipoPago, monto, solicitudId, enabled, pagadoCopero, comisionId, createdAt, computer, username, copoVentas.checksum) VALUES
  (pTurnoId, pPostDate, pTipoPago, 0, pSolicitudId, 1, 0, pComisionId, pPostDate, pComputer, pUsername, SHA2(CONCAT(turnoId,'Wakanda Forever','Copero system',pComputer,pUsername, comisionId), 256));

  -- PROFE, muy lerdo esto, usa last_insert_id
  SET pVentaId = (SELECT ventaId FROM copoVentas ORDER BY ventaId DESC LIMIT 1); 
  
  
  INSERT INTO productosPorVenta (ventaId, productoId, cantidad, enabled, createdAt, computer, username, productosPorVenta.checksum)
  SELECT pVentaId, productosVenta.productId, productosVenta.quantity, 1, pPostDate, pComputer, pUsername, SHA2(CONCAT('Wakanda Forever','Copero system',pComputer,pUsername, pComisionId), 256)
  FROM productosVenta
  WHERE guid = pGuid;

-- insertar en eventos carritos
	INSERT INTO eventosCarritos (turnoId, fecha, tipoEventoCarId, checkStatusId, enabled, createdAt, computer, username, eventosCarritos.checksum) VALUES 
  (pTurnoId, pPostDate, 4, 1, 1, pPostDate,pComputer, pUsername,  SHA2(CONCAT('Wakanda Forever','Copero system',pComputer,pTurnoId, pPostDate, pUsername, pComisionId), 256));

-- insertar en bitácora ingredientes
-- PROFE, lo mismo
  SET pEventId = (SELECT eventId FROM eventosCarritos ORDER BY eventId DESC LIMIT 1); 
  INSERT INTO bitacoraIngredientes (eventId, ingredienteId, cantidad, fecha, createdAt, computer, username, bitacoraIngredientes.checksum)
  SELECT pEventId, ingredientesPorProductos.ingredienteId, -(ingredientesPorProductos.cantidad * productosPorVenta.cantidad), pPostDate, pPostDate, pComputer,pUsername, SHA2('A wild gengar appeared',256)
  FROM productosPorVenta
  INNER JOIN copoProductos ON productosPorVenta.productoId = copoProductos.productoId
  INNER JOIN ingredientesPorProductos On copoProductos.productoId = ingredientesporproductos.productoId
  WHERE productosPorVenta.ventaId = pVentaId;
  
  -- update ingredientes por carrito
  -- PROFE, quita este producto cruz hacemo por join con la tabla temporal join ingredientesporproducto sumando y agrupando por ingrediente
  UPDATE ingredientesPorCarrito,
  (SELECT bitacoraingredientes.ingredienteId, bitacoraingredientes.eventId, SUM(bitacoraingredientes.cantidad) AS cantidad
  FROM bitacoraingredientes WHERE eventId = pEventId GROUP BY ingredienteId, eventId) AS matches
  SET ingredientesPorCarrito.cantidad = ingredientesporcarrito.cantidad + matches.cantidad
  WHERE ingredientesPorCarrito.ingredienteId = matches.ingredienteId AND matches.ingredienteId > 0 AND ingredientesPorCarrito.ingCarId > 0;
  
    -- insertar en caja carritos
  OPEN cur;  -- PROFE, quita este cursor lo podes hacer con un insert de select
  
  -- itera sobre el conjunto extraido por el cursor, calculando el precio del producto, el monto de la venta e inserta a caja carritos.
  read_loop: LOOP
    SET precioProducto = NULL;
    FETCH cur INTO productoFetch, cantidadFetch;
    IF done THEN
      LEAVE read_loop;
    END IF;
    
    -- PROFE, veo que usas mucho select anidado es más rápido JOIN
    SET precioProducto = (SELECT precio FROM preciosPorProducto WHERE productoId = productoFetch AND
    playaId = (SELECT playaId FROM turnos WHERE turnoId = pTurnoId) AND enabled = 1);
    IF precioProducto IS NULL THEN
		  SET precioProducto = (SELECT precio FROM preciosDefault WHERE preciosDefault.precioDefaultId =
          (SELECT precioDefaultId FROM copoProductos WHERE copoproductos.productoId = productoFetch) AND enabled = 1);
	  END IF;
	INSERT INTO cajaCarritos (turnoId, fecha, tipoEventoCarId, checkStatusId, ventaId, productoId, cantidadProd, monto, createdAt, computer, username, checksum) VALUES
    (pTurnoId, pPostDate, 3, 1, pVentaId, productoFetch, cantidadFetch, (cantidadFetch * precioProducto), pPostDate, pComputer, pUsername,
    SHA2(CONCAT('Wakanda Forever','Copero system',pComputer,pTurnoId, pPostDate, pUsername, pComisionId), 256));

  END LOOP;
  CLOSE cur;
  
  -- actualizar monto en venta
  -- PROFE, usa join no select anidado
  UPDATE copoVentas, (SELECT cajaCarritos.ventaId As ventaId, SUM(cajaCarritos.monto) AS montoTotal FROM cajaCarritos GROUP BY ventaId) AS cajaTotal
  SET copoVentas.monto = cajaTotal.montoTotal
  WHERE copoVentas.ventaId = pVentaId AND cajaTotal.ventaId = pVentaId;
END$$
DELIMITER ;

INSERT INTO comisiones (comision, fechaInicio, fechaFin, enabled, createdAt, computer, username, checksum) VALUES
(10.0, current_date(), current_date(), 1, Now(), 'computer1', 'user1', SHA2('Diego es pavo', 256));

DROP TABLE IF EXISTS horarios;
CREATE TEMPORARY TABLE horarios(
  guid VARCHAR (36),
  horarioId INT PRIMARY KEY AUTO_INCREMENT,
  horaInicio TIME NOT NULL,
  horaFinal TIME NOT NULL,
  horaRefill TIME DEFAULT NULL
);

-- tabla agrupadora de horarios de turnos por día, los cuales componen el dataset.
-- se asume que tienen que estar en orden.
SET @newTimeGUID = UUID();
INSERT INTO horarios(guid, horaInicio, horaFinal, horaRefill) VALUES
(@newTimeGUID, '07:00:00', '12:00:00', NULL),
(@newTimeGUID, '1:00:00', '20:00:00', '15:00:00');

-- tabla para generar combinaciones de carrito - playa, las cuales son fijas,
-- luego, se le asigna un copero aleatorio, el cual va a ir cambiando por el turno.
-- esta asignación se hace dentro del stored procedure de llenar base
DROP TABLE IF EXISTS combinations;
CREATE TEMPORARY TABLE combinations(
	combinationId INT PRIMARY KEY AUTO_INCREMENT,
	carritoId  INT,
    playaId INT,
    coperoId INT DEFAULT NULL
);

-- insertamos combinaciones carrito-playa para el dataset
INSERT INTO combinations (carritoId, playaId) VALUES
(1,1), (2,2), (3,3), (4,4), (5,1), (6,2), (7,3), (8,4), (9,1),
(10,2), (11,3), (12,4), (13,1), (14,2), (15,3);

-- tabla con coperos ID 
DROP TABLE IF EXISTS randomCoperos;
CREATE TEMPORARY TABLE randomCoperos(
	randomCoperoId INT PRIMARY KEY AUTO_INCREMENT,
    coperoId INT
);

INSERT INTO randomCoperos (coperoId) SELECT coperoId from coperos ORDER BY RAND() LIMIT 15;
UPDATE combinations INNER JOIN randomCoperos ON combinations.combinationId = randomCoperos.randomCoperoId
SET combinations.coperoId = randomCoperos.coperoId
WHERE combinationId > 0;

-- SELECT * FROM COMBINATIONS;

DROP PROCEDURE IF EXISTS llenarBase;
DELIMITER $$
CREATE PROCEDURE llenarBase(IN pMeses TINYINT, IN pFechaInicio DATETIME, IN pCantTurnos INT, IN pCarritosCant INT, IN pProductosCant INT, 
IN pVariedadVentas INT, IN pCantProdVentas INT, IN pVentasMin INT, IN pVentasMax INT,
IN pVentasMinEnd INT, IN pVentasMaxEnd INT, IN pCreatedAt DATETIME, IN pComputer VARCHAR(20), IN pUsername VARCHAR(20))
BEGIN
	DECLARE dias INT;
    DECLARE totalDias INT;
    DECLARE fechaGen DATE;
    DECLARE pHoraInicio TIME;
    DECLARE pHoraFinal TIME;
    DECLARE pHoraRefill TIME;
    DECLARE dateInicio DATETIME;
    DECLARE dateFinal DATETIME;
    DECLARE horaGen TIME;
    DECLARE turnoLength INT;
    DECLARE indice INT;
    DECLARE turnoNum INT;
    DECLARE rangeMin INT;
    DECLARE rangeMax INT;
    DECLARE pCopero INT;
    DECLARE pCarrito INT;
    Declare pPlaya INT;
    DECLARE pTurnoId INT;
    DECLARE pTurnoAnterior INT;
    DECLARE variedadProductos INT;
    DECLARE cantProductos INT;
    DECLARE ventaGUID VARCHAR(36);
    DECLARE done INT DEFAULT FALSE;
    DECLARE curHora CURSOR FOR SELECT horarios.horaInicio, horarios.horaFinal, horarios.horaRefill FROM horarios;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    SET dias = 0;
    SET totalDias = pMeses * 30;
    diasLoop: LOOP
		IF dias >= totalDias THEN
			LEAVE diasLoop;
		END IF;
			SET turnoNum = 1;
			WHILE turnoNum <= pCantTurnos DO
				-- generamos las parejas de copero carrito aleatoriamente.
                -- PROFE, no borres esta vara mejor, cambia el esquema para que uses lo que haya en la tabla sin borrar
                -- incluso esto podrías tenerlo listo en una tabla y siempre usarlo en todos los llenados
				DROP TABLE IF EXISTS randomCoperos;
				CREATE TEMPORARY TABLE randomCoperos(
					randomCoperoId INT PRIMARY KEY AUTO_INCREMENT,
					coperoId INT
				);
				INSERT INTO randomCoperos (coperoId) SELECT coperoId from coperos ORDER BY RAND() LIMIT 15;
                -- PROFE, esto ya tiene q estar hecho antes como te dije arriba
				UPDATE combinations INNER JOIN randomCoperos ON combinations.combinationId = randomCoperos.randomCoperoId
				SET combinations.coperoId = randomCoperos.coperoId WHERE combinationId > 0;
				SET indice = 1;
                
				WHILE indice <= pCarritosCant DO
                
				-- extraigo las horas del horario
				SET pHoraInicio = (SELECT horarios.horaInicio FROM horarios WHERE horarios.horarioId = turnoNum);
				SET pHoraFinal = (SELECT horarios.horaFinal FROM horarios WHERE horarios.horarioId = turnoNum);
                SET dateInicio = addTime(adddate(pFechaInicio, INTERVAL dias Day), pHoraInicio);
                SET dateFinal = addTime(adddate(pFechaInicio, INTERVAL dias Day), pHoraFinal);
                -- extraigo el copero, el carrito y la playa
                SET pCopero = (SELECT coperoId FROM combinations WHERE combinationId = indice);
                SET pCarrito = (SELECT carritoId FROM combinations WHERE combinationId = indice);
                SET pPlaya = (SELECT playaId FROM combinations WHERE combinationId = indice);
                -- creo el turno
                -- extraigo el turno anterior si lo tiene.
				IF dias <> 0 OR turnoNum <> 1 THEN
					SET pTurnoAnterior = (SELECT turnos.turnoId FROM turnos WHERE turnos.carritoId = pCarrito ORDER BY turnoFin DESC LIMIT 1);
				ELSE
					SET pTurnoAnterior = NULL;
                END IF;
                INSERT INTO turnos (coperoId, carritoId, playaId, turnoInicio, turnoFin, turnoAnterior, enabled, createdAt, computer, username, checksum) VALUES
                (pCopero, pCarrito, pPlaya, dateInicio, dateFinal, pTurnoAnterior, 1, pCreatedAt, pComputer, pUsername,
                SHA2(CONCAT(coperoId, carritoId, playaId, turnoInicio, turnoFin, enabled, createdAt, computer, username), 256));

				-- PROFE, last_insert_id, todo lado usa eso, esto de aqui te puede generar un id invalido en el mundo real y es muy lerdo
                -- guardo el turnoId creado
                SET pTurnoId = (SELECT turnoId FROM turnos ORDER BY turnoId DESC LIMIT 1);
                
                -- establezco la longitud del turno
                SET turnoLength = TIME_TO_SEC(TIMEDIFF(pHoraFinal, pHoraInicio));
                
                -- reviso si es un fin de semana para generar un intervalo de ventas más corto.
                -- las ventas se van a ir generando de acuerdo con un intervalo random de tiempo tal que quede un rango de ventas durante el turno.
                IF WEEKDAY(dateInicio) = 5 OR WEEKDAY(dateInicio) = 6 THEN
					SET rangeMax = turnoLength / pVentasMinEnd;
					SET rangeMin = turnoLength / pVentasMaxEnd;
				ELSE
					SET rangeMax = turnoLength / pVentasMin;
					SET rangeMin = turnoLength / pVentasMax;
				END IF;
                
                -- generación de ventas.
                SET horaGen = '00:00:00'; -- mientras no hayamos abarcado la duración total del turno
                
                -- PROFE, no usen un while para esto, dejen que el random se lo genere, puede ser tiempo constante
                WHILE horaGen < TIMEDIFF(pHoraFinal, pHoraInicio) DO
                    SET variedadProductos = 0;
                    SET ventaGUID = UUID(); -- agrupador de ventas.
                    
                    -- PROFE, nombres mae que paso con el curso de algoritmos jajaja, tenes muchos bucles anidados ,
                    -- traten de aplanar esto, que el dataset programe los random e insertan nada mas
                    -- se va a generar una cantidad random de productos distintos. el máximo lo dicta pVariedadVentas
                    WHILE variedadProductos < FLOOR( 1 + RAND() * pVariedadVentas) Do
                        -- falta validación de si hay suficientes ingredientes.
                        
                        -- Se insertan los productos agrupados en la tabla temporal de productosVenta, que es un input al stored procedure registrarVenta
						INSERT INTO productosVenta(guid, productId, quantity) VALUES
                        (ventaGUID, FLOOR(1 + RAND() * pProductosCant), FLOOR(1 + RAND() * pCantProdVentas));
                        -- se inserta una cantidad random de cada producto. El máximo lo dicta pCantProdVentas

                        SET variedadProductos = variedadProductos + 1;
                    END WHILE;
                    CALL registrarVenta (pTurnoId, 1, ADDTIME(dateInicio, horaGen), NULL, pComputer, pUsername, ventaGUID);
                    
                    SET horaGen = horaGen + INTERVAL FLOOR(rangeMin + RAND() * (rangeMax - rangeMin + 1)) SECOND;
					-- corremos la hora de generación de venta un intervalo aleatorio dictado por el mínimo y máximo de ventas.alter
                    
				END WHILE;
                -- nos corremos al siguiente carrito
                SET indice = indice + 1;
			END WHILE;
            -- nos corremos al siguiente turno
            SET turnoNum = turnoNum + 1;
        END WHILE;
        
        SET dias = dias + 1;
        
    END LOOP;
    
END$$
DELIMITER ;

CALL llenarBase(6, '2022-01-01 00:00:00', 2, 15, 13, 3, 3, 4, 20, 15, 20, NOW(), 'computer1', 'user1');
SELECT * FROM productosPorVenta ORDER BY ventaId;
SELECT * FROM bitacoraingredientes;
SELECT * FROM TURNOs;
SELECT * from ingredientesPorCarrito;
SELECT * FROM copoventas;
