-- day12 : DDL (Data Definition Language)
--         ������ ���Ǿ�
-- 1. ���̺��� �����ϴ� ���ɾ� => ���̺��� DBMS�� OBJECT�� �ϳ�
-- 2. DBMS �� OBJECT(��ü) �� ����/�ν� �ϴ� �����
--    ����, ����, ���� �ϴ� ���ɾ�

-- ���� : CREATE
-- ���� : ALTER
-- ���� : DROP

-- vs.DML (Data Manipulation Language) ������ ���Ǿ�
-- ���� : INSERT
-- ���� : UPDATE
-- ���� : DELETE

--------------------------------------------------------------------
/* DDL ������ ����

   CREATE | ALTER | DROP {������ ��ü�� Ÿ�Ը�}
   
   DBMS�� OBJECT(��ü)�� ����
   SHEMA, DOMAIN, TABLE, VIEW, INDEX, SEQUENCE, USER, DATABASE

*/
-- CREATE TABLE ���� ����
CREATE TABLE ���̺� �̸�
( �÷�1�̸� ������Ÿ��[(����)] [DEFAULT �⺻��] [�÷��� �������]
 [,�÷�2�̸� ������Ÿ��[(����)] [DEFAULT �⺻��] [�÷��� �������]]
 ...
 [,�÷�2�̸� ������Ÿ��[(����)] [DEFAULT �⺻��] [�÷��� �������]]
);

/* ------------------
   �÷��� �������
   1. PRIMARY KEY : �� �÷��� �ԷµǴ� ���� �ߺ����� �ʰ�
                    �� ���� �ĺ��� �� �ִ� ������ �����ؾ� �ϸ�
                    NULL������ �Է��� �Ұ����� ���̾�� �Ѵ�.
   2. FOREIGN KEY : �ַ� JOIN�� ���Ǵ� ������������
                    �ٸ� ���̺��� PRIMARY KEY��  ���Ǿ��� ���� �����ؾ߸� �Ѵ�.
   3. UNIAUE      : �� �÷��� �Էµ� ���� �ߺ����� ������ ����
                    NULL ������ �Է��� �����ϴ�.
                    ==> �����Ͱ� NULL(���ų�) �̰ų�
                        NULL��  �ƴϸ� �ݵ�� ������ ���̾�� ��.
   4. NOT NULL    : �� �÷��� �ԷµǴ� ���� �ߺ��� ���������
                    NULL ���´� ���� �ʵ��� �����Ѵ�.
                    
   ==> PK : UNIQUE + NOT NULL ���յ� ���¶�� ���� �� �� �ִ�.
*/

-- ��) û���� ���� �����ο� ������ ������ ���̺��� ����
/*
    ���̺� �̸�: member
    1. ������̵�      : member_id   :���� : VARCHAR2 :PK
    2. ��� �̸�       : member_name :���� : VARCHAR2 :NOT NULL
    3. ��ȭ��ȣ ���ڸ� : phone       :���� : VARCHAR2
    4. �ý��۵����    : reg_data    :��¥ : DATE
    5. ��� ��(���̸�) : address     :���� : VARCHAR2
    6. �����ϴ� ����   : like_number :���� : NUMBER
    7. ����            : major       :���� : VARCHAR2
*/

-- 1. ���̺� ���� ���� : member
CREATE TABLE member
( member_id     VARCHAR2(4)     PRIMARY KEY
 ,member_name   VARCHAR2(15)    NOT NULL
 ,phone         VARCHAR2(4)     -- NULL ����Ϸ��� ���������� �Ⱦ��� �ȴ�.
 ,reg_date      DATE            DEFAULT sysdate
 ,address       VARCHAR2(30)     
 ,like_number   NUMBER
 ,major         VARCHAR2(50)
);

-- Table MEMBER��(��) �����Ǿ����ϴ�.

-- 2. ���̺� ���� ����
DROP TABLE ���̺� �̸�;
DROP TABLE member;

