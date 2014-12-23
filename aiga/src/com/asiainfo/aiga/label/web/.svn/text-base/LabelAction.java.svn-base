package com.asiainfo.aiga.label.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.asiainfo.aiga.common.BaseAction;
import com.asiainfo.aiga.funPoint.service.IAigaFunPointSV;
import com.asiainfo.aiga.label.bo.AigaLabel;
import com.asiainfo.aiga.label.service.IAigaLabelSV;
import com.asiainfo.aiga.label.service.impl.AigaLabelTree;
import com.asiainfo.aiga.userCase.bo.AigaCase;
import com.asiainfo.aiga.userCase.bo.extend.AigaBaseCase;
import com.asiainfo.aiga.userCase.bo.extend.AigaInstCase;
import com.asiainfo.aiga.userCase.service.IAigaCaseSV;

@Controller
public class LabelAction extends BaseAction{

	@Resource(name="aigalabelSV")
	private IAigaLabelSV aigaLabelSV;
	
	@Resource(name="caseSV")
	private IAigaCaseSV aigaCaseSV;
	
	@RequestMapping("/saveLabel.do")
	public void saveLabel(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			Object[] results = this.transFormToObj(request, new Class[]{AigaLabel.class});
			AigaLabel aigaLabel = new AigaLabel();
			for(Object result : results){
				if(result instanceof AigaLabel)
					aigaLabel = (AigaLabel)result;
			}
			if(aigaLabel!=null&&results.length!=0) {
				if(aigaLabel.getLabelId() == 0) {
					aigaLabel.setIsLeaf(1);
				}
				AigaLabel[] aigaLabels = aigaLabelSV.getAigaLabelById(aigaLabel.getParentId());
				if(aigaLabels != null && aigaLabels.length == 1 && aigaLabels[0] != null) {
					aigaLabels[0].setIsLeaf(0);
					aigaLabelSV.saveAigaLabel(aigaLabel);
				}
				aigaLabelSV.saveAigaLabel(aigaLabel);
			}
			this.setPostInfo("success", true);
		}catch(Exception e){
			this.setPostInfo("success", false);
		}finally{
			this.postInfo(request, response);
		}
	} 
	
	@RequestMapping("/deleteLabel.do")
	public void deleteLabel(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			Object[] results = this.transFormToObj(request, new Class[]{AigaLabel.class});
			AigaLabel aigaLabel = new AigaLabel();
			for(Object result : results){
				if(result instanceof AigaLabel)
					aigaLabel = (AigaLabel)result;
			}
			if(aigaLabel!=null&&results.length!=0)
				aigaLabelSV.deleteAigaLabel(aigaLabel);
			this.setPostInfo("success", true);
		}catch(Exception e){
			this.setPostInfo("success", false);
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/getLabel.do")
	public void refreshLabel(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String id = request.getParameter("labelId");
			AigaLabel[] aigaLabels = aigaLabelSV.getAigaLabelById(Integer.valueOf(id));
			if(aigaLabels.length>1)
				throw new Exception("查询到的标签不唯一");
			this.setFormData(aigaLabels[0]);
			this.setPostInfo("success", true);
		}catch(Exception e){
			this.setPostInfo("success", false);
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/getCaseTable.do")
	public void getCaseTable(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String labelId = request.getParameter("labelId");
			AigaCase[] aigaCase = aigaLabelSV.getAigaCaseByLabelId(Integer.valueOf(labelId));
			this.setTable(aigaCase);
			this.setPostInfo("success", true);
		}catch(Exception e){
			this.setPostInfo("success", false);
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/getCaseForm.do")
	public void getCaseForm(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String caseId = request.getParameter("caseId");
			if(caseId!=null&&!caseId.equals("")){
				AigaCase[] aigaCase = aigaCaseSV.getAigaCaseById(Integer.valueOf(caseId),AigaInstCase.class);
				if(aigaCase.length==1)
					this.setFormData(aigaCase[0]);
				else
					this.setFormData(new AigaBaseCase());
			}else
				this.setFormData(new AigaBaseCase());
			this.setPostInfo("success", true);
		}catch(Exception e){
			this.setPostInfo("success", false);
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/getLabelTree.do")
	public void getLabelTree(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			ApplicationContext context = RequestContextUtils.getWebApplicationContext(request);
			AigaLabelTree aigaLabelTree = (AigaLabelTree)context.getBean("labelTree");
			this.setTree(aigaLabelTree, request);
			this.setPostInfo("success", true);
		}catch(Exception e){
			this.setPostInfo("success", false);
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping(value="/getSysLabel.do")
	public void getSysLabel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String querySql = "select * from aiga_label s where s.is_leaf=1 start with s.parent_id=4 connect by prior s.label_id=s.parent_id";
		AigaLabel[] labels = aigaLabelSV.getAigaLabelLeafBySql(querySql);
		JSONArray jsonAry = new JSONArray();
		for(AigaLabel label : labels) {
			JSONObject json = new JSONObject();
			json.put("value", label.getLabelName());
			json.put("show", label.getLabelName());
			jsonAry.add(json);
		}
		JSONObject json = new JSONObject();
		json.put("success", true);
		json.put("data", jsonAry);
		this.writeOwnJson(response, json);
	}
	
}
