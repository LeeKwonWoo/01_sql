-- day 09
-- 2. 복수형 함수(그룹 함수)

-- 1) COUNT(*) : FROM 절에 나열된
--                  특정테이블의 행의 (데이터 개수)를 세어주는 함수
--                  NULL 값을 처리하는 "유일" 한 그룹함수
--COUNT(expr) : expr 으로 등장한 값
--
SELECT d.*
  FROM dept d
;

/*
DEPTNO, DNAME, LOC
------------------------
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	CHICAGO
40	OPERATIONS	BOSTON
*/
--2. dept 테이블의 데이터 개수 조회: couNT*) 사용
SELECT COUNT(*)
  FROM dept d
;

/*
부서개수
-------
    4
*/

-- salgrade (급여등급 테이블)의 급여 등ㅇ급개수를 조회

SELECT COUNT(*)급여등급개수
  FROM salgrade
;

-- count(expr) 이 NULL 데이터를 처리하지 못하는 것 확인을 위한 데이터 추가
INSERT INTO "SCOTT"."EMP" (EMPNO, ENAME) VALUES ('7777', 'JJ');
COMMIT;

-- emp테이블에서 job 컬럼의 데이터 개수를 카운트
SELECT COUNT(e.JOB)"직무가 배정된 직원의 수"
  FROM emp e
;


-- 문제) 회사에 매니저가 배정된 직원이 몇명인가
SELECT COUNT(e.mgr)"상사가 있는 직원의 수"
  FROM emp e
;

/*
11
*/

-- 문제) 매니저 직을 맡고 있는 직원이 몇명인가?
-- 1. emp 테이블의 mgr 컬럼의 데이터 형태를 파악
-- 2. mgr 컬럼의 중복 데이터를 제거
SELECT DISTINCT e.mgr
  FROM emp e
;
/*
mgr
----
7782
7698
7902
7566
(null)
7839
*/
-- 3. 중복 데이터가 제거된 결과를 카운트
SELECT count(DISTINCT e.mgr) -- 5
  FROM emp e
;

-- 문제) 부서가 배정된 직원이 몇명이나 있는가?
SELECT count(e.deptno) "부서 배정 인원"
  FROM emp e
;

-- COUNT(*) 가 아닌 COUNT(expr)을 사용한 경우에는
SELECT e.deptno
  FROM emp e
 WHERE e.deptno IS NOT NULL
;
-- 을 수행한 결과를 카운트 한 것으로 생각할 수 있음

-- 문제) 전체 인원, 부서 배정 인원, 부서 미배정 인원을 구하시오
SELECT COUNT(*) "전체 인원"
     , COUNT(e.deptno)"부서 배정 인원"
     , COUNT(*)-COUNT(e.deptno)"부서 미배정 인원"
  FROM emp e
;

/*
전체 인원, 부서 배정 인원, 부서 미배정 인원
-------------------------------------------
15	        12	            3
*/

-- SUM(expr) : NULL 항목 제외하고
--             합산 가능한 행을 모두 더한 결과를 출력
-- SALESMAN 들의 수다 총합을 구해보자.
SELECT SUM(e.comm)
  FROM emp e
 WHERE e.job = 'SALESMAN'
;

-- 수당 총합 결과에 숫자 출력 패턴을 적용 $, 세자리 끊어 읽기 적용
SELECT TO_CHAR(SUM(e.comm),'$9,999') "수당 총합"
  FROM emp e
 WHERE e.job = 'SALESMAN'
;

-- 3)AVG(expr) : NULL 값 제외하고 연산 가능한 항목의 산술 평균을 구함
-- SALESMAN 의 수당 평균을 구해보자
SELECT AVG(e.comm)"평균 수당"
  FROM emp e
;
SELECT AVG(e.comm)"평균 수당"
  FROM emp e
 WHERE e.job = 'SALESMAN'
;
/*
평균 수당
---------
    550
*/
-- 수당 평균 결과에 숫자 출력 패턴 $, 세자리 끊어 읽기 적용
SELECT TO_CHAR(AVG(e.comm),'$9,999') "평균 수당"
  FROM emp e
 WHERE e.job = 'SALESMAN'
