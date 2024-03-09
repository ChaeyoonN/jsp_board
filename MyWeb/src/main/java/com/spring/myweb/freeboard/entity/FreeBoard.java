package com.spring.myweb.freeboard.entity;
/*
  CREATE TABLE freeboard(
    bno NUMBER PRIMARY KEY,
    title VARCHAR2(150) NOT NULL,
    writer VARCHAR2(100) NOT NULL, 
    content VARCHAR2(4000),
    password VARCHAR2(100),
    reg_date DATE DEFAULT sysdate,
    update_date DATE DEFAULT NULL,
    
    ref_no NUMBER NOT NULL, -- 그룹번호 1부터 시퀀스
    step NUMBER DEFAULT 0, -- 들여쓰기 깊이
    ref_order NUMBER DEFAULT 0, -- 그룹 내 순번
    answer_no NUMBER DEFAULT 0, -- 자식글 개수
    parent_no NUMBER DEFAULT 0 -- 부모글의 고유키값(최상위글이라면 0)
);

CREATE SEQUENCE freeboard_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 1000
    NOCYCLE
    NOCACHE;
    
CREATE SEQUENCE freeboard_ref_seq
START WITH 1
INCREMENT BY 1
MAXVALUE 1000
NOCYCLE
NOCACHE;
 */

import java.time.LocalDateTime;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter
@ToString @EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class FreeBoard {
	private int bno;
	private String title;
	private String writer;
	private String content;
	private String password;
	private LocalDateTime regDate;
	private LocalDateTime updateDate;
	
	private int refNo;
	private int step;
	private int refOrder;
	private int answerNo;
	private int parentNo;

	private int commentCount;
	
	private List<String> filePaths;
	
}
