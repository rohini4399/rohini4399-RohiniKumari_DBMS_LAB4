create database Lab4;
use Lab4;

-- query1
create table supplier(
SUPP_ID	INT primary key,
SUPP_NAME	varchar(50) NOT NULL,
SUPP_CITY	varchar(50) NOT NULL,
SUPP_PHONE	varchar(50) NOT NULL
);

create table customer(
CUS_ID	INT primary key,
CUS_NAME	VARCHAR(20) NOT NULL,
CUS_PHONE	VARCHAR(10) NOT NULL,
CUS_CITY	VARCHAR(30) NOT NULL,
CUS_GENDER	CHAR);

create table category(
CAT_ID	INT primary key,
CAT_NAME	VARCHAR(20) NOT NULL);

create table product(
PRO_ID	INT primary key,
PRO_NAME	VARCHAR(20) NOT NULL DEFAULT "Dummy",
PRO_DESC	VARCHAR(60),
CAT_ID	INT,
foreign key (CAT_ID) references category(CAT_ID) );

create table supplier_pricing(
PRICING_ID	INT primary key,
PRO_ID	INT ,
SUPP_ID	INT ,
SUPP_PRICE	INT DEFAULT 0,
foreign key (PRO_ID) references product(PRO_ID),
foreign key (SUPP_ID) references supplier(SUPP_ID)
);

create table `order`(
ORD_ID	INT primary key,
ORD_AMOUNT	INT NOT NULL,
ORD_DATE	DATE NOT NULL,
CUS_ID	INT,
PRICING_ID	INT,
foreign key (CUS_ID) references customer(CUS_ID),
foreign key (PRICING_ID) references supplier_pricing(PRICING_ID)
);

create table rating(
RAT_ID	INT primary key,
ORD_ID	INT,
RAT_RATSTARS INT NOT NULL,
foreign key (ORD_ID) references order1(ORD_ID)
);

-- query2
insert into supplier values (1,'Rajesh Retails','Delhi',1234567890);
insert into supplier values (2,'Appario Ltd.','Mumbai',2589631470);
insert into supplier values (3,'Knome products','Banglore',9785462315);
insert into supplier values (4,'Bansal Retails','Kochi',8975463285);
insert into supplier values (5,'Mittal Ltd.','Lucknow',7898456532);

insert into customer values (1,'AAKASH',9999999999,'DELHI','M');
insert into customer values (2,'AMAN',9785463215,'NOIDA','M');
insert into customer values (3,'NEHA',9999999999,'MUMBAI','F');
insert into customer values (4,'MEGHA',9994562399,'KOLKATA','F');
insert into customer values (5,'PULKIT',7895999999,'LUCKNOW','M');

insert into category values (1,'BOOKS');
insert into category values (2,'GAMES');
insert into category values (3,'GROCERIES');
insert into category values (4,'ELECTRONICS');
insert into category values (5,'CLOTHES');

insert into product values (1,'GTA V','Windows 7 and above with i5 processor and 8GB RAM',2);
insert into product values (2,'TSHIRT','SIZE-L with Black, Blue and White variations',5);
insert into product values (3,'ROG LAPTOP','Windows 10 with 15inch screen, i7 processor, 1TB SSD',4);
insert into product values (4,'OATS','Highly Nutritious from Nestle','3');
insert into product values (5,'HARRY POTTER','Best Collection of all time by J.K Rowling',1);
insert into product values (6,'MILK','1L Toned Milk',3);
insert into product values (7,'Boat Earphones','1.5Meter long Dolby Atmos',4);
insert into product values (8,'Jeans','Stretchable Denim Jeans with various sizes and color',5);
insert into product values (9,'Project IGI','compatible with windows 7 and above',2);
insert into product values (10,'Hoodie','Black GUCCI for 13 yrs and above',5);
insert into product values (11,'Rich Dad Poor Dad','Written by RObert Kiyosaki',1);
insert into product values (12,'Train Your Brain','By Shireen Stephen',1);

insert into supplier_pricing values (1,1,2,1500);
insert into supplier_pricing values (2,3,5,30000);
insert into supplier_pricing values (3,5,1,3000);
insert into supplier_pricing values (4,2,3,2500);
insert into supplier_pricing values (5,4,1,1000);

insert into `order` values (101,1500,'2021-10-06',2,1);
insert into `order` values (102,1000,'2021-10-12',3,5);
insert into `order` values (103,30000,'2021-09-16',5,2);
insert into `order` values (104,1500,'2021-10-05',1,1);
insert into `order` values (105,3000,'2021-08-16',4,3);
insert into `order` values (106,1450,'2021-08-18',1,4);
insert into `order` values (107,789,'2021-09-01',3,3);
insert into `order` values (108,780,'2021-09-07',5,1);
insert into `order` values (109,3000,'2021-09-10',5,3);
insert into `order` values (110,2500,'2021-09-10',2,4);
insert into `order` values (111,1000,'2021-09-15',4,5);
insert into `order` values (112,789,'2021-09-16',4,2);
insert into `order` values (113,31000,'2021-09-16',1,3);
insert into `order` values (114,1000,'2021-09-16',3,5);
insert into `order` values (115,3000,'2021-09-16',5,3);
insert into `order` values (116,99,'2021-09-17',2,4);

insert into rating values (1,101,4);
insert into rating values (2,102,3);
insert into rating values (3,103,1);
insert into rating values (4,104,2);
insert into rating values (5,105,4);
insert into rating values (6,106,3);
insert into rating values (7,107,4);
insert into rating values (8,108,4);
insert into rating values (9,109,3);
insert into rating values (10,110,5);
insert into rating values (11,111,3);
insert into rating values (12,112,4);
insert into rating values (13,113,2);
insert into rating values (14,114,1);
insert into rating values (15,115,1);
insert into rating values (16,116,0);

-- query3
select count(t2.cus_gender) as NoOfCustomers, t2.cus_gender from
(select t1.cus_id, t1.cus_gender, t1.ord_amount, t1.cus_name from
(select `order`.*, customer.cus_gender, customer.cus_name from `order` inner join customer where `order`.cus_id=customer.cus_id having `order`.ord_amount>=3000)
as t1) as t2 group by t2.cus_gender;


-- query 4
select `order`.*, product.pro_name from `order`, supplier_pricing,product where `order`.cus_id=2 
and `order`.pricing_id= supplier_pricing.pricing_id 
and supplier_pricing.pro_id=product.pro_id;

-- query5
select supplier.* from supplier where supplier.supp_id in
        	(select supp_id from supplier_pricing group by supp_id having
        	count(supp_id)>1)
group by supplier.supp_id;

-- query6
select category.cat_id,category.cat_name, min(t3.min_price) as Min_Price from category inner join
(select product.cat_id, product.pro_name, t2.* from product inner join 
(select pro_id, min(supp_price) as Min_Price from supplier_pricing group by pro_id)
as t2 where t2.pro_id = product.pro_id)
as t3 where t3.cat_id = category.cat_id group by t3.cat_id;

-- query7
select product.pro_id, product.pro_name from product,supplier_pricing inner join 
(select supplier_pricing.pricing_id,t1.* from supplier_pricing,`order` inner join 
(select `order`.ord_date from `order`,supplier_pricing where `order`.ord_date>='2021-10-05')
as t1 where supplier_pricing.pricing_id=`order`.pricing_id)
as t2 where supplier_pricing.pro_id = product.pro_id group by product.pro_id;

-- query8
select cus_name, cus_gender from customer where cus_name like 'A%' or cus_name like '%A';

-- query9
call lab4.query9();