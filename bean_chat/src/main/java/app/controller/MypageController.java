package app.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;

import app.dao.BoardDao;
import app.dao.FriendDao;
import app.dao.UserDao;
import app.dto.BoardDto;
import app.dto.FileRename;
import app.dto.FriendDto;
import app.dto.FriendRequestDto;
import app.dto.PasswordEncoder;
import app.dto.UserDto;

@WebServlet("/MypageController")
public class MypageController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	private String location;
	public MypageController(String location) {
		this.location = location;		
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//마이페이지 메인
		if (location.equals("myMain.do")) {
			
			String path ="/mypage/my_main.jsp";
			 RequestDispatcher rd = request.getRequestDispatcher(path);
			 rd.forward(request, response);
		
			 
		//내 정보보기
		}else if(location.equals("myProfile.do")){
			HttpSession session = request.getSession();
			
			
			int uidx = (Integer)session.getAttribute("uidx");
			
	
			UserDao udao = new UserDao();
			UserDto udto = udao.UserSelectOne(uidx);
			
			request.setAttribute("udto", udto);
		
			
						
			String path ="/mypage/my_profile.jsp";
			 RequestDispatcher rd = request.getRequestDispatcher(path); 
			 rd.forward(request, response);
			
			 
		//내정보 수정 링크	 
		}else if(location.equals("myModify.do")){
			HttpSession session = request.getSession();

			
			int uidx = (Integer)session.getAttribute("uidx");
			System.out.println("uidx>?"+uidx);

			
			UserDao udao = new UserDao();
			UserDto udto = udao.UserSelectOne(uidx);
			System.out.println("udto?"+udto);
			
			request.setAttribute("udto", udto);
			
			
			String path ="/mypage/my_profile_modify.jsp";
			 RequestDispatcher rd = request.getRequestDispatcher(path);
			 rd.forward(request, response);
			
			
		
		//내정보 수정	 
		}else if(location.equals("myModifyAction.do")){
			
			HttpSession session = request.getSession();
			int uidx = (Integer)session.getAttribute("uidx");
			System.out.println("uidx>?"+uidx);
			System.out.println("getuidx"+uidx);
			String userNickname =request.getParameter("userNickname");
			String userName = request.getParameter("userName");
			String userYear = request.getParameter("userYear");
			String userMonth = request.getParameter("userMonth");
			String userDay = request.getParameter("userDay");
			String userPhone =request.getParameter("userPhone");

			String userBirth  = userYear+userMonth+userDay;
			
			UserDto udto = new UserDto();

			udto.setUserNickname(userNickname);
			udto.setUserName(userName);
			udto.setUserBirth(userBirth);
			udto.setUserPhone(userPhone);
			udto.setUidx(uidx);


			UserDao udao = new UserDao();
			int value = udao.userModify(udto);
			
			PrintWriter out = response.getWriter();
			
			if(value == 1) {
				out.println("<script>alert('정상적으로 변경 되었습니다.');"
						+	"document.location.href='"+request.getContextPath()+"/mypage/myProfile.do'</script>");
			}else{
				out.println("<script>history.back();</script>");	
			}
			
			
		
		//프로필 사진 업로드
		}else if(location.equals("myImage.do")){
			
			HttpSession session = request.getSession();
			int maxSize = 1024 * 1024 * 20;
			String folderPath = "/resources/images/userImage/";
			String filePath = session.getServletContext().getRealPath(folderPath);
			
			String encoding = "UTF-8";
			MultipartRequest mpReq = new MultipartRequest(request, filePath, maxSize,encoding, new FileRename());

			System.out.println("루트가 어딘디" + filePath);
			
			
			
			int uidx = (Integer)session.getAttribute("uidx");
			UserDao udao = new UserDao();
			UserDto udto = udao.UserSelectOne(uidx);
			
			request.setAttribute("udto", udto);
			
			
			String userImage = folderPath + mpReq.getFilesystemName("userImage");
			System.out.println(userImage+"이미지파일 최종저장");
			int value = udao.userImageUpdate(uidx, userImage);
			System.out.println("value는?"+value);
			System.out.println("uidx는?"+uidx);
			System.out.println("udao.userImageUpdate?"+udao.userImageUpdate(uidx, userImage));
			
			
			
			if(value > 0){	//성공
				session.setAttribute("message", "프로필 이미지가 변경되었습니다.");
				udto.setUserImage(userImage);
				System.out.println("userImage?" + udto.getUserImage());
				//sysout은 set을 못찍는듯
				String path = request.getContextPath()+"/mypage/myProfile.do";
				response.sendRedirect(path);
				
			}else {
				session.setAttribute("message", "프로필 이미지 변경 실패 ㅠ.ㅠ");
				String path = request.getContextPath()+"/mypage/myProfile.do";
				response.sendRedirect(path);
			}
			
			
			
			
			
			
		//비밀번호 변경	
		}else if(location.equals("userUpdatePwd.do")) {
			
			//세션에 uidx에서 비밀번호 비교를 위한 id값 가져오기
			HttpSession session = request.getSession();
			int uidx = (Integer)session.getAttribute("uidx");
			UserDao udao = new UserDao();
			UserDto udto = udao.UserSelectOne(uidx);
			
			request.setAttribute("udto", udto);
			
			
			PasswordEncoder passwordEncoder = new PasswordEncoder();
			int maxSize = 1024 * 1024 * 20;
			String folderPath = "/resources/images/userImage/";
			String filePath = session.getServletContext().getRealPath(folderPath);
			
			String encoding = "UTF-8";
			MultipartRequest mpReq = new MultipartRequest(request, filePath, maxSize,encoding, new FileRename());
			//input(userPwd) 해싱하기
			String userPwd = mpReq.getParameter("userPwd"); // 사용자가 입력한 비밀번호
			System.out.println(userPwd + "기존에 갖고있던 pwd값");
			String userPwdHash = null;
		    try {
		    	userPwdHash = passwordEncoder.EncBySha256(userPwd);
		    	System.out.println(userPwdHash+ "해쉬한 userPwdHash값.");
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		    System.out.println("userPwd"+userPwd);
		    System.out.println("userPwdHash"+userPwdHash);
		    
		    
			
		    PrintWriter out = response.getWriter();

		   
		    try {
		      // UserDao를 통해 데이터베이스에서 해당 아이디에 대한 해시된 비밀번호 가져오기
		        String userHashPwd = udao.userHashPassword(udto.getUserId());
		      //udto.getUserId=>세션에 담겨있는 아이디
		    System.out.println("인풋해쉬"+userPwdHash);
		    System.out.println("원래유저비밀번호해쉬값"+userHashPwd);

		        // 저장된 해시된 비밀번호와 사용자 입력의 해시된 비밀번호를 비교
		        if (userHashPwd.equals(userPwdHash)) {
		            // 비밀번호 일치: 비밀번호 변경할 준비됨
		        	String newPwd = mpReq.getParameter("newPwd");
		        	System.out.println("변경할비번"+newPwd);
					String newPwdHash = null;
						try {
							newPwdHash = passwordEncoder.EncBySha256(newPwd);
							udto.setUserPwd(newPwdHash);

							
						} catch (Exception e) {
							e.printStackTrace();
						}
						
				udto.setUserPwd(newPwdHash);
				System.out.println("변경할비번해수ㅣ"+newPwdHash);
				int exec = udao.userPwdUpdate(uidx, newPwdHash);  
				if(exec==1) {
					out.println("<script>alert('정상적으로 비밀번호 변경 되었습니다..');"
							+	"document.location.href='"+request.getContextPath()+"/mypage/myModify.do'</script>");
						}else{
							out.println("<script>history.back();</script>");	
						}
		        } else {
		    		out.println("<script>alert('현재 비밀번호가 일치하지 않습니다.');"
							+	"document.location.href='"+request.getContextPath()+"/mypage/myModify.do'</script>");
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		
		    
		    
		    
		    
		//회원탈퇴
			}else if(location.equals("userBye.do")){
				
				
				HttpSession session = request.getSession();
				int uidx = (Integer)session.getAttribute("uidx");
				UserDao udao = new UserDao();
				UserDto udto = udao.UserSelectOne(uidx);
				
				request.setAttribute("udto", udto);
			
				PasswordEncoder passwordEncoder = new PasswordEncoder();
				
				int maxSize = 1024 * 1024 * 20;
				String folderPath = "/resources/images/userImage/";
				String filePath = session.getServletContext().getRealPath(folderPath);
				String encoding = "UTF-8";
				
				MultipartRequest mpReq = new MultipartRequest(request, filePath, maxSize,encoding, new FileRename());
				//input(userPwd) 해싱하기
				String userPwd = mpReq.getParameter("delUserPwd"); // 사용자가 입력한 비밀번호
				String userPwdHash = null;
			    try {
			    	userPwdHash = passwordEncoder.EncBySha256(userPwd);
			    	System.out.println(userPwdHash+ "해쉬한 userPwdHash값.");
				} catch (Exception e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			
			    
			    PrintWriter out = response.getWriter();
	
			    try {
			    	
				      // UserDao를 통해 데이터베이스에서 해당 아이디에 대한 해시된 비밀번호 가져오기
				        String userHashPwd = udao.userHashPassword(udto.getUserId());
				      //udto.getUserId=>세션에 담겨있는 아이디
				        
				        if (userHashPwd.equals(userPwdHash)) {
				        	
				            // 비밀번호 일치: 
				        	int exec=udao.userDelete(uidx);
				        	
						if(exec==1) {
							session.removeAttribute("uidx");
							session.removeAttribute("userId");
							session.invalidate();
							out.println("<script>alert('정상적으로 회원 탈퇴 되었습니다..');"
									+	"document.location.href='"+request.getContextPath() + "/index.jsp'</script>");
								}else{
									out.println("<script>history.back();</script>");
								}
				        } else {
				    		out.println("<script>alert('현재 비밀번호가 일치하지 않습니다.');"
									+	"document.location.href='"+request.getContextPath()+"/mypage/myModify.do'</script>");
				        }
				    } catch (Exception e) {
				        e.printStackTrace();
				    }
					
			
			}else if(location.equals("myModify.do")){
			String path ="/mypage/my_profile_modify.jsp";
			 RequestDispatcher rd = request.getRequestDispatcher(path);
			 rd.forward(request, response);
			
			
		}
		
	}


}
