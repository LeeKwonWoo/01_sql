-- day13

-----------------------------------------------------
-- 오라클의 특별한 컬럼 2가지
-- : 사용자가 만든 적 없어도 자동을 ㅗ제공되는 컬럼

-- 1. ROWID : 물리적으로 디스크에 저장된 위치를 가리키는 값
--        물리적 위치 미으로 한 행당 반드시 유일한 값을 수 밖에 없음
--        ORDER BY 절에 의해 변경되지 않는 값

-- 2. ROWNUM : 조회된 결과의 첫번째 행부터 1로 증가하는 값
------------------------------------------------------------------------

-- 예) emp 테이블의 'SMITH' 를 조회
SELECT e.empno
     , e.ename
  FROM emp e
 WHERE e.ename = 'SMITH'
;

-- ROWID 를 같이 조회

SELECT e.rowid
     , e.empno
     , e.ename
  FROM emp e
 WHERE e.ename = 'SMITH'
;

-- ROWNUM 를 같이 조회
SELECT rownum
     , e.empno
     , e.ename
  FROM emp e
 WHERE e.ename = 'SMITH'
;

-- ORDER BY 절에 의해 ROWNUM 이 변경되는 결과 확인
-- (1) ORDER BY 가 없을 때의 ROWNUM
SELECT rownum
     , e.empno
     , e.ename
  FROM emp e
;
-- (2) ename 순으로 오름차순 정렬 후 ROWNUM 값 확인
SELECT rownum
     , e.empno
     , e.ename
  FROM emp e
 ORDER BY e.ename
;

-- ==> ROWNUM 이 ORDER BY 결과에 영향을 받지 않는 것처럼 보일 수 있음.
--     SUB-QUERY 로 사용할 때 영향을 받음.
-- (3) SUB-QUERY 를 썼을 때 ROWNUM 의 값 확인
SELECT rownum
     , a.empno
     , a.ename
     , a.numrow
  FROM (SELECT rownum as numrow
        , e.empno
        , e.ename
        FROM emp e
        ORDER BY e.ename) a
;

-- 이름에 A 가 들어가는 사람들을 조회 (ORDER BY 없이)
SELECT ROWNUM
     , e.ename
  FROM emp e
 WHERE e.ename LIKE '%A%'
;

-- 이름에 A 가 들어가는 사람들을 이름순으로 정렬하여 조회
SELECT ROWNUM
     , e.ename
  FROM emp e
 WHERE e.ename LIKE '%A%'
 ORDER BY e.ename
;

-- 이름에 S 가 들어가는 사람들을 조회
-- 이떄, ROWNUM, ROWID 를 확인
SELECT ROWNUM
     , e.ROWID
     , e.ename
  FROM emp e
 WHERE e.ename LIKE '%S%'
 ORDER BY e.ename
;

-- 이름에 S가 들어가는 사람들의 조회 결과를
-- SUB-QUERY 로 감쌌을 때의 ROWNUM, ROWID 확인
SELECT ROWNUM
     , a.rowid
     , a.ename
  FROM (SELECT e.rowid
             , e.ename
          FROM emp e
         WHERE e.ename LIKE '%S%'
         ORDER BY e.ename) a
;

-- ROWNUM 으로 할 수 있는 쿼리
-- emp 에서 급여를 많이 받는 상위 5명을 조회하시오.

-- 1. 급여가 많은 역순 정렬
SELECT e.empno
     , e.ename
     , e.sal
  FROM emp e
 ORDER BY e.sal DESC
;

-- 2. 1의 결과를 SUB-QUERY 로 FROM 절에 사용하여
--    ROWNUM 을 같이 조회
SELECT ROWNUM
     , a.*
  FROM (SELECT e.empno
             , e.ename
             , e.sal
          FROM emp e
         ORDER BY e.sal DESC) a
