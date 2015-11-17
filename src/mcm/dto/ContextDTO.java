package mcm.dto;

import java.sql.Timestamp;
import java.util.List;

import sun.awt.SunHints.Value;

import net.sf.json.JSONObject;

public class ContextDTO {
	private int id = 0;
	private int sensorType = 0;
	private List<Float> values = null;
	private Timestamp time = null;
	private int memberId = 0;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getSensorType() {
		return sensorType;
	}
	public void setSensorType(int sensorType) {
		this.sensorType = sensorType;
	}
	public List<Float> getValues() {
		return values;
	}
	public void setValues(List<Float> values) {
		this.values = values;
	}
	public Timestamp getTime() {
		return time;
	}
	public void setTime(Timestamp time) {
		this.time = time;
	}
	public int getMemberId() {
		return memberId;
	}
	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}
	public JSONObject convertToJSON() {
		JSONObject json = new JSONObject();
		json.put("id", id);
		json.put("member_id", memberId);
		json.put("sensor_type", sensorType);
		json.put("time", time.toString());
		int i = 0;
		for(Float v:values) json.put("value"+i++, v);
		return json;
	}
}
