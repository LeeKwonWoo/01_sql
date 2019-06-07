-- day 09
-- 2. ������ �Լ�(�׷� �Լ�)

-- 1) COUNT(*) : FROM ���� ������
--                  Ư�����̺��� ���� (������ ����)�� �����ִ� �Լ�
--                  NULL ���� ó���ϴ� "����" �� �׷��Լ�
--COUNT(expr) : expr ���� ������ ��
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
--2. dept ���̺��� ������ ���� ��ȸ: couNT*) ���
SELECT COUNT(*)
  FROM dept d
;

/*
�μ�����
-------
    4
*/

-- salgrade (�޿���� ���̺�)�� �޿� ��ް����� ��ȸ

SELECT COUNT(*)�޿���ް���
  FROM salgrade
;

-- count(expr) �� NULL �����͸� ó������ ���ϴ� �� Ȯ���� ���� ������ �߰�
INSERT INTO "SCOTT"."EMP" (EMPNO, ENAME) VALUES ('7777', 'JJ');
COMMIT;

-- emp���̺��� job �÷��� ������ ������ ī��Ʈ
SELECT COUNT(e.JOB)"������ ������ ������ ��"
  FROM emp e
;


-- ����) ȸ�翡 �Ŵ����� ������ ������ ����ΰ�
SELECT COUNT(e.mgr)"��簡 �ִ� ������ ��"
  FROM emp e
;

/*
11
*/

-- ����) �Ŵ��� ���� �ð� �ִ� ������ ����ΰ�?
-- 1. emp ���̺��� mgr �÷��� ������ ���¸� �ľ�
-- 2. mgr �÷��� �ߺ� �����͸� ����
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
-- 3. �ߺ� �����Ͱ� ���ŵ� ����� ī��Ʈ
SELECT count(DISTINCT e.mgr) -- 5
  FROM emp e
;

-- ����) �μ��� ������ ������ ����̳� �ִ°�?
SELECT count(e.deptno) "�μ� ���� �ο�"
  FROM emp e
;

-- COUNT(*) �� �ƴ� COUNT(expr)�� ����� ��쿡��
SELECT e.deptno
  FROM emp e
 WHERE e.deptno IS NOT NULL
;
-- �� ������ ����� ī��Ʈ �� ������ ������ �� ����

-- ����) ��ü �ο�, �μ� ���� �ο�, �μ� �̹��� �ο��� ���Ͻÿ�
SELECT COUNT(*) "��ü �ο�"
     , COUNT(e.deptno)"�μ� ���� �ο�"
     , COUNT(*)-COUNT(e.deptno)"�μ� �̹��� �ο�"
  FROM emp e
;

/*
��ü �ο�, �μ� ���� �ο�, �μ� �̹��� �ο�
-------------------------------------------
15	        12	            3
*/

-- SUM(expr) : NULL �׸� �����ϰ�
--             �ջ� ������ ���� ��� ���� ����� ���
-- SALESMAN ���� ���� ������ ���غ���.
SELECT SUM(e.comm)
  FROM emp e
 WHERE e.job = 'SALESMAN'
;

-- ���� ���� ����� ���� ��� ������ ���� $, ���ڸ� ���� �б� ����
SELECT TO_CHAR(SUM(e.comm),'$9,999') "���� ����"
  FROM emp e
 WHERE e.job = 'SALESMAN'
;

-- 3)AVG(expr) : NULL �� �����ϰ� ���� ������ �׸��� ��� ����� ����
-- SALESMAN �� ���� ����� ���غ���
SELECT AVG(e.comm)"��� ����"
  FROM emp e
;
SELECT AVG(e.comm)"��� ����"
  FROM emp e
 WHERE e.job = 'SALESMAN'
;
/*
��� ����
---------
    550
*/
-- ���� ��� ����� ���� ��� ���� $, ���ڸ� ���� �б� ����
SELECT TO_CHAR(AVG(e.comm),'$9,999') "��� ����"
  FROM emp e
 WHERE e.job = 'SALESMAN'
;

