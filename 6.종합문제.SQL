/* 실습으로 구분하기 애매한 문제들 */

-----------------------------------------------------------------------------------------------

/* Lv.1 */
-- 조건에 부합하는 중고거래 댓글 조회하기
-- USED_GOODS_BOARD 와 USED_GOODS_REPLY 테이블에서 2022년 10월에 작성된 게시글 제목, 게시글 ID, 댓글 ID, 댓글 작성자 ID, 댓글 내용, 댓글 작성일을 조회하는 SQL문을 작성해주세요. 결과는 댓글 작성일을 기준으로 오름차순 정렬해주시고, 댓글 작성일이 같다면 게시글 제목을 기준으로 오름차순 정렬해주세요.
SELECT A.TITLE, A.BOARD_ID, B.REPLY_ID, B.WRITER_ID, B.CONTENTS, 
        DATE_FORMAT(B.CREATED_DATE, '%Y-%m-%d') AS CREATED_DATE
    FROM USED_GOODS_BOARD AS A JOIN USED_GOODS_REPLY AS B
    ON A.BOARD_ID = B.BOARD_ID
    WHERE DATE_FORMAT(A.CREATED_DATE, '%Y-%m') = '2022-10'
    ORDER BY B.CREATED_DATE ASC, A.TITLE ASC;

-- 조건에 맞는 회원수 구하기
-- USER_INFO 테이블에서 2021년에 가입한 회원 중 나이가 20세 이상 29세 이하인 회원이 몇 명인지 출력하는 SQL문을 작성해주세요.
SELECT COUNT(*)
    FROM USER_INFO
    WHERE AGE BETWEEN 20 AND 29 AND DATE_FORMAT(JOINED, '%Y') = '2021';

-- 자동차 대여 기록에서 장기/단기 대여 구분하기
-- CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서 대여 시작일이 2022년 9월에 속하는 대여 기록에 대해서 대여 기간이 30일 이상이면 '장기 대여' 그렇지 않으면 '단기 대여' 로 표시하는 컬럼(컬럼명: RENT_TYPE)을 추가하여 대여기록을 출력하는 SQL문을 작성해주세요. 결과는 대여 기록 ID를 기준으로 내림차순 정렬해주세요.
SELECT HISTORY_ID, CAR_ID, 
    DATE_FORMAT(START_DATE, '%Y-%m-%d') AS 'START_DATE', 
    DATE_FORMAT(END_DATE,'%Y-%m-%d') AS 'END_DATE',
    CASE WHEN DATEDIFF(END_DATE,START_DATE) + 1 >= 30 
        THEN '장기 대여'
        ELSE '단기 대여' END AS 'RENT_TYPE'
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
    WHERE DATE_FORMAT(START_DATE, '%Y-%m') = '2022-09'
    ORDER BY HISTORY_ID DESC;

-----------------------------------------------------------------------------------------------

/* Lv.2 */
-- 가격대별 상품 개수 구하기
-- PRODUCT 테이블에서 만원 단위의 가격대 별로 상품 개수를 출력하는 SQL 문을 작성해주세요. 이때 컬럼명은 각각 컬럼명은 PRICE_GROUP, PRODUCTS로 지정해주시고 가격대 정보는 각 구간의 최소금액(10,000원 이상 ~ 20,000 미만인 구간인 경우 10,000)으로 표시해주세요. 결과는 가격대를 기준으로 오름차순 정렬해주세요.
SELECT FLOOR(PRICE/10000) * 10000 AS PRICE_GROUP,
        COUNT(*) AS PRODUCTS
    FROM PRODUCT
    GROUP BY PRICE_GROUP
    ORDER BY PRICE_GROUP;

-- 조건에 부합하는 중고거래 상태 조회하기
-- USED_GOODS_BOARD 테이블에서 2022년 10월 5일에 등록된 중고거래 게시물의 게시글 ID, 작성자 ID, 게시글 제목, 가격, 거래상태를 조회하는 SQL문을 작성해주세요. 거래상태가 SALE 이면 판매중, RESERVED이면 예약중, DONE이면 거래완료 분류하여 출력해주시고, 결과는 게시글 ID를 기준으로 내림차순 정렬해주세요.
SELECT BOARD_ID, WRITER_ID, TITLE, PRICE, 
        CASE WHEN STATUS = 'SALE' THEN '판매중'
            WHEN STATUS = 'RESERVED' THEN '예약중'
            WHEN STATUS = 'DONE' THEN '거래완료'
            ELSE '' END AS 'STATUS'
    FROM USED_GOODS_BOARD
    WHERE CREATED_DATE = '2022-10-05'
    ORDER BY BOARD_ID DESC;