;

/*
수당 총합
---------
$550
*/

-- 4) MAX(expr) : expr 이 등장한 값 중 최댓값을 구함
--                expr이 문자인 경우는 알파벳순 윗쪽에 위치한 글자를
--                최댓값을 계산

--                이름이 가장 나중인 직원
SELECT MAX(e.ename) "이름이 가장 나중인 직원"
  FROM emp e
;
/*
이름이 가장 나중인 지구언
------------------------
WARD
*/

-- 5) MIN(expr) : expr에 등장한 값 중 최솟값을 구함
--                expr이 문자인 경우는 알파벳순 앞쪽에 위치한 글자를
--
SELECT MIN(e.ename) "이름이 가장 앞인 직원"
  FROM emp e
;
/*
이름이 가장 앞인 직원
---------------------
ALLEN
*/



--------- 3. GROUP BY 절의 사용
-- 문제) 각 부서별로 급여의 총합, 평균, 최대, 최소를 조회

-- 각 부서별로 급여의 총합을 조회하려면
--   총합 : SUM() 을 사용
--   그룹화 기준을 부서번호(deptno)를 사용
--   GROUP BY 절이 등장해야함

-- a) 먼저 emp 테이블에서 급여 총합을 구하는 구문 작성
SELECT SUM(e.sal)
  FROM emp e 
;

-- b) 부서 번호를 기준으로 그룹화 진행
--    SUM()은 그룹함수다.
--    GROUP BY 절을 조합하면 그훕화 가능하다.
--    그룹화를 하려면 기준컬럼이 GROUP BY절에 등장해야 함
SELECT e.deptno "부서 번호" -- 그룹화 기준컬럼으로 SELECT 절에 등장
     , SUM(e.sal)"급여 총합" --그룹함수가 사용된 컬럼
  FROM emp e
 GROUP BY e.deptno --    그룹화 기준컬럼으로 GROUP BY절에 등장해야 함
 ORDER BY e.deptno -- 부서번호 정렬
;
/*
부서번호 급여총합
-----------------
10	    8750
20	    6775
30	    9400
null    null	
*/

-- GROUP BY절에 그룹화 기준 컬럼으로 등장한 걸럼이 아닌 것이
-- SELECT 절에 등장하면 오류, 실행 불가
SELECT e.deptno "부서 번호" -- 그룹화 기준컬럼으로 SELECT 절에 등장
     , e.job  --그룹화 기준컬럼이 아닌데 SELECT 절에 등장 -> 원인
     , SUM(e.sal)"급여 총합" --그룹함수가 사용된 컬럼
  FROM emp e
 GROUP BY e.deptno --    그룹화 기준컬럼으로 GROUP BY절에 등장해야 함
 ORDER BY e.deptno -- 부서번호 정렬
;

/*
ORA-00979: GROUP BY 표현식이 아닙니다.
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
206행, 42열에서 오류 발생
*/

-- 문제) 부서별 급여의 총합, 평균, 최대, 최소
SELECT e.deptno "부서 번호"
     , TO_CHAR(SUM(e.sal),'$9,999')"부서 급여 총합"
     , TO_CHAR(AVG(e.sal),'$9,999')"부서 급여 평균"
     , TO_CHAR(MAX(e.sal),'$9,999')"부서 급여 최대"
     , TO_CHAR(MIN(e.sal),'$9,999')"부서 급여 최소"
  FROM emp e
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;
/*
부서 번호, 부서 급여 총합, 부서 급여 평균, 부서 급여 최대, 부서 급여 최소
-------------------------------------------------------------------------
10	       $8,750	       $2,917	       $5,000	       $1,300
20	       $6,775	       $2,258	       $3,000	       $800
30	       $9,400	       $1,567	       $2,850	       $950
*/

