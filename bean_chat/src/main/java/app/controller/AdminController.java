package app.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import app.dao.AdminDao;
import app.dao.UserDao;
import app.dto.PasswordEncoder;
import app.dto.UserDto;

@WebServlet("/AdminController")
public class AdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private String location;

	public AdminController(String location) {
		this.location = location;
	}
	// ㅇㅇㅇㅇ
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		PasswordEncoder passwordEncoder = new PasswordEncoder();

		// 관리자 페이지 이동
		if (location.equals("userList.do")) {
			AdminDao adao = new AdminDao();
			ArrayList<UserDto> alist = adao.userSelectAll();
			
			request.setAttribute("alist", alist);

			String path = "/admin/admin_user_list.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);

			// 회원가입 페이지 이동
		} else if (location.equals("userJoin.do")) {
			
		}
	}
}