-- 3월에 태어난 여성 회원 목록 출력하기
-- MEMBER_PROFILE 테이블에서 생일이 3월인 여성 회원의 ID, 이름, 성별, 생년월일을 조회하는 SQL문을 작성해주세요. 이때 전화번호가 NULL인 경우는 출력대상에서 제외시켜 주시고, 결과는 회원ID를 기준으로 오름차순 정렬해주세요.
SELECT MEMBER_ID, MEMBER_NAME, GENDER, DATE_FORMAT(DATE_OF_BIRTH,'%Y-%m-%d') AS DATE_OF_BIRTH
    FROM MEMBER_PROFILE
    WHERE GENDER = 'W' AND MONTH(DATE_OF_BIRTH) = 3 AND TLNO IS NOT NULL
    ORDER BY MEMBER_ID;

-- 재구매가 일어난 상품과 회원 리스트 구하기
-- ONLINE_SALE 테이블에서 동일한 회원이 동일한 상품을 재구매한 데이터를 구하여, 재구매한 회원 ID와 재구매한 상품 ID를 출력하는 SQL문을 작성해주세요. 결과는 회원 ID를 기준으로 오름차순 정렬해주시고 회원 ID가 같다면 상품 ID를 기준으로 내림차순 정렬해주세요.
SELECT USER_ID, PRODUCT_ID
    FROM ONLINE_SALE
    GROUP BY USER_ID, PRODUCT_ID
    HAVING COUNT(ONLINE_SALE_ID)>=2
    ORDER BY USER_ID ASC, PRODUCT_ID DESC;

-- 자동차 평균 대여 기간 구하기
-- CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서 평균 대여 기간이 7일 이상인 자동차들의 자동차 ID와 평균 대여 기간(컬럼명: AVERAGE_DURATION) 리스트를 출력하는 SQL문을 작성해주세요. 평균 대여 기간은 소수점 두번째 자리에서 반올림하고, 결과는 평균 대여 기간을 기준으로 내림차순 정렬해주시고, 평균 대여 기간이 같으면 자동차 ID를 기준으로 내림차순 정렬해주세요.
SELECT CAR_ID, 
        ROUND(AVG(DATEDIFF(END_DATE, START_DATE) + 1),1) AS AVERAGE_DURATION
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
    GROUP BY CAR_ID 
    HAVING AVERAGE_DURATION>= 7
    ORDER BY AVERAGE_DURATIONDESC, CAR_ID DESC;

-- 상품별 오프라인 매출 구하기
-- PRODUCT 테이블과 OFFLINE_SALE 테이블에서 상품코드 별 매출액(판매가 * 판매량) 합계를 출력하는 SQL문을 작성해주세요. 결과는 매출액을 기준으로 내림차순 정렬해주시고 매출액이 같다면 상품코드를 기준으로 오름차순 정렬해주세요.
SELECT A.PRODUCT_CODE, SUM(A.PRICE * B.SALES_AMOUNT) AS SALES
    FROM PRODUCT A JOIN OFFLINE_SALE B ON A.PRODUCT_ID = B.PRODUCT_ID
    GROUP BY A.PRODUCT_CODE
    ORDER BY SALES DESC, A.PRODUCT_CODE;

-----------------------------------------------------------------------------------------------

/* Lv.3 */
-- 오랜 기간 보호한 동물 찾기(2)
-- `ANIMAL_OUTS` 테이블의 `ANIMAL_ID`는 `ANIMAL_INS`의 `ANIMAL_ID`의 외래 키입니다. 입양을 간 동물 중, 보호 기간이 가장 길었던 동물 두 마리의 아이디와 이름을 조회하는 SQL문을 작성해주세요. 이때 결과는 보호 기간이 긴 순으로 조회해야 합니다.
SELECT I.ANIMAL_ID, I.NAME
	FROM ANIMAL_INS AS I
	JOIN ANIMAL_OUTS AS O
	ON O.ANIMAL_ID = I.ANIMAL_ID
	ORDER BY (O.DATETIME - I.DATETIME) DESC
	LIMIT 2;

