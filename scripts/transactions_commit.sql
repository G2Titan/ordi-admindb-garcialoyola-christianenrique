USE `mejia_ordi_nombres`;

DROP PROCEDURE IF EXISTS insert_ten_songs_commit;
DELIMITER $$
CREATE PROCEDURE insert_ten_songs_commit()
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    SELECT 'ERROR: transaction rolled back' as status;
  END;

  START TRANSACTION;

  INSERT INTO Canciones (titulo, id_album, id_genero, duracion_segundos, created_by) VALUES
  ('Commit Song 1',1,2,200,'tx'),
  ('Commit Song 2',1,2,210,'tx'),
  ('Commit Song 3',2,1,240,'tx'),
  ('Commit Song 4',2,1,300,'tx'),
  ('Commit Song 5',3,4,360,'tx'),
  ('Commit Song 6',3,4,180,'tx'),
  ('Commit Song 7',4,5,240,'tx'),
  ('Commit Song 8',4,5,200,'tx'),
  ('Commit Song 9',5,3,220,'tx'),
  ('Commit Song 10',5,3,240,'tx');

  COMMIT;
  SELECT 'SUCCESS: transaction committed' as status;
END$$
DELIMITER ;

-- Execute procedure
CALL insert_ten_songs_commit();

-- Cleanup: drop procedure (optional)
DROP PROCEDURE IF EXISTS insert_ten_songs_commit;
