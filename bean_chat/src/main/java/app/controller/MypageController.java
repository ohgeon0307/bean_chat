package app.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import app.dao.UserDao;
import app.dto.FileRename;
import app.dto.UserDto;

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
			HttpSession session = request.getSession();
			
			
			int uidx = (Integer)session.getAttribute("uidx");
			
	
			UserDao udao = new UserDao();
			UserDto udto = udao.UserSelectOne(uidx);
			
			request.setAttribute("udto", udto);
		
			
						
			String path ="/mypage/my_profile.jsp";
			 RequestDispatcher rd = request.getRequestDispatcher(path); 
			 rd.forward(request, response);
			
		}else if(location.equals("myModify.do")){
			HttpSession session = request.getSession();
			System.out.println(session.getAttribute("uidx"));
			
			int uidx = (Integer)session.getAttribute("uidx");
			System.out.println("uidx"+uidx);
			
			UserDao udao = new UserDao();
			UserDto udto = udao.UserSelectOne(uidx);
			
			request.setAttribute("udto", udto);
			
			
			String path ="/mypage/my_profile_modify.jsp";
			 RequestDispatcher rd = request.getRequestDispatcher(path);
			 rd.forward(request, response);
			
			
		}else if(location.equals("myModifyAction.do")){
			
			HttpSession session = request.getSession();
			int uidx = (Integer)session.getAttribute("uidx");
			System.out.println("getuidx"+uidx);
			String userNickname = request.getParameter("userNickname");
			String userName = request.getParameter("userName");
			String userYear = request.getParameter("userYear");
			String userMonth = request.getParameter("userMonth");
			String userDay = request.getParameter("userDay");
			String userPhone = request.getParameter("userPhone");

			
			String userBirth  = userYear+userMonth+userDay;
			
			System.out.println("username"+userName);
			
			UserDto udto = new UserDto();
			System.out.println("udto.uidx"+udto.getUidx());
			System.out.println("udto"+udto.getUserNickname());
			udto.setUserNickname(userNickname);
			udto.setUserName(userName);
			udto.setUserBirth(userBirth);
			udto.setUserPhone(userPhone);
			udto.setUidx(uidx);
			System.out.println("setuidx"+uidx);
			System.out.println("setuserName"+userName);
			System.out.println("setuserBirth"+userBirth);
			System.out.println("setuserPhone"+userPhone);
			System.out.println("setuserNickname"+userNickname);

			UserDao udao = new UserDao();
			int value = udao.userModify(udto);
			
			System.out.println(udto);
			System.out.println(udto.getUserNickname());
			System.out.println(value);
			System.out.println("path"+request.getContextPath());
			
			PrintWriter out = response.getWriter();
			
			if(value == 1) {
				out.println("<script>alert('정상적으로 변경 되었습니다.');"
						+	"document.location.href='"+request.getContextPath()+"/mypage/myProfile.do'</script>");
				System.out.println("path"+request.getContextPath());
			}else{
				out.println("<script>history.back();</script>");	
			}
			
			
			
		}else if(location.equals("myImage.do")){
			
			int maxSize = 1024 * 1024 * 20;
			HttpSession session = request.getSession();
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
			
			
			
			if(value>0){	//성공
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
			
			
			
			
			
			
			
		}else if(location.equals("myFriend.do")){
			String path ="/mypage/my_friend_list.jsp";
			 RequestDispatcher rd = request.getRequestDispatcher(path);
			 rd.forward(request, response);
			
			
		}else if(location.equals("myList.do")){
			String path ="/mypage/my_list.jsp";
			 RequestDispatcher rd = request.getRequestDispatcher(path);
			 rd.forward(request, response);
			
			
		}else if(location.equals("myModify.do")){
			String path ="/mypage/my_profile_modify.jsp";
			 RequestDispatcher rd = request.getRequestDispatcher(path);
			 rd.forward(request, response);
			
			
		}
		
	}


}
