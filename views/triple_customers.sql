CREATE VIEW triple_customers
AS
SELECT id, email, name FROM customers_orders_gt_3;