package com.my0803.myapp.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller   //전통적인 Spring MVC의 컨트롤러 어노테이션인 @Controller는 주로 View(화면)를 반환하기 위해 사용합니다.
				//@Controller는 Controller 클래스에 붙이는 것이다. Controller 클래스는 클라이언트와의 요청, 응답을 주고 받는 역활을 한다.
public class HomeController {
	
	//@Resource(name="db")   @Resource : Name으로 Bean을 지정한다.(필드/메서드에만 적용 가능)
	//@Inject
	//@Autowired  @Autowired : 타입(클래스)로 Bean을 지정한다.(생성자/필드/메서드에 모두 적용 가능)
	@Resource(name="db")
	DriverManagerDataSource dmds;   //������ �������� ������ ��ü����
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/index.do", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		//포워드 방식
		return "views/home"; //views 찐주소 home.jsp로 들어가서 보여준다
	}
	
	
	
	
	
	@RequestMapping(value = "/introduction.do", method = RequestMethod.GET)
	public String introduction() {
		
		//	System.out.println("주소값?"+dmds);
		
		//포워드 방식
		return "views/introduction";//views 찐주소introduction.jsp로 들어가서 보여준다
	}
	

	
	
}
