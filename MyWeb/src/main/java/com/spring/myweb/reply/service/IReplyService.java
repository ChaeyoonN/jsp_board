package com.spring.myweb.reply.service;

import java.util.List;

import com.spring.myweb.reply.dto.ReplyListResponseDTO;
import com.spring.myweb.reply.dto.ReplyRequestDTO;
import com.spring.myweb.reply.dto.ReplyUpdateRequestDTO;
import com.spring.myweb.reply.entity.Reply;

public interface IReplyService {

	void replyRegist(ReplyRequestDTO dto);//댓글 등록
	List<ReplyListResponseDTO> getList(int bno, int pageNum);//댓글 목록 요청
	int getTotal(int bno);//댓글 개수 (페이징, PageCreator는 사용하지 않습니다.)
	
	String pwCheck(int rno);//비밀번호 확인
	String update(ReplyUpdateRequestDTO dto);//댓글 수정
	String delete(int rno, String replyPw);//댓글 삭제
	
	
}
