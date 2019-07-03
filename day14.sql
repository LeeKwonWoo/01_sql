-- day14 : dml 계속

------------------------------------------------------------------------------------------
-- 3) DELETE : 테이블에서 행단위로 데이터를 삭제

-- DELETE 구문 구조
DELETE [FROM] 테이블이름
 WHERE 문장
;

--- 1. WHERE 조건이 있는 DELETE 구문
-- 삭제전 커밋
COMMIT;

-- member 테이블에서 gender 'F' 인 데이터를 삭제

DELETE member m
 WHERE m.gender = 'F'
;

ROLLBACK;

DELETE member m
 WHERE m.member_id = 'M004'
;
COMMIT;
-- 3. DELETE 의 WHERE 에 서브쿼리 조합
-- 예) 주소가 '아산시' 인 사람을 모두 삭제
DELETE member m
 WHERE m.address = '아산시'
;

SELETE m.member_id
  FROM member m
 WHERE m.address = '아산시'

--- new_member 를 TRUNCATE 로 잘라내보자.
--TRUNCATE 실행후 에 되돌아갈 COMMIT 실행

TRUNCATE new_member;

---------------------------------------------------------------------------
-- TCL : Transaction control Language

-- 1) COMMIT :
-- 2) ROLLBACK :
-- 3) SAVEPOINT :
--- 1. member 테이블에 1행을 추가
---- 1.1 INSERT 전에 커밋지점 생성
COMMIT;
---- 1.2 DML : INSERT 작업 실행
INSERT INTO member m (m.member_id, m.member_name) VALUES ('M010','홍길동');

---- 1.3 1행 추가까지 중간상태 저장
SAVEPOINT do_insert;
--- 2. 홍길동의 주소를 업데이트
---- 2.1 DML : UPDATE 작업 실행
UPDATE member m
   SET m.address = '율도국'
 WHERE m.member_id = 'M010'
;

---- 2.2. 주소 수정까지 중간 저장
SAVEPOINT do_update_addr;

--- 3. 홍길동의 전화번호 업데이트
---- 3.1 DML : UPDATE 작업 실행
UPDATE member m
   SET m.phone = '9999'
 WHERE m.member_id = 'M010'
;

---- 3.2. 전화번호 수정까지 중간 저장
SAVEPOINT do_update_phone;

--- 4. 홍길동의 성별 업데이트
---- 4.1 DML : UPDATE 작업실행
UPDATE member m
   SET m.gender = 'F'
 WHERE m.member_id = 'M010'
;

---- 4.2 성별 수정까지 중간 저장
SAVEPOINT do_update_gender;
-- 여기까지 하나의 트랜잭으로 4개의 DML 쿼리 묶여 있는 상황
-- 아직 COMMIT 되지 않았으므로 트랜잭션의 정상종료가 아닌 상황
--------------------------------------------------------------------
-- 홍길동의 데이터 ROLLBACK 시나리오
-- 1. 주소 수정까지는 맞는데, 전화번호, 성별을 잘못수정했다고 착각
--- 사실은 성별만 잘못 수정
--- : 되돌아갈 SAVEPOINT = do_update_addr
ROLLBACK do_update_addr;

-- 2. 주소, 전화번호 수정까지는 맞았고, 성별 수정만 잘못되었음.
ROLLBACK do_update_phone;
-- SAVEPOINT 에는 순서가 있다. do_update_addr 이 do_update_phone 보다 앞서 생성된 지점이기때문에 여기까지 ROLLBACK_TO 가일어나면
-- 그 후 생성된 SAVEPOINT 는 모두 삭제됨.

-- 3. 2번의 ROLLBACK TO 수행후에 되돌릴 수 있는 지점
ROLLBACK TO do_insert; -- insert 후 지점
ROLLBACK;               -- 최초 시작 시점
---------------------------------------------------------------------------------------
-- 기타 객체 : SEQUENCE, INDEX, VIEW

-- SEQUENCE : 기본 키(PK) 등으로 사용되는 일련번호 생성 객체
-- 1. 시작번호 : 1, 최대 : 30, 사이클이 없는 시퀀스 생성

CREATE SEQUENCE seq_member_id
START WITH 1
MAXVALUE 30
NOCYCLE
;

-- 시퀀스는 객체이기떄문에 DDL 생성한다.
-- 시퀀스가 생성되면 시스템 카탈로그에 저장된다.
-- user_sequences
SELECT s.sequence_name
     , s.min_value
     , s.max_value
     , s.cycle_flag
     , s.increment_by
  FROM user_sequences s
 WHERE s.sequence_name = 'SEQ_MEMBER_ID'
