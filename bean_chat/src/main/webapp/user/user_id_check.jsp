<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="app.dao.UserDao" %>  
<%
String userId =request.getParameter("userId");

UserDao udao = new UserDao();
int value = udao.userIdCheck(userId);

String str ="{ \"cnt\" :  \""+value+"\"   }";
out.println(str);
%>    
 
  
