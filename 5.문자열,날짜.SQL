/* LEFT, RIGHT, SUBSTR, CONCAT */
-- SUBSTR은 엑셀의 MID 동일함

/* 실습 */
SELECT LEFT('01012345678', 3);
SELECT RIGHT('01012345678', 4);
SELECT SUBSTR('01012345678', 4, 4);

SELECT CONCAT(LEFT('01012345678', 3), 
              SUBSTR('01012345678', 4, 4), 
              RIGHT('01012345678', 4)
             ) AS PHONE_NUMBER;

-----------------------------------------------------------------------------------------------

/* LIKE */
-- WHERE 컬럼 LIKE 표현식

/* 실습 */
CREATE TABLE NAME_LIST(
  	ID VARCHAR(10),
	NAME VARCHAR(10)
	);

INSERT INTO NAME_LIST VALUES ('No1', 'Mike');
INSERT INTO NAME_LIST VALUES ('No2', 'May');
INSERT INTO NAME_LIST VALUES ('No3', 'Mia');
INSERT INTO NAME_LIST VALUES ('No4', 'Jake');
INSERT INTO NAME_LIST VALUES ('--', 'Jam');

SELECT NAME FROM NAME_LIST WHERE ID LIKE 'No%';  -- ID가 No로 시작하는 NAME
SELECT NAME FROM NAME_LIST WHERE NAME LIKE '%i%'; -- i 포함
SELECT NAME FROM NAME_LIST WHERE NAME LIKE 'M__'; -- M + 2글자
SELECT NAME FROM NAME_LIST WHERE NAME LIKE 'M[ai]y';  -- M + a 또는 i + y

/* 실습 */
SELECT ANIMAL_ID, NAME
	FROM ANIMAL_INS
	WHERE ANIMAL_TYPE = 'Dog' AND LOWER(NAME) LIKE '%el%'
	ORDER BY NAME;

/* 실습 */
SELECT CAR_TYPE, COUNT(*) AS CARS
    FROM CAR_RENTAL_COMPANY_CAR
    WHERE OPTIONS LIKE '%통풍시트%' OR OPTIONS LIKE '%열선시트%' OR OPTIONS LIKE '%가죽시트%'
    GROUP BY CAR_TYPE
    ORDER BY CAR_TYPE

-----------------------------------------------------------------------------------------------

/* REGEXP */
-- WHERE 컬럼 REGEXP 표현식
/*
	. 문자 한 개
	^ 문자열 처음
	* 앞에 나온 문자 n개 이상 반복
	[] 괄호 안 문자열 일치
	| 또는
	[^패턴] 패턴이 아닌 것
	[A-z] 문자
	[0-9] 숫자
*/

/* 실습 */
CREATE TABLE NAME_LIST(
  	ID VARCHAR(10),
	NAME VARCHAR(10)
	);

INSERT INTO NAME_LIST VALUES ('No1', 'Mike');
INSERT INTO NAME_LIST VALUES ('No2', 'May');
INSERT INTO NAME_LIST VALUES ('No3', 'Mia');
INSERT INTO NAME_LIST VALUES ('No4', 'Jake');
INSERT INTO NAME_LIST VALUES ('--', 'Jam');

SELECT NAME FROM NAME_LIST WHERE NAME REGEXP 'a';  -- a 포함
SELECT NAME FROM NAME_LIST WHERE NAME REGEXP '...e';  -- 3글자 + e
SELECT NAME FROM NAME_LIST WHERE NAME REGEXP '^M';  -- 첫 글자가 M
SELECT NAME FROM NAME_LIST WHERE NAME REGEXP '[JM]a..';   -- J or M + a + 문자 2개
SELECT NAME FROM NAME_LIST WHERE NAME REGEXP 'May|Jam';

/* 실습 */
SELECT CAR_TYPE, COUNT(*) AS CARS
    FROM CAR_RENTAL_COMPANY_CAR
    WHERE OPTIONS REGEXP '통풍시트|열선시트|가죽시트'
    GROUP BY CAR_TYPE
    ORDER BY CAR_TYPE

-----------------------------------------------------------------------------------------------

/* DATE_FORMAT */
DATE_FORMAT(START_DATE, '%Y-%m-%d'); #2022-09-10
DATE_FORMAT(START_DATE, '%Y-%m'); #2022-09
DATE_FORMAT(START_DATE, '%y_%m'); #22_09

/*
	%Y = YYYY
	%y = YY
	%m = MM
	%d = DD
	%b = MON(Jan~Dec)
	%a = Day(Sun~Sat)
	%H = 24 hour
	%h = 12 hour
	%i = minutes
	%s = seconds
*/

/* 실습 */
-- 2021년에 출판된 인문 카테고리 도서
SELECT BOOK_ID, DATE_FORMAT(PUBLISHED_DATE, '%Y-%m-%d') AS PUBLISHED_DATE
    FROM BOOK
    WHERE DATE_FORMAT(PUBLISHED_DATE, '%Y') = '2021' AND CATEGORY = '인문'
    ORDER BY PUBLISHED_DATE;

-----------------------------------------------------------------------------------------------

/* YEAR, MONTH, DAY */
SELECT YEAR('2024-01-11');
SELECT MONTH('2024-01-11');
SELECT DAY('2024-01-11');

/* 실습 */
-- 2021년에 출판된 인문 카테고리 도서
SELECT BOOK_ID, DATE_FORMAT(PUBLISHED_DATE, '%Y-%m-%d') AS PUBLISHED_DATE
    FROM BOOK
    WHERE YEAR(PUBLISHED_DATE) = '2021' AND CATEGORY = '인문'
    ORDER BY PUBLISHED_DATE;

-----------------------------------------------------------------------------------------------

/* NOW */
SELECT NOW();

-----------------------------------------------------------------------------------------------

/* DATEDIFF */
-- DATEDIFF(END_DATE, START_DATE)
SELECT DATEDIFF('2021-01-03', '2021-01-01');