package com.asiainfo.csc.common.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.web.CustomProperty;
import com.ai.appframe2.web.DataContainerList;
import com.ai.appframe2.web.HttpUtil;
import com.ai.appframe2.web.action.BaseAction;
import com.asiainfo.csc.common.bo.BOSysParamBean;
import com.asiainfo.csc.common.ivalues.IBOSysParamValue;
import com.asiainfo.csc.common.service.interfaces.ISysParamSV;
import com.asiainfo.csc.common.service.interfaces.IWorkflowService;
import com.asiainfo.csc.matrix.bo.BOAlmWorkflowBean;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkflowValue;

public class OpTableAction extends BaseAction {
	
	public void saveSysParam(HttpServletRequest request, HttpServletResponse response) throws Exception {
		CustomProperty cp = CustomProperty.getInstance();
		IBOSysParamValue[] saveVals = null;
		String retVal = "N";
		try {
			DataContainerList[] dcs = HttpUtil.getDataContainerLists(request.getInputStream(),
					new Class[]{BOSysParamBean.class});
			if(dcs == null || dcs.length == 0 || dcs[0] == null) {
				throw new Exception("未发现要保存的数据！");
			}
			for(int i = 0; i < dcs.length; i++) {
				Object[] obj = dcs[i].getColDataContainerInterface(0);
				if(obj instanceof BOSysParamBean[]) {
					saveVals = (BOSysParamBean[]) obj;
				}
			}
			if(saveVals == null || saveVals.length == 0 || saveVals[0] == null) {
				throw new Exception("未发现要保存的数据！");
			}
			
			ISysParamSV iSysParamSV = (ISysParamSV)ServiceFactory.getService(ISysParamSV.class);
			for(IBOSysParamValue saveVal : saveVals) {
				iSysParamSV.saveSysParam(saveVal);
			}
			
			retVal = "Y";
		} catch(Exception e) {
			retVal = "保存中出现异常：" + e.getMessage(); 
			e.printStackTrace();
			throw new Exception(retVal);
		} finally {
			cp.set("retVal", retVal);
			HttpUtil.showInfo(response, cp);
		}
	}
	
	public void delSysParam(HttpServletRequest request, HttpServletResponse response) throws Exception {
		CustomProperty cp = CustomProperty.getInstance();
		IBOSysParamValue[] delVals = null;
		String retVal = "N";
		try {
			DataContainerList[] dcs = HttpUtil.getDataContainerLists(request.getInputStream(),
					new Class[]{BOSysParamBean.class});
			if(dcs == null || dcs.length == 0 || dcs[0] == null) {
				throw new Exception("未发现要删除的数据！");
			}
			for(int i = 0; i < dcs.length; i++) {
				Object[] obj = dcs[i].getColDataContainerInterface(0);
				if(obj instanceof BOSysParamBean[]) {
					delVals = (BOSysParamBean[]) obj;
				}
			}
			if(delVals == null || delVals.length == 0 || delVals[0] == null) {
				throw new Exception("未发现要删除的数据！");
			}
			
			ISysParamSV iSysParamSV = (ISysParamSV)ServiceFactory.getService(ISysParamSV.class);
			for(IBOSysParamValue delVal : delVals) {
				iSysParamSV.delSysParam(delVal);
			}
			
			retVal = "Y";
		} catch(Exception e) {
			retVal = "保存中出现异常：" + e.getMessage(); 
			e.printStackTrace();
			throw new Exception(retVal);
		} finally {
			cp.set("retVal", retVal);
			HttpUtil.showInfo(response, cp);
		}
	}
	
	public void saveWorkflow(HttpServletRequest request, HttpServletResponse response) throws Exception {
		CustomProperty cp = CustomProperty.getInstance();
		IBOAlmWorkflowValue[] saveVals = null;
		String retVal = "N";
		try {
			DataContainerList[] dcs = HttpUtil.getDataContainerLists(request.getInputStream(),
					new Class[]{BOAlmWorkflowBean.class});
			if(dcs == null || dcs.length == 0 || dcs[0] == null) {
				throw new Exception("未发现要保存的数据！");
			}
			for(int i = 0; i < dcs.length; i++) {
				Object[] obj = dcs[i].getColDataContainerInterface(0);
				if(obj instanceof BOAlmWorkflowBean[]) {
					saveVals = (BOAlmWorkflowBean[]) obj;
				}
			}
			if(saveVals == null || saveVals.length == 0 || saveVals[0] == null) {
				throw new Exception("未发现要保存的数据！");
			}
			
			IWorkflowService iws = (IWorkflowService)ServiceFactory.getService(IWorkflowService.class);
			for(IBOAlmWorkflowValue saveVal : saveVals) {
				iws.saveWorkflow(saveVal);
			}
			
			retVal = "Y";
		} catch(Exception e) {
			retVal = "保存中出现异常：" + e.getMessage(); 
			e.printStackTrace();
			throw new Exception(retVal);
		} finally {
			cp.set("retVal", retVal);
			HttpUtil.showInfo(response, cp);
		}
	}
	
	public void delWorkflow(HttpServletRequest request, HttpServletResponse response) throws Exception {
		CustomProperty cp = CustomProperty.getInstance();
		IBOAlmWorkflowValue[] delVals = null;
		String retVal = "N";
		try {
			DataContainerList[] dcs = HttpUtil.getDataContainerLists(request.getInputStream(),
					new Class[]{BOAlmWorkflowBean.class});
			if(dcs == null || dcs.length == 0 || dcs[0] == null) {
				throw new Exception("未发现要删除的数据！");
			}
			for(int i = 0; i < dcs.length; i++) {
				Object[] obj = dcs[i].getColDataContainerInterface(0);
				if(obj instanceof BOAlmWorkflowBean[]) {
					delVals = (BOAlmWorkflowBean[]) obj;
				}
			}
			if(delVals == null || delVals.length == 0 || delVals[0] == null) {
				throw new Exception("未发现要删除的数据！");
			}
			
			IWorkflowService iws = (IWorkflowService)ServiceFactory.getService(IWorkflowService.class);
			for(IBOAlmWorkflowValue delVal : delVals) {
				iws.delWorkflow(delVal);
			}
			
			retVal = "Y";
		} catch(Exception e) {
			retVal = "保存中出现异常：" + e.getMessage(); 
			e.printStackTrace();
			throw new Exception(retVal);
		} finally {
			cp.set("retVal", retVal);
			HttpUtil.showInfo(response, cp);
		}
	}

}
