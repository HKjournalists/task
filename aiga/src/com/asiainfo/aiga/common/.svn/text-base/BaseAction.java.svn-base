package com.asiainfo.aiga.common;

import java.io.UnsupportedEncodingException;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONNull;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.processors.DefaultValueProcessor;
import net.sf.json.util.CycleDetectionStrategy;
import net.sf.json.util.JSONUtils;

import org.apache.log4j.Logger;
import org.hibernate.lob.SerializableClob;
import org.springframework.context.ApplicationContext;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.asiainfo.aiga.sysConstant.util.SysContentUtil;

public class BaseAction {
	protected final static String PAGE_PARAM="page";
	protected final static String START_PARAM="start";
	protected final static String LIMIT_PARAM="limit";
	private static Logger logger = Logger.getLogger(BaseAction.class);
	private Map<String, Object> rtnMap = new HashMap<String, Object>();
	public static JsonConfig jsonConfig = new JsonConfig();
	static{
		jsonConfig.registerDefaultValueProcessor(Integer.class,
			    new DefaultValueProcessor(){
			        public Object getDefaultValue(Class type){
			            return JSONNull.getInstance();
			        }
			    });
		jsonConfig.registerJsonValueProcessor(Date.class , new JsonDateTrans());
		jsonConfig.registerJsonValueProcessor(Timestamp.class , new JsonDateTrans());
		jsonConfig.registerJsonValueProcessor(String.class, new JsonStringTrans());
		jsonConfig.registerJsonValueProcessor(Integer.class, new JsonInteger2Boolean());
		jsonConfig.registerJsonValueProcessor(SerializableClob.class, new JsonClobStringType2String());
		
	}
	//完成 待测
	public Object[] transFormToObj(HttpServletRequest request, Class[] dataBeans)
			throws Exception {
		try{
			request.setCharacterEncoding("UTF-8");
			List resultObjects = new ArrayList();
			for(Class dataBean : dataBeans){
				Object form = dataBean.newInstance();
				Field[] fields = dataBean.getDeclaredFields();  
				Field[] superFields = dataBean.getSuperclass().getDeclaredFields();
				List<Field> fieldList = new ArrayList<Field>();
				for(Field field : fields){
					fieldList.add(field);
					
				}
				for(Field superField:superFields){
					fieldList.add(superField);
				}
				for(Field field : fieldList){
					Class[] parameterTypes = new Class[1];
					parameterTypes[0] = field.getType(); 
					String filedName = field.getName();
					
					String filedValue = request.getParameter(filedName);
					if(filedValue==null)
						continue;
					Object newVal =null;
					if(filedName.startsWith("is")&&(parameterTypes[0].getName().equals(Integer.class.getName())||parameterTypes[0].getName().equals(Short.class.getName()))){
						if(filedValue.equals("false"))filedValue="0";
						if(filedValue.equals("true"))filedValue="1";
						if(filedValue.equals("on"))filedValue="1";
						}
					newVal= this.transFormType(parameterTypes[0], filedValue);
					StringBuffer sb = new StringBuffer();  
					sb.append("set");  
					sb.append(filedName.substring(0, 1).toUpperCase());
					sb.append(filedName.substring(1));  
					Method method = dataBean.getMethod(sb.toString(), parameterTypes);  
					method.invoke(form, newVal);
				}
				resultObjects.add(form);
			}
			return resultObjects.toArray();
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			this.rtnMap.put("success", false);
			JSONObject errobject = new JSONObject();
			errobject.put("clientCode", "error");
			errobject.put("portOfLoading", e.getMessage());
			return null;
		}
	}
	public Object[] transTableToObj(HttpServletRequest request, Class dataBean) throws Exception
	{
		List resultObjects = new ArrayList();
		request.setCharacterEncoding("UTF-8");
		String strTable = request.getParameter("table");
		strTable = unicodeToString(strTable);
		if (strTable != null && strTable.length() > 0)
		{
			String[] formats={"yyyy-MM-dd HH:mm:ss","yyyy-MM-dd" };
			JSONUtils.getMorpherRegistry().registerMorpher(new JsonDateToObj(formats));  
		
			JSONArray jsonArr = JSONArray.fromObject(strTable);
			for (int i = 0, n = jsonArr.size(); i < n; i++)
			{
				JSONObject json = (JSONObject) jsonArr.get(i);
				resultObjects.add(JSONObject.toBean(json, dataBean));
			}

		}

		return resultObjects.toArray();
	}
	
