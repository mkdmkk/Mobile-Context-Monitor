package mcm.client;

import java.io.IOException;

import net.sf.json.JSONObject;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicHeader;
import org.apache.http.protocol.HTTP;

public class TestClinet {
	private final String url = "http://112.171.82.244:8080/MobileContextMonitor/ContextReceiver";
	private HttpClient client = null;
	private HttpResponse response = null;
	private StringEntity entity = null;
	private HttpPost post = null; 
	private JSONObject json = null;
	
	public TestClinet() {
		// TODO Auto-generated constructor stub
		try { 
			client = new DefaultHttpClient();
			json = new JSONObject();
			json.put("sensorType", "GPS");
			json.put("value0", "1");
			json.put("value1", "2");
			json.put("value2", "3");
			entity = new StringEntity(json.toString());
			entity.setContentEncoding(new BasicHeader(HTTP.CONTENT_TYPE, "application/json"));
			post = new HttpPost(url);
			post.setEntity(entity);
			response = client.execute(post);
			if(response != null) response.getEntity().getContent();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) {
		new TestClinet();
	}
}
