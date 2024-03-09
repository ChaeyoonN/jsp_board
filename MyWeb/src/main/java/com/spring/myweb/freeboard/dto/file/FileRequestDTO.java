package com.spring.myweb.freeboard.dto.file;

import org.springframework.web.multipart.MultipartFile; 

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class FileRequestDTO {

	private String fileName; // uuid
	private String fileRealName;
	private String fileRoute;
	private int bno;
	
//	private MultipartFile file;
	
}
