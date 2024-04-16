/* ON 과 WHERE의 차이 */
-- ON : JOIN을 하기 전에 필터링
-- WHERE : JOIN을 한 후에 필터링

-----------------------------------------------------------------------------------------------

/* JOIN */

/* 실습 */
SELECT F.FLAVOR
    FROM FIRST_HALF AS F
    JOIN ICECREAM_INFO AS I 
    ON F.FLAVOR = I.FLAVOR
    WHERE F.TOTAL_ORDER > 3000 AND I.INGREDIENT_TYPE = 'fruit_based'
    ORDER BY F.TOTAL_ORDER DESC;

/* 실습 */
SELECT *
    FROM APPOINTMENT A 
		JOIN PATIENT P ON A.PT_NO = P.PT_NO
		JOIN DOCTOR D ON A.MDDR_ID = D.DR_ID;

/* 실습 */
SELECT A.BOOK_ID, B.AUTHOR_NAME, DATE_FORMAT(A.PUBLISHED_DATE, '%Y-%m-%d') AS PUBLISHED_DATE
    FROM BOOK A JOIN AUTHOR B ON A.AUTHOR_ID = B.AUTHOR_ID
    WHERE A.CATEGORY = '경제'
    ORDER BY A.PUBLISHED_DATE ASC;

/* LEFT JOIN */
-- 오랜 기간 보호한 동물(1)
-- 아직 입양을 못 간 동물 중, 가장 오래 보호소에 있었던 동물 3마리의 이름과 보호 시작일을 조회하는 SQL문을 작성해주세요. 이때 결과는 보호 시작일 순으로 조회해야 합니다.
SELECT I.NAME, I.DATETIME
    FROM ANIMAL_INS I LEFT JOIN ANIMAL_OUTS O 
    ON I.ANIMAL_ID = O.ANIMAL_ID
    WHERE O.ANIMAL_ID IS NULL
    ORDER BY I.DATETIME ASC
    LIMIT 3;

/* RIGHT JOIN */
-- 없어진 기록 찾기
-- 천재지변으로 인해 일부 데이터가 유실되었습니다. 입양을 간 기록은 있는데, 보호소에 들어온 기록이 없는 동물의 ID와 이름을 ID 순으로 조회하는 SQL문을 작성해주세요.
SELECT O.ANIMAL_ID, O.NAME
    FROM ANIMAL_INS I RIGHT JOIN ANIMAL_OUTS O
    ON I.ANIMAL_ID = O.ANIMAL_ID
    WHERE I.ANIMAL_ID IS NULL;

-----------------------------------------------------------------------------------------------

/* USING */
-- 컬럼명이 같은 경우만 사용할 수 있음

/* 실습 */
SELECT *
    FROM APPOINTMENT
		JOIN PATIENT USING (PT_NO);

-----------------------------------------------------------------------------------------------

/* UNION ALL */		
SELECT FLAVOR
    FROM 
        (
        SELECT FLAVOR, TOTAL_ORDER
        FROM FIRST_HALF
        UNION ALL
        SELECT FLAVOR, TOTAL_ORDER
        FROM JULY
        ) A;