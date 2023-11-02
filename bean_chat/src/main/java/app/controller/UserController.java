package app.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import app.dao.UserDao;
import app.dto.UserDto;

@WebServlet("/UserController")
public class UserController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	private String location;
	public UserController(String location) {
		this.location = location;		
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		if (location.equals("userList.do")) {
			UserDao udao = new UserDao();
			ArrayList<UserDto> list = udao.userSelectAll();
			
			request.setAttribute("list", list);
		
			String path ="/user/admin_user_manage.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
		}
		
		
	
	}
}
