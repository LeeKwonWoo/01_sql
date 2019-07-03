-- day14 : dml ���

------------------------------------------------------------------------------------------
-- 3) DELETE : ���̺��� ������� �����͸� ����

-- DELETE ���� ����
DELETE [FROM] ���̺��̸�
 WHERE ����
;

--- 1. WHERE ������ �ִ� DELETE ����
-- ������ Ŀ��
COMMIT;

-- member ���̺��� gender 'F' �� �����͸� ����

DELETE member m
 WHERE m.gender = 'F'
;

ROLLBACK;

DELETE member m
 WHERE m.member_id = 'M004'
;
COMMIT;
-- 3. DELETE �� WHERE �� �������� ����
-- ��) �ּҰ� '�ƻ��' �� ����� ��� ����
DELETE member m
 WHERE m.address = '�ƻ��'
;

SELETE m.member_id
  FROM member m
 WHERE m.address = '�ƻ��'

--- new_member �� TRUNCATE �� �߶󳻺���.
--TRUNCATE ������ �� �ǵ��ư� COMMIT ����

TRUNCATE new_member;

---------------------------------------------------------------------------
-- TCL : Transaction control Language

-- 1) COMMIT :
-- 2) ROLLBACK :
-- 3) SAVEPOINT :
--- 1. member ���̺� 1���� �߰�
---- 1.1 INSERT ���� Ŀ������ ����
COMMIT;
---- 1.2 DML : INSERT �۾� ����
INSERT INTO member m (m.member_id, m.member_name) VALUES ('M010','ȫ�浿');

---- 1.3 1�� �߰����� �߰����� ����
SAVEPOINT do_insert;
--- 2. ȫ�浿�� �ּҸ� ������Ʈ
---- 2.1 DML : UPDATE �۾� ����
UPDATE member m
   SET m.address = '������'
 WHERE m.member_id = 'M010'
;

---- 2.2. �ּ� �������� �߰� ����
SAVEPOINT do_update_addr;

--- 3. ȫ�浿�� ��ȭ��ȣ ������Ʈ
---- 3.1 DML : UPDATE �۾� ����
UPDATE member m
   SET m.phone = '9999'
 WHERE m.member_id = 'M010'
;

---- 3.2. ��ȭ��ȣ �������� �߰� ����
SAVEPOINT do_update_phone;

--- 4. ȫ�浿�� ���� ������Ʈ
---- 4.1 DML : UPDATE �۾�����
UPDATE member m
   SET m.gender = 'F'
 WHERE m.member_id = 'M010'
;

---- 4.2 ���� �������� �߰� ����
SAVEPOINT do_update_gender;
-- ������� �ϳ��� Ʈ�������� 4���� DML ���� ���� �ִ� ��Ȳ
-- ���� COMMIT ���� �ʾ����Ƿ� Ʈ������� �������ᰡ �ƴ� ��Ȳ
--------------------------------------------------------------------
-- ȫ�浿�� ������ ROLLBACK �ó�����
-- 1. �ּ� ���������� �´µ�, ��ȭ��ȣ, ������ �߸������ߴٰ� ����
--- ����� ������ �߸� ����
--- : �ǵ��ư� SAVEPOINT = do_update_addr
ROLLBACK do_update_addr;

-- 2. �ּ�, ��ȭ��ȣ ���������� �¾Ұ�, ���� ������ �߸��Ǿ���.
ROLLBACK do_update_phone;
-- SAVEPOINT ���� ������ �ִ�. do_update_addr �� do_update_phone ���� �ռ� ������ �����̱⶧���� ������� ROLLBACK_TO ���Ͼ��
-- �� �� ������ SAVEPOINT �� ��� ������.

-- 3. 2���� ROLLBACK TO �����Ŀ� �ǵ��� �� �ִ� ����
ROLLBACK TO do_insert; -- insert �� ����
ROLLBACK;               -- ���� ���� ����
---------------------------------------------------------------------------------------
-- ��Ÿ ��ü : SEQUENCE, INDEX, VIEW

-- SEQUENCE : �⺻ Ű(PK) ������ ���Ǵ� �Ϸù�ȣ ���� ��ü
-- 1. ���۹�ȣ : 1, �ִ� : 30, ����Ŭ�� ���� ������ ����

CREATE SEQUENCE seq_member_id
START WITH 1
MAXVALUE 30
NOCYCLE
;

