USE master;

IF EXISTS (SELECT *
			FROM sysdatabases
			WHERE name = 'DIMS')
BEGIN
	DROP DATABASE DIMS;
END;

CREATE DATABASE DIMS;

GO

USE DIMS;

CREATE LOGIN dba WITH PASSWORD = 'abcd1234@', DEFAULT_DATABASE = DIMS;

CREATE USER dba FOR LOGIN dba WITH DEFAULT_SCHEMA = dbo;

EXEC sp_addrolemember 'db_owner', 'dba';

CREATE TABLE Admin( -- 库存管理员
	Ano VARCHAR(20) PRIMARY KEY, -- 编号
	Aname VARCHAR(20) NOT NULL, -- 姓名
	Asex BIT NOT NULL DEFAULT 1, -- 性别 (1 为男，0 为女)
	Aage SMALLINT NOT NULL, -- 年龄
	Apwd VARCHAR(20) NOT NULL DEFAULT '00000000' -- 登陆密码
);

CREATE TABLE Doctor( -- 医生
	Dno VARCHAR(20) PRIMARY KEY, -- 编号
	Dname VARCHAR(20) NOT NULL, -- 姓名
	Dsex BIT NOT NULL DEFAULT 1, -- 性别 (1 为男，0 为女)
	Dage SMALLINT NOT NULL, -- 年龄
	Dpwd VARCHAR(20) NOT NULL DEFAULT '00000000' -- 登陆密码
);

CREATE TABLE Nurse( -- 发药处护士
	Nno VARCHAR(20) PRIMARY KEY, -- 编号
	Nname VARCHAR(20) NOT NULL, -- 姓名
	Nsex BIT NOT NULL DEFAULT 1, -- 性别 (1 为男，0 为女)
	Nage SMALLINT NOT NULL, -- 年龄
	Npwd VARCHAR(20) NOT NULL DEFAULT '00000000' -- 登陆密码
);

CREATE TABLE Supplier( -- 供应商
	Sno VARCHAR(20) PRIMARY KEY, -- 编号
	Sname VARCHAR(60) NOT NULL, -- 名称
	Saddr VARCHAR(60) NOT NULL, -- 地址
	Sphone VARCHAR(20) NOT NULL -- 电话
);

CREATE TABLE Drug( -- 药品
	PDno VARCHAR(20) PRIMARY KEY, -- 编号
	PDname VARCHAR(20) NOT NULL, -- 名称
	PDlife SMALLINT NOT NULL -- 保质期 (天数)
);

CREATE TABLE InventoryDrug( -- 库存药品
	PDno VARCHAR(20), -- 编号
	PDbatch DATE, -- 批次
	PDnum SMALLINT NOT NULL, -- 数量
	Sno VARCHAR(20) NOT NULL, -- 供应商编号
	SAno VARCHAR(20) NOT NULL, -- 入库库存管理员编号
	Stime DATETIME NOT NULL DEFAULT GETDATE(), -- 入库时间
	PRIMARY KEY(PDno, PDbatch),
	FOREIGN KEY (PDno) REFERENCES Drug(PDno),
	FOREIGN KEY (Sno) REFERENCES Supplier(Sno),
	FOREIGN KEY (SAno) REFERENCES Admin(Ano)
);

CREATE TABLE DestroyedDrug( -- 已销毁药品
	PDno VARCHAR(20), -- 编号
	PDbatch DATE, -- 批次
	PDnum SMALLINT NOT NULL, -- 数量
	Sno VARCHAR(20) NOT NULL, -- 供应商编号
	SAno VARCHAR(20) NOT NULL, -- 入库库存管理员编号
	Stime DATETIME NOT NULL, -- 入库时间
	DAno VARCHAR(20) NOT NULL, -- 销毁库存管理员编号
	Dtime DATETIME NOT NULL DEFAULT GETDATE(), -- 销毁时间
	PRIMARY KEY(PDno, PDbatch),
	FOREIGN KEY (PDno) REFERENCES Drug(PDno),
	FOREIGN KEY (Sno) REFERENCES Supplier(Sno),
	FOREIGN KEY (SAno) REFERENCES Admin(Ano),
	FOREIGN KEy (DAno) REFERENCES Admin(Ano)
);

