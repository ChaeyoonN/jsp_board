//package com.spring.myweb.freeboard.dto.file;
//
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.PreparedStatement;
//
//import org.springframework.beans.factory.annotation.Value;
//
//import lombok.AllArgsConstructor;
//import lombok.Builder;
//import lombok.EqualsAndHashCode;
//import lombok.Getter;
//import lombok.Setter;
//import lombok.ToString;
//
//@Getter @Setter @ToString
//@EqualsAndHashCode
//@AllArgsConstructor
//@Builder
//public class FileDAO {
//	
//	private Connection connection;
//	
//	@Value("${ora.url}")
//    private String url;
//	
//	@Value("${ora.username}")
//    private String username;
//
//    @Value("${ora.password}")
//    private String password;
//
//    // 생성자
//	public FileDAO() {
//		try {
//			Class.forName("oracle.jdbc.driver.OracleDriver");
//			connection = DriverManager.getConnection(url, username, password);
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}
//	
//	// 메서드
//	public int upload(String fileName, String fileRealName, String fileRoute, int bno) {
//		String SQL = "INSERT INTO TBL_FILE VALUES (?, ?, ?, sysdate, ?)";
//		try {
//			PreparedStatement psmt = connection.prepareStatement(SQL);
//			psmt.setString(1, fileName);
//			psmt.setString(2, fileRealName);
//			psmt.setString(3, fileRoute);
////			psmt.setString(4, "sysdate");
//			psmt.setInt(5, bno);
//			return psmt.executeUpdate(); // 성공 시 1 반환
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return -1; // 시류ㅐ 시 -1 반환
//	}
//	
//	
//	
//	
//	
//}
