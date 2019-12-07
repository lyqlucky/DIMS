USE DIMS;

SELECT d.PDno, d.PDname, d.PDlife, SUM(i.PDnum) AS PDnum
FROM Drug d, InventoryDrug i
WHERE d.PDno = i.PDno
GROUP BY d.PDno, d.PDname, d.PDlife;
