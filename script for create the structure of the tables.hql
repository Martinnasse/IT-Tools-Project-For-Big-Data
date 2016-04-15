-- ---------------------------------------------------------------------------------------------------
-- This script is to create the structure of all the tables
------------------------------------------------------------------------------------------------------

-- We start by creating a database project
CREATE DATABASE IF NOT EXISTS project;

use project;


-- structure of the table customer
CREATE TABLE data_customer (customerid INT, domaincode STRING, dob TIMESTAMP, gender STRING, sizes INT)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE;




-- structure of the table order
CREATE TABLE data_order(ordernumber INT, variantid INT, customerid INT, quantity INT, unitprice FLOAT, ordercreationdate TIMESTAMP)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE;




-- structure of the table product_reference
CREATE TABLE data_productref (variantid INT, productcolorid INT, productid INT)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE;



-- structure of the table catalogue
CREATE TABLE data_catalogue (productcolorid INT, genderlabel STRING, suppliercolorlabel STRING, seasonlabel STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE;



-- structure of the table variant
CREATE TABLE data_variant (variantid INT, minsize INT, maxsize INT, sizes STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE;


-- structure of the table weather
CREATE TABLE data_weather (ville STRING, domaincode STRING, longitude DOUBLE, latitude DOUBLE, Date string,Weather DOUBLE, temperature DOUBLE)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE;





-- Creation of the intermediate tables

CREATE TABLE data_customer_intermediate (customerid INT, genderlabel STRING, sizes STRING, ordercreationdate TIMESTAMP)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE;

CREATE TABLE data_product_intermediate (productid INT,quantity INT, unitprice FLOAT, customerid INT)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE;


CREATE TABLE data_customer_final(customerid INT, dominant_genderlabel STRING, dominant_sizes STRING, lastday_purachase TIMESTAMP)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE;

CREATE TABLE data_product_final (productid INT,total_quantity INT, total_amount FLOAT, numberof_customers INT)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE;
