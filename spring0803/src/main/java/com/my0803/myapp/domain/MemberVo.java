package com.my0803.myapp.domain;


//나중에 DATABASE의 회원정보를 담기위한 클래스(value Object)
public class MemberVo {
   
   private int midx;  //회원번호 값을 담는 변수
   private String memberId;
   private String memberPwd;
   private String memberName;
   private String memberPhone;
   private String memberEmail;
   private String delyn;   //삭제여부
   private String writeday;  //등록일
   private String memberIp;  //ip추출
   private String memberBirth;
   private String memberGender;
   private String memberAddr;
   private String memberYear;
   private String memberMonth;
   private String memberDay;
   
   public String getMemberDay() {
      return memberDay;
   }
   public void setMemberDay(String memberDay) {
      this.memberDay = memberDay;
   }
   public String getMemberYear() {
      return memberYear;
   }
   public void setMemberYear(String memberYear) {
      this.memberYear = memberYear;
   }
   public String getMemberMonth() {
      return memberMonth;
   }
   public void setMemberMonth(String memberMonth) {
      this.memberMonth = memberMonth;
   }
   
   
   
   public String getMemberAddr() {
      return memberAddr;
   }
   public void setMemberAddr(String memberAddr) {
      this.memberAddr = memberAddr;
   }
   public String getMemberGender() {
      return memberGender;
   }
   public void setMemberGender(String memberGender) {
      this.memberGender = memberGender;
   }
   public String getMemberBirth() {
      return memberBirth;
   }
   public void setMemberBirth(String memberBirth) {
      this.memberBirth = memberBirth;
   }
   public String getMemberHobby() {
      return memberHobby;
   }
   public void setMemberHobby(String memberHobby) {
      this.memberHobby = memberHobby;
   }
   private String memberHobby;
   
   public int getMidx() {   //회원번호 값을 꺼내는 메소드
      return midx;
   }
   public void setMidx(int midx) {  //값을 담다
      this.midx = midx;
   }
   public String getMemberId() {
      return memberId;
   }
   public void setMemberId(String memberId) {
      this.memberId = memberId;
   }
   public String getMemberPwd() {
      return memberPwd;
   }
   public void setMemberPwd(String memberPwd) {
      this.memberPwd = memberPwd;
   }
   public String getMemberName() {
      return memberName;
   }
   public void setMemberName(String memberName) {
      this.memberName = memberName;
   }
   public String getMemberPhone() {
      return memberPhone;
   }
   public void setMemberPhone(String memberPhone) {
      this.memberPhone = memberPhone;
   }
   public String getMemberEmail() {
      return memberEmail;
   }
   public void setMemberEmail(String memberEmail) {
      this.memberEmail = memberEmail;
   }
   public String getDelyn() {
      return delyn;
   }
   public void setDelyn(String delyn) {
      this.delyn = delyn;
   }
   public String getWriteday() {
      return writeday;
   }
   public void setWriteday(String writeday) {
      this.writeday = writeday;
   }
   public String getMemberIp() {
      return memberIp;
   }
   public void setMemberIp(String memberIp) {
      this.memberIp = memberIp;
   }
   

}