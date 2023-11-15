package app.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import app.dao.BoardDao;
import app.dao.UserDao;
import app.dto.BoardDto;
import app.dto.UserDto;

@WebServlet("/BoardController")
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private String location;

	public BoardController(String location) {
		this.location = location;
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (location.equals("boardList.do")) {
			BoardDao bdao = new BoardDao();
			ArrayList<BoardDto> alist = bdao.boardSelectAll();

			request.setAttribute("alist", alist);

			String path = "/board/board_list.jsp";

			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);

		} else if (location.equals("boardWrite.do")) {

			String path = "/board/board_write.jsp";

			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);

		} else if (location.equals("boardWriteAction.do")) {

			HttpSession session = request.getSession();
			System.out.println(session.getAttribute("userId"));
			int uidx = (Integer) session.getAttribute("uidx");

			UserDao udao = new UserDao();
			UserDto udto = udao.UserSelectOne(uidx);

			request.setAttribute("udto", udto);

			if (udto != null) {
				System.out.println("udto.userNickname: " + udto.getUserNickname());
				request.setAttribute("udto", udto);
			} else {
				System.out.println("udto is null or empty.");
			}

			String subject = request.getParameter("subject");
			System.out.println("subject : " + subject);
			String contents = request.getParameter("contents");
			System.out.println("contents : " + contents);
			String writer = request.getParameter("writer");
			System.out.println("writer : " + writer);

			// viewCnt, bList default error occurred(추후수정)

			// int uidx = 0;
			// HttpSession session = request.getSession();
			// uidx = (int)session.getAttribute("uidx");

			BoardDto bdto = new BoardDto();
			bdto.setSubject(subject);
			bdto.setContents(contents);
			bdto.setWriter(writer);
			// bdto.setFilename(fileName);
			bdto.setUidx(uidx);

			BoardDao bdao = new BoardDao();
			int value = bdao.boardInsert(bdto);

			if (value == 0) {
				String path = request.getContextPath() + "/board/boardWrite.do";
				response.sendRedirect(path);
			} else {
				String path = request.getContextPath() + "/board/boardList.do";
				response.sendRedirect(path);
			}

		}

	}
}
