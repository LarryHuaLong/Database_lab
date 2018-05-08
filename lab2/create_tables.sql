USE lab_1and2;

--��Ӱ����Ӱ��ţ���Ӱ���ƣ���Ӱ���ͣ�������������Ӱʱ�����Է��Ӽƣ����Ƿ�3D���û����֡�
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
----����Ϊ��Ӱ��ţ�IS3DȡֵΪ��Y����ʾ��3D��Ӱ����N����ʾ���ǣ��û����ֹ涨Ϊ0~100��֮�����Ϊ��ֵ��

--��Ա����Ա��ţ���Ա�������Ա𣬳�����ݡ�
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
----����Ϊ��Ա���

--���ݱ���Ա��ţ���Ӱ��ţ��Ƿ����ǣ��û��Ը���Ա�ڸõ�Ӱ�е����֡�
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
----���롢����������Ӧ�ñ��������塣ISLEADINGȡֵΪ��Y����ʾ�ǣ���N����ʾ�������ǣ�Ҳ����ȡ��ֵ����ʾ��̫ȷ������Ա�ڸõ�Ӱ���Ƿ����ǡ�GRADE�涨Ϊ0~100��֮�����Ϊ��ֵ��

--��ӰԺ����ӰԺ��ţ���ӰԺ���֣�ӰԺ������������ӰԺ��ַ��
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
----����Ϊ��ӰԺ��ţ�ӰԺ����������ȡֵ�硰��ɽ����������������ȵȡ�

--��ӳ����Ӱ��ţ�ӰԺ��ţ���ӳ��ݣ���ӳ�·ݡ�
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
----�ٶ�һ����Ӱ��һ��ӰԺֻ��ӳһ�Σ����롢����������Ӧ�ñ��������塣




