package com.asiainfo.aiga.common.xls;

import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jxls.transformer.XLSTransformer;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.asiainfo.aiga.common.helper.CommonHelper;
import com.asiainfo.aiga.search.dao.BaseDAO;
import com.asiainfo.lucene.LuceneEntities.LuceneManager.LuceneIndexContants.BYTE;
import com.asiainfo.lucene.LuceneEntities.LuceneManager.LuceneIndexContants.DATE;
import com.asiainfo.lucene.LuceneEntities.LuceneManager.LuceneIndexContants.FieldType;
import com.asiainfo.lucene.LuceneEntities.properties.LuceneCommon;

public class XlsHelper {
	private static Logger logger = Logger.getLogger(XlsHelper.class);
	public static Object[] transXlsToObjs(InputStream is, Map[] fieldsToCells,Class[] clazzs) throws Exception {
		HSSFWorkbook hssfWorkbook = new HSSFWorkbook(is);
		List[] resultObjects = new ArrayList[clazzs.length];
		if (fieldsToCells.length != clazzs.length)
			throw new Exception("map 和类型没有对应");
		Map[] fieldTypeMaps = new HashMap[clazzs.length];
		// excel 列号 和 excelBean 对应
		Map fieldIndex = new HashMap();

		for (int clasIndex = 0; clasIndex < clazzs.length; clasIndex++) {
			resultObjects[clasIndex] = new ArrayList();
			Map map = new HashMap();
			Class clazz = clazzs[clasIndex];
			for (Class<?> _clazz = clazz; _clazz != Object.class; _clazz = _clazz
					.getSuperclass())
				for (Field field : _clazz.getDeclaredFields()) {
					map.put(field.getName(), field);
				}
			fieldTypeMaps[clasIndex] = map;
		}
		/**
		 * 获取第一列 列名
		 */
		HSSFSheet firstSheet = hssfWorkbook.getSheetAt(0);
		HSSFRow firstRow = firstSheet.getRow(0);


		for (int i = 0, n = firstRow.getPhysicalNumberOfCells(); i < n; i++) {
			HSSFCell firstRowCell = firstRow.getCell(i);
			// 暂时存储第一列
			for (int ii = 0, nn = fieldsToCells.length; ii < nn; ii++) {
				// 获取到第几个map
				String cellName=(String) firstRowCell.getStringCellValue();
				// ff为属性 名称
				String ff = (String) fieldsToCells[ii].get(cellName);
				CommonHelper.mapRemove(fieldsToCells[ii], cellName);
				if (ff == null || ff.equals(""))
					continue;
				ExcelBean eb = new ExcelBean();
				Map fieldMap = (Map) fieldTypeMaps[ii];
				Field field = (Field) fieldMap.get(ff);
				if (field != null) {
					eb.setClassField(field);
					eb.setClassIndex(ii);
					eb.setCellColumnName((String) firstRowCell.getStringCellValue());
				} else {
					System.out.println("未找到 属性" + ff);
					continue;
				}

				fieldIndex.put(i, eb);
			}

		}
		String missCells="";
		for (int ii = 0, nn = fieldsToCells.length; ii < nn; ii++) {
			if(fieldsToCells[ii].size()>0){
				  Iterator<Map.Entry<String, String>> it = fieldsToCells[ii].entrySet().iterator();  
			        while(it.hasNext()){  
			            Map.Entry<String, String> entry=it.next();  
			            String key=entry.getKey();  
			            missCells+=key+"  ";
			        }  
			}
		}
		if(missCells.length()>0)throw new Exception("excel表格中少了【"+missCells+"】列");
		Connection conn=null;
		Statement stat =null;
		ResultSet rs =null;
		try{
			conn = BaseDAO.getBaseDaoInstance().getConnection();
			stat= conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
			rs = null;
		// 循环工作表Sheet
		for (int numSheet = 0; numSheet < hssfWorkbook.getNumberOfSheets(); numSheet++) {
			HSSFSheet hssfSheet = hssfWorkbook.getSheetAt(numSheet);

			if (hssfSheet == null) {
				continue;
			}
			// 循环行Row
			for (int rowNum = 1; rowNum <= hssfSheet.getLastRowNum(); rowNum++) {
				HSSFRow hssfRow = hssfSheet.getRow(rowNum);
				if (hssfRow == null) {
					break;
				}
				//判断是否为空行
				String rowString="";
				for (int cellNum = 0; cellNum <= hssfRow.getPhysicalNumberOfCells(); cellNum++) {
					HSSFCell currentCell = hssfRow.getCell(cellNum);
					if(currentCell==null)continue;
					String cellString=getCellValue(currentCell);
					if(cellString!=null&&!cellString.toLowerCase().equals("null")&&!cellString.toLowerCase().equals("")){
						rowString+=cellString.toString();
						break;
					}
				}
				if(rowString.equals("")){
					break;
				}
				Object[] objs = new Object[clazzs.length];
				for (int clasIndex = 0; clasIndex < clazzs.length; clasIndex++) {

					Class clazz = clazzs[clasIndex];
					objs[clasIndex] = clazz.newInstance();
				}
				for (int cellNum = 0; cellNum <= hssfRow.getPhysicalNumberOfCells()+1; cellNum++) {
					HSSFCell currentCell = hssfRow.getCell(cellNum);
					ExcelBean eb = (ExcelBean) fieldIndex.get(cellNum);
					if (eb == null)continue;
					Field field = eb.getClassField();
					String name = field.getName();
					if (name == null || name.equals("null"))
						continue;
					String type = field.getGenericType().toString();
					String shortTypeName = (type.lastIndexOf(".") > -1 ? type
							.substring(type.lastIndexOf(".") + 1) : type)
							.toUpperCase();
					String setterMethodName = "set"
							+ name.substring(0, 1).toUpperCase()
							+ name.substring(1);
					String getValue = "";
					try {
						getValue = getCellValue(currentCell);
					} catch (Exception e) {
						e.getStackTrace();
					}

					Object transValue = new Object();
					try {
						if (name.startsWith("is")&& Integer.class.getName().toUpperCase().endsWith(shortTypeName)) {
							if (getValue.trim().equals("false"))
								getValue = "0";
							else if (getValue.trim().equals("true"))
								getValue = "1";
							else if (getValue.trim().equals("on"))
								getValue = "1";
							else if (getValue.trim().equals("是"))
								getValue = "1";
							else if (getValue.trim().equals("否"))
								getValue = "0";
							else
								throw new Exception("转换异常:excel文件第【"+(rowNum+1)+"】行,列名为:"+ eb.getCellColumnName()+".<br/>请注意,不要插入脏数据!");
						}
						transValue = transType(shortTypeName, getValue);
					} catch (Exception e) {
						if(e.getMessage().startsWith("转换异常:excel文件第【")){
							throw e;
						}
						e.getStackTrace();
						// 转义
						String escape_SQL = "";
						try {
								escape_SQL = "SELECT t.value as value FROM sys_constant t WHERE t.escape_field ='"
										+ objs[eb.getClassIndex()].getClass()
												.getSimpleName()
										+ "_"
										+ name
										+ "' AND (t.SHOW='"
										+ getValue
										+ "' OR t.escape_show='"
										+ getValue
										+ "') AND ROWNUM ='1' ";
								logger.info("常量表转换"+escape_SQL);
							rs = stat.executeQuery(escape_SQL);
							while (rs.next()) {
//								getValue = "0";
								getValue = rs.getString("value");
							}
						} catch (Exception e1) {
							logger.info("SQL语句为:[" + escape_SQL+ "]未查到数据或者数据有误！");
							
							logger.info("码表未配置"+ objs[eb.getClassIndex()].getClass().getSimpleName() + "_" + name+ "\n 值为" + getValue + "\n 已经默认为0");
//							getValue = "0";
						} finally {
						}
						try {
							transValue = transType(shortTypeName, getValue);
						} catch (Exception e2) {
							String errorMsg = "转换异常:excel文件第【"+(rowNum+1)+"】行,列名为:"+ eb.getCellColumnName()+ ",fieldValue:" + getValue + ",FieldType:" + shortTypeName + ",方法为:setterMethodName:" + setterMethodName+ "";
//							System.out.println(errorMsg);
							throw new Exception(errorMsg);
						}
					}
					Class[] parameterTypes = new Class[1];
					parameterTypes[0] = field.getType();
					Method method = clazzs[eb.getClassIndex()].getMethod(setterMethodName, parameterTypes);
					method.invoke(objs[eb.getClassIndex()], transValue);
				}
				for (int clasIndex = 0; clasIndex < clazzs.length; clasIndex++) {
					resultObjects[clasIndex].add(objs[clasIndex]);
				}
			}
		}
		}catch (Exception e) {
			throw e;
		}finally{
			BaseDAO.free(rs, stat, conn);
		}
		return resultObjects;

	}

