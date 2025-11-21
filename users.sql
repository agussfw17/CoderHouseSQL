-- Cambiar a la base de datos administrativa
USE mysql;

-- Crear 3 usuarios
CREATE USER 'usuario1'@'localhost' IDENTIFIED BY 'Password123!';
CREATE USER 'usuario2'@'localhost' IDENTIFIED BY 'Password123!';
CREATE USER 'usuario3'@'localhost' IDENTIFIED BY 'Password123!';

-- Dar permisos (por ejemplo, todos los permisos sobre la base GESTIONCLIENTE)
GRANT ALL PRIVILEGES ON GESTIONCLIENTE.* TO 'usuario1'@'localhost';
GRANT ALL PRIVILEGES ON GESTIONCLIENTE.* TO 'usuario2'@'localhost';
GRANT ALL PRIVILEGES ON GESTIONCLIENTE.* TO 'usuario3'@'localhost';

-- Aplicar cambios
FLUSH PRIVILEGES;

-- Verificar usuarios creados
SELECT user, host FROM mysql.user WHERE user IN ('usuario1','usuario2','usuario3');