-- 조건별로 분류하여 주문상태 출력하기
-- FOOD_ORDER 테이블에서 5월 1일을 기준으로 주문 ID, 제품 ID, 출고일자, 출고여부를 조회하는 SQL문을 작성해주세요. 출고여부는 5월 1일까지 출고완료로 이 후 날짜는 출고 대기로 미정이면 출고미정으로 출력해주시고, 결과는 주문 ID를 기준으로 오름차순 정렬해주세요.
SELECT ORDER_ID, PRODUCT_ID, DATE_FORMAT(OUT_DATE, '%Y-%m-%d') AS OUT_DATE,
    CASE WHEN OUT_DATE IS NULL THEN '출고미정'
        WHEN DATE_FORMAT(OUT_DATE, '%Y-%m-%d') <= '2022-05-01' THEN '출고완료'
        WHEN DATE_FORMAT(OUT_DATE, '%Y-%m-%d') > '2022-05-01' THEN '출고대기'
        END AS '출고여부'
    FROM FOOD_ORDER
    ORDER BY ORDER_ID ASC;

-- 조건에 맞는 사용자 정보 조회하기
-- USED_GOODS_BOARD와 USED_GOODS_USER 테이블에서 중고 거래 게시물을 3건 이상 등록한 사용자의 사용자 ID, 닉네임, 전체주소, 전화번호를 조회하는 SQL문을 작성해주세요. 이때, 전체 주소는 시, 도로명 주소, 상세 주소가 함께 출력되도록 해주시고, 전화번호의 경우 xxx-xxxx-xxxx 같은 형태로 하이픈 문자열(-)을 삽입하여 출력해주세요. 결과는 회원 ID를 기준으로 내림차순 정렬해주세요.
SELECT B.USER_ID, B.NICKNAME, 
    CONCAT(B.CITY,' ',B.STREET_ADDRESS1,' ',B.STREET_ADDRESS2) AS '전체주소',
    CONCAT(LEFT(B.TLNO,3),'-',SUBSTR(B.TLNO,4,4),'-',RIGHT(B.TLNO,4)) AS '전화번호'
    FROM USED_GOODS_BOARD A JOIN USED_GOODS_USER B
        ON A.WRITER_ID = B.USER_ID
    GROUP BY B.USER_ID HAVING COUNT(A.BOARD_ID) >= 3
    ORDER BY B.USER_ID DESC;

-- 대여 기록이 존재하는 자동차 리스트 구하기
-- CAR_RENTAL_COMPANY_CAR 테이블과 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서 자동차 종류가 '세단'인 자동차들 중 10월에 대여를 시작한 기록이 있는 자동차 ID 리스트를 출력하는 SQL문을 작성해주세요. 자동차 ID 리스트는 중복이 없어야 하며, 자동차 ID를 기준으로 내림차순 정렬해주세요.
SELECT DISTINCT(A.CAR_ID) AS CAR_ID
    FROM CAR_RENTAL_COMPANY_CAR A JOIN CAR_RENTAL_COMPANY_RENTAL_HISTORY B
    ON A.CAR_ID = B.CAR_ID
    WHERE A.CAR_TYPE = '세단' AND DATE_FORMAT(B.START_DATE, '%m') = 10
    ORDER BY CAR_ID DESC;

-- 조회수가 가장 많은 중고거래 게시판의 첨부파일 조회하기
-- USED_GOODS_BOARD와 USED_GOODS_FILE 테이블에서 조회수가 가장 높은 중고거래 게시물에 대한 첨부파일 경로를 조회하는 SQL문을 작성해주세요. 첨부파일 경로는 FILE ID를 기준으로 내림차순 정렬해주세요. 기본적인 파일경로는 /home/grep/src/ 이며, 게시글 ID를 기준으로 디렉토리가 구분되고, 파일이름은 파일 ID, 파일 이름, 파일 확장자로 구성되도록 출력해주세요. 조회수가 가장 높은 게시물은 하나만 존재합니다.
SELECT CONCAT('/home/grep/src/',BOARD_ID,'/',FILE_ID,FILE_NAME,FILE_EXT) AS FILE_PATH
    FROM USED_GOODS_FILE
    WHERE BOARD_ID = (SELECT BOARD_ID
            FROM USED_GOODS_BOARD
            ORDER BY VIEWS DESC LIMIT 1)
    ORDER BY FILE_ID DESC;

