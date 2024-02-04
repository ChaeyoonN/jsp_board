-- ?? ?? ???
select * from freeboard
order by ref_no desc, ref_order asc;

/* Drop */
DROP TABLE freeboard CASCADE CONSTRAINTS;

DROP SEQUENCE freeboard_seq;
DROP SEQUENCE freeboard_ref_seq;

/* Create */
 CREATE TABLE freeboard(
    bno NUMBER PRIMARY KEY,
    title VARCHAR2(150) NOT NULL,
    writer VARCHAR2(100) NOT NULL, 
    content VARCHAR2(4000),
    password VARCHAR2(100),
    reg_date DATE DEFAULT sysdate,
    update_date DATE DEFAULT NULL,
    
    ref_no NUMBER NOT NULL, -- ???? 1?? ????
    step NUMBER DEFAULT 0, -- ???? ??
    ref_order NUMBER DEFAULT 0, -- ?? ? ??
    answer_no NUMBER DEFAULT 0, -- ??? ?? -- ???? ????(??????? 0)
    parent_no NUMBER DEFAULT 0 
    
);

CREATE SEQUENCE freeboard_seq
    START WITH 1
    INCREMENT BY 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;
    
CREATE SEQUENCE freeboard_ref_seq
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCYCLE
NOCACHE;

-- ?? 
DROP TABLE tbl_reply CASCADE CONSTRAINTS;

DROP SEQUENCE reply_seq;

 CREATE TABLE tbl_reply (
    rno NUMBER PRIMARY KEY,
    reply_text VARCHAR2(1000),
    reply_writer VARCHAR2(100) NOT NULL,
    reply_pw VARCHAR2(100) NOT NULL,
    reply_date DATE DEFAULT sysdate,
    bno NUMBER,
    update_date DATE DEFAULT NULL,
    
    CONSTRAINT reply_bno_fk FOREIGN KEY(bno) REFERENCES freeboard(bno)
    ON DELETE CASCADE -- ???? ?? ?? ?? ??? ? ??? ?? ?? ??.
);

CREATE SEQUENCE reply_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 10000
    NOCYCLE
    NOCACHE;
    
-- ?? ??? ??? ?? 
SELECT bno, COUNT(*) as comment_count
FROM tbl_reply
GROUP BY bno;

SELECT freeboard.*, NVL(tbl_reply.comment_count, 0) as comment_count
FROM freeboard
LEFT JOIN (
    SELECT bno, COUNT(*) as comment_count
    FROM tbl_reply
    GROUP BY bno
) tbl_reply ON freeboard.bno = tbl_reply.bno
ORDER BY ref_no DESC, ref_order ASC;

SELECT * FROM	
			(
			SELECT ROWNUM AS rn, tbl.*
				FROM	
				(
				SELECT freeboard.*, NVL(tbl_reply.comment_count, 0) as comment_count
                FROM freeboard
                
                LEFT JOIN (
                    SELECT bno, COUNT(*) as comment_count
                    FROM tbl_reply
                    GROUP BY bno
                ) tbl_reply ON freeboard.bno = tbl_reply.bno
                ORDER BY ref_no DESC, ref_order ASC
                
				) tbl
                WHERE title LIKE '%?%'
			)
;