-- Создаем таблицу "customers"
CREATE TABLE customers (
	customer_id int PRIMARY KEY,
	name varchar,
	email varchar
);

-- Создаем таблицу "products"
CREATE TABLE products (
	product_id int PRIMARY KEY,
	product_name varchar,
	price_per_unit decimal(5, 2)
);

-- Создаем таблицу "orders"
CREATE TABLE orders (
	order_id int PRIMARY KEY,
	order_date date,
	customer_id int,
	product_id int,
	quantity int,
	FOREIGN key (customer_id) REFERENCES customers (customer_id),
	FOREIGN key (product_id) REFERENCES products (product_id)
);

-- Вставляем данные в таблицу "customers" с новыми значениями customer_id
INSERT INTO
	customers (customer_id, name, email)
VALUES
	(101, 'Иван Иванов', 'ivanov@mymail.tu'),
	(102, 'Петр Петров', 'petrov@mymail.tu'),
	(103, 'Максим Максимов', 'maximov@mymail.tu'),
	(104, 'Алексей Алексеев', 'alexeev@mymail.tu');

-- Вставляем данные в таблицу "products"
INSERT INTO
	products (product_id, product_name, price_per_unit)
VALUES
	(1, 'Флешка', 10.00),
	(2, 'Клавиатура', 15.00),
	(3, 'Наушники', 20.00);

-- Вставляем данные в таблицу "orders"
INSERT INTO
	orders (
		order_id,
		order_date,
		customer_id,
		product_id,
		quantity
	)
VALUES
	(1, '2024-05-01', 101, 1, 1),
	(2, '2024-05-01', 102, 2, 1),
	(3, '2024-05-01', 103, 3, 1),
	(4, '2024-05-01', 104, 1, 3),
	(5, '2024-05-01', 101, 2, 1),
	(6, '2024-05-02', 101, 1, 1),
	(7, '2024-05-02', 102, 2, 2),
	(8, '2024-05-02', 103, 3, 1),
	(9, '2024-05-02', 104, 1, 1),
	(10, '2024-05-02', 101, 2, 2),
	(11, '2024-05-03', 101, 1, 1),
	(12, '2024-05-03', 102, 2, 2),
	(13, '2024-05-03', 103, 3, 1),
	(14, '2024-05-03', 104, 1, 4),
	(15, '2024-05-03', 101, 2, 1),
	(16, '2024-05-04', 101, 1, 1),
	(17, '2024-05-04', 102, 2, 1),
	(18, '2024-05-04', 103, 3, 1),
	(19, '2024-05-04', 104, 1, 1),
	(20, '2024-05-04', 101, 2, 1);

SELECT
	p.product_name
FROM
	orders AS o
	LEFT JOIN products AS p ON o.product_id = p.product_id
	LEFT JOIN customers AS c ON o.customer_id = c.customer_id
GROUP BY
	p.product_name
HAVING
	COUNT(DISTINCT c.name) = 1;


SELECT order_id, order_date, quantity,
       ROW_NUMBER() OVER (PARTITION BY order_date ORDER BY quantity DESC) AS row_num
FROM orders;


SELECT o.order_id,
    RANK() OVER (ORDER BY p.price_per_unit DESC) AS order_rank
FROM orders o
JOIN products p ON o.product_id = p.product_id;



