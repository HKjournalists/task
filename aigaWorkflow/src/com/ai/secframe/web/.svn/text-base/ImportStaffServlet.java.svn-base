package com.ai.secframe.web;

import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.service.ServiceFactory;
import com.ai.secframe.bo.orgmodel.SysEmployeeBean;
import com.ai.secframe.bo.orgmodel.SysStaffBean;
import com.ai.secframe.bo.orgmodel.SysStaffOrgRelatBean;
import com.ai.secframe.bo.sysmgr.SysStaffRoleAuthorBean;
import com.ai.secframe.ivalues.orgmodel.ISysEmployeeValue;
import com.ai.secframe.ivalues.orgmodel.ISysOrganizeValue;
import com.ai.secframe.ivalues.orgmodel.ISysStaffOrgRelatValue;
import com.ai.secframe.ivalues.orgmodel.ISysStaffValue;
import com.ai.secframe.ivalues.sysmgr.ISysRoleValue;
import com.ai.secframe.ivalues.sysmgr.ISysStaffRoleAuthorValue;
import com.ai.secframe.service.orgmodel.interfaces.ISysEmployee;
import com.ai.secframe.service.orgmodel.interfaces.ISysOrganize;
import com.ai.secframe.service.orgmodel.interfaces.ISysStaff;
import com.ai.secframe.service.orgmodel.interfaces.ISysStaffOrgRelat;
import com.ai.secframe.service.sysmgr.interfaces.ISysRole;
import com.ai.secframe.service.sysmgr.interfaces.ISysStaffRoleAuthor;

public class ImportStaffServlet extends HttpServlet {
	
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
		cell.setCellValue("用户名");
		cell = headRow.createCell(1);
		cell.setCellStyle(headStyle);
		cell.setCellValue("工号");
		cell = headRow.createCell(2);
		cell.setCellStyle(headStyle);
		cell.setCellValue("角色");
		cell = headRow.createCell(3);
		cell.setCellStyle(headStyle);
		cell.setCellValue("组织");
		for(int i = 0; i < 4; i++) {
			sheet.autoSizeColumn(i);
		}
		
