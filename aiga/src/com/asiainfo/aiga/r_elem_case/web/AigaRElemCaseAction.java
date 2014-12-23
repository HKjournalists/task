package com.asiainfo.aiga.r_elem_case.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.asiainfo.aiga.common.BaseAction;
import com.asiainfo.aiga.common.helper.ActionHelper;
import com.asiainfo.aiga.r_collect_case.bo.AigaRFunCase;
import com.asiainfo.aiga.r_collect_case.service.IAigaRFunCaseSV;
import com.asiainfo.aiga.r_elem_case.bo.AigaRElemCase;
import com.asiainfo.aiga.r_elem_case.service.IAigaRElemCaseSV;
import com.asiainfo.aiga.userCase.bo.AigaCase;
import com.asiainfo.aiga.userCase.service.IAigaCaseSV;

@Controller
@Scope(value="prototype")
public class AigaRElemCaseAction extends BaseAction{

	@Resource(name="rElemCaseSV")
	private IAigaRElemCaseSV aigaRElemCaseSV;
	
	@Resource(name="rFunCaseSV")
	private IAigaRFunCaseSV aigaRFunCaseSV;
	
	@Resource(name="caseSV")
	private IAigaCaseSV aigaCaseSV;
	
	@RequestMapping("/saveRElemCase.do")
	public void saveRElemCase(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String elemTag = request.getParameter("elemTag");
			String caseIds = request.getParameter("caseIds");
			if(elemTag!=null&&!elemTag.equals("")&&caseIds!=null&&!caseIds.equals(""))
				aigaRElemCaseSV.saveRElemCase(caseIds, elemTag);
			this.setPostInfo("success", true);
		}catch(Exception e){
			this.setPostInfo("success", false);
		}finally{
			this.postInfo(request, response);
		}
	}
	@RequestMapping("/addRElemCase.do")
	public void addRElemCase(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String elemTag = request.getParameter("elemTag");
			String caseIds = request.getParameter("caseIds");
			if(elemTag!=null&&!elemTag.equals("")&&caseIds!=null&&!caseIds.equals(""))
				aigaRElemCaseSV.addRElemCase(caseIds, elemTag);
			this.setPostInfo("success", true);
		}catch(Exception e){
			this.setPostInfo("success", false);
		}finally{
			this.postInfo(request, response);
		}
	}
	@RequestMapping("/deleteRElemCase.do")
	public void deleteRElemCase(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String elemTag = request.getParameter("elemTag");
			String caseIds = request.getParameter("caseIds");
			if(elemTag!=null&&!elemTag.equals("")&&caseIds!=null&&!caseIds.equals(""))
				aigaRElemCaseSV.deleteRElemCase(caseIds, elemTag);
			this.setPostInfo("success", true);
		}catch (Exception e) {
			this.setPostInfo("success", false);
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/getRElemCase.do")
	public void getRElemCase(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String caseIds = "0";
			String elemTag = request.getParameter("elemTag");
			if(elemTag!=null&&!elemTag.equals(""))
				caseIds = aigaRElemCaseSV.getRElemCaseIdByElemTag(elemTag);
			this.setPostInfo("caseIds", caseIds);
			this.setPostInfo("success", true);
		}catch (Exception e) {
			this.setPostInfo("success", false);
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/getElemCaseCount.do")
	public void getElemCaseCount(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String elemTag = request.getParameter("elemTag");
			String querySql = "from AigaInstCase where case_id in(select caseId from AigaRElemCase where elem_tag='"+elemTag+"')";
			AigaCase[] cases = aigaCaseSV.getAigaCaseBySql(querySql);
			this.setPostInfo("size", cases.length);
			this.setPostInfo("success", true);
		}catch (Exception e) {
			this.setPostInfo("success", false);
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/saveCollection.do")
	public void saveCollection(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Object[] objs=	this.transTableToObj(request, AigaRFunCase.class);
		AigaRFunCase[] aigaRFunCases=new AigaRFunCase[objs.length];
		for(int i=0,n=objs.length;i<n;i++){
			if(objs[i] instanceof AigaRFunCase){
				aigaRFunCases[i]=(AigaRFunCase)objs[i];
			}
		}
		aigaRFunCaseSV.saveRAigaFunCase(aigaRFunCases);
		Map map=new HashMap();
		map.put("success", "true");
		ActionHelper.returnResponseData(request, response, map);
	}

}
