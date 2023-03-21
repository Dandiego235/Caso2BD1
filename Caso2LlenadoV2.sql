-- Daniel y Diego Granados

DROP TABLE IF EXISTS ingredientesEvento;
CREATE TEMPORARY TABLE ingredientesEvento(
  guid VARCHAR(36),
  ingredienteId INT,
  quantity DECIMAL(10,2)
);

DROP PROCEDURE IF EXISTS registrarEventoTurno;
DELIMITER $$
CREATE PROCEDURE registrarEventoTurno(IN pTipoEvento TINYINT, IN pCheckStatus TINYINT, IN pTurnoId INT, IN pFecha DATETIME, IN pComputer VARCHAR(20), IN pUsername VARCHAR(20), IN pGuid VARCHAR(36))
BEGIN
  DECLARE pEventId INT;
  DECLARE pRandom TINYINT;

-- insertar en eventos carritos
	INSERT INTO eventosCarritos (turnoId, fecha, tipoEventoCarId, checkStatusId, enabled, createdAt, computer, username, eventosCarritos.checksum) VALUES 
  (pTurnoId, pFecha, pTipoEvento, pCheckStatus, 1, pFecha,pComputer, pUsername,  SHA2(CONCAT('Wakanda Forever','Copero system',pComputer,pTurnoId, pFecha, pUsername), 256));

  -- insertar en bitácora ingredientes
  SET pEventId = LAST_INSERT_ID(); 
  INSERT INTO bitacoraIngredientes (eventId, ingredienteId, cantidad, fecha, createdAt, computer, username, bitacoraIngredientes.checksum)
  SELECT pEventId, ingredientesEvento.ingredienteId, ingredientesEvento.quantity, pFecha, pFecha, pComputer,pUsername, SHA2('A wild gengar appeared',256)
  FROM ingredientesEvento
  WHERE ingredientesEvento.guid = pGuid;
  
  -- update ingredientes por carrito
  UPDATE ingredientesPorCarrito
  INNER JOIN (SELECT bi.eventId, bi.ingredienteId, SUM(cantidad) AS total FROM bitacoraIngredientes AS bi GROUP BY eventId, ingredienteId) AS matches
  ON matches.ingredienteId = ingredientesPorCarrito.ingredienteId
  INNER JOIN eventosCarritos ON matches.eventId = eventosCarritos.eventId
  INNER JOIN turnos ON eventosCarritos.turnoId = turnos.turnoId
  SET ingredientesPorCarrito.cantidad = ingredientesPorCarrito.cantidad + matches.total
  WHERE matches.eventId = pEventId AND matches.ingredienteId = ingredientesPorCarrito.ingredienteId
  AND ingredientesPorCarrito.carritoId = turnos.carritoId;
  
END$$
DELIMITER ;

DROP TABLE IF EXISTS productosVenta;
CREATE TEMPORARY TABLE productosVenta(
  guid VARCHAR(36),
  productId INT,
  quantity SMALLINT
);

DROP PROCEDURE IF EXISTS registrarVenta;
DELIMITER $$
CREATE PROCEDURE registrarVenta(IN pTurnoId INT, IN pTipoPago TINYINT, IN pPostDate DATETIME, IN pComputer VARCHAR(20), IN pUsername VARCHAR(20), IN pGuid VARCHAR(36))
BEGIN
  DECLARE pComisionId INT;
  DECLARE pVentaId INT;
  DECLARE pEventId INT;
  DECLARE pStatusId TINYINT;
  
  SET pStatusId = 1;
  SET pComisionId = (SELECT comisionId FROM comisiones WHERE (comisiones.enabled = 1 AND DATEDIFF(pPostDate, comisiones.fechaInicio) > 0)
  OR (pPostDate BETWEEN comisiones.fechaInicio AND comisiones.fechaFin)); 
     
  INSERT INTO copoVentas (turnoId, postDate, tipoPago, monto, solicitudId, enabled, pagadoCopero, comisionId, createdAt, computer, username, copoVentas.checksum) VALUES
  (pTurnoId, pPostDate, pTipoPago, 0, NULL, 1, 0, pComisionId, pPostDate, pComputer, pUsername, SHA2(CONCAT(turnoId,'Wakanda Forever','Copero system',pComputer,pUsername, comisionId), 256));

  SET pVentaId = LAST_INSERT_ID(); 
  INSERT INTO productosPorVenta (ventaId, productoId, cantidad, enabled, createdAt, computer, username, productosPorVenta.checksum)
  SELECT pVentaId, productosVenta.productId, productosVenta.quantity, 1, pPostDate, pComputer, pUsername, SHA2(CONCAT('Wakanda Forever','Copero system',pComputer,pUsername, pComisionId), 256)
  FROM productosVenta
  WHERE guid = pGuid;

