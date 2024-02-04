package com.spring.myweb.freeboard.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.myweb.freeboard.dto.page.Page;
import com.spring.myweb.freeboard.entity.FreeBoard;

public interface IFreeBoardMapper {

	//글 등록
	void regist(FreeBoard freeBoard);
	
	//글 목록
	List<FreeBoard> getList(Page page);

	//총 게시물 개수 구하기
	int getTotal(Page page);
	
	//상세보기
	FreeBoard getContent(int bno);
	
	//수정
	void update(FreeBoard freeBoard);
	
	//삭제
	void delete(int bno);
	
	//상세보기
	String getPassword(int bno);
	
	// 같은 그룹번호인 게시글 개수 구하기
	int getEqualRefNo(int refNo);
	
	// 같은 그룹번호인 게시글 리스트 
	List<FreeBoard> getAllEqualRefNo(int refNo);
	
	// 최대 그룹번호 구하기
	Integer getMaxRefNo();
	
	// refOrder 수정
	void updateRefOrder(@Param("bno") int bno, @Param("refOrder") int refOrder);
	
	void updatePastRefOrder(FreeBoard freeboard);
	// 자식수 수정
	void updateAnswerNo(@Param("bno") int bno, @Param("answerNo") int answerNo);
	
	// 답변글 등록
	void registAns(FreeBoard freeBoard);
	
}
