USE DIMS;

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

