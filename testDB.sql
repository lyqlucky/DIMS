USE DIMS;

-- AdminMapper
SELECT *
FROM Drug d LEFT OUTER JOIN InventoryDrug i ON d.PDno = i.PDno;

SELECT d.PDno, COALESCE(SUM(i.PDnum), 0)
FROM Drug d LEFT OUTER JOIN InventoryDrug i ON d.PDno = i.PDno
GROUP BY d.PDno;

SELECT PDno, PDbatch, PDnum, Sno, SAno, Stime FROM InventoryDrug
UNION
SELECT PDno, PDbatch, PDnum, Sno, SAno, Stime FROM DestroyedDrug;

-- 统计量少的库存药品种数 countLowInventoryDrugs
SELECT COUNT(*)
FROM (SELECT d.PDno
		FROM Drug d LEFT OUTER JOIN InventoryDrug i ON d.PDno = i.PDno
		GROUP BY d.PDno
		HAVING COALESCE(SUM(i.PDnum), 0) <= 50) Temp;

-- 统计临期库存药品批数 countClose2ExpiryPDbatches
SELECT COUNT(*)
FROM Drug d, InventoryDrug i
WHERE d.PDno = i.PDno AND DATEDIFF(DAY, i.PDbatch, GETDATE()) >= (d.PDlife / 10 * 9);

-- 统计药品种数 countDrugs
SELECT COUNT(*)
FROM Drug;

-- 统计库存药品种数 countInventoryDrugs
SELECT COUNT(*)
FROM (SELECT PDno
		FROM InventoryDrug
		GROUP BY PDno) Temp;

-- 统计销毁药品批数 countDestroyedPDbatches
SELECT COUNT(*)
FROM DestroyedDrug;

-- 统计库存药品批数 countPDbatches
SELECT COUNT(*)
FROM InventoryDrug;

-- DoctorMapper

-- NurseMapper

SELECT d.PDno, d.PDname, d.PDlife, SUM(i.PDnum) AS PDnum
FROM Drug d, InventoryDrug i
WHERE d.PDno = i.PDno
GROUP BY d.PDno, d.PDname, d.PDlife;

SELECT p.Pno, p.Pid, p.Dno, p.Ptime, p.Nno, p.Htime, p.Pstate
FROM Prescription p
WHERE p.Pstate = 0;

SELECT p.Pno, p.Pid, p.Dno, p.Ptime, p.Nno, p.Htime, p.Pstate
FROM Prescription p
WHERE p.Pstate = 1;