		response.setCharacterEncoding("UTF-8");
		response.addHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode("员工批量导入模板.xlsx","UTF-8"));
		OutputStream os = new BufferedOutputStream(response.getOutputStream());
		workBook.write(os);
		os.flush();
		os.close();
	}
	
	public void dealStaffExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		String callBackMsg = "未找到工作簿";
		if(isMultipart) {
			FileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			try {
				List<FileItem> items = upload.parseRequest(request);
				for(FileItem item : items) {
					if(!item.isFormField()) {
//						String name = item.getName();
//						获取上传文件
						XSSFWorkbook workbook = new XSSFWorkbook(item.getInputStream());
						XSSFSheet sheet = workbook.getSheetAt(0);
						if(sheet != null) {
							int j = 0;
							List<String[]> allData = new ArrayList<String[]>();
							for(Iterator<Row> i = sheet.rowIterator(); i.hasNext(); j++) {
								XSSFRow row = (XSSFRow)i.next();
								if(row == null || j == 0) {
									continue;
								}
								String[] cellVals = new String[4];
								for(int k = 0; k < 4; k++) {
									XSSFCell cell = row.getCell(k);
									cellVals[k] = getCellValue(cell);
								}
								allData.add(cellVals);
							}
//							获取组织对应的id
							Map<String, Long> orgMap = getOrgMap(allData);
							ISysStaff staffSv = (ISysStaff)ServiceFactory.getService("com.ai.secframe.service.orgmodel.SysStaff");
					        ISysEmployee employeeSv = (ISysEmployee)ServiceFactory.getService("com.ai.secframe.service.orgmodel.SysEmployee");
					        ISysStaffOrgRelat relatSv = (ISysStaffOrgRelat)ServiceFactory.getService("com.ai.secframe.service.orgmodel.SysStaffOrgRelat");
//							判断是否code有重复
					        if(checkCode(allData)) {
//					        	条件满足，逐行导入
								for(String[] rowVal : allData) {
									ISysEmployeeValue sysEmployeevalue = new SysEmployeeBean();
									ISysStaffValue sysStaffvalue = new SysStaffBean();
								    ISysStaffOrgRelatValue sysRelatvalue = new SysStaffOrgRelatBean();
								    
								    sysEmployeevalue.setEmployeeName(rowVal[0]);
//								    sysEmployeevalue.setBillId(rowVal[4]);
//								    sysEmployeevalue.setEmail(rowVal[5]);
								    
								    sysStaffvalue.setCode(rowVal[1].toUpperCase());
								    sysStaffvalue.setPassword("Abc123");
								    sysStaffvalue.setRecentPassTimes(3);
								    sysStaffvalue.setMinPasswdLength(6);
								    sysStaffvalue.setAllowChangePassword("Y");
								    sysStaffvalue.setAcctEffectDate(dateTimeStrToTimestamp("2014-08-13 14:58:08"));
								    sysStaffvalue.setAcctExpireDate(dateTimeStrToTimestamp("2050-08-13 14:58:08"));
								    sysStaffvalue.setMultiLoginFlag("Y");
								    sysStaffvalue.setTryTimes(3);
								    sysStaffvalue.setLockFlag("N");
								    sysStaffvalue.setPasswdValidDays(5000);
								    sysStaffvalue.setPasswordValidDate(dateTimeStrToTimestamp("2014-08-13 14:58:08"));
								    sysStaffvalue.setChgPasswdAlarmDays(3);
								    sysStaffvalue.setState(1);
								    

								    sysRelatvalue.setOrganizeId(orgMap.get(rowVal[3]));
								    sysRelatvalue.setIsAdminStaff("N");
								    sysRelatvalue.setIsBaseOrg("Y");
								    sysRelatvalue.setState(1);
								    
								    employeeSv.saveSysEmployee(new ISysEmployeeValue[]{sysEmployeevalue});
								    
								    sysStaffvalue.setEmployeeId(sysEmployeevalue.getEmployeeId());
								    staffSv.saveSysStaff(new ISysStaffValue[]{sysStaffvalue});
								    
								    sysRelatvalue.setStaffId(sysStaffvalue.getStaffId());
								    relatSv.saveSysStaffOrgRelat(new ISysStaffOrgRelatValue[]{sysRelatvalue});
								    
								    String roles = rowVal[2];
								    String[] roleAry = roles.split(",");
								    ISysStaffRoleAuthorValue[] sysAuthorRoleValues = new SysStaffRoleAuthorBean[roleAry.length];
								    for(int n = 0; n < sysAuthorRoleValues.length; ++n) {
								    	sysAuthorRoleValues[n] = new SysStaffRoleAuthorBean();
								        sysAuthorRoleValues[n].setStaffId(sysStaffvalue.getStaffId());
								        sysAuthorRoleValues[n].setCreateDate(ServiceManager.getOpDateTime());
								        sysAuthorRoleValues[n].setDoneDate(ServiceManager.getOpDateTime());
								        sysAuthorRoleValues[n].setOpId(ServiceManager.getUser().getID());
								        sysAuthorRoleValues[n].setOrganizeId(orgMap.get(rowVal[3]));
								        sysAuthorRoleValues[n].setState(1);
								        sysAuthorRoleValues[n].setAuthorValidDate(dateTimeStrToTimestamp("2014-08-13 14:58:08"));
								        sysAuthorRoleValues[n].setAuthorExpireDate(dateTimeStrToTimestamp("2050-08-01 14:58:10"));
								        sysAuthorRoleValues[n].setValidDate(dateTimeStrToTimestamp("2014-08-13 14:58:08"));
								        sysAuthorRoleValues[n].setExpireDate(dateTimeStrToTimestamp("2050-08-01 14:58:10"));
								        sysAuthorRoleValues[n].setRoleId(getRoleIdByName(roleAry[n]));
								    }
								    ISysStaffRoleAuthor service = (ISysStaffRoleAuthor)ServiceFactory.getService("com.ai.secframe.service.sysmgr.SysStaffRoleAuthor", ISysStaffRoleAuthor.class);
								    service.saveSysStaffRoleAuthor(sysAuthorRoleValues);
								}
							}
						}
					}
					callBackMsg = "导入成功";
				}
			} catch(Exception e) {
				e.printStackTrace();
				callBackMsg = "出现错误：" + e.getMessage();
				throw new Exception(e.getMessage());
			} finally {
				response.setContentType("text/html; charset=GBK");
				response.getWriter();
				PrintWriter writer = response.getWriter();
				String outJs = "<script type=\"text/javascript\">window.parent.dealCallback('" + 
					callBackMsg + "')</script>'";
				writer.write(outJs);
				writer.close();
			}
		}
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String method = request.getParameter("method");
			if(method.equalsIgnoreCase("getExcelDemo")) {
				getExcelDemo(request, response);
			} else if(method.equalsIgnoreCase("dealStaffExcel")) {
				dealStaffExcel(request, response);
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
		ISysOrganize orgSV = (ISysOrganize)ServiceFactory.getService("com.ai.secframe.service.orgmodel.SysOrganize");
		for(String[] rowVal : allData) {
			String orgName = rowVal[3];
			String condition = "organize_name='" + orgName + "'";
			ISysOrganizeValue[] curSysOrg = orgSV.getSysOrganize(condition, null);
			if(curSysOrg == null || curSysOrg.length == 0 || curSysOrg[0] == null) {
				throw new Exception("未找到组织【" + orgName + "】");
			} else {
				retMap.put(orgName, curSysOrg[0].getOrganizeId());
			}
		}
		return retMap;
	}
	
	private long getRoleIdByName(String roleName) throws Exception {
		ISysRole service = (ISysRole)ServiceFactory.getService("com.ai.secframe.service.sysmgr.SysRole", ISysRole.class);
		String condition = "name='" + roleName + "' and state=1";
		ISysRoleValue[] roles = service.querySysRole(null, condition, null, -1, -1, false, null);
		if(roles == null || roles.length == 0 || roles[0] == null) {
			throw new Exception("未找到对应角色【" + roleName + "】");
		}
		if(roles.length > 1) {
			throw new Exception("对应角色[" + roleName + "]有"+ roles.length + "个");
		}
		return roles[0].getRoleId();
	}
	
	private boolean checkCode(List<String[]> allData) throws Exception {
		boolean retVal = true;
		ISysStaff staffSv = (ISysStaff)ServiceFactory.getService("com.ai.secframe.service.orgmodel.SysStaff");
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
			String code = rowVal[1].toUpperCase();
			if(checkMap.get(code) == null) {
				checkMap.put(code, 1);
			} else {
				retVal = false;
				throw new Exception("excel中工号【" + code + "】有重复或与原表中数据重复");
			}
		}
		
		return retVal;
	}
	
	private Timestamp dateTimeStrToTimestamp(String date) throws ParseException {
		return Timestamp.valueOf(date);
	}

}
