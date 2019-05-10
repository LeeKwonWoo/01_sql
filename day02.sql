-- DAY 02
-- SCOTT 계정 EMP 테이블 조회
SELECT *
  FROM emp
;

-- SCOTT 계정 DEPT 테이블 조회
SELECT *
  FROM dept
;

-- 1) emp 테이블에서 job 컬럼을 조회
SELECT job
  FROM emp
;

/*
JOB
-----------
CLERK
SALESMAN
SALESMAN
MANAGER
SALESMAN
MANAGER
MANAGER
PRESIDENT
SALESMAN
CLERK
ANALYST
CLERK
*/

-- 2) emp 테이블에서 중복을 제거하여
-- job 컬럼을 조회
SELECT DISTINCT job
  FROM emp
;
-- => 각 JOB이  한번씩만 조회된 결과
-- 를 얻을 수 있다.
-- 이 결과로 회사에는 다섯 종류의
-- JOB 이 있음을 확인할 수 있다.

/* 다중 행 주석
---------
CLERK
SALESMAN
ANALYST
MANAGER
PRESIDENT
*/

