-- MySQL Script generated by MySQL Workbench
-- Tue May 30 12:20:57 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bikeRental
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bikeRental
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bikeRental` DEFAULT CHARACTER SET utf8 ;
USE `bikeRental` ;

-- -----------------------------------------------------
-- Table `bikeRental`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bikeRental`.`users` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `date_registered` DATETIME NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bikeRental`.`stations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bikeRental`.`stations` (
  `station_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `location` VARCHAR(250) NOT NULL,
  `capacity` INT NOT NULL,
  PRIMARY KEY (`station_id`),
  UNIQUE INDEX `station_id_UNIQUE` (`station_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bikeRental`.`bikes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bikeRental`.`bikes` (
  `bike_id` INT NOT NULL AUTO_INCREMENT,
  `model` VARCHAR(50) NOT NULL,
  `status` VARCHAR(50) NOT NULL,
  `current_station_id` INT NOT NULL,
  PRIMARY KEY (`bike_id`),
  UNIQUE INDEX `bike_id_UNIQUE` (`bike_id` ASC) VISIBLE,
  INDEX `fk_bikes_stations1_idx` (`current_station_id` ASC) VISIBLE,
  CONSTRAINT `fk_bikes_stations1`
    FOREIGN KEY (`current_station_id`)
    REFERENCES `bikeRental`.`stations` (`station_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bikeRental`.`bikeRentals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bikeRental`.`bikeRentals` (
  `rental_id` INT NOT NULL AUTO_INCREMENT,
  `time_start` DATETIME NOT NULL,
  `time_end` DATETIME NOT NULL,
  `cost` DECIMAL(4,2) NOT NULL,
  `user_id` INT NOT NULL,
  `bike_id` INT NOT NULL,
  `station_start_id` INT NOT NULL,
  `station_end_id` INT NOT NULL,
  PRIMARY KEY (`rental_id`),
  UNIQUE INDEX `bike_rental_id_UNIQUE` (`rental_id` ASC) VISIBLE,
  INDEX `fk_bikeRentals_users_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_bikeRentals_bikes1_idx` (`bike_id` ASC) VISIBLE,
  INDEX `fk_bikeRentals_stations1_idx` (`station_start_id` ASC) VISIBLE,
  INDEX `fk_bikeRentals_stations2_idx` (`station_end_id` ASC) VISIBLE,
  CONSTRAINT `fk_bikeRentals_users`
    FOREIGN KEY (`user_id`)
    REFERENCES `bikeRental`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_bikeRentals_bikes`
    FOREIGN KEY (`bike_id`)
    REFERENCES `bikeRental`.`bikes` (`bike_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_bikeRentals_stations_start`
    FOREIGN KEY (`station_start_id`)
    REFERENCES `bikeRental`.`stations` (`station_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_bikeRentals_stations_end`
    FOREIGN KEY (`station_end_id`)
    REFERENCES `bikeRental`.`stations` (`station_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bikeRental`.`passes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bikeRental`.`passes` (
  `pass_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(50) NOT NULL,
  `price` DECIMAL(5,2) NOT NULL,
  `valid_from` DATETIME NOT NULL,
  `valid_to` DATETIME NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`pass_id`),
  INDEX `fk_passes_users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_passes_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `bikeRental`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bikeRental`.`passBikeRentals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bikeRental`.`passBikeRentals` (
  `pass_rental_id` INT NOT NULL,
  `time_start` DATETIME NOT NULL,
  `time_end` DATETIME NOT NULL,
  `pass_id` INT NOT NULL,
  `bikes_bike_id` INT NOT NULL,
  `station_start_id` INT NOT NULL,
  `station_end_id` INT NOT NULL,
  PRIMARY KEY (`pass_rental_id`),
  INDEX `fk_passRentals_passes1_idx` (`pass_id` ASC) VISIBLE,
  UNIQUE INDEX `pass_rental_id_UNIQUE` (`pass_rental_id` ASC) VISIBLE,
  INDEX `fk_passBikeRentals_bikes1_idx` (`bikes_bike_id` ASC) VISIBLE,
  INDEX `fk_passBikeRentals_stations1_idx` (`station_start_id` ASC) VISIBLE,
  INDEX `fk_passBikeRentals_stations2_idx` (`station_end_id` ASC) VISIBLE,
  CONSTRAINT `fk_passRentals_passes`
    FOREIGN KEY (`pass_id`)
    REFERENCES `bikeRental`.`passes` (`pass_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_passBikeRentals_bikes`
    FOREIGN KEY (`bikes_bike_id`)
    REFERENCES `bikeRental`.`bikes` (`bike_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_passBikeRentals_stations1`
    FOREIGN KEY (`station_start_id`)
    REFERENCES `bikeRental`.`stations` (`station_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_passBikeRentals_stations2`
    FOREIGN KEY (`station_end_id`)
    REFERENCES `bikeRental`.`stations` (`station_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bikeRental`.`events`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bikeRental`.`events` (
  `event_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(250) NOT NULL,
  `date` DATETIME NOT NULL,
  `location` VARCHAR(250) NOT NULL,
  `organizer_id` INT NOT NULL,
  PRIMARY KEY (`event_id`),
  UNIQUE INDEX `event_id_UNIQUE` (`event_id` ASC) VISIBLE,
  INDEX `fk_events_users1_idx` (`organizer_id` ASC) VISIBLE,
  CONSTRAINT `fk_events_users1`
    FOREIGN KEY (`organizer_id`)
    REFERENCES `bikeRental`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bikeRental`.`rentalTransactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bikeRental`.`rentalTransactions` (
  `transaction_id` INT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL,
  `amount` DECIMAL(4,2) NOT NULL,
  `type` VARCHAR(50) NOT NULL,
  `user_id` INT NOT NULL,
  `rental_id` INT NOT NULL,
  PRIMARY KEY (`transaction_id`),
  UNIQUE INDEX `transaction_id_UNIQUE` (`transaction_id` ASC) VISIBLE,
  INDEX `fk_rentalTransactions_users1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_rentalTransactions_bikeRentals1_idx` (`rental_id` ASC) VISIBLE,
  CONSTRAINT `fk_rentalTransactions_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `bikeRental`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rentalTransactions_bikeRentals1`
    FOREIGN KEY (`rental_id`)
    REFERENCES `bikeRental`.`bikeRentals` (`rental_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bikeRental`.`passTransactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bikeRental`.`passTransactions` (
  `transaction_id` INT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL,
  `type` VARCHAR(50) NOT NULL,
  `amount` DECIMAL(5,2) NOT NULL,
  `pass_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`transaction_id`),
  UNIQUE INDEX `transaction_id_UNIQUE` (`transaction_id` ASC) VISIBLE,
  INDEX `fk_passTransactions_passes1_idx` (`pass_id` ASC) VISIBLE,
  INDEX `fk_passTransactions_users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_passTransactions_passes1`
    FOREIGN KEY (`pass_id`)
    REFERENCES `bikeRental`.`passes` (`pass_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_passTransactions_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `bikeRental`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bikeRental`.`technicians`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bikeRental`.`technicians` (
  `technician_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `phone_number` VARCHAR(13) NOT NULL,
  `email` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`technician_id`),
  UNIQUE INDEX `technician_id_UNIQUE` (`technician_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bikeRental`.`maintenance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bikeRental`.`maintenance` (
  `maintenance_id` INT NOT NULL AUTO_INCREMENT,
  `date_start` DATETIME NULL,
  `date_end` DATETIME NULL,
  `description` VARCHAR(450) NOT NULL,
  `bike_id` INT NOT NULL,
  `technician_id` INT NOT NULL,
  PRIMARY KEY (`maintenance_id`),
  UNIQUE INDEX `maintenance_id_UNIQUE` (`maintenance_id` ASC) VISIBLE,
  INDEX `fk_maintenance_bikes1_idx` (`bike_id` ASC) VISIBLE,
  INDEX `fk_maintenance_technicians1_idx` (`technician_id` ASC) VISIBLE,
  CONSTRAINT `fk_maintenance_bikes1`
    FOREIGN KEY (`bike_id`)
    REFERENCES `bikeRental`.`bikes` (`bike_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_maintenance_technicians1`
    FOREIGN KEY (`technician_id`)
    REFERENCES `bikeRental`.`technicians` (`technician_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bikeRental`.`feedback`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bikeRental`.`feedback` (
  `feedback_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL,
  `rating` INT NOT NULL,
  `comments` VARCHAR(450) NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`feedback_id`),
  INDEX `fk_feedback_users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_feedback_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `bikeRental`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
