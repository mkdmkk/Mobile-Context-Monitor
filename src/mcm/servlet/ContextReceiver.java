package mcm.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mcm.dao.ContextDAO;
import mcm.servlet.util.CacheManager;
import mcm.servlet.util.RequestHandler;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * Servlet implementation class ContextReceiver
 */
@WebServlet("/ContextReceiver")
public class ContextReceiver extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static CacheManager cacheManager = new CacheManager(CacheManager.CACHE_FILE_NAME_PATH);
	private static ContextDAO contextDAO = null;
	
	// Injection Code for Testing Congestions
//	private static int count = 1;
//	public static ArrayList<Long> responses = new ArrayList<Long>();
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ContextReceiver() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
//		contextDAO = new ContextDAO();
		String reqStr = RequestHandler.getRequestString(request);
		System.out.println("REQ: "+reqStr);
		cacheManager.writeData(reqStr);

		// ====================================================
		// JSON Structure
		// {__TYPE__:__CONTEXT__, __TYPE__:__CONTEXT__, ...} 
		// Example: {"3":{"time":1369196686376,"values":[235.15850830078125,1.418946385383606,0.7923339605331421],"minimumDelay":"Orientation Sensor","name":"Orientation Sensor","power":"Orientation Sensor","maximumRange":360,"resolution":"Orientation Sensor","accuracy":3,"version":1},"2":{"time":1369196686402,"values":[13.4375,-6.5,-13.9375],"minimumDelay":"AK8973 3-axis Magnetic field sensor","name":"AK8973 3-axis Magnetic field sensor","power":"AK8973 3-axis Magnetic field sensor","maximumRange":2000,"resolution":"AK8973 3-axis Magnetic field sensor","accuracy":3,"version":1},"10":{"time":1369196686377,"values":[-0.30799275636672974,-0.12110219895839691,-0.053516387939453125],"minimumDelay":"Linear Acceleration Sensor","name":"Linear Acceleration Sensor","power":"Linear Acceleration Sensor","maximumRange":19.613300323486328,"resolution":"Linear Acceleration Sensor","accuracy":3,"version":3},"1":{"time":1369196686377,"values":[-0.17238251864910126,-0.363918662071228,9.749189376831055],"minimumDelay":"KR3DM 3-axis Accelerometer","name":"KR3DM 3-axis Accelerometer","power":"KR3DM 3-axis Accelerometer","maximumRange":19.613300323486328,"resolution":"KR3DM 3-axis Accelerometer","accuracy":3,"version":1},"5":{"time":1369196685959,"values":[113.32460021972656,0,0],"minimumDelay":"GP2A Light sensor","name":"GP2A Light sensor","power":"GP2A Light sensor","maximumRange":3626657.75,"resolution":"GP2A Light sensor","accuracy":0,"version":1},"4":{"time":1369196686411,"values":[-0.00746291596442461,0.18354180455207825,0.011957308277487755],"minimumDelay":"Corrected Gyroscope Sensor","name":"Corrected Gyroscope Sensor","power":"Corrected Gyroscope Sensor","maximumRange":34.906585693359375,"resolution":"Corrected Gyroscope Sensor","accuracy":0,"version":1},"9":{"time":1369196686376,"values":[0.13561023771762848,-0.24281646311283112,9.802705764770508],"minimumDelay":"Gravity Sensor","name":"Gravity Sensor","power":"Gravity Sensor","maximumRange":19.613300323486328,"resolution":"Gravity Sensor","accuracy":3,"version":3},"8":{"time":1369196682729,"values":[5,0,0],"minimumDelay":"GP2A Proximity sensor","name":"GP2A Proximity sensor","power":"GP2A Proximity sensor","maximumRange":5,"resolution":"GP2A Proximity sensor","accuracy":0,"version":1},"11":{"time":1369196686377,"values":[3.956493455916643E-4,-0.014176009222865105,0.8862424492835999],"minimumDelay":"Rotation Vector Sensor","name":"Rotation Vector Sensor","power":"Rotation Vector Sensor","maximumRange":1,"resolution":"Rotation Vector Sensor","accuracy":-17,"version":3}}
		// ====================================================
//		ContextDAO contextDAO = new ContextDAO();
//		contextDAO.write(JSONObject.fromObject(reqStr));
		
		//		if(request.getParameter("actionType").equals("array")) {
//			cacheManager.writeData(reqStr);
//			ContextDAO contextDAO = new ContextDAO();
//			contextDAO.write(JSONArray.fromObject(reqStr));
//		} else {
//			cacheManager.writeData(reqStr);
//			ContextDAO contextDAO = new ContextDAO();
//			contextDAO.write(JSONObject.fromObject(reqStr));
//		}
//		contextDAO.closeDB();
	}
	
}
