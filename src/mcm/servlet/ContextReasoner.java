package mcm.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import mcm.reasoning.MovementReasoner;
import mcm.servlet.util.TimeConverter;

/**
 * Servlet implementation class ContextReasoner
 */
@WebServlet("/ContextReasoner")
public class ContextReasoner extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ContextReasoner() {
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
		String actionType = request.getParameter("actionType");

		MovementReasoner mr = new MovementReasoner();
		
		if(actionType.equals("clear")) {
			mr.clearTraningDataFile();
		} else if(actionType.equals("train")) {
			mr.writeTrainingDataFile(0, 0, 0, false);
		} else if(actionType.equals("getMovementState")) {
			TimeConverter tc = new TimeConverter();
			long stime = tc.toLong(request.getParameter("sdate"), request.getParameter("stime"));
			long etime = tc.toLong(request.getParameter("edate"), request.getParameter("etime"));
			String movementStateKNN = mr.getMovementStateKNN(stime, etime, 4);
			PrintWriter out = response.getWriter();
			out.print(movementStateKNN);
			out.flush();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
