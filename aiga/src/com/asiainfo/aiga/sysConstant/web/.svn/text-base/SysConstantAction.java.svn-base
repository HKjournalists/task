package com.asiainfo.aiga.sysConstant.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.asiainfo.aiga.common.BaseAction;
import com.asiainfo.aiga.common.helper.ActionHelper;
import com.asiainfo.aiga.sysConstant.bo.SysConstant;
import com.asiainfo.aiga.sysConstant.util.SysContentUtil;

@Controller
public class SysConstantAction extends BaseAction {
	
	@RequestMapping(value="/getSysParam.do")
	public void getSysParam(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String category = request.getParameter("category");
		SysConstant[] result = SysContentUtil.getSysContant(category);
		Map map=new HashMap();
		map.put("data", result);
		map.put("success", true);
		ActionHelper.returnResponseJsonMap(request, response, map);
	}
	
	@RequestMapping(value="/getQryAndOther2.do")
	public void getQryAndOther2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String query = request.getParameter("query");
		String other2 = request.getParameter("other2");
		if(other2 == null) {
			other2 = "kkk";
		}
		SysConstant[] sysConstants = SysContentUtil.getSysContant("AIGA_TEST_PLAN");
		List<SysConstant> sysQuery = new ArrayList<SysConstant>();
		List<SysConstant> result = new ArrayList<SysConstant>();
		for(SysConstant sysConstant : sysConstants) {
			if(sysConstant.getCategoryName().equalsIgnoreCase(query)) {
				sysQuery.add(sysConstant);
			}
		}
		for(SysConstant constant : sysQuery) {
			if(constant.getOther2() != null && constant.getOther2().equalsIgnoreCase(other2)) {
				result.add(constant);
			}
		}
		this.setTable(result.toArray(new SysConstant[0]));
		this.postInfo(request, response);
	}

}