	@SuppressWarnings("finally")
	protected Map<String,Integer> paginationParams(HttpServletRequest request)throws Exception{
		Map<String,Integer> paginationParams =new HashMap<String,Integer>();
		try{
			Integer page=Integer.valueOf(request.getParameter(PAGE_PARAM));
			Integer start=Integer.valueOf(request.getParameter(START_PARAM));
			Integer limit=Integer.valueOf(request.getParameter(LIMIT_PARAM));
			paginationParams.put(PAGE_PARAM, page);
			paginationParams.put(START_PARAM, start);
			paginationParams.put(LIMIT_PARAM, limit);
		}catch (Exception e) {
			e.getStackTrace();
		}finally{
			return paginationParams;
		}
	}
	protected Object transFormType(Class type,String value)throws Exception{
		
		Object transVal = null;
		if(type.getName().equals(Integer.class.getName())){
			if(value==null||value.equals(""))
				return null;
			transVal = Integer.valueOf(value);
		}else if(type.getName().equals(String.class.getName())){
			if(value==null||value.equals(""))
				return "";
			transVal = String.valueOf(value);
		}else if(type.getName().equals(Long.class.getName())){
			if(value==null||value.equals(""))
				return null;
			transVal = Long.valueOf(value);
		}else if(type.getName().equals(Double.class.getName())){
			if(value==null||value.equals(""))
				return null;
			transVal = Double.valueOf(value);
		}else if(type.getName().equals(Short.class.getName())){
			if(value==null||value.equals(""))
				return null;
			transVal = Short.valueOf(value);
		}else if(type.getName().equals(Boolean.class.getName())){
			if(value==null||value.equals(""))
				return null;
			transVal = Boolean.valueOf(value);
		}else if(type.getName().equals(Date.class.getName())){
			if(value==null||value.equals(""))
				return null;
			String eL = "[0-9]{4}-[0-9]{2}-[0-9]{2}";
			Pattern p = Pattern.compile(eL);		
			Matcher m = p.matcher(value);		
			boolean dateFlag = m.matches();	
			Date date = null;
			if (dateFlag==true)		
				date = new SimpleDateFormat("yyyy-MM-dd").parse(value);
			else{
				eL = "^((((1[6-9]|[2-9]\\d)\\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\\d|3[01]))|(((1[6-9]|[2-9]\\d)\\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\\d|30))|(((1[6-9]|[2-9]\\d)\\d{2})-0?2-(0?[1-9]|1\\d|2[0-8]))|(((1[6-9]|[2-9]\\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-)) (20|21|22|23|[0-1]?\\d):[0-5]?\\d:[0-5]?\\d$";
				p = Pattern.compile(eL);		
				m = p.matcher(value);		
				dateFlag = m.matches();	
				if(dateFlag==true){
					date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(value);
				}else{
					throw new Exception("非正确的日期格式:"+value);
				}
			}
			transVal = date;
		}else if(type.getName().equals(Timestamp.class.getName())){
			if(value==null||value.equals(""))
				return null;
			String eL = "[0-9]{4}-[0-9]{2}-[0-9]{2}";
			Pattern p = Pattern.compile(eL);		
			Matcher m = p.matcher(value);		
			boolean dateFlag = m.matches();	
			Date date = null;
			if (dateFlag==true)		
				date = new SimpleDateFormat("yyyy-MM-dd").parse(value);
			else{
				eL = "^((((1[6-9]|[2-9]\\d)\\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\\d|3[01]))|(((1[6-9]|[2-9]\\d)\\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\\d|30))|(((1[6-9]|[2-9]\\d)\\d{2})-0?2-(0?[1-9]|1\\d|2[0-8]))|(((1[6-9]|[2-9]\\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-)) (20|21|22|23|[0-1]?\\d):[0-5]?\\d:[0-5]?\\d$";
				p = Pattern.compile(eL);		
				m = p.matcher(value);		
				dateFlag = m.matches();	
				if(dateFlag==true){
					date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(value);
				}else{
					throw new Exception("非正确的日期格式:"+value);
				}
			}
			transVal = new Timestamp(date.getTime());
		}else if(type.getName().equals(BigDecimal.class.getName())){
			if(value==null||value.equals(""))
				return null;
			transVal = BigDecimal.valueOf(Long.valueOf(value));
		}
		return transVal;
	}
	
	//完成  已测
	public void setTable(Object[] tableData) throws Exception {

		if(tableData!=null && tableData.length!=0){
			JSONArray jsonArray = JSONArray.fromObject(tableData,jsonConfig);
			this.rtnMap.put("data", jsonArray);
		}else
			this.rtnMap.put("data", new JSONArray());
	}
	
	//未完成 待重写
	public void setTree(Object treeObject,HttpServletRequest request)throws Exception{
		if(treeObject!=null){
			Class[] parameterTypes = new Class[1];
			parameterTypes[0] = HttpServletRequest.class;
			Method method = treeObject.getClass().getMethod("getTree", parameterTypes);  
			JSONObject jsonTree = (JSONObject)method.invoke(treeObject, request);
			this.rtnMap.put("data", jsonTree);
		}else
			this.rtnMap.put("data", new JSONObject());
	}
	
	//完成 已测
	public void setPostInfo(String key,Object value)throws Exception{
		this.rtnMap.put(key, value);
	}
	
