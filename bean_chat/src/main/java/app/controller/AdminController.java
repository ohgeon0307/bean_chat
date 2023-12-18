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

import app.dao.AdminDao;
import app.dao.UserDao;
import app.dto.PageMakerDto;
import app.dto.PasswordEncoder;
import app.dto.SearchCriteriaDto;
import app.dto.UserDto;

@WebServlet("/AdminController")
public class AdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private String location;

	public AdminController(String location) {
		this.location = location;
	}
	// ㅇㅇㅇㅇ
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		PasswordEncoder passwordEncoder = new PasswordEncoder();

		// 관리자 페이지 이동
		if (location.equals("userList.do")) {
			String searchType = request.getParameter("searchType");
			System.out.println(searchType + "<-- searchType");
			if (searchType ==null) searchType="uidx";
			String keyword = request.getParameter("keyword");
			System.out.println(keyword + "<-- keyword");
			if (keyword ==null) keyword="";			
			String page = request.getParameter("page");
			if (page ==null) page ="1";
			
			SearchCriteriaDto scri = new SearchCriteriaDto();
			System.out.println(scri + "<- scri");
			scri.setPage(Integer.parseInt(page));	
			scri.setSearchType(searchType);
			scri.setKeyword(keyword);
			
			PageMakerDto pmdto = new PageMakerDto();
			System.out.println(pmdto + "<-pmdto");
			pmdto.setScri(scri);
			
			AdminDao adao = new AdminDao();
			ArrayList<UserDto> alist = adao.userSelectAll(scri);
			int cnt =adao.userTotalCount(scri);
			
			pmdto.setTotalCount(cnt);
			
			request.setAttribute("alist", alist);
			request.setAttribute("pmdto", pmdto);

			String path = "/admin/admin_user_list.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);

			// 회원가입 페이지 이동
		} else if (location.equals("adminUserDelete.do")) {
			String[] selectUidx = request.getParameterValues("uidx");

			if (selectUidx != null && selectUidx.length > 0) {
	            UserDao udao = new UserDao();

	            PrintWriter out = response.getWriter();
	            for (String uidx : selectUidx) {
	                int uidxValue = Integer.parseInt(uidx);
	                int exec= udao.userDelete(uidxValue); // 선택된 회원 삭제

	                if(exec > 0) {
						out.println("<script>alert('정상적으로 해당 회원 탈퇴처리 되었습니다.');"
								+	"document.location.href='"+request.getContextPath() + "/admin/userList.do'</script>");
							}else{
								out.println("<script>history.back();</script>");
							}
	            	}
				}

		}else if (location.equals("adminUserDeletdde.do")) {


			
		}
	}
}
