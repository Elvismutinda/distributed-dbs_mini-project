-- MYSQL AND MARIADB
CREATE USER 'elvis87'@'%' IDENTIFIED BY 'elvis87';

GRANT ALL PRIVILEGES ON *.* TO 'elvis87'@'%';

DROP USER 'elvis87'@'%';




-- POSTGRES
CREATE USER elvis87 WITH PASSWORD 'elvis87';

GRANT ALL PRIVILEGES ON DATABASE soishop TO elvis87;

DROP USER elvis87;