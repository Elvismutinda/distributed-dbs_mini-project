-- Reconstructs the customers table that was fragmented orders wise

CREATE VIEW customers_reconstructed AS
SELECT * 
FROM customers_orders_gt_3
UNION ALL
SELECT * 
FROM customers_orders_lte_3;
