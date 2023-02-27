CREATE DATABASE Lab4;
USE Lab4;

-- query1
CREATE TABLE supplier (
    SUPP_ID INT PRIMARY KEY,
    SUPP_NAME VARCHAR(50) NOT NULL,
    SUPP_CITY VARCHAR(50) NOT NULL,
    SUPP_PHONE VARCHAR(50) NOT NULL
);

CREATE TABLE customer (
    CUS_ID INT PRIMARY KEY,
    CUS_NAME VARCHAR(20) NOT NULL,
    CUS_PHONE VARCHAR(10) NOT NULL,
    CUS_CITY VARCHAR(30) NOT NULL,
    CUS_GENDER CHAR
);

CREATE TABLE category (
    CAT_ID INT PRIMARY KEY,
    CAT_NAME VARCHAR(20) NOT NULL
);

CREATE TABLE product (
    PRO_ID INT PRIMARY KEY,
    PRO_NAME VARCHAR(20) NOT NULL DEFAULT 'Dummy',
    PRO_DESC VARCHAR(60),
    CAT_ID INT,
    FOREIGN KEY (CAT_ID)
        REFERENCES category (CAT_ID)
);

CREATE TABLE supplier_pricing (
    PRICING_ID INT PRIMARY KEY,
    PRO_ID INT,
    SUPP_ID INT,
    SUPP_PRICE INT DEFAULT 0,
    FOREIGN KEY (PRO_ID)
        REFERENCES product (PRO_ID),
    FOREIGN KEY (SUPP_ID)
        REFERENCES supplier (SUPP_ID)
);

CREATE TABLE `order` (
    ORD_ID INT PRIMARY KEY,
    ORD_AMOUNT INT NOT NULL,
    ORD_DATE DATE NOT NULL,
    CUS_ID INT,
    PRICING_ID INT,
    FOREIGN KEY (CUS_ID)
        REFERENCES customer (CUS_ID),
    FOREIGN KEY (PRICING_ID)
        REFERENCES supplier_pricing (PRICING_ID)
);

CREATE TABLE rating (
    RAT_ID INT PRIMARY KEY,
    ORD_ID INT,
    RAT_RATSTARS INT NOT NULL,
    FOREIGN KEY (ORD_ID)
        REFERENCES order1 (ORD_ID)
);

-- query2
INSERT INTO supplier VALUES (1,'Rajesh Retails','Delhi',1234567890);
INSERT INTO supplier VALUES (2,'Appario Ltd.','Mumbai',2589631470);
INSERT INTO supplier VALUES (3,'Knome products','Banglore',9785462315);
INSERT INTO supplier VALUES (4,'Bansal Retails','Kochi',8975463285);
INSERT INTO supplier VALUES (5,'Mittal Ltd.','Lucknow',7898456532);

INSERT INTO customer VALUES (1,'AAKASH',9999999999,'DELHI','M');
INSERT INTO customer VALUES (2,'AMAN',9785463215,'NOIDA','M');
INSERT INTO customer VALUES (3,'NEHA',9999999999,'MUMBAI','F');
INSERT INTO customer VALUES (4,'MEGHA',9994562399,'KOLKATA','F');
INSERT INTO customer VALUES (5,'PULKIT',7895999999,'LUCKNOW','M');

INSERT INTO category VALUES (1,'BOOKS');
INSERT INTO category VALUES (2,'GAMES');
INSERT INTO category VALUES (3,'GROCERIES');
INSERT INTO category VALUES (4,'ELECTRONICS');
INSERT INTO category VALUES (5,'CLOTHES');

INSERT INTO product VALUES (1,'GTA V','Windows 7 and above with i5 processor and 8GB RAM',2);
INSERT INTO product VALUES (2,'TSHIRT','SIZE-L with Black, Blue and White variations',5);
INSERT INTO product VALUES (3,'ROG LAPTOP','Windows 10 with 15inch screen, i7 processor, 1TB SSD',4);
INSERT INTO product VALUES (4,'OATS','Highly Nutritious from Nestle','3');
INSERT INTO product VALUES (5,'HARRY POTTER','Best Collection of all time by J.K Rowling',1);
INSERT INTO product VALUES (6,'MILK','1L Toned Milk',3);
INSERT INTO product VALUES (7,'Boat Earphones','1.5Meter long Dolby Atmos',4);
INSERT INTO product VALUES (8,'Jeans','Stretchable Denim Jeans with various sizes and color',5);
INSERT INTO product VALUES (9,'Project IGI','compatible with windows 7 and above',2);
INSERT INTO product VALUES (10,'Hoodie','Black GUCCI for 13 yrs and above',5);
INSERT INTO product VALUES (11,'Rich Dad Poor Dad','Written by RObert Kiyosaki',1);
INSERT INTO product VALUES (12,'Train Your Brain','By Shireen Stephen',1);

