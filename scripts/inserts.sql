-- Inserts idempotent: use INSERT ... ON DUPLICATE KEY UPDATE to avoid errors on re-run
USE `mejia_ordi_nombres`;

-- Generos (>=5)
INSERT INTO Generos (id_genero, nombre, created_by) VALUES
(1,'Pop','seed'),
(2,'Rock','seed'),
(3,'Hip-Hop','seed'),
(4,'Jazz','seed'),
(5,'Classical','seed')
ON DUPLICATE KEY UPDATE nombre=VALUES(nombre);

-- Usuarios
INSERT INTO Usuarios (id_usuario, nombre, correo, pais, created_by) VALUES
(1,'Ana Perez','ana.perez@example.com','Mexico','seed'),
(2,'Luis Gomez','luis.gomez@example.com','Peru','seed'),
(3,'Mariana Ruiz','mariana.ruiz@example.com','Colombia','seed'),
(4,'Carlos Lopez','carlos.lopez@example.com','Chile','seed'),
(5,'Sofia Martinez','sofia.martinez@example.com','Argentina','seed')
ON DUPLICATE KEY UPDATE nombre=VALUES(nombre);

-- Artistas
INSERT INTO Artistas (id_artista, nombre, id_genero, created_by) VALUES
(1,'The Sample Band',2,'seed'),
(2,'Pop Star',1,'seed'),
(3,'Jazz Collective',4,'seed'),
(4,'Classical Ensemble',5,'seed'),
(5,'HipHop Crew',3,'seed')
ON DUPLICATE KEY UPDATE nombre=VALUES(nombre);

-- Albumes
INSERT INTO Albumes (id_album, titulo, id_artista, fecha_lanzamiento, created_by) VALUES
(1,'Album One',1,'2020-01-10','seed'),
(2,'Hits 2021',2,'2021-06-15','seed'),
(3,'Jazz Live',3,'2019-09-01','seed'),
(4,'Symphonies',4,'2018-05-20','seed'),
(5,'Urban Beats',5,'2022-03-30','seed')
ON DUPLICATE KEY UPDATE titulo=VALUES(titulo);

-- Canciones (>=5) - durations >= 180
INSERT INTO Canciones (id_cancion, titulo, id_album, id_genero, duracion_segundos, created_by) VALUES
(1,'Song A',1,2,200,'seed'),
(2,'Song B',1,2,240,'seed'),
(3,'Song C',2,1,210,'seed'),
(4,'Song D',3,4,300,'seed'),
(5,'Song E',5,3,180,'seed')
ON DUPLICATE KEY UPDATE titulo=VALUES(titulo);

-- Playlists
INSERT INTO Playlists (id_playlist, nombre, id_usuario, created_by) VALUES
(1,'Favorites',1,'seed'),
(2,'Chill',2,'seed'),
(3,'Workout',3,'seed'),
(4,'Study',4,'seed'),
(5,'Party',5,'seed')
ON DUPLICATE KEY UPDATE nombre=VALUES(nombre);

-- PlaylistCanciones
INSERT INTO PlaylistCanciones (id_playlist, id_cancion, created_by) VALUES
(1,1,'seed'),
(1,2,'seed'),
(2,3,'seed'),
(3,4,'seed'),
(4,5,'seed')
ON DUPLICATE KEY UPDATE updated_at=NOW();

-- Suscripciones (>=5)
INSERT INTO Suscripciones (id_suscripcion, id_usuario, fecha_inicio, fecha_fin, monto, estado, created_by) VALUES
(1,1,'2025-01-01','2025-03-01',9.99,'cancelado','seed'),
(2,1,'2025-04-01','2025-12-31',9.99,'activo','seed'),
(3,2,'2025-02-15','2025-05-15',7.99,'cancelado','seed'),
(4,3,'2025-01-01','2025-12-31',9.99,'activo','seed'),
(5,4,'2025-03-01','2025-07-01',5.00,'cancelado','seed')
ON DUPLICATE KEY UPDATE estado=VALUES(estado);

-- Reproducciones (>=5)
INSERT INTO Reproducciones (id_reproduccion, id_usuario, id_cancion, fecha_reproduccion, minutos_listen, created_by) VALUES
(1,1,1,'2025-02-10 10:00:00',3,'seed'),
(2,1,2,'2025-03-12 12:00:00',4,'seed'),
(3,2,3,'2025-06-01 15:00:00',5,'seed'),
(4,3,4,'2025-07-20 18:00:00',6,'seed'),
(5,1,5,'2025-08-05 09:00:00',3,'seed')
ON DUPLICATE KEY UPDATE minutos_listen=VALUES(minutos_listen);
