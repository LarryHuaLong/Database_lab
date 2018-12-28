--FILM(FID int, FNAME char(30), FTYPE char(10), DNAME char(30), length int, IS3D char(1),GRADEGRADE int)
--ACTOR(ACTID int, ANAME char(30), SEX char(2), BYEAR int)
--ACTIN(ACTID int, FID int, ISLEADING char(1), GRADE int)
--THEATER (TID int, TNAME char(20), TAREA char(20), ADDRESS char(30))
--SHOW(FID int, TID int , PRICE int, YEAR int , MONTH int)

USE lab_1and2;

--1）分别用一条sql语句完成对电影表基本的增、删、改的操作；
INSERT INTO FILM
VALUES
    ( 225759, '侏罗纪世界', '冒险', '胡安', 128, 'Y', 73);

UPDATE FILM 
SET FTYPE = '动作'
WHERE FID = 225759;

DELETE FROM FILM
WHERE FID = 225759;
GO
--2）批处理操作
---- 将演员表中的90后演员记录插入到一个新表YOUNG_ACTOR中。
SELECT * INTO YOUNG_ACTOR FROM ACTOR WHERE BYEAR >= 1990;
GO
--3）数据导入导出
----通过查阅DBMS资料学习数据导入导出功能，并将任务2.1所建表格的数据导出到操作系统文件，然后再将这些文件的数据导入到相应空表。

--4）观察性实验
----建立一个关系，但是不设置主码，然后向该关系中插入重复元组，然后观察在图形化交互界面中对已有数据进行删除和修改时所发生的现象。

--5）创建视图
----创建一个有80后演员作主角的参演记录视图，其中的属性包括：演员编号、演员姓名、出生年份、作为主角参演的电影数量、这些电影的用户评分的最高分。
CREATE VIEW ACTIN_80
(
    ACTID,
    ANAME,
    BYEAR,
    LEADING_NUM,
    MAX_GRADE
)
AS
    SELECT ACTOR.ACTID, ACTOR.ANAME, ACTOR.BYEAR, COUNT(DISTINCT ACTIN.FID), MAX(FILM.GRADE)
    FROM ACTOR, ACTIN, FILM
    WHERE ACTIN.ACTID=ACTOR.ACTID AND ACTIN.FID=FILM.FID
        AND ACTOR.BYEAR > 1980 AND ISLEADING = 'Y'
    GROUP BY ACTOR.ACTID,ACTOR.ANAME,ACTOR.BYEAR;
GO
--6）触发器实验
----编写一个触发器，用于实现对电影表的完整性控制规则：当增加一部电影时，若导演的姓名为周星驰，则电影类型自动设置为“喜剧”。
USE lab_1and2;

CREATE TRIGGER IS_ZHOUXINCHI
ON FILM 
AFTER INSERT
AS
DECLARE @fid int
DECLARE @dname VARCHAR(30)
SELECT @fid = FID FROM inserted
SELECT @dname = DNAME FROM inserted
IF @dname = '周星驰'
    UPDATE FILM SET FTYPE = '喜剧' WHERE FID = @fid 
GO
INSERT INTO FILM
VALUES
    ( 2259, '美人鱼2', '科幻', '周星驰', 128, 'Y', 63);