/*
���� ����
---------
$550
*/

-- 4) MAX(expr) : expr �� ������ �� �� �ִ��� ����
--                expr�� ������ ���� ���ĺ��� ���ʿ� ��ġ�� ���ڸ�
--                �ִ��� ���

--                �̸��� ���� ������ ����
SELECT MAX(e.ename) "�̸��� ���� ������ ����"
  FROM emp e
;
/*
�̸��� ���� ������ ������
------------------------
WARD
*/

-- 5) MIN(expr) : expr�� ������ �� �� �ּڰ��� ����
--                expr�� ������ ���� ���ĺ��� ���ʿ� ��ġ�� ���ڸ�
--
SELECT MIN(e.ename) "�̸��� ���� ���� ����"
  FROM emp e
;
/*
�̸��� ���� ���� ����
---------------------
ALLEN
*/



--------- 3. GROUP BY ���� ���
-- ����) �� �μ����� �޿��� ����, ���, �ִ�, �ּҸ� ��ȸ

-- �� �μ����� �޿��� ������ ��ȸ�Ϸ���
--   ���� : SUM() �� ���
--   �׷�ȭ ������ �μ���ȣ(deptno)�� ���
--   GROUP BY ���� �����ؾ���

-- a) ���� emp ���̺��� �޿� ������ ���ϴ� ���� �ۼ�
SELECT SUM(e.sal)
  FROM emp e 
;

-- b) �μ� ��ȣ�� �������� �׷�ȭ ����
--    SUM()�� �׷��Լ���.
--    GROUP BY ���� �����ϸ� ���gȭ �����ϴ�.
--    �׷�ȭ�� �Ϸ��� �����÷��� GROUP BY���� �����ؾ� ��
SELECT e.deptno "�μ� ��ȣ" -- �׷�ȭ �����÷����� SELECT ���� ����
     , SUM(e.sal)"�޿� ����" --�׷��Լ��� ���� �÷�
  FROM emp e
 GROUP BY e.deptno --    �׷�ȭ �����÷����� GROUP BY���� �����ؾ� ��
 ORDER BY e.deptno -- �μ���ȣ ����
;
/*
�μ���ȣ �޿�����
-----------------
10	    8750
20	    6775
30	    9400
null    null	
*/

-- GROUP BY���� �׷�ȭ ���� �÷����� ������ �ɷ��� �ƴ� ����
-- SELECT ���� �����ϸ� ����, ���� �Ұ�
SELECT e.deptno "�μ� ��ȣ" -- �׷�ȭ �����÷����� SELECT ���� ����
     , e.job  --�׷�ȭ �����÷��� �ƴѵ� SELECT ���� ���� -> ����
     , SUM(e.sal)"�޿� ����" --�׷��Լ��� ���� �÷�
  FROM emp e
 GROUP BY e.deptno --    �׷�ȭ �����÷����� GROUP BY���� �����ؾ� ��
 ORDER BY e.deptno -- �μ���ȣ ����
;

/*
ORA-00979: GROUP BY ǥ������ �ƴմϴ�.
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
206��, 42������ ���� �߻�
*/

-- ����) �μ��� �޿��� ����, ���, �ִ�, �ּ�
SELECT e.deptno "�μ� ��ȣ"
     , TO_CHAR(SUM(e.sal),'$9,999')"�μ� �޿� ����"
     , TO_CHAR(AVG(e.sal),'$9,999')"�μ� �޿� ���"
     , TO_CHAR(MAX(e.sal),'$9,999')"�μ� �޿� �ִ�"
     , TO_CHAR(MIN(e.sal),'$9,999')"�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;
/*
�μ� ��ȣ, �μ� �޿� ����, �μ� �޿� ���, �μ� �޿� �ִ�, �μ� �޿� �ּ�
-------------------------------------------------------------------------
10	       $8,750	       $2,917	       $5,000	       $1,300
20	       $6,775	       $2,258	       $3,000	       $800
30	       $9,400	       $1,567	       $2,850	       $950
*/

