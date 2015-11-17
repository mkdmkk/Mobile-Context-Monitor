package mcm.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import mcm.dao.ContextDAO;
import mcm.servlet.util.CacheManager;

/**
 * Servlet implementation class ContextRetriver
 */
@WebServlet("/ContextRetriever")
public class ContextRetriever extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static CacheManager cacheManager = new CacheManager(CacheManager.CACHE_FILE_NAME_PATH);
	private ContextDAO contextDAO = null;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ContextRetriever() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json; charset=utf-8");
		String actionType = request.getParameter("actionType");

		
		if(actionType.equals("current")) {
			System.out.println("Retieve Current Context.");
			String data = cacheManager.readData();
			PrintWriter out = response.getWriter();
			out.print(JSONObject.fromObject(data));
			out.flush();
			
			// No cache? then... consider to retrieve from DB.
		} else if(actionType.equals("past")) {
			contextDAO = new ContextDAO();
			SimpleDateFormat sdf = new SimpleDateFormat("EEE MMM dd yyyy HH:mm:ss");
			try {
				Date odate = sdf.parse("Thu Jan 01 1970 00:00:00"); 
				long stime = sdf.parse(request.getParameter("sdate").split("GMP")[0]).getTime()+
						sdf.parse(request.getParameter("stime").split("GMP")[0]).getTime()-odate.getTime();
				long etime = sdf.parse(request.getParameter("edate").split("GMP")[0]).getTime()+
						sdf.parse(request.getParameter("etime").split("GMP")[0]).getTime()-odate.getTime();
//				System.err.println(""+stime);
//				System.err.println(""+etime);
				JSONArray jsons = contextDAO.getAllContextsWithPeriod(stime, etime);
//				System.out.println(jsons);
				PrintWriter out = response.getWriter();
				out.print(jsons);
				out.flush();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			contextDAO.closeDB();
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