SELECT TO_CHAR(SUM(e.sal),'$9,999')"부서 급여 총합"
     , TO_CHAR(AVG(e.sal),'$9,999')"부서 급여 평균"
     , TO_CHAR(MAX(e.sal),'$9,999')"부서 급여 최대"
     , TO_CHAR(MIN(e.sal),'$9,999')"부서 급여 최소"
  FROM emp e
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;
/*
위의 쿼리는 수행되지만 정확하게 어느 부서의 결과인지 알 수 없다는 단점이 존재
그래서, GROUP BY 절에 등장한는 기준 컬럼은 SELECT 절에 똑같이 등장하는 편이
결과 해석에 편리하다.
SELECT 절에 나열된 컬럼중에서 그룹함수가 사용되지 않는 컬럼이 없기때문에
위의 쿼리는 수행되는 것이다.
*/

SELECT e.deptno 부서번호
     , e.job 직무
     , TO_CHAR(SUM(e.sal),'$9,999')"부서 급여 총합"
     , TO_CHAR(AVG(e.sal),'$9,999')"부서 급여 평균"
     , TO_CHAR(MAX(e.sal),'$9,999')"부서 급여 최대"
     , TO_CHAR(MIN(e.sal),'$9,999')"부서 급여 최소"
  FROM emp e
 GROUP BY e.deptno, e.job 
 ORDER BY e.deptno 
;
/*
부서번호, 직무, 부서 급여 총합, 부서 급여 평균, 부서 급여 최대, 부서 급여 최소
-------------------------------------------------------------------------------------
10	    CLERK	 $1,300	        $1,300	        $1,300	        $1,300
10	    MANAGER	 $2,450	        $2,450	        $2,450	        $2,450
10	    PRESIDENT$5,000	        $5,000	        $5,000	        $5,000
20	    ANALYST	 $3,000	        $3,000	        $3,000	        $3,000
20	    CLERK	 $800	        $800	        $800	        $800
20	    MANAGER	 $2,975	        $2,975	        $2,975	        $2,975
30	    CLERK	 $950	        $950	        $950	        $950
30	    MANAGER	 $2,850	        $2,850	        $2,850	        $2,850
30	    SALESMAN $5,600	        $1,400	        $1,600	        $1,250
        CLERK				
					
*/

-- 오류상황
-- a) GROUP BY 절에 그룹화 기준이 누락된 경우
SELECT e.deptno 부서번호
     , e.job 직무
     , TO_CHAR(SUM(e.sal),'$9,999')"부서 급여 총합"
     , TO_CHAR(AVG(e.sal),'$9,999')"부서 급여 평균"
     , TO_CHAR(MAX(e.sal),'$9,999')"부서 급여 최대"
     , TO_CHAR(MIN(e.sal),'$9,999')"부서 급여 최소"
  FROM emp e
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;
/*
ORA-00979: GROUP BY 표현식이 아닙니다.
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
284행, 15열에서 오류 발생
*/

-- b) SELECT 절에 그룹함수 의 일반 컬럼이 섞여 등장
--    GROUP BY 절 전체가 누락된 경우
SELECT e.deptno 부서번호
     , e.job 직무
     , TO_CHAR(SUM(e.sal),'$9,999')"부서 급여 총합"
     , TO_CHAR(AVG(e.sal),'$9,999')"부서 급여 평균"
     , TO_CHAR(MAX(e.sal),'$9,999')"부서 급여 최대"
     , TO_CHAR(MIN(e.sal),'$9,999')"부서 급여 최소"
  FROM emp e
-- GROUP BY e.deptno 
 ORDER BY e.deptno 
;
/*
ORA-00937: 단일 그룹의 그룹 함수가 아닙니다
00937. 00000 -  "not a single-group group function"
*Cause:    
*Action:
303행, 8열에서 오류 발생
*/

-- 문제) 직무(job) 별 급여의 총합, 평균, 최대, 최소 를 구해보자
--       별칭 : 직무, 급여총합, 급여평균, 최대급여, 최소급여
SELECT e.job 직무
     , TO_CHAR(SUM(e.sal),'$9,999')급여총합
     , TO_CHAR(AVG(e.sal),'$9,999')급여평균
     , TO_CHAR(MAX(e.sal),'$9,999')최대급여
     , TO_CHAR(MIN(e.sal),'$9,999')최소급여
  FROM emp e
 GROUP BY e.job
 ORDER BY e.job