SELECT TO_CHAR(SUM(e.sal),'$9,999')"�μ� �޿� ����"
     , TO_CHAR(AVG(e.sal),'$9,999')"�μ� �޿� ���"
     , TO_CHAR(MAX(e.sal),'$9,999')"�μ� �޿� �ִ�"
     , TO_CHAR(MIN(e.sal),'$9,999')"�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;
/*
���� ������ ��������� ��Ȯ�ϰ� ��� �μ��� ������� �� �� ���ٴ� ������ ����
�׷���, GROUP BY ���� �����Ѵ� ���� �÷��� SELECT ���� �Ȱ��� �����ϴ� ����
��� �ؼ��� ���ϴ�.
SELECT ���� ������ �÷��߿��� �׷��Լ��� ������ �ʴ� �÷��� ���⶧����
���� ������ ����Ǵ� ���̴�.
*/

SELECT e.deptno �μ���ȣ
     , e.job ����
     , TO_CHAR(SUM(e.sal),'$9,999')"�μ� �޿� ����"
     , TO_CHAR(AVG(e.sal),'$9,999')"�μ� �޿� ���"
     , TO_CHAR(MAX(e.sal),'$9,999')"�μ� �޿� �ִ�"
     , TO_CHAR(MIN(e.sal),'$9,999')"�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno, e.job 
 ORDER BY e.deptno 
;
/*
�μ���ȣ, ����, �μ� �޿� ����, �μ� �޿� ���, �μ� �޿� �ִ�, �μ� �޿� �ּ�
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

-- ������Ȳ
-- a) GROUP BY ���� �׷�ȭ ������ ������ ���
SELECT e.deptno �μ���ȣ
     , e.job ����
     , TO_CHAR(SUM(e.sal),'$9,999')"�μ� �޿� ����"
     , TO_CHAR(AVG(e.sal),'$9,999')"�μ� �޿� ���"
     , TO_CHAR(MAX(e.sal),'$9,999')"�μ� �޿� �ִ�"
     , TO_CHAR(MIN(e.sal),'$9,999')"�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;
/*
ORA-00979: GROUP BY ǥ������ �ƴմϴ�.
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
284��, 15������ ���� �߻�
*/

-- b) SELECT ���� �׷��Լ� �� �Ϲ� �÷��� ���� ����
--    GROUP BY �� ��ü�� ������ ���
SELECT e.deptno �μ���ȣ
     , e.job ����
     , TO_CHAR(SUM(e.sal),'$9,999')"�μ� �޿� ����"
     , TO_CHAR(AVG(e.sal),'$9,999')"�μ� �޿� ���"
     , TO_CHAR(MAX(e.sal),'$9,999')"�μ� �޿� �ִ�"
     , TO_CHAR(MIN(e.sal),'$9,999')"�μ� �޿� �ּ�"
  FROM emp e
-- GROUP BY e.deptno 
 ORDER BY e.deptno 
;
/*
ORA-00937: ���� �׷��� �׷� �Լ��� �ƴմϴ�
00937. 00000 -  "not a single-group group function"
*Cause:    
*Action:
303��, 8������ ���� �߻�
*/

-- ����) ����(job) �� �޿��� ����, ���, �ִ�, �ּ� �� ���غ���
--       ��Ī : ����, �޿�����, �޿����, �ִ�޿�, �ּұ޿�
SELECT e.job ����
     , TO_CHAR(SUM(e.sal),'$9,999')�޿�����
     , TO_CHAR(AVG(e.sal),'$9,999')�޿����
     , TO_CHAR(MAX(e.sal),'$9,999')�ִ�޿�
     , TO_CHAR(MIN(e.sal),'$9,999')�ּұ޿�
  FROM emp e
 GROUP BY e.job
 ORDER BY e.job
;

/*
����,     �޿�����, �޿����, �ִ�޿�, �ּұ޿�
----------------------------------------------
ANALYST	    $3,000	 $3,000	 $3,000	 $3,000
CLERK	    $3,050	 $1,017	 $1,300	   $800
MANAGER	    $8,275	 $2,758	 $2,975	 $2,450
PRESIDENT	$5,000	 $5,000	 $5,000	 $5,000
SALESMAN	$5,600	 $1,400	 $1,600	 $1,250
null        null     null    null    null
*/

