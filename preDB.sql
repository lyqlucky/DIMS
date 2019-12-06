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

INSERT INTO Admin(Ano, Aname, Asex, Aage, Apwd) VALUES('admin1111', '李勇', 1, 25, 'admin1111');
INSERT INTO Admin(Ano, Aname, Asex, Aage, Apwd) VALUES('admin2222', '刘晨', 0, 28, 'admin2222');
INSERT INTO Admin(Ano, Aname, Asex, Aage, Apwd) VALUES('admin3333', '王敏', 0, 24, 'admin3333');
INSERT INTO Admin(Ano, Aname, Asex, Aage, Apwd) VALUES('admin4444', '张立', 1, 27, 'admin4444');
INSERT INTO Admin(Ano, Aname, Asex, Aage, Apwd) VALUES('admin5555', '张三', 1, 32, 'admin5555');

INSERT INTO Doctor(Dno, Dname, Dsex, Dage, Dpwd) VALUES('doctor1111', '李四', 1, 39, 'doctor1111');
INSERT INTO Doctor(Dno, Dname, Dsex, Dage, Dpwd) VALUES('doctor2222', '王红', 0, 35, 'doctor2222');
INSERT INTO Doctor(Dno, Dname, Dsex, Dage, Dpwd) VALUES('doctor3333', '何琳', 0, 29, 'doctor3333');
INSERT INTO Doctor(Dno, Dname, Dsex, Dage, Dpwd) VALUES('doctor4444', '李敏', 0, 38, 'doctor4444');
INSERT INTO Doctor(Dno, Dname, Dsex, Dage, Dpwd) VALUES('doctor5555', '张辉', 1, 41, 'doctor5555');

INSERT INTO Nurse(Nno, Nname, Nsex, Nage, Npwd) VALUES('nurse1111', '白磊', 1, 29, 'nurse1111');
INSERT INTO Nurse(Nno, Nname, Nsex, Nage, Npwd) VALUES('nurse2222', '杜鹃', 0, 35, 'nurse2222');
INSERT INTO Nurse(Nno, Nname, Nsex, Nage, Npwd) VALUES('nurse3333', '李强', 1, 32, 'nurse3333');
INSERT INTO Nurse(Nno, Nname, Nsex, Nage, Npwd) VALUES('nurse4444', '张飞', 1, 44, 'nurse4444');
INSERT INTO Nurse(Nno, Nname, Nsex, Nage, Npwd) VALUES('nurse5555', '黎敏', 0, 25, 'nurse5555');

INSERT INTO Supplier(Sno, Sname, Saddr, Sphone)
	VALUES('supplier1111', '遵义市意通医药有限责任公司', '遵义市沙河小区华南C2栋', '17811111111');
INSERT INTO Supplier(Sno, Sname, Saddr, Sphone)
	VALUES('supplier2222', '贵州鼎圣药业有限公司', '遵义市红花岗区沙河路B号楼2楼', '17822222222');
INSERT INTO Supplier(Sno, Sname, Saddr, Sphone)
	VALUES('supplier3333', '贵州国泰医药有限公司', '贵阳市富源北路35号', '17833333333');
INSERT INTO Supplier(Sno, Sname, Saddr, Sphone)
	VALUES('supplier4444', '铜仁梵天药业有限公司', '铜仁市梵净山大道绿福宫小区', '17844444444');
INSERT INTO Supplier(Sno, Sname, Saddr, Sphone)
	VALUES('supplier5555', '贵州科渝奇鼎医药有限公司', '贵阳市园林路1号', '17855555555');
INSERT INTO Supplier(Sno, Sname, Saddr, Sphone)
	VALUES('supplier6666', '贵州振兴医药有限公司贵阳分公司', '贵阳市舒家寨富源中路261号', '17866666666');
INSERT INTO Supplier(Sno, Sname, Saddr, Sphone)
	VALUES('supplier7777', '国药控股贵州有限公司', '贵阳国家高新技术产业开发区金阳科技产业园', '17877777777');
INSERT INTO Supplier(Sno, Sname, Saddr, Sphone)
	VALUES('supplier8888', '铜仁新中太药业有限公司', '铜仁市文笔路25号', '17888888888');
INSERT INTO Supplier(Sno, Sname, Saddr, Sphone)
	VALUES('supplier9999', '贵州省药材公司', '贵阳市富源北路22号A区', '17899999999');

