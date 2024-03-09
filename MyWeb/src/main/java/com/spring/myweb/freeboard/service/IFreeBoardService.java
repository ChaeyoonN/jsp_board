package com.spring.myweb.freeboard.service;
// ctrl+shift+o : 패키지 일괄 import
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.myweb.freeboard.dto.page.Page;
import com.spring.myweb.freeboard.dto.request.FreeModifyRequestDTO;
import com.spring.myweb.freeboard.dto.request.FreeRegistRequestDTO;
import com.spring.myweb.freeboard.dto.response.FreeContentResponseDTO;
import com.spring.myweb.freeboard.dto.response.FreeListResponseDTO;

public interface IFreeBoardService {
	
	//글 등록
//	void regist(FreeRegistRequestDTO dto);
	void regist(String writer, String password, String title, String content, List<MultipartFile> files);
	void registFile(List<MultipartFile> list);
	
	//글 목록
	List<FreeListResponseDTO> getList(Page page);
	
	//총 게시물 개수
	int getTotal(Page page);
	
	//상세보기
	FreeContentResponseDTO getContent(int bno);
	
	//수정
	void update(FreeModifyRequestDTO dto);
	
	//삭제
	String delete(int bno) throws Exception;
	
	String getPassword(int bno);

	// 답글 등록
	void ansRegist(int bno, FreeRegistRequestDTO dto);
		
}
