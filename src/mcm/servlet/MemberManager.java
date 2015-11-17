package mcm.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mcm.dao.MemberDAO;
import mcm.dto.MemberDTO;

/**
 * Servlet implementation class MemberController
 */
@WebServlet("/MemberController")
public class MemberManager extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberManager() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		HttpSession session = request.getSession();
		String actionType = request.getParameter("actionType");
		String url = "";
		if(actionType.equals("signIn")) {
			String email = "";
			String pw = "";
			if(!(email = request.getParameter("email")).equals("") && !(pw = request.getParameter("pw")).equals("")) {
				MemberDTO memberDTO = new MemberDAO().signIn(email, pw);
				session.setAttribute("MEMBER_INFO", memberDTO);
			}
			url = "/index.jsp";
		} else if(actionType.equals("signUp")) {
			MemberDTO memberDTO = new MemberDTO();
			String parameter = "";
			if(!(parameter = request.getParameter("email")).equals("")) memberDTO.setEmail(parameter);
			if(!(parameter = request.getParameter("pw")).equals("")) memberDTO.setPw(parameter);
			if(!(parameter = request.getParameter("name")).equals("")) memberDTO.setName(parameter);
			MemberDAO memberDAO = new MemberDAO();
			memberDTO = memberDAO.signUp(memberDTO);
			session.setAttribute("MEMBER_INFO", memberDTO);
			url = "/index.jsp";
		} else if(actionType.equals("signOut")) {
			session.removeAttribute("MEMBER_INFO");
			url = "/index.jsp";
		}
		ServletContext sc = getServletContext();
		RequestDispatcher rd = sc.getRequestDispatcher(url);
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
