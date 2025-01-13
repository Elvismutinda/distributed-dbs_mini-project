# Mini Project Assignment
- Mutinda Elvis Musau - P15/143051/2021

<br />


Individually or in a group of at most two, create a distributed heterogeneous database environment comprising three sites with three different participating database platforms, and at least two different operating systems.

Use the above environment to demonstrate your grasp of fragmentation and reconstruction. Think of a domain area comprising of at least four distributed relations. Write out your applications/reports and use them to perform fragmentation. Write out the applications/reports into calculus queries. Come up with appropriate query access frequencies of your choice. After working out the fragmentation, allocate the fragments by implementing them physically in the participating databases. Choose one of the sites to be the decision site and perform reconstruction using either views, functions, stored procedures or any other technique.

## Domain - Ecommerce

_The company Soi is an online retailer that sells a variety of products such as clothing, electronics, books, and home appliances.._

| 3 sites | 3 different Database Platforms | at least 2 Operating Systems | addresses |
| --- | --- | --- | --- |
| Machakos (Decision site) | PostgreSQL | Windows | localhost |
| Nairobi  | MySQL | Linux | 24.144.94.53 |
| Makueni | MariaDB | Linux | 146.190.146.117 |


## Global Tables

| Table | Field Description |
| --- | --- |
| category | **id**: Unique identifier<br>**name**: Type of goods dealt with (clothing, electronics, books, etc.)<br> **storehouse**: the storehouse that deals with that category (either Nairobi, Makueni or Machakos)|
| inventory | **id**: Unique identifier for each product<br>**name**: Name of the product<br>**category_id**: Foreign key referencing the id of the category that this product belongs to <br>**description**: Brief description of the product<br>**price**: Price of the product<br>**quantity**: Number of units available for the product<br>**supplier\_id**: Foreign key referencing the id of the supplier who provides the product |
| orders | **id**: Unique identifier for each order<br>**customer\_id**: Foreign key referencing the id of the customer who placed the order<br>**date**: Date of the order<br>**item**: Foreign Key referencing product in Inventories<br>**status**: Status of the order (pending, shipped, delivered, etc.)<br>**total**: Total amount of the order<br>**shipped\_from**: Storehouse where that item is located( either Nairobi, Makueni or Machakos)<br>**shipping\_address**: Shipping address of the order |
| customers | **id**: Unique identifier for each customer<br>**name**: Name of the customer<br>**email**: Email of the customer<br>**password**: Password of the customer<br>**phone**: Phone number of the customer<br>**address**: Address of the customer<br>**orders\_count**: Number of orders placed by the customer |
| suppliers | **id**: Unique identifier for each supplier<br>**name**: Name of the supplier<br>**email**: Email of the supplier<br>**phone**: Phone number of the supplier<br>**address**: Address of the supplier<br>**products\_count**: Number of products provided by the supplier |

### `category` Table


```sql
CREATE TABLE category (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    storehouse VARCHAR(50) NOT NULL
);

INSERT INTO category (id, name, storehouse) VALUES
(1, 'Clothing', 'Nairobi'),
(2, 'Electronics', 'Makueni'),
(3, 'Books', 'Machakos'),
(4, 'Toys', 'Nairobi'),
(5, 'Furniture', 'Makueni');
```

### `suppliers` Table


```sql
CREATE TABLE suppliers (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    products_count INT
);

INSERT INTO suppliers (id, name, email, phone, address, products_count) VALUES
(1, 'Supplier A', 'supplierA@example.com', '111-222-3333', '400 Supplier St', 5),
(2, 'Supplier B', 'supplierB@example.com', '444-555-6666', '500 Supplier St', 3),
(3, 'Supplier C', 'supplierC@example.com', '777-888-9999', '600 Supplier St', 7),
(4, 'Supplier D', 'supplierD@example.com', '999-888-7777', '700 Supplier St', 10),
(5, 'Supplier E', 'supplierE@example.com', '333-555-1111', '800 Supplier St', 8);
```

### `inventory` Table


