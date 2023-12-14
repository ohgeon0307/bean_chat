package app.controller;

import java.io.IOException;
import java.io.PrintWriter;
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
import app.dto.PageMakerDto;
import app.dto.SearchCriteriaDto;
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
			
			String searchType = request.getParameter("searchType");
			System.out.println(searchType + "<-- searchType");
			if (searchType ==null) searchType="subject";
			String keyword = request.getParameter("keyword");
			System.out.println(keyword + "<-- keyword");
			if (keyword ==null) keyword="";			
			String page = request.getParameter("page");
			if (page ==null) page ="1";
			
			SearchCriteriaDto scri = new SearchCriteriaDto();
			scri.setPage(Integer.parseInt(page));	
			scri.setSearchType(searchType);
			scri.setKeyword(keyword);
			
			PageMakerDto pmdto = new PageMakerDto();
			pmdto.setScri(scri);
			
			BoardDao bdao = new BoardDao();
			ArrayList<BoardDto> alist = bdao.boardSelectAll(scri);
			int cnt = bdao.boardTotalCount(scri);
			
			pmdto.setTotalCount(cnt);
			
			request.setAttribute("alist", alist);
			request.setAttribute("pmdto", pmdto);
			
			String path = "/board/board_list.jsp";

			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);

		} else if (location.equals("boardWrite.do")) {
			HttpSession session = request.getSession();
			int uidx = 0; // 초기값 설정

			if (session.getAttribute("uidx") != null) {
				uidx = (Integer) session.getAttribute("uidx");
			} else {
				// 로그인되지 않은 상태이므로 로그인 페이지로 이동
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>alert('로그인이 필요합니다.'); location.href='" + request.getContextPath()
						+ "/user/user_login.jsp';</script>");
				out.close();
				return;
			}

			UserDao udao = new UserDao();
			UserDto udto = udao.UserSelectOne(uidx);

			if (udto != null) {
				System.out.println("udto.userNickname: " + udto.getUserNickname());
				request.setAttribute("udto", udto);
			} else {
				System.out.println("udto is null or empty.");
			}

			String path = "/board/board_write.jsp";

			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
		} else if (location.equals("boardWriteAction.do")) {

			HttpSession session = request.getSession();
			int uidx = (Integer) session.getAttribute("uidx");

			String subject = request.getParameter("subject");
			System.out.println("subject : " + subject);
			String contents = request.getParameter("contents");
			System.out.println("contents : " + contents);
			String writer = request.getParameter("writer");
			System.out.println("writer : " + writer);

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

		} else if (location.equals("boardContents.do")) {
			String bidx = request.getParameter("bidx");
			int bidx_int = Integer.parseInt(bidx);

			BoardDao bdao = new BoardDao();
			int exec = bdao.boardCntUpdate(bidx_int);
			BoardDto bdto = bdao.boardSelectOne(bidx_int);

			request.setAttribute("bdto", bdto);

			String path = "/board/board_contents.jsp";

			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);

		} else if (location.equals("boardModify.do")) {
			HttpSession session = request.getSession();
			int uidx = 0;

			if (session.getAttribute("uidx") != null) {
				uidx = (Integer) session.getAttribute("uidx");
			} else {
				// 로그인되지 않은 상태이므로 로그인이 필요합니다. 알림 메시지 출력 및 로그인 페이지로 이동
				response.setContentType("text/html;charset=UTF-8");
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>alert('로그인이 필요합니다.'); location.href='" + request.getContextPath()
						+ "/user/user_login.jsp';</script>");
				out.close();
				return;
			}

			// 권한 확인
			String bidx = request.getParameter("bidx");
			int bidx_int = Integer.parseInt(bidx);

			BoardDao bd = new BoardDao();
			String authorUidx = bd.getAuthorUidx(bidx_int); // 해당 글의 작성자 Uidx를 가져옴

			if (uidx != 0 && uidx == Integer.parseInt(authorUidx)) {
				// 권한이 있는 경우에만 수정 페이지로 이동
				UserDao udao = new UserDao();
				UserDto udto = udao.UserSelectOne(uidx);

				if (udto != null) {
					request.setAttribute("udto", udto);
				} else {
					response.sendRedirect(request.getContextPath() + "/board/errorPage.jsp");
				}

				BoardDto bdto = bd.boardSelectOne(bidx_int);
				request.setAttribute("bdto", bdto);

				String path = "/board/board_modify.jsp";
				RequestDispatcher rd = request.getRequestDispatcher(path);
				rd.forward(request, response);
			} else {
				// 권한이 없는 경우에 대한 처리
				// 예: 권한이 없다는 메시지를 출력하거나 다른 페이지로 리다이렉트
				response.sendRedirect(request.getContextPath() + "/board/errorPage.jsp");
			}

		} else if (location.equals("boardModifyAction.do")) {
			String bidx = request.getParameter("bidx");
			System.out.println("-----------" + bidx);
			String subject = request.getParameter("subject");
			String contents = request.getParameter("contents");
			String writer = request.getParameter("writer");

			BoardDto bdto = new BoardDto();
			bdto.setSubject(subject);
			bdto.setContents(contents);
			bdto.setWriter(writer);
			bdto.setBidx(Integer.parseInt(bidx));

			// 수정 처리 부분
			HttpSession session = request.getSession();
			int uidx = (Integer) session.getAttribute("uidx");

			BoardDao bd = new BoardDao();
			String authorUidx = bd.getAuthorUidx(Integer.parseInt(bidx)); // 해당 글의 작성자 Uidx를 가져옴

			if (uidx != 0 && uidx == Integer.parseInt(authorUidx)) {
				// 현재 로그인된 사용자가 글의 작성자와 일치하는 경우에만 수정 수행
				int value = bd.boardModify(bdto);

				if (value != 0) {
					String path = request.getContextPath() + "/board/boardContents.do?bidx=" + bidx;
					response.sendRedirect(path);
				} else {
					// 수정 실패 시 처리 (예: 에러 페이지로 리다이렉트)
					response.sendRedirect(request.getContextPath() + "/board/errorPage.jsp");
				}
			} else {
				// 수정 권한이 없는 경우에 대한 처리
				// 예: 권한이 없다는 메시지를 출력하거나 다른 페이지로 리다이렉트
				response.sendRedirect(request.getContextPath() + "/board/errorPage.jsp");
			}
		} else if (location.equals("boardDeleteAction.do")) {
			HttpSession session = request.getSession();
			int uidx = 0; // 초기값 설정

			if (session.getAttribute("uidx") != null) {
				// 로그인된 사용자의 ID를 가져옴 (세션에서 또는 사용자 인증 시스템에서)
				uidx = (Integer) session.getAttribute("uidx");
			} else {
				// 로그인되지 않은 상태이므로 로그인이 필요합니다. 알림 메시지 출력 및 로그인 페이지로 이동
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>alert('로그인이 필요합니다.'); location.href='" + request.getContextPath()
						+ "/user/user_login.jsp';</script>");
				out.close();
				return;
			}

			String bidx = request.getParameter("bidx");
			int bidx_int = Integer.parseInt(bidx);

			BoardDao bdao = new BoardDao();
			String authorId = bdao.getAuthorUidx(bidx_int); // 해당 글의 작성자 ID를 가져옴

			if (uidx != 0 && Integer.toString(uidx).equals(authorId)) {
				// 현재 로그인된 사용자가 글의 작성자와 일치하는 경우에만 삭제 수행
				int value = bdao.boardDelete(bidx_int);

				if (value != 0) {
					String path = request.getContextPath() + "/board/boardList.do";
					response.sendRedirect(path);
				} else {
					String path = request.getContextPath() + "/board/boardContents.do?bidx=" + bidx;
					response.sendRedirect(path);
				}
			} else {
				// 삭제 권한이 없는 경우에 대한 처리
				// 예: 권한이 없다는 메시지를 출력하거나 다른 페이지로 리다이렉트
				response.sendRedirect(request.getContextPath() + "/board/errorPage.jsp");
			}
		}
	}
}
