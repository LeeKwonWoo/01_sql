-- day13

-----------------------------------------------------
-- ����Ŭ�� Ư���� �÷� 2����
-- : ����ڰ� ���� �� ��� �ڵ��� �������Ǵ� �÷�

-- 1. ROWID : ���������� ��ũ�� ����� ��ġ�� ����Ű�� ��
--        ������ ��ġ ������ �� ��� �ݵ�� ������ ���� �� �ۿ� ����
--        ORDER BY ���� ���� ������� �ʴ� ��

-- 2. ROWNUM : ��ȸ�� ����� ù��° ����� 1�� �����ϴ� ��
------------------------------------------------------------------------

-- ��) emp ���̺��� 'SMITH' �� ��ȸ
SELECT e.empno
     , e.ename
  FROM emp e
 WHERE e.ename = 'SMITH'
;

-- ROWID �� ���� ��ȸ

SELECT e.rowid
     , e.empno
     , e.ename
  FROM emp e
 WHERE e.ename = 'SMITH'
;

-- ROWNUM �� ���� ��ȸ
SELECT rownum
     , e.empno
     , e.ename
  FROM emp e
 WHERE e.ename = 'SMITH'
;

-- ORDER BY ���� ���� ROWNUM �� ����Ǵ� ��� Ȯ��
-- (1) ORDER BY �� ���� ���� ROWNUM
SELECT rownum
     , e.empno
     , e.ename
  FROM emp e
;
-- (2) ename ������ �������� ���� �� ROWNUM �� Ȯ��
SELECT rownum
     , e.empno
     , e.ename
  FROM emp e
 ORDER BY e.ename
;

-- ==> ROWNUM �� ORDER BY ����� ������ ���� �ʴ� ��ó�� ���� �� ����.
--     SUB-QUERY �� ����� �� ������ ����.
-- (3) SUB-QUERY �� ���� �� ROWNUM �� �� Ȯ��
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

-- �̸��� A �� ���� ������� ��ȸ (ORDER BY ����)
SELECT ROWNUM
     , e.ename
  FROM emp e
 WHERE e.ename LIKE '%A%'
;

-- �̸��� A �� ���� ������� �̸������� �����Ͽ� ��ȸ
SELECT ROWNUM
     , e.ename
  FROM emp e
 WHERE e.ename LIKE '%A%'
 ORDER BY e.ename
;

-- �̸��� S �� ���� ������� ��ȸ
-- �̋�, ROWNUM, ROWID �� Ȯ��
SELECT ROWNUM
     , e.ROWID
     , e.ename
  FROM emp e
 WHERE e.ename LIKE '%S%'
 ORDER BY e.ename
;

-- �̸��� S�� ���� ������� ��ȸ �����
-- SUB-QUERY �� ������ ���� ROWNUM, ROWID Ȯ��
SELECT ROWNUM
     , a.rowid
     , a.ename
  FROM (SELECT e.rowid
             , e.ename
          FROM emp e
         WHERE e.ename LIKE '%S%'
         ORDER BY e.ename) a
;

-- ROWNUM ���� �� �� �ִ� ����
-- emp ���� �޿��� ���� �޴� ���� 5���� ��ȸ�Ͻÿ�.

-- 1. �޿��� ���� ���� ����
SELECT e.empno
     , e.ename
     , e.sal
  FROM emp e
 ORDER BY e.sal DESC
;

-- 2. 1�� ����� SUB-QUERY �� FROM ���� ����Ͽ�
--    ROWNUM �� ���� ��ȸ
SELECT ROWNUM
     , a.*
  FROM (SELECT e.empno
             , e.ename
             , e.sal
          FROM emp e
         ORDER BY e.sal DESC) a
;
-- 3. �� ��, ROWNUM <= 5 ������ �߰�
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
-- DML : ������ ���۾�
--------------------------------------------------------------------------
-- 1) INSERT : ���̺� ������ ��(row)�� �߰��ϴ� ���
-- MEMBER ���̺� ������ �߰� ����
DROP TABLE member;
CREATE TABLE member
( member_id     VARCHAR2(4)     
 ,member_name   VARCHAR2(15)    NOT NULL
 ,phone         VARCHAR2(4)     -- NULL ����Ϸ��� ���������� �Ⱦ��� �ȴ�.
 ,reg_date      DATE            DEFAULT sysdate
 ,address       VARCHAR2(30)
 ,major         VARCHAR2(50)
 ,birth_month   NUMBER(2)
 ,gender        VARCHAR2(1) CHECK (gender IN ('F','M'))
 , CONSTRAINT PK_MEMBER PRIMARY KEY (member_id)
 , CONSTRAINT CK_GENDER CHECK (gender IN ('F','M'))
 , CONSTRAINT CK_BIRTH  CHECK (BIRTH_MONTH BETWEEN 1 AND 12)
);

