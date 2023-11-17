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
import app.dto.PasswordEncoder;
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
		
			
		//회원가입 수행
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
			String userImage = request.getParameter("userImage");
			
			String userBirth  = userYear+userMonth+userDay;
			PasswordEncoder passwordencoder= new PasswordEncoder();
			String userPwdHash = null;
			try {
				userPwdHash = passwordencoder.EncBySha256(userPwd);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			UserDto udto = new UserDto();
			udto.setUserId(userId);
			udto.setUserPwd(userPwdHash);
			udto.setUserName(userName);
			udto.setUserNickname(userNickname);
			udto.setUserBirth(userBirth);
			udto.setUserPhone(userPhone);
			udto.setUserDate(userDay);
			udto.setUserGender(userGender);
			udto.setUserImage(userImage);
			
			UserDao udao = new UserDao();
			int exec = udao.userInsert(udto);
			
			
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
				String userPwd = request.getParameter("userPwd"); // 사용자가 입력한 비밀번호
				
							
				UserDao udao = new UserDao();
				int uidx = udao.userLoginCheck(userId); // 사용자의 아이디로부터 uidx 가져오기
				
				HttpSession session = request.getSession();
				PrintWriter out = response.getWriter();
				
				
				//Action처리하는 용도는 send방식으로 보낸다
				try {
					// 사용자가 입력한 비밀번호를 해시하여 저장
					UserDto udto = new UserDto();
					PasswordEncoder passwordencoder= new PasswordEncoder();
				    udto.setUserPwd(passwordencoder.EncBySha256(userPwd));
				    //해싱을 왜 한번더 ?
				    
				    System.out.println("입력받은 비밀번호?"+userPwd);
				    
				    
				    // UserDao를 통해 데이터베이스에서 해당 아이디에 대한 해시된 비밀번호 가져오기
			        String userHashPwd = udao.userHashPassword(userId);
				    System.out.println("원래 저장된 비밀번호?"+userHashPwd);
				    // 저장된 해시된 비밀번호와 사용자 입력의 해시된 비밀번호를 비교
				    if (userHashPwd != null) {
				    	// 비밀번호 일치: 로그인 성공
			            session.setAttribute("userId", userId);
			            session.setAttribute("uidx", uidx);
			            session.setMaxInactiveInterval(3600);
			            
			            response.sendRedirect(request.getContextPath() + "/index.jsp");
				    } else {
				    	  // 비밀번호 불일치: 로그인 실패
			            out.println("<script>alert('아이디 또는 비밀번호가 일치하지 않습니다.'); history.back();</script>");
			        }
				} catch (Exception e) {
				    e.printStackTrace();
				}
				
				
			}else if(location.equals("userLogout.do")) {
				
				HttpSession session = request.getSession();
				session.removeAttribute("userId");
				session.removeAttribute("uidx");
				session.invalidate();
				
				response.sendRedirect(request.getContextPath() + "/index.jsp");
			
				
				
			//아이디 비밀번호찾기		
			}else if(location.equals("userFindIdpwd.do")) {
				
			String path ="/user/user_find_idpwd.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
			
			
		
		}
				
				
				
		}
			
			
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
		
		
		
	
}