INSERT INTO Drug(PDno, PDname, PDlife) VALUES('drug1111', '阿莫西林胶囊', 180);
INSERT INTO Drug(PDno, PDname, PDlife) VALUES('drug2222', '氨苄西林钠', 120);
INSERT INTO Drug(PDno, PDname, PDlife) VALUES('drug3333', '青霉素钠', 90);
INSERT INTO Drug(PDno, PDname, PDlife) VALUES('drug4444', '磷霉素钠', 360);
INSERT INTO Drug(PDno, PDname, PDlife) VALUES('drug5555', '头孢氨苄甲氧苄啶胶囊', 270);
INSERT INTO Drug(PDno, PDname, PDlife) VALUES('drug6666', '头孢拉定胶囊', 120);
INSERT INTO Drug(PDno, PDname, PDlife) VALUES('drug7777', '头孢曲松钠', 90);
INSERT INTO Drug(PDno, PDname, PDlife) VALUES('drug8888', '头孢吡肟', 180);
INSERT INTO Drug(PDno, PDname, PDlife) VALUES('drug9999', '头孢噻肟钠', 480);

INSERT INTO InventoryDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime)
	VALUES('drug1111', '2019-06-20', 15, 'supplier1111', 'admin1111', '2019-06-25 10:30:30.000');
INSERT INTO InventoryDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime)
	VALUES('drug2222', '2019-08-18', 32, 'supplier2222', 'admin1111', '2019-08-25 10:28:23.000');
INSERT INTO InventoryDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime)
	VALUES('drug3333', '2019-09-30', 180, 'supplier3333', 'admin2222', '2019-10-10 15:05:26.000');
INSERT INTO InventoryDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime)
	VALUES('drug4444', '2019-06-01', 280, 'supplier4444', 'admin2222', '2019-06-10 16:45:39.000');
INSERT INTO InventoryDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime)
	VALUES('drug5555', '2019-03-15', 5, 'supplier5555', 'admin3333', '2019-03-25 09:16:30.000');
INSERT INTO InventoryDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime)
	VALUES('drug6666', '2019-09-01', 50, 'supplier6666', 'admin3333', '2019-09-10 10:30:30.000');
INSERT INTO InventoryDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime)
	VALUES('drug7777', '2019-10-08', 50, 'supplier7777', 'admin4444', '2019-10-11 10:36:55.000');
INSERT INTO InventoryDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime)
	VALUES('drug8888', '2019-11-05', 245, 'supplier8888', 'admin4444', '2019-11-09 14:29:16.000');
INSERT INTO InventoryDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime)
	VALUES('drug9999', '2019-11-21', 165, 'supplier9999', 'admin5555', '2019-11-25 11:53:55.000');
INSERT INTO InventoryDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime)
	VALUES('drug1111', '2019-11-25', 270, 'supplier5555', 'admin2222', '2019-11-30 13:59:53.000');
INSERT INTO InventoryDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime)
	VALUES('drug2222', '2019-11-27', 500, 'supplier4444', 'admin3333', '2019-11-30 15:25:22.000');

INSERT INTO DestroyedDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime, DAno, Dtime)
	VALUES('drug9999', '2018-06-10', 5, 'supplier9999', 'admin5555', '2018-06-25 10:30:30.000',
														'admin1111', '2019-09-30 15:22:16.000');
INSERT INTO DestroyedDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime, DAno, Dtime)
	VALUES('drug8888', '2018-08-18', 7, 'supplier8888', 'admin5555', '2018-08-25 10:28:23.000',
														'admin2222', '2019-02-06 16:13:43.000');
INSERT INTO DestroyedDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime, DAno, Dtime)
	VALUES('drug7777', '2018-09-30', 13, 'supplier7777', 'admin4444', '2018-10-10 15:05:26.000',
														'admin1111', '2018-12-24 09:16:55.000');
INSERT INTO DestroyedDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime, DAno, Dtime)
	VALUES('drug6666', '2018-06-01', 9, 'supplier6666', 'admin4444', '2018-06-10 16:45:39.000',
														'admin4444', '2018-09-24 13:59:15.000');
