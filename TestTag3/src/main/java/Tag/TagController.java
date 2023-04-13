package Tag;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SearchTagForm
 */
@WebServlet("/TagController")
public class TagController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TagController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//request.setCharacterEncoding("UTF-8");
		//String context = request.getContextPath();
		//DB_Connect dc = new DB_Connect();
		//getParameter로 list가져오고
		
		//가져온 데이터로 bto 값 초기화.
		
		//db_conn에 있는 함수 호출, 입력받은 정보 전달.
		
		//페이지 이동(출력 페이지)
		//response.sendRedirect(context+"OutTag.jsp");
		//main페이지 유지(사용안함)
		//request.getRequestDispatcher("tag_main.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
