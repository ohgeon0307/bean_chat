package app.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import app.dao.BoardDao;
import app.dto.BoardDto;

@WebServlet("/BoardController")
public class BoardController extends HttpServlet{
private static final long serialVersionUID = 1L;
	
	private String location;
	public BoardController(String location) {
		this.location = location;		
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(location.equals("boardList.do")) {
			BoardDao bdao = new BoardDao();
			ArrayList<BoardDto> alist = bdao.boardSelectAll();
			
			request.setAttribute("alist", alist);
			
			String path ="/board/board_list.jsp";
			
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
		}
	
	}
}
