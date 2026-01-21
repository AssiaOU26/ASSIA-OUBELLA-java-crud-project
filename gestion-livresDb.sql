CREATE DATABASE IF NOT EXISTS `gestion-livresDb`
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_general_ci;

USE `gestion-livresDb`;

CREATE TABLE IF NOT EXISTS auteur (
  matricule INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(100) NOT NULL,
  prenom VARCHAR(100) NOT NULL,
  genre ENUM('Masculin','Feminin') NOT NULL
);

CREATE TABLE IF NOT EXISTS livre (
  isbn INT PRIMARY KEY,
  titre VARCHAR(255) NOT NULL,
  description TEXT,
  date_edition DATE,
  editeur ENUM('ENI','DUNOD','FIRST') NOT NULL,
  matricule INT NULL,
  CONSTRAINT fk_livre_auteur
    FOREIGN KEY (matricule) REFERENCES auteur(matricule)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS `user` (
  login VARCHAR(150) PRIMARY KEY,
  password VARCHAR(255) NOT NULL,
  role ENUM('Admin','Visiteur') NOT NULL
);

INSERT IGNORE INTO auteur (matricule, nom, prenom, genre) VALUES
  (1, 'Bennani', 'Laila', 'Feminin'),
  (2, 'El Amrani', 'Youssef', 'Masculin');

INSERT IGNORE INTO `user` (login, password, role) VALUES
  ('admin@demo.com', 'admin123', 'Admin'),
  ('visiteur@demo.com', 'visiteur123', 'Visiteur');