;
-- 3. 그 때, ROWNUM <= 5 조건을 추가
SELECT ROWNUM
     , a.*
  FROM (SELECT e.empno
             , e.ename
             , e.sal
          FROM emp e
         ORDER BY e.sal DESC) a
 WHERE ROWNUM <= 5
;

--------------------------------------------------------------------------
-- DML : 데이터 조작어
--------------------------------------------------------------------------
-- 1) INSERT : 테이블에 데이터 행(row)을 추가하는 명령
-- MEMBER 테이블에 데이터 추가 진행
DROP TABLE member;
CREATE TABLE member
( member_id     VARCHAR2(4)     
 ,member_name   VARCHAR2(15)    NOT NULL
 ,phone         VARCHAR2(4)     -- NULL 허용하려면 제약조건을 안쓰면 된다.
 ,reg_date      DATE            DEFAULT sysdate
 ,address       VARCHAR2(30)
 ,major         VARCHAR2(50)
 ,birth_month   NUMBER(2)
 ,gender        VARCHAR2(1) CHECK (gender IN ('F','M'))
 , CONSTRAINT PK_MEMBER PRIMARY KEY (member_id)
 , CONSTRAINT CK_GENDER CHECK (gender IN ('F','M'))
 , CONSTRAINT CK_BIRTH  CHECK (BIRTH_MONTH BETWEEN 1 AND 12)
);

--- 1. INTO 구문에 컬럼이름 생략시 데이터 추가
--     : VALUES 절에 반드시 전체 컬럼의 데티어를 순서대로 모두 나열
INSERT INTO MEMBER VALUES ('M001', '박성협', '9155',sysdate, '수원시', '행정', 3, 'M');
INSERT INTO MEMBER VALUES ('M002', '오진오', '1418',sysdate, '군포시', '일어', 1, 'M');
INSERT INTO MEMBER VALUES ('M003', '이병현', '0186',sysdate, NULL,NULL, 3, 'M');
INSERT INTO MEMBER VALUES ('M004', '김문정', '1392',sysdate, '청주시', '일어', 3, 'F');
INSERT INTO MEMBER VALUES ('M005', '송지환', '0322',sysdate, '안양시', '제약', 3, NULL);
COMMIT;

-- GENDER 컬럼에 CHECK 제약조건을 위배하는 데이터 추가 시도
-- GENDER 컬럼에, 'F','M',NULL 외의 값을 추가하면
INSERT INTO MEMBER VALUES ('M006','홍길동','0001',sysdate,'율도국','도술',3,'G');
--ORA-02290: 체크 제약조건(SCOTT.CK_GENDER)이 위배되었습니다

-- BIRTH_MONTH 컬럼에 1~12 외의 숫자값 입력 시도
INSERT INTO MEMBER VALUES ('M006','홍길동','0001',sysdate,'율도국','도술',13,'G');
-- ORA-02290: 체크 제약조건(SCOTT.CK_BIRTH)이 위배되었습니다

-- MEMBER_NAME 에 NULL 입력 시도
INSERT INTO MEMBER VALUES ('M006',NULL,'0001',sysdate,'율도국','도술',13,'G');


--- 2. INTO 절에 컬럼 이름을 명시한 경우의 데이터 추가
--      : VALUES 절에 INTO 의 순서대로
--       값의 타입, 갯수를 맞추어서 작성

INSERT INTO MEMBER (member_id,member_name) VALUES('M007','김지원');
COMMIT;

INSERT INTO MEMBER (member_id,member_name,gender) VALUES('M008','김지우','M');
COMMIT;

-- 테이블 정의 순서와 상관없이 INRO 절에 컬럼을 나열할 수 있다.
INSERT INTO MEMBER (birth_month,member_name,member_id) VALUES(NULL,'유현동','M009');
COMMIT;

-- INTO 절의 컬럼 갯수와 VALUES 절의 값의 개수 불일치
INSERT INTO MEMBER (member_id,member_name) VALUES('M008','허균','M');
COMMIT;

