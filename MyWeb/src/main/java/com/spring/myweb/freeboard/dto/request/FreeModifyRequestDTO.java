package com.spring.myweb.freeboard.dto.request;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter
@ToString @EqualsAndHashCode
@NoArgsConstructor @AllArgsConstructor
public class FreeModifyRequestDTO {
	
	private int bno;
	
	private String writer;
	private String password;
	
	private String title;
	private String content;
	
//	private LocalDateTime date;
	
}
