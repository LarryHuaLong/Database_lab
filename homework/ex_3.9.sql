USE homework--切换数据库
/*
DROP VIEW SANJIAN CASCADE;
CREATE VIEW SANJIAN (SNO, PNO, QTY)
AS
    SELECT SNO, PNO, QTY
    FROM SPJ, J
    WHERE SPJ.JNO=J.JNO AND
        J.JNAME='三建'
    WITH CHECK OPTION;
SELECT *
FROM sys.views;
--*/

SELECT PNO,SUM(QTY) 
FROM SANJIAN
GROUP BY PNO;

SELECT *
FROM SANJIAN
WHERE SNO='S1';