-- 3. ���̺� ���� ����
/* -------------------
   ������ ����
   ----------------------------
   1. �÷��� �߰� : ADD
   2. �÷��� ���� : MODIFY
   3. �÷��� ���� : DROP COLUMN
   ----------------------------
*/

ALTER TABLE ���̺��̸� {ADD | MODIFY | DROP COLUMN} ....;
-- ��) ������ member ���̺��� �÷� 2���� �߰�
-- ��� �� : birth_month : NUMBER
-- ����    : gender      : VARCHAR(1) : F,M �� ���� �� �ϳ��� �Է°����ϵ���

-- 1) ADD
-- member ���̺� ���� �� �Ʒ� ���� ����
ALTER TABLE member ADD
( birth_month NUMBER
 ,gender      VARCHAR2(1) CHECK (gender IN ('F','M'))
);

-- 2) MODIFY
-- ��) ��� �� �÷��� ����2 �ڸ������� �����ϵ��� ����
ALTER TABLE ���̺��̸� MODIFY �÷��̸� ������Ÿ��(ũ��);
ALTER TABLE member MODIFY birth_month NUMBER(2);

-- 3) DROP COLUMN
-- ��) ������ ���̺� member���� like_number �÷��� ����
ALTER TABLE ���̺��̸� DROP COLUMN �÷��̸�;
ALTER TABLE member DROP COLUMN like_number;

---------------------------------------------------------
-- ���� ����� member ���̺��� ��������
CREATE TABLE member
( member_id     VARCHAR2(4)     PRIMARY KEY
 ,member_name   VARCHAR2(15)    NOT NULL
 ,phone         VARCHAR2(4)     -- NULL ����Ϸ��� ���������� �Ⱦ��� �ȴ�.
 ,reg_date      DATE            DEFAULT sysdate
 ,address       VARCHAR2(30)
 ,major         VARCHAR2(50)
 ,birth_month NUMBER(2)
 ,gender      VARCHAR2(1) CHECK (gender IN ('F','M'))
);

-- ���� �ܼ�ȭ�� ���̺� ���� ����
-- ���������� �� �÷� �ڿ� �ٷ� �������� �̸� ���� ����

-- �������ǿ� �̸��� �ο��ؼ� ���� :
-- �÷��� ���ǰ� ���� �� �������� ���Ǹ� ���Ƽ� �ۼ�
-- ���̺� ����
DROP TABLE member;
-- �������� �̸��� �־� member ���̺�����
CREATE TABLE member
( member_id     VARCHAR2(4)     
 ,member_name   VARCHAR2(15)    NOT NULL
 ,phone         VARCHAR2(4)     -- NULL ����Ϸ��� ���������� �Ⱦ��� �ȴ�.
 ,reg_date      DATE            DEFAULT sysdate
 ,address       VARCHAR2(30)
 ,major         VARCHAR2(50)
 ,birth_month   NUMBER(2)
 ,gender        VARCHAR2(1) 
-- ,CONSTRAINT ���������̸� ��������Ÿ�� (������)
 ,CONSTRAINT pk_member        PRIMARY KEY (member_id)
 ,CONSTRAINT ok_member_gender CHECK (gender IN ('M','F'))
);

-- ���̺� ������ DDL �� ������ ������ �ý��� īŻ�α׿� �����
-- user_tables, user_constraints
-- �ΰ��� �ý��� īŻ�α� ���̺��� ��ȸ

-- 1) �����̺��� ����(�÷� �̸�) ��ȸ
-- ���� ����(SCOTT)�� ������ �ִ� ���̺� ����� ��ȸ
SELECT t.table_name
  FROM user_tables t
;
/*
TABLE_NAME
----------
DEPT
EMP
BONUS
SALGRADE
MEMBER
*/
DESC user_tables;

DESC user_constraints;
-- ���� ����(SCOTT)�� �������ִ� ���̺� ����
SELECT c.constraint_name
     , c.constraint_type
     , c.table_name
  FROM user_constraints c
;
/*
CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
--------------------------------------------
FK_DEPTNO	        R	            EMP
PK_DEPT	            P	            DEPT
OK_MEMBER_GENDER	C	            MEMBER
PK_EMP	            P	            EMP
PK_MEMBER	        P	            MEMBER
*/