-- INTO 결과 VALUES 절의 갯수는 같으나
-- 값의 타입이 일치하지 않을 때
-- 숫자 데이터 컬럼인 birth_month 에 '한양' 이라는 문자를
-- 추가하려 하는 시도
INSERT INTO MEMBER (member_id,member_name,birth_month) VALUES ('M010','허균','한양');
COMMIT;

-- 필수 입력 컬럼을 나열하지 않을 떄
-- member_id : PK, member_name : NOT NULL
INSERT INTO MEMBER (birth_month,address,gender) VALUES (12,'서귀포시','F');

--------------------------------------------------------------------------
-- 다중 행 입력 : SUB-QUERY 를 사용하여 가능

-- 구분구조
INSERT INTO 테이블 이름
SELECT 문장; --서브쿼리

/*
CREATE TABLE 테이블이름
AS
SELECT ...
: 서브쿼리의 데이터를 복사하면서 새 테이블을 생성

vs.

INSERT INTO 테이블이름
SELECT 문장;
: 이미 만들어진 테이블에 데이터만 복사해서 추가
*/

-- new_member 삭제
DROP TABLE new_member;

-- member 복사해서 테이블 생성
CREATE TABLE new_member
AS
SELECT a.*
  FROM member a
 WHERE 1 = 2
;

-- 다중 행 입력 서브쿼리로 new_member 테이블에 데이터 추가
-- 이름 가운데 글자가 '지'인 사람들의 정보를 추가
INSERT INTO NEW_MEMBER
SELECT a.*
  FROM member a
 WHERE a.member_name LIKE '_지_'
;
COMMIT;

-- 컬럼을 명시한 다중행 입력
INSERT INTO new_member (member_id,member_name,phone)
SELECT m.member_id
     , m.member_name
     , m.phone
  FROM member m
 WHERE m.member_id < 'M004'
;

-- new_member 에 추가된 행 모두 삭제
DELETE new_member;
COMMIT;

-- 멤버들의 출생 월 데이터 수정
UPDATE "SCOTT"."MEMBER"
SET BIRTH_MONTH = '2' 
WHERE MEMBER_ID = 'M002';
UPDATE "SCOTT"."MEMBER"
SET BIRTH_MONTH = '1'
WHERE BIRTH_ID = 'M007';
UPDATE "SCOTT"."MEMBER"
SET BIRTH_MONTH = '7'
WHERE BIRTH_ID = 'M008';
COMMIT;


-- 문제) new_member 테이블에
--       member 테이블로부터 데이터를 복사하여 다중행 입력을 하시오.
--       단, member 테이블의 데이터에서 birth_month 가
--       홀수달인 사람들만 조회하여 입력하시오.
INSERT INTO new_member (member_id,member_name,phone,birth_month)
SELECT m.member_id
     , m.member_name
     , m.phone
     , m.birth_month
  FROM member m
 WHERE MOD(m.birth_month,2) = 1 
;

------------------------------------------------------------------------
-- 2) UPDATE : 테이블의 행(레코드)을 수정
--             WHERE 조건절의 조합에 따라서

--             1행만 수정하거나 다중 행 수정이 가능
--             다중 행이 수정되는 경우는 매우 주의가 필요!!


-- 예) 홍길동의 이름을 수정시도
UPDATE 테이블이름
   SET 칼럼1 = 값1
     [,컬럼2 = 값2]
     ....
     [,컬럼n = 값n]
 [WHERE 조건]
;

-- 예) 홍길동의 이름을 수정 시도
UPDATE member m
   SET m.member_name = '길동이'
 WHERE m.member_id = 'M006'
;

-- 예) 김문정 멤버의 전화번호 뒷자리 업데이트
--     초기에 INSERT 시 NULL 로 데이터를 받지 않은 경우
--     후에 데이터 수정이 발생할 수 있다.
--     이런 경우 UPDATE 구문으로 처리.
UPDATE member m
   SET m.phone = '1392'
 WHERE m.member_id = 'M004'