;

/*
직무,     급여총합, 급여평균, 최대급여, 최소급여
----------------------------------------------
ANALYST	    $3,000	 $3,000	 $3,000	 $3,000
CLERK	    $3,050	 $1,017	 $1,300	   $800
MANAGER	    $8,275	 $2,758	 $2,975	 $2,450
PRESIDENT	$5,000	 $5,000	 $5,000	 $5,000
SALESMAN	$5,600	 $1,400	 $1,600	 $1,250
null        null     null    null    null
*/

-- 직무가 null인 사람들은 직무명 대신 '직무 미배정' 으로 출력
SELECT NVL(e.job,'직무 미배정')    직무
     , TO_CHAR(SUM(e.sal),'$9,999')급여총합
     , TO_CHAR(AVG(e.sal),'$9,999')급여평균
     , TO_CHAR(MAX(e.sal),'$9,999')최대급여
     , TO_CHAR(MIN(e.sal),'$9,999')최소급여
  FROM emp e
 GROUP BY e.job
 ORDER BY e.job
;

/*
직무,       급여총합,급여평균, 최대급여, 최소급여
----------------------------------------------------
ANALYST	     $3,000	 $3,000	    $3,000	 $3,000
CLERK	     $3,050	 $1,017	    $1,300	   $800
MANAGER	     $8,275	 $2,758	    $2,975	 $2,450
PRESIDENT	 $5,000	 $5,000	    $5,000	 $5,000
SALESMAN	 $5,600	 $1,400	    $1,600	 $1,250
직무 미배정				
*/

-- 부서별, 총합, 평균 ,최대, 최소
-- 부서번호가 null인경우 '부서 미배정'으로 분류되도록
SELECT NVL(e.deptno,'직무 미배정') 부서번호
     , TO_CHAR(SUM(e.sal),'$9,999')급여총합
     , TO_CHAR(AVG(e.sal),'$9,999')급여평균
     , TO_CHAR(MAX(e.sal),'$9,999')최대급여
     , TO_CHAR(MIN(e.sal),'$9,999')최소급여
  FROM emp e
 GROUP BY e.deptno
 ORDER BY e.deptno
;
/*
ORA-01722: 수치가 부적합합니다
01722. 00000 -  "invalid number"
*Cause:    The specified number was invalid.
*Action:   Specify a valid number.
*/

-- 해결방법 : deptno 의 해결

SELECT NVL(TO_CHAR(e.deptno),'직무 미배정') 부서번호
     , TO_CHAR(SUM(e.sal),'$9,999')급여총합
     , TO_CHAR(AVG(e.sal),'$9,999')급여평균
     , TO_CHAR(MAX(e.sal),'$9,999')최대급여
     , TO_CHAR(MIN(e.sal),'$9,999')최소급여
  FROM emp e
 GROUP BY e.deptno
 ORDER BY e.deptno
;


-- 숫자를 문자로 변경 : 집합연산자(||) 를 사용
SELECT NVL(e.deptno||'','직무 미배정') 부서번호
     , TO_CHAR(SUM(e.sal),'$9,999')급여총합
     , TO_CHAR(AVG(e.sal),'$9,999')급여평균
     , TO_CHAR(MAX(e.sal),'$9,999')최대급여
     , TO_CHAR(MIN(e.sal),'$9,999')최소급여
  FROM emp e
 GROUP BY e.deptno
 ORDER BY e.deptno
;
-- NVL,DECODE,TO_CHAR조합으로 해결
SELECT DECODE(NVL(e.deptno,0), e.deptno, TO_CHAR(e.deptno)
                             , 0       , '부서 미배정')부서번호
     , TO_CHAR(SUM(e.sal),'$9,999')급여총합
     , TO_CHAR(AVG(e.sal),'$9,999')급여평균
     , TO_CHAR(MAX(e.sal),'$9,999')최대급여
     , TO_CHAR(MIN(e.sal),'$9,999')최소급여
  FROM emp e
 GROUP BY e.deptno
 ORDER BY e.deptno
