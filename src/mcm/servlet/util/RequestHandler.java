package mcm.servlet.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;

public class RequestHandler {
	public static String getRequestString(HttpServletRequest request) {
		try {
			request.setCharacterEncoding("utf-8");
			InputStream is = request.getInputStream();
			InputStreamReader isr = new InputStreamReader(is, "UTF-8");
			BufferedReader bis = new BufferedReader(isr);
			String s = "";
			StringBuffer sb = new StringBuffer();
			while((s = bis.readLine()) != null) sb.append(s);
			bis.close();
			is.close();
			return sb.toString();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}
}
