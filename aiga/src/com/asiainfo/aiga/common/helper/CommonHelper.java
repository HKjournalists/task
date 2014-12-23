package com.asiainfo.aiga.common.helper;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Field;
import java.net.URLDecoder;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import net.sf.json.JSONNull;
import net.sf.json.JsonConfig;
import net.sf.json.processors.DefaultValueProcessor;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.core.io.ClassPathResource;

import com.asiainfo.aiga.common.BaseAction;
import com.asiainfo.aiga.common.JsonDateTrans;
import com.asiainfo.aiga.common.JsonInteger2Boolean;
import com.asiainfo.aiga.common.JsonStringTrans;



/**
 * Created on Jan 17, 2013
 * <p>Description: [工具类]</p>
*/
public class CommonHelper
{
	/**
	* Logger for this class
	*/
	private static final Logger logger = Logger.getLogger(CommonHelper.class);

	public static String DATE_FORMAT = "yyyy-MM-dd";

	public static String DATE_SLASH_FORMAT = "yyyy/MM/dd";
	
	private static final String regEx_html = "<[^>]+>"; // 定义HTML标签的正则表达式 
	public static JsonConfig jsonConfig =BaseAction.jsonConfig;  
	
	public static String dateToString(Date date)
	{
		if(date==null)return "";
		SimpleDateFormat formatter = new SimpleDateFormat(DATE_FORMAT);
		String dateString = formatter.format(date);
		return dateString;
	}
	public static String dateToString(Object dateObj)
	{
		if(dateObj==null)return "";
		return dateToString(dateObj,DATE_FORMAT);
	}
	/**
	 * 
	 * <p>Discription:[根据模版转换日期类型]</p>
	 * @param date
	 * @param patten
	 * @return
	 */
	public static String dateToString(Object dateObj,String patten){
		Date date=null;
		if(dateObj==null)return "";
		if(dateObj instanceof Timestamp)date=(Timestamp)dateObj;
		if(dateObj instanceof Date)date=(Date)dateObj;
		if(date==null)return "";
		SimpleDateFormat formatter = new SimpleDateFormat(patten);
		String dateString = formatter.format(date);
		return dateString;
	}
	/**
	 * 
	 * <p>Discription:[根据模版转换日期类型]</p>
	 * @param date
	 * @param patten
	 * @return
	 */
	public static String dateToString(Date date,String patten){
		SimpleDateFormat formatter = new SimpleDateFormat(patten);
		String dateString = formatter.format(date);
		return dateString;
	}
	/**
	 * @author wenghy
	 * <p>Discription:[String转Date]</p>
	 * @param inputDate
	 * @return
	 */
	public static Date stringToDate(String inputDate,String patten)
	{
		if (StringUtils.isEmpty(inputDate))
		{
			return null;
		}
		SimpleDateFormat sdf = new SimpleDateFormat(patten);
		Date date = null;
		try
		{
			date = sdf.parse(inputDate, new ParsePosition(0));
		}
		catch (Exception ex)
		{
			SimpleDateFormat sdfs = new SimpleDateFormat(DATE_SLASH_FORMAT);
			date = sdfs.parse(inputDate, new ParsePosition(0));
			return date;
		}
		return date;
	}
	/**
	 * @author wenghy
	 * <p>Discription:[String转Date]</p>
	 * @param inputDate
	 * @return
	 */
	public static Date stringToDate(String inputDate)
	{
		if (StringUtils.isEmpty(inputDate))
		{
			return null;
		}
		SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
		Date date = null;
		try
		{
			date = sdf.parse(inputDate, new ParsePosition(0));
		}
		catch (Exception ex)
		{
			SimpleDateFormat sdfs = new SimpleDateFormat(DATE_SLASH_FORMAT);
			date = sdfs.parse(inputDate, new ParsePosition(0));
			return date;
		}
		return date;
	}
	/**
	 * @author wenghy
	 * <p>Discription:[转换成yyyyMMdd]</p>
	 * @param strData
	 * @return
	 */
	public static String cvsDataFormat(String strData)
	{
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMdd");
		Date date = null;
		try
		{
			date = sdf1.parse(strData);
		}
		catch (ParseException e)
		{
			e.printStackTrace();
		}

		return sdf2.format(date);
	}

	public static Date getNowDateShort(Date date)
	{
		SimpleDateFormat formatter = new SimpleDateFormat(DATE_FORMAT);
		String dateString = formatter.format(date);
		ParsePosition pos = new ParsePosition(8);
		Date currentTime_2 = formatter.parse(dateString, pos);
		return currentTime_2;
	}


	

	/**
	 * <p>Discription:[获取chart参数]</p>
	 * @param strKey
	 * @return
	 */
	public static String getProertiesValue(String strKey,String strPropertiesName)
	{
		String strValue = "";
		try
		{
			InputStream in = new ClassPathResource(strPropertiesName).getInputStream();
			Properties p = new Properties();
			p.load(in);
			in.close();
			strValue = p.getProperty(strKey);
		}
		catch (IOException e)
		{
			e.printStackTrace();
		}

		return strValue;
	}
	
