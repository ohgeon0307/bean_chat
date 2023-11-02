package app.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/MypageController")
public class MypageController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	private String location;
	public MypageController(String location) {
		this.location = location;		
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if (location.equals("mymain.do")) {
			
			String path ="/mypage/my_main.jsp";
			 RequestDispatcher rd = request.getRequestDispatcher(path);
			 rd.forward(request, response);
		}
		
	}
}
