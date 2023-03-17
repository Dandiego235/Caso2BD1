-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Copos
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Copos` ;

-- -----------------------------------------------------
-- Schema Copos
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Copos` DEFAULT CHARACTER SET utf8 ;
USE `Copos` ;

-- -----------------------------------------------------
-- Table `Copos`.`preciosDefault`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`preciosDefault` ;

CREATE TABLE IF NOT EXISTS `Copos`.`preciosDefault` (
  `precioDefaultId` INT NOT NULL AUTO_INCREMENT,
  `productoId` INT NOT NULL,
  `precio` DECIMAL(7,2) NOT NULL,
  `fechaInicio` DATETIME NOT NULL,
  `fechaFin` DATETIME NULL,
  `enabled` BIT NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  `computer` VARCHAR(20) NOT NULL,
  `username` VARCHAR(20) NOT NULL,
  `checksum` VARBINARY(150) NOT NULL,
  PRIMARY KEY (`precioDefaultId`),
  INDEX `fk_preciosDefault_copoProductos1_idx` (`productoId` ASC) VISIBLE,
  CONSTRAINT `fk_preciosDefault_copoProductos1`
    FOREIGN KEY (`productoId`)
    REFERENCES `Copos`.`copoProductos` (`productoId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`copoProductos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`copoProductos` ;

CREATE TABLE IF NOT EXISTS `Copos`.`copoProductos` (
  `productoId` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(35) NOT NULL,
  `precioDefaultId` INT NULL,
  `enabled` BIT NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  `computer` VARCHAR(20) NOT NULL,
  `username` VARCHAR(20) NOT NULL,
  `checksum` VARBINARY(150) NOT NULL,
  PRIMARY KEY (`productoId`),
  INDEX `fk_copoProductos_preciosDefault1_idx` (`precioDefaultId` ASC) VISIBLE,
  CONSTRAINT `fk_copoProductos_preciosDefault1`
    FOREIGN KEY (`precioDefaultId`)
    REFERENCES `Copos`.`preciosDefault` (`precioDefaultId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`coperos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`coperos` ;

CREATE TABLE IF NOT EXISTS `Copos`.`coperos` (
  `coperoId` INT NOT NULL AUTO_INCREMENT COMMENT 'identificacion del copero',
  `nombre` VARCHAR(50) NOT NULL,
  `telefono` INT NOT NULL,
  `cuentaBancaria` VARCHAR(50) NOT NULL,
  `enabled` BIT NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  `computer` VARCHAR(20) NOT NULL,
  `username` VARCHAR(20) NOT NULL,
  `checksum` VARBINARY(150) NOT NULL,
  PRIMARY KEY (`coperoId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`carritos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`carritos` ;

CREATE TABLE IF NOT EXISTS `Copos`.`carritos` (
  `carritoId` SMALLINT NOT NULL AUTO_INCREMENT,
  `color` VARCHAR(10) NOT NULL,
  `dinero` DECIMAL(10,2) NOT NULL,
  `placa` VARCHAR(10) NOT NULL,
  `enabled` BIT NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  `computer` VARCHAR(20) NOT NULL,
  `username` VARCHAR(20) NOT NULL,
  `checksum` VARBINARY(150) NOT NULL,
  PRIMARY KEY (`carritoId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`playas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`playas` ;

CREATE TABLE IF NOT EXISTS `Copos`.`playas` (
  `playaId` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(20) NOT NULL,
  `enabled` BIT NOT NULL,
  PRIMARY KEY (`playaId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`turnos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`turnos` ;

CREATE TABLE IF NOT EXISTS `Copos`.`turnos` (
  `turnoId` INT NOT NULL AUTO_INCREMENT,
  `coperoId` INT NOT NULL,
  `carritoId` SMALLINT NOT NULL,
  `playaId` INT NOT NULL,
  `turnoInicio` DATETIME NOT NULL,
  `turnoFin` DATETIME NOT NULL,
  `turnoAnterior` INT NULL,
  `enabled` BIT NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  `computer` VARCHAR(20) NOT NULL,
  `username` VARCHAR(20) NOT NULL,
  `checksum` VARBINARY(150) NOT NULL,
  INDEX `fk_carritos_por_copero_coperos1_idx` (`coperoId` ASC) VISIBLE,
  INDEX `fk_carritos_por_copero_carritos1_idx` (`carritoId` ASC) VISIBLE,
  PRIMARY KEY (`turnoId`),
  INDEX `fk_turnos_playas1_idx` (`playaId` ASC) VISIBLE,
  INDEX `fk_turnos_turnos1_idx` (`turnoAnterior` ASC) VISIBLE,
  CONSTRAINT `fk_carritos_por_copero_coperos1`
    FOREIGN KEY (`coperoId`)
    REFERENCES `Copos`.`coperos` (`coperoId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_carritos_por_copero_carritos1`
    FOREIGN KEY (`carritoId`)
    REFERENCES `Copos`.`carritos` (`carritoId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_turnos_playas1`
    FOREIGN KEY (`playaId`)
    REFERENCES `Copos`.`playas` (`playaId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_turnos_turnos1`
    FOREIGN KEY (`turnoAnterior`)
    REFERENCES `Copos`.`turnos` (`turnoId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`usuarios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`usuarios` ;

CREATE TABLE IF NOT EXISTS `Copos`.`usuarios` (
  `usuarioId` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `email` VARCHAR(35) NOT NULL,
  `countryCode` SMALLINT NOT NULL DEFAULT 506,
  `telefono` INT NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `identificacion` INT NOT NULL,
  `fechaNacimiento` DATE NOT NULL,
  `enabled` BIT NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  `computer` VARCHAR(20) NOT NULL,
  `username` VARCHAR(20) NOT NULL,
  `checksum` VARBINARY(150) NOT NULL,
  PRIMARY KEY (`usuarioId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`solicitudes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`solicitudes` ;

CREATE TABLE IF NOT EXISTS `Copos`.`solicitudes` (
  `solicitudId` INT NOT NULL AUTO_INCREMENT,
  `playaId` INT NOT NULL,
  `ubicacion` VARCHAR(80) NULL,
  `usuarioId` INT NOT NULL,
  `enabled` BIT NOT NULL,
  `geolocalizacion` POINT NOT NULL COMMENT 'SPATIAL INDEX SRID 4326 para GPS o 3857 para Google Maps',
  `posttime` DATETIME NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  `computer` VARCHAR(20) NOT NULL,
  `username` VARCHAR(20) NOT NULL,
  `checksum` VARBINARY(150) NOT NULL,
  PRIMARY KEY (`solicitudId`),
  INDEX `fk_solicitudes_playas1_idx` (`playaId` ASC) VISIBLE,
  INDEX `fk_solicitudes_usuarios1_idx` (`usuarioId` ASC) VISIBLE,
  CONSTRAINT `fk_solicitudes_playas1`
    FOREIGN KEY (`playaId`)
    REFERENCES `Copos`.`playas` (`playaId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_solicitudes_usuarios1`
    FOREIGN KEY (`usuarioId`)
    REFERENCES `Copos`.`usuarios` (`usuarioId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`comisiones`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`comisiones` ;

CREATE TABLE IF NOT EXISTS `Copos`.`comisiones` (
  `comisionId` INT NOT NULL AUTO_INCREMENT,
  `comision` DECIMAL(5,2) NOT NULL,
  `fechaInicio` DATE NOT NULL,
  `fechaFin` DATE NULL,
  `enabled` BIT NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  `computer` VARCHAR(20) NOT NULL,
  `username` VARCHAR(20) NOT NULL,
  `checksum` VARBINARY(150) NOT NULL,
  PRIMARY KEY (`comisionId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`copoVentas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`copoVentas` ;

CREATE TABLE IF NOT EXISTS `Copos`.`copoVentas` (
  `ventaId` INT NOT NULL AUTO_INCREMENT,
  `turnoId` INT NOT NULL,
  `postDate` DATETIME NOT NULL,
  `tipoPago` TINYINT NOT NULL,
  `monto` DECIMAL(10,2) NOT NULL,
  `solicitudId` INT NULL,
  `enabled` BIT NOT NULL,
  `pagadoCopero` BIT NOT NULL,
  `comisionId` INT NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  `computer` VARCHAR(20) NOT NULL,
  `username` VARCHAR(20) NOT NULL,
  `checksum` VARBINARY(150) NOT NULL,
  PRIMARY KEY (`ventaId`),
  INDEX `fk_copoVentas_turnos1_idx` (`turnoId` ASC) VISIBLE,
  INDEX `fk_copoVentas_solicitudes1_idx` (`solicitudId` ASC) VISIBLE,
  INDEX `fk_copoVentas_comisiones1_idx` (`comisionId` ASC) VISIBLE,
  CONSTRAINT `fk_copoVentas_turnos1`
    FOREIGN KEY (`turnoId`)
    REFERENCES `Copos`.`turnos` (`turnoId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_copoVentas_solicitudes1`
    FOREIGN KEY (`solicitudId`)
    REFERENCES `Copos`.`solicitudes` (`solicitudId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_copoVentas_comisiones1`
    FOREIGN KEY (`comisionId`)
    REFERENCES `Copos`.`comisiones` (`comisionId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`ingredientes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`ingredientes` ;

CREATE TABLE IF NOT EXISTS `Copos`.`ingredientes` (
  `ingredienteId` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL,
  `medida` VARCHAR(20) NOT NULL,
  `enabled` BIT NOT NULL,
  PRIMARY KEY (`ingredienteId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`ingredientesPorProductos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`ingredientesPorProductos` ;

CREATE TABLE IF NOT EXISTS `Copos`.`ingredientesPorProductos` (
  `productoId` INT NOT NULL,
  `ingredienteId` INT NOT NULL,
  `cantidad` DECIMAL(8,2) NOT NULL,
  `enabled` BIT NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  `computer` VARCHAR(20) NOT NULL,
  `username` VARCHAR(20) NOT NULL,
  `checksum` VARBINARY(150) NOT NULL,
  INDEX `fk_ingredientes_por_productos_copo_productos1_idx` (`productoId` ASC) VISIBLE,
  INDEX `fk_ingredientes_por_productos_ingredientes1_idx` (`ingredienteId` ASC) VISIBLE,
  CONSTRAINT `fk_ingredientes_por_productos_copo_productos1`
    FOREIGN KEY (`productoId`)
    REFERENCES `Copos`.`copoProductos` (`productoId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ingredientes_por_productos_ingredientes1`
    FOREIGN KEY (`ingredienteId`)
    REFERENCES `Copos`.`ingredientes` (`ingredienteId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`tiposEventosCar`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`tiposEventosCar` ;

CREATE TABLE IF NOT EXISTS `Copos`.`tiposEventosCar` (
  `tipoEventoCarId` TINYINT NOT NULL AUTO_INCREMENT,
  `nombreEvento` VARCHAR(15) NOT NULL,
  `enabled` BIT NOT NULL,
  PRIMARY KEY (`tipoEventoCarId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`checkStatuses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`checkStatuses` ;

CREATE TABLE IF NOT EXISTS `Copos`.`checkStatuses` (
  `checkStatusId` TINYINT NOT NULL AUTO_INCREMENT,
  `nombreStatus` VARCHAR(15) NOT NULL,
  `enabled` BIT NOT NULL,
  PRIMARY KEY (`checkStatusId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`eventosCarritos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`eventosCarritos` ;

CREATE TABLE IF NOT EXISTS `Copos`.`eventosCarritos` (
  `eventId` INT NOT NULL AUTO_INCREMENT,
  `turnoId` INT NOT NULL,
  `fecha` DATETIME NOT NULL,
  `tipoEventoCarId` TINYINT NOT NULL,
  `checkStatusId` TINYINT NOT NULL,
  `enabled` BIT NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `computer` VARCHAR(20) NOT NULL,
  `username` VARCHAR(20) NOT NULL,
  `checksum` VARBINARY(150) NOT NULL,
  INDEX `fk_ingredientesPorCarrito_turnos1_idx` (`turnoId` ASC) VISIBLE,
  PRIMARY KEY (`eventId`),
  INDEX `fk_eventosCarritos_tiposEventos1_idx` (`tipoEventoCarId` ASC) VISIBLE,
  INDEX `fk_eventosCarritos_checkStatuses1_idx` (`checkStatusId` ASC) VISIBLE,
  CONSTRAINT `fk_ingredientesPorCarrito_turnos1`
    FOREIGN KEY (`turnoId`)
    REFERENCES `Copos`.`turnos` (`turnoId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_eventosCarritos_tiposEventos1`
    FOREIGN KEY (`tipoEventoCarId`)
    REFERENCES `Copos`.`tiposEventosCar` (`tipoEventoCarId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_eventosCarritos_checkStatuses1`
    FOREIGN KEY (`checkStatusId`)
    REFERENCES `Copos`.`checkStatuses` (`checkStatusId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`preciosPorProducto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`preciosPorProducto` ;

CREATE TABLE IF NOT EXISTS `Copos`.`preciosPorProducto` (
  `precioId` INT NOT NULL AUTO_INCREMENT,
  `productoId` INT NOT NULL,
  `playaId` INT NULL DEFAULT NULL,
  `precio` DECIMAL(7,2) NOT NULL,
  `fechaInicio` DATETIME NOT NULL,
  `fechaFin` DATETIME NULL,
  `enabled` BIT NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  `computer` VARCHAR(20) NOT NULL,
  `username` VARCHAR(20) NOT NULL,
  `checksum` VARBINARY(150) NOT NULL,
  INDEX `fk_preciosPorProducto_playas1_idx` (`playaId` ASC) VISIBLE,
  PRIMARY KEY (`precioId`),
  CONSTRAINT `fk_preciosPorProducto_copo_productos1`
    FOREIGN KEY (`productoId`)
    REFERENCES `Copos`.`copoProductos` (`productoId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_preciosPorProducto_playas1`
    FOREIGN KEY (`playaId`)
    REFERENCES `Copos`.`playas` (`playaId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`productosPorSolicitud`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`productosPorSolicitud` ;

CREATE TABLE IF NOT EXISTS `Copos`.`productosPorSolicitud` (
  `solicitudId` INT NOT NULL,
  `productoId` INT NOT NULL,
  `cantidad` SMALLINT NOT NULL,
  `enabled` BIT NOT NULL,
  `nota` VARCHAR(80) NULL,
  `createdAt` DATETIME NOT NULL,
  `computer` VARCHAR(20) NOT NULL,
  `username` VARCHAR(20) NOT NULL,
  `checksum` VARBINARY(150) NOT NULL,
  INDEX `fk_productosPorSolicitud_solicitudes1_idx` (`solicitudId` ASC) VISIBLE,
  INDEX `fk_productosPorSolicitud_copoProductos1_idx` (`productoId` ASC) VISIBLE,
  CONSTRAINT `fk_productosPorSolicitud_solicitudes1`
    FOREIGN KEY (`solicitudId`)
    REFERENCES `Copos`.`solicitudes` (`solicitudId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_productosPorSolicitud_copoProductos1`
    FOREIGN KEY (`productoId`)
    REFERENCES `Copos`.`copoProductos` (`productoId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`productosPorVenta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`productosPorVenta` ;

CREATE TABLE IF NOT EXISTS `Copos`.`productosPorVenta` (
  `ventaId` INT NOT NULL,
  `productoId` INT NOT NULL,
  `cantidad` SMALLINT NOT NULL,
  `enabled` BIT NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `computer` VARCHAR(20) NOT NULL,
  `username` VARCHAR(20) NOT NULL,
  `checksum` VARBINARY(150) NOT NULL,
  INDEX `fk_productosPorVenta_copoProductos1_idx` (`productoId` ASC) VISIBLE,
  INDEX `fk_productosPorVenta_copoVentas1_idx` (`ventaId` ASC) VISIBLE,
  CONSTRAINT `fk_productosPorVenta_copoProductos1`
    FOREIGN KEY (`productoId`)
    REFERENCES `Copos`.`copoProductos` (`productoId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_productosPorVenta_copoVentas1`
    FOREIGN KEY (`ventaId`)
    REFERENCES `Copos`.`copoVentas` (`ventaId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`bitacoraIngredientes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`bitacoraIngredientes` ;

CREATE TABLE IF NOT EXISTS `Copos`.`bitacoraIngredientes` (
  `itemId` INT NOT NULL AUTO_INCREMENT,
  `eventId` INT NOT NULL,
  `ingredienteId` INT NOT NULL,
  `cantidad` DECIMAL(8,2) NOT NULL,
  `fecha` TIMESTAMP NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `computer` VARCHAR(20) NOT NULL,
  `username` VARCHAR(20) NOT NULL,
  `checksum` VARBINARY(150) NOT NULL,
  PRIMARY KEY (`itemId`),
  INDEX `fk_bitacoraIngredientes_eventosCarritos1_idx` (`eventId` ASC) VISIBLE,
  INDEX `fk_bitacoraIngredientes_ingredientes1_idx` (`ingredienteId` ASC) VISIBLE,
  CONSTRAINT `fk_bitacoraIngredientes_eventosCarritos1`
    FOREIGN KEY (`eventId`)
    REFERENCES `Copos`.`eventosCarritos` (`eventId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bitacoraIngredientes_ingredientes1`
    FOREIGN KEY (`ingredienteId`)
    REFERENCES `Copos`.`ingredientes` (`ingredienteId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`ingredientesPorCarrito`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`ingredientesPorCarrito` ;

CREATE TABLE IF NOT EXISTS `Copos`.`ingredientesPorCarrito` (
  `carritoId` SMALLINT NOT NULL,
  `ingredienteId` INT NOT NULL,
  `cantidad` DECIMAL(8,2) NOT NULL,
  `enabled` BIT NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  `computer` VARCHAR(20) NOT NULL,
  `username` VARCHAR(20) NOT NULL,
  `checksum` VARBINARY(150) NOT NULL,
  `ingCarId` INT NOT NULL AUTO_INCREMENT,
  INDEX `fk_ingredientesPorCarrito_carritos1_idx` (`carritoId` ASC) VISIBLE,
  INDEX `fk_ingredientesPorCarrito_ingredientes1_idx` (`ingredienteId` ASC) VISIBLE,
  PRIMARY KEY (`ingCarId`),
  CONSTRAINT `fk_ingredientesPorCarrito_carritos1`
    FOREIGN KEY (`carritoId`)
    REFERENCES `Copos`.`carritos` (`carritoId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ingredientesPorCarrito_ingredientes1`
    FOREIGN KEY (`ingredienteId`)
    REFERENCES `Copos`.`ingredientes` (`ingredienteId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`cajaCarritos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`cajaCarritos` ;

CREATE TABLE IF NOT EXISTS `Copos`.`cajaCarritos` (
  `cajaId` INT NOT NULL AUTO_INCREMENT,
  `turnoId` INT NOT NULL,
  `fecha` DATETIME NOT NULL,
  `tipoEventoCarId` TINYINT NOT NULL,
  `checkStatusId` TINYINT NOT NULL,
  `ventaId` INT NULL,
  `monto` DECIMAL(10,2) NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `computer` VARCHAR(20) NOT NULL,
  `username` VARCHAR(20) NOT NULL,
  `checksum` VARBINARY(150) NOT NULL,
  PRIMARY KEY (`cajaId`),
  INDEX `fk_cajaCarritos_copoVentas1_idx` (`ventaId` ASC) VISIBLE,
  INDEX `fk_cajaCarritos_checkStatuses1_idx` (`checkStatusId` ASC) VISIBLE,
  INDEX `fk_cajaCarritos_tiposEventos1_idx` (`tipoEventoCarId` ASC) VISIBLE,
  INDEX `fk_cajaCarritos_turnos1_idx` (`turnoId` ASC) VISIBLE,
  CONSTRAINT `fk_cajaCarritos_copoVentas1`
    FOREIGN KEY (`ventaId`)
    REFERENCES `Copos`.`copoVentas` (`ventaId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cajaCarritos_checkStatuses1`
    FOREIGN KEY (`checkStatusId`)
    REFERENCES `Copos`.`checkStatuses` (`checkStatusId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cajaCarritos_tiposEventos1`
    FOREIGN KEY (`tipoEventoCarId`)
    REFERENCES `Copos`.`tiposEventosCar` (`tipoEventoCarId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cajaCarritos_turnos1`
    FOREIGN KEY (`turnoId`)
    REFERENCES `Copos`.`turnos` (`turnoId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`pagosPorCopero`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`pagosPorCopero` ;

CREATE TABLE IF NOT EXISTS `Copos`.`pagosPorCopero` (
  `pagoId` INT NOT NULL AUTO_INCREMENT,
  `montoTotal` DECIMAL(10,2) NOT NULL,
  `coperoId` INT NOT NULL,
  `fechaPago` DATETIME NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  `computer` VARCHAR(20) NOT NULL,
  `username` VARCHAR(20) NOT NULL,
  `checksum` VARBINARY(150) NOT NULL,
  PRIMARY KEY (`pagoId`),
  INDEX `fk_pagosPorCopero_coperos1_idx` (`coperoId` ASC) VISIBLE,
  CONSTRAINT `fk_pagosPorCopero_coperos1`
    FOREIGN KEY (`coperoId`)
    REFERENCES `Copos`.`coperos` (`coperoId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`ventasPorPago`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`ventasPorPago` ;

CREATE TABLE IF NOT EXISTS `Copos`.`ventasPorPago` (
  `pagoId` INT NOT NULL,
  `ventaId` INT NOT NULL,
  `montoComision` DECIMAL(10,2) NOT NULL,
  `enabled` BIT NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `computer` VARCHAR(20) NOT NULL,
  `username` VARCHAR(20) NOT NULL,
  `checksum` VARBINARY(150) NOT NULL,
  INDEX `fk_ventasPorPago_pagosPorCopero1_idx` (`pagoId` ASC) VISIBLE,
  INDEX `fk_ventasPorPago_copoVentas1_idx` (`ventaId` ASC) VISIBLE,
  CONSTRAINT `fk_ventasPorPago_pagosPorCopero1`
    FOREIGN KEY (`pagoId`)
    REFERENCES `Copos`.`pagosPorCopero` (`pagoId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ventasPorPago_copoVentas1`
    FOREIGN KEY (`ventaId`)
    REFERENCES `Copos`.`copoVentas` (`ventaId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`bitacoraUbicaciones`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`bitacoraUbicaciones` ;

CREATE TABLE IF NOT EXISTS `Copos`.`bitacoraUbicaciones` (
  `ubicacionId` INT NOT NULL AUTO_INCREMENT,
  `coperoId` INT NOT NULL,
  `ubicacion` POINT NOT NULL,
  `hora` TIMESTAMP NOT NULL,
  `comisionId` INT NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `computer` VARCHAR(20) NOT NULL,
  `username` VARCHAR(20) NOT NULL,
  `checksum` VARBINARY(150) NOT NULL,
  PRIMARY KEY (`ubicacionId`),
  INDEX `fk_bitacoraUbicaciones_coperos1_idx` (`coperoId` ASC) VISIBLE,
  CONSTRAINT `fk_bitacoraUbicaciones_coperos1`
    FOREIGN KEY (`coperoId`)
    REFERENCES `Copos`.`coperos` (`coperoId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`bitacoraSolicitudes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`bitacoraSolicitudes` ;

CREATE TABLE IF NOT EXISTS `Copos`.`bitacoraSolicitudes` (
  `solicitudLogId` INT NOT NULL AUTO_INCREMENT,
  `solicitudId` INT NOT NULL,
  `coperoId` INT NULL,
  `checkStatusId` TINYINT NOT NULL,
  `hora` DATETIME NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `computer` VARCHAR(20) NOT NULL,
  `username` VARCHAR(20) NOT NULL,
  `checksum` VARBINARY(150) NOT NULL,
  PRIMARY KEY (`solicitudLogId`),
  INDEX `fk_bitacoraSolicitudes_solicitudes1_idx` (`solicitudId` ASC) VISIBLE,
  INDEX `fk_bitacoraSolicitudes_coperos1_idx` (`coperoId` ASC) VISIBLE,
  INDEX `fk_bitacoraSolicitudes_checkStatuses1_idx` (`checkStatusId` ASC) VISIBLE,
  CONSTRAINT `fk_bitacoraSolicitudes_solicitudes1`
    FOREIGN KEY (`solicitudId`)
    REFERENCES `Copos`.`solicitudes` (`solicitudId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bitacoraSolicitudes_coperos1`
    FOREIGN KEY (`coperoId`)
    REFERENCES `Copos`.`coperos` (`coperoId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bitacoraSolicitudes_checkStatuses1`
    FOREIGN KEY (`checkStatusId`)
    REFERENCES `Copos`.`checkStatuses` (`checkStatusId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`levels`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`levels` ;

CREATE TABLE IF NOT EXISTS `Copos`.`levels` (
  `levelId` TINYINT NOT NULL,
  `descripcion` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`levelId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`eventTypes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`eventTypes` ;

CREATE TABLE IF NOT EXISTS `Copos`.`eventTypes` (
  `eventTypeId` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`eventTypeId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`objectTypes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`objectTypes` ;

CREATE TABLE IF NOT EXISTS `Copos`.`objectTypes` (
  `objectTypeId` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`objectTypeId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`sources`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`sources` ;

CREATE TABLE IF NOT EXISTS `Copos`.`sources` (
  `sourceId` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`sourceId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`eventLogs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`eventLogs` ;

CREATE TABLE IF NOT EXISTS `Copos`.`eventLogs` (
  `eventLogId` INT NOT NULL,
  `posttime` DATETIME NOT NULL,
  `computer` VARCHAR(15) NOT NULL,
  `username` VARCHAR(20) NOT NULL,
  `checksum` VARBINARY(150) NOT NULL,
  `descripcion` VARCHAR(250) NOT NULL,
  `referenceId1` BIGINT NOT NULL,
  `referenceId2` BIGINT NOT NULL,
  `value1` VARCHAR(60) NOT NULL,
  `value2` VARCHAR(60) NOT NULL,
  `ubicacion` POINT NOT NULL,
  `levelId` TINYINT NOT NULL,
  `eventTypeId` INT NOT NULL,
  `objectTypeId` INT NOT NULL,
  `sourceId` INT NOT NULL,
  PRIMARY KEY (`eventLogId`),
  INDEX `fk_eventLogs_levels1_idx` (`levelId` ASC) VISIBLE,
  INDEX `fk_eventLogs_eventTypes1_idx` (`eventTypeId` ASC) VISIBLE,
  INDEX `fk_eventLogs_objectTypes1_idx` (`objectTypeId` ASC) VISIBLE,
  INDEX `fk_eventLogs_sources1_idx` (`sourceId` ASC) VISIBLE,
  CONSTRAINT `fk_eventLogs_levels1`
    FOREIGN KEY (`levelId`)
    REFERENCES `Copos`.`levels` (`levelId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_eventLogs_eventTypes1`
    FOREIGN KEY (`eventTypeId`)
    REFERENCES `Copos`.`eventTypes` (`eventTypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_eventLogs_objectTypes1`
    FOREIGN KEY (`objectTypeId`)
    REFERENCES `Copos`.`objectTypes` (`objectTypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_eventLogs_sources1`
    FOREIGN KEY (`sourceId`)
    REFERENCES `Copos`.`sources` (`sourceId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


use copos;

INSERT INTO tiposEventosCar (nombreEvento, enabled) VALUES
('Apertura', 1),
('Cierre', 1),
('CambioTurno', 1),
('Ingreso', 1),
('Salida', 1);


INSERT INTO checkStatuses (nombreStatus, enabled) VALUES
('Confirmado', 1),
('Diferencias', 1),
('Cancelado', 1),
('Pendiente', 1),
('Procesando', 1),
('Completado', 1);

INSERT INTO coperos (nombre, telefono, cuentaBancaria, enabled, createdAt, computer, username, checksum) VALUES
('John Doe', 12345678, '95325407219874586241632509731246508084676124896093', 1, '2023-03-10 09:30:00', 'computer1', 'user1',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Mary Smith', 98765432, '38921579046210593740581720713506235904215619867538', 1, '2023-03-09 12:00:00', 'computer2', 'user2',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Peter Parker', 23456789, '12746385902753108495296087135473802956439157035841', 1, '2023-03-08 15:45:00', 'computer3', 'user3',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Anna Garcia', 34567890, '76285934789601327510896352819347602510679083450790', 1, '2023-03-07 18:20:00', 'computer4', 'user4',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Luis Hernandez', 45678901, '35170894362105890347582301965823901456792018452793', 1, '2023-03-06 21:10:00', 'computer5', 'user5',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Robert Johnson', 56789012, '24680359214879605193742850310975862497501263458021', 1, '2023-03-05 10:30:00', 'computer6', 'user6',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Carla Martinez', 67890123, '89173508294719654802371564892603574109826503721549', 1, '2023-03-04 13:45:00', 'computer7', 'user7',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Fernando Torres', 78901234, '50294813675913208695470281534967820945739062187504', 1, '2023-03-03 16:20:00', 'computer8', 'user8',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Monica Rodriguez', 89012345, '46795802315701823509658739452601987025394106837549', 1, '2023-03-02 19:10:00', 'computer9', 'user9',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Jorge Gonzalez', 90123456, '81964702915734806250375910642539871068947532051469', 1, '2023-03-01 22:30:00', 'computer10', 'user10',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Laura Alvarez', 34567812, '53078490273185469025794806321409568039762103548975', 1, '2023-02-28 09:15:00', 'computer11', 'user11',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Alberto Castro', 23456781, '21358069741085694752037809654120978354601938275014', 1, '2023-02-27 12:30:00', 'computer12', 'user12',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Beatriz Romero', 45678123, '91368740529701324659842715603897512406915382045763', 1, '2023-02-26 15:45:00', 'computer13', 'user13',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Juan Hernandez', 12349876, '17624590328479610857923046587354901263458097531028', 1, '2023-02-25 18:20:00', 'computer14', 'user14',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Alfonso Davies', 89016472, '46810235790532194085790346580231759674809312506943', 1, '2023-03-10 09:30:00', 'computer1', 'user1',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Alice Johnson', 60123235, '3456789012345678901234567890123456789012', 1, '2023-03-08 15:45:00', 'computer3', 'user3',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Bob Brown', 81924433, '4567890123456789012345678901234567890123', 1, '2023-03-07 18:20:00', 'computer4', 'user4',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Eva Green', 92375632, '5678901234567890123456789012345678901234', 1, '2023-03-06 21:10:00', 'computer5', 'user5',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Juan Perez', 12345678, '59403725801620493875012648579321058694750382165024', 1, '2022-01-01 09:00:00', 'computer1', 'user1',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Maria Rodriguez', 98765432, '30895740213658971064579203846509723156840925760318', 1, '2022-02-02 12:00:00', 'computer2', 'user2',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Pedro Gonzalez', 23456789, '83215096740135869745910234658732095146708931520486', 1, '2022-03-03 15:00:00', 'computer3', 'user3',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Ana Ramirez', 34567890, '56012378490563219804751032968475021396845702135048', 1, '2022-04-04 18:00:00', 'comcputer4', 'user4',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Luisa Fernandez', 45678901, '40325689701895746230186594072513860492573681058921', 1, '2022-05-05 21:00:00', 'computer5', 'user5',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Roberto Martinez', 56789012, '17890324569810756249356821905304769123580475293681', 1, '2022-06-06 10:00:00', 'computer6', 'user6',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Carla Sanchez', 67890123, '64379012506825793105489620731584620978435612093875', 1, '2022-07-07 13:00:00', 'computer7', 'user7',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Fernando Garcia', 78901234, '51023784698563129704589620347158602493587210643985', 1, '2022-08-08 16:00:00', 'computer8', 'user8',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Monica Castro', 89012345, '23875904136589217409653827014567905832701594638012', 1, '2022-09-09 19:00:00', 'computer9', 'user9',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Jorge Jimenez', 90123456, '72039568451386794025193408652741390528694750126348', 1, '2022-10-10 22:00:00', 'computer10', 'user10',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Laura Alvarez', 34567812, '46017293875102893568403925710659483207950623145897', 1, '2022-11-11 09:00:00', 'computer11', 'user11',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Alberto Castro', 23456781, '52039867541089623579043125768409521763908405213758', 1, '2022-12-12 12:00:00', 'computer12', 'user12',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256));

-- SELECT * FROM coperos;

INSERT INTO carritos (color, dinero, placa, enabled, createdAt, updatedAt, computer, username, checksum) VALUES
('rojo', 0, 'ABC-123', 1, '2022-01-01 10:00:00', NULL, 'computer1', 'user1', SHA2(CONCAT(username, placa, createdAt, dinero, enabled, 'carritos', computer, color), 256)),
('azul', 0, 'DEF-456', 1, '2022-01-02 11:30:00', NULL, 'computer2', 'user2', SHA2(CONCAT(username, placa, createdAt, dinero, enabled, 'carritos', computer, color), 256)),
('verde', 0, 'GHI-789', 1, '2022-01-03 14:45:00', NULL, 'computer1', 'user3', SHA2(CONCAT(username, placa, createdAt, dinero, enabled, 'carritos', computer, color), 256)),
('amarillo', 0, 'JKL-012', 1, '2022-01-04 09:15:00', NULL, 'computer2', 'user4', SHA2(CONCAT(username, placa, createdAt, dinero, enabled, 'carritos', computer, color), 256)),
('negro', 0, 'MNO-345', 1, '2022-01-05 08:00:00', NULL, 'computer3', 'user5', SHA2(CONCAT(username, placa, createdAt, dinero, enabled, 'carritos', computer, color), 256)),
('blanco', 0, 'PQR-678', 1, '2022-01-06 17:45:00', NULL, 'computer3', 'user6', SHA2(CONCAT(username, placa, createdAt, dinero, enabled, 'carritos', computer, color), 256)),
('morado', 0, 'STU-901', 1, '2022-01-07 15:30:00', NULL, 'computer4', 'user7', SHA2(CONCAT(username, placa, createdAt, dinero, enabled, 'carritos', computer, color), 256)),
('gris', 0, 'VWX-234', 1, '2022-01-08 12:00:00', NULL, 'computer4', 'user8', SHA2(CONCAT(username, placa, createdAt, dinero, enabled, 'carritos', computer, color), 256)),
('anaranjado', 0, 'YZA-567', 1, '2022-01-09 09:15:00', NULL, 'computer5', 'user9', SHA2(CONCAT(username, placa, createdAt, dinero, enabled, 'carritos', computer, color), 256)),
('rosado', 0, 'BCD-890', 1, '2022-01-10 14:45:00', NULL, 'computer5', 'user10', SHA2(CONCAT(username, placa, createdAt, dinero, enabled, 'carritos', computer, color), 256)),
('cafe', 0, 'EFG-123', 1, '2022-01-11 09:15:00', NULL, 'computer6', 'user11', SHA2(CONCAT(username, placa, createdAt, dinero, enabled, 'carritos', computer, color), 256)),
('plateado', 0, 'HIJ-456', 1, '2022-01-12 11:30:00', NULL, 'computer6', 'user12', SHA2(CONCAT(username, placa, createdAt, dinero, enabled, 'carritos', computer, color), 256)),
('dorado', 0, 'DGR-235', 1, '2022-01-10 14:45:00', NULL, 'computer5', 'user10', SHA2(CONCAT(username, placa, createdAt, dinero, enabled, 'carritos', computer, color), 256)),
('celeste', 0, 'TWN-039', 1, '2022-01-11 09:15:00', NULL, 'computer6', 'user11', SHA2(CONCAT(username, placa, createdAt, dinero, enabled, 'carritos', computer, color), 256)),
('turquesa', 0, 'WKN-777', 1, '2022-01-12 11:30:00', NULL, 'computer6', 'user12', SHA2(CONCAT(username, placa, createdAt, dinero, enabled, 'carritos', computer, color), 256));

-- SELECT * FROM carritos;

INSERT INTO playas (nombre, enabled) VALUES
('playa herradura', 1),
('playa blanca', 1),
('playa tamarindo', 1),
('playa jacó', 1);

-- SELECT * FROM playas;

INSERT INTO ingredientes (descripcion, medida, enabled) VALUES
('hielo granizado', 'tazas', 1),
('leche en polvo', 'cucharadas', 1),
('leche condensada', 'cucharadas', 1),
('sirope', 'tazas', 1),
('sabor café', 'tazas', 1),
('sabor limon', 'tazas', 1),
('sabor chicle', 'tazas', 1),
('sabor maracuya', 'tazas', 1),
('tequila', 'onzas', 1),
('cointreau', 'onzas', 1),
('jugo de limon', 'onzas', 1),
('sal', 'cucharada', 1),
('vaso', 'unidad', 1),
('jugo de piña', 'mL', 1),
('ron blanco', 'mL', 1),
('crema de coco', 'mL', 1),
('piña', 'gramos', 1),
('lima', 'unidad', 1),
('azúcar granulada', 'cucharadita', 1),
('menta', 'gramos', 1),
('agua carbonatada', 'mL', 1);

-- SELECT * FROM ingredientes;

INSERT INTO copoProductos (nombre, enabled, createdAt, computer, username, checksum) VALUES
('copo regular', 1, '2023-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(username, enabled, createdAt, 'copoProducts', nombre), 256)),
('copo regular grande', 1, '2023-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(username, enabled, createdAt, 'copoProducts', nombre), 256)),
('copo sabor café', 1, '2023-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(username, enabled, createdAt, 'copoProducts', nombre), 256)),
('copo sabor cafe grande', 1, '2023-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(username, enabled, createdAt, 'copoProducts', nombre), 256)),
('copo sabor limon', 1, '2023-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(username, enabled, createdAt, 'copoProducts', nombre), 256)),
('copo sabor limon grande', 1, '2023-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(username, enabled, createdAt, 'copoProducts', nombre), 256)),
('copo sabor chicle', 1, '2023-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(username, enabled, createdAt, 'copoProducts', nombre), 256)),
('copo sabor chicle grande', 1, '2023-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(username, enabled, createdAt, 'copoProducts', nombre), 256)),
('margarita', 1, '2023-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(username, enabled, createdAt, 'copoProducts', nombre), 256)),
('piña colada', 1, '2023-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(username, enabled, createdAt, 'copoProducts', nombre), 256)),
('mojito', 1, '2023-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(username, enabled, createdAt, 'copoProducts', nombre), 256)),
('copo sabor maracuya', 1, '2023-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(username, enabled, createdAt, 'copoProducts', nombre), 256)),
('copo sabor maracuya grande', 1, '2023-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(username, enabled, createdAt, 'copoProducts', nombre), 256));

-- SELECT * FROM copoProductos;

INSERT INTO ingredientesPorProductos (productoId, ingredienteId, cantidad, enabled, createdAt, computer, username, checksum) VALUES
(1, 1, 1, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(1, 2, 4, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(1, 3, 2, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(1, 4, 0.25, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(1, 13, 1, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(2, 1, 2, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(2, 2, 6, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(2, 3, 4, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(2, 4, 0.5, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(2, 13, 1, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(3, 1, 1, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(3, 2, 4, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(3, 3, 2, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(3, 5, 0.25, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(3, 13, 1, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(4, 1, 2, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(4, 2, 6, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(4, 3, 4, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(4, 5, 0.5, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(4, 13, 1, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(5, 1, 1, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(5, 2, 4, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(5, 3, 2, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(5, 6, 0.25, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(5, 13, 1, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(6, 1, 2, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(6, 2, 6, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(6, 3, 4, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(6, 6, 0.5, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(6, 13, 1, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(7, 1, 1, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(7, 2, 4, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(7, 3, 2, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(7, 7, 0.25, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(7, 13, 1, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(8, 1, 2, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(8, 2, 6, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(8, 3, 4, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(8, 7, 0.5, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(8, 13, 1, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(9, 9, 1.5, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(9, 10, 1, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(9, 11, 0.75, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(9, 12, 0.5, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(9, 13, 1, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(10, 14, 120, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(10, 15, 60, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(10, 16, 60, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(10, 17, 15, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(10, 13, 1, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(11, 18, 1, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(11, 19, 1, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(11, 20, 5, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(11, 15, 60, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(11, 21, 180, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(11, 13, 1, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(12, 1, 1, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(12, 2, 4, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(12, 3, 2, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(12, 8, 0.25, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(12, 13, 1, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(13, 1, 2, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(13, 2, 6, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(13, 3, 4, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(13, 8, 0.5, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(13, 13, 1, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256));

-- SELECT * FROM ingredientesPorProductos;

INSERT INTO preciosDefault (productoId, precio, fechaInicio, enabled, createdAt, computer, username, checksum) VALUES
(1, 2500, '2022-01-05 09:30:00', 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(precio, createdAt, computer, productoId, enabled, username), 256)),
(2, 4000, '2022-01-05 09:30:00', 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(precio, createdAt, computer, productoId, enabled, username), 256)),
(3, 2500, '2022-01-05 09:30:00', 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(precio, createdAt, computer, productoId, enabled, username), 256)),
(4, 4000, '2022-01-05 09:30:00', 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(precio, createdAt, computer, productoId, enabled, username), 256)),
(5, 2500, '2022-01-05 09:30:00', 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(precio, createdAt, computer, productoId, enabled, username), 256)),
(6, 4000, '2022-01-05 09:30:00', 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(precio, createdAt, computer, productoId, enabled, username), 256)),
(7, 2500, '2022-01-05 09:30:00', 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(precio, createdAt, computer, productoId, enabled, username), 256)),
(8, 4000, '2022-01-05 09:30:00', 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(precio, createdAt, computer, productoId, enabled, username), 256)),
(9, 5000, '2022-01-05 09:30:00', 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(precio, createdAt, computer, productoId, enabled, username), 256)),
(10, 5000, '2022-01-05 09:30:00', 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(precio, createdAt, computer, productoId, enabled, username), 256)),
(11, 5000, '2022-01-05 09:30:00', 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(precio, createdAt, computer, productoId, enabled, username), 256)),
(12, 2500, '2022-01-05 09:30:00', 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(precio, createdAt, computer, productoId, enabled, username), 256)),
(13, 4000, '2022-01-05 09:30:00', 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(precio, createdAt, computer, productoId, enabled, username), 256));

UPDATE copoProductos, preciosDefault
SET copoProductos.precioDefaultId = preciosDefault.precioDefaultId
WHERE copoProductos.productoId = preciosDefault.precioDefaultId AND preciosDefault.enabled = 1;

-- SELECT * FROM preciosDefault;

INSERT INTO preciosPorProducto (productoId, playaId, precio, fechaInicio, enabled, createdAt, computer, username, checksum) VALUES
(3, 1, 3500, '2022-01-05 09:30:00', 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(precio, createdAt, playaId, fechaInicio, computer, productoId, enabled, username), 256)),
(3, 2, 3000, '2022-01-05 09:30:00', 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(precio, createdAt, playaId, fechaInicio, computer, productoId, enabled, username), 256)),
(4, 1, 5000, '2022-01-05 09:30:00', 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(precio, createdAt, playaId, fechaInicio, computer, productoId, enabled, username), 256)),
(10, 3, 5500, '2022-01-05 09:30:00', 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(precio, createdAt, playaId, fechaInicio, computer, productoId, enabled, username), 256)),
(9, 4, 5500, '2022-01-05 09:30:00', 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(precio, createdAt, playaId, fechaInicio, computer, productoId, enabled, username), 256));

INSERT INTO ingredientesPorCarrito (carritoId, ingredienteId, cantidad, enabled, createdAt, computer, username, checksum) VALUES
(1, 1, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 2, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 3, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 4, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 5, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 6, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 7, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 8, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 9, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 10, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 11, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 12, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 13, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 14, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 15, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 16, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 17, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 18, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 19, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 20, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 21, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(2, 1, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(2, 2, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(2, 3, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(2, 4, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(2, 5, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(2, 6, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(2, 7, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(2, 8, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(2, 9, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(2, 10, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(2, 11, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(2, 12, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(2, 13, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(2, 14, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(2, 15, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(2, 16, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(2, 17, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(2, 18, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(2, 19, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(2, 20, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(2, 21, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(3, 1, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(3, 2, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(3, 3, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(3, 4, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(3, 5, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(3, 6, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(3, 7, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(3, 8, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(3, 9, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(3, 10, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(3, 11, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(3, 12, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(3, 13, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(3, 14, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(3, 15, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(3, 16, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(3, 17, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(3, 18, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(3, 19, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(3, 20, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(3, 21, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(4, 1, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(4, 2, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(4, 3, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(4, 4, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(4, 5, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(4, 6, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(4, 7, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(4, 8, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(4, 9, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(4, 10, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(4, 11, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(4, 12, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(4, 13, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(4, 14, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(4, 15, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(4, 16, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(4, 17, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(4, 18, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(4, 19, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(4, 20, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(4, 21, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(5, 1, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(5, 2, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(5, 3, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(5, 4, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(5, 5, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(5, 6, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(5, 7, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(5, 8, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(5, 9, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(5, 10, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(5, 11, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(5, 12, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(5, 13, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(5, 14, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(5, 15, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(5, 16, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(5, 17, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(5, 18, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(5, 19, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(5, 20, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(5, 21, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(6, 1, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(6, 2, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(6, 3, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(6, 4, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(6, 5, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(6, 6, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(6, 7, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(6, 8, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(6, 9, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(6, 10, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(6, 11, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(6, 12, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(6, 13, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(6, 14, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(6, 15, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(6, 16, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(6, 17, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(6, 18, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(6, 19, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(6, 20, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(6, 21, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(7, 1, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(7, 2, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(7, 3, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(7, 4, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(7, 5, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(7, 6, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(7, 7, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(7, 8, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(7, 9, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(7, 10, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(7, 11, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(7, 12, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(7, 13, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(7, 14, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(7, 15, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(7, 16, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(7, 17, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(7, 18, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(7, 19, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(7, 20, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(7, 21, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(8, 1, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(8, 2, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(8, 3, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(8, 4, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(8, 5, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(8, 6, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(8, 7, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(8, 8, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(8, 9, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(8, 10, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(8, 11, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(8, 12, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(8, 13, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(8, 14, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(8, 15, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(8, 16, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(8, 17, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(8, 18, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(8, 19, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(8, 20, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(8, 21, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(9, 1, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(9, 2, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(9, 3, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(9, 4, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(9, 5, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(9, 6, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(9, 7, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(9, 8, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(9, 9, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(9, 10, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(9, 11, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(9, 12, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(9, 13, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(9, 14, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(9, 15, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(9, 16, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(9, 17, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(9, 18, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(9, 19, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(9, 20, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(9, 21, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(10, 1, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(10, 2, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(10, 3, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(10, 4, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(10, 5, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(10, 6, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(10, 7, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(10, 8, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(10, 9, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(10, 10, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(10, 11, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(10, 12, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(10, 13, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(10, 14, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(10, 15, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(10, 16, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(10, 17, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(10, 18, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(10, 19, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(10, 20, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(10, 21, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(11, 1, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(11, 2, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(11, 3, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(11, 4, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(11, 5, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(11, 6, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(11, 7, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(11, 8, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(11, 9, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(11, 10, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(11, 11, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(11, 12, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(11, 13, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(11, 14, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(11, 15, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(11, 16, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(11, 17, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(11, 18, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(11, 19, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(11, 20, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(11, 21, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(12, 1, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(12, 2, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(12, 3, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(12, 4, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(12, 5, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(12, 6, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(12, 7, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(12, 8, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(12, 9, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(12, 10, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(12, 11, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(12, 12, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(12, 13, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(12, 14, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(12, 15, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(12, 16, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(12, 17, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(12, 18, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(12, 19, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(12, 20, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(12, 21, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(13, 1, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(13, 2, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(13, 3, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(13, 4, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(13, 5, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(13, 6, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(13, 7, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(13, 8, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(13, 9, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(13, 10, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(13, 11, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(13, 12, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(13, 13, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(13, 14, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(13, 15, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(13, 16, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(13, 17, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(13, 18, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(13, 19, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(13, 20, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(13, 21, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(14, 1, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(14, 2, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(14, 3, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(14, 4, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(14, 5, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(14, 6, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(14, 7, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(14, 8, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(14, 9, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(14, 10, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(14, 11, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(14, 12, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(14, 13, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(14, 14, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(14, 15, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(14, 16, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(14, 17, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(14, 18, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(14, 19, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(14, 20, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(14, 21, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(15, 1, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(15, 2, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(15, 3, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(15, 4, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(15, 5, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(15, 6, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(15, 7, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(15, 8, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(15, 9, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(15, 10, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(15, 11, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(15, 12, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(15, 13, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(15, 14, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(15, 15, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(15, 16, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(15, 17, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(15, 18, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(15, 19, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(15, 20, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(15, 21, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256));

INSERT INTO comisiones (comision, fechaInicio, fechaFin, enabled, createdAt, computer, username, checksum) VALUES
(10.0, '2021-01-01', NULL, 1, Now(), 'computer1', 'user1', SHA2('Diego es pavo', 256));