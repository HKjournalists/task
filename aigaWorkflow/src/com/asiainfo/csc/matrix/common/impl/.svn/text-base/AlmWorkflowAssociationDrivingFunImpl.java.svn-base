package com.asiainfo.csc.matrix.common.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ai.appframe2.util.criteria.Criteria;
import com.asiainfo.csc.matrix.common.ConstDefine;
import com.asiainfo.csc.matrix.common.interfaces.IAlmWorkflowAssociationDrivingFun;
import com.asiainfo.csc.matrix.factory.BusiFactory;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkflowDrivingValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkflowTemplateValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkflowValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkorderValue;
import com.asiainfo.csc.matrix.ivalues.IBOTopoViewValue;

public abstract class AlmWorkflowAssociationDrivingFunImpl implements
		IAlmWorkflowAssociationDrivingFun {
	//可以通过继承类AlmWorkflowAssociationDrivingFunImpl重写getBusiObjIdByCondition(Long active_obj_id,String active_obj_type,String passive_obj_type)方法 实现从其他业务表中获取obj_id
	public abstract Long[] getBusiObjIdByCondition(Long active_obj_id,String active_obj_type,String passive_obj_type);
	//主动流程有多个流程实例同时属于一个被动流程实例，当一个主动流程实例发生变化时 被动流程就跟着发生变化
	public IBOAlmWorkorderValue[] fristActiveWODrivePassiveWO(Long active_obj_id,String active_obj_type,String activeTopoNo,String passiveTopoNo) throws Exception{
		String condition = "NO=:topoNo";
		Map<String,Object> paramter = new HashMap<String,Object>();
		paramter.put("topoNo", passiveTopoNo);
		IBOTopoViewValue[] passiveTopos = BusiFactory.getAlmTopoViewDao().getTopoByCondition(condition, paramter);
		
		condition = "LINK_ID=:linkId";
		paramter = new HashMap<String,Object>();
		paramter.put("linkId", passiveTopos[0].getFpoint());
		IBOAlmWorkflowValue[] passiveWorkflows = BusiFactory.getAlmWorkflowSV().getAlmWorkflowByCondition(condition, paramter);
		
		condition = "TEMPLATE_ID=:templateId";
		paramter = new HashMap<String,Object>();
		paramter.put("templateId", passiveWorkflows[0].getTemplateId());
		IBOAlmWorkflowTemplateValue[] passiveWorkflowTemplates = BusiFactory.getAlmWorkflowTemplateSV().getAlmWorkflowTemplateByCondition(condition, paramter);
		String passive_obj_type = passiveWorkflowTemplates[0].getObjType();
		Long[] obj_ids = this.getBusiObjIdByCondition(active_obj_id, active_obj_type, passive_obj_type);
		List<IBOAlmWorkorderValue>  passiveWOList = new ArrayList<IBOAlmWorkorderValue>();
		for(long passive_obj_id : obj_ids ){
			Criteria sql = new Criteria();
			sql.addEqual(IBOAlmWorkorderValue.S_ObjId, passive_obj_id);
			sql.addEqual(IBOAlmWorkorderValue.S_ObjType, passive_obj_type);
			sql.addEqual(IBOAlmWorkorderValue.S_OrderType, ConstDefine.STAKEHOLDERTYPE_WF);
			sql.addEqual(IBOAlmWorkorderValue.S_LinkId, passiveTopos[0].getFpoint());
			sql.addEqual(IBOAlmWorkorderValue.S_Status, ConstDefine.WO_STATUS_RECEIVE);
			IBOAlmWorkorderValue[] workorders = BusiFactory.getAlmWorkorderSV().getAlmWorkorderByCondition(sql.toString(), sql.getParameters());
			for(IBOAlmWorkorderValue wo : workorders){
				passiveWOList.add(wo);
			}
			
		}
		return passiveWOList.toArray(new IBOAlmWorkorderValue[0]);
		
	}
	//主动流程有多个流程实例同时属于一个被动流程实例，当全部主动流程实例都从b1环节到c1环节时 被动流程才跟着发生变化 B到C
	public IBOAlmWorkorderValue[] allActiveWODrivePassiveWO(Long active_obj_id,String active_obj_type,String activeTopoNo,String passiveTopoNo) throws Exception{
		String condition = "NO=:topoNo";
		Map<String,Object> paramter = new HashMap<String,Object>();
		paramter.put("topoNo", passiveTopoNo);
		IBOTopoViewValue[] passiveTopos = BusiFactory.getAlmTopoViewDao().getTopoByCondition(condition, paramter);
		if(passiveTopos.length==0||passiveTopos==null)
			throw new Exception("未找到被动点的关系");
		
		condition = "NO=:topoNo";
		paramter = new HashMap<String,Object>();
		paramter.put("topoNo", activeTopoNo);
		IBOTopoViewValue[] activeTopos = BusiFactory.getAlmTopoViewDao().getTopoByCondition(condition, paramter);
		if(activeTopos.length==0||activeTopos==null)
			throw new Exception("未找到主动点的关系");
		
		condition = "LINK_ID=:linkId";
		paramter = new HashMap<String,Object>();
		paramter.put("linkId", activeTopos[0].getFpoint());
		IBOAlmWorkflowValue[] activeWorkflows = BusiFactory.getAlmWorkflowSV().getAlmWorkflowByCondition(condition, paramter);
		if(activeWorkflows.length==0||activeWorkflows==null)
			throw new Exception("未找到主动流程");
		
		condition = "LINK_ID=:linkId";
		paramter = new HashMap<String,Object>();
		paramter.put("linkId", passiveTopos[0].getFpoint());
		IBOAlmWorkflowValue[] passiveWorkflows = BusiFactory.getAlmWorkflowSV().getAlmWorkflowByCondition(condition, paramter);
		if(passiveWorkflows.length==0||passiveWorkflows==null)
			throw new Exception("未找到被动流程");
		
		Long activeTemplateId = activeWorkflows[0].getTemplateId();
		
		condition = "PASSIVE_POINT=:passivePoint and ACTIVE_TEMPLATE_ID=:activeTemplateId";
		paramter = new HashMap<String,Object>();
		paramter.put("passivePoint", passiveTopos[0].getFpoint());
		paramter.put("activeTemplateId", activeTemplateId);
		IBOAlmWorkflowDrivingValue[] almWorkflowDrivings = BusiFactory.getAlmWorkflowDrivingSV().getAlmWorkflowDrivingByCondition(condition, paramter);
		if(almWorkflowDrivings.length==0||almWorkflowDrivings==null)
			throw new Exception("未找到相应的驱动");
		
		condition = "TEMPLATE_ID=:templateId";
		paramter = new HashMap<String,Object>();
		paramter.put("templateId", passiveWorkflows[0].getTemplateId());
		IBOAlmWorkflowTemplateValue[] passiveWorkflowTemplates = BusiFactory.getAlmWorkflowTemplateSV().getAlmWorkflowTemplateByCondition(condition, paramter);
		if(passiveWorkflowTemplates.length==0||passiveWorkflowTemplates==null)
			throw new Exception("未找到被动点的流程模版");
		String passive_obj_type = passiveWorkflowTemplates[0].getObjType();
		
		//***下面方法用于获取业务表中objId***//
		Long[] obj_ids = this.getBusiObjIdByCondition(active_obj_id, active_obj_type, passive_obj_type);
		List<IBOAlmWorkorderValue>  passiveWOList = new ArrayList<IBOAlmWorkorderValue>();
		for(long passive_obj_id : obj_ids ){
			Criteria sql = new Criteria();
			sql.addEqual(IBOAlmWorkorderValue.S_ObjId, passive_obj_id);
			sql.addEqual(IBOAlmWorkorderValue.S_ObjType, passive_obj_type);
			sql.addEqual(IBOAlmWorkorderValue.S_OrderType, ConstDefine.STAKEHOLDERTYPE_WF);
			sql.addEqual(IBOAlmWorkorderValue.S_LinkId, passiveTopos[0].getFpoint());
			sql.addEqual(IBOAlmWorkorderValue.S_Status, ConstDefine.WO_STATUS_RECEIVE);
			IBOAlmWorkorderValue[] workorders = BusiFactory.getAlmWorkorderSV().getAlmWorkorderByCondition(sql.toString(), sql.getParameters());
			for(IBOAlmWorkorderValue wo : workorders){
				passiveWOList.add(wo);
				//判断被动流程关联的所有主动流程都以流转的到当前被动环节所属阶段后的阶段
				Long[] active_obj_ids = this.getBusiObjIdByCondition(passive_obj_id, passive_obj_type, active_obj_type);
				if(active_obj_ids!=null)
				for(long active_objId : active_obj_ids){
					sql = new Criteria();
					sql.addEqual(IBOAlmWorkorderValue.S_ObjId, active_objId);
					sql.addEqual(IBOAlmWorkorderValue.S_ObjType, active_obj_type);
					sql.addEqual(IBOAlmWorkorderValue.S_OrderType, ConstDefine.STAKEHOLDERTYPE_WF);
					sql.addNotEqual(IBOAlmWorkorderValue.S_Status, ConstDefine.WO_STATUS_COMPLETE);
					IBOAlmWorkorderValue[] wos = BusiFactory.getAlmWorkorderSV().getAlmWorkorderByCondition(sql.toString(), sql.getParameters());
					if(wos==null||wos.length==0)
						continue;
					condition = "PASSIVE_TEMPLATE_ID=:passiveTemplateId and ACTIVE_TEMPLATE_ID=:activeTemplateId and ACTIVE_POINT like :activePoint";
					paramter = new HashMap<String,Object>();
					paramter.put("passiveTemplateId", almWorkflowDrivings[0].getPassiveTemplateId());
					paramter.put("activeTemplateId", almWorkflowDrivings[0].getActiveTemplateId());
					paramter.put("activePoint", "%|"+wos[0].getLinkId()+"|%");
					IBOAlmWorkflowDrivingValue[] tempWorkflowDrivings = BusiFactory.getAlmWorkflowDrivingSV().getAlmWorkflowDrivingByCondition(condition, paramter);
					if(tempWorkflowDrivings.length!=0 && tempWorkflowDrivings != null && tempWorkflowDrivings[0].getLinkRelativePhase() <= almWorkflowDrivings[0].getLinkRelativePhase()){
						return null;
					}
				}
			}			
		}
		return passiveWOList.toArray(new IBOAlmWorkorderValue[0]);
	}
	
	//1多流程带单流程回退 需要修改此段代码 tempWorkflowDrivings[0].getLinkRelativePhase() <= almWorkflowDrivings[0].getLinkRelativePhase()
	//2主流程多个分支  解决办法加 分支选择优先级配置 还需在框架代码中做修改
	//3 多子流程且多主流程交叉互带
	
}
