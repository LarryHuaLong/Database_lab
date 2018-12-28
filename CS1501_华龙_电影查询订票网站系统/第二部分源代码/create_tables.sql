USE lab_1and2;

--电影表【电影编号，电影名称，电影类型，导演姓名，电影时长（以分钟计），是否3D，用户评分】
--FILM(FID int, FNAME char(30), FTYPE char(10), DNAME char(30), length int, IS3D char(1)，GRADE int)
IF NOT EXISTS (
    SELECT name
FROM sys.tables
WHERE name = N'FILM'
)
CREATE TABLE FILM
(
	FID    INT      NOT NULL PRIMARY KEY,
	FNAME  CHAR(10) NOT NULL,
	FTYPE  CHAR(10) NULL,
	DNAME  CHAR(30) NULL,
	LENGTH INT      NULL,
	IS3D   CHAR(1)  NULL CONSTRAINT [CK_IS3D] CHECK  (([IS3D]='N' OR [IS3D]='Y' OR [IS3D] IS NULL)) ,
	GRADE  INT      NULL CONSTRAINT [CK_FILM_GRADE] CHECK  (([GRADE]>=(0) AND [GRADE]<=(100) OR [GRADE] IS NULL))
);
----主码为电影编号，IS3D取值为’Y’表示是3D电影，’N’表示不是，用户评分规定为0~100分之间或者为空值。

--演员表【演员编号，演员姓名，性别，出生年份】
--ACTOR(ACTID int, ANAME char(30), SEX char(2), BYEAR int)
IF NOT EXISTS (
    SELECT name
FROM sys.tables
WHERE name = N'ACTOR'
)
CREATE TABLE ACTOR
(
	ACTID INT      PRIMARY KEY NOT NULL,
	ANAME CHAR(30) NOT NULL,
	SEX   CHAR(2)  NOT NULL,
	BYEAR INT      NULL
);
----主码为演员编号

--参演表【演员编号，电影编号，是否主角，用户对该演员在该电影中的评分】
--ACTIN(ACTID int, FID int, ISLEADING char(1), GRADE int)
IF NOT EXISTS (
    SELECT name
FROM sys.tables
WHERE name = N'ACTIN'
)
CREATE TABLE ACTIN
(
	ACTID     INT     NOT NULL,
	FID       INT     NOT NULL,
	ISLEADING CHAR(1) NULL CONSTRAINT [CK_ISLEADING] CHECK  (([ISLEADING]='N' OR [ISLEADING]='Y')) ,
	GRADE     INT     NULL CONSTRAINT [CK_ACTIN_GRADE] CHECK  (([GRADE]>=(0) AND [GRADE]<=(100) OR [GRADE] IS NULL)),
	PRIMARY KEY (ACTID,FID),
	FOREIGN KEY (ACTID) REFERENCES ACTOR(ACTID),
	FOREIGN KEY (FID) REFERENCES FILM(FID),
);
----主码、外码请依据应用背景合理定义。ISLEADING取值为’Y’表示是，’N’表示不是主角，也可能取空值，表示不太确定该演员在该电影中是否主角。GRADE规定为0~100分之间或者为空值。

--电影院表【电影院编号，电影院名字，影院所在行政区，影院地址】
--THEATER (TID int, TNAME char(20), TAREA char(20), ADDRESS char(30))
IF NOT EXISTS (
    SELECT name
FROM sys.tables
WHERE name = N'THEATER'
)
CREATE TABLE THEATER
(
	TID     INT      NOT NULL PRIMARY KEY,
	TNAME   CHAR(20)NOT NULL,
	TAREA   CHAR(20) NULL,
	ADDRESS CHAR(30) NULL
);
----主码为电影院编号，影院所在行政区取值如“洪山区”、“武昌区”等等。

--上映表【电影编号，影院编号，上映年份，上映月份】
--SHOW(FID int, TID int , PRICE int, YEAR int , MONTH int)
IF NOT EXISTS (
    SELECT name
FROM sys.tables
WHERE name = N'SHOW'
)CREATE TABLE SHOW
(
	FID   INT NOT NULL,
	TID   INT NOT NULL,
	PRICE INT NULL,
	YEAR  INT NULL,
	MONTH INT NULL,
	PRIMARY KEY (FID,TID),
	FOREIGN KEY (FID) REFERENCES FILM(FID),
	FOREIGN KEY (TID) REFERENCES THEATER(TID)
);
----假定一部电影在一家影院只上映一次，主码、外码请依据应用背景合理定义。




