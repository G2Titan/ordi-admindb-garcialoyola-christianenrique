-- transactions_rollback.sql
-- This script will attempt to insert 10 songs; one of them intentionally violates the CHECK constraint (duracion_segundos >= 180)
-- The EXIT HANDLER will ROLLBACK the whole transaction when an error occurs.
USE `mejia_ordi_nombres`;

DROP PROCEDURE IF EXISTS insert_ten_songs_rollback;
DELIMITER $$
CREATE PROCEDURE insert_ten_songs_rollback()
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    SELECT 'ERROR: transaction rolled back due to invalid duration (one song < 180s)' as status;
  END;

  START TRANSACTION;

  INSERT INTO Canciones (titulo, id_album, id_genero, duracion_segundos, created_by) VALUES
  ('Rollback Song 1',1,2,200,'tx'),
  ('Rollback Song 2',1,2,210,'tx'),
  ('Rollback Song 3',2,1,240,'tx'),
  ('Rollback Song 4',2,1,300,'tx'),
  ('Rollback Song 5',3,4,360,'tx'),
  ('Rollback Song 6',3,4,180,'tx'),
  ('Rollback Song 7',4,5,240,'tx'),
  ('Rollback Song 8',4,5,200,'tx'),
  ('Rollback Song 9',5,3,120,'tx'), -- <-- ERROR: duration 120 < 180 will cause CHECK constraint violation and trigger rollback
  ('Rollback Song 10',5,3,240,'tx');

  COMMIT;
  SELECT 'SUCCESS: transaction committed' as status;
END$$
DELIMITER ;

-- Execute procedure to demonstrate rollback
CALL insert_ten_songs_rollback();

-- Cleanup
DROP PROCEDURE IF EXISTS insert_ten_songs_rollback;
