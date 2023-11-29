package app.controller;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import app.dao.ChatDao;
import app.dto.ChatDto;

@WebServlet("/ChatSubmitController")
public class ChatSubmitController extends HttpServlet {
   private static final long serialVersionUID = 1L;
   private String location;


   public ChatSubmitController(String location) {
      this.location = location;
   }
	
   protected void doGet(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {
	   
	   if (location.equals("chat_one.do")) {
	         response.setContentType("application/json");
	         

	         String cFrom = request.getParameter("cFrom");
	         String cTo = request.getParameter("cTo");
	         String cContents = request.getParameter("cContents");
	         
	     
	
	          
	         if (cFrom == null || cFrom.equals("") || cTo == null || cTo.equals("") || cContents == null
	               || cContents.equals("")) {
	            response.getWriter().write("0"); //하나라도 값이 비어있는게 있으면 클라이언트에게 반환

	         } else  {
	            cFrom = URLDecoder.decode(cFrom, "UTF-8");
	            cTo = URLDecoder.decode(cTo, "UTF-8");
	            cContents = URLDecoder.decode(cContents, "UTF-8");
				/*
				 * String fromNickname = new ChatDao().getUserNickname(cFrom); String toNickname
				 * = new ChatDao().getUserNickname(cTo);
				 * 
				 * request.setAttribute("fromNickname", fromNickname);
				 * request.setAttribute("toNickname", toNickname);
				 */
	          
	            response.getWriter().write(new ChatDao().submit(cFrom, cTo, cContents) + ""); //submit함수를 실행해서 실행한 결과를 반환할수있게 write해줌

	         }

	      }


         }
      
  
   
}