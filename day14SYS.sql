-- day14 view

-----------------------------------------------------------------
-- VIEW : 논리적으로만 존재하는 가상 테이블
-- 1. SYS접속
CONN sys as sysdba;
-- 2. SCOTT 계정에 VIEW 생성 권한 설정
--- (1) 접속 탭
--- (2) sys 계정의 다른 사용자
--- (3) SCOTT 에서 오른쪽 클릭
--- (4) 사용자 편집
--- (5) 시스템 권한 탭
--- (6) CREATE VIEW 권한이 부여됨 체크박스 선택 -> 적용
GRANT CREATE VIEW TO SCOTT;

-- 3. SCOTT으로 접속
CONN SCOTT/TIGER;

--------------------------------------------------------------------------------------------
-- 1. emp, dept 테이블 복사
DROP TABLE new_emp;

CREATE TABLE new_emp
AS
SELECT e.*
  FROM emp e
 WHERE 1 = 1
;
DROP TABLE new_dept;

CREATE TABLE new_dept
AS
SELECT d.*
  FROM dept d
 WHERE 1 = 1
;

-- 2. 복사테이블에는 pk 설정이 누락되어 있으므로 pk 설정을 ALTER로 추가

/*
    new_dept : PK_NEW_DEPT , deptno 컬럼을 PRIMARY KEY 로 설정
    new_emp  : PK_NEW_EMP , empno 컬럼을 PRIMARY KEY 로 설정
               FK_NEW_DEPTNO, deptno 컬럼을 FOREIGN KEY 로 설정
               new_dept 테이블의 deptno 컬럼을 RESFERENCES 하도록 설정
               FK_MGR     , mgr 컬럼을 FOREIGN KEY 로 설정
               new_emp 테이블의 empno 컬럼을 REFERENCES 하도록 설정
*/
-- 3. 복사 테이블을 기본 테이블로 하는 VIEW 를 생성
--      : 직원의 기본 정보 + 상사의 이름 + 부서이름 + 부서명 + 부서위치 까지 조회가능한 뷰
CREATE OR REPLACE VIEW v_emp_dept
AS
SELECT e.empno
     , e.ename
     , e1.ename as mgr_name
     , e.deptno
     , d.dname
     , d.loc
  FROM new_emp e
     , new_dept d
     , new_emp e1
 WHERE e.deptno = d.deptno(+)
   AND e.mgr = e1.empno(+)
WITH READ ONLY
;

-- 조인이 걸린 결과를 일반 테이블에 조회하듯 뷰를 통해 조회 가능
SELECT v.*
  FROM v_emp_dept v
;

SELECT v.empno
     , v.ename
     , v.dname
     , v.loc
  FROM v_emp_dept v
;
-- 4. VIEW 가 생성되면 user_views 라는 시스템 테이블에 정보가 추가되는

SELECT v.view_name
     , v.read_only
  FROM user_views v
;

-- 5. 생성된 뷰에서 DQL 조회
--- 1) 부서명이 SALES 인 부서 소속 직원을 조회
SELECT v.*
  FROM v_emp_dept v
 WHERE v.dname = 'SALES'
;
--- 2) 부서명이 NULL 인 직원을 조회
SELECT v.*
  FROM v_emp_dept v
 WHERE v.dname IS NULL
;
--- 3) 상사(매니저,mgr)가 NULL 인 직원을 조회

SELECT v.*
  FROM v_emp_dept v
 WHERE v.mgr_name IS NULL
;

