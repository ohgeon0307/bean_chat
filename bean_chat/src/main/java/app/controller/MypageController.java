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
		
		if (location.equals("myMain.do")) {
			
			String path ="/mypage/my_main.jsp";
			 RequestDispatcher rd = request.getRequestDispatcher(path);
			 rd.forward(request, response);
			 
		}else if(location.equals("myProfile.do")){
			
			String path ="/mypage/my_profile.jsp";
			 RequestDispatcher rd = request.getRequestDispatcher(path);
			 rd.forward(request, response);
			
		}else if(location.equals("myProfileModify.do")){
			String path ="/mypage/my_profile_modify.jsp";
			 RequestDispatcher rd = request.getRequestDispatcher(path);
			 rd.forward(request, response);
			
			
		}else if(location.equals("myFriend.do")){
			String path ="/mypage/my_friend_list.jsp";
			 RequestDispatcher rd = request.getRequestDispatcher(path);
			 rd.forward(request, response);
			
			
		}else if(location.equals("myList.do")){
			String path ="/mypage/my_list.jsp";
			 RequestDispatcher rd = request.getRequestDispatcher(path);
			 rd.forward(request, response);
			
			
		}
		
	}
}