-- 있었는데요 없었습니다
-- 관리자의 실수로 일부 동물의 입양일이 잘못 입력되었습니다. 보호 시작일보다 입양일이 더 빠른 동물의 아이디와 이름을 조회하는 SQL문을 작성해주세요. 이때 결과는 보호 시작일이 빠른 순으로 조회해야합니다.
SELECT I.ANIMAL_ID, I.NAME
    FROM ANIMAL_INS I JOIN ANIMAL_OUTS O
    ON I.ANIMAL_ID = O.ANIMAL_ID
    WHERE I.DATETIME > O.DATETIME
    ORDER BY I.DATETIME ASC;

-- 카테고리별 도서 판매량 집계하기
-- 2022년 1월의 카테고리 별 도서 판매량을 합산하고, 카테고리, 총 판매량 리스트를 출력하는 SQL문을 작성해주세요. 결과는 카테고리명을 기준으로 오름차순으로 정렬해주세요.
SELECT A.CATEGORY, SUM(B.SALES) AS TOTAL_SALES
    FROM BOOK A JOIN BOOK_SALES B
    ON A.BOOK_ID = B.BOOK_ID
    WHERE DATE_FORMAT(B.SALES_DATE, '%Y-%m') = '2022-01' 
    GROUP BY A.CATEGORY
    ORDER BY A.CATEGORY ASC;

-- 조건에 맞는 사용자와 총 거래금액 조회하기
-- USED_GOODS_BOARD와 USED_GOODS_USER 테이블에서 완료된 중고 거래의 총금액이 70만 원 이상인 사람의 회원 ID, 닉네임, 총거래금액을 조회하는 SQL문을 작성해주세요. 결과는 총거래금액을 기준으로 오름차순 정렬해주세요.
SELECT B.USER_ID, B.NICKNAME, SUM(A.PRICE) AS TOTAL_SALES
    FROM USED_GOODS_BOARD A JOIN USED_GOODS_USER B
    ON A.WRITER_ID = B.USER_ID
    WHERE A.STATUS = 'DONE'
    GROUP BY A.WRITER_ID
    HAVING SUM(A.PRICE) >= 700000
    ORDER BY TOTAL_SALES;

-- 대여 횟수가 많은 자동차들의 월별 대여 횟수 구하기
-- CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서 대여 시작일을 기준으로 2022년 8월부터 2022년 10월까지 총 대여 횟수가 5회 이상인 자동차들에 대해서 해당 기간 동안의 월별 자동차 ID 별 총 대여 횟수(컬럼명: RECORDS) 리스트를 출력하는 SQL문을 작성해주세요. 결과는 월을 기준으로 오름차순 정렬하고, 월이 같다면 자동차 ID를 기준으로 내림차순 정렬해주세요. 특정 월의 총 대여 횟수가 0인 경우에는 결과에서 제외해주세요.
--> 5회 이상 빌린 자동차들을 구함 -> 그 자동차들의 대여 횟수 파악
SELECT MONTH(START_DATE) AS MONTH, CAR_ID, COUNT(HISTORY_ID) AS RECORDS
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
    WHERE MONTH(START_DATE) IN ('8','9','10')
    AND CAR_ID IN 
        (SELECT CAR_ID
        FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
        WHERE MONTH(START_DATE) IN ('8','9','10')
        GROUP BY CAR_ID
        HAVING COUNT(*) >= 5)
    GROUP BY MONTH(START_DATE), CAR_ID HAVING RECORDS > 0
    ORDER BY MONTH ASC, CAR_ID DESC;

-----------------------------------------------------------------------------------------------

