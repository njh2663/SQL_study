/* ON 과 WHERE의 차이 */
-- ON : JOIN을 하기 전에 필터링
-- WHERE : JOIN을 한 후에 필터링

/* JOIN */
-- 3개 조인
SELECT *
    FROM APPOINTMENT A 
		    JOIN PATIENT P ON A.PT_NO = P.PT_NO
		    JOIN DOCTOR D ON A.MDDR_ID = D.DR_ID

/* USING */
-- 컬럼명이 같은 경우만 사용할 수 있음
SELECT *
    FROM APPOINTMENT
				JOIN PATIENT USING (PT_NO)


/* UNION ALL */		
SELECT FLAVOR
FROM 
    (
    SELECT FLAVOR, TOTAL_ORDER
    FROM FIRST_HALF
    UNION ALL
    SELECT FLAVOR, TOTAL_ORDER
    FROM JULY
    ) A