	//完成 已测
	public Object getPostInfoValue(String key)throws Exception{
		return this.rtnMap.get(key);
	}
	
	//完成 待测
	public void setFormData(Object formData){
		try{
			if(formData!=null){
				JSONObject formdata = JSONObject.fromObject(formData,jsonConfig);
				this.rtnMap.put("data", formdata);
				this.rtnMap.put("success", true);
			}else{
				this.rtnMap.put("success", true);
				this.rtnMap.put("data", new JSONObject());
			}
		}catch(Exception e){
			e.printStackTrace();
			this.rtnMap.put("success", false);
			this.rtnMap.put("errorMessage", e.getMessage());
		}
	}
	
	//完成  已测
	public void postInfo(HttpServletRequest request, HttpServletResponse response)throws Exception{
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
		JSONObject object = JSONObject.fromObject(this.rtnMap,jsonConfig);
		response.setContentType("application/Json;charset=UTF-8");
		response.getWriter().write(object.toString());
		logger.info(object.toString());
		this.rtnMap.clear();
	}
	
	public void writeOwnJson(HttpServletResponse response, JSONObject json) throws Exception {
		response.setContentType("application/Json;charset=UTF-8");
		response.getWriter().write(json.toString());
	}
	
	public String unicodeToString(String str) throws Exception {
		if(str == null) {
			return null;
		}
        Pattern pattern = Pattern.compile("(\\\\u(\\p{XDigit}{4}))");    
        Matcher matcher = pattern.matcher(str);
        char ch;
        while (matcher.find()) {
            ch = (char) Integer.parseInt(matcher.group(2), 16);
            str = str.replace(matcher.group(1), ch + "");    
        }
        return str;
    }
	public void sysConstantInt(HttpServletRequest request, HttpServletResponse response)throws Exception{
		ApplicationContext context = RequestContextUtils.getWebApplicationContext(request);
		SysContentUtil sysUtil = (SysContentUtil)context.getBean("sysConstantInt");
		sysUtil.init();
	}
	   /**
	    * SQL注入效验
	    * @param SqlParam
	    * @return
	    * @throws Exception
	    */
    protected static boolean sqlValidate(String SqlParam)throws Exception {
    	SqlParam = SqlParam.toLowerCase();//统一转为小写
        String badStr = "'|and|exec|execute|insert|select|delete|update|count|drop|*|%|chr|mid|master|truncate|" +
                "char|declare|sitename|net user|xp_cmdshell|;|or|-|+|,|like'|and|exec|execute|insert|create|drop|" +
                "table|from|grant|use|group_concat|column_name|" +
                "information_schema.columns|table_schema|union|where|select|delete|update|order|by|count|*|" +
                "chr|mid|master|truncate|char|declare|or|;|-|--|+|,|like|//|/|%|#";//过滤掉的sql关键字，可以手动添加
        String[] badStrs = badStr.split("\\|");
        for (int i = 0; i < badStrs.length; i++) {
            if (SqlParam.indexOf(badStrs[i]) >= 0) {
            	return true;
            }
        }
        return false;
    }
    /**
     * SQL非法字符过滤
     * @param SqlParam
     * @return
     * @throws Exception
     */
    protected static String sqlFilter(String SqlParam)throws Exception{
       	if(!sqlValidate(SqlParam))return SqlParam;
    	else
    	throw new Exception("Illegal parameter,SQL injection risk");
    }
    /**
     * SQL非法字符过滤
     * @param SqlParam
     * @return
     * @throws Exception
     */
    protected static Boolean sqlInjectionCheck(String...SqlParam)throws Exception{
    	if(SqlParam.length==1){
    		if(!sqlValidate(SqlParam[0]))return true;
    		else{ throw new Exception("Illegal parameter,SQL injection risk");}
    	}else{
    		for(String str:SqlParam){
    			if(!sqlValidate(str))continue;
        		else{ throw new Exception("Illegal parameter,SQL injection risk");}
    		}
    	}
    	return true;
    	
    }
    /**
     * 参数空值校验
     * @param params
     * @return
     */
    protected static boolean NaNull(Object param){
    	if(param==null || param.equals("")|| param.equals("null")|| param.equals("undefined"))
    	return false;
    	else return true;
    }
    protected static String NullValueFilter(Object param) {
		return NaNull(param)?param.toString():"";
		
	}
    public static void main(String[] args) throws Exception {
    	logger.info(BaseAction.decodeCN("%25E6%2588%2591"));
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
	public static JSON addTotalProperty(JSON json,String TotalProperty)throws Exception{
		JSONObject retJSON=new JSONObject();
		retJSON.put("totalProperty", TotalProperty);
		retJSON.put("root", json);
		return retJSON;
	}
	public static JSON addTotalProperty(JSON json,Integer TotalProperty)throws Exception{
		JSONObject retJSON=new JSONObject();
		retJSON.put("totalProperty", TotalProperty);
		retJSON.put("root", json);
		return retJSON;
		
	}

}
