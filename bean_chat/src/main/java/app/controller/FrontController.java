package app.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/FrontController")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		//�뿬湲곗뿉�꽌 �뼱�뒓 而⑦듃濡ㅻ윭濡� 蹂대궪吏� 遺꾧린�븳�떎
		String url = request.getRequestURI();	
		int length = request.getContextPath().length();
		String command = url.substring(length);	
		//jfyujfuyruru
		
		
		
		//   /member/memberList.do   
		//   /board/boardList.do
		
		String[] ary = command.split("/");
		String str = ary[1];
		String location = ary[2];
		//�삤�젏萸�
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