;

/*
부서번호, 급여총합, 급여평균, 최대급여, 최소급여
------------------------------------------------
10	 $8,750	 $2,917	 $5,000	 $1,300
20	 $6,775	 $2,258	 $3,000	   $800
30	 $9,400	 $1,567	 $2,850	   $950
직무 미배정				
*/

---------- 4. HAVING 절의 사용
-- GROUP BY 결과에 조건을 걸어서
-- 그 결과를 제한할 목적으로 사용되는 점.
-- WHERE 절과 WHERE 절괴 비슷하지만
-- SELECT 구문의 실행 순서떄문데
-- GROUP BY 절 보다 먼저 실행되는 WHERE 절로는
-- GROUP BY 결과를 제한할 수 없다.
-- 따라서 GROUP BY 다음 수행순서를 가지는
-- HAVING 에서 제한한다.

-- 문제) 부서별 급여 평균이 2000 이상인 부서를 조회하여라.
-- a) 우선 부서별 급여 평균을 구한다.
SELECT e.deptno
     , AVG(e.sal)
  FROM emp e
 GROUP BY e.deptno
;

-- b) a의 결과에서 급여평균이  2000이상인 값만 남긴다.
--    HAVING 으로 결과 제한

SELECT e.deptno
     , AVG(e.sal)
  FROM emp e
 GROUP BY e.deptno
HAVING avg(e.sal) >= 2000
;

-- 결과에 숫자 패턴
SELECT e.deptno
     , TO_CHAR(AVG(e.sal),'$9,999')
  FROM emp e
 GROUP BY e.deptno
HAVING avg(e.sal) >= 2000
;

-- 주의: HAVING 에는 별칭을 사용할 수 없다.
SELECT e.deptno 부서번호
     , AVG(e.sal) 급여평균
  FROM emp e
 GROUP BY e.deptno
HAVING 급여평균 >= 2000
;


-- HAVING 절이 존재하는 경우 SELECT구문의 실행 순서 정리
/*
1. FROM     절의 테이블 각 행 모두를 대상으로
2. WHERE    절의 조건에 맞는 행만 선택하고
3. GROUP BY 절에 나온 컬럼, 식(함수 식) 으로 그룹화 진행
4. HAVING   절의 조건을 만족시키는 그룹행만 선택
5.          4까지 선택된 그룹 정보를 가진 행에 대해서
6.SELECT    절에 명시된 컬럼, 식(함수 식)만 출력
7.ORDER BY  가 있다면 정렬조건에 맞추어
*/

----------------------------------------------------------------

-- 수업중 실습
-- 1. 매니저별, 부하직원의 수를 구하고, 많은 순으로 정렬
--   : mgr 컬럼이 그룹화 기준 컬럼
SELECT e.mgr 매니저번호
     , COUNT(e.mgr) "부하직원의 수"
  FROM emp e
 GROUP BY e.mgr
 ORDER BY COUNT(e.mgr) DESC
;

/*
매니저번호, 부하직원의 수
-------------------------
7698	    5
7839	    3
7566	    1
7782	    1
7902	    1
null        0
*/

-- 2.1 부서별 인원을 구하고, 인원수 많은 순으로 정렬
--    : deptno 컬럼이 그룹화 기준 컬럼
SELECT e.deptno 부서번호
     , COUNT(e.deptno) "부서별 인원"
  FROM emp e
 GROUP BY e.deptno
 ORDER BY COUNT(e.deptno) DESC
;
/*
부서번호, 부서별 인원
-------------------------
30	        6
20	        3
10	        3
null        0
*/
-- 2.2 부서 배치 미배정 인원 처리
SELECT NVL(TO_CHAR(e.deptno||''),'부서 배치 미배정') 부서번호
     , COUNT(e.deptno) "부서별 인원"
  FROM emp e
 GROUP BY e.deptno
 ORDER BY COUNT(e.deptno) DESC