-- MEMBER ���̺��� �������Ǹ� Ȯ��
SELECT c.constraint_name
     , c.constraint_type
     , c.table_name
  FROM user_constraints c
 WHERE c.table_name = 'MEMBER'
;
/*
CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
--------------------------------------------
SYS_C007478	        C	            MEMBER
OK_MEMBER_GENDER	C	            MEMBER
PK_MEMBER	        P	            MEMBER
*/

-- user_objects : ���� ����ڰ� ������ �ִ� object���� ������ ����Ǵ�
--                �ý��� īŻ�α� ���̺�
DESC user_objects;

SELECT o.object_name
     , o.object_id
     , o.object_type
  FROM user_objects o
;

/*
OBJECT_NAME, OBJECT_ID, OBJECT_TYPE
-----------------------------------
DEPT	    73559	    TABLE
PK_DEPT	    73560	    INDEX
PK_EMP	    73570	    INDEX
EMP	        73569	    TABLE
BONUS	    73571	    TABLE
SALGRADE	73572	    TABLE
MEMBER	    74336	    TABLE
PK_MEMBER	74337	    INDEX
*/

-- ���̺� ���� ����� �̹� �����ϴ� ���̺��� ���� ���� ����
-- ���̺� ���� ���� ���� ����
CREATE TABLE ���̺��̸�
AS
SELECT �÷��̸�...
  FROM ���������̺�
 WHERE �׻� ������ �Ǵ� ����
;

-- ��) �ռ� ������ member ���̺����� ���� : new_member
CREATE TABLE new_member
AS
SELECT m.*
  FROM member m
 WHERE 1=2 -- �׻� ������ �Ǵ� ����
;

-- PK ������ ������� �ʰ� ���̺� ����(��ȸ�� �÷���) �����

-- Table NEW_MEMBER��(��) �����Ǿ����ϴ�.
-- new_member ���̺��� ������ ��ȸ
DESC new_member;



/*
-- member ���̺��� ������ �߰�
*/
INSERT INTO "SCOTT"."MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, ADDRESS, MAJOR, BIRTH_MONTH, GENDER) VALUES ('M001', '�ڼ���', '9155', '������', '����', '3', 'M')
INSERT INTO "SCOTT"."MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, ADDRESS, MAJOR, BIRTH_MONTH, GENDER) VALUES ('M002', '������', '1418', '������', '�Ͼ�', '1', 'M')
INSERT INTO "SCOTT"."MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, ADDRESS, MAJOR, BIRTH_MONTH, GENDER) VALUES ('M003', '�̺���', '0186', 'õ�Ƚ�', '�İ�', '3', 'M')
INSERT INTO "SCOTT"."MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, ADDRESS, MAJOR, BIRTH_MONTH, GENDER) VALUES ('M004', '�蹮��', '1392', 'û�ֽ�', '�Ͼ�', '3', 'F')
INSERT INTO "SCOTT"."MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, ADDRESS, MAJOR, BIRTH_MONTH, GENDER) VALUES ('M005', '����ȯ', '0322', '�Ⱦ��', '����', '3', 'F')
COMMIT;

-- 3������ ������ �����ؼ� �� ���̺��� ����
CREATE TABLE march_member
AS
SELECT m.*
  FROM member m
 WHERE m.birth_month = 3
;
-- �����Ͽ� ���̺� ������ ���� �� �� �ִ� ������ �ָ�
-- �ش� ������ �����ϴ� ���� �����ͱ��� ����Ǹ鼭 ���̺� ����

-- �׻� ���̵Ǵ� ������ �ָ� ��� �����͸� �����ϸ鼭 ���̺� ����
CREATE TABLE full_member
AS
SELECT m.*
  FROM member m
 WHERE 1=1
;


-- full_member ����
DROP TABLE full_member;
CREATE TABLE full_member
AS
SELECT m.*
  FROM member m
    --where �������� �����ϸ�
    --�׻� ���� ����� �����ϹǷ� ��� �����Ͱ� ����Ǹ� �� ���̺� ����
