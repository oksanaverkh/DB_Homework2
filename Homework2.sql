CREATE DATABASE homework2;
USE homework2;

-- 1. Используя операторы языка SQL, создайте табличку “sales”. Заполните ее данными
CREATE TABLE sales (
  ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  OrderDate DATE NOT NULL,
  Bucket VARCHAR(45) NOT NULL
);

INSERT INTO sales (OrderDate, Bucket)
VALUES 
('2017-05-21', 'less than or equal to 100'),
('2017-05-02', '101 to 300'),
('2017-05-03', '101 to 300'),
('2017-05-03', 'greater than 300'),
('2017-05-04', 'less than or equal to 100'),
('2017-05-04', 'greater than 300');

SELECT * FROM sales;


#2. Разделите  значения поля “bucket” на 3 сегмента: меньше 100(“Маленький заказ”),101-300(“Средний заказ”) и больше 300 (“Большой заказ”)
ALTER TABLE sales ADD COLUMN Segment TEXT;
SET SQL_SAFE_UPDATES = 0;

UPDATE sales SET Segment =
CASE
	WHEN Bucket='less than or equal to 100' THEN 'Small order'
	WHEN Bucket='101 to 300' THEN 'Middle order'
	WHEN Bucket='greater than 300' THEN 'Large order'
END;
SELECT * FROM sales;


-- 3. Создайте таблицу “orders”, заполните ее значениями. Покажите “полный” статус заказа, используя оператор CASE
CREATE TABLE orders (
  ID_order INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  employee_id VARCHAR(5) NOT NULL,
  amount INT NOT NULL,
  order_status TEXT NOT NULL
);

INSERT INTO orders (employee_id, amount, order_status)
VALUES 
('emp_1', 15, 'open'),
('emp_1', 205, 'closed'),
('emp_5', 43, 'open'),
('emp_5', 15, 'cancelled'),
('emp_3', 70, 'open'),
('emp_2', 2, 'cancelled'),
('emp_6', 156, 'closed'),
('emp_1', 90, 'cancelled'),
('emp_6', 87, 'closed'),
('emp_5', 139, 'cancelled'),
('emp_2', 15, 'open'),
('emp_4', 23, 'closed');

SELECT * FROM orders;

# Вариант с оператором CASE
SELECT ID_order, order_status,
CASE
	WHEN order_status = 'open' THEN 'Order is in open state'
	WHEN order_status = 'closed' THEN 'Order is closed'
	WHEN order_status = 'cancelled' THEN 'Order is cancelled'
    ELSE 'FAIL'
END
AS order_summary
FROM orders;

# Вариант с IF
SELECT ID_order, order_status,
IF (order_status = 'open', 'Order is in open state', 
IF (order_status = 'closed', 'Order is closed', 
IF(order_status = 'cancelled', 'Order is cancelled', 'ERROR')))
AS order_summary
FROM orders;


