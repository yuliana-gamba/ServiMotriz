-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema servi_motriz
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema servi_motriz
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `servi_motriz` DEFAULT CHARACTER SET utf8 ;
USE `servi_motriz` ;

-- -----------------------------------------------------
-- Table `servi_motriz`.`tipos_identificaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servi_motriz`.`tipos_identificaciones` (
  `id_tipo_identificacion` INT NOT NULL AUTO_INCREMENT,
  `descripcion_tipo_identificacion` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_tipo_identificacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `servi_motriz`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servi_motriz`.`roles` (
  `id_rol` INT NOT NULL AUTO_INCREMENT,
  `descripcion_rol` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_rol`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `servi_motriz`.`generos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servi_motriz`.`generos` (
  `id_genero` INT NOT NULL AUTO_INCREMENT,
  `descripcion_genero` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_genero`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `servi_motriz`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servi_motriz`.`usuarios` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `numero_identificacion` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `apellido` VARCHAR(100) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `telefono` VARCHAR(20) NOT NULL,
  `correo` VARCHAR(150) NOT NULL,
  `direccion` VARCHAR(200) NOT NULL,
  `clave` VARCHAR(255) NOT NULL,
  `fecha_vencimiento_clave` DATE NOT NULL,
  `autorizacion_datos` TINYINT NOT NULL,
  `generos_id_genero` INT NOT NULL,
  `tipos_identificaciones_id_tipo_identificacion` INT NOT NULL,
  `roles_id_rol` INT NOT NULL,
  `estado` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '1 = activo, 0 = inactivo',
  PRIMARY KEY (`id_usuario`),
  UNIQUE INDEX `id.identificacion_UNIQUE` (`numero_identificacion` ) ,
  UNIQUE INDEX `correo_UNIQUE` (`correo` ) ,
  INDEX `fk_usuarios_generos1_idx` (`generos_id_genero` ) ,
  INDEX `fk_usuarios_tipos_identificaciones1_idx` (`tipos_identificaciones_id_tipo_identificacion` ) ,
  INDEX `fk_usuarios_roles1_idx` (`roles_id_rol` ) ,
  CONSTRAINT `fk_usuarios_generos1`
    FOREIGN KEY (`generos_id_genero`)
    REFERENCES `servi_motriz`.`generos` (`id_genero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_tipos_identificaciones1`
    FOREIGN KEY (`tipos_identificaciones_id_tipo_identificacion`)
    REFERENCES `servi_motriz`.`tipos_identificaciones` (`id_tipo_identificacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_roles1`
    FOREIGN KEY (`roles_id_rol`)
    REFERENCES `servi_motriz`.`roles` (`id_rol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `servi_motriz`.`marcas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servi_motriz`.`marcas` (
  `id_marca` INT NOT NULL AUTO_INCREMENT,
  `descripcion_marca` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_marca`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `servi_motriz`.`vehiculos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servi_motriz`.`vehiculos` (
  `id_vehiculo` INT NOT NULL AUTO_INCREMENT,
  `fecha_reg_vehi` DATE NOT NULL,
  `color` VARCHAR(45) NOT NULL,
  `modelo` VARCHAR(45) NOT NULL,
  `placa` VARCHAR(20) NOT NULL,
  `marcas_id_marca` INT NOT NULL,
  `usuarios_id_usuario` INT NOT NULL,
  PRIMARY KEY (`id_vehiculo`),
  INDEX `fk_vehiculos_marcas1_idx` (`marcas_id_marca` ) ,
  INDEX `fk_vehiculos_usuarios1_idx` (`usuarios_id_usuario` ) ,
  CONSTRAINT `fk_vehiculos_marcas1`
    FOREIGN KEY (`marcas_id_marca`)
    REFERENCES `servi_motriz`.`marcas` (`id_marca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vehiculos_usuarios1`
    FOREIGN KEY (`usuarios_id_usuario`)
    REFERENCES `servi_motriz`.`usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `servi_motriz`.`medios_pagos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servi_motriz`.`medios_pagos` (
  `id_medio_pago` INT NOT NULL AUTO_INCREMENT,
  `descripcion_medio_pago` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_medio_pago`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `servi_motriz`.`servicios_realizados_cabezas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servi_motriz`.`servicios_realizados_cabezas` (
  `id_servicio_realizado_cabeza` INT NOT NULL AUTO_INCREMENT,
  `fecha_servicio` DATE NOT NULL,
  `numero_Servicio` INT NOT NULL,
  `descripcion` VARCHAR(255) NOT NULL,
  `total` DECIMAL(10,2) NOT NULL,
  `numero_ref_pago` VARCHAR(100) NOT NULL,
  `vehiculos_id_vehiculo` INT NOT NULL,
  `medios_pagos_id_medio_pago` INT NOT NULL,
  `usuarios_id_usuario` INT NULL COMMENT 'Mecánico que realizó el servicio',
  PRIMARY KEY (`id_servicio_realizado_cabeza`),
  INDEX `fk_servicios_realizados_cabezas_vehiculos1_idx` (`vehiculos_id_vehiculo` ) ,
  INDEX `fk_servicios_realizados_cabezas_medios_pagos1_idx` (`medios_pagos_id_medio_pago` ) ,
  INDEX `fk_servicios_realizados_cabezas_usuarios1_idx` (`usuarios_id_usuario` ) ,
  CONSTRAINT `fk_servicios_realizados_cabezas_vehiculos1`
    FOREIGN KEY (`vehiculos_id_vehiculo`)
    REFERENCES `servi_motriz`.`vehiculos` (`id_vehiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_servicios_realizados_cabezas_medios_pagos1`
    FOREIGN KEY (`medios_pagos_id_medio_pago`)
    REFERENCES `servi_motriz`.`medios_pagos` (`id_medio_pago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_servicios_realizados_cabezas_usuarios1`
    FOREIGN KEY (`usuarios_id_usuario`)
    REFERENCES `servi_motriz`.`usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `servi_motriz`.`tipos_de_servicios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servi_motriz`.`tipos_de_servicios` (
  `id_tipo_de_servicio` INT NOT NULL AUTO_INCREMENT,
  `nombre_servicio_hacer` VARCHAR(100) NOT NULL,
  `valor` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id_tipo_de_servicio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `servi_motriz`.`servicios_realizados_detalles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servi_motriz`.`servicios_realizados_detalles` (
  `id_servicio_realizado_detalle` INT NOT NULL AUTO_INCREMENT,
  `cantidad` INT NOT NULL,
  `subtotal` DECIMAL(10,2) NOT NULL,
  `servicios_realizados_cabezas_id_servicio_realizado_cabeza` INT NOT NULL,
  `tipos_de_servicios_id_tipo_de_servicio` INT NOT NULL,
  PRIMARY KEY (`id_servicio_realizado_detalle`),
  INDEX `fk_servicios_realizados_detalles_servicios_realizados_cabez_idx` (`servicios_realizados_cabezas_id_servicio_realizado_cabeza` ) ,
  INDEX `fk_servicios_realizados_detalles_tipos_de_servicios1_idx` (`tipos_de_servicios_id_tipo_de_servicio` ) ,
  CONSTRAINT `fk_servicios_realizados_detalles_servicios_realizados_cabezas1`
    FOREIGN KEY (`servicios_realizados_cabezas_id_servicio_realizado_cabeza`)
    REFERENCES `servi_motriz`.`servicios_realizados_cabezas` (`id_servicio_realizado_cabeza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_servicios_realizados_detalles_tipos_de_servicios1`
    FOREIGN KEY (`tipos_de_servicios_id_tipo_de_servicio`)
    REFERENCES `servi_motriz`.`tipos_de_servicios` (`id_tipo_de_servicio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `servi_motriz`.`permisos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servi_motriz`.`permisos` (
  `id_permiso` INT NOT NULL AUTO_INCREMENT,
  `descripcion_permiso` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_permiso`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `servi_motriz`.`roles_has_permisos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servi_motriz`.`roles_has_permisos` (
  `roles_id_rol` INT NOT NULL,
  `permisos_id_permiso` INT NOT NULL,
  PRIMARY KEY (`roles_id_rol`, `permisos_id_permiso`),
  INDEX `fk_roles_has_permisos_permisos1_idx` (`permisos_id_permiso` ) ,
  INDEX `fk_roles_has_permisos_roles1_idx` (`roles_id_rol` ),
  CONSTRAINT `fk_roles_has_permisos_roles1`
    FOREIGN KEY (`roles_id_rol`)
    REFERENCES `servi_motriz`.`roles` (`id_rol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_roles_has_permisos_permisos1`
    FOREIGN KEY (`permisos_id_permiso`)
    REFERENCES `servi_motriz`.`permisos` (`id_permiso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;