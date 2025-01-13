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
