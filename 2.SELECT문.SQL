/*
SELECT 열_이름
	FROM 테이블_이름
	WHERE 조건식
	GROUP BY 열_이름
	HAVING 조건식
	ORDER BY 열_이름
	LIMIT 숫자
*/

/* WHERE */
-- AND, OR, BETWEEN, IN, LIKE

/* 실습 */
-- CAR_TYPE이 SUV인 자동차들의 평균 일일 대여 요금
SELECT ROUND(AVG(DAILY_FEE)) AS AVERAGE_FEE
	FROM CAR_RENTAL_COMPANY_CAR
	WHERE CAR_TYPE = 'SUV'

-----------------------------------------------------------------------------------------------

/* ORDER BY */
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
    ORDER BY NAME, DATETIME DESC  -- DEFALUT 값은 ASC

/* 실습 */
-- 총주문량 내림차순, 같을 경우 출하번호 오름차순 정렬
SELECT FLAVOR
	FROM FIRST_HALF
	ORDER BY TOTAL_ORDER DESC, SHIPMENT_ID ASC



-----------------------------------------------------------------------------------------------

/* LIMIT */

/* 실습 */
SELECT NAME
    FROM ANIMAL_INS
    ORDER BY DATETIME
    LIMIT 1

/* GROUP BY */

/* HAVING */


