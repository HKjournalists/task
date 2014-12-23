package com.asiainfo.csc.matrix.service.impl;

import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONObject;

import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.util.criteria.Criteria;
import com.asiainfo.csc.matrix.bo.BOAlmWorkflowBean;
import com.asiainfo.csc.matrix.bo.BOWorkflowComponentConfigBean;
import com.asiainfo.csc.matrix.dao.interfaces.IWorkflowComponentConfigDao;
import com.asiainfo.csc.matrix.factory.BusiFactory;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkflowValue;
import com.asiainfo.csc.matrix.ivalues.IBOWorkflowComponentConfigValue;
import com.asiainfo.csc.matrix.service.interfaces.IWorkflowComponentConfigSV;

public class WorkflowComponentConfigSVImpl implements
		IWorkflowComponentConfigSV {

	
	public IBOWorkflowComponentConfigValue[] getWorkflowComponentConfig(
			String currentLinkNo) throws Exception {
		// TODO Auto-generated method stub
		IWorkflowComponentConfigDao componentConfigDao = (IWorkflowComponentConfigDao)ServiceFactory.getService(IWorkflowComponentConfigDao.class);
		Criteria sql = new Criteria();
		sql.addEqual(BOWorkflowComponentConfigBean.S_CurrentLinkno, currentLinkNo);
		sql.addAscendingOrderByColumn(BOWorkflowComponentConfigBean.S_ButtonOrder);
		return componentConfigDao.getWorkflowComponentConfig(sql.toString(), sql.getParameters());
	}

	
	public String getWorkflowComponent(String currentLinkNo,String contextPath) throws Exception {
		// TODO Auto-generated method stub
		String html = "<div class=\"btmFixed_left\">" +
				"<ul id=\"workflowComponent\">";
		IBOWorkflowComponentConfigValue[] componentConfigValues = this.getWorkflowComponentConfig(currentLinkNo);
		for(IBOWorkflowComponentConfigValue componentConfigValue : componentConfigValues){
			
			html += "<li id=\""+componentConfigValue.getNextLinkno()+"\" title=\""+componentConfigValue.getHtmlDes()+"\" onmouseover=\"this.className='hover'\" onmouseout=\"this.className=''\" ";
			if(componentConfigValue.getButtonOnclick()==null||componentConfigValue.getButtonOnclick().equals("")){
				Criteria sql = new Criteria();
				sql.addEqual(BOAlmWorkflowBean.S_LinkNo, componentConfigValue.getNextLinkno());
				IBOAlmWorkflowValue[] almWorkflowValues = BusiFactory.getAlmWorkflowSV().getAlmWorkflowByCondition(sql.toString(), sql.getParameters());
				if(almWorkflowValues.length>1)
					throw new Exception("查找到的流程配置大于1,函数:[com.asiainfo.csc.matrix.service.impl.WorkflowComponentConfigSVImpl.getWorkflowComponent]");
				if(almWorkflowValues!=null&&almWorkflowValues.length==1){
					if(almWorkflowValues[0].getLinkNoType().equals("user"))
						html += "onclick=\"reqCommonMethod.setWOResult('"+componentConfigValue.getNextLinkno()+"')\">";
					if(almWorkflowValues[0].getLinkNoType().equals("sign"))
						html += "onclick=\"reqCommonMethod.setSignWOResult('"+componentConfigValue.getNextLinkno()+"')\">";
				}
				if(almWorkflowValues==null||almWorkflowValues.length==0)
					html += ">";
			}
			else
				html += "onclick=\""+componentConfigValue.getButtonOnclick()+"\">";
			html += "<span><img src=\""+contextPath+componentConfigValue.getButtonimgUrl()+"\" /></span>";
			html += "<p>"+componentConfigValue.getHtmlButtonText()+"</p>";
			html += "</li>";
		}
		html += "</ul>" +
				"</div>";
//		System.out.println(html);
		return html;
	}

	
	public String getWorkflowComponentJson(String currentLinkNo)
			throws Exception {
		// TODO Auto-generated method stub
		IBOWorkflowComponentConfigValue[] componentConfigValues = this.getWorkflowComponentConfig(currentLinkNo);
		JSONObject json = new JSONObject();
		for(IBOWorkflowComponentConfigValue componentConfigValue : componentConfigValues){
			Criteria sql = new Criteria();
			sql.addEqual(BOAlmWorkflowBean.S_LinkNo, componentConfigValue.getNextLinkno());
			IBOAlmWorkflowValue[] almWorkflowValues = BusiFactory.getAlmWorkflowSV().getAlmWorkflowByCondition(sql.toString(), sql.getParameters());
			if(almWorkflowValues.length > 1)
				throw new Exception("【查询到的下一环节数据大于一,错误在com.asiainfo.csc.matrix.service.impl.WorkflowComponentConfigSVImpl.getWorkflowComponentJson】");
			else if(almWorkflowValues.length == 1){
				Map<String, String> componentValue = new HashMap<String, String>();
				componentValue.put("cond", componentConfigValue.getCondXml());
				componentValue.put("result", componentConfigValue.getResult());
				componentValue.put("nextLinkId", String.valueOf(almWorkflowValues[0].getLinkId()));
				componentValue.put("nextRoleCode", almWorkflowValues[0].getRoleCode());
				componentValue.put("templateId", String.valueOf(almWorkflowValues[0].getTemplateId()));
				componentValue.put("submitUrl", String.valueOf(componentConfigValue.getSubmitUrl()));
				componentValue.put("submitSuccessMsg", String.valueOf(componentConfigValue.getSubmitSuccessMsg()));
				componentValue.put("submitFailMsg", String.valueOf(componentConfigValue.getSubmitFailMsg()));
				componentValue.put("submitResultVar", String.valueOf(componentConfigValue.getSubmitResultVar()));
				componentValue.put("isChoiceStakeholder", String.valueOf(componentConfigValue.getIsChoiceStakeholder()));
				componentValue.put("needRefreshStakeholder", String.valueOf(componentConfigValue.getNeedRefreshStakeholder()));
				componentValue.put("refreshStakeholderLinkNo", componentConfigValue.getRefreshStakeholderLinkno());
				componentValue.put("linkNoType", almWorkflowValues[0].getLinkNoType());
				componentValue.put("needOption", String.valueOf(componentConfigValue.getNeedOption()));
				componentValue.put("optionDefaultValue", componentConfigValue.getOptionDefaultValue());
				
				json.put(componentConfigValue.getNextLinkno(), componentValue);
			}
		}
//		System.out.println(json.toString());
		return json.toString();
	}


	@Override
	public String addWorkflowComponent(String linkNo, String contextPath)
			throws Exception {
		// TODO Auto-generated method stub
		String html = "";
		IBOWorkflowComponentConfigValue[] componentConfigValues = this.getWorkflowComponentConfig(linkNo);
		for(IBOWorkflowComponentConfigValue componentConfigValue : componentConfigValues){
			
			html += "<li id=\""+componentConfigValue.getNextLinkno()+"\" title=\""+componentConfigValue.getHtmlDes()+"\" onmouseover=\"this.className='hover'\" onmouseout=\"this.className=''\" ";
			if(componentConfigValue.getButtonOnclick()==null||componentConfigValue.getButtonOnclick().equals("")){
				Criteria sql = new Criteria();
				sql.addEqual(BOAlmWorkflowBean.S_LinkNo, componentConfigValue.getNextLinkno());
				IBOAlmWorkflowValue[] almWorkflowValues = BusiFactory.getAlmWorkflowSV().getAlmWorkflowByCondition(sql.toString(), sql.getParameters());
				if(almWorkflowValues.length>1)
					throw new Exception("查找到的流程配置大于1,函数:[com.asiainfo.csc.matrix.service.impl.WorkflowComponentConfigSVImpl.getWorkflowComponent]");
				if(almWorkflowValues!=null&&almWorkflowValues.length==1){
					if(almWorkflowValues[0].getLinkNoType().equals("user"))
						html += "onclick=\"reqCommonMethod.setWOResult('"+componentConfigValue.getNextLinkno()+"')\">";
					if(almWorkflowValues[0].getLinkNoType().equals("sign"))
						html += "onclick=\"reqCommonMethod.setSignWOResult('"+componentConfigValue.getNextLinkno()+"')\">";
				}
				if(almWorkflowValues==null||almWorkflowValues.length==0)
					html += ">";
			}
			else
				html += "onclick=\""+componentConfigValue.getButtonOnclick()+"\">";
			html += "<span><img src=\""+contextPath+componentConfigValue.getButtonimgUrl()+"\" /></span>";
			html += "<p>"+componentConfigValue.getHtmlButtonText()+"</p>";
			html += "</li>";
		}
		return html;
	}

}
