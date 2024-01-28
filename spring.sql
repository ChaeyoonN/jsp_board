-- ?? ?? ???
select * from freeboard;

/* Drop */
DROP TABLE freeboard CASCADE CONSTRAINTS;

DROP SEQUENCE freeboard_seq;

/* Create */
 CREATE TABLE freeboard(
    bno NUMBER PRIMARY KEY,
    title VARCHAR2(150) NOT NULL,
    writer VARCHAR2(100) NOT NULL, 
    content VARCHAR2(4000),
    password VARCHAR2(100),
    reg_date DATE DEFAULT sysdate,
    update_date DATE DEFAULT NULL
);

CREATE SEQUENCE freeboard_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 1000
    NOCYCLE
    NOCACHE;