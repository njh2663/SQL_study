/* CREATE */
-- CREATE TABLE 테이블이름(속성1 타입 (제약조건), 속성2 타입 (제약조건));

/* INSERT */
-- INSERT INTO 테이블이름(속성1, 속성2) VALUES(속성값1, 속성값2);

/* ALTER */
-- ALTER TABLE 테이블이름 ADD 속성이름 데이터타입;
-- ALTER TABLE 테이블이름 MODIFY 컬럼명 데이터타입;
-- ALTER TABLE 테이블이름 DROP COLUMN 컬럼명;
-- ALTER TABLE 테이블이름 CHANGE COLUMN 기존컬럼명 바꿀컬럼명 컬럼타입;

/* SELECT */
-- SELECT 속성이름 FROM 테이블이름 WHERE 조건;

/* UPDATE */
-- UPDATE 테이블이름 SET 속성이름=속성값 WHERE 속성이름=속성값;

/* DELETE */
-- DELETE FROM 테이블이름;

-----------------------------------------------------------------------------------------------

/* 실습 */
CREATE TABLE TEST(
	ID INT NOT NULL,
	NAME VARCHAR(5) PRIMARY KEY,
	GAME VARCHAR(5) UNIQUE
	);

INSERT INTO TEST VALUES (2,'A',NULL); -- UNIQUE는 NULL이 가능함
INSERT INTO TEST VALUES (3,'C',NULL);

SELECT * 
	FROM TEST;

-- INSERT INTO TEST VALUES (NULL,'B',NULL); -- ID는 NOT NULL이어야 함
-- INSERT INTO TEST VALUES (2,NULL,'A');    -- NAME은 PK로 NOT NULL이어야 함
-- INSERT INTO TEST VALUES (2,'A','A');     -- NAME은 PK로 중복 불가능
-- INSERT INTO TEST (ID, GAME) VALUES (1,'AA'); 
-- NAME을 언급하지 않았는데 이는 NULL을 입력한다는 의미임, PK에 NULL이 들어가 오류

-----------------------------------------------------------------------------------------------

/* 실습 */
CREATE TABLE TEST(
		ID INT NOT NULL,
		NAME VARCHAR(10),
		CREATED DATE NOT NULL,
		PRIMARY KEY(ID) -- ID를 PK로 설정
		);

INSERT INTO TEST VALUES(1,'A','2024-04-09');
INSERT INTO TEST VALUES(2,'B','2024-01-01');

SELECT * 
	FROM TEST;

-- INSERT INTO TEST VALUES(1,'C','2023-01-03'); -- ID는 PK로 중복 불가능

-----------------------------------------------------------------------------------------------

/* 실습 */
CREATE TABLE TEST(
	ID VARCHAR(10),
	MATH NUMERIC(5,1)
);

INSERT INTO TEST VALUES('1',99);
INSERT INTO TEST VALUES('2',80);

SELECT * 
	FROM TEST 
	WHERE MATH >= 90;

-----------------------------------------------------------------------------------------------

/* 실습 */
CREATE TABLE TEST(
    ID VARCHAR(10), 
    MATH NUMERIC(10,1)
    );

INSERT INTO TEST VALUES ('1',19);
INSERT INTO TEST VALUES ('2',40);

ALTER TABLE TEST ADD SEX CHAR(10);  -- SEX 컬럼 추가
ALTER TABLE TEST MODIFY SEX VARCHAR(10); -- 데이터 타입 변경, 비어있는 열만 변경할 수 있음
ALTER TABLE TEST DROP COLUMN MATH;  -- MATH 컬럼 삭제
ALTER TABLE TEST CHANGE ID AAA VARCHAR(10); -- 컬럼명 변경, ID를 AAA로 변경

SELECT * 
	FROM TEST;

-----------------------------------------------------------------------------------------------

/* 실습 */
CREATE TABLE TEST( 
	ID         VARCHAR(100), 
	FIRST_NAME VARCHAR(100), 
	LAST_NAME  VARCHAR(100) 
	); 

INSERT INTO TEST (ID, FIRST_NAME, LAST_NAME) VALUES ('1', 'John', 'Snow'); 
INSERT INTO TEST (ID, FIRST_NAME, LAST_NAME) VALUES ('2', 'Mike', 'Tyson'); 
INSERT INTO TEST (ID, FIRST_NAME, LAST_NAME) VALUES ('3', 'Bill', 'Keaton');

UPDATE TEST SET ID='10' WHERE ID='1';  -- ID가 1인 행의 ID를 10으로 변경
DELETE FROM TEST WHERE ID='3';  -- ID가 3인 행 제거

SELECT *
	FROM TEST
