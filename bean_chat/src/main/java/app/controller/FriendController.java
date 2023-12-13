package app.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import app.dao.FriendDao;
import app.dao.UserDao;
import app.dto.FriendDto;
import app.dto.FriendRequestDto;
import app.dto.UserDto;

@WebServlet("/FriendController")
public class FriendController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	private String location;
	public FriendController(String location) {
		this.location = location;		
	}


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//마이페이지 메인
		if (location.equals("myFriend.do")){
	         
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
		
		}else if(location.equals("myRequestReject.do")){
			
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
			System.out.println(fUidx+"<<<fUidx");
			System.out.println(uidx+"<<<uidx");
			System.out.println(fridx+"<<<frdx값");
			
			//fridx로 찾아서 보낸요청을 삭제
			int exec = fdao.friendReject(fridx);
			System.out.println(exec+"<<<<삭제되면 1");
			
			if(exec > 0) {
				String jsonResponse = "{\"success\": true}";

			    response.setContentType("application/json;charset=UTF-8");
			    response.getWriter().write(jsonResponse);
			    
			}else{
				out.println("<script>alert('친구 추가에 실패했어요 ㅠ.ㅠ'); history.back();</script>");
			}
				
		}else if(location.equals("myModify.do")){
			String path ="/mypage/my_profile_modify.jsp";
			 RequestDispatcher rd = request.getRequestDispatcher(path);
			 rd.forward(request, response);
			
			
		}
	}
}