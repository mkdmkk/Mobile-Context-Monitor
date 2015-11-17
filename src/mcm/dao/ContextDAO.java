package mcm.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import mcm.db.DBConnector;
import mcm.dto.ContextDTO;
import mcm.servlet.ContextReceiver;

/**
 * Version: 1.1
 * Update Date: 130522
 * @author mkk
 *
 */
public class ContextDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private int resCnt = 0;
	private String sql = "";
	public static ArrayList<Long> responses = new ArrayList<Long>();

	public ContextDAO() {
		// TODO Auto-generated constructor stub
		conn = DBConnector.connectMysql("mcm");
	}
	

	public JSONArray getAllContextsWithPeriod(long stime, long etime) {
		sql = "SELECT * FROM (SELECT * FROM context WHERE time >= ? AND time <= ? ORDER BY time DESC) c ORDER BY c.sensor_type";
		JSONArray jsons = null;
		JSONObject tmpJSON = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setTimestamp(1, new Timestamp(stime));
			pstmt.setTimestamp(2, new Timestamp(etime));
			rs = pstmt.executeQuery();
			if(rs.next()) {
				jsons = new JSONArray();
				int prevSensorType = -1;
				do {
					int sensorType = rs.getInt("sensor_type");
					if(prevSensorType != sensorType) {
						if(prevSensorType != -1) {
							jsons.add(tmpJSON);
						}
						tmpJSON = new JSONObject();
						tmpJSON.put("sensor_type", sensorType);
						tmpJSON.put("member_id", rs.getInt("member_id"));
						tmpJSON.put("time", new JSONArray());
						tmpJSON.put("value0", new JSONArray());
						tmpJSON.put("value1", new JSONArray());
						tmpJSON.put("value2", new JSONArray());
						tmpJSON.put("id", rs.getInt("id"));
						prevSensorType = sensorType;
					}
					((JSONArray) tmpJSON.get("time")).add(rs.getTimestamp("time"));
					((JSONArray) tmpJSON.get("value0")).add(rs.getDouble("value0"));
					((JSONArray) tmpJSON.get("value1")).add(rs.getDouble("value1"));
					((JSONArray) tmpJSON.get("value2")).add(rs.getDouble("value2"));
				} while(rs.next());
				jsons.add(tmpJSON);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return jsons;
	}
	
	public JSONArray getAllLatestContexts() {
		//		sql = "SELECT id, member_id, time, sensor_type, value0, value1, value2 " +
		//				"FROM (SELECT a.*, " +
		//				"(CASE @vjob WHEN a.sensor_type THEN @rownum:=@rownum+1 ELSE @rownum:=1 END) rnum, " +
		//				"(@vjob:=a.sensor_type) vjob " +
		//				"FROM (select * from context T1) a, " +
		//				"(SELECT @vjob:='', @rownum:=0 FROM DUAL) b " +
		//				"ORDER BY a.sensor_type,a.time desc) c where c.rnum=1";
		sql = "SELECT * FROM (SELECT * FROM context ORDER BY time DESC LIMIT 50) c GROUP BY c.sensor_type ";
		//		sql = "SELECT * FROM context GROUP BY sensor_type";
		//		sql = "SELECT * FROM context GROUP BY sensor_type ";
		JSONArray jsons = null;
		JSONObject json = null;
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				jsons = new JSONArray();
				do {
					json = new JSONObject();
					json.put("id", rs.getInt("id"));
					json.put("member_id", rs.getInt("member_id"));
					json.put("sensor_type", rs.getInt("sensor_type"));
					json.put("time", rs.getTimestamp("time"));
					json.put("value0", rs.getFloat("value0"));
					json.put("value1", rs.getFloat("value1"));
					json.put("value2", rs.getFloat("value2"));
					jsons.add(json);
				} while(rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return jsons;
	}

	public JSONObject getLatestContext(int sensorType, Connection conn) {
		sql = "SELECT * FROM context WHERE sensor_type=? ORDER BY time DESC LIMIT 1";
		JSONObject json = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sensorType);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				json = new JSONObject();
				do {
					json.put("id", rs.getInt("id"));
					json.put("member_id", rs.getInt("member_id"));
					json.put("sensor_type", sensorType);
					json.put("time", rs.getTimestamp("time"));
					json.put("value0", rs.getFloat("value0"));
					json.put("value1", rs.getFloat("value1"));
					json.put("value2", rs.getFloat("value2"));
				} while(rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return json;
	}

	public JSONObject getLatestContext(int sensorType) {
		sql = "SELECT * FROM context WHERE sensor_type=? ORDER BY time DESC LIMIT 1";
		JSONObject json = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sensorType);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				json = new JSONObject();
				do {
					json.put("id", rs.getInt("id"));
					json.put("member_id", rs.getInt("member_id"));
					json.put("sensor_type", sensorType);
					json.put("time", rs.getTimestamp("time"));
					json.put("value0", rs.getFloat("value0"));
					json.put("value1", rs.getFloat("value1"));
					json.put("value2", rs.getFloat("value2"));
				} while(rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return json;
	}
	
	public void write(JSONObject json) {
		sql = "INSERT INTO context(type, values, time) VALUES(?, ?, ?)";
		try {
			Iterator<?> jsonIterator = json.keys();
			while(jsonIterator.hasNext()) {
				String key = (String) jsonIterator.next();
				JSONObject context = (JSONObject) json.get(key);
				if(context instanceof JSONObject) {
					System.out.println(context);
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, context.getInt("type"));
					pstmt.setString(2, context.getString("values"));
					pstmt.setLong(3, context.getLong("time"));
					pstmt.executeUpdate();
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public List<List<Double>> getContextsWithPeriod(int sensorType, Timestamp sTime, Timestamp eTime) {
		sql = "SELECT value0, value1, value2 FROM context WHERE sensor_type = ? AND time >= ? AND time <= ? ORDER BY time DESC";
		List<List<Double>> result = new ArrayList<List<Double>>();
		result.add(new ArrayList<Double>());
		result.add(new ArrayList<Double>());
		result.add(new ArrayList<Double>());
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sensorType);
			pstmt.setTimestamp(2, sTime);
			pstmt.setTimestamp(3, eTime);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				result.get(0).add(rs.getDouble("value0"));
				result.get(1).add(rs.getDouble("value1"));
				result.get(2).add(rs.getDouble("value2"));
			}
			return result;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public List<List<Double>> getNContextsWithPeriod(int sensorType, Timestamp sTime, Timestamp eTime, int n) {
		sql = "SELECT value0, value1, value2 FROM context WHERE sensor_type = ? AND time >= ? AND time <= ? ORDER BY time DESC LIMIT ?";
		List<List<Double>> result = new ArrayList<List<Double>>();
		result.add(new ArrayList<Double>());
		result.add(new ArrayList<Double>());
		result.add(new ArrayList<Double>());
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sensorType);
			pstmt.setTimestamp(2, sTime);
			pstmt.setTimestamp(3, eTime);
			pstmt.setInt(4, n);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				result.get(0).add(rs.getDouble("value0"));
				result.get(1).add(rs.getDouble("value1"));
				result.get(2).add(rs.getDouble("value2"));
			}
			return result;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public void closeDB() {
		DBConnector.close(conn);
	}
	
	@Override
	protected void finalize() throws Throwable {
		// TODO Auto-generated method stub
		super.finalize();
		closeDB();
	}
}
