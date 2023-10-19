package com.my0803.myapp.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;



//�α��� üũ ���� ���ͼ��� Ŭ���� 
public class AuthInterceptor  extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle( // 이 메서드는 요청이 컨트롤러에 도달하기 전에 실행됩니다. 
							 //사용자의 세션에 "midx" 속성이 없으면, 즉 로그인되지 않은 사용자라면 다음과 같은 작업을 수행합니다:
			HttpServletRequest request,
			HttpServletResponse response,
			Object handler
			) throws Exception{
		
		HttpSession session = request.getSession();
		
		boolean tf =false;
		if (session.getAttribute("midx") == null) {
			
			System.out.println(request);
			//���ǿ� �̵��ҷ��� �ϴ� �ּҸ� ��´�
			saveUrl(request);//메서드를 호출하여 현재 요청의 URL을 세션에 저장합니다. 이것은 사용자가 로그인 후 이전 페이지로 다시 이동하기 위한 목적입니다.
			
			String location =request.getContextPath()+"/member/memberLogin.do"; //request.getContextPath()
																				//를 사용하여 로그인 페이지의 URL을 생성합니다.
			response.sendRedirect(location);			
			return false;			
		} else {
			return true;			
		}		
		//return true;
	}
	
	//�̵��Ϸ��� �ϴ� �ּҸ� ���ǿ� ��� �޼ҵ�
	public void saveUrl(HttpServletRequest req) {
		
		String uri = req.getRequestURI();   //��ü����ּ�
		String query =req.getQueryString();  // �Ķ����
		
		if (query ==null || query.equals("null")) {
			query="";
		}else {
			query = "?" +query;
		}
		System.out.println(uri+query);
		
		if (req.getMethod().equals("GET")) {   // ��ҹ��� �߿�!!!
			req.getSession().setAttribute("saveUrl", uri+query);
		}		
	}
	
	
	
	
}