package ServLet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import HR.HRead;
import net.sf.json.JSONArray;

/**
 * Servlet implementation class TServlet
 */
@WebServlet("/TServlet")
public class TServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		HRead head = new HRead();
		try {
			List<String> lists = head.TRead();
			PrintWriter out = response.getWriter(); // 向客户端发送字符数据
			response.setContentType("text/text"); // 设置请求以及响应的内容类型以及编码方式
			response.setCharacterEncoding("UTF-8");
			JSONArray json = JSONArray.fromObject(lists); // 将newsList对象转换为json对象
			String str = json.toString(); // 将json对象转换为字符串
			out.write(str); // 将str字符传输到前台
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
