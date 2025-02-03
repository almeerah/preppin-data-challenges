--Challenge URL: https://preppindata.blogspot.com/2021/01/2021-week-2.html

-- Select all records from the bike_sales table
SELECT * FROM bike_sales;

-- Clean the MODEL column by removing non-alphabetic characters
UPDATE bike_sales
SET MODEL = REGEXP_REPLACE(MODEL, '[^a-zA-Z ]', '', 1, 0, 'c');

-- Add a new column ORDER_VALUE to store the total order value
ALTER TABLE bike_sales
ADD ORDER_VALUE DOUBLE;

-- Add a new column DAYS_TO_SHIP to store the shipping duration
ALTER TABLE bike_sales
ADD DAYS_TO_SHIP INT;

-- Calculate the total order value by multiplying quantity by value per bike
UPDATE bike_sales
SET ORDER_VALUE = QUANTITY * VALUE_PER_BIKE;

-- Calculate the days taken to ship the order
UPDATE bike_sales
SET DAYS_TO_SHIP = DATEDIFF('days', ORDER_DATE, SHIPPING_DATE);

-- Aggregate data by BRAND and BIKE_TYPE to calculate total quantity sold, total order value, and average order value
SELECT
    BRAND, BIKE_TYPE, 
    SUM(QUANTITY) AS QUANTITY_SOLD,
    SUM(ORDER_VALUE) AS ORDER_VALUE,
    AVG(ORDER_VALUE) AS AVG_ORDER_VALUE
FROM
    bike_sales
GROUP BY
    BRAND, BIKE_TYPE;

-- Rename the MODEL column to BRAND for consistency
ALTER TABLE bike_sales
RENAME COLUMN MODEL TO BRAND;

-- Aggregate data by BRAND and STORE to calculate total quantity sold, total order value, and average days to ship
SELECT
    BRAND, STORE, 
    SUM(QUANTITY) AS QUANTITY_SOLD,
    SUM(ORDER_VALUE) AS ORDER_VALUE,
    AVG(DAYS_TO_SHIP) AS AVG_DAYS_TO_SHIP
FROM
    bike_sales
GROUP BY
    BRAND, STORE;
