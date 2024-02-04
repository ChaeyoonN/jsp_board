package com.spring.myweb.freeboard.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.myweb.freeboard.dto.page.Page;
import com.spring.myweb.freeboard.dto.page.PageCreator;
import com.spring.myweb.freeboard.dto.request.FreeModifyRequestDTO;
import com.spring.myweb.freeboard.dto.request.FreeRegistRequestDTO;
import com.spring.myweb.freeboard.dto.response.FreeContentResponseDTO;
import com.spring.myweb.freeboard.service.IFreeBoardService;

import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/freeboard")
@RequiredArgsConstructor
@Slf4j
public class FreeBoardController {
	
	private final IFreeBoardService service;
	private final BCryptPasswordEncoder encoder;
	
	//목록 확인
	@GetMapping("/freeList")
	public void freeList(Page page, Model model) {
		System.out.println("/freeboard/freeList: GET!");
		log.info("Page :{}",page);
		
		PageCreator creator;
		int totalCount = service.getTotal(page);
		model.addAttribute("msg", "showList");
		
		if(page.getCondition() != null && page.getKeyword() != null) { // 검색한 경우
			page.setSearchFlag(true);
			if(totalCount == 0) { // 검색 결과 없음
				model.addAttribute("msg", "searchFail");
			}
		}
		
		if(totalCount == 0) { // 게시글 없는경우
			if(!page.isSearchFlag()) { // 원래 게시글 없음
				model.addAttribute("msg", "zeroBoard");
			} else { 
				model.addAttribute("msg", "searchFail");
			}
			page.setKeyword(null);
			page.setCondition(null);
			creator = new PageCreator(page, service.getTotal(page));
			
		}else {
			creator = new PageCreator(page, totalCount);
			
		} // if문 끝
		
		model.addAttribute("boardList", service.getList(page)); //void이므로 freeList.jsp로 전달
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("pc", creator);
//		model.addAttribute("msg", "showList");
	}
	
	//글쓰기 페이지를 열어주는 메서드
	@GetMapping("/freeRegist")
	public void regist() {
		
	}
	
	//글 등록 처리
	@PostMapping("/freeRegist")
	public String regist(FreeRegistRequestDTO dto) {
		service.regist(dto);
		return "redirect:/freeboard/freeList";
	}
	
	//글 상세 보기
	@GetMapping("/content") //"3번 글 상세 보기 요청을 넣으면 "컨트롤러는 DB에서 가지고 온 글 객체를 
	//"model에 담아 freeDetail.jsp로 이동시킬 것이다."
	public String getContent(@RequestParam("bno") int bno,
			Model model,
			@ModelAttribute("p") Page page) {
		System.out.println("/freeboard/content: GET!");
		FreeContentResponseDTO dto = service.getContent(bno);
		model.addAttribute("board", dto);
		
		return "freeboard/freeDetail"; // 폴더명/파일명
	}
	
	// 수정 위한 비번 검증
	@PostMapping("/modPage")
	@ResponseBody
	public String checkPw(@ModelAttribute("board") FreeModifyRequestDTO dto,
	                      @RequestParam("inputPw") String inputPw) {
	    System.out.println("/freeboard/modPage: POST!");
	    log.info("FreeModifyRequestDTO :{}",dto);
	    log.info("inputPw :{}",inputPw);

	    // DB에서 현재 비밀번호를 가져옵니다.
	    String currentPassword = service.getPassword(dto.getBno());

	    // 입력받은 비밀번호와 DB에 저장된 비밀번호를 비교합니다.
	    if (currentPassword == null || !currentPassword.equals(inputPw)) {
	        // 비밀번호가 일치하지 않으면 에러 메시지를 반환합니다.
	        return "pwWrong";
	    }
	    return "pwCorrect";
	}
	
	// 삭제 위한 비번 검증
		@PostMapping("/delete")
		@ResponseBody
		public String lookPw(@ModelAttribute("board") FreeModifyRequestDTO dto,
		                      @RequestParam("inputPw") String inputPw) {
		    System.out.println("/freeboard/modPage: POST!");
		    log.info("FreeModifyRequestDTO :{}",dto);
		    log.info("inputPw :{}",inputPw);

		    // DB에서 현재 비밀번호를 가져옵니다.
		    String currentPassword = service.getPassword(dto.getBno());

		    // 입력받은 비밀번호와 DB에 저장된 비밀번호를 비교합니다.
		    if (currentPassword == null || !currentPassword.equals(inputPw)) {
		        // 비밀번호가 일치하지 않으면 에러 메시지를 반환합니다.
		        return "pwWrong";
		    }
		    return "pwCorrect";
		}
	
	// 글 수정 페이지 이동 요청
	@GetMapping("/freeModify")
	public String freeModify(@RequestParam("bno") int bno,
			Model model) {
	    // 'bno'를 이용하여 필요한 데이터를 가져옵니다.
	    // 예를 들어, DB에서 해당 번호의 게시글 정보를 가져온다고 가정하면 다음과 같이 작성할 수 있습니다.
		FreeContentResponseDTO dto = service.getContent(bno);
	     model.addAttribute("board", dto);

	    // 'freeModify.jsp' 페이지를 렌더링합니다.
	    return "freeboard/freeModify";
	}
	
	//글 수정
	@PostMapping("/modify")
	public String modify(FreeModifyRequestDTO dto) {
		System.out.println("/freeboard/modify: POST!");
		service.update(dto);
		
		return "redirect:/freeboard/content?bno=" + dto.getBno();//파라미터변수명(bno)은 리퀘스트파람변수명과 같아야
	}
	
	//글 삭제
	@PostMapping("/realDelete") 
//	@ResponseBody
	public String delete(int bno,
	                     @RequestParam("inputPw") String inputPw,
	                     RedirectAttributes redirectAttributes, 
	                     Model model) {
	    System.out.println("/freeboard/realDelete: POST!");
	    
	    String msg = service.delete(bno);
	    model.addAttribute("mes", msg);
	    if(msg.equals("deleteFailCauseOfChild")) {
	    	return "freeboard/freeDetail";
	    } else {
	    	return "redirect:/freeboard/freeList";
	    }
	    
	}
	
	//답변글쓰기 페이지를 열어주는 메서드
	@GetMapping("/freeAnsRegist")
	public String goToAnsRegist(@RequestParam("bno") int bno,
			Model model) {
	    // 'bno'를 이용하여 필요한 데이터를 가져옵니다.
	    // 예를 들어, DB에서 해당 번호의 게시글 정보를 가져온다고 가정하면 다음과 같이 작성할 수 있습니다.
		FreeContentResponseDTO dto = service.getContent(bno);
	     model.addAttribute("board", dto);

	    // 'freeAnsRegist.jsp' 페이지를 렌더링합니다.   
	     return "freeboard/freeAnsRegist";
	}
	
	// 답변 글 등록 요청
	@PostMapping("/freeAnsRegist")
	public String ansRegist(@RequestParam("bno") int bno, FreeRegistRequestDTO dto) {
		System.out.println("/freeboard/freeAnsRegist: POST!");
		service.ansRegist(bno, dto);
		return "redirect:/freeboard/freeList";
	}
	
	
	
}
