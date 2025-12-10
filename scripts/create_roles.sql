-- Create DB users / roles (idempotent)
USE `mejia_ordi_nombres`;

-- Admin user: full privileges on the database
CREATE USER IF NOT EXISTS 'admin_user'@'%' IDENTIFIED BY 'AdminPass123!';
GRANT ALL PRIVILEGES ON `mejia_ordi_nombres`.* TO 'admin_user'@'%';

-- Auditor: write and read (SELECT, INSERT, UPDATE)
CREATE USER IF NOT EXISTS 'auditor_user'@'%' IDENTIFIED BY 'AuditorPass123!';
GRANT SELECT, INSERT, UPDATE ON `mejia_ordi_nombres`.* TO 'auditor_user'@'%';

-- Programador: read-only
CREATE USER IF NOT EXISTS 'programador_user'@'%' IDENTIFIED BY 'ProgPass123!';
GRANT SELECT ON `mejia_ordi_nombres`.* TO 'programador_user'@'%';

FLUSH PRIVILEGES;
