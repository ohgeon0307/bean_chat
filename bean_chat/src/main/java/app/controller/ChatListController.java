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

@WebServlet("/ChaListController")
public class ChatListController extends HttpServlet {
   private static final long serialVersionUID = 1L;
   
   
   
   private String location;
   public ChatListController(String location) {
	 this.location = location;
   }
   
}
	
	