;

/*
부서번호, 부서별 인원
---------------------
30	                6
20	                3
10	                3
부서 배치 미배정	0
*/

-- 3.1 직무별 급여 평균 구하고, 급여평균 높은 순으로 정렬
--   : job 이 그룹화 기준 컬럼

SELECT e.job 직무
     , TO_CHAR(AVG(e.sal),'$9,999') "급여 평균"
  FROM emp e
 GROUP BY e.job
 ORDER BY AVG(e.sal) DESC
;

/*
직무,     급여 평균
-------------------
null        null
PRESIDENT	$5,000
ANALYST	    $3,000
MANAGER	    $2,758
SALESMAN	$1,400
CLERK	    $1,017
*/
-- 3.2 job 이 null 인 데이터 처리

SELECT NVL(e.job,'직무 미배정') 직무
     , TO_CHAR(AVG(e.sal),'$9,999') "급여 평균"
  FROM emp e
 GROUP BY e.job
 ORDER BY AVG(e.sal) DESC
;

/*
직무,     급여 평균
-------------------
직무 미배정	
PRESIDENT	 $5,000
ANALYST	     $3,000
MANAGER	     $2,758
SALESMAN	 $1,400
CLERK	     $1,017
*/

-- 4. 직무별 급여 총합 구하고, 총합 높은 순으로 정렬
--   : job 이 그룹화 기준 컬럼

SELECT e.job 직무
     , SUM(e.sal) "급여 총합"
  FROM emp e
 GROUP BY e.job
 ORDER BY SUM(e.sal) DESC
;

/*
직무,  급여 총합
----------------
MANAGER	    8275
SALESMAN	5600
PRESIDENT	5000
CLERK	    3050
ANALYST	    3000
*/
-- 5. 급여의 앞단위가 1000미만, 1000, 2000, 3000, 5000 별로 인원수를 구하시오
--    급여 단위 오름차순으로 정렬

SELECT CASE         WHEN e.sal between 0    and 1000 THEN 0
                    WHEN e.sal between 1000 and 2000 THEN 1000
                    WHEN e.sal between 2000 and 3000 THEN 2000
                    WHEN e.sal between 3000 and 4000 THEN 3000
                    WHEN e.sal between 4000 and 5000 THEN 4000
                    WHEN e.sal between 5000 and 6000 THEN 5000 END 급여단위
     , COUNT(*) 인원수
  FROM emp e
 GROUP BY CASE      WHEN e.sal between 0    and 1000 THEN 0
                    WHEN e.sal between 1000 and 2000 THEN 1000
                    WHEN e.sal between 2000 and 3000 THEN 2000
                    WHEN e.sal between 3000 and 4000 THEN 3000
                    WHEN e.sal between 4000 and 5000 THEN 4000
                    WHEN e.sal between 5000 and 6000 THEN 5000 END
 ORDER BY e.sal
;
-- 6. 직무별 급여 합의 단위를 구하고, 급여 합의 단위가 큰 순으로 정렬

SELECT e.job 직무
     , SUM(e.sal) "급여 합"
  FROM emp e
 GROUP BY e.job
 ORDER BY SUM(e.sal) DESC
;
/*
직무,      급여 합
-----------------
null        null	
MANAGER	    8275
SALESMAN	5600
PRESIDENT	5000
CLERK	    3050
ANALYST	    3000
*/

-- 7. 직무별 급여 평균이 2000이하인 경우를 구하고 평균이 높은 순으로 정렬

SELECT e.job 직무
     , TO_CHAR(AVG(e.sal),'$9,999') "급여 평균"
  FROM emp e
 GROUP BY e.job
HAVING AVG(e.sal) <= 2000
 ORDER BY AVG(e.sal) DESC
;

/*
직무,     급여 평균
-------------------
SALESMAN	 $1,400
CLERK	     $1,017
*/

-- 8. 년도별 입사 인원을 구하시오

SELECT to_char(e.hiredate,'YY')
     , COUNT(*)
  FROM emp e
 GROUP BY to_char(e.hiredate,'YY')
;