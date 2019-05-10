-- sql 과제 : 본인이름 한글로 작성
-- sql 과제 파일 명 : 본인이름01.sql
-- 제출 제목 : 청해진대학 본인 이름 SQL 01 과제
-- 강사 이메일 : hannacne@naver.com
-- 실습 1)
SELECT empno
     , ename
     , job
     , sal
  FROM emp
  ORDER BY sal DESC
;

/*
EMPNO,  ENAME,    JOB,       SAL
------------------------------------
7839	KING	PRESIDENT	 5000
7902	FORD	ANALYST	     3000
7566	JONES	MANAGER	     2975
7698	BLAKE	MANAGER	     2850
7782	CLARK	MANAGER	    2450
7499	ALLEN	SALESMAN	1600
7844	TURNER	SALESMAN	1500
7934	MILLER	CLERK	    1300
7654	MARTIN	SALESMAN	1250
7521	WARD	SALESMAN	1250
7900	JAMES	CLERK	    950
7369	SMITH	CLERK	    800
*/


-- 실습 2)
SELECT empno
     , ename
     , hiredate
  FROM emp
 ORDER BY hiredate
;

/*
EMPNO,  ENAME,  HIREDATE
------------------------
7369	SMITH	80/12/17
7499	ALLEN	81/02/20
7521	WARD	81/02/22
7566	JONES	81/04/02
7698	BLAKE	81/05/01
7782	CLARK	81/06/09
7844	TURNER	81/09/08
7654	MARTIN	81/09/28
7839	KING	81/11/17
7900	JAMES	81/12/03
7902	FORD	81/12/03
7934	MILLER	82/01/23
*/

-- 실습 3)
SELECT empno
     , ename
     , comm
  FROM emp
 ORDER BY comm
;

/*
EMPNO,  ENAME,  COMM
----------------------
7844	TURNER	0
7499	ALLEN	300
7521	WARD	500
7654	MARTIN	1400
7839	KING	
7900	JAMES	
7902	FORD	
7782	CLARK	
7934	MILLER	
7566	JONES	
7369	SMITH	
7698	BLAKE	

*/


--실습 4)
SELECT empno
     , ename
     , comm
  FROM emp
 ORDER BY comm DESC
;
/*
EMPNO,  ENAME,  COMM
---------------------
7369	SMITH	
7698	BLAKE	
7902	FORD	
7900	JAMES	
7839	KING	
7566	JONES	
7934	MILLER	
7782	CLARK	
7654	MARTIN	1400
7521	WARD	500
7499	ALLEN	300
7844	TURNER	0
*/


-- 실습 5) 
SELECT empno 사번
     , ename 이름
     , sal   급여
     , hiredate 입사일
  FROM emp
;

/*
사번,    이름,    급여,   입사일
--------------------------------
7369	SMITH	800	    80/12/17
7499	ALLEN	1600	81/02/20
7521	WARD	1250	81/02/22
7566	JONES	2975	81/04/02
7654	MARTIN	1250	81/09/28
7698	BLAKE	2850	81/05/01
7782	CLARK	2450	81/06/09
7839	KING	5000	81/11/17
7844	TURNER	1500	81/09/08
7900	JAMES	950	    81/12/03
7902	FORD	3000	81/12/03
7934	MILLER	1300	82/01/23
*/


-- 실습 6)
SELECT *
  FROM emp
;
/*
EMPNO,  ENAME,  JOB,        MGR,    HIREDATE,   SAL,        COMM,   DEPTNO
---------------------------------------------------------------------------
7369	SMITH	CLERK	    7902	80/12/17	800		    20
7499	ALLEN	SALESMAN	7698	81/02/20	1600	    300	    30
7521	WARD	SALESMAN	7698	81/02/22	1250	    500	    30
7566	JONES	MANAGER	    7839	81/04/02	2975		20
7654	MARTIN	SALESMAN	7698	81/09/28	1250	    1400	30
7698	BLAKE	MANAGER	    7839	81/05/01	2850		30
7782	CLARK	MANAGER	    7839	81/06/09	2450		10
7839	KING	PRESIDENT		    81/11/17	5000		10
7844	TURNER	SALESMAN	7698	81/09/08	1500	    0	    30
7900	JAMES	CLERK	    7698	81/12/03	950		    30
7902	FORD	ANALYST	    7566	81/12/03	3000		20
7934	MILLER	CLERK	    7782	82/01/23	1300		10
*/

-- 실습 7)
SELECT *
  FROM emp e, dept d
 WHERE e.ename = 'ALLEN'
;
/*
EMPNO,  ENAME,  JOB,        MGR,    HIREDATE,   SAL,    COMM,   DEPTNO, DEPTNO_1, DNAME,        LOC
--------------------------------------------------------------------------------------------------------
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	    30	    10	      ACCOUNTING	NEW YORK
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	    30	    20  	  RESEARCH	    DALLAS
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	    30	    30	      SALES	        CHICAGO
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	    30	    40	      OPERATIONS	BOSTON
*/

-- 실습 8)
SELECT e.empno
     , e.ename
     , e.deptno
  FROM emp e
 WHERE e.deptno=20
;

/*
EMPNO,  ENAME, DEPTNO
--------------------
7369	SMITH	20
7566	JONES	20
7902	FORD	20
*/

-- 실습 9)
SELECT e.empno
     , e.ename
     , e.sal
     , e.deptno
  FROM emp e
 WHERE e.deptno=20 AND e.sal<3000
;

/*
EMPNO,  ENAME,  SAL,  DEPTNO
----------------------------
7369	SMITH	800	    20
7566	JONES	2975	20
*/

-- 실습 10)
SELECT e.empno
     , e.ename
     , e.sal + e.comm
  FROM emp e
;

/*
EMPNO,  ENAME,  E.SAL+E.COMM
--------------------------
7369	SMITH	
7499	ALLEN	1900
7521	WARD	1750
7566	JONES	
7654	MARTIN	2650
7698	BLAKE	
7782	CLARK	
7839	KING	
7844	TURNER	1500
7900	JAMES	
7902	FORD	
7934	MILLER	
*/

--실습 11)
SELECT e.empno
     , e.ename
     , e.sal + e.comm 년급여
  FROM emp e
;

/*
EMPNO,  ENAME, 년급여
--------------------
7369	SMITH	
7499	ALLEN	1900
7521	WARD	1750
7566	JONES	
7654	MARTIN	2650
7698	BLAKE	
7782	CLARK	
7839	KING	
7844	TURNER	1500
7900	JAMES	
7902	FORD	
7934	MILLER	
*/

--실습 12)
SELECT e.empno
     , e.ename
     , e.job
     , e.comm
  FROM emp e
 WHERE e.ename = 'MARTIN' OR e.ename = 'BLAKE'
;

/*
EMPNO,  ENAME,  JOB,        COMM
--------------------------------
7654	MARTIN	SALESMAN	1400
7698	BLAKE	MANAGER	
*/

--실습 13)
SELECT e.empno
     , e.ename
     , e.job
     , e.sal + e.comm
  FROM emp e
 WHERE  e.ename = 'MARTIN' OR e.ename = 'BLAKE'
;

/*
EMPNO,  ENAME,  JOB,    E.SAL+E.COMM
------------------------------------
7654	MARTIN	SALESMAN	2650
7698	BLAKE	MANAGER	
*/