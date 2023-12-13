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
		

		String url = request.getRequestURI();	
		int length = request.getContextPath().length();
		String command = url.substring(length);	
		
		String[] ary = command.split("/");
		String str = ary[1];
		String location = ary[2];
		
		//UserController 분기
		if (str.equals("user")) {
			UserController uc = new UserController(location);
			uc.doGet(request, response);
			
		//MypageController 분기
		}else if(str.equals("mypage")) {
			MypageController mc = new MypageController(location);
			mc.doGet(request, response);
		
		//BoardController 분기
		}else if(str.equals("board")) {
			BoardController bc = new BoardController(location);
			bc.doGet(request, response);
		
		//ChatController 분기	
		}else if(str.equals("chat")) {
			ChatController cc = new ChatController(location);
			cc.doGet(request, response);
			
		} else if(str.equals("notice")) {
			NoticeController nc = new NoticeController(location);
			nc.doGet(request, response);
	
		
		//MypageController 분기
		}else if(str.equals("friend")) {
			FriendController fc = new FriendController(location);
			fc.doGet(request, response);
				
		}
		/*
			 * else if(str.equals("chatsubmit")) { ChatSubmitController csc = new
			 * ChatSubmitController(location); csc.doGet(request, response);
			 * 
			 * }
			 */
		
	}

	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