-- ������ null�� ������� ������ ��� '���� �̹���' ���� ���
SELECT NVL(e.job,'���� �̹���')    ����
     , TO_CHAR(SUM(e.sal),'$9,999')�޿�����
     , TO_CHAR(AVG(e.sal),'$9,999')�޿����
     , TO_CHAR(MAX(e.sal),'$9,999')�ִ�޿�
     , TO_CHAR(MIN(e.sal),'$9,999')�ּұ޿�
  FROM emp e
 GROUP BY e.job
 ORDER BY e.job
;

/*
����,       �޿�����,�޿����, �ִ�޿�, �ּұ޿�
----------------------------------------------------
ANALYST	     $3,000	 $3,000	    $3,000	 $3,000
CLERK	     $3,050	 $1,017	    $1,300	   $800
MANAGER	     $8,275	 $2,758	    $2,975	 $2,450
PRESIDENT	 $5,000	 $5,000	    $5,000	 $5,000
SALESMAN	 $5,600	 $1,400	    $1,600	 $1,250
���� �̹���				
*/

-- �μ���, ����, ��� ,�ִ�, �ּ�
-- �μ���ȣ�� null�ΰ�� '�μ� �̹���'���� �з��ǵ���
SELECT NVL(e.deptno,'���� �̹���') �μ���ȣ
     , TO_CHAR(SUM(e.sal),'$9,999')�޿�����
     , TO_CHAR(AVG(e.sal),'$9,999')�޿����
     , TO_CHAR(MAX(e.sal),'$9,999')�ִ�޿�
     , TO_CHAR(MIN(e.sal),'$9,999')�ּұ޿�
  FROM emp e
 GROUP BY e.deptno
 ORDER BY e.deptno
;
/*
ORA-01722: ��ġ�� �������մϴ�
01722. 00000 -  "invalid number"
*Cause:    The specified number was invalid.
*Action:   Specify a valid number.
*/

-- �ذ��� : deptno �� �ذ�

SELECT NVL(TO_CHAR(e.deptno),'���� �̹���') �μ���ȣ
     , TO_CHAR(SUM(e.sal),'$9,999')�޿�����
     , TO_CHAR(AVG(e.sal),'$9,999')�޿����
     , TO_CHAR(MAX(e.sal),'$9,999')�ִ�޿�
     , TO_CHAR(MIN(e.sal),'$9,999')�ּұ޿�
  FROM emp e
 GROUP BY e.deptno
 ORDER BY e.deptno
;


-- ���ڸ� ���ڷ� ���� : ���տ�����(||) �� ���
SELECT NVL(e.deptno||'','���� �̹���') �μ���ȣ
     , TO_CHAR(SUM(e.sal),'$9,999')�޿�����
     , TO_CHAR(AVG(e.sal),'$9,999')�޿����
     , TO_CHAR(MAX(e.sal),'$9,999')�ִ�޿�
     , TO_CHAR(MIN(e.sal),'$9,999')�ּұ޿�
  FROM emp e
 GROUP BY e.deptno
 ORDER BY e.deptno
;
-- NVL,DECODE,TO_CHAR�������� �ذ�
SELECT DECODE(NVL(e.deptno,0), e.deptno, TO_CHAR(e.deptno)
                             , 0       , '�μ� �̹���')�μ���ȣ
     , TO_CHAR(SUM(e.sal),'$9,999')�޿�����
     , TO_CHAR(AVG(e.sal),'$9,999')�޿����
     , TO_CHAR(MAX(e.sal),'$9,999')�ִ�޿�
     , TO_CHAR(MIN(e.sal),'$9,999')�ּұ޿�
  FROM emp e
 GROUP BY e.deptno
 ORDER BY e.deptno
;