--- 1. INTO ������ �÷��̸� ������ ������ �߰�
--     : VALUES ���� �ݵ�� ��ü �÷��� ��Ƽ� ������� ��� ����
INSERT INTO MEMBER VALUES ('M001', '�ڼ���', '9155',sysdate, '������', '����', 3, 'M');
INSERT INTO MEMBER VALUES ('M002', '������', '1418',sysdate, '������', '�Ͼ�', 1, 'M');
INSERT INTO MEMBER VALUES ('M003', '�̺���', '0186',sysdate, NULL,NULL, 3, 'M');
INSERT INTO MEMBER VALUES ('M004', '�蹮��', '1392',sysdate, 'û�ֽ�', '�Ͼ�', 3, 'F');
INSERT INTO MEMBER VALUES ('M005', '����ȯ', '0322',sysdate, '�Ⱦ��', '����', 3, NULL);
COMMIT;

-- GENDER �÷��� CHECK ���������� �����ϴ� ������ �߰� �õ�
-- GENDER �÷���, 'F','M',NULL ���� ���� �߰��ϸ�
INSERT INTO MEMBER VALUES ('M006','ȫ�浿','0001',sysdate,'������','����',3,'G');
--ORA-02290: üũ ��������(SCOTT.CK_GENDER)�� ����Ǿ����ϴ�

-- BIRTH_MONTH �÷��� 1~12 ���� ���ڰ� �Է� �õ�
INSERT INTO MEMBER VALUES ('M006','ȫ�浿','0001',sysdate,'������','����',13,'G');
-- ORA-02290: üũ ��������(SCOTT.CK_BIRTH)�� ����Ǿ����ϴ�

-- MEMBER_NAME �� NULL �Է� �õ�
INSERT INTO MEMBER VALUES ('M006',NULL,'0001',sysdate,'������','����',13,'G');


--- 2. INTO ���� �÷� �̸��� ����� ����� ������ �߰�
--      : VALUES ���� INTO �� �������
--       ���� Ÿ��, ������ ���߾ �ۼ�

INSERT INTO MEMBER (member_id,member_name) VALUES('M007','������');
COMMIT;

INSERT INTO MEMBER (member_id,member_name,gender) VALUES('M008','������','M');
COMMIT;

-- ���̺� ���� ������ ������� INRO ���� �÷��� ������ �� �ִ�.
INSERT INTO MEMBER (birth_month,member_name,member_id) VALUES(NULL,'������','M009');
COMMIT;

-- INTO ���� �÷� ������ VALUES ���� ���� ���� ����ġ
INSERT INTO MEMBER (member_id,member_name) VALUES('M008','���','M');
COMMIT;

-- INTO ��� VALUES ���� ������ ������
-- ���� Ÿ���� ��ġ���� ���� ��
-- ���� ������ �÷��� birth_month �� '�Ѿ�' �̶�� ���ڸ�
-- �߰��Ϸ� �ϴ� �õ�
INSERT INTO MEMBER (member_id,member_name,birth_month) VALUES ('M010','���','�Ѿ�');
COMMIT;

-- �ʼ� �Է� �÷��� �������� ���� ��
-- member_id : PK, member_name : NOT NULL
INSERT INTO MEMBER (birth_month,address,gender) VALUES (12,'��������','F');

--------------------------------------------------------------------------
-- ���� �� �Է� : SUB-QUERY �� ����Ͽ� ����

-- ���б���
INSERT INTO ���̺� �̸�
SELECT ����; --��������

/*
CREATE TABLE ���̺��̸�
AS
SELECT ...
: ���������� �����͸� �����ϸ鼭 �� ���̺��� ����

vs.

INSERT INTO ���̺��̸�
SELECT ����;
: �̹� ������� ���̺� �����͸� �����ؼ� �߰�
*/

-- new_member ����
DROP TABLE new_member;

-- member �����ؼ� ���̺� ����
CREATE TABLE new_member
AS
SELECT a.*
  FROM member a
 WHERE 1 = 2
;

-- ���� �� �Է� ���������� new_member ���̺� ������ �߰�
-- �̸� ��� ���ڰ� '��'�� ������� ������ �߰�
INSERT INTO NEW_MEMBER
SELECT a.*
  FROM member a
 WHERE a.member_name LIKE '_��_'
;
COMMIT;

-- �÷��� ����� ������ �Է�
INSERT INTO new_member (member_id,member_name,phone)
SELECT m.member_id
     , m.member_name
     , m.phone
  FROM member m
 WHERE m.member_id < 'M004'
;

-- new_member �� �߰��� �� ��� ����
DELETE new_member;
COMMIT;

-- ������� ��� �� ������ ����
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


-- ����) new_member ���̺�
--       member ���̺�κ��� �����͸� �����Ͽ� ������ �Է��� �Ͻÿ�.
--       ��, member ���̺��� �����Ϳ��� birth_month ��
--       Ȧ������ ����鸸 ��ȸ�Ͽ� �Է��Ͻÿ�.
INSERT INTO new_member (member_id,member_name,phone,birth_month)
SELECT m.member_id
     , m.member_name
     , m.phone
     , m.birth_month
  FROM member m
 WHERE MOD(m.birth_month,2) = 1 
;

------------------------------------------------------------------------
-- 2) UPDATE : ���̺��� ��(���ڵ�)�� ����
--             WHERE �������� ���տ� ����

