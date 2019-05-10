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
JOB
---------
CLERK
SALESMAN
ANALYST
MANAGER
PRESIDENT
*/

-- 3) emp 테이블에서 job 과 deptno 를 조회
SELECT job
     , deptno
  FROM emp
;
/*
JOB,      DEPTNO
----------------
CLERK	    20
SALESMAN	30
SALESMAN	30
MANAGER	    20
SALESMAN	30
MANAGER	    30
MANAGER	    10
PRESIDENT	10
SALESMAN	30
CLERK	    30
ANALYST	    20
CLERK	    10
*/

-- 4) emp 테이블에서 중복을 제거하여
-- job,deptno 를 조회

SELECT DISTINCT job
     , deptno
  FROM emp
;
/*
JOB,      DEPTNO
----------------
CLERK	    20
MANAGER	    20
MANAGER	    30
MANAGER	    10
SALESMAN	30
PRESIDENT	10
CLERK	    30
ANALYST	    20
CLERK	    10
*/

-- 5) emp 테이블에서 중복을 제거하여
-- job 을 조회하고
-- 결과를 job의 오름차순으로 정렬하시오.

SELECT DISTINCT job
  FROM emp
 ORDER BY job
;

-- 2) 번 쿼리의 실행결과와
-- 정렬순서가 다른 것을 확인하고 넘어가자.

/*
JOB
---------
ANALYST
CLERK
MANAGER
PRESIDENT
SALESMAN
*/

-- 6) emp 테이블에서 중복을 제거하여
--    job을 조회하고
--    job을 내림차순으로 정렬하시오.
--    (5)  번의 실행결과와 비교
SELECT DISTINCT job
  FROM emp
 ORDER BY job DESC
;
/*
JOB
---------
SALESMAN
PRESIDENT
MANAGER
CLERK
ANALYST
*/

-- 7) emp 테이블에서 empno (사번), ename(사원이름),job(직무)
--    를 조회하시오.
SELECT empno
     , ename
     , job
  FROM emp
;

/*
EMPNO,  ENAME,   JOB
------------------------
7369	SMITH	CLERK
7499	ALLEN	SALESMAN
7521	WARD	SALESMAN
7566	JONES	MANAGER
7654	MARTIN	SALESMAN
7698	BLAKE	MANAGER
7782	CLARK	MANAGER
7839	KING	PRESIDENT
7844	TURNER	SALESMAN
7900	JAMES	CLERK
7902	FORD	ANALYST
7934	MILLER	CLERK
*/

-- 8) emp 테이블에서
--    empno, ename, job, hiredate(입사일)
--    을 조회하시오.
SELECT empno
     , ename
     , job
     , hiredate
  FROM emp
;

/*
EMPNO,  ENAME,   JOB,       HIREDATE
------------------------------------
7369	SMITH	CLERK	    80/12/17
7499	ALLEN	SALESMAN	81/02/20
7521	WARD	SALESMAN	81/02/22
7566	JONES	MANAGER	    81/04/02
7654	MARTIN	SALESMAN	81/09/28
7698	BLAKE	MANAGER	    81/05/01
7782	CLARK	MANAGER	    81/06/09
7839	KING	PRESIDENT	81/11/17
7844	TURNER	SALESMAN	81/09/08
7900	JAMES	CLERK	    81/12/03
7902	FORD	ANALYST	    81/12/03
7934	MILLER	CLERK	    82/01/23
*/

-- ORDER BY : 정렬
-- 9) emp 테이블에서 comm 을 가장 많이 받는 순서대로
--    empno, ename, job, hiredate, comm 칼럼을 조회하시오.
SELECT empno
     , ename
     , job
     , hiredate
     , comm
  FROM emp
 ORDER BY comm DESC
;
-- => null 데이터는 항상 큰 값으로 취급한다.
--    따라서 DESC 정렬에서는 위쪽으로 정렬된다.