CREATE TABLE Prescription( -- 处方
	Pno INT PRIMARY KEY IDENTITY (1, 1), -- 编号
	Pid VARCHAR(20) NOT NULL, -- 病人身份证号码
	Dno VARCHAR(20) NOT NULL, -- 开出医生编号
	Ptime DATETIME NOT NULL, -- 开出时间
	Nno VARCHAR(20), -- 处理护士编号
	Htime DATETIME, -- 处理时间
	Pstate BIT NOT NULL DEFAULT 0, -- 状态 (1 为已处理，0 为未处理)
	FOREIGN KEY (Dno) REFERENCES Doctor(Dno),
	FOREIGN KEY (Nno) REFERENCES Nurse(Nno)
);

CREATE TABLE PID( -- 处方包含的药品
	Pno INT, -- 处方编号
	PDno VARCHAR(20), -- 药品编号
	PDnum SMALLINT NOT NULL, -- 药品数量
	PRIMARY KEY (Pno, PDno),
	FOREIGN KEY (Pno) REFERENCES Prescription(Pno),
	FOREIGN KEY (PDno) REFERENCES Drug(PDno)
);

INSERT INTO Admin(Ano, Aname, Asex, Aage, Apwd) VALUES('admin0001', '李勇', 1, 25, 'admin0001');
INSERT INTO Admin(Ano, Aname, Asex, Aage, Apwd) VALUES('admin0002', '刘晨', 0, 28, 'admin0002');
INSERT INTO Admin(Ano, Aname, Asex, Aage, Apwd) VALUES('admin0003', '王敏', 0, 24, 'admin0003');
INSERT INTO Admin(Ano, Aname, Asex, Aage, Apwd) VALUES('admin0004', '张立', 1, 27, 'admin0004');
INSERT INTO Admin(Ano, Aname, Asex, Aage, Apwd) VALUES('admin0005', '张三', 1, 32, 'admin0005');

INSERT INTO Doctor(Dno, Dname, Dsex, Dage, Dpwd) VALUES('doctor0001', '李四', 1, 39, 'doctor0001');
INSERT INTO Doctor(Dno, Dname, Dsex, Dage, Dpwd) VALUES('doctor0002', '王红', 0, 35, 'doctor0002');
INSERT INTO Doctor(Dno, Dname, Dsex, Dage, Dpwd) VALUES('doctor0003', '何琳', 0, 29, 'doctor0003');
INSERT INTO Doctor(Dno, Dname, Dsex, Dage, Dpwd) VALUES('doctor0004', '李敏', 0, 38, 'doctor0004');
INSERT INTO Doctor(Dno, Dname, Dsex, Dage, Dpwd) VALUES('doctor0005', '张辉', 1, 41, 'doctor0005');

INSERT INTO Nurse(Nno, Nname, Nsex, Nage, Npwd) VALUES('nurse0001', '白磊', 1, 29, 'nurse0001');
INSERT INTO Nurse(Nno, Nname, Nsex, Nage, Npwd) VALUES('nurse0002', '杜鹃', 0, 35, 'nurse0002');
INSERT INTO Nurse(Nno, Nname, Nsex, Nage, Npwd) VALUES('nurse0003', '李强', 1, 32, 'nurse0003');
INSERT INTO Nurse(Nno, Nname, Nsex, Nage, Npwd) VALUES('nurse0004', '张飞', 1, 44, 'nurse0004');
INSERT INTO Nurse(Nno, Nname, Nsex, Nage, Npwd) VALUES('nurse0005', '黎敏', 0, 25, 'nurse0005');

