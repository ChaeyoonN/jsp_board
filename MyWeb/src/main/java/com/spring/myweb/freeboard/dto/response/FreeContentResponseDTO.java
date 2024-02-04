package com.spring.myweb.freeboard.dto.response;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import com.spring.myweb.freeboard.entity.FreeBoard;

import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter @ToString @EqualsAndHashCode

public class FreeContentResponseDTO {
	
	//필드 
	private int bno;
	private String title;
	private String writer;
	private String password;
	private String content;
	private String date;
	
	private int refNo;
	private int step;
	private int refOrder;
	private int answerNo;
	private int parentNo;
	
	//생성자
	public FreeContentResponseDTO(FreeBoard board) {
		super();
		this.bno = board.getBno();
		this.title = board.getTitle();
		this.writer = board.getWriter();
		this.password = board.getPassword();
		this.content = board.getContent();
		
		this.date = board.getUpdateDate()==null? 
				FreeListResponseDTO.makePrettierDateString(board.getRegDate()) : 
				FreeListResponseDTO.makePrettierDateString(board.getUpdateDate())+"(수정됨)";
		this.refNo = board.getRefNo();
		this.step = board.getStep();
		this.refOrder = board.getRefOrder();
		this.answerNo = board.getAnswerNo();
		this.parentNo = board.getParentNo();
		
//		if(board.getUpdateDate() == null) {
//			this.date = FreeListResponseDTO.makePrettierDateString(board.getRegDate());
//		}else {
//			this.date = FreeListResponseDTO.makePrettierDateString(board.getUpdateDate())
//					+"(수정됨)";
//		}
		
	}

	
	
	
	
	
}
