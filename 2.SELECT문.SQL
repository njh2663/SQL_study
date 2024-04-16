/*
SELECT 열_이름
	FROM 테이블_이름
	WHERE 조건식
	GROUP BY 열_이름
	HAVING 조건식
	ORDER BY 열_이름
	LIMIT 숫자
*/

-----------------------------------------------------------------------------------------------

/* WHERE */
-- AND, OR, BETWEEN, IN, LIKE

/* 실습 */
-- CAR_TYPE이 SUV인 자동차들의 평균 일일 대여 요금
SELECT ROUND(AVG(DAILY_FEE)) AS AVERAGE_FEE
	FROM CAR_RENTAL_COMPANY_CAR
	WHERE CAR_TYPE = 'SUV';

/* 실습 */
SELECT ANIMAL_ID, NAME, SEX_UPON_INTAKE 
	FROM ANIMAL_INS 
	WHERE NAME IN ('Lucy','Ella','Pickle','Rogan','Sabrina','Mitty')
	ORDER BY ANIMAL_ID ASC;

-----------------------------------------------------------------------------------------------

/* ORDER BY */
/* 실습 */
CREATE TABLE SCORE(
	ID INT NOT NULL,
	MATH INT,
	ENGLISH INT
);

INSERT INTO SCORE VALUES(1,80,90);
INSERT INTO SCORE VALUES(2,70,100);
INSERT INTO SCORE VALUES(3,90,40);

SELECT * FROM SCORE ORDER BY ID;  -- DEFAULT 값은 ASC

SELECT * FROM SCORE ORDER BY MATH DESC;

/* 실습 */
SELECT ANIMAL_ID, NAME, DATETIME
    FROM ANIMAL_INS
    ORDER BY NAME, DATETIME DESC;  -- DEFALUT 값은 ASC

/* 실습 */
-- 총주문량 내림차순, 같을 경우 출하번호 오름차순 정렬
SELECT FLAVOR
	FROM FIRST_HALF
	ORDER BY TOTAL_ORDER DESC, SHIPMENT_ID ASC;

-----------------------------------------------------------------------------------------------

/* LIMIT, OFFSET */
-- 조회 한계를 설정, 몇 행까지만 가져와라

/* 실습 */
SELECT NAME
    FROM ANIMAL_INS
    ORDER BY DATETIME
    LIMIT 3; -- 3개 행만 가져오기

SELECT NAME
    FROM ANIMAL_INS
    ORDER BY DATETIME
    LIMIT 10, 5; -- 11행부터 5개의 행 가져오기

-----------------------------------------------------------------------------------------------

/* IN */
/* 실습 */
SELECT DR_NAME, DR_ID, MCDP_CD, 
				DATE_FORMAT(HIRE_YMD,'%Y-%m-%d') AS HIRE_YMD
    FROM DOCTOR
    WHERE MCDP_CD IN ('CS','GS')
    ORDER BY HIRE_YMD DESC, DR_NAME;

-----------------------------------------------------------------------------------------------

/* GROUP BY */
/* 실습 */
SELECT SUBSTR(PRODUCT_CODE,1,2) AS CATEGORY, 
	COUNT(*) AS PRODUCTS
	FROM PRODUCT
	GROUP BY CATEGORY
	ORDER BY CATEGORY;

-----------------------------------------------------------------------------------------------

/* HAVING */
/* 실습 */
SELECT HOUR(DATETIME) AS HOUR, COUNT(*) AS COUNT
    FROM ANIMAL_OUTS
    GROUP BY HOUR HAVING HOUR BETWEEN 9 AND 19
    ORDER BY HOUR;

/* 실습 */
SELECT ANIMAL_TYPE, COUNT(*)
    FROM ANIMAL_INS
    GROUP BY ANIMAL_TYPE
    HAVING ANIMAL_TYPE IN ('Cat', 'Dog')
    ORDER BY ANIMAL_TYPE ASC;