INSERT INTO supplier_pricing VALUES (1,1,2,1500);
INSERT INTO supplier_pricing VALUES (2,3,5,30000);
INSERT INTO supplier_pricing VALUES (3,5,1,3000);
INSERT INTO supplier_pricing VALUES (4,2,3,2500);
INSERT INTO supplier_pricing VALUES (5,4,1,1000);

INSERT INTO `order` VALUES (101,1500,'2021-10-06',2,1);
INSERT INTO `order` VALUES (102,1000,'2021-10-12',3,5);
INSERT INTO `order` VALUES (103,30000,'2021-09-16',5,2);
INSERT INTO `order` VALUES (104,1500,'2021-10-05',1,1);
INSERT INTO `order` VALUES (105,3000,'2021-08-16',4,3);
INSERT INTO `order` VALUES (106,1450,'2021-08-18',1,4);
INSERT INTO `order` VALUES (107,789,'2021-09-01',3,3);
INSERT INTO `order` VALUES (108,780,'2021-09-07',5,1);
INSERT INTO `order` VALUES (109,3000,'2021-09-10',5,3);
INSERT INTO `order` VALUES (110,2500,'2021-09-10',2,4);
INSERT INTO `order` VALUES (111,1000,'2021-09-15',4,5);
INSERT INTO `order` VALUES (112,789,'2021-09-16',4,2);
INSERT INTO `order` VALUES (113,31000,'2021-09-16',1,3);
INSERT INTO `order` VALUES (114,1000,'2021-09-16',3,5);
INSERT INTO `order` VALUES (115,3000,'2021-09-16',5,3);
INSERT INTO `order` VALUES (116,99,'2021-09-17',2,4);

INSERT INTO rating VALUES (1,101,4);
INSERT INTO rating VALUES (2,102,3);
INSERT INTO rating VALUES (3,103,1);
INSERT INTO rating VALUES (4,104,2);
INSERT INTO rating VALUES (5,105,4);
INSERT INTO rating VALUES (6,106,3);
INSERT INTO rating VALUES (7,107,4);
INSERT INTO rating VALUES (8,108,4);
INSERT INTO rating VALUES (9,109,3);
INSERT INTO rating VALUES (10,110,5);
INSERT INTO rating VALUES (11,111,3);
INSERT INTO rating VALUES (12,112,4);
INSERT INTO rating VALUES (13,113,2);
INSERT INTO rating VALUES (14,114,1);
INSERT INTO rating VALUES (15,115,1);
INSERT INTO rating VALUES (16,116,0);

-- query3
SELECT 
    COUNT(t2.cus_gender) AS NoOfCustomers, t2.cus_gender
FROM
    (SELECT 
        t1.cus_id, t1.cus_gender, t1.ord_amount, t1.cus_name
    FROM
        (SELECT 
        `order`.*, customer.cus_gender, customer.cus_name
    FROM
        `order`
    INNER JOIN customer
    WHERE
        `order`.cus_id = customer.cus_id
    HAVING `order`.ord_amount >= 3000) AS t1) AS t2
GROUP BY t2.cus_gender;


-- query 4
SELECT 
    `order`.*, product.pro_name
FROM
    `order`,
    supplier_pricing,
    product
WHERE
    `order`.cus_id = 2
        AND `order`.pricing_id = supplier_pricing.pricing_id
        AND supplier_pricing.pro_id = product.pro_id;

-- query5
SELECT 
    supplier.*
FROM
    supplier
WHERE
    supplier.supp_id IN (SELECT 
            supp_id
        FROM
            supplier_pricing
        GROUP BY supp_id
        HAVING COUNT(supp_id) > 1)
GROUP BY supplier.supp_id;

-- query6
SELECT 
    category.cat_id,
    category.cat_name,
    MIN(t3.min_price) AS Min_Price
FROM
    category
        INNER JOIN
    (SELECT 
        product.cat_id, product.pro_name, t2.*
    FROM
        product
    INNER JOIN (SELECT 
        pro_id, MIN(supp_price) AS Min_Price
    FROM
        supplier_pricing
    GROUP BY pro_id) AS t2
    WHERE
        t2.pro_id = product.pro_id) AS t3
WHERE
    t3.cat_id = category.cat_id
GROUP BY t3.cat_id;

-- query7
SELECT 
    product.pro_id, product.pro_name
FROM
    product,
    supplier_pricing
        INNER JOIN
    (SELECT 
        supplier_pricing.pricing_id, t1.*
    FROM
        supplier_pricing, `order`
    INNER JOIN (SELECT 
        `order`.ord_date
    FROM
        `order`, supplier_pricing
    WHERE
        `order`.ord_date >= '2021-10-05') AS t1
    WHERE
        supplier_pricing.pricing_id = `order`.pricing_id) AS t2
WHERE
    supplier_pricing.pro_id = product.pro_id
GROUP BY product.pro_id;

-- query8
SELECT 
    cus_name, cus_gender
FROM
    customer
WHERE
    cus_name LIKE 'A%' OR cus_name LIKE '%A';

-- query9
CALL lab4.query9();