INSERT INTO DestroyedDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime, DAno, Dtime)
	VALUES('drug5555', '2018-03-15', 15, 'supplier5555', 'admin3333', '2018-03-25 09:16:30.000',
														'admin1111', '2018-12-05 11:05:06.000');
INSERT INTO DestroyedDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime, DAno, Dtime)
	VALUES('drug4444', '2018-06-01', 3, 'supplier4444', 'admin3333', '2018-06-10 10:30:30.000',
														'admin1111', '2019-05-10 16:17:05.000');
INSERT INTO DestroyedDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime, DAno, Dtime)
	VALUES('drug3333', '2018-10-08', 5, 'supplier3333', 'admin2222', '2018-10-11 10:36:55.000',
														'admin5555', '2019-01-02 12:05:53.000');
INSERT INTO DestroyedDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime, DAno, Dtime)
	VALUES('drug2222', '2018-11-05', 7, 'supplier2222', 'admin2222', '2018-11-09 14:29:16.000',
														'admin3333', '2019-02-26 10:59:05.000');
INSERT INTO DestroyedDrug(PDno, PDbatch, PDnum, Sno, SAno, Stime, DAno, Dtime)
	VALUES('drug1111', '2018-11-21', 17, 'supplier1111', 'admin1111', '2018-11-25 11:53:55.000',
														'admin2222', '2019-05-05 15:15:29.000');

INSERT INTO Prescription(Pid, Dno, Ptime, Nno, Htime, Pstate)
	VALUES('44019901023', 'doctor1111', '2019-12-01 09:05:10.000', 'nurse2222', '2019-12-01 09:25:13.000', 1);
INSERT INTO Prescription(Pid, Dno, Ptime, Nno, Htime, Pstate)
	VALUES('44019981102', 'doctor2222', '2019-12-01 09:22:19.000', 'nurse3333', '2019-12-01 09:28:33.000', 1);
INSERT INTO Prescription(Pid, Dno, Ptime, Nno, Htime, Pstate)
	VALUES('44019971206', 'doctor3333', '2019-12-01 09:35:17.000', 'nurse5555', '2019-12-01 09:45:19.000', 1);
INSERT INTO Prescription(Pid, Dno, Ptime, Nno, Htime, Pstate)
	VALUES('44019810516', 'doctor4444', '2019-12-01 09:55:10.000', 'nurse4444', '2019-12-01 10:05:52.000', 1);
INSERT INTO Prescription(Pid, Dno, Ptime, Nno, Htime, Pstate)
	VALUES('44019760215', 'doctor5555', '2019-12-01 10:05:59.000', 'nurse1111', '2019-12-01 10:25:33.000', 1);
INSERT INTO Prescription(Pid, Dno, Ptime, Nno, Htime, Pstate)
	VALUES('44019950916', 'doctor4444', '2019-12-01 10:55:18.000', 'nurse2222', '2019-12-01 11:05:46.000', 1);
INSERT INTO Prescription(Pid, Dno, Ptime, Nno, Htime, Pstate)
	VALUES('44019910416', 'doctor3333', '2019-12-01 15:19:35.000', NULL, NULL, 0);
INSERT INTO Prescription(Pid, Dno, Ptime, Nno, Htime, Pstate)
	VALUES('44019970730', 'doctor2222', '2019-12-01 15:27:45.000', NULL, NULL, 0);
INSERT INTO Prescription(Pid, Dno, Ptime, Nno, Htime, Pstate)
	VALUES('44019921016', 'doctor1111', '2019-12-01 15:35:16.000', NULL, NULL, 0);

INSERT INTO PID(Pno, PDno, PDnum) VALUES(1, 'drug1111', 2);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(1, 'drug3333', 1);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(2, 'drug5555', 3);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(3, 'drug7777', 2);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(3, 'drug8888', 2);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(3, 'drug9999', 3);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(4, 'drug2222', 5);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(4, 'drug3333', 4);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(5, 'drug2222', 4);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(5, 'drug3333', 3);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(5, 'drug5555', 3);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(5, 'drug7777', 7);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(5, 'drug9999', 2);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(6, 'drug2222', 2);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(6, 'drug4444', 1);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(8, 'drug6666', 3);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(8, 'drug8888', 3);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(8, 'drug9999', 2);
INSERT INTO PID(Pno, PDno, PDnum) VALUES(9, 'drug1111', 1);