;

-----------------------------------------
-- ���̺� ����(ALTER) ���ǻ���

-- 1) �÷��� ���� �� : ��� ���濡 �����ο�
--                     ������ Ÿ�Ժ���, ������ ũ�⺯�濡 ��� �����ο�

-- 2) �÷��� �����Ͱ� ���� ��
--  : �����Ͱ� �ҽǵǸ� �ȵǹǷ� ���濡 ������ ����
--    Ÿ�� ������ ���� Ÿ�Գ������� ����
--    ���� Ÿ�԰��� CHAR -> VARCHAR2 ���� ����

--    ũ�� ������ ���� Ȥ�� Ŀ���� �������θ� ����
--    ���� Ÿ���� ũ�⺯���� ���е��� Ŀ���� �������θ� ����

-- ��) MARCH_MONTH ���̺����� BIRTH_MONTH �÷���
--     ������ Ÿ���� ũ�⸦ NUMBER(1) �� ���̸�
ALTER TABLE MARCH_MEMBER MODIFY (BIRTH_MONTH NUMBER(1));

/*
ORA-01440: ���� �Ǵ� �ڸ����� ����� ���� ��� �־�� �մϴ�
01440. 00000 -  "column to be modified must be empty to decrease precision or scale"
*Cause:    
*Action:
*/
-- ���ڵ������� ���е��� �����ϴ� ������ �����ϸ�
-- 2 -> 10�ڸ�, ���� �Ҽ��� 2�ڸ�
ALTER TABLE MARCH_MEMBER MODIFY (BIRTH_MONTH NUMBER(10,2));

-- ���� �������� BIRTH_MONTH �÷��� ���� �����ͷ� ����
ALTER TABLE MARCH_MEMBER MODIFY (BIRTH_MONTH VARCHAR2(1));
/*
ORA-01439: ������ ������ ������ ���� ��� �־�� �մϴ�
01439. 00000 -  "column to be modified must be empty to change datatype"
*Cause:    
*Action:
*/

-- MARCH_MEMBER ���̺��� ��� �࿡ ���ؼ�
-- BIRTH_MONTH �÷��� ���� NULL �����ͷ� �����ϴ¸���

UPDATE "SCOTT"."MARCH_MEMBER"
   SET BIRT_MONTH = ''
COMMIT;
-- �����Ͱ� ���� �÷����� ���� ��
-- VARCHAR2(2) �����÷��� ����
ALTER TABLE MARCH_MEMBER MODIFY (BIRTH_MONTH VARCHAR2(2));
-- NUMBER(1) ����1�ڸ� �÷����� ����
ALTER TABLE MARCH_MEMBER MODIFY (BIRTH_MONTH NUMBER(1));
----------------------------------------------------------------------------------------------------------
-- 3) �⺻ ��(DEFAULT) ������ ���� ���� ������ ���� ��.
-- ��) 3�� ���� ����� ������ MARCH_MEMBER ���̺��� �����غ���.
--   : BIRTH_MONTH �÷��� ���� �׻� 3 ���� �����Ǿ �� �� ����.

-- a)
-- MARCH_MEMBER ���̺���
-- BIRTH_MONTH �÷��� ���� ���� ��� ���� 1�� �߰�
INSERT INTO "SCOTT"."MARCH_MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, ADDRESS, MAJOR, GENDER) VALUES ('M006', '�Կ���', '0437', '������', '�İ�', 'F');
COMMIT;
-- b) a�� ��� ���� �߰� �� DEFAULT ���� �߰�
ALTER TABLE march_member MODIFY (BIRTH_MONTH DEFAULT 3);

-- c) MARCH_MEMBER ���̺��� DEFAULT ���� �߰� ��
--    �� ����� �߰�
INSERT INTO "SCOTT"."MARCH_MEMBER" (MEMBER_ID, MEMBER_NAME, ADDRESS, GENDER) VALUES ('M007', 'ȫ�浿', '������', 'M');
COMMIT;


