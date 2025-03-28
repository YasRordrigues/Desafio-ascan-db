#!/bin/bash

echo "Esperando MySQL estar pronto..."
until mysqladmin ping -h "mysql" --silent; do
    sleep 5
done

echo "Conectando ao MySQL e carregando os dados..."
mysql --host=mysql --user=root --password=root --local-infile=1 real_estate <<EOF
SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE '/var/lib/mysql-files/Built_used_area.csv'
INTO TABLE Built_used_area
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/var/lib/mysql-files/Details.csv'
INTO TABLE Details
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/var/lib/mysql-files/Price_changes.csv'
INTO TABLE Price_changes
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;
EOF

echo "Dados carregados com sucesso!"