/*
�μ���ȣ, �޿�����, �޿����, �ִ�޿�, �ּұ޿�
------------------------------------------------
10	 $8,750	 $2,917	 $5,000	 $1,300
20	 $6,775	 $2,258	 $3,000	   $800
30	 $9,400	 $1,567	 $2,850	   $950
���� �̹���				
*/

---------- 4. HAVING ���� ���
-- GROUP BY ����� ������ �ɾ
-- �� ����� ������ �������� ���Ǵ� ��.
-- WHERE ���� WHERE ���� ���������
-- SELECT ������ ���� ����������
-- GROUP BY �� ���� ���� ����Ǵ� WHERE ���δ�
-- GROUP BY ����� ������ �� ����.
-- ���� GROUP BY ���� ��������� ������
-- HAVING ���� �����Ѵ�.

-- ����) �μ��� �޿� ����� 2000 �̻��� �μ��� ��ȸ�Ͽ���.
-- a) �켱 �μ��� �޿� ����� ���Ѵ�.
SELECT e.deptno
     , AVG(e.sal)
  FROM emp e
 GROUP BY e.deptno
;

-- b) a�� ������� �޿������  2000�̻��� ���� �����.
--    HAVING ���� ��� ����

SELECT e.deptno
     , AVG(e.sal)
  FROM emp e
 GROUP BY e.deptno
HAVING avg(e.sal) >= 2000
;

-- ����� ���� ����
SELECT e.deptno
     , TO_CHAR(AVG(e.sal),'$9,999')
  FROM emp e
 GROUP BY e.deptno
HAVING avg(e.sal) >= 2000
;

-- ����: HAVING ���� ��Ī�� ����� �� ����.
SELECT e.deptno �μ���ȣ
     , AVG(e.sal) �޿����
  FROM emp e
 GROUP BY e.deptno
HAVING �޿���� >= 2000
;


-- HAVING ���� �����ϴ� ��� SELECT������ ���� ���� ����
/*
1. FROM     ���� ���̺� �� �� ��θ� �������
2. WHERE    ���� ���ǿ� �´� �ุ �����ϰ�
3. GROUP BY ���� ���� �÷�, ��(�Լ� ��) ���� �׷�ȭ ����
4. HAVING   ���� ������ ������Ű�� �׷��ุ ����
5.          4���� ���õ� �׷� ������ ���� �࿡ ���ؼ�
6.SELECT    ���� ��õ� �÷�, ��(�Լ� ��)�� ���
7.ORDER BY  �� �ִٸ� �������ǿ� ���߾�
*/

----------------------------------------------------------------

-- ������ �ǽ�
-- 1. �Ŵ�����, ���������� ���� ���ϰ�, ���� ������ ����
--   : mgr �÷��� �׷�ȭ ���� �÷�
SELECT e.mgr �Ŵ�����ȣ
     , COUNT(e.mgr) "���������� ��"
  FROM emp e
 GROUP BY e.mgr
 ORDER BY COUNT(e.mgr) DESC
;

/*
�Ŵ�����ȣ, ���������� ��
-------------------------
7698	    5
7839	    3
7566	    1
7782	    1
7902	    1
null        0
*/

-- 2.1 �μ��� �ο��� ���ϰ�, �ο��� ���� ������ ����
--    : deptno �÷��� �׷�ȭ ���� �÷�
SELECT e.deptno �μ���ȣ
     , COUNT(e.deptno) "�μ��� �ο�"
  FROM emp e
 GROUP BY e.deptno
 ORDER BY COUNT(e.deptno) DESC
;
/*
�μ���ȣ, �μ��� �ο�
-------------------------
30	        6
20	        3
10	        3
null        0
*/
-- 2.2 �μ� ��ġ �̹��� �ο� ó��
SELECT NVL(TO_CHAR(e.deptno||''),'�μ� ��ġ �̹���') �μ���ȣ
     , COUNT(e.deptno) "�μ��� �ο�"
  FROM emp e
 GROUP BY e.deptno
 ORDER BY COUNT(e.deptno) DESC
;

/*
�μ���ȣ, �μ��� �ο�
---------------------
30	                6
20	                3
10	                3
�μ� ��ġ �̹���	0
*/

