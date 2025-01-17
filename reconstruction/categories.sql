-- Reconstructs the inventory table that was fragmented category wise

CREATE VIEW inventory_c_reconstructed AS
-- Combine the fragments using UNION ALL
SELECT DISTINCT * 
FROM inventory_makueni
UNION ALL
SELECT DISTINCT * 
FROM inventory_nairobi
UNION ALL
SELECT DISTINCT * 
FROM inventory_machakos;