-- �������� ��ü�̱⋚���� DDL �����Ѵ�.
-- �������� �����Ǹ� �ý��� īŻ�α׿� ����ȴ�.
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
��Ÿ �����͸� �����Ѵ� ���� ��ųʸ�
���Ἲ �������� : user_constraints
������ �������� : user_sequences
���̺� �������� : user_tables
�ε��� �������� : user_indexes
��ü�� �������� : user_objects

*/

-- 2. ������ ���
-- : ������ ��������SELECT �������� ��밡��
-- (1) NEXTVAL : �������� ���� ��ȣ�� ��
--                 CREATE �ǰ��� �ݵ�� ���� 1��
--                  NEXTVAL ȣ���� �Ǿ�� ������ ����
--                  ����: ������ �̸�.NEXTVAL
SELECT SEQ_MEMBER_ID.NEXTVAL
  FROM dual
;
-- (2) CURRBAL : ���������� ���� ������ ��ȣ�� Ȯ��
--               ������ ���� �� ���� 1���� NEXTVAL ȣ���� ������
--               ������ ��ȣ�� ���� �� ����.
--               ��, �������� ���� ��Ȱ��ȭ ����
--               ����: �������̸� CURRVAL

SELECT SEQ_MEMBER_ID.CURRVAL
  FROM dual
;

-- 3. ������  : ALTER 
ALTER SEQUENCE SEQ_MEMBER_ID
NOMAXVALUE
;

-- SEQ_MEMBER_ID �� INCREAMENT�� 10���� �����Ϸ���
ALTER SEQUENCE SEQ_MEMBER_ID
INCREMENT BY 10
;

-- 4. ������ ����
DROP SEQUENCE seq_member_id;

SELECT SEQ_MEMBER_ID.CURRVAL
  FROM dual
;

-- new_member ���̺� ������ �Է½� ������ Ȱ��
-- new_member �� id �÷��� ����� ������ �ű� ����
/*
������ �̸�: seq_new_member_id
���� ��ȣ : START WITH 1
���� ��: INCREMENT BY 1
�ִ� ��ȣ : NOMAXVALUE
����Ŭ���� : NOCYCLE
*/
CREATE SEQUENCE seq_new_member_id
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCYCLE
;

-- new_member �� member_id �� M001, M002 �����Ѵ� ���·� ����
SELECT 'M' || LPAD(SEQ_NEW_MEMBER_ID.NEXTVAL,3,0) as member_id
  FROM dual
;
INSERT INTO new_member (member_id, member_name)
VALUES ('M' || LPAD(SEQ_NEW_MEMBER_ID.NEXTVAL,3,0) , 'ȫ�浿')
;

INSERT INTO new_member (member_id, member_name)
VALUES ('M' || LPAD(SEQ_NEW_MEMBER_ID.NEXTVAL,3,0) , '���')
;
COMMIT;

----------------------------------------------------------------------
-- INDEX : �������� �˻�(��ȸ)�� ������ �˻� �ӵ� ������ ���� DBMS �� �����ϴ� ��ü

-- 1. user_indexes ���̺��� �̹� �����ϴ� INDEX ��ȸ
SELECT i.index_name
     , i.index_type
     , i.table_name
     , i.include_column
  FROM user_indexes i
;

-- 2. ���̺��� ��Ű (primary key) �÷��� ���ؼ��� dbms ��
--    �ڵ����� �ε��� �������� �� �� ����.
--    unique �� ���ؼ��� �ε����� �ڵ����� ������
--    �� �� �ε����� ������ �÷��� ���ؼ��� �ߺ� ���� �Ұ���
--    ��) memeber ���̺��� member_id �÷��� ���� �ε��� �����õ�

CREATE INDEX idx_member_id
ON member (member_id)
;

-- 3. ���� ���̺� new_member ���� pk �� ���⋚���� �ε����� ���� ����
-- (1) new_member�� member_id �÷��� �ε��� ����
CREATE INDEX idx_new_member_id
ON new_member (member_id)
;

DROP INDEX idx_new_member_id;

-- DESC ���ķ� ����
CREATE INDEX idx_new_member_id
ON new_member (member_id DESC) 
;

-- �ε��� ��� �÷��� ���� unique ���� Ȯ���ϴٸ�
-- unique index��  �������
CREATE INDEX idx_new_member_id
ON new_member (member_id DESC)
;

-- index �� select�� ���ɶ�
-- ���� �˻��� ���ؼ� ��������� SELELCT�� ����ϴ� ��� ����
-- HINT ���� select �� ����Ѵ�.

