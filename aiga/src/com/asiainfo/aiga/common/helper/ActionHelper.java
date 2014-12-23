package com.asiainfo.aiga.common.helper;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Created on 2014-6-23
 * <p>Description: [���������Ҫ���ܽ���]</p>
*/
public class ActionHelper
{
	 private static final Log logger = LogFactory.getLog(ActionHelper.class);
	/**
	 * <p>��ȡ��ʵIP</p>
	 * @param request
	 * @return
	 */
	public static String getRealIpAddr(HttpServletRequest request)
	{
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))
		{
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))
		{
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))
		{
			ip = request.getRemoteAddr();
		}
		if (ip != null && ip.length() > 32)
		{
			ip = ip.substring(0, 32);//���32�Է����
		}
		if (ip == null)
		{
			ip = "";
		}
		return ip;
	}
	/**
	 * ҳ����ת
	 * @param request
	 * @param response
	 * @param pageURL
	 * @throws BusiException
	 */
	public static void forwardPage(HttpServletRequest request, HttpServletResponse response, String pageURL) throws Exception
	{
		try
		{
			request.getRequestDispatcher(pageURL).forward(request, response);
		}
		catch (Exception e)
		{
			e.getStackTrace();
		}
	}
	public static void responseData4JSON(HttpServletRequest request, HttpServletResponse response, JSON json) throws Exception{
		response.setContentType("text/json;charset=GBK");
		//PrintWriter out = response.getWriter();
		logger.info(json.toString());
		String json_str = json.toString();
		response.getOutputStream().write(json_str.getBytes());
		response.flushBuffer();
		//out.write(json.toString());
	}
	public static void responseData(HttpServletRequest request, HttpServletResponse response, String respString) throws Exception{
		response.setContentType("text/xml;charset=GBK");
		PrintWriter out = response.getWriter();
		out.write(respString);
	}
	public static void responseFileUpload(HttpServletRequest request, HttpServletResponse response, String respString) throws Exception{
		response.setContentType("text/html;charset=GBK");
		PrintWriter out = response.getWriter();
		logger.info(respString);
		out.write(respString);
	}
	public static void responseFileUpload(HttpServletRequest request, HttpServletResponse response,  Map map) throws Exception{
		String outInfo = JsonHelper.getJsonStr(map);
		responseFileUpload(request, response, outInfo);
	}
	/**
	 * ҳ����ת
	 * @param request
	 * @param response
	 * @param pageURL
	 * @throws BusiException
	 */
	public static void sendRedirect(HttpServletRequest request, HttpServletResponse response, String pageURL) throws Exception
	{
		try
		{
			response.sendRedirect(pageURL);
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}

	/**
	 * Ajax�������
	 * @param response
	 * @param outInfo
	 * @throws IOException
	 */
	private static void outWriter(HttpServletResponse response, String outInfo)
	{
		try
		{
			response.setContentType("text/xml;charset=GBK");
			response.setHeader("Cache-Control", "no-cache");
			PrintWriter out = response.getWriter();
			out.write(outInfo);
			out.close();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	private static void outWriter4JSON(HttpServletResponse response, String outInfo)
	{
		try
		{
			response.setContentType("application/Json;charset=UTF-8");
			response.setHeader("Cache-Control", "no-cache");
			PrintWriter out = response.getWriter();
			logger.info(outInfo);
			out.write(outInfo);
			out.close();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	/**
	 * Ajax�������
	 * @param response
	 * @param outInfo
	 * @throws IOException
	 */
	private static void outWriterUTF8(HttpServletResponse response, String outInfo)
	{
		try
		{
			response.setContentType("text/xml;charset=UTF-8");
			response.setHeader("Cache-Control", "no-cache");
			response.setHeader("Pragma", "No-Cache");
			response.setHeader("Cache-Control", "No-Cache");
			response.setDateHeader("Expires", 0);
			PrintWriter out = response.getWriter();
			out.write(outInfo);
			out.close();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	//���ظ�ҳ��ҵ�����ݣ���ҵ��ģ�鹹��map,����ҵ��ҳ��Ļص��������н���
		public static void returnResponseData(HttpServletRequest request, HttpServletResponse response, Map map) throws Exception
		{
			if (map == null)
			{
				map = new HashMap();
			}
				//json��װ        
				String outInfo = JsonHelper.getJsonStr(map);
				logger.info(outInfo);
				outWriter(response, outInfo);
		}
		/**
		 * ����setContentTypeΪapplication/Json��json
		 * @param request
		 * @param response
		 * @param map
		 * @throws Exception
		 */
		public static void returnResponseJsonMap(HttpServletRequest request, HttpServletResponse response, Map map) throws Exception
		{
			if (map == null)
			{
				map = new HashMap();
			}
				//json��װ        
				String outInfo = JsonHelper.getJsonStr(map);
				outWriter4JSON(response, outInfo);

		}
		/**
		 * ����setContentTypeΪapplication/Json��json
		 * @param request
		 * @param response
		 * @param map
		 * @throws Exception
		 */
		public static void returnResponseApplicatonJson(HttpServletRequest request, HttpServletResponse response, JSON json) throws Exception
		{
				outWriter4JSON(response, json.toString());

		}
		//��Map�е�ֵ�ŵ�request��
		private static void setAttibutesFromMap(HttpServletRequest request, Map map)
		{
			Iterator i = map.keySet().iterator();
			while (i.hasNext())
			{
				String key = (String) i.next();
				Object value = (Object) map.get(key);
				request.setAttribute(key, value);
			}
		}
		/**
		 * 
		 * <p>Discription:[urlת������]</p>
		 * @param strURI
		 * @return
		 * @throws UnsupportedEncodingException
		 */
		public static String decodeCN(String strURI) throws UnsupportedEncodingException{
			String s="";
			if(strURI!=null){
//				logger.info(URLDecoder.decode(strURI,"UTF-8"));
				s= URLDecoder.decode(strURI,"UTF-8");
			}
			return s;
			
		}
		/**
		 * <p>Discription:[JSON�ַ���ת��ΪMap]</p>
		 * @param jsonStr
		 * @return
		 */
		  public static Map<String, Object> parseJSON2Map(String jsonStr){
		        Map<String, Object> map = new HashMap<String, Object>();
		        //��������
		        JSONObject json = JSONObject.fromObject(jsonStr);
		       
		        return parseJSON2Map(json);
		    }
		  /**
		   * <p>Discription:[JSON����ת��ΪMap]</p>
		   * @param json
		   * @return
		   */
		  public static Map<String, Object> parseJSON2Map(JSONObject json){
		        Map<String, Object> map = new HashMap<String, Object>();
		        for(Object k : json.keySet()){
		            Object v = json.get(k); 
		            //����ڲ㻹������Ļ�����������
		            if(v instanceof JSONArray){
		                List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		                Iterator<JSONObject> it = ((JSONArray)v).iterator();
		                while(it.hasNext()){
		                    JSONObject json2 = it.next();
		                    list.add(parseJSON2Map(json2));
		                }
		                map.put(k.toString(), list);
		            } else {
		                map.put(k.toString(), v);
		            }
		        }
		        return map;
		    }
}