/*
EMPNO,  ENAME,  JOB,        HIREDATE,  COMM
-------------------------------------------
7369	SMITH	CLERK	    80/12/17	
7698	BLAKE	MANAGER	    81/05/01	
7902	FORD	ANALYST	    81/12/03	
7900	JAMES	CLERK	    81/12/03	
7839	KING	PRESIDENT	81/11/17	
7566	JONES	MANAGER	    81/04/02	
7934	MILLER	CLERK	    82/01/23	
7782	CLARK	MANAGER	    81/06/09	
7654	MARTIN	SALESMAN	81/09/28	1400
7521	WARD	SALESMAN	81/02/22	500
7499	ALLEN	SALESMAN	81/02/20	300
7844	TURNER	SALESMAN	81/09/08	0
*/

-- 10) emp 테이블에서 
--     comm 은 적은 순서대로(=> 오름차순)
--     , job은 오름차순(영문), ename 오름차순(영문)
--     정렬하여
--     empno, ename, job, hiredate, comm 을 조회하시오.

SELECT empno
     , ename
     , job
     , hiredate
     , comm
  FROM emp
 ORDER BY comm,job,ename
;

/*
EMPNO,  ENAME,    JOB,      HIREDATE,   COMM
-------------------------------------------------
7844	TURNER	SALESMAN	81/09/08	0
7499	ALLEN	SALESMAN	81/02/20	300
7521	WARD	SALESMAN	81/02/22	500
7654	MARTIN	SALESMAN	81/09/28	1400
7902	FORD	ANALYST	    81/12/03	
7900	JAMES	CLERK	    81/12/03	
7934	MILLER	CLERK	    82/01/23	
7369	SMITH	CLERK	    80/12/17	
7698	BLAKE	MANAGER	    81/05/01	
7782	CLARK	MANAGER	    81/06/09	
7566	JONES	MANAGER	    81/04/02	
7839	KING	PRESIDENT	81/11/17	
*/


-- emp 테이블에서
-- comm 이 적은 순서대로 , job 오름차순, ename내림차순 으로 정렬하여
-- empno, ename, job, hiredate, comm 을 조회하시오.

SELECT empno
     , ename
     , job
     , hiredate
     , comm
  FROM emp
 ORDER BY comm, job, ename DESC
;

/*
EMPNO,  ENAME,    JOB,      HIREDATE,   COMM
---------------------------------------------
7844	TURNER	SALESMAN	81/09/08	0
7499	ALLEN	SALESMAN	81/02/20	300
7521	WARD	SALESMAN	81/02/22	500
7654	MARTIN	SALESMAN	81/09/28	1400
7902	FORD	ANALYST	    81/12/03	
7369	SMITH	CLERK	    80/12/17	
7934	MILLER	CLERK	    82/01/23	
7900	JAMES	CLERK	    81/12/03	
7566	JONES	MANAGER 	81/04/02	
7782	CLARK	MANAGER	    81/06/09	
7698	BLAKE	MANAGER	    81/05/01	
7839	KING	PRESIDENT	81/11/17	
*/

-- Alias : 별칭
-- 11) emp 테이블에서
--     empno => Employee No.
--     ename => Employee Name
--     job   => Job Name
--     세 컬럼의 이름을 별칭으로 바꾸어서 조회
SELECT empno AS "Employee NO."
     , ename "Employee Name"   --AS 키워드는 생략가능
     , job   "Job Name"        --AS 키워드는 생략가능
  FROM emp
;

/*
Employee NO., Employee Name, Job Name
--------------------------------------
7369	        SMITH	    CLERK
7499	        ALLEN   	SALESMAN
7521	        WARD	    SALESMAN
7566	        JONES	    MANAGER
7654	        MARTIN	    SALESMAN
7698	        BLAKE	    MANAGER
7782	        CLARK	    MANAGER
7839	        KING	    PRESIDENT
7844	        TURNER  	SALESMAN
7900	        JAMES	    CLERK
7902	        FORD    	ANALYST
7934	        MILLER	    CLERK
*/

-- 12) 한글 별칭을 사용
--     emp 테이블에서 각 컬럼에 한글 별칭을 사용
--     empno => 사번
--     ename => 이 름
--     job   => 직무