	/**
	 * 得到Excel表中的值
	 * 
	 * @param hssfCell
	 *            Excel中的每一个格子
	 * @return Excel中每一个格子中的值
	 */
	@SuppressWarnings("static-access")
	private static String getValue(HSSFCell hssfCell) throws Exception {
		int typeCode=hssfCell.getCellType();
		String retValue="";
		switch (typeCode) {
		case HSSFCell.CELL_TYPE_BLANK :
			break;
		case HSSFCell.CELL_TYPE_BOOLEAN:
			retValue=String.valueOf(hssfCell.getBooleanCellValue());
			break;
		case HSSFCell.CELL_TYPE_NUMERIC:
			retValue=String.valueOf(hssfCell.getNumericCellValue());
			break;
		case HSSFCell.CELL_TYPE_FORMULA:
//			throw new Exception("包含公式");
			break;
		default:
			retValue=String.valueOf(hssfCell.getStringCellValue());
			break;
		}
		return retValue;
	}
	public static Object[] transFuncXlsToObjs(InputStream is, Map[] fieldsToCells,Class[] clazzs) throws Exception {
		HSSFWorkbook hssfWorkbook = new HSSFWorkbook(is);
		List[] resultObjects = new ArrayList[clazzs.length];
		if (fieldsToCells.length != clazzs.length)
			throw new Exception("map 和类型没有对应");
		Map[] fieldTypeMaps = new HashMap[clazzs.length];
		// excel 列号 和 excelBean 对应
		Map fieldIndex = new HashMap();

		for (int clasIndex = 0; clasIndex < clazzs.length; clasIndex++) {
			resultObjects[clasIndex] = new ArrayList();
			Map map = new HashMap();
			Class clazz = clazzs[clasIndex];
			for (Class<?> _clazz = clazz; _clazz != Object.class; _clazz = _clazz
					.getSuperclass())
				for (Field field : _clazz.getDeclaredFields()) {
					map.put(field.getName(), field);
				}
			fieldTypeMaps[clasIndex] = map;
		}
		/**
		 * 获取第一列 列名
		 */
		HSSFSheet firstSheet = hssfWorkbook.getSheetAt(0);
		HSSFRow firstRow = firstSheet.getRow(0);


		for (int i = 0, n = firstRow.getPhysicalNumberOfCells(); i < n; i++) {
			HSSFCell firstRowCell = firstRow.getCell(i);
			// 暂时存储第一列
			for (int ii = 0, nn = fieldsToCells.length; ii < nn; ii++) {
				// 获取到第几个map
				// ff为属性 名称
				String ff = (String) fieldsToCells[ii]
						.get((String) firstRowCell.getStringCellValue());
				if (ff == null || ff.equals(""))
					continue;
				ExcelBean eb = new ExcelBean();
				Map fieldMap = (Map) fieldTypeMaps[ii];
				Field field = (Field) fieldMap.get(ff);
				if (field != null) {
					eb.setClassField(field);
					eb.setClassIndex(ii);
					eb.setCellColumnName((String) firstRowCell.getStringCellValue());
				} else {
					System.out.println("未找到 属性" + ff);
					continue;
				}

				fieldIndex.put(i, eb);
			}

		}
		Connection conn=null;
		Statement stat =null;
		ResultSet rs =null;
		try{
			conn = BaseDAO.getBaseDaoInstance().getConnection();
			stat= conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
			rs = null;
		// 循环工作表Sheet
		for (int numSheet = 0; numSheet < hssfWorkbook.getNumberOfSheets(); numSheet++) {
			HSSFSheet hssfSheet = hssfWorkbook.getSheetAt(numSheet);

			if (hssfSheet == null) {
				continue;
			}
			// 循环行Row
			for (int rowNum = 1; rowNum <= hssfSheet.getLastRowNum(); rowNum++) {
				HSSFRow hssfRow = hssfSheet.getRow(rowNum);
				if (hssfRow == null) {
					continue;
				}
				Object[] objs = new Object[clazzs.length];
				for (int clasIndex = 0; clasIndex < clazzs.length; clasIndex++) {

					Class clazz = clazzs[clasIndex];
					objs[clasIndex] = clazz.newInstance();
				}
				for (int cellNum = 0; cellNum <= hssfRow
						.getPhysicalNumberOfCells()+1; cellNum++) {
					HSSFCell currentCell = hssfRow.getCell(cellNum);
					ExcelBean eb = (ExcelBean) fieldIndex.get(cellNum);
					if (eb == null)
						continue;
					Field field = eb.getClassField();
					String name = field.getName();
					if (name == null || name.equals("null"))
						continue;
					String type = field.getGenericType().toString();
					String shortTypeName = (type.lastIndexOf(".") > -1 ? type.substring(type.lastIndexOf(".") + 1) : type).toUpperCase();
					String setterMethodName = "set"+ name.substring(0, 1).toUpperCase()+ name.substring(1);
					String getValue = "";
					try {
						getValue = getCellValue(currentCell);
					} catch (Exception e) {
						e.getStackTrace();
					}

					Object transValue = new Object();
					try {
						if (name.startsWith("is")&& (Integer.class.getName().toUpperCase().endsWith(shortTypeName))) {
							if (getValue.equals("false"))
								getValue = "0";
							if (getValue.equals("true"))
								getValue = "1";
							if (getValue.equals("on"))
								getValue = "1";
							if (getValue.equals("是"))
								getValue = "1";
							if (getValue.equals("否"))
								getValue = "0";
						}
					transValue = transType(shortTypeName, getValue);
					} catch (Exception e) {
						e.getStackTrace();
						// 转义
						String escape_SQL = "";
						try {
								escape_SQL = "SELECT t.value as value FROM sys_constant t WHERE t.escape_field ='"
										+ objs[eb.getClassIndex()].getClass()
												.getSimpleName()
										+ "_"
										+ name
										+ "' AND (t.SHOW='"
										+ getValue
										+ "' OR t.escape_show='"
										+ getValue
										+ "') AND ROWNUM ='1' ";
							rs = stat.executeQuery(escape_SQL);
							while (rs.next()) {
								getValue = "0";
								getValue = rs.getString("value");
							}
						} catch (Exception e1) {
							System.out.println("SQL语句为:[" + escape_SQL+ "]未查到数据或者数据有误！");
							System.out.println("码表未配置"+ objs[eb.getClassIndex()].getClass().getSimpleName() + "_" + name+ "\n 值为" + getValue + "\n 已经默认为0");
							getValue = "0";
						} finally {
						}
						try {
							transValue = transType(shortTypeName, getValue);
						} catch (Exception e2) {
							//String errorMsg = "转换异常:【列名为:"+ eb.getCellColumnName()+ ",setterMethodName:" + setterMethodName+ ",FieldType:" + shortTypeName+ ",fieldValue:" + getValue + "】";
							String errorMsg = "转换异常:【列名为:"+ eb.getCellColumnName()+ "的数据存在异常】";
//							System.out.println(errorMsg);
							throw new Exception(errorMsg);
						}
					}
					Class[] parameterTypes = new Class[1];
					parameterTypes[0] = field.getType();
					Method method = clazzs[eb.getClassIndex()].getMethod(setterMethodName, parameterTypes);
					method.invoke(objs[eb.getClassIndex()], transValue);
				}
				for (int clasIndex = 0; clasIndex < clazzs.length; clasIndex++) {
					resultObjects[clasIndex].add(objs[clasIndex]);
				}
			}
		}
		}catch (Exception e) {
			throw e;
		}finally{
			BaseDAO.free(rs, stat, conn);
		}
		return resultObjects;

	}

