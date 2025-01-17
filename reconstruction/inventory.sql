-- Reconstructs the inventory table that was fragmented suppliers wise

CREATE VIEW inventory_s_reconstructed AS
-- Combine the fragments using UNION ALL
SELECT *
FROM (
    SELECT * FROM inventory_supplier_A
    UNION ALL
    SELECT * FROM inventory_supplier_B
    UNION ALL
    SELECT * FROM inventory_supplier_C
    UNION ALL
    SELECT * FROM inventory_supplier_D
    UNION ALL
    SELECT * FROM inventory_supplier_E
) AS combined_inventory;