```sql
CREATE TABLE inventory (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    category_id INT,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    supplier_id INT,
    FOREIGN KEY (category_id) REFERENCES category(id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(id)
);

INSERT INTO inventory (id, name, category_id, description, price, quantity, supplier_id) VALUES
(1, 'T-Shirt', 1, 'Cotton T-Shirt', 19.99, 100, 1),
(2, 'Laptop', 2, 'High-performance laptop', 899.99, 30, 2),
(3, 'Harry Potter Book', 3, 'Fantasy novel', 15.99, 50, 3),
(4, 'Action Figure', 4, 'Superhero action figure', 9.99, 80, 4),
(5, 'Sofa', 5, 'Comfortable sofa', 499.99, 10, 5),
(6, 'Jeans', 1, 'Blue jeans', 29.99, 50, 1),
(7, 'Smartphone', 2, 'Latest smartphone model', 699.99, 20, 2),
(8, 'Cookbook', 3, 'Collection of recipes', 12.99, 40, 3),
(9, 'Board Game', 4, 'Family board game', 24.99, 60, 4),
(10, 'Coffee Table', 5, 'Wooden coffee table', 129.99, 15, 5),
(11, 'Dress', 1, 'Elegant dress', 39.99, 30, 1),
(12, 'Headphones', 2, 'Noise-canceling headphones', 149.99, 25, 2),
(13, 'Mystery Novel', 3, 'Thriller mystery novel', 18.99, 35, 3),
(14, 'Building Blocks', 4, 'Educational building blocks', 14.99, 70, 4),
(15, 'Bed Frame', 5, 'Queen-sized bed frame', 299.99, 8, 5),
(16, 'Polo Shirt', 1, 'Casual polo shirt', 24.99, 40, 1),
(17, 'Tablet', 2, 'Android tablet', 199.99, 15, 2),
(18, 'Science Book', 3, 'Scientific exploration book', 20.99, 25, 3),
(19, 'Puzzle Set', 4, 'Challenging puzzle set', 17.99, 55, 4),
(20, 'Bookshelf', 5, 'Wooden bookshelf', 179.99, 12, 5);
```

### `customers` Table


```sql
CREATE TABLE customers (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    orders_count INT
);

INSERT INTO customers (id, name, email, password, phone, address, orders_count) VALUES
(1, 'John Doe', 'john@example.com', 'password123', '123-456-7890', '101 Main St', 2),
(2, 'Jane Smith', 'jane@example.com', 'pass456', '987-654-3210', '202 Oak St', 1),
(3, 'Bob Johnson', 'bob@example.com', 'secret321', '555-123-4567', '303 Pine St', 3),
(4, 'Alice Brown', 'alice@example.com', 'qwerty', '777-888-1234', '404 Maple St', 2),
(5, 'Charlie Davis', 'charlie@example.com', 'abcdef', '555-999-1111', '505 Cedar St', 4);
```

### `orders` Table


```sql
CREATE TABLE orders (
    id INT PRIMARY KEY,
    customer_id INT,
    date DATE,
    item INT,
    status VARCHAR(20),
    total DECIMAL(10, 2),
    shipped_from VARCHAR(50),
    shipping_address TEXT,
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (item) REFERENCES inventory(id)
);

INSERT INTO orders (id, customer_id, date, item, status, total, shipped_from, shipping_address) VALUES
(1, 1, '2024-01-01', 1, 'Shipped', 199.95, 'Nairobi', '123 Main St, Nairobi'),
(2, 2, '2024-01-02', 3, 'Pending', 31.98, 'Machakos', '456 Oak St, Machakos'),
(3, 3, '2024-01-03', 2, 'Delivered', 899.99, 'Makueni', '789 Pine St, Makueni'),
(4, 4, '2024-01-04', 5, 'Shipped', 649.95, 'Nairobi', '404 Maple St, Nairobi'),
(5, 5, '2024-01-05', 8, 'Pending', 149.99, 'Machakos', '505 Cedar St, Machakos'),
(6, 1, '2024-01-06', 12, 'Delivered', 299.97, 'Nairobi', '123 Main St, Nairobi'),
(7, 2, '2024-01-07', 15, 'Shipped', 2399.92, 'Makueni', '202 Oak St, Makueni'),
(8, 3, '2024-01-08', 18, 'Delivered', 419.85, 'Machakos', '303 Pine St, Machakos'),
(9, 4, '2024-01-09', 20, 'Pending', 359.98, 'Nairobi', '404 Maple St, Nairobi'),
(10, 5, '2024-01-10', 16, 'Shipped', 999.60, 'Makueni', '505 Cedar St, Makueni');
```

## Applications

- Application 1 - Find the name and price of the least ordered product in each store/branch
- Application 2 - Find the email and name of the customers who have ordered more than 10 times
- Application 3 - Find the total number of products in stock for each supplier

### Application 1 - Find the name and price of the cheapest product in each category

Horizontally fragment the products table category wise

Simple predicates → `category`

Category = {Clothing, Electronics, Books, Toys, Furniture}

