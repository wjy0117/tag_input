<!-- 
79줄의 new File의 위치를 프로젝트 위치로 설정해야함. 
프로젝트 기본위치가 자꾸 바탕화면으로 잡혀서 직접 지정해줬음.
나의 프로젝트 위치는 : ../eclipse-workspace/TestTag2 에 있으며, 
/src/main/webapp/test_io.js를 통해 프로젝트 내에 원하는 위치에 파일 생성.
 -->

<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ 
page import="java.sql.*" import="java.util.List"
	import="java.util.ArrayList" import="java.util.Map"
	import="java.util.HashMap" import="java.io.File" import="java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<style>
div {
	width: auto;
	background-color: #999999;
	border: 1px solid red;
}

li {
	width: 500px;
	background-color: orange;
	border: 1px solid #005500;
}

.ui-helper-hidden-accessible {
	border: 0;
	clip: rect(0, 0, 0, 0);
	height: 1px;
	margin: -1px;
	overflow: hidden;
	padding: 0;
	position: absolute;
	width: 1px;
}
</style>
<link rel="stylesheet" href="style_TagInput.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!-- 
<script src="./data.js"></script>
-->
<script src="./test_io.js"></script>
</head>
<body>
	<%
	Connection conn = null;// db접속객체
	PreparedStatement pstmt = null; // SQL실행객체
	ResultSet res = null; // 결과셋처리객체

	ArrayList<String> li = new ArrayList<String>();
	String encoding = "UTF-8";
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

		String sql = "select tagTbl.tagName from tagTbl";

		pstmt = conn.prepareStatement(sql);
		res = pstmt.executeQuery(sql);

		//(태그 리스트)파일을 저장할 위치 설정
		File f = new File("../eclipse-workspace/TestTag2/src/main/webapp/test_io.js");
		
		//utf-8형식으로 f파일 생성
		//PrintWriter writer = new PrintWriter(new BufferedWriter(new FileWriter(f)));
		PrintWriter writer = new PrintWriter(new BufferedWriter(new OutputStreamWriter(new FileOutputStream(f), "utf-8")));

		//db에서 추출한 정보 리스트 문자열
		while (res.next()) {
			li.add(res.getString("tagName"));
		}
		
		//f파일 내용구성
		writer.println("List = [");
		for (int i = 0; i < li.size(); i++) {
			writer.print("'");
			writer.print(li.get(i));
			writer.println("', ");

		}
		writer.println("]");
		//파일종료
		writer.close();
		
		//파일 상태 처리
		File file = new File("d:\\example\\file.txt");
		
		if (file.createNewFile()) {
			System.out.println("File created");
		} else {
			System.out.println("File already exists");
		}
		
	} catch (Exception e) {
		System.out.println("Failed");
		e.printStackTrace();

	} finally {
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
	%>
	<!-- 태그내용 입력부 -->
	<div id="input_tag">
		<span>#</span> <input type="text" id="id_input_tagName"
			name="input_tagName" onblur="input_blur()"
			onkeypress="javascript:show_name(event);"> <a
			href="javascript:del_Click()">x</a>
	</div>
	<span id="warning_msg" style="color: red; display: none">태그는 5개로
		제한되어 있습니다.</span>
	<!-- submit 버튼 클릭시 서블릿으로 이동하여 해당 내용 전송 -->
	<button>전송</button>

	<script type="text/javascript">
		//(input)태그명 담을 배열 생성
		var tag_list = [];
		var tag_count = 0;

		//(output)태그검색 리스트
		//var tag_search = List;

		$(function() { //화면 로딩후 시작
			$("#id_input_tagName").autocomplete({ //오토 컴플릿트 시작
				source : List, // source는 data.js파일 내부의 List 배열
				focus : function(event, ui) { // 방향키로 자동완성단어 선택 가능하게 만들어줌	
					//console.log(ui.item);
					return false;
				},
				minLength : 1,// 최소 글자수
				delay : 10, //autocomplete 딜레이 시간(ms)
			//disabled: true, //자동완성 기능 끄기
			});
		});

		//중복확인, t: 중복아님, f:중복
		//입력 input의 value값(String)
		function dup_check(str) {
			var x = document.getElementById("id_input_tagName");
			console.log(tag_count);
			for (var i = 0; i < tag_count + 1; i++) {
				console.log(str + " " + tag_list[i] + " " + i);
				if (str === tag_list[i]) {
					return 0;
				}
			}
			return 1;
		}

		//키 눌렀을때 실행
		function show_name(e) {
			//입력한 키 정보 받아오기
			var code = e.code;
			//경고문 안보이게
			document.getElementById("warning_msg").style.disabled = false;
			//input정보
			var x = document.getElementById("id_input_tagName");

			//입력이 없거나 태그가 5개 이하라면(0~4) 입력받음
			//code: 입력키, 입력이 ""이 아닐때, tag개수가 5개 이하일 때, 중복체크 1: 중복아님, 0:중복
			if (code == 'Enter' && x.value !== "" && tag_count < 5
					&& dup_check(x.value)) {
				//입력한 내용을 배열에 추가
				tag_list.push(x.value);
				//태그목록 생성
				var input_TagList = document.createElement('ul');
				var input_Tag = document.createElement('li');
				input_Tag.innerText = "#" + x.value;
				input_Tag.setAttribute("id", "list_div" + tag_count);

				/*
				삭제버튼 생성 <a></a>
				var input_vTag = document.createElement('a');
				input_vTag.innerText = "x";
				//input_vTag.setAttribute("id", "list_del"+tag_count);
				//input_vTag.setAttribute("class", "del_btn");
				 */
				//console.log("list_div"+tag_count);
				//var vtext = document.createTextNode = x.value; //원하는 요소에 문자열
				//view.appendChild(vtext);//요소의 자식요소
				//위치 지정
				//특정위치 앞에 삽입(상속관계), div > ul > li
				var pDiv = document.getElementById("input_tag");
				pDiv.insertBefore(input_TagList, null);
				input_TagList.insertBefore(input_Tag, null);

				//배열 내용출력
				for (var i = 0; i < tag_list.length; i++) {
					console.log(i + ": " + tag_list[i]);
				}
				//input창 초기화
				document.getElementById("id_input_tagName").value = null;
				//카운트
				tag_count++;
				/*}else{
					console.log(b);
				}*/
			} else if (tag_count > 4) { //태그 검색 개수가 5개 이상이라면 비활성화
				document.getElementById("id_input_tagName").disabled = true;
				document.getElementById("warning_msg").style.display = "block";
			} else { //빈 검색어라면 log에 none을 표시하고 추가되는 거 없음.
				console.log("none");
			}
		}
		//blur시에 리스트 추가
		function input_blur() {
			//경고문 안보이게
			document.getElementById("warning_msg").style.disabled = false;
			//input정보
			var x = document.getElementById("id_input_tagName");

			//입력이 없거나 태그가 5개 이하라면(0~4) 입력받음
			//code: 입력키, 입력이 ""이 아닐때, tag개수가 5개 이하일 때, 중복체크 1: 중복아님, 0:중복
			if (x.value !== "" && tag_count < 5 && dup_check(x.value)) {
				//입력한 내용을 배열에 추가
				tag_list.push(x.value);
				//태그목록 생성
				var input_TagList = document.createElement('ul');
				var input_Tag = document.createElement('li');
				input_Tag.innerText = "#" + x.value;
				input_Tag.setAttribute("id", "list_div" + tag_count);

				/*
				삭제버튼 생성 <a></a>
				var input_vTag = document.createElement('a');
				input_vTag.innerText = "x";
				//input_vTag.setAttribute("id", "list_del"+tag_count);
				//input_vTag.setAttribute("class", "del_btn");
				 */
				//console.log("list_div"+tag_count);
				//var vtext = document.createTextNode = x.value; //원하는 요소에 문자열
				//view.appendChild(vtext);//요소의 자식요소
				//위치 지정
				//특정위치 앞에 삽입(상속관계), div > ul > li
				var pDiv = document.getElementById("input_tag");
				pDiv.insertBefore(input_TagList, null);
				input_TagList.insertBefore(input_Tag, null);

				//배열 내용출력
				for (var i = 0; i < tag_list.length; i++) {
					console.log(i + ": " + tag_list[i]);
				}
				//input창 초기화
				document.getElementById("id_input_tagName").value = null;
				//카운트
				tag_count++;
				/*}else{
					console.log(b);
				}*/
			} else if (tag_count > 4) { //태그 검색 개수가 5개 이상이라면 비활성화
				document.getElementById("id_input_tagName").disabled = true;
				document.getElementById("warning_msg").style.display = "block";
			} else { //빈 검색어라면 log에 none을 표시하고 추가되는 거 없음.
				console.log("none");
			}
		}

		//delete만들었다.
		//지금은 input 옆에 x, 클릭시 뒤에서부터 리스트 삭제.
		function del_Click() {
			var index = (tag_count - 1).toString();
			//현재 배열 위치와 tag입력 개수 출력
			console.log("del: " + index + "\t" + tag_count);
			//tag_count != 0 체크하려했는데 실수지만 잘 
			if (tag_list != 0) {
				tag_list.pop();
				document.getElementById("list_div" + index).remove();
				tag_count--;
				document.getElementById("warning_msg").style.display = "none";
				for (var i = 0; i < tag_list.length; i++) {

					console.log("(Remain)" + i + ": " + tag_list[i]);
				}
				document.getElementById("id_input_tagName").disabled = false;
			} else {
				console.log("Value already missing in tag list");
			}
		}
	</script>
</body>
</html>
