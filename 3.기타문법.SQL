/* CASE */
-- CASE WHEN 조건절 THEN 참일때 값 ELSE 거짓일때 값 END 컬럼명

/* 실습 */
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

/* 실습 */
SELECT ANIMAL_ID, NAME 
      ,(CASE
           WHEN SEX_UPON_INTAKE LIKE '%Neutered%' OR SEX_UPON_INTAKE LIKE '%Spayed%' THEN 'O'
           ELSE 'X'
        END) AS 중성화
	FROM ANIMAL_INS
	ORDER BY ANIMAL_ID;

-----------------------------------------------------------------------------------------------

/* IF */
-- IF(조건, 참일때값, 거짓일때값)
SELECT IF(2 > 1, 'TRUE', 'FALSE') AS RESULT;

/* 실습 */
SELECT PT_NAME, PT_NO, GEND_CD, AGE, 
        IF(TLNO IS NULL, 'NONE', TLNO) AS TLNO  
    FROM PATIENT
    WHERE AGE <= 12 AND GEND_CD = 'W'
    ORDER BY AGE DESC, PT_NAME;

/* 실습 */
SELECT ANIMAL_ID, NAME ,IF (SEX_UPON_INTAKE LIKE '%Neutered%' OR SEX_UPON_INTAKE LIKE '%Spayed%','O','X') AS '중성화'
  FROM ANIMAL_INS
  ORDER BY ANIMAL_ID;

-----------------------------------------------------------------------------------------------

/* ISNULL */
/* 실습 */
SELECT COUNT(*) AS USERS
    FROM USER_INFO
    WHERE AGE IS NULL;

/* 실습 */
SELECT ANIMAL_ID
    FROM ANIMAL_INS
    WHERE NAME IS NOT NULL
    ORDER BY ANIMAL_ID;

-----------------------------------------------------------------------------------------------

/* IFNULL */
/* 실습 */
SELECT PT_NAME, PT_NO, GEND_CD, AGE, 
        IFNULL(TLNO, 'NONE') AS TLNO
    FROM PATIENT
    WHERE AGE <= 12 AND GEND_CD = 'W'
    ORDER BY AGE DESC, PT_NAME;

/* 실습 */
SELECT ANIMAL_TYPE, 
        IFNULL(NAME, 'No name') AS NAME, 
        SEX_UPON_INTAKE
    FROM ANIMAL_INS
    ORDER BY ANIMAL_ID;

/* 실습 */
SELECT WAREHOUSE_iD, WAREHOUSE_NAME, ADDRESS, 
        IFNULL(FREEZER_YN, 'N') AS FREEZER_YN
    FROM FOOD_WAREHOUSE
    WHERE ADDRESS LIKE '경기도%'
    ORDER BY WAREHOUSE_ID;

-----------------------------------------------------------------------------------------------

/* DISTINCT */
/* 실습 */
SELECT COUNT(DISTINCT(NAME))
    FROM ANIMAL_INS;

-----------------------------------------------------------------------------------------------

/* SUM, MAX, MIN, COUNT */
/* 실습 */
SELECT MAX(PRICE) AS MAX_PRICE
    FROM PRODUCT;

/* 실습 */
SELECT MIN(DATETIME)
	FROM ANIMAL_INS

/* 실습 */
SELECT COUNT(*)
    FROM ANIMAL_INS;

/* 실습 */
SELECT NAME, COUNT(ANIMAL_ID) AS COUNT
    FROM ANIMAL_INS
    GROUP BY NAME
    HAVING COUNT(NAME) >= 2
    ORDER BY NAME