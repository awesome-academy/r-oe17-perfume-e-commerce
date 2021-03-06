-- MySQL Script generated by MySQL Workbench
-- Thu Apr 11 09:08:31 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema TESTPRODUCT
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema TESTPRODUCT
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `TESTPRODUCT` DEFAULT CHARACTER SET utf8 ;
USE `TESTPRODUCT` ;

-- -----------------------------------------------------
-- Table `TESTPRODUCT`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TESTPRODUCT`.`category` (
  `category_id` INT NOT NULL AUTO_INCREMENT,
  `category_name` NVARCHAR(50) NOT NULL,
  `description` NVARCHAR(300) NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TESTPRODUCT`.`supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TESTPRODUCT`.`supplier` (
  `supplier_id` INT NOT NULL AUTO_INCREMENT,
  `company_name` NVARCHAR(50) NOT NULL,
  `contact_name` NVARCHAR(50) NULL,
  `homepage` VARCHAR(45) NULL,
  `address` NVARCHAR(100) NULL,
  `city` NVARCHAR(30) NULL,
  PRIMARY KEY (`supplier_id`),
  UNIQUE INDEX `supplier_id_UNIQUE` (`supplier_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TESTPRODUCT`.`sense`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TESTPRODUCT`.`sense` (
  `sense_id` INT NOT NULL AUTO_INCREMENT,
  `sense_name` NVARCHAR(45) NOT NULL,
  PRIMARY KEY (`sense_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TESTPRODUCT`.`brand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TESTPRODUCT`.`brand` (
  `brand_id` INT NOT NULL AUTO_INCREMENT,
  `brand_name` VARCHAR(45) NULL,
  `description` NVARCHAR(200) NULL,
  `homepage` VARCHAR(100) NULL,
  `country_name` NVARCHAR(50) NULL,
  PRIMARY KEY (`brand_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TESTPRODUCT`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TESTPRODUCT`.`product` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `name` NVARCHAR(50) NOT NULL,
  `quantity_per_unit` VARCHAR(20) NULL,
  `unit_price` DECIMAL(10,2) NULL,
  `unit_in_stock` SMALLINT(6) NULL,
  `unit_in_order` SMALLINT(6) NULL,
  `discontinue` TINYINT NULL DEFAULT 0,
  `reorderlevel` SMALLINT(6) NULL,
  `category_id` INT NOT NULL,
  `supplier_id` INT NOT NULL,
  `concentration` VARCHAR(50) NULL,
  `product_style` NVARCHAR(50) NULL,
  `sense_id` INT NOT NULL,
  `weight` SMALLINT(6) NULL,
  `description` NVARCHAR(500) NULL,
  `brand_id` INT NOT NULL,
  `picture_url` VARCHAR(100) NULL,
  PRIMARY KEY (`product_id`),
  INDEX `category_id_idx` (`category_id` ASC) VISIBLE,
  INDEX `supplier_id_idx` (`supplier_id` ASC) VISIBLE,
  INDEX `sense_id_idx` (`sense_id` ASC) VISIBLE,
  UNIQUE INDEX `brand_id_UNIQUE` (`brand_id` ASC) VISIBLE,
  CONSTRAINT `category_id`
    FOREIGN KEY (`category_id`)
    REFERENCES `TESTPRODUCT`.`category` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `supplier_id`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `TESTPRODUCT`.`supplier` (`supplier_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sense_id`
    FOREIGN KEY (`sense_id`)
    REFERENCES `TESTPRODUCT`.`sense` (`sense_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_brand_product_id`
    FOREIGN KEY (`brand_id`)
    REFERENCES `TESTPRODUCT`.`brand` (`brand_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TESTPRODUCT`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TESTPRODUCT`.`order` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `order_date` DATETIME NOT NULL,
  `required_date` DATETIME NULL,
  `shipped_date` DATETIME NULL,
  `customer_id` INT NOT NULL,
  `ship_address` NVARCHAR(300) NOT NULL,
  `ship_name` NVARCHAR(50) NOT NULL,
  `ship_city` NVARCHAR(50) NOT NULL,
  PRIMARY KEY (`order_id`),
  UNIQUE INDEX `customer_id_UNIQUE` (`customer_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TESTPRODUCT`.`order_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TESTPRODUCT`.`order_detail` (
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `unit_price` DECIMAL(10,2) NULL,
  `quantity` SMALLINT(2) NULL,
  `discount` DOUBLE(8,0) NULL,
  PRIMARY KEY (`order_id`),
  INDEX `product_id_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `order_id`
    FOREIGN KEY (`order_id`)
    REFERENCES `TESTPRODUCT`.`order` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `product_id`
    FOREIGN KEY (`product_id`)
    REFERENCES `TESTPRODUCT`.`product` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TESTPRODUCT`.`auth_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TESTPRODUCT`.`auth_user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(150) NULL,
  `password` VARCHAR(128) NULL,
  `first_name` NVARCHAR(30) NULL,
  `last_name` NVARCHAR(30) NULL,
  `email` VARCHAR(254) NULL,
  `is_active` TINYINT NULL,
  `date_joined` DATETIME NULL,
  `is_admin` TINYINT NULL,
  `last_login` DATETIME NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TESTPRODUCT`.`auth_role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TESTPRODUCT`.`auth_role` (
  `role_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(150) NULL,
  PRIMARY KEY (`role_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TESTPRODUCT`.`user_role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TESTPRODUCT`.`user_role` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `role_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE,
  UNIQUE INDEX `role_id_UNIQUE` (`role_id` ASC) VISIBLE,
  CONSTRAINT `FK_role_constrant_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `TESTPRODUCT`.`auth_user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_user_constrant_role`
    FOREIGN KEY (`role_id`)
    REFERENCES `TESTPRODUCT`.`auth_role` (`role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
