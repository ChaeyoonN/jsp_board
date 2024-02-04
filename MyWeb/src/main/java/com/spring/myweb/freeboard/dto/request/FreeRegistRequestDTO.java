package com.spring.myweb.freeboard.dto.request;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter
@ToString @EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
public class FreeRegistRequestDTO {
	// 폼 이름과 동일
	private String writer;
	private String password;
	private String title;
	private String content;
	
//	private int refNo;
//	private int step;
//	private int refOrder;
//	private int answerNo;
//	private int parentNo;
}
