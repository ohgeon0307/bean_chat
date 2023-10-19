package com.my0803.myapp.service;

import java.util.ArrayList;


import com.my0803.myapp.domain.MemberVo;

public interface MemberService {
//미완성된 메소드로 구성되어있는
//클래스가 아닌 클래스
//사용한 메소드 이름을 정의하는곳 선언
	

//설계도	

	public int memberInsert(MemberVo bv);
	
	public MemberVo memberLogin(String memberId,String memberPwd);
	
	public MemberVo memberLogin(String memberId);
	
	public int memberIdCheck(String memberId);
	
	public ArrayList<MemberVo> memberList();
	






	
	
}
