-- -------------------------------------------------------------------------------------------------------------------------
-- HAIDARA Pierre & NASSE Martin
-- This script is to create the aggregate 
-- -------------------------------------------------------------------------------------------------------------------------



-- Merge and Insert into intermediate

INSERT INTO TABLE data_customer_intermediate
SELECT a.customerid, d.genderlabel, e.sizes, a.ordercreationdate
FROM data_order a LEFT OUTER JOIN data_customer b ON (a.customerid=b.customerid)
                 LEFT OUTER JOIN data_productref c ON (a.variantid=c.variantid)
                 LEFT OUTER JOIN data_catalogue d ON (c.productcolorid=d.productcolorid)
                 LEFT OUTER JOIN data_variant e ON (a.variantid=e.variantid);


INSERT INTO TABLE data_product_intermediate
SELECT a.productid, b.quantity, b.unitprice, b.customerid
FROM data_productref a JOIN data_order b ON (a.variantid=b.variantid);



-- aggregate for products

TRUNCATE TABLE data_product_final;

INSERT INTO TABLE data_product_final
SELECT productid, COUNT(quantity), SUM(unitprice), COUNT(DISTINCT(customerid))
FROM data_product_intermediate
GROUP BY productid;

-- Aggregate the customers
TRUNCATE TABLE data_customer_final;

INSERT INTO TABLE data_customer_final
select a.customerid, dom_gender.dominant_gender, dom_size.dominant_size, MAX(a.ordercreationdate) 
from data_customer_intermediate a 
 join 
 (select t1.customerid,max(t1.genderlabel) as dominant_gender
  from 
  (select customerid, genderlabel, count(*) as frequency
        from data_customer_intermediate
        group by customerid, genderlabel) t1
  join 
  (select t2.customerid,max(t2.frequency) as max_frequency
  from (select customerid, genderlabel, count(*) as frequency
        from data_customer_intermediate
        group by customerid, genderlabel) t2
  group by t2.customerid) t3 on t3.customerid = t1.customerid and t1.frequency = t3.max_frequency
  group by t1.customerid
  order by customerid) dom_gender ON (a.customerid = dom_gender.customerid)
  join
  (select t1.customerid,max(t1.sizes) as dominant_size
   from 
   (select customerid, sizes, count(*) as frequency
         from data_customer_intermediate
         group by customerid, sizes) t1
    join 
   (select t2.customerid,max(t2.frequency) as max_frequency
   from (select customerid, sizes, count(*) as frequency
         from data_customer_intermediate
         group by customerid, sizes) t2
   group by t2.customerid) t3 
     on t3.customerid = t1.customerid and t1.frequency = t3.max_frequency
   group by t1.customerid
   order by customerid) dom_size ON (a.customerid = dom_size.customerid)
group by a.customerid, dom_gender.dominant_gender, dom_size.dominant_size;