INSERT INTO Supplier(Sno, Sname, Saddr, Sphone)
	VALUES('SYT0001', '遵义市意通医药有限责任公司', '遵义市沙河小区华南C2栋', '17811941621');
INSERT INTO Supplier(Sno, Sname, Saddr, Sphone)
	VALUES('SDS0001', '贵州鼎圣药业有限公司', '遵义市红花岗区沙河路B号楼2楼', '17822557252');
INSERT INTO Supplier(Sno, Sname, Saddr, Sphone)
	VALUES('SGT0001', '贵州国泰医药有限公司', '贵阳市富源北路35号', '17833553673');
INSERT INTO Supplier(Sno, Sname, Saddr, Sphone)
	VALUES('SFT0001', '铜仁梵天药业有限公司', '铜仁市梵净山大道绿福宫小区', '17845457475');
INSERT INTO Supplier(Sno, Sname, Saddr, Sphone)
	VALUES('SKYQD0001', '贵州科渝奇鼎医药有限公司', '贵阳市园林路1号', '17855257965');
INSERT INTO Supplier(Sno, Sname, Saddr, Sphone)
	VALUES('SZX0001', '贵州振兴医药有限公司贵阳分公司', '贵阳市舒家寨富源中路261号', '17867568686');
INSERT INTO Supplier(Sno, Sname, Saddr, Sphone)
	VALUES('SGYKG0001', '国药控股贵州有限公司', '贵阳国家高新技术产业开发区金阳科技产业园', '17837785477');
INSERT INTO Supplier(Sno, Sname, Saddr, Sphone)
	VALUES('SXZT0001', '铜仁新中太药业有限公司', '铜仁市文笔路25号', '17880257080');
INSERT INTO Supplier(Sno, Sname, Saddr, Sphone)
	VALUES('SYC0001', '贵州省药材公司', '贵阳市富源北路22号A区', '17859030598');

INSERT INTO Drug(PDno, PDname, PDlife) VALUES('H31020838', '阿莫西林胶囊', 180);
INSERT INTO Drug(PDno, PDname, PDlife) VALUES('H20043730', '氨苄西林钠', 120);
INSERT INTO Drug(PDno, PDname, PDlife) VALUES('H32021306', '青霉素钠', 90);
INSERT INTO Drug(PDno, PDname, PDlife) VALUES('H19993751', '磷霉素钠', 360);
INSERT INTO Drug(PDno, PDname, PDlife) VALUES('H15021340', '头孢氨苄甲氧苄啶胶囊', 270);
INSERT INTO Drug(PDno, PDname, PDlife) VALUES('H31020892', '头孢拉定胶囊', 120);
INSERT INTO Drug(PDno, PDname, PDlife) VALUES('H10910034', '头孢曲松钠', 90);
INSERT INTO Drug(PDno, PDname, PDlife) VALUES('H20153143', '头孢吡肟', 180);
INSERT INTO Drug(PDno, PDname, PDlife) VALUES('H20023788', '头孢噻肟钠', 480);
INSERT INTO Drug(PDno, PDname, PDlife) VALUES('Z20054523', '骨筋丸胶囊', 180);
INSERT INTO Drug(PDno, PDname, PDlife) VALUES('Z51020341', '复方穿心莲片', 360);
INSERT INTO Drug(PDno, PDname, PDlife) VALUES('Z20083397', '四季感冒片', 360);
INSERT INTO Drug(PDno, PDname, PDlife) VALUES('Z34020775', '午时茶颗粒', 360);
INSERT INTO Drug(PDno, PDname, PDlife) VALUES('Z63020270', '十三味马钱子丸', 720);
INSERT INTO Drug(PDno, PDname, PDlife) VALUES('H41024386', '氯芬黄敏片', 540);
INSERT INTO Drug(PDno, PDname, PDlife) VALUES('Z20025728', '痫愈胶囊', 360);

