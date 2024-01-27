package com.spring.myweb.freeboard.entity;
/*
 CREATE TABLE freeboard(
    bno NUMBER PRIMARY KEY,
    title VARCHAR2(100) NOT NULL,
    writer VARCHAR2(100) NOT NULL, 
    content VARCHAR2(4000),
    password VARCHAR2(50)
    reg_date DATE DEFAULT sysdate,
    update_date DATE DEFAULT NULL
);

CREATE SEQUENCE freeboard_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 1000
    NOCYCLE
    NOCACHE
 */

import java.time.LocalDateTime;

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
}