m1: Category = Clothing <br>
m2: Category = Electronics <br>
m3: Category = Books <br>
m4: Category = Toys <br>
m5: Category = Furniture <br>



```sql
--
-- Makueni
--
SELECT * FROM inventory WHERE category_id = 2; -- Electronics

SELECT * FROM inventory WHERE category_id = 5; -- Furniture


--
-- Nairobi
--
SELECT * FROM inventory WHERE category_id = 1; -- Clothing

SELECT * FROM inventory WHERE category_id = 4; -- Toys


--
-- Machakos
--
SELECT * FROM inventory WHERE category_id = 3; -- Books
```

### Application 2 - Find the email and name of the customers who have ordered more than 3 times

Horizontally fragment the customers table orders wise

Simple predicates → `orders_count` > 3

m1: Orders_count > 3 <br />
m2: Orders_count <= 3



```sql
SELECT * FROM customers WHERE orders_count > 10;

SELECT * FROM customers WHERE orders_count <= 10;
```

### Application 3 - Find the total number of products in stock for each supplier

Horizontally fragment the inventory table supplier wise

Simple predicates → `supplier`

m1: Supplier = Supplier A <br />
m2: Supplier = Supplier B <br />
m3: Supplier = Supplier C <br />
m4: Supplier = Supplier D <br />
m5: Supplier = Supplier E



```sql
SELECT * FROM inventory WHERE supplier_id = 1; -- Supplier A


SELECT * FROM inventory WHERE supplier_id = 2; -- Supplier B


SELECT * FROM inventory WHERE supplier_id = 3; -- Supplier C


SELECT * FROM inventory WHERE supplier_id = 4; -- Supplier D


SELECT * FROM inventory WHERE supplier_id = 5; -- Supplier E
```

## Query Execution Frequencies

|     | Machakos | Nairobi | Makueni | Total |
| --- | -------- | ------- | ------- | ----- |
| Q1  |    0     |   8     | 8       | 16    |
| Q2  |    8     |   10    | 5       | 23    |
| Q3  |    0     |   15    | 7       | 22    |

## Reconstruction

These are the views that have been implemented in the decision site.

### category_cheapest

```sql
CREATE VIEW category_cheapest
AS

-- Create a subquery to get the lowest price for each category
WITH min_price AS (
  SELECT category_id, MIN(price) AS price
  FROM (
    SELECT DISTINCT * FROM inventory_makueni
    UNION ALL
    SELECT DISTINCT * FROM inventory_nairobi
    UNION ALL
    SELECT DISTINCT * FROM inventory_machakos
  ) AS inventory_all
  GROUP BY category_id
)

-- Join the subquery with the fragmented tables to get the name and price of the cheapest product in each category
SELECT i.category_id AS category, i.name AS item, i.price
FROM (
  SELECT DISTINCT * FROM inventory_makueni
  UNION ALL
  SELECT DISTINCT * FROM inventory_nairobi
  UNION ALL
  SELECT DISTINCT * FROM inventory_machakos
) AS i
JOIN min_price AS m
ON i.category_id = m.category_id AND i.price = m.price
ORDER BY i.category_id;
```

### triple_customers

```sql
CREATE VIEW triple_customers
AS
SELECT id, email, name FROM customers_orders_gt_3;
```

### supplier_products

```sql
CREATE VIEW supplier_products
AS
-- Combine the fragments using UNION ALL
WITH combined_inventory AS (
    SELECT * FROM inventory_supplier_A
    UNION ALL
    SELECT * FROM inventory_supplier_B
    UNION ALL
    SELECT * FROM inventory_supplier_C
    UNION ALL
    SELECT * FROM inventory_supplier_D
    UNION ALL
    SELECT * FROM inventory_supplier_E
)

-- Calculate the total quantity for each supplier
SELECT
    'Supplier A' AS supplier,
    SUM(quantity) AS total_products
FROM combined_inventory
WHERE supplier_id = 1

UNION ALL

SELECT
    'Supplier B' AS supplier,
    SUM(quantity) AS total_products
FROM combined_inventory
WHERE supplier_id = 2

UNION ALL

SELECT
    'Supplier C' AS supplier,
    SUM(quantity) AS total_products
FROM combined_inventory
WHERE supplier_id = 3

UNION ALL

SELECT
    'Supplier D' AS supplier,
    SUM(quantity) AS total_products
FROM combined_inventory
WHERE supplier_id = 4

UNION ALL

SELECT
    'Supplier E' AS supplier,
    SUM(quantity) AS total_products
FROM combined_inventory
WHERE supplier_id = 5;
```