-- day 05
-- (6) 연산자 7.연산자 우선순위

/*
 주어진 조건 3개
 1. mgr = 7698
 2. job = 'CLERK'
 3. sal > 1300
 
 이 조건의 조합 순서에 따라
 결과가 어떻게 달라지는지 확인해보자.
*/

-- 1) 매니저의 사번이 7698 이며, 직무는 'CLERK' 이거나
--    급여가 1300이 넘는 조건을 만족하는 직원의 정보를 조회
--    사번, 이름, 직무, 급여, 매니저사번

SELECT e.empno
     , e.ename
     , e.job
     , e.sal
     , e.mgr
  FROM emp e
 WHERE e.mgr = 7698
   AND e.job = 'CLERK'
    OR e.sal > 1300
;

/*
EMPNO,  ENAME,  JOB,        SAL,    MGR
--------------------------------------------
7499	ALLEN	SALESMAN	1600	7698
7566	JONES	MANAGER	    2975	7839
7698	BLAKE	MANAGER	    2850	7839
7782	CLARK	MANAGER	    2450	7839
7839	KING	PRESIDENT	5000	
7844	TURNER	SALESMAN	1500	7698
7900	JAMES	CLERK	    950	    7698
7902	FORD	ANALYST	    3000	7566
*/

-- 2) 매니저가 7698인 직원중에서
--    직무가 'CLERK' 이거나 급여가 1300이 넘는 조건을 만족하는
--    직원의 정보를 조회

SELECT e.empno
     , e.ename
     , e.job
     , e.sal
     , e.mgr
  FROM emp e
 WHERE e.mgr = 7698
   AND (e.job = 'CLERK' OR e.sal > 1300)
;

/*
EMPNO,  ENAME,  JOB,        SAL,    MGR
----------------------------------------
7499	ALLEN	SALESMAN	1600	7698
7844	TURNER	SALESMAN	1500	7698
7900	JAMES	CLERK	    950	    7698
*/

-- 3) 직무가 CLERK 이거나
--    급여가 1300이 넘으면서
--    매니저가 7698 인 직원의 정보 조회
SELECT e.empno
     , e.ename
     , e.job
     , e.sal
     , e.mgr
  FROM emp e
 WHERE e.job = 'CLERK'
    OR e.sal > 1300
   AND e.mgr = 7698
;

-- AND 연산자는 OR 연산자보다 우선순위가 높기떄문에
-- 두번째 쿼리처럼 괄호를 사용하지 않아도
-- 수행 결과가 동일하게 나온다

SELECT e.empno
     , e.ename
     , e.job
     , e.sal
     , e.mgr
  FROM emp e
 WHERE e.job = 'CLERK'
    OR (e.sal > 1300 AND e.mgr = 7698)
;

/*
EMPNO,  ENAME,  JOB,        SAL,    MGR
--------------------------------------------
7369	SMITH	CLERK	    800	    7902
7499	ALLEN	SALESMAN	1600	7698
7844	TURNER	SALESMAN	1500	7698
7900	JAMES	CLERK	    950	    7698
7934	MILLER	CLERK	    1300	7782
9999	J_JAMES	CLERK		
8888	J%JAMES	CLERK		
*/


---------------------------- 6. 함수
-- (3) 단일행 함수
-------1) 숫자함수:
--------- 1. MOD(m,n) : m을 n으로 나눈 나머지 계산 함수
SELECT mod(10,3)
  FROM emp
;
-- 결과 : 1일 emp 테이블의 행 수 만큼 반복 출력

SELECT mod(10,3)
  FROM dept
;

-- 결과 : 1이 dept 테이블의 행 수인 4번 반복 출력

-- 문제 : emp테이블에서 각 사원의 급여를 
--        3으로 나눈 나머지를 조회

SELECT mod(sal,3)
  FROM emp
;

-- 문제 : emp테이블에서 각 사원의 급여를
--        3으로 나눈 나머지를 사번과 함께 조회를 하시오.
--        사번이 먼저 조회되도록 하시오.

SELECT e.empno
     , mod(e.sal,3)
  FROM emp e
;

-- 단일행 함수는 테이블의 1행당 1번씩 적용

------ 2. ROUND(m,n) : 실수 m울 소수좀 n + 1 자리에서 반올림 한 결과 계산
SELECT ROUND(1234.56,1) -- 1234.6
  FROM dual
;
SELECT ROUND(1234.56,0) -- 1235
  FROM dual
;
SELECT ROUND(1234.45,0) -- 1234
  FROM dual
;
--      ROUND (m) : n값을 생략하면 n = 0 인 것으로 연산한 결과를 돌려줌
SELECT ROUND(1234.45) -- 1234
  FROM dual
;
SELECT ROUND(1234.45) -- 1234
  FROM dual
;

---------- 3. TRUNC(m,n) : 실수 m을 n에서 지정한 자리 아래 소수점 버림
SELECT TRUNC(1234.56,1) -- 1234.5
  FROM dual
;
SELECT TRUNC(1234.56,0) -- 1234
  FROM dual
;
------------     TRUNC(m) : n이 생략된 경우는 n = 0 으로 수행한다.
----                        즉, 소수점 이하 모두 버림 연산으로 수행
SELECT TRUNC(1234.56) ---1234
  FROM dual
;

---------------- 4. CEIL(n) : 입력된 실수 n에서 같거나 가장 가까운 큰 정수
SELECT CEIL(1234.56) ---1235
  FROM dual
;
SELECT CEIL(1234) ---1234
  FROM dual
;
SELECT CEIL(1234.001) ---1235
  FROM dual
;

------------- 5. FLOOR(n) : 입력된 실수 n에서 같거나 가장 가까운 작은 정수
SELECT FLOOR(1234.56) ---1234
  FROM dual
;
SELECT FLOOR(1234) ---1234
  FROM dual
;
SELECT FLOOR(1235.56) ---1235
  FROM dual
;

-----------6. WIDTH_BUCKET(expr,min,max,buckets)
-- min ~ max 값 사이를 buckets 개수만큼으로 나누고
-- expr이 출력하는 값이 어느 buckets 에 위치하는지 숫자로 알려줌

-- 급여를 범위를 0 ~ 5000 으로 잡고, 한 bucket 을 1000 단윌 나누면
-- 총 5개의 bucket 이 있음을 알 수 있으므로
-- 각 직원의 급여가 어느 bucket 에 위치하는지 구해보자
-- 그리고 급여 구간 오름차순 정렬
SELECT e.empno
     , e.ename
     , e.sal
     , WIDTH_BUCKET(e.sal, 0, 5000, 5) as "급여 구간"
  FROM emp e
 ORDER BY "급여 구간"
;