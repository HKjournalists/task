package com.asiainfo.aiga.testTask.web;

import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.asiainfo.aiga.common.BaseAction;
import com.asiainfo.aiga.common.xls.XlsDto;
import com.asiainfo.aiga.common.xls.XlsHelper;
@Controller
public class TestTaskAction  extends BaseAction  {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void getExcelDemo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		XSSFWorkbook workBook = new XSSFWorkbook();
		XSSFSheet sheet = workBook.createSheet("模板");
		XSSFRow headRow = sheet.createRow(0);
		XSSFCellStyle headStyle = workBook.createCellStyle();
		XSSFFont headFont = workBook.createFont();
		headFont.setFontHeightInPoints((short)12);
		headFont.setFontName("微软雅黑");
		headFont.setBoldweight(XSSFFont.BOLDWEIGHT_NORMAL);
		headStyle.setFont(headFont);
		headStyle.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		headStyle.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		headStyle.setBorderTop(XSSFCellStyle.BORDER_THICK);
		headStyle.setBorderTop(XSSFCellStyle.BORDER_DOUBLE);
		headStyle.setBorderLeft(XSSFCellStyle.BORDER_MEDIUM);
		headStyle.setBorderRight(XSSFCellStyle.BORDER_MEDIUM);
		headStyle.setBorderBottom(XSSFCellStyle.BORDER_DOUBLE);
		
		XSSFCell cell = headRow.createCell(0);
		cell.setCellStyle(headStyle);
		cell.setCellValue("组织名称");
		cell = headRow.createCell(1);
		cell.setCellStyle(headStyle);
		cell.setCellValue("工号");
		cell = headRow.createCell(2);
		cell.setCellStyle(headStyle);
		cell.setCellValue("密码");
		cell = headRow.createCell(3);
		cell.setCellStyle(headStyle);
		cell.setCellValue("名称");
		cell = headRow.createCell(4);
		cell.setCellStyle(headStyle);
		cell.setCellValue("手机");
		cell = headRow.createCell(5);
		cell.setCellStyle(headStyle);
		cell.setCellValue("邮箱");
		cell = headRow.createCell(6);
		cell.setCellStyle(headStyle);
		cell.setCellValue("生效日期");
		cell = headRow.createCell(7);
		cell.setCellStyle(headStyle);
		cell.setCellValue("失效日期");
		cell = headRow.createCell(8);
		cell.setCellStyle(headStyle);
		cell.setCellValue("角色说明（本列无效，作说明使用）");
		for(int i = 0; i < 9; i++) {
			sheet.autoSizeColumn(i);
		}
		
		response.setCharacterEncoding("UTF-8");
		response.addHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode("员工批量导入模板.xlsx","UTF-8"));
		OutputStream os = new BufferedOutputStream(response.getOutputStream());
		workBook.write(os);
		os.flush();
		os.close();
		
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String method = request.getParameter("method");
			if(method.equalsIgnoreCase("getExcelDemo")) {
				getExcelDemo(request, response);
			} else if(method.equalsIgnoreCase("dealStaffExcel")) {
//				dealStaffExcel(request, response);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	
	private String getCellValue(Cell cell) {  
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
	            result = cell.getCellFormula();
	            break;
	        case Cell.CELL_TYPE_ERROR:
	            result = cell.getErrorCellValue();
	            break;
	        case Cell.CELL_TYPE_BOOLEAN:
	            result = cell.getBooleanCellValue();
	            break;
	        default:
	            result = "NULL";
	            break;
	    }
	    return result.toString();
	}
	
	private Map<String, Long> getOrgMap(List<String[]> allData) throws Exception {
		Map<String, Long> retMap = new HashMap<String, Long>();
//		ISysOrganize orgSV = (ISysOrganize)ServiceFactory.getService("com.ai.secframe.service.orgmodel.SysOrganize");
/*		for(String[] rowVal : allData) {
			String orgName = rowVal[0];
			String condition = "organize_name='" + orgName + "'";
//			ISysOrganizeValue[] curSysOrg = orgSV.getSysOrganize(condition, null);
			if(curSysOrg == null || curSysOrg.length == 0 || curSysOrg[0] == null) {
				throw new Exception("未找到组织【" + orgName + "】");
			} else {
				retMap.put(orgName, curSysOrg[0].getOrganizeId());
			}
		}*/
		return retMap;
	}
	
	private boolean checkCode(List<String[]> allData) throws Exception {
		boolean retVal = true;
/*		ISysStaff staffSv = (ISysStaff)ServiceFactory.getService("com.ai.secframe.service.orgmodel.SysStaff");
		String condition = "1=1";
		ISysStaffValue[] allStaff = staffSv.querySysStaffs(condition, null);
		Map<String, Integer> checkMap = new HashMap<String, Integer>();
		for(ISysStaffValue staff : allStaff) {
			String code = staff.getCode();
			if(checkMap.get(code) == null) {
				checkMap.put(code, 1);
			}
		}
		for(String[] rowVal : allData) {
			String code = rowVal[1];
			if(checkMap.get(code) == null) {
				checkMap.put(code, 1);
			} else {
				retVal = false;
				throw new Exception("excel中工号【" + code + "】有重复或与原表中数据重复");
			}
		}*/
		
		return retVal;
	}
	
	private Timestamp dateTimeStrToTimestamp(String date) throws ParseException {
		return Timestamp.valueOf(date);
	}

}
