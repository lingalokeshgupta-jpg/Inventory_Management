create database inventory;

use inventory;
--                            TABLES

create table suppliers(
suppliers_id int auto_increment primary key,
suppliers_name varchar(100),
contact_number int
);

create table products(
product_id int auto_increment primary key,
product_name varchar(100),
price decimal(10,2),
quantity int,
suppliers_id int,
foreign key (suppliers_id) references suppliers(suppliers_id)
);

create table orders(
order_id int auto_increment primary key,
product_id int,
product_name varchar(100),
quantity_ordered INT,
order_date DATE default (current_date),
FOREIGN KEY (product_id) REFERENCES products(product_id)
);

--                              INSERTING VALUES INTO TABLES

insert into suppliers(suppliers_name, contact_num)
values
('tulasi_industries', '9635897890'),
('guru_traders', '6548520356'),
('srinivas_traders',' 8529517530'),
('ks_supplies', '7549568522');

insert into products(product_name, price, quantity, suppliers_id)
values
('heartiva oil', 168.00, 160, 1),
('tasty gold oil pch', 144.00, 192, 1),
('tasty gold oil tin', 2125.00, 13, 1),
('gold drop pch', 170.00, 208, 2),
('gold drop tin', 2600.00, 10, 2),
('freedom pch', 172.00, 176, 2),
('freedom tin', 2620.00, 10, 2),
('super gold oil', 2200.00, 15,3),
('sunflower oil', 2400.00, 20, 3),
('vijay gn', 168.00, 64, 4),
('vijay plm', 125.00, 80, 4);
select * from products;

insert into orders(product_id, product_name, quantity_ordered)
values
(1, 'heartiva oil', 18),
(3, 'tast gold oil tin', 2),
(5, 'gold drop tin', 2);

--                         TRIGGERS


DELIMITER $$
CREATE TRIGGER reduce_stock_after_order
AFTER INSERT ON orders
FOR EACH ROW
BEGIN 
	UPDATE products
    SET quantity = quantity - new.quantity_ordered
    where product_id = new.product_id;
END $$
DELIMITER ;

--                      STORED PROCEDURES

--                     FOR ORDERS
DELIMITER $$
create procedure order_lite(

	in o_product_id int,
    in o_product_name varchar(100),
	in o_quantity_ordered int
)
begin 
	insert into orders (product_id,product_name,quantity_ordered) 
    values (o_product_id,o_product_name,o_quantity_ordered);
end $$
DELIMITER ;
    
--                     FOR PRODUCTS ENTRY
DELIMITER $$
CREATE PROCEDURE enter_inventory_products(
	IN p_product_name VARCHAR(100),
    IN p_price DECIMAL,
    IN p_quantity INT,
    IN p_suppliers_id INT
)
BEGIN
    INSERT INTO products(product_name, price, quantity, suppliers_id)
    VALUES (p_product_name, p_price, p_quantity, p_suppliers_id);
END $$
DELIMITER ;


--  					FOR UPDATING THE QUANTITY OF PRODUCTS
drop procedure if exists update_products;
DELIMITER $$
CREATE PROCEDURE update_products(
	   IN p_id INT,
    IN new_quantity INT
)
BEGIN 
    UPDATE products
    SET quantity = quantity + new_quantity
    WHERE product_id = p_id;
END $$
DELIMITER ;


--                      FOR UPDATING THE PRICE OF PRODUCTS  
DELIMITER $$
CREATE PROCEDURE update_price(
	IN p_id INT,
	IN p_new_price DECIMAL
)
BEGIN 
	UPDATE products 
    SET price = p_new_price
    WHERE product_id = p_id;
END $$
DELIMITER ;

--                        FOR ADDING NEW SUPPLIER 
DELIMITER $$
CREATE PROCEDURE new_suppliers(
	IN s_supplier_name VARCHAR(100),
    IN s_contact_num VARCHAR(100)
)
BEGIN 
	INSERT INTO suppliers(suppliers_name, contact_num)
    values (s_supplier_name, s_contact_num );
END $$
DELIMITER ;
    
--                                  VIEWS


CREATE VIEW inventory_value as 
SELECT product_name, quantity, (price * quantity) as total_valued
FROM products;

CREATE VIEW grand_inventory_value as 
SELECT  sum(price * quantity) as grand_value
FROM products

CREATE VIEW products_available as
SELECT product_id, product_name, price
FROM products
order by product_name;

CREATE VIEW sales_as_per_product as
SELECT o.product_name, o.quantity_ordered, p.price, (p.price * o.quantity_ordered) as total_valued, o.order_date
from orders o
join products p on o.product_id = p.product_id;

CREATE VIEW grand_sales as
SELECT SUM(total_valued) as grand_sales
FROM (SELECT p.price * o.quantity_ordered as total_valued 
    FROM orders o 
    JOIN products p ON o.product_id = p.product_id) as grand;    
    


