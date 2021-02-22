-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema fonasa
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema fonasa
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `fonasa` DEFAULT CHARACTER SET utf8 ;
USE `fonasa` ;

-- -----------------------------------------------------
-- Table `fonasa`.`paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fonasa`.`paciente` (
  `nHistoria` INT NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `edad` INT NULL,
  PRIMARY KEY (`nHistoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fonasa`.`PJoven`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fonasa`.`PJoven` (
  `nHistoriaJ` INT NOT NULL,
  `fumador` INT NOT NULL,
  INDEX `fh_pjoven_paciente_idx` (`nHistoriaJ` ASC) VISIBLE,
  CONSTRAINT `fh_pjoven_paciente`
    FOREIGN KEY (`nHistoriaJ`)
    REFERENCES `fonasa`.`paciente` (`nHistoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fonasa`.`pAnciano`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fonasa`.`pAnciano` (
  `nHistoriaA` INT NOT NULL,
  `Dieta` INT NOT NULL,
  INDEX `fk_pAnciano_Paciente_idx` (`nHistoriaA` ASC) VISIBLE,
  CONSTRAINT `fk_pAnciano_Paciente`
    FOREIGN KEY (`nHistoriaA`)
    REFERENCES `fonasa`.`paciente` (`nHistoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fonasa`.`pNino`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fonasa`.`pNino` (
  `nHistotiaN` INT NOT NULL,
  `relacionPeso` INT NOT NULL,
  INDEX `fk_pNino_Paciente_idx` (`nHistotiaN` ASC) VISIBLE,
  CONSTRAINT `fk_pNino_Paciente`
    FOREIGN KEY (`nHistotiaN`)
    REFERENCES `fonasa`.`paciente` (`nHistoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fonasa`.`salas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fonasa`.`salas` (
  `idsalas` INT NOT NULL AUTO_INCREMENT,
  `cod_Sala` INT NOT NULL,
  `nombre_Sala` VARCHAR(45) NOT NULL,
  `cantidadPersonas` INT NOT NULL,
  UNIQUE INDEX `idsalas_UNIQUE` (`idsalas` ASC) VISIBLE,
  PRIMARY KEY (`cod_Sala`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fonasa`.`consultas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fonasa`.`consultas` (
  `idconsultas` INT NOT NULL AUTO_INCREMENT,
  `nHistoriaConsulta` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `edad` INT NULL,
  `especialista` VARCHAR(45) NOT NULL,
  `tipoAtencion` INT NOT NULL,
  `cod_SalaC` INT NOT NULL,
  PRIMARY KEY (`idconsultas`),
  INDEX `fk_consulta_sala_idx` (`cod_SalaC` ASC) VISIBLE,
  CONSTRAINT `fk_consulta_sala`
    FOREIGN KEY (`cod_SalaC`)
    REFERENCES `fonasa`.`salas` (`cod_Sala`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fonasa`.`atenciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fonasa`.`atenciones` (
  `idatenciones` INT NOT NULL AUTO_INCREMENT,
  `idConsultaA` INT NOT NULL,
  `nHistoria` INT NOT NULL,
  `cos_salaA` INT NOT NULL,
  `fecha` DATETIME NOT NULL,
  `estado` INT NOT NULL,
  PRIMARY KEY (`idatenciones`),
  INDEX `fk_atenciones_consulta_idx` (`idConsultaA` ASC) VISIBLE,
  CONSTRAINT `fk_atenciones_consulta`
    FOREIGN KEY (`idConsultaA`)
    REFERENCES `fonasa`.`consultas` (`idconsultas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fonasa`.`historia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fonasa`.`historia` (
  `idhistoriaClinica` INT NOT NULL AUTO_INCREMENT,
  `idatencionH` INT NOT NULL,
  `nHistoria` INT NOT NULL,
  `diagbostico` VARCHAR(45) NOT NULL,
  `medicamento` VARCHAR(45) NULL,
  `tratamiento` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`idhistoriaClinica`),
  INDEX `fk_atencionHistoria_atencioni_idx` (`idatencionH` ASC) VISIBLE,
  CONSTRAINT `fk_atencionHistoria_atencioni`
    FOREIGN KEY (`idatencionH`)
    REFERENCES `fonasa`.`atenciones` (`idatenciones`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