	public static List<String> getMonthList()
	{
		List<String> listMonth = new ArrayList<String>();
		listMonth.add("1月");
		listMonth.add("2月");
		listMonth.add("3月");
		listMonth.add("4月");
		listMonth.add("5月");
		listMonth.add("6月");
		listMonth.add("7月");
		listMonth.add("8月");
		listMonth.add("9月");
		listMonth.add("10月");
		listMonth.add("11月");
		listMonth.add("12月");
		return listMonth;
	}
	

	
	/**
	 * @author wenghy
	 * <p>Discription:[获取系统当前时间]</p>
	 * @return
	 */
	public static String getCurrentTime()
	{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String strCurrentTime = sdf.format(new java.util.Date());
		return strCurrentTime;
	}
	/**
	 * @author wenghy
	 * <p>Discription:[获取系统当前时间]</p>
	 * @return
	 */
	public static Timestamp getCurrentTimestamp()
	{
		
		return new Timestamp(System.currentTimeMillis());
	}
	/**
	 * 判断一维数组是否包含关系
	 * @param outer
	 * @param inner
	 * @return
	 */
	public static boolean ArrayContain(String[] outer,String[] inner){
		if(inner.length==0||outer.length==0)return false;
		Arrays.sort(outer);Arrays.sort(inner);	
		HashSet<String> outerList=new HashSet<String>(Arrays.asList(outer));
		HashSet<String> innerList=new HashSet<String>(Arrays.asList(inner));
		return (outerList.containsAll(innerList));
	}
	public static boolean splitAndContain(String strOuter,String strInner){
		if(strOuter!=null&&strInner!=null&&!strOuter.equals("")&&!strInner.equals("")){
			String[] outer=strOuter.split(",");
			String[] inner=strInner.split(",");
			return ArrayContain(outer,inner);
		}
		return false;
	}
	public static Map<String,String> getFieldsClassTypeMap(Class<?>[] clazzs){
		Map<String,String> retMap=new HashMap<String,String>();
		List<Field> fieldList =new ArrayList<Field>();
		for(Class<?> clazz : clazzs){
			for(Class<?> _clazz = clazz ;_clazz!= Object.class;_clazz = _clazz.getSuperclass())
				for(Field field: _clazz.getDeclaredFields())fieldList.add(field);
		}
		for(Field field:fieldList){
			String name = field.getName();
			String originalTypeName = field.getGenericType().toString(); 
			String shortTypeName=(originalTypeName.lastIndexOf(".")>-1?originalTypeName.substring(originalTypeName.lastIndexOf(".")+1):originalTypeName).toLowerCase();
			String extjsTypeName="";
			if(shortTypeName.equals("integer"))extjsTypeName="int";
			else extjsTypeName="string";
			retMap.put(name, extjsTypeName);
		}
		return retMap;
	}
	public static String removeHTMLTag(String inStr) {
		String str=inStr;
		Pattern p_html = Pattern.compile(regEx_html, Pattern.CASE_INSENSITIVE);  
        Matcher m_html = p_html.matcher(inStr);  
        str = m_html.replaceAll(""); // 过滤html标签  
//		Pattern p_script = Pattern.compile("<[^>]+>", Pattern.);
//	    str = str.replace(/<\/?[^>]*>/g,''); //去除HTML tag
//	    str = str.replace(/[ | ]*\n/g,'\n'); //去除行尾空白
//	    str = str.replace(/\n[\s| | ]*\r/g,'\n'); //去除多余空行
//	    str=str.replace(/&nbsp;/ig,'');//去掉&nbsp;
	    return str;
	}
	public static String array2String(String[] strArrays,String separator){
		StringBuffer sb=new StringBuffer();
		for(int i=0,n=strArrays.length;i<n;i++){
			sb.append(strArrays[i]);
			if(i!=n-1)sb.append(separator);
		}
		return sb.toString();
	}
	public static String array2String(String[] strArrays){
		StringBuffer sb=new StringBuffer();
		for(int i=0,n=strArrays.length;i<n;i++){
			sb.append(strArrays[i]);
			if(i!=n-1)sb.append(",");
		}
		return sb.toString();
	}
	public static boolean ArrayHasValue(int[] ints,int value){
		for(int vals:ints){
			if(vals==value)return true;
		}
		return false;
	}
	public static void mapRemove(Map<String,Object> map,String... keys){
		String strKeys=array2String(keys,"--");
		Iterator<Map.Entry<String,Object>> it = map.entrySet().iterator(); 
		while(it.hasNext()){ 
			Map.Entry<String,Object> entry=it.next(); 
			String key=entry.getKey();
			if(strKeys.indexOf(key)!=-1){
				it.remove();
			}
		} 
	}
	  public static String resplaceAllIgnoreCase(String originalString,String splitString, String prefixString,String suffixString)
	    {
	        StringBuffer sb=new StringBuffer(originalString);
	        int start=originalString.toUpperCase().indexOf(splitString.toUpperCase());
	        if(start!=-1)sb.insert(start,prefixString);
	    	originalString=sb.toString();
	    	int end=originalString.toUpperCase().indexOf(splitString.toUpperCase());
	    	if(end!=-1)sb.insert(end+splitString.length(),suffixString);
	    	return sb.toString();
	    }
	   /**
	     * 参数空值校验
	     * @param params
	     * @return
	     */
	  public static boolean NaNull(Object param){
	    	if(param==null || param.equals("")|| param.equals("null")|| param.equals("undefined"))
	    	return false;
	    	else return true;
	    }
	    public static String NullValueFilter(Object param) {
			return NaNull(param)?param.toString():"";
			
		}
		/**
		 * 
		 * <p>Discription:[url转换中文]</p>
		 * @param strURI
		 * @return
		 * @throws UnsupportedEncodingException
		 */
		public static String decodeCN(String strURI) throws UnsupportedEncodingException{
			String s="";
			if(strURI!=null){
				s= URLDecoder.decode(URLDecoder.decode(strURI,"UTF-8"),"UTF-8");
			}
			return s;
		}
	//test
	public static void main(String[] args) throws UnsupportedEncodingException
	{
		Map map =new HashMap();
		map.put("1", "222");
		map.put("2", "333");
		map.put("3", "444");
		System.out.println(map.size());
		mapRemove(map, "1","2");
		System.out.println(map.size());
	}
}