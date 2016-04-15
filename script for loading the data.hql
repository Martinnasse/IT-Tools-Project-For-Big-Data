-- ---------------------------------------------------------------------------------------------------
-- HAIDARA Pierre & NASSE Martin 
-- This script is to load all the data 
------------------------------------------------------------------------------------------------------


-- load the data customer
TRUNCATE TABLE data_customer;
LOAD DATA INPATH '/user/cloudera/Data/Customer_20151101.csv' INTO TABLE data_customer;


-- load the data order

LOAD DATA INPATH '/user/cloudera/Data/Order_20151101.csv' INTO TABLE data_order;


-- load the data product_reference
TRUNCATE TABLE data_productref;
LOAD DATA INPATH '/user/cloudera/Data/Product_Reference_20151101.csv' INTO TABLE data_productref;

-- load the data catalogue
TRUNCATE TABLE data_catalogue;
LOAD DATA INPATH '/user/cloudera/Data/Catalogue_20151101.csv' INTO TABLE data_catalogue;


-- load the data data_weather

LOAD DATA INPATH '/user/cloudera/Data/data_weather_20151101.csv' INTO TABLE data_weather;



-- load the data variant
LOAD DATA INPATH '/user/cloudera/Data/Variant.csv' INTO TABLE data_variant;