/* Lv.4 */
-- 서울에 위치한 식당 목록 출력하기
-- REST_INFO와 REST_REVIEW 테이블에서 서울에 위치한 식당들의 식당 ID, 식당 이름, 음식 종류, 즐겨찾기수, 주소, 리뷰 평균 점수를 조회하는 SQL문을 작성해주세요. 이때 리뷰 평균점수는 소수점 세 번째 자리에서 반올림 해주시고 결과는 평균점수를 기준으로 내림차순 정렬해주시고, 평균점수가 같다면 즐겨찾기수를 기준으로 내림차순 정렬해주세요.
SELECT A.REST_ID, A.REST_NAME, A.FOOD_TYPE, 
    A.FAVORITES, A.ADDRESS,
    ROUND(AVG(B.REVIEW_SCORE), 2) AS SCORE
    FROM REST_INFO A JOIN REST_REVIEW B
    ON A.REST_ID = B.REST_ID
    WHERE A.ADDRESS LIKE '서울%'
    GROUP BY A.REST_ID
    ORDER BY SCORE DESC, A.FAVORITES DESC;

-- 우유와 요거트가 담긴 장바구니
-- 데이터 분석 팀에서는 우유(Milk)와 요거트(Yogurt)를 동시에 구입한 장바구니가 있는지 알아보려 합니다. 우유와 요거트를 동시에 구입한 장바구니의 아이디를 조회하는 SQL 문을 작성해주세요. 이때 결과는 장바구니의 아이디 순으로 나와야 합니다.
SELECT CART_ID
    FROM CART_PRODUCTS
    WHERE CART_ID 
    IN (SELECT CART_ID
            FROM CART_PRODUCTS
            WHERE NAME = 'Milk')
    AND NAME = 'Yogurt'
    ORDER BY CART_ID;

-- 취소되지 않은 진료 예약 조회하기
-- PATIENT, DOCTOR 그리고 APPOINTMENT 테이블에서 2022년 4월 13일 취소되지 않은 흉부외과(CS) 진료 예약 내역을 조회하는 SQL문을 작성해주세요. 진료예약번호, 환자이름, 환자번호, 진료과코드, 의사이름, 진료예약일시 항목이 출력되도록 작성해주세요. 결과는 진료예약일시를 기준으로 오름차순 정렬해주세요.
SELECT A.APNT_NO, P.PT_NAME, A.PT_NO, A.MCDP_CD, D.DR_NAME, A.APNT_YMD
    FROM APPOINTMENT A 
        JOIN PATIENT P ON A.PT_NO = P.PT_NO
        JOIN DOCTOR D ON A.MDDR_ID = D.DR_ID
    WHERE DATE_FORMAT(A.APNT_YMD, '%Y-%m-%d') = '2022-04-13'
        AND D.MCDP_CD = 'CS' 
        AND A.APNT_CNCL_YN = 'N'
    ORDER BY A.APNT_YMD ASC;

-- 보호소에서 중성화한 동물
-- 보호소에서 중성화 수술을 거친 동물 정보를 알아보려 합니다. 보호소에 들어올 당시에는 중성화되지 않았지만, 보호소를 나갈 당시에는 중성화된 동물의 아이디와 생물 종, 이름을 조회하는 아이디 순으로 조회하는 SQL 문을 작성해주세요.
SELECT ANIMAL_ID, ANIMAL_TYPE, NAME
    FROM ANIMAL_OUTS
    WHERE SEX_UPON_OUTCOME NOT LIKE 'Intact%' 
        AND ANIMAL_ID 
            IN (SELECT ANIMAL_ID
                FROM ANIMAL_INS
                WHERE SEX_UPON_INTAKE LIKE 'Intact%')
    ORDER BY ANIMAL_ID;

-- 5월 식품들의 총매출 조회하기
-- FOOD_PRODUCT와 FOOD_ORDER 테이블에서 생산일자가 2022년 5월인 식품들의 식품 ID, 식품 이름, 총매출을 조회하는 SQL문을 작성해주세요. 이때 결과는 총매출을 기준으로 내림차순 정렬해주시고 총매출이 같다면 식품 ID를 기준으로 오름차순 정렬해주세요.
SELECT A.PRODUCT_ID, A.PRODUCT_NAME, 
		A.PRICE * SUM(B.AMOUNT) AS TOTAL_SALES
    FROM FOOD_PRODUCT A JOIN FOOD_ORDER B
    ON A.PRODUCT_ID = B.PRODUCT_ID
    WHERE DATE_FORMAT(B.PRODUCE_DATE,'%Y%m')='202205'
    GROUP BY A.PRODUCT_ID
    ORDER BY TOTAL_SALES DESC, A.PRODUCT_ID ASC;