INSERT INTO InventoryDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime)
	VALUES('H31020838', '2019-06-20', 15, 'SYT0001', 'admin0001', '2019-06-25 10:30:30.000');
INSERT INTO InventoryDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime)
	VALUES('H20043730', '2019-08-18', 32, 'SDS0001', 'admin0001', '2019-08-25 10:28:23.000');
INSERT INTO InventoryDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime)
	VALUES('H32021306', '2019-09-30', 180, 'SGT0001', 'admin0002', '2019-10-10 15:05:26.000');
INSERT INTO InventoryDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime)
	VALUES('H19993751', '2019-06-01', 280, 'SFT0001', 'admin0002', '2019-06-10 16:45:39.000');
INSERT INTO InventoryDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime)
	VALUES('H15021340', '2019-03-15', 5, 'SKYQD0001', 'admin0003', '2019-03-25 09:16:30.000');
INSERT INTO InventoryDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime)
	VALUES('H31020892', '2019-09-01', 50, 'SZX0001', 'admin0003', '2019-09-10 10:30:30.000');
INSERT INTO InventoryDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime)
	VALUES('H10910034', '2019-10-08', 50, 'SGYKG0001', 'admin0004', '2019-10-11 10:36:55.000');
INSERT INTO InventoryDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime)
	VALUES('H20153143', '2019-11-05', 245, 'SXZT0001', 'admin0004', '2019-11-09 14:29:16.000');
INSERT INTO InventoryDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime)
	VALUES('H20023788', '2019-11-21', 165, 'SYC0001', 'admin0005', '2019-11-25 11:53:55.000');
INSERT INTO InventoryDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime)
	VALUES('H31020838', '2019-11-25', 270, 'SKYQD0001', 'admin0002', '2019-11-30 13:59:53.000');
INSERT INTO InventoryDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime)
	VALUES('H20043730', '2019-11-27', 500, 'SFT0001', 'admin0003', '2019-11-30 15:25:22.000');

INSERT INTO DestroyedDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime, DAno, Dtime)
	VALUES('H20023788', '2018-06-10', 5, 'SYC0001', 'admin0005', '2018-06-25 10:30:30.000',
														'admin0001', '2019-09-30 15:22:16.000');
INSERT INTO DestroyedDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime, DAno, Dtime)
	VALUES('H20153143', '2018-08-18', 7, 'SXZT0001', 'admin0005', '2018-08-25 10:28:23.000',
														'admin0002', '2019-02-06 16:13:43.000');
INSERT INTO DestroyedDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime, DAno, Dtime)
	VALUES('H10910034', '2018-09-30', 13, 'SGYKG0001', 'admin0004', '2018-10-10 15:05:26.000',
														'admin0001', '2018-12-24 09:16:55.000');
INSERT INTO DestroyedDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime, DAno, Dtime)
	VALUES('H31020892', '2018-06-01', 9, 'SZX0001', 'admin0004', '2018-06-10 16:45:39.000',
														'admin0004', '2018-09-24 13:59:15.000');
INSERT INTO DestroyedDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime, DAno, Dtime)
	VALUES('H15021340', '2018-03-15', 15, 'SKYQD0001', 'admin0003', '2018-03-25 09:16:30.000',
														'admin0001', '2018-12-05 11:05:06.000');
INSERT INTO DestroyedDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime, DAno, Dtime)
	VALUES('H19993751', '2018-06-01', 3, 'SFT0001', 'admin0003', '2018-06-10 10:30:30.000',
														'admin0001', '2019-05-10 16:17:05.000');
INSERT INTO DestroyedDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime, DAno, Dtime)
	VALUES('H32021306', '2018-10-08', 5, 'SGT0001', 'admin0002', '2018-10-11 10:36:55.000',
														'admin0005', '2019-01-02 12:05:53.000');
