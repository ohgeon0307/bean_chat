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
					
			
			}else if(location.equals("myFriend.do")){
	         
			 		String path ="/mypage/my_friend_list.jsp"; 
			 		RequestDispatcher rd =request.getRequestDispatcher(path);
			 		rd.forward(request, response);
	           
           
			}else if(location.equals("searchFriend.do")){
				//인풋값 : friendId
				String friendId = request.getParameter("friendId");
              
				FriendDao fdao = new FriendDao();
              
				//아이디로 상대 uidx 찾아서 fuidx변수에 넣어줌
				int fUidx= fdao.friendFindId(friendId);
  
				//상대uidx로 selectone메소드 이용해서 정보 가져와서 udto생성자에 담아줌.
				UserDao udao = new UserDao();
				UserDto udto = udao.UserSelectOne(fUidx);
			  
				response.setContentType("application/json;charset=UTF-8");
				PrintWriter out = response.getWriter();
			
				//gson==제이슨라이브러리
				//유저정보 문자열 가져온거 json으로 파싱해줌. ajax에 뿌려주기위해서
				Gson gson = new Gson();
			   
				//삼항연산자 사용
				//조건식 ? 표현식1 : 표현식 2
				//if 조건식 참-> 표1, if 조건식 거짓->표2 반환
				//{}>>>udto==null 일 때 처리, {}쓰는이유 : json 빈 객체 나타내는 표기법
				String json = (udto != null) ? gson.toJson(udto) : "{}";
			
				//이것도 PrintWriter객체사용 (out) json문자열 출력
				out.print(json);
				//출력버퍼를 비움????
				//==데이터 출력 전 임시저장 모든 데이터 클라이언트로 전송
				//실시간으로 데이터를 보내야 하는 경우, 중요한 메시지를 보낼 때 flush() 사용>> 버퍼 비우고 즉시전송
				out.flush();

			}else if(location.equals("addFriend.do")){

				//인풋값 : addId
				String addId= request.getParameter("addId");
				
				//아이디로 상대 uidx찾음
				FriendDao fdao = new FriendDao();
				int fUidx= fdao.friendFindId(addId);
				   
				PrintWriter out = response.getWriter();
				
				//세션에서 내 uidx 찾음
				HttpSession session = request.getSession();
				int uidx = (Integer)session.getAttribute("uidx");
				   
				
				if (fUidx != 0) {	//상대 id가 유효하다면
					//친구요청테이블에 사람들 정보를 담음
					FriendRequestDto frdto = new FriendRequestDto();
					frdto.setFromUidx(uidx);	//친구요청을 보내는 사람 == 나
					frdto.setToUidx(fUidx);		//받는사람 == 상대
					 
					//fromUidx=uidx, touidx=fuidx, fstate=w 로 변경
					//insert문이라 결과값이 int이긴한데.. int형도 파싱해야됨 예외없음.
					//json=텍스트 기반 데이터형식
					int exec = fdao.friendSend(frdto);
					
					//결과값 json으로 파싱
					Gson gson = new Gson();
					String json = gson.toJson(exec);
					//데이터->http응답생성->클라이언트
					//getWriter->PrintWriter객체 반환==>텍스트데이터 클라이언트 보낼수 있게함(OutputStream)
					//.write(json)=> 'json'저장된 데이터 출력 (PrintWriter사용)
					response.getWriter().write(json);

				}else {
					out.println("<script>alert('유효한 아이디가 아닙니다.'); history.back();</script>");
					}

			}else if(location.equals("myFriendRequest.do")){
		         
				 		String path ="/mypage/my_friend_request.jsp"; 
				 		RequestDispatcher rd =request.getRequestDispatcher(path);
				 		rd.forward(request, response);
		           
	           
			}else if(location.equals("myRequestList.do")){
				
				//세션에서 내 uidx가져옴
				HttpSession session = request.getSession();
				int uidx = (Integer)session.getAttribute("uidx");
								
				FriendDao fdao =new FriendDao();
				
				List<UserDto> alist = fdao.requestSelectAll(uidx);
				

				
				PrintWriter out = response.getWriter();
				Gson gson = new Gson();
				
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				
				
				 
				 
				 
				String json = (alist != null) ? gson.toJson(alist) : "{}";
						
				//이것도 PrintWriter객체사용 (out) json문자열 출력
				out.print(json);
				//출력버퍼를 비움????
				//==데이터 출력 전 임시저장 모든 데이터 클라이언트로 전송
				//실시간으로 데이터를 보내야 하는 경우, 중요한 메시지를 보낼 때 flush() 사용>> 버퍼 비우고 즉시전송
				out.flush();
				
			
		}else if(location.equals("myRequestAccept.do")){
			
			PrintWriter out = response.getWriter();
			String userId = request.getParameter("userId");
			FriendDao fdao = new FriendDao();
            
			//아이디로 상대 uidx 찾아서 fuidx변수에 넣어줌
			//상대 uidx== fuidx
			int fUidx= fdao.friendFindId(userId);
			
			//세션에서 내uidx가져옴
			//내 uidx == uidx
			HttpSession session = request.getSession();
			int uidx = (Integer)session.getAttribute("uidx");
			
			//내uidx와 상대uidx로 fridx가져옴
			//가져오는이유 :: fridx를 알아야 수락으로 상태변경 해주니깐..
			int fridx = fdao.findFridxByUidx(fUidx, uidx);
			
			//fridx의 fstate값을 'Y'로 변경
			int exec = fdao.friendAccept(fridx);
			
			if(exec != 0) {
				FriendDto fdto = new FriendDto();
				fdto.setUidx1(uidx);	//친구요청을 보내는 사람 == 나
				fdto.setUidx2(fUidx);		//받는사람 == 상대
				 
				//Uidx=uidx1, touidx=uidx2, fstate='Y' 로 변경

				int result = fdao.friendInsert(fdto);
				//결과값 json으로 파싱
				if(result !=0) {
					String jsonResponse = "{\"success\": true}";

				    response.setContentType("application/json;charset=UTF-8");
				    response.getWriter().write(jsonResponse);
				    
				}else{
					out.println("<script>alert('친구 추가에 실패했어요 ㅠ.ㅠ'); history.back();</script>");}
			}else{
				out.println("<script>alert('친구 추가에 실패했어요 ㅠ.ㅠ'); history.back();</script>");}
		
		}else if(location.equals("myRequestreject.do")){
			
			PrintWriter out = response.getWriter();
			String userId = request.getParameter("userId");
			FriendDao fdao = new FriendDao();
            
			//아이디로 상대 uidx 찾아서 fuidx변수에 넣어줌
			//상대 uidx== fuidx
			int fUidx= fdao.friendFindId(userId);
			
			//세션에서 내uidx가져옴
			//내 uidx == uidx
			HttpSession session = request.getSession();
			int uidx = (Integer)session.getAttribute("uidx");
			
			//내uidx와 상대uidx로 fridx가져옴
			int fridx = fdao.findFridxByUidx(fUidx, uidx);
			
			//fridx의 fstate값을 'N'로 변경
			int exec = fdao.friendAccept(fridx);
			
			Gson gson = new Gson();
			String json = gson.toJson(exec);
			//데이터->http응답생성->클라이언트
			//getWriter->PrintWriter객체 반환==>텍스트데이터 클라이언트 보낼수 있게함(OutputStream)
			//.write(json)=> 'json'저장된 데이터 출력 (PrintWriter사용)
			response.getWriter().write(json);
			
		
		}else if(location.equals("myModify.do")){
			String path ="/mypage/my_profile_modify.jsp";
			 RequestDispatcher rd = request.getRequestDispatcher(path);
			 rd.forward(request, response);
			
			
		}
		
	}


}
