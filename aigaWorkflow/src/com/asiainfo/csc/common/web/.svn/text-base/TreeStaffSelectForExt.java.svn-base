package com.asiainfo.csc.common.web;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.web.action.BaseAction;
import com.asiainfo.csc.common.ivalues.IBOStaffTableValue;
import com.asiainfo.csc.common.service.impl.StaffSelectTree;
import com.asiainfo.csc.common.service.interfaces.IStaffTableSV;
import com.asiainfo.csc.common.vo.StaffTable;

public class TreeStaffSelectForExt extends BaseAction {
	
	public void getStaffTree(HttpServletRequest request,HttpServletResponse response)throws Exception{
		StaffSelectTree staffSelectTree = new StaffSelectTree();
		JSONObject jsonObject = staffSelectTree.getTree(request);
		JSONObject jsonTree = new JSONObject();
		jsonTree.put("data", jsonObject);
		response.setContentType("application/Json;charset=UTF-8");
		System.out.println(jsonTree.toString());
		response.getWriter().write(URLEncoder.encode(jsonTree.toString(),"UTF-8"));
	}
	
	public void queryStaffsByIds(HttpServletRequest request,HttpServletResponse response)throws Exception{
		String staffIds = request.getParameter("staffIds");
		String roleCode = request.getParameter("roleCode");
		
		IStaffTableSV iStaffTableSV = (IStaffTableSV)ServiceFactory.getService(IStaffTableSV.class);
		IBOStaffTableValue[] iboStaffTableValues = iStaffTableSV.queryStaffsByIds(staffIds, roleCode);
		List<StaffTable> staffTables = new ArrayList<StaffTable>();
		for(IBOStaffTableValue iboStaffTableValue : iboStaffTableValues){
			StaffTable staffTable = new StaffTable();
			staffTable.setBillId(iboStaffTableValue.getBillId());
			staffTable.setEmployeeName(iboStaffTableValue.getEmployeeName());
			staffTable.setOrganizeId(iboStaffTableValue.getOrganizeId());
			staffTable.setOrganizeName(iboStaffTableValue.getOrganizeName());
			staffTable.setOrgCode(iboStaffTableValue.getOrgCode());
			staffTable.setParentOrganizeId(iboStaffTableValue.getParentOrganizeId());
			staffTable.setRoleCode(iboStaffTableValue.getRoleCode());
			staffTable.setStaffCode(iboStaffTableValue.getStaffCode());
			staffTable.setStaffId(iboStaffTableValue.getStaffId());
			
			staffTables.add(staffTable);
		}
		JSONArray object = JSONArray.fromArray(staffTables.toArray());
		response.setContentType("application/Json;charset=UTF-8");
		System.out.println(object.toString());
		response.getWriter().write(URLEncoder.encode(object.toString(),"UTF-8"));
	}
	
	public void queryStaffsByName(HttpServletRequest request,HttpServletResponse response)throws Exception{
		String staffIds = request.getParameter("staffIds");
		String roleCode = request.getParameter("roleCode");
		
		String name = request.getParameter("name");
		
		IStaffTableSV iStaffTableSV = (IStaffTableSV)ServiceFactory.getService(IStaffTableSV.class);
		IBOStaffTableValue[] iboStaffTableValues = iStaffTableSV.queryStaffsByName(staffIds, roleCode, name);
		List<StaffTable> staffTables = new ArrayList<StaffTable>();
		for(IBOStaffTableValue iboStaffTableValue : iboStaffTableValues){
			StaffTable staffTable = new StaffTable();
			staffTable.setBillId(iboStaffTableValue.getBillId());
			staffTable.setEmployeeName(iboStaffTableValue.getEmployeeName());
			staffTable.setOrganizeId(iboStaffTableValue.getOrganizeId());
			staffTable.setOrganizeName(iboStaffTableValue.getOrganizeName());
			staffTable.setOrgCode(iboStaffTableValue.getOrgCode());
			staffTable.setParentOrganizeId(iboStaffTableValue.getParentOrganizeId());
			staffTable.setRoleCode(iboStaffTableValue.getRoleCode());
			staffTable.setStaffCode(iboStaffTableValue.getStaffCode());
			staffTable.setStaffId(iboStaffTableValue.getStaffId());
			
			staffTables.add(staffTable);
		}
		JSONArray object = JSONArray.fromArray(staffTables.toArray());
		response.setContentType("application/Json;charset=UTF-8");
		System.out.println(object.toString());
		response.getWriter().write(URLEncoder.encode(object.toString(),"UTF-8"));
	}
}
