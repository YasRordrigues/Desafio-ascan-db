CREATE DATABASE IF NOT EXISTS real_estate;
USE real_estate;

CREATE TABLE Built_used_area (
    listing_id INT PRIMARY KEY,
    built_area FLOAT,
    used_area FLOAT
);

CREATE TABLE Details (
    listing_id INT PRIMARY KEY,
    details TEXT
);

CREATE TABLE Price_changes (
    listing_id INT,
    old_price FLOAT,
    new_price FLOAT,
    change_date DATE,
    details TEXT,
    PRIMARY KEY (listing_id, change_date)
);
