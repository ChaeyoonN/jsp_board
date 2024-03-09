package com.spring.myweb.freeboard.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.UUID;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.spring.myweb.freeboard.dto.page.Page;
import com.spring.myweb.freeboard.dto.request.FreeModifyRequestDTO;
import com.spring.myweb.freeboard.dto.request.FreeRegistRequestDTO;
import com.spring.myweb.freeboard.dto.response.FreeContentResponseDTO;
import com.spring.myweb.freeboard.dto.response.FreeListResponseDTO;
import com.spring.myweb.freeboard.entity.FreeBoard;
import com.spring.myweb.freeboard.mapper.IFreeBoardMapper;
import com.spring.myweb.snsboard.entity.SnsBoard;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class FreeBoardService implements IFreeBoardService {
	
	private final IFreeBoardMapper mapper;
	private final BCryptPasswordEncoder encoder;
//	private final FileDAO fileDAO;

	@Override
	public void regist(String writer,
	        String password,
	        String title,
	        String content,
	        List<MultipartFile> files) {
		
		int maxRefNo;
		if(mapper.getMaxRefNo() != null) {
			maxRefNo = 
					Objects.requireNonNull(mapper.getMaxRefNo());
		} else {
			maxRefNo = 0;
		}
		
		List<String> filePaths = new ArrayList<>();
		for (MultipartFile file : files) {
		    String fileName = StringUtils.cleanPath(file.getOriginalFilename());
		    Path dirPath = Paths.get("uploads");
		    Path filePath = dirPath.resolve(fileName);
		    try {
		        if (!Files.exists(dirPath)) {
		            Files.createDirectories(dirPath);
		        }
		        Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
		    } catch (IOException e) {
		        throw new RuntimeException("파일 저장에 실패하였습니다.", e);
		    }
		    filePaths.add(filePath.toString());
		}

		FreeBoard board = FreeBoard.builder()
							.title(title)
							.content(content)
							.writer(writer)
							.password(password)
							.refNo(maxRefNo+1)
					//		.filePaths(filePaths)
							.build();
		mapper.regist(board);
		int bno = board.getBno();

	    for (String filePath : filePaths) {
	        Map<String, Object> fileMap = new HashMap<>();
	        fileMap.put("bno", bno);
	        fileMap.put("filePath", filePath);
	        fileMap.put("fileName", Paths.get(filePath).getFileName().toString());
	        mapper.insertFile(fileMap);
	    }

	}
	
//	@Override
//	public void regist(FreeRegistRequestDTO dto) {
////		String securePw = encoder.encode(dto.getPassword());
////		dto.setPassword(securePw);
//		int maxRefNo;
//		if(mapper.getMaxRefNo() != null) {
//			maxRefNo = 
//					Objects.requireNonNull(mapper.getMaxRefNo());
//		} else {
//			maxRefNo = 0;
//		}
//		mapper.regist(FreeBoard.builder()
//						.title(dto.getTitle())
//						.content(dto.getContent())
//						.writer(dto.getWriter())
//						.password(dto.getPassword())
//						.refNo(maxRefNo+1)
//						.build());
//
//	}
	
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
	public String delete(int bno) throws Exception{
		// 자식이 존재해도 삭제 가능하게 한다
		FreeBoard board = mapper.getContent(bno);
		FreeContentResponseDTO dto = new FreeContentResponseDTO(board);

		int parentPK = dto.getParentNo();
		if(parentPK > 0) {
			// 부모가 있다면 
			FreeBoard parentBoard = mapper.getContent(parentPK);
			
			// 부모의 자식 수 감소시키기
			mapper.updateAnswerNo(parentPK, parentBoard.getAnswerNo()-1);			
		}
		// 해당 자식의 자식이 존재한다면 내용 비우고 title '삭제된 글입니다' update
		if(dto.getAnswerNo() > 0) {
			mapper.updateWhenAnsExist(bno);
		} else {
			// 해당 자식의 자식이 존재하지 않는다면 해당 자식 delete
			mapper.delete(bno);			
		}
		
		return "deleteSuccess";			
		
	}

	@Override
	public void registFile(List<MultipartFile> list) {
		System.out.println(list.toString());
		
		String uploadFolder = "C:/test/upload";
		
		LocalDateTime now = LocalDateTime.now();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyyMMdd");
		String fileLoca = now.format(dtf);
		
		File f = new File(uploadFolder +"/"+fileLoca);
		String p = uploadFolder +"/"+fileLoca;
        if(!f.exists()) {
			System.out.println("폴더가 존재하지 않음!");
			f.mkdirs();
		}

		for(MultipartFile m : list) {
			 try {
				if(m.getSize() == 0) break;
				
				UUID uuid = UUID.randomUUID();
				String fileName = uuid.toString();
				fileName = fileName.replace("-", "");	
				
				String fileExtension = 
						m.getOriginalFilename().substring(m.getOriginalFilename().lastIndexOf("."));
				
				File saveFile = new File(uploadFolder +"/"+fileLoca +"/"+fileName+fileExtension);
				
				m.transferTo(saveFile);
				
//				fileDAO.upload(fileName, m.getOriginalFilename(), p, 0);
				
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			} 
			 
		 }
		//DB에 각각의 값을 저장하세요. (INSERT)
        //uploadPath -> "C:/test/upload"
        //fileLoca -> 날짜로 된 폴더명
        //fileName -> 랜덤 파일명
        //fileRealName -> 실제 파일명
//        SnsBoard snsboard = SnsBoard.builder()
//        							.writer(dto.getWriter())
//        							.uploadPath(uploadPath)
//        							.fileLoca(fileLoca)
//        							.fileName(fileName+fileExtension)
//        							.fileRealName(fileRealName)
//        							.content(dto.getContent())
//        							.build();
//		mapper.insert(snsboard);
		
	}

}
