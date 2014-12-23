package com.asiainfo.csc.common.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.web.CustomProperty;
import com.ai.appframe2.web.DataContainerList;
import com.ai.appframe2.web.HttpUtil;
import com.ai.appframe2.web.action.BaseAction;
import com.asiainfo.csc.common.bo.BOReqRemarksBean;
import com.asiainfo.csc.common.define.IMessageConsts;
import com.asiainfo.csc.common.ivalues.IBOReqRemarksValue;
import com.asiainfo.csc.common.service.interfaces.IReqRemarksSV;

public class RemarksAction extends BaseAction {
	IReqRemarksSV iRESV=(IReqRemarksSV)ServiceFactory.getService(IReqRemarksSV.class);
	public void saveRemarks(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		List<IBOReqRemarksValue> IReVList = new ArrayList<IBOReqRemarksValue>();
		List other = new ArrayList();
		CustomProperty cp = CustomProperty.getInstance();
		try{
			getDatasFromRequestInputstream(request,IReVList,other);
			iRESV.saveReqRemarks(IReVList.get(0));
			cp.set(IMessageConsts.RESULT_KEY, IMessageConsts.SUCCESS);
			cp.set(IMessageConsts.RESULT_MESSAGE_KEY, IMessageConsts.REQ_RECEIVE_SUCCESS);		
		}catch(Exception e)
		{
			e.printStackTrace();
			cp.set(IMessageConsts.RESULT_KEY, IMessageConsts.FAILURE);
			cp.set(IMessageConsts.RESULT_MESSAGE_KEY, IMessageConsts.REQ_RECEIVE_FAILURE);
		}
		finally
		{
			HttpUtil.showInfo(response, cp);
		}
		
	}
	
	public void delRemarks(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String remarkId = request.getParameter("remarkId");
		CustomProperty cp = CustomProperty.getInstance();
		try{
			iRESV.delReqRemarks(remarkId);
			cp.set(IMessageConsts.RESULT_KEY, IMessageConsts.SUCCESS);
		}catch(Exception e)
		{
			e.printStackTrace();
			cp.set(IMessageConsts.RESULT_KEY, IMessageConsts.FAILURE);
		}
		finally
		{
			HttpUtil.showInfo(response, cp);
		}
	}
	
	public void getDatasFromRequestInputstream(HttpServletRequest request,
			List<IBOReqRemarksValue> res,List others)
			throws Exception {
		DataContainerList[] dcLists;
		IBOReqRemarksValue[] iReqRemarksValues = null;
		dcLists = HttpUtil.getDataContainerLists(request.getInputStream(),
				new Class[] { BOReqRemarksBean.class});
		for (int i = 0; i < dcLists.length; i++) {

			Object[] obj = dcLists[i].getColDataContainerInterface(0);
			if (obj instanceof BOReqRemarksBean[]) {
				iReqRemarksValues = (BOReqRemarksBean[]) obj;
				for (IBOReqRemarksValue value : iReqRemarksValues) {
					res.add(value);
				}
			}else {
				others.add(obj);
			}
		}
	}
}
