package com.my0803.myapp.aop;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Aspect   //AOP기능을 가진 모듈이다라는 뜻
@Component   //  빈으로 등록하겠다
public class SampleAdvice {
	
	Logger logger =   LoggerFactory.getLogger(SampleAdvice.class);
	
	@Before("execution(* com.my0803.myapp.service.BoardService*.*(..))")
	public void startLog() {
		
		logger.info("AOP로 로그를 찍어봅니다. 각 메소드를 들어갈때 메세지가 출력됩니다.");
		System.out.println("이것을sysout으로 찍어보는 기능입니다");
	}
	
	

}
