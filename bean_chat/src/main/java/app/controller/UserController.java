package app.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
		
		
		//관리자 페이지 이동
		if (location.equals("userList.do")) {
			UserDao udao = new UserDao();
			ArrayList<UserDto> list = udao.userSelectAll();
			
			request.setAttribute("list", list);
		
			String path ="/user/admin_user_manage.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
			
		//회원가입 페이지 이동	
		}else if(location.equals("userJoin.do")) {
			
			String path ="/user/user_join.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
		
			
		//로그인 수행
		}else if(location.equals("userJoinAction.do")) {			
			
			//데이터를 넘겨주면 요청 객체는 그 값을 받아서 넘어온 매개변수에
			//담긴 값을 꺼내서 새로운 변수에 담는다
			String userId = request.getParameter("userId");
			String userPwd = request.getParameter("userPwd");
			String userName= request.getParameter("userName");
			String userYear = request.getParameter("userYear");
			String userMonth = request.getParameter("userMonth");
			String userDay = request.getParameter("userDay");
			String userGender = request.getParameter("userGender");
			String userPhone = request.getParameter("userPhone");
			String userNickname = request.getParameter("userNickname");
		
			
			
			
			
			String userBirth  = userYear+userMonth+userDay;
			
			UserDao udao = new UserDao();
			int exec = udao.userInsert(userId, userPwd, userName, userBirth, userGender, userPhone, userNickname);
			
			PrintWriter out = response.getWriter();
			
			if(exec==1) {
				out.println("<script>alert('정상적으로 회원가입 되었습니다.');"
						+	"document.location.href='"+request.getContextPath()+"/user/userLogin.do'</script>");
					}else{
						out.println("<script>history.back();</script>");	
					}
			
			
			//로그인 페이지 이동
			}else if(location.equals("userLogin.do")) {
					
				String path ="/user/user_login.jsp";
				RequestDispatcher rd = request.getRequestDispatcher(path);
				rd.forward(request, response);
				
				
			//로그인 수행	
			}else if(location.equals("userLoginAction.do")) {
					
				String userId = request.getParameter("userId");
				String userPwd = request.getParameter("userPwd");
				
							
				UserDao udao = new UserDao();
				int uidx = 0; 
				uidx = udao.userLoginCheck(userId,userPwd);
				HttpSession session = request.getSession();
				PrintWriter out = response.getWriter();
				//Action처리하는 용도는 send방식으로 보낸다
				if (uidx !=0){  //일치하면
					//세션에 회원아이디를 담는다
					
					session.setAttribute("userId", userId);
					session.setAttribute("uidx", uidx);
					session.setMaxInactiveInterval(3600);
					
					
					
					response.sendRedirect(request.getContextPath() + "/index.jsp");
				}else{
					
					out.println("<script>alert('아이디,비밀번호가 일치하지 않습니다.');"
							+ "history.back();</script>");
				}
			}else if(location.equals("userLogout.do")) {
				
				HttpSession session = request.getSession();
				session.removeAttribute("userId");
				session.removeAttribute("uidx");
				session.invalidate();
				
				response.sendRedirect(request.getContextPath() + "/index.jsp");
			}
				
				
				
		}
			
			
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
		
		
		
	
}