-- 3.1 ������ �޿� ��� ���ϰ�, �޿���� ���� ������ ����
--   : job �� �׷�ȭ ���� �÷�

SELECT e.job ����
     , TO_CHAR(AVG(e.sal),'$9,999') "�޿� ���"
  FROM emp e
 GROUP BY e.job
 ORDER BY AVG(e.sal) DESC
;

/*
����,     �޿� ���
-------------------
null        null
PRESIDENT	$5,000
ANALYST	    $3,000
MANAGER	    $2,758
SALESMAN	$1,400
CLERK	    $1,017
*/
-- 3.2 job �� null �� ������ ó��

SELECT NVL(e.job,'���� �̹���') ����
     , TO_CHAR(AVG(e.sal),'$9,999') "�޿� ���"
  FROM emp e
 GROUP BY e.job
 ORDER BY AVG(e.sal) DESC
;

/*
����,     �޿� ���
-------------------
���� �̹���	
PRESIDENT	 $5,000
ANALYST	     $3,000
MANAGER	     $2,758
SALESMAN	 $1,400
CLERK	     $1,017
*/

-- 4. ������ �޿� ���� ���ϰ�, ���� ���� ������ ����
--   : job �� �׷�ȭ ���� �÷�

SELECT e.job ����
     , SUM(e.sal) "�޿� ����"
  FROM emp e
 GROUP BY e.job
 ORDER BY SUM(e.sal) DESC
;

/*
����,  �޿� ����
----------------
MANAGER	    8275
SALESMAN	5600
PRESIDENT	5000
CLERK	    3050
ANALYST	    3000
*/
-- 5. �޿��� �մ����� 1000�̸�, 1000, 2000, 3000, 5000 ���� �ο����� ���Ͻÿ�
--    �޿� ���� ������������ ����

SELECT CASE         WHEN e.sal between 0    and 1000 THEN 0
                    WHEN e.sal between 1000 and 2000 THEN 1000
                    WHEN e.sal between 2000 and 3000 THEN 2000
                    WHEN e.sal between 3000 and 4000 THEN 3000
                    WHEN e.sal between 4000 and 5000 THEN 4000
                    WHEN e.sal between 5000 and 6000 THEN 5000 END �޿�����
     , COUNT(*) �ο���
  FROM emp e
 GROUP BY CASE      WHEN e.sal between 0    and 1000 THEN 0
                    WHEN e.sal between 1000 and 2000 THEN 1000
                    WHEN e.sal between 2000 and 3000 THEN 2000
                    WHEN e.sal between 3000 and 4000 THEN 3000
                    WHEN e.sal between 4000 and 5000 THEN 4000
                    WHEN e.sal between 5000 and 6000 THEN 5000 END
 ORDER BY e.sal
;
-- 6. ������ �޿� ���� ������ ���ϰ�, �޿� ���� ������ ū ������ ����

SELECT e.job ����
     , SUM(e.sal) "�޿� ��"
  FROM emp e
 GROUP BY e.job
 ORDER BY SUM(e.sal) DESC
;
/*
����,      �޿� ��
-----------------
null        null	
MANAGER	    8275
SALESMAN	5600
PRESIDENT	5000
CLERK	    3050
ANALYST	    3000
*/

-- 7. ������ �޿� ����� 2000������ ��츦 ���ϰ� ����� ���� ������ ����

SELECT e.job ����
     , TO_CHAR(AVG(e.sal),'$9,999') "�޿� ���"
  FROM emp e
 GROUP BY e.job
HAVING AVG(e.sal) <= 2000
 ORDER BY AVG(e.sal) DESC
;

/*
����,     �޿� ���
-------------------
SALESMAN	 $1,400
CLERK	     $1,017
*/

-- 8. �⵵�� �Ի� �ο��� ���Ͻÿ�

SELECT to_char(e.hiredate,'YY')
     , COUNT(*)
  FROM emp e
 GROUP BY to_char(e.hiredate,'YY')
;