package mcm.servlet.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;


public class TimeConverter {
	public long toLong(String date, String time) {
		SimpleDateFormat sdf = new SimpleDateFormat("EEE MMM dd yyyy HH:mm:ss");
		long rst = 0;
		try {
			Date odate = sdf.parse("Thu Jan 01 1970 00:00:00"); 
			rst = sdf.parse(date.split("GMP")[0]).getTime()+
					sdf.parse(time.split("GMP")[0]).getTime()-odate.getTime();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			
		}
		return rst;
	}
}