SELECT empno 사번
     , empno "이 름"
     , job 직무
  FROM emp
;

/*
사번,   이 름,   직무
------------------------
7369	7369	CLERK
7499	7499	SALESMAN
7521	7521	SALESMAN
7566	7566	MANAGER
7654	7654	SALESMAN
7698	7698	MANAGER
7782	7782	MANAGER
7839	7839	PRESIDENT
7844	7844	SALESMAN
7900	7900	CLERK
7902	7902	ANALYST
7934	7934	CLERK
*/

-- 13) 테이블에 별칭 설정
--     emp 테이블에서 empno, ename 을 조회하시오.
-- 1.별칭 없이 구문 작성
SELECT empno
     , ename
  FROM emp
;
-- 2.SELECT절에 컬럼 나열할 때, 앞에 테이블 이름을 붙일 수 있음
--   테이블 이름을 붙여서 컬럼을 조회
SELECT emp,empno
     , emp.enmae
  FROM emp
;

-- 3. FROM 절의emp 테이블에 e 라는 별칭을 주고
--    SELECT 절의 컬럼앞에 테이블 별칭 e를 붙여서 조회
SELECT e.empno  -- 테이블 별칭이 사용되는 위치: 컬럼 이름 앞
     , e.ename
  FROM emp e --테이블 별칭 사용 위치
;


-- 14) 영문 별칭을 사용할 때, 쌍따옴표를 사용하지 않으면
--     => 결과 출력시 별칭이 모두 대문자화 되어 조회됨.
--     emp 테이블에서
--     empno => EmployeeNo
--     ename => "Employee Name"
--     job   => "Job Name"
SELECT e.empno AS EmployeeNo
     , e.ename "Employee Name"
     , e.job "Job Name"
  FROM emp e
;

/*
EMPLOYEENO, Employee Name, Job Name
-----------------------------------
7369	    SMITH	        CLERK
7499	    ALLEN	        SALESMAN
7521	    WARD	        SALESMAN
7566	    JONES	        MANAGER
7654	    MARTIN	        SALESMAN
7698	    BLAKE	        MANAGER
7782	    CLARK	        MANAGER
7839	    KING	        PRESIDENT
7844	    TURNER	        SALESMAN
7900	    JAMES	        CLERK
7902	    FORD	        ANALYST
7934	    MILLER	        CLERK
*/

--15) 별칭과 정렬의 조합
--    컬럼에 별칭을 준 경우 ORDER BY 절에 별칭을 사용 할 수 있다.
--    emp테이블에서 e 별칭을 주고 emp 테이블에서
--    empno => 사번
--    ename => 이름
--    job   => 직무
--    hiredate => 입사일
--    comm  => 수당
--    위와 같이 각 컬럼에 별칭을 주어 조회하고
--    수당, 직무, ename 을 모두 오름차순 정렬
SELECT e.empno 사번
     , e.ename 이름
     , e.job   직무
     , e.hiredate 입사일
     , e.comm 수당
  FROM emp e
 ORDER BY 수당,직무,e.ename
;
-- (10) 번과 동일하나 별칭을 사용한 부분만 차이가 남
--      => 결과 : ORDER BY 절에는 별칭과 원래 컬럼명을 섞어 쓸 수 있다.
/*
사번,   이름,    직무,       입사일,      수당
--------------------------------------------
7844	TURNER	SALESMAN	81/09/08	0
7499	ALLEN	SALESMAN	81/02/20	300
7521	WARD	SALESMAN	81/02/22	500
7654	MARTIN	SALESMAN	81/09/28	1400
7902	FORD	ANALYST	    81/12/03	
7900	JAMES	CLERK	    81/12/03	
7934	MILLER	CLERK	    82/01/23	
7369	SMITH	CLERK	    80/12/17	
7698	BLAKE	MANAGER	    81/05/01	
7782	CLARK	MANAGER	    81/06/09	
7566	JONES	MANAGER	    81/04/02	
7839	KING	PRESIDENT	81/11/17	
*/
