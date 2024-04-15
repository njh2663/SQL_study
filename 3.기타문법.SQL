/* CASE */
-- CASE WHEN 조건절 THEN 참일때 값 ELSE 거짓일때 값 END 컬럼명

CREATE TABLE GRADE(
    ID VARCHAR(3) NOT NULL,
    GENDER VARCHAR(1),
    NAME VARCHAR(100),
    SCORE INT
);

INSERT INTO GRADE VALUES('001','1','James',99);
INSERT INTO GRADE VALUES('002','2','Moa',82);
INSERT INTO GRADE VALUES('003','1','Kun',73);

SELECT NAME,
	CASE WHEN GENDER = '1' THEN '여' ELSE '남' END AS 성별
	FROM GRADE;

SELECT NAME,
    (CASE 
        WHEN SCORE >= '90' THEN 'A'
        WHEN SCORE >= '70' THEN 'B'
        ELSE 'C' 
    END) AS '등급'
	FROM GRADE;

-----------------------------------------------------------------------------------------------

/* IF */
-- IF 조건 참일때 값 ELSE 거짓일때 값 END 컬럼명

SELECT IF(2 > 1, 'TRUE', 'FALSE') AS result;

-----------------------------------------------------------------------------------------------

/* ISNULL */


/* IFNULL */


/* DISTINCT */

