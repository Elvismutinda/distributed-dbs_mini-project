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