--             1�ุ �����ϰų� ���� �� ������ ����
--             ���� ���� �����Ǵ� ���� �ſ� ���ǰ� �ʿ�!!


-- ��) ȫ�浿�� �̸��� �����õ�
UPDATE ���̺��̸�
   SET Į��1 = ��1
     [,�÷�2 = ��2]
     ....
     [,�÷�n = ��n]
 [WHERE ����]
;

-- ��) ȫ�浿�� �̸��� ���� �õ�
UPDATE member m
   SET m.member_name = '�浿��'
 WHERE m.member_id = 'M006'
;

-- ��) �蹮�� ����� ��ȭ��ȣ ���ڸ� ������Ʈ
--     �ʱ⿡ INSERT �� NULL �� �����͸� ���� ���� ���
--     �Ŀ� ������ ������ �߻��� �� �ִ�.
--     �̷� ��� UPDATE �������� ó��.
UPDATE member m
   SET m.phone = '1392'
 WHERE m.member_id = 'M004'
;
COMMIT;

-- ��) ������(M009) ����� ������ ����
-- ������
UPDATE member m
   SET m.major = '������'
 WHERE m.member_id = 'M009' --�Ǽ��� WHERE ����
;
COMMIT;
-- ���� COMMIT���� ROLLBACK ����
ROLLBACK;


-- ���� �÷� ������Ʈ (2�� �̻��� �÷� �ѹ��� ������Ʈ)
-- ��) ������(M008) ����� ��ȭ��ȣ, �ּ�, ������ �ѹ��� ������Ʈ
-- SET ���� ������Ʈ �� �÷��� ���� ����
UPDATE member m
   SET m.major = '�Ͼ�'
     , m.address = '�ƻ��'
     , m.phone = '4119'
 WHERE m.member_id = 'M008'
;
COMMIT;

-- ��) '�Ⱦ��'�� ��� '����ȯ' ����� GENDER ���� ����
--     WHERE ���ǿ� �ּҸ� ���ϴ� ������ ���� ���
UPDATE member m
   SET m.gender = 'M'
 WHERE m.address = '�Ⱦ��'
;
ROLLBACK;
-- UPDATE �ۼ��ÿ��� WHERE �������� �ۼ��� ���Ǹ� ��￩����.
-- 1���� �����ϴ� �����̶�� �ݵ�� PK �÷��� ���ؾ��Ѵ�.

-- UPDATE ������ SELECT ���������� ���
-- ��) ������(M008) ����� major ��
--     ������(M002) ����� major �� ����

-- 1) M008 �� major �� ���ϴ� SELECT
SELECT m.major
  FROM member m
 WHERE m.member_id = 'M008'
;

-- 2) M002 ����� major �� �����ϴ� UPDATE ���� �ۼ�
UPDATE member m
   SET m.major = ?
 WHERE m.member_id = 'M002'
;
-- 3) (1)�� ����� (2) UPDATE ������ ����
UPDATE member m
   SET m.major = (SELECT m.major
                    FROM member m
                   WHERE m.member_id = 'M008')
 WHERE m.member_id = 'M002'
;

-- ���� SET ���� ����ϴ� ���������� �����
-- ��Ȯ�ϰ� 1�� 1���� 1���� ���� �ƴ� ��� ��������
UPDATE member m
   SET m.major = (SELECT m.major
                    FROM member m)
 WHERE m.member_id = 'M002'
;

-- UPDATE �� �������� �����ϴ� ���
-- ��) M001 �� member_id ������ �õ�
--     : PK �÷� ������ �õ��ϴ� ���
UPDATE member m
   SET m.member_id = 'M002'
 WHERE m.member_id = 'M001'
;

-- ��) NOT NULL �� member_name �� NULL �����ͷ�
--     ������Ʈ�� �õ��ϴ� ���

-- ��) M001 �����Ϳ� ���ؼ�
--     birth_month �� -1�� �����õ�
UPDATE member m
   SET m.birth_month = -1
 WHERE m.member_id = 'M001'
;

---------------------------------------------------------------------
-- ������ �ǽ�


-- 1) PHONE �÷��� NULL�� ����� 
-- �ϰ������� '0000'���� ������Ʈ
-- : PK �� �� �ʿ� ���� ����
UPDATE member m
   SET m.phone = '0000'
 WHERE m.phone IS NULL
;
-- 2) M001 ����� ������
--    NULL ������ ������Ʈ
--     pk ���
UPDATE member m
   SET m.major = ''
 WHERE m.member_id = 'M001'
;
-- 3) address �÷��� NULL �λ���� �ϰ������� '�ƻ��'�ξ�����Ʈ
UPDATE member m
   SET m.address = '�ƻ��'
 WHERE m.address IS NULL
;
-- 4) M009 ����� NULL �����͸�
--    ��� ������Ʈ
--    PHONE : 3581
--    ADDRESS : õ�Ƚ�
--    GENDER : M

UPDATE member m
   SET m.phone = '3581'
     , m.address = 'õ�Ƚ�'
     , m.gender = 'M'
 WHERE m.member_id = 'M009'
;