-- insertar en eventos carritos

	IF (SELECT COUNT(*) FROM productosPorVenta WHERE productosPorventa.ventaId = pVentaId) = 0 THEN
		SET pStatusId = 3;
	END IF;
	INSERT INTO eventosCarritos (turnoId, fecha, tipoEventoCarId, checkStatusId, enabled, createdAt, computer, username, eventosCarritos.checksum) VALUES 
  (pTurnoId, pPostDate, 4, pStatusId, 1, pPostDate,pComputer, pUsername,  SHA2(CONCAT('Wakanda Forever','Copero system',pComputer,pTurnoId, pPostDate, pUsername, pComisionId), 256));
  SET pEventId = LAST_INSERT_ID(); 
  
  -- actualizar monto en venta
    IF pStatusId = 1 THEN
	  UPDATE copoVentas INNER JOIN
      (SELECT productosPorVenta.ventaId, SUM(productosPorVenta.cantidad * COALESCE(preciosPlayas.precioPlaya, preciosDefault.precio)) montoTotal
		FROM productosPorVenta
		  INNER JOIN preciosDefault ON productosPorVenta.productoId = preciosDefault.productoId
		  LEFT JOIN
		  (SELECT productosPorVenta.productoid, preciosPorProducto.precio precioPlaya FROM productosPorVenta
		  INNER JOIN preciosDefault ON productosPorVenta.productoId = preciosDefault.productoId
		  LEFT JOIN preciosPorProducto ON productosPorVenta.productoId = preciosPorProducto.productoId
		  LEFT JOIN copoVentas ON copoVentas.ventaId = productosPorVenta.ventaId
		  INNER JOIN turnos ON turnos.turnoId= copoVentas.turnoId
		  WHERE productosPorVenta.ventaId = pVentaId AND preciosPorProducto.playaId = turnos.playaId)
		  preciosPlayas ON preciosPlayas.productoId = productosPorVenta.productoId
		  WHERE productosPorVenta.ventaId = pVentaId GROUP BY productosPorVenta.ventaId) AS montoCaja
          ON montoCaja.ventaId = copoVentas.ventaId
	  SET copoVentas.monto = montoCaja.montoTotal
      WHERE copoVentas.ventaId = pVentaId AND montoCaja.ventaId = pVentaId;
	END IF;
    
-- insertar en bitácora ingredientes
  INSERT INTO bitacoraIngredientes (eventId, ingredienteId, cantidad, fecha, createdAt, computer, username, bitacoraIngredientes.checksum)
  SELECT pEventId, ingredientesPorProductos.ingredienteId, -(ingredientesPorProductos.cantidad * productosPorVenta.cantidad), pPostDate, pPostDate, pComputer,pUsername, SHA2('A wild gengar appeared',256)
  FROM productosPorVenta
  INNER JOIN copoProductos ON productosPorVenta.productoId = copoProductos.productoId
  INNER JOIN ingredientesPorProductos On copoProductos.productoId = ingredientesporproductos.productoId
  WHERE productosPorVenta.ventaId = pVentaId;

  -- update ingredientes por carrito
  UPDATE ingredientesPorCarrito
  INNER JOIN (SELECT bi.eventId, bi.ingredienteId, SUM(cantidad) AS total FROM bitacoraIngredientes AS bi GROUP BY eventId, ingredienteId) AS matches
  ON matches.ingredienteId = ingredientesPorCarrito.ingredienteId
  INNER JOIN eventosCarritos ON matches.eventId = eventosCarritos.eventId
  INNER JOIN turnos ON eventosCarritos.turnoId = turnos.turnoId
  SET ingredientesPorCarrito.cantidad = ingredientesPorCarrito.cantidad + matches.total
  WHERE matches.eventId = pEventId AND matches.ingredienteId = ingredientesPorCarrito.ingredienteId
  AND ingredientesPorCarrito.carritoId = turnos.carritoId;
  
    -- insertar en caja carritos
	  IF pTipoPago = 1 THEN
		  INSERT INTO cajaCarritos (turnoId, fecha, tipoEventoCarId, checkStatusId, ventaId, monto, createdAt, computer, username, checksum) 
		  SELECT pTurnoId, pPostDate, 4, 1, pVentaId, copoVentas.monto, pPostDate, pComputer, pUsername,
		  SHA2(CONCAT('Wakanda Forever','Copero system',pComputer,pTurnoId, pPostDate, pUsername, pComisionId), 256)
		  FROM copoVentas WHERE copoVentas.ventaId = pVentaId;
	  END IF;