	private static String getCellValue(Cell cell) throws Exception {  
	    Object result = null;
	    switch(cell.getCellType()) {
	        case Cell.CELL_TYPE_STRING:
	            result = cell.getStringCellValue();
	            break;
	        case Cell.CELL_TYPE_NUMERIC:
	            if(DateUtil.isCellInternalDateFormatted(cell)) {
	            	DateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	            	Date cellDate = cell.getDateCellValue();
	            	result = df.format(cellDate);
	            } else
	                result = (long)cell.getNumericCellValue();
	            break;
	        case Cell.CELL_TYPE_FORMULA:
	            result = "";
	            break;
	        case Cell.CELL_TYPE_ERROR:
	            result = cell.getErrorCellValue();
	            break;
	        case Cell.CELL_TYPE_BOOLEAN:
	            result = cell.getBooleanCellValue();
	            break;
	        case Cell.CELL_TYPE_BLANK:  
	        	result = "";
	        	break;
	        default:
	            result = "NULL";
	            break;
	    }
	    return result.toString();
	}

	private static Object transType(String shortTypeName, String value)
			throws Exception {
		Object transVal = null;
		switch (FieldType.toFieldType(shortTypeName)) {
		case STRING: {
			if (value == null || value.equals(""))
				return "";
			transVal = String.valueOf(value);
		}
			break;
		case INTEGER: {
			if (value == null || value.equals(""))
				return null;
			transVal = Integer.valueOf(value);
		}
			break;
		case DATE: {
			if (value == null || value.equals(""))
				return null;
			Date date = new SimpleDateFormat(DATE.FORMAT_TEMPLATE).parse(value);
			transVal = date;
		}
			break;
		case TIMESTAMP: {
			if (value == null || value.equals(""))
				return null;
			Timestamp timestamp = Timestamp.valueOf(value);
			transVal = timestamp;
		}
			break;
		case BOOLEAN: {
			if (value == null || value.equals(""))
				return null;
			transVal = Boolean.valueOf(value);
		}
			break;
		case BYTE: {
			if (value == null || value.equals(""))
				return null;
			transVal = value.getBytes(BYTE.BYTE_ENCODING);
		}
			break;
		case SHORT: {
			if (value == null || value.equals(""))
				return null;
			transVal = Short.valueOf(value);
		}
			break;
		case INT: {
			if (value == null || value.equals(""))
				return null;
			transVal = Integer.valueOf(value).intValue();
		}
			break;
		case LONG: {
			if (value == null || value.equals(""))
				return null;
			transVal = Long.valueOf(value);
		}
			break;
		case FLOAT: {
			if (value == null || value.equals(""))
				return null;
			transVal = Float.valueOf(value);
		}
			break;
		case DOUBLE: {
			if (value == null || value.equals(""))
				return null;
			transVal = Double.valueOf(value);
		}
			break;
		case CHAR: {
			if (value == null || value.equals(""))
				return null;
			transVal = value.toCharArray();
		}
			break;
		}
		return transVal;
	}

