package com.spring.myweb.freeboard.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import org.springframework.stereotype.Service;

import com.spring.myweb.freeboard.dto.page.Page;
import com.spring.myweb.freeboard.dto.request.FreeModifyRequestDTO;
import com.spring.myweb.freeboard.dto.request.FreeRegistRequestDTO;
import com.spring.myweb.freeboard.dto.response.FreeContentResponseDTO;
import com.spring.myweb.freeboard.dto.response.FreeListResponseDTO;
import com.spring.myweb.freeboard.entity.FreeBoard;
import com.spring.myweb.freeboard.mapper.IFreeBoardMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class FreeBoardService implements IFreeBoardService {
	
	private final IFreeBoardMapper mapper;
	private final BCryptPasswordEncoder encoder;

	@Override
	public void regist(FreeRegistRequestDTO dto) {
//		String securePw = encoder.encode(dto.getPassword());
//		dto.setPassword(securePw);
		int maxRefNo;
		if(mapper.getMaxRefNo() != null) {
			maxRefNo = 
					Objects.requireNonNull(mapper.getMaxRefNo());
		} else {
			maxRefNo = 0;
		}
		mapper.regist(FreeBoard.builder()
						.title(dto.getTitle())
						.content(dto.getContent())
						.writer(dto.getWriter())
						.password(dto.getPassword())
						.refNo(maxRefNo+1)
						.build());

	}
	
	//
	@Override
	public void ansRegist(int bno, FreeRegistRequestDTO dto) {
//		String securePw = encoder.encode(dto.getPassword());
//		dto.setPassword(securePw);
		FreeBoard board = mapper.getContent(bno);
		FreeContentResponseDTO parentDTO = new FreeContentResponseDTO(board);
		int refNo = parentDTO.getRefNo(); // 부모의 그룹번호
		int refOrder = parentDTO.getRefOrder(); // 부모의 그룹내순번
		int step = parentDTO.getStep(); // 부모의 들여쓰기
		int answerNo = parentDTO.getAnswerNo(); // 부모의 자식 개수
		int parentNo = parentDTO.getParentNo(); // 부모의 부모pk
	
		
		// 원글의 refOrder보다 큰 refOrder 증가시키기
		// 그룹번호 같은 보드 리스트
		List<FreeBoard> equalRefNoList = mapper.getAllEqualRefNo(refNo);
		
		Comparator<FreeBoard> comparatorByStep = (x1, x2) -> Integer.compare(x1.getStep(), x2.getStep());
		//동일 그룹 중 최대 step값 구하기
		int maxStep = equalRefNoList.stream().max(comparatorByStep).get().getStep();
		
		// 동일 그룹 steps 모음
		List<Integer> steps = equalRefNoList.stream().map(b->b.getStep()).collect(Collectors.toList());
		// steps가 같은 
		List<FreeBoard> sameStepList = equalRefNoList.stream().filter(b->b.getStep() == step + 1).collect(Collectors.toList());
		
		// refOrder가 큰
		List<FreeBoard> higherRefOrderList = sameStepList.stream().filter(b->
			b.getRefOrder() > refOrder
		).collect(Collectors.toList());
		System.out.println(steps); 
		  
		
		log.info("원글 step: {}, 동일 그룹 최대 step: {}", step, maxStep);
		int newRefOrder = 0;
//		if(maxStep == 0 ) { // 레벨1 답글이거나 동일레벨 답글만 존재하는 경우
//			mapper.registAns(FreeBoard.builder()
//					.refNo(refNo)
//					.step(step+1)
//					.refOrder(refOrder+1) //  
//					.parentNo(parentDTO.getBno())
//					.title(dto.getTitle())
//					.content(dto.getContent())
//					.writer(dto.getWriter())
//					.password(dto.getPassword())
//					.build());
//		} else { // 동일 레벨 답글이 아닌 경우
			// 같은 그룹 중 원글의 refOrder보다 큰 refOrder 가진 보드 list
			List<FreeBoard> biggerRefOrderList = 
					equalRefNoList.stream().filter(b->b.getRefOrder() > refOrder).collect(Collectors.toList());
			log.info("원글의 refOrder보다 큰 refOrder 가진 보드 list: {}",biggerRefOrderList);
			if (biggerRefOrderList.size() > 0) {
				
				for(FreeBoard f : biggerRefOrderList) {
					newRefOrder = f.getRefOrder();
					System.out.println("\n" +" 그룹순번 확인: "+ newRefOrder + "\n");
					
				}
				//  refOrder 기존보다 1씩 증가시켜 수정
				biggerRefOrderList.forEach(b -> mapper.updateRefOrder(b.getBno(), b.getRefOrder()+1));
			}
			mapper.registAns(FreeBoard.builder()
					.refNo(refNo)
					.step(step+1)
					.refOrder(refOrder+1) // refOrder+1
					.parentNo(parentDTO.getBno())
					.title(dto.getTitle())
					.content(dto.getContent())
					.writer(dto.getWriter())
					.password(dto.getPassword())
					.build());
			
//		}
			// 부모 업뎃(자식수)
			mapper.updateAnswerNo(parentDTO.getBno(), answerNo+1);
	}
			
		// 같은 그룹 중 step이 0인 보드 list
//		List<FreeBoard> summitBoardList = 
//				equalRefNoList.stream().filter(b->b.getStep()==0).collect(Collectors.toList());
//		int summitRefNo = summitBoardList.get(0).getRefNo();
		
//		mapper.registAns(FreeBoard.builder()
//				.refNo(refNo)
//				.step(step+1)
//				.refOrder(refOrder+1) // 
//				.parentNo(parentDTO.getBno())
//				.title(dto.getTitle())
//				.content(dto.getContent())
//				.writer(dto.getWriter())
//				.password(dto.getPassword())
//				.build());
		
		
	

	@Override
	public List<FreeListResponseDTO> getList(Page page) {
		List<FreeListResponseDTO> dtoList = new ArrayList<>();
		List<FreeBoard> list = mapper.getList(page);
		
		for(FreeBoard board : list) {
			dtoList.add(new FreeListResponseDTO(board));
		}
		
		return dtoList;
	}
	
	@Override
	public int getTotal(Page page) {
		return mapper.getTotal(page);
	}

	@Override
	public FreeContentResponseDTO getContent(int bno) {
		FreeBoard board = mapper.getContent(bno);
		
		FreeContentResponseDTO dto = new FreeContentResponseDTO(board);
		
		return dto;
		
	}
	
	@Override
	public String getPassword(int bno) {
		return mapper.getPassword(bno);
	}

	@Override
	public void update(FreeModifyRequestDTO dto) {
		
//		mapper.update(mapper.getContent(dto.getBno()));
		mapper.update(
						FreeBoard.builder()
						.bno(dto.getBno())
						.writer(dto.getWriter())
						.title(dto.getTitle())
						.content(dto.getContent())
						.build()
						);

	}

	@Override
	public String delete(int bno) {
		// 자식이 존재하면 삭제 못하게 하기
		FreeBoard board = mapper.getContent(bno);
		FreeContentResponseDTO dto = new FreeContentResponseDTO(board);
		if(dto.getAnswerNo() > 0) {
			return "deleteFailCauseOfChild";
		}
		int parentPK = dto.getParentNo();
		FreeBoard parentBoard = mapper.getContent(parentPK);
		
		// 부모의 자식 수 감소시키기
		mapper.updateAnswerNo(parentPK, parentBoard.getAnswerNo()-1);
		// 해당 자식 삭제하기
		mapper.delete(bno);
		return "deleteSuccess";

	}

}
