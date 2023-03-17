-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Copos
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Copos
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Copos` DEFAULT CHARACTER SET utf8 ;
USE `Copos` ;

-- -----------------------------------------------------
-- Table `Copos`.`preciosDefault`
-- -----------------------------------------------------
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
CREATE TABLE IF NOT EXISTS `Copos`.`coperos` (
  `coperoId` INT NOT NULL COMMENT 'identificacion del copero',
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
CREATE TABLE IF NOT EXISTS `Copos`.`carritos` (
  `carritoId` SMALLINT NOT NULL,
  `color` VARCHAR(10) NOT NULL,
  `dinero` DECIMAL(10,2) NOT NULL,
  `placa` VARCHAR(10) NOT NULL,
  `enabled` BIT NOT NULL,
  `created_At` DATETIME NOT NULL,
  `updated_at` DATETIME NULL,
  `computer` VARCHAR(20) NOT NULL,
  `username` VARCHAR(20) NOT NULL,
  `checksum` VARBINARY(150) NOT NULL,
  PRIMARY KEY (`carritoId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`playas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Copos`.`playas` (
  `playaId` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(20) NOT NULL,
  `enabled` BIT NOT NULL,
  PRIMARY KEY (`playaId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`turnos`
-- -----------------------------------------------------
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
CREATE TABLE IF NOT EXISTS `Copos`.`comisiones` (
  `comisionId` INT NOT NULL AUTO_INCREMENT,
  `comision` DECIMAL(5,2) NOT NULL,
  `fechaInicio` DATE NOT NULL,
  `fechaFin` DATE NOT NULL,
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
CREATE TABLE IF NOT EXISTS `Copos`.`copoVentas` (
  `ventaId` INT NOT NULL AUTO_INCREMENT,
  `turnoId` INT NOT NULL,
  `postDate` DATE NOT NULL,
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
CREATE TABLE IF NOT EXISTS `Copos`.`ingredientes` (
  `ingredienteId` INT NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `medida` VARCHAR(20) NOT NULL,
  `enabled` BIT NOT NULL,
  PRIMARY KEY (`ingredienteId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`ingredientesPorProductos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Copos`.`ingredientesPorProductos` (
  `productoId` INT NOT NULL,
  `ingrediente_id` INT NOT NULL,
  `cantidad` DECIMAL(8,2) NOT NULL,
  `enabled` BIT NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  `computer` VARCHAR(20) NOT NULL,
  `username` VARCHAR(20) NOT NULL,
  `checksum` VARBINARY(150) NOT NULL,
  INDEX `fk_ingredientes_por_productos_copo_productos1_idx` (`productoId` ASC) VISIBLE,
  INDEX `fk_ingredientes_por_productos_ingredientes1_idx` (`ingrediente_id` ASC) VISIBLE,
  CONSTRAINT `fk_ingredientes_por_productos_copo_productos1`
    FOREIGN KEY (`productoId`)
    REFERENCES `Copos`.`copoProductos` (`productoId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ingredientes_por_productos_ingredientes1`
    FOREIGN KEY (`ingrediente_id`)
    REFERENCES `Copos`.`ingredientes` (`ingredienteId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`tiposEventosCar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Copos`.`tiposEventosCar` (
  `tipoEventoCarId` TINYINT NOT NULL AUTO_INCREMENT,
  `nombreEvento` VARCHAR(15) NOT NULL,
  `enabled` BIT NOT NULL,
  PRIMARY KEY (`tipoEventoCarId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`checkStatuses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Copos`.`checkStatuses` (
  `checkStatusId` TINYINT NOT NULL AUTO_INCREMENT,
  `nombreStatus` VARCHAR(15) NOT NULL,
  `enabled` BIT NOT NULL,
  PRIMARY KEY (`checkStatusId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`eventosCarritos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Copos`.`eventosCarritos` (
  `eventId` INT NOT NULL AUTO_INCREMENT,
  `turnoId` INT NOT NULL,
  `fecha` DATETIME NOT NULL,
  `tipoEventoCarId` TINYINT NOT NULL,
  `checkStatusId` TINYINT NOT NULL,
  `enabled` BIT NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
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
CREATE TABLE IF NOT EXISTS `Copos`.`preciosPorProducto` (
  `precioId` INT NOT NULL AUTO_INCREMENT,
  `productoId` INT NOT NULL,
  `playaId` INT NOT NULL,
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
CREATE TABLE IF NOT EXISTS `Copos`.`bitacoraIngredientes` (
  `itemId` INT NOT NULL AUTO_INCREMENT,
  `eventId` INT NOT NULL,
  `ingredienteId` INT NOT NULL,
  `cantidad` DECIMAL(8,2) NOT NULL,
  `fecha` TIMESTAMP NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
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
  INDEX `fk_ingredientesPorCarrito_carritos1_idx` (`carritoId` ASC) VISIBLE,
  INDEX `fk_ingredientesPorCarrito_ingredientes1_idx` (`ingredienteId` ASC) VISIBLE,
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
CREATE TABLE IF NOT EXISTS `Copos`.`cajaCarritos` (
  `cajaId` INT NOT NULL,
  `turnoId` INT NOT NULL,
  `fecha` DATETIME NOT NULL,
  `tipoEventoCarId` TINYINT NOT NULL,
  `checkStatusId` TINYINT NOT NULL,
  `ventaId` INT NULL,
  `monto` DECIMAL(10,2) NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
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
CREATE TABLE IF NOT EXISTS `Copos`.`levels` (
  `levelId` TINYINT NOT NULL,
  `descripcion` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`levelId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`eventTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Copos`.`eventTypes` (
  `eventTypeId` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`eventTypeId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`objectTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Copos`.`objectTypes` (
  `objectTypeId` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`objectTypeId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`sources`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Copos`.`sources` (
  `sourceId` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`sourceId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`eventLogs`
-- -----------------------------------------------------
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