	/**
	 * @desc:导出Excel文本
	 * @author: wenghy
	 * @param request
	 * @param response
	 * @throws BusiException
	 * @throws SysException
	 * @throws UnifyInvokeException
	 * @throws UnsupportedEncodingException
	 * @date : 2014-3-28
	 */
	public static void export2Excel(HttpServletRequest request,
			HttpServletResponse response, ExcelVO excelVo) throws Exception,
			UnsupportedEncodingException {
		// 给导出的excel命名
		String exportExcelName = null;
		InputStream templateExcelIS = null;
		exportExcelName = excelVo.getExportExcelName();
		// excel模板位置,获取输入流,getResourceAsStream从classpath根目录下开始
		String path = LuceneCommon.getProertiesValue("excel.exportPath",
				"excel.properties");
		templateExcelIS = new FileInputStream(path + "/"
				+ excelVo.getTemplateName());
		try {
			// 告诉浏览器使用什么格式编译文件
			response.setContentType("application/octet-stream;charset=utf-8");
			// 在浏览器中弹出窗口，给文件名编码，防止中文乱码，火狐和非火狐浏览器其区别对待
			if (request.getHeader("USER-AGENT").toLowerCase()
					.indexOf("firefox") != -1) {
				// 如果是火狐浏览器则使用下面的方式对excel文件名编码
				response.setHeader("Content-Disposition","attachment;filename="+ new String(exportExcelName.getBytes("GB2312"),"ISO-8859-1"));
			} else {
				// 非火狐浏览器使用下面的方式
				response.setHeader("Content-Disposition","attachment;filename="+ java.net.URLEncoder.encode(exportExcelName,"utf-8"));
			}
			// 客户端不缓存
			// addHeader是增加头文件里没有的属性
			response.addHeader("Pragma", "no-cache");
			response.addHeader("Cache-Control", "no-cache");
			OutputStream os = response.getOutputStream();
			XLSTransformer transformer = new XLSTransformer();
			XSSFWorkbook workbook = (XSSFWorkbook) transformer.transformXLS(
					templateExcelIS, excelVo.getDataMap());
			// 写入到输出流中
			workbook.write(os);
			os.flush();
			os.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
