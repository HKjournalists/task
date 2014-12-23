package com.asiainfo.csc.common.define;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class HttpConnUtil {
	/**
	 * 向执行服务器发送数据
	 * @param urlString
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public static String connect(String urlString, String param) throws Exception {
		HttpURLConnection con = null;
		BufferedReader br = null;
		StringBuffer sb = new StringBuffer();
		URL url = new URL(urlString);
		con = (HttpURLConnection) url.openConnection();

		con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
		con.setRequestProperty("Content-Length", "" + Integer.toString(param.getBytes().length));
		con.setRequestProperty("Content-Language", "zh-CN");

		//con.setRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0)");
		con.setRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 5.0; Windows NT; DigExt)");
		con.setConnectTimeout(2*1000);
		con.setDoInput(true);
		con.setDoOutput(true);
		con.setRequestMethod("POST");

		con.getOutputStream().write(param.getBytes("UTF-8"));
		con.getOutputStream().flush();
		con.getOutputStream().close();

		br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
		for (String str = null; (str = br.readLine()) != null;) {
			sb.append(str);
		}
		return sb.toString();
	}
	
	public static void main(String[] args) throws Exception {
		System.out.println(connect("http://192.168.0.190:8002/alm_hn",""));
	}
	
}