;
COMMIT;

-- 예) 유현동(M009) 멤버의 전공을 수정
-- 역문컨
UPDATE member m
   SET m.major = '역문컨'
 WHERE m.member_id = 'M009' --실수로 WHERE 누락
;
COMMIT;
-- 직전 COMMIT까지 ROLLBACK 가능
ROLLBACK;


-- 다중 컬럼 업데이트 (2개 이상의 컬럼 한번에 업데이트)
-- 예) 김지우(M008) 멤버의 전화번호, 주소, 전공을 한번에 업데이트
-- SET 절에 업데이트 할 컬럼과 값을 나열
UPDATE member m
   SET m.major = '일어'
     , m.address = '아산시'
     , m.phone = '4119'
 WHERE m.member_id = 'M008'
;
COMMIT;

-- 예) '안양시'에 사는 '송지환' 멤버의 GENDER 값을 수정
--     WHERE 조건에 주소를 비교하는 구문을 쓰는 경우
UPDATE member m
   SET m.gender = 'M'
 WHERE m.address = '안양시'
;
ROLLBACK;
-- UPDATE 작성시에는 WHERE 조건절에 작성시 주의를 기울여야함.
-- 1행을 수정하는 목적이라면 반드시 PK 컬럼을 비교해야한다.

-- UPDATE 구문에 SELECT 서브쿼리를 사용
-- 예) 김지우(M008) 멤버의 major 를
--     오진오(M002) 멤버의 major 로 수정

-- 1) M008 의 major 를 구하는 SELECT
SELECT m.major
  FROM member m
 WHERE m.member_id = 'M008'
;

-- 2) M002 멤버의 major 를 수정하는 UPDATE 구문 작성
UPDATE member m
   SET m.major = ?
 WHERE m.member_id = 'M002'
;
-- 3) (1)의 결과를 (2) UPDATE 구문에 적용
UPDATE member m
   SET m.major = (SELECT m.major
                    FROM member m
                   WHERE m.member_id = 'M008')
 WHERE m.member_id = 'M002'
;

-- 만약 SET 절에 사용하는 서브쿼리의 결과가
-- 정확하게 1행 1열의 1개의 값이 아닌 경우 구문오류
UPDATE member m
   SET m.major = (SELECT m.major
                    FROM member m)
 WHERE m.member_id = 'M002'
;

-- UPDATE 시 제약조건 위반하는 경우
-- 예) M001 의 member_id 수정을 시도
--     : PK 컬럼 수정을 시도하는 경우
UPDATE member m
   SET m.member_id = 'M002'
 WHERE m.member_id = 'M001'
;

-- 예) NOT NULL 인 member_name 에 NULL 데이터로
--     업데이트를 시도하는 경우

-- 예) M001 데이터에 대해서
--     birth_month 를 -1로 수정시도
UPDATE member m
   SET m.birth_month = -1
 WHERE m.member_id = 'M001'
;

---------------------------------------------------------------------
-- 수업중 실습


-- 1) PHONE 컬럼이 NULL인 사람들 
-- 일괄적으로 '0000'으로 업데이트
-- : PK 로 걸 필요 없는 구문
UPDATE member m
   SET m.phone = '0000'
 WHERE m.phone IS NULL
;
-- 2) M001 멤버의 전공을
--    NULL 값으로 업데이트
--     pk 사용
UPDATE member m
   SET m.major = ''
 WHERE m.member_id = 'M001'
;
-- 3) address 컬럼이 NULL 인사람들 일괄적으로 '아산시'로업데이트
UPDATE member m
   SET m.address = '아산시'
 WHERE m.address IS NULL
;
-- 4) M009 멤버의 NULL 데이터를
--    모두 업데이트
--    PHONE : 3581
--    ADDRESS : 천안시
--    GENDER : M

UPDATE member m
   SET m.phone = '3581'
     , m.address = '천안시'
     , m.gender = 'M'
 WHERE m.member_id = 'M009'
;