END$$
DELIMITER ;

-- tabla agrupadora de horarios de turnos por día, los cuales componen el dataset.
-- se asume que tienen que estar en orden.
DROP TABLE IF EXISTS horarios;
CREATE TABLE horarios(
  guid VARCHAR (36),
  horarioId INT PRIMARY KEY AUTO_INCREMENT,
  horaInicio TIME NOT NULL,
  horaFinal TIME NOT NULL
);

SET @newTimeGUID = UUID();
INSERT INTO horarios(guid, horaInicio, horaFinal) VALUES
(@newTimeGUID, '07:00:00', '12:00:00'),
(@newTimeGUID, '13:00:00', '20:00:00');

-- tabla para generar combinaciones de carrito - playa, las cuales son fijas,
-- luego, se le asigna un copero aleatorio. Esta combinación se mantiene por todos los turnos.
DROP TABLE IF EXISTS combinations;
CREATE TABLE combinations(
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
CREATE TABLE randomCoperos(
	randomCoperoId INT PRIMARY KEY AUTO_INCREMENT,
    coperoId INT
);
-- insertamos un orden aleatorio de coperos y los asociamos con una combinación de carrito - playa.
INSERT INTO randomCoperos (coperoId) SELECT coperoId from coperos ORDER BY RAND() LIMIT 15;
UPDATE combinations INNER JOIN randomCoperos ON combinations.combinationId = randomCoperos.randomCoperoId
SET combinations.coperoId = randomCoperos.coperoId
WHERE combinationId > 0;

-- Tabla donde se crea la base para todos los turnos. El producto cruz entre horarios y combinations
-- resulta en todos los turnos que ocurren en esos horarios.
DROP TABLE IF EXISTS turnosCombinations;
CREATE TEMPORARY TABLE turnosCombinations(
  horarioId INT,
  horaInicio TIME NOT NULL,
  horaFinal TIME NOT NULL,
	combinationId INT,
	carritoId  INT,
    playaId INT,
    coperoId INT
);
INSERT INTO turnosCombinations(horarioId, horaInicio, horaFinal, combinationId, carritoId, playaId, coperoId)
SELECT h.horarioId, h.horaInicio, h.horaFinal,  c.combinationId,
c.carritoId, c.playaId, c.coperoId FROM horarios h, combinations c;

-- procedimiento para llenar la base de datos
DROP PROCEDURE IF EXISTS llenarBase;
DELIMITER $$
CREATE PROCEDURE llenarBase
(IN pDias TINYINT, IN pFechaInicio DATETIME, IN pCantTurnos INT, IN pCarritosCant INT, 
IN pProductosCant INT, IN pVariedadVentas INT, IN pCantProdVentas INT, IN pVentasMin INT,
IN pVentasMax INT, IN pVentasMinEnd INT, IN pVentasMaxEnd INT, IN pCreatedAt DATETIME,
IN pComputer VARCHAR(20), IN pUsername VARCHAR(20), IN pLadron INT, 
IN pRoboIngrediente INT, IN pPorcentajeRobo DECIMAL(4,2), IN pRoboProb INT)
BEGIN
	DECLARE dias INT;
    DECLARE primerDia DATETIME; -- fecha y hora donde empiezan los turnos
    DECLARE diferencia INT; -- diferencia entre turnos anteriores de dos días seguidos.
    DECLARE pHoraInicio TIME; -- hora de inicio de la jornada laboral
    DECLARE pHoraFinal TIME; -- hora final de la jornada laboral
    DECLARE turnoLength INT; -- lo que duran los turnos en segundos.
    DECLARE rangeMin INT; -- el mínimo de ventas que podemos tener por turno
    DECLARE rangeMax INT; -- el máximo de ventas que podemos tener por turno
    DECLARE ventasCant INT; -- La cantidad de ventas que tenemos en un turno
    DECLARE ventasNum INT; -- El contador de la cantidad de ventas
    DECLARE ventaGUID VARCHAR(36); -- agrupador de productos por venta
    DECLARE cierreGUID VARCHAR(36); -- agrupador de entradas en el cierre
    DECLARE cierreStatus TINYINT; -- status de cierre, si está confirmado o si tiene diferencias.
    
    -- extraemos fechas importantes de horarios
    SET pHoraInicio = (SELECT horaInicio from horarios WHERE horarioId = 1);
    SET pHoraFinal = (SELECT horaFinal FROM horarios ORDER BY horarioId DESC LIMIT 1);
    SET primerDia = addTime(pFechaInicio, pHoraInicio);
    
    -- se generan todos los turnos en el intervalo de días.
    SET dias = 0;
    diasLoop: LOOP
		IF dias >= pDias THEN
			LEAVE diasLoop;
		END IF;
        -- se insertan los turnos extrayendo las combinaciones de turnosCombinations. La fecha va incrementando por día.
        INSERT INTO turnos (coperoId, carritoId, playaId, turnoInicio, turnoFin, enabled, createdAt, computer, username, checksum)
        SELECT tc.coperoId, tc.CarritoId, tc.playaId, addTime(adddate(pFechaInicio, INTERVAL dias Day), tc.horaInicio),
        addTime(adddate(pFechaInicio, INTERVAL dias Day), tc.horaFinal), 1, pCreatedAt, pComputer, pUsername,
        SHA2(CONCAT(coperoId, carritoId, playaId, horaInicio, horaFinal, 1, pCreatedAt, pComputer, pUsername), 256)
        FROM turnosCombinations AS tc ORDER BY tc.carritoId, tc.horarioId;
        SET dias = dias + 1;
    END LOOP;
    -- diferencia entre turnos anteriores en algunos casos
    SET diferencia = ((SELECT turnoId FROM turnos WHERE TIME(turnoInicio) = pHoraInicio AND turnoInicio = primerDia + INTERVAL 1 DAY AND carritoId = 1) -
(SELECT turnoId FROM turnos WHERE TIME(turnoFin) = pHoraFinal AND DATE(turnoInicio) = pFechaInicio AND carritoId = 1));
	
    -- actualizamos los turnos para obtener el turno anterior
    UPDATE turnos
    SET turnoAnterior = CASE
		WHEN turnoInicio = primerDia THEN NULL
        WHEN TIME(turnoInicio) = pHoraInicio AND turnoInicio <> primerDia THEN turnoId - diferencia
        ELSE turnoId - 1
	END
    WHERE turnoId >= 1;
    
    -- vamos a ir generando las ventas para cada turno.
    turnosGen: BEGIN
		  DECLARE pTurnoid INT;
          DECLARE dateInicio DATETIME;
          DECLARE dateFinal DATETIME;
		  DECLARE done INT DEFAULT FALSE;
		  DECLARE cur CURSOR FOR SELECT turnoId, turnoInicio, turnoFin FROM turnos;
		  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
          
          OPEN cur;
          
          readLoop: LOOP
			FETCH cur INTO pTurnoId, dateInicio, dateFinal;
			IF done THEN
				LEAVE readLoop;
			END IF;

                -- establezco la longitud del turno
                SET turnoLength = TIME_TO_SEC(TIMEDIFF(dateFinal, dateInicio));
                
                -- reviso si es un fin de semana para ver si tengo un rango menos amplio para generar más ventas.
                IF WEEKDAY(dateInicio) = 5 OR WEEKDAY(dateInicio) = 6 THEN
					SET rangeMax = pVentasMaxEnd;
					SET rangeMin = pVentasMinEnd;
				ELSE
					SET rangeMax = pVentasMax;
					SET rangeMin = pVentasMin;
				END IF;
                
                -- generación de ventas.
                SET ventasCant = FLOOR(rangeMin + RAND() * (rangeMax - rangeMin + 1));
                SET ventasNum = 1;

                ventasGen: LOOP
					IF ventasNum > ventasCant THEN
						LEAVE ventasGen;
                    END IF;
                    SET ventaGUID = UUID(); -- agrupador de ventas.
                    
                    -- se va a generar una cantidad random de productos distintos.
                    INSERT INTO productosVenta(guid, productId, quantity)
					SELECT * FROM 
					(SELECT ventaGuid, copoProductos.productoId, FLOOR(0 + RAND() * pCantProdVentas) as cantidad
					FROM copoProductos ORDER BY RAND() LIMIT 5) as randomGen
                    WHERE randomGen.cantidad != 0;
                    
                    CALL registrarVenta (pTurnoId, 1, DATE_ADD(dateInicio, INTERVAL FLOOR(RAND() * turnoLength) SECOND), pComputer, pUsername, ventaGUID);
                    
                    SET ventasNum = ventasNum + 1;
                END LOOP;
                
                -- se inserta la cantidad de ingredientes que se gastó durante el turno para que no queden cantidades negativas y un 
                -- cinco por ciento más, por si acaso. Se usa la tabla temporal de ingredientesEvento
                INSERT INTO ingredientesEvento (guid, ingredienteId, quantity)
                SELECT ventaGuid, ingredientesPorCarrito.ingredienteId, CEILING(-1.05 * ingredientesPorCarrito.cantidad)
                FROM ingredientesPorCarrito
                INNER JOIN carritos ON ingredientesPorCarrito.carritoId = carritos.carritoId
                INNER JOIN turnos ON carritos.carritoId = turnos.carritoId
                WHERE turnos.turnoId = pTurnoId AND ingredientesPorCarrito.cantidad < 0;
                
				-- registramos la apertura o el cambio de turno. Si el turno es el primero, es una apertura (tipoEvento = 1).
                -- si no, es un cambio de turno (tipoEvento = 3).
                CALL registrarEventoTurno(CASE WHEN TIME(dateInicio) = pHoraInicio THEN 1 ELSE 3 END, 1, 
                pTurnoId, dateInicio, pComputer, pUsername, ventaGUID);
                
                -- si estamos en el ultimo turno del dia, hacemos un cierre
                IF TIME(dateFinal) = pHoraFinal THEN
					SET cierreGUID = UUID();
                    -- verificamos si se trata del copero que se designó como ladrón y si ocurre la probabilidad de que robe
                    -- la probabilidad se interpreta como "1 de cada pRoboProb"
					IF (SELECT coperoId from turnos where turnoId = pTurnoId) = pLadron AND FLOOR(1+RAND()*pRoboProb) = pRoboProb THEN
						-- si toca simular un robo, se genera una pérdida del porcentaje dado en pPorcentajeRobo del ingrediente dado
                        -- en pRoboIngrediente
                        -- En los otros ingredientes, se inserta un 0 porque no hay cambio.
						INSERT INTO ingredientesEvento (guid, ingredienteId, quantity)
						SELECT cierreGUID, ingredientesPorCarrito.ingredienteId,
                        CASE WHEN ingredientesPorCarrito.ingredienteId = pRoboIngrediente THEN -ceiling(pPorcentajeRobo * ingredientesPorCarrito.cantidad)
                        ELSE 0 END
						FROM ingredientesPorCarrito
						INNER JOIN carritos ON ingredientesPorCarrito.carritoId = carritos.carritoId
						INNER JOIN turnos ON carritos.carritoId = turnos.carritoId
						WHERE turnos.turnoId = pTurnoId;
                        SET cierreStatus = 2;
					ELSE
						-- si no hay diferencias, se insertan solo 0s en la tabla de ingredientesEvento
						INSERT INTO ingredientesEvento (guid, ingredienteId, quantity)
						SELECT cierreGUID, ingredientesPorCarrito.ingredienteId, 0
						FROM ingredientesPorCarrito
						INNER JOIN carritos ON ingredientesPorCarrito.carritoId = carritos.carritoId
						INNER JOIN turnos ON carritos.carritoId = turnos.carritoId
						WHERE turnos.turnoId = pTurnoId;
                        SET cierreStatus = 1;
                    END IF;
                    -- registramos el cierre
					CALL registrarEventoTurno(2, cierreStatus, pTurnoId, dateFinal, pComputer, pUsername, cierreGuid);
                END IF;
                
          END LOOP;
          
    END turnosGen;
    
END$$
DELIMITER ;

CALL llenarBase(1, '2022-01-01 00:00:00', 2, 15, 13, 3, 3, 4, 20, 15, 20, NOW(), 'computer1', 'user1', 1, 15, 0.1, 5);
