CREATE DATABASE IF NOT EXISTS apim_db character set latin1;
CREATE DATABASE IF NOT EXISTS shared_db;

CREATE USER IF NOT EXISTS 'apimadmin'@'%' IDENTIFIED BY 'apimadmin';
GRANT ALL PRIVILEGES ON apim_db.* TO 'apimadmin'@'%';

CREATE USER IF NOT EXISTS 'sharedadmin'@'%' IDENTIFIED BY 'sharedadmin';
GRANT ALL PRIVILEGES ON shared_db.* TO 'sharedadmin'@'%';

FLUSH PRIVILEGES;
