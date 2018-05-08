USE lab_1and2;

--电影表【电影编号，电影名称，电影类型，导演姓名，电影时长（以分钟计），是否3D，用户评分】
IF NOT EXISTS (
    SELECT name
FROM sys.tables
WHERE name = N'FILM'
)
CREATE TABLE FILM
(
    FID		INT NOT NULL PRIMARY KEY,
    FNAME	CHAR(10) NOT NULL,
    FTYPE	CHAR(10) NOT NULL,
    DNAME	CHAR(30) NOT NULL,
	LENGTH	INT NOT NULL,
	IS3D	CHAR(1) NOT NULL CONSTRAINT [CK_IS3D] CHECK  (([IS3D]='N' OR [IS3D]='Y')) ,
	GRADE	INT CONSTRAINT [CK_FILM_GRADE] CHECK  (([GRADE]>=(0) AND [GRADE]<=(100) OR [GRADE] IS NULL))
);
----主码为电影编号，IS3D取值为’Y’表示是3D电影，’N’表示不是，用户评分规定为0~100分之间或者为空值。

--演员表【演员编号，演员姓名，性别，出生年份】
IF NOT EXISTS (
    SELECT name
FROM sys.tables
WHERE name = N'ACTOR'
)
CREATE TABLE ACTOR
(
	ACTID	int PRIMARY KEY NOT NULL, 
	ANAME	char(30) NOT NULL, 
	SEX		char(2)NOT NULL, 
	BYEAR	int NOT NULL
);
----主码为演员编号

--参演表【演员编号，电影编号，是否主角，用户对该演员在该电影中的评分】
IF NOT EXISTS (
    SELECT name
FROM sys.tables
WHERE name = N'ACTIN'
)
CREATE TABLE ACTIN
(
	ACTID int NOT NULL, 
	FID int NOT NULL, 
	ISLEADING char(1) NULL CONSTRAINT [CK_ISLEADING] CHECK  (([ISLEADING]='N' OR [ISLEADING]='Y')) , 
	GRADE int NULL CONSTRAINT [CK_ACTIN_GRADE] CHECK  (([GRADE]>=(0) AND [GRADE]<=(100) OR [GRADE] IS NULL)),
	PRIMARY KEY (ACTID,FID),
    FOREIGN KEY (ACTID) REFERENCES ACTOR(ACTID),
    FOREIGN KEY (FID) REFERENCES FILM(FID),
);
----主码、外码请依据应用背景合理定义。ISLEADING取值为’Y’表示是，’N’表示不是主角，也可能取空值，表示不太确定该演员在该电影中是否主角。GRADE规定为0~100分之间或者为空值。

--电影院表【电影院编号，电影院名字，影院所在行政区，影院地址】
IF NOT EXISTS (
    SELECT name
FROM sys.tables
WHERE name = N'THEATER'
)
CREATE TABLE THEATER 
(
	TID int NOT NULL PRIMARY KEY, 
	TNAME char(20)NOT NULL, 
	TAREA char(20)NOT NULL, 
	ADDRESS char(30)NOT NULL
);
----主码为电影院编号，影院所在行政区取值如“洪山区”、“武昌区”等等。

--上映表【电影编号，影院编号，上映年份，上映月份】
IF NOT EXISTS (
    SELECT name
FROM sys.tables
WHERE name = N'SHOW'
)CREATE TABLE SHOW
(
	FID int NOT NULL, 
	TID int NOT NULL, 
	PRICE int NOT NULL, 
	YEAR int NOT NULL, 
	MONTH int NOT NULL,
	PRIMARY KEY (FID,TID),
    FOREIGN KEY (FID) REFERENCES FILM(FID),
    FOREIGN KEY (TID) REFERENCES THEATER(TID)
);
----假定一部电影在一家影院只上映一次，主码、外码请依据应用背景合理定义。




