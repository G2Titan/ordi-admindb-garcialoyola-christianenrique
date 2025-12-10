-- Schema (idempotent)
CREATE DATABASE IF NOT EXISTS `mejia_ordi_nombres`;
USE `mejia_ordi_nombres`;

SET @@SESSION.time_zone = '+00:00';

CREATE TABLE IF NOT EXISTS Usuarios (
  id_usuario INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  correo VARCHAR(150) NOT NULL UNIQUE,
  pais VARCHAR(50),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  created_by VARCHAR(100),
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  updated_by VARCHAR(100),
  active BOOLEAN DEFAULT TRUE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Generos (
  id_genero INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  created_by VARCHAR(100),
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  updated_by VARCHAR(100),
  active BOOLEAN DEFAULT TRUE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Artistas (
  id_artista INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  id_genero INT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  created_by VARCHAR(100),
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  updated_by VARCHAR(100),
  active BOOLEAN DEFAULT TRUE,
  CONSTRAINT fk_artistas_genero FOREIGN KEY (id_genero) REFERENCES Generos(id_genero)
    ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Albumes (
  id_album INT AUTO_INCREMENT PRIMARY KEY,
  titulo VARCHAR(100) NOT NULL,
  id_artista INT,
  fecha_lanzamiento DATE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  created_by VARCHAR(100),
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  updated_by VARCHAR(100),
  active BOOLEAN DEFAULT TRUE,
  CONSTRAINT fk_albumes_artista FOREIGN KEY (id_artista) REFERENCES Artistas(id_artista)
    ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Canciones has a CHECK constraint to ensure duration >= 180 seconds (3 minutes)
CREATE TABLE IF NOT EXISTS Canciones (
  id_cancion INT AUTO_INCREMENT PRIMARY KEY,
  titulo VARCHAR(100) NOT NULL,
  id_album INT,
  id_genero INT,
  duracion_segundos INT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  created_by VARCHAR(100),
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  updated_by VARCHAR(100),
  active BOOLEAN DEFAULT TRUE,
  CONSTRAINT chk_duracion CHECK (duracion_segundos >= 180),
  CONSTRAINT fk_canciones_album FOREIGN KEY (id_album) REFERENCES Albumes(id_album)
    ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT fk_canciones_genero FOREIGN KEY (id_genero) REFERENCES Generos(id_genero)
    ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Playlists (
  id_playlist INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  id_usuario INT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  created_by VARCHAR(100),
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  updated_by VARCHAR(100),
  active BOOLEAN DEFAULT TRUE,
  CONSTRAINT fk_playlists_usuario FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS PlaylistCanciones (
  id_playlist INT NOT NULL,
  id_cancion INT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  created_by VARCHAR(100),
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  updated_by VARCHAR(100),
  active BOOLEAN DEFAULT TRUE,
  PRIMARY KEY (id_playlist, id_cancion),
  CONSTRAINT fk_pc_playlist FOREIGN KEY (id_playlist) REFERENCES Playlists(id_playlist)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_pc_cancion FOREIGN KEY (id_cancion) REFERENCES Canciones(id_cancion)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Additional tables to reach richer domain and support reports
CREATE TABLE IF NOT EXISTS Suscripciones (
  id_suscripcion INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT NOT NULL,
  fecha_inicio DATE,
  fecha_fin DATE,
  monto DECIMAL(10,2),
  estado VARCHAR(20), -- activo, cancelado, recontratado
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  created_by VARCHAR(100),
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  updated_by VARCHAR(100),
  active BOOLEAN DEFAULT TRUE,
  CONSTRAINT fk_sus_usuario FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Reproducciones (
  id_reproduccion INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT NOT NULL,
  id_cancion INT NOT NULL,
  fecha_reproduccion DATETIME NOT NULL,
  minutos_listen INT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  created_by VARCHAR(100),
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  updated_by VARCHAR(100),
  active BOOLEAN DEFAULT TRUE,
  CONSTRAINT fk_rep_usuario FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_rep_cancion FOREIGN KEY (id_cancion) REFERENCES Canciones(id_cancion)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Make sure we use InnoDB and proper SQL modes for checks
