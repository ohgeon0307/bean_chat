package app.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.Random;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import app.dao.UserDao;
import app.dto.MailAuth;
import app.dto.PasswordEncoder;
import app.dto.UserDto;

@WebServlet("/UserController")
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private String location;

	public UserController(String location) {
		this.location = location;
	}
	// ㅇㅇㅇㅇ
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		PasswordEncoder passwordEncoder = new PasswordEncoder();

		if (location.equals("userJoin.do")) {

			String path = "/user/user_join.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);

			// 회원가입 수행
		} else if (location.equals("userJoinAction.do")) {

			// 데이터를 넘겨주면 요청 객체는 그 값을 받아서 넘어온 매개변수에
			// 담긴 값을 꺼내서 새로운 변수에 담는다
			String userId = request.getParameter("userId");
			String userPwd = request.getParameter("userPwd");
			// 현재값은 123123
			String userName = request.getParameter("userName");
			String userYear = request.getParameter("userYear");
			String userMonth = request.getParameter("userMonth");
			String userDay = request.getParameter("userDay");
			String userGender = request.getParameter("userGender");
			String userPhone = request.getParameter("userPhone");
			String userNickname = request.getParameter("userNickname");
			String userImage = request.getParameter("userImage");

			String userBirth = userYear + userMonth + userDay;
			String userPwdHash = null;
			try {
				userPwdHash = passwordEncoder.EncBySha256(userPwd);
				// 96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e 최초해싱
				UserDto udto = new UserDto();
				udto.setUserPwd(userPwdHash);

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			UserDto udto = new UserDto();
			udto.setUserId(userId);
			udto.setUserPwd(userPwdHash);
			System.out.println(userPwdHash + "<- 지금 값은 뭐야?");
			udto.setUserName(userName);
			udto.setUserNickname(userNickname);
			udto.setUserBirth(userBirth);
			udto.setUserPhone(userPhone);
			udto.setUserDate(userDay);
			udto.setUserGender(userGender);
			udto.setUserImage(userImage);

			UserDao udao = new UserDao();
			int exec = udao.userInsert(udto);
			System.out.println(udto.getUserPwd());

			PrintWriter out = response.getWriter();

			if (exec == 1) {
				out.println("<script>alert('정상적으로 회원가입 되었습니다.');" + "document.location.href='"
						+ request.getContextPath() + "/user/userLogin.do'</script>");
			} else {
				out.println("<script>history.back();</script>");
			}

			// 로그인 페이지 이동
		} else if (location.equals("userLogin.do")) {

			String path = "/user/user_login.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);

			// 로그인 수행
		} else if (location.equals("userLoginAction.do")) {

			String userId = request.getParameter("userId");
			// 사용자가 입력한 userId
			String userPwd = request.getParameter("userPwd"); // 사용자가 입력한 비밀번호
			try {
				userPwd = passwordEncoder.EncBySha256(userPwd);
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}

			UserDao udao = new UserDao();
			int uidx = udao.userLoginCheck(userId); // 사용자의 아이디로부터 uidx 가져오기
			

			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();

			// Action처리하는 용도는 send방식으로 보낸다
			try {
				// UserDao를 통해 데이터베이스에서 해당 아이디에 대한 해시된 비밀번호 가져오기
				String userHashPwd = udao.userHashPassword(userId);
				if(userHashPwd == null ) {
					out.println("<script>alert('아이디 또는 이름이 일치하지 않습니다.'); history.back();</script>");
				}
				// 저장된 해시된 비밀번호와 사용자 입력의 해시된 비밀번호를 비교
				else if (userHashPwd.equals(userPwd)) {
					// 비밀번호 일치: 로그인 성공
					
					String adminYn = udao.getUserAdminYn(userId);
					//관리자 여부 확인
					if(adminYn.equals("Y")) {
						//세션에 admin담아줌
						session.setAttribute("admin", "admin");
						session.setAttribute("userId", userId);
						session.setAttribute("uidx", uidx);
						session.setMaxInactiveInterval(3600);

						response.sendRedirect(request.getContextPath() + "/index.jsp");
					}else{
					session.setAttribute("userId", userId);
					session.setAttribute("uidx", uidx);
					session.setMaxInactiveInterval(3600);

					response.sendRedirect(request.getContextPath() + "/index.jsp");
					} 
				}else {
					// 비밀번호 불일치: 로그인 실패
					out.println("<script>alert('아이디 또는 비밀번호가 일치하지 않습니다.'); history.back();</script>");
				}
			} catch (Exception e) {
				out.println("<script>alert('아이디 또는 비밀번호가 일치하지 않습니다.'); history.back();</script>");
				e.printStackTrace();
			}
		} else if (location.equals("userLogout.do")) {

			HttpSession session = request.getSession();
			session.removeAttribute("userId");
			session.removeAttribute("uidx");
			session.invalidate();

			response.sendRedirect(request.getContextPath() + "/index.jsp");

			// 아이디 비밀번호찾기
		} else if (location.equals("userFindIdPwd.do")) {

			String path = "/user/user_find_id_pwd.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);

		}  else if (location.equals("userFindIdAction.do")) {

			String userName = request.getParameter("userName");
			String userPhone = request.getParameter("userPhone");
			UserDao udao = new UserDao();

			String userIdFind = udao.userFindId(userName, userPhone);
			System.out.println(userIdFind);
			// 문자열로 응답 생성=> 전송.
			// JSON 응답을 위한 Map 구성
		
			 Map<String, String> responseData = new HashMap<>();
			 responseData.put("userIdFind", userIdFind);
			 
			  // Gson 객체 생성 
			 Gson gson = new Gson();
			 
			  // JSON 형식으로 응답 구성 
			 String jsonResponse = gson.toJson(responseData);
			 
			 response.setContentType("application/json");
			 PrintWriter out =response.getWriter(); 
			 out.print(jsonResponse);
			 out.flush();
			 
			

		} else if (location.equals("userFindPwd.do")) {

			String path = "/user/user_find_pwd.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);

		} else if (location.equals("userFindPwdAction.do")) {
			PrintWriter out = response.getWriter();
			String userName = request.getParameter("userName");
			System.out.println(userName);
			String userId = request.getParameter("userId");
			System.out.println(userId);
			
			
			if(userName==null || userName=="" ) {
				out.println("<script>alert('아이디 또는 이름이 일치하지 않습니다.'); history.back();</script>");
			}else if(userId==null || userId=="" ) {
				out.println("<script>alert('아이디 또는 이름이 일치하지 않습니다.'); history.back();</script>");
			}else {
			
			// name / id 넘어오지 않거나 ""일경우 처리
			UserDao udao = new UserDao();

			UserDto udto = udao.userFindPwd(userName, userId);
			if( udto == null ) {
				out.println("<script>alert('아이디 또는 이름이 일치하지 않습니다.'); history.back();</script>");
			}
		
			if (udto != null && udto.getUidx() != 0) {
				Random ran = new Random();
				StringBuffer buffer = new StringBuffer();
				for (int i = 0; i < 6; i++) {
					if (ran.nextBoolean()) {
						buffer.append(((int) (ran.nextInt(10))));
					} else {
						buffer.append((char) ((int) (Math.random() * 26) + 65));
					}
				}

				String userEPwd = buffer.toString();

				Properties prop = System.getProperties();

				// 로그인시 TLS를 사용할 것인지 설정
				prop.put("mail.smtp.starttls.enable", "true");

				// 이메일 발송을 처리해줄 SMTP서버
				prop.put("mail.smtp.host", "smtp.gmail.com");

				// SMTP 서버의 인증을 사용한다는 의미
				prop.put("mail.smtp.auth", "true");

				// TLS의 포트번호는 587이며 SSL의 포트번호는 465이다.
				prop.put("mail.smtp.port", "587");

				Authenticator auth = new MailAuth();

				Session session = Session.getDefaultInstance(prop, auth);

				MimeMessage msg = new MimeMessage(session);
				try {
					// 보내는 날짜 지정
					msg.setSentDate(new Date());

					// 발송자를 지정한다. 발송자의 메일, 발송자명
					msg.setFrom(new InternetAddress("beanchatting@gmail.com", "bean_chat"));

					// 수신자의 메일을 생성한다.
					InternetAddress to = new InternetAddress(userId);

					// Message 클래스의 setRecipient() 메소드를 사용하여 수신자를 설정한다. setRecipient() 메소드로 수신자, 참조,
					// 숨은 참조 설정이 가능하다.
					// Message.RecipientType.TO : 받는 사람
					// Message.RecipientType.CC : 참조
					// Message.RecipientType.BCC : 숨은 참조
					msg.setRecipient(Message.RecipientType.TO, to);

					// 메일의 제목 지정
					msg.setSubject("BeanChat 비밀번호 설정 메일입니다.", "UTF-8");

					// Transport는 메일을 최종적으로 보내는 클래스로 메일을 보내는 부분이다.
					msg.setText(userName + "님의 임시비밀번호는 [" + buffer + "] 입니다.", "UTF-8");

					Transport.send(msg);

				} catch (AddressException ae) {
					System.out.println("AddressException : " + ae.getMessage());
				} catch (MessagingException me) {
					System.out.println("MessagingException : " + me.getMessage());
				} catch (UnsupportedEncodingException e) {
					System.out.println("UnsupportedEncodingException : " + e.getMessage());
				}

				String userPwdHash = null;
				try {
					userPwdHash = passwordEncoder.EncBySha256(userEPwd);
					System.out.println(userPwdHash + "해쉬한 userPwdHash값.");
				} catch (Exception e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}

				int uidx = udto.getUidx();
				System.out.println("바꿀 비밀번호uidx???" + uidx);
				int exec = udao.userPwdUpdate(uidx, userPwdHash);
				System.out.println("결과값?" + exec);
				if (exec == 1) {
					out.println("<script>alert('임시비밀번호가 메일로 전송되었습니다.');" + "document.location.href='"
							+ request.getContextPath() + "/user/userLogin.do'</script>");
				} else {
					out.println("<script>alert('비밀번호 변경에 실패하였습니다.'); history.back();</script>");
				}
			} 
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
