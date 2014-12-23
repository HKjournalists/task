package com.asiainfo.aiga.staff.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.asiainfo.aiga.common.BaseAction;
import com.asiainfo.aiga.common.helper.ActionHelper;
import com.asiainfo.aiga.common.security.user.service.IUserSV;
import com.asiainfo.aiga.staff.bo.StaffRoleView;
@Controller
public class SelectStaffAction extends BaseAction {
	
	@Resource(name="userSV")
	private IUserSV userSV;
	
	@RequestMapping(value="/getStaffRoleViews.do")
	public void getStaffRoleViews(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String staffId=request.getParameter("staffId");
		String roleCode=request.getParameter("roleCode");
		Map<String, Object> map=new HashMap<String, Object>();
		boolean success=false;
		try{
			StaffRoleView[] staffRoleViews=userSV.getStaffRoleViewByGroupLeader(staffId, roleCode);
			success=true;
			map.put("data", staffRoleViews);
		}catch (Exception e) {
		}finally{
			map.put("success", success);
			ActionHelper.returnResponseJsonMap(request, response, map);
		}
	}
	@RequestMapping(value="/getStaffRoleViewsByOrganizeId.do")
	public void getStaffRoleViewsByOrganizeId(HttpServletRequest request, HttpServletResponse response) throws Exception {
/*		String organizeId=request.getParameter("organizeId");
		String roleCode=request.getParameter("roleCode");
		Map<String, Object> map=new HashMap<String, Object>();
		boolean success=false;
		try{
			StaffRoleView[] staffRoleViews=userSV.getStaffRoleViewByGroupLeader(staffId, roleCode);
			success=true;
			map.put("data", staffRoleViews);
		}catch (Exception e) {
		}finally{
			map.put("success", success);
			ActionHelper.returnResponseJsonMap(request, response, map);
		}*/
	}
	@RequestMapping(value="/getStaffGiveViews.do")
	public void getStaffGiveViews(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String roleCode=request.getParameter("roleCode");
		Map<String, Object> map=new HashMap<String, Object>();
		boolean success=false;
		try{
			StaffRoleView[] staffRoleViews=userSV.getStaffRoleViewByGroupLeader(roleCode);
			success=true;
			map.put("data", staffRoleViews);
		}catch (Exception e) {
		}finally{
			map.put("success", success);
			ActionHelper.returnResponseJsonMap(request, response, map);
		}
	}
}