-------------------------------------------
-- ���̺� ���Ἲ ���� ���� ó����� 4����

/*
 MAIN_TABLE
 ID       VARCHAR2(10)    PK
 NICNAME  VARCHAR2(30)    UNIQUE
 REG_DATE DATE            DEFAULT SYSDATE
 GENDER   VARCHAR2(1)     CHECK (GENDER IN ('M','F'))
 MESSAGE  VARCHAR2(300)
 ------------------------------------------
 
 SUB_TABLE
 -------------------------------------------
 ID         VARCHAR2(10)    REFERENCES MAIN_TABLE(ID)
                            (FK FROM MAIN_TABLE.ID)
 HOBBY      VARCHAR2(200)
 BIRTH_YEAR NUMBER(4)
*/

----- 1. �÷� ������ ��, ���� ���� �̸� ���� �ٷ� ����
DROP TABLE main_table1;
CREATE TABLE main_table1
( ID       VARCHAR2(10)    PRIMARY KEY
 ,NICNAME  VARCHAR2(30)    UNIQUE
 ,REG_DATE DATE            DEFAULT SYSDATE
 ,GENDER   VARCHAR2(1)     CHECK (GENDER IN ('M','F'))
 ,MESSAGE  VARCHAR2(300)
);

DROP TABLE SUB_TABLE1;
CREATE TABLE SUB_TABLE1
( ID         VARCHAR2(10)    REFERENCES MAIN_TABLE1(ID)
 ,HOBBY      VARCHAR2(200)
 ,BIRTH_YEAR NUMBER(4)
);


----- 2. �÷������Ҷ�, ���� ���� �̸��� �ָ� ����
DROP TABLE main_table2;
CREATE TABLE main_table2
( ID       VARCHAR2(10)    CONSTRAINT PK_MAIN PRIMARY KEY
 ,NICNAME  VARCHAR2(30)    CONSTRAINT PK_NICNAME UNIQUE
 ,REG_DATE DATE            DEFAULT SYSDATE
 ,GENDER   VARCHAR2(1)     CONSTRAINT CK_GENDER CHECK (GENDER IN ('M','F'))
 ,MESSAGE  VARCHAR2(300)
);

DROP TABLE SUB_TABLE2;
CREATE TABLE SUB_TABLE2
( ID         VARCHAR2(10)    REFERENCES MAIN_TABLE2(ID)
 ,HOBBY      VARCHAR2(200)
 ,BIRTH_YEAR NUMBER(4)
);

-- MAIN_TABLE1, MAIN_TABLE2 �� ���������� ��
                                        -- �ؿ��ŷ� ����--
-- 3. �÷� ���� �� ���� ���� ���� ����
DROP TABLE main_table3;
CREATE TABLE main_table3
( ID       VARCHAR2(10)    
 ,NICNAME  VARCHAR2(30)    
 ,REG_DATE DATE          DEFAULT SYSDATE
 ,GENDER   VARCHAR2(1)     
 ,MESSAGE  VARCHAR2(300)
 ,CONSTRAINT PK_MAIN3    PRIMARY KEY (ID)
 ,CONSTRAINT PK_NICNAME3 UNIQUE (NICNAME)
 ,CONSTRAINT CK_GENDER3  CHECK  (GENDER IN ('M','F'))
);

DROP TABLE SUB_TABLE3;
CREATE TABLE SUB_TABLE3
( ID         VARCHAR2(10)    
 ,HOBBY      VARCHAR2(200)
 ,BIRTH_YEAR NUMBER(4)
 ,CONSTRAINT FK_SUB3 FOREIGN KEY(ID) REFERENCES MAIN_TABLE3(ID)
 -- SUB_TABLE3 �� ��� PRIMARY KEY �� ID, BIRTH_YEAR �� ����Ű�� ����
 -- ����Ű�� PK�� �������� ���� �ݵ�� �������� �߰��θ� ��������
 ,CONSTRAINT PK_SUB3 PRIMARY KEY (ID,BIRTH_YEAR)
);