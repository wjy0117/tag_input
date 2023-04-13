package Tag;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
//import java.sql.Statement;
import java.util.ArrayList;

public class DB_Connect{

	public Connection dbConn() {
		// db접속객체
		Connection conn = null;
		try {
			// mysql jdbc driver 로딩
			Class.forName("com.mysql.jdbc.Driver");

			// db연결 문자열 but 이방법은 보안에 취약하다.
			String url = "jdbc:mysql://localhost/mmn?characterEncoding=UTF-8&serverTimezone=UTC";
			String id = "root"; // mysql 접속아이디
			String pwd = "1234"; // mysql 접속 비번

			// db 접속
			conn = DriverManager.getConnection(url, id, pwd);
			System.out.println("db접속 성공");
		} catch (Exception e) {
			// db관련작업은 반드시 익셉션 처리
			System.out.println("db접속 실패");
			e.printStackTrace();
		}
		return conn;
	}

	/*
	//입력한 태그명을 가진 가게코드 리스트 리턴하는 메소드
	public ArrayList<Integer> StoreSearch() {
		// TODO Auto-generated method stub
		// storeCode를 가지는 리스트
		//ArrayList<Integer> arr_sc = new ArrayList<Integer>();
		Connection conn = null;// db접속객체
		PreparedStatement pstmt = null; // SQL실행객체
		ResultSet res = null; // 결과셋처리객체
		
		try {
			conn = dbConn();
			// 가게, 태그, 태그-가게 테이블에서 입력한 태그명과 같은 태그의 가게코드를 가져와서 출력
			//.storeCode from tag_storeTbl  " +  + ")
			//list의 0번째 요소 검색
			
			//문자열s 대신에 ...?
			//"tagTbl.tagName = " +"(검색할 태그명)" 로 &&해서 결과 가게 리스트 출력.
			String sql = "select tag_storeTbl.storeCode from tag_storeTbl where tag_storeTbl.tagID = (Select tagTbl.tagID from tagTbl where "+
					"tagTbl.tagName = " +"(검색할 태그명)"+
					")";
			System.out.println(sql);
			// 데이터베이스로 SQL 문을 보내기 위한 SQLServerStatement 개체생성
			pstmt = conn.prepareStatement(sql);

			// Select 문에서만 실행하며 데이터베이스에서 데이터를 가져와서 결과 집합을 반환
			res = pstmt.executeQuery(sql);
			
			// res의 길이만큼의 배열 생성 또는 arraylist 생성.
			while (res.next()) {
				SaveDTO sd = new SaveDTO();
				//리스트에 res.int("storeCode")추가
				//리스트로 전달
				//sd.setScode();
				//Integer.parseInt(td.toString())
				//arr_sc.add(sd.getScode());
			}
			System.out.println(arr_sc);
		} catch (Exception e) {
			System.out.println("Query_Failed");
			e.printStackTrace();

		} finally {
			// 리소스 정리작업
			try {
				if (pstmt != null) {
					pstmt.close();
				}

			} catch (Exception e2) {
				e2.printStackTrace();
			}

			try {
				if (conn != null) {
					conn.close();
				}

			} catch (Exception e2) {
				e2.printStackTrace();
			}

		}
		System.out.println();
		return arr_sc;
	}
	*/
	
	/*
	//모든 tag명 가져오는 메소드
	//차후 수정(미완)
	//입력한 태그명이 db에 있는 태그명인지 비교
	public ArrayList<String> TagSearch() {
		// TODO Auto-generated method stub
		// tagName을 가지는 리스트
		ArrayList<String> arr_td = new ArrayList<String>();
		Connection conn = null;// db접속객체
		PreparedStatement pstmt = null; // SQL실행객체
		ResultSet res = null; // 결과셋처리객체
		
		try {
			conn = dbConn();
			String sql2 = "Select tagTbl.tagName from tagTbl";
			System.out.println(sql2);
			pstmt = conn.prepareStatement(sql2);
			res = pstmt.executeQuery(sql2);
			
			// res의 길이만큼의 배열 생성 또는 arraylist 생성.
			while (res.next()) {
				SaveDTO sd = new SaveDTO();
				sd.setTname(res.getString("tagName"));
				//Integer.parseInt(td.toString())
				arr_td.add(sd.getTname());
			}
			System.out.println(arr_td);
		} catch (Exception e) {
			System.out.println("Query_Failed");
			e.printStackTrace();

		} finally {
			// 리소스 정리작업
			try {
				if (pstmt != null) {
					pstmt.close();
				}

			} catch (Exception e2) {
				e2.printStackTrace();
			}

			try {
				if (conn != null) {
					conn.close();
				}

			} catch (Exception e2) {
				e2.printStackTrace();
			}

		}
		System.out.println();
		return arr_td;
	}
	*/
}