-- 주문량이 많은 아이스크림들 조회하기
-- 7월 아이스크림 총 주문량과 상반기의 아이스크림 총 주문량을 더한 값이 큰 순서대로 상위 3개의 맛을 조회하는 SQL 문을 작성해주세요.
SELECT FLAVOR
FROM 
    (
    SELECT FLAVOR, TOTAL_ORDER
    FROM FIRST_HALF
    UNION ALL
    SELECT FLAVOR, TOTAL_ORDER
    FROM JULY
    ) A
GROUP BY FLAVOR
ORDER BY SUM(TOTAL_ORDER) DESC
LIMIT 3;
--> UNION ALL 사용하지 않고 SUM으로 풀면 FIRST_HALF 테이블의 3100이 2번 더해짐
--> STARAWBERRY가 FIRST_HALF에는 1개, JULY에는 2개 행이 있기 때문

-- 그룹별 조건에 맞는 식당 목록 출력하기
-- MEMBER_PROFILE와 REST_REVIEW 테이블에서 리뷰를 가장 많이 작성한 회원의 리뷰들을 조회하는 SQL문을 작성해주세요. 회원 이름, 리뷰 텍스트, 리뷰 작성일이 출력되도록 작성해주시고, 결과는 리뷰 작성일을 기준으로 오름차순, 리뷰 작성일이 같다면 리뷰 텍스트를 기준으로 오름차순 정렬해주세요.
--> 리뷰 개수 1위인 회원을 찾고 회원의 리뷰 조회
SELECT A.MEMBER_NAME, B.REVIEW_TEXT, DATE_FORMAT(B.REVIEW_DATE, '%Y-%m-%d') AS REVIEW_DATE
    FROM MEMBER_PROFILE A 
        JOIN REST_REVIEW B 
        ON A.MEMBER_ID = B.MEMBER_ID 
    WHERE A.MEMBER_ID 
        = (SELECT MEMBER_ID
            FROM REST_REVIEW
            GROUP BY MEMBER_ID
            ORDER BY COUNT(REST_ID) DESC 
            LIMIT 1)
    ORDER BY REVIEW_DATE ASC, REVIEW_TEXT ASC;

-- 년, 월, 성별 별 상품 구매 회원 수 구하기
-- USER_INFO 테이블과 ONLINE_SALE 테이블에서 년, 월, 성별 별로 상품을 구매한 회원수를 집계하는 SQL문을 작성해주세요. 결과는 년, 월, 성별을 기준으로 오름차순 정렬해주세요. 이때, 성별 정보가 없는 경우 결과에서 제외해주세요.
SELECT YEAR(B.SALES_DATE) AS YEAR, 
        MONTH(B.SALES_DATE) AS MONTH, A.GENDER,
        COUNT(DISTINCT(B.USER_ID)) AS USERS
    FROM USER_INFO A JOIN ONLINE_SALE B
    ON A.USER_ID = B.USER_ID
    WHERE A.GENDER IS NOT NULL
    GROUP BY YEAR, MONTH, A.GENDER
    ORDER BY YEAR, MONTH, A.GENDER;

-- 저자별 카테고리별 매출액 집계하기
-- 2022년 1월의 도서 판매 데이터를 기준으로 저자 별, 카테고리 별 매출액(TOTAL_SALES = 판매량 * 판매가) 을 구하여, 저자 ID(AUTHOR_ID), 저자명(AUTHOR_NAME), 카테고리(CATEGORY), 매출액(SALES) 리스트를 출력하는 SQL문을 작성해주세요.결과는 저자 ID를 오름차순으로, 저자 ID가 같다면 카테고리를 내림차순 정렬해주세요.
SELECT B.AUTHOR_ID, A.AUTHOR_NAME, B.CATEGORY, SUM(B.PRICE * BS.SALES) AS TOTAL_SALES
    FROM BOOK B
        JOIN AUTHOR A USING (AUTHOR_ID)
        JOIN BOOK_SALES BS USING (BOOK_ID)
    WHERE DATE_FORMAT(BS.SALES_DATE, '%Y%m') = '202201'
    GROUP BY B.AUTHOR_ID, B.CATEGORY
    ORDER BY B.AUTHOR_ID ASC, B.CATEGORY DESC;

-----------------------------------------------------------------------------------------------