package com.asiainfo.aiga.userCase.web;

import java.net.URLDecoder;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.asiainfo.aiga.common.BaseAction;
import com.asiainfo.aiga.userCase.bo.AigaCase;
import com.asiainfo.aiga.userCase.service.IAigaCaseWorkflowSV;

@Controller
public class AigaCaseWorkflowAction extends BaseAction{

	@Resource(name="caseWorkflowSV")
	private IAigaCaseWorkflowSV aigaCaseWorkflowSV;
	
	@RequestMapping(value = "/getCaseForManual.do")
	public void getCaseForManual(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		try{
			String funName = URLDecoder.decode(request.getParameter("funName"),"UTF-8");
			String applicateSys = URLDecoder.decode(request.getParameter("applicateSys"),"UTF-8");
			String important = URLDecoder.decode(request.getParameter("important"),"UTF-8");
			String caseName = URLDecoder.decode(request.getParameter("caseName"),"UTF-8");
			Integer start = Integer.valueOf(request.getParameter("start"));
			Integer limit = Integer.valueOf(request.getParameter("limit"));
			AigaCase[] aigaCases = aigaCaseWorkflowSV.getAigaInstCases(funName, applicateSys, important, caseName, start, limit);
			this.setTable(aigaCases);
			this.setPostInfo("total", aigaCaseWorkflowSV.getAigaInstCasesCount(funName, applicateSys, important, caseName));
			this.setPostInfo("success", true);
		}catch(Exception e){
			e.printStackTrace();
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getMessage());
		}finally{
			this.postInfo(request, response);
		}
	}
}
