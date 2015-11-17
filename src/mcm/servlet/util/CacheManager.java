package mcm.servlet.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

public class CacheManager {
	public static final String CACHE_FILE_NAME_PATH = "/Users/mkk/Development/Java/MobileContextMonitor/cache.dat";
	
	private File cacheFile = null;
	private BufferedWriter writer = null;
	private BufferedReader reader = null;
	
	public CacheManager() {
		// TODO Auto-generated constructor stub
	}
	
	public CacheManager(String cacheFilePath) {
		// TODO Auto-generated constructor stub
		cacheFile = new File(cacheFilePath);
		System.out.println("Check Cache File.");
		if(!cacheFile.exists()) {
			System.out.println("Create Cache File.");
			try {
				cacheFile.createNewFile();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	public String readData() {
		String data = "";
		try {
			reader = new BufferedReader(new FileReader(cacheFile));
			data = reader.readLine();
			reader.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return data;
	}
	
	public void writeData(String data) {
		try {
			writer = new BufferedWriter(new FileWriter(cacheFile));
			writer.write(data);
			writer.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