INSERT INTO DestroyedDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime, DAno, Dtime)
	VALUES('H20043730', '2018-11-05', 7, 'SDS0001', 'admin0002', '2018-11-09 14:29:16.000',
														'admin0003', '2019-02-26 10:59:05.000');
INSERT INTO DestroyedDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime, DAno, Dtime)
	VALUES('H31020838', '2018-11-21', 17, 'SYT0001', 'admin0001', '2018-11-25 11:53:55.000',
														'admin0002', '2019-05-05 15:15:29.000');

INSERT INTO Prescription(Pid, Dno, Ptime, Nno, Htime, Pstate)
	VALUES('44019901023', 'doctor0001', '2019-12-01 09:05:10.000', 'nurse0002', '2019-12-01 09:25:13.000', 1);
INSERT INTO Prescription(Pid, Dno, Ptime, Nno, Htime, Pstate)
	VALUES('44019981102', 'doctor0002', '2019-12-01 09:22:19.000', 'nurse0003', '2019-12-01 09:28:33.000', 1);
INSERT INTO Prescription(Pid, Dno, Ptime, Nno, Htime, Pstate)
	VALUES('44019971206', 'doctor0003', '2019-12-01 09:35:17.000', 'nurse0005', '2019-12-01 09:45:19.000', 1);
INSERT INTO Prescription(Pid, Dno, Ptime, Nno, Htime, Pstate)
	VALUES('44019810516', 'doctor0004', '2019-12-01 09:55:10.000', 'nurse0004', '2019-12-01 10:05:52.000', 1);
INSERT INTO Prescription(Pid, Dno, Ptime, Nno, Htime, Pstate)
	VALUES('44019760215', 'doctor0005', '2019-12-01 10:05:59.000', 'nurse0001', '2019-12-01 10:25:33.000', 1);
INSERT INTO Prescription(Pid, Dno, Ptime, Nno, Htime, Pstate)
	VALUES('44019950916', 'doctor0004', '2019-12-01 10:55:18.000', 'nurse0002', '2019-12-01 11:05:46.000', 1);
INSERT INTO Prescription(Pid, Dno, Ptime, Nno, Htime, Pstate)
	VALUES('44019910416', 'doctor0003', '2019-12-01 15:19:35.000', NULL, NULL, 0);
INSERT INTO Prescription(Pid, Dno, Ptime, Nno, Htime, Pstate)
	VALUES('44019970730', 'doctor0002', '2019-12-01 15:27:45.000', NULL, NULL, 0);
INSERT INTO Prescription(Pid, Dno, Ptime, Nno, Htime, Pstate)
	VALUES('44019921016', 'doctor0001', '2019-12-01 15:35:16.000', NULL, NULL, 0);

INSERT INTO PID(Pno, PDno, PDnum) VALUES(1, 'H31020838', 2);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(1, 'H32021306', 2);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(1, 'Z20025728', 4);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(1, 'Z51020341', 4);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(2, 'H15021340', 3);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(2, 'Z34020775', 3);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(2, 'Z20054523', 3);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(3, 'H10910034', 2);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(3, 'H20153143', 2);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(3, 'H20023788', 3);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(4, 'H20043730', 5);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(4, 'H32021306', 4);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(5, 'H20043730', 4);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(5, 'H32021306', 3);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(5, 'H15021340', 3);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(5, 'H10910034', 7);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(5, 'H20023788', 2);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(6, 'H20043730', 2);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(6, 'H19993751', 1);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(7, 'Z63020270', 4);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(7, 'Z51020341', 2);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(7, 'Z20054523', 2);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(7, 'H19993751', 4);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(8, 'H31020892', 3);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(8, 'H20153143', 3);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(8, 'H20023788', 2);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(9, 'Z51020341', 1);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(9, 'Z20083397', 7);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(9, 'H31020838', 1);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(9, 'H41024386', 7);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(9, 'Z20025728', 1);