;
/*
메타 데이터를 저장한느 유저 딕셔너리
무결성 제약조건 : user_constraints
시퀀스 생성정보 : user_sequences
테이블 생성정보 : user_tables
인덱스 생성정보 : user_indexes
객체들 생성정보 : user_objects

*/

-- 2. 시퀀스 사용
-- : 생성된 시퀀스는SELECT 구문에서 사용가능
-- (1) NEXTVAL : 시퀀스의 다음 번호를 얻어냄
--                 CREATE 되고나서 반드시 최초 1번
--                  NEXTVAL 호출이 되어야 생성이 시작
--                  사용법: 시퀀스 이름.NEXTVAL
SELECT SEQ_MEMBER_ID.NEXTVAL
  FROM dual
;
-- (2) CURRBAL : 시퀀스에서 현재 생성된 번호를 확인
--               시퀀스 생성 후 최초 1번의 NEXTVAL 호출이 없으면
--               현재의 번호를 얻을 수 있음.
--               즉, 시퀀스는 아직 비활성화 상태
--               사용법: 시퀀스이름 CURRVAL

SELECT SEQ_MEMBER_ID.CURRVAL
  FROM dual
;

-- 3. 시퀀스  : ALTER 
ALTER SEQUENCE SEQ_MEMBER_ID
NOMAXVALUE
;

-- SEQ_MEMBER_ID 의 INCREAMENT를 10으로 변경하려면
ALTER SEQUENCE SEQ_MEMBER_ID
INCREMENT BY 10
;

-- 4. 시퀀스 삭제
DROP SEQUENCE seq_member_id;

SELECT SEQ_MEMBER_ID.CURRVAL
  FROM dual
;

-- new_member 테이블에 데이터 입력시 시퀀스 활용
-- new_member 의 id 컬럼에 사용할 시퀀스 신규 생성
/*
시퀀스 이름: seq_new_member_id
시작 번호 : START WITH 1
증가 값: INCREMENT BY 1
최대 번호 : NOMAXVALUE
사이클여부 : NOCYCLE
*/
CREATE SEQUENCE seq_new_member_id
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCYCLE
;

-- new_member 의 member_id 를 M001, M002 증가한는 형태로 조합
SELECT 'M' || LPAD(SEQ_NEW_MEMBER_ID.NEXTVAL,3,0) as member_id
  FROM dual
;
INSERT INTO new_member (member_id, member_name)
VALUES ('M' || LPAD(SEQ_NEW_MEMBER_ID.NEXTVAL,3,0) , '홍길동')
;

INSERT INTO new_member (member_id, member_name)
VALUES ('M' || LPAD(SEQ_NEW_MEMBER_ID.NEXTVAL,3,0) , '허균')
;
COMMIT;

----------------------------------------------------------------------
-- INDEX : 데이터의 검색(조회)시 일정한 검색 속도 보장을 위해 DBMS 가 관리하는 객체

-- 1. user_indexes 테이블에서 이미 존재하는 INDEX 조회
SELECT i.index_name
     , i.index_type
     , i.table_name
     , i.include_column
  FROM user_indexes i
;

-- 2. 테이블의 주키 (primary key) 컬럼에 대해서는 dbms 가
--    자동으로 인덱스 생성함을 알 수 있음.
--    unique 에 대해서도 인데스를 자동으로 생성함
--    한 번 인덱스가 생성된 컬럼에 대해서는 중복 생성 불가능
--    예) memeber 테이블의 member_id 컬럼에 대해 인뎃스 생성시도

CREATE INDEX idx_member_id
ON member (member_id)
;

-- 3. 복사 테이블 new_member 에는 pk 가 없기떄문에 인덱스도 없는 상태
-- (1) new_member의 member_id 컬럼에 인덱스 생성
CREATE INDEX idx_new_member_id
ON new_member (member_id)
;

DROP INDEX idx_new_member_id;

-- DESC 정렬로 생성
CREATE INDEX idx_new_member_id
ON new_member (member_id DESC) 
;

-- 인덱스 대상 컬럼의 값이 unique 함이 확실하다면
-- unique index로  생성사능
CREATE INDEX idx_new_member_id
ON new_member (member_id DESC)
;

-- index 가 select에 사용될때
-- 빠른 검색을 위해서 명시적으로 SELELCT에 사용하는 경우 존재
-- HINT 절을 select 에 사용한다.

