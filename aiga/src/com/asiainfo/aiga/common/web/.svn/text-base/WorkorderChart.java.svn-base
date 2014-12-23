package com.asiainfo.aiga.common.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.asiainfo.aiga.common.BaseAction;
import com.asiainfo.aiga.common.security.user.bo.AigaUser;
import com.asiainfo.aiga.common.service.IWorkorderChartSV;
import com.asiainfo.aiga.common.service.impl.WorkorderChartSVImpl;

@Controller
public class WorkorderChart extends BaseAction{
	
	@Resource(name="workorderChartSV")
	private IWorkorderChartSV chartSV;
	@RequestMapping("/getChartData.do")
	public void getChartData(HttpServletRequest request,HttpServletResponse response) throws Exception {
		try{
			AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
			String json = chartSV.getChartDataJson(user.getUserAccount());
			this.setPostInfo("data", json);
			this.setPostInfo("success", true);
		}catch(Exception e){
			this.setPostInfo("success", false);
		}finally{
			this.postInfo(request, response);
		}
	}
}
