package com.asiainfo.aiga.caseLabelRela.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.asiainfo.aiga.caseLabelRela.service.IAigaCaseLabelRelaSV;
import com.asiainfo.aiga.common.BaseAction;

@Controller
@Scope(value="prototype")
public class AigaCaseLabelRelaAction extends BaseAction {

	@Resource(name="aigaCaseLabelRelaSV")
	private IAigaCaseLabelRelaSV caseLabelRelaSV;
	
	@RequestMapping("/saveCaseLabelRela.do")
	public void saveCaseLabelRela(HttpServletRequest request, HttpServletResponse response)throws Exception{
		String caseIds = request.getParameter("caseIds");
		String labelId = request.getParameter("labelId");
		caseLabelRelaSV.saveAigaCaseLabelRelaByCaseIds(labelId,caseIds);
	}
	
	@RequestMapping("/deleteCaseLabelRela.do")
	public void deleteCaseLabelRela(HttpServletRequest request,HttpServletResponse response)throws Exception{
		
		String caseIds = request.getParameter("caseIds");
		String labelId = request.getParameter("labelId");
		caseLabelRelaSV.deleteAigaCaseLabelRela(caseIds, labelId);
	}
}
